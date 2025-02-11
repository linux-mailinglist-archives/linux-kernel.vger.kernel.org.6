Return-Path: <linux-kernel+bounces-510032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43287A3176C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380831630F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94DF264FB3;
	Tue, 11 Feb 2025 21:13:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62493263C9E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308400; cv=none; b=jH5RXAcnL7TRPgPFVjyb6uAet+mOp+Spon1Ugf+aSJNtGE79uKzBRIgTX+rmT+TR3JSNTWciIfNRE0UMiEnKAFOpDLLK3geQTAjBFIK9H/NdMINWCiGYzPH+jUHzCkonZPn4qkyrb+LG2rph5wW29z5kpuHrFP14TpGpFTmwsCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308400; c=relaxed/simple;
	bh=+OTFB44uko1/DM7HK6FfvYUYcwW5Mc0PpeWcRkJ2+I0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdYZ4WcnVdyC55jVZUlH6pc9T0VdDowGXIpDLU5Ofvn2A/9yeCo/dIQ9OtxfP+avHQdq1mIYVKs5xjyfchKV2RLF+CzTjgLpMysRozSU/p0RFcsLy9NLfwdUlI+6yB4UoporyhKfPK3hHxCgiD2N4Rl/NdcRRKljRzJViZK0lVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D63E1D14;
	Tue, 11 Feb 2025 13:13:39 -0800 (PST)
Received: from [10.57.35.63] (unknown [10.57.35.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 533493F5A1;
	Tue, 11 Feb 2025 13:13:15 -0800 (PST)
Message-ID: <97dfb0d9-1d7d-4174-9a7d-aac6f4ffaea8@arm.com>
Date: Tue, 11 Feb 2025 21:13:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu/dart: Assert !locked when configuring
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Sven Peter <sven@svenpeter.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-5-5d97fe247f35@rosenzweig.io>
 <756ba6d7-b18e-4139-851b-496b1820117a@arm.com>
 <20250211192152.GA810942@robin.jannau.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250211192152.GA810942@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-11 7:21 pm, Janne Grunau wrote:
> On Tue, Feb 11, 2025 at 06:41:00PM +0000, Robin Murphy wrote:
>> On 2025-02-10 7:39 pm, Alyssa Rosenzweig wrote:
>>> Configuration is only possible and needed for non-locked DARTs and will
>>> fail for locked DARTs. We cannot try -- assert that we do not.
>>
>> Except now we absolutely will - if a locked DART and its client device
>> are advertised to Linux, instead of gracefully refusing to touch it,
>> we'll now attach the client to a DMA domain, firing a barrage of
>> multiple WARNs in the process, and give it DMA ops which still cannot
>> work. I'm not really convinced this series on its own leaves us in a
>> better position than we're already in now... :/
>>
>> How hideous is the rest of what's required to actually make this usable?
> 
> The TTBR can not be changed but the preset first level table can
> modified at will. The driver keeps a shadow first label table and syncs
> that to the preset 1st level table on flush_tbl().
> It gets more complicated by the fact that the iommu for the display
> coprocessor is locked and mappings for its firmware and boot framebuffer
> are preinstalled and have to be maintained or restored on
> initialization.
> This is handled via reserved memory with translation.
> 
> Downstream change to handle this is in
> https://github.com/AsahiLinux/linux/commit/d90cc3590ea460e1c574b4b7c47fdafb2794af6a
> not including the change to parse / handle reserved memory with
> translation in iommu core.

Oh, if we handwave away the reserved region stuff for now, it doesn't 
seem *too* terrible, so definitely worth trying to land the bones of it 
along with this prep work, I reckon. From a quick look I think it might 
possibly be even cleaner as an io-pgtable quirk, to essentially skip 
allocating/freeing L1 and have some mechanism to fill in data->pgd with 
the remap afterwards (possible super cheeky version - also prepopulate 
cfg->apple_dart_cfg.ttbr and have alloc/free handle the 
remapping/unmapping themselves...). I'm not 100% sure off-hand, but 
since you avoid the DMA API and don't seem to have any other dependency 
on data->pgd having a linear map VA (other than the virt_to_phys() in 
the normal alloc path which you'd skip anyway), it feels like it ought 
to work out.

I guess to support multiple domains you do still end up having to 
save/restore the L1 contents at the driver level when attaching, so some 
kind of shadow table notion isn't entirely unavoidable... oh well, it's 
a thought, at least.

Thanks,
Robin.

