Return-Path: <linux-kernel+bounces-231889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D49919FED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B61F29DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6E4D8CC;
	Thu, 27 Jun 2024 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVS7MnVZ"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922441CFB9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719471672; cv=none; b=qRpbclyLqE9D1JN18l6IY05ZRoXVQwvFBRdWrHDDSQaB0GQt34aGdvuY+IVZST84cRAEedetVCmzMJ523dnFn+KbTYgh54pJIJJF42v6Sgc9jSibAmvzttSqTYgqpys1rtXa1KYCAumW/SIQ0BCunsh0bn3gcUo5Ty54ImMLMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719471672; c=relaxed/simple;
	bh=oDqZyR+8bfJ3aEt0lEDS/JoaZ2NulptY81c2SiHzGrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mkhpvrn56oeDjlGsxeYgxwB0XWAx07XhUJngaIZU9Edyijzivh+KHECjEMTuTKc4JsjZGpecA+yi4V0JGGrvG2Q4jUZdTn9L9Ycz1FpBgTTJtpXGOAt2Ewf/kIcqhTVkTcB/iIZoXA3Sy+zTeiYcFVrXzijJxKnwYIPiFrg0ZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVS7MnVZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-364c9ec17d1so4686650f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719471669; x=1720076469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCgSGAV6EvGTTLCyg0h0NGRt6XTYg1PY0og0tI+4xAY=;
        b=MVS7MnVZIFqZMBH5z/fEJW3qvNxfGpNLDZFDjntCzTLig3oydd2AIbvtnvV0UUmtlJ
         HnhtCFoSkIPl9QcHAOE/cmKd7EGPOuWNOnrsHK7HSqwFYuLjskSLzg14H3rVO/PoaSJL
         J+NFwxaTjptdDhvbp+UQAJUWc4uNFlIjZaD7MH33jucfhq8lfcwDKWIaC+hMK0RlvrxU
         Dd1yQqZv6oKrL0Gu/+B+TDKgyrfUBI46urSqfOMpY4useo8fgAA8mIkRLj9sxFu1c0zh
         c6bzgZd3cAB/yfTUeD4pwu+bhhdX3S1tfWTVHdFmaj2058vNHl4+++FTVmK6xkLZmxz4
         HH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719471669; x=1720076469;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCgSGAV6EvGTTLCyg0h0NGRt6XTYg1PY0og0tI+4xAY=;
        b=to3SUWXX+bYjBnyTkS7G4ZoXbEedo38KhRI6UO5ZGOFvukG3vP8Z1T+0zyuLpIuRUH
         T781zk1Hzo7xLYeoi5Jvk/Do6AMnofIgePTvCcvzWQo8Dgsq48kR8zKeJkf53FxR+Kwz
         Z3V61Oig/ukkpk5m5NGvCEuHTz1S8f1RnR/7fgi2Byi+jhw6YQVWk31FeppwZbbtDG6V
         RTRw2skx/5uCb+fEnDJkpNig5GWEO2fk8AcmaxcUmRiU06XGNw+Y9lCGRUypHc8n3F0I
         6d4bNJl5DPOMCqBtBh7qlWJIMt49e2RmJ7jGQSuy8n7KVU8/rLgIhs7x1FIivbRtX+U1
         XeVA==
X-Forwarded-Encrypted: i=1; AJvYcCUng6K8d70k6U2f+5rBgnfAJsB/pA5SfF888ffDB4SqPAqqffw2GxcRgM3+X89sP1yuLEsrIP08VKL3IBVLATFZWu8KhMNL0BP4D9pk
X-Gm-Message-State: AOJu0YwEjb40YFHuGMA22xSF8Wh0KXFlVjdCWhKLec4ggALmDqXJu9ba
	96tk2SowAJYoOyQbhOuV+9nWOteYw2yTK3CWSH1CsCjCRnZVqBtHCUcnEauNd5s=
X-Google-Smtp-Source: AGHT+IGH2Dv0dIF+pOWIwNb6TZTGpgJIIEF1h8aEfoHfiYa9OlH1jelIcwVFmpCVUa2tUwQiXCh0Xg==
X-Received: by 2002:a5d:4c86:0:b0:360:727b:8b47 with SMTP id ffacd0b85a97d-366e9629df0mr8830268f8f.63.1719471668889;
        Thu, 27 Jun 2024 00:01:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3674358556fsm884793f8f.60.2024.06.27.00.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 00:01:08 -0700 (PDT)
Message-ID: <31ca93a7-865d-4a92-af21-69f15bc688d4@linaro.org>
Date: Thu, 27 Jun 2024 09:01:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mux: MAINTAINERS: drop ADGS1408 driver entry
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <20240626140343.145440-1-krzysztof.kozlowski@linaro.org>
 <8a3ac03fcdc5c2c6401d0a990af5d6e9f6c6670d.camel@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8a3ac03fcdc5c2c6401d0a990af5d6e9f6c6670d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/06/2024 07:43, Nuno Sá wrote:
> On Wed, 2024-06-26 at 16:03 +0200, Krzysztof Kozlowski wrote:
>> Emails to Mircea Caprioru bounce:
>>
>>   Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not
>> found by SMTP address lookup'
>>
>> so clearly this driver is not supported anymore.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> 
> Hi Krzysztof,
> 
> Mircea is no longer with us and often we just forget to update these entries until
> someone yells. But we still want to support this. Can you send a v2 putting me as
> maintainer or should I send a patch myself?

I'll send a v2, thanks.

Best regards,
Krzysztof


