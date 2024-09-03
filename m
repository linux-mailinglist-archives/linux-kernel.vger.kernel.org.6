Return-Path: <linux-kernel+bounces-312423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE5969671
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA4EB20DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2A200117;
	Tue,  3 Sep 2024 08:03:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8D1D6DBC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350584; cv=none; b=EQXy6QPSY2nGAXBaeqsgP1K0e+WLM2JgNivB1uUgE3F+8Z4STEcjTZTulXzvTfFtnwMbC73oUBmvjaDPmVqLNltkEKUI5YriS19i1+r3c9p/tt9D7qFae3DL4GW4pPb1zTdhz89UA53BsO7HE8wnvQjo6YM5qLh0ptbZCeGYGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350584; c=relaxed/simple;
	bh=NP5ua0HfwNlaj3aou7hr90oqWQ61oT4b0kihgmmZuA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S96v06+cRCZRxKMaP4ncc2Knx6PaF5yr2qhwvNYGUHOO0VUHbtdCQKtLULsB/dYmSJFMx0PouRgbLY+N3N3PYKQ+8yHOafTp0SrIwAwx/y31VL9Ne7ZdIv65ByFltTuI9oZgkn3VJ2NtId1RetpTqJypaT4YPmy+ZmnqFJvXjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE2A1227A87; Tue,  3 Sep 2024 10:02:57 +0200 (CEST)
Date: Tue, 3 Sep 2024 10:02:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: fix the page free when it is not
 addressable
Message-ID: <20240903080257.GA4746@lst.de>
References: <20240831110119.200377-1-yu.c.chen@intel.com> <20240903073521.GA2269@lst.de> <ZtbCLmsIF3On+aEv@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtbCLmsIF3On+aEv@chenyu5-mobl2>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 03, 2024 at 04:00:46PM +0800, Chen Yu wrote:
> Thanks for taking a look. Your are right, the pfn will be checked in
> cma_pages_valid() to see it is within the CMA range, if not, it prints
> some messages and return false, finally falls into __free_pages(). From
> the functional point of view, there is no bug. From the efficiency point
> of view(extra checks/printed message), and from the code readability to
> avoid confusing, maybe we can refine it?

I'll apply the patch with an updated commit log, thanks.


