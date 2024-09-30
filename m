Return-Path: <linux-kernel+bounces-343919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA2B98A166
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F409E1C21160
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C318A6CA;
	Mon, 30 Sep 2024 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m6dDP3WG"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F818E357
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697847; cv=none; b=JUTmnGLMSA9oCnMpwage9ku2g76y5WTuoBMEY6u+qtMfbumZKucWUb2yD40M7x6J/bn5tXo+72tzR3C1a/oOXW89RaAjPnfqOil5KP7NfI0BscIk4qZO1TBQ3U7FKWhVkk25l566iv88I1sUGmFqRdg32wyRWGcGPFN9KVdxVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697847; c=relaxed/simple;
	bh=5CcZFwY67VUyfBGEeXQ3+4Q+ziORs1PEInvOEq+lE04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToILWke2tnU85LM0fxiBS6Z79E9XVceW1sQMS5faRhWTUq+PDtUo7+RBOZ1OWroQ/BSMOeA9ReIgmm6E9gS2xE9emLgcAEo7rJh7E7xIqWXaLOEvW1A2Gn0fl76zbtPecm8O6Wz9RjSlrU7Vr3cqrVLtFiTDIPshuJXM3529JSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m6dDP3WG; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-710f0415ac8so2401676a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697844; x=1728302644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/d/VxAIFFwk8ny3jYVhNIfPO7NwT5z32rk28KK4f8Y=;
        b=m6dDP3WGM4vZ+qk0Yz9e8TMJuuGi7OrqHQU/xWE6YZdY+8DuBntQU7HXBw1g/Jyhyi
         465bUUXm3+1XMzbbxNpaVBh4PM2WGcj0WoG8l2qAqUpQ1OMv4CI2qj4+tQWDXoYPf4GB
         LFQ7qkqMfU33Mtjklqyji8q9b6vCnlSBcDQDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697844; x=1728302644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/d/VxAIFFwk8ny3jYVhNIfPO7NwT5z32rk28KK4f8Y=;
        b=rbKLey0+/WLjcRlkxP4iq7JmCxm/M7CY+/5vRynKKI3DSQXz7gF+MiAmkLU96NgeCs
         Gjs9cSJ1sZ/n9XU5KdfIa9TTAgCVOIWwamQg8ngP+f1DJr0KI/Qysw249tag1tZ/RcsW
         Kf2jzw1wpKutpaB3EmqaNon9uDdHTxgmZJMm6UYKwyF3FVhkDAltHPcK82ljer3Mo353
         USLc59GUbC4D0jGxXDexfW0MsZrqH/ueqyyEf0qxWwyhHUaiJoa0okQPaDuOOEbruZ5t
         33fBoOWIHv/Z3vDBkTVAl1pRX2JPmjkwC2wILNz/+V4zq4ieIFoJjAjpXaa26HTpi8kc
         5nrg==
X-Forwarded-Encrypted: i=1; AJvYcCWVdW7nRQ1hrCOWt2lw5COXt06Rpa3rv836Fply238Z2giIv4AYvDPeEVAGdkBvfQV4opF9u2/2RUGRixU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynn4bXmI9DuopVPUhHOrBOqH3P/Y9EpC3ZJph0KTDveFWVYJzJ
	QeRlBqtgP2qnbh7YjG0TP0hDQ6WcGXdWL37jniN5YGNAO1TbVNgc+fzh/jErDA==
X-Google-Smtp-Source: AGHT+IG/KAG5rLZearz2Wa+2ErVyBcttWaRGk175qbpKywxFfy3PRamVmOosYeNbd61Fqm2746wGGw==
X-Received: by 2002:a05:6358:4314:b0:1b1:ac2e:af69 with SMTP id e5c5f4694b2df-1becbd0a143mr332064355d.17.1727697843926;
        Mon, 30 Sep 2024 05:04:03 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:02 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:03:56 +0000
Subject: [PATCH 01/45] media: staging: ipu3: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-1-81e137456ce0@chromium.org>
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
drivers/staging/media/ipu3/ipu3-v4l2.c:290:3-31: opportunity for str_enabled_disabled(flags & MEDIA_LNK_FL_ENABLED)
drivers/staging/media/ipu3/ipu3-v4l2.c:305:3-31: opportunity for str_enabled_disabled(flags & MEDIA_LNK_FL_ENABLED)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index e7aee7e3db5b..443067ad0a50 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -287,7 +287,7 @@ static int imgu_link_setup(struct media_entity *entity,
 	WARN_ON(pad >= IMGU_NODE_NUM);
 
 	dev_dbg(&imgu->pci_dev->dev, "pipe %u pad %u is %s", pipe, pad,
-		 flags & MEDIA_LNK_FL_ENABLED ? "enabled" : "disabled");
+		 str_enabled_disabled(flags & MEDIA_LNK_FL_ENABLED));
 
 	imgu_pipe = &imgu->imgu_pipe[pipe];
 	imgu_pipe->nodes[pad].enabled = flags & MEDIA_LNK_FL_ENABLED;
@@ -302,7 +302,7 @@ static int imgu_link_setup(struct media_entity *entity,
 		__clear_bit(pipe, imgu->css.enabled_pipes);
 
 	dev_dbg(&imgu->pci_dev->dev, "pipe %u is %s", pipe,
-		 flags & MEDIA_LNK_FL_ENABLED ? "enabled" : "disabled");
+		 str_enabled_disabled(flags & MEDIA_LNK_FL_ENABLED));
 
 	return 0;
 }

-- 
2.46.1.824.gd892dcdcdd-goog


