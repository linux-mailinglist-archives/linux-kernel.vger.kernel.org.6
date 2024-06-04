Return-Path: <linux-kernel+bounces-200326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D278FAE6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C6B1C24267
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620AF143C44;
	Tue,  4 Jun 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJDlTvKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7403145B3A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717492171; cv=none; b=W6pW2c3FSigMvRlqQby9sR+tnW8lwdRmMdFTUd3wNPkTeMispLngWHGBZve8nwENspz92p3a8GXJM+amfyCCxZOQB6gxUz+86sP2cSpGxKepJuj75+cdxW0WsZNw2XqOKt8jEAYcBERMglk8mbYwDKKkIebfW2FhMkDTgwNQsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717492171; c=relaxed/simple;
	bh=sXjcCXgajbmAQt94Pk6QUfbkIjNpIdTaExdj0T/v6uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FulK2+Uyh/w191a8+yIKHtSWZZ9FTqQJDcrI/GDsCEM9ksfGj00lQJb5bouzvPcT7l3VbY3dlN747WHop4VKX9fsY+IETLVQxlejgraXDaEFvJLVxzjP0RT1qifBnCvJiH8pCXLqCide1VL3RnriKoqDYhJkuHwGb69AMQUvkKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJDlTvKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8FBC2BBFC;
	Tue,  4 Jun 2024 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717492170;
	bh=sXjcCXgajbmAQt94Pk6QUfbkIjNpIdTaExdj0T/v6uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJDlTvKSauNIbvDf9s6JtDlHi3NoB/8aBQHU9/OhhCPlqwVjCgI39n8NnwaHP9A6L
	 ndD6YJixI1eYvW/qmKyvtWaCnijdx/5v2lJta7oBqhD6O7ZLjzMz72OtDKO9IYkYlI
	 z1cDwYtlxs1T4lYBfdmuj8sFekNfss1bRSGDHoxY70eDQZBRTvmqn81DMqaBfiW7z9
	 5sR0InPCMm7Vk9DhisV3yGvlAWMHbgOTuotFo7wfwKWxGC30j3n17IeEjf4Wo+m0hx
	 QYWUIodZJh1iwITuSwuBYqVoTdEIxT6xgoIYJGuiauYSufxhxt/sFaDeMbMaHT0ye+
	 aQpx97sZXj6Ww==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEQAa-000000001Q2-2Ido;
	Tue, 04 Jun 2024 11:09:29 +0200
Date: Tue, 4 Jun 2024 11:09:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soundwire: bus: suppress probe deferral errors
Message-ID: <Zl7ZyEkmm8kHeRvL@hovoldconsulting.com>
References: <20240604075213.20815-1-johan+linaro@kernel.org>
 <20240604075213.20815-2-johan+linaro@kernel.org>
 <c5ecc0cd-c2ba-4f71-ac2a-9a81793a8f0c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ecc0cd-c2ba-4f71-ac2a-9a81793a8f0c@linux.intel.com>

On Tue, Jun 04, 2024 at 10:30:21AM +0200, Pierre-Louis Bossart wrote:
> On 6/4/24 02:52, Johan Hovold wrote:
> > Soundwire driver probe errors are currently being logged both by the bus
> > code and driver core:
> > 
> > 	wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -12
> > 	wsa884x-codec sdw:4:0:0217:0204:00:0: probe with driver wsa884x-codec failed with error -12
> > 
> > Drop the redundant bus error message, which is also incorrectly being
> > logged on probe deferral:
> 
> It's only redundant in the QCOM case... This would remove all error logs
> for other codecs, e.g. see
> 
> rt711_sdca_sdw_probe
> cs35l56_sdw_probe
> wcd9390_probe
> 
> Looks like the wsa884x-codec is the chatty driver, others are just fine
> with the existing code.

I believe you misunderstood this patch. The error messages above are not
printed by the wsa884x-codec driver, but by the soundwire bus code and
driver core, so the redundant error message will be printed for all
codecs on probe failures.

And specifically, driver core will still log probe failures after this
change.

Johan

