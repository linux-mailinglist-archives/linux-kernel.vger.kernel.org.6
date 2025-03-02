Return-Path: <linux-kernel+bounces-540671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F991A4B392
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C51E3AA8CE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7801EB195;
	Sun,  2 Mar 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biZXxSik"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6D111AD;
	Sun,  2 Mar 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740934532; cv=none; b=XYMlcUr+jJ8jf6Jk1MhmAZENf0XgxDKS/qdrZtU3pXn3GETX4Mpg7qe42dv7egzqi1mtFMLpG9WI0HWZWNhpzczsVpJ12hykDNLWNpmzpec80cgihY37o9I04buWwlQ8E052wprilW3st4K5zqVYxqLhYjkRNaOTY26vLXzUAtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740934532; c=relaxed/simple;
	bh=Ls/rpZuCyqqWDk2PpTIfMMqrhIRRyngTtHe2Gg9FGtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3IM/SqMG56RMDkuUJZAip33rrQJ3En2QAEA4tsrWx8laD2DiZGqQ+qT2tewjvfhALx4XGvIiJy3aajn3m8FoU9IwqlSDmf8HxQzG7sRPZw19CtW+INYgT5oHCraZj0sugd7n4QldKm3m/mPdLPCxgvNlJrkWDfWVMFlFfT+/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biZXxSik; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223378e2b0dso51823365ad.0;
        Sun, 02 Mar 2025 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740934530; x=1741539330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNhRIRChntze82/L4ktasbBRAu7Ns3w1vjLsBJ7Qi7A=;
        b=biZXxSikksVlOu+zhZ9sSWDBXuuyv9uGaGbGyX8pgovZkssb3uOTZa26Skmbv4zXft
         AZQ91HwTABNgRlptqQ1nnQBlhWbLP7fojrRsYfieX4aRX84B7fSVNutRmzriySF1PZqp
         xStRCFUlNyte5ZhFZGaiH/Eoaqb3oSiAldwt/JTXL3lAogF8uyub2P0a/oFjv3BmM+OY
         Q2ToWZZSHiof74yMuFo+Q2SHt5zSV0/kM7NX/oysfYm8CCWmWaJ/Qe5D8BMq9VKWgmXD
         Hnf9KiLsz5IeHEXzkomdxRqvRyCTIMTPs/J5y33FAb3+sKVw5Ki94ThTGJcYyDRRxIb4
         66rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740934530; x=1741539330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNhRIRChntze82/L4ktasbBRAu7Ns3w1vjLsBJ7Qi7A=;
        b=IWRI6mDKG10ToeWpl4pL3ubMkD9JR+i4licMhUs8rwD4gHn0Bx+KmKATGqj7pjdxo+
         NJmlClkLp4KjRzSx7IEXf1C97SsOx7ntUqc6XkBbX3OZPpcZdu2xH2n/rNKyMwhl3UUe
         iL+G03SmcBZXTJOy7xyELbImnNRye5Ui0M8iamVW1iFrM+kKgGKl2u1k7erRn8bcaT3S
         OecpywM9v5LTwhX+EjjePRoNCPMoVvMWtG3V2hPRx19Zjuo54zAaj2Uo7RWDxPkHHCC8
         ZSoG2CXOjse0+hc2BgX2kiF5memzTebZ37Zpe7qyU20dtUZR8LxGPdzfQgGl5pTdbt/o
         BPkg==
X-Forwarded-Encrypted: i=1; AJvYcCUco7PbqzX8Ehz7kF+Mn8gp1Ax5jQ248yok6mfYopn/sBubMDIaAuTTb1iT1fSCXT4/nYVKuYkk030ViJc=@vger.kernel.org, AJvYcCXPdmksCOTK8hLPHpEBCxvZen4ntRSSusEALSKvG18D/8MI8PgJEkEvhLnryTkrxyaYi+mbDDKt0JPcYTU3@vger.kernel.org, AJvYcCXfqb/BeQMOdiHjIGsftawRjqNrEtHaQUKsS5nG3zUh826Kwm3vrUJdXaZvO48l7mgPOL6kjV7qZS9S@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWiQl0u/Hp9gG2McZN79t7lbzkq5LophCFALTgKRHf8NqRrv5
	GqVKCf/XE6HklwnbSjpR+a5vds0hARSOgSL/ZWHh7ZpBflN2JvYajYlSkg==
X-Gm-Gg: ASbGncunVGqH0dXIaWKZyOX5E4EqYs8OJRXluo4mJUghWj6Sm7Hrq3yxQ745khOQNqV
	YWAZzBi6f+y2YI9wEkP2Sl7sspvCUZO7LdCKldbT6RZLPGrFPEuVfqMkOoiwrPVhuwvUXa4+67+
	TSGylPslARrywycIiJClvoJrxvpanXKhDNmuWZFRjXujkHl/KPGRQb5yHtJM0jPTNHvsjpUH9Pp
	ErYUUbA5WgE9XaweSMq077rodotaV3G7OKVAuSJHwUw0mD5G4CiDXFNPqSwybud6UeDeu0DJGbB
	wvdVWRU7Dk7Fap9MiszM837UMjTBJXFodijTUN4yxKwgihx3iO+FLEl41A==
X-Google-Smtp-Source: AGHT+IFFo1wG9lJxaIlR0ENetrO1ZrsYddgIGAvX1cZgJb5zhAAIMhfG8hI+9sd/l8gFDPF3BtaXiA==
X-Received: by 2002:a05:6a00:8d2:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-73650d1ff4cmr1660775b3a.21.1740934530173;
        Sun, 02 Mar 2025 08:55:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2b322sm7414594b3a.14.2025.03.02.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:55:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Mar 2025 08:55:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (gpio-fan) Remove unnecessary comment
Message-ID: <124ddf04-f9f9-478d-8bb7-0148a464af79@roeck-us.net>
References: <20250210145934.761280-1-alexander.stein@ew.tq-group.com>
 <20250210145934.761280-5-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210145934.761280-5-alexander.stein@ew.tq-group.com>

On Mon, Feb 10, 2025 at 03:59:32PM +0100, Alexander Stein wrote:
> __set_fan_ctrl() is only called by set_fan_speed(), which ensures
> fan_data->lock is held already.
> 

The comment is still valid, and it does not hurt to have it.

Guenter

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/hwmon/gpio-fan.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index 322b161d5ca1f..4614d0ad86b3a 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -100,7 +100,6 @@ static int fan_alarm_init(struct gpio_fan_data *fan_data)
>   * Control GPIOs.
>   */
>  
> -/* Must be called with fan_data->lock held, except during initialization. */
>  static void __set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_val)
>  {
>  	int i;

