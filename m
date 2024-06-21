Return-Path: <linux-kernel+bounces-224971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F991294E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF1B1C26558
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9706F2F0;
	Fri, 21 Jun 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwfGKdxI"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF728DB3;
	Fri, 21 Jun 2024 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983154; cv=none; b=ASNJ4sa5kh2GAE25Bozu+Jj9gIhL4jciYCKivme6T9+t92bSnmGDddOGEL4Dkt8nU792ZA5j+MvayPQrtG0H9L5LXuQTE/hPu1PP7Iqpg+51dhlOkXpef8UXE9D4rKq/emPHH3UR7c+2+SQWV583ysDwcVZPa3cnLY17XTggAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983154; c=relaxed/simple;
	bh=A5p+moRk0R9liIKtFtn2PGNkd8z9yeHkYGV/CCjCva4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2Kucgct1iu2CrJyCW/GGRvFFkzA39r6VjdDNczMI/Z4SZ+H8vKOVLd+30bzl6eCt+DD36dZ9kWkQAuADjedlAo43AKHYzDm0UjMdXyzQa+ZggTRdGoraAMLe9mXgwFjThtDHkGeiT2wSQ3MxA28tzEQdUBTOOHno7q9Vbu7gQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwfGKdxI; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7163489149eso854434a12.1;
        Fri, 21 Jun 2024 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718983152; x=1719587952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjxvv/dXpoLtAAeIGzsy9ReaW7NrPJCCE9CeS4zb3TA=;
        b=TwfGKdxIcXWBrwWJqdD8zau+nl+9x+JQae6iipIuzuVdnSnGcNh+okT70OUUHF2T6Z
         mFL7yhoOnW4BO3YNow7ZsUeNu0au/5MFaEKvJVIr2kHytwnkc6nKTXqlz5BW2vlhRmeK
         qjPWyfqAPYJWgQbV2d0BdEL3/gzXPN8Sr8DOF/sygmFwyxn+1wuE0/495I0jxby971CI
         u1BJ/Fn4QhQfpEWtlrQ8ap3RPVsijPuX+g/bdHrF6O7D42kGdQorHXC0fOJVMeW0yjRY
         lZmNIFzITjC8jwzpelQYtEyRD6bc6WOAoBbAEKb3T0BUGb+1d+39jBcciJ9M1Lttp4r/
         7kPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983152; x=1719587952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cjxvv/dXpoLtAAeIGzsy9ReaW7NrPJCCE9CeS4zb3TA=;
        b=fprxozMqrtSM1as9UCwDgXIFqRdVynsTnRSd6uQGnZqcm7A3qK4sYCGTREFKW7RWft
         CJoUpqeT+/b/JHp9yP21DJ4X6jdEpAr4r/Map9tRjGenMQcesTHEPJ3sg+n5zQS1iX4u
         ezchvyCRAZUOhbzL8pEd1qpYbhEUOlU6hK8BXHAlFfCLX5f5c2K8c8XEHeraYMCfLz0p
         lsbqj+Nv8JCt/DnSxEnAJpOkQEuJz6ljdkeZfK2X/p6V4y3qmKHenCIl2cHzU9EgJDaJ
         Ud8nDykZgtcj7wexxQbpK8q5c/5lwzwXs9KX3jewU7J/Y9/RBlS/ueZ6468T03eqBPd9
         6uCg==
X-Forwarded-Encrypted: i=1; AJvYcCVFVF9gCYz4gAwQSY0z0R2V53h2JjsmZdTc7WOljtB+XCM7IBTLVjLvkzQOSXywJ8xgOpAmjqJM5X8Z8HGzSEUY88+L/M6Ip808hPbblJCC21I4/+qM9zhLx7JK2vc3Z3OjFcTT1vkvQPlerwQKOIgoXnE1KWc9yLY03ODftzoQdbk6/JJp
X-Gm-Message-State: AOJu0YzUDthUxp9teUgoSrBQCY14Jgw5MWl0KmeXAa/Fu5+v/GXHYG9s
	LG/c/bckMdHel0c9HvShopfYwWfHaqNYoKgGsWsHG4DGKzFXd1FA
X-Google-Smtp-Source: AGHT+IEPNc1yAbSPX6EhL18Hn9h8G+pMaRon9VBVmVWl+LZtObdhSRq3RpDsRRBngcXbxQQSri7+Lw==
X-Received: by 2002:a17:90a:ea92:b0:2c3:e99:614f with SMTP id 98e67ed59e1d1-2c7b5d52dbfmr8330945a91.37.1718983152142;
        Fri, 21 Jun 2024 08:19:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e55db329sm3732434a91.26.2024.06.21.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:19:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 21 Jun 2024 08:19:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/2] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID: <df0f11cb-3b44-4869-bfd6-6e5d01e6debd@roeck-us.net>
References: <PH7PR20MB4962C6D8FD6989BC79F9483FBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
 <PH7PR20MB49622B0A6E9169B04211C7AFBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR20MB49622B0A6E9169B04211C7AFBB1D2@PH7PR20MB4962.namprd20.prod.outlook.com>

On Sun, May 05, 2024 at 09:18:53AM +0800, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
> 
> Add driver support for the onboard MCU of SG2042.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
>  drivers/hwmon/Kconfig            |  11 +
>  drivers/hwmon/Makefile           |   1 +
>  drivers/hwmon/sg2042-hwmon-mcu.c | 531 +++++++++++++++++++++++++++++++

Documentation missing.

> +config SENSORS_SG2042_HWMON_MCU

"SENSORS" and "HWMON" is redundant. Yes, I know, others do it
as well, but that doesn't make it less redundant.

> +static DEVICE_ATTR_RO(board_type);
> +static DEVICE_ATTR_RO(firmware_version);
> +static DEVICE_ATTR_RO(pcb_version);
> +static DEVICE_ATTR_RO(reset_count);
> +static DEVICE_ATTR_RO(uptime);
> +static DEVICE_ATTR_RO(reset_reason);
> +static DEVICE_ATTR_RO(mcu_type);
> +static DEVICE_ATTR_RW(critical_action);

None of the above are hardware monitoring attributes. They are not
acceptable as sysfs attributes. Some of them might be acceptable
as debugfs attributes.

> +static DEVICE_ATTR_RW(repower_temp);
> +

For this one, I don't know what it is. If it is a temperature
limit, it should be implemented as one (for example as _emergency
limit).

Guenter

