Return-Path: <linux-kernel+bounces-549624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFACA554C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D683A52D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9D526B084;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5825A2B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285104; cv=none; b=uEBhH6ZpY6chmcnVgJUdQeCeQiir5FGZeFN1lLtsF0Ogfu1zQ7knLzXHIl4Rdpyrjklr49VvxGyLN8SiN3wtAn79Hcbg0GAbb10xUycECxZPdVgSU5MS3AkqSPzEriwN+akuRj0ary2XjAymjOzne8QEtO6+XkcG/ykvsprMVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285104; c=relaxed/simple;
	bh=gsaXe5RYlJkso+aavT0nSGeOjR6X2weyybAnNMJE7Mc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Pyz1BNYoep3EVFcbxkqsZwJ15qIDdoMw1nXJjSmScl3xdPNHTFzE0v8KP19UhQjlGJXgjYnD+l8aonFg2GQ88sySrRUl2Dsy7W3EJERjBJUIjMvp8AZ6RNA8Kb1wSlBpYbdGD3eG0dnYXx/puVd6CfiRFSNpt6tQZoazqWJhnKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A21C4CEE9;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFnd-00000000PGd-4Bej;
	Thu, 06 Mar 2025 13:18:26 -0500
Message-ID: <20250306181825.857105005@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 03/10] rtla: Add optional dependency on BPF tooling
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

If tooling required for building BPF CO-RE skeletons is present (that
is, libbpf, clang with BPF CO-RE support, and bpftool), turn on
HAVE_BPF_SKEL flag.

Those requirements are similar to what perf requires, with the
difference of using system libbpf and bpftool instead of in-tree
versions.

rtla can be forcefully built without BPF skeleton support by setting
BUILD_BPF_SKEL=0 manually; in that case, a warning is displayed.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250218145859.27762-4-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile        |  6 +++++
 tools/tracing/rtla/Makefile.config | 42 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 8b5101457c70..0aa116f7b355 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -33,9 +33,15 @@ DOCSRC		:= ../../../Documentation/tools/rtla/
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
 FEATURE_TESTS	+= libcpupower
+FEATURE_TESTS	+= libbpf
+FEATURE_TESTS	+= clang-bpf-co-re
+FEATURE_TESTS	+= bpftool-skeletons
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
 FEATURE_DISPLAY	+= libcpupower
+FEATURE_DISPLAY	+= libbpf
+FEATURE_DISPLAY	+= clang-bpf-co-re
+FEATURE_DISPLAY	+= bpftool-skeletons
 
 ifeq ($(V),1)
   Q		=
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 92a6e12e42d3..5f2231d8d626 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -53,6 +53,48 @@ else
   $(info Please install libcpupower-dev/kernel-tools-libs-devel)
 endif
 
+ifndef BUILD_BPF_SKEL
+  # BPF skeletons are used to implement improved sample collection, enable
+  # them by default.
+  BUILD_BPF_SKEL := 1
+endif
+
+ifeq ($(BUILD_BPF_SKEL),0)
+  $(info BPF skeleton support disabled, building without BPF skeleton support.)
+endif
+
+$(call feature_check,libbpf)
+ifeq ($(feature-libbpf), 1)
+  $(call detected,CONFIG_LIBBPF)
+else
+  $(info libbpf is missing, building without BPF skeleton support.)
+  $(info Please install libbpf-dev/libbpf-devel)
+  BUILD_BPF_SKEL := 0
+endif
+
+$(call feature_check,clang-bpf-co-re)
+ifeq ($(feature-clang-bpf-co-re), 1)
+  $(call detected,CONFIG_CLANG_BPF_CO_RE)
+else
+  $(info clang is missing or does not support BPF CO-RE, building without BPF skeleton support.)
+  $(info Please install clang)
+  BUILD_BPF_SKEL := 0
+endif
+
+$(call feature_check,bpftool-skeletons)
+ifeq ($(feature-bpftool-skeletons), 1)
+  $(call detected,CONFIG_BPFTOOL_SKELETONS)
+else
+  $(info bpftool is missing or not supporting skeletons, building without BPF skeleton support.)
+  $(info Please install bpftool)
+  BUILD_BPF_SKEL := 0
+endif
+
+ifeq ($(BUILD_BPF_SKEL),1)
+  CFLAGS += -DHAVE_BPF_SKEL
+  EXTLIBS += -lbpf
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
-- 
2.47.2



