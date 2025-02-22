Return-Path: <linux-kernel+bounces-527120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1CEA4079D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB4A4251EE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A020896C;
	Sat, 22 Feb 2025 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="HzjEUkHq";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="0xpAi6Of"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23F16F0FE;
	Sat, 22 Feb 2025 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221326; cv=none; b=UVFCGdcBMVdRKsAmSVNoDDHBL7hMpZnfzNdrJm30PGGmKHYfd7ch5FtlJTJfGHjfOux4flWH3ugBJdjpdodH1PuzRx5k3y62ezEC5PvTmpyBjJOLdnOHzYLbMoLz1NDCBbReTpzCtwhXRml9ZL/WPWHzWq9+KfnrEkebFKLqKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221326; c=relaxed/simple;
	bh=K6Nyh2RaPue8OIU5uYXZtZdm/qdGvXvMpPEc6QdZmgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlZjUw/DADfyuYmlxajZu6t48Oc2Kpr37vm6T0hp6wYEvzl2tn3FK3HP0dg0PxtIJd10N9dwFNJ3Mx5QD5P9rV9caXBWlDG1ky9bYv56udWAE4nFT34oEa+pJfPDeH3Na4fPgosYYiqT9659sMr2WUZeKBDQzjDszexJoZqYHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=HzjEUkHq; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=0xpAi6Of; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 9C190122FE22;
	Sat, 22 Feb 2025 02:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740221322; bh=K6Nyh2RaPue8OIU5uYXZtZdm/qdGvXvMpPEc6QdZmgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzjEUkHqYogZ4w4yPtviWueYx3hvNn9UNpccS9i/tP9tyGV1Z4Qww4PGQxXBhYLmn
	 OuFgUUK7Tr3rTe9gF7sYohMdKKmUZoqQNn25sxgGu8kLYsaoRj2A7YYOFXErvmJUfF
	 AQbUm+Ory1Et5e/yiqd2y+eIZOe+ZloZsNqAEiELT/myB/Ze8bKM9kl9IkZhdY1wQg
	 jdv5p0krxErHwv8215mOwWfAP/p8co//eXlbtH1H2ecY9XuI3O0WnLAffPiJOal3MA
	 WHErU5lEI0Mu8qH77YSYQ0O1vja2q+lF9heApJY1FjZDt2DkiF21iVsHelrWtq48DY
	 SoZIfYI1NO9Zg==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iDt5bERNoadS; Sat, 22 Feb 2025 02:48:36 -0800 (PST)
Received: from ketchup (unknown [183.217.80.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 197FE122FE21;
	Sat, 22 Feb 2025 02:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740221316; bh=K6Nyh2RaPue8OIU5uYXZtZdm/qdGvXvMpPEc6QdZmgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0xpAi6Of6hQKz9iujbvRVBr3slZR+xJVJAu0zPYmyLnY7SzjI1s7DSDt7gOjoGho7
	 YDJiMQZoRd/yVZQeHZhFeY8PuDcK8bhtqjE3IU6NoYh3Cz42WuhCFxIi+Bv10Ace1l
	 hw5MxLUb3rm9RWOd3WL8bZ5Rxe2OM4F+1x9mb5iyCVN5iyjkNe/JqoRYgA3sQ0I1dR
	 2cwbR/RHg/w5We67fqS3fkxegj2WMvyNzEYGWuEf3od5VzhTe0tSrqxFSwYaAul6Jn
	 jKzbI9RjkJsfrtrvzdtX9xIvutwypw/i6w8XGuimC7ey7T7oi2rG8R808ZbKR2GFXi
	 lxTxErqCfPQ6w==
Date: Sat, 22 Feb 2025 10:48:22 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Alex Elder <elder@riscstar.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: soc: spacemit: Add spacemit,k1-syscon
Message-ID: <Z7mrdrACFp3m-7sy@ketchup>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-4-heylenay@4d2.org>
 <aw2vqnz5vcccqqvrrhz5tgawj7fnzzg3tds7nnepuorit37a7r@jcj3wrs7d73h>
 <Z6rdBhQ7s2ReOgBL@ketchup>
 <19e5129b-8423-4660-8e4f-8b898214d275@kernel.org>
 <Z63T_EDvXiuRQbvb@ketchup>
 <2ab715bd-e26c-41bb-ac64-baa864d90414@kernel.org>
 <Z7BTVu10EKHMqOnJ@ketchup>
 <7c697e9a-d6d9-4672-9738-93ce3a71beb6@riscstar.com>
 <4f7bf109-bf18-42be-971c-5d5edd9595b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7bf109-bf18-42be-971c-5d5edd9595b5@kernel.org>

On Sat, Feb 22, 2025 at 10:59:09AM +0100, Krzysztof Kozlowski wrote:
> On 22/02/2025 00:40, Alex Elder wrote:
> > I have a general proposal on how to represent this, but I'd
> > like to know whether it makes sense.  It might be what Krzysztof
> > is suggesting, but in any case, I hope this representation would
> > work, because it could simplify the code, and compartmentalizes
> > things.
> > 
> > Part of what motivates this is that I've been looking at the
> > downstream reset code this week.  It contains a large number of
> > register offset definitions identical to what's used for the
> > clock driver.  The reset driver uses exactly the same registers
> > as the clock driver does.  Downstream they are separate drivers,
> > but the clock driver exports a shared spinlock for both drivers
> > to use.
> > 
> > These really need to be incorporated into the same driver for
> > upstream.
> 
> Why? First, it is not related to the topic here at all. You can design
> drivers as you wish and still nothing to do with discussion about binding.
> Second, different subsystems justify different drivers and Linux handles
> this well already. No need for custom spinlock - regmap already does it.
> 
> 
> > 
> > The clock code defines four distinct "units" (a term I'll use
> > from here on; there might be a better name):
> >    MPMU  Main Power Management Unit
> >    APMU  Application Power Management Unit
> >    APBC  APB Clock
> >    APBS  APB Spare
> > 
> > The reset code defines some of those, but doesn't use APBS.
> > It also defines three more:
> >    APBC2 Another APB Clock
> >    RCPU  Real-time CPU?
> >    RCPU2 Another Real-time CPU
> > 
> > Each of these "units" has a distinct I/O memory region that
> > contains registers that manage the clocks and reset signals.
> 
> So there are children - mpmu, apmu, apbclock, apbspare, apbclock2, rcpu
> 1+2? But previous statements were saying these are intermixed?
> 
> " I'll make APMU/MPMU act as a whole device"

My reply seems somehow misleading. The statement means I will merge the
children with the syscon into one devicetree node, which applies for
both APMU and MPMU. I wasn't going to say that APMU and MPMU are
intermixed.

As Alex said, all these units have their own distinct and separate MMIO
regions.

> > 
> > I suggest a single "k1-clocks" device be created, which has
> 
> For four devices? Or for one device?

By Alex's example, I think he means a device node taking all these
distinct MMIO regions as resource.

	clock {
		compatible = "spacemit,k1-clocks";

		reg = <0x0 0xc0880000 0x0 0x2050>,
		      <0x0 0xc0888000 0x0 0x30>,
		      <0x0 0xd4015000 0x0 0x1000>,
		      <0x0 0xd4050000 0x0 0x209c>,
		      <0x0 0xd4090000 0x0 0x1000>,
		      <0x0 0xd4282800 0x0 0x400>,
		      <0x0 0xf0610000 0x0 0x20>;
		reg-names = "rcpu",
			    "rcpu2",
			    "apbc",
			    "mpmu",
			    "apbs",
			    "apmu",
			    "apbc2";

		/* ... */
	};

> No, it's again going to wrong direction. I already said:
> 
> "You need to define what is the device here. Don't create fake nodes ust
> for your drivers. If registers are interleaved and manual says "this is
> block APMU/MPMU" then you have one device, so one node with 'reg'."
> 
> So what is the device here? Can you people actually answer?
> 

I'm not sure about the apbc2, rcpu and rcpu2 regions; they aren't
related to the thread, either. For APBC, MPMU, APBS and APMU, I'm pretty
sure they're standalone blocks with distinct and separate MMIO regions,
this could be confirmed by the address mapping[1].

> 
> > access to all of the I/O address ranges.  And then within
> > the DT node for that device there is a sub-node for the
> 
> Uh, confusing. You said there is one device for all the clocks, so if
> there is one device so also one device node. No children.
> 
> Maybe you have more devices but none of you is explaining the hardware
> that way. Mixing talk about drivers is really not helping.
> 
>
> 
> 
> Best regards,
> Krzysztof

Best regards,
Haylen Chu

[1]: https://developer.spacemit.com/documentation?token=LzJyw97BCipK1dkUygrcbT0NnMg

