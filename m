Return-Path: <linux-kernel+bounces-343941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6402998A1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF3C1F25675
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96179199FA5;
	Mon, 30 Sep 2024 12:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LvA2tb1H"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D53919994A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697892; cv=none; b=Ax3Ff+yfUoPXDaLp0tOGq/R/xgnTjRUAD72HlnsskroQGii5QX7WMdNLTJQf8KQ7HYo3JMYUpjtpwcAYmlih93ZecqFPRxg/MF1SKic6M8h6yid5U1v8bu8/8UDDlAz1Zxs9vnihXOkH4KyN0nWuezQzVePBUn4uokbVSgFu4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697892; c=relaxed/simple;
	bh=iATwc6ufGXARE+6lG0pR6BzacdyrfLO5QVcrh6ufzXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtOUsx7HNsJapoumCDPz2x3dOmvkAVZNmC/Al0heN4wkvZkneDjTGEwXMU5N/5s5OsJmDh7pbTwe3DiX4i4Vx04SCxw+KvA3+HsrKjAd8jlErVyTwraqO3puvTZ+jrydfwz2HDV2C5/TfgMvqVrWW7ZzJs5/xviP//r6TB5Ehhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LvA2tb1H; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4582c4aa2c2so31353701cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697889; x=1728302689; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aurzIxhre/dA6wUpFHCHveAY7utZWkXC/gGbqMcXk0s=;
        b=LvA2tb1HIe4EJXs0G79Rn74NkQNdJWdJP+56rVBiqYVPpSSSKk+BaMlZMRCczp2yU4
         3yv7WSaE3UVkUxxMpxyeAKyszu8XsTZ9xN1BZZ1w4C04cSlMTNtVEG8MS57Dj90YuA5P
         uFzxyH8ewKsSpPhPvwpzbcoA3v3m/hhwNpc7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697889; x=1728302689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aurzIxhre/dA6wUpFHCHveAY7utZWkXC/gGbqMcXk0s=;
        b=GXcbdYyay5S4azf7rBmHjzeqdXTesRwqXQg6Xnyq3fA6+4b/H+QoAmAaxqJVHrwd56
         J6BCIVeizRbCVc0/ErgFEUpXVqtYXkxmJBig8M3P7ifP3KT0fk+FvSWtm88132wS4BUU
         zvmIk+UTlM+9J4lXgp+TlMJNU7m0WHyqjf1DRRfRrXs3ftIYIyYf8wDdoS7KMTtw3eCx
         vLWc5PQ7DrgKMWxf/NwQtrJPTMVT8b3HzOuV6LnRjnf8R9KPOWrg3BnRJKZiGEb+mXbi
         OEV7Mb9nvNuY6GcyITM2/sKMqqPV2ab00ZefP0uGstqAutjGjVeshecL4e5PPe6z8x0a
         1cmw==
X-Forwarded-Encrypted: i=1; AJvYcCV3kPKyJZgwwV/+WUuhjgoxodyjmazPBDSsCT2F9KqQMGujK6idpReUqOggma9Nf3woDm6dzJ4SxDyoGNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqyQI3NFz3gQhEBluPYNqt9YcGSLKS0/RBxQEYjEPNBYqnwA6
	ReMWfJZn3FWxsEPz3h/C746qLdxr3El2IQwSygxet7LuAgYzEEhxrWOOSsz4iA==
X-Google-Smtp-Source: AGHT+IGIOHdh67nNwgDel6paDE35Eb29KwEMX4XzmiYgJj7qtD9+Z/d/ZNDrc9s0mVLpMYI/GTz7DA==
X-Received: by 2002:a05:6214:53c4:b0:6cb:27e6:393f with SMTP id 6a1803df08f44-6cb3b63d1cfmr165544066d6.36.1727697889388;
        Mon, 30 Sep 2024 05:04:49 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:48 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:17 +0000
Subject: [PATCH 22/45] media: aspeed: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-22-81e137456ce0@chromium.org>
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
drivers/media/platform/aspeed/aspeed-video.c:1944:6-16: opportunity for str_on_off(v -> hq_mode)
drivers/media/platform/aspeed/aspeed-video.c:1230:3-17: opportunity for str_on_off(video -> hq_mode)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/aspeed/aspeed-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index fc6050e3be0d..9c4a47d7a442 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1227,7 +1227,7 @@ static void aspeed_video_update_regs(struct aspeed_video *video)
 	v4l2_dbg(1, debug, &video->v4l2_dev, "compression quality(%d)\n",
 		 video->jpeg_quality);
 	v4l2_dbg(1, debug, &video->v4l2_dev, "hq_mode(%s) hq_quality(%d)\n",
-		 video->hq_mode ? "on" : "off", video->jpeg_hq_quality);
+		 str_on_off(video->hq_mode), video->jpeg_hq_quality);
 
 	if (video->format == VIDEO_FMT_ASPEED)
 		aspeed_video_update(video, VE_BCD_CTRL, 0, VE_BCD_CTRL_EN_BCD);
@@ -1941,7 +1941,7 @@ static int aspeed_video_debugfs_show(struct seq_file *s, void *data)
 	seq_printf(s, "  %-20s:\t%d\n", "Quality", v->jpeg_quality);
 	if (v->format == VIDEO_FMT_ASPEED) {
 		seq_printf(s, "  %-20s:\t%s\n", "HQ Mode",
-			   v->hq_mode ? "on" : "off");
+			   str_on_off(v->hq_mode));
 		seq_printf(s, "  %-20s:\t%d\n", "HQ Quality",
 			   v->hq_mode ? v->jpeg_hq_quality : 0);
 	}

-- 
2.46.1.824.gd892dcdcdd-goog


