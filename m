Return-Path: <linux-kernel+bounces-185987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADA88CBDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204B92825FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765A811FB;
	Wed, 22 May 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGG8CZdw"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A180C15
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370032; cv=none; b=RaAPLrsTo+MJMfoVx86gi9i5CE3Vu12+QGQoxJ9fbN59tlY0YRC5Zf7YzwbNl5fVid21f5wbysBvisc+aGJmy+nVbKdBPIP5fhwus1PAOtOY1dBF/8GF1ZLl0Uojyd3VHe9TlXBO0HLY6Knmknp0hCvqX5VOi3O84UZyv6+0SuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370032; c=relaxed/simple;
	bh=HYvZGtA1obQ1/nRnxfWJRdy+0djkthrv4FuBYf0SULw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixXQ/I8inIldWhlbLWoyJleY+hpoLTipKQthNf6Q8K2bYIi06XbMjCEexBnX8x+wvmavdst1Hfxe+TFclTEKHt2yB6KAzWSzmiaKeGVKnkNP3amp0lWEffEyuxzZtWTszJ1Yu8OdbwGQjm7RcQTNaIRkKLDMbZ3ixhbNhH4yPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TGG8CZdw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-354e0d4db6cso200731f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716370028; x=1716974828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=orTTXUxg0WSMuNEfiYHEpVHLG+qKc+5VIYcHt8VvU/Q=;
        b=TGG8CZdw9uOZuNQnH9ORbGdTZACBlnXI3rHFU8snZcIaY5E5bh1/3l4QCtG+KDmNGW
         9xFzCrQROFrHbf/o/BlRUGIn2AcHS4JtPeyy5M1Lba80DjLFqz3XmYtVSGVg1XGQ6u9R
         mtIhAI86Y0llj26gP86tq0GSsSHkxVMglKqBGfXk5uAGuyj9FPPagDiWTWMP0Y7CkIaP
         LYvGs8Ni7JCBHl5Dp9d6LgfRMvXxGisOQx/iP8SQE7gYDpJYcjSrDbwjd70HjJPINIBw
         nDriqfI7/bTuhb8n2oNpE3RYbHyMmtel8fMaJvgJdp00NT+hmj2dO0/wliqwfF78nmly
         nz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716370028; x=1716974828;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orTTXUxg0WSMuNEfiYHEpVHLG+qKc+5VIYcHt8VvU/Q=;
        b=aQxJJ6Zl5u4ArRSfOoYvSOE12qYyz5ndl4tIp8JqJAn4DCkeBYHni5pFW8xiXBZWkW
         fbHKmi2r5PQ0IuoJ8HsMxt0il/nlmsV5b+UocekHQW9SQYZt/sVhJK1Rns3A3UQazVnq
         O6hMfZAprJW6WAz7KfA2HDuJteEdM1iI6djjClualHa60yihn5iHlUmKr+kUgMLdkICZ
         Nz/6nJi6KtA0Sr0+H577bvSIBZj1Wq77RZl+TrQDiV1vlToWJ6bhr879egQ70/+vTnVR
         H7jmcOVBWVdW8RXoORLPe7PIVhdnGKoHItbIfhRzGPCsFlFJ1Qr7jUvXpvR+NhwBl/rF
         C+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUO5SH2lH74DKfPuUtsWyqZ2y61E9YUwcdU2X2/SlH+DLpoHjZ+5hXoW46EZSx8lK9nZo/EheTXv7H/0CZpPbjzBTn+7nej1iRqJJhL
X-Gm-Message-State: AOJu0YxZJ53W/wT9aaTI+urivkMEE6ArI6b5JF5ZoGKvLovZ3w8Wpdxy
	HudiUQTpP01nEdzsAbY1nZvPiXs0jOjO0jNbScsgvA9w5cGYmC/F7bAFsggUm1k=
X-Google-Smtp-Source: AGHT+IF+tJzAY7Qg9MpN5EupepQQXdI1p28ISXARteXEPbvai7oPo+Y4pas8VeNJDWsWMYj65PZhRw==
X-Received: by 2002:a5d:6a8c:0:b0:34e:5284:4753 with SMTP id ffacd0b85a97d-354d800344fmr1253923f8f.1.1716370028553;
        Wed, 22 May 2024 02:27:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79be12sm33906275f8f.20.2024.05.22.02.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 02:27:08 -0700 (PDT)
Message-ID: <b094ce68-9ce2-411d-99f2-1f143e4c3347@linaro.org>
Date: Wed, 22 May 2024 11:27:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regulator: dt-bindings: rtq2208: Add specified fixed
 LDO VOUT property
To: Alina Yu <alina_yu@richtek.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 cy_huang@richtek.com
References: <cover.1715846612.git.alina_yu@richtek.com>
 <9c1bbe4b38a4ee5650d888478f1ce2cec2733669.1715846612.git.alina_yu@richtek.com>
 <5d26b19c-7679-4dba-a9ba-a7368d39b474@linaro.org>
 <20240522090302.GA19548@linuxcarl2.richtek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240522090302.GA19548@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/05/2024 11:03, Alina Yu wrote:
> On Thu, May 16, 2024 at 02:34:02PM +0200, Krzysztof Kozlowski wrote:
>> On 16/05/2024 11:20, Alina Yu wrote:
>>> As the fixed voltage for the LDO is outside the range of the adjustable voltage mode,
>>> the constraints for this scenario are not suitable to represent both modes.
>>> Therefore, A property is added to specify the fixed LDO VOUT.
>>>
>>> Examples of fixed LDO VOUT and adjustable LDO VOUT is also added to this version.
>>>
>>> Signed-off-by: Alina Yu <alina_yu@richtek.com>
>>> ---
>>
>> This is a v1 but I am pretty sure I saw it somewhere and there was
>> already some sort of discussion. Confused... :(
>>
>> Best regards,
>> Krzysztof
>>
> 
> The discussion regarding this matter took place during v2 and v3.

So in the future?

> Due to the fixed LDO VOUT being outside the range of the adjustable one,
> a special-use property has been added to avoid overusing the constraints.

Hm, why exactly this is not a bool property? What are the benefits?

Best regards,
Krzysztof


