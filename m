Return-Path: <linux-kernel+bounces-431930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193C39E42D2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE4116A44C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5320E000;
	Wed,  4 Dec 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Far6yeZu"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E220D511
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733334810; cv=none; b=Y7eq3TKAtVllNltthpfZbI1lNkNZOnb2PhCbB011dkGZW/pV0h9cEicsCivD2IIymFFLP7KYuUlQkS4Xtqt2vXDux5ZSBlUMNMCZmqjHEmpJIAWObywpA8I5vDZSjFX6HnhiwMY4U00i70pV5h+11/KAidpPazRCA99fps5nEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733334810; c=relaxed/simple;
	bh=AyKo+YmzS+804dulbnT0hBLtMmwENaVVL5O39CWyHfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jzr2891yrg/VIHU2otxbTbIOxTsjzCIL+RZ6hgY8GO3hmKD5FjeOPCjCFRF87ML2QdVrxeQ6nyrw+n4eGkLOYHcLP+xUvzF4WpCI1zptunSNozHXKVn9+bHrW9E7Oy7X4kfsC924GUFJuiQgjWTsUdprMJFFEeLdNpcrk7wdJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Far6yeZu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215a0390925so248485ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733334808; x=1733939608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+EdRdjsNOeXam2HnODspyLGBuskP5LGbao1nKrj0X3k=;
        b=Far6yeZui4GxeUze7xP8uTC8M1kvxQH/RfjxgopVyrrCUd9CTFMnR6PeoMU6eV/axh
         UZWSJ9q6vuXmIbSRxoRQHWxAAvqL/P4Dn9sheA++QRB/T4wFXzbVQN3JX0HocUroNJKE
         xVALB9gJeEi2HjaLTj2lqMOatfDqDqkB20Pd5uW57QaxexUjdFVOnT42FjQTmVW+gGhY
         T8w9JrjyeeBwBJCwCOF2ct+IRVRSkh5IReCozY01UTmqIT4BUwODd4r2FXV1b9X4xgiQ
         2Wa26xaZC5Bfjp9ewuDvICvjaOUqunSgRlOw6jcbCEPAnOjA67iMXtuH3MATY05kZAp+
         UVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733334808; x=1733939608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EdRdjsNOeXam2HnODspyLGBuskP5LGbao1nKrj0X3k=;
        b=q7SsA+zoHMxU1vuXafunt1OUp0QDD9NCxcnlxhgxQvs/6gzF3Bj0pO3GaLRvsBO1YN
         8HZb4bY698shNLdAI2Y8ipERsihccj9NJy/CRQhsXrhctNF3Lpx/CHJc8lSOg7LiErPz
         FNSSy6HFQHyX0qv9ALoj91L8XHrp2+lCAr8FUG0zC3Kt6/ayvz5sYdBOfWJ628jK9Q9k
         e/3Z6j7CoScQf9GKdmG8WKALf0t7NG3T9wD+/sYbS2bFXoDCGb+ItadzZY+4R9+7/qzG
         YCfl1lTEKWIJH3gtTU2g8w0+NVvK8wEElQYgkVLDl8SyEbqbk0mR4x2DkdQopbJE19mL
         /q7A==
X-Forwarded-Encrypted: i=1; AJvYcCUbKLnew1aGtGhftR1+cLbD8OK8p8GB/cKeBC6MNYGFOxA98Dyrutk/lGW4EapX0J1T6zEad4NJ6xZw1pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4nU3kWQonxERAyjRXq1BsPfulzc9v2tx9LVBLfzQgmrNqKNKU
	IihMAcwy+y9SxSanKFlVbVMMDyTiglZ6WJpjpbHk2sR0i4EM8J4cTyy6iefvk6Y=
X-Gm-Gg: ASbGnctDmpokK6Ux24nhayshCYZEtOe9xw/HhQYKUTsmNu9dpm6QilQflU+hnmdYuQ3
	hAuo8kTWuctyT//hoc8vgnXldiXnWh5yYBV1hGUicGo6sj4lO1JCWCjhXuEJpqcFYQqjq2g5roN
	HUzIkXDSa9pMwdg6MoAnQZyQFV7J/tk+hFJsXiip9WgsGasbg4cIDYdQB+Fem5kjO81d9hAiHeQ
	lyQXlEOC2+a/HKmW0LI+J/pjKL3RK2oGkedvcBds5fvHayObHkeVw==
X-Google-Smtp-Source: AGHT+IF3kCe4ZPa78Jwjel1HDu6mlsuiDp/NiBNhxqks+ew9mmhBlvqyTlfFPhbg92AJrj72T7k3kg==
X-Received: by 2002:a17:902:ea04:b0:215:7153:5697 with SMTP id d9443c01a7336-215bd200c68mr121380025ad.28.1733334807988;
        Wed, 04 Dec 2024 09:53:27 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:cb58:bf7f:6102:4f57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155249b0cesm84754705ad.211.2024.12.04.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:53:27 -0800 (PST)
Date: Wed, 4 Dec 2024 10:53:25 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 5/8] remoteproc: Make load_segments and load_fw ops
 exclusive and optional
Message-ID: <Z1CXFfXnSKkTPKU+@p14s>
References: <20241128084219.2159197-1-arnaud.pouliquen@foss.st.com>
 <20241128084219.2159197-6-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128084219.2159197-6-arnaud.pouliquen@foss.st.com>

On Thu, Nov 28, 2024 at 09:42:12AM +0100, Arnaud Pouliquen wrote:
> The two methods to load the firmware to memory should be exclusive.
> 
> - make load_segments optional returning 0 if not set in
>   rproc_load_segments(),
> - ensure that load_segments() and load_fw() are not both set,
> - do not set default rproc::ops fields if load_fw() is set.

This changelog is describing "what" the patch does rather than "why".  I have
commented on that before.

> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 4 ++++
>  drivers/remoteproc/remoteproc_internal.h | 2 +-
>  include/linux/remoteproc.h               | 7 +++++--
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index e4ad024efcda..deadec0f3474 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2477,6 +2477,10 @@ static int rproc_alloc_firmware(struct rproc *rproc,
>  
>  static int rproc_alloc_ops(struct rproc *rproc, const struct rproc_ops *ops)
>  {
> +	/* A processor with a load_segments() and a load_fw() functions makes no sense. */
> +	if (ops->load_segments && ops->load_fw)
> +		return -EINVAL;
> +

It is only a matter of time before someone needs both ->load_segments() and
->load_fw().


>  	rproc->ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
>  	if (!rproc->ops)
>  		return -ENOMEM;
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index b898494600cf..3a4161eaf291 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -170,7 +170,7 @@ int rproc_load_segments(struct rproc *rproc, const struct firmware *fw)
>  	if (rproc->ops->load_segments)
>  		return rproc->ops->load_segments(rproc, fw);
>  
> -	return -EINVAL;
> +	return 0;

Other than this hunk I would drop this patch completely.

>  }
>  
>  static inline int rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 55c20424a99f..4f4c65ce74af 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -374,8 +374,9 @@ enum rsc_handling_status {
>   * @find_loaded_rsc_table: find the loaded resource table from firmware image
>   * @get_loaded_rsc_table: get resource table installed in memory
>   *			  by external entity
> - * @load_segments:	load firmware ELF segment to memory, where the remote processor
> - *			expects to find it
> + * @load_segments:	optional load firmware ELF segments to memory, where the remote processor
> + *			expects to find it.
> + *			This operation is exclusive with the load_fw()
>   * @sanity_check:	sanity check the fw image
>   * @get_boot_addr:	get boot address to entry point specified in firmware
>   * @panic:	optional callback to react to system panic, core will delay
> @@ -383,8 +384,10 @@ enum rsc_handling_status {
>   * @coredump:	  collect firmware dump after the subsystem is shutdown
>   * @load_fw:	optional function to load non-ELF firmware image to memory, where the remote
>   *		processor expects to find it.
> + *		This operation is exclusive with the load_segments()
>   * @release_fw:	optional function to release the firmware image from memories.
>   *		This function is called after stopping the remote processor or in case of error
> + *
>   */
>  struct rproc_ops {
>  	int (*prepare)(struct rproc *rproc);
> -- 
> 2.25.1
> 

