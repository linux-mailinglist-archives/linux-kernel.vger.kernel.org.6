Return-Path: <linux-kernel+bounces-389452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F277D9B6D44
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA20F1F21996
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109441D14FB;
	Wed, 30 Oct 2024 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmdFdQm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6984C1CFEB0;
	Wed, 30 Oct 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730318857; cv=none; b=W6u6CjrxF90cre/VxyZNiI+CpsGzNQrA7xFpv8F1WyuC5l9Xbo+vNluag26T3yl5qEBn4dQl9uX0GniuFiTyaRhnzY42N8g9p8mzRrMnWrKX5Yts38vXrYKS04rHC848Crtp8ybv7RRWSOd517kLK1OQRs+z3IByIqbgAz/1VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730318857; c=relaxed/simple;
	bh=Ra8qcZsuP6DbklAARKQpxRKsoemXiiadlrDQHi+5vBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HdGwdN0JYPAqEik0eXVZHFnfHnYcxXWLLWCCPPAEhR/1wQmiAK4n3ShC8c1gZgbYvrklLLLq6t93h5neQaI034M8Nd7giQnD1wfh3KT66BD5Rg2bvFDtMH3+S4oqcUp0Juw6k8KGkfHhY/NqWL381fuJCNLSAn+iL4kvhLn1GwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmdFdQm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19C0C4CECE;
	Wed, 30 Oct 2024 20:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730318857;
	bh=Ra8qcZsuP6DbklAARKQpxRKsoemXiiadlrDQHi+5vBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmdFdQm15exyPGQth9twhzedcnpPhuYkrt7qjQQwfTK1UJAo1sbQRXbj2oDAR64jd
	 i1WBDD8xJYLTtcwBnGf3cSf/qWXpqB1kQbRyme2aZHr8BjynU4pPTa7NA9yUn5QNZa
	 XVcPopappddmffrOPP4mxyWKk8G66L90cFkagKSogkVS+dUYU3+fvzZHEyTYvfnRvs
	 nyGvO+jsCXXwAXnMiGKliN9Cd14s2Wu2aS5BRFVmP4MxesXXxUFBsf3DWPNeRKIXCx
	 Y61HM6qTICfapSBQqo64RvEV1B5alICOuZm+WW0oYCJNesVc4G0sbBgOnQKjJPWyQ2
	 V4rcq9SNNOTcw==
Received: by pali.im (Postfix)
	id 44BC39D2; Wed, 30 Oct 2024 21:07:29 +0100 (CET)
Date: Wed, 30 Oct 2024 21:07:29 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, w_armin@gmx.de,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: Re: [PATCH 1/2] dell-smbios-base: Extends support to Alienware
 products
Message-ID: <20241030200729.7klmmwvpnwxq326z@pali>
References: <20241030181244.3272-2-kuurtb@gmail.com>
 <20241030182613.xn3tl2khzuhft4sr@pali>
 <7kx45jrxlzo6vhaknkxlrpxfs6w4ijwee3qdb7mavz2rtxqetk@vpknhvcpfgwl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7kx45jrxlzo6vhaknkxlrpxfs6w4ijwee3qdb7mavz2rtxqetk@vpknhvcpfgwl>
User-Agent: NeoMutt/20180716

On Wednesday 30 October 2024 17:01:11 Kurt Borja wrote:
> On Wed, Oct 30, 2024 at 07:26:13PM +0100, Pali Rohár wrote:
> > On Wednesday 30 October 2024 15:12:45 Kurt Borja wrote:
> > > Fixes the following error:
> > > 
> > > dell_smbios: Unable to run on non-Dell system
> > > 
> > > Which is triggered after dell-wmi driver fails to initialize on
> > > Alienware systems, as it depends on dell-smbios.
> > > 
> > > This effectively adds dell-wmi and dell-smbios support to Alienware
> > > products.
> > > 
> > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > ---
> > >  drivers/platform/x86/dell/dell-smbios-base.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> > > index 73e41eb69..01c72b91a 100644
> > > --- a/drivers/platform/x86/dell/dell-smbios-base.c
> > > +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> > > @@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
> > >  	int ret, wmi, smm;
> > >  
> > >  	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> > > +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
> > 
> > Are we sure that all devices with "Alienware" OEM string supports this SMBIOS API?
> 
> No, I am not sure.
> 
> However, I believe this driver is intended for general Dell SMBIOS 
> implementations and automatically checks for support. I know this doesn't
> necessarily extend to Alienware, so I hope some of the Dell maintainers
> could shine some light on us.
> 
> I tested this on an Alienware x15 R1 and only some SMBIOS features
> work, but no errors and dell-wmi-base works perfectly.

This is good to know. You should write into commit message on which
platform you have tested this change. In case there would be some issues
in future, it will help to for example whitelist working machines.

I asked for this because for example dell hwmon driver has explicit list
of working and non-working devices. And on some dell some machines just
calling hwmon API cause issues...

So it is not just theoretical problem that allowing all devices from
Dell with some generic OEM string can cause issues.

> > 
> > >  	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> > >  		pr_err("Unable to run on non-Dell system\n");
> > >  		return -ENODEV;
> > > -- 
> > > 2.47.0
> > > 

