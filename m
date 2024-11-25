Return-Path: <linux-kernel+bounces-421246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93B9D8896
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40FD282B47
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C991B21A9;
	Mon, 25 Nov 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ojhY8dTN"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B2E1B2193
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732546674; cv=none; b=fxcCrE64cBrEQVT9KNdeftUg0gWSW29Q/uF4fEnTjyuMk0JZb3KPFlW7O5jIx8m/pSAfnLGlzrXYRxSo/kqjyAhZfd0EYI4yoe10zWscJpZhpGiue/H1oplCRmfslI1OOcqo4oIIV/gEewsW67ySsOJpSN2ojQnzFTtFnr1DPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732546674; c=relaxed/simple;
	bh=bk8Rp0zqwW65bPI33dLEaYlJnQGdgrX+zL0p6r4e4QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb9gtbtzQW0csu2DwLPrhDqddNQcN36buRnq2WOvTowAsx3wNYD+BuwwdFLHvn2fcauvDfi7kCxQAevedg1CvxGBkhuyM8BrR+ZT/BoAe6l0PgzfdYn7V0RNjyD55NcQwNgpQ5eQtngXIVEYUu7yhgdzUQTZtq/xm03BGUghugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ojhY8dTN; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-29645a83b1bso2753377fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732546671; x=1733151471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Sk5I+z2BGvx3HaF6SgZiv/hQ40aE794oKF5/2uvgbE=;
        b=ojhY8dTNUe4rUbU40n1vxi7funIlcPEMVV35tEIJIV6o9CiEiglZQMQ3eWCZ1/Vdzd
         nUXKUrc76Xx7/t9pNVFP/rnXfdyb3Nql5cVbhU0PjrqCpoCzZhwfd6Typb7w/hbmjN1Z
         CjDTuv1EgXgRYDhPmzA08yW15quWxWi/wEBCSCXnw7cQEFjXMC+dBZTUAkwvEYtmJCPx
         uobaecr7nSjXJv4pc/acgyhe79U8w06rUXuEiv4xHrKs5Gw5Wfhoppf70+dNAzoQQ5JI
         yWyuvKEf7dsyPOPqhGMgyT+81/O1JqJcOn9a++dMbP5kd7q+0kmrnZ4zqCSqj3dJWj+C
         bK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732546671; x=1733151471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Sk5I+z2BGvx3HaF6SgZiv/hQ40aE794oKF5/2uvgbE=;
        b=rseOnMdxBniKS83g1lz5DOnZH3PFVezkSNh2czOb1z3Unym5zs5RTBmmDEDelyw/aP
         z3Joq8gOFT5QYm5Vz12fU96euVRYNAzokYDyCO7/lzTvAKvipok01TkM0MxujYDgXiSR
         O98zf/WzZoWSwxYZvW/YNDsHwUHLZHogZ0H0OR0yMeh6vcedujSM/hC2NC9vKLh3LnKd
         QY4Seu9HyB+5ri5YOP0GDB653ApLbEZ3uylMMW7tnamXdQiRcpMBF5i0lYLhtNzYdX4E
         6avnzV4/xHIJNqJBLmIDeK7BE0FqnpU1v5LShX3byg8cNQD3oU0vTg0NQI+So+DhR/sS
         islg==
X-Forwarded-Encrypted: i=1; AJvYcCWPCg8Hy+184W1eLePVMChaeyik5AOQ18JZ7BGQhc+j7LqB2XjQ8aHsmaoVIGOCr/8EnY/lLhdWAeudv4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDh3qsaoI9PY1U11S9es/g2kqqPB655xcKfFAXywq3HK5hlp/
	mm1AJq/sUHU3GhAtSHHfBCG0DJn7uokbzw7+TlPEhEScaNtkTm4RRIAcjMD3lNY=
X-Gm-Gg: ASbGncv9XJjR6OryIJWnh3So1iPuac9pHeBpqU5YnxzH+0/vMVrMtwrcfvhRdBfF31b
	vMX3EWSPSOvt9lqIiBDPHVLCCw5nP+5p5+K4DpmhLqhYahu9UVRgtUvUb2bQ0/K63wYB6n50DRw
	QzbvyUM4wevfyNOTL0vwFQmGfJQDzeuQgnxI7UiNU8FICZ/zYL8e6ULuQ9dUOxTrrPEBIXzFArM
	WG4rXPPdG2lBoWCla0tdEonG0/cJpMw72moba++rFEIwRNJfrkQ3wn7R3N7f/j0xit+mJdLzwzo
	6O/jTd+L66g=
X-Google-Smtp-Source: AGHT+IEL8MmRzDS+0oJEMVoCro9m1ScKl1IojEg1ji4nNvqP24qjZ+AuwiOGiiY/AQSrRBr9cSTd2Q==
X-Received: by 2002:a05:6870:8189:b0:296:e365:d169 with SMTP id 586e51a60fabf-29720ae0117mr9301425fac.8.1732546671690;
        Mon, 25 Nov 2024 06:57:51 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d5e29ebsm3052686fac.14.2024.11.25.06.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:57:50 -0800 (PST)
Message-ID: <213f4510-0af3-4e17-8473-3929227bcfcf@baylibre.com>
Date: Mon, 25 Nov 2024 08:57:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iio: adc: ad7313: fix irq number stored in static
 info struct
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Michael Walle <michael@walle.cc>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guillaume Ranquet <granquet@baylibre.com>
References: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com>
 <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-1-d05c02324b73@baylibre.com>
 <76myaxinjuupszvwof355gxwqqs75yxupsy623nwrcms2g7ttu@q3vqdwmsp2ua>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <76myaxinjuupszvwof355gxwqqs75yxupsy623nwrcms2g7ttu@q3vqdwmsp2ua>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/25/24 2:59 AM, Uwe Kleine-König wrote:
> Hello,
> 
> first of all thanks for picking up my report.
> 
> $Subject ~= s/ad7313/ad7173/
> 
> I wonder if it would make sense to update the ad7173 binding to also
> allow specifying the irq as the other ADCs do it and just
> unconditionally fall back to rdy-interrupt (or the other way round)?
> There is no good reason for ad7173 being special, is there?
> 
> Best regards
> Uwe

That is a a good point. We actually don't have to change the DT
bindings, the "rdy" interrupt is already specified to be the first
interrupt, so spi->irq should already be the "rdy" interrupt
because is is always getting the interrupt at index 0. So we should
be able to just drop the special handling altogether.



