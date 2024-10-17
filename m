Return-Path: <linux-kernel+bounces-370618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FCA9A2FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071571C21D18
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7450F1D54EF;
	Thu, 17 Oct 2024 21:23:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192331D0F60
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200210; cv=none; b=GF0qWq48iUHGmoODiO35y8RnEQpCR3hP3YgbEabzyF1vpOd/dIcsgNXuDtnLQhx3AcMP3nrJWnfPNMLTOUzMq6V1HQbsVvaDOJA78w9WRmMG7dUVXGPOD+Yjvmq/zwvXcNMBiiR6fV4xcLUwq1G2EXU0/zEIEK3Y5VCD+YSQjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200210; c=relaxed/simple;
	bh=JY+r60lUnKKyaxhjO3X/QFJmUaemgGjxXMBGlHoA19E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fouZCOVFLyabwcRhC+1xsU8s76RVmQe0DU8JBCndhOop5UXSY3gsaOg4Is3TWNb//dL44IKY9sjvu3a4dyqWfIIlU7qDEhtXNNhWgKpGIOJ7jisj60wozw8ccresNxjGkmH781P73SsWSGeSZApOh8VjSnhWgEkVdpusJuWg/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCCEC4CEC5;
	Thu, 17 Oct 2024 21:23:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t1XyM-00000003wDe-1E2v;
	Thu, 17 Oct 2024 17:23:54 -0400
Message-ID: <20241017212354.154428413@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 17 Oct 2024 17:23:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>
Subject: [for-next][PATCH 2/6] rtla: Add optional dependency on libcpupower
References: <20241017212328.560060762@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

If libcpupower is present, set HAVE_LIBCPUPOWER_SUPPORT macro to allow
features depending on libcpupower in rtla.

Link: https://lore.kernel.org/20241017140914.3200454-3-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile        |  2 ++
 tools/tracing/rtla/Makefile.config | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index b5878be36125..a6a7dee16622 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -32,8 +32,10 @@ DOCSRC		:= ../../../Documentation/tools/rtla/
 
 FEATURE_TESTS	:= libtraceevent
 FEATURE_TESTS	+= libtracefs
+FEATURE_TESTS	+= libcpupower
 FEATURE_DISPLAY	:= libtraceevent
 FEATURE_DISPLAY	+= libtracefs
+FEATURE_DISPLAY	+= libcpupower
 
 ifeq ($(V),1)
   Q		=
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 5f8c286712d4..92a6e12e42d3 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -43,6 +43,16 @@ else
   $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
 endif
 
+$(call feature_check,libcpupower)
+ifeq ($(feature-libcpupower), 1)
+  $(call detected,CONFIG_LIBCPUPOWER)
+  CFLAGS += -DHAVE_LIBCPUPOWER_SUPPORT
+  EXTLIBS += -lcpupower
+else
+  $(info libcpupower is missing, building without --deepest-idle-state support.)
+  $(info Please install libcpupower-dev/kernel-tools-libs-devel)
+endif
+
 ifeq ($(STOP_ERROR),1)
   $(error Please, check the errors above.)
 endif
-- 
2.45.2



