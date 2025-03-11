Return-Path: <linux-kernel+bounces-556005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0462DA5BF86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943553B3253
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1526255E3A;
	Tue, 11 Mar 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcvlaCQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C691DE8A0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693527; cv=none; b=abOFGkuoAjkhls5SjpAMZvX7dLoBcSUhyfLdTVYd/1on+ez0U+sGWeiGbmqMdk5hWpVAO2tw/rK8zT5J3yeYbZ/PejpU1qS2rIsHPnB9zh3cNRjmzACGjBK5C44/JhA/NWeYxKhEyclOVE52tLLZxLM1wfyZtKYZaZNFT61e7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693527; c=relaxed/simple;
	bh=sWXHX5t+Kv3NfKtUWpDt2obvOSg0nfLxfHwkoaJD4eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duFP5BkmcgdKe4cX8Na6B9t5Uphy5F6HO4Y+IudvtonVqkVOUmt7VbL/dISOY8h0Edn130v4XIDiXOM+ynEfJCrDKZadLFmLsRbeIdYYi+rnSyC+UyzocGRq8tX6ljSUfOccawhjyzgItgkCDUgZPRJ010UOnAS9JjoyvsjY7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcvlaCQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417C6C4CEED;
	Tue, 11 Mar 2025 11:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693526;
	bh=sWXHX5t+Kv3NfKtUWpDt2obvOSg0nfLxfHwkoaJD4eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HcvlaCQoOWK3y/xnozjIw1SR5DfQnX10Z2/5uZ5PG+a65Ol9rjkQNEKBsXLZU9biO
	 PYszIP0v12V9LBP8N1Iu43VTUlL+ywVZ0VIgiFQUXyNvGgvfFzsUUYYNRXhUmouUPG
	 v0j5iT50gZYswdu0yeQv7z0Cnr+xFWboY83eHJ04ukLwDgaUa3G/I/xMWK0QFDNCVW
	 2ysVy3w8ogTiHuZKeP9brmgpxXfyZOlsA+T7WKGY8Tr50OIbqWs6wV1A3LesUO/Uzs
	 F8ARf4lNqdHgbnWwNu1Ljxj8tffudbC9PNId5Lbs/lCBZBUfpnMWOj/DleGAY9Nd2W
	 s6yezugEFkzCQ==
Date: Tue, 11 Mar 2025 11:45:20 +0000
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, maz@kernel.org, steven.price@arm.com,
	aneesh.kumar@kernel.org, gshan@redhat.com, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Christoph Hellwig <hch@lst.de>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/3] arm64: realm: Fix DMA address for devices
Message-ID: <20250311114519.GA4202@willie-the-truck>
References: <20250227144150.1667735-1-suzuki.poulose@arm.com>
 <CGME20250303113525eucas1p1099e087e2c11b9021603a6f13f8135c4@eucas1p1.samsung.com>
 <2b6d5287-bdea-4ec3-a07f-986bd3c3b285@arm.com>
 <7b5c90cf-00e4-4684-8719-f380badab064@samsung.com>
 <7ad365f0-d335-4da1-845a-8fe3bc5eb055@arm.com>
 <Z8nkNNR6vuoQ9bQD@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8nkNNR6vuoQ9bQD@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Mar 06, 2025 at 06:06:44PM +0000, Catalin Marinas wrote:
> On Thu, Mar 06, 2025 at 11:39:14AM +0000, Suzuki K Poulose wrote:
> > On 04/03/2025 13:40, Marek Szyprowski wrote:
> > > > On 27/02/2025 14:41, Suzuki K Poulose wrote:
> > > > > Linux can be run as a Confidential Guest in Arm CCA from Linux v6.13. The address
> > > > > space (GPA or IPA) of a Realm VM is split into two halves, with private bottom
> > > > > half and shared top half. In Linux we treat the "top" bit of the IPA space as
> > > > > an attribute, to indicate whether it is shared or not (MSB == 1 implies shared).
> > > > > Stage2 (GPA to PA) translations used by the CPU accesses, cover the full IPA space,
> > > > > and are managed by RMM. The "top" bit as attribute is only a software construct.
> [...]
> > > The changes look fine. However I won't be able to setup new dma-mapping
> > > git tree this week because I got really sick has to stay in bed. :/ If
> > > You don't want such delay, please merge it via ARM64 tree. Here is my:
> > 
> > Sorry to hear that. Hope you feel better soon.
> > 
> > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > 
> > Thanks Marek.
> > 
> > Btw, this series fixes the "Realm Guest" support for Linux, which was merged
> > in v6.13. To be precise, this should have :
> > 
> > Fixes: 42be24a4178f ("arm64: Enable memory encrypt for Realms")
> > 
> > Will/Catalin,
> > 
> > Please let me know if you would like me to send the series with
> > all the Acks, Reviews and mainly the Fixes tag added ?
> 
> We can add the acks and fixes tag, no worries. I can queue them for 6.15
> unless Will takes them as fixes for 6.14 (I'll wait for a bit).

For the series:

Acked-by: Will Deacon <will@kernel.org>

but I'd prefer this to land in 6.15 at this stage given that (a) it's
always been broken and (b) we're not exactly tripping over CCA-capable
hardware.

Cheers,

Will

