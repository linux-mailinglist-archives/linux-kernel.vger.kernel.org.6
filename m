Return-Path: <linux-kernel+bounces-200346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2B98FAEB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5BC7288EC3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14FA143C72;
	Tue,  4 Jun 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0buvv/Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE2143C64
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493098; cv=none; b=STKJG+Q8sZpy8UTGGV1KTb6oOu1oOX31Jfn/GskUVaGuvzBoE8Rw/4vDb1dYa8DHsqnz80G7CVhyImAtB71vx2ywtgM/YE8qkr5ZQv6fazOZkkjCPp6FSDVL8IKMt4N1f+XVYuMqYSmP/7zMSmGPHAU8LSP9fnnmZeuxJq6JnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493098; c=relaxed/simple;
	bh=WFpT7tceC4LqEAg6Pkh4MT4mrzlDn7hYSXs9KJvIZoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfxsCknzqZFI+QqIlxG5GI2x4OmFp1s1Ud3dE2Gg6i/u0fPM7T85RB7F5AQBhBrO24hXbCNDytBRzGehKMCS4fJ6D/1oGdaRLWwc5IQygzPXPQK7ycRYUTLwAJmY6GZLM6bhkjY+40ek0Xkc+GaE5W8y1AyYUICYsu/L3vVVIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0buvv/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1041C4AF07;
	Tue,  4 Jun 2024 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717493097;
	bh=WFpT7tceC4LqEAg6Pkh4MT4mrzlDn7hYSXs9KJvIZoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0buvv/ZD4+IABHIJF1b4BtB7fxBDaInn/gV6Z1zzhSJHxTaRtaDWrri/pSqWLx4M
	 J84Ri/AnMKxLOheT9Iic1h+hjKttdoRzPH5S6u/tjlqkmue2+zxrfq3DBS1KfXk2zz
	 cBChwZdQZ1BURbmoF1is4SYUv5Gq6Z06ydcqxXGCdzS0RTZrgeqTTMyE7Jls2ZmUVa
	 uZVm/mudAF4Mu/uk16uW6lgIQ3XULdrCiBkeX8eA+5KTTnlcqA8Qwzt+uNMawLLGz2
	 8oRSQm6o4/toaHAH3/NlqPT2X/tXme2mmbZ8q4HlszKu8JG4nWAKqNjjNOLrxoXv74
	 W9s90+G1cPbFA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEQPX-000000001er-2o5n;
	Tue, 04 Jun 2024 11:24:56 +0200
Date: Tue, 4 Jun 2024 11:24:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] soundwire: bus: drop redundant probe debug message
Message-ID: <Zl7dZ-4ysKC-jSA6@hovoldconsulting.com>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-5-johan+linaro@kernel.org>
 <e1c63097-b628-4c97-add6-40fa479a7806@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1c63097-b628-4c97-add6-40fa479a7806@linux.intel.com>

On Tue, Jun 04, 2024 at 10:37:17AM +0200, Pierre-Louis Bossart wrote:
> On 6/4/24 02:52, Johan Hovold wrote:
> > Drop the redundant probe debug message which is already provided by
> > driver core. Whether probe succeeded can also be determined through
> > sysfs.

> > @@ -152,8 +152,6 @@ static int sdw_drv_probe(struct device *dev)
> >  
> >  	mutex_unlock(&slave->sdw_dev_lock);
> >  
> > -	dev_dbg(dev, "probe complete\n");
> > -
> >  	return 0;
> >  }
> 
> I don't see the point of removing this, we've used it for the last 5
> years to figure out when the probe complete vs. when the device becomes
> attached. It's a simple log that helped us immensely with race
> conditions, etc.

Fair enough. Soundwire probing is indeed a bit of a mess.

Johan

