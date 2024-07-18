Return-Path: <linux-kernel+bounces-256696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03C935213
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E27FDB21AED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1F145359;
	Thu, 18 Jul 2024 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDg/J4k2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCCA144D18
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330210; cv=none; b=BnfkHs1B6eNqKlquMKRJsVpXE2R/E1PBIS92igYlQXH4MhwY/cmxyXXMiESXzEhiiRlcZs/VvXiSfbeCAI5g02vs4A7j0uOwzpGdOdJY+PIl6ORa1A/6UlmqVC76STNX+Y0dFtbPIxSOEYSPNAOT7ViPfnBgt2njUadE32rcqNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330210; c=relaxed/simple;
	bh=eDCnd5H5vIf/+mrtWj8r2mfvUhJRojFzzzsC79M3Bj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve8A4z3QNANGkUUWIPYz+1kF39KRs2bb+5bpaMXu3eP7/Mcf11NTLvhdiImlfAouIn2qcsNt0zF/o0Jnls2WpakpucQwK7wTJl8yXAwLShu8zllr70H8604eB5Xzat2KDFom17/RI7HHmf9GofCNrUzaDG6CPPwNXSlVEVC90YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDg/J4k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88087C116B1;
	Thu, 18 Jul 2024 19:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721330210;
	bh=eDCnd5H5vIf/+mrtWj8r2mfvUhJRojFzzzsC79M3Bj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDg/J4k2APxYP+ro8Pnfgy7hs7GKaW2wtSAqXOSw4O5310y6jqJUugqZKuKUsXdOj
	 IuOPYvi1rkIaSOfmm4a2kNK9qmVex+vzA9MGp13UrF6BzynjJe3r/W7rXFd4y+xk7u
	 6nlh8bM9tkHBAUXQxpiNPVNs51otEBhQuXs+2fzZWSWtQeL32FrMiY0XnGVS1q9da0
	 5il/HpMZrkndiL98dMP7JnPCMdkoALw+4KDZ6i0VddHgLozOQSi3RjmmuWjgj2RYlD
	 uMEG+i92m27Odlyc8bv087y8e7h+xPdqA0FYsA0QiD9nmo7X0y0pVQD7zXnEYeoIkF
	 jhBEA9jVw5LAw==
Date: Thu, 18 Jul 2024 13:16:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <ZplqH6uNn4IvULMS@kbusch-mbp.dhcp.thefacebook.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <64ec91e8-4ff2-4c56-a468-c194f803db6b@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64ec91e8-4ff2-4c56-a468-c194f803db6b@t-8ch.de>

On Wed, Jul 17, 2024 at 11:16:19PM +0200, Thomas Weißschuh wrote:
> On 2024-07-17 13:55:50+0000, Stuart Hayes wrote:
> > +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
> > +{
> > +	struct async_scan_info *scan_info = data;
> > +	int idx;
> > +	u32 nsid;
> > +
> > +	idx = (u32)atomic_fetch_add(1, &scan_info->next_nsid);
> 
> atomic_fetch_inc() ?

Good call. Also, that returns an int, and 'idx' is an int too, so the
(u32) cast inbetween is unnecessary. The highest 'next_nsid' could
possibly be anyway is 1023, so int is fine.

