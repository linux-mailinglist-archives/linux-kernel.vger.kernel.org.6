Return-Path: <linux-kernel+bounces-263373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B62E93D513
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25993282166
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500C13AF2;
	Fri, 26 Jul 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7DsES4G"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735D1CA80;
	Fri, 26 Jul 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003947; cv=none; b=i1qcr/AT2eSC7nxlfzin3HObj1NxiMArycSU67mZH/9mBwoIvrQkyKYEp9nYbWC8Nan+CfPibDUKdGMMAIyYmhB+jSHuphRwgy7JcYB1WyEOffBchWwH6PCLFUANkNW2lfI9ZNi3yT182i7CRlpyqWSbDkLoyG95U+x99+HJiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003947; c=relaxed/simple;
	bh=Dn135Z5lIeJU8XZ+6nZPpMeFanBfB1QMFUV4i8APx5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4KBehLFfuNGlUJtYJMk/sakFNtDDJvznautacJYeY1OQ7uqBWUnLJMy8lL2cjIfVfoes8gltHYgOevLV63cLoFQIJMWWtkzF5nNwviSEzi94qeMktGI+DSqG1g1s2jp7hV5I0fAFyKUPcxGD8N+aAp96Ejq9X3cAYLWcNyU/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7DsES4G; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d6301e7279so686514b6e.3;
        Fri, 26 Jul 2024 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722003945; x=1722608745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2dSjzQVoou3+io8zljtSLUJKL0DDyVy1h+d2igdtKk=;
        b=R7DsES4GWOJHLRiRqQ5qOL/u+2m1QS2QJyggyGSLRsFT8ie/9K9R4VbU+n5Nqd9wBx
         i70g4F1+kgNf7SUbQKm4BAL6VkKI4NV8LUV7FNv+oD8VZuDFpwOLhd9hGe6m8fhsULK3
         EuwNXYdZgpQTuGUIKlpi0x7HGGA0gKnZKw10BbXezBCbZ+WykpbpSSojhze8Ri9JNZY4
         lg2wKrwF5qObcF0G+uDGGTL1bDWEF++bj5XqSyThrfNmMeBSVlCniXUoylfQxZnFI8Yn
         dqhe2Ko+eroWeaVQT0Knax1AVIteRhiFxmnolmEfvljHtOBa6bKISthLNrn5ghrW2mT2
         PUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003945; x=1722608745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2dSjzQVoou3+io8zljtSLUJKL0DDyVy1h+d2igdtKk=;
        b=YrKl4v7OvLcnLQ1JDCEth+fHwXKMDO9azKbT0omoOty5QuA5sJE6Mp1FRBYkJiRTuQ
         NeAi3r52K9GT49OorhlLhQgXaQwdYNYP+aDlTO4KikNCCCMKKBYNjP/GfaC6yHIs1WvM
         iIIIKARuOiao9enA3spfJFLc2+j8VS0WD42XA5CN3nBZr+zJD4I3p8jH4a1ERkZXzCiv
         G3crbcLzSyjH6flJ+QoSBsL2tSd3jRI79m28fq2FO+UMswH3pdO0Uexw2IG0cTelrc8V
         umT4xW83QtE9nSJrC7tpvxQ1cEMGXalDqIoeIcAuwmCyq7lXjeeEUmHcaDtQE0aO324i
         HAlA==
X-Forwarded-Encrypted: i=1; AJvYcCUha4kS32OFR8hb4QRpg7YsZqNlSPU+/WQURKNgg5ZSxUwE5YqDywJCTwMBFyL5ZiCC9zib5eVvBwRX6XX4R+WUlEKDrWPitsPCqOUGZx/k/+sA95dHAcJe3CdZR0ocXGONkUlIM5zj9XTwA1nzML4HvcWbcieSdXbogPIEaXThG1NVQKI=
X-Gm-Message-State: AOJu0YwsoRuf6uLWkKYDAjoWBbW6o8DxPBw8uKF+ClDPUGZer1oXpcc1
	PpSw8DfjKj42VML9vgL1/lAxJWH5ImHX/nZvEhJuc23gRMRACdro
X-Google-Smtp-Source: AGHT+IGQcCgvF2YcDKF8DG4or6U99L3ds2DC7EMO4xgSJ6DHv7uif2MT5LRGelGsU0gcV84NNTP83w==
X-Received: by 2002:a05:6808:1816:b0:3d9:28cd:4f89 with SMTP id 5614622812f47-3db140ecad5mr5450726b6e.24.1722003945514;
        Fri, 26 Jul 2024 07:25:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa593715sm2883820a12.84.2024.07.26.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:25:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 26 Jul 2024 07:25:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cryolitia@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] hwmon: document: fix typo in oxp-sensors
Message-ID: <e4f93c17-be7f-405b-babb-2b4aef709537@roeck-us.net>
References: <20240726-typo-v1-1-3ca3f07f93e9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-typo-v1-1-3ca3f07f93e9@gmail.com>

On Fri, Jul 26, 2024 at 09:21:14AM +0800, Cryolitia PukNgae via B4 Relay wrote:
> From: Cryolitia PukNgae <Cryolitia@gmail.com>
> 
> RMP -> RPM
> ---
> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>

Plus, having your Signed-off-by: tag after '---' drops it
when applying the patch. _Please_ be more careful when submitting
patches, even more so for minor ones like this one.

Thanks,
Guenter

> ---
>  Documentation/hwmon/oxp-sensors.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> ---
> base-commit: 73f3c33036904bada1b9b6476a883b1a966440cc
> change-id: 20240726-typo-616bb7db0f68
> 
> Best regards,
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 55b1ef61625e..50618f064379 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -52,7 +52,7 @@ Sysfs entries
>  The following attributes are supported:
>  
>  fan1_input
> -  Read Only. Reads current fan RMP.
> +  Read Only. Reads current fan RPM.
>  
>  pwm1_enable
>    Read Write. Enable manual fan control. Write "1" to set to manual, write "0"

