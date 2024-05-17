Return-Path: <linux-kernel+bounces-181904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06428C8313
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666161F232E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A423758;
	Fri, 17 May 2024 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qg/Fr2OF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4F22324
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937095; cv=none; b=DtEtszDq4aQGSuKE++KUbyvRYatl6uaOJ1KTV23PaOJqjREKyMZ7TE41V4rtgV12EBT54qAzToW98JkCmKx66Z30QCl31Ie5cKfenXc12ABLxGZhh0uiPtiotqC1inA7l638RG6GZ263IrVH/bZ7drrod+fwKRHymMRXut1aKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937095; c=relaxed/simple;
	bh=DoLTsawHpeTfuB9cwiMX8gLog+phP2olzr7YENPNrxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfiR8iDQ5u4bGRKW97ilgfmUbQm785ZKMMuU634jEC92AqKJQYP6i9jBwCcMSdfywQr8Yw4dJpxFoDfTitwVY6Nck+MHqo54rd+lOR1uMU8N4yaTm/yrPQXkcfPYk4d4BttGW3QbNWzvQf+vKYTy3dMsuh8MvNlD9YuGO2/AE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qg/Fr2OF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59cf8140d0so375706266b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715937092; x=1716541892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3wbo50xwb3HFwy2Js34OThKfA1hpUVathWWvMAHMruo=;
        b=qg/Fr2OFlFQTT3Aol9ciNz8tsTHJM2U1dKVMIOqUlhQzbAOSrNKlNhTCX4anwSpxmN
         rkA/jtsf5La4dmXoZfOo2NlVokOQIhd6SrRaI3sNjkWN9DVgaFjC4Q/uh8vDvBnh2ut1
         fvGoKabouycpXWto8NWaYLuvZwv2f7hUfQwebBajG0T3QLPKD7U5nnMzeYZllPDfPUfs
         YQpn8Vo3oPoPQ5/76amJO38E02xiB1Dmzvg44cZWB0qBQCS64DY6gypy7MPof5WhTJA8
         Vzi/zem1SSANoyoqUEY5vOxaGsunwLx86pOXMnG3dMU1jgHWR/Bl7JS6mcO7WK+IYdff
         TJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715937092; x=1716541892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3wbo50xwb3HFwy2Js34OThKfA1hpUVathWWvMAHMruo=;
        b=ChPJRhmgbyUs/1+C48fBL38b6YEyxO7MnuTFDTT5OvuLOZS7AtLiE+/DOGXF210gfT
         S7/2p/+lzvSPVdHsdDGe0SJzfnWzaVWdtj4/HopeL9axNZPXgfY2ef8KRO3nhd2TffA/
         /PvAK6Um5xU1OL3hMSY89yzqYLfIO3rW6An/4qbwWhpimfujLSZdDUTcBrx8l2vCcOK9
         JlQh0+HStDl6HV3Zacv9/rkjBQdMNf8tsMmyfyhlt+tY4IyW7KF8V6fSMKtT3r5Ucdlm
         L/g78pwfAxLR6U+8NlkhBHpuIzWaU5uRYjZj/1C7o+H0kkgAa9QUISx6FLme/iUc5z3x
         CCzw==
X-Forwarded-Encrypted: i=1; AJvYcCXlE6eFJ0VfR+jGk6yNB9esu7/hgxaSrgxPq6EzwSupYyNVTjuXK34t3jkF2MWtafzcXkUjqsgOY/uT7nJD8xh0LL8I71hxab29N2C7
X-Gm-Message-State: AOJu0YwuLesJ/Qcmm7UjcNGASXBJLMj4Pdnp4xGrQTvVRO9eKUDrCEoC
	TzZlRF9QJK3QuBGmbcqqrirDU6Tt6mXIeti1Yp9VXslBtRU+BuO7ucFWd+sudSk=
X-Google-Smtp-Source: AGHT+IFUuE27SOBRiwiM5jzv8pfjnHU4AIrW12/v2KmpB6rpAdGZVts7qvikNVwq4pSeqOpzntfyrg==
X-Received: by 2002:a17:906:32d9:b0:a59:dd9d:6da5 with SMTP id a640c23a62f3a-a5a2d54c07amr1318225066b.3.1715937092597;
        Fri, 17 May 2024 02:11:32 -0700 (PDT)
Received: from [10.91.1.133] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892471sm1096886566b.84.2024.05.17.02.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 02:11:32 -0700 (PDT)
Message-ID: <39b66355-f67e-49e9-a64b-fdd87340f787@linaro.org>
Date: Fri, 17 May 2024 11:11:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: qcom: gpi: remove unused struct 'reg_info'
Content-Language: en-US
To: linux@treblig.org, Frank.li@nxp.com, vkoul@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240516152537.262354-1-linux@treblig.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240516152537.262354-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2024 17:25, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> Remove unused struct 'reg_info'
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   drivers/dma/qcom/gpi.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 1c93864e0e4d..639ab304db9b 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -476,12 +476,6 @@ struct gpi_dev {
>   	struct gpii *gpiis;
>   };
>   
> -struct reg_info {
> -	char *name;
> -	u32 offset;
> -	u32 val;
> -};
> -
>   struct gchan {
>   	struct virt_dma_chan vc;
>   	u32 chid;

More detail in the commit log please - is the structure unused ? What is 
the provenance of it being added and becoming dead code.

More detail required here.

---
bod

