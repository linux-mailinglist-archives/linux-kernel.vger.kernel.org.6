Return-Path: <linux-kernel+bounces-210546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8A904562
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B4128198B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 19:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A630B8595F;
	Tue, 11 Jun 2024 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxG1MlA+"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E382490
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135813; cv=none; b=C60ONA6xpBNPtkaGG9GIvokuEfhPt0IgQzS7MvIl7AY2PmZzgvSElV9SfiFbeIIhMiuHuUj697quvdVjEUqpfXGVdiZR4TqVpJLYbnZ4c1d8OGN/p6MdsTHbhF6IWTf2IsKZRKMA6cMnY9O/b4um5wu+tUejpeKg/x+w0axlMf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135813; c=relaxed/simple;
	bh=f52ZfaDJyYfE45I/t8usiFuaWQE/tHK60yXBoddILOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRXsm24jJsPeLlvt6yntKktLLkdMUTRJ5mxohaF/2KMdbBd+4J6sXSleGvgJesFAIADkovIrlkU2bzP9Lp0/gyG4AdtOpzZEBlYO/w9z5ZDNpCqyknlJxpnXcAbU31MUtKyvvY5lIWut6J4j6oTyw+Qp8wgYjD8OQRAeuP8g+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PxG1MlA+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so66026251fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718135809; x=1718740609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEPghwR2XmpVCR3o/1blYpkcLH7773zRI7ZULoFlz0s=;
        b=PxG1MlA+qIMQ2WxfHlqOv20aeM7F5dXXlKw/cC8lS7S66c9psN7hNEcrZQ99hWWnUZ
         lFWQycq1NoarAHLiCyVw7iA5SRSNk7qfgMIIjnHsMKM+hiDnLt3OYkA6pkdia+lxZvJO
         y8KIRa7NPRy/tOUGbVHNasMT+ybir6qc26UAEJt5pIHxdVCLMm++SYuUMPwwS2J/CUGE
         D+bWVaZr4b0C/3Q+PjAl0weqnF6EfAAQjCfAGuDT1yg5nE4uqywdUPLAFjvHl8UqiCyV
         ULSbjc1EsciQlwzl4GGbZGqV8ncU9aTwPfu5MEYl3gKohVGSCHnTH1aA48hzFGbMMbsF
         bBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718135809; x=1718740609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEPghwR2XmpVCR3o/1blYpkcLH7773zRI7ZULoFlz0s=;
        b=ddk+lLaa1ONi7PTvx0Zzz2aB2XpMEbHy6ZP/f2BvagIlxfNC9uPx8DOUx9+15Nu2sm
         Mwpcl8xQo19nb7QJOP6uN46QPs47hJxm1M/h6nnuGmOn7469wAiFHN9e2YZfHnUsG08E
         UNLoL2/U+YBBF0TWnaKrdapYw4r5Bp4B9pa1g9Vrq93H2xEkrhDXIqgAdMBqD2sT00Gl
         7AaBEsgv3YvAO/WvNA5QKGblNY8/kx3iYghV34S1KZ9rd5Ex/IBMbE8Hqp/Oom3KiYsR
         g4hL3hEV/aBMivCYCOR/m+FcDDB6twIOGEdUrdW2qPwNsN28xl1WtwfP4pXQIKzmSLKp
         su3w==
X-Forwarded-Encrypted: i=1; AJvYcCXxwLu5PATI4j/sK6HptMfI5c3nBbLQfgkzhx9osH9UlAtX3jt/GWYIjtHcfvaL0z2SCt+ZVhD+KZMhMXRcDF01vw2CSLHlzvD2in31
X-Gm-Message-State: AOJu0YzsfZflZw360EZfxbjW+H/qAaaGAEaevzg5R4/L/1/QQoBYl+Tk
	ggB6X49pVlef9lDIl4U4L9n2gxpO0Y7g9cHuoOUJJGPbvLApKHz3MgoEZKBYOKhiJYAka7aROEW
	8
X-Google-Smtp-Source: AGHT+IEr4GTdU4AxnL8+UGYWalCBdzfI2Rw2hfJifpjP74yQ2XM4sfXmhKiwG0IruqyzDVD2eeEfRA==
X-Received: by 2002:a2e:be04:0:b0:2eb:e365:f191 with SMTP id 38308e7fff4ca-2ebe365f2bamr53815041fa.15.1718135809150;
        Tue, 11 Jun 2024 12:56:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebdaeac43esm15379711fa.24.2024.06.11.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 12:56:48 -0700 (PDT)
Date: Tue, 11 Jun 2024 22:56:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dylan Van Assche <me@dylanvanassche.be>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Caleb Connolly <caleb.connolly@linaro.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 1/2] misc: fastrpc: support complete DMA pool access
 to the DSP
Message-ID: <vrw2v45cjem4qzhwtvapwzyjtq42dzkirkvxajgfd4retvmjyw@64fnc3ewjlnf>
References: <20240524161423.15392-1-me@dylanvanassche.be>
 <20240524161423.15392-2-me@dylanvanassche.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524161423.15392-2-me@dylanvanassche.be>

On Fri, May 24, 2024 at 06:14:02PM +0200, Dylan Van Assche wrote:
> To support FastRPC Context Banks which aren't mapped via the SMMU,
> make the whole reserved memory region available to the DSP to allow
> access to coherent buffers.
> 
> This is performed by assigning the memory to the DSP via a hypervisor
> call to set the correct permissions for the Virtual Machines on the DSP.
> This is only necessary when a memory region is provided for SLPI DSPs
> so guard this with a domain ID check.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 4c67e2c5a82e..c06667b29055 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2255,6 +2255,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	int i, err, domain_id = -1, vmcount;
>  	const char *domain;
>  	bool secure_dsp;
> +	struct device_node *rmem_node;
> +	struct reserved_mem *rmem;
>  	unsigned int vmids[FASTRPC_MAX_VMIDS];
>  
>  	err = of_property_read_string(rdev->of_node, "label", &domain);
> @@ -2297,6 +2299,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  		}
>  	}
>  
> +	rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
> +	if (domain_id == SDSP_DOMAIN_ID && rmem_node) {

I think we can drop the domain_id check here.

The rest looks good to me.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +		u64 src_perms;
> +
> +		rmem = of_reserved_mem_lookup(rmem_node);
> +		if (!rmem) {
> +			err = -EINVAL;
> +			goto fdev_error;
> +		}
> +
> +		src_perms = BIT(QCOM_SCM_VMID_HLOS);
> +
> +		qcom_scm_assign_mem(rmem->base, rmem->size, &src_perms,
> +				    data->vmperms, data->vmcount);
> +
> +	}
> +
>  	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
>  	data->secure = secure_dsp;
>  
> -- 
> 2.45.1
> 

-- 
With best wishes
Dmitry

