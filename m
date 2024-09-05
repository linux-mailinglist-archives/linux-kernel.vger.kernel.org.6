Return-Path: <linux-kernel+bounces-317404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B501E96DDB0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83F01C25CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD8198824;
	Thu,  5 Sep 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="M/9E/qtt"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E793A16F908;
	Thu,  5 Sep 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549242; cv=none; b=SGORPrKDVb9e0lDAHVlfro1GAeq+eDUmfLYJx42MPIQhPjRt1ORQ/ylR37VOm9a+aBIjprCPb8mXNY7S3AWVXacF2kNNA0nhPJiuB9i2MPLe0FDPQQWbwguvPB4BF6Dv8bxGugoGjJi3WgyPKY0ANhomoke0vxns8m0/bqrD+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549242; c=relaxed/simple;
	bh=fSm2APFItgpqcaLONseReVFvV7CdMHA5twyw+retTCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxC9cMPP+UmoHcgcNxJO6pD7As9d4Vhv1Ox+zt7UPZYT0qnqpjvyroNRvQzCqCzyfylkFaBPM6A70yNWgBvxajsnLqLB9z+5QYNT4VUi49gJdkmpbPihKMaWs0E0k8aQmdAdfnhkO2ZMOJtv5kwIHZa5IJO3Wqvll7tGzyOKgsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=M/9E/qtt; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3CBC9288723;
	Thu,  5 Sep 2024 17:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725549234;
	bh=fSm2APFItgpqcaLONseReVFvV7CdMHA5twyw+retTCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/9E/qttFn1bzMGap9dH4u3pb2hzSEOSTjRFJpK7XVARpU2wSiHxIJIA25JxBVBoG
	 9zIR88oxPi4XteRdah4aleprvBETYkhOMRlot7CUGaWV84H/JO5PsOjd8W0MgpAG3a
	 J8F5miVJ+FzF7FomaHgyBbq6BSlYy0Mbqr0LMwEHEX3C1rzyzk9yjSxdBlk6ghREcy
	 egg1jVLsRmKYquV3zs5KYlzaD/xfkIHOz4ut1gYQ5xnzMztNa7UkGTbDgBbwT8aTj1
	 g25yr/8ySyOwSUdhC0C2x9Xs5hr1jnLlEqoOBbsgfPyrg9KK3jOJ/Xg4lgKCWL9UC5
	 boWvVxmSP3K4g==
Date: Thu, 5 Sep 2024 17:13:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
Message-ID: <ZtnKsf71piBohHt_@8bytes.org>
References: <20240905072240.253313-1-joro@8bytes.org>
 <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
 <Ztle72HfrjBjlJGa@8bytes.org>
 <20240905120531.GD1358970@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905120531.GD1358970@nvidia.com>

On Thu, Sep 05, 2024 at 09:05:31AM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 05, 2024 at 09:34:07AM +0200, Joerg Roedel wrote:
> > On Thu, Sep 05, 2024 at 03:31:08PM +0800, Baolu Lu wrote:
> > > "iommu.nohugepages=1"?
> > 
> > Generally yes, but that requires to touch all drivers to make the
> > behavior consistent. We can start this effort on-top of this change, if
> > desired.
> 
> Let's at least use the same keyword that already exists though??

You mean amd_iommu=sp_off? I am not in favour of that, in the Linux
world the term 'hugepage' is more common than 'superpage'. So I
would avoid spreading the use of the later. We can extend that later to
the iommu.nohugepages parameter suggested by Baolu.

Regards,

	Joerg

