Return-Path: <linux-kernel+bounces-183614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A678C9B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F30B21CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2D50286;
	Mon, 20 May 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1PwuJKq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402ADA2D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201322; cv=none; b=a5XlWBn4bMLfSHSZ3zijBY/T8w16kSne2OPD7QTrN8tWGnCFaqDoIHqcK8ii0LeHRM/RtvuaLiknv5o7lHQOZn4VWqsbEt5t8dXM5haDHC5tIIbFU6OvEArL4Ji5weD/RKxZRrri032zSuhK3JhtScQ+qnXOTNvQixeh2hnkipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201322; c=relaxed/simple;
	bh=VrajtHotaC0Y2FBEW8M7f4Wyu2v52OxPlBDKc0SsWFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzcGZt7myj/TjYae6BaEmMGghHnGBjjItod4L7M+K82E1MGGzHeB7dUjSQtoLQW8ZWg/VY4qkwM2DhQOz6+TvTagQPHGn+WKFPJ5LQdiV2BsCP2o7hWNr8fxBXeAnXrb/UK8Z0j2a4hcA+wFtalh2KYaRFuQGelietXmrF9SKDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1PwuJKq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so3661589e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716201318; x=1716806118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M77u76U61V3fpnwyE5H4HgvMa1z+7+KqGOKbDArh6qQ=;
        b=p1PwuJKqIPRjL8z3J7mK9o454HcmVTSPOnBTCmxUUnAQyVzmqfG0hTisA9uPuGla3S
         tmLTSgsvyHRmwzrXaoxhICeHqDuKWefqEQN3pim4uXCDicFg28sXko22IN3t8FGZW2lo
         8jKMQ92Ii+vvMrKLitR64iUrxvGhpdx6hzpmlBvqL6Z9nZeRKKeRW6T7SYmE5tYStadM
         1cwXpBhxasNUh9IA4JEQKPJWcYVakxw4n9dR+wWJJKJBP1vZepMgPO/UUMxnDhUW+G6Z
         mBdvesADYBur2zYA0v4DAkQ3A5rrkeGgojuSWJxT3pvidQKzClvMoZrbh0ZD4eI/T2m0
         7cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716201318; x=1716806118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M77u76U61V3fpnwyE5H4HgvMa1z+7+KqGOKbDArh6qQ=;
        b=h82BinJeN7brMfwy1ZPlb1vA0g+p8hgEcK10FjsaCB1WVStkxnCaDFyaUQVH7UpxiT
         bp9SvXZ8kA+q6MdKN3mSAwNd4sPvKKV5slhoW40GetchJfRy2WJzQ3k7EAo80fv2sRyh
         N4YnWxLeOyVNEYMYyTgwyISMXGYCm3u/hCbggZzTSrt9NUCsoDw9QcHcQS+ndbYcigUV
         PLI/i4vMZ0AkeTkwh+BS+HZDmVtZrH/ujG9R9ck+OPcZ1KfYP8BLaB+AYXojyfkBm1Ud
         hHHpb3aalwxti7kWSF5j9sTQyulQzZReRDvwkP2xGFbBSUbn3eisLLaQeKRa11KhkqbW
         qnwA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jvUnGwOLisEzb1Cytv4mF+zDxFbvr67Kb15cNn695BquLhws4x/8WmU2G0p5rJBmuhjR7F2y9JF99rwn0B79A1l1Oc1yaUyziLeh
X-Gm-Message-State: AOJu0Yy+BRf0d1Ig6dtnc4S3TGZcw7k41BEZ8O7H+OMb4EyvGE3HlI7R
	M6TSNJadOP+96UwLP5eI3t5dz6W8ZQS4f/zs6ZA+1bALJzE2FK5O/tCOjj0FSJQ=
X-Google-Smtp-Source: AGHT+IG1dvoxsmukaeX1Kus3eIdC+OT63ZQWkr780bFS2L/nBs/Nzh0vDkDrMOtn4xkRBwm8TrAffQ==
X-Received: by 2002:a05:6512:68e:b0:516:c97d:96b4 with SMTP id 2adb3069b0e04-524079a8708mr2172995e87.2.1716201318383;
        Mon, 20 May 2024 03:35:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52434ae5899sm524387e87.119.2024.05.20.03.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 03:35:17 -0700 (PDT)
Date: Mon, 20 May 2024 13:35:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <la43b5ra7aziiv7dwt4o5zha3px7jarfmk45dwsf24qn6pgcre@pcmcsicjdrus>
References: <20240517232427.230709-1-linux@treblig.org>
 <6tfxkc3foarpfuo6viwmsm4e2ujxjmhpqsku37d4ov6ppufpjr@byrbjs7srqri>
 <ZkqAoG9ZGg0_dC-9@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkqAoG9ZGg0_dC-9@gallifrey>

On Sun, May 19, 2024 at 10:43:44PM +0000, Dr. David Alan Gilbert wrote:
> * Dmitry Baryshkov (dmitry.baryshkov@linaro.org) wrote:
> > On Sat, May 18, 2024 at 12:24:27AM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > 'bridge_init' is unused, I think following:
> > > commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> > > (which is where a git --follow finds it)
> > > Remove it.
> > 
> > Please rephrase the commit message following guidelines in
> > Documentation/process. Use Fixes tags if suitable.
> 
> I specifically don't want to use Fixes in these set because
> there's no need for someone to backport this to older
> kernels that use the original, and many backporters
> use 'Fixes' as an automated means to find stuff they should
> backport.
> 
> Other than that, is there something specific you think I've
> missed?

It's not about missing things. It's about a way it is written.
Consider something like:

The commit aaaaaaa ("drm/bridge: foo bar") has dropped all the users of
the struct bridge_init from the exynos_dp_core, while retainng unused
structure definition. Later on the driver was reworked and the
definition migrated to the analogix_dp driver. Remove unused struct
bridge_init definition.

> 
> (I'm also purposely being less certain here, because --follow
> is showing it in a ptn3460 and I don't quite follow
> why that changes it here).

The mentioned commit is a correct one. Historically exynos_dp_core had
been creating the ptn3460 bridge manually. Later on this was fixed in
the ptn3640 driver and the code was dropped from exynos_dp_core.

> 
> Dave
> 
> > 
> > > 
> > > Build tested.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > index df9370e0ff23..1e03f3525a92 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > @@ -36,11 +36,6 @@
> > >  
> > >  static const bool verify_fast_training;
> > >  
> > > -struct bridge_init {
> > > -	struct i2c_client *client;
> > > -	struct device_node *node;
> > > -};
> > > -
> > >  static int analogix_dp_init_dp(struct analogix_dp_device *dp)
> > >  {
> > >  	int ret;
> > > -- 
> > > 2.45.1
> > > 
> > 
> > -- 
> > With best wishes
> > Dmitry
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

-- 
With best wishes
Dmitry

