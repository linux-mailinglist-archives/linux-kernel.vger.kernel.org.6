Return-Path: <linux-kernel+bounces-211785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3DF9056C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81112B2362A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D1D17F392;
	Wed, 12 Jun 2024 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0Y1Yd3s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE317F504;
	Wed, 12 Jun 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718205916; cv=none; b=g6kwX07iL5cEnmQeNEClJuIaqntpyQp7B+Y0ubWRJ5wlZXbJ4vu17RnGh0Sb8g9nfeb0aNKaU0mvg3y6SHsyp1Fq7SrhUgwyS1iWfc+nxhKzrZ67PcHwWIxuiaeIObV+gcP6TqNtBOn/kVWd/cckfR91/9KpQWB7p4Mhyd7hA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718205916; c=relaxed/simple;
	bh=ZUjo3FL1LCdGSIPPmkJ/6gP5dCY2FOu4qlSrdDKhcos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJX5lTnZfpDKaK1YaPRStuagR8HkZnKzbv1xAVsnqFCKtORNv+vSaKsb3aTCjnzR/n7le5E5mKivLwCT0EFu3ff8UV/nJY6IuVOyVeRBBnYQrmzo2WJvRKIm/qvuZ/va/fa83f/ArbUVgBuQ2s4ZKZeadbQSaPbhakZstTLxT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0Y1Yd3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C0AC116B1;
	Wed, 12 Jun 2024 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718205915;
	bh=ZUjo3FL1LCdGSIPPmkJ/6gP5dCY2FOu4qlSrdDKhcos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G0Y1Yd3s3I2J3XTgOcsz/umRnlQZUS9QKRpUVqKHBt2++uCccgow+ooF11DFcyx4E
	 1bWdq68DZRo4cvCLQoT7ythsvGCCr4ZBfC9YGljBQ6lEWfRyXqeVK/Nwqj9wApm45Q
	 1mDyNoMdzfF5iYEYKuWlDGJJNUypKc/tIh9Q6uavij5I6uXlhgWvqvSSY2X2qcFj5i
	 IwgOenALmO5MX6/ncRQU6yKv+KXa/AX6uWAXLwRRucOrYB3WiVhQa62ccpfwksM/p3
	 Oodx1ZGfAaU5B7/Tgd4xbZOZm2oST/IYIeqV8KRpbruuT5pqI6xnkWXD85enaiAmDO
	 hkrOY9CqWA9lg==
Date: Wed, 12 Jun 2024 16:25:10 +0100
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
Message-ID: <20240612152510.GE1504919@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-2-andre.przywara@arm.com>
 <20240502093907.GM5338@google.com>
 <56aef347-7582-497e-be02-d82eda7b3528@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56aef347-7582-497e-be02-d82eda7b3528@arm.com>

On Wed, 12 Jun 2024, Andre Przywara wrote:

> Hi Lee,
> 
> On 02/05/2024 10:39, Lee Jones wrote:
> > On Thu, 18 Apr 2024, Andre Przywara wrote:
> > 
> > > While we list the "IRQ status *and acknowledge*" registers as volatile,
> > > they are missing from the writable range array, so acknowledging any
> > > interrupts was met with an -EIO error.
> > > 
> > > Add the five registers that hold those bits to the writable array.
> > > 
> > > Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
> > > Reported-by: Chris Morgan <macromorgan@hotmail.com>
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >   drivers/mfd/axp20x.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > 
> > Acked-by: Lee Jones <lee@kernel.org>
> 
> Can you please take just this patch as a fix for 6.10? This fixes the power
> key operation.
> This applies cleanly on top of v6.10-rc3, so there is no need for any extra
> immutable branch or coordination with regulator.
> (The same is true independently for patch 2/5, on the regulator side).

What does the Fixes: commit break?

Or is it the case that it never worked properly?

-- 
Lee Jones [李琼斯]

