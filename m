Return-Path: <linux-kernel+bounces-560982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF91A60BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F3C3AC4C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766431C84BC;
	Fri, 14 Mar 2025 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aroWDp12"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49F6176AA1;
	Fri, 14 Mar 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941753; cv=none; b=qyBQ11QNdMVQLTW70S7gUFQ2PqWL7Zhw3ZxUoVYbrHVFWIvTsNYpLf+YLVvmGIrZ74PYQptkKbcJ3/cHA/D+tElwL4hkRDV3CEOkU7cTWXCNnFIiQ8f5PSOE7s7B48GBsI/6km9y67M+XPA4ibmz4Sx10KxfAB59q3PftTs4XFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941753; c=relaxed/simple;
	bh=VQS1Yr4tAB+kjagZmPvDSgv3gMXHVfCnmPEGOBTodA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY/I5Z1Dyl12D1ij4n7rlkfRX0xsmnZdpva470vmUY86vfN8G0NPcQH5xaD1rHnPEDvdjr2wSt7bbwvwO3bRTmjCQWtqoXLCqe2ZwSc7ogM/WOx+un+eR82wSjSwoNMoiv1nV69k2EioLj8siKkbopwD7QBiZhxeCXVvP6TMhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aroWDp12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCB3C4CEE3;
	Fri, 14 Mar 2025 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741941753;
	bh=VQS1Yr4tAB+kjagZmPvDSgv3gMXHVfCnmPEGOBTodA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aroWDp12uCjQCvTYtVLocTJeFM5M5VgtVNoNyOVNxs2UzKYMNijJ8Kh7AoXiHm0fm
	 JImb3CaJ94LBildurK4O+I8fgZZduBY26IBJJtbrzWKConLJUJHb+SOQL4TKEfs6U6
	 W6CakZRT9d4ootX3Z5IDjJrK++GuLL1ZExp0VgzK1g6qDMGfNa3Lo+Icy2+OHRNInB
	 Y0/tEyw/yfU0VUzvO9jQikWmv24uK8U52DNjnllVLel6jZ39DVEkLROngw66uUYfQz
	 TRjemEdizSl30kWlOrNBZ6jJill4vzcv9qIKviCYIW/tEm7bI6gL936PODFY99wd9G
	 tCDv94y8VsYEg==
Date: Fri, 14 Mar 2025 08:42:27 +0000
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
Message-ID: <20250314084227.GJ3645863@google.com>
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-6-ae8302358443@gmail.com>
 <20250313132036.GB3616286@google.com>
 <ef190ba8-a5c7-4a1a-90e6-2610de00e4ed@sirena.org.uk>
 <f363c1ce-8612-476e-a5d5-c3cb358bf50a@gmail.com>
 <20250314080022.GH3645863@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314080022.GH3645863@google.com>

On Fri, 14 Mar 2025, Lee Jones wrote:

> On Thu, 13 Mar 2025, Artur Weber wrote:
> 
> > On 13.03.2025 14:25, Mark Brown wrote:
> > > On Thu, Mar 13, 2025 at 01:20:36PM +0000, Lee Jones wrote:
> > > > On Tue, 04 Mar 2025, Artur Weber wrote:
> > > 
> > > > > +	if (id != bcm590xx->pmu_id) {
> > > > > +		dev_err(bcm590xx->dev,
> > > > > +			"Incorrect ID for %s: expected %x, got %x. Check your DT compatible.\n",
> > > > 
> > > > Isn't it more likely that the H/W this is being executed on is
> > > > unsupported?  If so, say that instead.
> > > 
> > > Given that the compatibles are device specific the driver shouldn't be
> > > binding if the device is unsupported.
> > 
> > Yes, the intention here is just to make sure that the DT compatible and
> > hardware ID match. Unsupported hardware would not have a DT compatible.
> 
> Right, so the user is utilising the correct compatible on the incorrect
> (most likely unsupported) platform.  When using a supported DTB on
> unknown hardware, the driver will bind but fail here.

If you simply drop the unnecessary "Check your DT compatible." part, not
only does it tidy up the print / line, it also covers more bases.

-- 
Lee Jones [李琼斯]

