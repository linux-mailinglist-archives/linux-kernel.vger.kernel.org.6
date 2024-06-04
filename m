Return-Path: <linux-kernel+bounces-200798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D88FB50B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF581C21C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341F03BB24;
	Tue,  4 Jun 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9lQ2NZv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B81EB26
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510740; cv=none; b=Ssft5asEKpc92DZ1zLXzCuJvf7mC2MeqDkUP27AfCB1dfPExBM4HJE8Oqql8GordRhg7iy01MVQc84CeuRs2w5xBm0367tQqqQwQRz9QIANsOETXE44Mq8f2jaZ1zemqU3Gz+m8UKiMFddfKjhm2iXcHPzCjVJd3rSpd7hEKTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510740; c=relaxed/simple;
	bh=Ldo8Rxw3b/CMs8cXyF5xLOYbN3yefyXw5+4N7TYJbfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8cuQ8GcS+j6maaqq+/pT2rOyX3M6vepOsizhBKgPuXrhPaQW6IgsvH2XnBKncNy9pAIqzSizY2TF0Uzd+5rSRdUreycAUHMosmzu3Tmo93OlCsQQauxjLL3wunT4TzRZv3iiUnfPuixc7r4dZejwHwavzcnqq8sqWBaSwncXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9lQ2NZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166C7C2BBFC;
	Tue,  4 Jun 2024 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717510740;
	bh=Ldo8Rxw3b/CMs8cXyF5xLOYbN3yefyXw5+4N7TYJbfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9lQ2NZvSiAyqnvz6+FAHzAA9+SGGSX849IKWndqIhJ/k6JMZHLMK7A/6Sb5oRNFO
	 IzBJRP8s1BjhX0LYLmmFhgU34jw6Zb31Oh37nJt6iV/2A1xz0kWtqMYz7DbYU/qgnK
	 8NUBytOtBMqm2SYHcB+qqsjqndBvkUpDKv9WulLNm9hMWK/5N5WAcc0AZQ1ZliEzyu
	 9A8A0G22fwr0iJUaLitX2ib+Wqr9OmyL+vAaiipOv9bWoyxaWDzE6DVNJPMgVChkRz
	 7osTqt3Dev6fRmI8Pc3PDbJgIpGa2CzKzAO0GaYTEtDEW7wXjYNc45vDod41RlfUto
	 hlTY16X33DSBA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEV06-000000002X3-1SkF;
	Tue, 04 Jun 2024 16:18:59 +0200
Date: Tue, 4 Jun 2024 16:18:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] soundwire: bus: clean up probe warnings
Message-ID: <Zl8iUmOfrjw3gWVX@hovoldconsulting.com>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-4-johan+linaro@kernel.org>
 <8dd7cadc-138c-4ef5-b06f-7177550b1215@linux.intel.com>
 <Zl7boEkMpQaELARP@hovoldconsulting.com>
 <970501b1-09ae-4f2c-a078-2b4f23fe460e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970501b1-09ae-4f2c-a078-2b4f23fe460e@linux.intel.com>

On Tue, Jun 04, 2024 at 03:43:46PM +0200, Pierre-Louis Bossart wrote:
> On 6/4/24 11:17, Johan Hovold wrote:
> > On Tue, Jun 04, 2024 at 10:33:02AM +0200, Pierre-Louis Bossart wrote:
> >> On 6/4/24 02:52, Johan Hovold wrote:
> >>> Clean up the probe warning messages by using a common succinct format
> >>> (e.g. without __func__ and with a space after ':').
> > 
> >>> @@ -123,7 +123,7 @@ static int sdw_drv_probe(struct device *dev)
> >>>  	/* init the dynamic sysfs attributes we need */
> >>>  	ret = sdw_slave_sysfs_dpn_init(slave);
> >>>  	if (ret < 0)
> >>> -		dev_warn(dev, "Slave sysfs init failed:%d\n", ret);
> >>> +		dev_warn(dev, "failed to initialise sysfs: %d\n", ret);
> >>>  
> >>>  	/*
> >>>  	 * Check for valid clk_stop_timeout, use DisCo worst case value of
> >>> @@ -147,7 +147,7 @@ static int sdw_drv_probe(struct device *dev)
> >>>  	if (drv->ops && drv->ops->update_status) {
> >>>  		ret = drv->ops->update_status(slave, slave->status);
> >>>  		if (ret < 0)
> >>> -			dev_warn(dev, "%s: update_status failed with status %d\n", __func__, ret);
> >>> +			dev_warn(dev, "failed to update status: %d\n", ret);
> >>
> >> the __func__ does help IMHO, 'failed to update status' is way too general...
> > 
> > Error messages printed with dev_warn will include the device and driver
> > names so this message will be quite specific still.
> 
> The goal isn't to be 'quite specific' but rather 'completely
> straightforward'. Everyone can lookup a function name in a xref tool and
>  quickly find out what happened. Doing 'git grep' on message logs isn't
> great really, and over time logs tend to be copy-pasted. Just look at
> the number of patches where we had to revisit the dev_err logs to make
> then really unique/useful.

Error message should be self-contained and give user's some idea of what
went wrong and not leak implementation details like function names (and
be greppable, which "%s:" is not).

> >> Replacing 'with status' by ":" is fine, but do we really care about 10
> >> chars in a log?
> > 
> > It's not primarily about the numbers of characters but about consistency.
> 
> I am advocating for inclusion of __func__ everywhere...It's simpler for
> remote support and bug chasing.

A quick grep seems to suggest you're in a small minority here with some
5k of 65k dev_err() including __func__.

[ And there's only 55 out of 750 dev_err() like that in
drivers/soundwire, which is inconsistent at best. ]

Johan

