Return-Path: <linux-kernel+bounces-213784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72583907A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DAA1C24E52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3C14A4F1;
	Thu, 13 Jun 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLqjHO4g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006714A0B5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718301452; cv=none; b=s0mMbwlwQn78/Zwhu1VqH98WBQrjU7e5VbP62TAKDha2n6oUT8c4z7pVhdizh8MxMEZWUhhZFdgwH9fzVSrA6PhnwqLA5OY7XTgmK2MowYrJ5iC0nhhD6HZ9o9z7kPSs71TnTXhaktSYPBn3V5xSnVOFR1tKxnCyZRi2nuwrdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718301452; c=relaxed/simple;
	bh=PFLKk3aAXryZqidWEktEk8zeN02Uccm+5JDsOAo/nLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lON8G/DCFmsRqM7BC8UE+mg02f98zr4jf8BIIiV+odXr/vw6f/urlod82x28qCCm4SZAkGiweCqeRhGq9c7msvllBnxSOcNu1o9pHYGgYgC5CeKLEfL/sdlL6Z83KW5juKbYjrcWZfdPbe+D0XppccTg61AiqVrn+wuJv8UoKwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LLqjHO4g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so11520615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718301449; x=1718906249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+B9ceKkRX5FEf0SPWBJ9Zmo8cBJbU6FE3P/v7gIVhp8=;
        b=LLqjHO4gsUKaiBqD8azoTOQ5qgpfFQxQWYUbyxePvOfr9w1JtXxiUpVEF76Mi2Py+a
         morDNgAvWpC2xGWrKYdewHpif50h3P8zHevi0jmP7cgYJBnirGUQP2eORLfpkHdg/UL9
         ootPZ02HY3xo0OrcgQtssyGEEer6uaVeg+/MlpWPzem5BNAA8lVrxcosEgbDFWNHoIEv
         z2ePWfahYiy6Xwf/DbvHFF6zZDR7emDBQDRfmjbiVOacCd2CCG6iW7u0VUJu1Pl38zhh
         px49xm9so6FNdXmwz6awAm8V1+UmetYMl3JboXwCt3GgydnOMnmeh7B7hqi07mFmakcE
         +9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718301449; x=1718906249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B9ceKkRX5FEf0SPWBJ9Zmo8cBJbU6FE3P/v7gIVhp8=;
        b=UyF8nN1T2aeyC4wB5R3rhOFb77/ZtINCI+588kcIgAddL8lGN+QzwE5681/lal5hZq
         f7vGB2j++Uyl0YZT/QbkDQ0S3tWpTofTL5FBcHp50zAEQ3ps1IhrOyQErRPacZOOGBkZ
         1j47rTNMOlHzAURqQAMztUPh48LgjUGdfw4wQcX4y/XPIWgPcOGjbBVDCsztv20UB7sR
         QYX1esFMc7AsZlPT+Ww2nifX79KKdm0E2ZorZafEJAdaAAvVVS6GtpR1h5CBHSPY/rnE
         a0O4/u9uZlGP0e1vFJpbqQFNhRLCS+lqX9foBXv2w5uZE4UmxPGX/ziV3mTnUZelBn44
         nO+A==
X-Forwarded-Encrypted: i=1; AJvYcCWDJEnUeMGqx0hFe2QDTgd1G/LdK0iuRRjT+nzLqAZQ0jW4tqg22Yuix1f1Z1Yf9a5gOamve2zxnhVtFQZkbOO18g5SA/Oy7k8TtIx9
X-Gm-Message-State: AOJu0Yxf1B+uSr9/KAeGT4oCV/eLS90F1xNZms8a83fsQ7LyruWUl2N9
	7rmoG3EbAL7Qi5ZZ8NImDV7uy/1N/nH9ISdLHCRKJNgqQA07U/GHBWt1fwDBQiM=
X-Google-Smtp-Source: AGHT+IE6dgQXoYKU9RX6h04lt2PS4y9WATyRcs6QPDW9qkl2jxho7el+sGWFqPjFFz9XqCP563H2xg==
X-Received: by 2002:a05:600c:5118:b0:421:7df5:656a with SMTP id 5b1f17b1804b1-42304825bc5mr3919925e9.18.1718301449100;
        Thu, 13 Jun 2024 10:57:29 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de62fsm70837495e9.38.2024.06.13.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 10:57:28 -0700 (PDT)
Date: Thu, 13 Jun 2024 20:57:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ben Walsh <ben@jubnut.com>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Fix error code in
 cros_ec_lpc_mec_read_bytes()
Message-ID: <3226cba0-82c5-47a3-89da-01ffa935a9dc@moroto.mountain>
References: <e0b43fb5-ecc8-4fb4-9b76-c06dea8cc4c4@moroto.mountain>
 <87sexgrdk4.fsf@jubnut.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sexgrdk4.fsf@jubnut.com>

On Thu, Jun 13, 2024 at 05:51:39PM +0100, Ben Walsh wrote:
> 
> Thanks for fixing this! Unfortunately `in_range` returns -EINVAL if
> length == 0 (see the definition of `fwk_ec_lpc_mec_in_range`). I'm sure
> this broke something in my testing, but I can't find what it was now.

I don't think fwk_ec_lpc_mec_in_range() is upstream.  This email is the
only reference I can find to it on the internet.

> 
> My original suggestion was to add a test for "length == 0" before the
> "in_range" test, then do the test as you have done. But we decided to
> defer this to a later, separate patch.
> 
> There's also a similar "in_range" test in `fwk_ec_lpc_mec_write_bytes`.
> 
> We could:
> 
>   1. Revert this and change the `data & EC_LPC_STATUS_BUSY_MASK` to
>   `res & EC_LPC_STATUS_BUSY_MASK`. This is the same logic as before the
>   negative error code change.
> 
>   or 2. Put in a check for length == 0.
> 
>   or 3. Change the logic in `fwk_ec_lpc_mec_in_range`. Although I'm not
>   sure what the correct answer is to "zero length is in range?"
> 
> I prefer option 2. What do you think?

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index dfad934e65ca..9bf74656164f 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -94,7 +94,7 @@ static void cros_ec_lpc_mec_emi_write_address(u16 addr,
 int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
 {
 	if (length == 0)
-		return -EINVAL;
+		return 0;
 
 	if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
 		return -EINVAL;

But I don't like how subtle that is.  Probably adding a check for
for if (length == 0) to the  to cros_ec_lpc_mec_read_bytes() seems
like the best option.  I guess option 2 is the best option.

So far as I can see this is the only caller which passes "length == 0"
is in cros_ec_cmd_xfer_lpc().

        /* Read response and update checksum */
        ret = cros_ec_lpc_ops.read(EC_LPC_ADDR_HOST_PARAM, args.data_size,
                                                           ^^^^^^^^^^^^^^^
                                   msg->data);

regards,
dan carpenter



