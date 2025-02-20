Return-Path: <linux-kernel+bounces-524771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E5A3E6ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04817702136
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FFE264F9E;
	Thu, 20 Feb 2025 21:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ii1U/RoC"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4EB264F90
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740087832; cv=none; b=hKpBbWGG6VimAiEf2QNA4i7RptpXIjs2qp9Zeq467AGJbhvcEy2T5bN6XzjZPUPvuD7cusv1XFR9+GoRNeo5vauVNye1aKkrp4I91CYffyqCiRtoWjtzwlvG+l2dQcU5R8TsXsNjg6DYR2LqD+OeE4oUEM+yuOls6nkDN1NrTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740087832; c=relaxed/simple;
	bh=ES4OGi23rslj+Ajn+wNFewphPy7M6o0Ty7Wpu/HZ5lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtIQ0ymcUtPY7KyRByhCpOmWso5sDu616ozVIxXC4L2VgztRhj3uxezNKvZo3OaBBEQQeYTF8SmyB67Jsm+Bfoga+qNLrMeAKkqxxiJmYP0XeJuzXENXdnWMV1zGeXV08cr/ZwjuBOsH9/fdVEYVUMtPY6IB7UUYyEv8EiY/DqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ii1U/RoC; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fcee9dfcb3so652347eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740087829; x=1740692629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt524ElHokjzB1IIM2DIs3AzK+URz67k2uKl/q2oOJ8=;
        b=ii1U/RoCmBoiI1CKzwEmdZFMoROd9ObKguIgJPoJ7GwSpt2MItgCcdBShF8R2iK5mz
         3JzLWMMiEX6GwonlfLt2IIHNZE1sciNO4j+NbshDdkN2jYSjDnUXqTglyaHhXEuBkr7l
         qyotlmkD1evDNZ7IdqppSVS8wmUJePNzVhhFrYJvNuJmws3fc8L9oBNpSWHfak9qrPhl
         quJRpLx484t7pINKv64QHjZN/zSQ9wAgwOxIzg2mISK/IKJ9Kqt4oVh2/jWh+oOaWYpi
         E83WVRZZ/d9Jq2rjtrxuf/1Wd5Bicp6n+Xyciwget+J5VdQHYdJlRSwhBbD/lnQdoj5Z
         2iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740087829; x=1740692629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt524ElHokjzB1IIM2DIs3AzK+URz67k2uKl/q2oOJ8=;
        b=h1pR86CN96RnFmieApWx99dbQjyFHQWQj9OkH3CBzWSk8l9RXYz4V0iXRCCzfTVQo2
         K7LIjAI7XLmortnCL+opUuW0OMuXRqpOH1ga4MfF2KUyNLLaNo8q6QSMGraxfZLesV0W
         W3GQp5gGzpikVmk/WroYK8m9BLgDZDv9o/anFAnEfA7/Ss01aVSBw9OTRaB3NsAKbzkB
         ARXJ5Quky4DN4mFmLycgbKDEXB+Veo37kWAGsVJs5EA1NsuT2JpDeSnNm1KqcZH3SBks
         46L1eIo3ri7WvMe7IcYj90hF3ObMQYD76J2kILG52rAXT2NR8FJvS9SVwyZluWgF88yz
         KcuA==
X-Forwarded-Encrypted: i=1; AJvYcCWHB4/eisIy5L2jQmgggot1DrZjweHuq5m9RpFoiH/VwtWRyXpn/2MjM4rtI+q8jfxtVjZ/H5i3AVevPts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkP5vzvWklPUe5iCqUNkKm8LryUPKjN5+l2lIYV+5JUCGIoD+
	Olr2LNH8euFyKqNaGZfYdhh+jEymFbtKjXMo+3eBfKhsHnIeF8F0vQ7Ip28jHjo=
X-Gm-Gg: ASbGncv1PdF0KeCLGAgR+5dHNtaFJsTbNYkjYIVfBZCT+zcadfxKWd43CU01i3/6eGy
	tHqF+UgaR9NmTqsOXPGhWCxsO9+FEytqWaitfJIz3EjjGPE8st/wUDN5wRb2MDQyciF2Xq7+1Sg
	8Umo/c0umD3DXd42loY3YzHFXQx3ce+iCXnmX/OHXvd54Adfmqr2NoFV+2NxZDkSTE1bPsv9pNv
	ZGLLpfpi0Kwk9bt3L51UnSn6hdxXEik3JaCJOmww2yUs9WMI9qSrWqE6J2DZEGjhq1b5taCJLjs
	LMKAFh9Bzv+Xcc2h9FJskcWaUfthw6Zn0IJOGdJZjLXNVRWNEw4h
X-Google-Smtp-Source: AGHT+IFOfWm9sA+tBwWhqqwmy4uqvJdg4Cmb7v3gPA1NaW7kkEAVPWo6zRGWCJs9b+QrumlHS9MUmg==
X-Received: by 2002:a05:6820:825:b0:5fc:b489:6cec with SMTP id 006d021491bc7-5fd194de281mr893707eaf.2.1740087829046;
        Thu, 20 Feb 2025 13:43:49 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcf2e2c385sm1637668eaf.10.2025.02.20.13.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 13:43:46 -0800 (PST)
Message-ID: <b8c43ee5-ec88-4dcc-9926-38764d18efa0@baylibre.com>
Date: Thu, 20 Feb 2025 15:43:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 10/17] iio: adc: ad7768-1: Move buffer
 allocation to a separate function
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <d78aba0d188119bdfde7cb91041229ba16e8eeea.1739368121.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d78aba0d188119bdfde7cb91041229ba16e8eeea.1739368121.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 12:17 PM, Jonathan Santos wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> This change moves the buffer allocation in a separate function, making
> space for adding another type of iio buffer if needed.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


