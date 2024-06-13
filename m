Return-Path: <linux-kernel+bounces-212932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC499906861
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A261F22DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB85E13E897;
	Thu, 13 Jun 2024 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="1UjYE41b"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3DF13E8A7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270277; cv=none; b=SoIuH4+R7+TC5MokfSMeJgBTSn503GLy6C9uttu+BghDNXYWbPTmJb4eHHY+GGG16vewWZwM0YwglQNSBvsr6gK80p5khZLUOGPM69JzRxA9/77JhBZAs/AvSxengfzpJaehDyMhThB7v23yiHLowP+k6sNn7cwuACc6B9Rfj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270277; c=relaxed/simple;
	bh=p8kzm0Lqep3ToXmg6GA1wy29eukb+Rh7R3EbC4CVU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYNgI8ijP7L9ImKBchNZce7092yJmhmGJnURBJCT+qAUQaKmIGO9MPoHczWKzNuOm2kc9PmPN5hHyFBm+J3nTEYs/Co2dYDu/rmBtKGLjd3M5E52WAGN980kggpc8m2bzxpiDyi+EJVyBuGyxQtR72AnQ0NpdCEcjfwxF8dHYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=1UjYE41b; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3785C1C0BD3;
	Thu, 13 Jun 2024 11:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1718270274;
	bh=p8kzm0Lqep3ToXmg6GA1wy29eukb+Rh7R3EbC4CVU2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1UjYE41bD/NcmQRCnVJomsWRUGxXqWEniAp3C1av6UHGGCxeJsJVvz1UMpy0ADzl8
	 axK/udNQmJ58gtGSPUv1XAQsYmAa0RZz6RaMgFzRLTBlJLe2Vst50arTuW0kytKUSH
	 Ja3rxO/lrdPykBZWWalmTfZbkusXFJwbElW8QBm8TrIgtSfkkWJJk3Vpwf4APSdqdK
	 WAA8FZMPB2MvewJjNqlU7F3dUj/EpmnnIf++VS2kDiXAWqW8u12B2EfxSHujVhwiA0
	 YzBsMPXgPRfBLgXSMVQsCCZFZAesOGkjcHIgpkCzfNwOew0uJiIHHfRn+UL9V42C61
	 VIna/FzOT+Uew==
Date: Thu, 13 Jun 2024 11:17:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, hch@infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Prune redundant pgprot arguments
Message-ID: <Zmq5QWKtKvYzOej6@8bytes.org>
References: <c2a81b72df59a71a13f8bad94f834e627c4c93dd.1717504749.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2a81b72df59a71a13f8bad94f834e627c4c93dd.1717504749.git.robin.murphy@arm.com>

On Tue, Jun 04, 2024 at 01:39:09PM +0100, Robin Murphy wrote:
> Somewhere amongst previous refactorings, the pgprot value in
> __iommu_dma_alloc_noncontiguous() became entirely unused, and the one
> used in iommu_dma_alloc_remap() can be computed locally rather than by
> its one remaining caller. Clean 'em up.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Applied, thanks Robin.

