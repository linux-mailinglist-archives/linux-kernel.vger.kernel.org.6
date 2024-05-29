Return-Path: <linux-kernel+bounces-194749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9108D4166
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777BA286AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76916F0DA;
	Wed, 29 May 2024 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxtc0aF3"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213315B979;
	Wed, 29 May 2024 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021893; cv=none; b=F6hXsMwXXubu0IM2eck1kIUFpEPQsN0GdLoFPgFUza6VqwM4ELDV1Vs9yjH2pExTjVzIGNBKY2NLXicvJg6cnY0gf74pLEZBSVpUwLqnMFXbXS5YFQeJCwGsXQs9Ec0v2aMkA+mlNkg4lsFq3W4Ax007rKL3VjZmZVv3fQhNlyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021893; c=relaxed/simple;
	bh=LI6WjcMmv9OZvJURtgYXc2zS2t1HFMdN/XNg0xC1cPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri8rAD81uPXS5KlM0h3CAly1cgRS7bxUCqp1/8D7ORSrxaSXL0zpaXHBBgsTITi8bAAg+CrKrGddbHM1ZTAwdEFwW/tw3SuBPMcDjsJ0MWnLO/riw7nM0QwsFW0pathIgDre0M0mgWM2RaVXdUMgGJoZ3+jLfXE5wet4cxJKWFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bxtc0aF3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f47eb2354bso1983155ad.3;
        Wed, 29 May 2024 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717021892; x=1717626692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ozwb9Zz4GwZFP9/Y8ej5BoQULZ82oF43cCSad5qg3Hk=;
        b=Bxtc0aF3jPCLQQkzCI6mPG2EqIfnopsUhyOHuW3rwolBGOIqVqA0H1rvjT+EiuZfMB
         C9jnVpaEuB1RnXqpbi51+AbuTszglroV5Kvmt4vZGsv1AnrcHVEUaEEq5JMOXMRgCN8Q
         zztMNmQYFb+2slFvH82BLQv6euTg+uVJjo7eDYW1wETaa1HNWmVH6tzz2zlaIS2e7UJ/
         5vk3vPIJbC2bb37VtvxTk/OpEDG2bxcOyllxeDLHERbGFrN0h4nqkit/Nfk9ZbJSEx7O
         Ze7fFe0AA5AYtsVKlZ+V00+SvA2tAuBUUFpTWChFcx1fhG9btAFlr/6Oz92e6V77NSvj
         iMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021892; x=1717626692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ozwb9Zz4GwZFP9/Y8ej5BoQULZ82oF43cCSad5qg3Hk=;
        b=EWmaaShK2m21uV8s2QH+5vemwOdAabbQpL0LJFeX3gtNZlQHvxvBNUMf+ij8VyBmf8
         78fcohNj7XSRHLzZOHGYf9akN8vf2T2JwkuXFM0P3msRLx7XrhHJTlTtHwid4YcHG4GN
         St7L0EXLecPLBXWzQxDgmS1xxAHzUWLLxfP2+StCRH9p82Gdn6mPrumS1etF8JXJBlkm
         PbwfSgc/HOTYE0A+fl7JVA7ePeyny43e20xUEsBxe4pYZcWnz02Ai3RjUmzuX95OQlb0
         mriUWPMgl7/n8Y4DZpRlK+epTMqZ/F8+Up7v2QiwPBCCMZlsZ5jS10qg+7p/im1Ahbqw
         qryA==
X-Forwarded-Encrypted: i=1; AJvYcCX99VBUk4kujPb1bUAhkHiXZOma8pRxSxftHvLlc5WY5eKOjycsFCvv8BTwJVFKS1xp73YdXxmYAD75zo3/izYV4vyN7hrqw565Eyg8URjhJS7LNp7YM63ZGNfPcDDJKEOVHoUm2XXwTbk=
X-Gm-Message-State: AOJu0YzKb6hKroaWAuEGSD0x8cag92/XSOxcCJpvwBrfUehPemiYzF+W
	wzdHuhlfEsQeCNOGOq8nKHpAI9x+yc/abGMKVpChrjXV8eJtyaeq
X-Google-Smtp-Source: AGHT+IE6XFi7SxEJl+AY3m6sEU2SXq1fJ2zOEsHIeNL78sxx5pdvWOHrA3vKBDDt9c/JQzNhPoxzLA==
X-Received: by 2002:a17:903:2306:b0:1f6:fa0:da71 with SMTP id d9443c01a7336-1f6194f91ebmr4292195ad.18.1717021891787;
        Wed, 29 May 2024 15:31:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f61961e4afsm1361015ad.132.2024.05.29.15.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:31:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 29 May 2024 15:31:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Add Dell G15 5511 to fan control
 whitelist
Message-ID: <1f5290f6-35f8-43b1-8cd1-f8c8a4ece8f8@roeck-us.net>
References: <20240522210809.294488-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240522210809.294488-1-W_Armin@gmx.de>

On Wed, May 22, 2024 at 11:08:09PM +0200, Armin Wolf wrote:
> A user reported that he needs to disable BIOS fan control on his
> Dell G15 5511 in order to be able to control the fans.
> 
> Closes: https://github.com/Wer-Wolf/i8kutils/issues/5
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> Acked-by: Pali Rohár <pali@kernel.org>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --
> 2.39.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 48a81c64f00d..942526bd4775 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1545,6 +1545,14 @@ static const struct dmi_system_id i8k_whitelist_fan_control[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
>  	},
> +	{
> +		.ident = "Dell G15 5511",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Dell G15 5511"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_30A3_31A3],
> +	},
>  	{ }
>  };

