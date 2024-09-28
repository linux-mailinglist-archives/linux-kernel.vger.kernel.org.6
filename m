Return-Path: <linux-kernel+bounces-342602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A74C9890C7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64CB1F2143D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0301B15FCE5;
	Sat, 28 Sep 2024 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZhVBXedp"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF291586D3
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544258; cv=none; b=QOxviBKbAS0vz8CEu7+2at/guqqfQh6Fl+gZTR6Fx2AHXNEewHRanlfegQD/pveyH6AkudLB74Q6msy81BPCKt+dht53r8d7oyUr+dqpjqMSpkLueULWPtzI1YspSmZeYGSdqneixZkKtzihGl3D3sg+ntEJSBx1t5S2p4wy9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544258; c=relaxed/simple;
	bh=PTbEhgOwL2JzDldEWOrtkAWFRntEHE0H3eDBOM54qRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBa96uTts7SwT+e1GqjCEO0xXWzyizVeZA4ysWkhEGi3Kl2b22IENGnlvyQH5ibsvrubbwzSQodKP7tzIbAiTmBr8GVp3uHTyFMWaGT9La3EpOT+mZI2ruIOMPzbibUAD15xSVtNkIsYlGpirH08E/J0JsMSSEdSQFYKRcztM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZhVBXedp; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cb2f344dbbso24989006d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727544256; x=1728149056; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1m9W940jAO+8Km9/nF0drShVWDtg5UbNpWglt9zOgsU=;
        b=ZhVBXedpwAxdF4s52lCph6mb3CsesFAmqTEfsouIY9Y9OdH1F1MAVffAkR0WC9YG8s
         rM1krwipIREjnwRbJfsiFvN3ep8XW6lqKMaSfLlBt3kqkHP476TtUAV2WBEGFJtc+qnR
         99BQManyCtOkeZsY59jfiy8no6TTF1nvTeU4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727544256; x=1728149056;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m9W940jAO+8Km9/nF0drShVWDtg5UbNpWglt9zOgsU=;
        b=TTF56v4uMlI/0/+HFInNcG/GsPE+xN7yMYpYt1NUOEDOYKm++Lb85d+0rFzhuYwdXl
         xo7abNRBOqdDoy7IhLRfJbyuIb0rItWwlaQMONeiU5PL+Vr02Vtf8OhK++Zh0Lh29Z6t
         PehvJ3Q9xxU8szfKfdDJqoaku+7Pv09Eh9imyTWDGClD9/i7rQuVojKSf5olEUm6CoiV
         tCbvrPzFaUGtldul8LaCS0XC28uc79IuPMu2NDrdzvcKQ0eouC1gryeJ4ct/i+X2mkU1
         4gbAfODbmASuKhA/gEcIA60sg/uxoHolknGnXzhNda0Ss5NtgC5xYP7Okg9lDkhNJFqd
         v8KA==
X-Forwarded-Encrypted: i=1; AJvYcCUKyAVGX9Fe/ocieo23pRdTWiWVGo57nlA/L3QeD3US5SHNspP2xcMiOS+yG0lMSjnWXr7+ikNcjfeERII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcajJyEBZjxW4mIDhRlb/aF6AvliRGUqsd0n8EIwkyp+QQ9Qvd
	/3IIDOkENhJAAg0+Bh21D0c+Mswk33ShsZnGEb0FqDINgysQFlO1QCz4/YmhWw==
X-Google-Smtp-Source: AGHT+IHUubRePPbps9nQLaIqqpUrHOtrCXulHR+FT1p2sXm+rpX8Vvptl7dELgS+F8WL0gXGOOf3Jg==
X-Received: by 2002:a05:6214:3d0a:b0:6cb:4225:d85d with SMTP id 6a1803df08f44-6cb4225d9bamr101605986d6.1.1727544255950;
        Sat, 28 Sep 2024 10:24:15 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68311dsm21437756d6.122.2024.09.28.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 10:24:14 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 28 Sep 2024 17:23:59 +0000
Subject: [PATCH v3 2/3] staging: media: ipu3: Use str_down_up()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240928-cocci-6-12-v3-2-53fc5ed20be0@chromium.org>
References: <20240928-cocci-6-12-v3-0-53fc5ed20be0@chromium.org>
In-Reply-To: <20240928-cocci-6-12-v3-0-53fc5ed20be0@chromium.org>
To: Benoit Parrot <bparrot@ti.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The str_down_up() helper simplifies the code and fixes the following cocci
warning:

drivers/staging/media/ipu3/ipu3-css.c:229:18-47: opportunity for str_down_up(state & IMGU_STATE_POWER_DOWN)

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-css.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-css.c b/drivers/staging/media/ipu3/ipu3-css.c
index 1b0a59b78949..bb22375481a0 100644
--- a/drivers/staging/media/ipu3/ipu3-css.c
+++ b/drivers/staging/media/ipu3/ipu3-css.c
@@ -226,7 +226,7 @@ int imgu_css_set_powerup(struct device *dev, void __iomem *base,
 	state = readl(base + IMGU_REG_STATE);
 
 	dev_dbg(dev, "CSS pm_ctrl 0x%x state 0x%x (power %s)\n",
-		pm_ctrl, state, state & IMGU_STATE_POWER_DOWN ? "down" : "up");
+		pm_ctrl, state, str_down_up(state & IMGU_STATE_POWER_DOWN));
 
 	/* Power up CSS using wrapper */
 	if (state & IMGU_STATE_POWER_DOWN) {

-- 
2.46.1.824.gd892dcdcdd-goog


