Return-Path: <linux-kernel+bounces-268790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FBC94294F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BF61F218D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B91A8BF8;
	Wed, 31 Jul 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSAMpE2T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD071A7F8E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415129; cv=none; b=plmjsK3RLEwBeB3bjlC1Hef8yET7HAGFjz0QH2h2OHdv+Q5AOJRnFi2u6utwbkoi1anAwBqpPpUnhNmHtXocOyAXP8Dxr3JjW3kQcVy1X6x0yBUPBAXXlDpP4dlX6bft5XgR4HzWvdCmel/xWcKWQQ9xb4Lz9MiIF6Avr5wZSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415129; c=relaxed/simple;
	bh=a0cdYEUD5oq5HcwAOKRBad0IN2/8nMfvuKyFag1tFvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk03V3JUmIDd6KOihYS0fA7tFS9FPn2dZgmp7YeNFg517Fe8NtNHo4uOrMklzlPE9JVTPUGEAnl+KXudgAMiw9O9M4Hy9a0xyi0DX+T1/PPqzve1Vgrrfu88wBmsxd7ho4DiT6ssNJcgdlOYHTywbSSNFM93pdKFC574FMlGC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSAMpE2T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722415126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIStciBh0Hb4EArNcfK9qlAuqUz7MQEBahYgq8BR7mM=;
	b=BSAMpE2TJUBcQKifcNQcN08pni7nxlWDnKnvyNvr5/25wDGH6fsrzmwwm0G5kYyY3oIfsW
	7kf5e6pnAtjHUyCDZ1K5ag1O0Tj9zwwVh7vCaI74v9hjJF7TbyPgMFIK9ZJIuNskjqyuPt
	Xc6baqRJYOvZRLOIavy8NAProOfBjFg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-urKv-3ifMD-FXKRfskTbAQ-1; Wed,
 31 Jul 2024 04:38:45 -0400
X-MC-Unique: urKv-3ifMD-FXKRfskTbAQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 435611955D52;
	Wed, 31 Jul 2024 08:38:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3354300018D;
	Wed, 31 Jul 2024 08:38:41 +0000 (UTC)
From: tglozar@redhat.com
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 1/6] tools/build: Add libcpupower dependency detection
Date: Wed, 31 Jul 2024 10:36:50 +0200
Message-ID: <20240731083655.375293-2-tglozar@redhat.com>
In-Reply-To: <20240731083655.375293-1-tglozar@redhat.com>
References: <20240731083655.375293-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

Add the ability to detect the presence of libcpupower on a system to
the Makefiles in tools/build.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/build/Makefile.feature | 1 +
 tools/build/feature/Makefile | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1e2ab148d5db..e4fb0a1fbddf 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
         libslang-include-subdir         \
         libtraceevent                   \
         libtracefs                      \
+        libcpupower                     \
         libcrypto                       \
         libunwind                       \
         pthread-attr-setaffinity-np     \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 489cbed7e82a..c4a78333660b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -38,6 +38,7 @@ FILES=                                          \
          test-libslang.bin                      \
          test-libslang-include-subdir.bin       \
          test-libtraceevent.bin                 \
+         test-libcpupower.bin                   \
          test-libtracefs.bin                    \
          test-libcrypto.bin                     \
          test-libunwind.bin                     \
@@ -212,6 +213,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
 $(OUTPUT)test-libtraceevent.bin:
 	$(BUILD) -ltraceevent
 
+$(OUTPUT)test-libcpupower.bin:
+	$(BUILD) -lcpupower
+
 $(OUTPUT)test-libtracefs.bin:
 	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtracefs 2>/dev/null) -ltracefs
 
-- 
2.45.2


