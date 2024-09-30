Return-Path: <linux-kernel+bounces-343944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8F98A1B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E115B24D83
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884218EFCD;
	Mon, 30 Sep 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H794p1LB"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4319AA56
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697897; cv=none; b=awYYnkF1bcxO1iZsZUQoSgYOS6RunyfY9mvV1vLbNQnNHVEMMkV8rgZewlH5cQQ/ZslP0l9hVgh7OkPr9S0UWgdEUy8C1UkDgq2+LLOnUS99DH4onaTiSDnWHUqKzXvfYN4rluI0mbh0LXM7fAUqjsYpBqrtSiTJW4xyvLr5PEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697897; c=relaxed/simple;
	bh=1g0+rmMwCDuGWvS2q/K/LC+NTqBE6pcQhTrh1e6y+HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjylaoZitDBST7426kogHvvSHeruhL4+j9ggDMVu/RioUy4YUjfu5P8EZed6560hIoU2R+jNobJkGme0V2YSyKeuWgPQkNat3zV2DqmBgiTATXi70DpmScprKgNEzB6yDk7Z5m+x9syNYohPpkhCMFB1OYwyGXU6sI++DTVdLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H794p1LB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cb2e5d0104so32209596d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697895; x=1728302695; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IxOY0fJQbV1pYrixFE+l++vJW3v3+bYS5tnnmoYTEc=;
        b=H794p1LBruCwMGck57XbYiQV+9iuzBqVvSeioAUjU49B3jB0x60oPTVgKtbZoUo7ZA
         cTy6EyhLxpje/aI/C/Nf0I9CwM4gY1sMyVUdLmGSD4C/7L8k+CNduPaBD2UwTAFPAncW
         ixX05Z2Claa2qHaUiZJCvrTaZBBHsncyHPpus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697895; x=1728302695;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IxOY0fJQbV1pYrixFE+l++vJW3v3+bYS5tnnmoYTEc=;
        b=EQ91P7/5GAQ3b5BQ83lW977bLAroH5OU2hf3LvkxcnGv/sMROtqbaCvflpPCODlVQA
         1Ofn7qHZSSw/Rlaxq/dXfe6UIWubIml7c4YtZ8qexydFFnCMFx8g2wJusAJxoZrUN2gQ
         SnAeG5QBdk90JPCfxfuWIbdTHTcvMVxAk0xkjf9PJaLpuPwJ92dCD/I2cpIo+w+rEXVu
         3KeBj9OX7u0gsX0hP5BTdjNRMChnQ02wIEqRuZGeFr38FiVjyU36JeqI4c09T3RzDBx+
         vouvukuZeiHR+gBf5bb95Eks4/SyNG+6ifsmfhM5QIPOZClXTyHyEVjR/l205e2oQ3ih
         E6SA==
X-Forwarded-Encrypted: i=1; AJvYcCUdRsgn0roe274SHA6CX2haemCLXYNHcY4i+Gfo2hc/rSJCIQuUn/cBWxFVQzFGayuMK/eJnzdRWK+gQKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2forSMvHzF5+Tmn01OkZjxw8rk+ljApulC7PdSLpgpLa25b5K
	TushQS9oyyRC8UXv69s+nbgX4DEucEGd1v91tdelUVuXEc3vPhj99HP7RLMbFw==
X-Google-Smtp-Source: AGHT+IH66496SEOv3j8ygYtL4JJVB2nn5gkUmde7+6fS5LT2xRJFvFwOVG+MRgiMM8u5XXNXcxJVyg==
X-Received: by 2002:a05:6214:5b07:b0:6cb:5dd3:a3ce with SMTP id 6a1803df08f44-6cb5dd3a78emr68541006d6.14.1727697895340;
        Mon, 30 Sep 2024 05:04:55 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:54 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:20 +0000
Subject: [PATCH 25/45] media: cobalt: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-25-81e137456ce0@chromium.org>
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
drivers/media/pci/cobalt/cobalt-driver.c:263:25-33: opportunity for str_enable_disable(ctrl & 1)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/cobalt/cobalt-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index 6e1a0614e6d0..cff2d29410d4 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -260,7 +260,7 @@ static void msi_config_show(struct cobalt *cobalt, struct pci_dev *pci_dev)
 	u32 adrs_l, adrs_h;
 
 	pci_read_config_word(pci_dev, 0x52, &ctrl);
-	cobalt_info("MSI %s\n", ctrl & 1 ? "enable" : "disable");
+	cobalt_info("MSI %s\n", str_enable_disable(ctrl & 1));
 	cobalt_info("MSI multiple message: Capable %u. Enable %u\n",
 		    (1 << ((ctrl >> 1) & 7)), (1 << ((ctrl >> 4) & 7)));
 	if (ctrl & 0x80)

-- 
2.46.1.824.gd892dcdcdd-goog


