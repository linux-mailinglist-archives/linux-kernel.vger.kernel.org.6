Return-Path: <linux-kernel+bounces-191808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F838D1469
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C4F1F2252E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC91B53802;
	Tue, 28 May 2024 06:31:17 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FEF8F48
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877877; cv=none; b=knR3VjmgJyAweCriRMo1i5cUyiOlNVvtF+YyIw1JJurQJGv2cMaC1aKWf4JaBRxT0zwZG6CR10q9umTG63omdPnnR1hoJB8Xp33f8b7SLE/hedBrABVpn1S81vioZxD8Ny0EgWZR4wsePLHne39k6DxxNpY9iuvm37BxgvmlqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877877; c=relaxed/simple;
	bh=1pvqTEtklqkSqIZFAPqXsHkD3JkpggMJl6xPHjet5ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEaswf1abkq2UMfM2PfrHCwUtMzfkrWDTjiMbuMDWNWi5vVQR5EhcvG0h+6eg77UN7OnzZL9S+c2bkgzIj+Rr+hc7sc9gJf46TaJTlteOLrCoens2gBRsBx18axZnlaOlh6sRlbSCFiKMEi2YER5piIRNUiNqlg0znVIOLkexCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D36D67373; Tue, 28 May 2024 08:31:09 +0200 (CEST)
Date: Tue, 28 May 2024 08:31:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v6 3/4] driver core: shut down devices asynchronously
Message-ID: <20240528063109.GA29965@lst.de>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com> <20240516154920.221445-4-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516154920.221445-4-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 16, 2024 at 10:49:19AM -0500, Stuart Hayes wrote:
> Add /sys/kernel/async_shutdown to allow user control of this feature:
> 
>   safe: shut down all devices synchronously, unless driver prefers async
> 	shutdown (driver opt-in) (default)
>   on:	shut down all devices asynchronously, unless disabled by the driver
> 	(driver opt-out)
>   off:	shut down all devices synchronously

The on option seems very odd.  IMHO safe is the only really sensible
option, and maybe we have to support off as a bandaid due to userspace
behavior dependent on synchronous shutdown, but I'd rather try even
without that first.


