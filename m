Return-Path: <linux-kernel+bounces-332643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9AF97BC67
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4EE282E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DFF189F32;
	Wed, 18 Sep 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGy9dNEm"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8217C9A7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663414; cv=none; b=u5CXBVYNS7XfH5/DBtHvniKcNRXh3XUaep9OM6XfK0eXblNHK5a/KX2D5jc8KhQXFob+GSANEIVLG5NVZRQ2Eq8hCb6zYOp1kXNgw/l7OIaKSn+a2F+8Ss5dPIydfsYdQRqkDdxOFj7prWCHoerO48iZk60+l7SKwhkGdDJc+BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663414; c=relaxed/simple;
	bh=v8DcXf1BhgGJOau2KXFMnAiNGjrwcBnR8gUzd8YwlEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g/UB5roRndc6gtm3UVC9JFok3wqaCGnw4TurlCSdZe+nKIOliCOKWuYw7/9kXIehLrIssa8EV72JD4p8GXfMogD1J2+Y7hRHNE8jGHB9adngZRVKMTJE3FhzOhLhD+YLe7GDtKmzKa/YHnS+NDtocF6KOGKcx+VkH8ibz0zNdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGy9dNEm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206e614953aso68987255ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663413; x=1727268213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTKZFNlHn9F703T0EyhCC2dGWtgK4Zdb4VWczLMsNE4=;
        b=mGy9dNEmqrRMrqj4Z30F325cYbJnVcQ9sCwWOkkkPjAkF1bb+Se+AkFLMDtl5cpr8n
         xU6GYUf6eyxwjQrRvVNZW9JgOaQwBx9y+RGRo2mNCQz120EhxHW3ErEa6eANCkveCFYV
         v1HVEb50AFLcLFgDbs2BYIhKFlVh/IAcSjXhsOIb7l1mS+RobraZQiT7je72UtXTiYLz
         Vq/rG50ySTwkydPzhSkiWQXwBcsBn9t5l4odKBW4mlpCBhzLxx3Z9t4/9eLBzAwpu9/Z
         ycY3CHcz8GDUzNCcqa4xH7OCDh5OHp9TBDLOS8ZyBhjCJwxmJSbbWu2yPUGhD9CJ3fA8
         ozbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663413; x=1727268213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTKZFNlHn9F703T0EyhCC2dGWtgK4Zdb4VWczLMsNE4=;
        b=nsggLRNN5DBty+4tEzbmuG4JDyNrc73kGrwS/j3AnSBwiNL5iLJ0TwHuAX/NkZFKF2
         ieZMJK1G3o5cwAQSAgNac73u3sO8JhjqLkK4Bn0XiUvPwnmy/gxBPHgeswuaVcVzA5VO
         H9uvZB4rTHX28GfyQEHyYEanGcCU+UJyV93mxbVZocNAu+UmoBwGwZT6gBisU+6ek18b
         +TzIqB5nclQWq0ZL7QETPFvvJrvRQxwZtLnt/V6FRCAzr2BPhG3HTusoAhFmzXnkmvc6
         /omTrCEDcqvvR0jeXYdc5zymregi55iWDp6JpiZrVNR16Hl7REyPqbWEbBeOh3bTDuBd
         2FCA==
X-Forwarded-Encrypted: i=1; AJvYcCUJd6fJoEmOUDxSgyqOGxWErTrUSgw0GME31jYCVPUjoleMZ0zsX93FrIF7PsCpNAhDu2toE31oZX+/9og=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwPPgpNBV9OPhYoM0MWlRA+Q8Y9Unbjvj+fwNA+VxTmhqMVEz
	mXGqCz+pAv9zR+KA1NyaUXV0QoDab11L6aXQgmd2+HC36zn27Rwy
X-Google-Smtp-Source: AGHT+IH1JT2cZpqD8lenikRQuRcKc8hOZcbDHixmBaN7+AxopIarzf6KThf3RbADL6MSFjP80r9wsA==
X-Received: by 2002:a17:903:11ce:b0:207:6e8:edb8 with SMTP id d9443c01a7336-2076e364015mr305233115ad.20.1726663412577;
        Wed, 18 Sep 2024 05:43:32 -0700 (PDT)
Received: from xiaoa.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946f3595sm64238325ad.185.2024.09.18.05.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:43:31 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH] mm/cma.c: To better understand cma area during debugging, add total and used count logs to in cma_alloc
Date: Wed, 18 Sep 2024 20:43:25 +0800
Message-Id: <20240918124325.109236-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

[   24.225125] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 64, request count 1, align 0)
[   24.231963] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 65, request count 1, align 0)
[   24.235712] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 66, request count 1, align 0)

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 mm/cma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 3e9724716bad..cceff3b6a79e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -403,6 +403,17 @@ static void cma_debug_show_areas(struct cma *cma)
 	spin_unlock_irq(&cma->lock);
 }
 
+static unsigned long cma_get_used(struct cma *cma)
+{
+	unsigned long used;
+
+	spin_lock_irq(&cma->lock);
+	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
+	spin_unlock_irq(&cma->lock);
+
+	return (unsigned long)used << cma->order_per_bit;
+}
+
 /**
  * cma_alloc() - allocate pages from contiguous area
  * @cma:   Contiguous memory region for which the allocation is performed.
@@ -430,8 +441,8 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
 	if (!cma || !cma->count || !cma->bitmap)
 		return page;
 
-	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
-		(void *)cma, cma->name, count, align);
+	pr_debug("%s(cma %p, name: %s, total count %lu, used count: %lu, request count %lu, align %d)\n", __func__,
+		(void *)cma, cma->name, cma->count, cma_get_used(cma), count, align);
 
 	if (!count)
 		return page;
-- 
2.34.1


