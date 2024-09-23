Return-Path: <linux-kernel+bounces-334164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F8697D343
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 11:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7621F25A1A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17109137772;
	Fri, 20 Sep 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvJwaBWs"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576D273FE
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822959; cv=none; b=EwniR89qsP0Os15ULEZcAVvppCLEvv6VySxiBYIKmcs871bU5+R/ya5n1PSLWla7eXK2XI32iFYY/1hx0jy7u5eFQA6B9n8C+wJEA1voASEFD4Z5YfiJNnHmPIUUPWeyyce7H480YpuKvuvcq9mqKR/8TLzYgE/gmBK3PTLlq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822959; c=relaxed/simple;
	bh=Ljn8CrHEK/NDHp9A3UgFJMlX1fUsytD7RTU3OXbKOrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBQDpH4cMuzNlfPbVF9VK91sUgnb5qpiosQe3WDSh/XPITz4P56rp/v1RJHHugich7HkKNAysn2aB0zI999bG3V4tanlRvtBSMpu1KMuRYcatvWCXoPpu/njZr8EO4oxZ1X5FM6VSXkp+qACK+C8ek5a7xvblIYyUYgBNh7nBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvJwaBWs; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso16325515e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726822956; x=1727427756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9xHqn1CcNxUXmlVAV1u3xBKfqop9hQ91uqyD6F5KKo=;
        b=PvJwaBWs3oMXpNplfqOSoJaK6dQlb33up4qBa4oSjLYp8Oa+fP3jj00H/LKcpryDkw
         ztMM0JuCIjytEn7CrQX+dgbTDmVaEvZKPq7QU1AAPUGiw6Rv9UBB9Xfj37TrwR7AtBjY
         XdkXdCcIQumo66GcILWnVSU9A4AeJylSyUfGwC7eMYJVeSprH20kISO/CTJEpt8ja/Jm
         CjRLU/MSO+x6zG5RwJ+++CZ6fgTliWVjo1M+xHeGYEQfvR15AqmP1a97YLp8j7lgZJKQ
         plDuZgC9JJAiw4tK4aN9+5JSG/pcYq9TeHV68JXEqFtDpYzkQKcf9VwmYaxPvjxMURvS
         lj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822956; x=1727427756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9xHqn1CcNxUXmlVAV1u3xBKfqop9hQ91uqyD6F5KKo=;
        b=Q3cIIahOGmvMJue3JB80DoymIuPfx/6N5K5EIu3MzPxFtuUp1h5ty2JdraqcN+iWWw
         JhrTz4pGXmFxUkXPcxlnTguGa6X6aupjt9Fv+vgpvgR+VH1SkyoREYkCJPkwCUCBLBV7
         TLLxKL64baBY45TYedL4o51WnRvQtDTCWNGo7ZQsMJCwnGAXdDGK9X5pu9+1HwF/GzLl
         HDSKf8/NTNIUD4w8WK38y3jrh/zEpYZXb+IHwsgccHhqcml8jhlh4cp9F/2ddcqiO+ul
         +ePt1EhSKyeo7cLuJX+tVhzcVXDPF1k7kTbRnbk/N8ZW6SBcop1xzU4vImo/YWYvf33r
         5s4A==
X-Forwarded-Encrypted: i=1; AJvYcCXAMtJxMtmH5hr+SmidzAS3ETYe0YswSC/FbiackebqZfRhNv/hZ5kJ7kGC4ZL9iA5NnzxTl6sepEnwWxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVFc0uukE1zzsYxpdtRuJLoEndnmMrFlE9rmZFOPqMIK5fQp6
	mrtSL+eyPoeAQTOugmEiK7kd/WKjWeNKAyWAyZZuzt3McAxP6+2gFiMwqEMoIhU=
X-Google-Smtp-Source: AGHT+IGHKj8uLxsAhi/9AzjCpBT1u6Z/NQ3ZmyZIku0CR0sVmP89gc0izgxnNCELNWwoOtATq5c2oQ==
X-Received: by 2002:a05:600c:1e1d:b0:42c:e0da:f13e with SMTP id 5b1f17b1804b1-42e7c16ed2bmr11681675e9.18.1726822955919;
        Fri, 20 Sep 2024 02:02:35 -0700 (PDT)
Received: from linaro.org ([82.77.84.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afeb1c2sm16595405e9.36.2024.09.20.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:02:35 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:02:25 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: qcom: edp: Add runtime PM support
Message-ID: <Zu06IXym0it9UPpa@linaro.org>
References: <20240907-phy-qcom-edp-enable-runtime-pm-v1-1-8b9ee4210e1e@linaro.org>
 <ZuqmB3Cn7mGfA2PU@hovoldconsulting.com>
 <ZurRLf8S1j6s8GPz@linaro.org>
 <Zu007YUYie7bEQvj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu007YUYie7bEQvj@hovoldconsulting.com>

On 24-09-20 10:40:13, Johan Hovold wrote:
> On Wed, Sep 18, 2024 at 04:10:05PM +0300, Abel Vesa wrote:
> > On 24-09-18 12:05:59, Johan Hovold wrote:
> > > On Sat, Sep 07, 2024 at 06:25:21PM +0300, Abel Vesa wrote:
> > > > Enable runtime PM support by adding proper ops which will handle the
>  
> > > > clocks and regulators. These resources will now be handled on power_on and
> > > > power_off instead of init and exit PHY ops.
> > > 
> > > No, this is simply a false claim and indicates that you haven't reviewed
> > > how PHY runtime PM works. Core will increment the usage count on init()
> > > and decrement it on exit().
> > 
> > Yeah, I guess the better argument here would be that the PHY needs
> > regulators and clocks enabled
> 
> No, that's already handled today so is clearly not a valid argument.

I think we're saying the same thing here. I was trying to say that,
as it is currently done and it's correct, the init() needs those
resources enabled.

> 
> > Anyway, ignore this version as it was already NACKed by Dmitry.
> 
> No, my feedback is still valid, and you're bound to repeat the same
> mistakes over and over again unless you try to understand what I've been
> saying here.

Duly noted. My reply wasn't trying to dismiss your feedback.

Thanks for your feedback.

> 
> > > > Also enable these resources on
> > > > probe in order to balance out the disabling that is happening right after.
> > > > Prevent runtime PM from being ON by default as well.
> > > 
> > > And here you just regressed all current systems that do not have udev
> > > rules to enable runtime PM, and which will now be stuck with these
> > > resources always-on (e.g. during DPMS off and system suspend).
> > > 
> > > In fact, you are even regressing systems that would enable runtime PM,
> > > as the runtime suspend callback would not currently be called when you
> > > enter system suspend so the regulators and clocks will be left on.
> > > 
> > > This clearly hasn't been tested and analysed properly.
> 
> Johan

