Return-Path: <linux-kernel+bounces-183463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CA98C995B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487441C21240
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E781B949;
	Mon, 20 May 2024 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEXDjBz5"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9531C698
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190425; cv=none; b=HlYUwJ/qFAO8U+KEp+R0hNh3m6wBUNKhf4Jo5T44DZ717gOfCmVydPUqV5kaDolhYFZAVIWImCciENZheDsa6qnHuGnik+nFnpaN2yWJ86OZ4hPuJScQL5WZTlfXrWqrtxVkU6g6YbTJ1Lw82cJibZ/POmHBKhiRAfDqQlRTLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190425; c=relaxed/simple;
	bh=WeixK4Kgn0MvKplzBTKjFtE2DZaxPq1ICJ/opiDshY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj+MUT1XyxOfQ0ubm2QptZDBrtTBUaU1rl6ZWssBVS0pOd2ohTm3P+TTbbgU4Rt3BLD5zgR8TQSi28hBO3BKHFjyXpNLeFcOAJOSjNswXcUUCW8fZFsglEKvSrIqKrAK/4ZSlKudpeugrnJQs9usMlWALkbfUmsw/1KlZiyTD50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEXDjBz5; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9d0671dfaso1238495b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716190422; x=1716795222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTHkzAvMu+l8UyjO4kbcmDDhuFxHapp+W1C8XEMNXN4=;
        b=tEXDjBz5X6HIDXH/APEZKYUsx9z8++QOoTgXg1mStvoc9Ktlj2ZHefg99GLYWaPiDe
         sUrOgi/t0cfGfOBQwkS9kfRz8VcEyi5gJj6sWrqQ6W80b/a/LtlrteLrPWHv+4AAOgsk
         m05rMOipT9nBQIMp+1aPwqS5Ieb2w3qbZAfFiRS/mXaUJYEw7f3Kpq7otnGNao/r+T3v
         Eq1psNVOp9Flx8MQcBJ03nQkJjS5WcC6dSv1PqI45UGBYosD6vofoUzbnqZe0gOGG6Ls
         7GwkHGCyNuBK+KyKQqTHZKwNh2hjCqBG9NuB3WfYYfEBCPnPsyA0axjpu7lo4aHPQI1G
         G+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716190422; x=1716795222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTHkzAvMu+l8UyjO4kbcmDDhuFxHapp+W1C8XEMNXN4=;
        b=R1ZUpwaKoZrcORd1gFSCtI51wHafrXMSESRmcRSwqC95WcaJX/pxsvjkvK9zjHXvJb
         a+OMNbYEiO8pPlhMO7DxvyIj0g1c+xsuqfejax+/0BmHp3V6Ozsd/ORgvjrX2gim73vn
         pv0eNl6ekux1Xe2lJJo3h0oJExeGS2Dzr0w8X+vxrdIEtmVirIKaqkYfRi01VBhJkJHt
         bzl4L57SqqNW0g9TOd41MbOsOkvUmEYmSJmFFSrA3tJa+Zi/kVYGa8qagCh0YLuo4BqM
         6IWzspHcMXR7nSLvy5ZaSsDyad9/d//1Iq4+xBAm80tyjZlBBdPb8FN6qfoEmD89G49k
         xWwg==
X-Forwarded-Encrypted: i=1; AJvYcCWNDp6c9GE9Aic+L927tpGme0nO63cKDLBbii+lh237tPE4xVdJk556vNd+ZYvDLqJYhcVroC4cn3GdhltGoLt9kChF3ZEaYzPFDsBD
X-Gm-Message-State: AOJu0Yx6p19ikv2hjBGbA+aj1nMMjUDxpNAEMKyyzJwwPb0WAESOXVwp
	kfOv3ipGwJDdCidq+s2rgA68lKqHC51WetTJGiv+oJXy+mWduvgzvX7rbD7uez4=
X-Google-Smtp-Source: AGHT+IG7YMk/8WZfU70jkrguYTPefZ2BNfU/qrbtxJO+K7HFLFtKIi73g49AXVItMr7hLaQS5M2OgA==
X-Received: by 2002:a05:6870:40c8:b0:23d:49b4:6718 with SMTP id 586e51a60fabf-24172bc060emr33527554fac.32.1716190421955;
        Mon, 20 May 2024 00:33:41 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af52b4sm19106876b3a.174.2024.05.20.00.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:33:41 -0700 (PDT)
Date: Mon, 20 May 2024 13:03:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: sun50i: fix memory leak in
 dt_has_supported_hw()
Message-ID: <20240520073339.rf6laivnglmww3bf@vireshk-i7>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
 <20240503-sun50i-cpufreq-nvmem-cleanup-v1-1-0a2352cac46b@gmail.com>
 <20240510174937.0a710104@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510174937.0a710104@donnerap.manchester.arm.com>

On 10-05-24, 17:49, Andre Przywara wrote:
> On Fri, 03 May 2024 19:52:32 +0200
> Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:
> > diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > index 0b882765cd66..ef83e4bf2639 100644
> > --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > @@ -131,7 +131,7 @@ static const struct of_device_id cpu_opp_match_list[] = {
> >  static bool dt_has_supported_hw(void)
> >  {
> >  	bool has_opp_supported_hw = false;
> > -	struct device_node *np, *opp;
> > +	struct device_node *np;

Why is the opp pointer removed ?

> >  	struct device *cpu_dev;
> >  
> >  	cpu_dev = get_cpu_device(0);
> > @@ -142,7 +142,7 @@ static bool dt_has_supported_hw(void)
> >  	if (!np)
> >  		return false;
> >  
> > -	for_each_child_of_node(np, opp) {
> > +	for_each_child_of_node_scoped(np, opp) {
> >  		if (of_find_property(opp, "opp-supported-hw", NULL)) {
> >  			has_opp_supported_hw = true;
> >  			break;
> > 

-- 
viresh

