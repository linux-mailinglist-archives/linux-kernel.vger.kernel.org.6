Return-Path: <linux-kernel+bounces-343935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA298A192
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742841C21584
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E507194080;
	Mon, 30 Sep 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jn0XULH2"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767A198833
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697880; cv=none; b=pI53tKjz8g8uxxltLq3bKCikYQJP7FA7/ELb21t/o9g+FnCq3GWaYzmyvxAp0i+Rw/rYLbdbH7V/prO2wbwv81aPXGs8WT1QB97oitOakE5hQZe46p3AxLxWQ1b1Vm8QeqCEoshy+VRf21SXjxKyjUMNrRhFoU8P4EdLtDYXza0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697880; c=relaxed/simple;
	bh=dK6Sydo8sH5iuoPGo1uJmSzzE0aPjCjllccB1/DFlKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqGhvIQA9mUy1hAf3pnHbL/DCLCTAsbPNYUps/gFQmZPp4Xrub2MyZ8dJH9KLorayGiF+67MdTtD8NsFzZ79AMyBT5pm7m5oB1v0JB4pqlh7AjwjKP2uijZ/K8axO0B+MUn8R+TtewUF446AMqp5V0qxy+mMcL0K7IhywtWB5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jn0XULH2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb27e974ceso26202286d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697878; x=1728302678; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W54Rxedr36zEnsk929u7YgHxA5FxY+YC4oIk0CEmtoU=;
        b=Jn0XULH2WqTJNxeZzs8TnLvKGMwgXU/v0hEz/qJKIravbAVjrH3U4QB8Q0vXGJAG8h
         OuybWmJyDHnOS+z4tOjIklFhp7b6vtCEXP906duxVQUT9DJWP9iw44Q31/Tq/ZuZl3hD
         c7ch8LH7ITxKjnxdhbYYuBs3WuNtvCDtMTzEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697878; x=1728302678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W54Rxedr36zEnsk929u7YgHxA5FxY+YC4oIk0CEmtoU=;
        b=ciDFseeKrSN3E+5eE5b+dGOBKWSkqB3mx6tVzMZPeLiBQOuHIhRIymKrBqN9EGpTV1
         GYQL1Mqnepu/wh8TTBgugQpsSwPEpf3LvDM+n1HFXvc8yafKQNJEm0fiSr0ZeGNyhpYJ
         tUs7dHB7+85oeeyEwxieqVhRiGDpN53geyQQzM7SlCX5XRTnRiNR0Wt29aacstSwylGd
         r80DJA8hI4xwuwfE01Hwzrm5kiD900aBOaoFhmhrkKqWJ94lt9Ba1Z1Z3TxxL8lVEMi0
         jRF4Acu61HWkrBNtxD7GWPDQis+u2QncfMkV1rItJRJ1iDgOA0OtEhUhifTpjb3wyHOW
         bhgw==
X-Forwarded-Encrypted: i=1; AJvYcCWzjg1N13darIMQhN7WJq4Yrc8KabS/HkdEBwMRjxq0FGE7u/9WdetJIiJAGhfX8+ms/CawC6JC6ILEoxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxugx2AoWR4H5fC4/29TTnnGcFUl3f+trZY57E1asi2B8WpskGm
	cktn7gxUEO2DgYdYK4Bcx6KpZbp9FL3nqItxILIMOBDSPFTbuSQ1qPD9KPbumRSQ66iP8WnhbQs
	=
X-Google-Smtp-Source: AGHT+IGgo8OgcYFtsubdwQ48E/Z3+k42qUYOU3xS8KlzOd05WOz0ImPebYZJQvx35b0omDgntAq/gQ==
X-Received: by 2002:ad4:580c:0:b0:6cb:3b6d:2775 with SMTP id 6a1803df08f44-6cb3b6d2d88mr154770176d6.17.1727697878145;
        Mon, 30 Sep 2024 05:04:38 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b694369sm38822536d6.144.2024.09.30.05.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:04:36 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:11 +0000
Subject: [PATCH 16/45] media: pci: ivtv: Use string_choices helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-cocci-opportunity-v1-16-81e137456ce0@chromium.org>
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
drivers/media/pci/ivtv/ivtvfb.c:809:3-57: opportunity for str_on_off(( var -> vmode & FB_VMODE_MASK ) == FB_VMODE_NONINTERLACED)
drivers/media/pci/ivtv/ivtvfb.c:609:3-57: opportunity for str_on_off(( var -> vmode & FB_VMODE_MASK ) == FB_VMODE_NONINTERLACED)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/ivtv/ivtvfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ivtv/ivtvfb.c b/drivers/media/pci/ivtv/ivtvfb.c
index 90c584cf97c2..bd07afc68191 100644
--- a/drivers/media/pci/ivtv/ivtvfb.c
+++ b/drivers/media/pci/ivtv/ivtvfb.c
@@ -606,7 +606,7 @@ static int ivtvfb_set_var(struct ivtv *itv, struct fb_var_screeninfo *var)
 		      var->left_margin, var->upper_margin);
 
 	IVTVFB_DEBUG_INFO("Display filter: %s\n",
-			(var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED ? "on" : "off");
+			str_on_off((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED));
 	IVTVFB_DEBUG_INFO("Color space: %s\n", var->nonstd ? "YUV" : "RGB");
 
 	return 0;
@@ -806,7 +806,7 @@ static int _ivtvfb_check_var(struct fb_var_screeninfo *var, struct ivtv *itv)
 		      var->left_margin, var->upper_margin);
 
 	IVTVFB_DEBUG_INFO("Display filter: %s\n",
-			(var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED ? "on" : "off");
+			str_on_off((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED));
 	IVTVFB_DEBUG_INFO("Color space: %s\n", var->nonstd ? "YUV" : "RGB");
 	return 0;
 }

-- 
2.46.1.824.gd892dcdcdd-goog


