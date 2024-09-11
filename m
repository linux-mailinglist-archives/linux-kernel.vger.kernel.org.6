Return-Path: <linux-kernel+bounces-325558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83185975B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59D51C2221C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A71BB684;
	Wed, 11 Sep 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mpkFgOWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD801BA273;
	Wed, 11 Sep 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085067; cv=none; b=nPVIQS/fOZWkIY0mMKOWlOrMpBHZfj2/CuAFGym1UpXIngRVJYr2p1KNagNCSyWbesEMtGD1xVPevs6Ft8ucx1OwgpPQQKWLXox5cG31s6kmtBYW1wcuy4Ax1axQxAGws8Et90xNI5lxWUOOSig2dPZPHWEHO+QAmlscNLz+s5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085067; c=relaxed/simple;
	bh=GXOiEIYsWfuKvKBtFBVA4UteXR8sE5bAKt5Q/mK32Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoQ59046ZtOQxh5kznqkOBdTGFn6Z50Fv8tJ3zTXp9X8DklhIB5TqUx0F2JViV2kkBHO6lr1R3Zu256tBQLSEiR9enJKXKLtybWiqosUQFSXbz5OPlOVJ6mTTE9bzrKJlO59V8yWHK3ClMBaGwN2zJWPVPxlDxOzZmOGfkPvbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mpkFgOWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA161C4CEC0;
	Wed, 11 Sep 2024 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726085066;
	bh=GXOiEIYsWfuKvKBtFBVA4UteXR8sE5bAKt5Q/mK32Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpkFgOWt22rc4Hs/PznEZ1kisjL/9YAWdqztfJ/MJ0AXEFWJCniDIxo7dkeQR093h
	 iTdV11flhCNA/YMyESfAE8+wsXyGOiBNQ3Ok4HL3Uah0YguFxkguAUtAI7jBl72tTi
	 fP0HB49EeqABIbNnAMr9YsStbrn8sHj2sxX2/7eo=
Date: Wed, 11 Sep 2024 22:04:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: Ayush Singh <ayush@beagleboard.org>, fabien.parent@linaro.org,
	d-gole@ti.com, lorforlinux@beagleboard.org,
	jkridner@beagleboard.org, robertcnelson@beagleboard.org,
	Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
Message-ID: <2024091151-unworldly-dance-9a80@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
 <2024091149-vocalize-composite-6e48@gregkh>
 <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>

On Wed, Sep 11, 2024 at 09:26:06PM +0530, Ayush Singh wrote:
> On 9/11/24 20:28, Greg Kroah-Hartman wrote:
> 
> > On Wed, Sep 11, 2024 at 07:57:25PM +0530, Ayush Singh wrote:
> > > - GPS3 Click is a UART MikroBUS addon Board
> > > 
> > > Link: https://www.mikroe.com/gps-3-click
> > > 
> > > Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> > > ---
> > >   addon_boards/mikrobus/Makefile         |  1 +
> > >   addon_boards/mikrobus/mikroe-1714.dtso | 28 ++++++++++++++++++++++++++++
> > Odd top-level directory for the kernel, are you sure this is correct?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> Well, it is kinda a temporary location, since well, I could not find a good
> place for board overlays but a top-level location seems better than putting
> them in any arch specific location. I am open to moving them to a more
> suitable location if we have one.

top-level location is not ok for something so tiny and "special".  Just
put it where all other dtso files go.

thanks,

greg k-h

