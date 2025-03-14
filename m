Return-Path: <linux-kernel+bounces-560891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E48DA60AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763D4189F62F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C31B1624D5;
	Fri, 14 Mar 2025 08:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip2N1VrF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CD2AD25;
	Fri, 14 Mar 2025 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939228; cv=none; b=aZedHSsmFdf9gzMvwlP6P0EsZX6tbdaJzR9232XOFUQH+Pf3C7Q+9UW04kBglPi0qoRbuH6D6X0WZ/E2p5i/sHURFImkxiHi8gLohpoJTrEVIqCZSRB9q7X2hX74vGB3LXz7M4IYsT6rzOVPK+GnzDFaNFwDdf9TRnN1stu3k7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939228; c=relaxed/simple;
	bh=7U8GExGUpIrRj21vxo50VT57HSCBjO9buljApi9E9Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwpsqYT1N85Ybhrl7BH+xYd+ZV0ckG+ngwUPTsVnWA8ZsP9T1k/dMxtrpTrahB0ipyZo/8ny0+egLD/GvUVDOMYV4gHp8diQKOXO2EMyjXK5lVtkci77jrqY8zm/Fslhz/EIFuSRWnJKXYl7ptwVuZdo6EaLNDTuoENZOr9+z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip2N1VrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233A8C4CEE5;
	Fri, 14 Mar 2025 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741939228;
	bh=7U8GExGUpIrRj21vxo50VT57HSCBjO9buljApi9E9Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ip2N1VrFv07pJUN826d9NhByxmZDPrULXITjASJ0+CdknlGXT8HPiuJYW5W5mhFjW
	 8DXTYNA8XDKNPHhZNPMTkkE0OxZUvRg7+maUvfhffmOtxKhEYZUu62RqORGVw78zjz
	 tMKrODkyUaf2MtiMqJXC6G0gV21xjC0VXhLwZConcNmX3V4IZtYhd6QnVc9ty/re4+
	 1MCX5njrIslpGQJQMTxEXLS8wlQvg83vCznIa/XoJXsuPIqUxKuXW5bvwMqGr+AdXN
	 rIf5xtkEgwwHw19Zqq6KfjyIvtwy2vtYNvjx1jAuC8ghCvsZA3mjpFNvdrsA/lAaax
	 FIlOLUOKscRrA==
Date: Fri, 14 Mar 2025 08:00:22 +0000
From: Lee Jones <lee@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 06/10] mfd: bcm590xx: Add PMU ID/revision parsing
 function
Message-ID: <20250314080022.GH3645863@google.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-6-ae8302358443@gmail.com>
 <20250313132036.GB3616286@google.com>
 <ef190ba8-a5c7-4a1a-90e6-2610de00e4ed@sirena.org.uk>
 <f363c1ce-8612-476e-a5d5-c3cb358bf50a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f363c1ce-8612-476e-a5d5-c3cb358bf50a@gmail.com>

On Thu, 13 Mar 2025, Artur Weber wrote:

> On 13.03.2025 14:25, Mark Brown wrote:
> > On Thu, Mar 13, 2025 at 01:20:36PM +0000, Lee Jones wrote:
> > > On Tue, 04 Mar 2025, Artur Weber wrote:
> > 
> > > > +	if (id != bcm590xx->pmu_id) {
> > > > +		dev_err(bcm590xx->dev,
> > > > +			"Incorrect ID for %s: expected %x, got %x. Check your DT compatible.\n",
> > > 
> > > Isn't it more likely that the H/W this is being executed on is
> > > unsupported?  If so, say that instead.
> > 
> > Given that the compatibles are device specific the driver shouldn't be
> > binding if the device is unsupported.
> 
> Yes, the intention here is just to make sure that the DT compatible and
> hardware ID match. Unsupported hardware would not have a DT compatible.

Right, so the user is utilising the correct compatible on the incorrect
(most likely unsupported) platform.  When using a supported DTB on
unknown hardware, the driver will bind but fail here.

-- 
Lee Jones [李琼斯]

