Return-Path: <linux-kernel+bounces-192371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA88D1C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83931F24E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888E16DED6;
	Tue, 28 May 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rl5kBtq1"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBD17E8F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901945; cv=none; b=lF3cLApjyKKYGM4SVZDMFRjFGgLp5xUvF57R7L2ykVys4fUvHQQAHj6KG2kJ6kfgW7iGatm81lmLUtIFNR8iwDdvKNyEHky1CIbZBIu6KDQ2GhwYuVC/oF/Fo2jatXv/Oddk4cjP49qo7Qpv7R//RyKLgUt9kaPc72roDBgS7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901945; c=relaxed/simple;
	bh=iaHSfVk3cYotj/lpjrNnV72ctCzwvrJC062eqOjiZ64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMqnyBMDpTyaB/4jLs72wlyOwBXrNnzrRGTzsU8uwX7avmXecdiJXU4tHq9ZrJ0FafgVhEal7AWJF7GvGAyhIiTw8kJVnihb7/QIckOGQeSQAaEYi9Z+FTSbQGmCJseTJeHYgex+KDMzKiSVrGVtldAWVVdexnI0DH/3IWMgKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rl5kBtq1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52388d9ca98so1379302e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716901940; x=1717506740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VeSY2ceVXmdz5zqyxr0C6Kr9UZqmvZCx0+drlbb4RkY=;
        b=Rl5kBtq1cbzmSgYiWxECD6OpsjiHBs93onbqxBIa04gETjs4w4a5Mg1SmH1uZL8532
         i3Lpi3GB9Td+Z8m7HIhKbHoBXAyOFKWzc3KweEFwK5xZhn/vaokGUIyBZtWQ8q3gg4Ak
         QO7fZ5LrwALvOMMuMArbu0KaDPTC06rbvlncJHb+gzqKKa2KHAp8i3FVIoR5GTVe30ia
         5wg60Zv64OCkTzKppQas+/TkVYT70cN3yFqK+/zQ4updmPPICUttnwwMRE2uRD81qiDy
         PbNuwkXrL8XJ+/fLivuFqcDZFHgyaF7PAIk/3dMgw+CzJ2UB2Zw4vF1JehRSHvZ4t3Vf
         KRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901940; x=1717506740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeSY2ceVXmdz5zqyxr0C6Kr9UZqmvZCx0+drlbb4RkY=;
        b=ZXWPqAmDnzbs1j09S9/QELuTM3GX0XJGxUYPkAOcq0hGAIVKlO3eE7J/yOYTJjLNoQ
         4h0TB1/fpPCXdt3DDYazdW0niZ3yDOxdu1b+N3U/eED2p/62mDezO41swyptpf55tRXd
         lZtmBI0xZngY0/r4MOM3lqUmJ7582MdMztPeWtP7IgSKYyKwyG7/toUV3ZSTxvBaG7vt
         J2WWVt018J3H/EJ/SoGq6b/jaGacwvWYoSRVm2npVNzvZ71FKsxsmf/RQSt6FrasaqEa
         wCoeFtk35bsoUvLzEVgPl9+B+eWqlnAIQrSNLlaOXSQ8TQ5w2F2JuPr+r19zmsNx8hin
         Gg+g==
X-Forwarded-Encrypted: i=1; AJvYcCVvtpoDdPWnQp7tVz0WJI4Wgzp/unS1QlOkAEnQnJLDfGY20CSSgUoiJ9qnhCDBplT0CNaS60vuAxPN/8ZImEqM/8Gwud9NyjmORTrz
X-Gm-Message-State: AOJu0YyvfoAuTFFQ3HCPBLd7KK1tULzrO4X0wOoDM96tC++MsiwidVm/
	TRs3wj7wnTqJFkGlj++u8YDvM5rQL6T4QzDjUSrFCfHyGJ5jVNQI7UoEGEMlaAk=
X-Google-Smtp-Source: AGHT+IEQsnfewAV9/ZWWR29dWl1FWNwoP9P5zP+0yccPOd0kgBwvS7Qmct6DbXrltf+MWC5dAYOZPA==
X-Received: by 2002:a05:6512:3ba6:b0:523:78de:11a3 with SMTP id 2adb3069b0e04-52965290530mr14260463e87.2.1716901939904;
        Tue, 28 May 2024 06:12:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296f410fc1sm939673e87.117.2024.05.28.06.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:12:19 -0700 (PDT)
Date: Tue, 28 May 2024 16:12:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com
Subject: Re: [PATCH v2 8/8] misc: fastrpc: Add system unsigned PD support
Message-ID: <zwlzdhb5zn2wx6bew437hzj7l6nsj2ccekkkabatykmtzihotr@5ocy5wqxtoah>
References: <20240528112956.5979-1-quic_ekangupt@quicinc.com>
 <20240528112956.5979-9-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528112956.5979-9-quic_ekangupt@quicinc.com>

On Tue, May 28, 2024 at 04:59:54PM +0530, Ekansh Gupta wrote:
> Trusted CPU applications currently offload to signed PDs on CDSP to
> gain some additional services provided by root PD. Unsigned PDs have
> access to limited root PD services that may not be sufficient for
> all use-cases. Signed PDs have a higher dynamic loading latency
> which impacts the performance of applications. Limited root PD
> services could be opened up for unsigned PDs but that should be
> restricted for untrusted processes. For this requirement, System
> unsigned PD is introduced which will be same as Unsigned PD for
> most part but will have access to more root PD services. Add
> changes to offload trusted applications to System unsigned PD
> when unsigned offload is requested.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c      | 9 +++++++++
>  include/uapi/misc/fastrpc.h | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 7f81a18b8aea..ebe20915392f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -122,6 +122,7 @@
>  enum fastrpc_userpd_type {
>  	SIGNED_PD			= 1,
>  	UNSIGNED_PD			= 2,
> +	SYSTEM_UNSIGNED_PD	= 3,

Any reason why this is not indented properly? Maybe you have
non-standard tab width?

Also the usage of non-bool type makes sense here, not in the 'unisgned
PD' patch. Please use bool beforehand and switch to an enum here.

>  };
>  
>  static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
> @@ -1552,12 +1553,20 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>  	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
>  		fl->userpd_type = UNSIGNED_PD;
>  
> +	/* Disregard any system unsigned PD attribute from userspace */
> +	init.attrs &= (~FASTRPC_MODE_SYSTEM_UNSIGNED_PD);
>  
>  	if (is_session_rejected(fl, !(fl->userpd_type == SIGNED_PD))) {
>  		err = -EACCES;
>  		goto err;
>  	}
>  
> +	/* Trusted apps will be launched as system unsigned PDs */
> +	if (!fl->untrusted_process && (fl->userpd_type != SIGNED_PD)) {
> +		fl->userpd_type = SYSTEM_UNSIGNED_PD;
> +		init.attrs |= FASTRPC_MODE_SYSTEM_UNSIGNED_PD;
> +	}
> +
>  	if (init.filelen > INIT_FILELEN_MAX) {
>  		err = -EINVAL;
>  		goto err;
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index f33d914d8f46..3b3279bb2cf9 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -62,6 +62,8 @@ enum fastrpc_proc_attr {
>  	FASTRPC_MODE_SYSTEM_PROCESS	= (1 << 5),
>  	/* Macro for Prvileged Process */
>  	FASTRPC_MODE_PRIVILEGED		= (1 << 6),
> +	/* Macro for system unsigned PD */
> +	FASTRPC_MODE_SYSTEM_UNSIGNED_PD	= (1 << 17),
>  };
>  
>  /* Fastrpc attribute for memory protection of buffers */
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

