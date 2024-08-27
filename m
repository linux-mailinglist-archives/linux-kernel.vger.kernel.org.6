Return-Path: <linux-kernel+bounces-303689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694F9613BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D3B22290
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAAD1CEAB8;
	Tue, 27 Aug 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RI+mUrYT"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6B71CE6E7
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775173; cv=none; b=crL0MY2VUiffUd3bLWNEo+EsJDug8HkGlPerY4DkShu4UOoaO523GdvFMB1mROC+JyX4l0xsdHg+I/FpXx/OnOBF6Jj58dE81PSqdFQea6F4dYhTYyBkTYDgUGlgPsDfGYX0iw0+iJQFjqN/+LP8+/Aw2mn5eq7aw1dJmHIKKNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775173; c=relaxed/simple;
	bh=fY38fN99qRFKXKSA5I+1rUysd3mbokIVBvaR3N/Edko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyIlzuAAjExB0VkjK7cdnm3KRjHI2QNOG9t3XMAfIYxhhe2bOhKhTlrFOT5WaDUgCFQizPfQ7799o0IjPJRXa++s2fXmwWbgK3Lt2nJ71ePZAoMDG2l9poRVOkTni5F488PreHr/8zIKJC9jz4wkQrZMRpaLUg8Wl9bmWo/e6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RI+mUrYT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5343e75c642so4888286e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724775170; x=1725379970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VeZJltoLAKxh7d3cB6a8DRSH0vtTp7P9mPnF3uj0f8=;
        b=RI+mUrYTpwomUtNNZddBxcnpkQo3+xlfIbutUj2xTqTH43Yg0/Rdd8Cl6kX/pRYRHt
         DjhmiCJ23GZW7N18wuGDFve1iXdkmWV0GJn790afZL4JkdtFVahHmrf12Oa5ZCDWDtKX
         TBTqWSTExIUt1sB1uzIFV3kOhnR4bB0mxwLJpuAymG21qUyorC75pnXf4awgotjMn4mW
         7FpGKr/K+8qVkJDD1hmNfTPBP/b2/Q8pS0xR2MByIWmvm+uBz5NGj6CHYhnbAqMYFHlb
         /rI3KA1mCCJftKG19eIno1N00h5WRZu+3ttyqgXVhlc9cUgtRLznHWVqypD+NIOe497K
         x9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724775170; x=1725379970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VeZJltoLAKxh7d3cB6a8DRSH0vtTp7P9mPnF3uj0f8=;
        b=jxRVn377Guydt94dq48FCtjbbaA0RtPuixARH9AombSxEtEUe1x0HewDJPU0X5Xj59
         Emi9wqIE518n53n794DmnSEeuRyEDCMB5Nmz3Rvln/9gOkmQCM4TRucxR95VjTwRQORW
         K0zJD306KetLkolhfZLhDMkvCzdBfWDg5Gnti8+PkMsvIZOd/2BdCfXC91qC1TvCrJ2a
         QYgT7MDoGdIMyRQpsuFTxP3jHcx7hJGp8NxsC4uK7QD5wBLXxtrRG46WAKpSgTYpukcd
         /qH1AUPk5rMlye39bcMsz7hDXqz3UU6plECqjDbGdlszOJ/mWb/jF3QdAVA4pT3XnD/Y
         CIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhFRvVYZQqetMcp5ioCj77lxqPCPBzoPXVTex50KxWHgXAAx4ftiCcm2N5VTvzAOwF7MytfZ5pnpr6wZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQcl+54/IzQ8gMZBam75rIVuhuc5TAGrXb48NoiUwrY2yqn6R6
	d5j77BoJumq/jZbaedJvEVvvdp3Ezyh9AUq2esLVhYE2PFCg0oJix+Uk+cZ47Hw=
X-Google-Smtp-Source: AGHT+IEn6EiOoC6u9T3Qh/ZYHO31b5oMxMsAnawAD7VSKPISxZfLW3mQWnzXyfQVhrfz81mditnTcg==
X-Received: by 2002:a05:6512:4004:b0:530:aa09:b6bf with SMTP id 2adb3069b0e04-534388330bcmr10078492e87.24.1724775169565;
        Tue, 27 Aug 2024 09:12:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e54b50dbsm127893966b.93.2024.08.27.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:12:49 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: manikandan.m@microchip.com,
	dharma.b@microchip.com,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hari.prasathge@microchip.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 3/3] drm/bridge: microchip-lvds: Use devm_platform_ioremap_resource()
Date: Tue, 27 Aug 2024 19:12:23 +0300
Message-Id: <20240827161223.4152195-4-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
References: <20240827161223.4152195-1-claudiu.beznea@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The devm_platform_ioremap_resouce() does exactly what
devm_ioremap_resource() combined with platform_get_resouce() does.
Thus use it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/gpu/drm/bridge/microchip-lvds.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
index f04831106eea..85aff8c5aaf4 100644
--- a/drivers/gpu/drm/bridge/microchip-lvds.c
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -154,8 +154,7 @@ static int mchp_lvds_probe(struct platform_device *pdev)
 
 	lvds->dev = dev;
 
-	lvds->regs = devm_ioremap_resource(lvds->dev,
-			platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	lvds->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lvds->regs))
 		return PTR_ERR(lvds->regs);
 
-- 
2.39.2


