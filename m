Return-Path: <linux-kernel+bounces-564353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E7A6537C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8053A2E84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B422094;
	Mon, 17 Mar 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jc4viob8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F41A5BB8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221648; cv=none; b=HG0kgF/DcTbjwDuHPQJpDVEGMSLIsQIgd3GNmVB/59cmwcJUiwAINSiPRWXbWE7YiOhf7G4XsoxB9idcGrhSprdWD3EVC2xAVddRO3M4aROjQ0VRLPC+f2Ji0UcW9exG3ojTSqPsoRGdIk+yUP+aoE1RggjHuYvv5H9f7cFziIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221648; c=relaxed/simple;
	bh=9izreXOsYHDAFk4yCUoo+6Q+ttAIPBeesv5iTU9x80U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZevzskBETi+EpBxVYSHsKiIo8pG+xh2BpnutKZZ3yifrNu/+0otmG+gQfY5Vc0qCakUpMB6dU2YuN2nLDouvKGWweZG78KfhLApa/zGz4h9hbXK/nmX2wPB33aVeCtRzwzoBlJESZdJhAtBf5HLJuldexfncqjzzKWuWanRFIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jc4viob8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E294C4CEE3;
	Mon, 17 Mar 2025 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742221648;
	bh=9izreXOsYHDAFk4yCUoo+6Q+ttAIPBeesv5iTU9x80U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jc4viob83lYKgq+KEQct4gADo9SaDmWW9gh7Ffs/iPDePaqlZSbhQa6c6pmDKk6Eh
	 m+f7lW6DeFpzBxrJyM7gzAMpIY3OV3ThwFy2UQ8c7SV6iCWcaoPDrXmfyylmah/47U
	 Eh+YoHUxZSn0EMNJ/k+TbcB1t+WqYwwHbo15pRAw=
Date: Mon, 17 Mar 2025 15:26:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 9/9] regulator: dummy: convert to use the faux device
 interface
Message-ID: <2025031742-perfectly-hydrogen-159c@gregkh>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>
 <2025031716-decaf-overhead-c56c@gregkh>
 <Z9guHSE0nwC1-52J@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9guHSE0nwC1-52J@bogus>

On Mon, Mar 17, 2025 at 02:13:49PM +0000, Sudeep Holla wrote:
> On Mon, Mar 17, 2025 at 02:00:04PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 17, 2025 at 10:13:21AM +0000, Sudeep Holla wrote:
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > Why are you resending my patch back to me?
> > 
> > > The dummy regulator driver does not need to create a platform device, it
> > > only did so because it was simple to do.  Change it over to use the
> > > faux bus instead as this is NOT a real platform device, and it makes
> > > the code even smaller than before.
> > > 
> > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Message-Id: <2025021027-outclass-stress-59dd@gregkh>
> > > (sudeep.holla: Made dummy_regulator_driver static)
> > 
> > So this is a new version?
> > 
> 
> Not really, I pulled your patch as I needed that as well to clean out
> all faux device out of platform. I just made dummy_regulator_driver
> static back again as compiler was warning. Definitely nothing new.
> I will drop it when posting v2. You can probably fix up to make
> dummy_regulator_driver static.

My tree can't be rebased, can you just send a patch to make that change
instead?

thanks,

greg k-h

