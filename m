Return-Path: <linux-kernel+bounces-390404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8F9B796D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE151C21D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C7D19AA56;
	Thu, 31 Oct 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bp4jGK0o"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144545025
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373211; cv=none; b=Wq6mFi1oU8EzWrL8F0Tdrvm50DhVQYSz4jWAdPWFpG6taKHPlsHbmh6cHbj3aVpU09OdrguTGGbkCjlxZByGDZ8yNcE2PmFeisA7QIjOLyodKTTCUwGqFivC1lwCUuHlHeYy8O/mr9wqTRX5Ide42LYzbVmLv6NiLYD6LyoZZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373211; c=relaxed/simple;
	bh=UR+AZkACxbATXx2sqIfcnbBjwtoC++48d+OLHhNINNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ncYUTRJGacOSnwQ9xEfEVDsg0kP/3DV8kh00yHMCSZBLUy+JyiCIWg/RqjPgTGvCZfc0b0M+IgpIfGVEQ03s0qHreB0DWup5xF6Wv85gSdWZfer+piHebivrNGVq9jKShVJ45WDLBzmN+fJTZOXg31kDzVLVCkF2+705pZU6Gmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bp4jGK0o; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e58878f2so169261e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730373208; x=1730978008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qz71vnw5/+cff0GcfCxZkyXlF45Rde5KArOUta65nkg=;
        b=Bp4jGK0o7hpPwx/1bZUYwawQetPkA2Wvce3xZ7KQYt7kbltgWTZTFEbxtEeGjQt8M+
         p9ExZ3y1vg1tIwghJudEyH4PlQw3fDoWEw3/f7XkUTCaMfAcEdi9+dWYHjmo8KIaFmLS
         lxk7Pn/KaLoumkaQr2o7EhM48aPXV2gtFH9gYT9l25L67CvOXhUbi39Rq2SP1thA3RA6
         csbfv4AEWEGEteOj5K6znzEorNOOWn9aozGTng9njKeJlxbBDm1EUm6di5T5iIb9Ap5B
         ucdh4BntFTqjj8SggV2ENOdCJTnSaLVGMSEZkfEqxJk6/SEW8IpMnz87FIllJnXfAd9s
         VsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730373208; x=1730978008;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz71vnw5/+cff0GcfCxZkyXlF45Rde5KArOUta65nkg=;
        b=a6ukReeizr2lxIrieWRG+3dJseFbQGCHVQDgQQIKjOdV+QdKRG99f1M7l8RBn+hXU9
         MkWP8uky6ZslV4GAoOxr5Bl65xMaQdXTvN3L8Q0XKqPzxHmzo88/H5WPI+IM1Fv3PoIr
         2DIyufttynStShDqy6TIn9fYcduzmDvjdWMUsO97EQ3OFMIxZrGfmGsCgaqcAAVGLKtM
         4v9UeB1XePfCRfjC/y/kZKq/du9qniJ6jzi39vAF/vFjirOy3bHHrgTtqsgy9t6LBsl0
         AVGtq/K/2boY9lRaJqNEN92v1bD9l5kgIclJ/23v+w0p2m+STfV1LO1D8dhH6JzhwBjp
         ta7g==
X-Forwarded-Encrypted: i=1; AJvYcCX2kbsx5HYPk02mIlxVsCbLwRb2GCXxHI9pAp4BbQAa0CPnOeQ67SehVfFezJS1GJ0o0bHNON0zp5rIL5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2M63QrsOGfspqVhqMQR2iA4QwDr+Q1olJvyePNfI34KEs3tr4
	yA7tTQoh70Ud5zGMyeYAmhzFIgkhOicVvfg5ub1CD95WmaNawlxF7DvT6Arm52I=
X-Google-Smtp-Source: AGHT+IHMRW3LKj7hVd13fw0NA8R8RK3iFhWEx0wtfxCzkNV7xvC+GUbQfnGNOuOyF4KN9HvNqZ7bTA==
X-Received: by 2002:a05:651c:b0a:b0:2fb:591d:3de1 with SMTP id 38308e7fff4ca-2fcbe0c1d42mr30158671fa.7.1730373207464;
        Thu, 31 Oct 2024 04:13:27 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef61837dsm1875871fa.70.2024.10.31.04.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:13:26 -0700 (PDT)
Message-ID: <f06dea2e-893b-4de5-89a3-e25af56afb31@linaro.org>
Date: Thu, 31 Oct 2024 13:13:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] i2c: qcom-cci: Remove the unused variable
 cci_clk_rate
Content-Language: en-US
To: Andi Shyti <andi.shyti@kernel.org>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: loic.poulain@linaro.org, rfoss@kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20241029020931.42311-1-jiapeng.chong@linux.alibaba.com>
 <rql2u5k3esavdmpdzgo4l4up4ir7yjpdzc3qlmsvjvqalqzvjc@xspprcohlout>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <rql2u5k3esavdmpdzgo4l4up4ir7yjpdzc3qlmsvjvqalqzvjc@xspprcohlout>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andi,

On 10/31/24 12:44, Andi Shyti wrote:
> Hi Jiapeng,
> 
> On Tue, Oct 29, 2024 at 10:09:31AM +0800, Jiapeng Chong wrote:
>> Variable ret is not effectively used, so delete it.
>>
>> drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> thanks for your patch! Applied to i2c/i2c-host
> 
> Thanks,
> Andi
> 

FWIW I've noticed that my Reviewed-by tag was added to the accepted change,
while it was the conditional one... Actually I don't know how to be aware
of such nuances, if only b4 tool is used, likely there is no way for it.

Hopefully I'm not too picky with it.

--
Best wishes,
Vladimir

