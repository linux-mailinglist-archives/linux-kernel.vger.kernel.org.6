Return-Path: <linux-kernel+bounces-280556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649AB94CC1C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF235B2495B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4859D18DF6C;
	Fri,  9 Aug 2024 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeBXzDhu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE1218CBFA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191855; cv=none; b=l13qiSEGnvZfVnan55NuDGqi9kTa8xIevQpWp1hsZKmH35K9+5LTbUZcXd9vfowsOpue4DjJsWz/D5fx1tfOf4rsitwOZuTKRYQhuMh4iPxJwQgUVhYV4tkCWngw/9ES5OoefDGeqWpmZ1BBwxTcL8g5S8GuWCf+lPTn6G5etis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191855; c=relaxed/simple;
	bh=eCPYO7k8einZmGW1UrDuHki8qQ6ec/+2EnDneiq2HZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8epNsPKOsS2Na+zOtM4tpcd8g4VzF5YiAk6KFr5m/kDGk7A9fY3BZz6jRzzdtJrmOQtVou2MTUJPecGjs+GXHKQgxvK8z8YAKgwzcPwfFEN8tuiK06Y1t0tkodb12EgEl2u8zCYl6uOMZlCC29GByTdRg4TnA8q7rS3LCEXd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeBXzDhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9C8C32782;
	Fri,  9 Aug 2024 08:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723191855;
	bh=eCPYO7k8einZmGW1UrDuHki8qQ6ec/+2EnDneiq2HZ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DeBXzDhuqZUaRs00yRhoABN21W0kmvnS+rp31D95QzOB8JtfX8ORd1Ewl0ecdBCaj
	 P6nzJD7ELL21XOecdzwwQ8j3Q+AkZDmSoLERd/NTWTMAuuX9yQUvUNVvgEgowKmhsD
	 Bm0883My3nWU1pa2Tupw/vwAGwvh/D1eJ96oPUolqpMxY3JqaENs0hj431J2t1MgMS
	 fy5L3c9y1R4rDye21rUYqrfeh0ZTvgachzwetEhskgNxTLx1Zezda10e8PG+RiT+yn
	 KlSmiPrJA+W6PFvxGun2mpKc8YTh12EJZi75NLAzQEzAYY3cWZRU1huPCoDgh4Xix9
	 1+K58H5Wj0UuQ==
Date: Fri, 9 Aug 2024 10:24:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Cleber Rosa <crosa@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] scripts/ghes_inject: add a script to generate
 GHES error inject
Message-ID: <20240809102409.136837ec@foz.lan>
In-Reply-To: <CAFn=p-ZM8cgKvUx+5v7YU6TaPZySJL1QnHqjmN5rQpF=D_V=8Q@mail.gmail.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<0654a89fe24f4343016b9cecc0752594ad1cd49f.1722634602.git.mchehab+huawei@kernel.org>
	<CAFn=p-Y27zap1P5G3NibdZS26iGwCqh8U0vgW0Vw31f53+oU1w@mail.gmail.com>
	<20240809004137.01f97da2@foz.lan>
	<CAFn=p-ZM8cgKvUx+5v7YU6TaPZySJL1QnHqjmN5rQpF=D_V=8Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 8 Aug 2024 19:33:32 -0400
John Snow <jsnow@redhat.com> escreveu:

> > > Then here you'd use qmp.cmd (raises exception on QMPError) or qmp.cmd_raw
> > > or qmp.cmd_obj (returns the QMP response as the return value even if it  
> > was  
> > > an error.)  
> >
> > Good to know, I'll try and see what fits best.
> >  
> 
> I might *suggest* you try to use the exception-raising interface and catch
> exceptions to interrogate expected errors as it aligns better with the
> "idiomatic python API" - I have no plans to support an external API that
> *returns* error objects except via the exception class. This approach will
> be easier to port when I drop the legacy interface in the future, see below.
> 
> But, that said, whichever is easiest. We use all three interfaces in many
> places in the QEMU tree. I have no grounds to require you to use a specific
> one ;)

While a python-style exception handling is cool, I ended opting to use 
cmd_obj(), as the script needs to catch the end of /machine/unattached/device[]
array, and using cmd_obj() made the conversion easier.

One of the things I missed at the documentation is a description of the
possible exceptions that cmd() could raise.

It is probably worth documenting it and placing them on a QMP-specific
error class, but a change like that would probably be incompatible with
the existing applications. Probably something to be considered on your
TODO list to move this from legacy ;-)

Anyway, I already folded the changes at the branch I'll be using as basis
for the next submission (be careful to use it, as I'm always rebasing it):

	https://gitlab.com/mchehab_kernel/qemu/-/commit/62feb8f6037ab762a9848eb601a041fbbbe2a77a#b665bcbc1e5ae3a488f1c0f20f8c29ae640bfa63_0_17


Thanks,
Mauro

