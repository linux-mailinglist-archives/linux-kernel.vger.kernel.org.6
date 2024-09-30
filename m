Return-Path: <linux-kernel+bounces-343938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F1598A19E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616331C21586
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE0199246;
	Mon, 30 Sep 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KhC5w88C"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285B1990BB
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697887; cv=none; b=GoQ6CdWNrOMLB7h8bsbs3z0te7Ak41OHxTZRDNHylQHMHb/4CehY/9H1QAfG5SyBciD0iNt+ywpIkWPcJ5WTnU8lAbzZts1JlBsfDK+XcMqXgdoxi7yvA+UR6HfK641nIj+5lQI+rzIS2+h5o9DZXFhuS00mItT5rJZfMGl9EwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697887; c=relaxed/simple;
	bh=wO32bcNT3LvCUpFUE8spFFSYHTYoba2s3UV9j7voxsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owgm6d5jyH034dFmDvd5wRCEMFrGc6GnkeE9EBXMysLcxZy+Bt5SEwsrDIhhsM9N7jyiV+QmHhQzhN0jc53WIjSHicREHtc4P9DjM6tAmvJ/f3vBY/0u9WN0YyNk0dWq6bkZi/fzVI9Y/HGMHGGKNgndOOW+C0zn2EXpVUacUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KhC5w88C; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a9b3cd75e5so426661385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697884; x=1728302684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+1PZUGpVB6A0qj8dhi+z1VPBRWAZJyLXCCfSc2+bXs=;
        b=KhC5w88CtXPFsIB2n84YMCvLm2h6osRr7DtJCJZzhKSESJlUqH2KqhNLuArd9GE9lh
         +gLEpomrL24vZOel/ff8uGR/TbwemMkLFVzj3jT58wz+VkIjbHUZ+4Qyj1m43dTgoKwp
         jlrPeLjMTA3HuemNVJQ5iLixteQoDLc8G7zw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697884; x=1728302684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+1PZUGpVB6A0qj8dhi+z1VPBRWAZJyLXCCfSc2+bXs=;
        b=ZfBX9hHu0kLiP8C9PubmKC8UFVVWxadDugEzSTofDWIgGoNlpcy+v8J8IMHwo1N2Ep
         4E+d7BrnJ0++d6kiSGL5Lo4ZoXiFlp5M/k6QcKlkXrk03W3fv0TnLM0TjeoXtXEQV21o
         JDcSFu7vaPMigIzoWlxDSuNwex1KFRJH7TxLHmCO4dQjlbAhxG9aw/X8RgLGCGuAlypz
         R82sNLn/gnpuzMerssUtET7t7u5C4/GlyW+Td/7AiG+9REpRMEl9ec+OizTBmomrKG1i
         jNem96BrOv3AFRewu/FuvIX33ujLfEL0n6Mr72aIUoyVCpANzpkgA0cA649rGGHIeztt
         dYNw==
X-Forwarded-Encrypted: i=1; AJvYcCVWeTIyTU+Y5qowNFrz5UzQ55VC2kiEIdxO7yi50t9HEKKxCsF3HQU5CPLxbd6Qi/biG81TwhEnKS3/LZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9MUVehX+WLba9A2qalEDlOQbmp7+taotGlf+ylxFYlafNeQEN
	PC+j4BL9G3c0QbL5mIfI1iMX/wKxa3nHBTM1lf1dZ3QppX3ftTJ2eoaZCh8c2Q==
X-Google-Smtp-Source: AGHT+IGmAxnIT189WVUBwg+x/R9UvWvqRDVNzUhwwxur3BAKszcZq3coNxLRGmF9WP2isGNKo1o/8A==
X-Received: by 2002:a05:6214:5706:b0:6bf:7bcd:78e3 with SMTP id 6a1803df08f44-6cb3b643feamr164774016d6.29.1727697883855;
        Mon, 30 Sep 2024 05:04:43 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:42 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:14 +0000
Subject: [PATCH 19/45] media: platform: ti: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-19-81e137456ce0@chromium.org>
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

The following cocci warning is fixed:
drivers/media/platform/ti/omap3isp/ispstat.c:771:21-27: opportunity for str_enable_disable(enable)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/ti/omap3isp/ispstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/omap3isp/ispstat.c b/drivers/media/platform/ti/omap3isp/ispstat.c
index 359a846205b0..603439afe582 100644
--- a/drivers/media/platform/ti/omap3isp/ispstat.c
+++ b/drivers/media/platform/ti/omap3isp/ispstat.c
@@ -768,7 +768,7 @@ int omap3isp_stat_enable(struct ispstat *stat, u8 enable)
 	unsigned long irqflags;
 
 	dev_dbg(stat->isp->dev, "%s: user wants to %s module.\n",
-		stat->subdev.name, enable ? "enable" : "disable");
+		stat->subdev.name, str_enable_disable(enable));
 
 	/* Prevent enabling while configuring */
 	mutex_lock(&stat->ioctl_lock);

-- 
2.46.1.824.gd892dcdcdd-goog


