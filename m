Return-Path: <linux-kernel+bounces-549589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987A5A55447
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7853B83D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCBD26E179;
	Thu,  6 Mar 2025 18:06:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB3F25D55E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284409; cv=none; b=J4GABs7a5Qp5kusldKBqvHRMBGXwQhFVLpl9O215xgeaHrS3vM1Ed/mmO81J5vQM01fsW+4X60xxqqTKfESXmz+uw9mn7kWHh5mEGUnYjqIQex1oTiYiqxr5O+R3jmXpy0rUQMG5bmVdkBRRl61AthIcOvbBxTyvY73gsgKUHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284409; c=relaxed/simple;
	bh=Begl+fe1gAwLPm7HwS17V/btmIoLsvailaiqC0QREYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZT3Ks4WalfcJKk0VHmGeh1KxoFLaqSrcjrCF5GJcUrwQ1fUeFWvMZblEbHJ1rwFUI/2wxXFIjD66NdnPBtr3pE7xTS2IP/+K1eo1JmNh2u7+y2EBnbAXSknH3iDuaP/cMpsKu5YXDlD3wE3AIc9Lg1HgunhJxPucvcKyGhnG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51837C4CEE0;
	Thu,  6 Mar 2025 18:06:47 +0000 (UTC)
Date: Thu, 6 Mar 2025 18:06:44 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
	maz@kernel.org, steven.price@arm.com, aneesh.kumar@kernel.org,
	gshan@redhat.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/3] arm64: realm: Fix DMA address for devices
Message-ID: <Z8nkNNR6vuoQ9bQD@arm.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <CGME20250303113525eucas1p1099e087e2c11b9021603a6f13f8135c4@eucas1p1.samsung.com>
 <2b6d5287-bdea-4ec3-a07f-986bd3c3b285@arm.com>
 <7b5c90cf-00e4-4684-8719-f380badab064@samsung.com>
 <7ad365f0-d335-4da1-845a-8fe3bc5eb055@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad365f0-d335-4da1-845a-8fe3bc5eb055@arm.com>

On Thu, Mar 06, 2025 at 11:39:14AM +0000, Suzuki K Poulose wrote:
> On 04/03/2025 13:40, Marek Szyprowski wrote:
> > > On 27/02/2025 14:41, Suzuki K Poulose wrote:
> > > > Linux can be run as a Confidential Guest in Arm CCA from Linux v6.13. The address
> > > > space (GPA or IPA) of a Realm VM is split into two halves, with private bottom
> > > > half and shared top half. In Linux we treat the "top" bit of the IPA space as
> > > > an attribute, to indicate whether it is shared or not (MSB == 1 implies shared).
> > > > Stage2 (GPA to PA) translations used by the CPU accesses, cover the full IPA space,
> > > > and are managed by RMM. The "top" bit as attribute is only a software construct.
[...]
> > The changes look fine. However I won't be able to setup new dma-mapping
> > git tree this week because I got really sick has to stay in bed. :/ If
> > You don't want such delay, please merge it via ARM64 tree. Here is my:
> 
> Sorry to hear that. Hope you feel better soon.
> 
> > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks Marek.
> 
> Btw, this series fixes the "Realm Guest" support for Linux, which was merged
> in v6.13. To be precise, this should have :
> 
> Fixes: 42be24a4178f ("arm64: Enable memory encrypt for Realms")
> 
> Will/Catalin,
> 
> Please let me know if you would like me to send the series with
> all the Acks, Reviews and mainly the Fixes tag added ?

We can add the acks and fixes tag, no worries. I can queue them for 6.15
unless Will takes them as fixes for 6.14 (I'll wait for a bit).

-- 
Catalin

