Return-Path: <linux-kernel+bounces-577179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01FDA71999
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7B316FCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0412E1F3D56;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949201F30C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000917; cv=none; b=sD56GoEW1oEgib0ll3prCqteF9ZScxkaJzMKfKrQbLIjUOUPtb2ALsHqdCKQAQ8U0TVXB8VWjeQJAz7WwaVX75BIRz3zjvP4mdp103v0nPMVQUiDVaSRysu/u61eJNsLmKAHqn6WAcMzfpUyhfGXvLIJspbHQdSMvnvTmsnEeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000917; c=relaxed/simple;
	bh=gjToE7QgykzKawNsxmG3DcShp7PPTJxWmW+vtXnpAyw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Hxlf7X5RSB/Z28OwTh5fH+LET1aUdOWI8tQm8weghDcnvQDOn55jykRrGNZ7KLx4YLjaGTEeHUmwYNfhuHCF+DO4Z+KFP8yzA82Xgv2psLQQ9W6zF+jDGh1xSYr3/qlSmYY7TGBu03tAFJOdqRRazHVaIiM57cDfMrf90WTl2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44503C4CEEB;
	Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAl-00000002kCd-3yhK;
	Wed, 26 Mar 2025 10:56:03 -0400
Message-ID: <20250326145603.801808440@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Quentin Monnet <qmo@kernel.org>
Subject: [for-next][PATCH 1/9] tools/build: Use SYSTEM_BPFTOOL for system bpftool
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

The feature test for system bpftool uses BPFTOOL as the variable to set
its path, defaulting to just "bpftool" if not set by the user.

This conflicts with selftests and a few other utilities, which expect
BPFTOOL to be set to the in-tree bpftool path by default. For example,
bpftool selftests fail to build:

$ make -C tools/testing/selftests/bpf/
make: Entering directory '/home/tglozar/dev/linux/tools/testing/selftests/bpf'

make: *** No rule to make target 'bpftool', needed by '/home/tglozar/dev/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h'.  Stop.
make: Leaving directory '/home/tglozar/dev/linux/tools/testing/selftests/bpf'

Fix the problem by renaming the variable used for system bpftool from
BPFTOOL to SYSTEM_BPFTOOL, so that the new usage does not conflict with
the existing one of BPFTOOL.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250326004018.248357-1-tglozar@redhat.com
Fixes: 8a635c3856dd ("tools/build: Add bpftool-skeletons feature test")
Closes: https://lore.kernel.org/linux-kernel/5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com/
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Suggested-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/build/feature/Makefile   | 2 +-
 tools/scripts/Makefile.include | 2 +-
 tools/tracing/rtla/Makefile    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 4f9c1d950f5d..b8b5fb183dd4 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -419,7 +419,7 @@ $(OUTPUT)test-libpfm4.bin:
 	$(BUILD) -lpfm
 
 $(OUTPUT)test-bpftool-skeletons.bin:
-	$(BPFTOOL) version | grep '^features:.*skeletons' \
+	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
 		> $(@:.bin=.make.output) 2>&1
 ###############################
 
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index 71bbe52721b3..34a33c1ad96c 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -92,7 +92,7 @@ LLVM_OBJCOPY	?= llvm-objcopy
 LLVM_STRIP	?= llvm-strip
 
 # Some tools require bpftool
-BPFTOOL		?= bpftool
+SYSTEM_BPFTOOL	?= bpftool
 
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 557af322be61..3dc050317b9d 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -78,7 +78,7 @@ src/timerlat.bpf.o: src/timerlat.bpf.c
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 
 src/timerlat.skel.h: src/timerlat.bpf.o
-	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
+	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
 else
 src/timerlat.skel.h:
 	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
-- 
2.47.2



