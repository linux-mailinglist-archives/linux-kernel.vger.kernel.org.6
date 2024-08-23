Return-Path: <linux-kernel+bounces-298579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFC995C907
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154EC1F21C69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4F14A4C3;
	Fri, 23 Aug 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="zi0p0Yg4"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2F13B5A1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404698; cv=none; b=GDW2BhqXnndIMxlPoymTv9uKRBHoE17w+QEfyyadvhtu/rhoV3SN6AZE7mZoMp4KKM+6sgJx2hifMuCNXBeN0Jr0mKW8Tb1yox0WOJ872vWeZT3Uhpmulty1AJtdwfWJeh7pxvspwMwBMO7DVk1xub5njqP2yct6ZX8qr0h3KUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404698; c=relaxed/simple;
	bh=/lPWVL30lzbw2Z/KCenJf+gD3M11QjZxo9FsS4BrDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5Eiz+SORPOcaweME+KwT5nWVUOJhoAS9XjK/+4g2uxnkrPHJ/vh7440XxccCVEYjubSJZmqpymD1UOOE+iclvIWzhM5LZE4pAJG++AamX0GBbPtVpwcJOt5j8rNX+pO671SuHl+DW7TClO9/X2mHb1by/jPi5GO3sPAZEXrsmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=zi0p0Yg4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D80AA2A7BA5;
	Fri, 23 Aug 2024 11:18:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724404694;
	bh=/lPWVL30lzbw2Z/KCenJf+gD3M11QjZxo9FsS4BrDZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zi0p0Yg46Jc5JyxW6ZtXW0XrW9sV+zqiJjzdD3wPHd2pPUKAWSf2tgAphLvYvX8On
	 k0IToqDinkFx8FRhrgB+sPoekPbJdSPnq477y6tTXrnxPD/jYj73YMzk4mheka5bD5
	 4YvaWAfQMA30JTj5qYRl41SbekWlYNzJ/w8AekOfzlNC4UwlK2mM1Cx1SDEGZo8kDC
	 /n0DMkQqDp+/PfWSr/PHnG3H9pudGfvNa4VtCfv5Yeu8A62AmZFTbLLuHCt6DB1hqQ
	 Fn7LPR2BJZay+BqHa8Pu4aSrlVrZtMzN/n1JkCutMZO8wvXmOETZBRgRt25orwVCvx
	 i8zkQYGVrRcwA==
Date: Fri, 23 Aug 2024 11:18:13 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	robin.murphy@arm.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH V2] iommu/amd: Update PASID, GATS, GLX, SNPAVICSUP
 feature related macros
Message-ID: <ZshT1dXiXZR3qkGT@8bytes.org>
References: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816221650.62295-1-suravee.suthikulpanit@amd.com>

On Fri, Aug 16, 2024 at 10:16:50PM +0000, Suravee Suthikulpanit wrote:
> Clean up and reorder them according to the bit index. There is no
> functional change.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  5 -----
>  drivers/iommu/amd/amd_iommu_types.h | 16 ++++++----------
>  drivers/iommu/amd/init.c            |  8 +++-----
>  3 files changed, 9 insertions(+), 20 deletions(-)

Applied, thanks.
> 

