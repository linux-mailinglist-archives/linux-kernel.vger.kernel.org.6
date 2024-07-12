Return-Path: <linux-kernel+bounces-250739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CC92FC1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6FAC1C22825
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D4217109D;
	Fri, 12 Jul 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pPlI1DtF"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765D16C69E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793105; cv=none; b=RY/SnhSWQoUPjIO3FQ3B+ngrXl8CUb293zf1uOU7bysxyd4qBD7hgskw+opYtwdzHnSpGi00DutCrPxLBWIm48pl777BTWag/PtZeoFbq8WHatqDzuJaMIWXTz55ZgLjVZLVHgxtUEDcsVFRtCjFc2XEc5rfyBZtN9AM33v3vXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793105; c=relaxed/simple;
	bh=IKwu4IeO4ctIHCAUeLuXDVYmpaVD4J5Qf/i0s0LEYt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GkqJpHIAFtvNYQgFUePSPRNDmlZ/uxPskhq4yIi7x+tcbK80uF2hfddmfvyg99Fs4AFQVLWyEu/e55MpBPbxvwajAjQ6CWOtaTYSlgQQLZeBFNFhSf5MHDeHBfIOexTkf/ae4TYApD+HvnkRQYIzsssYGavymXje+fk27yT7wEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pPlI1DtF; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-708b273b437so892611a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793102; x=1721397902; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VghSScXg0SnQ65hjRgRRdsd386IPCF3v3rBLbMWrDA4=;
        b=pPlI1DtFjrYkcc5iP02KyHctwNmU/dTI846uBcmcoxncvXHALoYXSwrqT8TOXx1yBx
         0T8wToDuig/+P6PRdOhTXiAXD6OekG6YAjA0oP6z22IVIQkg4eES9waj7O7Mfg3L6gsO
         yDyXrHJryRziT8/BmH94Pkb5DtdX6yYwnkXRePuFAH8pkfIrLyUbPAKYpqT2e355ascl
         E0jjB6ysjZZqB7YOdEsr4GbGAFtHEMMeB+Xukk3k6Sb6WdCaq4DkYCqH3n9wuygnCqLx
         fNw7uNBEhRQfLQ32pCiCujgoDRy37f0+H+FLvEPEx1YfLnM+YQeXbMJjd+ORLYUzBvir
         feig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793102; x=1721397902;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VghSScXg0SnQ65hjRgRRdsd386IPCF3v3rBLbMWrDA4=;
        b=E9UzI/ThNxszSo7smKRr0+vijY4sd3lDRJyhl2RazrAD+GvzlQhLI8pqmN/fw6RQ73
         MYT4NaLUyTzJmkbq4GE7vUfxmFdwYCnWgAziP8tbmYBXyLXpp6zlpp3USTQwtG+D1mmS
         5vv3JEWaBPzGSEQ7Z//UoRLzdeg5peys9KnLkge4k4dmeXWEVyxJpamMohCephxAM3/t
         KMnOp0tTEvO/L/mPvn5edTES2PhJ9nCAZDe9Kmf8GDBH7jfz98bXamPTZTZmmDNkeHMF
         2xZBaZo/YVqBoIiheV3EIGJbnU4F52fL1O9rQnjt4kxfbc6mw6gRJoz8s0ph1QHbaBQH
         JZPw==
X-Forwarded-Encrypted: i=1; AJvYcCWutjRTzjZb43LissMBWASwkz4dAEEaucb38gpQPXhyu5GjO/4vTZEWxzhhHEgdIPvHiFFiQ00oj+5a1tamSlcAXS++1ff4Y5KQGi4r
X-Gm-Message-State: AOJu0Yz1fcI9u+T85/hJevi7TKS993C6gPHVqvYE+khD01TP2LyXf3gP
	3v+BObNhEedNAPpZeLR+RA+bIReJfjC06R1Xx+aXx2SQbMo1dOQvu/TJDgjNoV8=
X-Google-Smtp-Source: AGHT+IFA0p4jpx4ZTZg5gSmdCsyYovFZ3XvuMQom8jLmz1vaX/2ViXszD44aiF1MHSHh4j1LYznztQ==
X-Received: by 2002:a9d:759a:0:b0:703:7a17:f267 with SMTP id 46e09a7af769-7037a17f53dmr12708239a34.26.1720793102310;
        Fri, 12 Jul 2024 07:05:02 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70559902e6esm847390a34.35.2024.07.12.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:05:02 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:04:59 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hector Martin <marcan@marcan.st>
Cc: Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] nvme: apple: remove some dead code
Message-ID: <124bbda3-7ccf-4e6b-b30d-7115e1c2620f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

platform_get_irq() never returns zero so we can remove his dead code.
Checking for zero is a historical artifact from over ten years ago.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/nvme/host/apple.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index b1387dc459a3..f5a3a4e8b1e5 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1417,10 +1417,6 @@ static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 		ret = anv->irq;
 		goto put_dev;
 	}
-	if (!anv->irq) {
-		ret = -ENXIO;
-		goto put_dev;
-	}
 
 	anv->mmio_coproc = devm_platform_ioremap_resource_byname(pdev, "ans");
 	if (IS_ERR(anv->mmio_coproc)) {
-- 
2.43.0


