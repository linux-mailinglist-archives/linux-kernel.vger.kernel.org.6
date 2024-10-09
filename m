Return-Path: <linux-kernel+bounces-356480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D69D9961AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451711C24889
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B53188722;
	Wed,  9 Oct 2024 08:00:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A118870E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460858; cv=none; b=bN5c87Utq0udgyIbXFov+9+ZXvB+EiiiQG2VensV2UX8APHq9WpNHTUZrZvENsoJk/zGBd5Q6yAmToFPkiL68muyYG0YDcNz5lhNT7BzacMxa4B4QTpzUmIposnX3dPfE/qtSIdZ77YeVhXwL4Z66FAyBUjDJDbPA9hz7AgIDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460858; c=relaxed/simple;
	bh=axFQRrF2Y8HkeQ4+fO7T8+Nt4YU1FpmE7EWBJtnvsvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEFJLxS8PGxB8nCueGUDERm8IMSHdzhKAqfUgShInRanEwzE+J9zuY5Vwye/D+9kZ9ppz8lCVfN3fWjtdTsZ33rHwOmaM8M6hhPL0qNhbf0WOU9nobNaeShartkLpPhfvSt5WDUH38PhtyVZx3/BvI0Wq0X7pWvHr+AA5cNAHqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FF24227A8E; Wed,  9 Oct 2024 10:00:52 +0200 (CEST)
Date: Wed, 9 Oct 2024 10:00:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kbusch@kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
Message-ID: <20241009080052.GA16711@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com> <20241004101014.3716006-2-tero.kristo@linux.intel.com> <20241007061926.GA800@lst.de> <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 09, 2024 at 09:45:07AM +0300, Tero Kristo wrote:
> Initially, I posted the patch against block layer, but there the
> recommendation was to move this closer to the HW; i.e. NVMe driver
> level.

Even if it is called from NVMe, at lot of the code is not nvme specific.
Some of it appears block specific and other pats are entirely generic.

But I still don't see how walking cpumasks and updating paramters in
far away (in terms of cache lines and pointer dereferences) for every
single I/O could work without having a huge performance impact.


