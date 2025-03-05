Return-Path: <linux-kernel+bounces-548000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3F8A53EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A33AA399
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50510207A10;
	Wed,  5 Mar 2025 23:51:27 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D516CD1D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218687; cv=none; b=UstIvfjb4i+u2QsS3oo8L4hFkD0n1EZNSwz7U0pxRexv6/vWu893ThbXgegxzHjk8swDfcfMMkBhqlOBeMDC856nmdncppZ/IXRhdWyAL46A47JFUF5f0SxPJSqUC2HdjO/tTFfzLjU5bgvobrTfY7uaw2kiypTiPNO545wVcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218687; c=relaxed/simple;
	bh=EGtXC5kBwI+LGxYsg5fT3yG7Ka8j8ZrLxJ6c+D9qq1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6MDj4fDX5/cBIxI52vpu0q6vpFPS7+T6BpEus5g/2IHqxCNvzBcM1Cvgbu1P95f5Co2M4w8OPUqQpObG8rgj5VqGbE1kKJMIWHxReqHCzgsecwY/fGmmCI72TctOV//OVs7Z+nKSZSp68RKZZc4S6qa9GJ2ZmjtSM+/hmtQWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 347BB68BEB; Thu,  6 Mar 2025 00:51:20 +0100 (CET)
Date: Thu, 6 Mar 2025 00:51:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250305235119.GB896@lst.de>
References: <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com> <Z7Sh-3yHbXVmRbNL@kbusch-mbp> <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com> <Z7TARX-tFY3mnuU7@kbusch-mbp> <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 05, 2025 at 08:17:59AM -0700, Keith Busch wrote:
> > > Plus there are some NVMe devices out there which _despite_ being PCIe do 
> > > report NMIC and CMIC set (I won't name names, if you came across them 
> > > you'll know)
> > 
> > ?????
> > 
> > NMIC and CMIC is perfectly normal and expected for multiported PCIe.
> > WTF are you talking about?
> 
> Obviously he's not talking about multiported PCIe.

Why is that obvious?  At least based on the stated works he talks about
PCIe and not about multi-port.  The only not multiported devices I've
seen that report NMIC and CMIC are a specific firmware so that the
customer would get multipath behavior, which is a great workaround for
instable heavily switched fabrics.  Note that multiported isn't always
obvious as there are quite a few hacks using lane splitting around that
a normal host can't really see.

> And he's right, the
> behavior of a PCIe hot plug is very different and often undesirable when
> it's under native multipath.

If you do actual hotplug and expect the device to go away it's indeed
not desirable.  If you want the same device to come back after switched
fabric issues it is so desirable that people hack to devices to get it.
People talked about adding a queue_if_no_path-like parameter to control
keeping the multipath node alive a lot, but no one has ever invested
work into actually implementing it.

