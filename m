Return-Path: <linux-kernel+bounces-548005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D1A53EB6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0483AE0AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD0207A23;
	Wed,  5 Mar 2025 23:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkfXpqyF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0911E7C20
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741219068; cv=none; b=DSKCvhABNcDYSQPAqswLv1cbfSRqEV4gmQmTC03/P0g7aL04o+UNHs3msmZ2RHlK0g86CUpJM5hoXH2ZP76sx8X3QOeYsU/mG7kDmWF5CouWIQrBXVlZ0MVvrO6qBlpF9tjEOFcbmPnjAUBMxBw01hU+K42QzutV7cWFhmju4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741219068; c=relaxed/simple;
	bh=sjr6OGckziQ9YjoNnbDRgjPZEbhWstKtXIcNkou+a8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkrcglvyNwz7QlBmNZnYtcvjoORsun+7ZNyOdhbAT+IZtzHsmtdmBPV4aYvx/AEmGsrzBcgd5SBAeq1QY2UhrKYVPE74jiiUPUCtyzaSsbREb7L3M+HeIZzMQeSJQmPzmvWWL9yWYdTCzjoSdpLkEpp3Kd640EASyN1XkbDX8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkfXpqyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FFC4CEE0;
	Wed,  5 Mar 2025 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741219068;
	bh=sjr6OGckziQ9YjoNnbDRgjPZEbhWstKtXIcNkou+a8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkfXpqyFDo5zQ9MZZ5agzkXVt7qI+0luk5+RfNUOj7cYm0Tyb3jnfo6gMD0Ut9eve
	 ErclBYH7EOOELDoWJU0y7CoCtWIWoIta9RbmEBX6ZI1fQPzhwGcHeiazzjAu6AsBWw
	 b5/pxh32zLr+0bJwvrrWDwtAFyZxjUdMkTOIr6awWiHiCgr+gKuMFTaAOOS/JiZJRS
	 e7htLB10fGt1tLIFDyDQDbN+nIwMRVOV3YuYwHB4cs52aP0tLwsllPxxTIcq1xEwnp
	 NJLejuBwEelzbGH3FpGxMNjQ8Yu58WTEdkXSsVuuY/4mcYz75kYA893hIvaW1mVvXr
	 J+alAQyfCea2A==
Date: Wed, 5 Mar 2025 16:57:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8jk-D3EjEdyBIU5@kbusch-mbp>
References: <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305235119.GB896@lst.de>

On Thu, Mar 06, 2025 at 12:51:19AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 05, 2025 at 08:17:59AM -0700, Keith Busch wrote:
> > > > Plus there are some NVMe devices out there which _despite_ being PCIe do 
> > > > report NMIC and CMIC set (I won't name names, if you came across them 
> > > > you'll know)
> > > 
> > > ?????
> > > 
> > > NMIC and CMIC is perfectly normal and expected for multiported PCIe.
> > > WTF are you talking about?
> > 
> > Obviously he's not talking about multiported PCIe.
> 
> Why is that obvious?  

No one here would think a multiported device *wouldn't* report CMIC. The
fact Hannes thinks that's a questionable feature for his device gives
away that it is single ported.

> At least based on the stated works he talks about
> PCIe and not about multi-port.  The only not multiported devices I've
> seen that report NMIC and CMIC are a specific firmware so that the
> customer would get multipath behavior, which is a great workaround for
> instable heavily switched fabrics.  Note that multiported isn't always
> obvious as there are quite a few hacks using lane splitting around that
> a normal host can't really see.

In my experience, it's left enabled because of SRIOV, which many of
these devices end up shipping without supporting in PCI space anyway.

> > And he's right, the
> > behavior of a PCIe hot plug is very different and often undesirable when
> > it's under native multipath.
> 
> If you do actual hotplug and expect the device to go away it's indeed
> not desirable.  If you want the same device to come back after switched
> fabric issues it is so desirable that people hack to devices to get it.
> People talked about adding a queue_if_no_path-like parameter to control
> keeping the multipath node alive a lot, but no one has ever invested
> work into actually implementing it.

Not quite the same thing, but kind of related: I proposed this device
missing debounce thing about a year ago:

https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/

