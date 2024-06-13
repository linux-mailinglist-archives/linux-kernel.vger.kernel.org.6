Return-Path: <linux-kernel+bounces-213169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED94906E47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB721C210A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAC146A6F;
	Thu, 13 Jun 2024 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHcmG3o3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAD714659E;
	Thu, 13 Jun 2024 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280267; cv=none; b=LjZaaGxim17a+OpgILSyI+a7LVmfpJs7N5vkEsx8YiOOf5B+RcHXWs3ZyLAvvr1huj3SjP4wEB701iaP+KnU262Un3xwM2dwwUj8bC2fkdCaMbptQuchLgq7lQ4QJ9FQgLNpaa1O782AVjQkDzqoshPl+EWfK9o+dencUQopCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280267; c=relaxed/simple;
	bh=FeKv081F4ryjfkLhJLQQcMa4OiwLi8c45XnRk6gnceA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSqnaCIjbep9YWJO2eF/JH4yW4DC/qpwOvhHSUZxw5caqpANmGCu9m+cMFmONuCPydqCbXTtNtWdzXZ5gMUuxLsb1GhvMcZVjHZklB2tLNrzcvmlJWeBrG3N8F0KvIU2lIEF+K++lznaAhKmsXM1gAQ8Ay07OgwuKWSf3h2dgps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHcmG3o3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03ADC4AF1A;
	Thu, 13 Jun 2024 12:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718280266;
	bh=FeKv081F4ryjfkLhJLQQcMa4OiwLi8c45XnRk6gnceA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHcmG3o3Ae4kxCS7Qji7JK4J5MToPvmI6f+fy47XcIFafwVOyqvG5eSDGEl0nHcPH
	 tW+zNxcr55Qm3cLJcTiX5fOJb/nVF5Iys9qekUYNYocqlkoAiFdQPjMAVhIv/7t3hQ
	 Sj58yWpmkg9N4JNz3Ry0PY6gyazKtuj697ZdZpvJivmqwfSwevUlnpRECs/SrpvZ6d
	 dA7QoYX2KSDVzlEW4iDcAAf6G05h52vI/9LJOYwRNz7u7h6Bs0NOKvJsji7je2d+td
	 Q2Afo0MiFgk1ZOxVPPoBi6UlxN3FM4nbB+k4Y/b04kQ3NyNwp/yHjwNp0/ozV3pQz3
	 OaOBftj/DrykA==
Date: Thu, 13 Jun 2024 13:04:20 +0100
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
	Chris Morgan <macroalpha82@gmail.com>,
	Philippe Simons <simons.philippe@gmail.com>
Subject: Re: [PATCH v2 1/5] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
Message-ID: <20240613120420.GO1504919@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-2-andre.przywara@arm.com>
 <20240502093907.GM5338@google.com>
 <56aef347-7582-497e-be02-d82eda7b3528@arm.com>
 <20240612152510.GE1504919@google.com>
 <7fdc23ff-fd55-4347-ac61-dd115eff6ff1@arm.com>
 <20240612154817.GH1504919@google.com>
 <8a968327-131d-40f1-b6e2-effe1390ef70@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a968327-131d-40f1-b6e2-effe1390ef70@arm.com>

On Thu, 13 Jun 2024, Andre Przywara wrote:

> Hi Lee,
> 
> On 12/06/2024 16:48, Lee Jones wrote:
> > On Wed, 12 Jun 2024, Andre Przywara wrote:
> > 
> > > Hi,
> > > 
> > > On 12/06/2024 16:25, Lee Jones wrote:
> > > > On Wed, 12 Jun 2024, Andre Przywara wrote:
> > > > 
> > > > > Hi Lee,
> > > > > 
> > > > > On 02/05/2024 10:39, Lee Jones wrote:
> > > > > > On Thu, 18 Apr 2024, Andre Przywara wrote:
> > > > > > 
> > > > > > > While we list the "IRQ status *and acknowledge*" registers as volatile,
> > > > > > > they are missing from the writable range array, so acknowledging any
> > > > > > > interrupts was met with an -EIO error.
> > > > > > > 
> > > > > > > Add the five registers that hold those bits to the writable array.
> > > > > > > 
> > > > > > > Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
> > > > > > > Reported-by: Chris Morgan <macromorgan@hotmail.com>
> > > > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > > > > ---
> > > > > > >     drivers/mfd/axp20x.c | 1 +
> > > > > > >     1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > Acked-by: Lee Jones <lee@kernel.org>
> > > > > 
> > > > > Can you please take just this patch as a fix for 6.10? This fixes the power
> > > > > key operation.
> > > > > This applies cleanly on top of v6.10-rc3, so there is no need for any extra
> > > > > immutable branch or coordination with regulator.
> > > > > (The same is true independently for patch 2/5, on the regulator side).
> > > > 
> > > > What does the Fixes: commit break?
> > > > 
> > > > Or is it the case that it never worked properly?
> > > 
> > > The interrupt part never worked properly, but so far that's only needed for
> > > the power key operation. Unfortunately that part wasn't tested properly
> > > initially, so the patches were merged into your tree before that.
> > 
> > This doesn't sounds like a -fixes candidate.  I'll mark the set for v6.11.
> 
> Sorry, correction, this patch missing is actually fatal now, since we have
> an interrupt connected in the DT (which wasn't there initially). The code
> tries to clear all IRQs upon driver probe, which fails due to regmap
> error-ing out. This makes the whole driver fail probing, and since the AXP
> supplies basically every peripheral, the system is dead in the water:
> 
> [    1.173014] sunxi-rsb 7083000.rsb: RSB running at 3000000 Hz
> [    1.174996] axp20x-rsb sunxi-rsb-3a3: AXP20x variant AXP717 found
> [    1.198931] axp20x-rsb sunxi-rsb-3a3: Failed to ack 0x49: -5
> [    1.220878] axp20x-rsb sunxi-rsb-3a3: failed to add irq chip: -5
> [    1.235760] axp20x-rsb sunxi-rsb-3a3:
> 
> (Thanks to loki666@IRC for providing the log!)
> 
> This was discovered early, long before the merge window, and I was actually
> hoping to have this patch squashed into the original series still, but there
> was this immutable branch already.
> 
> So can you please take this as a fix for 6.10?

Please draft a new patch (the diff is likely to be the same) with an
updated commit message describing the new problem and why it's required
for -fixes.  I'll then submit it to Linus.

-- 
Lee Jones [李琼斯]

