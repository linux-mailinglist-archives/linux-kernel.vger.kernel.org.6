Return-Path: <linux-kernel+bounces-370561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6C9A2E88
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7E71F23C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD962281E8;
	Thu, 17 Oct 2024 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvdK54on"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF49227387
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197268; cv=none; b=F7LUOeNEVWJ1L0Zp2F6aYPxSGHsfTN5QhVOjwZ2NDW0fSZ6/97HIm3Cu07Lp0PkiLJYIr/ch0OKa/VOUe5QHoso8A+suMxV7N+zQn9Mu/X08HOYZ8OMo1D/dggF5PMIUKDr0gvpIT8kNFMsHoSCDKdqc0KjAGGBgf5I4JDVDgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197268; c=relaxed/simple;
	bh=DpHYpfP4wfR+URtc3nLIT4CXA+r4pWyOSFTF/zEameU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jYJzxwG92mHcOOLN8kvkEx50E62vw2c79w883bDygmhcsLnaVL32SBabTX/4bltsJKChUBf5lT92UDNr3UgzhCjBTscEdEqEgzAaI8DbD07r+c49+cbPdxT79AqD7X5KyRsTmYR/Tl7e2zD4PlT6+qP/ss66eWruojtXIgPMlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZvdK54on; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a3da96a8aso218270666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729197261; x=1729802061; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGfGq8AYZ7Nk9tfcNf0RUEE9wnLOSE1tLqUZ0uRmdU8=;
        b=ZvdK54onCQZMwMu5h0gfjMtOM2ceD0nIXRT51Nmr7qtJjXHbV7JZew+pwlBj0Ha4JY
         bNmQ0J7nwwBcYf9N/Jo6MsYkCDMDHEbmz+RueYlY/USCt83DYEnq3u9ctkIS5w+GDuE+
         83MC4FrhpB6LP+c5US+AhegZFaeWFyuyc2IklgujaL4SYcbFKB/21mPmjw/cwvQnYQX3
         OsAi8Yaw8OdtWMI4EzhFmbdUqfAWJ2ji8EZ3LXHYqITvTA+vcz7UuWZH78hdD7U1Rx4f
         pgfcDVenGTdz+nAVZ7quikpHThYMIXE/8j45MIDWbZDIlraMvBjgfggTPDo2L59cmNDB
         h+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729197261; x=1729802061;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGfGq8AYZ7Nk9tfcNf0RUEE9wnLOSE1tLqUZ0uRmdU8=;
        b=HHG0Nr+gxsyWIguH7ABGffNe4lfuE1jH/AVq9vrmNMsum70viX2pztw9ZioZhlrMo+
         gpi8UyEh9YIAGSA+/ADkS3pknouQ0pwjGAMJnfipQlV8DEvJSsFR+9zIWWQ+rWwyHZBO
         C6MBQXewuUs24axkAwHAUpaDiSxEfLV87Gxa8/cZcBtUhzKTmS7d7wGJwpWw6rKCw4SY
         hDDhDGRen8AOefEVWSYRPm7N8RsBK3LVibO1dbpf2stg0F9hSnoXEGGiUZ9yqJTlF5Eu
         RuKYjnqSHjM9TWdmARc9I37pBmE6AkpA35eD0Rtegmzd2ang3Zep6A1Nl86kCr/v0eLU
         +mZg==
X-Forwarded-Encrypted: i=1; AJvYcCW3lGosn7owFyDmOvY/mBe3rxotuEloCWiytlMTPxYfY/qqjTYJNturhjid9HDVB88AoTWCVk1z8TDpfnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGa+2S6RMcRqTTCF8ULVF3ZYcWQNguqs1uIaNwqP8QI33LeUsK
	BCq9jVyoXOLS8x9hVBow2p5ju5sY+7c1mfeUYm+AizCzf9dAB2jCP3PDwvIcKSM=
X-Google-Smtp-Source: AGHT+IEmgPvX1kkIRYEDJUNIKySkuA4+HXCNFKzqTi2T8I5tzNgjLRaV5zSnWNszCG4Cmi9deiEQMQ==
X-Received: by 2002:a17:907:9404:b0:a99:ee26:f416 with SMTP id a640c23a62f3a-a9a4c2ef2a6mr454115166b.14.1729197260600;
        Thu, 17 Oct 2024 13:34:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a68c284dfsm9818466b.197.2024.10.17.13.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:34:19 -0700 (PDT)
Date: Thu, 17 Oct 2024 23:34:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ming Qian <ming.qian@nxp.com>
Cc: Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, TaoJiang <tao.jiang_2@nxp.com>,
	imx@lists.linux.dev, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] media: imx-jpeg: Fix potential error pointer
 dereference in detach_pm()
Message-ID: <ZxF0yOCms6cldOlV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The proble is on the first line:

	if (jpeg->pd_dev[i] && !pm_runtime_suspended(jpeg->pd_dev[i]))

If jpeg->pd_dev[i] is an error pointer, then passing it to
pm_runtime_suspended() will lead to an Oops.  The other conditions
check for both error pointers and NULL, but it would be more clear to
use the IS_ERR_OR_NULL() check for that.

Fixes: fd0af4cd35da ("media: imx-jpeg: Ensure power suppliers be suspended before detach them")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: The buggy patch hasn't hit Linus's tree yet, but it's destined for stable so
    add a stable tag to this too.

 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index d8e946aebba2..918ab12edc9e 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2679,11 +2679,12 @@ static void mxc_jpeg_detach_pm_domains(struct mxc_jpeg_dev *jpeg)
 	int i;
 
 	for (i = 0; i < jpeg->num_domains; i++) {
-		if (jpeg->pd_dev[i] && !pm_runtime_suspended(jpeg->pd_dev[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_dev[i]) &&
+		    !pm_runtime_suspended(jpeg->pd_dev[i]))
 			pm_runtime_force_suspend(jpeg->pd_dev[i]);
-		if (jpeg->pd_link[i] && !IS_ERR(jpeg->pd_link[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_link[i]))
 			device_link_del(jpeg->pd_link[i]);
-		if (jpeg->pd_dev[i] && !IS_ERR(jpeg->pd_dev[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_dev[i]))
 			dev_pm_domain_detach(jpeg->pd_dev[i], true);
 		jpeg->pd_dev[i] = NULL;
 		jpeg->pd_link[i] = NULL;
-- 
2.45.2


