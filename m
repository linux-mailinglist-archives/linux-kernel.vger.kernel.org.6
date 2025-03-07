Return-Path: <linux-kernel+bounces-550655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB0A56280
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E0189729C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B041B4240;
	Fri,  7 Mar 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/Mz7WNU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04384A2B;
	Fri,  7 Mar 2025 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335634; cv=none; b=rqUmyTs9f39F/RbZyw6OJCZYW3FZMTyDzNXjj7L/ASbRjHxLiNYf0fGUHBx8nNbEk28nR6ueCOTrxgeBR4e9qVKcVM6nr4pWPmo9pVnMD64nT/Ld9CjeKe7b7lrX9LtKxW152j8nfMqv9RmT9eeCZg3BSNaNkUbTK4b8zI/7LHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335634; c=relaxed/simple;
	bh=oVm6oRCCgzBMQKbkDLj8w69l734KJkAdES1OKCD4igk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mcmw8mgZFewNcV3A8wqOrROwE7LqNA6TRdjmA9k9HALobhGUiS04i6T6o3V2Q6fi0mmlz1itC1KqiJfJE0CzR/fM/xw04pVKIHH6g8+N8HxZXMnFpmKczqjKCDJP8uKlffl9MxHkGQPUMQpu+P6eIF1X+qOGAafx3LEtUl9bcgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/Mz7WNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2A3C4CED1;
	Fri,  7 Mar 2025 08:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741335633;
	bh=oVm6oRCCgzBMQKbkDLj8w69l734KJkAdES1OKCD4igk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/Mz7WNUDOZ1u5k0Wuo5/k21xfyiEhb/Cjpfb27pbxbYX1EbvCHMAplOU3mkboTUZ
	 2XMVL+8aOp05AdPnRfld+3CH6QgZqctsozW7o2Jf3tV9QF0kvlmZadAaqjPhMiwjPS
	 Nl4TEfepZbaPrq+kHW+gXnXDDKQh9CfmlXR16NPvrMI2Yt3TjkrkdR6BDL+PES94Sv
	 yXW0cG5V7Yjdobw9AvBqgFPE41ipjurPpmCBrSshGI1cNL2JKYQhX4o6zjqdKKD6RX
	 kYoYwiG5jZ9r6EHt1yrzis5Yql/ypJLoC4/QSIAM0F0LPMou5shfp6UDZ4dtPubwlR
	 WgwN+bAnFwPdQ==
Date: Fri, 7 Mar 2025 09:20:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: Yixun Lan <dlan@gentoo.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>, linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxdotw@foxmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: clock: spacemit: Add spacemit,k1-pll
Message-ID: <20250307-juicy-grasshopper-of-enthusiasm-9bfb15@krzk-bin>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-4-heylenay@4d2.org>
 <20250307002943-GYA64516@gentoo>
 <Z8qTh1zRJTjYNCtz@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8qTh1zRJTjYNCtz@ketchup>

On Fri, Mar 07, 2025 at 06:34:47AM +0000, Haylen Chu wrote:
> > > +properties:
> > > +  compatible:
> > > +    const: spacemit,k1-pll
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description: External 24MHz oscillator
> > > +
> > > +  spacemit,mpmu:
> > how about naming it as "spacemit,mpmu-syscon" explicitly?
> > to indicate this is a syscon phandle, it's more readable
> 
> It's okay but I'm not sure whether this helps a lot... will wait for the
> maintainer to decide the name.

Can mpmu be not a syscon phandle? And what exactly means "syscon" here
that it brings additional information?

Best regards,
Krzysztof


