Return-Path: <linux-kernel+bounces-537354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F0AA48AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBB916A258
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B20227129B;
	Thu, 27 Feb 2025 21:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NchOCmf6"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B61CEAA3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693261; cv=none; b=hXof7rQgraGQRVJW4FXC1Txk7PbGAzvDT1MH1Si1Yygz4a7NXYWCG1akIBi8FKBo9RU3X/kRS6tDWidkw6E0p7Yd+YRfnk9Up334qx811NV032wkwKewlQCqqleqPiNE7/dUwu0ke7dG5u49i8ZadzSqn8nVmIYt5SMB4FfW24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693261; c=relaxed/simple;
	bh=vQHbDRJK2BUW3sVk844uq3TqW7P1kixXvD0chqN70M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EecN5xyOAt/nbPLP1EzexG8gIQ5RBXMkwOe0XEzItmV/QiwuVQjoZc8viNSRC2cHnA7+YpIS5w3DUXMHKsoEje0yCcfgzo9Pn20m2lrbVp5Neag8KVA6sVzC8SHRu81fqChFrt7KUL1sjQcFUIyuNwb7gZT9ZNxAtZmOibiU1Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NchOCmf6; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7272f1de42fso860911a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740693257; x=1741298057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/hXAHCtNLeAWG63+hcCl8SC7KoqJ0y7pVArSY1JtLE=;
        b=NchOCmf6bMHnnHxl040Lq65ldRvmeF/mYcjC5nT+hsvtK6qv42bYpS99G0bAjOJTap
         w8w94ygtA3AC/r34AY8yKXmM7BFHDRKAEe0B8oklM3AYnzu8RaPVtJye1MH2hdq4PSBI
         DyNWr2e+BMyWKCqzAYiFvkt26qAzVlfpOKZ1bls/sZS/nSdOrqx/uiK4+mkVvHE9HN2b
         swBdS4tM8H43/opyqAp7naksuCu6SbLoDl80Y/iL/yy8H/vCaJ1hn7BO1IZx4otdUmJl
         kNWqicHO9OlFW+YNOItI8kF8Ovi0BVYkSFbs6EuQZbzPSOhZQQ6H0bl4EVrP34c9sps3
         9HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693257; x=1741298057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/hXAHCtNLeAWG63+hcCl8SC7KoqJ0y7pVArSY1JtLE=;
        b=IqXmTHVFYP//HENHKGoC96x6MMW7Y9cF3A4sXazafdmobOnCXCPKgWLMFHDNiSd+2J
         v5DX9e1KSao4N+Pe54vdVFrPpFM5ca1Hmtj/ayqBFsOD0nYRWOhEijQwVSRnS1H9mOfG
         Cfu9M7YAF7ifDYLRd3WsZtnOoTSLvEpTbvTIW18fGkIkXAosic6oNs+zoul66sEqiPq2
         JMgxdscTiF+LH6vlbqoxwqzECnbjGjW2MJAMqMJ3TXsWOCpHZO3q1oc5hoNwaLLpvzom
         eU6wPsiHRd0xXXLwyi6dJIB+qK1MmxPQ121+TmeGTBANs/nuDo25K8uPHHAi+zV1VW9d
         4nGw==
X-Forwarded-Encrypted: i=1; AJvYcCXj50hfzzneJKauK/mJMsUxu+JdM21HDZnpQurzaPWuOx6eVEJKkmh5d6Ok33rpdVHXKKfxDrbYiu/2cHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykEzcERWb7MAmIexLrBvZMUmF/tNHb9ie9f6G6BXlvoP3PAzW/
	wV9ZxHFB+xbkrwTos8V4W7Ks/8dNgLdVHQAEBFUluKMuMNZENCrtXpWy8lUdE8o=
X-Gm-Gg: ASbGncv5wi++yrLcYEXKKLKi8KG+GXnBjxCN+usynGWVQDTFJMDWc57jfZNajVihQ69
	OGgMCKIQE2YekfBposc1fyZnwr3xQskZIQnfp8RQyVFHe0gy9bVH3j4WkMHkuOvWEPKxL3Bh1+A
	AvIc3tsP/xfxqnExd+PhefIUuuhca6TAmEUd83BIjgHRFVrNG1+5bfnScUzKFy7lcl6GGgE7YcH
	XtnDQmWMD6ddFRrhJFMYQo4xcLp8uLjWSwBAC00hq1JB6Qk2M/Gk46J6sPHRDc1I7ckPtquGr2g
	B9oRRmE5K8hPI5esecVaPhO0a8qrl14F1kFD5n96YmVfhUMKl2tmZ5P6Tqa9540=
X-Google-Smtp-Source: AGHT+IGX6e+UTV3fnyRf7e6ZqTStb+426CrDeWO0t2ai6r0zce8y0wyvZGrnkjPKj62Xq0Vh0eHNCQ==
X-Received: by 2002:a05:6830:6505:b0:726:ee0c:57e7 with SMTP id 46e09a7af769-728b8306535mr539540a34.24.1740693257155;
        Thu, 27 Feb 2025 13:54:17 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-728afd76cc4sm404845a34.42.2025.02.27.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 13:54:15 -0800 (PST)
Message-ID: <47ae0fa6-8005-4c8c-9409-3189ba6f42af@baylibre.com>
Date: Thu, 27 Feb 2025 15:54:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
To: 7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
 <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
 <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
 <Z8DazwTguF/gfKW1@JSANTO12-L01.ad.analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Z8DazwTguF/gfKW1@JSANTO12-L01.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/25 3:36 PM, Jonathan Santos wrote:
> On 02/20, David Lechner wrote:
>> On 2/19/25 2:34 PM, Linus Walleij wrote:
>>> Hi Jonathan/Sergiu,
>>>
>>> thanks for your patch!
>>>
>>> On Wed, Feb 12, 2025 at 7:20 PM Jonathan Santos
>>> <Jonathan.Santos@analog.com> wrote:
>>>
>>>> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>>>>
>>>> The AD7768-1 has the ability to control other local hardware (such as gain
>>>> stages),to power down other blocks in the signal chain, or read local
>>>> status signals over the SPI interface.
>>>>
>>>> This change exports the AD7768-1's four gpios and makes them accessible
>>>> at an upper layer.
>>>>
>>>> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>>>> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
>>>
>>> Is it not possible to use the gpio regmap library in this driver
>>> like we do in drivers/iio/addac/stx104.c?
>>>
>>> It cuts down the code size of simple GPIO chips on random
>>> chips quite a lot.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> I think the answer is "no" since we need to hold a conditional lock
>> while accessing registers. Namely: iio_device_claim_direct_mode()/
>> iio_device_release_direct_mode().
>>
>> Unless we add some extra stuff to the gpio regmap implementation to
>> add optional callbacks to call these. Which could be worth it given
>> that quite a few ADCs provide GPIOs like this.
> 
> Since this patch set is quite large already, is it worth to do this
> here? if you say it is necessary, i can try this.
> 
>>

I'm a big fan of not trying to implement every single possible
feature in one big patch series, but rather splitting it up.

