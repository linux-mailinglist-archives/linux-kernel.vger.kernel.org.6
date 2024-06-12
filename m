Return-Path: <linux-kernel+bounces-211815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE704905756
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D20CB26DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF462180A6C;
	Wed, 12 Jun 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUoEHlHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8717C7C8;
	Wed, 12 Jun 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207303; cv=none; b=bnuOSKhKFDCemBXUCMllHnyj6oIuzqn/ix0PUR0xERqMjcyEYMf5uO+nC7pvdAi0g2DB3AqVn8DDkmAa+8pm60XVVMJuynFVdT/F7CMUWUbhE1BKWPl7/xVeQsaYukL6qmycPAFNTEKrpX1YtvR0Na/ouC6WZ8PhqFSQh5Isdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207303; c=relaxed/simple;
	bh=+7dgCMAE8xXP+L3ANBWO9tjojn+ydsIoH8bkB9Y/hl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2eeqcuRL1L17jiBrCpNp5g8HIho98O/p99fGZP8+RK/yybjofOVwcvRY89QBUZnrWQPbN5dG6KdsZb54lyUFpdlzjyFoUKx0We0yosaad49CPERkIaPIsfEhu4XXSjo9Il4LyFTRLFReBSdBFmRo5suo/ltGWHDTz+Oy7kLraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUoEHlHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14137C116B1;
	Wed, 12 Jun 2024 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207302;
	bh=+7dgCMAE8xXP+L3ANBWO9tjojn+ydsIoH8bkB9Y/hl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUoEHlHKTw5SY/PsFRy8BXdFLVNotLH7+Y0aYLHpuXxwKr8kdciwjPmVIP6d+k5wP
	 hYFaetN8ddefpaQIiEdi8hNpYWMRSZkCQX3rZa7/sA/WYbeoKDiBtHbQusF4I8mbm+
	 385Gqc0wc9u1/RmHSyf+fvac0YfcmoGz8tVW3zwmJnYcFxJYhzBpK70FeYe4sA9ONN
	 8k8RcPuApOOZNBas84sRHCZ5UOYna7nLs0BPv1zNOowrOTSQ0Z4H9+bCKstTfPAM6p
	 pOGg/SlEVU+/YiBhKeg2is8TWNY9RQiZLfmAlQn7ZDvgM7xdXnUpg0HBpa/Mi05HKr
	 c6aYUD9b6Dmpg==
Date: Wed, 12 Jun 2024 16:48:17 +0100
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 1/5] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
Message-ID: <20240612154817.GH1504919@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-2-andre.przywara@arm.com>
 <20240502093907.GM5338@google.com>
 <56aef347-7582-497e-be02-d82eda7b3528@arm.com>
 <20240612152510.GE1504919@google.com>
 <7fdc23ff-fd55-4347-ac61-dd115eff6ff1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fdc23ff-fd55-4347-ac61-dd115eff6ff1@arm.com>

On Wed, 12 Jun 2024, Andre Przywara wrote:

> Hi,
> 
> On 12/06/2024 16:25, Lee Jones wrote:
> > On Wed, 12 Jun 2024, Andre Przywara wrote:
> > 
> > > Hi Lee,
> > > 
> > > On 02/05/2024 10:39, Lee Jones wrote:
> > > > On Thu, 18 Apr 2024, Andre Przywara wrote:
> > > > 
> > > > > While we list the "IRQ status *and acknowledge*" registers as volatile,
> > > > > they are missing from the writable range array, so acknowledging any
> > > > > interrupts was met with an -EIO error.
> > > > > 
> > > > > Add the five registers that hold those bits to the writable array.
> > > > > 
> > > > > Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
> > > > > Reported-by: Chris Morgan <macromorgan@hotmail.com>
> > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > > ---
> > > > >    drivers/mfd/axp20x.c | 1 +
> > > > >    1 file changed, 1 insertion(+)
> > > > 
> > > > Acked-by: Lee Jones <lee@kernel.org>
> > > 
> > > Can you please take just this patch as a fix for 6.10? This fixes the power
> > > key operation.
> > > This applies cleanly on top of v6.10-rc3, so there is no need for any extra
> > > immutable branch or coordination with regulator.
> > > (The same is true independently for patch 2/5, on the regulator side).
> > 
> > What does the Fixes: commit break?
> > 
> > Or is it the case that it never worked properly?
> 
> The interrupt part never worked properly, but so far that's only needed for
> the power key operation. Unfortunately that part wasn't tested properly
> initially, so the patches were merged into your tree before that.

This doesn't sounds like a -fixes candidate.  I'll mark the set for v6.11.

-- 
Lee Jones [李琼斯]

