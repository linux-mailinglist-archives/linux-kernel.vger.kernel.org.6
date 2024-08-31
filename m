Return-Path: <linux-kernel+bounces-309780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0875967058
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AA01F22E20
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A90170A23;
	Sat, 31 Aug 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G+Gl5hoe"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B186916EBED
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725092772; cv=none; b=TcqAmRXGB2pN1JAFJRslhgSi3yCYM+Od09ifYdm7ylG/pRpsCTwWbOrn+VIix8doQ2VLzfm5Uq7DsyKPEWyVzj9/RaAKEd/Qa+earhQRWoMEe6vagnZeoZXLDdhpa4zbBVZ/PN3gYsl80hth6kDfNFNEWmNXSDTfm76ON7YqLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725092772; c=relaxed/simple;
	bh=wrI9Ia4Ar4QKeJfDIgGIGj41ailash/OWxo+v7iPnis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGyVXqdcdUJnjYdXmETV/bE2Ih4G4+bDfTjBr3u1DBLxUuzzU6V7iu1yFDGY8tNEiMwxbmvc9fMH8hRoFge/+kO1fAO7TiQ0onA0Xw69HDCaQGOXoGEuqSIDQKmFwuOB75QzfWD9psUyVpoPq11aGeuu7HtY3o2y6By1gwbc9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G+Gl5hoe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42bb81e795bso19709815e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725092769; x=1725697569; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PUn25yylj83ADt3TIdVylAl6ydwxlNjsLdxzQbv/uu8=;
        b=G+Gl5hoeYYAEO/vbsF4zbV9SZ37CMfgMB3u9pibTRJURQUm4OhFevQGdp7tHsBEH+X
         hEgbOJ+IAf7M5wcIlx1PR3u6A4e+RdPdzCVIB0tZMNSIdNU/sh+szOshJPzV9Ul62VHR
         YT/6T622omHgz4JNGkAmbzdZBsYNo15XPTT1/xGKZ2qG+p4VWna+22MliUjjEksg4e29
         6GSAq/yO+Dm2Abgd/G6GmD+Po2bnUd+n4GSZbVBai8sxMdMJZUMe9Aw4tN20S3chphpc
         6qFZY7uM+IrZ3jsYb0AgrgrV25usngFsB6t61RgS5PRcAEOA5Z3MLlPiORAxVQeBztdi
         rPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725092769; x=1725697569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUn25yylj83ADt3TIdVylAl6ydwxlNjsLdxzQbv/uu8=;
        b=BwVEYoKXJbFLBryENmCdLZxXdUuoJOYRU59b/J3oYzUO9G+EmNgEYnIvHWQEQHuZO+
         TVj0LQ+F1ODIEUBLxmczG/QzO8iuO2ib2fbSyy0LTznuaMUnOy7SP90kTGgyQsyu9qXe
         SsE4h8Wh3sGyor3nH2mzxIaQe98kV3Oudorg5XChx902ut4BE7ZonieUVJ6hInIwZzxO
         2BYC26yS1RQj+ieLqbvolqj9G0Uq3pJtaXxA3xzb/Fg0UFIUUmbL2TIfxfsYXo5UvRPa
         bqFw0JYiTBgCd6nfbCtRcmDRbKgWaz1IX7w7zA4E2SwdQPI3OZYkSO7ZdLrIrvSlmTdD
         ws+w==
X-Forwarded-Encrypted: i=1; AJvYcCXSeVc9set/u5RNcERi5T3Uo4/ElChX5lXTqIZ7HKcdJmjcr9nQZ8Z9Ms4L5mx5gMkTzh/WAw1Ejwd7Dfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhUSv3PHD0RM3YoB4aGmmLmVyeOYf67HAR58bQdg6i2Qc69Ov
	mn1jLbwmMUJNhTU0EOVcOaBm9Wx1sAQbOGItyO3JkZlkfKgvNfPG0x+h3rPvd/s=
X-Google-Smtp-Source: AGHT+IHWvHDiyoJfajPjn0ChFw5L62xII7chAIudL8Rfv0VPD2SsDp1xkjww+bPGvwVAiAoynVDyIQ==
X-Received: by 2002:a05:600c:3b93:b0:426:5e0b:5823 with SMTP id 5b1f17b1804b1-42bbb44114emr36049175e9.34.1725092768683;
        Sat, 31 Aug 2024 01:26:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396516sm104491425e9.4.2024.08.31.01.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 01:26:08 -0700 (PDT)
Date: Sat, 31 Aug 2024 11:25:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <ce59c3c6-8729-469f-a0df-b6844792e324@stanley.mountain>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>

On Thu, Aug 22, 2024 at 04:05:38PM +0300, Andy Shevchenko wrote:
> In the similar way, ignore 0 error code (AKA "success") in
> dev_err_probe(). This helps to simplify a code such as
> 
>   if (ret < 0)
>     return dev_err_probe(int3472->dev, ret, err_msg);
> 
>   return ret;
> 
> to
> 
>   return dev_err_probe(int3472->dev, ret, err_msg);
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This is a terrible idea because currently Smatch is able to detect about one
bug per month where someone unintentionally passes the wrong error variable
to dev_err_probe().

I really hate this.

NAKed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


