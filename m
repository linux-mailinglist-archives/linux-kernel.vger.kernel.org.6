Return-Path: <linux-kernel+bounces-573568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 740B4A6D930
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075787A3DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167825E46F;
	Mon, 24 Mar 2025 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rk+6Q2Yy"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1ED25DB03
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816010; cv=none; b=iyghWhRj5ocV6z6A0NOZ3S0p6sYaAYbn92XQb/6HYNFSc01FyVnCbWprCLBwcSyR73GR95yfDVlTP5xJ83UZ+MMj7pcPm1L6QPSaJfZR2/DQIq2g96TOMrH39EhswTVr6Q4iOM7qqI3tipz6qZA53in6DYap3a3aNnMvUT0M6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816010; c=relaxed/simple;
	bh=0QhCQHHqNirjdYBN4QdEl9+nTA8hPopgI9hEFzjoWzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUx7RouTg/5QSdvTmjBXLlqIgF+T4dDaDrX8yAj2u2jjuOxtnOqglDdmk2ogCpUvxdb4DyMDFwm7kytmmlYKqML+RUGzppNpLHHItgzoqWYc9LFbc6IbuuF4X6CLDXNmH1XdWkTSSlUSvxVF/PrrnLXbeF9l2acRLOKMkty9SOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rk+6Q2Yy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913958ebf2so3417727f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 04:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742816006; x=1743420806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZaqAclEJIkWjFVuVskTZM+5u6eA26Yq4IN8pnm0qc8=;
        b=Rk+6Q2YyZ5mwJEAB4v6YJLWozKyNqVLumD0a1sxc+G6Cqz6C32Zzk//+/wp9wD87qj
         hp1Xk4Ucd67hLMhFK8M+R8Agh9rMNGJTvTlsJ2yWRllyO0w+4zPbPgy4FJ2WoVQ0W1n5
         Mg87q6iSV1oPEM0+fdGq05TPo9jQBiJh50z+Pgd4V2qq1VFc/VamwWwkMbXIy+DBZyyO
         8W9/xL/9UR8rudXN7oJ+wGtZKdrH0VOY896sXrbN3pYDkJ+wNN9LIUUY2Rhw8jIzg0Jr
         t1mUBVhn11HpaD5wAcHSVk4VAL0Ru3Nf3LR21NrJ/OVhfL8OB3DgDBvhOBBdKvjrG+zG
         /AcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742816006; x=1743420806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZaqAclEJIkWjFVuVskTZM+5u6eA26Yq4IN8pnm0qc8=;
        b=cWNx8uq0Ah+x1ebgZ5w6/vmbH19clsBhlLoXHyqKQcrKJ2zx+sDAeAAenD55ZN4v27
         W6bLEVAdf5sA8o4Ap2z3Vgkpn6qCPASowJ+xG5H1GAT5Z8cMwyEEu2di5ztQOLeNsdTU
         NlYpdKIJ3Ne/lBbUPE8LwalisjU/0bd6arDA1Zz9OFgzK/rn9zTTmDdf43UKiLLXfH2O
         /2BVoZdvuqccHPIgJuymJGd5bA6JgF+UpN1agz2KddfNaLxF0llB0qKk+0X91EF6hMis
         7ZmQplmM8ysEK+s5i7RDecRpEQSalzTue5fB4GuRpUUmIuPvAy5b4BVlmnD1759VX2ce
         XLtA==
X-Forwarded-Encrypted: i=1; AJvYcCXrz/Fi9OJWncgPvQjKLssTbVg7WQWGWan4icbbGmMsr2otdiKXQE/SSw3ayX+KY17CDg6iePHIhjvkt9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQJ2r7VFMUc3zdEXsYtnb0kJhzdTQRAKn8TapG7gmMpl3PJ6m
	k/aSLBSdVUUAsS1qYR7mZlny6mkxuvb8J3u8J0IM+nsoziq1UayBy6kynbYx89g=
X-Gm-Gg: ASbGnctBDZ7ji5caucfEDhqLx9HI5WtdeLYRZi3ofX++Aols5QZj6IuBgeE7jmgC9gA
	n6OfWHXLOdD0H6r5zveBUEGoen0tvSqmKGW3y8GX/E6uuaxBruIt90PfhjRZkizysrsAo+1znP2
	jnGRNY+1sXRMYjc6pFFwRE6t5r+3tcduIKMbV3haYPDNrWtHd0awpd8iby/YzX9uTxRLWREvPCF
	zD9WJm5692EU6V+cAqPPP7XxPiqJL1/Shwq4CUBMJ2ZyiNjjp5Jwab7J3a2DdI2lcyXSdOLXQM2
	FbR/4Lp3veJhLI0CYsi/owGWulH6Ez8bidJWlr1Pkz5Ohg11yTO+taup82GuWxE=
X-Google-Smtp-Source: AGHT+IFSfs1o8ReuKsDzD9hr5+CF5RuqGwYnwXccjml/f40pB4QQMqmLEg2EktW6960K8d3RhxZUkA==
X-Received: by 2002:a05:6000:186b:b0:391:3768:f448 with SMTP id ffacd0b85a97d-3997f941b0fmr9625633f8f.49.1742816005906;
        Mon, 24 Mar 2025 04:33:25 -0700 (PDT)
Received: from [192.168.68.117] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3997f9b517csm10918673f8f.51.2025.03.24.04.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 04:33:25 -0700 (PDT)
Message-ID: <4256f8ab-d975-4f5d-8762-50d301ce4dcd@linaro.org>
Date: Mon, 24 Mar 2025 11:33:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] ASoC: dt-bindings: wcd93xx: add bindings for audio
 mux controlling hp
To: Krzysztof Kozlowski <krzk@kernel.org>, peda@axentia.se,
 broonie@kernel.org, andersson@kernel.org, krzk+dt@kernel.org
Cc: ivprusov@salutedevices.com, luca.ceresoli@bootlin.com,
 zhoubinbin@loongson.cn, paulha@opensource.cirrus.com, lgirdwood@gmail.com,
 robh@kernel.org, conor+dt@kernel.org, konradybcio@kernel.org,
 perex@perex.cz, tiwai@suse.com, dmitry.baryshkov@oss.qualcomm.com,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 johan+linaro@kernel.org, Christopher Obbard <christopher.obbard@linaro.org>
References: <20250324110606.32001-1-srinivas.kandagatla@linaro.org>
 <20250324110606.32001-5-srinivas.kandagatla@linaro.org>
 <201dc2a7-e031-47d7-9c17-c4275365b477@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <201dc2a7-e031-47d7-9c17-c4275365b477@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/03/2025 11:18, Krzysztof Kozlowski wrote:
> On 24/03/2025 12:06, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> On some platforms to minimise pop and click during switching between
>> CTIA and OMTP headset an additional HiFi mux is used. Most common
>> case is that this switch is switched on by default, but on some
>> platforms this needs a regulator enable.
>>
>> Move to using mux-controls so that both the gpio and regulators can be
>> driven correctly, rather than adding regulator handing in the codec.
>>
>> This patch adds required bindings to add such mux controls.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
> 
> I claim you cannot test a binding in the way we understand Tested-by
> tags. Testing a binding is part of the build process and we do not have
> tested-by for builds...

I see your point, Normally if the tested by is given to series Its 
applied to all the patches in that series, I guess even b4 does that.

Will make a note of this next time and not add tested by to bindings.



Thanks,
Srini

> 
> Anyway,
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof

