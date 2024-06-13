Return-Path: <linux-kernel+bounces-213225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAABA907203
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926F21F24398
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3FF143C60;
	Thu, 13 Jun 2024 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcBFu9AL"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995814A0F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282563; cv=none; b=J26iGGRpJqlLLaE9ai/peRvpllJZ2+POsGE61E66bE+rSR7JwsnDB6U04JWmE/iU5Deqnk74c7gOboUabQ1Olljp1COfznS1pnRa2waUIBTKoIHKMUmTYiEnBd4kkvTsDz2oihF6VPAuEAXVrb/vmNJTBmROTlifoX5eTd7aYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282563; c=relaxed/simple;
	bh=Ba0f2L0qBaPnNOoB5ZkJeLek3EUUQwCaD5yKAe23nSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WlO6gJ5TfcoOioIj7skdV2pOguOwMQMxOey4cHQBYBrhrn80gWFjQVxMvmV0v9qt0+zmGMrWBke2fptWGQaFyrPw8tpGrKueBlcjBYO+WfXvu/Jajzig4nkuWsZvMgBYzs4zQuiap6QX4H7ktm2v3W+aWopMh4e5pVLj9dgrdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pcBFu9AL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f0e153eddso135664166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718282560; x=1718887360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zDen0vJUW+xT9L+oF3bv30VDdb8wwl+RQxO77NA+7JU=;
        b=pcBFu9ALlgkRRPXPR2qlqttv/a7kdoHKegtfR7z9gfkNnnPTWRCp90Sr3KUgzRr9yJ
         bffQTofk9xO60KQGTm4tgKZAxzcHt2VHiTA0h1XeLSB5BKJzZWe0n/Ir0BMyBh42O8u5
         xZyXBR+S93IOQonBvoLIY42vuf6WtlOD1AG1XdAZt35ZNn2uvnXujQZ6nnyKrKKWcvfF
         B8vKSB1ARZQ3spuJv1iQXp2DdDYxem0TA+Zq3VHQuZstbmMwdtmvmY02W+8xR9I5Ny+v
         DR1PirsF3eE2jFtKeDfVQtiIrK237taoKvtZ8Afr2Z4PlqQLq/X9j86bjF8QVnLxNIk0
         hk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282560; x=1718887360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDen0vJUW+xT9L+oF3bv30VDdb8wwl+RQxO77NA+7JU=;
        b=BnGQ82S810zA42ZQeMVrB2LiLhtsS3n9KGi6qy6gSUXWJrwA4lgaSHMZSscZ98jKPD
         pKTwRfF+bA7Q+xHMBkajJGJCCgTYMNWNuS3jp3UpWn4oifG1/Z4YX2bIpMAK90hQ+V2T
         zU1tZ8rqkXB3uBPLVtpMJmU/RiOARMywyj7WSufvIlJSw3eCYL1M1JlAjo7gv6QgGAMb
         NdKJ4eHlUAGPyvSkeVL1dvobRg13uTyRWXMW2GC9mWnKZ93ynS1hJJTf1DXT5DcUrWIM
         ba7Rbg8phptgcOGxVuaojoPKETOyBzFEmd8fxWSVzgCMSjKrD1BOdJMlnVqsYFQ9RWIB
         Ge7w==
X-Forwarded-Encrypted: i=1; AJvYcCWQq+ULBupQn7oDQnhEOrYn3T3+AcsMCdxR09If8IsFatB5Id02I52+whc2Ysh4RbHCBrmJjO+Mr8IJNy2nwKFshkqMKsOCmB+Rl6OI
X-Gm-Message-State: AOJu0Yz8lzi6BmnE0ec2Cxbx7ZM9cAL1SS4PcRXrJx5Bq6YTWIz2/VQ+
	HyW6TxK08GDb81K5D00XhQMbpjwy/YjceZCtx0w1cLugFH7K8NlnMaHnos/GZKo=
X-Google-Smtp-Source: AGHT+IHhniSGyoEipOniastD+bMxg3ST8u3KBQmi75/UrvUJzOGUDP3BZAKq+V+k4xmYl27dFY/zmQ==
X-Received: by 2002:a17:906:dfe6:b0:a6e:f91f:672c with SMTP id a640c23a62f3a-a6f47f8c006mr276509466b.25.1718282559957;
        Thu, 13 Jun 2024 05:42:39 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a6f56fa6a1esm68319166b.216.2024.06.13.05.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 05:42:39 -0700 (PDT)
Message-ID: <4de45d93-6ffe-4357-9aca-b9fadb3850f3@linaro.org>
Date: Thu, 13 Jun 2024 13:42:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: q6apm-lpass-dai: close graph on prepare errors
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>
References: <20240613-q6apm-fixes-v1-1-d88953675ab3@linaro.org>
 <CAA8EJpq7SN5J8Ye8nGfbJdKAC5Ws61iKMu6QO9ebnRV6q3EVNQ@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CAA8EJpq7SN5J8Ye8nGfbJdKAC5Ws61iKMu6QO9ebnRV6q3EVNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2024 13:37, Dmitry Baryshkov wrote:
> [...]
> 
>> ---
>> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> Note: this didn't go to linux-arm-msm, probably because of the use of
> an outdated tree for submission. This commit is v6.10-rc1, it probably
True I sent my patches on top if rc1 which is why b4 did not pick up all 
Cc's.

--srini

