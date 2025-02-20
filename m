Return-Path: <linux-kernel+bounces-524816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7FCA3E779
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B7BE7A9932
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23721323F;
	Thu, 20 Feb 2025 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWske4AI"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D951B6D06;
	Thu, 20 Feb 2025 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090154; cv=none; b=HJ8sXfYz8aWIKBnCBKyBPypCBcF2Xp5fdzF+XaLEVIGiAfey5MSiAMPJmxWG2CORPpzXpCud+wA0arj9eIlhjdaMXgbVWJjakkGO7l/t9BQocQKWa16KD51ZRDIU9NRRmPmfCvBwGdMd0vnqmVjz2vYVeb2GZm+YDHGxJSDPyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090154; c=relaxed/simple;
	bh=6B6FSe6DVN2MTY/rJvHuvje8ZU3R38sOomVuhIvff6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0ceS7FCvZ0iOKrNakRdl51NV6ji+Ewd0ewWRwnImoAUhu2LTesmwC5COGKJYxzCJ9cFvWH7O43Bzzm5EoiA7/8NkAPa46A1cn63pAO6+6/4BU0GDR5LzMUNbC/ZLI5zcQJQW1u8b8HlToVogiFD2Y9eElY87Kxpik+e2pMGDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWske4AI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22100006bc8so26404205ad.0;
        Thu, 20 Feb 2025 14:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740090151; x=1740694951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCWwZcYXXjRdf892WSGghwBWWZu0cLbILy6CcELDbs4=;
        b=HWske4AIW14ihq6H00FqUxIo9KDb1sGpkxFzZuSUWgq9NBPGXZ+ooEpsWFa9m9dhj0
         xWMao6oOhK/A03bsfaXzgUaGsMRgcrKh1rCORI4FC54mgjVq6WInKv1bqw7Sui2906FB
         3bjDVHV+BPcmbCUkxbEspDosgfdM+YXmmzrRiOQVTVX58QKWV8WurnUU4oWxm3jSQvKJ
         AzMPRCI3C4UiyZbueUZPE7Z3zHsbfg9sPRQX2TNhI0QHDe6HkTSxBYoRtH71fGEXZaR2
         0CuiLbfkxrtukoNVyoOrMn8qEMYR6pC2Agw4Ht2OoD1VHREjGJ9cgiO39UmPYRijoBoK
         va6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090151; x=1740694951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCWwZcYXXjRdf892WSGghwBWWZu0cLbILy6CcELDbs4=;
        b=PcAyV1SKANuJuYgH5DA2LF/Fd/g+VwVJhvPgM36ze89JvvEpNVQr7tvlMb9YV1LSWQ
         4OKZjRIDBZoij7JjQwR2KByAtwK46v0jBZ9r+8DaXVKnupwq+6uNuW0qMNKPDT7QSF3v
         duOYA7RWN+/3gxl0N68sr77MFCP0H+AZvEL5a7PTuE3bshBEutx3JPSk7iYGY+bUufU2
         ZAW9Jlw5Wx4jIkc0WmEZI0oeOP9dWgHzWqdQHqI3IpVbnBHqmJ+xU7JKC+BPF1d1ae3Q
         XTUt9Sg8pwEMFNw7B0ZJmmy0Ejshi2dz2FZqDJqRB9MCVVlZR2dCiZRt0MOWOwMSzpv2
         Ow8g==
X-Forwarded-Encrypted: i=1; AJvYcCW6ZGqdsHsF7FbmpBCw+zQ0ZYUDhUTK8v3WK9qPhEE6DVw6W+tXSncz7uLu+97B76DPVvF+ic8KK14otHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw09xOCpdIgmyXIwMa3KSn26T3CvyOkgevQs2S4s9lv+kdRhm9F
	EMtuKigacVov8ESe7FDnGyYdDulJxpuEAHMuDKGXdJGKId5meaRJ
X-Gm-Gg: ASbGncuPNcHQGQUzhaezv85KCEoncPkg/yj+Fee9F+gCWWlZGL7WHzd7Jb2tyU/nAxc
	KY5VvXKwyPNyJ+hBVOLzawrjsWlNhYuH1ZXQ2z/Fy+76adWC6kY0wplrej7WUkJhYdkLbPA2blK
	mIump4KpUMyGP7fi8OQ1fD+F61VvrLjGhKazlFFVvZxE3sHKwOBZTVCIWoEiXiOARiDyYQm1Ylu
	PwDuaUmfYD6dX/tXXPIfjui5kC/t3lUzY4HRU09XcIHPqLIDhiekICcvfeC8pvH3xgkeMc1prHI
	4GOO4WfTW9Bsw8981xc0gXKSWkSQ
X-Google-Smtp-Source: AGHT+IGbrsZ4qyaDOjAYUhu53Fftt4vkYb/8xMjeKDsR6ODk3APmHP8kKAFjDw4BXXNFWtdq78JDKg==
X-Received: by 2002:a05:6a21:6e91:b0:1ee:d0f4:d14c with SMTP id adf61e73a8af0-1eef3c894e4mr1669416637.15.1740090151276;
        Thu, 20 Feb 2025 14:22:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732532ce7f1sm12397577b3a.73.2025.02.20.14.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 14:22:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 20 Feb 2025 14:22:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Erik Schumacher <erik.schumacher@iris-sensing.com>
Cc: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jdelvare@suse.com" <jdelvare@suse.com>
Subject: Re: [PATCH] hwmon: (ad7314) Validate leading zero bit and return
 error
Message-ID: <7f299e75-a4c5-45c8-a755-e0365f8c7e2e@roeck-us.net>
References: <c54ef4dd7b562268768200239b00441a74b547c3.camel@iris-sensing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c54ef4dd7b562268768200239b00441a74b547c3.camel@iris-sensing.com>

On Thu, Feb 20, 2025 at 10:18:17AM +0000, Erik Schumacher wrote:
> A leading zero bit is sent on the bus before the temperature value is
> transmitted. If this bit is high, the connection might be unstable or it
> could mean that no AD7314 (or compatible) is connected on the bus.
> Return -ENXIO in that case.
> 
> Signed-off-by: Erik Schumacher <erik.schumacher@iris-sensing.com>
> ---
>  drivers/hwmon/ad7314.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
> index 7802bbf5f958..025846f1f18b 100644
> --- a/drivers/hwmon/ad7314.c
> +++ b/drivers/hwmon/ad7314.c
> @@ -65,6 +65,10 @@ static ssize_t ad7314_temperature_show(struct device *dev,
>  		return ret;
>  	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
>  	case ad7314:
> +		if (ret & BIT(15)) {
> +			/* Invalid read-out, leading zero bit is missing */
> +			return -ENXIO;

ENXIO = No such device or address

We don't know if that is the case. -EIO seems more appropriate.

Also, AD7301 and AD7302 transmit two leading zeros. If we make this change
for one of the chips supported by the driver, we should make it for all
chips.

Thanks,
Guenter

