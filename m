Return-Path: <linux-kernel+bounces-326120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2249762E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB801C22E08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3BA18FDAB;
	Thu, 12 Sep 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ErX2h4WQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B545186E58;
	Thu, 12 Sep 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726126773; cv=none; b=i/s9U/y68sxPp0WkQ5szORxkDO/GOsd3t4bYA1DeK/cNorcbHdUIXEpV4dUuwlg7gqLvyrjK8wW6xBkrBaWeLpTewdxGFTE7hZb0bjYWtEqicF4rnYtoKvZVjc6Xq5/LtoSo9W9q9dJB1a64fSpZZGRHcHJqRTXCNj4W7gFWFvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726126773; c=relaxed/simple;
	bh=gV3RMZWJnnQir9K3hCqxXCfW964fDFkZOcrcBd9k0Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnA2znkZ7Orl2xfDiIzpnHKC0n3mMDmbtP+9iFH97D9cKF37q2VP+/6LDaEita6A2l7ySF+OMHJxtQ+WHDbtNdpzov+lQm4UkbwacAA9aoKZVmvfWHenftl/vpYe33CsNbCoXEBzWObsFXRBhbqjC65s+TV3us681tcgDpjtTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ErX2h4WQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C76AC4CED2;
	Thu, 12 Sep 2024 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726126773;
	bh=gV3RMZWJnnQir9K3hCqxXCfW964fDFkZOcrcBd9k0Q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErX2h4WQz1LUJl504c7zcNhfCsuRhNJPrRLmgsmmKY8pgeUqQ+g/VxvSXmFr6VUJm
	 MMqOnbZpOdmirXhV3mgq1fM9jzl8H/5QAgRFUl17Ph4HeLDA+8u53cNK+lEWRRIkhN
	 wO5FOXcMV8RjS4zf61yY/zXtL+aQi5M2cOUyg64U=
Date: Thu, 12 Sep 2024 09:39:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Ayush Singh <ayush@beagleboard.org>,
	Ayush Singh <ayushdevel1325@gmail.com>, fabien.parent@linaro.org,
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
Message-ID: <2024091211-bladder-runner-2d75@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
 <2024091149-vocalize-composite-6e48@gregkh>
 <44039255-159a-4284-abd8-a0f558ad006d@gmail.com>
 <2024091151-unworldly-dance-9a80@gregkh>
 <097159c7-1602-4e32-8e6f-9cd023d62238@beagleboard.org>
 <419bf74e-74cb-46ca-95d0-03b3bab3948d@de.bosch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <419bf74e-74cb-46ca-95d0-03b3bab3948d@de.bosch.com>

On Thu, Sep 12, 2024 at 09:29:01AM +0200, Dirk Behme wrote:
> On 12.09.2024 09:16, Ayush Singh wrote:
> > On 9/12/24 01:34, Greg Kroah-Hartman wrote:
> > 
> > > On Wed, Sep 11, 2024 at 09:26:06PM +0530, Ayush Singh wrote:
> > > > On 9/11/24 20:28, Greg Kroah-Hartman wrote:
> > > > 
> > > > > On Wed, Sep 11, 2024 at 07:57:25PM +0530, Ayush Singh wrote:
> > > > > > - GPS3 Click is a UART MikroBUS addon Board
> > > > > > 
> > > > > > Link: https://www.mikroe.com/gps-3-click
> > > > > > 
> > > > > > Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> > > > > > ---
> > > > > >    addon_boards/mikrobus/Makefile         |  1 +
> > > > > >    addon_boards/mikrobus/mikroe-1714.dtso | 28
> > > > > > ++++++++++++++++++++++++++++
> > > > > Odd top-level directory for the kernel, are you sure this is correct?
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > > 
> > > > Well, it is kinda a temporary location, since well, I could not
> > > > find a good
> > > > place for board overlays but a top-level location seems better
> > > > than putting
> > > > them in any arch specific location. I am open to moving them to a more
> > > > suitable location if we have one.
> > > top-level location is not ok for something so tiny and "special".  Just
> > > put it where all other dtso files go.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > 
> > So here are the directories where dtso files currently go:
> > 
> > ❯ find . -type f -name "*.dtso" -printf "%h\n" | sort -u
> > ./arch/arm64/boot/dts/amlogic
> > ./arch/arm64/boot/dts/freescale
> > ./arch/arm64/boot/dts/mediatek
> > ./arch/arm64/boot/dts/qcom
> > ./arch/arm64/boot/dts/renesas
> > ./arch/arm64/boot/dts/rockchip
> > ./arch/arm64/boot/dts/ti
> > ./arch/arm64/boot/dts/xilinx
> > ./arch/arm/boot/dts/nxp/imx
> > ./arch/arm/boot/dts/ti/omap
> > ./drivers/clk
> > ./drivers/of
> > ./drivers/of/unittest-data
> > 
> > 
> > Out of these, `drivers/of` and `drivers/of/unittest-data` contain
> > unittest dtso, so probably not the place.
> > 
> > And the `arch/arm` and `arch/arm64` are for arch specific stuff.
> > MikroBUS is supported in RISC-V boards as well (BeagleV-Ahead). So
> > probably not the correct location either.
> > 
> > Maybe something like `arch/common/addon_boards` would be better?
> 
> Whats about
> 
> drivers/misc/mikrobus/mikrobus.rs
> drivers/misc/mikrobus/mikroe-1714.dtso
> drivers/misc/mikrobus/mikroe-5761-i2c.dtso

Exactly, put them where the drivers are, like clk and of does.

thanks,

greg k-h

