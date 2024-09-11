Return-Path: <linux-kernel+bounces-325211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B96975636
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CB31F261BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB51A3044;
	Wed, 11 Sep 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="diiAG7RO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E81A3AB7;
	Wed, 11 Sep 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066663; cv=none; b=MDOUAAgdJxL3s2jdz7bK9ACp7WkmZZGyxuo/AZG5L1rCPR6eJOiRKGnC9XG8Npwe7PA35uL4E7Rx7wVPxm4t8TMI7agdVJMg8HFu1qyK2cseLCJQj6X50kKrqPXf9HQgi2UBKcqtkFY4/HKH6GwWeTMmiR32b2+o61ylJRbzz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066663; c=relaxed/simple;
	bh=IqUX2V7EiXOEzNuwkkw8pyGCRs0LMUPt/GHdSfxXN30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW2SnowmL1wgWeWzDrDjk3Ehds456Dvhk8aoZzwCGKDOSptUlhbytssJPGWzef1Jl9cH1eCww485HqT1uOy1ZDZlBQFtdQlckaxamKOdrwNUqi4vZpwVONfhqkwLq6uIpFfWc5AM71oIARqOBm9EDA0q3k92V0SFNVm797xwz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=diiAG7RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10399C4CEC5;
	Wed, 11 Sep 2024 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726066662;
	bh=IqUX2V7EiXOEzNuwkkw8pyGCRs0LMUPt/GHdSfxXN30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=diiAG7ROWhoSuhEFjMWBZU1zby3fBsWNni50e+cMgGhI/iys1CC+6LAYjIVJ7rxgy
	 AMmz3+IACpEeO+x7SNpG99GwgNrU4xjEg613BgqmpyzEUxuvnA0Nem+/V+aWY7GQXR
	 aBk91V0VRE2U9+3eLHVU1kxHqIkU1Ple/bf09c60=
Date: Wed, 11 Sep 2024 16:57:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org,
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
Subject: Re: [PATCH 3/8] mikrobus: Add mikrobus driver
Message-ID: <2024091144-glitzy-kindly-fa74@gregkh>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-3-3ded4dc879e7@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-mikrobus-dt-v1-3-3ded4dc879e7@beagleboard.org>

On Wed, Sep 11, 2024 at 07:57:20PM +0530, Ayush Singh wrote:
> A simple platform driver for now that does nothing. This is required
> because without a platform driver, the mikrobus_gpio0 nexus node cannot
> be used.
> 
> In future, this driver will also allow for dynamic board detection using
> 1-wire eeprom in new mikrobus boards.
> 
> Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> ---
>  MAINTAINERS              |  1 +
>  drivers/misc/Kconfig     | 17 +++++++++++++++++
>  drivers/misc/Makefile    |  1 +
>  drivers/misc/mikrobus.rs | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 51 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cc27446b18a..d0c18bd7b558 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15433,6 +15433,7 @@ MIKROBUS CONNECTOR
>  M:	Ayush Singh <ayush@beagleboard.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
> +F:	drivers/misc/mikrobus.rs
>  
>  MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
>  M:	Luka Kovacic <luka.kovacic@sartura.hr>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3fe7e2a9bd29..30defb522e98 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -610,6 +610,23 @@ config MARVELL_CN10K_DPI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mrvl_cn10k_dpi.
>  
> +menuconfig MIKROBUS
> +	tristate "Module for instantiating devices on mikroBUS ports"
> +	help
> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
> +	  board socket standard that offers maximum expandability with
> +	  the smallest number of pins. The mikroBUS driver instantiates
> +	  devices on a mikroBUS port described by identifying data present
> +	  in an add-on board resident EEPROM, more details on the mikroBUS
> +	  driver support and discussion can be found in this eLinux wiki :
> +	  elinux.org/Mikrobus

So you want to be a bus?  Or just a single driver?  I'm confused, what
exactly is this supposed to do?

If a bus, great, let's tie into the proper driver core bus code, don't
"open code" all of that, as that's just going to make things messier and
harder to work overall in the end.

If a single driver, why is it called "bus"?  :)

thanks,

greg k-h

