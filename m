Return-Path: <linux-kernel+bounces-420937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C79D8523
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC0DFB38A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557161922F0;
	Mon, 25 Nov 2024 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTG14RGl"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CCA35
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534433; cv=none; b=rZqWlvqeXq8jWqh7cmt5hG+5nkYwTvkAmLF/zbqGQ7S8Mn0vFlpDB1Y1tpCZbcud9gOZUFAl2NI7ULwOs9yqKenJtrIir92XfRnIfEM4C9uQerbzWnWwY9rqsMrF62K+r8BXhwvbBGGH6dNU1V49cGlFlBoCb2V/Q11IxkPLnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534433; c=relaxed/simple;
	bh=Y0pO1oyhjAPKL5nt1aPK7xIJvGf12wHU9jf95wCj+IA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=chNj3XcAaDPZIrLPNPd6kPomOrDRMVcDuFIqmF2j2YcE/HCl6sbrTLMvqGXT7RyE9A7NQpTs77CGAvp+H2iG2cFu3suddFzHOc/d2TGLL9L61DkJOVX00xbtNB7au3MsU6xzDR2LC/2TrdjTaBo2HSodio34+H+pm56pf4hQ4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BTG14RGl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38233152c8fso300098f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732534430; x=1733139230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bq1myq/LdEjHthwXVChnvJN8lXo7LXiqyVkAx0EDVHU=;
        b=BTG14RGltFr0PgcCAT2GVgDfoH0rwICl6xVV9xFb5C/317m1lO7WU9KVnTtzlMdRnK
         vZqOjRZZhWXbKb/XDOCZ7TMxlgLiBiCnmReVfF8sDAO/Xk7PyN89flwIKF5jpdiKjKv/
         2+rMMHrn0VRMEI33qp5cPNQ3YueimE9DmycZBudnAOm7KHghdm+2AfNudG3TGcDsMuD0
         Px0hYFwDzoJzN3tnZ/mn6MbQ66kT6rPZFE+j6u5FFQ8AUL673FxqFzVlVVREf4zeDjcB
         5dtZEpdJ85SnVUfnvLhr7FAQEFHdA0cR8ntaMh7718JGFUpBGUFcuoE4ntpAle7fZERI
         Tc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534430; x=1733139230;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq1myq/LdEjHthwXVChnvJN8lXo7LXiqyVkAx0EDVHU=;
        b=czdiClqw4wOOfMgV3r9UFNOAbl/A2Esk25iZaJtwGne/RKtkQctIcL7FIMZjVF9bwd
         ElGm6ZPIDbxRCh/qD2Mos7LHVDmS/4HeYBNtEJP7wE8Zs7dwtCROpTZ5bTYn5vnyh4Gx
         hhvRzNcDMZfNBPn9/JJcqcgthd9bIuOrli9SqRuFJYpEFWp/R42K9J/F6g/I9gpyd890
         kRjL1ZpmyO7E61YDM17sHrzYENH0ibJW/sbqHVjEm1sLg49PEo98HVnoROW85a356Pqw
         Cu9zEaM0pKaRJn4qMFb1CJ30XoggYaQEpYzG2/9SiI6KCSET7Q48jHIjsrCzpsiAX5YW
         TWhw==
X-Forwarded-Encrypted: i=1; AJvYcCVpiWrcaJWU8F8nvOSUOstLrIKB1WinMOxAe85/5l/FZ3Ls8Sc8umf6GUR5e6xUjKzd8NIqjMMc9LJmAJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAisOpSxzrtFyMZbMpmQxrYC+Xt/8dAwcIVFRC3Gbbc+9lWSA
	tSMig640yYeGjjBc3EHR4ISucKJHk/clzzxpnt72xt3YrtwG8hX4XSPZZfcywts=
X-Gm-Gg: ASbGnctsesT0zPlpb/burjyBLp0Qc+bSq7GE2mv3qTXQYczl6/tVbdn2GbjL1IFz8B2
	onWEM0Lb0lCpFIJE3bjQ3Ck8UugNZR10PlU5McA7xwIyU9NGK36uc5/Q89mbcqkdQdBpqikam4s
	JHiiyiRPjNeuEl5O1br/mqgrahQHnVLODOX73QTGdktmD63i9jthN7Mm72BkBJKk1t7BSSaxSQ/
	GsExO9++aeKnAefBr6pH1bgZUoDJYP1AUgT36aYP/prnG5IXRp8gC/MQ5jNITNyqGRCjw==
X-Google-Smtp-Source: AGHT+IF2vPou6F+jFBQByuXLqF7Zv4HrZFxhrlsMBFUJP6yPAfwqoinw08bfxrm53NuMVRE8xcx+xg==
X-Received: by 2002:a05:6000:2a7:b0:382:3ef9:dfbc with SMTP id ffacd0b85a97d-38260ba3df8mr3414325f8f.5.1732534430139;
        Mon, 25 Nov 2024 03:33:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a15d86a4sm14158975e9.36.2024.11.25.03.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 03:33:49 -0800 (PST)
Message-ID: <e77669ea-9edd-4321-8d17-4da40161b59d@linaro.org>
Date: Mon, 25 Nov 2024 12:33:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Devicetree updates for v6.13
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Sasha Levin <sashal@kernel.org>, Rob Herring <robh@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Saravana Kannan <saravanak@google.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>
References: <20241118210730.GA3331421-robh@kernel.org>
 <Z0NUdoG17EwuCigT@sashalap> <c25e6a80-f6dc-4ef9-a90d-0fa09cbbc217@linaro.org>
 <Z0NbeyTwxo-M4Lgi@sashalap>
 <936bf452-3d1f-4940-9a91-69efcdc6985e@collabora.com>
 <CAGXv+5FLkZbZVHNkfRWuT+OioZ0TG=u2WfaFCx-jZFi73QHnVg@mail.gmail.com>
 <19ba4910-f909-41b4-ba62-c904bc37d41d@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <19ba4910-f909-41b4-ba62-c904bc37d41d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/11/2024 12:00, Krzysztof Kozlowski wrote:
> On 25/11/2024 11:34, Chen-Yu Tsai wrote:
>> On Mon, Nov 25, 2024 at 5:48 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Il 24/11/24 17:59, Sasha Levin ha scritto:
>>>> On Sun, Nov 24, 2024 at 05:47:33PM +0100, Krzysztof Kozlowski wrote:
>>>>> On 24/11/2024 17:29, Sasha Levin wrote:
>>>>>> Hi Rob,
>>>>>>
>>>>>> On Mon, Nov 18, 2024 at 03:07:30PM -0600, Rob Herring wrote:
>>>>>>>      of: WARN on deprecated #address-cells/#size-cells handling
>>>>>>
>>>>>> With the commit above, I've started seeing boot warnings on a few
>>>>>
>>>>> And same boards do not report problems on the next?
>>>>
>>>> Looks like they do. I haven't checked it previously, but I see that we
>>>> have similar warnings on a few boards that KernelCI is testing -next on.
>>>>
>>>
>>> That's... horrendous.
>>>
>>> I hope that we can get a proper fix with a bootloader update on these (now very
>>> old) devices... Adding a Google engineer to the loop so that he can follow up
>>> internally.
>>
>> AFAIK that's unlikely going to happen given the resources needed from
>> the ODMs for a firmware re-qualification. Or we would have fixed the GIC
>> bug in ATF and had pseudo-NMI.
>>
>> Some of the firmware code involved is 10 years old, so even the RK3399
>> Chromebooks, which no longer have support, could suffer from this as
>> well.
>>
>>> The alternative would be to hack-in a firmware node to mt8183-kukui.dtsi, but....
>>> ...ugh. That'd be indeed a hack for the sole purpose of fixing a bootloader that
>>> is acting in a broken way, and I don't like that at all (...and I'm sure I'm not
>>> alone!).
>>
> 
> Then we should add it to the exception list. Let me take a look at this.
https://lore.kernel.org/linux-devicetree/20241125113151.107812-1-krzysztof.kozlowski@linaro.org/T/#u

I sent a fix for this platform only. You did not paste links to other
failing platforms (and sorry but kernelci web interface was absolutely
unmanageable and unusable, so I am not going to even try to look for
them) so not sure who should be added to list of exceptions.


Best regards,
Krzysztof

