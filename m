Return-Path: <linux-kernel+bounces-231835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA61E919EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD8D1F23486
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4AB1F94A;
	Thu, 27 Jun 2024 05:55:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AF11C2A8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467722; cv=none; b=UPFeP5sPB2CpauzFPwnKMezr+IA9KWJB3ayflAxvZ1GVpT4H5C+q8KaIKSG2yhRI2A3Ne7ar2w9DELgpWJihGCJ4/mGVIuf1jIYKzVke43S/zYnFYCIIKFEMyAUgIHaPddhId6qx4oZQvQ+3nvYVhO2ao5lyKymCZxmu8W7dTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467722; c=relaxed/simple;
	bh=yWX2VrSP9sbJZxs+GSyxspez6mJzT8tJKS/p/PyIZ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buDUH/Q4YozXU5fD7bZJKrSPM+iUi5Nsify+DIrEdU4oMxutafrhSOZCo+k1OwM2qV3PmwONw8HRAuMZPpcnWgNZOYxSQE+F6R6HeAoMWG5x+E1/K/GGbkkQxYEaRLWja3QTczKtvPhd64jQ7Ez8Bu7K5pcJXRN/BdTYeJudyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A2FEB68CFE; Thu, 27 Jun 2024 07:55:15 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:55:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
Message-ID: <20240627055515.GC15415@lst.de>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com> <20240626194650.3837-4-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194650.3837-4-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 26, 2024 at 02:46:49PM -0500, Stuart Hayes wrote:
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Add async_shutdown_enable to struct device_driver, and expose it via sysfs.
> This can be used to view or change driver opt-in to asynchronous shutdown.
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

We discussed this before, but there is no summary of it and I of course
forgot the conclusion:

 - why don't we do this by default?
 - why is it safe to user enable it?

> + * @shutdown_after - used during device shutdown to ensure correct shutdown ordering.

Overly long line.

> +static ssize_t async_shutdown_enable_store(struct device_driver *drv, const char *buf,

.. and here.


