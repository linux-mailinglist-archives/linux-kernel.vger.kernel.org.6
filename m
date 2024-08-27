Return-Path: <linux-kernel+bounces-303655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718CB961317
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2619C1F248B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5591C6F76;
	Tue, 27 Aug 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkYNZw6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC551A072D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773331; cv=none; b=rGRo3UX2sHgp/Qco1avb/LBD4dFz/2yEMMjTCMTNA4o3WE06Wh6OuCEDiG8Gjg7cllriZ7oJIsonVQi39CQMeH66gZyoOJE2qzsL1oh19WDe+Ypoh4eh49kgl90DX1s71oSL9Ggz/eizwYgb5kw8dihs12CEkwKLIAQ6FbXlhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773331; c=relaxed/simple;
	bh=ct6HsZJM+KbM3jK/pFTdFUUrmqP2gqx8ImXYUPW9F+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtslsu6lp5EDx2wwFhXp30u855kRLZxIjc4qSrSu7LoXP4pmbxIO9kXBKd4OlBi7l+PNyc27uyATSKK0ORNbDvCP0fCo15DIuVHlyHOp8VY3FeArJjrN/yz0SteDGuhGjUKSkiKtLEL8FfE+UJl79j//0Np9v4uFBBHrZkdRYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkYNZw6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60AC4AF18;
	Tue, 27 Aug 2024 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724773331;
	bh=ct6HsZJM+KbM3jK/pFTdFUUrmqP2gqx8ImXYUPW9F+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkYNZw6M+QD0ekK/X/XfDOnHo+5zWJ/ZTs1SSSgbHuf5TDE8kEIAuNMiooKqkoDDZ
	 EtNHIgPu3pY5p6JsFT37HOzFq9OKJ2++cYqJ/Vgwzz0VlmRpxe6arYZVwJ5IoROluk
	 b3w3DF6dJQmZR/MjrTOdHCrKRQAPO3cIvCjTGDNLayST2pcPrOybkKsbODnuIPmD10
	 dItZ9i0sFGpqRMjej9NC6oXP1j3V3+1XEelKPKAiX4kk1F5gGwrluxyPxwZbbguLwC
	 Lxc25vQjLhXMoFwqrRlzrmIQCzjImpGgO+w/vukd1Oc3S7zaahv81wpUeSs6Ec/EgX
	 auoxW2bASVwTA==
Date: Tue, 27 Aug 2024 09:42:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <Zs3z0CNrREMYafoC@kbusch-mbp.dhcp.thefacebook.com>
References: <20240827121701.48792-1-pjy@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827121701.48792-1-pjy@amazon.com>

On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
> @@ -122,6 +123,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>  	struct bio *bio = NULL;
>  	int ret;
>  
> +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
> +		return -EINVAL;
> +

Should we also fail if there's no bdev? The driver won't use the
requested metadata for admin commands either, so that is also an invalid
user request.

