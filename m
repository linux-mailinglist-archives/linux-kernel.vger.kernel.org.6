Return-Path: <linux-kernel+bounces-528685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D70A41A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDBF3AC178
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697A24C692;
	Mon, 24 Feb 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="niCjXbTi";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="UkjrEQil"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5D24A07C;
	Mon, 24 Feb 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392285; cv=none; b=ugtgZX16ZOjmaOFtDZD/7Sp8981KZBDzZs9mv2uasIu1cdcJ27A6asHYQZiASZLCq7ZD0j+fd/VMeJ7/Po397OffWmmlmdk+aMrL2JHXsLnZ2J+riUqleHYhKTHh/6qfpXGsie7V/vpnKk53BvMtiop28wF1vtTp7n6vsjIvEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392285; c=relaxed/simple;
	bh=Lwv+SdLlgCCVTrLfdebdm1ZrgIaYP0UgzwvumboP/Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6iGFTLhWyOp4ZJ8P2hvNGbG/aPHnn5OO4etjxbb1MXCRkyhYy6TU94q2Wk4pg4WSTBon77ua4ha9z+TVJmPLjipSub6Abtg4+QUr575zQiQE/OaACx3oQXmnL8/M1WjGVvZb0mesGu3tfvoAH0F1R+YjdvwPed5dTVydpYklKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=niCjXbTi; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=UkjrEQil; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 52D4D122FE23;
	Mon, 24 Feb 2025 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740392276; bh=Lwv+SdLlgCCVTrLfdebdm1ZrgIaYP0UgzwvumboP/Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niCjXbTievjPfp2HmOums4MrUOg/tOro7gx/TCt7XJ2cPvwaMrZykwcckHHr0zJuG
	 p9xSjwlq7D713ed9/6aXE4x6EDZ/ym1Z+pP7cVdK/zk1dRqMZjPbxnHAnRGtk3iotm
	 XAEkIJ0aQ/Qkfref1IT+bVBZZT0QbM7QCjp47jQXdoOvFjhUmqSYNbNEroo9E4MFV1
	 srPvEaBJ4dmpjRr5NJaaJazeMJREqJSZZILgGxjo/XY6fce5oAfHPdVVjLd08rSADt
	 cIog1Xr8aUwP6vVrE2pFBkQH1CM0xlFwVbmEDzo2T4PUeDFm3lafA1b9icW3CZr25S
	 BQ848tOhqzc+Q==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zq8oGhaoyk3h; Mon, 24 Feb 2025 02:17:54 -0800 (PST)
Received: from ketchup (unknown [183.217.80.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id D9D65122FE21;
	Mon, 24 Feb 2025 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1740392274; bh=Lwv+SdLlgCCVTrLfdebdm1ZrgIaYP0UgzwvumboP/Ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkjrEQilES+wAWOqAgIE+CWAGiRh2WE8Z77le9pWr5tgNy1pWWbTyvFrFuLig7CnF
	 dyklHRklhPKiGkBC4LE6uYN+Rl0kydApuUOx4z+Z7LJpzk2udQKSZbeIGhkNZwg0jy
	 9aDvewbfZHh8T4ZBHNmauBCB//kbGb41vZo9tvBDP8ob6o8J4J7cS/Q/o6GqPIP7Tk
	 DT5ea06zULyMSIjah2/ojuRxiDYZP9KzU6IgCNnGOpNy5JImavBQtP+Rl042DCMURl
	 qZyAc5btfGtkVngR4Qcf1rNwimx5rW5utOUyUm+S8G0DjcrYcxmmkpMkFs8No+GFT9
	 sBeXApdL2iOjQ==
Date: Mon, 24 Feb 2025 10:17:40 +0000
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
Message-ID: <Z7xHRAFE4-QEA6PO@ketchup>
References: <aw2vqnz5vcccqqvrrhz5tgawj7fnzzg3tds7nnepuorit37a7r@jcj3wrs7d73h>
 <Z6rdBhQ7s2ReOgBL@ketchup>
 <19e5129b-8423-4660-8e4f-8b898214d275@kernel.org>
 <Z63T_EDvXiuRQbvb@ketchup>
 <2ab715bd-e26c-41bb-ac64-baa864d90414@kernel.org>
 <Z7BTVu10EKHMqOnJ@ketchup>
 <7c697e9a-d6d9-4672-9738-93ce3a71beb6@riscstar.com>
 <4f7bf109-bf18-42be-971c-5d5edd9595b5@kernel.org>
 <Z7mrdrACFp3m-7sy@ketchup>
 <6ea8ac17-42c8-46fa-b970-77ba89de66c4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea8ac17-42c8-46fa-b970-77ba89de66c4@kernel.org>

On Sat, Feb 22, 2025 at 12:50:13PM +0100, Krzysztof Kozlowski wrote:
> On 22/02/2025 11:48, Haylen Chu wrote:
> > On Sat, Feb 22, 2025 at 10:59:09AM +0100, Krzysztof Kozlowski wrote:
> >> On 22/02/2025 00:40, Alex Elder wrote:
> >>> I have a general proposal on how to represent this, but I'd
> >>> like to know whether it makes sense.  It might be what Krzysztof
> >>> is suggesting, but in any case, I hope this representation would
> >>> work, because it could simplify the code, and compartmentalizes
> >>> things.
> >>>
> >>> Part of what motivates this is that I've been looking at the
> >>> downstream reset code this week.  It contains a large number of
> >>> register offset definitions identical to what's used for the
> >>> clock driver.  The reset driver uses exactly the same registers
> >>> as the clock driver does.  Downstream they are separate drivers,
> >>> but the clock driver exports a shared spinlock for both drivers
> >>> to use.
> >>>
> >>> These really need to be incorporated into the same driver for
> >>> upstream.
> >>
> >> Why? First, it is not related to the topic here at all. You can design
> >> drivers as you wish and still nothing to do with discussion about binding.
> >> Second, different subsystems justify different drivers and Linux handles
> >> this well already. No need for custom spinlock - regmap already does it.
> >>
> >>
> >>>
> >>> The clock code defines four distinct "units" (a term I'll use
> >>> from here on; there might be a better name):
> >>>    MPMU  Main Power Management Unit
> >>>    APMU  Application Power Management Unit
> >>>    APBC  APB Clock
> >>>    APBS  APB Spare
> >>>
> >>> The reset code defines some of those, but doesn't use APBS.
> >>> It also defines three more:
> >>>    APBC2 Another APB Clock
> >>>    RCPU  Real-time CPU?
> >>>    RCPU2 Another Real-time CPU
> >>>
> >>> Each of these "units" has a distinct I/O memory region that
> >>> contains registers that manage the clocks and reset signals.
> >>
> >> So there are children - mpmu, apmu, apbclock, apbspare, apbclock2, rcpu
> >> 1+2? But previous statements were saying these are intermixed?
> >>
> >> " I'll make APMU/MPMU act as a whole device"
> > 
> > My reply seems somehow misleading. The statement means I will merge the
> > children with the syscon into one devicetree node, which applies for
> > both APMU and MPMU. I wasn't going to say that APMU and MPMU are
> > intermixed.
> > 
> > As Alex said, all these units have their own distinct and separate MMIO
> > regions.
> > 
> >>>
> >>> I suggest a single "k1-clocks" device be created, which has
> >>
> >> For four devices? Or for one device?
> > 
> > By Alex's example, I think he means a device node taking all these
> > distinct MMIO regions as resource.
> 
> 
> You still do not answer about the hardware: how many devices is there?

In my understanding, the series covers four devices, APBC, APMU, MPMU
and APBS, each comes with its separate MMIO region and is clearly
described in the datasheet. I stated this in the later part of the
reply,

> > For APBC, MPMU, APBS and APMU, I'm pretty
> > sure they're standalone blocks with distinct and separate MMIO regions,
> > this could be confirmed by the address mapping[1].

Thus I don't agree on Alex's solution, since it creates fake devices not
mentioned by the datasheet (spacemit,k1-clocks and all its children in
the example devicetree).

> > 
> > 	clock {
> > 		compatible = "spacemit,k1-clocks";
> > 
> > 		reg = <0x0 0xc0880000 0x0 0x2050>,
> > 		      <0x0 0xc0888000 0x0 0x30>,
> > 		      <0x0 0xd4015000 0x0 0x1000>,
> > 		      <0x0 0xd4050000 0x0 0x209c>,
> > 		      <0x0 0xd4090000 0x0 0x1000>,
> > 		      <0x0 0xd4282800 0x0 0x400>,
> > 		      <0x0 0xf0610000 0x0 0x20>;
> > 		reg-names = "rcpu",
> > 			    "rcpu2",
> > 			    "apbc",
> > 			    "mpmu",
> > 			    "apbs",
> > 			    "apmu",
> > 			    "apbc2";
> > 
> > 		/* ... */
> > 	};
> > 
> >> No, it's again going to wrong direction. I already said:
> >>
> >> "You need to define what is the device here. Don't create fake nodes ust
> >> for your drivers. If registers are interleaved and manual says "this is
> >> block APMU/MPMU" then you have one device, so one node with 'reg'."
> >>
> >> So what is the device here? Can you people actually answer?
> >>
> > 
> > I'm not sure about the apbc2, rcpu and rcpu2 regions; they aren't
> > related to the thread, either. For APBC, MPMU, APBS and APMU, I'm pretty
> > sure they're standalone blocks with distinct and separate MMIO regions,
> > this could be confirmed by the address mapping[1].
> 
> They were brought here to discuss for some reason. Long discussions,
> long emails, unrelated topics like hardware or different devices - all
> this is not making it easier for me to understand.
>
> Best regards,
> Krzysztof

By the way, I made a summary on the hardware covered by this series in
one of my earlier reply[1]. Could you please comment further on my
proposal[2] according it, or pointing out anything that's unclear or
missing? It will be helpful for things to improve.

Thanks,
Haylen Chu

[1]: https://lore.kernel.org/all/Z7m2oNXbwJ06KtLQ@ketchup/
[2]: https://lore.kernel.org/all/Z7BTVu10EKHMqOnJ@ketchup/

