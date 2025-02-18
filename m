Return-Path: <linux-kernel+bounces-519454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96C0A39CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2477A188F1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3453269AF6;
	Tue, 18 Feb 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfuWBYV0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0B1269806
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883958; cv=none; b=mRDtACGbWKiKE6yHDn3uegre8RAfjg1APr0acC1JxZxMil7N5zA1oj7FHOUuBpZUMJj6QA8IcWre3DEzr6BMWEWb8wAMNAtXVZ7nlfgsZBi7TsV1yTvm1ARRoFF5hZRqazIX/bjB71eGpRR9Fh74WYlWYmn9IXqAlQ119MHEH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883958; c=relaxed/simple;
	bh=4qkh8yLy8dDdZM21T9lsKyPTqQzhKGIVigwfv4cqQ2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N7O3TWqW7ZBYbb5EgRMfizODjSBfYcHOiXvRBKQW0rTDWxWIFPNsF8YNNfFfkf3aUm7WpJikImbu0vemr35ZX1CF0KyEyfhpEM0Mfo/zrpBxePaCwlgM9f4bqe13Rqnw2WAdbMnKptHKPJKlY7BeXv1OPRlcEJ+UmYpvA8DRaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfuWBYV0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso905211266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739883955; x=1740488755; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kasHUX4bzeiCrVBmf7mcD2rXkVNVkykZ6gjvVSR3ULQ=;
        b=SfuWBYV0e6WFQq9q6DWaRHs/D5VVlhArm4iAsWWis9S4c+B9STONknQ5vwHbX72XHK
         A24MtlGLOISPMGcoX50Z+GkIgI/CWynSiHxOxNBUIamyUs7QoBMwf3822Ayj7evV0VFK
         gw51z18ADrNYGjdZHHTyO7bZr2ua7FLKOfKS2EgX4wdjePcm7cxCIIOZ7VtGy2mJ7wWs
         ydsNRX6MpmBvMeQwlz/Zvo20fOm8P3Oc3tvs9t/0WvuZlB2sX8/kDmcSIYHXBrBF8ewb
         E3wRtC7clgMxSu++ZpIkmCEOiGOsIjkE/grgOJrpl4utZl385xMeBARkMPzrFd4KPxjv
         Acew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739883955; x=1740488755;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kasHUX4bzeiCrVBmf7mcD2rXkVNVkykZ6gjvVSR3ULQ=;
        b=jsKc6yWmia5UjDpE5o6+uF5P01qAGqPkUofmB6b8Gp/kylH0d1Yf4kX5fUJ9JYFrgy
         gxr7jBvJgrvqvgazqPlUcK2LbaliazwEZ1DMq+QrhyGkPDNQE0k0qHO3vrxAdj5RjZvJ
         112ThCux1485H+Ak9DnbJIo6qRGdldoLC9WpANkjTh+HaUPkpNKjiorqxqB3h9D4q9/M
         PZyHmjMn1f0coRzFx40nnu/ScsBhXCziQogacN3fEXmFKEKca9ZAI7acYRKfk6oRvWzC
         xJxx+D6no+SzAcdtaexg5PL3XDrJM5CEsr4Fa0f7C3rYMS2tolJyLZ+krPAQbfVB8sfJ
         7J5g==
X-Forwarded-Encrypted: i=1; AJvYcCXRn9yVSPAsQOrt3E297lQHtYAeEabGPsNVILCnQ4d2IvlWMtO6GX1x+436FiFcCe1+X6QjPPq6dUGbYRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ibFvgEFJR4hd1wANLKKM/DzQ+WjhmUorGxIfhF6/Mx6O87Ar
	85BrW3rUsrAKwpVoYtyWO50Ocs5Ji0JxGJVYq3+EJMfqvP4pPqZUXGZD0Cx1xVM=
X-Gm-Gg: ASbGncsR2yemvfqTJ9DqunrKmF4HtKmdgmTFNmzXgsAzrNfLsqBdLFwueW3LlLdkNOI
	BPztmnYOfdKNhpAAulboXwdBe9et4rQ4CaSuKnh4Kn+diYMfWtJXF4rKPS0TMEAWu0AjO1q89DC
	znREKBJ8dtgfVPKBQxQ/jRwXS7nmei8dc1CsXk1hnp0W5+6Doy8Qpd406fZvfqGO+HkTuj96LDE
	kvQe9Agjiev+sXkEdRjeacxMTNVyqTiLtIDREwfih5BPFRzSgOo+v+yTscvoYihuhay231kRz0W
	bDgON4f//xZagOQYv1cI
X-Google-Smtp-Source: AGHT+IF2qeAel4OTdeuho/BN/9zq3dRQjnmGfMFgYzkqOj53acAaPZ+YeAFgAYZN9+aL4nEgHblvKA==
X-Received: by 2002:a17:907:1c21:b0:ab7:faca:a323 with SMTP id a640c23a62f3a-abb70d677c5mr1438999266b.39.1739883954756;
        Tue, 18 Feb 2025 05:05:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abba9bd6e3asm261505566b.58.2025.02.18.05.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:05:54 -0800 (PST)
Date: Tue, 18 Feb 2025 16:05:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc: Ricardo Ribalda <ribalda@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] media: i2c: imx214: Fix uninitialized variable in
 imx214_set_ctrl()
Message-ID: <1e4da85e-b975-4638-bd14-09ba0675d9d6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

You can't pass uninitialized "ret" variables to cci_write().  It has to
start as zero.

Fixes: 4f0aeba4f155 ("media: i2c: imx214: Convert to CCI register access helpers")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/media/i2c/imx214.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 6c3f6f3c8b1f..68775ee8256e 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -795,7 +795,7 @@ static int imx214_set_ctrl(struct v4l2_ctrl *ctrl)
 					     struct imx214, ctrls);
 	const struct v4l2_mbus_framefmt *format = NULL;
 	struct v4l2_subdev_state *state;
-	int ret;
+	int ret = 0;
 
 	if (ctrl->id == V4L2_CID_VBLANK) {
 		int exposure_max, exposure_def;
-- 
2.47.2


