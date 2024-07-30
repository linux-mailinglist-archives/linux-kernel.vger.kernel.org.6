Return-Path: <linux-kernel+bounces-267975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D82941EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C3CF282DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E718991A;
	Tue, 30 Jul 2024 17:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiTzS0HH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328B1A76AE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361165; cv=none; b=G+3xRcP5fdRdwaK/JK76BZ26PnBNSBa2n/60jTYtUIhSt4EzdIJdR/K/TZBxN1ZsZftxCBRtnHUPDm8SdR2V+tmN+dN6PqKDWYpM5KQ+sEJyZOx/AWCEpchTVmLiBmCD13BYx5cyudiI/yU3PdbjyIa5feJGAeC/3ValPd1iLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361165; c=relaxed/simple;
	bh=7IQUNO1kOJBp9DfcumXq6iEFLOL/qswKjwY8TjFVz9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kabgq0cpJ8l7tU3zzeW6QW7kkWD6qoU5hOih/uAwcWitGItSWpZZbprw5HhGSqLGHMJyitR2fnGlbLHSDAgKABaBqu8aOEKP6tFeg4aXt4X2t5sEI3VqomDryXUUXuUP2dX6EE9IvbQku6v5nqVjor9toki7u0HOdx1Ys8uLfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiTzS0HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6913C32782;
	Tue, 30 Jul 2024 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722361165;
	bh=7IQUNO1kOJBp9DfcumXq6iEFLOL/qswKjwY8TjFVz9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiTzS0HHo1HnBDfrFLLsjKI5MO9b6axeyhoIf4RASWjsXDyryA+N3nWFlmauw6fea
	 1nfd0BUTEO3AQr25IgWl4o6leykIXj/94bli5NyHlXBD10esePurcoPQDgfgLJXUXG
	 KmkIxAYqrg2Pu6iwaxcPcuFaoVXjjUywWdZ15yUmEYkQYv6HwhDJSvEoEWAuhovZaZ
	 AJ/H9JbKAdZbGoDORxWqBR4WDjviQXNiwdT8mjaVzTb2sl698gfvJzhK1kbZGrjsjn
	 gFB9uGkjGB6qofunJqbdFoV95gfaz/2uNrjTEpWUg9cQv0BdDPIHQUNlt9NP/Mfv6k
	 n1FE/mKuJDHow==
Date: Tue, 30 Jul 2024 20:39:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <20240730173920.GD4209@unreal>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
 <ZqkeMJ5PPETMb5d3@kbusch-mbp>
 <20240730172111.GA32320@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730172111.GA32320@lst.de>

On Tue, Jul 30, 2024 at 07:21:11PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2024 at 11:09:04AM -0600, Keith Busch wrote:
> > > +	if (blk_rq_nr_phys_segments(req))
> > > +		nvme_unmap_data(dev, req);
> > 
> > This is already applied, but it is kind of strange. We get here only if
> > metadata mapping fails. Is there actually a command that has metadata
> > without data?
> 
> Well, passthrough can always set metadata to map without data even
> if there is no NVMe defined command that works that way, so we should
> handle the error.
> 
> But I suspect this is due to Leon's dma-mapping work, and it probably
> points to a bug in that :)

Yeah, something like that. I had a bug in my code and saw this
asymmetry while reviewed all paths which lead to nvme_unmap_data().

Thanks

