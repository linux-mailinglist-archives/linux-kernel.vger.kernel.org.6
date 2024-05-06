Return-Path: <linux-kernel+bounces-170336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F36E8BD560
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DDB281781
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4E159576;
	Mon,  6 May 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I1G2koOd"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D7C1591F4
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023491; cv=none; b=en18zu1aAFUxXsuBtMmZ7dG6GCKA4XkmXJVL/cyCAvnTw5K884QEitAQVXacxc55PN+kjKnMNYas0rgkHL44d40XAavPu1vkpW4CbJstCvD1Esn1kQu9xgdEyPQGRF7E1ZVyZl8XTzOG3WBfVh+5hLMxr1ObaiB/q7mcRPxTHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023491; c=relaxed/simple;
	bh=mhhV9C965LonYmohFrFfWzyGr+/LNO+1ZjetyU5xPQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gwELUDS5vFmwOFLyJul8+3DfavhXZXhgAenoZYnD5ibcWm2bG+Ij+T+3f8qDzZilNUg7SivdpRncLsw+4wJ2WANkmXeKnh6IQmb3YfpGsrTh+2aNVT92U4hinADPszObc1SedfJLEQCW11s1FO8i05lJ9PSAj04ux/fehWPMoE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I1G2koOd; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43ab2b2f11bso5704721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 12:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715023488; x=1715628288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sERH3AW/jfrsCIvECuFC7tcnEgKRlBvngV0r54MZywU=;
        b=I1G2koOdXT8QZl6rjPb4sNxNUfxuZbL8cdVOw6iqoV3ThGhOm6jv7MmK4wRQO7NziC
         WlslPdhIrRI2kH49jRFyM952zIOMGATPrqU271dh5D8NpZbRysvnVwWTp2zcR8NlQDuN
         K9fgBrkHgeI73tcbL6tpiXU9YHmgEs1mpyFx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023488; x=1715628288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sERH3AW/jfrsCIvECuFC7tcnEgKRlBvngV0r54MZywU=;
        b=cXx2agzJH5aFOA1l7P8PJ2SvB8AVKX5CL3h3IJQtj4ZjxGWKmC2x62KlWHwVvMMZ8F
         DeNP6rSIvV9EIc92wtbWTND9m7YflxADlGQtehALsDZ5wDL0WNMi4+kTN+T5uBVATw3m
         VxP6rXMYzq1GVv6mhkRbEJvZQVM/CZL1AGyove4abdq6tQMzMR8JgLD2t9HaeFRG6pW7
         OOw80NvAUI3/sRcPxu+18sRIZjoRZA+Am0+MBgDo155njBDCFDrtLfezpKA71tgDlvNx
         AixdzLhn0ulKXW5Ko29Uly5cbx78zWzLeI3HKUVA2r6Zx3MywyUM3yI607UL0ijc8cJC
         CDIw==
X-Forwarded-Encrypted: i=1; AJvYcCWA/AvHK8mOpEmd8z0H21YezezulvGot21g6i22EWVo4mqmkooKpqrp9uMenCqM3BkJtAcpuh+qsMXh8kkZTW5tZRsiN/rLY3fumLPA
X-Gm-Message-State: AOJu0YxrV/NmFHbSfnRvqSMN28vYqKUAWn9NYTGTg4yQ9gdFZGDvx/AY
	QzcMEExOJxwsK3qXJ8wjmRvaje9oI817hMXTqyac+02K11LYRRPjY+f34te9Kg==
X-Google-Smtp-Source: AGHT+IE7wQrVOaXIB6u6ahbWEXnIqKIxesTWerqc3J7ZVDikE6i1K0SYZJY5aGJnqDPOw+uBmngdig==
X-Received: by 2002:ac8:7fc2:0:b0:43a:e5b2:8627 with SMTP id b2-20020ac87fc2000000b0043ae5b28627mr13527239qtk.62.1715023488343;
        Mon, 06 May 2024 12:24:48 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id ch9-20020a05622a40c900b00436e193f408sm5439870qtb.28.2024.05.06.12.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:24:48 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 06 May 2024 19:24:46 +0000
Subject: [PATCH v2 1/2] media: bcm2835-unicam: Do not replace IRQ retcode
 during probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-fix-broad-v2-1-e6a2a5c0d609@chromium.org>
References: <20240506-fix-broad-v2-0-e6a2a5c0d609@chromium.org>
In-Reply-To: <20240506-fix-broad-v2-0-e6a2a5c0d609@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

platform_get_irq() cannot return the value 0. It will either return a non-zero
irq or a errcode.

If a errcode is returned, we need to populate the error code upwards. It will
give a more accurate reason of why it failed to the caller, who might decide
to retry later.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index bd2bbb53070e..60c0fe956c58 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -2660,9 +2660,8 @@ static int unicam_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
+	if (ret < 0) {
 		dev_err(&pdev->dev, "No IRQ resource\n");
-		ret = -EINVAL;
 		goto err_unicam_put;
 	}
 
@@ -2670,7 +2669,6 @@ static int unicam_probe(struct platform_device *pdev)
 			       "unicam_capture0", unicam);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to request interrupt\n");
-		ret = -EINVAL;
 		goto err_unicam_put;
 	}
 

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


