Return-Path: <linux-kernel+bounces-313250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FA196A265
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1206EB222AF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAE5193424;
	Tue,  3 Sep 2024 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OLcWo0jN"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93E193062
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377022; cv=none; b=AfawmaxY8fgDtOI7jme3Z2RCPyFCzE1XBuWWaGtYo0Xifgsfzek71/f5pZUqyCj+XrL7EyZZ0KFj52QkEquaqV20b1AR9OQudPTM6gwX23c2E2ACTEL38kMerrDZc8PoynMBy54QcM/wYM3/ADXbwDXNkXqL5wmdhNu5pqQ929A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377022; c=relaxed/simple;
	bh=LSXBQzuMvwQnEFqlcLPM6IyMjtxotrMkO5SoP7cZ5pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rB8NbRJYG4xGKnE9ntwQvLEuStamagd4n7dXvdfdoHhWnyxk37UQ8NCRFPry6g0V/9NkmPaOI1QmuinVs4qY4cBFz4mNTt3BuG1Cmjwgg+jNXv5FfpTv3s7dvhedqCNzBNNGwoz+yTWCJjI5OjLd186C5f64O5sImgKX6/mBs5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OLcWo0jN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374bb08d011so2234893f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 08:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725377017; x=1725981817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L1G9f/MXCSpO6qwfznQfsfWrRfp80ZqUfxGMTFXBu5Y=;
        b=OLcWo0jNNBIYBJuibym20HbtOT1+/ndElAb9aoCafUSqVS6AfRDZKNf8jni/t7E1kP
         QdrIniRuoCQE2adk9YmdA+i/6RvTaB5emzce7FsNI1oIYcAcBnV6kNvSKagSh2RKZG0/
         HpxAGMa1iP9lZQsiH/XpBePgY7LanRqJ8+a1zk1EdnIpBEvZfeyZNwRexhi1MtsztCJL
         9OvQZObpffhe8uusfN1OJjoUdNaiIlwzpuVY7NQcvnUsch7h1VWZyjYzMeEtjQ1ooie6
         Z5ePDUlX7cdALfJ9H6XUprHGWexwAjFEK63/ihPf7LzMF8h6IXFPKMktXZVxj3C2B13J
         gStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725377017; x=1725981817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1G9f/MXCSpO6qwfznQfsfWrRfp80ZqUfxGMTFXBu5Y=;
        b=jQvz8XGc2KPbj73knvCy6AG/emSsjg2luCYMfCJH/TLe/6ZBSYIZyoD/hDYcgHcgAD
         5u9tvGP/fMtd4fZcI9pODxSZFgB0tBuYg6lZkuYNgleeerk/3mfXZ//3d/ik4/gq//2U
         mK8UfWPcK+EWUq36ZCP8bVsbe/qRJAIfjI2WvY28XLrJ3gMiHP0xQAjRdotZvOHUssGp
         9Gld/ayEC32sJrQA7CH1om7j7tYauxWJ4FQDbRTfdMB5xw++5QobvCZbGObuoO/972rF
         8BgPBH3JWQxPUdrEJLQX9//9uvRmZMdUikPGo9GsMdP/Oz8LbA76HNHxVrNpsuqxehla
         s2tw==
X-Forwarded-Encrypted: i=1; AJvYcCVZF8Q66+h8T4isgR0kzGgQutGNloVeB6EypyitQAp5TymejOMv3TL0YFJR273hdKiXt+Iw6WGqMjoeTC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3+8OmNl0eo/ida5DZMMNsQ7Z+9Yl9Ue70tSPYo1Ss2oceGzU8
	KfYI9OQ3UZYfMqBHqcG2KfOtPUzM4z8PpTzP1tMpLSexlLd7sGrRBrS7MwBYX+s=
X-Google-Smtp-Source: AGHT+IFjLT74hWyeCcIPiDRsTGYQMqo03yurJboIMV+vyqM4AWpK0oyBWljpHjUmIS2Q4aG2dcZX5g==
X-Received: by 2002:adf:fe48:0:b0:374:ba3d:67bf with SMTP id ffacd0b85a97d-374c9478609mr4619376f8f.58.1725377017343;
        Tue, 03 Sep 2024 08:23:37 -0700 (PDT)
Received: from blmsp ([2001:4091:a247:83d8:caa7:e645:3612:56b6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374baae211bsm10616060f8f.66.2024.09.03.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:23:36 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:23:35 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Vibhore Vardhan <vibhore@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 4/4] firmware: ti_sci: add CPU latency constraint
 management
Message-ID: <d7eufnszflhujjyx2opw52qsi2tmr4euivxhpttoxhsgzg4f6v@jch7fy4ca4ao>
References: <20240829201606.1407773-1-msp@baylibre.com>
 <20240829201606.1407773-5-msp@baylibre.com>
 <20240903005422.GA4638@thelio-3990X>
 <20240903124540.73cdhsf755lyfisa@tartness>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903124540.73cdhsf755lyfisa@tartness>

Hi,

On Tue, Sep 03, 2024 at 07:45:40AM GMT, Nishanth Menon wrote:
> On 17:54-20240902, Nathan Chancellor wrote:
> [...]
> 
> > > @@ -3669,7 +3671,27 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
> > >  static int __maybe_unused ti_sci_suspend(struct device *dev)
> > >  {
> > >  	struct ti_sci_info *info = dev_get_drvdata(dev);
> > > -	int ret;
> > > +	struct device *cpu_dev, *cpu_dev_max = NULL;
> > > +	s32 val, cpu_lat = 0;
> > > +	int i, ret;
> > > +
> > > +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
> > > +		for_each_possible_cpu(i) {
> > > +			cpu_dev = get_cpu_device(i);
> > > +			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
> > 
> > This change is now in -next as commit 458d22d2e064 ("firmware: ti_sci:
> > add CPU latency constraint management"), where it breaks the build
> > when this driver is built as a module because dev_pm_qos_read_value() is
> > not exported to modules:
> > 
> >   ERROR: modpost: "dev_pm_qos_read_value" [drivers/firmware/ti_sci.ko] undefined!
> > 
> > Obviously exporting it would fix the build but sometimes that is
> > controversial, hence just the report.
> 
> Thank you for the report. I will drop the series from my queue for now.
> That should give us some time to sort things out properly for the next
> window.

Thanks as well for reporting. I looked into this issue and it looks like
many of the dev_pm_qos_* functions are already exported.
Documentation/power/pm_qos_interface.rst also already lists the function
for kernel-internal use along with many others. So I think adding the
export is the right way and I prepared a patch for that.

Also from what I saw and tested, I was only able to reproduce this issue
with ARCH_KEYSTONE when the TI_SCI_PROTOCOL is selected as module.
multi_v7_defconfig and keystone_defconfig both select it as built-in as
well as ARCH_K3. For all other architectures, TI_SCI_PROTOCOL can not be
selected as it depends on TI_MESSAGE_MANAGER which depends on KEYSTONE
or K3.

Best
Markus

