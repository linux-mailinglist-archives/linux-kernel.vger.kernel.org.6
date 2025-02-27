Return-Path: <linux-kernel+bounces-536813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB62A48478
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74633B1187
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D426F44F;
	Thu, 27 Feb 2025 16:05:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2826E976
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672331; cv=none; b=mxlV9+I/Lqko2qJ5U2czqXva8hZDa1k2pblbkCAuH1wFtxZKJ47VulL6Ln/dAEWpxdqly75xTnS9lINpBdhDiui1FSGQLTJPs7xYiZ8THtT5lqNbGa8ctkDs5vD7s39pxv5qGruGCPk8ChieTZ8AEQV+ZRCrEXmhWqtqNNMpBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672331; c=relaxed/simple;
	bh=CM3jHJNu5aG9mbYNIMDkkTPn0Nvuqwb/oNrzGihLKnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loMiUncPU3NrpMNNUclSPYBzuaT0ed02m96GvXMInBX8SBz89eE5+Tz3hB6f5mP8vY/ppSZdunqvB/UG0Dc+Rz91/Rzklx0F0UOVggTq6OjjmBExtL5qYqEHZNwandUgs2ucvzEB7LUClsi8PF2INmFyf9WlO5k9mR0lKneIiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411EDC4CEDD;
	Thu, 27 Feb 2025 16:05:28 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:05:26 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
	steven.price@arm.com, aneesh.kumar@kernel.org, gshan@redhat.com,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 3/3] arm64: realm: Use aliased addresses for device
 DMA to shared buffers
Message-ID: <Z8CNRqJ6dJAG0Daa@arm.com>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <20250227144150.1667735-4-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227144150.1667735-4-suzuki.poulose@arm.com>

On Thu, Feb 27, 2025 at 02:41:50PM +0000, Suzuki K Poulose wrote:
> When a device performs DMA to a shared buffer using physical addresses,
> (without Stage1 translation), the device must use the "{I}PA address" with the
> top bit set in Realm. This is to make sure that a trusted device will be able
> to write to shared buffers as well as the protected buffers. Thus, a Realm must
> always program the full address including the "protection" bit, like AMD SME
> encryption bits.
> 
> Enable this by providing arm64 specific dma_addr_{encrypted, canonical}
> helpers for Realms. Please note that the VMM needs to similarly make sure that
> the SMMU Stage2 in the Non-secure world is setup accordingly to map IPA at the
> unprotected alias.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

In case this goes in via the DMA API tree:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(we could bikeshed on the names like unencrypted vs decrypted but I'm
not fussed about)

