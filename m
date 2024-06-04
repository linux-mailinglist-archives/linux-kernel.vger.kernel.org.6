Return-Path: <linux-kernel+bounces-200337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE78FAE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C81BB238B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8195314375B;
	Tue,  4 Jun 2024 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3YGOQUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982F1386D2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492642; cv=none; b=h/UH/4AA8m/bHdDB8M/ggC1xz8NkUBD9hYX6m9kCsztjg9DV+4+HfNwbJZgOMnuxJBFuym7HSQ5v3EJ7kjVtU+Z3Eihipvl391tFg3W5I8BW5H0G9heXob7RMooMy0Wwv7jC8roCu3mQ6r8EFtuz7ybPoPx8GtPi6esXu6VmYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492642; c=relaxed/simple;
	bh=FCrFtvGT7nfYDArMK5ytnHOL+AVDEQiP/9i3bDpr0hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLxyEVuVLPoiOknLnao2C1y5hMgtF7TyfIdJaoOFF10lLY7/rVWWy08O/pma+Bz9yn/evys9+ssBGNgBkGMiJiRU+wFzMuVWTVDGtDSchZjl4rKSPiP0+UZpjU2Z2+82Eq8QJNsQ4lVrrLx6jgRO/+RertQorsXoMha5Gmo7qsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3YGOQUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52111C2BBFC;
	Tue,  4 Jun 2024 09:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717492642;
	bh=FCrFtvGT7nfYDArMK5ytnHOL+AVDEQiP/9i3bDpr0hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3YGOQULFYzsdRUHxPDwrS0zuMsIKMDkRsByuPi3yXGkmGiKwxqZme5r7pqSeB8xb
	 D8vsUY1rbs2KS6EaMvEOYpFTFpkX1u1H4LhNh4MP/kFmsO5Bt3v1doMjiCz9OWCDTn
	 ZRuywir2hsfdLVWK7/vQtTv+6wd8rFJDcBNxB7hYb6+JOnBSKNf0lwk+r90Dg12qSg
	 m+gdgqCMA+opVFr+bGwSXHursv8ZjOB2JH1+fblDh9h1LMaNujBgYDgRygEFNdv0ki
	 wjBeqI1ZIpl549F832GSb1f+hp9Vp51ZHNVcFirChjnBTWOC6ZBudBb20H73DQBfiq
	 6IjoFe9Qd/dHA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEQIC-000000001XF-28Nh;
	Tue, 04 Jun 2024 11:17:21 +0200
Date: Tue, 4 Jun 2024 11:17:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] soundwire: bus: clean up probe warnings
Message-ID: <Zl7boEkMpQaELARP@hovoldconsulting.com>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-4-johan+linaro@kernel.org>
 <8dd7cadc-138c-4ef5-b06f-7177550b1215@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd7cadc-138c-4ef5-b06f-7177550b1215@linux.intel.com>

On Tue, Jun 04, 2024 at 10:33:02AM +0200, Pierre-Louis Bossart wrote:
> On 6/4/24 02:52, Johan Hovold wrote:
> > Clean up the probe warning messages by using a common succinct format
> > (e.g. without __func__ and with a space after ':').

> > @@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
> >  	/* init the dynamic sysfs attributes we need */
> >  	ret = sdw_slave_sysfs_dpn_init(slave);
> >  	if (ret < 0)
> > -		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
> > +		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
> >  
> >  	/*
> >  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
> > @@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
> >  	if (drv->ops && drv->ops->update_status) {
> >  		ret = drv->ops->update_status(slave, slave->status);
> >  		if (ret < 0)
> > -			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
> > +			dev_warn(dev, "failed to update status: %d\n", ret);
> 
> the __func__ does help IMHO, 'failed to update status' is way too general...

Error messages printed with dev_warn will include the device and driver
names so this message will be quite specific still.

> Replacing 'with status' by ":" is fine, but do we really care about 10
> chars in a log?

It's not primarily about the numbers of characters but about consistency.

Johan

