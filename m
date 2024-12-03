Return-Path: <linux-kernel+bounces-430366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385569E2FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E338BB28415
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ECF209F51;
	Tue,  3 Dec 2024 23:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDPxV6H8"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D7205AD6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269098; cv=none; b=jPU7H1RwTgjHiUG9abEsiKlt1+3oCywK6gc4BxuphlQPze26wkBFdoy3a0QIrnC9f+aXkPTrv1ggcWZw/qcJpIXb0bEhdQLslLPz33vaSFSlG7HZUZz82TUK1nFanZAIpgEfGGR6pJ9RVOBwBUYPw/vxNvdbL7aBRpUOF2W1VZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269098; c=relaxed/simple;
	bh=7HPRDhBmNX229it5gZJpFg3uexTNN2BzNHQC2yu+IS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBlgrQU0Os4IPjhOCqYGNedKtXNElJiPRvUw5ApP4OLqDdl+PQXcxGEzM0FuenKorjWqxXbD/by+eKGhoFYRys0bwwmC63XwxhUeRjrSFikQRzQAVnx67nmLROccEIqGsqbD7KtlwUjQ7B2ZAmIDdSJRXFoTYqmdBNfFlm7jeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oDPxV6H8; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e1c3dfbb0so362986e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 15:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733269094; x=1733873894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvIkRrq0tXitj5MQqLQ3oqy5bggdWAmTtXbggggiuHU=;
        b=oDPxV6H8xIYc2tK/rpEa/CmuCJ6dY56vdJx8foBvsyawW483k5QolaXacWIdFpXLGL
         C3dvpoNhGGywbcHYg0QJwOgSxlP9wVb1dvFDuMpTM9jRmrip7VgBjGMbOo+CbFpQR2Eo
         9XN5d+PQAxneala9O9k4My7ZA/HqMtrTio+kFBax78lQ+SYoS08XxSd1doQLf3he3av0
         HXbbWnhfem3WktBW7S/4OiWjLYwlLSMJiKmP96kaDi1s69HvcRcr6WTyKfUaV67JlkSY
         WqjXPAmlz/j1TaMVEvVxP4DqdPfex8NFJsl66h0/LGFt8WH96Srcx9jGStwAjiNRE7+Z
         8s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269094; x=1733873894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvIkRrq0tXitj5MQqLQ3oqy5bggdWAmTtXbggggiuHU=;
        b=adh2r48amDVJMC9jaHUykSGon9E9bpy0HvhmY8SVSaAwohqxcdUfOjLNp0RA3taGGu
         HDuVytyC9uk88QtWGdWxoN9q3k9jcRDGcNxX4XLlvGHlgiZ22dbrILeOtFSvFp3c8nD4
         SI62xWFC17xPJ/CDfUfhigCpBtIlfY0DPlWP1+rD7J6009f8NhljXUENbgq9Nz33oRZT
         Ca/zTqRZQy2EppLuFk6ngWBw+QcXnFIMo9eg4g+pgHx+K0fNboOIBsLyAyh7G9uVEN88
         swXwjloSHaiMAQcAQWknebmYIzn2gR3h3L/XjZmaS2tO26HaDQyitMKBcF+4la7aGauH
         /55A==
X-Forwarded-Encrypted: i=1; AJvYcCU0Tc5qZ00MhzkhbYjoAC2wM+Q7OntokGNUU2t6tpScBt8eVYAapddWnIKK8SewlCOtoLAtMx1g3s70pfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATjHdCtlCA4HtNwwK/i1tE+Ogb0NzqXpwi8sMAjvTotv/sMY6
	lB3xFE15zPn/cNk1uk361OSCWafGdxKyFfnomGer1Tac20e+TfSJlYuipqVmVQ4=
X-Gm-Gg: ASbGncu+BcE+FzpreYWOHGOopa02gXnkCsE8upSw5Q4yDqMeHMwoNd0GWYDShP7zhGd
	0KXINxDOFc1xEaGgbYcOlPQTM6Kg00idmpk4mz4ZU2AdHV3psxftbA/snjpvpKGvQ8QKO4jXkQE
	ZjsWQkXqnDEDt5fSKLYoWkDXY59bV4YIqlVtkfkCfpGLqhS20/TRnLRSMdtM7CPK7vLc5trp96q
	p89pLgoaaCnfpaQI9RQYNNOxKIpKTOjvvcJt9z2IgNBtsgjGc6mnn1gXoka5JjqWXJ2bXH6JXlX
	oxDyD6sMJctE4TQlu9KCQxCH+XKBtQ==
X-Google-Smtp-Source: AGHT+IFEAY3DxNqKHxw8mhGMitDTHIqwhcTfqELsGsjzfMmTb1zcKOW4rDkr5UYxAPj+4eEnCeVPww==
X-Received: by 2002:a05:6512:10c5:b0:53e:1c3d:d1ae with SMTP id 2adb3069b0e04-53e1c3dd2c2mr500865e87.29.1733269094445;
        Tue, 03 Dec 2024 15:38:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6496903sm1980271e87.210.2024.12.03.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:38:13 -0800 (PST)
Date: Wed, 4 Dec 2024 01:38:10 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH 3/3] drm/msm/dp: add a debugfs node for using tpg
Message-ID: <uv2phgi72mmw5c462ijsqlqedeiv4gahrwi26i2luqkhgwmfxc@ycj7jrujdj6w>
References: <20241202-tpg-v1-0-0fd6b518b914@quicinc.com>
 <20241202-tpg-v1-3-0fd6b518b914@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-tpg-v1-3-0fd6b518b914@quicinc.com>

On Mon, Dec 02, 2024 at 12:42:00PM -0800, Abhinav Kumar wrote:
> DP test pattern generator is a very useful tool to debug issues
> where monitor is showing incorrect output as it helps to isolate
> whether the issue is due to rest of DPU pipeline or in the DP
> controller itself. Expose a debugfs to use the TPG configuration
> to help debug DP issues.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c | 61 +++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
> index 22fd946ee201..843fe77268f8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> @@ -197,6 +197,65 @@ static const struct file_operations test_active_fops = {
>  	.write = msm_dp_test_active_write
>  };
>  
> +static ssize_t msm_dp_tpg_write(struct file *file, const char __user *ubuf,
> +				size_t len, loff_t *offp)
> +{
> +	const struct msm_dp_debug_private *debug;
> +	char *input_buffer;
> +	int val;
> +	int status = 0;
> +	struct msm_dp_panel *dp_panel;
> +
> +	debug = ((struct seq_file *)file->private_data)->private;
> +	dp_panel = debug->panel;
> +
> +	input_buffer = memdup_user_nul(ubuf, len);
> +	if (IS_ERR(input_buffer))
> +		return PTR_ERR(input_buffer);
> +
> +	status = kstrtoint(input_buffer, 10, &val);
> +	if (status < 0) {
> +		kfree(input_buffer);
> +		return status;
> +	}
> +
> +	msm_dp_panel_tpg_config(dp_panel, val);
> +
> +	dp_panel->tpg_enabled = val;

Does this need any kind of locking? The driver performs some actions,
then we write the global state. What if the user in parallel writes
different values to the file?

> +
> +	kfree(input_buffer);
> +
> +	*offp += len;
> +	return len;
> +}
> +
> +static int msm_dp_tpg_show(struct seq_file *f, void *data)
> +{
> +	struct msm_dp_debug_private *debug = f->private;
> +	struct msm_dp_panel *dp_panel = debug->panel;
> +
> +	if (dp_panel->tpg_enabled)
> +		seq_puts(f, "1");
> +	else
> +		seq_puts(f, "0");
> +
> +	return 0;
> +}
> +
> +static int msm_dp_tpg_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, msm_dp_tpg_show, inode->i_private);
> +}
> +
> +static const struct file_operations msm_dp_tpg_fops = {
> +	.owner = THIS_MODULE,
> +	.open = msm_dp_tpg_open,
> +	.read = seq_read,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +	.write = msm_dp_tpg_write
> +};
> +
>  int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
>  		  struct msm_dp_link *link,
>  		  struct drm_connector *connector,
> @@ -231,6 +290,8 @@ int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
>  		debugfs_create_file("dp_test_type", 0444,
>  				    root,
>  				    debug, &msm_dp_test_type_fops);
> +
> +		debugfs_create_file("dp_tpg", 0444, root, debug, &msm_dp_tpg_fops);

I'd say, skip the dp_ part of the name, everything in that dir is
DP-related.

>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index 0e944db3adf2..7910b11fd685 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -50,6 +50,8 @@ struct msm_dp_panel {
>  	u32 max_dp_link_rate;
>  
>  	u32 max_bw_code;
> +
> +	bool tpg_enabled;
>  };
>  
>  int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

