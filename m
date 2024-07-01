Return-Path: <linux-kernel+bounces-237084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C643491EAF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7691F2268F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059AB171064;
	Mon,  1 Jul 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoR+ETrT"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EE17BA1;
	Mon,  1 Jul 2024 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719873953; cv=none; b=L4OGARm+q8Gh+WRh+URPypBP8tw2q18f8X6xu7Wsn82LnoiiyCsFt6hFBG8pfSVivktTYzaMi9IvSPtHtRG2zIwCyn+HY8nQ8jjo/Pn8C8KZJLTxZqHXRc86/4pjwaHsf4X2COW2IYRdDeUJ4xpzDWB1FY0WZFb8w1tGbTNsr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719873953; c=relaxed/simple;
	bh=ufjEm8YoF5Op33vbJ09TdKfLOuic197HbSb/KsG6WD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnAorOfXY42arRhiuHlGYartc289HdzK6yf0niuLalimZK7vwnRvA5vg2Tp24DDJJHmmYp7QkUM4mbLHkEXaDb3+8Zt7DWVXbtgU9fj9j1h6sEpT8oJ61mLLXmclimeFBe7RIVKrSLelNTC4WnB8UFxf9eRU76f+eiNt6ZFC29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoR+ETrT; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so2388757a12.0;
        Mon, 01 Jul 2024 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719873951; x=1720478751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytilIlYGI6G0vsdwh8EYmpZox8Lx+hJDscML5QdmUfw=;
        b=FoR+ETrTrCBZW1V0ooicIBSWU9r63sCvjghH6JYYVwqkhvwYr9yS41e1f2qGaq4J8N
         7DJr4/R+adLM5FBKYdDBnXg6/NmGbbIZR3KoVY+t9N1f5N83YWfoVLqnyVY9pNn+rKQB
         hoshbxwPSzgwbdRSnbVbZuN9izSSeZgvp+IZDvIsScAwlTodPY/9fZt+PJLTlc95Rj7I
         1zub1wjSMgihRn2zajTgXvbwrBr7zyeRrmcF24y5c9Nbe+t9SH9jTOHRpMrcl0KNCiBh
         Yj92CPpTBj+96MrIZeZSwq8R0dMzd0bhdlGd0JDPoOarsSCLk7FEmoM0eQZWUAxnnLxn
         6Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719873951; x=1720478751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytilIlYGI6G0vsdwh8EYmpZox8Lx+hJDscML5QdmUfw=;
        b=WohY3bh63o8imXVBuQH7xwB2j2oAIWMzdpw3oC+lLzf0lYVW3M0T0kBoz7GOxDQYim
         mun2Z5E8qr2qT63ROK8QMMF2OjB46ewz1x69wtgbMXC2lTz0fgtJpzOmiG2lv/CPOyWG
         Py8k+RGTjbO4Yn7qmkyqc6wvEmh6mMUNcn5jE0KJHyUiFDddyZRWHJ4+w6H9AuENL8xt
         BJ9yWO1JTFDwL38NmyU89iVcvpCtXVZ+oiDXotYILZ9qN3pvPOtLVpEUjJkaEta4gPxO
         CHBFRxUTFU3iNaedzqtLLas1BDD5l8eAo06BpcjHb3DcaluUp1bA6As4sxkvqB/2iaW4
         iRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5+XZaN3N/rtGMLimkecwM/Le2REKTzpeq5hpjXyVl8mChkJUApsPEr47BwJZkGSZCmMdM9gtT08KESdjDwuDSXRi1726TeQFRdZH8tyNtNFQMuKrTI3lz9qq+4weQgifvcw/XPiE06GE=
X-Gm-Message-State: AOJu0YwmKKV5tcCcWfMVz2NUtgZiMf5UDm428mGIGzU+k/mjN19F8lur
	Il298VHPVeehvF2EBpBHEVAAaJ5+mJhTh+nGWeZ7cY5FUMcBfWBC
X-Google-Smtp-Source: AGHT+IGeS8lCW4viz7kTH1BTqyoltsuzGNlKEnhrJtxVzeeiGEWTrgq1RqLWtJq+2CQ12bx2NhxqOw==
X-Received: by 2002:a17:90b:a53:b0:2c7:8fac:48bf with SMTP id 98e67ed59e1d1-2c93d6e3bacmr5573407a91.2.1719873951113;
        Mon, 01 Jul 2024 15:45:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e8125sm7352521a91.48.2024.07.01.15.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 15:45:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 1 Jul 2024 15:45:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wayne Tung <chineweff@gmail.com>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adt7475) Fix default duty on fan is disabled
Message-ID: <6c91530f-00f3-44ed-ae77-312260c2af9e@roeck-us.net>
References: <20240701073252.317397-1-chineweff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701073252.317397-1-chineweff@gmail.com>

On Mon, Jul 01, 2024 at 03:32:52PM +0800, Wayne Tung wrote:
> According to the comments on fan is disabled, we change to manual mode
> and set the duty cycle to 0.
> For setting the duty cycle part, the register is wrong. Fix it.
> 
> Signed-off-by: Wayne Tung <chineweff@gmail.com>
> ---

Applied. 

Curious - how did you find that ? That bug existed since the driver was
introduced.

Thanks,
Guenter

>  drivers/hwmon/adt7475.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> index 4224ffb30483..ec3336804720 100644
> --- a/drivers/hwmon/adt7475.c
> +++ b/drivers/hwmon/adt7475.c
> @@ -1900,7 +1900,7 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
>  		data->pwm[CONTROL][index] &= ~0xE0;
>  		data->pwm[CONTROL][index] |= (7 << 5);
>  
> -		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
> +		i2c_smbus_write_byte_data(client, PWM_REG(index),
>  					  data->pwm[INPUT][index]);
>  
>  		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),

