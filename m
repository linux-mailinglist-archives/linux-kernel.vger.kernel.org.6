Return-Path: <linux-kernel+bounces-267946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19F1941CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70474289A65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382AB1917C4;
	Tue, 30 Jul 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faK3gBo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745AA189B85
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359348; cv=none; b=HOn1DrBkJ95R+FTMuPqKCde9ISScp1ZBISOdhzZPoIWW32pvgHVAB8fI1JCJoFRDwM2y4auHlMPKBwp0w1F4alitU1+QS39dYx7rDBuRbt0WxW1Yi61nZvs6TRZo+uBynkKSpWz/kJXulRSqWNW6RNDCzWzMB6bNoKALCg7xySg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359348; c=relaxed/simple;
	bh=uVyHO6h84g5FxZT8rw+t8wAv43/VQkWOzj0sFQ8gdA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhcjRadOEpIuZCXoxaFIJMHqvA3Ta0EONA2MOP6Btoza1QuppX3zZe2/ZK+HZJcAiiCF6irmLD3dmAmOoWb3ce9+hzSFDFyXDNmxhvthsvmCH2juo855oAT1m2oTt5VhwTqibwqCYwrDYrRrOu8neTzBswm1xUjJTEdC/glc/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faK3gBo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BFEC32782;
	Tue, 30 Jul 2024 17:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722359348;
	bh=uVyHO6h84g5FxZT8rw+t8wAv43/VQkWOzj0sFQ8gdA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faK3gBo0EcDMZr7FE2ObHJueRyB0dG6B3AUV5FufylY9HWC4fEZLHjPpmGYXJbkEE
	 cYiC3buejVbK0VgDZO9m4QNyWk5k2QLkOS3saxdFqsKFOXKSGb2CH4ZSL2fiiJd+/b
	 af2TT7B0mSci19NfgecGaQCyOPMu+U8d349vW4zEV6OsQO2nkBzSCyX+nTSvMAIC9g
	 g4ZORZf4JtVedWNZ4UFhBnXIS4ddkMbi/OwUm1VkwBjgZqkU6Wb+74/gL/iHF4Axla
	 bOehkbdBNY4ScgYz72Kk9wKMY3HQYb8Fkwwex98OhWJXjTJwyRS1XWURKtaom5dLqg
	 IoQadgMIpvg2A==
Date: Tue, 30 Jul 2024 11:09:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leonro@nvidia.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <ZqkeMJ5PPETMb5d3@kbusch-mbp>
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
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 102a9fb0c65f..cdc0b25091e9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -863,7 +863,8 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
>  	nvme_start_request(req);
>  	return BLK_STS_OK;
>  out_unmap_data:
> -	nvme_unmap_data(dev, req);
> +	if (blk_rq_nr_phys_segments(req))
> +		nvme_unmap_data(dev, req);

This is already applied, but it is kind of strange. We get here only if
metadata mapping fails. Is there actually a command that has metadata
without data?

