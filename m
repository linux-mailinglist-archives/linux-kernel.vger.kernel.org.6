Return-Path: <linux-kernel+bounces-547856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23222A50E69
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2716CEBB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF751266565;
	Wed,  5 Mar 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2uq83Ow"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06B1FFC75
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213048; cv=none; b=BYc7CK4+UTP+yF4+XoKW696ld1NVe8XmvMhF4C0RGnTgsauGxeSlzQFl5vSecuXo/qIfDa8kvd3Cg5AVjabXA8+6+k3C9E7dUtRHwC2v/e8bq+Uxu5tkjOk8cSye4ruC+7Q6V0MxduMKuxDPfCnb+b43jS7XITH0qZ9+7I3NAwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213048; c=relaxed/simple;
	bh=0EASBjsKyosgnKgR5LYlE5kSUH+MJui/0SdB/Sv1BfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c8T2x6hjm7JrINVOLn/0cRInNweHfEG8Qt4vWDbzBQ4aKRl/VieuHQUI/j3HVAOVJHDMth71b00a4x7z+xW+8R5PSWWo8FXFuhNQukB3f6zhEmnMSSx/uTVPplf4/t+4E4mY/TptaOt88s1mngNP0BYleU8p7Zeav8qXXAIUe0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2uq83Ow; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso264115166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 14:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741213044; x=1741817844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05I7Zu62yUz7WtzNJ79+oYpmHE/xDrzeMJzIBYcCoB4=;
        b=b2uq83OwB9ki9tUUbRqfmeWLQFYcDUD68KGCMGgw2qVq5gbwJJNMfyZdHkxeNgku8L
         M5yUcqZjAE3y1nm26Ng3dsyHQO4uTHCGG7xCJxd5/bRchYVFOTUz4GEg2nUua4byZPQq
         hwlaw0CGNMWPIvr9Pj7wof48/j5QUKt4KxM+u6O6QVB1NL2GYmvgJhOPEgiA9Li+7mx4
         vOFn6IKFO/FukHhXNEnwX5a/692UlSL4Cg6DLD0iSbhdwRXjNziBKawlhcMhfeNHGE75
         B142Iifu389obFDsIsCSUzgTd3b3MejpvosPQYKi6pA/sQq2vMIaaNQKnRDBqYq8BKar
         HNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741213044; x=1741817844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05I7Zu62yUz7WtzNJ79+oYpmHE/xDrzeMJzIBYcCoB4=;
        b=Xmo0+t5f0ay9fMKEN2jXUPqwq1rDb1Att4vScoGivOZz5D7lf1B4dAxf7s9uS962fb
         2OSLtFMjBiZjUWg2VU4mVd49EZqEm61MOEkXEONetiZlUSOSEaAN/RTiTWas8gq+Wd3W
         r7ax/G874JYQVp9dg7RzwsRqn+B+neMN9U5xMtRnNbqMhZdXftFF/B/QOLwLOyyIZjMP
         FlhHGIwSyT/pYRtstfUn/U2gZx26bPZfSXgpYMU/xROloSOiW4msUp8lgPjjCYUhsmMj
         0DIjXqkQYgb+/VVElzuLGtU7zKi/P6XefW12d9UEzfYc8KeP5C6KMqxA5k7WPxYZsspG
         jgoA==
X-Forwarded-Encrypted: i=1; AJvYcCXZYdjOBVvrPUakr47EvdtSuGr+4XiIbfb6rX9YZ3VCeMRmBVJLMgp5MYxbdEi0LLSeBDJSt1NGbm9jm+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGPqxJx3tE5mEOoOX0oBbJ42+JiwJQ/O4DQWD9Q7DBeb75WHx
	lg1ckwFxsvXKnShZrCoDDYnI1HmNSNvasXYi0+lBspyNdLF+NCRIULtK8Qjq7bHLE64pmXyIJ46
	ShAU=
X-Gm-Gg: ASbGncuLYHk217oPp3si9cf/a9s/RUd0xMbj9rLanCWhY2z8Ew/P1Xc9sxbHzvwF8on
	uxRXcUNBVo33VyM9uEDcorNKG09rUQ8c015CDZcPvrIt8Frz2mkEdfknt5FqElDp1AMVQEK+bvK
	VJPLloWP1Pocef8DtMbTr68W6kofi5Ko1JKtod0SZwswYfo+Jq8pJM71+sGMXNr3ubCN6A9PNGY
	zMPBNaIHGLkIDa29Jk7GUYY44n+2lrPueKlr5Ni3/zjG9z/JJYO9gWfk85UEgY/qEX+TC/xZtIh
	lLhP6oqVbbOWIGy+siqb2WRuwud8J/ML4LITshf0o/Zw4n3GNQh0HAh+y042U37qDqNUd2zgkyB
	D8We6vQH0PwWdd2nYc8zyYqa1qA==
X-Google-Smtp-Source: AGHT+IFySJJTv+uF4nFVy3MQo13MAKioll0wB0jIBjyasXh3UmkhJxVLukr73dcjkJKsIaPAWkDHfg==
X-Received: by 2002:a17:907:d24:b0:ac1:e45f:9c71 with SMTP id a640c23a62f3a-ac22caa102emr73495566b.1.1741213044551;
        Wed, 05 Mar 2025 14:17:24 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:1352:bac1:449e:9a8e? ([2a0a:ef40:1d11:ab01:1352:bac1:449e:9a8e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac117f39e04sm529347966b.94.2025.03.05.14.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 14:17:23 -0800 (PST)
Message-ID: <ea047098-2baf-456a-a57f-b698c0ce1b6e@linaro.org>
Date: Wed, 5 Mar 2025 22:17:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] ASoC: q6apm: fix under runs and fragment sizes
To: srinivas.kandagatla@linaro.org, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, krzysztof.kozlowski@linaro.org,
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org,
 johan+linaro@kernel.org
References: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250304105723.10579-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Srini,

On 3/4/25 10:57, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> On Qualcomm Audioreach setup, some of the audio artifacts are seen in
> both recording and playback. These patches fix issues by
> 1. Adjusting the fragment size that dsp can service.
> 2. schedule available playback buffers in time for dsp to not hit under runs
> 3. remove some of the manual calculations done to get hardware pointer.
> 
> With these patches, am able to see Audio quality improvements.
> 
> Any testing would be appreciated.

This totally breaks audio on SDM845, and often results in a hard-crash 
to crashdump mode on my OnePlus 6.

Unfortunately I can't get UART logs right now. But I imagine this is 
reproducible on RB3.

Kind regards,
> 
> thanks,
> Srini
> 
> Changes since v2:
> 	- dropped patch which is causing regression with pluseaudio.
> 	- setup period sizes only for capture path
> 	- fix underruns/overruns in dsp pipelines.
> 	- add fixes tag
> 	- add patch to fix buffer alignment
> 
> Changes since v1:
> 	- added new patches to fix the fragment size, pointer
> 	  calculations
> 	- updated to schedule only available buffers.
> 
> Srinivas Kandagatla (6):
>    ASoC: q6apm-dai: schedule all available frames to avoid dsp under-runs
>    ASoC: q6apm: add q6apm_get_hw_pointer helper
>    ASoC: q6apm-dai: make use of q6apm_get_hw_pointer
>    ASoC: qdsp6: q6apm-dai: set correct period and buffer alignment.
>    ASoC: qdsp6: q6apm-dai: fix capture pipeline overruns.
>    ASoC: qdsp6: q6apm-dai: fix playback dsp pipeline underruns
> 
>   sound/soc/qcom/qdsp6/q6apm-dai.c | 63 +++++++++++++++++---------------
>   sound/soc/qcom/qdsp6/q6apm.c     | 18 ++++++++-
>   sound/soc/qcom/qdsp6/q6apm.h     |  3 ++
>   3 files changed, 53 insertions(+), 31 deletions(-)
> 

-- 
Caleb (they/them)


