Return-Path: <linux-kernel+bounces-380195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8DC9AEA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7219281525
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E71EC00D;
	Thu, 24 Oct 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ueD47rt8"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9591C8788
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782811; cv=none; b=maxNy6bGnyh9FsGh4VLE8QFQWmD46vovYXQL/Xtu3M/e3oxf3DqPTwpxRgh1BUQ+7idNvZskutt0GH+mqxkt/VUEcf1dc8zIZogKmGcYnWixXEdIff2xnSeHYS9Cjlrm/noSfdqmGhmpJyTbycvb37iS/y3uMzbGdwJt7sfoAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782811; c=relaxed/simple;
	bh=8OXMHfKwXNFd7LmH/a4GndUZUNcRvsUGK8/koqLYQo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIeHZZRLVf+6PCVzZ8P/OByOUjd/dH6y2cVafq2rh6vOmm4C9nIp4u3gfE9SygS2eHGAzgm04rHCGo4Tp7poRnqFk4QKd2ZQJABpBt9XYeRv4804+xB+xHW6wVza5HbHldwVY54CF6655H9F81Em/Z9uO2elLfXc4uh7UsVYmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ueD47rt8; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5e98bfea0ceso489740eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729782808; x=1730387608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fd0iDovBJ0d/hwyt9t5TzW4nj1RKDhGA9pl/sSbDpIc=;
        b=ueD47rt8B/4+gxN6LBiwcWmIZW7wWuCfC4TxB05lwWIxEG1nneqalZPaOOUzRa6Va/
         Zunp9gxyiEJMIOXEtqsIXriyzH0cUrpr0gksUEyeCMhdTGXdyFokx2oR/wY2qNNdFLKG
         FjcAhlPB59boWF+9s0Fd2Q5oNNcisHGNfyVilKKSyYhXtJux5csCk2fM/yYySpxlo2m8
         +sjOrvAqSonmc6LkQNKOtPG2am1y+BOcg+zVTzEGTh8O2UV0MeKIqrn63LDORh0ltsEd
         awMJwnibc2rkDaVtptV7JeBNI3rOkFd0aJCGiIgNa3aR2ZPo8xc8aEwgJukCk4zA+kiJ
         rmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782808; x=1730387608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd0iDovBJ0d/hwyt9t5TzW4nj1RKDhGA9pl/sSbDpIc=;
        b=QnU5pgoRUIRtYLS+xDpwQgZqH+GQ/iRH47f3dgrDXZFS0GUCm0L6eIFo7KbXja4tvm
         uWG6x3kGa7mxmPM8ZYTBqtXUyj5Y0LywYoIV9EEMOHtU91lNLyTojAWtGFEeZWn2Io+V
         +9HwtCDYs6MHzBStkwCvIykZp3qa2wcSjM6bXWGgoOVxvUVlJ68p4lnbJH+AajJOsVMQ
         hGq/7IxkogzOjYKuQ0TcwdIjenYoN4PfpoXA+Koad3EEWtz2K+pTJRSFs4KtAra8ptnL
         nBT6RoZzmedHDMyzpjkIy+f6DL8x7KiufRQ+WRaIcLzKU/MWy8iBJWPkgjL94I8HAvqP
         KrCw==
X-Forwarded-Encrypted: i=1; AJvYcCWIfBTs1AL1xVXs64dFh8XKDq9SBw6OYuiO+1r0DnnSG3ImbqD8V60TmEpuzIXDYoPQxS+DPyYjY9NAfSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmH+9kCsOsKX5tSkQdtFAwMjZrxSc/vTIJSl2b/QWYWM72VwsC
	KolBtl4n8L3k391EI56RdVxb7KFB1maCBfA050pd5QuCnxqXq/cBaBtHvPGokPc=
X-Google-Smtp-Source: AGHT+IHUs1ILvEchERhevtw0FSAS8U+VdD9+RUaorNqTllSmxFejVAbBw/+53oLTFljWYCql6cMVEw==
X-Received: by 2002:a05:6870:1cf:b0:277:d360:8971 with SMTP id 586e51a60fabf-28ccb6a104amr6491523fac.43.1729782808158;
        Thu, 24 Oct 2024 08:13:28 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7182eb3df52sm2157342a34.18.2024.10.24.08.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 08:13:26 -0700 (PDT)
Message-ID: <f70854c2-8006-4278-b149-6d8c3e76b30d@baylibre.com>
Date: Thu, 24 Oct 2024 10:13:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] iio: dac: ad3552r: add high-speed platform driver
To: Angelo Dureghello <adureghello@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-7-969694f53c5d@baylibre.com>
 <9f00e86e8a7d8f821cdb79d5b083235daec481a9.camel@gmail.com>
 <exprb7zhsr5qbpjdhbxisodmm4pf74hwl7ijql5o6zyuc3assg@sf53j42lzurf>
 <14d0f5fb4240a7e0c3665d4ffc128117c5515ac6.camel@gmail.com>
 <wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <wvnyqgng5h2trpjlrwuvxryvy2i7sftnribnkjp5uh5ogrxdoc@wbh5do3rmqqe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/24 10:02 AM, Angelo Dureghello wrote:
> Hi Nuno,
> 
> On 24.10.2024 15:05, Nuno Sá wrote:
>> On Tue, 2024-10-22 at 18:40 +0200, Angelo Dureghello wrote:
>>> Hi Nuno,
>>>
>>> On 22.10.2024 14:28, Nuno Sá wrote:
>>>> On Mon, 2024-10-21 at 14:40 +0200, Angelo Dureghello wrote:
>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>
>>>>> Add High Speed ad3552r platform driver.

...

>>>>> +	switch (mask) {
>>>>> +	case IIO_CHAN_INFO_RAW:
>>>>> +		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
>>>>> +			return st->data->bus_reg_write(st->back,
>>>>> +				    AD3552R_REG_ADDR_CH_DAC_16B(chan-
>>>>>> channel),
>>>>> +				    val, 2);
>>>>> +		}
>>>>
>>>> Maybe we'll get the new stuff in time for this :)
>>>>
> This is not clear, sorry.
> 

Probably this :-)

https://lore.kernel.org/all/20241023105757.GA9767@noisy.programming.kicks-ass.net/

But it hasn't reached the stable tree yet.

