Return-Path: <linux-kernel+bounces-260093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F693A2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71081C228D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B00915572F;
	Tue, 23 Jul 2024 14:39:44 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4064814F122
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745584; cv=none; b=e5oP2/jmch5N2o6kSWCRNXzYjlobuAY9PI8hUrc99PFt1LE3OY+cEeelGuQPvMgYiKQUK/qxBlx0mmYy8gHy6Yv1sRnRKpSv61mYPL/lg246gi64p1TqbrnT4TSrnEpaYrMqY5Wx08SGYZGuvYCg7lXZpzITiAKtZHpbykJdJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745584; c=relaxed/simple;
	bh=yyiHY2OEGPNGftiY+4S+aJGb6KYjgz7vOmeBFgHvSKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guQIpivBCwZwpiv0rA+p0MxQclqqJtNQ96q/guEpFvTy4nLPs7XnRFGaOnkM/x0NkZnxuKvGkvrT5x3S80e+uOgYEr3kFcWWqHgoVtnZwwfqj6hx9bdJ5+ZbASoKkMlcquxNgT2CLOq6fPq6xWMsZDZltuRMez8tdr0+QS31rlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D747068AA6; Tue, 23 Jul 2024 16:39:37 +0200 (CEST)
Date: Tue, 23 Jul 2024 16:39:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Pratyush Yadav <ptyadav@amazon.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <20240723143937.GA20891@lst.de>
References: <20230725110622.129361-1-ptyadav@amazon.de> <CAFL455=O23ci6GCzdnJr8DmyVSXAD=ctmj4AEk=XfSSLjbUQYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFL455=O23ci6GCzdnJr8DmyVSXAD=ctmj4AEk=XfSSLjbUQYA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 23, 2024 at 11:49:24AM +0200, Maurizio Lombardi wrote:
> FYI, we have received bug reports because of this patch.
> All single numa nodes like a VMware guest or a system set to interleaved mode
> will now see -1 as the numa_node attribute.
> 
> Apparently, some applications like Lightbits do not expect to see -1.

But they can see the same for all kinds of other devices.  I can't see
how we could cater to this kind of behavior..


