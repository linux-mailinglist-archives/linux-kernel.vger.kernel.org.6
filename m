Return-Path: <linux-kernel+bounces-274788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3237A947CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13572820E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88413A884;
	Mon,  5 Aug 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEavpQ1B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114CC5339D;
	Mon,  5 Aug 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867715; cv=none; b=Uw9tm31DmVf2fOOM+5T4cZ9TZUEEI4ySB35DUL23+2G4SMQMk/pIm7WL94Jure1QpmdYyXf86s99nTUNJKVsvwJcfs9liwXWWaq0dqACHe3zQmqFYrTIB0MAzwt+1tMKtlVCx8TYUqYbQ4i7RGUC5AvfvRa4xpiVfDrOc9M7L/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867715; c=relaxed/simple;
	bh=hen2BAOote4ovnEFkZpQyYc/wpKosPIuJ6C+p6n+xZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NabiK9xhZ5FPZfw+v/b1kzxcNvlapE0CgEXE3efx/WG8ZAw7QwvPwK6dacho9mEhJlkNtDCEx54mL9LECzQdC2zzMRrKag6nVfFATWLwyde0lVMfCA4I8FvNup3acAKYDMQmU/w1O16Y8Q6HW7y+XJBOI14rmCCI5u1pNLh9E1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEavpQ1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7FBC32782;
	Mon,  5 Aug 2024 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722867714;
	bh=hen2BAOote4ovnEFkZpQyYc/wpKosPIuJ6C+p6n+xZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEavpQ1BjwqrHIFt/pEToIPtj3vmUU3xqVPzJ1rne0u8qoGXchczfZ1L84wxAjfqp
	 dtDQ+/iFydr0/BaaRHNQI7IFqgN8hjqli1CQGTvx2bWvuKAcYg9ao4nzswW63fgSB+
	 F7OxhjPDDmP9NJ6s/IU3oypuO7RsoxsVak4/ZQdbnbKVsqZmGS3x1H75G6BC3XqpGR
	 9IHzMqxUu7yYDogZpR5jAjnRoJ/iMPEChECnVZveV++MOSD6z+WnffKl1qM5p6JxgH
	 yg4A1EDC1dI1Vr+vPV1mJ7f5SHKvbGL0SouRZ83CoZs74i1h3zzwemvej3lUkplmy9
	 xYxOO4D64MmbQ==
Date: Mon, 5 Aug 2024 15:21:49 +0100
From: Lee Jones <lee@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 0/5] regulator: Fix AXP717 PMIC support
Message-ID: <20240805142149.GD1019230@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <CAGb2v64DLez_FwH=Na=swQ30BdZa8JPaueFkM=ozjU56=f1DXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v64DLez_FwH=Na=swQ30BdZa8JPaueFkM=ozjU56=f1DXQ@mail.gmail.com>

On Thu, 01 Aug 2024, Chen-Yu Tsai wrote:

> Hi,
> 
> On Thu, Apr 18, 2024 at 8:07 AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > This is v2 of the fixes to the AXP717 PMIC support series. Lee put the
> > original patches in an immutable branch already, so these here go on top.
> > Patch 1 is new in v2, and adds the IRQ status and acknowledge registers
> > to the writable range. Thanks to Chris for pointing this out.
> > Patch 2 contains fixes to the regulator descriptions: the LDOs had the
> > wrong supply source, and two numbers were wrong. The datasheet describes
> > the voltage ranges and register values differently from what our macros
> > expect, in a way that literally begs for off-by-ones, so here you go.
> > Also there is an actual wrong number in the datasheet, add a comment to
> > document this.
> > I don't know if that's still feasible, but those two patches would be a
> > good candidate to squash into the patches that they fix.
> >
> > The other three patches add the "boost" regulator, which is meant to
> > provide the 5V USB VBUS power when operating from the battery. It's the
> > usual trinity of binding/mfd/regulator patches.
> > Again this could be squashed into the respective patches from the
> > original series, if people agree.
> >
> > Please have a look and test!
> >
> > Based on mfd/ib-mfd-regulator-6.10, as detailed below.
> >
> > Cheers,
> > Andre
> >
> > Changelog v1 .. v2:
> > - add tags
> > - add patch to add missing IRQ ack register range
> > - add comment to document bug in datasheet
> >
> > Andre Przywara (5):
> >   mfd: axp20x: AXP717: Fix missing IRQ status registers range
> >   regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
> >   dt-bindings: mfd: x-powers,axp152: add boost regulator
> >   mfd: axp20x: AXP717: Add support for boost regulator
> >   regulator: axp20x: AXP717: Add boost regulator
> 
> The latter three patches still haven't been merged.
> 
> Andre, can you resend them for Lee or Mark to merge? Otherwise I
> can't take the RG35XXSP DT patches.

Right, please rebase and resubmit.  I've lost all context now.

-- 
Lee Jones [李琼斯]

