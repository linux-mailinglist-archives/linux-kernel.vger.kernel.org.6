Return-Path: <linux-kernel+bounces-312372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507719695B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0718F1F23332
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526C21D6DCE;
	Tue,  3 Sep 2024 07:35:27 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BCD1CE700
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348927; cv=none; b=l/ka2ksQsWOJzMv9lXH6tQnejxG+GgLQUIwTtu6YsoTnj2lavYabzVMQTrowEg61SshN8t47W9m+IERo+frx7AGshzeqw8mWqjufsW9kjkFpaKTyIjbsLmgp2TKjVHcUCtFXSFqTrViQig/M49jUi5Vs8l8torlfVxr4DVbnE7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348927; c=relaxed/simple;
	bh=L5dtt8qQfTMhLLtafcf0rW50PFnHUJ9iWp786DZnYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB9DKvkAzFJPxvVP+z1ulcc59kLKLJcbhLxzIHjYLBbELIdGlAGbG/AC4BFAWEKbdJ+f7cfM5w7EgotzfnsOXut/nS3NSBtVIsnc5Ht2f8PZCIMQJSqaiyOpktZGMKB7mPj/sl4CrB5WjlI0uiHoRBETroirHJUGTqpUN6pXlwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D800C227A87; Tue,  3 Sep 2024 09:35:21 +0200 (CEST)
Date: Tue, 3 Sep 2024 09:35:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: fix the page free when it is not
 addressable
Message-ID: <20240903073521.GA2269@lst.de>
References: <20240831110119.200377-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831110119.200377-1-yu.c.chen@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Aug 31, 2024 at 07:01:19PM +0800, Chen Yu wrote:
> When the CMA allocation succeeds but isn't addressable, its
> buffer has already been released and the page is set to NULL.
> So later when the normal page allocation succeeds but isn't
> addressable, __free_pages() should be used to free that normal
> page rather than freeing continuous page(CMA).

So the patch is obviously correct and probably useful, but I don't think
the existing code is buggy.

dma_free_contiguous calls into cma_release, which uses cma_pages_valid to
check if the page belongs to the CMA pool and retuns early if not,
letting dma_free_contiguous fall back to __free_pages eventually.

What am I missing here?


