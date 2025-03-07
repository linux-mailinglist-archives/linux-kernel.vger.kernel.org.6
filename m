Return-Path: <linux-kernel+bounces-550659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B683DA5628A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E86176C48
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB221C6FF0;
	Fri,  7 Mar 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUy9Ewf3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8D1A5B86;
	Fri,  7 Mar 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336011; cv=none; b=VmsIhHSuEKT72J2mPRaIDzD9mBuP45jwQZE33K3de8KEl33JpeqYyxXJUXdL6mQpztSj5YLnelfrEGy9hBJnuTLYkR3yYQ/jG9QHk8TmXuJPhxdPK3ZCGRkGni/f8m/GXQztQDju/O6Frp93bGg3Nbp7vWDIm5/udm8sM3ze7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336011; c=relaxed/simple;
	bh=4g4KFVEllHF9Fzyk30OF0hRqc9JoCbYtjKmWSqDx7uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGQYf9xhm7QHkMBsENKsZN7UTVM7knXjnJ5Ngr+Q0S3mkzWK5cv6pOIKDfuKzw+AQoKvhonIHu0BTatiOOXKCTuvN4fabxCw7T84iPGNfQPY1uuk64RT46Fv9rSDHPOqBkd3rd6klWkuesGsP8Jk0yYZPOm/P/+r1B2ziySV+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUy9Ewf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78902C4CED1;
	Fri,  7 Mar 2025 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741336010;
	bh=4g4KFVEllHF9Fzyk30OF0hRqc9JoCbYtjKmWSqDx7uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUy9Ewf3tVuuvEuoi4JjxRnHfFDBBZ8agqsMeht/L3IHHDfmSNPi0UcsbLnezXZxm
	 gICDgiLTQMxGAwN2+xp1MhFsfCf5CnUY6LOjVJEHwxiKwbN8zbNrNTLCLSqt61c2wD
	 PF9YNGMMQ4DILHADeaTzVndOBQuO82CVSjjF4UJf6U6fmYzN53Hki4xhfMIbEKFs/X
	 BPR8yGXVrX6vXPSeSeDKo7eVscXnAgDTJ7d3DvqQlBkPSoU3bE1MsU9vh9ba0gMUqF
	 CWkvb8SPDaPFJb4sHYjPfNqslI17euLFM9qRWgBokn7/9AlaM0N6Aw8LQRhw806TZs
	 KrlUrV+tyxZmQ==
Date: Fri, 7 Mar 2025 09:26:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Haylen Chu <heylenay@4d2.org>
Cc: Yixun Lan <dlan@gentoo.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>, linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxdotw@foxmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <20250307-impossible-fine-panther-38c66b@krzk-bin>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-5-heylenay@4d2.org>
 <20250307005149-GYA66361@gentoo>
 <Z8qVOssDHaVDQmLY@ketchup>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8qVOssDHaVDQmLY@ketchup>

On Fri, Mar 07, 2025 at 06:42:02AM +0000, Haylen Chu wrote:
> > > +static int k1_ccu_probe(struct platform_device *pdev)
> > > +{
> > > +	struct regmap *base_regmap, *lock_regmap = NULL;
> > > +	struct device *dev = &pdev->dev;
> > > +	int ret;
> > > +
> > > +	base_regmap = device_node_to_regmap(dev->of_node);
> > > +	if (IS_ERR(base_regmap))
> > > +		return dev_err_probe(dev, PTR_ERR(base_regmap),
> > > +				     "failed to get regmap\n");
> > > +
> > > +	if (of_device_is_compatible(dev->of_node, "spacemit,k1-pll")) {
> > ..
> > > +		struct device_node *mpmu = of_parse_phandle(dev->of_node,
> > > +							    "spacemit,mpmu", 0);
> > > +		if (!mpmu)
> > > +			return dev_err_probe(dev, -ENODEV,
> > > +					     "Cannot parse MPMU region\n");
> > > +
> > > +		lock_regmap = device_node_to_regmap(mpmu);
> > > +		of_node_put(mpmu);
> > > +
> > you can simplify above with syscon_regmap_lookup_by_phandle(), which
> > would save a few lines
> > 
> > or further, just call syscon_regmap_lookup_by_compatible()? then
> > won't be necessary to introduce the "spacemit,mpmu" property..
> > 
> 
> These syscon_* functions differ a little from device_node_to_regmap():
> they get and enable the first item in "clocks" property when
> instantiating a regmap, which isn't desired for a clock controller.

Yes. And mpmu is not a syscon, so it would be inaccurate or even wrong
API to use.

Best regards,
Krzysztof


