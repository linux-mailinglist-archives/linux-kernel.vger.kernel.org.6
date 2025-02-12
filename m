Return-Path: <linux-kernel+bounces-510583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A7A31F0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE29168A01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4FE202F9D;
	Wed, 12 Feb 2025 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HM4EOh65"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FE31FF619
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342004; cv=none; b=QqukyfkLrexONqCBUFYw/Cd5AhXN3BAAe410cpxk4o49e5xyPUJq/Kbd9MwpDVVy73L7wUrrmZwyde21/ef55RBgO31NMoomP9Kqlua3dKoSQza++VSsAy0EikK3GPAL62S+cUV2EzsI8LNBUdFtbdfyjdyxsJcsn51/iM45o/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342004; c=relaxed/simple;
	bh=IRNOrDs38GxZoqcpi2Pg4Y3Su9b9UpAHfoJgnAuvVZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJC2QyYIFICch0vaCUc192G8m6LKWHhBGgvfHjDxQ4LXG7mGI6zmJZaU1alwgzyx1KDI9PCny/qemAir8RWJM/wTMuAXI2h5DZyK7PA5WRXrZDyrjOtIZOaXHQJMJSq4lcXZC81lRaRXXgSxi4F0YwGC6nehk1hZqbRh0wapaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HM4EOh65; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f6d2642faso99524185ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739342002; x=1739946802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDJRc+CzjHHBPozwYIKOoKTE7RtcGO1bK7SyyTKpM/I=;
        b=HM4EOh65SO/ZvQDsQcOul2wug7E+hygDh0muC+GHZAFKeVe/stD22J5UgiLmdPDlDh
         2Q0YK9+fw5gQIGgnPtbg17MnD27cQDc/m/2a+XNpNBtVS7uDqe1q3xgI5U/2TRWSOnAx
         ErzTDmCiOPozMP/UOP1BkJ1yG33aMTgO9SJdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342002; x=1739946802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDJRc+CzjHHBPozwYIKOoKTE7RtcGO1bK7SyyTKpM/I=;
        b=jVZZTGLZX5LOU5mvXTQpI8wDDyzH48by8R4oE5Kk5NeBWx4TZpITtKpQCG5qKAwAFJ
         qS/rz4dJMz4ko4WpauzHk2apxQJBx0ImaIOIGKvTgDU2C1SyHxuefyNBxhRhVyxaUVjk
         zp7DROh2MHt+MI4lO3Zxq2n3Zee0elnEkATB1yaTTomJXb/hxTlnowUOlihiPih3Vq1G
         LAWLpQrSFFbNK4L77R0rdCNTgiSkJiirOGty/bu2mUMj6z1nkn3A99+AcBwaWRckI2IO
         TeraOX9CZjMc2RzlkLU/MkZwMciKtHLy2Aqi8rE//ItKr9zf+jKXfvJB+xR/5KIrOYkZ
         7mOA==
X-Forwarded-Encrypted: i=1; AJvYcCXxQcZfFgr8JbYFrj14+VQPzhbOJPBIPElaL9n++Osw/GNxaaFDuh/iHbZbMu4Fr4GqP9yUWw11BbloHSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZGwjQt/Yjsk0NVhT88SawMC0SfrdkEvqsraM5yDzLXxf2jSGi
	ciy3OdmA4CJEcugXHlN/ovM6MKKMLV0rt93GPqtaMQfJYAGexpzG2vhMQuYjoA==
X-Gm-Gg: ASbGncub7VrU3PFpCwYYi0s1IXRFZ0e8msnmARyfcSJTwCnRaYU88bUfcROI3UkRmQ5
	UfsbXD4TCP2RfNhhZa72trahLiTRkFxS5UHSw1v8Ah0e5uaICaRf1GY1Fvc7/8cfc+fD05AD+Ha
	nnp0KjjshjB21qZfQoFEI/8g/NijJXsj57zrPHHB0JWm0Z6pIiSQy9VCfr99WojS6TXN4hxotsP
	NUouTeK8kcjifuBFVQ5YqjZnB+7tEQsa/u8xtduTtbL0zfGvDKfFw22GyS9Os/IrE1VVOEHpenP
	GIFAG9ztSaqV9gYEFw==
X-Google-Smtp-Source: AGHT+IGOuYujF/oHMf514Cu6FZkIg94rGPYgxxAA4Ed/XcTGYHy4Z7A3N+oerldYL8V8e8DNCN1OUw==
X-Received: by 2002:a17:902:da87:b0:216:3297:92a4 with SMTP id d9443c01a7336-220bbc73ab5mr34950945ad.46.1739342002127;
        Tue, 11 Feb 2025 22:33:22 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3687bde1sm106393605ad.195.2025.02.11.22.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:33:21 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 16/18] zram: do not leak page on recompress_store error path
Date: Wed, 12 Feb 2025 15:27:14 +0900
Message-ID: <20250212063153.179231-17-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the page used for local object data is freed
on error out path.

Fixes: 3f909a60cec1 ("zram: rework recompress target selection strategy")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c6310077c221..f4644c29f74e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2017,7 +2017,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
 	u32 prio, prio_max;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret;
 
 	prio = ZRAM_SECONDARY_COMP;
@@ -2161,9 +2161,9 @@ static ssize_t recompress_store(struct device *dev,
 		cond_resched();
 	}
 
-	__free_page(page);
-
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.502.g6dc24dfdaf-goog


