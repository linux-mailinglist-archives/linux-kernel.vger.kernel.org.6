Return-Path: <linux-kernel+bounces-413780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1579D1E99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721C9281F99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEBF142624;
	Tue, 19 Nov 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgRc5s+1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476841A28C;
	Tue, 19 Nov 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985452; cv=none; b=U0rSb2Zx6hEJexOmgcZiv4kRuBRWPvEPHr5NmXsA700QzbW0keErikzWxkx9n3o4pzrJLxiul6cV8wLj/FfVH7SzTBb2Jkuq6yEKToT0BEikF7IxqAkzDjpYswJgcVZqovUHBEpmlVKdWO5YYw1TPrBNST/SzxbnIwPLZHNOHHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985452; c=relaxed/simple;
	bh=8UnIt6nf6xlNgw20k3rqUKdl+epAp0Ho80SLBcAHygQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvoOH/hulsCs/uUOFdgWLlp6tjolrAgSzrka1lgnStF9a0JL2bsPq03TjKYye1i89Co6ZIfmtwlSw6xRyoSIkP2R/nqBvId/A40G+3VkebBIylKiJkRZdDtLo5pzlSaa/9quC17MtOdnTzES6Y/DWX4rKZVeJC/0y9VTN32BcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgRc5s+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15713C4CECC;
	Tue, 19 Nov 2024 03:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985451;
	bh=8UnIt6nf6xlNgw20k3rqUKdl+epAp0Ho80SLBcAHygQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YgRc5s+1hk8UrAiA9YpkiUisBj3YXqSWEoab1ujN/3Scj/17f5noFnouTbd1cTjZv
	 FhCUQG1w37JR/eIrCTWMhwDdx4tSHsY3dEPBloF9oIwR5UpRxnCrpI1Z69+ecbPzYf
	 gtaPmVA3bOGJ3QtN6gHTaxQwNcN7lDodFfAw4hZ+C1lQtaWK74Q3fwHdCG+orufoZB
	 kxOaSOMl2xPrTIr5RZS52CXHoOP8dZxQAGzsFKas2OPDEBuRNBUXnFNnrdj7cc0w5f
	 uCoNsYMaWnajB9DWP5P7bgb4wahVsOJIvNdl/wtxWw90f5GkdWsOAaXTShW9chNYSe
	 BFeiOnHNrnH9w==
Date: Mon, 18 Nov 2024 19:04:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Lars Povlsen"
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Russell King <linux@armlinux.org.uk>,
 <jacob.e.keller@intel.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v3 0/8] net: lan969x: add RGMII support
Message-ID: <20241118190410.4b576c45@kernel.org>
In-Reply-To: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
References: <20241118-sparx5-lan969x-switch-driver-4-v3-0-3cefee5e7e3a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 14:00:46 +0100 Daniel Machon wrote:
> This series is the fourth of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
> 
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
> 
>         1) Prepare the Sparx5 driver for lan969x (merged)
> 
>         2) Add support for lan969x (same basic features as Sparx5
>            provides excl. FDMA and VCAP, merged).
> 
>         3) Add lan969x VCAP functionality (merged).
> 
>     --> 4) Add RGMII support.  
> 
>         5) Add FDMA support.

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new drivers,
features, code refactoring and optimizations. We are currently accepting
bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


