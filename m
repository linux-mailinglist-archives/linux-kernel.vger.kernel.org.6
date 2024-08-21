Return-Path: <linux-kernel+bounces-295937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3612895A343
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBF11F22E90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC61AF4E3;
	Wed, 21 Aug 2024 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="doquKV8T"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD515098E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724259425; cv=none; b=NVu3UvAUbi3VNAPnm7XwQYhj88YEjSKV6w5pga5PeqHtPCURkfifqjJ3I/PWJSIAu/kaMpa+D601oXtzYtQ1r1zV7uxXRHiHkvVwXrmocaH3bhi22JeHPEiVH7PALcaz5WFCC9KpvNOK7uWWFEVLNXuvGB2GgOY/4bzKfMcizgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724259425; c=relaxed/simple;
	bh=nVndjd8LQ1lnWsWfRCEVnX6dxkXb4jf3fpRMWQEc6WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtIMHaoSiFpUuZmLf5qEDP79VNj28DrvztRC3S7gS8SAZ9/MmZ3IlFt4wmkwbtjMWZC62UAYylAmWnsu2uY7u4JkSWbzHDKmnErvxDTjDIH39KzGQM/ctnlCiJI0uGaDygtEtGLKtRpSKlJoIqJXX+BsQ8tsYinu1xgqA0r7r7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=doquKV8T; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8677ae5a35so102328266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724259421; x=1724864221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gr3yCN8G50bMck2oSxMfeRcm87tCJcNUJM4Xxr3rrZQ=;
        b=doquKV8TG+woUoPH9wPDbT2Nt4whZi9p451sL2OLVAfMqaDEjm7B8AsQpmUMGS77tK
         CzqzEYZdNrhc+WhfDvyfQvMh2GE0SW5D8gU45T2IyQu6Lyv2IyH1IMRA3gXM8XVD36cb
         z6smnAwExjMhp7UxP5EHTylaT+q3kOe7fnc/8hAeaN0VD0JzVnmWEsE95uL0khuUFioR
         h8o1watqrKDpbQGDKZQ7z1SSp6q5fQMUFt6AvdNp6sTdvXISWqjuAbVFf5iJfYJCcumS
         mWmKQrzw2heTlhS6YIznitn639jqj47rW6BbCjwjZFSKbz8td0OSByNz+ePFO48tkmuh
         qx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724259421; x=1724864221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr3yCN8G50bMck2oSxMfeRcm87tCJcNUJM4Xxr3rrZQ=;
        b=HUlIS8rxOg8rC9qHMF8sBT7TDoydPJoO6+en1kswbWYNZQGmAVm6DCugKCGWmS6L7v
         3B3JBeLly2pSV9rQAsLcc/VralkAAQx56Hlk2jPWPc7J+ysz/E1YyVl8jZFoajP8s82d
         zJ7ogmHSUhvEFoNAfCzbNYjeWUI01uc+2cGfxuaeF6jILmjQZKsQiXiY6Nix0lGiC/3c
         PqmPod2FzTp23uu3hL0KRareaG9piSDcsIj4LHJRhbmp72qvX0q1ysExMqueC72fTToM
         2pzJ4svb6N3NtnQJFJfabwoqGSOlmhk5fykP/yXS92R0i9A2XRuDy+491s0wyx569+GD
         4tUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrH1Rf6A/lpFmAUeFl7jJ82LI/bn505dCUGhqzk1A2gWVhnh4wrute+NuXUoefIRSsIZnysfFec0HVlkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhI8uPGGkb4CHnJNJ3RuL11fBGEB8o/BhaxdsDlEkmukOAmqSp
	ze5Wcbh9gjmV8WON6HTP6ts3NP/u4Ar0qE3sBPCT29Oe1g5LkU8cGpie0qFE7HU=
X-Google-Smtp-Source: AGHT+IERQnuazH854bi+rbAbn9vyI09ekH1cOuPFLwgcVkGcFMLdn18jBYjNuW6VBEvlRMuQiRd1Jg==
X-Received: by 2002:a17:907:a4d:b0:a77:cacf:58b5 with SMTP id a640c23a62f3a-a866f1472d7mr204400466b.1.1724259420888;
        Wed, 21 Aug 2024 09:57:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86829ccb6bsm50814266b.144.2024.08.21.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:57:00 -0700 (PDT)
Date: Wed, 21 Aug 2024 19:56:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]The patch fixes the following warning generated by
 running the
Message-ID: <dd5aaf11-60c3-4621-8278-16bddc1080e7@stanley.mountain>
References: <20240821161539.541062-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821161539.541062-1-sayyad.abid16@gmail.com>

On Wed, Aug 21, 2024 at 09:45:39PM +0530, Sayyad Abid wrote:
> From: abid-sayyad <sayyad.abid16@gmail.com>
> 

Your email from header is better than this From header.

> diff --git a/drivers/staging/vt6656/Kconfig b/drivers/staging/vt6656/Kconfig
> index f52a3f1d9a2e..a37dc3c921ea 100644
> --- a/drivers/staging/vt6656/Kconfig
> +++ b/drivers/staging/vt6656/Kconfig
> @@ -4,4 +4,10 @@ config VT6656
>  	depends on MAC80211 && USB && WLAN && m
>  	select FW_LOADER
>  	help
> -	  This is a vendor-written driver for VIA VT6656.
> +	  This is a vendor-written driver for VIA VT6656. VIA Technology VT6656
> +	  is a wireless network controller that operates on the 2.4GHz band.
> +
> +	  If you have this hardware and wish to use it, set 'Y' or 'M' here to
> +	  compile the driver either directly in the kernel or as a module
> +	  respectively. If you are unsure, it is safe to set it to 'M'.
> +	  If enabled it loads the firmware for the mentioned device.

I feel like this second paragraph doesn't add any value.  Just ignore checkpatch
when it tells you to do stuff like this.

regards,
dan carpenter


