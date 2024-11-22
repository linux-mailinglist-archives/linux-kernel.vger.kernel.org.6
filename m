Return-Path: <linux-kernel+bounces-418794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235129D65B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72AD0B2400A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88D71DFE3C;
	Fri, 22 Nov 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eOTy88oW"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E74119DF45
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313830; cv=none; b=XmNQGN/hsG4/G3n04pvvi/T6YiOa0KYHJjowt09uJPuQXrpDZsLynpPGHFxInwph2H/Fl2zWNDwCDdREIGUatUcGocLTv2Dw6te95l5vIje2Zx7/DyUDgk3nypkj8SHKUmQydVlhnBMSfd4MORXHoB3NEZ7zu11mfGbMArpxr8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313830; c=relaxed/simple;
	bh=suvkAfBGBjUXa2245JmSbUdEzRQCqXoVi3fUmt5kocQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY0xHycZHl82MsVEpie5h3IJ1boyfOK5mcILmvGCvRybHVxcS5ARghG/uEV59a8Vpq1aTpkaO879Erypy34goyiNzvL9N7rPEIETT8H/WVmTaYeqhiWvL/wueTzzbOAj9KBTYsJEQ3qWs50Wl+9BwKKvFI4i/si0K9/zNdr67+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=eOTy88oW; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e44654ae3so358183066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313826; x=1732918626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koSu2Qr3uUTmv0FA1/R7W/a8VprfWgcqXI/05k6MgFU=;
        b=eOTy88oWwRKhGbYe/jJydKcu7IAjIigG/XN0jF/BEKmSgdCCufy9oWQmhOhZZrVXLH
         EAjXtBZo0r/7v0EuYI3ZhE4MTxsn6uuv/m8om06XKXD5qY7KnNGtSwSChlxyKy6YCd0y
         84guymLA14ZlPoQO7YNj9CKpXk0RpniapbbbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313826; x=1732918626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koSu2Qr3uUTmv0FA1/R7W/a8VprfWgcqXI/05k6MgFU=;
        b=RdATh/whb6kToqm8yQjghs5e3VWx7Svddu3HcEQ60+KYKNPMdC//qOHthv77qWtMJZ
         gZ8v3LJusCjip3Nuy0BVRNQOPhwxJ4mTkF3dXlDstnsqExoI1v4Eihp03BB095fbduPe
         H4anpID9kKo6gyEZWKfXI7coZSl03pkc7Upvr2zK12CFFB47y2sdRG49uEguJpuz1Ca1
         HAAzlC2C9n0zSrYr6ABo+4XnhhukXaGCknm8Z0XkeSJL4H78x/YTEjhk85n2x1KhL2Rd
         aNF3q49Q+rn0tDb0QEYE3Uf7aSRqsqrLzmysdMcB5hqMauVw1PA1BVBNE5YxFVbWkRL6
         vZ+g==
X-Gm-Message-State: AOJu0YzomkfoWif9M1da0wLaSypklSYGEeVnMQEPg6aSp4R0kOxxBIOB
	PoP7nrpLsamVvGbbvW0Blsuv0FC70/lOhg24sFJInqi2MtMIUGY16BTNpxRFiQb9PC/pp531Q5L
	l
X-Gm-Gg: ASbGncsdbH9IcAgN5t4wPsWxCjADitOqmfqEvioBuioJH9NeiEajmVj4AELOrSbs2S2
	KOWutAe8HH/HticCLI8+3oZAn2derdQHMitfsQHfTaCyNKQQwnPuCUR41mspShv1HVKSIulONIg
	j0G/AWROqDYAimCxSlnNyndldD6+TSERkN2qyutqlZISX96tIPHg28PJqCnqMHMLuLt5wm4Dsug
	yI2TqzN+yzTuLvVoluLUlgdaiHoUwCXmAV6bMO1myxOF+Y4zheRExvnrQM5WDc9nugICrUB6OvT
	+ddFiiwj1l+oqu+hOGI66GfTPn4PjZVuXBoxeT7Aw6r3amy41bk9mDrprwFXUY5wz4oMf8ATjcv
	+xx3tteRMj3myqT7z
X-Google-Smtp-Source: AGHT+IGzFnZJs4h2n/iV/ioahj7WXElDTwCpUUULB2OBEylU5ouM6Ybr9FJMu/M15S4g4KqefHT26Q==
X-Received: by 2002:a17:906:31da:b0:aa5:30c0:384b with SMTP id a640c23a62f3a-aa530c03aecmr47395466b.24.1732313826492;
        Fri, 22 Nov 2024 14:17:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:06 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 10/12] can: sun4i_can: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:51 +0100
Message-ID: <20241122221650.633981-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sun4i_can_err() function only incremented the receive error counter
and never the transmit error counter, even if the STA_ERR_DIR flag
reported that an error had occurred during transmission. Increment the
receive/transmit error counter based on the value of the STA_ERR_DIR
flag.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/sun4i_can.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 840b972498c1..5285bb0b7c69 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -579,7 +579,6 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		/* bus error interrupt */
 		netdev_dbg(dev, "bus error interrupt\n");
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		if (likely(skb)) {
 			ecc = readl(priv->base + SUN4I_REG_STA_ADDR);
@@ -601,9 +600,15 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 					       >> 16;
 				break;
 			}
-			/* error occurred during transmission? */
-			if ((ecc & SUN4I_STA_ERR_DIR) == 0)
+		}
+
+		/* error occurred during transmission? */
+		if ((ecc & SUN4I_STA_ERR_DIR) == 0) {
+			if (likely(skb))
 				cf->data[2] |= CAN_ERR_PROT_TX;
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
 		}
 	}
 	if (isrc & SUN4I_INT_ERR_PASSIVE) {
-- 
2.43.0


