Return-Path: <linux-kernel+bounces-211084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74111904CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2681C243C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12AF16B729;
	Wed, 12 Jun 2024 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="POSB4jy1"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B083D388
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178112; cv=none; b=RhtcD91uBJHYL/3e+vZumC5b0snV2HRwLvgVRqFaO//ZPBd6+/h5TgZ8Ya9aNAgy0Vp9tG9KI933+6SS4nsmKxb1Ns8ESBbdAhCwRP9MUT+e2aoZLiGdWsSHzf3mh2/W+g446vajIODyd8dRcmZtNb2ZSPqEwX+XeFub+FafuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178112; c=relaxed/simple;
	bh=pAxEN/pEpk/A/lKna5/aObh83KDjBFmnxO98DMHCy0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH7OVEa5MBZYtixLuohIpI1vShxoNxW1WNcSMghav3xckpNTFMdUxrDHYuN6ut7eHgro8QgW31HdRzb7dPmw7MPFeDMfg1EX2WRQH3u6nbjb4S1VCdS6F2yChe8DQNX/WirR5379eNfIH7uNWGke2esDiqWHw5pa11s/7d16ZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=POSB4jy1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso3909252e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718178109; x=1718782909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhUYOzKS7bxm8hVJN2VTT6LKZPnSimHnSUqc0btaeBA=;
        b=POSB4jy1r4teGlSaeE/AiZhXaA1U6E6LgSgQgDL22EsMbUon/dup+VJwIyo9Bx5S7g
         p1jkVxzqE5YSEg3j4gSp3fvhbwYq95z8tNREisAUTe5AEFl/y0sbQ+w/1X9y3wDJqogf
         84faBxl2QPBKDCGT3+rPUum/kwaAA6RVP/kvyxeMXNToaY8Og6+4dCSXXdbRCKOIpSa9
         TRxgtygdL2Ksim0GCBCjPmdYm974zbtVITfn+bQ/FFdQ/wnO41V64AzECg0vhuGRZ08E
         21vqY2fzNPeedTf4lCSjeX93wBEKBZvJjWKiIa8fi5B2cDz4WM57wwdKN99/m6TNGV/7
         PZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178109; x=1718782909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhUYOzKS7bxm8hVJN2VTT6LKZPnSimHnSUqc0btaeBA=;
        b=LzYW+rIYnASj3FoipCT3MnEj63NVbBH1Y+KG5pmonJxsDE1qrBZmR+2DpdZv7YrPm7
         hQnI6otDtB7C2FyH7kcIVqmQB+SxY7Q+OLAPXZ5dNmFJLYXn0x7OAl0nN5+MXzjclXbz
         ytEs3aMhNx7RI0+fphlfFtsVJLhCj3okU1a73LXJh+/RAwZnIC1emrgGWt4Qt0EABJwZ
         CCRBIVwEvip10gNDa1ob7xxd1C6KbbNRHue+nT8rfCsN80ikUCSCX6zBp1Z61cMoJdVW
         q+xsf8eUjtXrToxjiU17Q6OBjHwb1+MtkWk2i4r24YvX2tEe5eMEL897onprIdaQDdX5
         ARHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdLB2mynGVBr3McQNPxtEkfwdzUcgVcfmr4GIF5T19U2NbQXDvwL+D/r2SeZa5m87OdoiNVwiE32B8vCjvqIJGSU9DyGhs6ssL0dxP
X-Gm-Message-State: AOJu0YzP9C46VQQ7cDGPK8eZfUGTkWjadh2z+eyGF9OnX2/Jr4w0aOq/
	MOpWEMV17MkO1kxXVyqsGt97sUlRv5hXYTLNLGdMZT1vw/N+jf9iYbwdX5t1Si4=
X-Google-Smtp-Source: AGHT+IGiFcvWYgMfWy+TBCsBEXUzdu01h4MvSH5Q3a8uPRBVsPEg47UYCX3+/Peoq5J8+bdFWnv9ug==
X-Received: by 2002:ac2:46f6:0:b0:52c:84a2:6e0f with SMTP id 2adb3069b0e04-52c9a3c768fmr482466e87.15.1718178108521;
        Wed, 12 Jun 2024 00:41:48 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871f9068sm14413155e9.43.2024.06.12.00.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:41:48 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:41:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: "Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] misc: microchip: pci1xxxx: Fix return value of nvmem
 callbacks
Message-ID: <ddfd1887-87b4-4cbb-9f6a-765e50986105@moroto.mountain>
References: <20240612070031.1215558-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612070031.1215558-1-joychakr@google.com>

On Wed, Jun 12, 2024 at 07:00:30AM +0000, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> Currently pci1xxxx_otp_read()/pci1xxxx_otp_write() and
> pci1xxxx_eeprom_read()/pci1xxxx_eeprom_write() return the number of
> bytes read/written on success.
> Fix to return 0 on success.
> 
> Fixes: 9ab5465349c0 ("misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX EEPROM via NVMEM sysfs")
> Fixes: 0969001569e4 ("misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX OTP via NVMEM sysfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


