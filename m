Return-Path: <linux-kernel+bounces-422193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B518B9D95AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6F28509D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112C61C8FBA;
	Tue, 26 Nov 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xMxj/S/t"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CAF1C4A13
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617462; cv=none; b=bzFJrFt9JdIdyCE+257l3QtIRBueW8pxf+ajfFVErgNQMX5KRJGjM1W9DauqywYnaD9oCB8wzlAUIrr7+imTkhDqD3Fyz03C2El9Jo13s29nrWAn6YBgaJ5xaZ4Yn31e6l9BZgWF0DoB3EGIHWkybHmavdmQ0pa4rGHsEmR5PoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617462; c=relaxed/simple;
	bh=bsvH9kSUCwHWawfblNJ3PAi3vG5GvJUBddlpJRrsx3g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=G5iBBNytFWy9JCZ64xbaBQ2jxKpL6SYflltCEbFbUFKuYXfaLymBZtiwoXI8F5Mw/PJoFkhqkZViaUvJYE4t/FAp6tfXZb1fzkEzAb/vUR/oraAqBLYtJz2c3zDbv5V/YUNe/8Hj5qIq/CmsglurV7Y0H6TVCrg9L0zilzpzwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xMxj/S/t; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53dd8b7796dso4004796e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732617457; x=1733222257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL8n6YXE9oeQeCSKnUhWjhtX76X8Z5GX8Xt7bIlqK5s=;
        b=xMxj/S/tOPbUkbqCLLckSQb5XvgUMAJfI2BfNGc00Q775+EYirZitoj16d630Y9gWT
         TWdvQibP0Ef8eStRRoeVtbp/NdlKkZo1Gls7JkLDT+aZkXbolf/vI+RlhJKvkHvdEoji
         5CCGTQSuNiaT2IwQ0gbDO5+8ahH1S4im04Z4+f9cfl4rFEtfGUpb9w0mWDsdqjASPMHd
         isF+Uf8EQnHa7XSX86QQD4Tzmx+kPzXS/W8aFv+ypRuLOQh5B7xoOV5b2JB6i36ayCx4
         3M4u+kKZJvry9z9YniN2zuoloB1ZucvNiw+Xit7WpXun2fcVQVWtVWgv5cPVpDR6Kif+
         upKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617457; x=1733222257;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DL8n6YXE9oeQeCSKnUhWjhtX76X8Z5GX8Xt7bIlqK5s=;
        b=tMK3MVX2XtazJ75CBSl0Nse3T1rkH1V/nygGALfQjixS2mfU1TgCoBjC0YLPoJGrVb
         1OSNuNcVKPaonxhEfTtQAzm2m++qcIZy3eO30eWHVHkPeJipbmVD+rEBW+ESblD13amH
         SfLmddZMtUBxKxcOpIUkvarCEI0JKCrfFxkIt+nGr9kt0s39hjmjaNKmjVtU/UcVHlaX
         PkUGPN8tfVP7etV8VVe3F9hSOow2qs+HG7kR6ehednZaV883UbBbzHftO+i52U28UPqI
         dg4gap6lpf2l44824tqP3U6dvu18+ITprG7ynDHggkYHjbv/Jxy9gt5BClbIN1ZTy9Lc
         Ohhw==
X-Forwarded-Encrypted: i=1; AJvYcCUy0sRtYjyNoxx+c59MRhH7bJwKxIBVTKqz+fRZ0v4eMz+gM8wdGCft500FA/KhdAaHj+wp0MJDVIcMFTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCV2y3z8Cj0tbBT8VZ3WiVybHAv0KEuhYmZFn23mtAHaEFc+AC
	g53gMADl6Ej48IIgk9F/KKuDbjSqMw4suPRtCyXBqT9YziB/UJFXGjWQUYSO5lw=
X-Gm-Gg: ASbGnctYB3GVy00PKvhqIRpBa3LQN228MFoj5cOJofe4JRezO6v3ggMeOPe499wGAwe
	oJO15UD9JXgjfIfHenjlKFhEODq2XwwWKB/jF3LvVC2ahbyDEEHsueZavsKAc+B6N9IeT28X+qy
	DVwW6IjiYJ2MifPG0JkPiqaiiTXoGpuJQhnaDlGXvik3CaHhPcypjOotZuSjJk+WYVhUJ5ItGNW
	EYRqr9EDq0pdeJENV6vjVN9aqeoRmMt7a5sLAeGoibEdHyk9Bb9sg5H7qPjECqfB6x2sZrkSI+s
	XXaDD3vx/GwThg==
X-Google-Smtp-Source: AGHT+IGm9T8BP8eFPLu32fca54MvgO0F+vLQWk0tpYQ0ycW//DTGAHcftsM6xJdvIIJ/40Jr4imMYA==
X-Received: by 2002:a05:6512:39cb:b0:53d:ec92:2968 with SMTP id 2adb3069b0e04-53dec922a7cmr947039e87.17.1732617457163;
        Tue, 26 Nov 2024 02:37:37 -0800 (PST)
Received: from [192.168.0.172] (88-127-185-239.subs.proxad.net. [88.127.185.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad658esm13229915f8f.8.2024.11.26.02.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:37:36 -0800 (PST)
Message-ID: <49fa1677-db35-497b-afae-caa5dccf3747@baylibre.com>
Date: Tue, 26 Nov 2024 11:37:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ASoc: mediatek: mt8365: Don't use "proxy" headers
From: Alexandre Mergnat <amergnat@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, Nicolas Belin <nbelin@baylibre.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20241031102725.2447711-1-andriy.shevchenko@linux.intel.com>
 <ZykbMlshvlwCaeGJ@smile.fi.intel.com>
 <d7bf7863-fd24-4f8e-8cd0-d84867a997bb@sirena.org.uk>
 <dad2ecb7-e624-49c2-a7d5-0ff53b6a1686@baylibre.com>
 <Z0RkaqfID9v0age_@smile.fi.intel.com>
 <ed50c130-076c-4697-9f11-fe602c7ca03d@baylibre.com>
Content-Language: en-US
In-Reply-To: <ed50c130-076c-4697-9f11-fe602c7ca03d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/11/2024 11:29, Alexandre Mergnat wrote:
> On 25/11/2024 12:50, Andy Shevchenko wrote:
>> On Mon, Nov 25, 2024 at 12:32:13PM +0100, Alexandre Mergnat wrote:
>>> Hello Andy.
>>>
>>> Actually, after test it, "linux/of_gpio.h" isn't needed at all anymore.
>>>
>>> That mean all added include in this patch aren't required.
>> Do you mean the driver doesn't not use types from types.h or dev_*() macros
>> from dev_printk.h? I don't believe this, sorry.
> 
>>
>> Basically what you are trying to say is "let's move of_gpio.h implicit
>> includes to become something else's problem". It's not what this patch
>> intended to do.
> 
> I'm just saying that I've test a build/boot with "linux/of_gpio.h" removed and without all
> include added in you patch. My understand is "linux/of_gpio.h" act as proxy
> for the includes added in your patch, my first idea was "if I remove it, build should fail cause
> of lack of other includes". I can understand these missing includes are mandatory, that
> probably means there is another proxy header ?
> Maybe my test isn't consistent because it isn't possible to clear all proxy ?
> 
> If that's the case, consider my review-by.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

> I've validated some include manually. Are you using a script to parse the file and raise all 
> necessary "linux/*" include ?

-- 
Regards,
Alexandre

