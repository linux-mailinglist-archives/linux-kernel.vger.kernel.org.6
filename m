Return-Path: <linux-kernel+bounces-237440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D86E9237E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D392B282399
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A99614F10E;
	Tue,  2 Jul 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXD0xa1r"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAA14E2E8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909792; cv=none; b=aEasInKymWkihnmmUzAD4j1bpHMGJSeV/3QoqbGNBfsPwAZZcHo82ukBHfbf2oRbd4Afs7nEI4yF6P0A08PLUmH4ehEQAM0VLEj9dcn/IpTOtfJYL2zN9hOY216BD1yN2KVx0VnrTcGtM3d6TIP8lamXYm2HLK9WT0E/T55sYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909792; c=relaxed/simple;
	bh=SJHlZBOSA+3+lnPuviGQpdlU9rY3FwzL6Gu9MvuAZco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuAe9Rq4SJAWBVbpkWnl+IqVIJzkNYizRjDVHL7Qp1IgOPxsnPzWZtSGVDzk378lVGy3sxeOCSjZB/B5RE+lAUnRvwZL6s20koHKHjKX0vKnUYOH3Wi1rbZnz3ex3D65fUC/TJ2HGlV3vl98yRWZBeBnc+GAj2xbYn+YuT3tfeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PXD0xa1r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f9cd92b146so25438465ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719909790; x=1720514590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vQ8zplKEvkyqs0AhE9LwFp0KDkZC+KF7mrGUufJk6Ng=;
        b=PXD0xa1rPRriMku4erUF1QY2TBZ4Ug44pJOPVVj6Nhcl5bh/1LW1m9lDSaKCyKqKP1
         Bnsub1BlfqJSddD1x1AZ6flScuiXvDwhpF2yElbbc63Qbs9iUAmjxK3z+fWxpGCyDFJa
         mayt8fyCKIB/OMIy4cP3T227SvHHKm0JQkWV/4DEWjoQvq0r6URwXJDraD76Y5FRnXcM
         laJvpvVdUOoxhJJ5ZvqWzgMKhZ+F9ZIXFKMssCnUuYnCa5m5W9ZxrkV8cAKkk0UDnmUC
         z3WEE9d6FEwa3n+jHxHe7KSCl9o10zjGTk9aW+nCZ2ZMvr/H/rN1YPpEH+ACrxL0Dc9A
         4D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909790; x=1720514590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ8zplKEvkyqs0AhE9LwFp0KDkZC+KF7mrGUufJk6Ng=;
        b=L4mWGWDTG3aYwaFMDdIZvgVZ58nIoyn8LeCOJmiKJQUHjHNqWd+fwpgHMqI2ZAVtSR
         VCL1BYcj0jgk4cOe1Ez0fJpvSVd4xkhYEHNkxUh65dcIfIydCFFgrf1EvrZHr0fed8sE
         GZOwRGkMlBUyNdy9Lc8uDqfmTA1BYx86CS6gVef3HHyWh0OaoS04BTBjYm9j1DGLbEXA
         7r+D7fEQpCgTOO2GibV/A+Bt7kbZTYSUCk71YiyPeBy8qBfe37pYQr7waovwFw8BKMAi
         bTy2ReMC8kdsFo1w2htAtCtnmDw+IjqxLrG9ng56EMdczcFkwDPFihe++bYiPZ1npb3U
         o5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBXYpIoC90YzOcTNymFdn2ONONK6scF7jrAIjNfFLM7XOL0WMewOMo2k7UGpxdmDPbGScqHKpUkmvAkc1saBgsc8niY+fTu4TJEdJG
X-Gm-Message-State: AOJu0YyLb1CryM4QqJ3FwXYesw9G0NwEVjOE4CTn2X5hdAgztLAC9suv
	tsRBxT2LyJFph3WOZqBzcfgbZuMp5pMMdme/IK77yYfYXCv0TMOqRBmz3rSHIG9ZBpUzfiiogM+
	g
X-Google-Smtp-Source: AGHT+IEmIv2vGdHXLm2ZvbXST6X7Il1ZBsG0xUxf3z1Ipxyow451EWanRYVGWaC0ZCem1Pikt0Jlng==
X-Received: by 2002:a17:902:d488:b0:1fa:a68:47a8 with SMTP id d9443c01a7336-1fadbca042dmr72974405ad.28.1719909789985;
        Tue, 02 Jul 2024 01:43:09 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156957fsm78805885ad.228.2024.07.02.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:43:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:13:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>

On 02-07-24, 10:26, AngeloGioacchino Del Regno wrote:
> Il 02/07/24 07:57, Viresh Kumar ha scritto:
> > On 28-06-24, 15:48, Nícolas F. R. A. Prado wrote:
> > > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > > @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
> > >   	int cpu, ret;
> > >   	data = dev_get_platdata(&pdev->dev);
> > > -	if (!data) {
> > > -		dev_err(&pdev->dev,
> > > -			"failed to get mtk cpufreq platform data\n");
> > > -		return -ENODEV;
> > > -	}
> > > +	if (!data)
> > > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > 
> > What's the point of calling dev_err_probe() when we know for sure that
> > the error isn't EPROBE_DEFER ?
> > 
> 
> Logging consistency, that's all; the alternative would be to rewrite the dev_err()
> messages to be consistent with what dev_err_probe() says, so that'd be
> dev_err("error %pe: (message)");

That would be better I guess. There is no point adding inefficient
code.

> > > +				     "failed to get mtk cpufreq platform data\n");
> > >   	for_each_possible_cpu(cpu) {
> > >   		info = mtk_cpu_dvfs_info_lookup(cpu);
> > > @@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
> > >   		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> > >   		if (!info) {
> > >   			ret = -ENOMEM;
> > > +			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");
> > 
> 
> By the way, forgot to point that out in my former review: to make it shorter,
> instead of "ret = -ENOMEM; dev_err_probe()" you can write it as...
> 
> ret = dev_err_probe(&pdev->dev, -ENOMEM, ".... message");

`ret` will be  be used I guess with the `goto` statement to return
error and so the change was like this.

-- 
viresh

