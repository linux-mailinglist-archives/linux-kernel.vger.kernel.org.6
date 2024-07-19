Return-Path: <linux-kernel+bounces-257634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9887E937CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 21:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E2C1F21CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4214831C;
	Fri, 19 Jul 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4/XgPtij"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CED383AE;
	Fri, 19 Jul 2024 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721416572; cv=none; b=rDnI2UUCNpmAlF5YrUpDmbi9WBuFM3I96LiDXvmFhon2aBNKnKgFe2WMX02Sm/s8sj6QvYYBeWCxvlxbp9C+l2duSeLZdIaiFFRKFjnUtBJ9KnNtgHjO4DP1HMBrOTDB+fy2Uv00nvSdT//bURHkl/wvnGRDuUHqECywowRpxyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721416572; c=relaxed/simple;
	bh=Qp45Bc5Xy2NOxD4SnLWPPVtUbCoC1udEsnBfNbE4wgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=huTZh35bPbx5xCF3wtfEG3j7nH5e6XqPaYoat8Uxvl76Uwz25wITj/LEQzvZUsUCJyFkeUplFdxvkr3qkm0vLx7qPVfszG4kacz8xVIH2bqZNVWPCjwPO7f2ZAVBeuSCHf34OQwcLARfNuDHsHpgG/EZa7TrNTlnM6yqHzg5P/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4/XgPtij; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=utcWhnK0nFVAk70VesExqQRxttF6pnNN+AhFcvP+pG4=; b=4/XgPtijOoYUGCIyClpyHfU7jD
	l23u+XC2xH0UjwWIMllWNThfrgzH41IdkpR3TyxYAnKNkIyGA2OKVPAZHgTk1vibSBuv/GQqTJB7o
	vDN5++khxHNmWofYvWC6smNjOPDXnKGx2Z0IcUMkFLMMHxmCpbdoQDJuBdjUvdohaNLo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUt4y-002rdH-HD; Fri, 19 Jul 2024 21:15:44 +0200
Date: Fri, 19 Jul 2024 21:15:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: Ayush Singh <ayush@beagleboard.org>, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
Message-ID: <b3269dc8-85ac-41d2-8691-0a70b630de50@lunn.ch>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
 <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>
 <Zppeg3eKcKEifJNW@test-OptiPlex-Tower-Plus-7010>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zppeg3eKcKEifJNW@test-OptiPlex-Tower-Plus-7010>

> >  drivers/greybus/Kconfig         |   1 +
> >  drivers/greybus/gb-beagleplay.c | 625 +++++++++++++++++++++++++++++++++++++++-

> > +static u8 csum8(const u8 *data, size_t size, u8 base)
> > +{
> > +	size_t i;
> > +	u8 sum = base;
> follow reverse x-mas tree

Since this is not networking, even thought it was posted to the netdev
list, this comment might not be correct. I had a quick look at some
greybus code and reverse x-mas tree is not strictly used.

Please see what the Graybus Maintainers say.

	Andrew

