Return-Path: <linux-kernel+bounces-279962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8608B94C3E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336D41F23131
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5E13DDCD;
	Thu,  8 Aug 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwLljYqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686E1635;
	Thu,  8 Aug 2024 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139395; cv=none; b=J/Lhnd3XPbicoD/KEojlEZxHcALWHYzd4IoCMO4GRReLkNlrodutqNrLXkW/9WCHJwvmjN8ebwfQ41Guc76P4PsA4SPAnDM1SKzTt3QEMtgkvMiBxHnL4JS9wCrn6QhHt+itmzBxJE+qbYyc7I92UEIV30EuNk3JDw3HSy3nkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139395; c=relaxed/simple;
	bh=5+aelMbURuH5w4Acf65OlNYwqYxFl+suSWuEQ7s74BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h67bZvYstD5DC3mSpOx97w1VSNriEfbJBB7VfoMr+ZYU7HXnIpCOg3USNipALwAhC2yQyFA9xqAeJwIKjNmTKsUH65l5ir99MK07dCaoAAnZG0e10HIgrwcKq6TrLPL1gMANDCUKSoj4A5F8/UN2A6hrDiWIymJGVyYGk3lqIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwLljYqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34B8C32782;
	Thu,  8 Aug 2024 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723139395;
	bh=5+aelMbURuH5w4Acf65OlNYwqYxFl+suSWuEQ7s74BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwLljYqWdV99qq+FG4d7s+pMQofwnCrgZrhqdxNEaERupcsqgSXWjCcDiecrinZ3L
	 0Fg7w3GiirSCJMSe10umnH3WujARsfzSk9HmhiFDpCIU4Xhho4zeB/3oQ3Nen3oqVZ
	 5DCNp6Rnq5TDRnEdKKm4LKdEQMSnzfo9PGI4y+wMCzgZGBSqtk5QB2ho9jmLWT6Icu
	 zFZCwiFEA8tvUyxHf2asLiotHTh2dG2Z+Wl5lBYfSLFCHLNtiTW70aCCjjYt2UVIzL
	 NUBW4mcFRxoPVTliV5RqKs6NKh4Do4aR02DBNQDa7hWQi+xhPIKO4HHvK5IFjKokjp
	 bPoUloCM1Gvpg==
Date: Thu, 8 Aug 2024 11:49:53 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of/irq: Consider device address size in interrupt map
 walk
Message-ID: <20240808174953.GA1670999-robh@kernel.org>
References: <20240807120153.1208858-2-stefan.wiehler@nokia.com>
 <CAL_JsqLciDTxfeKwuNNWEOZjrUDFp9g7ZAzTuY4nQ1GCwPmaow@mail.gmail.com>
 <9d19cec9-3e40-471c-8c76-8842a5d86973@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d19cec9-3e40-471c-8c76-8842a5d86973@nokia.com>

On Thu, Aug 08, 2024 at 09:53:59AM +0200, Stefan Wiehler wrote:
> > You've missed a bunch of people/lists. Use get_maintainers.pl.
> 
> Sorry, indeed, did not think about about PCI...
> 
> > Can you provide some details on what these nodes look like. The
> > interrupt provider to an SoC device is a PCI device? That's weird...
> 
> The DTO looks like this:
> 
> watchdog {
> 	...
> 	reg = <0x00002064 0x00000028>;
> 	...
> 	interrupt-parent = <&gpio_17_0>;
> 	interrupts = <4 0x8>; // 8 -> IRQ_TYPE_LEVEL_LOW
> 	...
> };
> 
> And the base DT:
> 
> ecam0: pci@878000000000 {
> 	...
> 	#size-cells = <2>;
> 	#address-cells = <3>;
> 	...
> 	gpio_17_0: gpio0@17,0 {
> 		...
> 		reg = <0x8800 0 0 0 0>; /*  DEVFN = 0x88 (17:0) */
> 		...
> 	};
> 	...
> };
> 
> I completely agree it's a bit sketchy, but it's not me who came up with
> this ;-) Nevertheless I think other people might run into this issue of
> mismatching address sizes as well when no interrupt mapping was intended.
> 
> > Note that of_irq_parse_raw() was refactored in 6.10, so your patch is
> > not going to apply.
> 
> I'm aware of that and have adapted the patch accordingly.
> 
> > That's not the right information to parse the address correctly. You
> > would need the device's #address-cells. However, in most cases we
> > don't really need to parse the address. The address is not really used
> > except in cases where interrupt routing matches the bus and so there
> > is only one size. That's effectively only PCI devices today. In that
> > case, the address size would always be equal, and the code implicitly
> > assumes that. It would be better if we could just detect when to use
> > the address or not. I think we'd have to look at 'interrupt-map-mask'
> > first to see whether or not to read the address cells. Or maybe we
> > could detect when the interrupt parent is the device's parent node.
> > Either way, this code is tricky and hard to change without breaking
> > something.
> 
> Thanks for confirming that it's PCI only and no address size mismatch
> should occur. I also was thinking in the direction of checking first if
> interrupt mapping is intended and return early otherwise, but was
> worried to break something along the way...
> 
> > A simpler way to fix this is just always pass in an address buffer of
> > 3 cells to of_irq_parse_raw. You would just need to copy the cells in
> > of_irq_parse_one() to a temporary buffer.
> 
> That indeed sounds like the easiest solution to me; I'll send a new patch
> shortly. However I don't understand how you came up with an address
> buffer size of 3 - shouldn't it be MAX_PHANDLE_ARGS
> (addrsize = MAX_PHANDLE_ARGS and intsize = 0 in the worst case)?

There is simply no supported case of more than 3 address-cells. If 
someone has 4, then their address translation is not going to work and 
we won't even get to worrying about interrupts...

Rob

