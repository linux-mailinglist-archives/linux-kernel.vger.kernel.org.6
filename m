Return-Path: <linux-kernel+bounces-348835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FA598EC64
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406A41C211C4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41B146A73;
	Thu,  3 Oct 2024 09:42:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DF37F48C
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948538; cv=none; b=PnZmpmXORQeVnyr0i4/TOn6T+VRG38WN0dWXozKtrwDk+9NkcX20QgQcJ8SHlOa95k8jaHvEzuosZ0LWlilJ2BYGNH9j4+t4qPCtRIy333h+P9T36E3mKRqVmYsT5BPOeCeqIoHXylX/vWq3JKabWz/PXxofhiCcYW6eZWrV898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948538; c=relaxed/simple;
	bh=dId4Z5Ex9W/PgQgaijAXWmLWf4zAeICnDvr4oA2wL40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBH7onPdtcUglMErXxRxNjbnhVZKSluHL2qHEwPlaxo5WGJ383GS82mbda3JapVGW2X8vNEU2CpTwZJgpgGv/rpg32oXPYBCQsaYC6nys/GyTsE+KmhruesSY/U9/D1AoZk5DvEXwYzEZXtgtVL7Wu5JCwlOpl8/Evn6jmpdHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F91C4CECF;
	Thu,  3 Oct 2024 09:42:16 +0000 (UTC)
Date: Thu, 3 Oct 2024 10:42:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 2/2] irqchip/gic-v3-its: Rely on genpool alignment
Message-ID: <Zv5m9p6aNQiapov4@arm.com>
References: <20241002141630.433502-1-steven.price@arm.com>
 <20241002141630.433502-3-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002141630.433502-3-steven.price@arm.com>

On Wed, Oct 02, 2024 at 03:16:30PM +0100, Steven Price wrote:
> its_create_device() over-allocated by ITS_ITT_ALIGN - 1 bytes to ensure
> that an aligned area was available within the allocation. The new
> genpool allocator has its min_alloc_order set to
> get_order(ITS_ITT_ALIGN) so all allocations from it should be
> appropriately aligned.
> 
> Remove the over-allocation from its_create_device() and alignment from
> its_build_mapd_cmd().
> 
> Tested-by: Will Deacon <will@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steven Price <steven.price@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

