Return-Path: <linux-kernel+bounces-441441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D20C9ECE70
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C038E18877AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC26513D53B;
	Wed, 11 Dec 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BFln27Vh"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8938DE9;
	Wed, 11 Dec 2024 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733926909; cv=none; b=gio32i0NjmTBqTBBMx1AXpn8CFj3t7lIL4byGLFBrBN8HJ1ejr1ufIVOm9tJglCioXK/RPN3bq8m9AWFo56et2/e5kY7hVBXX1sAjLbIEMQAwtU5A0aLh3KIex9XQe/eaEu00ETK21XIbth3Q/Ks1uI9SFEE8M3KRUnfd0BKrZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733926909; c=relaxed/simple;
	bh=VtPTBcTdAQ8LL/SqRz3M1y6IWXY2rf8Za4/3ZnMH3yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQA5cbvbbm3I4hSd4S0remGTTQ885lHM/7A/9HgnqqPhQeUv+ZaiyxHk0RUKKAD2nC2zruNAWI7mZEuDlpwiItuRyOx0+zq260HOtpgzM2AjJwdWAkcM8zd7e8ASWcgSJWQZEhn6eAYJh1lEbbkHLib30X+0a6+TwOg8gZKurIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BFln27Vh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dl6HhXnXtI5BMmbbTqQQtMZmSD0CbjaLdCDoc3kPugM=; b=BFln27Vhw+E0relxuerHP6SKRC
	vLKMujKc7cgsvnc3eyuxC5H/VNkwW/vaJWZX5vTPY9oL3PAYixyvqC1jGImS0jSsTskpAr1x40a+m
	5Wg/f0tn4IHK/tpV88JO8FKkj96T0QWWTqjH55V6BYdzcUzS6NRIDEbZwviLxQtqWY88=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tLNav-0006fY-6M; Wed, 11 Dec 2024 15:21:41 +0100
Date: Wed, 11 Dec 2024 15:21:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 07/15] ARM: zynq: Add ethernet phy reset information to
 DT(zc702)
Message-ID: <897ab5eb-a210-41d6-bfef-a60ab74f5943@lunn.ch>
References: <cover.1733920873.git.michal.simek@amd.com>
 <9e18d59ca339804320d2a5e3c7362aefa3bb7c99.1733920873.git.michal.simek@amd.com>
 <8395fb6b-d7a5-4e2c-9eb3-4984b8c775c4@lunn.ch>
 <344eb4b3-1073-4c65-a8ba-fee943776627@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <344eb4b3-1073-4c65-a8ba-fee943776627@amd.com>

On Wed, Dec 11, 2024 at 03:04:28PM +0100, Michal Simek wrote:
> Hi Andrew,
> 
> On 12/11/24 14:45, Andrew Lunn wrote:
> > On Wed, Dec 11, 2024 at 01:41:26PM +0100, Michal Simek wrote:
> > > Added phy reset gpio information for gem0.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > > 
> > >   arch/arm/boot/dts/xilinx/zynq-zc702.dts | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/xilinx/zynq-zc702.dts b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
> > > index 424e78f6c148..975385f4ac01 100644
> > > --- a/arch/arm/boot/dts/xilinx/zynq-zc702.dts
> > > +++ b/arch/arm/boot/dts/xilinx/zynq-zc702.dts
> > > @@ -79,6 +79,8 @@ &gem0 {
> > >   	phy-handle = <&ethernet_phy>;
> > >   	pinctrl-names = "default";
> > >   	pinctrl-0 = <&pinctrl_gem0_default>;
> > > +	phy-reset-gpio = <&gpio0 11 0>;
> > > +	phy-reset-active-low;
> > 
> > Hi Michal
> > 
> > Could you point me at code which actually implements these two
> > properties.
> 
> I have tracked it down and it was only used from 2016 to 2018 in Xilinx
> downstream Linux repository. After that it was removed.

O.K. So when you ran the DT lint tools to validate these DT changes,
why did it not give errors pointing this out?

I wounder how many other such errors there are in this patchset?

	Andrew

