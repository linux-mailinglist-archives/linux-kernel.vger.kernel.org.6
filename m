Return-Path: <linux-kernel+bounces-193090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB118D26B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E142C1F26D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3D76033;
	Tue, 28 May 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozQOsBPs"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B91224D1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930240; cv=none; b=cXxPMDujgiToMQBXuJ5z9W5ZsvFOViWI9AQlL0FkUZRClpUdsY5AJJU41bFKDGY0lPoTYpZcmAwYxCbKzVXP+s/JEOrxeikiAwNK1A8UxkwXqaJDF/35+W05T/OVs0BI01UpZLeYG0YLBRqBtheu4UGutAI6ha4yEij2Vs6SU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930240; c=relaxed/simple;
	bh=NrCL3ttWtjWyjhUzmrA/40ri0lQhmCPKGkcqsktYAIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex1ZKSpljgkFeUq/Ay1uhWVyvDucfrulfXkG8DgEjzPPOtpY+wm+DNscG/uWZu+lqVCpaH9OPXOhL0NE2w12gnqtJtWncX9Mw2osyZqKsHA8l1ZPN+xeWmg2N+Q7lb9byRVCbX1ZdM07RNEXHJH9DDjpRKOwNWdVQQ3vZ6+52oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ozQOsBPs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f48e9414e9so2297735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716930238; x=1717535038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RmEhT88aTz3DGDqj6R9iZYqHzSu06mmxBxyiGQRj0OU=;
        b=ozQOsBPsLV9xtQdcp5pXzFh60IveYz7C5eCIfuOTVGgI/euTNh7lNx3lLUduy56cwg
         X57aDi+OU/LinOvHy4HPJR/iaSzvjr9csschHFTZugLgVpKxtzWZaDID1XYYcGK9Zzq9
         pKPGyJ9pOy0TZ2/i1+73prBrKrMeiPsKJOvg/pMF0qI1xPY7IqP7j69zCE6xtSAt4gIw
         XKrMyZlfXTNZNcevcGRit/cWQ6GlPYvJd5SJs5weNHVCHQvOndsMZKdLNxsyaA2Ssxz6
         WnnxdK+xtGh9WG8TdQxzi14UAJhh6zC2WGMaCHx5kgyKcFntvLRHFWIkV+VE2S1SpKOY
         4WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930238; x=1717535038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmEhT88aTz3DGDqj6R9iZYqHzSu06mmxBxyiGQRj0OU=;
        b=QmMx0wNPXqSb59esUxquwig7JMM5OiSxAdF6ZlfnZlIm4u4X6wWiJkDMSTaUiHreXG
         gIQ3fU4kHyO2SGNl8+e03EPr34twXzJX9fdhPEBK3mQaHUcLprHuFRloGrLW9rce9g7Y
         c0aFvZbmKxJEpjaOdSkAtt1ZGFjhrrPfVjF6LLcfGJ09LNxyR/v8thj40zOw5RBvRRAU
         xGSWBnL5SK87vetQbarZ8e+CD5eSDsEErU2ag8YEJzo8vOqbfkWQtKA3SGmSToYhKFLS
         TvjKVkFGaqQFnNdMjek8dN5p8HjHesaf8Iq3Rz/Cs5YzSk1NcCGgFBGEKKOv8DylVMEn
         V+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCW182pXWxv4OkIzvO/xcRPri59B/uzIohFt5CQjpciywtA/j4oXSmXd96eMBWUx0ZGrIb+GUP8O3F2zuxRZQN45TOxkJ6XYfuy/Sz+H
X-Gm-Message-State: AOJu0Yy12bw1r8tbV55cXRqCCH1rTDknfr+cwfQ33ouAlucFn8FPfF5m
	75IDkHwLcKyj3LsSL0xAvefrXji4lnn0PE2n8svxEcU94RdVV1ybjiHC8fcmjCg=
X-Google-Smtp-Source: AGHT+IFSLsuBgNepaa9uXWFhRm7TTE7smDcKQUDGy+q3E60dnDvPx31raQ/EGznET3bpmPoPeK+Vjg==
X-Received: by 2002:a17:902:d485:b0:1f3:1092:ab45 with SMTP id d9443c01a7336-1f4eaaebf79mr2195525ad.26.1716930238350;
        Tue, 28 May 2024 14:03:58 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4c7:2691:aa4a:e6b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96fd68sm84916855ad.171.2024.05.28.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:03:57 -0700 (PDT)
Date: Tue, 28 May 2024 15:03:55 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 4/7] remoteproc: core introduce
 rproc_set_rsc_table_on_start function
Message-ID: <ZlZGu16h1xsM3es5@p14s>
References: <20240521081001.2989417-1-arnaud.pouliquen@foss.st.com>
 <20240521081001.2989417-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521081001.2989417-5-arnaud.pouliquen@foss.st.com>

On Tue, May 21, 2024 at 10:09:58AM +0200, Arnaud Pouliquen wrote:
> Split rproc_start()to prepare the update of the management of

I don't see any "splitting" for rproc_start() in this patch.  Please consider
rewording or removing.

> the cache table on start, for the support of the firmware loading
> by the TEE interface.
> - create rproc_set_rsc_table_on_start() to address the management of
>   the cache table in a specific function, as done in
>   rproc_reset_rsc_table_on_stop().
> - rename rproc_set_rsc_table in rproc_set_rsc_table_on_attach()
> - move rproc_reset_rsc_table_on_stop() to be close to the
>   rproc_set_rsc_table_on_start() function

This patch is really hard to read due to all 3 operations happening at the same
time.  Please split in 3 smaller patches.

> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 116 ++++++++++++++-------------
>  1 file changed, 62 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index f276956f2c5c..42bca01f3bde 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1264,18 +1264,9 @@ void rproc_resource_cleanup(struct rproc *rproc)
>  }
>  EXPORT_SYMBOL(rproc_resource_cleanup);
>  
> -static int rproc_start(struct rproc *rproc, const struct firmware *fw)
> +static int rproc_set_rsc_table_on_start(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct resource_table *loaded_table;
> -	struct device *dev = &rproc->dev;
> -	int ret;
> -
> -	/* load the ELF segments to memory */
> -	ret = rproc_load_segments(rproc, fw);
> -	if (ret) {
> -		dev_err(dev, "Failed to load program segments: %d\n", ret);
> -		return ret;
> -	}
>  
>  	/*
>  	 * The starting device has been given the rproc->cached_table as the
> @@ -1291,6 +1282,64 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  		rproc->table_ptr = loaded_table;
>  	}
>  
> +	return 0;
> +}
> +
> +static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
> +{
> +	/* A resource table was never retrieved, nothing to do here */
> +	if (!rproc->table_ptr)
> +		return 0;
> +
> +	/*
> +	 * If a cache table exists the remote processor was started by
> +	 * the remoteproc core.  That cache table should be used for
> +	 * the rest of the shutdown process.
> +	 */
> +	if (rproc->cached_table)
> +		goto out;
> +
> +	/*
> +	 * If we made it here the remote processor was started by another
> +	 * entity and a cache table doesn't exist.  As such make a copy of
> +	 * the resource table currently used by the remote processor and
> +	 * use that for the rest of the shutdown process.  The memory
> +	 * allocated here is free'd in rproc_shutdown().
> +	 */
> +	rproc->cached_table = kmemdup(rproc->table_ptr,
> +				      rproc->table_sz, GFP_KERNEL);
> +	if (!rproc->cached_table)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Since the remote processor is being switched off the clean table
> +	 * won't be needed.  Allocated in rproc_set_rsc_table_on_start().
> +	 */
> +	kfree(rproc->clean_table);
> +
> +out:
> +	/*
> +	 * Use a copy of the resource table for the remainder of the
> +	 * shutdown process.
> +	 */
> +	rproc->table_ptr = rproc->cached_table;
> +	return 0;
> +}
> +
> +static int rproc_start(struct rproc *rproc, const struct firmware *fw)
> +{
> +	struct device *dev = &rproc->dev;
> +	int ret;
> +
> +	/* load the ELF segments to memory */
> +	ret = rproc_load_segments(rproc, fw);
> +	if (ret) {
> +		dev_err(dev, "Failed to load program segments: %d\n", ret);
> +		return ret;
> +	}
> +
> +	rproc_set_rsc_table_on_start(rproc, fw);
> +
>  	ret = rproc_prepare_subdevices(rproc);
>  	if (ret) {
>  		dev_err(dev, "failed to prepare subdevices for %s: %d\n",
> @@ -1450,7 +1499,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	return ret;
>  }
>  
> -static int rproc_set_rsc_table(struct rproc *rproc)
> +static int rproc_set_rsc_table_on_attach(struct rproc *rproc)
>  {
>  	struct resource_table *table_ptr;
>  	struct device *dev = &rproc->dev;
> @@ -1540,54 +1589,13 @@ static int rproc_reset_rsc_table_on_detach(struct rproc *rproc)
>  
>  	/*
>  	 * The clean resource table is no longer needed.  Allocated in
> -	 * rproc_set_rsc_table().
> +	 * rproc_set_rsc_table_on_attach().
>  	 */
>  	kfree(rproc->clean_table);
>  
>  	return 0;
>  }
>  
> -static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
> -{
> -	/* A resource table was never retrieved, nothing to do here */
> -	if (!rproc->table_ptr)
> -		return 0;
> -
> -	/*
> -	 * If a cache table exists the remote processor was started by
> -	 * the remoteproc core.  That cache table should be used for
> -	 * the rest of the shutdown process.
> -	 */
> -	if (rproc->cached_table)
> -		goto out;
> -
> -	/*
> -	 * If we made it here the remote processor was started by another
> -	 * entity and a cache table doesn't exist.  As such make a copy of
> -	 * the resource table currently used by the remote processor and
> -	 * use that for the rest of the shutdown process.  The memory
> -	 * allocated here is free'd in rproc_shutdown().
> -	 */
> -	rproc->cached_table = kmemdup(rproc->table_ptr,
> -				      rproc->table_sz, GFP_KERNEL);
> -	if (!rproc->cached_table)
> -		return -ENOMEM;
> -
> -	/*
> -	 * Since the remote processor is being switched off the clean table
> -	 * won't be needed.  Allocated in rproc_set_rsc_table().
> -	 */
> -	kfree(rproc->clean_table);
> -
> -out:
> -	/*
> -	 * Use a copy of the resource table for the remainder of the
> -	 * shutdown process.
> -	 */
> -	rproc->table_ptr = rproc->cached_table;
> -	return 0;
> -}
> -
>  /*
>   * Attach to remote processor - similar to rproc_fw_boot() but without
>   * the steps that deal with the firmware image.
> @@ -1614,7 +1622,7 @@ static int rproc_attach(struct rproc *rproc)
>  		goto disable_iommu;
>  	}
>  
> -	ret = rproc_set_rsc_table(rproc);
> +	ret = rproc_set_rsc_table_on_attach(rproc);
>  	if (ret) {
>  		dev_err(dev, "can't load resource table: %d\n", ret);
>  		goto unprepare_device;
> -- 
> 2.25.1
> 

