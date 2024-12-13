Return-Path: <linux-kernel+bounces-445682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93229F19A5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C01188A1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762081B6CE0;
	Fri, 13 Dec 2024 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yBLDng+e"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974791B21B3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734131371; cv=none; b=MAPLP9K5gvyEwo6mqW5YQwncepUyPQZXefIs+uP9jRSl4s9lBz8v3g3nqbM35l07kFX9zmHDd7AIjiQDadRyNjovvHiRla0w2ScydEwt1mywLPQELOEPWyNxPLCooyGUVBnFYf4j8rnOh4meelZ6hgnmZoySVsfYGe1r0i1Yy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734131371; c=relaxed/simple;
	bh=a66lIxSlpOjSTxBDXLm5oz67ehuFCRs4HJpp5BjgPg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J6d9pHFFVJLaqC+uRlUpxs2zcPjphELL3jeyeVCPpCtdrDOylXhSTRJfFNegxArER39SkIs4n81W8GM3ZiPooQmLFhcZFBLB9TNlveLSpcY9ig6zEMfxyNOryWP/s8niYvV9PJop6zxcguSVNNGLtAU0V25pKg7ha0EHSltWPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yBLDng+e; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-71e3284f963so1061259a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734131368; x=1734736168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=naGXFTMazXpixOxAatrKjd6JeusIndHF4os7SSqqSwY=;
        b=yBLDng+ewcd9pD4csewchmMn+U3PGK+ouCmHTLQ9WrfGsgyeUxf6Ex4hFgukJzrBjB
         srUqv0UUR0UVmUv3q9G28o99Jouexm3+OFRu/EVpk6YzuilEDcbYETBme1HKHRy5rUkc
         QURd91wtJpj0fiYPqJQdxDasGYAsojLZTZu5aDoDxFx1zo41JhW7cIKK5EIyeivdqKjK
         zItLfvB/EYks7cm6ctPA9cI2ouqjtVWr2u2sfaFb/P5jmHA7O25Vz4T9hccKOgQBhzTm
         94JR/ekutgRqhg4uczghCYvnOgug7ZbiqqVbXWf1ONlf9hrNbi9CAdqXh4kV5zDyUBhh
         AMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734131368; x=1734736168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naGXFTMazXpixOxAatrKjd6JeusIndHF4os7SSqqSwY=;
        b=VjKF/QXbHk3+liQAT+oqozf/nNLp+3U61qJm7p50NSXYGOMkTqKcNjlsthvVAx1Uq1
         5iCbtk3SnX7GwF+pOWhBE5cFldTEU6WjqKaYjdFckC2XbyhNm/8N0yqE04CFZo9jfChi
         gM0Qb/7RTluQfNwhlTf1r1Awt5FGmzfzwRBXPVKr7NnFpA5uqQ64TLABkZfPm+du8HDj
         FO2BiUCqz0hXo+vmxqSMnJzMP5WuRcEZOLOjXCV06XwYba1Bak4oQNlsS/GM0iXAm1Z7
         tNqldRwUh+5awrNDjQB2DyYdzXxc79d8T947yfZDK8UzT1TztNYMOgxI1A27VyIlGpvI
         5veQ==
X-Forwarded-Encrypted: i=1; AJvYcCUthUnoimJaRB6z+eoXLSzEW1SW1L72XSe9LZ8hujAduObRlK3h1zQml47rAIsxwni/vKi+b6WavQRLdXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOY7fk6OhiNenh+ZSGd9xnYQI1N/gWnJ6hFRRS4++iDQp+tuU
	+QhSfDiJwnXZjhW/AKpVMsph2/TQyjRM/07bGqTDNrY695mouEVIpoCZdu9ONe4=
X-Gm-Gg: ASbGncthFmarRC6hPH1HoNgO4xd/4ejP0+e2Czsb14jf0/4hc4HT3PVCz2Md5O1mLB7
	+3lv/SQj9PZ4Dbol3IdA/Ybt/5+5XOS6WVb9dHDiYUAY+IaCTceowNL96u1umc6/T9CU1Wk5Y/N
	um8fv2G3K1MYES5lUpA5bixNlfJd+Ay0YtoiUR57zPq/rf82sSdEpuLLcU/I5/8EVhxNfrgqz3n
	JhFpfO+1sQsGgT11s4TyV/zgcy9F2z6UUM5fb1pnWQ3YZHYLNTrQVlyjxkjrE/xBaNgC+LuNy+I
	MbA15iNvir1e4ryYEw==
X-Google-Smtp-Source: AGHT+IHoJ9Ixk34ZMQqbJ1mkbnpXEc+OKf3C3bitRp9/AunmS1rwBG42IOuY5b+Pobx7K3tkl0VShw==
X-Received: by 2002:a05:6808:2208:b0:3eb:4b4c:80d8 with SMTP id 5614622812f47-3eba65ba0admr2149752b6e.0.1734131368695;
        Fri, 13 Dec 2024 15:09:28 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48308005sm139273a34.13.2024.12.13.15.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 15:09:28 -0800 (PST)
Message-ID: <99a14b87-90f1-4450-9e73-ae672edbf3e0@baylibre.com>
Date: Fri, 13 Dec 2024 17:09:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/8] iio: backend: add support for data size set
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
 <20241213164445.23195-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241213164445.23195-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 10:44 AM, Antoniu Miclaus wrote:
> Add backend support for setting the data size used.
> This setting can be adjusted within the IP cores interfacing devices.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


