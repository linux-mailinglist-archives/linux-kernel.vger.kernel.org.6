Return-Path: <linux-kernel+bounces-544544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F6A4E26A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817BC189667B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECDE2417F7;
	Tue,  4 Mar 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ufv8lhra"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049027D77E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100270; cv=none; b=oYi9FVeqAFfiHY8kBVMOA6P45XydeK8OkfmGk9eRnfFjdr1Ts7SbhnW6pul8TqV/ZU5JFUhB3NYMZ1MzWSaZSrOkzs6SapNATieyMsghBcvjer7jvu2+P0aNi7wRgUtdQgkgLnTMABGJX9S42zUYWrGiFo7mWgQSw5ouKu+59YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100270; c=relaxed/simple;
	bh=6BkGgMCQlKnBVI/z/gSMz/QG6/qLrODbE7vy+j+F1/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFIl8A/s4nHrPeVF1g2mh0p/BN8epymS9Zkjhu3RA3JDTL5kRGix4QhqPUEcJU1VbJGDfk3EIeeS0pHqBJVPM3fX3EQAnQ7HXemRrRxBDR8ApF1SNYwSKslUNbG48kfsgqwwEFbNo3fbRpDfMrzdNGBfom7ykC49hURtazFZ5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ufv8lhra; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e539ea490dso3422218a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 06:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100267; x=1741705067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/68QcT9qmsXPc69IGraMC5MbQqgSu9/5hLTlhc2o0Zo=;
        b=Ufv8lhraUMgD36VHSmxAiE9zDab4TrUVF2NHgCj4x8lnn4TqheD2GPGLJ7PgtIp8pG
         E7b7EECSb+RMHVtC2sPpAUgxlHP6iICI1Vb3+y2bkqom+ly/GgjUy7Qs0Hok1Jp6ML6p
         qqZwhVBBAH11EiD2QmQK9M+xY4ZNHkPR86FuL6iQJhUyjFbKz8vqs74fTkRDTk8vYyli
         63/NIbqOXTHHdrMpkEeIK3uIly/vgoYrAIeVwdZngllBVORQkkCQOVXNg6pajmrs/hH/
         NfeaGqpEQsoeNNSCMKlcyIr7lggNK0yb4IfzNlnERwGeaZmduXrj7DWwoBLeUR2CpmCJ
         5X3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100267; x=1741705067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/68QcT9qmsXPc69IGraMC5MbQqgSu9/5hLTlhc2o0Zo=;
        b=W6dwy0tacvJXCIjE0FPbRfdX96QQXJ1p8Cv+2BD60zSuaJuK7TA689UkIQjVenQUPC
         2svnSsdTSWrtOS3waBt5Olu/sipKYAnXYberL7N8Dv0Rkrnd6jIoJ5/RNY14Wq9ArxSe
         ua0S6qn50t+GkCgvo8c+i2VUxOABEEhwWzMxNIyq6fqtrpNtnXUF8q4WqFduHHGOzE1L
         fp5EGFl2VAEYYqo0fWju9cvCg/qnYtNBLtu4Mlb1tUkkdErwCZsHwmrBClUazJWeJDrI
         qbv8WGoWiHlq3JPjaaeSyv7ODxjNOLHrlj5Aj5TauJEAsfcDrEf3L/yULDJETnVRmyXo
         zQGw==
X-Forwarded-Encrypted: i=1; AJvYcCXMMf2Wi7Rs8dE+NIZLYykndOz7I0BFoMl/ex+/Hk8Mmkuckk52BdYGEeyT4j1B4Wz6pD13Auqah246CYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhxna0VRwy2v6daKId4bo05UK7FVcxW/v9m9kJS2v8qHRnmKyV
	imNAWzxhhn43Xf1AVynEBrIGQICpPN20jbtJdxiFu19q5Q3RFHfK8SkJBBPqUlg=
X-Gm-Gg: ASbGncsFD6HPHM/tKh7anOUUyYkBxtPCoDBPNhRs9+X4o/WuxyGTiUJgNtXTc1aKHRs
	vgJaBCwftPx47/EGbdaV5L76FG3Q1+WNJ5Xfn3rZhtOZ5p2U/ttan/79rd8ItGL4jHCzFMpcVRE
	zeBpMQR9dKVXf12yGUg7DXOdfkpozHeZFayOkboX4Q2QvckM9Box2FX6iM54wVM65OrCelAigUX
	YP5YQeCWfhtAdaniwmNm+vtuJQ7dHVrr8RJlZN5UmQk9U2ycbWElw7YpJ+eEZshRbtkOP6vUZd7
	LHiUweCFTtWhOCoFxmfKEHvMWrbS38wwzGk2hlA0CydDC37qMkW1BSZsuBDz6No=
X-Google-Smtp-Source: AGHT+IEY7PhEqQJuGNVHSkKsQAe7pu1Yw5wYxTDHs1q4RmGyn0tUXGiG6DmuGxPMIR02qbfXS4GcZw==
X-Received: by 2002:a05:6402:388a:b0:5e5:335:dad1 with SMTP id 4fb4d7f45d1cf-5e50335de57mr44726697a12.27.1741100267164;
        Tue, 04 Mar 2025 06:57:47 -0800 (PST)
Received: from [192.168.68.113] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac12cdf244esm296583766b.20.2025.03.04.06.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 06:57:46 -0800 (PST)
Message-ID: <beab1578-eb49-4cf9-bb74-b1282ab04754@linaro.org>
Date: Tue, 4 Mar 2025 14:57:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/13] ASoC: wcd938x: Use SOC_SINGLE_EXT_TLV() helper
 macro
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc: lgirdwood@gmail.com, peda@axentia.se, andrei.simion@microchip.com,
 nuno.sa@analog.com, paul@crapouillou.net, oder_chiou@realtek.com,
 kiseok.jo@irondevice.com, shenghao-ding@ti.com, kevin-lu@ti.com,
 baojun.xu@ti.com, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
References: <20250304140500.976127-1-ckeepax@opensource.cirrus.com>
 <20250304140500.976127-6-ckeepax@opensource.cirrus.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20250304140500.976127-6-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Charles,

On 04/03/2025 14:04, Charles Keepax wrote:
> Rather than open coding use the helper macro provided by the ASoC core.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No change since v2.
> 
>   sound/soc/codecs/wcd938x.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index f2a4f3262bdbc..b536e8bdc5a74 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -70,13 +70,8 @@
>   #define WCD_MBHC_HS_V_MAX           1600
>   
>   #define WCD938X_EAR_PA_GAIN_TLV(xname, reg, shift, max, invert, tlv_array) \

We remove WCD938X_EAR_PA_GAIN_TLV altogether.

Otherwise lgtm,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini
> -{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
> -	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
> -		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
> -	.tlv.p = (tlv_array), \
> -	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
> -	.put = wcd938x_ear_pa_put_gain, \
> -	.private_value = SOC_SINGLE_VALUE(reg, shift, max, invert, 0) }
> +	SOC_SINGLE_EXT_TLV(xname, reg, shift, max, invert, snd_soc_get_volsw, \
> +			   wcd938x_ear_pa_put_gain, tlv_array)
>   
>   enum {
>   	WCD9380 = 0,

