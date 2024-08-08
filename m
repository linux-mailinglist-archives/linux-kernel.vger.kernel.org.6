Return-Path: <linux-kernel+bounces-278805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B440294B510
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1672816C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D7D530;
	Thu,  8 Aug 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIK/q8UU"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189BC2E3;
	Thu,  8 Aug 2024 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084145; cv=none; b=Sqo/BsgvBPilTHQVBILHf3GAEW4DyfHWYZGk6VkE4DH/kz38fEgukzvJMKLN9YYtuxOR2uEHaXSMBQ6MQQFl66zEvNcGu905m0chjRqds+uuuizbvXXO2ZYZqOT8nVTMecgJtEfUu68pgjtGLBY5cuCCTjsLHNYhxHXzGKh0Xaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084145; c=relaxed/simple;
	bh=M5odKgRdiYB4QiClc+4B0qhQc9NLJddk0d001KyKyEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iu80A8U/ITu4lqcth4gDwJ5/k3PeVFYwGyTzw87US/qyLEW6L3ETysfGNO+eKi/xWMoNF0Wc0h1p5BSWp8eVsyfDmhy6pxQOI2wUx72gDoH4u3N20qmEDWF0ODsJkI31N0052Tj+qzH6EFZUbv3LBqrFmgZDpBn4GQhzstQGz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIK/q8UU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso484587b3a.0;
        Wed, 07 Aug 2024 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723084143; x=1723688943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ONR16OLsmnYFIi37edT6X8si5tDO2pD3UYRS4yUxjjA=;
        b=EIK/q8UUYmufd+jOnfXfvY3B37tx0u8OOX8ik9m8NC4AdMFzagGyi01YAkMBx2FWQh
         +44fqyqteTlPRdjo0DXcE85ICxcppftrKKFOE83B2CYpTK8Yf383wfe3akeYaNfpPG/r
         79gTYyh8B9SIQq9eSZu6ySwxWKxU2f7j2qv4W69VLlGUUvwI7dtLHfOBirHT4NID6p0n
         BQRn2UHmmgikMDwyYp7pXW7PGk+FWtiqLq7Wv7f/r8a04JxBMuetJAlyhg4TmMOQE2He
         MUcLPz+OOWQNAEB6HV1KixhJ10MhxKEqMQ1tvY0gulTXas6zneg9uphmgUosS0sqKIIP
         /sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723084143; x=1723688943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONR16OLsmnYFIi37edT6X8si5tDO2pD3UYRS4yUxjjA=;
        b=ERyUicljTOoLT9sbhcLNiQWILxPR4jQYRQ68ithmxTeojLg0wo7ApYZTD/0NGTrSEK
         1QjkuTwORiYmEVDwFpS2NYkQvU7IjtPP17eiJ7BOGiohCHELEdNgikwiNJPfTNJ4Lrr7
         Qql4gIe1kemwxcYnmokjeQ9Jldorxs6oRnkdAqmbe8+WbDPu4vRZvwklc4YLMviqnryg
         52fjkkgW6rz8tnws4ywQ37UObnT8ZBUs8l5vcIqKlDDKb79H9SAZ9aHiJRy3Zc5TfdIX
         u/77Xl0LStrYLcz4Hqv3gjSzC9e3j2hPBBNPKdN8oqPZN4gFk3MRdEExdApMWrxc0S9O
         plQA==
X-Forwarded-Encrypted: i=1; AJvYcCWexMLTt1ujomLLsCgRvRbsxayHJQz+z+ShEdPZFNHWNrnfE82193gF44I2CD28YhP0852E+1D0a5SMRw==@vger.kernel.org, AJvYcCXl1lLlJokbImt0m9FbCyotXNzaKqgmT4P3q6QJBEkWNRiH9mfJordscSJ+A7Dgt0HP4ybNvkqiHpeVKP4R@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRDXVPocI7s2/utvfZXRAF0NinUDOSTjA9m6B6sNiDWQUcPYY
	waFI3gb8UcDdr/rmLaA7YD5t1zbfjM5nRl536kJNg+FDijGy4Bzwxk6bjNtc
X-Google-Smtp-Source: AGHT+IGMm3IMUSPrMpyI6bchgrNHCd66zaz2jzidMWRtIQWMFwDhn+AfcBMRBpyOLC/xs9rCK1G1jg==
X-Received: by 2002:a05:6a00:1249:b0:705:a13b:e740 with SMTP id d2e1a72fcca58-710cae20b3bmr734926b3a.19.1723084143114;
        Wed, 07 Aug 2024 19:29:03 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([110.225.178.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2d3544sm177193b3a.115.2024.08.07.19.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:29:02 -0700 (PDT)
Date: Thu, 8 Aug 2024 07:46:36 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (lm93) Return error values on read failure
Message-ID: <ZrQqhOvt3zCHNh38@embed-PC.myguest.virtualbox.org>
References: <20240807181746.508972-1-abhishektamboli9@gmail.com>
 <bdca4f35-ec3e-4fac-bbcf-ed5326feb6f4@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdca4f35-ec3e-4fac-bbcf-ed5326feb6f4@roeck-us.net>

On Wed, Aug 07, 2024 at 11:38:34AM -0700, Guenter Roeck wrote:
Hi Guenter,
Thank you for your feedback.
> On 8/7/24 11:17, Abhishek Tamboli wrote:
> > Fix the issue of lm93_read_byte() and lm93_read_word() return 0 on
> > read failure after retries, which could be confused with valid data.
> > 
> > Address the TODO: what to return in case of error?
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> > ---
> >   drivers/hwmon/lm93.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
> > index be4853fad80f..b76f3c1c6297 100644
> > --- a/drivers/hwmon/lm93.c
> > +++ b/drivers/hwmon/lm93.c
> > @@ -798,6 +798,7 @@ static unsigned LM93_ALARMS_FROM_REG(struct block1_t b1)
> >   static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
> 
> This is still returning an u8.
My interpretation of the TODO was to address the error condition while keeping the 
existing logic of the driver intact. I understand that this driver is 
old and that changes should be approached with caution.
> >   {
> >   	int value, i;
> > +	int ret;
> >   	/* retry in case of read errors */
> >   	for (i = 1; i <= MAX_RETRIES; i++) {
> > @@ -808,14 +809,14 @@ static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
> >   			dev_warn(&client->dev,
> >   				 "lm93: read byte data failed, address 0x%02x.\n",
> >   				 reg);
> > +			ret = value;
> >   			mdelay(i + 3);
> >   		}
> >   	}
> > -	/* <TODO> what to return in case of error? */
> >   	dev_err(&client->dev, "lm93: All read byte retries failed!!\n");
> 
> Those messages only make sense if there is no error return.
> 
> > -	return 0;
> > +	return ret;
> 
> This is pointless and actually dangerous unless the calling code actually checks
> the return value and aborts on error.
> 
> 
> 
> >   }
> >   static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
> > @@ -836,6 +837,7 @@ static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
> >   static u16 lm93_read_word(struct i2c_client *client, u8 reg)
> >   {
> >   	int value, i;
> > +	int ret;
> >   	/* retry in case of read errors */
> >   	for (i = 1; i <= MAX_RETRIES; i++) {
> > @@ -846,14 +848,14 @@ static u16 lm93_read_word(struct i2c_client *client, u8 reg)
> >   			dev_warn(&client->dev,
> >   				 "lm93: read word data failed, address 0x%02x.\n",
> >   				 reg);
> > +			ret = value;
> >   			mdelay(i + 3);
> >   		}
> >   	}
> > -	/* <TODO> what to return in case of error? */
> >   	dev_err(&client->dev, "lm93: All read word retries failed!!\n");
> > -	return 0;
> > +	return ret;
> 
> Same as above.
> 
> Actually, your patch makes the problem worse because the errors are still ignored
> and at the same time report more or less random values to the user (the error code
> truncated to an unsigned 8 or 16 bit value).
> 
> Is this just a blind patch, submitted as kind of an exercise, or do you have an
> actual use case for this driver ? 
This was not intended as a blind exercise. I aimed to make a meaningful improvement.
>The driver is in such bad shape that it should
> be left alone unless someone actually needs it and is able to test any changes.
> Otherwise changes like this just increase risk (or, rather, make it even worse)
> without real benefit.
I’m relatively new to kernel development, and I appreciate your insights on how this 
patch may have introduced additional issues rather than resolving the problem. 

I'll take your comments into account and Thank you for pointing out the mistakes.

Regards,
Abhishek

