Return-Path: <linux-kernel+bounces-332669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3EC97BCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D262B21EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42B1CD3F;
	Wed, 18 Sep 2024 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXMUM1eh"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7847C24B28
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726665011; cv=none; b=l5faE82QzqebKH/7f8dNSShPiFYR5N6Qw66i+2/RrdzYkRShQq8SdtwgOYoid2OFxvDqTYpbMX2FoHd1TYyzc/dAEij27rs8zMU3WndXZpKMCGqPMJqbqh6WIW3D72fa9lorAU61WAab9dIkRvyRll21SDiHEnf5KJ+Tr/aA6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726665011; c=relaxed/simple;
	bh=qSS9j04dMz97s1/G7sXN4oo94BzskpOxNZlCp1HcBGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOeSI40kfBOzf12udOs8EUF7gp2WVbH0OknWOtnawh9v6nkb7fnERKd4y0xDb/kC4jlp4rHOZ7QHaCIgkiFEm9Ac+XQ+4IvJAbDA1vX2AmveKGHvyHCecQ3MQLTa9dBShN7uxraZGrnSAlN/MdOTWxHerj8MOao4GPhswXj15OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bXMUM1eh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso1594626a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726665008; x=1727269808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVRgT66/mOuXoJrqQ8wh1eZWHMJn1TVCedz1ceMT+pM=;
        b=bXMUM1ehfNXoefr+2aBc3G/dLfGptZpgUDvbcIEq1jnu4aLwvo8HeYO/DcAJje3MHV
         3cATBVkLuErbn3GPp4oR47+s373xqpNee+GkfeoGq2F9glXutMQwLWwspFXhSlHaAaGT
         wIow2jvihLG4EexhxvQfKTsBACPh7OLa4M5NiaT1WKgHWmD0SsrA/Dko0FIFnuRfVqIQ
         7kh1A62kShBJBqAqOlKno1UEQJCTlSQDAPBiCNTGChsKQJ6tZdNW2c8Ip25Dp05Yibvy
         RuPGOnWItTXjn32KistG+ktBb8sZrnI6WnRnN/Uj7BnyUIys7PVjhajKoP27slpp1rdp
         VPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726665008; x=1727269808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVRgT66/mOuXoJrqQ8wh1eZWHMJn1TVCedz1ceMT+pM=;
        b=gpyISFGxYhmRhURfZ0bBiO0+6WbNwlofprQneN+T090Gqb62LsgRlfgsHBoZkRW/XM
         tk9GSVkw1lY+RB4TBVrwNVBQObiuYvj6NRRwSGRG7Quqm4fUmLaXEkpnonMghPnfujAC
         XUUu3vf2pvYXomISplRkqMi8LuRvWO1Sj5sX+BRjuIpCV1cvltnMftHhtJkoIcfGoDPI
         iK/KeA6S8yJhyQMGeNhsM03uGlTXd4hAIDEODAF5srIM8shQ3rcj5Ie78pDAxJ2jwamK
         ykbV1faucGUwaom/RxotLUoe3TjbIvQVrYbDGVpR/eZo5VjBscyOCBXlT44hJsW7caIt
         Y9gw==
X-Forwarded-Encrypted: i=1; AJvYcCUGvBZmkZ/PVJrpfWEH2lkSs5ItuELC2A3bc8BUTg2m0y61mAEC8iPAVdlIoRyXR1R1VTC61WSAhDFjXjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy212iad8wbOCxqI/5XA6YdJTcyJQbP/OVdF76hp1E0WwdNpwKO
	+APqCovP16wc4HlXQrVwtPf4CwE3EJcx3XRbzBt+WFI0/lxC4FwGQrV3AfJOkSA=
X-Google-Smtp-Source: AGHT+IGHtxlIXrPw47xVhdH8uLboKPn/Kp7bXo6oA0xYfYIupxuqexOncbN9AZZ0BmhjMlNITwnFjw==
X-Received: by 2002:a17:907:1b05:b0:a7a:afe8:1013 with SMTP id a640c23a62f3a-a902a3d188dmr2413879466b.1.1726665007741;
        Wed, 18 Sep 2024 06:10:07 -0700 (PDT)
Received: from linaro.org ([62.231.96.65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9060f39a8fsm588762066b.0.2024.09.18.06.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 06:10:07 -0700 (PDT)
Date: Wed, 18 Sep 2024 16:10:05 +0300
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
Message-ID: <ZurRLf8S1j6s8GPz@linaro.org>
References: <20240907-phy-qcom-edp-enable-runtime-pm-v1-1-8b9ee4210e1e@linaro.org>
 <ZuqmB3Cn7mGfA2PU@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuqmB3Cn7mGfA2PU@hovoldconsulting.com>

On 24-09-18 12:05:59, Johan Hovold wrote:
> On Sat, Sep 07, 2024 at 06:25:21PM +0300, Abel Vesa wrote:
> > Enable runtime PM support by adding proper ops which will handle the
> 
> Avoid words like 'proper' here (what are non-proper runtime PM ops?).

Sure.

> 
> > clocks and regulators. These resources will now be handled on power_on and
> > power_off instead of init and exit PHY ops.
> 
> No, this is simply a false claim and indicates that you haven't reviewed
> how PHY runtime PM works. Core will increment the usage count on init()
> and decrement it on exit().

Yeah, I guess the better argument here would be that the PHY needs
regulators and clocks enabled. Anyway, ignore this version as it
was already NACKed by Dmitry.

> 
> > Also enable these resources on
> > probe in order to balance out the disabling that is happening right after.
> > Prevent runtime PM from being ON by default as well.
> 
> And here you just regressed all current systems that do not have udev
> rules to enable runtime PM, and which will now be stuck with these
> resources always-on (e.g. during DPMS off and system suspend).
> 
> In fact, you are even regressing systems that would enable runtime PM,
> as the runtime suspend callback would not currently be called when you
> enter system suspend so the regulators and clocks will be left on.
> 
> This clearly hasn't been tested and analysed properly.
> 
> > +static int __maybe_unused qcom_edp_runtime_suspend(struct device *dev)
> > +{
> > +	struct qcom_edp *edp = dev_get_drvdata(dev);
> > +
> > +	dev_err(dev, "Suspending DP phy\n");
> 
> You forgot to drop your development printks (same below).
> 
> Johan

