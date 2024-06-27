Return-Path: <linux-kernel+bounces-232477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C291A959
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AF32815EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF534197A88;
	Thu, 27 Jun 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OnWYtuuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD28A197A65
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498945; cv=none; b=DkxB7Rt/b5z0Q6UHnsoDa2z0E0wRE+E6ogVcjQF455YH0yFWWh7F5nKLsWTDST0KXFBhcyz07HtBdox1pIknDDrCu79ibxtH3c/3qlnh5/OtRnbHJUDxHNoFeIcYdpxk5Qi7CLgx7ryga6oPTKKq2l43qI/sERytX2Hy00DynVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498945; c=relaxed/simple;
	bh=NQiBXQ9n1hDdkvx74U1VHfRUYjZb3SZE/fC7Kdw6bks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7tBJjWC4OW7s0t6t3BxHiA4EeBbMGhkAlqwOyQPYViepxu+XQmUWbynEZCcW+xMz1oxPkzyZ/c5PyXoa4j0O6vs80pe3KtTWblGf97v52xoxRSUo9o5k2DVMsVBZBZdLXMUREqQ/BS8OEaadvj4lVLwFVrp9Htc/E4FNBkyWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OnWYtuuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9070DC32786;
	Thu, 27 Jun 2024 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719498944;
	bh=NQiBXQ9n1hDdkvx74U1VHfRUYjZb3SZE/fC7Kdw6bks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnWYtuuN5AuLTHtiribpakK1MkUx0dRC1w8G+Op+DQNH2m4H7X1DMuGk7RJRzsiZo
	 eRImw1a9Trl3cqZTztsST2Tz7svKZWd9G04rm35aocyPAqoNKfba0r1+1mTpMF9mE9
	 u/2k1NJuNTX/3DGTs54fLaUWgE8hI4OGQryhg5nM=
Date: Thu, 27 Jun 2024 16:35:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devres: Simple code optimization
Message-ID: <2024062724-bunion-swept-23b9@gregkh>
References: <d029d754-aeb7-493a-8e48-6acaa53fee1e@quicinc.com>
 <1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024062750-hubcap-parish-7bda@gregkh>
 <179b5505-f64b-4c29-b2df-2eec9e276904@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179b5505-f64b-4c29-b2df-2eec9e276904@quicinc.com>

On Thu, Jun 27, 2024 at 10:29:43PM +0800, quic_zijuhu wrote:
> On 6/27/2024 9:54 PM, Greg KH wrote:
> > On Thu, Jun 27, 2024 at 09:47:16PM +0800, Zijun Hu wrote:
> >> Initialize an uninitialized struct member for devres_open_group()
> >> and simplify devm_percpu_match() implementation.
> > 
> > Huge hint, when you say "and" or "also" in a patch, it's a good idea to
> > split it up into different commits, right?
> > 
> you are right.
> i would like to split this change into two changes within a patchset
> even if this change is *very* simple.
> >>
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >> This change is intend to replace below one:
> >> https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/#t
> > 
> > Why?  SHouldn't this be v2 instead?
> > 
> this change has different title and maybe be identified as different
> patch, so i send it as v1.
> >>  drivers/base/devres.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> >> index 3df0025d12aa..5b1d498e83ab 100644
> >> --- a/drivers/base/devres.c
> >> +++ b/drivers/base/devres.c
> >> @@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
> >>  	grp->id = grp;
> >>  	if (id)
> >>  		grp->id = id;
> >> +	grp->color = 0;
> >>  
> >>  	spin_lock_irqsave(&dev->devres_lock, flags);
> >>  	add_dr(dev, &grp->node[0]);
> >> @@ -1172,9 +1173,9 @@ static void devm_percpu_release(struct device *dev, void *pdata)
> >>  
> >>  static int devm_percpu_match(struct device *dev, void *data, void *p)
> >>  {
> >> -	struct devres *devr = container_of(data, struct devres, data);
> >> +	void __percpu *ptr = *(void __percpu **)data;
> >>  
> >> -	return *(void **)devr->data == p;
> >> +	return ptr == (void __percpu *)p;
> > 
> > What exactly is being "optimized" here?
> > 
> 1) remove redundant container_of() and devr->data operations
>    pointer parameter @data already is address of devr->data.

But do we really know that ahead of time?  If so, how, just by virtue of
this being the first field?  If so, then no, keep the container_of.

> 2) compare with right data type
>     original type of @p is void __percpu * returned by
> __devm_alloc_percpu().

It's pointer math, no need for types, right?

> @data is storing a pointer type void __percpu * as shown by below
> statement within __devm_alloc_percpu().
> *(void __percpu **)p = pcpu;

Again, it's not very obvious so you better document the heck out of it
in your changelog text.

thanks,

greg k-h

