Return-Path: <linux-kernel+bounces-218028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1331690B838
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111921C22E34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87398185E78;
	Mon, 17 Jun 2024 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbhr3ejE"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39604185E47
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645896; cv=none; b=Gb2tIH5lUE7uQLmXXutsn9I6h+RPOuHbFOspZQNrXwkBzEN9u9fyeYAl+8SWbQIO1uYTb+XqfbSCe9flGOOlk2MD1tcAVWFwYJzJL4DRCc1QZ9gjism9hkpPB+eYbng1wa9KmMYEnSpbRMkQ6hrpL01ZCcDTFTK/zu4arCwvlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645896; c=relaxed/simple;
	bh=yfyc9qcR7L9LOYuk+Rpu/ICu+drOPMuVxh76xzEUh+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COGgoKEQuhidwyCAERG6IkcuwfMzeNLUYcTCL1lG+ekqo2tJb/gnf3o/zTf7q0yExxISfPLwXFVinsnwjxKu/+z78r0mIOyH5anKdDgwsHCPhylAzIcmDN2F0C5Tr1e66wyJznVS7TgATo4agoKweMuHFnMxT8JZT3SLX/LxYDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbhr3ejE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so32852391fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718645893; x=1719250693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kt9rSbMK48zchYAqXzwtp2fIt9BL61bcmFfZ69RGv2o=;
        b=pbhr3ejEnhpt/ih41VjT5oA+ftqVH4vv8rzkFcQlD+UGSUnfnHlMtL+kIO2IRZ7mCY
         vZcvQiZxAeG50nnFZaRiYRoLqUijxF861WIXqG/Im15yUVuW4cIgKcGj/9iRkeYIWFpK
         XhzeXhp0xU7NxZngC1rULeb/nQd2GP1WWC+8S5886DHq8+tyhmjONHGk4AcZGds0eMK4
         Rpxay5iacQc75uGHLfhK83yv/4zk1aYi9bdjw06YFyk5ir+f9/SST55MfsmtOkMaNKcA
         lLD+IMx51k5VJHbKVyjw3h+77+KpvCjzb/Ti6Rmd++wGEUp1dPE5WTi/5GYrfqgBHHqU
         JBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718645893; x=1719250693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kt9rSbMK48zchYAqXzwtp2fIt9BL61bcmFfZ69RGv2o=;
        b=s9ep+XLU08eJQ4kteqMCSwkcysMydJOpz+l8BXUI5k5EeVWDmxXWX8Y4y268vyMaXu
         El8rikqIVd/sMWix+n0eUUu/lQJWOEXF2Cu3HUVj+DsOaRBgcZlfN4xwJeNyRG/CcEza
         8hwC/EPm5Mzr6ZjuxLKkyEEocA47JvSH0lwQLc46xDzqIvXaGigOZcNf7lFZkzGNpnYB
         vjzKksGmIHPr5QdaRgFm3IHet6w/QoAqvBS5z5B/96gyHyX4KCJiSeLeiAUD2qUrMZzG
         lu4iTwc4IToRCtTMhpeQnufR/BzvE8mHDPcwn5H5DBotEqJXjSpFa1r64ZeGuiUrU0WH
         ROTw==
X-Gm-Message-State: AOJu0YzR/YJDmndmzD21qvbmKGu9hPv3xsrAVrhT5nhd4ltuo/RrhRgN
	zbm7seBT6KnIaYlrmU5ot3Uotb3auhGSNPf7lPnSMcQ0lQAB/JkYbRWxP4aUu4A=
X-Google-Smtp-Source: AGHT+IGAv/VMxJ0kYZm0BjCFR4S5shtVmPPA8JVH1i0GUUnbuSVRcoBn9ry476jxv2gGWz/I9uBKzw==
X-Received: by 2002:a2e:b0d6:0:b0:2ea:e12e:bee5 with SMTP id 38308e7fff4ca-2ec0e5b58bdmr68281141fa.4.1718645893449;
        Mon, 17 Jun 2024 10:38:13 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cb2:a9df:20fa:cfbe:9ea6:1fe8? ([2a00:f41:cb2:a9df:20fa:cfbe:9ea6:1fe8])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec2d25ad22sm4015741fa.86.2024.06.17.10.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 10:38:13 -0700 (PDT)
Message-ID: <ff3e62b8-3b54-43d9-8b90-88646d1b585e@linaro.org>
Date: Mon, 17 Jun 2024 19:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] ufs: core: add support for generate, import and
 prepare keys
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
 andersson@kernel.org, ebiggers@google.com, neil.armstrong@linaro.org,
 srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, robh+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 kernel@quicinc.com, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, quic_omprsing@quicinc.com,
 quic_nguyenb@quicinc.com, bartosz.golaszewski@linaro.org,
 ulf.hansson@linaro.org, jejb@linux.ibm.com, martin.petersen@oracle.com,
 mani@kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au,
 psodagud@quicinc.com, quic_apurupa@quicinc.com, sonalg@quicinc.com
References: <20240617005825.1443206-1-quic_gaurkash@quicinc.com>
 <20240617005825.1443206-10-quic_gaurkash@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240617005825.1443206-10-quic_gaurkash@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/24 02:51, Gaurav Kashyap wrote:
> Block crypto allows storage controllers like UFS to
> register ops to generate, prepare and import wrapped
> keys in the kernel.
> 
> Wrapped keys in most cases will have vendor specific
> implementations, which means these ops would need to have
> corresponding UFS variant ops.
> This change adds hooks in UFS core to support these variant
> ops and tie them to the blk crypto ops.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> ---
>   drivers/ufs/core/ufshcd-crypto.c | 41 ++++++++++++++++++++++++++++++++
>   include/ufs/ufshcd.h             | 11 +++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/ufs/core/ufshcd-crypto.c b/drivers/ufs/core/ufshcd-crypto.c
> index c14800eac1ff..fb935a54acfa 100644
> --- a/drivers/ufs/core/ufshcd-crypto.c
> +++ b/drivers/ufs/core/ufshcd-crypto.c
> @@ -143,10 +143,51 @@ bool ufshcd_crypto_enable(struct ufs_hba *hba)
>   	return true;
>   }
>   
> +static int ufshcd_crypto_generate_key(struct blk_crypto_profile *profile,
> +				      u8 lt_key[BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE])
> +{
> +	struct ufs_hba *hba =
> +		container_of(profile, struct ufs_hba, crypto_profile);
> +
> +	if (hba->vops && hba->vops->generate_key)
> +		return  hba->vops->generate_key(hba, lt_key);

Couple more double spaces in this one

Konrad

