Return-Path: <linux-kernel+bounces-324248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645B974A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C20E288174
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E47580C;
	Wed, 11 Sep 2024 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="CpwdqHXI"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B238DE5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034904; cv=none; b=VbQ4SgZ2DAnfET624J/xbX2VHR7u0wqr8gmDexORCG//a3v/3zOZ6x6hUCzBu/mHlKF/jdJRww7FRBFJLaH5Tgo80ginl4wjVlbVTs/sMvFFfTfib6Buhgo4YbM+K6BzWpEviHdfixy+cBKgnv1GVIR2rG+awdnCy/oXj3SHoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034904; c=relaxed/simple;
	bh=PQjQYLlgol0s2xXUQS0tc7U8m5i0EhHDVAAEg3ws/4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK7qLulR5L7Qn4fLcutwWJe4Og70OK/VU0AzV5EL2yOkcUSM1cO1MAI0OGVHxyYdJeRcSLkCpGAw8DWs6zoJaATumr+Dn8RoMHXrrkC/F3NEbRpHfz1IEk3zwh00ndMZdskprEj+RODk+tWH2EV+5iFmEnajA7q8pwF7hmrlYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=CpwdqHXI; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=CpwdqHXI;
	dkim-atps=neutral
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 7667C5E8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:08:21 +0900 (JST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-270617b90b7so5058376fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1726034900; x=1726639700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lp38k0toLxisIn/B8aEYnDA+fE9TR3RoFUskSoeQ60=;
        b=CpwdqHXI4uAX/jznQemh+yLqBKDMvzXbLbvPSO8bPxh8EuRJnUq9U18TmtHvcJs8lK
         XY3NjPbXC8zYYrnGXTrMu4mtXP+cZyRaEwjMsA0ronXrvzEPRw9Qs/owa/k6EWXVz3sb
         aOnngY3UC7+wMS/E8Jd0Hx7+gGEodj8uYqvfjMXQTNYFPzlUL81BOpjD4zu0Hb5hwUip
         xsEYg/K98c532kwzXDtnrHCp3H8CQe10k7Q0wEVAt/sgnod8MBSLV7lCU6EkN1u5TP/y
         eOStM7bMK/FVjSQPKose/GX40BYLkoPR+ix+elAPFNIxrgOS1JpXhy0SX4R8dpnpKOSc
         cgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726034900; x=1726639700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lp38k0toLxisIn/B8aEYnDA+fE9TR3RoFUskSoeQ60=;
        b=dDoDgRm114gxOdm96yFiBq5fwAx+X3MCojDfjA7vruOGHZdJv3R9/a4BQ/iaTCvPH+
         9AQw3nR/8hmUtefpBKmbsnoYapkPS/DRYmJ+WCgWAfzoplcWSFip5ZApc+t1SRVaJx+T
         nWPFltS18D0GCVHKMAL/Hz1P/DtJKBzZZnI/4I2OHCbXOy92Xiz2qVnbzSSXs06JDQvm
         rTxl5bJB4Il+d0eRVsXGuwaPtlaLsvHMlt96zD9Tf1h8RLg2yA4bg1U2FVM/bsnx41V5
         XzIbHu6CYiO0mhlbAxA3q4pNqk+nOVk7I2Rq8IaSytlGKcSqAKrwlJOFlOzQ9rTTmvzk
         E+kw==
X-Forwarded-Encrypted: i=1; AJvYcCVu4/urpO/RKAtcI82pylFDveupsZ58oN3PLfHe9rvubCU08R49ClNITkCyvOSC3sXE3FK6tNe9aJX1NrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5eRkGEP4P7HDaU5ljjVI07VJ1w0vkqe9gAfI2MW0s9vpOcJ7g
	TfzERfFTXZG+Z92P9fTtAMg7vbymK/vJyxzxvAMpTh/dGQ1Opmo7zptCgBgBPk+EXT4ZbKUNAri
	vPHYLa3qieYaWsHFcePhunHDvRL5k5/rnPHY6dt41KXxx1ZhHggsaTTejnyRg3LA=
X-Received: by 2002:a05:6870:e0d2:b0:277:e40b:1aff with SMTP id 586e51a60fabf-27b9d92257cmr9017161fac.9.1726034900073;
        Tue, 10 Sep 2024 23:08:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxdpLsS49QByP64MoIJ5Yg0iFT4+YNDfB8VHF2UKv2JNQthocyLtssFQVJrFtRaLDY2b5xFw==
X-Received: by 2002:a05:6870:e0d2:b0:277:e40b:1aff with SMTP id 586e51a60fabf-27b9d92257cmr9017144fac.9.1726034899668;
        Tue, 10 Sep 2024 23:08:19 -0700 (PDT)
Received: from localhost (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ae07bsm2267726b3a.163.2024.09.10.23.08.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 23:08:19 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:08:07 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: Frieder Schrempf <frieder@fris.de>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>, Adam Ford <aford173@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
Message-ID: <ZuEzxw96vRlYJ321@atmark-techno.com>
References: <20240910181544.214797-1-frieder@fris.de>
 <ZuDjAwPxHeJTvXAp@atmark-techno.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuDjAwPxHeJTvXAp@atmark-techno.com>

Dominique Martinet wrote on Wed, Sep 11, 2024 at 09:23:31AM +0900:
> so if I find some time I'll whip some loop to check all other values...

There were more differences than I thought there'd be (see diff below)

they're all minor enough to probably not care, but your script finds
exact values for them so it might be worth updating the regs if we keep
the table...
(OTOH these seem to work, and "if it works don't touch it" -- I have no
further opinion now I've checked, curiosity is sated)

Might want to just check 154000000 though, reg6's 0x80 was not set so
SDC was disabled? and it'd get the integer fraction (153600000) instead
if I understand this correctly

---------
diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index a5ad51425ee3..72facc7bd045 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -73,7 +73,7 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 24024000,
 		.pll_div_regs = { 0xd1, 0x50, 0xf1, 0x99, 0x02, 0x80, 0x40 },
 	}, {
-		.pixclk = 25175000,
+		.pixclk = 25177981,
 		.pll_div_regs = { 0xd1, 0x54, 0xfc, 0xcc, 0x91, 0x80, 0x40 },
 	},  {
 		.pixclk = 26750000,
@@ -82,16 +82,16 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 27027000,
 		.pll_div_regs = { 0xd1, 0x5a, 0xf2, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
-		.pixclk = 29500000,
+		.pixclk = 29487500,
 		.pll_div_regs = { 0xd1, 0x62, 0xf4, 0x95, 0x08, 0x80, 0x40 },
 	}, {
-		.pixclk = 30750000,
+		.pixclk = 30729661,
 		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x82, 0x01, 0x88, 0x45 },
 	}, {
-		.pixclk = 30888000,
+		.pixclk = 30848949,
 		.pll_div_regs = { 0xd1, 0x66, 0xf4, 0x99, 0x18, 0x88, 0x45 },
 	}, {
-		.pixclk = 33750000,
+		.pixclk = 33731250,
 		.pll_div_regs = { 0xd1, 0x70, 0xf4, 0x82, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 35000000,
@@ -106,13 +106,13 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 44500000,
 		.pll_div_regs = { 0xd1, 0x5c, 0x92, 0x98, 0x11, 0x84, 0x41 },
 	}, {
-		.pixclk = 47000000,
+		.pixclk = 47005000,
 		.pll_div_regs = { 0xd1, 0x62, 0x94, 0x95, 0x82, 0x80, 0x40 },
 	}, {
-		.pixclk = 47500000,
+		.pixclk = 47502000,
 		.pll_div_regs = { 0xd1, 0x63, 0x96, 0xa1, 0x82, 0x80, 0x40 },
 	}, {
-		.pixclk = 50349650,
+		.pixclk = 50355924,
 		.pll_div_regs = { 0xd1, 0x54, 0x7c, 0xc3, 0x8f, 0x80, 0x40 },
 	}, {
 		.pixclk = 53250000,
@@ -124,16 +124,16 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 54054000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x72, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
-		.pixclk = 59000000,
+		.pixclk = 58975000,
 		.pll_div_regs = { 0xd1, 0x62, 0x74, 0x95, 0x08, 0x80, 0x40 },
 	}, {
-		.pixclk = 59340659,
+		.pixclk = 59264777,
 		.pll_div_regs = { 0xd1, 0x62, 0x74, 0xdb, 0x52, 0x88, 0x47 },
 	},  {
-		.pixclk = 61500000,
+		.pixclk = 61459322,
 		.pll_div_regs = { 0xd1, 0x66, 0x74, 0x82, 0x01, 0x88, 0x45 },
 	}, {
-		.pixclk = 63500000,
+		.pixclk = 63437500,
 		.pll_div_regs = { 0xd1, 0x69, 0x74, 0x89, 0x08, 0x80, 0x40 },
 	}, {
 		.pixclk = 67500000,
@@ -145,25 +145,25 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 72072000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x52, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
-		.pixclk = 74176000,
+		.pixclk = 74175824,
 		.pll_div_regs = { 0xd1, 0x5d, 0x58, 0xdb, 0xA2, 0x88, 0x41 },
 	}, {
 		.pixclk = 74250000,
 		.pll_div_regs = { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
 	}, {
-		.pixclk = 78500000,
+		.pixclk = 78487500,
 		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
 	},  {
-		.pixclk = 82000000,
+		.pixclk = 81945763,
 		.pll_div_regs = { 0xd1, 0x66, 0x54, 0x82, 0x01, 0x88, 0x45 },
 	}, {
-		.pixclk = 82500000,
+		.pixclk = 82486555,
 		.pll_div_regs = { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
 	}, {
-		.pixclk = 89000000,
+		.pixclk = 89075000,
 		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
 	}, {
-		.pixclk = 90000000,
+		.pixclk = 89950000,
 		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x82, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 94000000,
@@ -178,7 +178,7 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 99000000,
 		.pll_div_regs = { 0xd1, 0x52, 0x32, 0x82, 0x01, 0x88, 0x47 },
 	}, {
-		.pixclk = 100699300,
+		.pixclk = 100711847,
 		.pll_div_regs = { 0xd1, 0x54, 0x3c, 0xc3, 0x8f, 0x80, 0x40 },
 	},  {
 		.pixclk = 102500000,
@@ -196,16 +196,16 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 108108000,
 		.pll_div_regs = { 0xd1, 0x5a, 0x32, 0xfd, 0x0c, 0x80, 0x40 },
 	}, {
-		.pixclk = 118000000,
+		.pixclk = 117950000,
 		.pll_div_regs = { 0xd1, 0x62, 0x34, 0x95, 0x08, 0x80, 0x40 },
 	},  {
-		.pixclk = 123000000,
+		.pixclk = 122918644,
 		.pll_div_regs = { 0xd1, 0x66, 0x34, 0x82, 0x01, 0x88, 0x45 },
 	}, {
-		.pixclk = 127000000,
+		.pixclk = 126875000,
 		.pll_div_regs = { 0xd1, 0x69, 0x34, 0x89, 0x08, 0x80, 0x40 },
 	}, {
-		.pixclk = 135000000,
+		.pixclk = 134925000,
 		.pll_div_regs = { 0xd1, 0x70, 0x34, 0x82, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 135580000,
@@ -214,20 +214,20 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 137520000,
 		.pll_div_regs = { 0xd1, 0x72, 0x38, 0x99, 0x10, 0x85, 0x41 },
 	}, {
-		.pixclk = 138750000,
+		.pixclk = 138658397,
 		.pll_div_regs = { 0xd1, 0x73, 0x35, 0x88, 0x05, 0x90, 0x4d },
 	}, {
-		.pixclk = 140000000,
+		.pixclk = 140040000,
 		.pll_div_regs = { 0xd1, 0x75, 0x36, 0xa7, 0x90, 0x80, 0x40 },
 	},  {
-		.pixclk = 148352000,
+		.pixclk = 148265128,
 		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0xdb, 0x39, 0x90, 0x45 },
 	}, {
-		.pixclk = 148500000,
+		.pixclk = 148396403,
 		.pll_div_regs = { 0xd1, 0x7b, 0x35, 0x84, 0x03, 0x90, 0x45 },
 	}, {
 		.pixclk = 154000000,
-		.pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x00, 0x40 },
+		.pll_div_regs = { 0xd1, 0x40, 0x18, 0x83, 0x01, 0x80, 0x40 },
 	}, {
 		.pixclk = 157000000,
 		.pll_div_regs = { 0xd1, 0x41, 0x11, 0xa7, 0x14, 0x80, 0x40 },
@@ -268,10 +268,10 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 254000000,
 		.pll_div_regs = { 0xd1, 0x69, 0x14, 0x89, 0x08, 0x80, 0x40 },
 	}, {
-		.pixclk = 277500000,
+		.pixclk = 277316794,
 		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
 	},  {
-		.pixclk = 297000000,
+		.pixclk = 296792806,
 		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
 	},
 };
-------------
-- 
Dominique

