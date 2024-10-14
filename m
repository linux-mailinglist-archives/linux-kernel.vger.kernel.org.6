Return-Path: <linux-kernel+bounces-364805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B156599D9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29761C2148A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3081D1E79;
	Mon, 14 Oct 2024 22:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lT+tEeVN"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FE61D0F61
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943731; cv=none; b=Y/T15g1P7ojvXVkXmFPKu0bkDS0fQ1LTv/xbn374eAVTYtUeGBS4SABWDwe8XY2I1hB9joiDGuEQmYCEGyfGg/fcPJ2UwyDcRd3C5RthPq/EzVVttfKVUnEUrifEyy14UyTPbOfDd0q6ohPizj6H9eUkmRevN0hynzGO+2WJ3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943731; c=relaxed/simple;
	bh=RwiWGV2rzLk4cT6vGo2hf7iXveFtHH9FPuvO1qveBSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a95UZmad7tIC9TBhLHM5/M6ocz4U7Huhix5IQbeG9/olU/8L8DH3/n6cQKm/EG+r/JZtz+E48m9+i3O34SnTqFOUvptfbVu2r+sndlvuALgZJTAZ09sEL5HzF+kT2daCJ2ZOgf/zWAASmQsqo3HdeLTpQ/DyWEOEFPwq6Zty/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lT+tEeVN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-716a7fabf31so1501356a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728943728; x=1729548528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE71Pg+9qQgmK3mJbmPthhcZO1J5ofFDM3FllRmUogo=;
        b=lT+tEeVN0xGWgs+x4V9vNAiPWxKgu1AV3NjGgTIrMBGIXOf9+MhPnUKn1w9Q5QnPgU
         LQ/Z6dcbU1eYPKyXskY/O37o6ts3TRvVT9MXhf0TNXCvaPhA+jnUe/ta2i47mxVN+F/o
         wdSRHBLIYBx6837VAgQkbrwhCgl+J+0ASnprk/URj03MpbYCpRxwS+KNw+OH3sP4bi2N
         9plioMKvVNGuPbEh9ovOa0OoNUFPMrrulp0lVt7kuUPg3/TrCBKXT49FGLTyOlnVxxNL
         p3+AH3FV+Otvi/Hqhn1bVRKSIID056yOlCNUasyj+lmK/aR/pCcjKRB/m2Kc9e805QDp
         +3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943728; x=1729548528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE71Pg+9qQgmK3mJbmPthhcZO1J5ofFDM3FllRmUogo=;
        b=qnM4MvOHMrehHmcTHhKQgRK1txJZPxDCltlMmFizRWzqdwRh78naM+bXW2UN9z7RpV
         qW6O6cmky+N95bttOA4viNFtuxWm2FR4Pr0b+BaAlPTSc6UsU+Fptz7SQLzEgThlQ7f5
         AAB1UM1QJOQskTVtlWM7xfzCxOqx63LsjETTRoli1skY9rzXF1Z3WpIsxhmySBSQ1BIZ
         uQdoYZLyROJWgsvZ1Bm3sryxcNMJmmRv0h/ucuKgY/Zok0uyssroicQd3VRZ6EpfCoyZ
         Hkk6LASoYoGpg/t/FoHgZ9zp4GzeYGk5ohfQRT/MhhTjEMiGlCtD8GDCX/isLRF1zp/i
         TMLA==
X-Forwarded-Encrypted: i=1; AJvYcCVqLIvSol0Yz0Lxay+lxDFBdtfeWgbdog15hfffrbZh8bKnFEXBHEym/y7KOIIdctqxJ2vYW+F3t8UQUbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAyi569YFgkkhbJM/vxcD+e01E84H1gpcB2hJiTg95D9DTmZF
	XCV+JLB/OgAVsFVKnH5OdvHO+qmVp+/CkgUbm3xe/n/AfuI6B0umADtEKnrhZoc=
X-Google-Smtp-Source: AGHT+IHJnl83Mw1D/U95VcdXHn7KiobS+KbDMYq68e+4vVzo3kcSL5k6sBEGoQjwDIdvMPPL4KFOQw==
X-Received: by 2002:a05:6830:65c4:b0:703:6434:aba8 with SMTP id 46e09a7af769-717df1e1178mr7335220a34.0.1728943728669;
        Mon, 14 Oct 2024 15:08:48 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-717fb9f022asm13921a34.27.2024.10.14.15.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 15:08:48 -0700 (PDT)
Message-ID: <c70139f8-c0ba-4e28-9477-964db3fbfbba@baylibre.com>
Date: Mon, 14 Oct 2024 17:08:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] iio: adc: ad4851: add ad485x driver
To: Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marius Cristea <marius.cristea@microchip.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
 <20241014094154.9439-6-antoniu.miclaus@analog.com>
 <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <Zw0ZM0vQXJep3dFJ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 8:14 AM, Andy Shevchenko wrote:
> On Mon, Oct 14, 2024 at 12:40:40PM +0300, Antoniu Miclaus wrote:
>> Add support for the AD485X a fully buffered, 8-channel simultaneous
>> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
>> differential, wide common-mode range inputs.
> 

...

>> +	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
>> +				  AD4851_PACKET_FORMAT_MASK, (osr == 1) ? 0 : 1);
> 
> I would do it with a conditional
> 
> 	if (osr ...)
> 		return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> 					  AD4851_PACKET_FORMAT_MASK, 0);
> 
> 	return regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> 				  AD4851_PACKET_FORMAT_MASK, 1);
> 
If we do this, regmap_set_bits() and regmap_clear_bits() would
be even better.



