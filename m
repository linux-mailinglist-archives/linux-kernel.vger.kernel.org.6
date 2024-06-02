Return-Path: <linux-kernel+bounces-198416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECBA8D77F8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B295283005
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565F084D26;
	Sun,  2 Jun 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="u9+AM0pV"
Received: from mail-108-mta213.mxroute.com (mail-108-mta213.mxroute.com [136.175.108.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13F84D10
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717359620; cv=none; b=K7HMFs5av0cFftD890Fe79tVhuMF0fwdiAKmDvWeGvlomFgaYYn/tUzfoswxf8V8vasEPKJJiV5iUuh1NfyI0D7dEpqdKd0qq+5rBODti746yRE2xTJ1h1OjFRdIYBwn51KEbIotOzh76tbKgEH6pm5Lj/FJHZN1idlc3dFUJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717359620; c=relaxed/simple;
	bh=oCSJBQE3aiwqbmfu1EJ9a36gJDCKL6HMUjBrjCIJ3ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm9Q4Byaotp/nKlkqbzVHpPMVueUH/lxqemhhFdPcuU8GwLNe/Mq4bFBaPELviAwKOOZh3g6YOK28a320FDSC7BJxuOY+DzWZSxASTgQQTyeHKiE3Ew0dm888b38ysIuHsVGMsq568iSrnmd0OE84uOHtNjCZzNmLONz37zy7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=u9+AM0pV; arc=none smtp.client-ip=136.175.108.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta213.mxroute.com (ZoneMTA) with ESMTPSA id 18fda96b4c5000e2b6.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 02 Jun 2024 20:14:20 +0000
X-Zone-Loop: 9261a51d01533583f471be85b79fe6cc63fe34fd7418
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eDZZF6N9fGs2w7erh1JS+Jobb378vgl6f0WBmuxrApM=; b=u9+AM0pV8Vw0lYwReSKrbxB2CZ
	nc3NaKqeTdDG1y+sTVM5JeTLbQDCLlfXkLbqYB2xkA6kXXHLlAyBu3fl7yXes3/zZrYv5naks+5km
	7De9Spc79ZuUsEgARDu0aav+b1irUO/bT6XnxDPmyOmtwSeLdhCducQlGpvFaYDgMAUIZ7VV70bJm
	BVVyvC1uLJQjuG0lcY5iVvIQI5k9vhboAircnVeG3LruWP+6KLf+f9ea2wmI0rFY9B3RMeu1nOlX7
	MHWN6IgxXRgpJRNuOWCbItjhyXJSp9gLAHLFpQNCxHOkfDCUwh7DubaLInTO9VYegh9Mqfa03zMVK
	QH6goPzA==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v6 13/23] media: i2c: imx258: Correct max FRM_LENGTH_LINES value
Date: Sun,  2 Jun 2024 14:13:35 -0600
Message-ID: <20240602201345.328737-14-git@luigi311.com>
In-Reply-To: <20240602201345.328737-1-git@luigi311.com>
References: <20240602201345.328737-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The data sheet states that the maximum value for registers
0x0340/0x0341 FRM_LENGTH_LINES is 65525(decimal), not the
0xFFFF defined in this driver. Correct this limit.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/imx258.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 2429eb7b55c6..c1a2c2406aaa 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -28,7 +28,7 @@
 #define IMX258_VTS_30FPS		0x0c50
 #define IMX258_VTS_30FPS_2K		0x0638
 #define IMX258_VTS_30FPS_VGA		0x034c
-#define IMX258_VTS_MAX			0xffff
+#define IMX258_VTS_MAX			65525
 
 #define IMX258_REG_VTS			0x0340
 
-- 
2.44.0


