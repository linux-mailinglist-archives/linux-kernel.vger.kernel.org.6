Return-Path: <linux-kernel+bounces-343958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7EE98A1C6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158EB1C2106E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681881A01A6;
	Mon, 30 Sep 2024 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZCD5B08q"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473D19FA6B
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697920; cv=none; b=GsSLYU8TexPaZVd+K7KhU2/WCIKHxZxZ3tIpiEgcc88HlmlwCGRavSX35/XWH8NXJ6xr7NqkGw6UTnriee8r5uimsod8K7WBnaSR7kck6w/tOd+tWRChXACDtBS+3mQItdz8mGzRbbW2GTY/TMKQCBDmpBKP3Xs9IN8MHJgsSIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697920; c=relaxed/simple;
	bh=aBtuDT9YPo78PM4HWkajYyL24yWOJ9YEO0Dm4FdZ3Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsOUiWwoJMHHN7UBgNR90uFBw1cGqA1XPtjeTmVHn1ye3LQxEhWOdvYdGrVQkrRPdKJ2fgxX/Zx6Hs00fa4t/Z09XexznLt5dhn2/865Q+IvmObugemvU586ZSjdYcG4N0/7wAxZIko7MqcXe0WeAvzxbkCYRdPBTPco2DQw708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZCD5B08q; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb2c5128d5so31327076d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697918; x=1728302718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJx29BD9yZboyGEAUyw+4rBBbXZtXq331Q8okj0vBtk=;
        b=ZCD5B08qgC087lPHrULv0sb4AT/R4EQtvNOnHcoYz2UdSrpU6sdz/c++EQb6VSh0ge
         5wRsZgjaKFSO5knR3DStPQjQBf2j3JCnUxBcFllImVCnX+Zyxn6Ym7wZDYEEq0406OYI
         bYQvfawfrF8075UiuSnyFIkObLzHpJD4lq0zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697918; x=1728302718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJx29BD9yZboyGEAUyw+4rBBbXZtXq331Q8okj0vBtk=;
        b=Kl3KOTnQaE7hhIVMd5Cy8E4049UZ+J4Zp+B7RCOtnVLM8pKE7kAEUBv4diiJf15leh
         Bp4aJQJ6fmd7HhV23jl0fgr85uAusqgXZcTNA4VaNvSIwtKGRa6NzhganSulqJ1XkqI8
         zttjJZpcCYjYcQ1drvwRvlq+6gdKfDRvoKA27xuMEgxD/07A/XvpNseNPnU0e5QWMd5u
         pdnpNjMqPqBAu5NvIhsdz15GhZAMYfUC8ZnbjYThOo164ZsSyTBbawqcrOqtwgIqzy9z
         Ur+/7GYhjfocxsKx6bce/AzZlexXJm3SrsCsbe1AlWl2VuIE+LhPZ7Ad8VqqcZ/wotWo
         5kcA==
X-Forwarded-Encrypted: i=1; AJvYcCV++7v7TI6QghBZJxc+bk6KlD3Cu35BfDKfySCX+Kyy+wxO+068WalKZifCFxT0xSFK+fsXI4ax6Ca9Y1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0360G+uL1NB+azGtZEIjAht6ZQULnYSgyoro7yoncUkjeAHYD
	3azJQOk4bRP9gG2QXGZZzmqmNi8by2Xcupm0SFtgwZfEGYr/rCtCQVojK34z+Q==
X-Google-Smtp-Source: AGHT+IHvBkaWPQbVKiD/u2iOrMRkK3daurGtkkhjknrAX1KIWB3cA5A9a8FHevVPAdBTGyigNIjY6g==
X-Received: by 2002:a05:6214:3a88:b0:6cb:2e94:3e24 with SMTP id 6a1803df08f44-6cb3b5b7edcmr189314226d6.11.1727697918247;
        Mon, 30 Sep 2024 05:05:18 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:05:17 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:33 +0000
Subject: [PATCH 38/45] media: i2c: max9286: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-38-81e137456ce0@chromium.org>
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
drivers/media/i2c/max9286.c:1333:3-9: opportunity for str_on_off(enable)
drivers/media/i2c/saa7115.c:1366:3-9: opportunity for str_enable_disable(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/max9286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
index 9fc4e130a273..d0f542343344 100644
--- a/drivers/media/i2c/max9286.c
+++ b/drivers/media/i2c/max9286.c
@@ -1330,7 +1330,7 @@ static int max9286_poc_enable(struct max9286_priv *priv, bool enable)
 
 	if (ret < 0)
 		dev_err(&priv->client->dev, "Unable to turn power %s\n",
-			enable ? "on" : "off");
+			str_on_off(enable));
 
 	return ret;
 }

-- 
2.46.1.824.gd892dcdcdd-goog


