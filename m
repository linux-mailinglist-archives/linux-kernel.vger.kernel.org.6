Return-Path: <linux-kernel+bounces-212927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857B0906849
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7092833F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8A13DBA4;
	Thu, 13 Jun 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="L2ztk/XA"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F929AB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270196; cv=none; b=Ymk0GNI7f88KFXInzs9zUaSSvfovJ25izQXcPu8dJnCabhshtcFVvcOGuzSju4t2ZSJHyGTPA0RGI4dr5al7MIoAv2mqHmGmgcKrLsi4fzHx4syo4kOo+tFJfsttXiYHBk+R81nfrpMuTSRH+QMnTLKrDLGEY8B8aHc9JJhRYGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270196; c=relaxed/simple;
	bh=LPWIOse+YFlkFcyvFtEOOyBQYQP0Mbqf1JcsJOhIcyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djz+xbF83dUIA3ENZjV+vp6CCfPKFQO/3DsovVVHyMPrSQ8Q9IpY/UwNRrpHUO15NTpIpf95Mlrs2PT0+E6Ky2VU00pfWBkt3336jI1G3HRNdBhhQZC3/OVpcY7UCzCdfm58fGzXCTlGt1z0y8Xb1Rv6cCcyBWdkt25191AV5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=L2ztk/XA; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 944641C0BD3;
	Thu, 13 Jun 2024 11:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1718270193;
	bh=LPWIOse+YFlkFcyvFtEOOyBQYQP0Mbqf1JcsJOhIcyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2ztk/XAasnW7MKlKOWfczlO6ccl+jh2A0pPkt1uASxflfNLfpYHs/WKirS3KUcP5
	 7Af0W0cyPjiRQ/F/T7xD/IiXOw1GYvyKCOTeoL+B+IPp7dAwTFinzEBuwHIXLC5Yov
	 tiMaAe/FbMPy/jAbYugNzEmj/L/EptP9EUqyr1p7u8GhM+HyGN08sBlphaFAb+T+Ac
	 N8RquNzqdn8G1omybxKNrlblmPZSp0REhvowKAwxF4i7AX9rw/Fx603sCiwZV1JE1p
	 fExx7QpHCwskIQyiYWK8E2SPXhWxqZI4j7R81NaQckZVzvCGFepQBReaCMvqL9yo1a
	 rieuqifrIts7g==
Date: Thu, 13 Jun 2024 11:16:32 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	David Wang <00107082@163.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Steve Wahl <steve.wahl@hpe.com>,
	Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] iommu/amd: Fix panic accessing amd_iommu_enable_faulting
Message-ID: <Zmq48DZ04MDhQf0g@8bytes.org>
References: <ZljHE/R4KLzGU6vx@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZljHE/R4KLzGU6vx@hpe.com>

On Thu, May 30, 2024 at 01:36:03PM -0500, Dimitri Sivanich wrote:
> This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
> DMAR fault interrupts locally").  The panic happens when
> amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to iommu/fixes, thanks.

