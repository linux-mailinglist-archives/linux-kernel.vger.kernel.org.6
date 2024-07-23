Return-Path: <linux-kernel+bounces-260346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDE93A796
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F231F23349
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388313DDA6;
	Tue, 23 Jul 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0xvj4lf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8C013C9D3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761849; cv=none; b=tF+KcoT59IJPbGvNiB8ISeHMZlTnNimfY0qT+bx06182VMBXwwuaSNJKdUbbZKw0otdQI5qWF1X1An0M6X+Td175BhrDVdnpYDP9i6gnQp2nn7Dd/MT2aLx+0zarwAuH4Yp9QC0dROsEJzec5FeV7siKgMXOnUAZaLYjS3bzKEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761849; c=relaxed/simple;
	bh=Y58wAguMTmz9yVCrmWD1/TDqZk6sn1TDi31Msev2X5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NMw6K2DkiBnHZ93xeFX2Tf2gtLdfWl5InHpup6kkzQ0iiapDUmI3KJGlxeb2bwu5NyXj7T6AAhNTtAHJ20ABGTkrEEUbyb8ZIBENvp53D4HqhDl193Cc4tOUQAHz9Hgl5hnrXXS1FSVVKUiPCkW4GJVGlhCippzvEQ8OlVp7q+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0xvj4lf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721761845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sTmt+mPR6Dh8yvYNnj7E89BbgXp2IxTdtH3bFQH013s=;
	b=Y0xvj4lfy//6ijU1WTULcXRRfASx8aliGoiZctBTDoI9DZawAKt9ao94URj0MsJzX847ba
	cC0UuL4tuxD5NtAFEQo1q6f0beylrreNrT6SvleuVsnIQHLf+qyuGlxqMdl+5ZepqIb4y6
	MnziGd7BqQ6WBN8W3AceA8O+QfM9ZDI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-flcJsAc6Pbi53CPa5Y7oVg-1; Tue, 23 Jul 2024 15:10:44 -0400
X-MC-Unique: flcJsAc6Pbi53CPa5Y7oVg-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-8213223337eso2153951241.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721761844; x=1722366644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTmt+mPR6Dh8yvYNnj7E89BbgXp2IxTdtH3bFQH013s=;
        b=Mxizw37jkYjrUrQIyRbCg/QepK7MEcqa1yIVmhXLbo3PCZ/9giknGCMCRxS5DWxkou
         gamP8LcKonWPJt7Gp55SA1L2JX1KkXUkpE08dlYYxW1HFVWkDMVRysMv6xCqH45KMIf+
         Yd8Ekd1M93+Q63HDASW+FENksRq1bGNfgtlcwMgjo8UtzJW4jtpxs494zRrHD/T4A42i
         E9H4+y2jmHZZeABX9Z08r6ZFttzG9TfQvD4ANzRC4Tr1QKjSV7uGwiM7NuVQSKeJtLjW
         rO7yWtE+l0TJayRWPHZiP5mTtFy2q4vX9uhUriB4BSt7uOxyX2UyBU368iIf6sQwsqqT
         XjJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjLuUDgaDUZ3LKkZGJQ0CRXZh4sjoKwwnQMGfUwWR1jY6/lT1m6uCa5O2T8BFO0WsHyWRpA/geCZk0E7j2xLECgXmUDGkYwPOoFgoO
X-Gm-Message-State: AOJu0YwbMovZy3Xbni6OJHGAQFfJHtVKwpx8WSXNBB4aCCW/dYc6JdrZ
	i4ViflqqAAyOdsA64dXx/Fm5lzO8Ch5d65Pi4AkTvdpeAgdn6p3qrzWSGCfhDgRo/QmWC667Fuz
	99adweB8BCBAU3iQrf8nG6XR8subnMsaR7DoQ8esj1Xi5I59c9VX770jiK0YkMRN1Ih8o
X-Received: by 2002:a05:6122:1da3:b0:4f5:1d9a:ad5c with SMTP id 71dfb90a1353d-4f51d9ab5f3mr9493107e0c.14.1721761843684;
        Tue, 23 Jul 2024 12:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbsG3Spdqe024LSLYLFda/r1gVi4vp0VlP6ZUyCQKUEMpONzanpiYNPezzXds561tCZPFRZg==
X-Received: by 2002:a05:6122:1da3:b0:4f5:1d9a:ad5c with SMTP id 71dfb90a1353d-4f51d9ab5f3mr9493080e0c.14.1721761843282;
        Tue, 23 Jul 2024 12:10:43 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fbd489sm505744085a.31.2024.07.23.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 12:10:42 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Marco Pagani <marpagan@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/test: use kunit action wrapper macro in the gem shmem test suite
Date: Tue, 23 Jul 2024 21:10:35 +0200
Message-ID: <20240723191036.131286-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deferred action function wrappers with equivalent ones defined
using the macro introduced by commit 56778b49c9a2 ("kunit: Add a macro to
wrap a deferred action function")

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c | 27 ++++++----------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_gem_shmem_test.c b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
index c3758faa1b83..f7f7d8b0f61f 100644
--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -23,29 +23,16 @@
 #define TEST_BYTE		0xae
 
 /*
- * Wrappers to avoid an explicit type casting when passing action
- * functions to kunit_add_action().
+ * Wrappers to avoid cast warnings when passing action functions
+ * directly to kunit_add_action().
  */
-static void kfree_wrapper(void *ptr)
-{
-	const void *obj = ptr;
-
-	kfree(obj);
-}
-
-static void sg_free_table_wrapper(void *ptr)
-{
-	struct sg_table *sgt = ptr;
+KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
 
-	sg_free_table(sgt);
-}
-
-static void drm_gem_shmem_free_wrapper(void *ptr)
-{
-	struct drm_gem_shmem_object *shmem = ptr;
+KUNIT_DEFINE_ACTION_WRAPPER(sg_free_table_wrapper, sg_free_table,
+			    struct sg_table *);
 
-	drm_gem_shmem_free(shmem);
-}
+KUNIT_DEFINE_ACTION_WRAPPER(drm_gem_shmem_free_wrapper, drm_gem_shmem_free,
+			    struct drm_gem_shmem_object *);
 
 /*
  * Test creating a shmem GEM object backed by shmem buffer. The test
-- 
2.45.2


