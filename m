Return-Path: <linux-kernel+bounces-320399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 233029709B3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D631F229F7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975D17A597;
	Sun,  8 Sep 2024 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0nDQ9/b"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41017839E
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725827174; cv=none; b=l7DgGO7gWvtECy80ms6PUcnF2PLuRYwRMkeJGTZwp93l/wCJHq6IWjJ6QdnAL73sbftZBQZXggkzWHy+4AjmMgNugz/4dZ+mnFKatwoywRnuVf8VlO+U93juERhb225llFqpGeloPp8okrJZ/uafGga4M0xpByIt2RLlgzYE8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725827174; c=relaxed/simple;
	bh=ZONi8oTVgdeLD7glO6pXuDk1u8cI1QYm/3E0oElhbP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVboCrHyl2fd9uZnqB3wqkc8GFjUMOBM2I2t8E2fP+Laj+HJQXWwANDzIHeH0kYAdhmY9pFECSOCiOlyvZcXNbDE3VaJWehsjwaWlek6uPu1z661nQr0mWH1thOICF3bri6xSHqB4HfSNNXwn4+vfBL7yKqbRI2BZ5I9Ixi7iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0nDQ9/b; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374ca65cafdso2245030f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 13:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725827171; x=1726431971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFgTZS6YaG4OZRC2cQbKF/8vq72Pq4HNgWz2U4ZCqEo=;
        b=d0nDQ9/bxvUMWpoGGRRQSabiNhQJmpH0h1lZLn7dMleNapoRy+37I/eoRBmxfbQxhY
         ik4Lq6HBDUWjIyCjkF80g+eamBVFPApOqfTJm7+xyTl02PQowCe+/Q0QDg8lbP5CCWbZ
         CVdIm7NnXt9CT37f4ftRr/I3jYstk4z7mL7g7dtT7ks3jTUHWSWLJ+qQxd/0Fyv/E7rR
         oEO3fBfrPJs759a0VgDyes/MjuAP+ut0F4FNev/E7UEcv47r4A01Nk49w6mSjtbBKhS5
         n/VB5zSotP+arehGvB8U5oqtk0qj+9WtMi869xZSfAlD7wBxdsRXjCsXlAobbCrNOndH
         GB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725827171; x=1726431971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFgTZS6YaG4OZRC2cQbKF/8vq72Pq4HNgWz2U4ZCqEo=;
        b=g+cBUm30K9jBzlhLBuNCIQWajQzh8mIQehSQiTPec/RLQ/SgnqDC2+3sd7ibauqq0L
         hOy43rVNGABAka2NeWSvTmVN0dNJiDbtrSskOIIL2jPVrUEJnQALaVdpmOQ8r9aYD/k0
         jahIwxbu/SnjzNYCALtPXgi3MuJsWNUtGVZTQoOjAbNDJcSjmn/U1KQac09puwg+WM7/
         k7RTdTs2gS5c98gTKwQBc5AhILWETs4wdJzrkXoieyQaOCgMKIJ3UFkhtoxfKYKHr4Jx
         DVuY+cvBiz9fUXzQZlO4V8loZnUY6UXDxn5Gs2S35Ei79oDRVPlwUuJcOaxPSgQuQTKD
         /89g==
X-Forwarded-Encrypted: i=1; AJvYcCVnommWre9BwmtiSthyt9+GeNMmuxRpao7OlBw3j1UJ685PuAxScY3slWFT3d6HvqA63c6k64KIBKVWzuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLkqDfn2eV3gZWpMVxraSKmGj69AR88HGKmHHKzpE9ulvZUVn
	M0RQJA2xPzVoVdGcCj2x0VuAyd1cSv40uvAZ1CxD9RwjSr3RETfK
X-Google-Smtp-Source: AGHT+IHVNtAxcHLeKntFo0w1vxjjPlBWpIVcqJJM9cZm+EOP8X5coWa622xs7sypcOql4/uV4QZ3uw==
X-Received: by 2002:a5d:5189:0:b0:374:c1de:7e64 with SMTP id ffacd0b85a97d-37894a53e29mr3416928f8f.42.1725827171022;
        Sun, 08 Sep 2024 13:26:11 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2a:8576:4416:5fef:fc17:c89e? (p200300c78f2a857644165feffc17c89e.dip0.t-ipconnect.de. [2003:c7:8f2a:8576:4416:5fef:fc17:c89e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cebcb2sm242997466b.153.2024.09.08.13.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 13:26:10 -0700 (PDT)
Message-ID: <4bc6cfea-ecf4-40ad-a3f6-c32bb411949a@gmail.com>
Date: Sun, 8 Sep 2024 22:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] staging: rtl8723bs: fix comment with a trailing */ on
 a separate line
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
 <20240908101110.1028931-5-sayyad.abid16@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240908101110.1028931-5-sayyad.abid16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 12:11, Sayyad Abid wrote:
> This patch fixes the trailing "*/" on a comment block.

Hi Sayyad,

important is to describe why this patch makes the code better. You 
described in the description just what you did. But that can be seen in 
the changed lines blow.

Thanks

Bye Philipp

> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
> 
> ---
>   drivers/staging/rtl8723bs/include/rtw_security.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
> index 4efa2d258ebf..1e5e7f52f8da 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> @@ -240,7 +240,8 @@ struct mic_data {
>   /* ===== start - public domain SHA256 implementation ===== */
>   
>   /* This is based on SHA256 implementation in LibTomCrypt that was released into
> - * public domain by Tom St Denis. */
> + * public domain by Tom St Denis.
> + */
>   
>   int omac1_aes_128(u8 *key, u8 *data, size_t data_len, u8 *mac);
>   void rtw_secmicsetkey(struct mic_data *pmicdata, u8 *key);


