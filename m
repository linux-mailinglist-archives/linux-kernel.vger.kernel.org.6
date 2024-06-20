Return-Path: <linux-kernel+bounces-223253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B945E911038
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185192899CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB211D0F7B;
	Thu, 20 Jun 2024 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WecGNaMs"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C71D18E4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906344; cv=none; b=QrAMzKg2bPUwnnExoKNbJFBav4Mf7qoJcI9mvIoV2JhNx8/5rOnHMz81OtBU+6iLbGHgI6dE9Rgk+Tc41k6sIp8RPQcMBELiXvTKADk4n4zOOr3rzkJVke3axau58dGO9lknfZXuqt4+av3/ImoK2hpB+SfpnngIJs4GAb14kyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906344; c=relaxed/simple;
	bh=4Us/VrK+pFb5LnKE8hNzRDXM2DGUvjJ7JpoDeE9B24Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABNxQIL+NCh3Du5s9rSTN4HZeKLi8BjPfDdL+AqG6KdDsaSw9dJShcOFwj/LRBFV/U6CeD0FOzlPM/KWtN+kfZcgoAxXJl2vYSmlIXp9JQeJtml0+ryCmk3le6tEL2QbzSprATb/ewwzLG3um71bl7/P9w53wptdSuLNYcfdE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WecGNaMs; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7062bf6d9a1so953471b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906342; x=1719511142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+W8qrsNzjA5KvK9XemaQbK3hnneV0OURa4QuE2WY6E=;
        b=WecGNaMs58p1PKf9iEuYwVwc4iu0qZnvp2oP0FNrrQg7gyCLA6+2mXVlzgig857hKd
         rnt00pN1ENFWg/9EhXYBtswurInkU6H0hdCT8j1cxhB0nW2R485LkRqlRBuyufsAI/ur
         UgshH3MxgTFKED5lolaXeYkNC7uC/xqIt7scBxktSLQaHnQGzUc6qDwXMaNwqEH+ryHm
         nJMlPwK+hOHbhGQiHSKc+8ZbFdpP4ePYJsvolzOtq6Xsek+S0OrD3tfetEKZaqcs5PDd
         Qprdc7D6g25BWU3jyvfVtjA/8J5x27N6G5pZS+gFNyF7QWxkA5+M6dFtcT5lLmvHcTIm
         pXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906342; x=1719511142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+W8qrsNzjA5KvK9XemaQbK3hnneV0OURa4QuE2WY6E=;
        b=n7wuuilwaMd91sDk44pQcS7j/2Bd8vko4QXg+z2ORg6zigs4F66LQLkPvdCQaFoQD0
         9gjuZLllx/ADthGh/qHvkokCtICpN4cPcFLs5KoEXTtujAqzno4OVYFwZdCGKCtlEaMo
         rgT4dkiNQkAd+Z9C8XpK9TMVjZJtIPRlUwPDb2lYoBbsccoPoYgFTwd553xVCpqU5WWq
         AJjfqLYZQUShVoNLiZ90hoTvP9ZJ+y8TVwBPfDm18XMbZ/Zbk5AN6KUdKPETLrhJVZQy
         +lR4IfrOKbYclKLY+RFzb9Myo3RToZJ6JaJkzgbj6HKx+mFy67qU/1K4EtUJXiufpOtl
         I/Hg==
X-Gm-Message-State: AOJu0YwvJ6sMOIMCruZ+25E7uyffNP5RzcXaIpnJO1tSTI3OwASWjuvE
	/Dj5j4mImN5wCTmdyr8aOVeXha9hykT+ceXTN3aP3R25iqhxrZ7QmX574mQJ8IQ=
X-Google-Smtp-Source: AGHT+IEbaEr10aoZqMNXkMGuZ5af7kUmWBhANe7UmWWwHg5OCvBD+k/5bSXXGBLZOHAs+1L/wt8fOA==
X-Received: by 2002:aa7:820d:0:b0:704:3491:d74e with SMTP id d2e1a72fcca58-70629cce5b3mr5236265b3a.22.1718906341930;
        Thu, 20 Jun 2024 10:59:01 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4c621sm12637684b3a.115.2024.06.20.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:59:01 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 40/40] powerpc/xive: drop locking around IRQ map
Date: Thu, 20 Jun 2024 10:57:03 -0700
Message-ID: <20240620175703.605111-41-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code operates on individual bits of the bitmap, and leveraging
atomic find ops we can drop locking scheme around the map.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 34 ++++++--------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index e45419264391..2b3b8ad75b42 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/bitmap.h>
 #include <linux/cpumask.h>
+#include <linux/find_atomic.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/libfdt.h>
@@ -41,7 +42,6 @@ struct xive_irq_bitmap {
 	unsigned long		*bitmap;
 	unsigned int		base;
 	unsigned int		count;
-	spinlock_t		lock;
 	struct list_head	list;
 };
 
@@ -55,7 +55,6 @@ static int __init xive_irq_bitmap_add(int base, int count)
 	if (!xibm)
 		return -ENOMEM;
 
-	spin_lock_init(&xibm->lock);
 	xibm->base = base;
 	xibm->count = count;
 	xibm->bitmap = bitmap_zalloc(xibm->count, GFP_KERNEL);
@@ -81,47 +80,26 @@ static void xive_irq_bitmap_remove_all(void)
 	}
 }
 
-static int __xive_irq_bitmap_alloc(struct xive_irq_bitmap *xibm)
-{
-	int irq;
-
-	irq = find_first_zero_bit(xibm->bitmap, xibm->count);
-	if (irq != xibm->count) {
-		set_bit(irq, xibm->bitmap);
-		irq += xibm->base;
-	} else {
-		irq = -ENOMEM;
-	}
-
-	return irq;
-}
-
 static int xive_irq_bitmap_alloc(void)
 {
 	struct xive_irq_bitmap *xibm;
-	unsigned long flags;
-	int irq = -ENOENT;
 
 	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
-		spin_lock_irqsave(&xibm->lock, flags);
-		irq = __xive_irq_bitmap_alloc(xibm);
-		spin_unlock_irqrestore(&xibm->lock, flags);
-		if (irq >= 0)
-			break;
+		int irq = find_and_set_bit(xibm->bitmap, xibm->count);
+
+		if (irq < xibm->count)
+			return irq + xibm->base;
 	}
-	return irq;
+	return -ENOENT;
 }
 
 static void xive_irq_bitmap_free(int irq)
 {
-	unsigned long flags;
 	struct xive_irq_bitmap *xibm;
 
 	list_for_each_entry(xibm, &xive_irq_bitmaps, list) {
 		if ((irq >= xibm->base) && (irq < xibm->base + xibm->count)) {
-			spin_lock_irqsave(&xibm->lock, flags);
 			clear_bit(irq - xibm->base, xibm->bitmap);
-			spin_unlock_irqrestore(&xibm->lock, flags);
 			break;
 		}
 	}
-- 
2.43.0


