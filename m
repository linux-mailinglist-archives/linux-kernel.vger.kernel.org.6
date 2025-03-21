Return-Path: <linux-kernel+bounces-570772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E2A6B453
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54053174741
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C51DEFD2;
	Fri, 21 Mar 2025 06:17:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925828836
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537853; cv=none; b=F1YI/NjbscIOYc4yDoNg0Vyc2TxzE/NaKy4S8RQsy17QqHAsmz5fZ9JY1aQ1Qq6d3M/ozOLmfZylniIcxjn0d+Q8Im+pHjDkUeObnRCgdpEK/6wjuYyqq24QI0XseFaCXXNmCAXboePawieJ8qq4azk57CuvnZgnBSsblaFxzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537853; c=relaxed/simple;
	bh=c5KZlB2CmXF0TxBjyWqynI/I8sJE7X34iLiQXBNIW3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0ddS+moB30xmZPL2J/jug1RqIqiDxTK0FjvAt9WIggv/RUFgBvPsrwSrvE1lJb7t8j8DWSchctzuMlc37fXHgiTtu0q530NvNq+XQo9BSlnIiu8sprV9V4AJoaOOXnlC/rtKZebr6Qapi4M6edOrhqbDhm0ew5yUBlKhf0KXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3C6768AA6; Fri, 21 Mar 2025 07:17:28 +0100 (CET)
Date: Fri, 21 Mar 2025 07:17:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 14/18] nvmet-fc: take tgtport reference only once
Message-ID: <20250321061728.GF3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-14-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-14-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 11:40:08AM +0100, Daniel Wagner wrote:
> The reference counting code can be simplified. Instead taking a tgtport
> refrerence at the beginning of nvmet_fc_alloc_hostport and put it back
> if not a new hostport object is allocated, only take it when a new
> hostport object is allocated.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  drivers/nvme/target/fc.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 8b14947906948c8b4914932837b4ec90921b419d..b2f5934209f9952679dc1235fb7c927818930688 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1030,33 +1030,26 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
>  	struct nvmet_fc_hostport *newhost, *match = NULL;
>  	unsigned long flags;
>  
> +	/*
> +	 * A ref on tgtport is being held while executing this function,
> +	 * thus there is no need to take first one and give it back on
> +	 * exit.
> +	 */

I'd move this above the function and shorten it to:

	/*
	 * Caller hpolds a reference on tgtport.
	 */

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

