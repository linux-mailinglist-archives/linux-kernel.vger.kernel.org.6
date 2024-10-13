Return-Path: <linux-kernel+bounces-362844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13F99B9E4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BD01F21A03
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBE1145B22;
	Sun, 13 Oct 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="novNcfIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667E804
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831768; cv=none; b=gErwhs1X9cfBnjs1CaV7lvEH9uV4aiylcEcHqPSPNJ26+nDLcH6sm+jxa1Reo1wvJLOVG/6EvU4jliAg6an/2kTpMiAadnR/JtqGPpo22+JkakTXGmOFNBrhHVFUbq6O+uS8v40YeSLj66f8zdRMlHtkH+A7g/JeGKgFFMw8uxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831768; c=relaxed/simple;
	bh=0F6BolcVyWF36BCdfHv5P0AKF0/C4ojsVgwNXi9OIY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qisLlp/krf3iqqmKZFSqPD+O1NXGwaBu0+ym+Jp2Ev0WssNVkOFrRdNcS1gz1fuu+Wb/gF0xtpy91u5IerLQDoSlqJOaM8/cmVTW1+z3CE2L/mJo7h6gatVc31keQPABPqjzcxar/IxXCkannRLTKKfIsShiq00YWJnjjg5u8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=novNcfIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F5CC4CEC5;
	Sun, 13 Oct 2024 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728831767;
	bh=0F6BolcVyWF36BCdfHv5P0AKF0/C4ojsVgwNXi9OIY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=novNcfIvfnWLZ6+ok4CGmqK5rde93GPD6P8QJWqbYy9e40KQmOYUFReo/BBySrTHx
	 HTQI0bsOu2z/J/HK3aoi/bJ87gcHaKd8OlDOAE5lgAEassHKTkqGR5urYYlZCH/mzm
	 OM8O5r5JBIFRnYrMt0ouG4amMZnJ9oJpYwZDUnpw=
Date: Sun, 13 Oct 2024 17:02:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2] driver core: bus: Remove an impossible error handling
 path in bus_add_driver()
Message-ID: <2024101316-designing-renegade-6f00@gregkh>
References: <20240917-bus_add_driver_fix-v2-1-a94026443444@quicinc.com>
 <420b202e-e094-4e82-bf77-dd1c62119aa7@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420b202e-e094-4e82-bf77-dd1c62119aa7@icloud.com>

On Tue, Sep 17, 2024 at 02:53:32PM +0800, Zijun Hu wrote:
> On 2024/9/17 14:49, Zijun Hu wrote:
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> > 
> > For the following function call chain:
> > API driver_register() -> bus_add_driver() -> driver_attach()
> > 
> > There is an error handling path for driver_attach() returning non-zero
> > or failure in bus_add_driver(), remove it with below reasons:
> > 
> > - It is impossible for driver_attach() to have failure in bus_add_driver()
> >   For int driver_attach(const struct device_driver *drv), the only factor
> >   which makes it failed is that bus_to_subsys(@drv->bus) is NULL, but
> >   the factor has been excluded by bus_add_driver() before calling it.
> > 
> > - driver_attach() is irrelevant with driver_register(), so the former's
> >   result should not also have an impact on the later.
> > 
> > Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> > ---
> > Changes in v2:
> > - Remove the error handling path instead of WARN_ON() it.
> > - Correct title and commit message
> > - Link to v1: https://lore.kernel.org/r/20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com
> > ---
> >  drivers/base/bus.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index 657c93c38b0d..54ff92aece92 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -674,7 +674,8 @@ int bus_add_driver(struct device_driver *drv)
> >  	if (sp->drivers_autoprobe) {
> >  		error = driver_attach(drv);
> >  		if (error)
> > -			goto out_del_list;
> > +			pr_warn("%s: failed to attach driver '%s' to bus '%s'\n",
> > +				__func__, drv->name, sp->bus->name);
> 
> driver_attach() has __must_check attribute and this error may be
> inconsequential for driver_register(), so give pr_warn() here

Yes, but you  now ignore the error, so someone will come back and add
that error handling in.  I'd just leave it as-is.

thanks,

greg k-h

