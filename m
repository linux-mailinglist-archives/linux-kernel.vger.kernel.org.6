Return-Path: <linux-kernel+bounces-432458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CD9E4B72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839A41881207
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE091B59A;
	Thu,  5 Dec 2024 00:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fYKcZfQT"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC621401B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359581; cv=none; b=Cp8T0dSJCpgOmwrbsXimvkDO2lkfciEK+lco9lms1HgkA70EtSPwlLXjFGK7DoapS5RpqcM4eOMjBpug8b0If4DSVBaSiDSkhJ/SudiBucZhppZ9vN4vsQmgTn/nTraT57xUHlCu4hBi/uL7bhF3S9M1XGga15Cdabp+kw7zYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359581; c=relaxed/simple;
	bh=2z0iKqJu1GJejrxfok3jyqtqP1mGC/thUx+YN2pvhFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiMYkkXFSSQ1NC39GVnYUJeCKLmRskrYf+VVTAtraPZuQyKZ0WhSST/tX/EkM7JTvB8DgRT0udz6e1PE2kx70oJgY4ciyQo5jrNxBLmrzKk/6+Q/PqMzEo6lVyyVCqd7AHoYTg77Xs0k17TW4Z0CsoBQBytx2WGYOLJzcTNro88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fYKcZfQT; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71d54fc1944so244123a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 16:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733359578; x=1733964378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qStXvs/zcX62n3zX8u3CLNYt6qTW8moFcPaeP/VvQ0g=;
        b=fYKcZfQTZW+BlrkODYqkYVmGHmTckIv80hIgqzDDEOfUuyVyI8Tf9IjtlJjPEkXeAy
         oCyGq5S+dq3uumw9juQBIXaXX6KVC4Ed+lpq/+2GujmYcKEZdZBzFQ9Ekkwd0bQU30Mv
         LPOAKZbJKnsGWa/s3Y9vX9qf8/j96ATjNJRB14uJJ+LWKMjHxc7cUDFJUaW4hgXoVCk5
         1SX6kWjP8w9yr3fW+nV79pkJDz1U7gPqqOuN9nuBhfGwIdBtQXrfdVEK7jRiNRbk8M4w
         C78X61/giJ73ZJfJbN84EC8+dOazw+WNQkf1CjE8kwgaGzkhajrgD3cGz8ZIxAN4oiCX
         Zlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359578; x=1733964378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qStXvs/zcX62n3zX8u3CLNYt6qTW8moFcPaeP/VvQ0g=;
        b=AJVUIV7QX9UO+KOy4H+9G5aOt3bG+Pze89D+tAxqLEAns/E3ZZyoIC58geaRER51nO
         i83Af6M5eXQHwKzQCcy3cqDXIIRmx5KqB7aKzigSzMoXzWWB4csxiAIQb0W2nCGD5bHd
         yJ3HIprNS77EFQYGP58XSswIxbBhOxRO3OJf9H/GtB6tr6popAImXoec7OtfKFKKVn/m
         dMRDT7UNXO4/N5KcB5Cil2FcRTXWukRiCD18VDhtpSCkGf0gkGMcicpXajS2ApLd+1Xs
         F8DwV25xfY2QqMyj6mt5IhGblXLkPRpT+/4yDZYYln8ep8mJM8q69xkP70GWqKv4H6Xh
         n9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXneEAt+t8o6G5xXZsIPkB0TrzEqhAWdDzJ+AOhfk4B4wSBVTJhTi/nusDTFm85eW1g1RRsbu7khwMNpNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz079IFhM4+KuDHlireKyWdX5Lf/SnSxM6rCkpV5pE4ibczaV4s
	aTuSxQCo9/QI8zZ4zqbzvh5HmRxyXyxrMeSb6fl37Ph2ybrWOnwSLRTfxBxhWX0=
X-Gm-Gg: ASbGncvBgtO+KvmrpNRYVUCE8bELvNofad/5nRz/099DsVmoWm+aiIJVtwKeAihAqqg
	lUe2TO231E0W+XJz59UKSf4BSt1CrEaU4SaMVASnuX0hUx53l9Kx84TWK863TV3iF8YCOR343du
	g3/iDGlRzkAdqfgXuMknfMyDH0ph2K2yNHu9wfBVG61udqJAGEnvb/tQ6jPfI9BKkKwyAdZBAyS
	hOEDvybGQ51P/MoCnY/CR9ycg/UoQjj4hMp2W0suzLNWdE8E+wdvB/mkhKpiBh0dihyc2jNkUCC
	JeUWZgq0TzM=
X-Google-Smtp-Source: AGHT+IGnMa8pjHhI6ipUO0fiWTjR601DUJqqzeZSFC1UmSfdr9z+Kj03mH/trfcErz+eVgRfBurCog==
X-Received: by 2002:a9d:63d7:0:b0:717:f666:9559 with SMTP id 46e09a7af769-71dad610a7amr7951902a34.9.1733359577951;
        Wed, 04 Dec 2024 16:46:17 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc493b027sm111901a34.14.2024.12.04.16.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 16:46:16 -0800 (PST)
Message-ID: <2d760894-bda5-4000-9598-914b830333a7@baylibre.com>
Date: Wed, 4 Dec 2024 18:46:15 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] dt-bindings: iio: adc: add ad4851
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
 <20241129153546.63584-8-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241129153546.63584-8-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/24 9:35 AM, Antoniu Miclaus wrote:
> Add devicetree bindings for ad485x family.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v7:
>  - add adc channels support

What is the reason for this change? In a previous version of this series,
you explained that we didn't want to specify diff-channels in the DT
because there was a use case to use channels as both single-ended and
differential at runtime. So I am surprised to see this being added now.

> +patternProperties:
> +  "^channel(@[0-7])?$":
> +    $ref: adc.yaml
> +    type: object
> +    description: Represents the channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        description: The channel number in single-ended mode.
> +        minimum: 0
> +        maximum: 7
> +
> +      diff-channels: true
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +

