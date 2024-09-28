Return-Path: <linux-kernel+bounces-342427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2B988EEE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53AAAB21890
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9419F125;
	Sat, 28 Sep 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFIZs3W1"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDD919E7E0
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727517937; cv=none; b=IeUW2q2Wx3Ytvft9gKrkHL8S2wLaPl1+T+bVf0kUz94d7h6+UnScKs9OsAPMBzgvO+BnKqFKGZ1GkGBdidWNBFQbv4y1qGkJUIslLf9McGihMMK575PEdb/qSh7n/aUrm2OZosuSVqlq589dyF527u2B78tM0p48KMz95USeDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727517937; c=relaxed/simple;
	bh=nysf4iZQmwHqPE9b3am1r0Q+jJLgASIeYoXVo9KcmOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hoV6/o8ZYBGDmMH1nnHzbrMOO8NbmjA4UKayy28FSuFMK87thmN1VkULDcJhb1VtsbmxFIZx2SvTviJQ4vifln8kvpKxBNdVRrfIdTnjcD0TzaZdD2LpOnX9bRUi2xMbrDv9pDk29+brg2SRHlzv4Hg+M02xB52ALPsALcEMUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFIZs3W1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cba8340beso24034065e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727517933; x=1728122733; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0UkuD3GuJbEJOo86vgUIxaJ+Z37a87v7S3JRkIjSIg=;
        b=EFIZs3W1+t49WVMXmO0Qhi+izUpOTnAODaFO8STl6XOaV7aCALjiZ9/w2H0zRipd51
         YjUqKkmBY5z3xVDYudIcT2eBaZ6VWzTCsaWcqxvlRyIADJKdFD/V85R2kwTpleTIONnO
         /uKwuqyPOuDsr0QaOM+zssyB7SZFfA+9zZrvMAC3BqN4IreNvMzr8Ody6K1C/J0I81P7
         RYZotmAKzcs7x0QovjYNHHNuPzDHfGVLVxjSSYTH7P7XRIe0veGMwphX2i95S3F7JcJE
         rlRhiPGWnRg6vXbQIiAjQqpiMQyM3ALeVsSFvnWad2WdEjZQd9qUmNTn7/byaZANduhq
         YdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727517933; x=1728122733;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0UkuD3GuJbEJOo86vgUIxaJ+Z37a87v7S3JRkIjSIg=;
        b=VZEkfj3xA+N3LI/Sj4+QtWvGkf8yXSLo3oeM8/dTyy3A1uD8lV2XL67XRoreOAEHu/
         xrzY2wyzLenPYBsadFB1sSdtLArgzf3Lpfc8WeTd4Ld2iMewcJ0AqafCxEvB5ujrOnJs
         PDzUJE9qFL7XnLdOQh28D3irEnTElu7wKlvOiXEJRKIVkafibzqDC0SqRtQy33uyzVSe
         vAxm9WlWtkocvUM6hrAJlvb5tFzCqCGBjya+nD04yuUYIvw7tabX3nDTMRtsHdRsvJuS
         ZUK+r0nJL1aFcFu+DD2KysgbF+a2oBRaHJRvx4LpyJ+rjnJEolI1EAg86LTuH2F7TCqp
         kklQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdaTD/AbWs61q1ELCWTkkujPbYePucxXAgpdCYw/UV1+ZCxRZWJFBrkvbrwiSyyCB1XSaa9L/zCVA7n+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ3Jo8ErAZT08CvtEnafoXIbhyBm4xx4dzInGLKLY8uIPn/g2o
	tJfFbhVnFn2kPcV0SkZbNPh3JoZp/64u6YP/je6QnrskjaYVUWWGlh5tdy1BQTY=
X-Google-Smtp-Source: AGHT+IHAOnv7oc28ECrLbwz3MYtI2XlwEqYRbMn63MqyesZiRUO48orsjcjBjVWP4TAofwPjbOtNpQ==
X-Received: by 2002:a05:600c:1d08:b0:42c:b697:a62c with SMTP id 5b1f17b1804b1-42f521ce1a4mr63796565e9.5.1727517933542;
        Sat, 28 Sep 2024 03:05:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575e322sm4431080f8f.110.2024.09.28.03.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 03:05:33 -0700 (PDT)
Date: Sat, 28 Sep 2024 13:05:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adam Guerin <adam.guerin@intel.com>, qat-linux@intel.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] crypto: qat - (qat_4xxx) fix off by one in uof_get_name()
Message-ID: <cca43549-7715-44ba-a1c0-61dd027ed3b5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The fw_objs[] array has "num_objs" elements so the > needs to be >= to
prevent an out of bounds read.

Fixes: 10484c647af6 ("crypto: qat - refactor fw config logic for 4xxx")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 9fd7ec53b9f3..bbd92c017c28 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -334,7 +334,7 @@ static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
 	else
 		id = -EINVAL;
 
-	if (id < 0 || id > num_objs)
+	if (id < 0 || id >= num_objs)
 		return NULL;
 
 	return fw_objs[id];
-- 
2.45.2


