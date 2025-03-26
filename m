Return-Path: <linux-kernel+bounces-576359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961EA70E42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8435F7A5590
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0611DA53;
	Wed, 26 Mar 2025 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5bi/cya"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A64B67A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949649; cv=none; b=FDbRJ6lClYdlyObApj8Rd6j2GAybO0N7JsGFUGubVWJsBiKAzs+UjzBC2d5cVa5ew++OOjs1mWYccWwZx/pJlMPACp6KjgV2/EGwwt/bkjbcApUwmTk8uSB269xbDVbkNC0KfylHaWs3aieHH7MHoNDz/fMp0E6yabxOuoCl2Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949649; c=relaxed/simple;
	bh=efOHKhADG0LVdVjQwpE9pSn3MTJSniuA8sQ5t9VJ8/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JJaDbz+dx/GRefftSkGuUBavsOiN3tS5+6IUmJrghli+Hfk7zfWqsCGaO0OhfXcd3/jAXeWQdPkgJeRkP38fbe770ruFulVRkDK39rLi8vAHfT07ipMgI5q7mT9QDbllXUBD6PHVHbebqZflqpfIJQC0v7e3H8cwn8ONCQqgZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5bi/cya; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742949647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2tX4edrltQifnxcWbzYvJ8/3NP9BgeSuosZ8Lt5jiAc=;
	b=T5bi/cyaB9vO/YvYd4xXpseN9magUB47G5v1gUcGByvS7a785ihT3rE2hfxUVUFoFcHos9
	MF5/3aVKwQTXl8vjUw9LP8GHEvtVKzgWNceGGdrJqVRPMUG1nSyH81hrNmNjGrN29XE1RY
	ZRxs7pa8rewLgF1oZIgkQZrQwsYmGIA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-IkyezFRAM5ShJAbKWzNdzg-1; Tue,
 25 Mar 2025 20:40:43 -0400
X-MC-Unique: IkyezFRAM5ShJAbKWzNdzg-1
X-Mimecast-MFC-AGG-ID: IkyezFRAM5ShJAbKWzNdzg_1742949642
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CE561800257;
	Wed, 26 Mar 2025 00:40:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 890711801750;
	Wed, 26 Mar 2025 00:40:28 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Quentin Monnet <qmo@qmon.net>
Subject: [PATCH] tools/build: Use SYSTEM_BPFTOOL for system bpftool
Date: Wed, 26 Mar 2025 01:40:18 +0100
Message-ID: <20250326004018.248357-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/linux-kernel/5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com/
Suggested-by: Quentin Monnet <qmo@qmon.net>
Fixes: 8a635c3856dd ("tools/build: Add bpftool-skeletons feature test")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
index 6268534309aa..5158250988ce 100644
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
index 4cc3017dccaa..746ccf2f5808 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -72,7 +72,7 @@ src/timerlat.bpf.o: src/timerlat.bpf.c
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 
 src/timerlat.skel.h: src/timerlat.bpf.o
-	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
+	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
 else
 src/timerlat.skel.h:
 	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
-- 
2.48.1


