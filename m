Return-Path: <linux-kernel+bounces-242441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDF792880F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0D31C2188F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1390149DEA;
	Fri,  5 Jul 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="db2upT0o"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12F1482F3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179402; cv=none; b=nyoc0tqFvHwO6T+vsxLXCZpYMLL+sSXiXVFzHCzixSGoRcIIz1gW5NkVcR+tPQ3AaYQEQnEfV4U59FmPNM8wLPsZ8OB0IHTHLrJXm+bDI7P46vYVyup11DNAVh8TdpEyYEMLZM8Va9PgaDqRJqSNe3GhpbbXgt4oWbtzJhB+bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179402; c=relaxed/simple;
	bh=vl9UJxKYmmK00tLm3Hc/iglrSeCsatI+wdE0XTAlrI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSK9Wp+ERfADjdwG3UTGZMrvmooKE9coS2SMHLgCm9nPuR2HwMgc2Q5MuedeTMrDmJA+Xmw+D37MMAjh/7zAXZLksUXe7uZOhKlVE9P45kEQA2/fhkJ/I+/eaUyMT9nL80Ymt9cTOdildojVtywImamHJGf5SR7/99VihpdsENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=db2upT0o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso10508525e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720179400; x=1720784200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ftpwpdpd74QlveoBY7KO0dbT9gEHf6+1Hk4UhbSr99I=;
        b=db2upT0ooLPi717qXj2q2Me3NrUJm5Nk1LpjrQBEDFWTPpaiTUUR6SbubO2yyOzAIl
         ZQgwmksU0UYgje+yJ5COay2MYlJatV7MxR22gyXu7UEwBV27HupXqESQaaqwlhUxKaiP
         vm1PK7MVHvH9iWiewnLQ85cUW7PisIw32kANcpRfSeb8/wIWF2JPW7Kbs8bEB53VQOpo
         DWpdxlSBu1Yj48S9PgPHIWp/792Po8OWijxeHfP9gFvdpwbnlsr0BuNG23UmN7ZwSH5b
         qG7EW07xfQ9Ye2JoGWIlME7s2V5jnrieANegPDO/6Rt0Mtt5GfNjYiMVDz6eqvbleC7a
         DcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179400; x=1720784200;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ftpwpdpd74QlveoBY7KO0dbT9gEHf6+1Hk4UhbSr99I=;
        b=Btf3K6mXYXFXdyvAcOynha16KxLl7DWdDa/Z5RbZkEbpBdXYl8tO91FuXWqJPwNFur
         2p5q5i99z91YUTZWx+XJWKBAA3fSDMadHabuL8HkH3o/z1PJllt9U4nFwNOzy723/EUL
         ioammB6UYnoxgJ3SggoZnA2moDA9c+nINS8SsmJ1ujZpokd3zdCLgBmNNUEAYf3vPJX7
         0CQF8d9ChTmSgrUQbosyLA3ODqO8wTC7GIKWNImR0IN99xyJdFpymKjDveKKGISEIVnE
         tEQnwiFYE3jD4zmoCmZHQ1eBSLs2p3ArTfLm+x7f7hxYiQ3I3XJWXtsRcV3lK3NOmlfp
         I0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWkUfI0vJRranSh2Pv2IRjN9VXdJWH1JJDa5LO0pHfAXjwINzHcfXnuyx/o1k7gm8Q63DHjpzKz2SQZ2rG8ilmzHrH5IXJDDqNpwahN
X-Gm-Message-State: AOJu0YwhXPoFfShhAW3EWW//iO0WRpax1ksOANyW29EutleWEljmke66
	BxdlXYXUUWBAFJ1fLFrhFiuhntmyZqGMj5ow2fHdBXn2HV3VsPY/OlbIZFKyCvA=
X-Google-Smtp-Source: AGHT+IHoNggNRmVBDMFmlxr1SI7XUi5lDCC9FhrxjvRoTRfup+gkVCoGLhuu+uxwdOjMivleq2n37Q==
X-Received: by 2002:a05:600c:4395:b0:425:6f3a:651d with SMTP id 5b1f17b1804b1-4264a4319e2mr27863795e9.27.1720179399774;
        Fri, 05 Jul 2024 04:36:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a21d2basm58124875e9.28.2024.07.05.04.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:36:39 -0700 (PDT)
Message-ID: <72069f51-d416-4c55-8c9a-56f2ed1a6ef0@linaro.org>
Date: Fri, 5 Jul 2024 13:36:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] drm/sti: hdmi: drop driver owner assignment
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Alain Volmat <alain.volmat@foss.st.com>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
 <20240330205722.93801-1-krzysztof.kozlowski@linaro.org>
 <20240527144700.GC713992@gnbcxd0016.gnb.st.com>
 <77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org>
 <20240705-bustard-of-unreal-sorcery-bfc9ba@houat>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240705-bustard-of-unreal-sorcery-bfc9ba@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 13:14, Maxime Ripard wrote:
> +Alain
> 
> On Tue, Jun 04, 2024 at 03:18:55PM GMT, Krzysztof Kozlowski wrote:
>> On 27/05/2024 16:47, Alain Volmat wrote:
>>> Hi Krzysztof,
>>>
>>> thanks for your patch, sorry for the delay.
>>>


...

>>>
>>> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
>>
>> What does this ack mean? You are the maintainer, so what is supposed to
>> happen now? If maintainer does not take patches, then the DRM STI looks
>> orphaned.
> 
> The expectation would have been that Alain would have applied these
> patches. That being said, your reply here dropped him from the
> recipients list, so it's not surprising you didn't get any answer.


Uh, indeed. I don't know how this happened. I was replying to him, which
is visible in "On 27/05 .... Alain Vormat wrote" header, but... weird.

Alain,
I apologize, it seems I am responsible for this mishap here.

Best regards,
Krzysztof


