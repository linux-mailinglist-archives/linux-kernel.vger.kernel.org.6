Return-Path: <linux-kernel+bounces-223555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F35289114C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8859FB219B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6667602B;
	Thu, 20 Jun 2024 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xf6bmuRc"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B574BF0
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919540; cv=none; b=G+1Bl9fqSTkWtKdKZ4QVIbV/UJI/t9WQVdGNTvMBR+ajeMVloG04y+RLsOv36NRoNuqgb9OPKHeHle+JiVY+2ShZ01uAa+/oRoA9s2QXmhyQa9e8VQAWFJDeGlZ/FVbDeRpW/gKzWon8saRQpmdpopyTi7vyd4r0cV6yZj7J6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919540; c=relaxed/simple;
	bh=R+gP8GWTKEf6vW2sVTmz7saJ84W+0KRqig3G9hZeYTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC6AKrSnIzM3FXfboSiHq0bRp3Hnr4VriND7x+pyZW5Dv7opqaNVg+8cb1L9tZKgjnOn9nKRyGyW0/JlB5LgCjTpPUuPurM20YJtR+gHgNp5rhMSt49gCP1yIJ+7/XH8tQJk+S+E6UqfnoltyzTtU2I3nhbniaiKYpzq3qqSJ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xf6bmuRc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so16565351fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718919537; x=1719524337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9KCIXUhFa5F6js3PXOw4A1bh3KoXXlrj5hfzxoF/A0=;
        b=Xf6bmuRcIBSs6UIqrNKcuq6P1dkrjnFFEEe3i1cW2OADRLdsH+CnUKg3he6BG3fMAL
         owLPQ8VqHXKBH8STQfZwQ/NgPSHEQsHBBb69E76Pel9XIboU0ls1aNSsnkiMNy9hyWg/
         syOltxdCh7IYypo88M0X88oYisqlBQwde7eWQHLVMHgKDHf1+goUOOthqayXVzI4E/5x
         3jKgDvf+SR+DwccenD+JohCVgk7ZKBqpphNpmYQ4D/xtJgoiXtzuUMSABNA+2mAjMe+R
         AymCQ2tyzPzkVo3k2z0VfD0h682YGNWrYTPTejVaI3kD0XI+I9BR7PzuAEboxPGMoXHt
         pXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718919537; x=1719524337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9KCIXUhFa5F6js3PXOw4A1bh3KoXXlrj5hfzxoF/A0=;
        b=JGMvGQt9xbylEBTaZ0pggKuIoJjxMOhlUqN9Evb4AD/1sTeAeTpZcQXNj+BlomkPKh
         eWO3t22aaK/mDdJYzcwjdQe8RYsNkBJ733DhPRh+K25R7pDVdAK2hJOD4KqfGYxTq2CX
         CfsRzv/CP9/2w3Ij/pLdqxmUGAjXPRZPVvWJ7ceu616dvnp2DDphCsoEOBFqblHyb0xM
         KzVTVaShOb/JBUtR2MAC9ELhoD5bW7+aBcW+Av34Vol2uo3sk6SDvgPSq0dG4Sv0jajG
         8mhh8RmM4RYSGV9WPrq4QjN28hAaUiMZ+Xutpj+xP6rWKYMgm11A/1+z4t1APn6wwSRo
         AH9w==
X-Forwarded-Encrypted: i=1; AJvYcCV0LDpo3+Kl8LjvvExHa2Bss++vntkJUiL3zYkee5OOHFvBJD5LeooYSx9sJgQALUfWK7SpwmUiRn9FUiZB+Cgb8JeAte1Mgm+XkweZ
X-Gm-Message-State: AOJu0Yyv9ESCI3o9ZI0XVn5aktcT3/If73ylP+5yAAJDzTxYhwGqmcRQ
	lD0nZk7OaX9aTzOnVfWWr4d1edp2giB784oWJX719JgmUrY1qz74Yqg10p35PXg=
X-Google-Smtp-Source: AGHT+IHiMxxgvNQOz2qJ9dqor7EtzwDmQRBfBf4gn70dlQm9/1P3yzhIJXB4quhP1LKkp/I04wrZuA==
X-Received: by 2002:a2e:914b:0:b0:2ec:1c9:badb with SMTP id 38308e7fff4ca-2ec3ce7dcd8mr44568761fa.9.1718919537058;
        Thu, 20 Jun 2024 14:38:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d7090f2sm319011fa.56.2024.06.20.14.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:38:56 -0700 (PDT)
Date: Fri, 21 Jun 2024 00:38:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>
Subject: Re: [PATCH v3 2/4] remoteproc: qcom: q6v5: Add support for q6 rmb
 registers
Message-ID: <o6aqjxyinwowtexwsucavwfqylx3wv3sihxvla442kskzqprbr@37rfxxzwsolg>
References: <20240620120143.12375-1-quic_kbajaj@quicinc.com>
 <20240620120143.12375-3-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620120143.12375-3-quic_kbajaj@quicinc.com>

On Thu, Jun 20, 2024 at 05:31:41PM GMT, Komal Bajaj wrote:
> From: Melody Olvera <quic_molvera@quicinc.com>
> 
> When attaching a running Q6, the remoteproc driver needs a way
> to communicate with the Q6 using rmb registers, so allow the
> rmb register to be gotten from the device tree if present.

rmb or RMB? And what is it?

> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5.h     | 8 ++++++++
>  drivers/remoteproc/qcom_q6v5_pas.c | 4 ++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
> index 5a859c41896e..95824d5b64ce 100644
> --- a/drivers/remoteproc/qcom_q6v5.h
> +++ b/drivers/remoteproc/qcom_q6v5.h
> @@ -7,6 +7,12 @@
>  #include <linux/completion.h>
>  #include <linux/soc/qcom/qcom_aoss.h>
> 
> +#define RMB_BOOT_WAIT_REG 0x8
> +#define RMB_BOOT_CONT_REG 0xC
> +#define RMB_Q6_BOOT_STATUS_REG 0x10
> +
> +#define RMB_POLL_MAX_TIMES 250
> +
>  struct icc_path;
>  struct rproc;
>  struct qcom_smem_stat;
> @@ -16,6 +22,8 @@ struct qcom_q6v5 {
>  	struct device *dev;
>  	struct rproc *rproc;
> 
> +	void __iomem *rmb_base;
> +

Why is this a part of the common structure and is not a part of the _pas
struct?

>  	struct qcom_smem_state *state;
>  	struct qmp *qmp;
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 8458bcfe9e19..b9759f6b2283 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -770,6 +770,10 @@ static int adsp_probe(struct platform_device *pdev)
>  		goto free_rproc;
>  	adsp->proxy_pd_count = ret;
> 
> +	adsp->q6v5.rmb_base = devm_platform_ioremap_resource_byname(pdev, "rmb");
> +	if (IS_ERR(adsp->q6v5.rmb_base))
> +		adsp->q6v5.rmb_base = NULL;
> +
>  	ret = qcom_q6v5_init(&adsp->q6v5, pdev, rproc, desc->crash_reason_smem, desc->load_state,
>  			     qcom_pas_handover);
>  	if (ret)
> --
> 2.42.0
> 

-- 
With best wishes
Dmitry

