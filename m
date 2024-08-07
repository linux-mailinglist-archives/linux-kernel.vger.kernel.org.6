Return-Path: <linux-kernel+bounces-278410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2A94AFEC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD218B21419
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948A140360;
	Wed,  7 Aug 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfdIJB4m"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE64653A;
	Wed,  7 Aug 2024 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055919; cv=none; b=PHj+mQ60Hwc4hGOzWUF4PxAzi+hwqQ0j20KGxtsivKlBWGJDg27deUrfwGR2hGA+mz+/Cht0Ri4HvaFSzz+TjfQvsHDa8oLKXjTBPcd843yHS/NJDu4xYTTYALjlOinNcHp2ioqMO6COEULepmwFzxbJGvund6n/MDz2W4++XNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055919; c=relaxed/simple;
	bh=Ma5knbmN34MSI03mkT7FloKBYCg2Csz7tEsOg/INh4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+LDguRkAi17u+QDzXsHUnAG6mn7WMEEDLpl/f/pz7KE488EBdX4CRfisGVcom4nZMMMBtcMk6r9VLZInogO2hlyK/Vcr0FDOv6jrZiClj8gzM9DdJhEyJMucXYooXO1HHUAJuyqEfMfgWiRgEIN3Ymc1UOWcRIru9ULHTwgGT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfdIJB4m; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso193896b3a.0;
        Wed, 07 Aug 2024 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723055917; x=1723660717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MHZu6Ag/9qKzgb4ZqxJhiR7NIGjVSmJ1XSyPMQ5cI10=;
        b=XfdIJB4mARtta+1PO8a2K09AZyIKonajQudNBxyTj7R1ERg//dOAV+VYppWWwkrY91
         ZWrY0yOeaxhAeCkDKtkhAtJMDg4nRU5qEIXCfOGRjEDtIG8pQchYv7cqN9dTZHZkXPex
         k515SuMkagSaDbdQJrkDbbA+wXLbbILrOs0AaKCq9Uo7Z0aypSEFEtrHDCtfl9khoPU3
         AfZTrDohGMYQ9/gn2Spi0UAPmNbg8Of9KNEgU4dbN5J3txKLypgxO/LNec6RmFiGJbT0
         flsDPDXsnS3Hazwv8QHuWNlgtboHjHHie4eCvBvPqaXS5las6y38nSLCUxnVJYx8QV4J
         +ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055917; x=1723660717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHZu6Ag/9qKzgb4ZqxJhiR7NIGjVSmJ1XSyPMQ5cI10=;
        b=AFFZS+ZLmfWT2y0i0aqdr83povFO01j+oNqeyQUUaYMPosUhSZ82rYcEU2xZRhKIVY
         FstapXyVOTiMfiq/l32H3TCQ2R6E33r8+tar1nL0y/XLwNvwo0SfO42DEUMv9tudaa0b
         nP0ehsuJsJamxlQrNIqkea5Xnhrfr72JtU6Nhz6Seus8HNTJaTk5OJIEE7oyHpAV72qN
         zVYPVe6144kbAQNTXkbATp27c4tNvLkqlJ80dNlcpVJqTh71jX62OO1o36I8I5utNa+P
         OX2gySfNPVahkKLA1Xy4Pigvr/7BTGypdd/Sj342n9V/XxXEpgxegL4vOioPdMpenGuY
         ISAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUebVlJYMuS9M2GGERRYQlHUgdT8uxr3ombQm50xYtZ28zmTPMUHSZsiSqG8ci4Ic6kZtv27Dcb9L2Mi/N+uYwOtteyk3PMSLQUZrJPyR7gyQEjiOXvVR8YQg287YoHPtncF5SmsukGohw=
X-Gm-Message-State: AOJu0YwgMBb07vdUEaAvr5hA8rNPDQs+IxrCo4Trf4fo/MtuYcio6EJ+
	kK+jfDPO2Z35+ZDUB4xwG5oLhmAn+15bow+3HzhYg6f36DkmUkQU
X-Google-Smtp-Source: AGHT+IE29lXDJY0DJgZzjwEH7h/3o7kLHX3laqmrwpTO+ckQzdByOSlQCUSu2Nellw3JaiKg102baA==
X-Received: by 2002:a05:6a20:d510:b0:1c0:bce5:c19c with SMTP id adf61e73a8af0-1c699579612mr23682342637.12.1723055917340;
        Wed, 07 Aug 2024 11:38:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec4292fsm8695485b3a.73.2024.08.07.11.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 11:38:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bdca4f35-ec3e-4fac-bbcf-ed5326feb6f4@roeck-us.net>
Date: Wed, 7 Aug 2024 11:38:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (lm93) Return error values on read failure
To: Abhishek Tamboli <abhishektamboli9@gmail.com>, jdelvare@suse.com
Cc: skhan@linuxfoundation.org, rbmarliere@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240807181746.508972-1-abhishektamboli9@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240807181746.508972-1-abhishektamboli9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 11:17, Abhishek Tamboli wrote:
> Fix the issue of lm93_read_byte() and lm93_read_word() return 0 on
> read failure after retries, which could be confused with valid data.
> 
> Address the TODO: what to return in case of error?
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>   drivers/hwmon/lm93.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> index be4853fad80f..b76f3c1c6297 100644
> --- a/drivers/hwmon/lm93.c
> +++ b/drivers/hwmon/lm93.c
> @@ -798,6 +798,7 @@ static unsigned LM93_ALARMS_FROM_REG(struct block1_t b1)
>   static u8 lm93_read_byte(struct i2c_client *client, u8 reg)

This is still returning an u8.

>   {
>   	int value, i;
> +	int ret;
>   
>   	/* retry in case of read errors */
>   	for (i = 1; i <= MAX_RETRIES; i++) {
> @@ -808,14 +809,14 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
>   			dev_warn(&client->dev,
>   				 "lm93: read byte data failed, address 0x%02x.\n",
>   				 reg);
> +			ret = value;
>   			mdelay(i + 3);
>   		}
>   
>   	}
>   
> -	/* <TODO> what to return in case of error? */
>   	dev_err(&client->dev, "lm93: All read byte retries failed!!\n");

Those messages only make sense if there is no error return.

> -	return 0;
> +	return ret;

This is pointless and actually dangerous unless the calling code actually checks
the return value and aborts on error.



>   }
>   
>   static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
> @@ -836,6 +837,7 @@ static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
>   static u16 lm93_read_word(struct i2c_client *client, u8 reg)
>   {
>   	int value, i;
> +	int ret;
>   
>   	/* retry in case of read errors */
>   	for (i = 1; i <= MAX_RETRIES; i++) {
> @@ -846,14 +848,14 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
>   			dev_warn(&client->dev,
>   				 "lm93: read word data failed, address 0x%02x.\n",
>   				 reg);
> +			ret = value;
>   			mdelay(i + 3);
>   		}
>   
>   	}
>   
> -	/* <TODO> what to return in case of error? */
>   	dev_err(&client->dev, "lm93: All read word retries failed!!\n");
> -	return 0;
> +	return ret;

Same as above.

Actually, your patch makes the problem worse because the errors are still ignored
and at the same time report more or less random values to the user (the error code
truncated to an unsigned 8 or 16 bit value).

Is this just a blind patch, submitted as kind of an exercise, or do you have an
actual use case for this driver ? The driver is in such bad shape that it should
be left alone unless someone actually needs it and is able to test any changes.
Otherwise changes like this just increase risk (or, rather, make it even worse)
without real benefit.

Thanks,
Guenter


