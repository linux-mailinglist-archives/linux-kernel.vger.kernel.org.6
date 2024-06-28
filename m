Return-Path: <linux-kernel+bounces-234457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27191C6DF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52035B237C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E60770E1;
	Fri, 28 Jun 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DCEmaBr0"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405074CB37
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604416; cv=none; b=alTylEBooMeYU+rx3OnFz8omfc4gKfuzarxuEN6wIfPRaEeXETbuxv2/+WXxVqNlqMiekebGrNcgtYLa2OwyxKHG8rxUWtx9UxIFDifu8bQFa0bwe2X/cpMcCXghDPzVNtaIFNYyulQ4N+k9AQqRSP/x55xq7u0hthE5x3h1VFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604416; c=relaxed/simple;
	bh=/CKACYWLUIqjV38aqh2m2zOYGnLhG7wNTvhY4HFHgYY=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f07WuwSLtKsrPnBtMmkeMPEcWeLo0g6iQaLB7ZID5zxYxTv9/MK0yXldg540IYEh5cPhBug+DPGL6BsPECdF7DDEQTo6YboOPnfeYC3j9i+XtSDZf3L/YZpKwl5dS/pVQwcoJeN6SvViB1bZfBlFSWY28DKOsugSL1JdSFjiwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DCEmaBr0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7065a2f4573so814477b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719604414; x=1720209214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/jH00phhVWAYucey8EridRtG9VCd7OvweCgJMd7i18=;
        b=DCEmaBr0LLBA3eALClfeInde0qF5lERaAhmaAWgQDZizmcNqqiiA3vQaU46YnJTZwr
         2//1vXNUTvkhOYs6RmawHwruIuwYmz1V1SJgkaf0Ty7UAV2cU41xIVzeDSod8WF89As1
         hleEh+iV0qWjRMUSMZxsz8cnYWmU+Da56zgtB8kuC7hlVm0F+2VU3ZDpN8W2Cv76dc1i
         uF4tqUUBiNr7BlHyed/RY/ivCx7inNyIVzFV5BHOZj+y+C3Bxf+S+L686ZEn0/XpSEmk
         YwEanWE61l50lmfqU9FJYgKJJKHvfSR1+NTuMcWZRhg5TFmcs/1lg/kyTv2fOXPww2VX
         YSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719604414; x=1720209214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/jH00phhVWAYucey8EridRtG9VCd7OvweCgJMd7i18=;
        b=psATVtP17F7+5gzSZKvmO2VRyfWWYvpN8FV0NWMUJaeNZ/kUggdlppWrUwIDo9elkx
         4des1TMRix0bP/CyBCfGgx3mmjH86zEPk2ShEYRG9L7dey7gelL6PxMbj9aVzYjdCUGf
         AXRCv+SQ8ieDnGsvkFXiZAO3ptzWdyrpBq0heI6jgKeGBf1y/tRUCldnC7pgKrCBb5E3
         bajTDMvCX6XOFhRqNiWFephQKRH8dseQ9z2jPk4X+Yi89NiVp73QOARJwrq2jFjYGzIE
         74GW/C1RzI/D9Ye5l1jjXT40q9eyFdAldb25jwSOCRPMfs9mW8Lp/fttAQtBUZPqxHZT
         r8bg==
X-Forwarded-Encrypted: i=1; AJvYcCV/vV0ap6Cnp856GcuL9BoecLzryWmRdDxT8DVYmD2qpF5VoyMbX9VFkx6SpUxGRcKEHTut7+6+rCeEgmNeGEzMPwQp0bxP4JTdA1WN
X-Gm-Message-State: AOJu0YxR9jdTF2k9r0Lr4HherlJHEehIL/yr+NbOfHh7uGB4i4ohCEaW
	dwdPreoqVD/do1qUZfiOi4ttg8SoTm2xOyZJthOfvHgSC5RCsLgHFUEY31rVSEc=
X-Google-Smtp-Source: AGHT+IGGVpZm0QgAO8OiY/RswohPQdDDzJOJzZYPS1dn9RuOsBpSkWpHg7go+YNF2koi9gk2JWcBsw==
X-Received: by 2002:aa7:9d85:0:b0:706:5bf1:586f with SMTP id d2e1a72fcca58-70674363825mr17052236b3a.0.1719604414459;
        Fri, 28 Jun 2024 12:53:34 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e53e:a53d:f473:181e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53b47sm2022516b3a.37.2024.06.28.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 12:53:34 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:53:30 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Hari Nagalla <hnagalla@ti.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] remoteproc: k3-r5: Fix IPC-only mode detection
Message-ID: <Zn8UumUllbGS4/p9@p14s>
References: <20240621150058.319524-1-richard.genoud@bootlin.com>
 <20240621150058.319524-2-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621150058.319524-2-richard.genoud@bootlin.com>

Good day,

On Fri, Jun 21, 2024 at 05:00:55PM +0200, Richard Genoud wrote:
> ret variable was used to test reset status, get from
> reset_control_status() call. But this variable was overwritten by
> ti_sci_proc_get_status() a few lines bellow.
> And as ti_sci_proc_get_status() returns 0 or a negative value (in this
> latter case, followed by a return), the expression !ret was always true,
> 
> Clearly, this was not what was intended:
> In the comment above it's said that "requires both local and module
> resets to be deasserted"; if reset_control_status() returns 0 it means
> that the reset line is deasserted.
> So, it's pretty clear that the return value of reset_control_status()
> was intended to be used instead of ti_sci_proc_get_status() return
> value.
> 
> This could lead in an incorrect IPC-only mode detection if reset line is
> asserted (so reset_control_status() return > 0) and c_state != 0 and
> halted == 0.
> In this case, the old code would have detected an IPC-only mode instead
> of a mismatched mode.
> 

Your assessment seems to be correct.  That said I'd like to have an RB or a TB
from someone in the TI delegation - guys please have a look.

Thanks,
Mathieu

> Fixes: 1168af40b1ad ("remoteproc: k3-r5: Add support for IPC-only mode for all R5Fs")
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 50e486bcfa10..39a47540c590 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -1144,6 +1144,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  	u32 atcm_enable, btcm_enable, loczrama;
>  	struct k3_r5_core *core0;
>  	enum cluster_mode mode = cluster->mode;
> +	int reset_ctrl_status;
>  	int ret;
>  
>  	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
> @@ -1160,11 +1161,11 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  			 r_state, c_state);
>  	}
>  
> -	ret = reset_control_status(core->reset);
> -	if (ret < 0) {
> +	reset_ctrl_status = reset_control_status(core->reset);
> +	if (reset_ctrl_status < 0) {
>  		dev_err(cdev, "failed to get initial local reset status, ret = %d\n",
> -			ret);
> -		return ret;
> +			reset_ctrl_status);
> +		return reset_ctrl_status;
>  	}
>  
>  	/*
> @@ -1199,7 +1200,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  	 * irrelevant if module reset is asserted (POR value has local reset
>  	 * deasserted), and is deemed as remoteproc mode
>  	 */
> -	if (c_state && !ret && !halted) {
> +	if (c_state && !reset_ctrl_status && !halted) {
>  		dev_info(cdev, "configured R5F for IPC-only mode\n");
>  		kproc->rproc->state = RPROC_DETACHED;
>  		ret = 1;
> @@ -1217,7 +1218,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
>  		ret = 0;
>  	} else {
>  		dev_err(cdev, "mismatched mode: local_reset = %s, module_reset = %s, core_state = %s\n",
> -			!ret ? "deasserted" : "asserted",
> +			!reset_ctrl_status ? "deasserted" : "asserted",
>  			c_state ? "deasserted" : "asserted",
>  			halted ? "halted" : "unhalted");
>  		ret = -EINVAL;

