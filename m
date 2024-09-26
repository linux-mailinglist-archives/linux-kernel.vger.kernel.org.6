Return-Path: <linux-kernel+bounces-340417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283E498732E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092B11C24989
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC015DBA3;
	Thu, 26 Sep 2024 12:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpEDbugS"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157414C5AE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352058; cv=none; b=mHvP9/lCFcwgjTdBzb0zVYACMIeiJZYrGIQmjMeGGSOuNrScyp+J6Coz/aw5iNbQEfueUjLkjQVkbXukqEp4+LUDWVKq71ka2MmXkDINdEbikmC+/AE1KWXlYz9A8jq0xGN5OAXBICGL1XTbdx5QJavEXtc5ewt1lzBLC0lI97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352058; c=relaxed/simple;
	bh=1IDIx+9Wanu9Uu3uGwq+qvd2AaETcdP6DtocYfM5fNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qJICTKWzv2zcefWCXw6v9FqEm56Rg1MVzAkPRMhRsPpOf7+XrKh66d8l4VhHZaGmS0eFRoJdqs/Y9KoZD0FImZZQcddBiPerUGqH9l5/6fhNnJ03wTagTUpbUU5RRtCN17cotPJ4O19XqpnidUiDDJ19WbdKH48X/9TIok4zlGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpEDbugS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71b08405187so788427b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727352056; x=1727956856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7KCWGxZhj1y1aKLk6OuylPhX7GhAPrJcm5GWveFmkw=;
        b=PpEDbugSRRdfjRuu+UOXdmm8LMmZsWeAEu0/9GGdXTR95bxCL9mUbpgt5wbcsXmqxg
         YHFWBzSGUCAej/OopQJ2LrB5tWXTphjhemAF9FLdE72PkAkp9JGcR1fyiB/YP6tgecZD
         /cK3n3He0tqWj0ROeCiywm1Hb8i8sJGLKeH9LYmreh/tXfxPAkNPlivepuXjqxlvTyJE
         PBrQBk2xLjJKXGfODkzJqU1Yvb/STSXaYi7v0z2Ksl0Y1WThRNJ7RrkjWOH/FcM1kfgL
         ooG6nNgfzUCIRS/xNtF+Bm+3WAK7Ir8EiScCxIGdIaAGLEIzusZljop/UZxTGjJDPBKU
         lN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727352056; x=1727956856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7KCWGxZhj1y1aKLk6OuylPhX7GhAPrJcm5GWveFmkw=;
        b=NOVh8QRylta9MBlFoN1MmOxb0dGhS6KWYLarMvHbQOZaw2sNncVPLM3OslzbV2SCQA
         G6SVZsezt/7Hn/lyaEEyjZylx8cW1kC3Zk80wTlzzYtkg1Q7scAGfoTwWGpjIYXjfeqa
         eN1alyfJgSrxcWcRYmDyunzzCmQetumMLHTPFCsF+olqAgXVQAh/W9BbNsfaPMT5OCJ8
         6drprzIQQB/45YWZqrgVHXBoaRslz/s//uXqHysbx+S/KNvDuYA7RDOVUTo5URa3KR9n
         dD/D7n3Yvamr6QCjRVWqY1Z9b4cggO0Rst+GrlnSeheisi5NQkQs/8XYkwAcclczAUZt
         GWsg==
X-Forwarded-Encrypted: i=1; AJvYcCUBDmv8IbTIYS008FqWjhRPwzBnmhNg37vYeVxc1vBTjGPGQG3xn3Tman7n3z2mm8nojrZNtRNybQdO4hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFcU092K9Z4WPfBomc/nlEy2Av9A1f6+L99JmcMGToCrCb6/J
	hB7m0sAb4mf+WcuYdsasTZZmn3Po8n421RYEnJDxXbcSzPgcX5P6
X-Google-Smtp-Source: AGHT+IESzLMriRLSPqkZ4Cp7hI+8v1XHdKwNCcIXZ+c9djXqMKBez3id/sdylBSuj2PoBH2dp+k7iA==
X-Received: by 2002:a05:6a20:cd92:b0:1d2:e807:b65b with SMTP id adf61e73a8af0-1d4d4b9bcddmr7864536637.37.1727352055854;
        Thu, 26 Sep 2024 05:00:55 -0700 (PDT)
Received: from xiaoa.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc967539sm4323103b3a.147.2024.09.26.05.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:00:55 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH] mm/cma: print total and used count in cma_alloc()
Date: Thu, 26 Sep 2024 20:00:49 +0800
Message-Id: <20240926120049.321514-1-gxxa03070307@gmail.com>
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
[   24.097989] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 64, request count 1, align 0)
[   24.104260] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 65, request count 1, align 0)
[   24.107504] cma: cma_alloc(cma (____ptrval____), name: reserved, total count 16384, used count: 66, request count 1, align 0)

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 mm/cma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 2d9fae939283..fc35a86aa82f 100644
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
+	pr_debug("%s(cma %p, name: %s, total count %lu, used count: %lu, request count %lu, align %d)\n", __func__,
+		(void *)cma, cma->name, cma->count, cma_get_used(cma), count, align);
 
 	if (!count)
 		return page;
-- 
2.34.1


