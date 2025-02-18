Return-Path: <linux-kernel+bounces-519684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7801A3A0B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3371888A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEF326A1B9;
	Tue, 18 Feb 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoU0CBFV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58A26AAB6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890765; cv=none; b=p5vlBHHmpBHzuTppYGCttcntvp0zhrahmJi5UX0JQs2hoI+EyuhoTAeKqFjzDVHpXHRnslm4wapf8QllWFR/cOESnsbJzom9VU0W2Gt/P+5wDEg/2tvBofIJJ/iQB/UFhrJ83PmkM4BTOpvxPAZKIE1h1vRfGzhpCbnnWkX/vhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890765; c=relaxed/simple;
	bh=q+K7SBLdREUGN10PaqJHOWL0mSxjc+7OAFYDwtafJ6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAck0t8u8xZbsjVjJ/0Wc87Z1p4bFbE46XK36qid+kCO7Qt7vxj/CMwJNcNrUsGbmncOSkiwfGhVEE9PpAOjCzSFqJodTFi5iy1WanHysDtSXLnCgqLFGGvOKVtGQmgZ3vRFwd/FpfRIFFQVX/vFy9MiRwcg/4NcNIE+7IjnwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoU0CBFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739890763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MutaJ1T8FiM2gmghpIEBv1pTnM22TWTUmbkc8yLx1Vw=;
	b=aoU0CBFVjNKsjVxpVf+lg8a8/yDCdtBayrxYNGxEGbUJHGPYuSViNEGQMgUShrPzVt9Nh9
	brVtXKGAhSvqCk1Ceye0idlpXr93e4FzinuKCbIrl7vApzGSmUzOL/k65t3pBaSXxAOet9
	338dUUDobSRHfg0rVWEUiKOzscIw9gU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-ac1YrbtiMtG58K9LfBhTzQ-1; Tue,
 18 Feb 2025 09:59:19 -0500
X-MC-Unique: ac1YrbtiMtG58K9LfBhTzQ-1
X-Mimecast-MFC-AGG-ID: ac1YrbtiMtG58K9LfBhTzQ_1739890759
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA3A51801A10;
	Tue, 18 Feb 2025 14:59:18 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9319D1800361;
	Tue, 18 Feb 2025 14:59:16 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/8] tools/build: Add bpftool-skeletons feature test
Date: Tue, 18 Feb 2025 15:58:53 +0100
Message-ID: <20250218145859.27762-3-tglozar@redhat.com>
In-Reply-To: <20250218145859.27762-1-tglozar@redhat.com>
References: <20250218145859.27762-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add bpftool-skeletons feature test, testing the presence of a bpftool
capable of generating skeletons.

This is to be used for tools that do not require building their own
bootstrap bpftool from the kernel source tree.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
2.48.1


