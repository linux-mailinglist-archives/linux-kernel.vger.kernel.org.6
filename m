Return-Path: <linux-kernel+bounces-430968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4B9E37A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96492285A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8731B21B5;
	Wed,  4 Dec 2024 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wt7UKkMw"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FA1B2196
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308428; cv=none; b=mwVOUpeCwVG2jdhlU1ju3GHdT9C+H4I3GZhqu07AgYWoc85xH/5qaOl5t3AHZ/jjknsBB5NK/icVmgwAmjExHoxbHaUp0XSTRk7RXXeB0kyMajBJS4nNZqbbhzuM2J9uiT+WR26W3/VRzjnsav0vjFzrb5ozL+Lzl0zfxlQamY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308428; c=relaxed/simple;
	bh=iHpOqOUVZXcd3yJhrDWa+7PLHhBxMiNTxmS5kKZe+/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW41TiQj4R2lRXp6ZkLP4UPPnLyhsDasRmJggDaNBtoKOjd4+6ZiiSyUyd50TtkSOFdLJFxYlwHYlrZ4v4MYLU3UCW11HqeLuf+mw4wY5uPxNoZQ+fyfN1lIzx6OoqAnFxsz5+fqexv7P1NynhG+ihX4S2TVplYvKquZ4v3w03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wt7UKkMw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffdbc0c103so94414161fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733308425; x=1733913225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c7QuloSgj0r15TwR5fMQCFbF2vjnGQ7hXPKInCZLKyg=;
        b=wt7UKkMw05bnqn5swRaCwJw4JgecqbX9Uge5DjbPNzS8F14DWWLLEvIpTdfe3pYnrn
         WKoIfR9vkpWQYflT0Y5uBMon1/zwx5f4tWtoI1aAQe36x6naVZ+hv4YwWvgV/nF+ewGW
         MNCPf5DMf10qb9zQbmIUwg5h+T3FFo5GevmBiFq/A4z49bUZJ80JhjNziAOhzxdXYP/i
         YbuuplCtItZEEbS3MiWFxyVIOeaO8EVrCZ/ekVMWWHlL0O/yJriQoFTKI8g1a4Xy/WRS
         6guqI27Cuu2d5C7mjIRLgKZ8F4sEjZgDv+dVzf3A1eO/hwuUVHdaD3eftQnPewf9Akek
         HCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308425; x=1733913225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7QuloSgj0r15TwR5fMQCFbF2vjnGQ7hXPKInCZLKyg=;
        b=q1hSEsgTrFRLJZKIwopQZQgcovmGvTnFqWDDzQHuhszQ9UWne09NY0dmpWt2ye0jdy
         /7iOugpLke0scfDYuqUO0l4FnpE2LuTd4ZDM/eNKFB+1XTfYkPYEgbu/ZIXX3A9cBDZi
         A3iu+SAXPUW2zJQbeeEN2D3Wmaw7UToFMQYOs5ZCKkaN4pmlKgRpOYuSCvGoZpq7I9+r
         1QFEbowHZRdoL+tuo9gQdZdTvNvFCBfL5NpoqPuVnpoCnjEmd3noPJbOFlOILD0wvbcN
         Dn/PFVLGvcFX33caeiPq97IYssKypEkle3xOMAkEaC1THLo4FgVlud79phifmO9jXhQ9
         IbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLiog+JbFcpPfPTJhKjosfFcnWkVVJFYVv/AdnPNP+mc9HQKTOmhL4aEM1Mb2CxNAIdbqVuerlsHnWlY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjDebfdbgTx8IYgB28s8fMMXW83Duazz9fkR9EG5KySJBQkjH
	rmf9w+1DTjn6eu28v8QH3zQFnLFckMi/LuBBBPC4ngLlCpq67JLNVEqQAD/BHLE=
X-Gm-Gg: ASbGncv+1HtrLTYZS5wFSdTOYgpidq7PtqC0US7yxRELaR3dORI4whquXfyyeKAccjm
	yrdUx7n5u6MOVXhZWROouE22XPCFX15jVWqRP6QWO6fYh5NuU2AYVhS88ehgS12QriMaAeJ5F6T
	LbUQcm6h0nzRd4Zc/B9VeqAc2O5TCbwZnjeYFkhZk5VR2aXbDnp5I73vd3oUdKxzmcDHS31nNuW
	Fv9h6Q3/eyNCujGOz8rbnyWSxUebbRqDx9gTafQOas+p9S3n2nk0HKFsvfbtYXOCmQVebVS9jm8
	yOxh/daw4x1uCHGuNuP/X3mqceNnog==
X-Google-Smtp-Source: AGHT+IHEKTFXGocF66IHpQf3lweb12Yys+xaiLn/9Oq325/K+Ss10BFbBCPkL38hsPYrE2+4j+byxw==
X-Received: by 2002:a2e:3507:0:b0:300:17a3:7ad9 with SMTP id 38308e7fff4ca-30017a37d6emr11123981fa.12.1733308424883;
        Wed, 04 Dec 2024 02:33:44 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30018a4d0a4sm1455701fa.71.2024.12.04.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:33:43 -0800 (PST)
Date: Wed, 4 Dec 2024 12:33:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH 3/3] drm/msm/dp: add a debugfs node for using tpg
Message-ID: <ibjx5lcpw2yrogp4qygcterjcbchdrqtjtdv77iozlrlicieqr@sxgtt4n42t3z>
References: <20241202-tpg-v1-0-0fd6b518b914@quicinc.com>
 <20241202-tpg-v1-3-0fd6b518b914@quicinc.com>
 <uv2phgi72mmw5c462ijsqlqedeiv4gahrwi26i2luqkhgwmfxc@ycj7jrujdj6w>
 <2193c915-cdda-416d-8e24-209e808c6d10@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2193c915-cdda-416d-8e24-209e808c6d10@quicinc.com>

On Tue, Dec 03, 2024 at 07:57:25PM -0800, Abhinav Kumar wrote:
> 
> 
> On 12/3/2024 3:38 PM, Dmitry Baryshkov wrote:
> > On Mon, Dec 02, 2024 at 12:42:00PM -0800, Abhinav Kumar wrote:
> > > DP test pattern generator is a very useful tool to debug issues
> > > where monitor is showing incorrect output as it helps to isolate
> > > whether the issue is due to rest of DPU pipeline or in the DP
> > > controller itself. Expose a debugfs to use the TPG configuration
> > > to help debug DP issues.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_debug.c | 61 +++++++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
> > >   2 files changed, 63 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
> > > index 22fd946ee201..843fe77268f8 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> > > @@ -197,6 +197,65 @@ static const struct file_operations test_active_fops = {
> > >   	.write = msm_dp_test_active_write
> > >   };
> > > +static ssize_t msm_dp_tpg_write(struct file *file, const char __user *ubuf,
> > > +				size_t len, loff_t *offp)
> > > +{
> > > +	const struct msm_dp_debug_private *debug;
> > > +	char *input_buffer;
> > > +	int val;
> > > +	int status = 0;
> > > +	struct msm_dp_panel *dp_panel;
> > > +
> > > +	debug = ((struct seq_file *)file->private_data)->private;
> > > +	dp_panel = debug->panel;
> > > +
> > > +	input_buffer = memdup_user_nul(ubuf, len);
> > > +	if (IS_ERR(input_buffer))
> > > +		return PTR_ERR(input_buffer);
> > > +
> > > +	status = kstrtoint(input_buffer, 10, &val);
> > > +	if (status < 0) {
> > > +		kfree(input_buffer);
> > > +		return status;
> > > +	}
> > > +
> > > +	msm_dp_panel_tpg_config(dp_panel, val);
> > > +
> > > +	dp_panel->tpg_enabled = val;
> > 
> > Does this need any kind of locking? The driver performs some actions,
> > then we write the global state. What if the user in parallel writes
> > different values to the file?
> > 
> 
> Sure, I can add a lock to struct msm_dp_debug_private and use it to protect
> the tpg_write and tpg_reads.

Yes, I think it's worth doing that.

> 
> > > +
> > > +	kfree(input_buffer);
> > > +
> > > +	*offp += len;
> > > +	return len;
> > > +}
> > > +
> > > +static int msm_dp_tpg_show(struct seq_file *f, void *data)
> > > +{
> > > +	struct msm_dp_debug_private *debug = f->private;
> > > +	struct msm_dp_panel *dp_panel = debug->panel;
> > > +
> > > +	if (dp_panel->tpg_enabled)
> > > +		seq_puts(f, "1");
> > > +	else
> > > +		seq_puts(f, "0");
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int msm_dp_tpg_open(struct inode *inode, struct file *file)
> > > +{
> > > +	return single_open(file, msm_dp_tpg_show, inode->i_private);
> > > +}
> > > +
> > > +static const struct file_operations msm_dp_tpg_fops = {
> > > +	.owner = THIS_MODULE,
> > > +	.open = msm_dp_tpg_open,
> > > +	.read = seq_read,
> > > +	.llseek = seq_lseek,
> > > +	.release = single_release,
> > > +	.write = msm_dp_tpg_write
> > > +};
> > > +
> > >   int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
> > >   		  struct msm_dp_link *link,
> > >   		  struct drm_connector *connector,
> > > @@ -231,6 +290,8 @@ int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
> > >   		debugfs_create_file("dp_test_type", 0444,
> > >   				    root,
> > >   				    debug, &msm_dp_test_type_fops);
> > > +
> > > +		debugfs_create_file("dp_tpg", 0444, root, debug, &msm_dp_tpg_fops);
> > 
> > I'd say, skip the dp_ part of the name, everything in that dir is
> > DP-related.
> > 
> 
> Ack.

-- 
With best wishes
Dmitry

