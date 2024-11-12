Return-Path: <linux-kernel+bounces-405210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B119C4E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FE32848AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D26208239;
	Tue, 12 Nov 2024 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYSpyVlc"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190BE5234;
	Tue, 12 Nov 2024 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390130; cv=none; b=tWC56QTf+Q0Q1/XaYepwTHZvKamVxmbLWaQdcGwQJLFrbwtZw5cIImQK9oC4B/mm9+ZCD3x5Aj83CarDthukpIOI4YbEEkh9oNee/uGiK0U3ln+PUH3MKB4XjEI7WBn6KqC04dxzP4lFhzXHIGwcQfqAuSRGA93kOGd96cb+88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390130; c=relaxed/simple;
	bh=IPrGo1Rro9HU3wBjuo9sLmO/hQAJeJQFAnp24Fiji5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaWgv3/JInYIWTArszySYDvgIOcmxaJVD1GyCxcDBqpZz66Ftr5K0LJlR+G+FkeIrn9bdtUcH0CITk6/fbbqjXK7Swv0x5k5s1Ygcw6l3mvAfdJSHu5LRPxR3h6CyXpaOVBUdCGSMg2YnhoniwS0XQk1JANomJkyBlKNpFvTRr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYSpyVlc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f4d8ef66so7841538e87.1;
        Mon, 11 Nov 2024 21:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731390127; x=1731994927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUFmNGkmzzIu35XEOjP9v3YV3HAuqfyHMeeZTNXbTrM=;
        b=JYSpyVlcEI3iw8Ti1DRfHJzOKAFW/ZrkX5ZnawN35Hg69IHkaRAfNgbE2zjnTIfW87
         NXcsULuPUPx01sNUm22E9E130TCjM6iEujHZElI9QwDVMTIn6DKDQnfsmosQIH8Cntlk
         IDbybS+rGc9sXmlYl6S3ZuHBSDoAI7W4hK9DBzs9OoG11xUL+t2l1l+qB8zNYGMMiHBD
         gQufJD9NhhSf4gh5fnLYdtswjxef8NhxZdsTXqlz9RjtqZrIQJHLxAbOM6cFmlX7UMnK
         zTGoNVloYdThIRbI+mpJzFYjSouhEQSYHQ5LDp0z3o6dvnl2ocNr/hTA9pLbyJG3LI+k
         v5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731390127; x=1731994927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUFmNGkmzzIu35XEOjP9v3YV3HAuqfyHMeeZTNXbTrM=;
        b=Met03iIqGbjdSHHzI6gw4sNeRJRgu+ogBIaYV9aYkeRYUM85BlIckGFaEsvAPIoh6Y
         nIeSFL/AArqIFPVgBa09Dz33sm4Pe9dPZAC9iwP6ol5mlaJe0QvqzwBOlpRmSmddyKuv
         qcIWpPtC8t+iQvT/Rc0wyvs7tfTHx9EWhfEaACfOWdHTioUzP8DsHuAEDHIJwsZnag9d
         BWxS2fw9lWCd/EhtaiwEBg/vYMy2nPrKxUD1yrDiBG5McX0/w3WLAlp02CXwitzNnT7d
         +eeA07KwGRx7RKq34F1ScNDjIx0YBibCVjuIRqjQAjyvSXhT970BiKTTJrWEL56AeqKa
         j9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Joh0J0kWHKOoqwBTfYJcEV/oku/zDU+ky9aGFlp67pvJC6FHCb9bWhMKPhD/28Ugq14MwC4WVUkm@vger.kernel.org, AJvYcCV75AxphraBfEb4Qlqrobp67XWK/tGBu0sfoE5pKO4MDvQe+KlsjJyB2/NtXCx3P3yyER+RmzS2rgMmC51c@vger.kernel.org
X-Gm-Message-State: AOJu0YzMABwmZVbOKhvVq+/1UAtifym2rtePW/T0C2f42+AU7VplDAJe
	yakfqny3mH8wlV3TFGv6jMyCbdqBAwvxsEtRXUZdYauBDZ1F19DftRoyRyp3
X-Google-Smtp-Source: AGHT+IE1N/h5+sac9hxDo/olMe3nglqNNcq1zrWqZURbOMVUpuGd6CVOdX+wDIbp3uLiBXdYKlupfg==
X-Received: by 2002:a05:6512:1313:b0:539:ed5e:e226 with SMTP id 2adb3069b0e04-53d862cb04amr6680466e87.26.1731390126971;
        Mon, 11 Nov 2024 21:42:06 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a71dasm1779014e87.157.2024.11.11.21.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 21:42:06 -0800 (PST)
Message-ID: <7661b9f9-c301-4eb9-9764-db8b24ad0c08@gmail.com>
Date: Tue, 12 Nov 2024 07:42:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: bd71828: Use charger resistor in mOhm
 instead of MOhm
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Rob Herring <robh@kernel.org>, lee@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sre@kernel.org
References: <20241029111112.33386-1-andreas@kemnade.info>
 <20241101192705.GA4062121-robh@kernel.org>
 <bf50b6c0-af1a-4c7f-9c3e-ffbd3da87a80@gmail.com>
 <20241111113117.2392d4d8@akair>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241111113117.2392d4d8@akair>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2024 12:31, Andreas Kemnade wrote:
> Am Mon, 4 Nov 2024 08:06:53 +0200
> schrieb Matti Vaittinen <mazziesaccount@gmail.com>:
> 
>> On 01/11/2024 21:27, Rob Herring wrote:
>>> On Tue, Oct 29, 2024 at 12:11:12PM +0100, Andreas Kemnade wrote:
>>>> Apparently there was some confusion regarding milliohm vs. megaohm.
>>>> (m/M). Use microohms to be able to properly specify the charger
>>>> resistor like other drivers do. This is not used yet by mainline code
>>>> yet. Specify a current sense resistor in milliohms range rathes then
>>>> megaohms range in the examples.
>>>
>>> milliohms?
>>>
>>> rathes?
>>>    
>>>>
>>>> CC: sre@kernel.org
>>>> Reported-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> Closes: https://lore.kernel.org/imx/6dcd724a-a55c-4cba-a45b-21e76b1973b0@gmail.com/T/#mf590875a9f4d3955cd1041d7196ff0c65c0a7e9d
>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>> ---
>>>>    .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml  | 13 +++++++------
>>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> Looks like rohm,bd71815-pmic.yaml has the same problem.
>>
>> Yes! Thanks for pointing it out. I'll wait for a while if Andreas wants
>> to fix them both at the same go. I'll send a fix for BD71815 if I've not
>> seen one in a week or so :)
>>
> There is more debris left from an apparently copy-paste-modify process
> from bd71828. That should be checked. At least there are several
> occurances of the BD71828 string in there. So a brush is needed.

Thanks for a heads-up Andreas. I'll take a look at it :)

Yours,
	-- Matti


