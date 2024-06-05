Return-Path: <linux-kernel+bounces-202557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE508FCE63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4520B23A53
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3C196D91;
	Wed,  5 Jun 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWKkrD6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B2196C73
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589508; cv=none; b=W0Rl/EWDCnvQGl2UVxQ4AFOmhsDcbrH69VmXaNHvWzDwIgYMXn80bAOxMZJ4ewa/SpzAzociaE3/aIi/lijHTEseMgLTy+yWtjt3IvSwWQ0mHzGYvH9zOfJsRSTLqTvLExPZsSGzhpMBSMawKD2eoKDHlA66OXNRWHxhuCoPbss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589508; c=relaxed/simple;
	bh=cwTJba3C8Qwz1ZLeDncLpCLV7/mbQe8fxcLPmmDJQto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoZNejn4E9LTOH0EEn7zzUsbXgz3Xu9vglTVOL2ixzZd3JVT8UYQfdL80H4zaDKj6xM7DzyEz3K4QEO1szv3uHmhZ12ROxq8kbcDs8EXFv5Q/H9YMlis3RevjulnmNRy/MiaYPwQc4H4Bvps1xQsqoNMeS43sG3fb6lclr4BJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWKkrD6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6728EC32781;
	Wed,  5 Jun 2024 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589508;
	bh=cwTJba3C8Qwz1ZLeDncLpCLV7/mbQe8fxcLPmmDJQto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWKkrD6kulejFb9Jcnx/Dpfk8fUAEF1BuapcvVUBFriLJ64IFO7T9o///SetkdC5j
	 hRKoiH9NdxNg3aWmre+8+wZmMSGTuK5HXW1KCxtIptk3CEUWU17SjrLLVGUUrCy+Kx
	 UZfx1egKTnttA1GOKyR/uhJIde6qZdSM/Hp5o3joj2v2s+Ldp2VCMSo4LZmb6cNCWI
	 zf9hyiyq5gbMOJqPVWCA7Pg1gvRniuj6o4xgez74OtfbEXTIfDvJQCM/Lan5dNpZ0y
	 MGxKcrKXmXXES50RTevVcy9X0okES53ldURt4qnI+BM8ZUpxlVGQSvyBll9rZr74Ea
	 XvpEKlfHy9zCg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEpUc-0000000079R-06fM;
	Wed, 05 Jun 2024 14:11:50 +0200
Date: Wed, 5 Jun 2024 14:11:50 +0200
From: Johan Hovold <johan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] soundwire: bus: clean up probe warnings
Message-ID: <ZmBWBrJDRjPn6TpA@hovoldconsulting.com>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-4-johan+linaro@kernel.org>
 <8dd7cadc-138c-4ef5-b06f-7177550b1215@linux.intel.com>
 <Zl7boEkMpQaELARP@hovoldconsulting.com>
 <970501b1-09ae-4f2c-a078-2b4f23fe460e@linux.intel.com>
 <Zl8iUmOfrjw3gWVX@hovoldconsulting.com>
 <0d15954f-0158-4a56-afef-f0d043135146@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d15954f-0158-4a56-afef-f0d043135146@linux.intel.com>

On Tue, Jun 04, 2024 at 05:07:39PM +0200, Pierre-Louis Bossart wrote:
> \
> >>>>> @@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
> >>>>>  	/* init the dynamic sysfs attributes we need */
> >>>>>  	ret = sdw_slave_sysfs_dpn_init(slave);
> >>>>>  	if (ret < 0)
> >>>>> -		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
> >>>>> +		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
> >>>>>  
> >>>>>  	/*
> >>>>>  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
> >>>>> @@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
> >>>>>  	if (drv->ops && drv->ops->update_status) {
> >>>>>  		ret = drv->ops->update_status(slave, slave->status);
> >>>>>  		if (ret < 0)
> >>>>> -			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
> >>>>> +			dev_warn(dev, "failed to update status: %d\n", ret);
> >>>>
> >>>> the __func__ does help IMHO, 'failed to update status' is way too general...
> >>>
> >>> Error messages printed with dev_warn will include the device and driver
> >>> names so this message will be quite specific still.
> >>
> >> The goal isn't to be 'quite specific' but rather 'completely
> >> straightforward'. Everyone can lookup a function name in a xref tool and
> >>  quickly find out what happened. Doing 'git grep' on message logs isn't
> >> great really, and over time logs tend to be copy-pasted. Just look at
> >> the number of patches where we had to revisit the dev_err logs to make
> >> then really unique/useful.
> > 
> > Error message should be self-contained and give user's some idea of what
> > went wrong and not leak implementation details like function names (and
> > be greppable, which "%s:" is not).
> 
> "Failed to update status" doesn't sound terribly self-contained to me.
> 
> It's actually a great example of making the logs less clear with good
> intentions. How many people know that the SoundWire bus exposes an
> 'update_status' callback, and that callback can be invoked from two
> completely different places (probe or on device attachment)?
> 
> /* Ensure driver knows that peripheral unattached */
> ret = sdw_update_slave_status(slave, status[i]);
> if (ret < 0)
> 	dev_warn(&slave->dev, "Update Slave status failed:%d\n", ret);
> 
> You absolutely want to know which of these two cases failed, but with
> your changes they now look rather identical except for the order of
> words. one would be 'failed to update status' and the other 'update
> status failed'.
> 
> What is much better is to know WHEN this failure happens, then folks
> looking at logs to fix a problem don't need to worry about precise
> wording or word order.
> 
> It's a constant battle to get meaningful messages that are useful for
> validation/integration folks, and my take is that it's a
> windmill-fighting endeavor. The function name is actually more useful,
> it's not an implementation detail, it's what you're looking for when
> reverse-engineering problematic sequences from a series of CI logs.

Just add "at probe" to differentiate the two cases if you really think
this is an issue:

	dev_warn(dev, "failed to update status at probe: %d\n", ret);

Johan

