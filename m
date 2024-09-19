Return-Path: <linux-kernel+bounces-333285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3EE97C666
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8181F273B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B003E19B3E3;
	Thu, 19 Sep 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfqaLzg8"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51073199381
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736209; cv=none; b=skZVOxUAHXnt8M0XQYWJznX+mGLM3Nn6xfR/MrA4Xt74h/zKOL25FiBot6F3M4ZVewjYtXTF+2iaRcHUMLdFkc8uNhi75yUUWSFOQWkfVJc3MwgMIWEMpGaoq7+wx/0OmgM++X/EGh/OSGeRJpUyXrdVuBSjQvIOCUZK+Fr5IxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736209; c=relaxed/simple;
	bh=Kg6qWDVTVJC9Yu0YXI44B93jdutxj4y/cCo0bwD8peg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qosg1UenGRhsdZm6y4+8p2qq9rDPEMRLRO8LVffZbjyW823mtQzHiywBmVEoYMUnVmChmot/uyXDQvng3TIPuin7sl15vUV+C7pqh3PfL0mAovc4SpFqluhAPH8721358Mdw0u7kHYTO/ATlTfU1ABcddNH1AUhda53Uf+5JtH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PfqaLzg8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5367ae52a01so658422e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726736205; x=1727341005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0fjrFt8H0uQ2396C/wLSUJ2SYMrzOJLqihwcUbz0SRo=;
        b=PfqaLzg8OpAoyUekTAnQnEp241xMHmr+U1JbkhMOeyQGZ7DzO9nVoUgsFbld4tCp7W
         Bzql4O3+/VUCw+vvpxw4POrrt+rEqiGlzyY5mk/zzX59hW64gUujLHUVzSWlbQNfLWrg
         2pR+/qX3Vmow1BhLQnroh4LhAaZ7xo9+fyKe4pT9vuVod1F56Sb1YwuMs0PYKevDtjgv
         AU6iviSlQWPuhivYDd4bjYv3903IRPHo6rICwGYJcfsWfmH3neMEHLnLLJzmoIPU8lXu
         dd+1La7ZN6xzlExjeHVlEf46Y8vj3zM3sGCFn5qrQIZU5sR1TyVpiMryXaoam40O8ia6
         Izqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726736205; x=1727341005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fjrFt8H0uQ2396C/wLSUJ2SYMrzOJLqihwcUbz0SRo=;
        b=AYoj26YQ5azhLJXemzfWrat6E61R2OiEdvu6lqszBXnFhDr/V9s45w+esCSzGhGATN
         fusHi/SvlQuqpPNujLyVoVPpqlpqMS3ldV/IACdtFeN0qdYDzCrvOwC6f3gp3eeXDyVO
         +KGMMN9LdZYPMnD1div/bTQtt24CrTkCT5TSVKoYYyyHIAO45xXXgBOvRl/Zo/VACshY
         PerZNL0idjgvXxK/WvQqRmIlUweY3S7vxN1T1AcBBrwP3gznwhtqGzVYu5whp1ey9S8H
         F+OyE3GlUHjuIyVcxU2vrIaB96x9rtRSv6B46XKs2+HnnXAp3oXMUqCjI+B0l48m/yZv
         COsA==
X-Forwarded-Encrypted: i=1; AJvYcCUYG7aVH8Ib30im9Nc3XSKf/wSbsZ1XdAAdb148c+mlQ/QG/vpVsNzTyRn31Ph9mD05QKDpQvZuKM5ieCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONh2S/CVapUC7gLcNDbLx9DDCHXaXsIPWhOVKvScGNjnODfH8
	O5WTC7RpOEpfxIc0CsmHEHw0wEnxL08WZQ3a98Lpx5sHyQXtE5KMWnAmuTWvg9s=
X-Google-Smtp-Source: AGHT+IGSUyWSIkrQHPaIEg5b3XpczZ+FNNwzNt7fLl6oCke2oHX26DGoxX3XhtU9zxbn5ENhD80UTw==
X-Received: by 2002:a05:6512:12d1:b0:536:5827:8778 with SMTP id 2adb3069b0e04-5367ff3382bmr11105969e87.53.1726736205331;
        Thu, 19 Sep 2024 01:56:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a465esm1762422e87.198.2024.09.19.01.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 01:56:43 -0700 (PDT)
Date: Thu, 19 Sep 2024 11:56:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, 
	heikki.krogerus@linux.intel.com, badhri@google.com, kyletso@google.com, rdbabiera@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 2/2] usb: typec: tcpm: Add support for parsing time dt
 properties
Message-ID: <kjscycfgp7kxlrrdvfszzmhvxxql7y6gs6jpfcgebvtj5qwhxp@zayctjtma2cx>
References: <20240919075120.328469-1-amitsd@google.com>
 <20240919075120.328469-3-amitsd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919075120.328469-3-amitsd@google.com>

On Thu, Sep 19, 2024 at 12:51:14AM GMT, Amit Sunil Dhamne wrote:
> Add support for DT time properties to allow users to define platform
> specific timing deadlines of certain timers rather than using hardcoded
> ones. For values that have not been explicitly defined in DT using this
> property, default values will be set therefore, making this change
> backward compatible.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 81 ++++++++++++++++++++++++++++-------
>  1 file changed, 65 insertions(+), 16 deletions(-)

> @@ -7053,6 +7068,35 @@ static int tcpm_port_register_pd(struct tcpm_port *port)
>  	return ret;
>  }
>  
> +static int tcpm_fw_get_timings(struct tcpm_port *port, struct fwnode_handle *fwnode)
> +{
> +	int ret;
> +	u32 val;
> +
> +	if (!fwnode)
> +		return -EINVAL;

I think this check isn't really necessary here. Other than that:

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +
> +	ret = fwnode_property_read_u32(fwnode, "sink-wait-cap-time-ms", &val);
> +	if (!ret)
> +		port->timings.sink_wait_cap_time = val;
> +	else
> +		port->timings.sink_wait_cap_time = PD_T_SINK_WAIT_CAP;
> +
> +	ret = fwnode_property_read_u32(fwnode, "ps-source-off-time-ms", &val);
> +	if (!ret)
> +		port->timings.ps_src_off_time = val;
> +	else
> +		port->timings.ps_src_off_time = PD_T_PS_SOURCE_OFF;
> +
> +	ret = fwnode_property_read_u32(fwnode, "cc-debounce-time-ms", &val);
> +	if (!ret)
> +		port->timings.cc_debounce_time = val;
> +	else
> +		port->timings.cc_debounce_time = PD_T_CC_DEBOUNCE;
> +
> +	return 0;
> +}
> +
>  static int tcpm_fw_get_caps(struct tcpm_port *port, struct fwnode_handle *fwnode)
>  {
>  	struct fwnode_handle *capabilities, *child, *caps = NULL;
> @@ -7608,9 +7652,14 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
>  	init_completion(&port->pps_complete);
>  	tcpm_debugfs_init(port);
>  
> +	err = tcpm_fw_get_timings(port, tcpc->fwnode);
> +	if (err < 0)
> +		goto out_destroy_wq;
> +
>  	err = tcpm_fw_get_caps(port, tcpc->fwnode);
>  	if (err < 0)
>  		goto out_destroy_wq;
> +
>  	err = tcpm_fw_get_snk_vdos(port, tcpc->fwnode);
>  	if (err < 0)
>  		goto out_destroy_wq;
> -- 
> 2.46.0.792.g87dc391469-goog
> 

-- 
With best wishes
Dmitry

