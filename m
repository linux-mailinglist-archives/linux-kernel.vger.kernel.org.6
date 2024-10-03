Return-Path: <linux-kernel+bounces-348777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700498EBC5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB1D286CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788913D886;
	Thu,  3 Oct 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKVxRR/G"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B2E13D502
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944690; cv=none; b=oK58rvNuqPOdjbsCrT/PRje8ZvyCWsG8rjvKlk7phieZNntX82rSgw3ikMVMAWnieFQqC3jnBuk901jn0at9HcOndeGOoq+oa19/Z5gIlztZseluANED6ipixwxOr6ukrWBO/wv0Q/Wl1isiIW6j7ENVjL2Q97/c3VGRhs1okyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944690; c=relaxed/simple;
	bh=4ua2maflkVRqMc2LZtuqDFH1fI3chW0M0xmBlZRER0s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bkUlXF9aLQIMrJS/OfhtN/Hy5l/NIMFckcRQ09E08/KcHb+VvUg8uAQL0nhZjToMHwlhn1KPIgPBZncQgUr7Xx5f1eqAc6xMaauyZ80/mu46/vv3pZVd4hAHx4dCx2AhCMqoJBRzuE3tE8RkTg/7Bdkj+4NzqhJAGcBu0bPs5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PKVxRR/G; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c5b9d2195eso922414a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 01:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727944687; x=1728549487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AI95hdAo0L197vsF1rDqCX/UBH8QpXiLJGBbpmWlwYs=;
        b=PKVxRR/GPeqYE0BPqAOeoqHbiPKdBn1JL+shVzXW8QHbMhTBPXt396ktVHnceTPI5q
         B2gyeoAO8LvJqWjLqD10Vs/SR9byy6ApiXv2isXDqrTOrrVizSEcAWsETU3Imc/pK2Ns
         qaINMeywuDyhMjLP7qWdWNILeX539lzpvB/hkSm3jJI5qOtCUpB02JesGTpFNeOr1M7V
         XB+XDKau8Er3HJq4+rSso24d2eBGhS1GvjCYNKkaaeJmwyLIZXm6Eq9f7J4GRB3CX2Fv
         vR2pHF46S7yiflHlBLxeGGCzSGoBy+eQDm6+Vj0pMWYzAboYZ5qwcxxgYhSPINX04VJ/
         kopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727944687; x=1728549487;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AI95hdAo0L197vsF1rDqCX/UBH8QpXiLJGBbpmWlwYs=;
        b=vNbeTpR99g7xRqJRBgdh73x8os55g+aMkJkL9vHks8jDlK9Wm+bMuna2VE9/Bz0/Sb
         nmA3K2FKYjSNGBIjlqX69z/hyDp9uf+l/xWX/g3PAaURs9XcpnfQbI8828OJvkpiEK3I
         dWdsCQs8stQykCFsxiAkRvjpgtVCrdSDmCZNYZ7J91xEI5WoOBM6PVRmCcMV8eLB/GV2
         LRJkErtq3Z+w5Ee+dBBBLQ4qiw5nLQo9c7xsnCediDbQuuObJTcDJO/113aOV80Zphem
         Y1aquHYbXVrMeicRToHl4uf4E1RoTJsAz+wvEQYdcgWpmVOVwqvoYMIgcXlUF50XyKwx
         Rmmg==
X-Forwarded-Encrypted: i=1; AJvYcCXBQ0wYOeNuvA3G11mle36TeIpzbG1hEbMFBBOJ2PEa7uEMkCgYoddAFNvte8zmz4z9LNLTvwP7xZFy8SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScRsy7XTCSL0uks5tJ4ajxUJrnqIjotwfAEbWR9ImOEm65/Kv
	h5+AhcVLlPSvmXXU/u2i7rkj8MAUwSbQZSsx3Diufz4OXPaNvxBW3bEzWdF9itA=
X-Google-Smtp-Source: AGHT+IFJtQ5Q6vU9bV3iUsDqKrnaXd3wQlCvpuKx4mdOk/dlYDndw7FIUWSdSe2S/QZdI82/p+L1qQ==
X-Received: by 2002:a05:6402:280e:b0:5c8:83f1:2531 with SMTP id 4fb4d7f45d1cf-5c8b1b7d282mr7308984a12.28.1727944687275;
        Thu, 03 Oct 2024 01:38:07 -0700 (PDT)
Received: from [192.168.0.15] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8ca3bcee4sm464438a12.8.2024.10.03.01.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 01:38:06 -0700 (PDT)
Message-ID: <8554d372-18cb-4351-a5ab-894be09c613b@linaro.org>
Date: Thu, 3 Oct 2024 09:38:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] media: dt-bindings: Add OmniVision OV08X40
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jason Chen <jason.z.chen@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20241002-b4-master-24-11-25-ov08x40-v3-0-483bcdcf8886@linaro.org>
 <20241002-b4-master-24-11-25-ov08x40-v3-2-483bcdcf8886@linaro.org>
 <t4fajppdqagkl7wr2krcucsga4zocz6liar64odk2mnasdyfms@5fp7bfwalson>
 <a86d05c3-5151-4161-8612-58894b1d0203@linaro.org>
Content-Language: en-US
In-Reply-To: <a86d05c3-5151-4161-8612-58894b1d0203@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/10/2024 09:33, Bryan O'Donoghue wrote:
> On 03/10/2024 09:29, Krzysztof Kozlowski wrote:
>> On Wed, Oct 02, 2024 at 02:58:44PM +0100, Bryan O'Donoghue wrote:
>>> +        properties:
>>> +          data-lanes:
>>> +            oneOf:
>>> +              - items:
>>> +                  - const: 1
>>> +                  - const: 2
>>> +              - items:
>>> +                  - const: 1
>>> +                  - const: 2
>>> +                  - const: 3
>>> +                  - const: 4
>>> +
>>> +          link-frequencies: true
>>
>> Not much changed here and you did not continued discussion about it.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Ah my mistake, I didn't read the bit at the bottom of your email

I'll do this

Documentation/devicetree/bindings/media/i2c/thine,thp7312.yaml

           data-lanes:
             description:
               This property is for lane reordering between the THP7312
               and the SoC. The sensor supports either two-lane, or
               four-lane operation.
               If this property is omitted four-lane operation is
               assumed. For two-lane operation the property must be
               set to <1 2>.
             minItems: 2
             maxItems: 4
             items:
               maximum: 4

This captures what I'm after.

---
bod

