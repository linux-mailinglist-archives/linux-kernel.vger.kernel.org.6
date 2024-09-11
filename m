Return-Path: <linux-kernel+bounces-324386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8370974BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D49B214FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C965943155;
	Wed, 11 Sep 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwLG9qF0"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380E41AAC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041285; cv=none; b=UmD9KJXdmA0i8qWKBeCpvd1ZTQD7Rkc3hnDJj/LVTqPD9eoVa7I2Mv0OnqlQQ5vH1AAmWDhvkFJsJftiStUaKLQLyxjk59WC8so8+Iw5DYw+4FGa/AnWiIGxjm9XCmazw6TgJ1HLAOykwz1ZIT8z0/ZBVKhCwxxBhPTv686ylAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041285; c=relaxed/simple;
	bh=YlRgfgg94/S+YD+u7hs0fDpJ4YnH6iNeSjeUa4mMHH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lFnljVBsV32OPv5YBVgQBU5DQtiErFsjYlAx5fCUYotLi8CBIw+kVLRIQqEz4RFffLornbS2cIhjWIYCPRivvCmzqRcRUQ5Os9ySUIOQhs7Y4zijJjGVvrV2xrfss3wszXx/JKqCNwMHi+brCq88BS01L7Ll4cq5kdtcCspaI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WwLG9qF0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb5b3c57eso31914625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726041282; x=1726646082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqbhBzP+AwPfpycxn8GsxBvEG+G4YMSO9DnKKL5O6Bs=;
        b=WwLG9qF0Aq7BVYaaCb51/BC3JOkVnHb3uZ7/2y+CrSsqOP5SZY+VT1eXIIZEA/Wynt
         owZGFlHQgXFNwhOMNDkt+/NXDnpKNKzO3iIc2jkf/tCNKjDAWqKxBUBOHaD235V7k4M6
         1TFiwRPAow46IcidSt/Vx3mO7Sjn6YicWILCL79d7d6WwoE0Bo8mHDrLcWCQ3BFdouuD
         KMgf1HUV6oklntiMdY295n0jB9GYDRq1y8klVtzj1xXnZz6PQalmDMTKGHjdZAdNj5U/
         9Xo0e1MEvIfQWEo+wG9Tf1JUhyKVXRU4Rd3xHPqmr19gtTqzgwIEmL2Y3P3FOltawXcE
         ZmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041282; x=1726646082;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqbhBzP+AwPfpycxn8GsxBvEG+G4YMSO9DnKKL5O6Bs=;
        b=vtXGlR9QaOKYT+oYDX8XZN1rgo/MiG8dFl/qqBpm0YKk+cDGeBl+qnKvrdAgx/rIjs
         9ef1UimmXCMf8XjAw+UwmanvrpjQOcMG4d4KSZOH3/NRCPhCxrZSy33j3n8YxEqxRblk
         ssQSsqkIp/fTYBRMcyakfT+41CcDGB338LFbH53xc9qs7o/jIoSTHlSpwb/SIqp6exph
         bw/KaVxi/LhQqkEGwunDf3AGi2ZLZb3A+d3yy+d2bVSUUOoZTf5LGKdmJP/cfbKKFEoX
         q7XfISv7M+j6lDFvzgtn//+61KuN5SByYv8hz/L9ejhnX0lRiemg/OQOLycBVGZBuKpk
         5qwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu9NYMxpkOLNQfemv2W1+oGzycz9KV89YuUjLBOSoEd+HlURNZw9dnoDyjkhW/yxFJcPqhkrZxrd0GANw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjlbq8qcyvOZL2aSViI1nV7UbdZW/JfVHDx8nvEWojI9gfw8e
	tCGgQ5v8dVWxRSrXC/jc+XxY7CNsxJh0r4oVHHP3ti8ef0MNqxBhobjwPnKlnU7JZxYnD+23I1b
	p
X-Google-Smtp-Source: AGHT+IF+JIETRuZS3KaW654cPaCnNTiUYodx1+48B9ArQWBZPpTcHlQbCGI9kxNJpQdkWvbN6vVhnQ==
X-Received: by 2002:a05:600c:4f4e:b0:42c:b4f5:47a9 with SMTP id 5b1f17b1804b1-42cb4f54c54mr89048395e9.14.1726041281915;
        Wed, 11 Sep 2024 00:54:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb21d3asm135033535e9.5.2024.09.11.00.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:54:41 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:54:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: Jagath Jog J <jagathjog1996@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: bmi323: fix copy and paste bugs in suspend resume
Message-ID: <c02e52c2-ff23-4bb3-b1f3-a8b93ff9799d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2efd1dd8-5a4f-4df0-8acf-972c91b7c9a0@stanley.mountain>

This code is using bmi323_reg_savestate[] and ->reg_settings[] instead
of bmi323_ext_reg_savestate[] and ->ext_reg_settings[].  This was
discovered by Smatch:

    drivers/iio/imu/bmi323/bmi323_core.c:2202 bmi323_core_runtime_suspend()
    error: buffer overflow 'bmi323_reg_savestate' 9 <= 11

Fixes: 16531118ba63 ("iio: bmi323: peripheral in lowest power state on suspend")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested.

 drivers/iio/imu/bmi323/bmi323_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 671401ce80dc..d415b6542089 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -2199,12 +2199,12 @@ static int bmi323_core_runtime_suspend(struct device *dev)
 	}
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
-		ret = bmi323_read_ext_reg(data, bmi323_reg_savestate[i],
-					  &savestate->reg_settings[i]);
+		ret = bmi323_read_ext_reg(data, bmi323_ext_reg_savestate[i],
+					  &savestate->ext_reg_settings[i]);
 		if (ret) {
 			dev_err(data->dev,
 				"Error reading bmi323 external reg 0x%x: %d\n",
-				bmi323_reg_savestate[i], ret);
+				bmi323_ext_reg_savestate[i], ret);
 			return ret;
 		}
 	}
@@ -2243,12 +2243,12 @@ static int bmi323_core_runtime_resume(struct device *dev)
 	}
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
-		ret = bmi323_write_ext_reg(data, bmi323_reg_savestate[i],
-					   savestate->reg_settings[i]);
+		ret = bmi323_write_ext_reg(data, bmi323_ext_reg_savestate[i],
+					   savestate->ext_reg_settings[i]);
 		if (ret) {
 			dev_err(data->dev,
 				"Error writing bmi323 external reg 0x%x: %d\n",
-				bmi323_reg_savestate[i], ret);
+				bmi323_ext_reg_savestate[i], ret);
 			return ret;
 		}
 	}
-- 
2.45.2


