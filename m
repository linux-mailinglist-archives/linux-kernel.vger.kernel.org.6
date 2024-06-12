Return-Path: <linux-kernel+bounces-212246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E2905D43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7941EB22E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D88564B;
	Wed, 12 Jun 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxj/s95x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1085298
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225715; cv=none; b=O73WnjjrYzzlmUHwBfgzjEwHhGDiIJq4pTesmlXnXRLDeXnGNK/8eMwSnKuEjdfZ0ZK8kJh45rj/lX8hlUqtG9hGMbxeJ1jNGBpgECrRmjpHbuuXiwhidS1T/S8aMExA7qJP3NFLpvG7pmizjUnDJ5aAN5kTYgk0s6HjsomXZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225715; c=relaxed/simple;
	bh=vtyWHnXG1p3yyQvY7vBy4X4sTbiCW7OZDwJn2nOC4hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5K/3eJeHEKKd6TM5xOq+oI6IkZo8g9xjjWYz5WUjeVfIfB8Wzyn0ytbDh9wso3JDwBpC5XCpyhp2te5sHLMcmSE3FGrS3W3lQ5sylxYz+6VCrKylYNCMv17IFHqkNQW1G/hC72jlDcIGHsnH+/0GiSKJaB5tONUhBQI79Ryi30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxj/s95x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4AAC116B1;
	Wed, 12 Jun 2024 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718225715;
	bh=vtyWHnXG1p3yyQvY7vBy4X4sTbiCW7OZDwJn2nOC4hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxj/s95xv3glfSecT6BZP98WWPduof/lIMq4LzAnx+gsENNyq1OZE+bzjQcSRImUe
	 GZEJrLRd3hMmXRYAfhlqPMOM7E9pz4sfHIElIZno7wqUKgQllosOVxlXeGkl2xjADS
	 hOWG30s4dUfq7IqiSBaPPOCd4R6QOd3r3ruc5iirQUS//afFkppnDWdJ4lXiq5phDJ
	 PHxH4/No+mxfybSPxNPv42tGz0eiWXlfTyR67RJBsQ8uYmUlRQGEmisXI8Z6yvNFeP
	 SadQ9IOm8jdyYEFIifm+VFBK6bcm6DYWCtWTZGEBPJFSzhG7jMFmeMOWmvT8Gi9W+g
	 vBU93sGE5l3sQ==
Date: Wed, 12 Jun 2024 14:55:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <ZmoLL8c_ujmjzSHQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
 <20240516154920.221445-4-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516154920.221445-4-stuart.w.hayes@gmail.com>

On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
> Add code to shut down devices asynchronously, while ensuring that each
> device is shut down before its parents & suppliers, and allowing devices
> that share a driver to be shutdown one at a time if necessary.
> 
> Add /sys/kernel/async_shutdown to allow user control of this feature:
> 
>   safe: shut down all devices synchronously, unless driver prefers async
> 	shutdown (driver opt-in) (default)
>   on:	shut down all devices asynchronously, unless disabled by the driver
> 	(driver opt-out)
>   off:	shut down all devices synchronously
> 
> Add async_shutdown to struct device_driver, and expose it via sysfs.
> This will be used to view or change driver opt-in/opt-out of asynchronous
> shutdown, if it is globally enabled.
> 
>  async:   driver opt-in to async device shutdown (devices will be shut down
>           asynchronously if async_shutdown is "on" or "safe")
>  sync:    driver opt-out of async device shutdown (devices will always be
>           shut down synchronously)
>  default: devices will be shutdown asynchronously if async_shutdown is "on"
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

I've successfully tested this out on a few systems, and noticing a very
decent shutdown time on my nvme systems. I also like the current
solution here, as the two-pass method was harder to follow.

So I think just remove the extra options that Christoph mentioned and
always use the driver's preferred shutdown method, then this would all
look good to me.

