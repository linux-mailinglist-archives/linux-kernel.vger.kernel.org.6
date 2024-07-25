Return-Path: <linux-kernel+bounces-262332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8D93C42F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F56B1F2107A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6034319D083;
	Thu, 25 Jul 2024 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0uEhNqg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9119D06B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917772; cv=none; b=EUFQLyFKZBkWUCSMnoJrGpNTlWyuDnWQYSc2+0meS32AOAlIWOkMGJxWhh9MFSmNON0pRFAXU/Zs5PxDy1gbli0/jqShHku1llApPrlDRS0Uf1DoISl8tI/1xPDoorD7ArOBCciyNAW7A4IC/VjT7AcrPJO2BHegFktrIs6z/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917772; c=relaxed/simple;
	bh=YPVwZISppMNNtJugbjRyRBJF+SaRqxTdU9F8rN/Mnkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnK7l5sEOIU7hIc2iLObAfZOd7EJEJrxxsrYw6AYjik1DRpEcOCKKjX2CfnmXDmCS3UbP6J4Xn9lycFNsSSfGL996VkGKL7b4Jzen8tuRJOXwtOHauMxYf55wRjc/qJ9E9EYTe8746/GdtZq+s25juhrZjrweATIYO3jyMS7rJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0uEhNqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807BDC116B1;
	Thu, 25 Jul 2024 14:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917772;
	bh=YPVwZISppMNNtJugbjRyRBJF+SaRqxTdU9F8rN/Mnkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0uEhNqgT5Few0Nfy/+a6Yu5XDnK3jQeKnhnYFP/IeX6rFYlhAPtm33PyE1ymY9Ko
	 4zy0S/xGEKohwF54s5rCiqdQdLCGe6emL8Cgmneo/wkcErL0++/wUZ2Ct3MbO+wMKi
	 1kVXXGBazcHEC/x3sRi4x2FpLKemi8cL4Fi63rvcI6koIv4ND757aMlUl3oA/xh0wt
	 l5oDgc6OZwSEl3wbWWiwQY8Rs32Ixv0adT6z1sYBb1LosFZgziBIfhYJ0MJ3vZVDPG
	 o+ht2mJ9b62en7rLGxONFGfjeh2YPA2DC01VNL0ktc1v6Fb0QmSgmsKJnkjyYHuFD3
	 j02P+8i+PVgfQ==
Date: Thu, 25 Jul 2024 08:29:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <ZqJhSZw7Gww4SBTE@kbusch-mbp>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>

On Wed, Jul 24, 2024 at 01:31:14PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> nvme_map_data() is called when request has physical segments, hence
> the nvme_unmap_data() should have same condition to avoid dereference.

Thanks, applied to nvme-6.11.

