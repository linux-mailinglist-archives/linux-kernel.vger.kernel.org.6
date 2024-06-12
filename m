Return-Path: <linux-kernel+bounces-212166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848D2905C29
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 21:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFED1F21C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478A839F3;
	Wed, 12 Jun 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BhSR0zJc"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC1839F1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718221228; cv=none; b=EhUJNA4XbiQ5KJZF1GBHeqBt6Pk9vI0t2IwrHMVbuqh/cDDr/cMZuqgciJo4dRUd72xaT9gFlrFqvRcKtwUNxmq3MX9XP2YXjNkcmkCuivDqRh+52eZFikXLsaMq+mFeyEgT8Bqx3sXt0QH79+lTJLjtL84GpRp6B/HAYOxmfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718221228; c=relaxed/simple;
	bh=cSKMFEYXfnxs8boSeddh2ftPnZABvpUWL3r1pVUsXaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWJTqIoWR1irP27QE7gnTtXJ5iuWGFZoi/gfVgn/EI0sIuIdLIjv8oBJ/lYYZn+u6tKmACkPdYrpEMMHexIeaOSgx8QRn59vH3m2lJnATZf5x0QBup7VM+Y9hh3eUuZFDBe3BS1gakFRGMsjs2oSLJqXtBhHT+R4NU9JeoiRtds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BhSR0zJc; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d22368713aso93129b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718221226; x=1718826026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5LNtnpb+cPV0IybYX1l2BPxrq2qZxhs9ZuI7HpIWdM=;
        b=BhSR0zJc9Vy29nagRHebEf96qeTJ71fsNkJK5Whj8Q4sPt4L4CdQuXAByjLDSylTL2
         Li3sgKMW3GTSUkh8vhNM6WwmcGllQXmNcjaCFwQDfBacok+pd1SEBhLzvngZ2/6MRbdz
         Pv3dsYGXzbK68fEjkzP+FY9uwgE4kGCqMrdZ7IeVNhWed7L+0+qOIWu/owem8mtARq++
         UHSKosws61j8csR3tHvgmLcUbHUo95kTnrB3hVBv9EQleUY4KxNw9TexGyXOoHxyl2vf
         iu5o6kQyZyMYyBkoJAKGHFonxpY3bWxicO8DlUHdzRFak2dI8FfvZTeF2URlEPd/II0v
         wcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718221226; x=1718826026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5LNtnpb+cPV0IybYX1l2BPxrq2qZxhs9ZuI7HpIWdM=;
        b=qn7YIY/dJSEyfxJasr/AQ4NTD6GFDs/aTgFVlGl867mSuyGd91bBZ9Y1YpT4eAO6zb
         xWUQA+DNuFeLEM9Mu5hteW/tsPa5uo0S/EAKS4a+roKLKHxvcgevZ33JyXhdR122TvGW
         leI04yBvWSvqxRe4kFC5ThDtEhGQZMGKCnI7S366BaJlo7LbVOBo2T+kftPYjUtmdcuN
         BynPUDLVjsQuITLc6PDacM8O4d1Kylr/A4Mr23QPm6LKGRtZqJFbfwcMJ2w912iynI80
         h74svkGIccO+RIZKWaMz2cm4FSrOE9D+LWtTqS5ibO/EhBwormRomBaafkbj2VCwr0Zu
         FWRw==
X-Forwarded-Encrypted: i=1; AJvYcCWfDDQQd5PjYhNPuDu5vjx9YLUfmCetEVPDezE2W7HiehIsRU0zoZgPU0v+cmLLbbGM1COsPR927yQa3g9J0abUKMu+1E9YvmemNkmt
X-Gm-Message-State: AOJu0YyBB3kYESzWil0MhfVyiDlJpogKoexN6n6wkhGYblR0V5bZZ4hE
	9SS0GXKXDdQgXUG8roMoGcDjqa5LV7l0l0eukY7HJXPqDbM09KSaSihA4VNsuPg=
X-Google-Smtp-Source: AGHT+IF6oKhV6A6Y8jPxsGC+iDd30Uo+tPSQ/KOgptYZ4SVvzSzhteTlGlt677GoxMbr0X9fXi+ZCg==
X-Received: by 2002:a05:6808:1594:b0:3d1:fc50:1aae with SMTP id 5614622812f47-3d23dfdbe9dmr2927945b6e.7.1718221226425;
        Wed, 12 Jun 2024 12:40:26 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d21cac78d0sm1690192b6e.13.2024.06.12.12.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 12:40:26 -0700 (PDT)
Message-ID: <80093c72-d0c3-4d25-8830-392324744300@baylibre.com>
Date: Wed, 12 Jun 2024 14:40:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: ad4695: Add driver for AD4695 and similar
 ADCs
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Ramona Gradinariu <ramona.gradinariu@analog.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
 <20240612-iio-adc-ad4695-v1-2-6a4ed251fc86@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240612-iio-adc-ad4695-v1-2-6a4ed251fc86@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 2:20 PM, David Lechner wrote:


> +	ad4695_set_ref_voltage(st, st->vref_mv);
> +	if (ret)
> +		return ret;
> +
For some reason, no matter how many times I go over a patch, I
always find something as soon as I hit send.

This is missing ret =


