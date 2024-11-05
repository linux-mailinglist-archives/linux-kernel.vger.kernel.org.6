Return-Path: <linux-kernel+bounces-396525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A999BCE63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D57282678
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA51D6DB3;
	Tue,  5 Nov 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqCYQvXe"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC471D6DA3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730814919; cv=none; b=XLltXa1UrT964tpwG95xpNMzlmxpSftL6CpoGkEBBnqftRwbOToJYVi2yiD4xtbX64MCkePxARSmDxisyEdw8t8cOnLWdZxHd6J8BCM3RZdVzmT/ge33DimIGcqHRJ4ncdSWsTF+6E5z5GNJBMS+0JrUR/FtAl5BfJisxCvVQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730814919; c=relaxed/simple;
	bh=q3GUUlKx9/4DSdIfudTo/BHl0hN1/E6WoZ6HBZQcFBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rqtg09AKBtVF20WT0D8TjwTJQTU+HXBTEbicDa9Li8LDj9NQqkHLrWh4MAtXVoqrD4wATQqmb6dfiysU88ZsDRqMUYG+Hr8XkoVlvaQG7B5G2akYcjRDwbfQSlN6t4XZzwsJvnfB199skWT7+apB5yjzvNSHXiNueJ1HBc/hAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eqCYQvXe; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so5340593e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730814915; x=1731419715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYPfDLl1JujNUnzUwabCMz6D5QPnpcJrxkCJPH1YFNY=;
        b=eqCYQvXeHRGvRxdW7FlF+UFkmDn712x9y6/xZvjDPZW18kfuCoG1q4XMpfFuowGLJ3
         F4XDD296dEQCO/C/iuKCwkPKErI9dBWhJeMFx7P1OgKY4ATUg2TphS3tzP4HaH1R8Wnv
         NdDQpfhFnhQGsUmSUoENwpWmdBVFvf/Cy21ouNt4UfIBGfjWOkJQurqz1KdkNA9XjcD9
         jaxq+uQ7keCMJb0qOYRURV/lqe50825ln2WjFyt9LUz93wFMC68s2UrY/OAb6F0zqxqX
         WpvT0uTiRiHZjPBGrS+HytlrzdSBsJONgCnfOZ2PqtenqX+8PEqIpUkS6MofwR0bGT0R
         2H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730814915; x=1731419715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYPfDLl1JujNUnzUwabCMz6D5QPnpcJrxkCJPH1YFNY=;
        b=gd9pSl+3iQ+WyteX51dNCMqKrlNUOwrs0qT41LIC9Z0vmfgVNg/WRrYxqQHur9HWbY
         jgO78GYWYiIQ0ufVjjZ2Is6OXixxNSgwIu8+OX9BzNsvoIRT07chgXox4UVt2NNWb+BI
         3HvC99veENiQMSUWcICR4C6deDHGj8vgX6LuPJConudwb/qsx3YotNKwab7t0Tp7nld5
         ZeY17EyRl312l2cIzmqDx/yx8USN3sVpKp2Bf/ppV1r7RdkeQYTwgnQr7XXH/QyQenSX
         Xxge9cK+ItyTyfe7dzTe0YQHXi3pCT7plUrIEg8CP9e6mo8Dz558D8i5nPfEuX5neQM3
         0Xaw==
X-Forwarded-Encrypted: i=1; AJvYcCXL0AFzgZfK7YM1Dd+omsH/DR7DXAahYTK2b1Q+X3biHHWGUmiAjtfhKnXmhd0Vj69ftJMlf2gRZfeQ92U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuVA9O62kcRma+PCY6jrRWyOo4t0JekJ/O7ogLDByRO/rmWFF
	sSeHchQeLVJZyHib/Jp43f8hpwg/7yYpUoNpk91J0mxtFflellxLBMBJ2DBVvnk=
X-Google-Smtp-Source: AGHT+IEpdU8rDqLX+DIyNpSfiPybyrFjFo19IbFA9Zw/IdLK8a2VdSMO8JD0bOCCp6sr0LFzmU0S1w==
X-Received: by 2002:a05:6512:e9b:b0:539:fbfd:fc74 with SMTP id 2adb3069b0e04-53b7ed185a8mr13160964e87.40.1730814914500;
        Tue, 05 Nov 2024 05:55:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcbfa6sm2103558e87.208.2024.11.05.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 05:55:13 -0800 (PST)
Date: Tue, 5 Nov 2024 15:55:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] media: venus: hfi_parser: add check to avoid out of
 bound access
Message-ID: <b2yvyaycylsxo2bmynlrqp3pzhge2tjvtvzhmpvon2lzyx3bb4@747g3erapcro>
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-venus_oob-v1-1-8d4feedfe2bb@quicinc.com>

On Tue, Nov 05, 2024 at 02:24:54PM +0530, Vikash Garodia wrote:
> There is a possibility that init_codecs is invoked multiple times during
> manipulated payload from video firmware. In such case, if codecs_count
> can get incremented to value more than MAX_CODEC_NUM, there can be OOB
> access. Keep a check for max accessible memory before accessing it.

No. Please make sure that init_codecs() does a correct thing, so that
core->codecs_count isn't incremented that much (or even better that
init_codecs() doesn't do anything if it is executed second time).

> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_parser.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 3df241dc3a118bcdeb2c28a6ffdb907b644d5653..27d0172294d5154f4839e8cef172f9a619dfa305 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -23,6 +23,8 @@ static void init_codecs(struct venus_core *core)
>  		return;
>  
>  	for_each_set_bit(bit, &core->dec_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>  		cap = &caps[core->codecs_count++];
>  		cap->codec = BIT(bit);
>  		cap->domain = VIDC_SESSION_TYPE_DEC;
> @@ -30,6 +32,8 @@ static void init_codecs(struct venus_core *core)
>  	}
>  
>  	for_each_set_bit(bit, &core->enc_codecs, MAX_CODEC_NUM) {
> +		if (core->codecs_count >= MAX_CODEC_NUM)
> +			return;
>  		cap = &caps[core->codecs_count++];
>  		cap->codec = BIT(bit);
>  		cap->domain = VIDC_SESSION_TYPE_ENC;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

