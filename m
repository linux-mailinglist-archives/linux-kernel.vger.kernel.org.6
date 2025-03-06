Return-Path: <linux-kernel+bounces-549183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F26A54EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83641897D80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19C020CCF4;
	Thu,  6 Mar 2025 15:17:03 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A31FDE37
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274223; cv=none; b=hvJ1QX+cFyvdu5b4iKgKs9rYw8gPZ1xvpACJn+tZEAtqrI/pxMtPWJuJfB77xxxmNYUeTB0D14GIfgPTJCsvQoQJf2SQbOjfMJCwzq1iljpO0fEEoVgP9i8KA53AnHfAd+6XoHeSn9+o2Z8IZiYMwz6//HQHPP+NXWWAJjS1WX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274223; c=relaxed/simple;
	bh=/IKJ4cvE8EfwkcDpOfePKAOZq4NxpraupgUJ0cu/nD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBbr7yRqMKpzoIDzfv+teu0d+/LnuJLFdwDnnRIlCXYQM5J1iGu8kuCD4uYXUV+nVXaB8dhra6JWwO9eVOPga7s/MT6oswopFg/crdung90sRORG7op2ovW53CQJAhTQkgy2VpM+4J38WGzdMUrFF4h+ggYQ57MWR+MED5xE+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A15AC68C4E; Thu,  6 Mar 2025 16:16:54 +0100 (CET)
Date: Thu, 6 Mar 2025 16:16:54 +0100
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
Message-ID: <20250306151654.GA22810@lst.de>
References: <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de> <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8m4vzE36UHWjwep@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Mar 06, 2025 at 08:01:19AM -0700, Keith Busch wrote:
> > If the device is indeed entirely single ported and Samsung can confirm
> > the setting is incorret and not easily fixable by a firmware update
> > we can quirk it.
> 
> It's not one vendor or device.

I've not seen in in the wild so it can't be that common.

> Or consider a true multiport PCIe where each port connects to a
> different host. Each host sees a single port so they're not using
> multipath capabilities, and the admin wants the MD behavior that removes
> a disk on hot plug. Or even if one host sees both paths of a multiport
> PCIe, they still might want that hot plug behavior. The module parameter
> makes that possible, so some equivalent should be available before
> removing it.

A module-wide parameter is absolutely the wrong way to configure it.
You'd ad best want it per-controller or even per-namespace.  One
tradeoff would be to disable the multipath code for private namespaces,
although that would cause problems when rescanning changes the flag.

