Return-Path: <linux-kernel+bounces-542613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D2DA4CB9B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBDA7A8470
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E6223498F;
	Mon,  3 Mar 2025 19:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IgLiRlUq"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45796231CB9
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028840; cv=none; b=r2CRPdCeD3GhMY3nKZbej8QCO5u7/Dcjk9nNdYlWFz08XwcU6t5U1sylt6brigNgBqyF+eSoW56Vld1Js7R5+pOpQ5ahJwlE549Bb9VtQ5BcQWUXYD7NSUm9mnwq4qGPUZiQFGiI/W5SmiLC9hmfb6+nhYQlk7OBE9et2U6I0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028840; c=relaxed/simple;
	bh=727RL/vy1smD0AJDbCjmRvd1a1o2D/6943w37oDoA8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0mTc/WXOK1WxUNtoQaWgtWKOkJqwzINk3+xTtDX0yonK+6gHIllvs2F4x8pyfLB25zU5yV94kEM1bSB9A38F4qA3p0ZXoJCt2EvP0lLIl6L8HwLWWYWEJ5eZ9tdD33a7r/Mh+9Hd1F8ATtjl05MkSk13OTd2LbjVUMwPHK/Mh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IgLiRlUq; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-474eca99f9bso18447081cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741028835; x=1741633635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZwQUn/XlYg8B1gU2t/0mo4nCO2lMeP4D6FyqvnakfU=;
        b=IgLiRlUqFdj+Xe6BrIOuDEPp1ifXdeLCIO4SE7jmB+5CB6c4XjtiNYG/B5XkDzlfIz
         tt37qcdaMEqPh6s4XyfYkLthB20ATIKzRVy2UOI0gpPRUpNY6PlvJRSMOQf+YqS3zAeo
         g6ZFmom0+dyhSFphyROYz5ieiUzOjK+7QwGcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028835; x=1741633635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZwQUn/XlYg8B1gU2t/0mo4nCO2lMeP4D6FyqvnakfU=;
        b=IYxoxKd2eqSTLHk8nH03fmzE36sl+4SW7ypRXAOhSAMWpR/cFpK+ZvwDfK6DH8FnQ7
         ElaJBL9JU4VFgptgsoIxuzmSvu8iYOL0SIkiD+PHEp2k5NWewOL1AVBbIukfz7B9l+Iq
         i1VPc+GtxpijpFwlJgN2Odmsw1p2chq2rMqhfsNdAxMJ30Q47eN6WGUq2x6iq2rq0blQ
         p/rtr9cHu18kGslOf+VkywW+DSF7dyAqDXNqzESJ5Dss9JyBRO5uxzZeJgUROunUcAs2
         NHZ3KqQ67rchTfDsyirTgo4gDtfYhU3aVca4Zyrai4OogJl13AMmHH7hDdbodBanK5xf
         YjcA==
X-Forwarded-Encrypted: i=1; AJvYcCUblGMTFA+k/td9JeUwGsmDd9M11CzVxVWEQNj22iYsuEGkLhcDRws4DJfjjyYbevgBcDC/ULVZJfQcPfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0xj/yO3s+34MbYhthEd/uaAYLb5EKXCW1EWM0XOc71soApBh
	u/bllIMxRasAmipY26vz1bcfR+ONUDXy+WAKUHxjZymt7jBjM+Spl1SIyK8kEg==
X-Gm-Gg: ASbGncvp4yC3NaNH8Z1otXTVF+MEclp0E8VRL5vNisUkHaKeWDwdh/6/5YJajawktZe
	wKp4hyVwToEJh2WKZNJvYLWGz17PZxtoWU1tYb6dg7P6NNV8++bfas+K2EXzZdfgL9V9iF6/W7f
	oVbal14qoR+vztvG5+KHs1BCymYE+liUpa2iVH1QzRXVZAp27NBxcNz/OV2nuoDqKr6CONZN3Gi
	bq4usPyUTyf+zD0FvCDHxxwbwYR/hnbrH9QjW2DLOpQCwHD753XKV5iJz+KiW8OiYBKzMcmL+Nc
	794h1KFINpGzFk098GuEemFzZ7iL07nyAW4FDMPbeOGIusk52gzB10pfqh6R1AyOsq+OEHmjwBL
	LofkYsnrcOy+10ARFzXSRdw==
X-Google-Smtp-Source: AGHT+IHbB2ULThZDwvr8LwWiOxMeoRP6M+8CIeBuTRWBxSc7Hsd2Skry93C67PBKQasajm2/AaIqQw==
X-Received: by 2002:a05:622a:610c:b0:474:bca3:85c1 with SMTP id d75a77b69052e-474bca38813mr202403531cf.8.1741028835091;
        Mon, 03 Mar 2025 11:07:15 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474f1b76856sm10218651cf.16.2025.03.03.11.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:07:13 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 03 Mar 2025 19:07:09 +0000
Subject: [PATCH v2 2/2] media: uvcvideo: Use dev_err_probe for
 devm_gpiod_get_optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-uvc-eprobedefer-v2-2-be7c987cc3ca@chromium.org>
References: <20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org>
In-Reply-To: <20250303-uvc-eprobedefer-v2-0-be7c987cc3ca@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Doug Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.1

Use the dev_err_probe() helper for devm_gpiod_get_optional(), like we do
with gpiod_to_irq()

That eventually calls device_set_deferred_probe_reason() which can be
helpful for tracking down problems.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e966bdb9239f..0094cfc092d6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1297,8 +1297,13 @@ static int uvc_gpio_parse(struct uvc_device *dev)
 
 	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
 					       GPIOD_IN);
-	if (IS_ERR_OR_NULL(gpio_privacy))
-		return PTR_ERR_OR_ZERO(gpio_privacy);
+	if (!gpio_privacy)
+		return 0;
+
+	if (IS_ERR(gpio_privacy))
+		return dev_err_probe(&dev->intf->dev,
+				     PTR_ERR(gpio_privacy),
+				     "Can't get privacy GPIO\n");
 
 	irq = gpiod_to_irq(gpio_privacy);
 	if (irq < 0)

-- 
2.48.1.711.g2feabab25a-goog


