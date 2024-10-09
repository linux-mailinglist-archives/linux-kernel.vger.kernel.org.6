Return-Path: <linux-kernel+bounces-357976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105B9978AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5B81F20610
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C365188587;
	Wed,  9 Oct 2024 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZvkI5mu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92E38DD6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728514029; cv=none; b=pHWyhaGfLNuM7lBm+/T3kQ+mu6HS76L/gCnknfRPcUExZ/NjtzDKS1rqHlsaKIpheXKoT05t0iLtahDqkh3E6h2VA7hxYgATEDBc0rPGzFijEr+q8j9QZCHvzJh+/zU5am6tPrLfz9K0M4ElhDmas8wNEise5Deq77GRVywZ75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728514029; c=relaxed/simple;
	bh=zezz4miSiEcAUWwCNxLP4M8HbD5Q3oG1LiX06x3IoAM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RRhHHJzDQosDNwsdlZJqth/8GISnoxmOoRMX8OO/LmjDczzl89i5ydbee+qC0i7J26hL8BNIehWcRgqZYcHG8yMi9u6Pvc34K4v9iVQ+vrg5BFE90M0/N4/WrYKWV4SiuZkYA+Ozz6UQXS/vkmqcUFFMQO9Z6IlvvMDzBkfvM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZvkI5mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12752C4CEC3;
	Wed,  9 Oct 2024 22:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728514029;
	bh=zezz4miSiEcAUWwCNxLP4M8HbD5Q3oG1LiX06x3IoAM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=sZvkI5muk6awGGVdIHrLvoDRdzZ21X2AHklId6MA8LcOAk40rNThbq+RWFi+ZZAan
	 fyQmQD/z8xufkSYMulX16TXR81GuzFMTjAfIkcnHsPF1mH3b0z8CpSkyp/Ww4KG5bM
	 vdScIWAbluxij52vhCH9E+O+N338aMMd3s3A8Yk9SBNajU6GgHzMdQvm2/9YBomupa
	 yZoKu9bqw4pzvIs5pYDrzRMkRHrUiwA0a2cA6ht2isdML/EA+iJFFxjBy37zSvlT43
	 f5xAt5S6ETrJC+IFpVSBVEbWPcHAnZ1IOtAV4iDBpPCowxdmojpJo0YJQIqfmMLpCo
	 V+Ec4rCGtOfsg==
Date: Wed, 9 Oct 2024 15:46:59 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Jan Beulich <jbeulich@suse.com>
cc: Jiqian Chen <Jiqian.Chen@amd.com>, xen-devel@lists.xenproject.org, 
    linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Marek Marczykowski <marmarek@invisiblethingslab.com>
Subject: Re: [PATCH] xen: Remove config dependency in XEN_PRIVCMD
 definition
In-Reply-To: <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
Message-ID: <alpine.DEB.2.22.394.2410091539260.471028@ubuntu-linux-20-04-desktop>
References: <20241009062014.407310-1-Jiqian.Chen@amd.com> <73174eb0-380d-4f95-a2c3-097b86fac8db@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Oct 2024, Jan Beulich wrote:
> On 09.10.2024 08:20, Jiqian Chen wrote:
> > Commit 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
> > adds a weak reverse dependency to the config XEN_PRIVCMD definition, its
> > purpose is to pass the combination of compilation that CONFIG_XEN_PRIVCMD=y
> > and CONFIG_XEN_PCIDEV_BACKEND=m, because in that combination, xen-pciback
> > is compiled as a module but xen-privcmd is built-in, so xen-privcmd can't
> > find the implementation of pcistub_get_gsi_from_sbdf.
> > 
> > But that dependency causes xen-privcmd can't be loaded on domU, because
> > dependent xen-pciback is always not be loaded successfully on domU.
> > 
> > To solve above problem and cover original commit's requirement, just remove
> > that dependency, because the code "IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND)"
> > of original commit is enough to meet the requirement.
> > 
> > Fixes: 2fae6bb7be32 ("xen/privcmd: Add new syscall to get gsi from dev")
> > Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> 
> This lacks a Reported-by:.
> 
> > --- a/drivers/xen/Kconfig
> > +++ b/drivers/xen/Kconfig
> > @@ -261,7 +261,6 @@ config XEN_SCSI_BACKEND
> >  config XEN_PRIVCMD
> >  	tristate "Xen hypercall passthrough driver"
> >  	depends on XEN
> > -	imply XEN_PCIDEV_BACKEND
> >  	default m
> >  	help
> >  	  The hypercall passthrough driver allows privileged user programs to
> 
> The report wasn't about a build problem, but a runtime one. Removing the
> dependency here doesn't change anything in the dependency of xen-privcmd
> on xen-pciback, as the use of pcistub_get_gsi_from_sbdf() continues to
> exist.
>
> Consider the case of XEN_PCIDEV_BACKEND=m and XEN_PRIVCMD=m, which
> I guess is what Marek is using in his config. Both drivers are available
> in such a configuration, yet loading of xen-privcmd then requires to
> load xen-pciback first. And that latter load attempt will fail in a DomU.
> The two drivers simply may not have any dependency in either direction.

The idea is that there should be no hard dependency on
pcistub_get_gsi_from_sbdf(). If it is available, the service will be
used, otherwise an error will be reported.

The problem is that IS_REACHABLE is a compile-time check. What we need
is a runtime check instead. Maybe symbol_get or try_module_get ?



