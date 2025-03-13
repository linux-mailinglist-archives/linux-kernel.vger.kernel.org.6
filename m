Return-Path: <linux-kernel+bounces-559472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CBBA5F42C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0600317E8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9574326771E;
	Thu, 13 Mar 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ah5iSIxS"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62560266B45
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868445; cv=none; b=Kx0cL0rhBlUn99wGJnbx9ex01qY3+rI/vSh+RqsqUtejRCJk31gqYjxXUM/XmFZSOzlThfbTEcDa/6hQ1YYtrZeM0l6IyTGDsuDDOiTprg065Jw2KQC9e5SaO3b7JjB1zaNSgmdXyabs+Yv3LUqp4p2o5nRTU8hkMWLzjEI3yBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868445; c=relaxed/simple;
	bh=BwgDyyHIsbebUjnhMSTS4dLo89prxllUAC1gteUe9+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sn9Q4ywUoqMiiXacXaH7KcWaD4VL/WrIbcIDeBfCpqSKnheQwmCqjWTlVhVAgb3PX+xubZGsxrg+eF3br7wgqHvK0SSB/5o62KyyOLJxlWGL+/QYAsa3FdaaHL9EreOJa+x8BccXnRWk96tgj9ZgBOgjTTxEREtyTy++boVwfEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ah5iSIxS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-476ab588f32so11478911cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741868442; x=1742473242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vcY7CKAqwG/zbhJLiCG47Bjs6dQB9a8QmJmLIP3Qqw=;
        b=ah5iSIxS7Aj+YxIWECxRvdVPVmXgxyLGb16fC/p9+NwgWFl0dFjyFOCYzSHh646dGW
         KkiaHLayq8ztEjWYi68ec/2tK5tp9cUzzGr60NIlNMNjCv4z+0h04XHSv02kS1LXULLi
         01mXtaOmlFmt5hkM3MkpqfafTV49xgkM48fwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741868442; x=1742473242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vcY7CKAqwG/zbhJLiCG47Bjs6dQB9a8QmJmLIP3Qqw=;
        b=g1QFKb2u2V45eu6DsnjvK+kkvcdMLM60Y5lh2rQXoGmjlkb6mHq9om5sV4MeCRTFox
         B+ldQBMEf7igQA1DzSH2VSiSBoq77ls8XX/i5wsxhN3XjtM+BRqs2pJqRaRUZJAOG9L7
         0AhG2diLj3Y1q3vJTD17AhvtvE+z+SQmakI/gGe940XqIEb744et3HqhCu7S7cygkeb6
         vcb4mJHGDKCctDUuLHwlxQdZG5ts1mUIX5/WWJF1B7yK7tk1aMsHIsVWx1MY4fZasyI2
         bvdrae2E0wH1SApvZhQ73QGUVr/Qx+ISSgD+wexTt1gPDwCjGkWVvSmn8jUPCzj+pit4
         yGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm2BvLWA+KZbYINvhyJt37Hy4HHqVbJPZ3pa+zl/JwL80vKgr0PEWHRlkaZGJ262pm54NRpaodf72L8XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydPUpgiIKoRXCkSooA2CNzfYPA9kytV/c1FY/4uUEWm31DKUCs
	yMjBMPYzuHr12zLs8RjDGi/2g2N+ik4TL55ONa6o5zxrKB8Wg+9obl0pjiD5BQ==
X-Gm-Gg: ASbGncuZ3ISbR76ZQ8+yQTs73Ne+ahrqnHV+iF+9hPbl6eGHUYFJt7SZXV4mDTPGbcC
	nd6sUkxQkJTdyazYu5VxcMaiSqdviMoL8MtAg9L5EquLO1hQmQlYNh3ZpPME4Nr/Y1lK7KwqusT
	4vzN1sy9DQwnOqJj4lP2cBOzoDWOk+lL+Inyv6BuIymnQP7YelPU5V1CT+y4uPNrtltGLGG5DMa
	AQPCDq4pweqvxUCruU3hnF6KbbOhvn2tGs5yISznB+eB1ObzlBIQ7ABLGudLBshMWTi4D9vGmtY
	hcH/1GRD+vdSdYix/HGtL0g/d6VyhBUDPenrrtsGmrZFM2XjZs2SPepYiIt0aRJkwVIC3ct/3GL
	yN5VomPpJheoy6lefSAPdOIIAZ7u1on3O
X-Google-Smtp-Source: AGHT+IGxu2l67R32KRhYTVLsCIiUHIBqUN26a2hLoa3PyEKo82RHqkFlvKoqmyrBpM6B8yDc3nFn+w==
X-Received: by 2002:ad4:5f85:0:b0:6e8:9394:cbbe with SMTP id 6a1803df08f44-6e90060978amr408704926d6.20.1741868442139;
        Thu, 13 Mar 2025 05:20:42 -0700 (PDT)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade235f9bsm9038616d6.29.2025.03.13.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 05:20:41 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Mar 2025 12:20:40 +0000
Subject: [PATCH v3 2/2] media: uvcvideo: Use dev_err_probe for
 devm_gpiod_get_optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-uvc-eprobedefer-v3-2-a1d312708eef@chromium.org>
References: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
In-Reply-To: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Doug Anderson <dianders@chromium.org>, 
 Douglas Anderson <dianders@chromium.org>
X-Mailer: b4 0.14.2

Use the dev_err_probe() helper for devm_gpiod_get_optional(), like we do
with gpiod_to_irq()

That eventually calls device_set_deferred_probe_reason() which can be
helpful for tracking down problems.

Now that all the error paths in uvc_gpio_parse have dev_err_probe, we
can remove the error message in uvc_probe.

Suggested-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e966bdb9239f345fd157588ebdad2b3ebe45168d..d8e51c3db7575bebe7bb700b53b50ae02d355d8e 100644
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
@@ -2240,10 +2245,8 @@ static int uvc_probe(struct usb_interface *intf,
 
 	/* Parse the associated GPIOs. */
 	ret = uvc_gpio_parse(dev);
-	if (ret < 0) {
-		uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
+	if (ret < 0)
 		goto error;
-	}
 
 	dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
 		 dev->uvc_version >> 8, dev->uvc_version & 0xff,

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


