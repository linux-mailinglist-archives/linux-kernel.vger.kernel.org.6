Return-Path: <linux-kernel+bounces-261236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E0193B48E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510371C239EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB10615E5BB;
	Wed, 24 Jul 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wP40oO2d"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1715CD41
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721837389; cv=none; b=PT9PLs/wF7+3GRC2wccZwcVhh5sjDckzbzE3IkzFuJnlfKPl1N885/4e1U8puhCn1P8aBZt27tzn8VyBOMTocmCXP/UwDgBMyBpqQ2lgsXiYaxtWXD4xyYcDs8TXMLSWcg9kiP8HFqYnt1j5W++FIkQFR6exazKJ/6Q1ftap9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721837389; c=relaxed/simple;
	bh=irBx30ZH81Fx6HQI9IkJBrgeBdvBm9pERG4FSMQxMC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UnCofS6hhsOME8uSLGWwV8XjT0dGoxHend5AuIekzQgAZyyS6Cix51K8Gu7Y4Yx55lXbJxD1eBFU6WaCLh40ldywhq82gab/B1YUoDzCg7NHEyQeBaldJ8PHaSnn/2SR64SzZeY4yfBBx1IatuWjUP848p1pyWbOkji2S8zaoJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wP40oO2d; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c791729c36so3765eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721837386; x=1722442186; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1PBLgIHK487Z50PNrv9ADUF0TlVhgZyaxmIow0sPp4=;
        b=wP40oO2dBS+rjR249dRQfWx3BLWseJVbRKHlmZDoZNNgA3PmgBDWGL0KPs5p3GMdIJ
         0JxTlp7O1RdTlyVqDaBaG4hlpVlmZPCvrFYDZCWBaF9kVlS/Y11y6dyRBmxWooIY/T3S
         uLDfNqMA6VME/yyhPNod3SGKn3jSGNU6VwtLNYHAy2Ipgtei6pnbqRl5aO9JFKmCjbzE
         oS4/Jom9JqXor9QpwyBG2EcMpNSNU5SoYSqrIu7/+Dot9NRLwZ/Z/NXIDdf3uFD89sjV
         FDr5wFd9oDQ36mp8fadEnPVMmc4ZwJme8Gh7rDTMPvmfHssN7XsysRq92PJa+Qm4D2Od
         suXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721837386; x=1722442186;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1PBLgIHK487Z50PNrv9ADUF0TlVhgZyaxmIow0sPp4=;
        b=rFWtrwZMWfZOnq+j4ZQ1W1X2ShNRSUq0qsGDeGdL47VAVBYOElUkK7RrJ8gFgTUGtq
         Ilmma1JSmAWat5M7MGsyqFJ0p09ZvAfpcB/Ny3hSk9jGMQGmFamarJsa060lpOOXuP6f
         DsTYZeH2FUixZOqKuwXobLVxq/eb5px27R8ido4bhoIdRDgd+wBeXAKdk9QHYDuR+NsZ
         Rmn9ZNPE/jyz4hgsI8c9P98tpFlHCKYKi7TGWx50Nahn2Vz4wTOonjkYPUhRaDLMkfGx
         m8fDvZ7kqzES+2x1aHKFyAbnM0DMeB5wgNyF6XOu8kjrXYDbRfJOv8VG3i7mXcoIDAi9
         GyPA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdzDA/l5EY36yapLZVklJdNVs7NzIu+wsofNAmZm9BXGGFETee4F4O4jAAOJOPK/VKSD/liF9NijatM0WaNpZ4O4lWEELJddBGr/l
X-Gm-Message-State: AOJu0YwsZMcSIFM6swVa2d8mXfVhCYI8cIBTUCyWDgzc6c7V+ozvT0e1
	2J6QpjgiyzF8nd8ttSTLPakTwxyEYdAv/VY9lBr4KdE186loiL+Q71dr3GyH9oMjhiT5l/T7opu
	Rps8=
X-Google-Smtp-Source: AGHT+IHFom7KvpfbYKrPK/1mGnzI+CArrRK1rhoQT2jftUr92K4IlDd8GEMZkPh8yOdOvyQOSkETJg==
X-Received: by 2002:a05:6820:200e:b0:5ba:f20c:3629 with SMTP id 006d021491bc7-5d5add05fd4mr387041eaf.4.1721837386161;
        Wed, 24 Jul 2024 09:09:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:23ae:46cb:84b6:1002])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d59f07e534sm364151eaf.43.2024.07.24.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:09:45 -0700 (PDT)
Date: Wed, 24 Jul 2024 11:09:43 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] crypto: iaa - Fix potential use after free bug
Message-ID: <e049271f-41f2-4d04-ac69-80186f2eecd9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The free_device_compression_mode(iaa_device, device_mode) function frees
"device_mode" but it iss passed to iaa_compression_modes[i]->free() a few
lines later resulting in a use after free.

The good news is that, so far as I can tell, nothing implements the
->free() function and the use after free happens in dead code.  But, with
this fix, when something does implement it, we'll be ready.  :)

Fixes: b190447e0fa3 ("crypto: iaa - Add compression mode management along with fixed mode")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index e810d286ee8c..237f87000070 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -495,10 +495,10 @@ static void remove_device_compression_modes(struct iaa_device *iaa_device)
 		if (!device_mode)
 			continue;
 
-		free_device_compression_mode(iaa_device, device_mode);
-		iaa_device->compression_modes[i] = NULL;
 		if (iaa_compression_modes[i]->free)
 			iaa_compression_modes[i]->free(device_mode);
+		free_device_compression_mode(iaa_device, device_mode);
+		iaa_device->compression_modes[i] = NULL;
 	}
 }
 
-- 
2.43.0


