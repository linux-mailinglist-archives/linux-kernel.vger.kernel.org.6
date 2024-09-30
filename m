Return-Path: <linux-kernel+bounces-343927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD39698A18C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7699EB24E85
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06489192598;
	Mon, 30 Sep 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MLPcKC+H"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8523E191F82
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697864; cv=none; b=jVA5TR7EW9BWiIV0xkIiT33+yeJyCLfT9FrcoC5UVicS4xYQ1wNgN3ppLilWunxiym4r3UIRhvjRV2FrSpqNUhVH486gGk49uy+Kw94Rg4LA6bbJAxDcDuqxzAOcKlTcTkngCoigi51FEX0WmoMUZU9XcsPmZ7iSK3EBdNJs8MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697864; c=relaxed/simple;
	bh=GRNRTE3KFYZCTqmHqSQFYdbDtQolStbwq9AxxoNYcUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlLCBJHOTq5crtCdgVjTQtHYOCMrao1LOJ1Gss6KdxdPI7jMAYYodvGPB0/9ciOxzrgWMRltSIasYcNnbkn47wDs7wlyzz9BTtxGBphKnj5KXOTPbVjyWrNezZkjha/rIITfuUlUcPkSpqKbdMPfGqEfOLUow7PTO+EbbfhaEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MLPcKC+H; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb3062d9a6so36150916d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697861; x=1728302661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0DduMWqX0LlLrfJFzeOwfQDx0mBLtEZV9WrRhA8PwA=;
        b=MLPcKC+H5g1f7pl32q5ujlg/ILompcNeudAhYQSXsx9ogt6D5TCSzrmqpVRZ/JtLWy
         T6ES9WI0O6mNOcYfOExqdCk6y1r+z6r2fVK4wh0D04v6gKLAaFrb0eedHU+vifhwM9W/
         WV//oGfeHw+6PG1EGtHyoQA1k5NnvUNKchczY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697861; x=1728302661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0DduMWqX0LlLrfJFzeOwfQDx0mBLtEZV9WrRhA8PwA=;
        b=W8XWpc9fDdhpwY1PVYG1trFgW9ebhBZgvAgYQrvR3y8WWFBIzFzpi2qw3+ATg/oquv
         LBWC84bFkXx16T1q2Qyr3Pk9p+Eoi+JpVXbnQbCeXag9Go0P9ZR7CsXl9iFptf7QbvU1
         8ncfw7/CqDq44oaAK2t/L/loNdTwYxcNIlho0+hGPOMKDDwwS/VNdU7dTDdlV2WjCWho
         nnHPJuu/OMNmXJ3E8dsikT8R1Kqe5MSggO225Y09b0Pb/lCsv7VKn8W6FYvYHOTUAP2v
         CjrTYIh2sc6nCq1iIHRc7RzGBoA2WU8YKo9Toaf4ZMG1OeqKZrX0++k+u5vCnAddrRWt
         GgBg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Zse4mMNzDIQLZoKew+qI0p7UQ5/XYoUsMZXFmEsqpUPbuYS12k7WBsv/dA8R6kyLt/Qs8NuMPSEhL3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz6+T84vFfYVTwK2kvDSbVWa0o73ExQ0VHIs/xcaCp33ZUW8W5
	vZC+B19kvSfRMQ0OLLcQqqOxaj7MU1MHzqwsXEX/aIQLdP9WgpbOO+YXIfxOdg==
X-Google-Smtp-Source: AGHT+IFW5o76WLto1m5OIr01yojLQTVPsUEplusVOtBKeM+zgF4Mr8Jjm4ekkrZvP/8oEpp3jj7xuA==
X-Received: by 2002:a05:6214:3a88:b0:6cb:35ea:a343 with SMTP id 6a1803df08f44-6cb3b5b60c5mr157899696d6.5.1727697861311;
        Mon, 30 Sep 2024 05:04:21 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:20 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:04 +0000
Subject: [PATCH 09/45] media: cx231xx: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-9-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>, Mike Isely <isely@pobox.com>, 
 Olli Salonen <olli.salonen@iki.fi>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Sean Young <sean@mess.org>, 
 Sergey Kozlov <serjk@netup.ru>, Abylay Ospan <aospan@netup.ru>, 
 Jemma Denson <jdenson@gmail.com>, 
 Patrick Boettcher <patrick.boettcher@posteo.de>, 
 Ming Qian <ming.qian@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>, 
 Andy Walls <awalls@md.metrocast.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
 Sylvain Petinot <sylvain.petinot@foss.st.com>, 
 Jacopo Mondi <jacopo+renesas@jmondi.org>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, openbmc@lists.ozlabs.org, 
 linux-aspeed@lists.ozlabs.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The following cocci warnings are fixed:
drivers/media/usb/cx231xx/cx231xx-video.c:144:4-9: opportunity for str_enabled_disabled(flags)
drivers/media/usb/cx231xx/cx231xx-i2c.c:373:4-30: opportunity for str_read_write(( msgs [ i ] . flags & I2C_M_RD ))
drivers/media/usb/cx231xx/cx231xx-i2c.c:402:4-32: opportunity for str_read_write(( msgs [ i + 1 ] . flags & I2C_M_RD ))

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/cx231xx/cx231xx-i2c.c   | 4 ++--
 drivers/media/usb/cx231xx/cx231xx-video.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-i2c.c b/drivers/media/usb/cx231xx/cx231xx-i2c.c
index 6da8e7943d94..6d8b70562f6d 100644
--- a/drivers/media/usb/cx231xx/cx231xx-i2c.c
+++ b/drivers/media/usb/cx231xx/cx231xx-i2c.c
@@ -370,7 +370,7 @@ static int cx231xx_i2c_xfer(struct i2c_adapter *i2c_adap,
 		addr = msgs[i].addr;
 
 		dprintk2(2, "%s %s addr=0x%x len=%d:",
-			 (msgs[i].flags & I2C_M_RD) ? "read" : "write",
+			 str_read_write(msgs[i].flags & I2C_M_RD),
 			 i == num - 1 ? "stop" : "nonstop", addr, msgs[i].len);
 		if (!msgs[i].len) {
 			/* no len: check only for device presence */
@@ -399,7 +399,7 @@ static int cx231xx_i2c_xfer(struct i2c_adapter *i2c_adap,
 			}
 			/* read bytes */
 			dprintk2(2, "plus %s %s addr=0x%x len=%d:",
-				(msgs[i+1].flags & I2C_M_RD) ? "read" : "write",
+				str_read_write(msgs[i + 1].flags & I2C_M_RD),
 				i+1 == num - 1 ? "stop" : "nonstop", addr, msgs[i+1].len);
 			rc = cx231xx_i2c_recv_bytes_with_saddr(i2c_adap,
 							       &msgs[i],
diff --git a/drivers/media/usb/cx231xx/cx231xx-video.c b/drivers/media/usb/cx231xx/cx231xx-video.c
index 435eb0b32cb1..4cdcfe635ad7 100644
--- a/drivers/media/usb/cx231xx/cx231xx-video.c
+++ b/drivers/media/usb/cx231xx/cx231xx-video.c
@@ -141,7 +141,7 @@ static int cx231xx_enable_analog_tuner(struct cx231xx *dev)
 			dev_err(dev->dev,
 				"Couldn't change link %s->%s to %s. Error %d\n",
 				source->name, sink->name,
-				flags ? "enabled" : "disabled",
+				str_enabled_disabled(flags),
 				ret);
 			return ret;
 		} else

-- 
2.46.1.824.gd892dcdcdd-goog


