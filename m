Return-Path: <linux-kernel+bounces-549623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF41A554AB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D197A3AD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92EA26AA8F;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF3255E54
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285104; cv=none; b=pUQFEkSmgG1ypSlIfPuGz9WGtCWKGlUAIau9Azwm/jdiWfsLV8zh1qV3lkszil0EmDorzVR8QiE3tBOnEhHkTq1h8RZXH9h0VPih5KKzOpJteZ/zx0U2IzmdtXrPQDO9jMVqS4umZWLB94VfyEVTV8au8QPwn/54vBSD4YzECYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285104; c=relaxed/simple;
	bh=/ObXtS+zWSro/hwzqIMzWOPpBwE3Ga++eqdELVgA+Gs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Xeobfnzb00qUD9w6EY/dsbG5FuURF0JjkRqxzE7dNkDNjD4h+3KqhxwNMll/lZXv8N0ckac7SAYBWvoN0PKPwX+UBSGNb070j9Q6NVT0KFRKCsrn2MnxR9l9UgYx75Mu1xfzOfoB/Fe6HI/wfycMB8t/EcoJ6p2lNjY5CR7fwbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2522BC4CEE8;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFnd-00000000PG9-3WJU;
	Thu, 06 Mar 2025 13:18:25 -0500
Message-ID: <20250306181825.696586340@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 02/10] tools/build: Add bpftool-skeletons feature test
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Add bpftool-skeletons feature test, testing the presence of a bpftool
capable of generating skeletons.

This is to be used for tools that do not require building their own
bootstrap bpftool from the kernel source tree.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250218145859.27762-3-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/build/Makefile.feature   | 3 ++-
 tools/build/feature/Makefile   | 3 +++
 tools/scripts/Makefile.include | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1931b6321314..1f44ca677ad3 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -135,7 +135,8 @@ FEATURE_TESTS_EXTRA :=                  \
          libbpf-bpf_create_map		\
          libpfm4                        \
          libdebuginfod			\
-         clang-bpf-co-re
+         clang-bpf-co-re		\
+         bpftool-skeletons
 
 
 FEATURE_TESTS ?= $(FEATURE_TESTS_BASIC)
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index cb1e3e2feedf..4f9c1d950f5d 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -418,6 +418,9 @@ $(OUTPUT)test-file-handle.bin:
 $(OUTPUT)test-libpfm4.bin:
 	$(BUILD) -lpfm
 
+$(OUTPUT)test-bpftool-skeletons.bin:
+	$(BPFTOOL) version | grep '^features:.*skeletons' \
+		> $(@:.bin=.make.output) 2>&1
 ###############################
 
 clean:
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 0aa4005017c7..71bbe52721b3 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -91,6 +91,9 @@ LLVM_CONFIG	?= llvm-config
 LLVM_OBJCOPY	?= llvm-objcopy
 LLVM_STRIP	?= llvm-strip
 
+# Some tools require bpftool
+BPFTOOL		?= bpftool
+
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
 
-- 
2.47.2



