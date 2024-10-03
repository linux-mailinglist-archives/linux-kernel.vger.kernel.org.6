Return-Path: <linux-kernel+bounces-348718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0550898EAF6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92851F23E89
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16A612F588;
	Thu,  3 Oct 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEmtEx+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFD810940;
	Thu,  3 Oct 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942416; cv=none; b=mRl7YEA7EbBiboJOohYN7mJ2HiMff//XS4kIymOR59krZ6bwX7zprvUoLL++7BSOpysbmWmq+0N3TYP+9G7kqQmW6uMt4fM8+wv2MnYhI4jNfYNEA1EmG0ljJSc2s+LGvdwM2NwNGEcNZFYJmOjE2774FODLkh/t5MMas6xyPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942416; c=relaxed/simple;
	bh=YoAvCVp4HtIMRiHkCzZhf/KFXZd0NkaR4FoWZ9wm1Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkDVPSEdLZwKPjQbCKV3V6J51lBxQxGSPIANjYUPjs7lcZnjSrzRpnLIYRcmcAYJ16ErN14WeQrDl7GptZIb/bM4SbekYQn60hj3r9yuP6rWim5Za4pfuqVsjtxQGdO+pon352hjGlUA1Dxtq1XQSyoBbH4EDoGCsQY5qhUfUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEmtEx+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815EEC4CEC7;
	Thu,  3 Oct 2024 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727942416;
	bh=YoAvCVp4HtIMRiHkCzZhf/KFXZd0NkaR4FoWZ9wm1Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEmtEx+tFS5bHueV3GqjKU3ouGIX0j/NwPqU05yv4EIU5dngKmYcHz23gUbSuab4U
	 Ls6BkvmMaB2o+pXYQct54xiAMNpMAVlsVY5qas9VD7kE0xs5dY/SWqKOZv9U6fyTpb
	 /swHNlYHAOgqltAUOlVnOv1rk8ZZRvcFjjlNDYfli0lQcHqn9CgbjjShzNzDxFfVwN
	 fUPk5YbPzit9Vin97imTFmX5cgEWpLC8wlyfXOlKHqRDKvTOPZg2E7EKsk+G7aQtcm
	 7d8qOcnJj2Kb7c2yqOgVtz2DkMGWpqi3ecjLlU/I9dsxdMradOLAQUnWTHatVevuW/
	 /hycbVKGF6a4g==
Date: Thu, 3 Oct 2024 13:30:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: "Liao, Bard" <bard.liao@intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] soundwire: intel_auxdevice: add kernel parameter for
 mclk divider
Message-ID: <Zv5PDAQjrhfG+78d@vaman>
References: <20240806083840.24094-1-yung-chuan.liao@linux.intel.com>
 <ZsGhdFm8nYkm5Y5w@vaman>
 <SJ2PR11MB84245A5FAA3672471928C26CFF8C2@SJ2PR11MB8424.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2PR11MB84245A5FAA3672471928C26CFF8C2@SJ2PR11MB8424.namprd11.prod.outlook.com>

On 19-08-24, 08:13, Liao, Bard wrote:
> 
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Sunday, August 18, 2024 3:24 PM
> > To: Bard Liao <yung-chuan.liao@linux.intel.com>
> > Cc: linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org; pierre-
> > louis.bossart@linux.intel.com; Liao, Bard <bard.liao@intel.com>
> > Subject: Re: [PATCH] soundwire: intel_auxdevice: add kernel parameter for
> > mclk divider
> > 
> > On 06-08-24, 16:38, Bard Liao wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > >
> > > Add a kernel parameter to work-around discrepancies between hardware
> > > and platform firmware, it's not unusual to see e.g. 38.4MHz listed in
> > > _DSD properties as the SoundWire clock source, but the hardware may be
> > > based on a 19.2 MHz mclk source.
> > 
> > I think this should be documented in kernel-parameters.txt?
> 
> The parameter is only needed when a BIOS provides a MCLK rate which
> does not match the actual rate. It is not a normal case and it happens rarely.
> Is it really necessary to be documented in kernel-parameters.txt?

Yes I think so, all of the parameters are supposed to be documented :-)

-- 
~Vinod

