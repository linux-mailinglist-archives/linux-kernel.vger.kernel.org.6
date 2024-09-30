Return-Path: <linux-kernel+bounces-343570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4030989CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A54E1F22366
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1317B516;
	Mon, 30 Sep 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKVgvIiP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597C17B4E5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684882; cv=none; b=GXISVQ3oIZrWb0ykN0NZc5FlQ3flah2qpClleljh1t0FxM1+uzgXVG2TO0B1YzOx7bI9g4BFdejagMohRgJ9zyVvrjORocXTtl52pDzy65knhB6V0YrbDH/rdu+KMKGf7dLXCFbgL2ZTpNfD4xPMCILH5SJIRXveKa/BYz2zdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684882; c=relaxed/simple;
	bh=/KD4yic1tli4acL5VBbKB1+MQngCqbT0zGDn7ckq8Ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUKVOBLdpY69UwvRDwWai3ECJ1iH86fM+UvsOBwVCV+lzsVlB0m6Sypw/SpGtu94+yPEmfxIc0ofe75JcVaDs31ZSNEWSqB3+b4Qr0R3Y3WzWvCePKMo3FUbLG9e9oFLhsln+GLQ1LsgliQfbss+XwIweuiC7he1I7LWAVYZm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKVgvIiP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727684879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sDU+RimjAAL3vNJr/8wALHfm0p2c+7kTQQWyP5C3KLU=;
	b=XKVgvIiPf7w6aOsAd/tlbffNnKIPr/JDz54pFYRRH0AqAy3clclOTsjPFiXQl1Z7s6q2pB
	mIwfyd+g/ALvIo2g10PPhxa0+mxu52HJm+YdI9H9cAZwm3wF76T/fXHNc+wiEa1ThxKiSt
	uL/XWzXbXLXp/xt0WUQUhR6fQi177GQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-daGLRTr-P3WY4yNIsIlNcw-1; Mon, 30 Sep 2024 04:27:55 -0400
X-MC-Unique: daGLRTr-P3WY4yNIsIlNcw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8a92ab4cdbso327497866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727684874; x=1728289674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sDU+RimjAAL3vNJr/8wALHfm0p2c+7kTQQWyP5C3KLU=;
        b=uY0YlEDNYBV81AA7pjO1qHodL+xSMhuLPkDhXIxle7J0u0eqTwTjDkovB3TIFq2uIr
         8W/Pu2wU0iljFAbPIAnizQLzZ/P52QM1zJcLoALGz/WzXSTcSBN0OD+CUjctDta3O9Co
         e0BirRXhs0KSh7tWFR/emT17vPE9ehN/5ESmkWUz6U41a+LiUO1mIIJusIjT8rrzrWjm
         mQdb7yH0jual3A3cDTZ05yC+JleFse+Nl7uG6p/P0+Exeq0I15K5dnxZdNP9GN5h3ROq
         1ABm/ABVlavuddLshJy0g0Dt2NEXCrMTyNdIMG75BZPSjV1a1ju/gxqR7NJHJYv0EKKI
         yAEA==
X-Forwarded-Encrypted: i=1; AJvYcCXf0mW3Mcpz2kyCeDoKzF7YvuN/QJWoeofXwhiuqkFq8qwOMh1XZm2nISaDnfwO1v3ll98Eu8w6EjH2iGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbwbS4aUoY2s3ktNttplrJiI8rGv4d5M2+1I4sM0XlOxXwNUp
	NAGlDuDb6M0laM0m7e7bo/j122EK7dvBltIIV0enJrxofQX+kDlf3XRfLvX6qoMDZ3SHsQcI3bJ
	9CkKzMvDaBh10vLgS7rl/DjEOehVnL5y+4ejA/GeuTZvbW+cn6tBjNHF89ZpQug==
X-Received: by 2002:a17:906:dc92:b0:a93:c2b1:738f with SMTP id a640c23a62f3a-a93c4ab15ffmr1095639066b.64.1727684874221;
        Mon, 30 Sep 2024 01:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOA2SnqaGeHXSaIOulX3uQDWKXvptoCf9oRU/ysVfNevdX1YHCxCHWYLJbVMXdwwUmeF1lig==
X-Received: by 2002:a17:906:dc92:b0:a93:c2b1:738f with SMTP id a640c23a62f3a-a93c4ab15ffmr1095636966b.64.1727684873884;
        Mon, 30 Sep 2024 01:27:53 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2946f78sm493359966b.110.2024.09.30.01.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 01:27:52 -0700 (PDT)
Message-ID: <8062d702-9426-408e-b3e5-3a33d81d2927@redhat.com>
Date: Mon, 30 Sep 2024 10:27:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] media: atomisp: Use max() macros
To: David Laight <David.Laight@ACULAB.COM>,
 'Ricardo Ribalda' <ribalda@chromium.org>, Benoit Parrot <bparrot@ti.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bingbu Cao <bingbu.cao@intel.com>, Tianshu Qiu <tian.shu.qiu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andy@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
References: <20240927-cocci-6-12-v1-0-a318d4e6a19d@chromium.org>
 <20240927-cocci-6-12-v1-3-a318d4e6a19d@chromium.org>
 <c183afe8986d444a8e777ae0b9bb9189@AcuMS.aculab.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c183afe8986d444a8e777ae0b9bb9189@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 29-Sep-24 11:34 PM, David Laight wrote:
> From: Ricardo Ribalda
>> Sent: 27 September 2024 10:42
>>
>> The max() macro produce nicer code and also fixes the following cocci
>> errors:
>>
>> drivers/staging/media/atomisp/pci/sh_css_frac.h:40:17-18: WARNING opportunity for max()
>> drivers/staging/media/atomisp/pci/sh_css_frac.h:50:17-18: WARNING opportunity for max()
>>
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> ---
>>  drivers/staging/media/atomisp/pci/sh_css_frac.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/media/atomisp/pci/sh_css_frac.h
>> b/drivers/staging/media/atomisp/pci/sh_css_frac.h
>> index 8ba65161f7a9..9642506d2388 100644
>> --- a/drivers/staging/media/atomisp/pci/sh_css_frac.h
>> +++ b/drivers/staging/media/atomisp/pci/sh_css_frac.h
>> @@ -37,7 +37,7 @@ static inline int sDIGIT_FITTING(int v, int a, int b)
>>  	int fit_shift = sFRACTION_BITS_FITTING(a) - b;
>>
>>  	v >>= sSHIFT;
> 
> IIRC right shifts of signed values are undefined.
> (C does not require a cpu to have a right shift that replicates the
> sign bit.)
> 
>> -	v >>= fit_shift > 0 ? fit_shift : 0;
>> +	v >>= max(fit_shift, 0);
> 
> If the shift isn't done the return value is garbage.
> So the code better not let it happen.
> In which case you might as well let the cpu generate a (different)
> random value - so delete the conditional.

Given the history of this code I would no be surprised if some
weird corner case actually relies on the check, so NACK for
dropping the conditional.

> 
>>
>>  	return clamp_t(int, v, sISP_VAL_MIN, sISP_VAL_MAX);
> 
> all three values seem to be 'int' - so no need for the _t variant
> and all the associated casts.

sDIGIT_FITTING() originally was a macro with a bunch of max() + min()
calls nested leading to it expanding to a lot of code after running it
through the pre-processor. When converting this to a static online to
choice was made to with clamp_t() to avoid the overhead of the extra
type checks in regular clamp().

Regards,

Hans




> 
>>  }
>> @@ -47,7 +47,7 @@ static inline unsigned int uDIGIT_FITTING(unsigned int v, int a, int b)
>>  	int fit_shift = uFRACTION_BITS_FITTING(a) - b;
>>
>>  	v >>= uSHIFT;
>> -	v >>= fit_shift > 0 ? fit_shift : 0;
>> +	v >>= max(fit_shift, 0);
>>
>>  	return clamp_t(unsigned int, v, uISP_VAL_MIN, uISP_VAL_MAX);
> 
> as above, but it is just min(v, iISP_VAL_MAX)
> 
> 	David
> 
>>  }
>>
>> --
>> 2.46.1.824.gd892dcdcdd-goog
>>
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)


