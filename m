Return-Path: <linux-kernel+bounces-325303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA4975796
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F66F1F27F1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3B81AB6DA;
	Wed, 11 Sep 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Wuc/sGyS"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75C185954;
	Wed, 11 Sep 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069758; cv=none; b=d5cF4oEsk3gY/Dt1nrUqIME3kR1RaKPPsfvlaw0phczMH2VInfr9n99xBeglKTSc0eiPi6Gf7GJm+kMHKs7YUyExXuPXvseSfRmhmGzH339zV902p3taYzLiQqbT4k510IxTwKMfJcJme9/QFRzuiklefX/AlCTQqbxT8aRCx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069758; c=relaxed/simple;
	bh=jvJrBcnk+D8yfH+0FQrinizcg59VFH4KplTPztnryN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxeVznSjZOWVt24BCtzBjMsu1Uv/FckEASRW7+SQzy3aVjnKuwYOTb5MqK2+aeiaF8dm0OtXMUvlW2b3Z4M4C63Qk8AMfmc4XUgRYBK61NHHCzeQImhitPyRbNQcx5iuC7OEjhLfzYHBNuE4pUAk+xBhcJoBxaOCJCkwl3cx4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Wuc/sGyS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=t6UG7PLdbkoosunbZul9Kx6uV/hzSw/RTZj0KodJ6ls=; b=Wuc/sGySYMF45bcq3U9BoGJBhg
	udLHtgMRTDcvtuEAtsLTSvF9hsBCKouVn6Q6JbA2IDlDcRjw1u3NHuPCsCGn9NQiQXDnzrUhCIFf0
	f0dF9JkCMoeDZ6tn+UAq6FnjDI7HLZvB/alVkHI8L0hBkWCdtbwTd8KP+bWjHJG/mC2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soPaP-007E9Y-JU; Wed, 11 Sep 2024 17:48:53 +0200
Date: Wed, 11 Sep 2024 17:48:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
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
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] mikrobus: Add mikrobus driver
Message-ID: <2a1155b4-f158-4cdd-ad3b-82d4a1841245@lunn.ch>
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

You are missing

        depends on RUST

	Andrew

