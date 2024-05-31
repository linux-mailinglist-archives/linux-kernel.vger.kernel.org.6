Return-Path: <linux-kernel+bounces-196361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDD8D5AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E159283461
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9F80028;
	Fri, 31 May 2024 06:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sPlJ9kcd"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF012E68
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137989; cv=none; b=foIswD7bk+7KkOJtqJynCvIu/NAxhDiO+XNFjMsij8XkKwO7Ql1uKxJvUN3yBUUMVnrl4kHW5he1LyeY49BkFtjgAzahwgbamJpBS26nx0HyaToyLpVU+9zJbX+IK3pa9r2obzRQLkIqmlqbgwBnbpFAz0Ys7UBwqgN7NopG3bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137989; c=relaxed/simple;
	bh=0Re9j0u00pdevZ2KlKx4RRRmTiC+zHWbqBp/+GYrG6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzRNNljdvMUMFa1bBgx7DEsv03Do+qZB9wwUStqDleptliu4dnxS+yFI23tqMqypIdaEDQgGiiuYplBIvjTL1+5zoqCWMcN7USR+/O+0qLomDZt/1fz8zJ81+YeWYp3DbUsDbikiKsDVR2hfMgIGg9e6mXDrV22DV9axaI7+zcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sPlJ9kcd; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202ca70289so7317575e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717137986; x=1717742786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUSOp8UvNapxCeX003T5UKHkufeJYkJ0l1crerbsGyM=;
        b=sPlJ9kcdHjdSGTgG+KnxBb7Bzxk82WV9Yy1Su+GY306/qoh8FzZgGts1HNobQJy+xZ
         0C6SsyC6FC7l0sW9S0wNKqD/AqzJREO3i2rr04LoUDHV9BRQSS3S+a+iMIjiOo1cJ4Wy
         rwrVm+nmgeg00bccyULfzP/458TEfbMAT/iji6KvJWXeaqymt91Uuq/mMj6FW75RPbVv
         f+BBnBaY+XEFCCvcgnmkcYIIusVlvZO70tkcqmocflG5nr5IN7YkOMHfkGywLs173Bky
         G1Sd2fMBTW7IsSTtV9nCrFWdhwrz7zy5TTltXkxmiNEmnHsKmCovVBGNh/cgs/B3CRK+
         Bmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717137986; x=1717742786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUSOp8UvNapxCeX003T5UKHkufeJYkJ0l1crerbsGyM=;
        b=JzH2M8AutlYJfQD55LdBE+TXADvO96x4kL5lAvv2j0fKWzeZoYeiwRe43sq/kZXGSS
         dN/chOLm56APd6UY2YhYbNaNSGqOAsWPk2070xYlLidPArg5UjG3+Blmf+xarfLMl87B
         a0U9/s8OU4TqTLjY0BPDae77bTKcTVKwljMIDeXZ0+5pGh+W4rcTqamzAYc2/bfx5i8E
         PBIdBgwrLLJtf/dQtmn3udrI8ndrbvW/Fz8p/wgr4tWAwXZKYjyXTMuuExZotVFAjnsI
         xYisOD4BiaW3dxSCNjmqmg3SrHG1K5EEU5TwvFYGzBG3VwwsmSUht04eXacRlu2mMlhH
         avFA==
X-Forwarded-Encrypted: i=1; AJvYcCXYmW70O9C22FqbcqTU6lqKwaVNW7aDGT7MDslUTfBHOTgifvD6PapO2bDuYRQz8sCoH/Ea2LGrx/3QMFF3Zc2E2B79yAjj98dcDp/D
X-Gm-Message-State: AOJu0Yx5zBp/UQBYBYWAlVgbIslvkG9EqbIB00T5drmy+b2ZEyqIQsoz
	y7o0n3j4P7pko7WfbeZgFSVQ56vUNjJPcCmg/oGxR4nBLjawhfvtZ87VAfhLCD0=
X-Google-Smtp-Source: AGHT+IHQ+qTokXrRqmkS/nR6JkLNEDogtK9W4N+4B+JhENUzvVWkWuxBKMJtkvaf7Hrz2xIF3TDMfw==
X-Received: by 2002:a05:600c:3c98:b0:41f:3ee0:a302 with SMTP id 5b1f17b1804b1-4212e0ae746mr8522225e9.30.1717137985717;
        Thu, 30 May 2024 23:46:25 -0700 (PDT)
Received: from [192.168.86.191] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4212b84aceasm15051355e9.15.2024.05.30.23.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 23:46:25 -0700 (PDT)
Message-ID: <cf25c61c-6e2a-4f07-be5f-f9b5bfa35307@linaro.org>
Date: Fri, 31 May 2024 07:46:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: copy linux-arm-msm for sound/qcom changes
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240531-asoc-qcom-cc-lamsm-v1-1-f026ad618496@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240531-asoc-qcom-cc-lamsm-v1-1-f026ad618496@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/05/2024 23:30, Dmitry Baryshkov wrote:
> Not having linux-arm-msm@ in cc for audio-related changes for Qualcomm
> platforms means that interested parties can easily miss the patches. Add
> corresponding L: entry so that linux-arm-msm ML gets CC'ed for audio
> patches too.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

thanks Dmitry..

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 523d84b2d613..b9bdd1f08005 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18227,6 +18227,7 @@ QCOM AUDIO (ASoC) DRIVERS
>   M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>   M:	Banajit Goswami <bgoswami@quicinc.com>
>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> +L:	linux-arm-msm@vger.kernel.org
>   S:	Supported
>   F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr*
>   F:	Documentation/devicetree/bindings/sound/qcom,*
> 
> ---
> base-commit: 9d99040b1bc8dbf385a8aa535e9efcdf94466e19
> change-id: 20240531-asoc-qcom-cc-lamsm-be80e19f8cd8
> 
> Best regards,

