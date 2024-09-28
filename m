Return-Path: <linux-kernel+bounces-342428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C494D988EF1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA59B21863
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12619F43D;
	Sat, 28 Sep 2024 10:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3HdzhXn"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E619E977
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727517947; cv=none; b=ny50Xf+K6WbDED/5YJ5FWEfqn9/ZV5uwKxggygBpaxT8yFeRF4zYwe6mtIuFLqbKnXFJsIbMKg+/M2P1/5pA7+ITAC93W+s8xHBvllEEcdP8/a0g+vQsvD/CunL+pacaLXbgvPOreXsXmzt/0wccbQh27UOMCTOvz3OgAuLvQSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727517947; c=relaxed/simple;
	bh=Fhj/2WAgRX6TZNq4s+b672pG6RSzJbtSTQ4lNixnLGY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qqekhVPlO5c/1uzOAfFDw1DpHJIvRE2jR5wCzwzNf5ck2RZIHYHsEhoMRqJmj7diOIgovSJVkoE5+7Z79TGokYfE4llHcL9EyhVhg+47/F8y+QRViF/c8pldjxT9blFC+DK95HnxQAY18LxKpwReJhMb+l58SNSZTZPQJthwUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3HdzhXn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so22256605e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 03:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727517944; x=1728122744; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFXnq8tjuGE++NF0IRFhg8u5PXx+L4dCmmjvPjHBwaI=;
        b=o3HdzhXnPH1LpR51MzYDBAiJA6/5cRm2VJR/v0v9YpbfHcaf6GES4L9riF64ru572b
         2lmmjUDWPxwnCZEnmu85tpo/RqFuCAaSacVyONl9evKLdHRoVePv3W/nP1NwrBaaFNms
         ghxXQfuTQiqKUySMbJRaKW13XzY3dT55VU5PQttiNJsKgp43Tqo7Hxoo0KECndUQARSH
         uty3cxnnanyT886dRCask47aVrONdQRItwj0C3jyHDlrDWCncSMdxAckPQHsLHzTV5RZ
         zOsJls1LNOKNQ2VY4zJYye6PttLoSx64abd3vsBjl6wHmbVljkH/Zsy/en1t3CIkZ4MO
         K+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727517944; x=1728122744;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFXnq8tjuGE++NF0IRFhg8u5PXx+L4dCmmjvPjHBwaI=;
        b=JbodmyKGmxI+F19mtl8G3tzU3ifvIQVHQqele1aJEPtRxEvwDH+ZBZaNgeq6pxsuac
         RsPR6mOhnFCVA7iuhdIx/6K2/LCQKsFyscTcFiQFwdfeXIUoH4jozGAeS7vKISemHqMa
         dw5qTvN8vIKlF0ZwxxPRfbw6CEa/+KxPlfaZbfZJDn06NUsVSban3utEQTTd3pisNAQK
         GHsSLpZZiBcbmCVp0x008TqsC0tnXstJ2F8Je0RxDeUnaJIsp2E6lNwG9BAB2M8zyNdT
         7eUwSEhDgTWcflxGsktGyZCC1/HKh/LPilN7RlIQq1k76jXOx6Iwp9W/SyRPBM47kzDj
         ytHg==
X-Forwarded-Encrypted: i=1; AJvYcCWw7TEimzS6jOPQHz74xHdREPtUKsK/j+B8rAcsZu6h6ML1dsIDsvdhC1JIc5gPpYDlSCQk+P/7Txzf+WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+6OSoAdsLfza9i2kuBCiIRzG7A/gM8Qf8/PywvG53oFhuJzkz
	uri9DnTlLejDqt/gPq318Mje+ZP5WY+TElHS6eYoidKHVDR5no95wtM94YIj5lAp4V5hlD8BgJB
	o
X-Google-Smtp-Source: AGHT+IHZBI2SeNYmPuzbzS4OIpWMwP4GQ7Yg15aONo1+6wQnhIL+THchIfM5hb67RF96jt8tGxyVRA==
X-Received: by 2002:a05:600c:4f8f:b0:426:6a53:e54f with SMTP id 5b1f17b1804b1-42f5849101emr43200315e9.33.1727517943974;
        Sat, 28 Sep 2024 03:05:43 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e90274aa0sm77268275e9.0.2024.09.28.03.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Sep 2024 03:05:43 -0700 (PDT)
Date: Sat, 28 Sep 2024 13:05:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jie Wang <jie.wang@intel.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
	Dong Xie <dong.xie@intel.com>, qat-linux@intel.com,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] crypto: qat - (qat_420xx) fix off by one in uof_get_name()
Message-ID: <796ecd7c-54ad-4bec-b748-3e156cc0a1aa@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This is called from uof_get_name_420xx() where "num_objs" is the
ARRAY_SIZE() of fw_objs[].  The > needs to be >= to prevent an out of
bounds access.

Fixes: fcf60f4bcf54 ("crypto: qat - add support for 420xx devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
index 78f0ea49254d..9faef33e54bd 100644
--- a/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_420xx/adf_420xx_hw_data.c
@@ -375,7 +375,7 @@ static const char *uof_get_name(struct adf_accel_dev *accel_dev, u32 obj_num,
 	else
 		id = -EINVAL;
 
-	if (id < 0 || id > num_objs)
+	if (id < 0 || id >= num_objs)
 		return NULL;
 
 	return fw_objs[id];
-- 
2.45.2


