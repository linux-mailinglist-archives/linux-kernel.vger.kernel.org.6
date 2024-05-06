Return-Path: <linux-kernel+bounces-170337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C301F8BD561
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38E81C2191A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E715958C;
	Mon,  6 May 2024 19:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQaDgD0R"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAA31591FB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023491; cv=none; b=NJItf1ilIf32s2ENno88sO5Nb4dZhqJGRJECUYwrFuOZauLJAy9eP+xHwUwJ2fnqXRbwf+iSiCpnRJ5SxW6s9GeR15myFaRdi3iXKN+sDo9o1UgLKQOP4WWTiFRonZiiXDPNRNFHKSA95320MI9qvWVI7lTeg0Pa4z9aMf0B4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023491; c=relaxed/simple;
	bh=2UHWC2bxvJRpPIbR8NMDLC+df/QxdRgc5rfe62kBZfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MoqPQZ0XRyFqyMO1W5ekNufy8cm1SR1tCNDK8Id3AvSD+7420XLrTmn/nfBDZl1eSVwGQXaYIesXVGDjihkNjwDWZEldxY0BGefToljUnr3EuVWbzjlYl9cuyOT7Uahiz7Lvx/p7qVRKfHm/uX2TFVXe4/e/bTEW8w6Rq0y1yDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KQaDgD0R; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c97a4857a8so68505b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715023490; x=1715628290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raDFNcDQUrEtJLVjBh+B3qIrZSUwTfQ8a/Tp6m6/klY=;
        b=KQaDgD0RMrnKCLWYW/tQ40vUmqBXHTxVUikTQ2THRo4LQdbsAVTFw6q4b3VRAm+/h0
         e33fBydjIJC8WLu++VdlUv7PvQFWgi86cUsAQT13hz719D6n8pro4vMGrYLkviy90M4C
         ZHLb9ZqrhE/S863I9aymXEytFU0sKm/j7td8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023490; x=1715628290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raDFNcDQUrEtJLVjBh+B3qIrZSUwTfQ8a/Tp6m6/klY=;
        b=mAo87By+830yzIqRW18ZCxRCYqNa+zP1VoWyNfFtXRc4O2+5SJHQT5SyW7Jmldnz7G
         3H5QN1KukzuciR9kcpEmsrxpVAD17kmRhdo0jAFKvbPUqRSFJoYtA8WiFkiYbFbJ8Yme
         bzhICdTDoUpvkNanOm0b306nQ+hoEbAZQ06CdSdt/3b0qVjLEStt4cxcOhEn5JAt/Xfz
         9REnzgKLE4XLui+92uhV4NlfrYYX2VFFXMeiWyS94lr4ik/yuimXrD8folj40qjA5mtK
         7hmmbEig4ypxN1twVv/EPAzpH0R1T/bRp47YSPfr5Krh7mABu3aHUJ9yR6SbqMyN84Vu
         KUjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3V4CYI8dBtFG2bdo288AHuG8//If+xje9ur29ZxknFxVRwv39La7fBQX0vh3T9z3+W+jIijJ/VzbAI7ZbJeyv8TPUBVDLbYKli2BY
X-Gm-Message-State: AOJu0YxLHt0Q0bhphHz7doSMU08C3yabwL+BWBGI8q1R8EE2OJsAhAyu
	AnnGDrxJSDCCGTd6fTR3Hx5x9uR8Ne7iAl/E+vUwr507kkhsIJcoYBNRBaTdcw==
X-Google-Smtp-Source: AGHT+IFkAi80BKvF8PjygfQV1vvybXcizCZQWAbOTCI4v5z2AeP2XUkBEmlpXEhtlrpvoxrfTZ4Amg==
X-Received: by 2002:a05:6808:258:b0:3c9:6acd:c626 with SMTP id m24-20020a056808025800b003c96acdc626mr4930719oie.46.1715023489673;
        Mon, 06 May 2024 12:24:49 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id ch9-20020a05622a40c900b00436e193f408sm5439870qtb.28.2024.05.06.12.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:24:48 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 06 May 2024 19:24:47 +0000
Subject: [PATCH v2 2/2] media: bcm2835-unicam: Do not print error when irq
 not found
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-fix-broad-v2-2-e6a2a5c0d609@chromium.org>
References: <20240506-fix-broad-v2-0-e6a2a5c0d609@chromium.org>
In-Reply-To: <20240506-fix-broad-v2-0-e6a2a5c0d609@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.12.4

platform_get_irq() already prints an error for us.

Fix this cocci warning:
drivers/media/platform/broadcom/bcm2835-unicam.c:2664:2-9: line 2664 is redundant because platform_get_irq() already prints an error

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index 60c0fe956c58..0b2729bf4a36 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -2660,10 +2660,8 @@ static int unicam_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (ret < 0)
 		goto err_unicam_put;
-	}
 
 	ret = devm_request_irq(&pdev->dev, ret, unicam_isr, 0,
 			       "unicam_capture0", unicam);

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


