Return-Path: <linux-kernel+bounces-394241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B039BAC53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 056C5B21855
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190DE18C02F;
	Mon,  4 Nov 2024 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3vrlsfg"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86E189914;
	Mon,  4 Nov 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730700421; cv=none; b=ozEH45Dt75hvhwK1rdYSXfrtAZ+3BYKK66ITZxFCjFpfASmmvIktveOwv+AdJzeDg89V/nbqqEazXYAs3lomQ4BPXwb0JOIQElf4iB9fuhzZN65lXpxA1fyCBm6VL96Nx9UY7xrFaYZzw4WAoTpxBeOEcm970L0X4tDmn3/s8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730700421; c=relaxed/simple;
	bh=EZnJdlfz5hvZ6tAgtg48RQwQz7DoCasQ1QKR1j1/LAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/0LUKsytw4aQh5QVM/NmrQd3AVf2UiGwYpJCNcV2G1zpfLayNIBJ0lnE26WHUj6lDcZz294y1thqnwyJvjwQRz+oIUEVOt1Vl0RTE0Vr0AAwzw1FXV3NRlfVy1FrW3GKwfNsgchN2nCa/U/8ThgS22EtNPsPkEG34FNOPTzdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3vrlsfg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso53323311fa.2;
        Sun, 03 Nov 2024 22:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730700418; x=1731305218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6jQkrpv3MdS+5xKVIFE6860tge3gxXMaWgpp2Uy0w8=;
        b=M3vrlsfgaO4Ya5MMFh+4t1kMQKekv0oE8E7i6pjsQLZb4/sOBpyN8hGd42cM0J7Hfm
         dGPM+TW5/KAekCy8z35ePqsIB3Q76MvuPzSk1+MDaGe12m8xYJh0k9mXpssvAJH61EVO
         1Zj2wzPiHV6SqNcJGzhPMSt99l1Ytn1pJ73Wp0mZRJ0a+ClgSREFRMlLppqu4dmrGlpk
         ub1CDyUQy/wZXznZHsXzHC75fcZSJm9KAVMIDnq7xf34i+lOxQCRw/RQscPt19PwvpM4
         UyMXiGLcnloePLhUH0RmwP2FcvfhFxbmzEJ4iIsoM9BeSjamEo3YDW5D5iOpMe1N6atF
         muNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730700418; x=1731305218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6jQkrpv3MdS+5xKVIFE6860tge3gxXMaWgpp2Uy0w8=;
        b=IqofcMwTkJIaes+ZT96risE7B7+tkvOMlZvNT+gHZE37e4umK9uJNmeDcDwg0uhwUo
         8Co8DMZ8vi23cs5YwJDxxA9MKZxRv7wc2s0AKZmN3uVY7YmlGS2afpaIQPTX5Xy3RAW4
         FQmAZF7vb71miWbtDadLOe19Bn9dskSmvSKF4P9R+EDsJbOk12WS72NlhnFt2EMn3US0
         uRB10co+PIsHyM++sTreKwFz0EoGsYg18foMB7JYjwEGhTVGmtkOzCbpW+k/+T3IxQ4z
         ehlA93WDfa3TrzCZrk5UQOtjLFF7Ks96rMJWzQdn7V9opFABCtzE9MLOtmOTuCFptcK2
         d89Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWxDPwGbid+KqwLZbRGaT+bF0r9rEmX3nW9cMCaWIlHd8W/vjmsoerQJWMEfaLISBrrkSURuxrZeJd@vger.kernel.org, AJvYcCXVMnGpwLk0Mgjp95Kph8N5o7p1qZcNp3ZYm9RZH+hHNeuOcA1DnTAMJKRLzUYBDHYfAHTe1EcSpxdKhRve@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8i3PSENYi1ceqJqgPum3/YLhkx+OIUn13bF+jZY3PbKr3tPh
	ZdZ4uDtpTTdNYL+fQXAbz8atonK+1a6kpGh+cHarJNV0MFdig7Xhh4knKmYG
X-Google-Smtp-Source: AGHT+IEQoFtFhAEtNK1sLHmReP5ogTKOoTOKksUbZIT3SlZPpjCKyRUuyr0b78o4npcXlMhtfo+jkA==
X-Received: by 2002:a2e:a908:0:b0:2fb:2a1c:936d with SMTP id 38308e7fff4ca-2fedb7a1fd0mr75423731fa.10.1730700417856;
        Sun, 03 Nov 2024 22:06:57 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3b8c91sm15148751fa.18.2024.11.03.22.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 22:06:56 -0800 (PST)
Message-ID: <bf50b6c0-af1a-4c7f-9c3e-ffbd3da87a80@gmail.com>
Date: Mon, 4 Nov 2024 08:06:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: bd71828: Use charger resistor in mOhm
 instead of MOhm
To: Rob Herring <robh@kernel.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org
References: <20241029111112.33386-1-andreas@kemnade.info>
 <20241101192705.GA4062121-robh@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241101192705.GA4062121-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2024 21:27, Rob Herring wrote:
> On Tue, Oct 29, 2024 at 12:11:12PM +0100, Andreas Kemnade wrote:
>> Apparently there was some confusion regarding milliohm vs. megaohm.
>> (m/M). Use microohms to be able to properly specify the charger
>> resistor like other drivers do. This is not used yet by mainline code
>> yet. Specify a current sense resistor in milliohms range rathes then
>> megaohms range in the examples.
> 
> milliohms?
> 
> rathes?
> 
>>
>> CC: sre@kernel.org
>> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>> ---
>>   .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml  | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> Looks like rohm,bd71815-pmic.yaml has the same problem.

Yes! Thanks for pointing it out. I'll wait for a while if Andreas wants 
to fix them both at the same go. I'll send a fix for BD71815 if I've not 
seen one in a week or so :)

Yours,
     --Matti

