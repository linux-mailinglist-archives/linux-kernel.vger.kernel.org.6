Return-Path: <linux-kernel+bounces-342777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2CF9892E8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 05:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FC41C217ED
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B441F95E;
	Sun, 29 Sep 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWcU2Ris"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91011CD0C
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727580485; cv=none; b=LvqXy3D32wxErBfdYVaBOmnxDMrJl+gzIG4jtbAITd99cocqUoPfN75Tin4bV/Otpc2gtrm8sX7IK0o1s0VPza5FL6iZVTkZRlez3ycU2HflajBbJ7lG/TfhuWO5j0+QxOqDZuWOnpRxGjzex1VUI8SREOKX37KU6DjliW+WWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727580485; c=relaxed/simple;
	bh=4/ZZ/z4jWQPw0Uw+Rm4mGzWOcg4VBEF2kQ+ckU+E/Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rJEhCt0w+v9dPVrI3Wxm79u0iKbixHETqgeNYP0Q+ELS4u1Ww4PAKWPOQUCPwXRzJhrC4cjBfnrZPbeJs4vvbtZ1K6MTiA26ZCXXm/ajBz0cgptTh6GfPIBTL4HzV+9D9KqIxh2NBlJIuDtoUV3eAf2FdMhk52mVQA4Zgd+Bk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWcU2Ris; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20aff65aa37so27706245ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727580483; x=1728185283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UE8V6Td1Fw+A1+MJmjCr8qJzqzcVKk/EZFo8rjJKFqU=;
        b=hWcU2Ris0EBCz6eqKQ6MU4B6+CKka0WOY3KvMB9BvDV7VRtiFBZwCCd+WLVr0lQgkM
         rapHE5dqDBk99WLxXDTxfv3iQFy+UYpqQbb7GoRpgEhO9+EjHGDr8pvPK2WkpUf3V1E2
         DokNM3WxU5KsFN0yGlw2bEZ4rtGaU84cgQg9cvt8qLZA48VudsmT6ml2bfWgElkoTYwk
         /ogH0Mz98jwnpofhdiLS/ca8Srb/r0r22VlMYmXDfwqHy4n/0IlQ7u+IDTJjdaWyuL86
         SIYZMeT31T22kOMbd+E5WhfVAqkMBxK0r/1/j78yJbIIIF3Q2A9m3UmuRlqN/n8trjvd
         gcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727580483; x=1728185283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UE8V6Td1Fw+A1+MJmjCr8qJzqzcVKk/EZFo8rjJKFqU=;
        b=nrQWYVk3hqU6BvHhNFwp/uqyFKnrd3MvuUf2p+moU+0SyE/W454e24E1+fcm2jfdc0
         VEJ6OTAANJ8uQhEiaBHgr0kpVHOUo/JnO1yncjfrlzUbd9SEOaDe/wV7MVinDfVLAvTR
         mexf4HeTkY38TgFmFxFzOLGZ1up0YZfF5yvMijtmJNcmTYFut0JnvQap0QRbjjPzftD6
         lHQp9KPNqu+pFvcxvP+jpdaBBNadfy8TFQstX+mhJmuE9FvG3L91demu2Yl9J5a7xWPb
         4SeELihMPyPGMchJsnLfBj58JCT5vwKQbsOQA8MnxQIIf21wdhGCTuU+VMv4Jwpe5D1O
         7npg==
X-Forwarded-Encrypted: i=1; AJvYcCV7DWUEW4d0DzPIL3fqJtOh0kXTaTHt0bL/I8kZ7NWtGNPCt7pwD2uhOH9YU3r4EJ+XB+maJ8t7iB+j7h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1iggh8/LbZad9jVWFbWvDNirWQcB4WUnJiweVTmGlqW7kXlR
	fgXu/Jb49k16wpr9FAsMvNORJ8AWEj1KcQ/WreiGLezBJFC9nM5ZA9iwOQ==
X-Google-Smtp-Source: AGHT+IHsKCSR+OwxmfRjQdp2L2pSY3A7ZWZwjGQdY2SI2pU6AjcDsn4M0sLY7hurx0bNFRDEB1l1mw==
X-Received: by 2002:a17:902:d4c3:b0:20b:7731:e3f8 with SMTP id d9443c01a7336-20b7731e676mr8372045ad.26.1727580483093;
        Sat, 28 Sep 2024 20:28:03 -0700 (PDT)
Received: from xiaoa.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e115e7sm33482265ad.153.2024.09.28.20.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 20:28:02 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH v2] mm/cma: print total and used count in cma_alloc()
Date: Sun, 29 Sep 2024 11:27:57 +0800
Message-Id: <20240929032757.404707-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

before:
[   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
[   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)
[   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, count 1, align 0)

after:
[   24.069738] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 64, request pages: 1, align 0)
[   24.075317] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 65, request pages: 1, align 0)
[   24.078455] cma: cma_alloc(cma (____ptrval____), name: reserved, total pages: 16384, used pages: 66, request pages: 1, align 0)

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 mm/cma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2d9fae939283..90b3fdbac19c 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -403,6 +403,17 @@ static void cma_debug_show_areas(struct cma *cma)
 	spin_unlock_irq(&cma->lock);
 }
 
+static unsigned long cma_get_used_pages(struct cma *cma)
+{
+	unsigned long used;
+
+	spin_lock_irq(&cma->lock);
+	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
+	spin_unlock_irq(&cma->lock);
+
+	return used << cma->order_per_bit;
+}
+
 static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 				unsigned int align, gfp_t gfp)
 {
@@ -420,8 +431,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
 	if (!cma || !cma->count || !cma->bitmap)
 		return page;
 
-	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
-		(void *)cma, cma->name, count, align);
+	pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, request pages: %lu, align %d)\n", __func__,
+		(void *)cma, cma->name, cma->count, cma_get_used_pages(cma), count, align);
 
 	if (!count)
 		return page;
-- 
2.34.1


