Return-Path: <linux-kernel+bounces-525752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F479A3F45C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A911886744
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FEB209F4B;
	Fri, 21 Feb 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyleH0/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600911E9B0D;
	Fri, 21 Feb 2025 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141104; cv=none; b=UBlZ43rYBBdILq5rz46UDfXZQM35TAcm4mVrIFlozuQLxVw2ilJ7M3oubYDyWPAoZM3q7Lu0oR/kCvr7wnWVJ6Qz5j9iSghIsyfxepIU+553X5mjpgT0zRODlseZXhxHJlQLJqmUEoix+BFhhJO5LR5WC5Y8UKJlDHNYmoznP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141104; c=relaxed/simple;
	bh=q8WccUvMCEjEq8D445PcgFQTfSEcnZeGJELN1WQnJpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSSxQgY1k6/2U46xavAXowEdzda0liY9GCoIcgmRnloi6fFu//MgDtShHJJYLcZROQiCULWFPZqh0eZLwriUSUGkU04w5tyC5SSfLURYqTp28yn+fuEPtzOpVnC+m3OLDbQX8RxcyUHl7JTGH5j86lSGnfFbuya0NPoU7JwQWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyleH0/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6271BC4CED6;
	Fri, 21 Feb 2025 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740141103;
	bh=q8WccUvMCEjEq8D445PcgFQTfSEcnZeGJELN1WQnJpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TyleH0/GM5J84z9onnQrMroU9wvXKOptL1fakQv4PcmqK7ukY1tfLzxO0Y2HrOREJ
	 LmwH48qpkhDBzGHgcKREumi0uVK39mfYYiUTbfeqhX7+FiI9Hdi9rcaUldEeITPuDt
	 GzH0OIGc3OQxBQTzYc7yhI6cIHL5XfseEm2jn9ihiyup/43v5DeMtg3+5t3kMVUv5X
	 msW72GqQ4gywSELxcAx6InTB5uoHXAPsolLgGSmp+tyYATQ7gWAe1MnEcOvlwRZyA1
	 +ai0Pu0D9sf6ZLcKZQgXGD64UT2LIeHdX993FSvAzxpRAe4IBwarUfBw1fUvlxd6VZ
	 bBZztWPKcn0fw==
Date: Fri, 21 Feb 2025 13:31:38 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Dave Airlie <airlied@gmail.com>, Timur Tabi <ttabi@nvidia.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Subject: Re: [PATCH RFC 1/3] rust: add useful ops for u64
Message-ID: <Z7hyKm1jcRtdrmh9@pollux>
References: <D7VLMD31YB0V.OKHDSVUPAZTE@nvidia.com>
 <1b8921d46f7d70c7467ea0940d60220f05cccc5d.camel@nvidia.com>
 <D7W119MHCCWH.IS600FTIOV8O@nvidia.com>
 <e6322f90-08bd-4e86-8dad-2ddbd7e5cece@nvidia.com>
 <D7WFP99SMV3H.26AJWK17S0UPX@nvidia.com>
 <fd920faf-a707-4c6d-8c0b-3d59c010da1d@nvidia.com>
 <CAPM=9txmQWO+SHnZhr8zXHCZ=S8CNY=PryRVkWWuHyor-ajU6A@mail.gmail.com>
 <1597EDB7-D91B-4660-ADDC-D2252B26CB22@collabora.com>
 <41cf1c79-f61c-47e7-a0ed-afb8e82d50e6@nvidia.com>
 <D7Y3CO9OMZBQ.1QGFV73NZBBIF@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7Y3CO9OMZBQ.1QGFV73NZBBIF@nvidia.com>

On Fri, Feb 21, 2025 at 08:35:54PM +0900, Alexandre Courbot wrote:
> On Thu Feb 20, 2025 at 9:14 AM JST, John Hubbard wrote:
> > On 2/19/25 3:13 PM, Daniel Almeida wrote:
> >>> On 19 Feb 2025, at 17:23, Dave Airlie <airlied@gmail.com> wrote:
> >>> On Thu, 20 Feb 2025 at 06:22, John Hubbard <jhubbard@nvidia.com> wrote:
> >>>> On 2/19/25 4:51 AM, Alexandre Courbot wrote:
> >>>>> Yes, that looks like the optimal way to do this actually. It also
> >>>>> doesn't introduce any overhead as the destructuring was doing both
> >>>>> high_half() and low_half() in sequence, so in some cases it might
> >>>>> even be more efficient.
> >>>>>
> >>>>> I'd just like to find a better naming. high() and low() might be enough?
> >>>>> Or are there other suggestions?
> >>>>>
> >>>>
> >>>> Maybe use "32" instead of "half":
> >>>>
> >>>>      .high_32()  / .low_32()
> >>>>      .upper_32() / .lower_32()
> >>>>
> >>>
> >>> The C code currently does upper_32_bits and lower_32_bits, do we want
> >>> to align or diverge here?
> >
> > This sounds like a trick question, so I'm going to go with..."align". haha :)
> >
> >>>
> >>> Dave.
> >> 
> >> 
> >> My humble suggestion here is to use the same nomenclature. `upper_32_bits` and
> >> `lower_32_bits` immediately and succinctly informs the reader of what is going on.
> >> 
> >
> > Yes. I missed the pre-existing naming in C, but since we have it and it's
> > well-named as well, definitely this is the way to go.
> 
> Agreed, I wasn't aware of the C equivalents either, but since they exist
> we should definitely use the same naming scheme.

IIUC, we're still talking about extending the u64 primitive type.

Hence, I think there is no necessity to do align with the corresponding C
nameing scheme. I think this would only be the case if we'd write an abstraction
for the C API.

In this case though we extend an existing Rust type, so we should do something
that aligns with the corresponding Rust type.

In this specific case I think it goes hand in hand though.

- Danilo

