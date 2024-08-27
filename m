Return-Path: <linux-kernel+bounces-303265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC1D9609EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF29B227D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CDB19F466;
	Tue, 27 Aug 2024 12:20:02 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C01A01BC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761201; cv=none; b=gTkUiNuSDFLtEB1iorme9BqAR2OSLLCvBtCQxPaNaT7MXqMqfODGJJhBvcK7UbfIcICKHmW5tGL7IX85vbvGJghJdAsFqow7ilJOsJcBi4BhBeNyElw4iSHiX5+3ORTLAb7BnqEco6reHFel+kK0y2Px2KxNSBM5SlrO7ppNV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761201; c=relaxed/simple;
	bh=8P/gIg+eojACiT7mqGXAF9k1AqOUqV2qozB88rWGfLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lO/0+9Qw9VbMWBUutcG2SJGsAu8hgEzxQv114eVOjtkHRK62rZFH1Dm9E16SfXd09q4tXAujhtrPBr0g4pSKKse8rVjgy9UKRBEHtiC/44vfQCl9qwEV6IsB885FjERKVp+yvksQ2Ti+IswDD5xJoB5FPADPRuvq5QJdmhJJluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB90768AFE; Tue, 27 Aug 2024 14:19:55 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:19:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240827121955.GB1607@lst.de>
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
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
> +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
> +		return -EINVAL;

Overly long line here.  If we go past my initial RFC I'd probably
restructure the function a little bit, i.e. add a new

	bool has_metadata = bdev && meta_buffer && meta_len;

and then use that both for the support check and the actualy mapping
below.


