Return-Path: <linux-kernel+bounces-247049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14992CA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D861F237C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137394CB5B;
	Wed, 10 Jul 2024 05:55:28 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC633C092
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720590927; cv=none; b=GDUIpVM6uJtBcLFzqiM+2zavKAcumGbci1KHEmI1RJeA923+rvoqJDojgRjaOXGD3sKmNLi/NJ4JyqbGxBCkCajRj07R0NUJ/0LwEojL59nApYnglooHufZWi1aG+DN1/i0gvfzaIh8AQOP/XlKTpUjFzgzuaY2dxOMI0FYhmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720590927; c=relaxed/simple;
	bh=jzDyJroF8/afP3GzKI2rmY8da0VGXH1bOwktasOHt5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t28T8xxSABJs0cwQNNop0zL5J3VnSLiXZrJOd8+2TCIAYaV78Nr0LQeOBYbIOQH697MzYAWi8iqNGXuOF0v00zA6Hro/E+TfuDsdij2qX65k2Sofuj68yqzDIob2bGeR2ciXz/CmAfUQiXUSsrxiSIYtw1NMNf8WQj3mzQss5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E662A227A87; Wed, 10 Jul 2024 07:55:20 +0200 (CEST)
Date: Wed, 10 Jul 2024 07:55:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>, mhkelley58@gmail.com,
	mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org, jgross@suse.com, sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com, m.szyprowski@samsung.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3 1/1] swiotlb: Reduce swiotlb pool lookups
Message-ID: <20240710055520.GA25305@lst.de>
References: <20240708194100.1531-1-mhklinux@outlook.com> <20240709111013.6103d3f0@mordecai.tesarici.cz> <20240709111812.GB4421@lst.de> <20240709210818.28116c53@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240709210818.28116c53@meshulam.tesarici.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jul 09, 2024 at 09:08:18PM +0200, Petr Tesařík wrote:
> I'm confused. If you're not a big fan, why are we effectively adding
> them to more places now than before the patch?

Because I didn't want to second guess the patch author too much.

