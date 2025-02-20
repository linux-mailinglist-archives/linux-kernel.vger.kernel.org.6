Return-Path: <linux-kernel+bounces-524362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9ABA3E250
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CE8701C96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2570212D66;
	Thu, 20 Feb 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0dHwAlgy"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D920485D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071811; cv=none; b=DAPu+EQ3lSB9lo/OTEFsWjbDdM2BUZXKj9vv4A5Fy7sCFlP56UHp8YFh4LEl7Vl25ZBeYplYkCqTE1B5vfffrqxc4OoqqOfttHjcgiqMKgjeniKuv9m4tfk9JmHgukExhUqSHVNZi5UcgYwWcFOu6MlTpCdcamiDujP3ilkmd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071811; c=relaxed/simple;
	bh=244XeKEKX+5A8ehxHdeeLmwJwhJA1rgjh3BsIfR/8tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVn80J7Z0QHDrtc6eGiwZjxK4DMKNfhxza9TOHTj9vCLM52qnYtCr7j9DtmVqIDfS17Xng19vFy4EuA9bxqbEzYhot4TLyJKLg+8/4R9G0dm++w8NuvPH89wPo8xwJTjvFMF/0mqJCuvxjWDllRpreSdAR+j0cwY0NuQpDzaj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0dHwAlgy; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fcd509468eso639209eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740071808; x=1740676608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcApaWVKSxQSIvLEEHhnSoFMNHumzt0nl4dOj28dnl0=;
        b=0dHwAlgykdXsqX1wYLYwXt2Ts6SA+KR2AVFl1WMrJgrYcqwb03g2FGq+gIlg79FlGl
         HxGhNcYVONWq8D+2KmxIXUuurbEKtF5vSXt6rNUzHDenwAPnne5yVzPmYKFhRUestJUt
         lnTuxe3XS4a+qI4UZdD/MqPZ/iSKemhkEga8k3sBjRsqEnrXSginVeTCQyBWYKjIrR1w
         9m01GH1SD5LP5gObtGkv2JLIRP8g7Rttsrfda6eFuGk8j720J9T5rKunXb0SrEsRTrB5
         PrpiTOkYk14eJuJrhMuJlOrg/UI8dDwO3e6bepwWbwqQZ92UqXDPipJ2wzSQTSeT1onq
         5YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071808; x=1740676608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcApaWVKSxQSIvLEEHhnSoFMNHumzt0nl4dOj28dnl0=;
        b=bpBqcc6qfqHWZ0yhVMdq5w64lpNUXVD5C+Bd6Dezy9zXYoN63dS1qZw9zWiiJl3Zkj
         6BpDFcWjjKoxM3Gbe8X3oCU0ZFSll6qpey48/9UhXNxRUiIOnkYhLMsY3V5le8NBicRk
         neItK6iSS0lzCYs8FL98RXDAKVqqIlLvRD4AY1Q4PxDFm5/BrdRYYGrj9aVSrfEtW8O+
         ibKWnp/XJokPyFJkui5PV/w/0C5GE9hp7UTNycTQLTngDVS68SqQ2G5H8UuSKZefAIa8
         I1Z9HQ0vmqmHuMiHnVdgogCiSJaDg2D8AO1VtsGIahphfW3AUg13NOs8aF0DEDbBrSM1
         urRw==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZzDue6wendTCN1kEVvY3cGYEnhW9XOm5E1ayG3F/mL9jBdQscAlG/XHprJTw87nBoZZgwSxCGe4e3zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2kJ/7wl7N8Ni23CKwpz7H5wMEMbmc3RI0Oxg1ZwbLwn5lAeE
	+w1HGxFaMj1HhYq3lqZFIBzqVNnLpWH28mT1tQ3/G9D5piD/Y7f8uyUseeBdLvc=
X-Gm-Gg: ASbGncuHEKPVufDrlkkpLIMOruCqRek1/MrtA2o00rmhZJbhAHFpRdkR4iDCYM+QAnR
	G/uPFnzhhOTUns2pIR3FT7r2n2lgu4IFUb50UzjJso/GNm/MGhaZBUp2V3G+84iIJb8hebr/owG
	zSLac0QCsGvvBaPuhgZA/Ceah5wIezpK/K7fYjUZfkn2C9mVwS35ieZbZqAcPBbxONk/DHxge+6
	pBxnLWCVKVnaxSRJ6jTXa1CC0b3wXw+3obOcvUojv5euz1O56Zdn4kVtEYbLFvm7H9wKH9kewpR
	aHmey8imijGhPPHLam31TGap4WCbc1NA4/LrAXBbW034gUSAGcn0
X-Google-Smtp-Source: AGHT+IFQ4fpht1GK2L64Lff/K3FzPWt1QsXeXeofzfatOKhBNQXj463x1jUtS3u3WnZ5Fb1+N2LaOQ==
X-Received: by 2002:a05:6808:3996:b0:3f4:205c:d9aa with SMTP id 5614622812f47-3f424701c1dmr163494b6e.21.1740071808115;
        Thu, 20 Feb 2025 09:16:48 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3da962049sm5144033b6e.21.2025.02.20.09.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:16:46 -0800 (PST)
Message-ID: <37dc5907-b04f-4879-8271-68e36a6a2924@baylibre.com>
Date: Thu, 20 Feb 2025 11:16:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] bus: ts-nbus: use bitmap_get_value8()
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Simon Horman <horms@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Peter Rosin <peda@axentia.se>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-sound@vger.kernel.org
References: <20250210-gpio-set-array-helper-v3-0-d6a673674da8@baylibre.com>
 <20250210-gpio-set-array-helper-v3-5-d6a673674da8@baylibre.com>
 <20250220101742.GR1615191@kernel.org>
 <CAHp75Vch7QKyT8Fbya3u=YrPR8z-2-mbWXjHyOwZ-fqcBjjm0A@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAHp75Vch7QKyT8Fbya3u=YrPR8z-2-mbWXjHyOwZ-fqcBjjm0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/20/25 6:06 AM, Andy Shevchenko wrote:
> On Thu, Feb 20, 2025 at 12:17 PM Simon Horman <horms@kernel.org> wrote:
>> On Mon, Feb 10, 2025 at 04:33:31PM -0600, David Lechner wrote:
> 
> ...
> 
>> But when compiling with GCC 14.2.0 I see warnings that values
>> is used uninitialised - bitmap_set_value8() appears to rely on
>> it being so.
> 
>> In file included from drivers/bus/ts-nbus.c:13:
>> In function ‘bitmap_write’,
>>     inlined from ‘ts_nbus_reset_bus’ at drivers/bus/ts-nbus.c:111:2:
>> ./include/linux/bitmap.h:818:12: error: ‘values’ is used uninitialized [-Werror=uninitialized]
>>   818 |         map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
>>       |         ~~~^~~~~~~
> 
> Heh, the compiler is dumb. Even if it's not initialised we do not care.
> 
> ...
> 
> Wondering if the bitmap_write() will work better...
> 

It is already using that:

#define bitmap_set_value8(map, value, start)		\
	bitmap_write(map, value, start, BITS_PER_BYTE)

