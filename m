Return-Path: <linux-kernel+bounces-193115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABEE8D2706
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F121C1C20FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C517B431;
	Tue, 28 May 2024 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wc594tiK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B305199B8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716931843; cv=none; b=b+C8TK5FzWGKobE7rE628uxQ2Uenq+MLhU2iIWO6x9ehVdSTLNwsCemYecTE1/uXBFi547if4JyGSVb3QpOp5Gq1/EgHuU4VhpHkNddtfWBnIh6UdwmSzee1lPvknTKAsE/uGSb1ArtjvAfgL+iwgpiIDvvD1/otYdSQZCaon0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716931843; c=relaxed/simple;
	bh=5rJ6C2fvM31iHiu5ju1m5SG2s+zChPz9rDT003tlYZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7JOJsh1GUf13kigYljjT+c+mkSEdTWHNgOSrsrxexQrKemETK4HVq+1akK3TL1HLAE5mAvruxk+qbMwiZZo5/frIMGEeNTj9etAeQsQFqmfhYVw3kL5WHAVk3997aEGHqIW4pdFWHwbPZc5lojKNtIuVBl6VdE3wmmATyQcju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wc594tiK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b59f8daso10385945ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716931841; x=1717536641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/886KhgNlZLfUXdG7YdFOApfJCvvDP8iK4brhkLxPE=;
        b=wc594tiKNC7VBSM9g457bt+sTju58yY6+dkPGKAWyOY/GecwCGOeKJRZOo6XkLGT89
         lxUpQNZoKNHgATwuD+ERmGE6f6Hx4SFYUIQgBVIv7ve5nhaRyD3c4gcxQnEEWUrcBeB0
         amHEm/85B2Y65i+30pbEhjV81AOCGdX7h2yQmHBr/71Hv6AjT5S4lxOugKPhoj14VLJn
         bGF3AA8vynTtPimXEh/JPNQFR3fmf3uvvIYbHfT9Al+Yr6zNEMXK2R5LjRDBXtqfTlkb
         e7YuwXGJeaUYpwYO7+6vu7fnw02CiB0h54n3KSHtwM8yHycF98wnEAz8zYzOJ0NBxLfY
         DAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716931841; x=1717536641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/886KhgNlZLfUXdG7YdFOApfJCvvDP8iK4brhkLxPE=;
        b=uc3wjiBoy/4sWJX/zmnFPQo/TwC/8bS0K9c8tOT/I0bfYtCDpL4nB9yg1aWBKuL6sf
         eO5OtwGBP+VMECX9mpEC4kMnUpyHjxfC+vWLRAqNnfSDyUbJ5eSFDSra0KkwV62Ivfq+
         xhRPQWnbjNNLNNs7g2mH0IcWfEmXNqv3SApwbiDULbnACu3gqnF7HDL4KOsCRJF4mcCi
         uvkXPWyHTaDfU7HK3IBTVh58GagQCU+e1fL2BarpEVc8cUnuMfHdpAfiNVwkgyJY7dS1
         4J5tA+s+bg9WADdEGuNwhN0Pl2kOpr85yuqqdVvwWlQreMC7BNONcFva0rgTdY1fpQPZ
         zrlA==
X-Forwarded-Encrypted: i=1; AJvYcCXyAmyCuz11/DrwYBq5MLKEFAkWFv1a7TrMRy8L85dV0LfmExo91tAA6LphcyXv23MeP1QTioDbzKq386g7YMB6d5onTmzL2bw62s5J
X-Gm-Message-State: AOJu0YwiEIg8798Nns1+LAiE+diFABGnBrhLkNpqtQ2qjg7S27IIq3WA
	wTLkXYcQ19sLZRepahQFdhIIfGetftIblHt1wU/2KRFlN4xv6WyeIB7I+5lt/Kyh4SiDMIPEF7D
	R
X-Google-Smtp-Source: AGHT+IEP4vGis8cJF35Vj03cY02Mx4GSJp1qf2JV+6D5QpG98m20SLH34o1uGa6a3mw4BJaNA2Si8g==
X-Received: by 2002:a17:903:2283:b0:1f2:fb89:1d3e with SMTP id d9443c01a7336-1f4486bd871mr151487525ad.7.1716931841312;
        Tue, 28 May 2024 14:30:41 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4c7:2691:aa4a:e6b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a50fbsm84917215ad.217.2024.05.28.14.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:30:40 -0700 (PDT)
Date: Tue, 28 May 2024 15:30:38 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 5/7] remoteproc: core: support of the tee interface
Message-ID: <ZlZM/hgSO4EeRVqS@p14s>
References: <20240521081001.2989417-1-arnaud.pouliquen@foss.st.com>
 <20240521081001.2989417-6-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521081001.2989417-6-arnaud.pouliquen@foss.st.com>

On Tue, May 21, 2024 at 10:09:59AM +0200, Arnaud Pouliquen wrote:
> 1) on start:
> - Using the TEE loader, the resource table is loaded by an external entity.
> In such case the resource table address is not find from the firmware but
> provided by the TEE remoteproc framework.
> Use the rproc_get_loaded_rsc_table instead of rproc_find_loaded_rsc_table
> - test that rproc->cached_table is not null before performing the memcpy
> 
> 2)on stop
> The use of the cached_table seems mandatory:
> - during recovery sequence to have a snapshot of the resource table
>   resources used,
> - on stop to allow  for the deinitialization of resources after the
>   the remote processor has been shutdown.
> However if the TEE interface is being used, we first need to unmap the
> table_ptr before setting it to rproc->cached_table.
> The update of rproc->table_ptr to rproc->cached_table is performed in
> tee_remoteproc.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 31 +++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 42bca01f3bde..3a642151c983 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1267,6 +1267,7 @@ EXPORT_SYMBOL(rproc_resource_cleanup);
>  static int rproc_set_rsc_table_on_start(struct rproc *rproc, const struct firmware *fw)
>  {
>  	struct resource_table *loaded_table;
> +	struct device *dev = &rproc->dev;
>  
>  	/*
>  	 * The starting device has been given the rproc->cached_table as the
> @@ -1276,12 +1277,21 @@ static int rproc_set_rsc_table_on_start(struct rproc *rproc, const struct firmwa
>  	 * this information to device memory. We also update the table_ptr so
>  	 * that any subsequent changes will be applied to the loaded version.
>  	 */
> -	loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
> -	if (loaded_table) {
> -		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
> -		rproc->table_ptr = loaded_table;
> +	if (rproc->tee_interface) {
> +		loaded_table = rproc_get_loaded_rsc_table(rproc, &rproc->table_sz);
> +		if (IS_ERR(loaded_table)) {
> +			dev_err(dev, "can't get resource table\n");
> +			return PTR_ERR(loaded_table);
> +		}
> +	} else {
> +		loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
>  	}
>  
> +	if (loaded_table && rproc->cached_table)
> +		memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
> +

Why is this not part of the else {} above as it was the case before this patch?
And why was an extra check for ->cached_table added?

This should be a simple change, i.e introduce an if {} else {} block to take
care of the two scenarios.  Plus the comment is misplaced now. 

More comments tomorrow.

Thanks,
Mathieu

> +	rproc->table_ptr = loaded_table;
> +
>  	return 0;
>  }
>  
> @@ -1318,11 +1328,16 @@ static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
>  	kfree(rproc->clean_table);
>  
>  out:
> -	/*
> -	 * Use a copy of the resource table for the remainder of the
> -	 * shutdown process.
> +	/* If the remoteproc_tee interface is used, then we have first to unmap the resource table
> +	 * before updating the proc->table_ptr reference.
>  	 */
> -	rproc->table_ptr = rproc->cached_table;
> +	if (!rproc->tee_interface) {
> +		/*
> +		 * Use a copy of the resource table for the remainder of the
> +		 * shutdown process.
> +		 */
> +		rproc->table_ptr = rproc->cached_table;
> +	}
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

