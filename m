Return-Path: <linux-kernel+bounces-554331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE773A59646
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADB47A5A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551122A818;
	Mon, 10 Mar 2025 13:28:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C1227EA0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613301; cv=none; b=fQTafHtavxbtoeG/m1y/h5oNrJGMHiyS0T4n3rwp2i3P1XkbUk4KlUizu++xOcOhCq/yg8t0fRZ0DduaUwoAR5o14xam67C4XQSoc2/X5z0B2bC3fMQ7Trx/ML8MZhLatbPaGFRWB+bfUm34X1/l06sBr+L7/Quz2HiE2mmR7Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613301; c=relaxed/simple;
	bh=qZzsgzBHn6Cmkaes12sBstWbDAq01HmfuX9Of2oYJ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6hOD+fhSOo834DqzeXn1NeajssYlVp9/V3RZ3jTcCP3iot82OvRff5Iy+Qn+52VMwCt6uM/RO2yJovt9qXnB/I8mwUli6doI5DWtJhqr6FcYlXfrwEsjzguGMW3Yx4/ndUeF27fX6KMxin0c0P4EPRI5gzQmtMli/Uivrh4ABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5DE6667373; Mon, 10 Mar 2025 14:28:13 +0100 (CET)
Date: Mon, 10 Mar 2025 14:28:13 +0100
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
Message-ID: <20250310132813.GA8956@lst.de>
References: <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de> <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp> <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pB9jQALxMN6WaA@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 06, 2025 at 05:46:46PM -0700, Keith Busch wrote:
> On Thu, Mar 06, 2025 at 04:16:54PM +0100, Christoph Hellwig wrote:
> > On Thu, Mar 06, 2025 at 08:01:19AM -0700, Keith Busch wrote:
> > 
> > > Or consider a true multiport PCIe where each port connects to a
> > > different host. Each host sees a single port so they're not using
> > > multipath capabilities, and the admin wants the MD behavior that removes
> > > a disk on hot plug. Or even if one host sees both paths of a multiport
> > > PCIe, they still might want that hot plug behavior. The module parameter
> > > makes that possible, so some equivalent should be available before
> > > removing it.
> > 
> > A module-wide parameter is absolutely the wrong way to configure it.
> > You'd ad best want it per-controller or even per-namespace.  One
> > tradeoff would be to disable the multipath code for private namespaces,
> > although that would cause problems when rescanning changes the flag.
> 
> It's not really about private vs. shared namespaces, though.

PArt of it is about that.  A private namespace can't have another
path.


> There
> really is no programatic way for the driver to know what behavior the
> admin needs out of their system without user input. If you don't want a
> module parameter, then the driver will just have to default to
> something, then the user will have to do something to change it later.
> Not very pleasant compared to a simple one time boot parameter.

The point is that different devices want different behavior.  Think of
a fabrics attached array vs a usb4 dongle used by the admin.


