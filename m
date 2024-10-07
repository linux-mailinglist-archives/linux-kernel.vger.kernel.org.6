Return-Path: <linux-kernel+bounces-353287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F067992B97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391E81F24EE1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D84C1D27A5;
	Mon,  7 Oct 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bABFTtW3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956C1CB53F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303845; cv=none; b=cyjC5Krn6tLi99LpzcLRwKRjB3CHbcsBbXgKorj2C4gkdyVNA/Joql/3Jve4NiSR4fsNGW9DsdD5LClcarfRidQu9g6CaCzygNN5TRQoJ2sZ7GrmbQmlHyfYAjCsnrETSVS4IA4WSiiCqcdF45Sh26k3tcHJFG3L/G2pekiVhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303845; c=relaxed/simple;
	bh=pDevDo+wMa9Y2R1TfjKko9pz+dsZmzvgb3aS6X+SvA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCGSbrfGX25fS0fRgeKmhCbh4WeYK6LN5uhaCkN8BWxobvSnfli3GNvM8l/HFm4lz4+zUAVByjZt55rV8C9+x7+gleQyRdbm/0b0O/MBSuL8ViZ9k+RxaRPBwIpySjhvNZd0a+POElJNIhw7IT14TwJeoVAjEB0TjA66pr+CM/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bABFTtW3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so58532245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728303842; x=1728908642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtsdn2sdnIw2THBvQxYTL0WcNMFNnP+qLKduuE3CQsw=;
        b=bABFTtW3c4Pg+zQzWlSJCAoYQC4CYW8OLx2K26vTisSY1WzwKhT0bK/1gEh6xKcECm
         vss8uuLVruYkb+fnS5SOUCskJQOWo3F9Y/aZ06483uEHcjsjkDiKJyDZGwHjNmVjOf4B
         WW2wHz+QbvBEJF3/rYOgp4KjbKYK7X9MzLSKv0KwTBDUGYZ20n1NOmwGagzvJLh9qgf4
         RnjH4PJdKPcKRHkOKv1seG4nHMMdgrqdLgXymkSQLGXGfggZpnbmjAoYdBTVPt9ceBJz
         ICILjdbvToWgau3i/4YqUcwh9Ccplx2KCE4w8ukXTFytqkfpC2f9pygjdvroxWYINzgb
         q+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303842; x=1728908642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mtsdn2sdnIw2THBvQxYTL0WcNMFNnP+qLKduuE3CQsw=;
        b=NKfVfuegNoCOM0YhkpOqWCFM7gCwlUZubH13G/rVS4k3Gy43Yk5+Ta7mqcgE+Ry4FE
         7VKW5AKy3BVg3VCJr/iVuD346dWXjCU05KHQ2N/lYJ9cgIfzNwePKnGVF+kopaCNt3E2
         R09CEWN+/nlVkuYBk3nV5BZr+8CVCHfOnOZKOYuLTvxpUX25sGjAHQ/U1MZiVQQ5oPzz
         PYll67ilnvCg+OVYGi5XR5kMku+/cQLnCYVpKxT2yd5eutd6zlxALxQqS2w0dBUZcLwP
         BFUNm4t1NFRg0qegGC95qxMbtAIdkbdGdcTwvK7i+Vfk8WJnoph9afp6DQKQ9HzCvZqP
         yfpw==
X-Forwarded-Encrypted: i=1; AJvYcCUHCe8AzExSEj2uwErrh/sE0OYRuP05ZyXOmLYnq5OcE7jJdS4UXqt/lJ5uD8YDPdKTYRf0+zioqnNDyWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1JM96iCEMFM6v01HTu87rlVKMeOPZe41FixqATI1yGseM0Dc2
	IPYc+okW9x9HkBcWoo0bLVewfSbQp1lJfE0eD3bD/PU6nj5t6QMeEYMyT8Z2iYU=
X-Google-Smtp-Source: AGHT+IE5a2HJKDGTi1yqW5JxEQV/1ZD7BrBNtA8ZdNme3sZO53ssLaPmPv8UF1maBvki6cDzJkuG9Q==
X-Received: by 2002:a5d:6a4e:0:b0:378:81aa:2653 with SMTP id ffacd0b85a97d-37d0e6eaee2mr9694904f8f.9.1728303842271;
        Mon, 07 Oct 2024 05:24:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695eee7sm5626914f8f.82.2024.10.07.05.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:24:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/3] mtd: rawnand: davinci: break the line correctly
Date: Mon,  7 Oct 2024 14:23:49 +0200
Message-ID: <20241007122350.75285-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007122350.75285-1-brgl@bgdev.pl>
References: <20241007122350.75285-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The line in nand_davinci_get_pdata() prototype is broken in a weird and
unreadable way. Make it consistent with the rest of the code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mtd/nand/raw/davinci_nand.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 5510b39c0b98..6c884b59bc98 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -487,8 +487,8 @@ static const struct of_device_id davinci_nand_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, davinci_nand_of_match);
 
-static struct davinci_nand_pdata
-	*nand_davinci_get_pdata(struct platform_device *pdev)
+static struct davinci_nand_pdata *
+nand_davinci_get_pdata(struct platform_device *pdev)
 {
 	if (!dev_get_platdata(&pdev->dev) && pdev->dev.of_node) {
 		struct davinci_nand_pdata *pdata;
@@ -557,8 +557,8 @@ static struct davinci_nand_pdata
 	return dev_get_platdata(&pdev->dev);
 }
 #else
-static struct davinci_nand_pdata
-	*nand_davinci_get_pdata(struct platform_device *pdev)
+static struct davinci_nand_pdata *
+nand_davinci_get_pdata(struct platform_device *pdev)
 {
 	return dev_get_platdata(&pdev->dev);
 }
-- 
2.43.0


