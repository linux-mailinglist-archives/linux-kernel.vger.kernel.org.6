Return-Path: <linux-kernel+bounces-213071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6A906AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166C42862DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5BA142E7A;
	Thu, 13 Jun 2024 11:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4xBmUY1"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C621142E73
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276693; cv=none; b=nI4xQPWUxSh0C6VvVAxCZ73Bd8tsZ01SqJIJxOGgz/924zahg29J7/uhoZGsSY7htywY0jFisgttVH2e9f6XymoCB6ctlfai6h4i9Uxz3C+1pY8v9+jZhafZNWlo6cNUtA1jaIovemowxS2DSha938nOTH5jXsuN7zkLFtPCQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276693; c=relaxed/simple;
	bh=tAcSgvKXqfnSUFX2CtxDigGjnUYTBy78IoinGdlH2fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dImnQ4PF3LivxERjGdIyN6iszZ/pI/Pv8VWinie1rERJEvjpL1il21uA8BlSOdhgo/AV5w2ozhUZkyTxziIM9JTPK+bWEQhmKQ899OnOny9vuFBfxfqkIwuX93rp+pwe55bvlaSPfL/jVIzxAkc/L8QyEvV4GKOfB8i049fWyo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w4xBmUY1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so878523a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718276690; x=1718881490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r05GSGoeixdTdrkrNQk/uUV5myauBem2SPDkvyRDYgc=;
        b=w4xBmUY1ZJlIjBu16PzN8sZaXgkMZqijgAdXFvQWwFJBZ2towBcf+TEUgIUNrLAD4U
         1cvWhBKoj8wd7QY3XyPGjA+HmL2OUzXk2np8ayObVlZw8UKfOptdXsVmnIVxmi+kOOhv
         KEAPweB709bz/I/N6lVo8b6fiwDS+Xi+HYL3fqwXRTOPtjmJlndtIm+UoyFSjUzdRoAS
         HPs3nVNcc4hFM3K8qv9r62e5AqK35r7HquKA20Tqh8Ey97mRsMmgdvsyHWkRUly3AbRA
         WvMCd61dPGvXp6IttJsP2Tn+NMa5TKqSE5W6rJPVXBlo5VQmtMzd7sCZGfpwvHjxjIvi
         PWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718276690; x=1718881490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r05GSGoeixdTdrkrNQk/uUV5myauBem2SPDkvyRDYgc=;
        b=uUgNbe4xdV/EU8OQNaGna0kMAk8K7pFF9Hu400Odl4pl8fo+ErtD900K8NLBKGtHyn
         /JSDc6DnktBmUGAY2R+A/UkvmqkO6i4a96UJ68aLE0KIqLKCP1gzJMup3YEwBKRI9SbC
         IWzfRdlu3eTsIZfkO5x4JncAGrnltIVLZTPa8y3fEml/3wCgBrT/jKfh6bRqB1V1pJ8G
         B0zUQoKNqUlIolbiZS9HME0BQYpzJXMB4awkQWRy8ogEJvSCh8DGM/LAVmJ+SOt2JKZT
         NL93jC8YW4FjYi0V8cZnimXrjmJ3vffG5P11NPGPs83yyx7hc0ge/xNsdkB0LYfq2kek
         r6vg==
X-Forwarded-Encrypted: i=1; AJvYcCVI2H09biHCHtNNlOoj8KapujnCFnAGdy1tm3h3EReOhEB0Lp05Ay7LDxahkl28+AG3piZpPonmajPIyX0SopJUO4IaRlE+iATU+RAF
X-Gm-Message-State: AOJu0YwYfv2DX08xtPIw4ncMuTiChy3uPbEo9vD/xeP6t4jO4U8ldxBQ
	xLUtvAPOUZt0z6FhH/x1zKoLTG7BedujsoDQ3nTkpIlYhpXQ2ezfMuhj8wwPdPs=
X-Google-Smtp-Source: AGHT+IFZMCZjqTdFJ+VphErIaK9g4laFVqVLl8sNw4G7xzHX0fkq7AQsk5RVkxZ0AbcMTIBCZQzPyg==
X-Received: by 2002:a50:d7d9:0:b0:57c:5f22:f9c1 with SMTP id 4fb4d7f45d1cf-57ca976a4e8mr3004561a12.21.1718276689646;
        Thu, 13 Jun 2024 04:04:49 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da37csm768974a12.27.2024.06.13.04.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 04:04:49 -0700 (PDT)
Message-ID: <93b2de4e-dc2d-4781-9c1b-d6ad6d888eb2@linaro.org>
Date: Thu, 13 Jun 2024 12:04:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] ASoC: codec: lpass-rx-macro: add support for 2.5
 codec version
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Banajit Goswami <bgoswami@quicinc.com>
Cc: neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240612-lpass-codec-v25-v4-0-f63d3676dbc4@linaro.org>
 <20240612-lpass-codec-v25-v4-3-f63d3676dbc4@linaro.org>
 <a6793126-ba1c-4679-a2c2-eabad4f5a506@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <a6793126-ba1c-4679-a2c2-eabad4f5a506@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2024 12:00, Krzysztof Kozlowski wrote:
> On 13/06/2024 12:49, Srinivas Kandagatla wrote:
>> LPASS Codec v2.5 has significant changes in the rx register strides.
>> Due to this headset playback on SM8550, SM8650, x1e80100 and all SoCs
>> after SM8450 have only Left working.
>>
>> This patch adjusts the registers to accomdate 2.5 changes. With this
>> fixed now L and R are functional on Headset playback.
> 
> I was just about to respond, are you sure this is suitable for sm8450? I
> looked now at registers and sm8450 (which should have codec v2.5) has
> old style register layout.
> 
from 2.5 the layout has changed, I have verified it on SM8450, with and 
without this patch, This fixes the issue one speaker issue.


--srini
> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I tested earlier version of patchset on SM8550 and X1E80100.
> Best regards,
> Krzysztof
> 

