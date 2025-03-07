Return-Path: <linux-kernel+bounces-551433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33BA56C58
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0558164328
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA23321D3F8;
	Fri,  7 Mar 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9RYZvUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D381DE3C3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362187; cv=none; b=Xy5vQl+bfnuDy8Stn9vOAObJWuGSzoKmmhG4ddeeueYBe/+wbMThfnRjIDSqwxbPcdGI09A9CIqOL7afh2BsWdzuFBiWWr1hwFIc8+gtSvRFCbWrfLmneQpmfmFllvwCIZdBgWh3DD1U0gwt3R/Ha8slPMW1FRfcVe0n36l1sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362187; c=relaxed/simple;
	bh=VgH0UurqNrPQRnOJzP1srSiyWoUpHvrVJDCtSjug9hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnC5gMNf5CLj/Y5OxSnklylBvU9kvgjL/ZuGisvunIK1ug17qSXgVB1ruBVBAF0/9K61+4uaUS0BuKE7T3BsrLGeOgLUnP7U9gj15xIxKcJbeQuSQ+ZOTgb159vVhxcupRiaoVnG0e8G+Rl2TUwrxS+5/PdtTDHTC/rqUydiCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9RYZvUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47CEC4CED1;
	Fri,  7 Mar 2025 15:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741362186;
	bh=VgH0UurqNrPQRnOJzP1srSiyWoUpHvrVJDCtSjug9hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9RYZvUOBW79UPzNkSH0OgKtZkU8sd2kvkXsm6zBBkOzH3vxuIcrU7GiSwVDNW9Vn
	 uDv1qYJGRcdBVrfB1CHZL2xdLoL7+7z7g+zdrsyPT3opqGx6u/8NAgbFnaVgE008VK
	 D+untZ9txPJfJrTQmko297MppiWSQTnL8BWh8o4z0TbJr56cEtieoupy5QZ+2fgMHm
	 vFX4CAKkA6rnKEF26F3AaRu2UdPfKiOPi743+8nr74Jl2fMHHIwrdkuJDS8JqBXFeW
	 3HZvOOiHbKbhxnk38f14j7VnlJiud/p3fMaF59Fb07NC1iV22R46t4vfBsQ8vZVaTU
	 ZGINQSE44SQWw==
Date: Fri, 7 Mar 2025 08:43:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8sUB2bbbMsurZmu@kbusch-mbp>
References: <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de>
 <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de>
 <Z8pB9jQALxMN6WaA@kbusch-mbp>
 <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>

On Fri, Mar 07, 2025 at 08:49:09PM +0530, Nilay Shroff wrote:
> On 3/7/25 6:16 AM, Keith Busch wrote:
> I think always creating multipath head node even for the disk which doesn't 
> have CMIC/NMIC capability should be useful. That way, we may then be able 
> to remove multipath module parameter? In fact, you already mentioned about
> it in one of your previous message. I see two approaches (one of them you 
> proposed and another one Christoph proposed: 
> https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/). 
> 
> Maybe in first cut we should create multipath head disk node always for 
> single/multi ported NVMe disk. Later we may enhance it and allow pinning the 
> head node for hotplug events so that head node dev name remains consistent 
> across disk add/remove hotplug events.

It honestly has potential to solve some real problems, like
re-enumeration triggered by a link reset on an in-use drive. You'd
currently need to close the old handle and open a new on, even though
it's the same device. It may not even be possible to do that if that
device contains your root partition, and then you can only power cycle.

The downside is we wouldn't get the short cut to blk_mq_submit_bio. We'd
instead stack that atop an indirect call, so it's not free.

