Return-Path: <linux-kernel+bounces-386543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEBD9B44D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512031C20C28
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA4204018;
	Tue, 29 Oct 2024 08:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="aUQ6xfw4"
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2E203700
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191781; cv=none; b=U7iJ+JOLtcZawkGvtQeUrUhCANLJu+J1v81+PLhBQp003zRMihKkxOvrGSwqbPvJRvG7+0x4mTMyTem3Tz02MV6IxQsUlfknTU08o299XpoNr83/qkS3K++K/Zj4JAWm8YBR3x+DSpckCQkvCdmrAwb9qD4yBoOi5ZVq07o4MwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191781; c=relaxed/simple;
	bh=t4F6EkQzc+Tx2dGrpH/0oshPhSFvIj0HR4NfuwzqRJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIj+a7QOb1hJOVteDbk70APoTGNvUFrhBwd5ewon+aKVRrxYqO9igKP+rjFi14iu9x72NfbcaGWLyecSaR//Fm5OVFwo4DmuvQuRQx7dfZsit+bUAr1ly05jNh3R4vOEuxpdBiD0L5bAt1qJLFReYzjHFGgUd1tVUL6HjLcAs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=aUQ6xfw4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549219d2.dip0.t-ipconnect.de [84.146.25.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D77FF2A8D41;
	Tue, 29 Oct 2024 09:49:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1730191778;
	bh=t4F6EkQzc+Tx2dGrpH/0oshPhSFvIj0HR4NfuwzqRJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUQ6xfw4G2fAmph3fMFdnFmV5d7IVswiGPxXeaXX/I9SmikyU2MAAf+y4Isth8Y5K
	 p21a5tZ9rsQN0CxRZso6IVwby5zEOcH2BVQpWpR9rDow9TEbXHCS92Z+0aheRh471F
	 xHWeF+1O85Qp+VWsrNNEHC2kW6wmlznAOKjfdfyX494GntCf2fDENFo2kxeRU2udOd
	 zTifyhsLLwcopsEVsl7OaOng1N2eL6IcVYq8qymV4U36kJb5amFqmOiZ4p0BD607Hm
	 qoqV9iL1vxQfocKm3vi1TXeIE060idIsNLCclyrLXHabpebwZBZ1UagunS4H0Aie/g
	 uuXtwG4E1t3hw==
Date: Tue, 29 Oct 2024 09:49:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Konrad Adamczyk <konrada@google.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Wojciech Macek <wmacek@google.com>
Subject: Re: [PATCH] iommu/mediatek: Add PGTABLE_PA_35_EN to mt8186 platform
 data
Message-ID: <ZyChoFmaID6aGQT1@8bytes.org>
References: <20241017112036.368772-1-konrada@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017112036.368772-1-konrada@google.com>

On Thu, Oct 17, 2024 at 11:20:36AM +0000, Konrad Adamczyk wrote:
>  drivers/iommu/mtk_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

