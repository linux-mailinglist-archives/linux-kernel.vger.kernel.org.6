Return-Path: <linux-kernel+bounces-549168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0FDA54E76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B143A7710
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10ADE150997;
	Thu,  6 Mar 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU7gRBZB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4BEEA9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273283; cv=none; b=qUjHbBpTouy7g0bZYQaaPKy0akuMWFVRgwQYF5+8AZEWaIsInUVfZlPzkuq7OmfYpJ+17oOg9fbNxk8XSkQ9BdJmEfI4nBmAt/n7132WvGg7VyDBsmFEVaB/It6e+jRc4w5qNMuCnf809TP/a8AAZ69UKyo3pxRSFgp2sZLzk48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273283; c=relaxed/simple;
	bh=jZlvV4iZTdSil+zgfLGfHzpyML/Vo7QSZIW0eHQ6HKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWIY2Vg2UnXwFVbDbLiJt6kMkWoWMYo4XvKjOzvGcygbnpmQvKtUESWM9f0zEi+52A91HzsOYF8DF5K7hfdmW9nRNox4s4s135/xAgiX7VGY3ZRmNDhTAjHHG9zlUNUPFvg3s5RGwqFtjmr+kO1vnczZ7/i21Ws4mxILvoAuPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU7gRBZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB7C4CEE0;
	Thu,  6 Mar 2025 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741273282;
	bh=jZlvV4iZTdSil+zgfLGfHzpyML/Vo7QSZIW0eHQ6HKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sU7gRBZBqEdXDYByqDmxKuk/FfCYoU2HtU7hdkuZYJ6xwiOp3nhXrsIF++PX4TVnt
	 2ZQpwJ6VWfPq9yNbrzYpBuHkm9Vgt7TL46FBkJMKAu6yzXxuG+CJzxXMtPvqoWO5CF
	 K75udfwe5iklckYNXUP21uQSYJx8zucM24JmKcO85CYzsXsAzmC2XRBCL8zFjZIoqL
	 yMx8+U2TlZbX4eJzDroPws3lUDIxP77Z1H/9daFpC3QnhRugYNdeFEGkOjIBr6OQVN
	 BOFMhZWYAwlMTydy5uY+RonPGVLTqPZmnYgzkCwNIf+leX8rJ+BhjGj0nsRfdeCgNw
	 fECfkaRK1uD6A==
Date: Thu, 6 Mar 2025 08:01:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8m4vzE36UHWjwep@kbusch-mbp>
References: <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306141837.GA21353@lst.de>

On Thu, Mar 06, 2025 at 03:18:37PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 06, 2025 at 08:12:03AM +0100, Hannes Reinecke wrote:
> > Single ported.
> > There is a range of Samsung NVMe where one is a normal, single ported,
> > NVMe, and one with a nearly identical model number reporting CMIC.
> >
> > Causing _quite_ a lot of confusion with the customer (and L3) when
> > used under MD, as for the first hotplug works, for the second ... not so 
> > much.
> 
> If the device is indeed entirely single ported and Samsung can confirm
> the setting is incorret and not easily fixable by a firmware update
> we can quirk it.

It's not one vendor or device. Making this a quirk is a good way to get
the mailing list spammed with requests to add yet another device to a
quirk table.

Or consider a true multiport PCIe where each port connects to a
different host. Each host sees a single port so they're not using
multipath capabilities, and the admin wants the MD behavior that removes
a disk on hot plug. Or even if one host sees both paths of a multiport
PCIe, they still might want that hot plug behavior. The module parameter
makes that possible, so some equivalent should be available before
removing it.

