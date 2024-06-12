Return-Path: <linux-kernel+bounces-212058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F5905AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD2B1F22912
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3505839850;
	Wed, 12 Jun 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQlfMnEt"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742B38F98
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216394; cv=none; b=aCxh3rKyvRd4zLgUYsY0mALajvt8ZST/IuNmCNssS1fXMrYxUVtDfc5/Ieft2yYTb8hFzn7wSiuipZgPa7d7EShRC2C+2XX/IAKqq6Mt1H/ZzXmyaM5XP+qsFnb2lUMW5GydnTWhO0cuvIno4pQLYuqwDqUol5q9ws2mTI7FjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216394; c=relaxed/simple;
	bh=7m0NLHe62plcr+KKn2aUoCMSPm1X8JIzBoTlRPy0rf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mspG82qIpES9QEx/J6m7gxseny3lPJI8hdRsauUfeBvBWRmm+lfECVkRJ4kkGxNanlChZmLbxjaXFPeBqUza8L7nhfAgEifivBavDeIR7mg8Hz22HI3+UEHAhWZcEtRfiXnicWcZxyLyDOHQxEGU88JN5o84YQ25o/JvaipXOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQlfMnEt; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e724bc466fso845001fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718216391; x=1718821191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqNOK6VrunTwe+R6PcjcYFGfe2uxZR6mzT7FM1DBlfw=;
        b=vQlfMnEt3BO1nbAXlsGVb3OW+yEvA4YPkVZiw1osN5BnWh3MkGb84Sk880BdY4qK+l
         J9oiocYCrVWiOTNKG/kgvG8HPPz0d/HRHRdEVfLQeQjUaSq+dnTCog6mWrK/+TXv9keU
         Z0dzi7e7AKnTVNlGcESIeGBCT+7xgvnJC06csY0A4dBA9eIZ3xdnmcB1EkwRRf2+sPZ0
         5UtQ/Pct14TLkkpaSkLTcwjnJZu7YPUEhO5+q4MspKtSTXRe8h42kq2TZArmDZR4Yu4J
         wBsrfxy3k/ZsbIKa8izqi4aLvfLsK20/+Cvo6HkfbDo/ukcenXAF9q6n9w6Cjj+yJKM5
         T6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718216391; x=1718821191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqNOK6VrunTwe+R6PcjcYFGfe2uxZR6mzT7FM1DBlfw=;
        b=ZYpGq9sB22fayPyPdlkDw1Twcq8cr/yKJUvgihFPZnIgfm5tAwqGRq8qXSZo4Q7fDU
         mSzHQ57pANj5MY1fNy9yGVZFBODIMLQIzJMA8kD7j5aquv9X5UwfEE6L/gPl0YPmvBqu
         +5DYlVlmUt8Hz1SJWitgEyI37CTo4OV8/xUgX34kf3OdmzKh7CZOqUthuXOMVHX9pq20
         +Cj7NY41piYwWRNvPGg/sgjZqFk5tIftc24cOux7ahLO4mkuZB+UmZum4YOzRxLngstV
         CC11/8lfpARN3wWxryDJBZM/+i7pV3BP9HQRUW86dP/+P9Ge+VcLh52Q8LVQUmQhjrxT
         MtJg==
X-Forwarded-Encrypted: i=1; AJvYcCW3ub/0JFeG68Ir59ayXHwlB6myzAaldPq6jpxk82Ya0JEdW5Iiobfu18xZ7V+MMAsG1/i4BbDmFCtBieuMF1d47ZzBb3AE80PzmO1P
X-Gm-Message-State: AOJu0Yw1broIm1wt7r3IIXGrCEyOUj5+RhjqyvFGfy3lFyfyCC4AP9Sc
	fJBClkI6DMJclAsLclupK3vpEUrU0okK3DJNuJ6GFcX3RK+6R6sP4fPyq+S/+yg=
X-Google-Smtp-Source: AGHT+IHwWrOxv+6BSvdQ2PNy6rTqJ3e9pBd+N6k30YVyrZHLYYoJG+Hkk1QVviuejSmiogYnavs+FQ==
X-Received: by 2002:a2e:320c:0:b0:2eb:dc66:c49b with SMTP id 38308e7fff4ca-2ebfc99c4a0mr18310981fa.44.1718216391279;
        Wed, 12 Jun 2024 11:19:51 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57c80997d90sm6072608a12.25.2024.06.12.11.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 11:19:50 -0700 (PDT)
Message-ID: <eb551b0e-4d19-4a8b-b9e6-70199029e8c2@linaro.org>
Date: Wed, 12 Jun 2024 19:19:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ASoC: codec: lpass-rx-macro: add support for 2.5
 codec version
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Banajit Goswami <bgoswami@quicinc.com>, neil.armstrong@linaro.org,
 linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240612-lpass-codec-v25-v1-0-9f40611a1370@linaro.org>
 <20240612-lpass-codec-v25-v1-3-9f40611a1370@linaro.org>
 <dxkgfqxdx4kovs4lfgl6y22chv7b7skmacpttp2z5nzhqj2ijh@6sofslw756mp>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <dxkgfqxdx4kovs4lfgl6y22chv7b7skmacpttp2z5nzhqj2ijh@6sofslw756mp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/06/2024 19:18, Dmitry Baryshkov wrote:
>> -	memcpy(&reg_defaults[0], rx_defaults, sizeof(rx_defaults));
>> -	memcpy(&reg_defaults[ARRAY_SIZE(rx_defaults)],
>> -			rx_pre_2_5_defaults, sizeof(rx_pre_2_5_defaults));
>> +	switch (rx->codec_version) {
>> +	case LPASS_CODEC_VERSION_2_5 ... LPASS_CODEC_VERSION_2_8:
> I don't like that the next 2.9 version will end up in a default bucket.
> It might be better to have an explicit list of versions instead and then
> return -EINVAL in the default case.
makes sense

--srini

