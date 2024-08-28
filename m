Return-Path: <linux-kernel+bounces-305182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4086E962AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C06ABB20E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BE619AD4F;
	Wed, 28 Aug 2024 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUs28LMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1650819ADB6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856303; cv=none; b=Zl54/cxBdyrvHtsXQowfiHAw4/UAiORyIhty5SxxzusPUZ6a63V6VEnEj+PpnJfYvyVBq/MhzyIP5cNuDT4IOwuS3w0BlDCSgDwzyCYRIhwCYiFqUXthm8JAz7v1IBF94d7WMrd3FY19NRMW32DFFrt0ohHkYYu7YKhiqQGACzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856303; c=relaxed/simple;
	bh=C/owWcqokpG1H1qQ8ELjChlBOTZP8wQl8nYAkusz5SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj23klhKwlxLsvW1EBBnZEWQzeJbsw3J1mQObB/9FIlRTd10YXCk+7+k47XxxYNKWu1ZwOP26nEBMv+jtDVGg7TsQCJAqaDRwa9PWnkZRoo5lB4g0W4SoNgZQoJOUonMRu88cJTsqn8Xw3WXSbvdbDPGLYeY/TI4B8CvWSV5eUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUs28LMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953DBC4CECD;
	Wed, 28 Aug 2024 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724856302;
	bh=C/owWcqokpG1H1qQ8ELjChlBOTZP8wQl8nYAkusz5SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUs28LMJjS2z9EXeYHwLdxMaS9CJ4uXk+f5yd/xfU1Eq7558tCzdVxh+kORjemX+d
	 As2Gd+y2Vl2x47PiafwrkTdVXcq2qIuYQwPPr4+uvPFS8E4m+BmZCQhBnPqGPoDh8S
	 VFBinZiMJZRvTAzt9Tc7v3igidZIPqV3jrzhXyab0SW2CmyLAZyKcGIy4D8upFvciS
	 jgcSzitReH1zTyiIzxQj54fTbbSXbkZ9pMirNFGvVc4G421sLhekr6Pw9VkmaLkw6s
	 FpHZzU0o6p6cHpkEv9vQhKaUIUMOeyg9NSep7dy7VFObXy2LwVtiONTVWVOnAMXWhF
	 rdu8SnNigJyxg==
Date: Wed, 28 Aug 2024 08:44:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <Zs8360kRPGa1B5xy@kbusch-mbp>
References: <20240827132327.1704-1-pjy@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827132327.1704-1-pjy@amazon.com>

On Tue, Aug 27, 2024 at 01:23:27PM +0000, Puranjay Mohan wrote:
> @@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>  	struct request_queue *q = req->q;
>  	struct nvme_ns *ns = q->queuedata;
>  	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
> +	bool has_metadata = bdev && meta_buffer && meta_len;

If this is an admin command, then bdev is NULL, so "has_metadata" is
false.

>  	struct bio *bio = NULL;
>  	int ret;
>  
> +	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
> +		return -EINVAL;
> +

Since has_metadata is false, we continue on to process this admin
command, but ignore the user's metadata settings. Do we want to return
error there too?

