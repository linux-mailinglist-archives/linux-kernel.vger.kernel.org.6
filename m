Return-Path: <linux-kernel+bounces-214511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323659085CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B591C21F90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4D1836C7;
	Fri, 14 Jun 2024 08:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3fsTfIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952737318A;
	Fri, 14 Jun 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352751; cv=none; b=UMzu/uYE7gMPxe915XFlX80a9x/9/jh1R6l0GmnUGBku/vgx45SRN8lz2b/S1mQUjDQp0eIAmXm254RlG4V/RHoqXxgLjqCFFINffAlkeSwGxKh1OSyKUmBH/bEbbBoCtzeY0V+c+QVGvKccWMUE9p8uoSN5RqM7tYUNFT75m3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352751; c=relaxed/simple;
	bh=tX718joJyIE6B+wV6r1BSs0uMJZFD+gOUjigSrolFiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLaNDi59IWMbbGCFiR3V3aGZXSzH431ISS8AHyW8XAG8Z4qRo2RlNDdi3HCA4nIyDKRhJnYP+ZUFcPqJFzbU8j8GAjB213Hnhu6APA+Z9VRqCMdqPDK7GqITsAqui2hmgDUicoKw8AQIu1TBaFsuapBbau444iaO4bmispgQ6cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3fsTfIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B34CC2BD10;
	Fri, 14 Jun 2024 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718352750;
	bh=tX718joJyIE6B+wV6r1BSs0uMJZFD+gOUjigSrolFiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3fsTfIvzWfbjqgMWimZHz75wRji/1p+IJN4Uta/5jtv3SIeuWh2de3Ff4Y+MAC0T
	 NBMI+3DPozioudUgj0jlSWM+nPk7alc/rELse2FejAns9ESLW4u4OQE4JAgvxPalcm
	 cfxwqnpt1ehFW+O+aRZra8342KQZ/J/c74Z2r5sv98qTgcC+uq1uypK+TKNbegUrVO
	 Z6aQKhQfgFXzbrLaEljBoOH7SuPv2mIwmSo7ZslgOlbzucv97viCU9PrcykJUpqhq9
	 +b9P99z8ZmrNY3pGqkNld8EnhTh13xB1kxOjLU1ZGCErelU076sgl5UdhpxhSJa12F
	 WQhSAZhHeqMiw==
Date: Fri, 14 Jun 2024 09:12:24 +0100
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
Subject: Re: [PATCH v2 2/5] regulator: axp20x: AXP717: fix LDO supply rails
 and off-by-ones
Message-ID: <20240614081224.GD2561462@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-3-andre.przywara@arm.com>
 <f685b49a-36b1-46c9-a0a3-734bca8bd968@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f685b49a-36b1-46c9-a0a3-734bca8bd968@arm.com>

On Wed, 12 Jun 2024, Andre Przywara wrote:

> Hi Broonie,
> 
> On 18/04/2024 01:07, Andre Przywara wrote:
> > The X-Powers AXP717 PMIC has separate input supply pins for each group
> > of LDOs, so they are not all using the same DCDC1 input, as described
> > currently.
> > 
> > Replace the "supply" member of each LDO description with the respective
> > group supply name, so that the supply dependencies can be correctly
> > described in the devicetree.
> > 
> > Also fix two off-by-ones in the regulator macros, after some double
> > checking the numbers against the datasheet. This uncovered a bug in the
> > datasheet: add a comment to document this.
> > 
> > Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Can you please take (at least) this one patch as a fix for 6.10? Applies
> cleanly on top of v6.10-rc3. The changes are not super-critical, but worth
> fixing nevertheless.

FWIW, I have no idea what's going on with this set now.

Once all of the necessary patches have been expedited, please gather
together what's left and I'll take them via MFD.

-- 
Lee Jones [李琼斯]

