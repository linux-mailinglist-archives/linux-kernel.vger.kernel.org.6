Return-Path: <linux-kernel+bounces-571798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B42A6C25F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8035B480FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DCF22FDE7;
	Fri, 21 Mar 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UHqUobbR"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512571E5B83
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581744; cv=none; b=UKdbMA0XUXohkAvb9+Xnis5LxqLhqjSaQtPpC4PDSncqoZGRdb1AHSOhjVHPwC5C93kpCr6aWfRnB2d++S+1FkhsF8Aatv7EQUEOdLfiUh5W9MtB6SR6PQ1Cw6g8KixnJ5kc+ivs1JzXBnO49xUmV7J3alRhP+9r90rhf55iF7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581744; c=relaxed/simple;
	bh=vhRSD/sXVHlXEO82NM8Vc+1oXUYVgQcVeL2JYmSpP9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juaJKPZrAhlCzlZHLvWBLYv274aPhPSyKxOyUfHkTfZMfXeOw2GsZVnX3vk9LEinY6DirIRAIpN6Ymr1nlCeYD2GWTuQQXax2Y5gWZcrct8zx47lR+5LgXzmevmD8ITiqPxrtwOpCIhVZFbYD3bEIByJN3/LfLy3fu3ceyROaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UHqUobbR; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6eb1e09f7e4so25392596d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742581742; x=1743186542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrQ0EzEMWWG6jQuSoJHeIyls2E9YhdY6/vRFZgsC7e0=;
        b=UHqUobbRnVFT97pGCaj8rvS5P+q3ZbkIf/O2qAG1Ofh5FPnoU38S5IpIFBmew2sFOz
         mIZCuqHpLFodRK4Ce+wJ9hOnpLaNTXVvRKCP05PHILjRJ42sGNnTbF9YSLTww+4TyuH1
         UngwjWbM87qq6fe+3c0n9fpwhAfpwjSUgm7hMTTr65XPBa9ctF7JeYxZh43ICo0yWMaZ
         /bYMXc55qZM+JwtQgWlOZswBnFWLQw2r9n+VTMMSdK5zItRR434E3wOI0g9Xz/OhMYf4
         xL+DcZjwcIHcDTuXSh1qW7ST5KDDxRUNIMkJl5wMhRUCRO9YPyqk/d0wWMC9A/o33MWy
         FRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581742; x=1743186542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrQ0EzEMWWG6jQuSoJHeIyls2E9YhdY6/vRFZgsC7e0=;
        b=NuZkrHLa8H0o6jDzaW58BrkuRzRqKh0l55+aiervJfyEs4+HICSujdYiLV5LmB4S7e
         yA++6CiQ7Yk2OZoyKn9jzl6tfHhBKJe9Co+Czk/Ku0R9EDcbj9MAy7PLmetGsUnQ7Mvm
         fPidhUhq4s+j6H+PpA/hf1fyR0xqzG+wa82dkabszTPQ+j5mGzj1chlLIuhvhsC4/zV4
         K38p973s3jZo+cj88/zoaDux9oOKxrfhKJsat49XEoypO3gm6DnR31YujIMqu0bkrSIB
         ZfS/vm7sdxl2gL+3PZ2vnMxfYUDY87gWnSmEEhx9wz/56tAGaQPocTkF2wWgUS1cHlZd
         zp1A==
X-Forwarded-Encrypted: i=1; AJvYcCVKHSQc/R632F/iYFHUt7jbGyRVYvHVAAWTHxrxzNIQDpEvroLRzch5pB0NXcQu4tdYqgpldhVe1xOIVbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JhSUl2qaL88Oy8eK3R4MPLjJrFv3nCH3/yiY/G+YnOOsSLfV
	vOydhdCfv4BqFLGebj0sUJ5B5+unzJtS4EyfJnShX46Nz1LvBIwRQdxk5P88BeXH+JXPtmpkZza
	b
X-Gm-Gg: ASbGnctFOVb/9bQg8PKdS8AUZx+obpbvfPr0Itx0DqymnWpjQz7K8i1e761ptqvtqYE
	AbsDx1eFj5F6FfPF4taQhrYXJC/98+L2Eftcg828monjFagNCtdnUrJjK9DxxKkgWYv5nNaCATg
	R79h9nN1pZG2Pbedp7BYw2TfYQ+YALUD1jXcz8BX1vrpuHVW5t0bYxAeH1FWu1FVeAFJx7tgBxB
	grwOK0xs8D6geTYsqFe5lFulD3DmZDjRX65oudjoGAjBebJvZ7U7XxN//gLcw7d0itZbRL48SEr
	kQfGtYL3El1J/vDRKah/4UjOazFCgF6KFQSBakvOgxyiv5wgjYVBoYixCj9zaqqqBESDoIGcI2H
	yZnlXsiZh2XedRScrrAOPac8=
X-Google-Smtp-Source: AGHT+IE8/kN4YgJruUR+/bfMJ7DomcrEj95sqf6MWrpr+dGE/We4hf0Dqm3GWvJMjve9Iw4bEfc0/g==
X-Received: by 2002:a05:6214:2469:b0:6e8:fbb7:6769 with SMTP id 6a1803df08f44-6eb3f2937c0mr69832456d6.14.1742581742075;
        Fri, 21 Mar 2025 11:29:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef0ed67sm13821566d6.12.2025.03.21.11.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:29:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvh77-000000016ZW-0DDA;
	Fri, 21 Mar 2025 15:29:01 -0300
Date: Fri, 21 Mar 2025 15:29:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v13 2/7] rust: add dma coherent allocator abstraction.
Message-ID: <20250321182901.GQ126678@ziepe.ca>
References: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
 <20250307110821.1703422-3-abdiel.janulgue@gmail.com>
 <20250321172353.GO126678@ziepe.ca>
 <Z92jPXvMOqhgv04k@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92jPXvMOqhgv04k@pollux>

On Fri, Mar 21, 2025 at 06:34:53PM +0100, Danilo Krummrich wrote:
> On Fri, Mar 21, 2025 at 02:23:53PM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 07, 2025 at 01:06:19PM +0200, Abdiel Janulgue wrote:
> > 
> > > +        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
> > > +        let ret = unsafe {
> > > +            bindings::dma_alloc_attrs(
> > > +                dev.as_raw(),
> > > +                size,
> > > +                &mut dma_handle,
> > > +                gfp_flags.as_raw(),
> > > +                dma_attrs.as_raw(),
> > > +            )
> > 
> > This is not the correct safety statement, the device must have a driver
> > bound to call this function, a struct device reference is not
> > sufficient.
> > 
> > I belive Danilo was suggesting to ignore this unsafety for now, but if
> > so it should be documented correctly.
> 
> If just landed patches [1], which are the foundation of addressing this issue.

Those patches say:

 The context types can be extended as required, e.g. to limit availability  of
 certain (bus) device functions to probe().

Which is not an appropriate limitation for dma_alloc_coherent, we
expect it to be called outside probe in real drivers. Is there more to
that story?

Regardless, the safety comment should not be merged with incorrect
information. :\

> > Also think the use of devres here is going to be very problematic for
> > drivers to use as I said in other emails. :(
> 
> In an earlier reply today in a different thread already gave you the link [2] of
> what we landed, which, besides explaining the situation, also makes clear that
> there is *no* Devres wrapper around a CoherentAllocation and why.

Yes, I see, I have so much email right now it is hard find all the
different versions of everything.

Jason

