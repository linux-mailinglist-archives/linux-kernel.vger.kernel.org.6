Return-Path: <linux-kernel+bounces-391176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FD9B837E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491C028207E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 19:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32521CB320;
	Thu, 31 Oct 2024 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I6gpoXGk"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DF1C9DFC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730403315; cv=none; b=ARL8lQyOxwyyUyah+bu+FG9VK4yNQqHvN/pFSkFLrX9Wg5TsrN/2ub9vB4yW4sNO+Z7ZYdFxURI6UuQ4rixgQyWJjo0gZHi20AGSgmYGMjHrwmqeG+Dnyc4QE1Hp2llxNhwTjUS+6samNvmLCyy0ZjZH39Jq6QzY5AtdDsM/3eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730403315; c=relaxed/simple;
	bh=BCXAO6MrcBYVJSUeWAqVK0/QIlQriCU+ES43nF0ki/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIYmUgCrRepLnXUdAqhJV6ENG9+ynWZpYBZKU1YtFRBk9wNFdYQGw0+66yhPCAIJwGml2gmJ5fx7hy8eNtUEg0ovy9cppZVBnQ9VcwQ5agzxpol3iyFFsm05vo1M4LM4n46Z8HO+npfP275dwkZGuvDpNomL/0h5hDFg2k6CRtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I6gpoXGk; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730403310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7k0lhlqVUH2PRuKZimC+zuSQ9tywYvWdXQj8NJnprjw=;
	b=I6gpoXGk4WpkxHpqqw7B0hi70vPzUkPh1qxplJi+Yww9CwVFeFqJQDR4mycBdi0D6ZBbqu
	ccQdynerUPnHzj3IKoShuccqmsyFi7CDokBvhRmxXrKiG2UzT7r4Oxfb+qZt3C3IOqrA9h
	y9e1FBHwej5C57edUWznZzAULvg9XNc=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>
Cc: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 00/18] KVM: arm64: nv: Support for EL2 PMU controls
Date: Thu, 31 Oct 2024 19:34:55 +0000
Message-ID: <173040329116.3311297.4818685036404939787.b4-ty@linux.dev>
In-Reply-To: <20241025182354.3364124-1-oliver.upton@linux.dev>
References: <20241025182354.3364124-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 25 Oct 2024 18:23:35 +0000, Oliver Upton wrote:
> v3 -> v4:
>  - Align sysreg definitions with DDI0601 2024-09
>  - Fix 'accessible' counter mask construction
>  - Fix MDCR_EL2.MTPME RES0 logic
> 
> v3: https://lore.kernel.org/kvmarm/20241007174559.1830205-1-oliver.upton@linux.dev/
> 
> [...]

Applied to kvmarm/next, thanks!

[01/18] KVM: arm64: Extend masking facility to arbitrary registers
        https://git.kernel.org/kvmarm/kvmarm/c/a0162020095e
[02/18] arm64: sysreg: Describe ID_AA64DFR2_EL1 fields
        https://git.kernel.org/kvmarm/kvmarm/c/93d7356e4b30
[03/18] arm64: sysreg: Migrate MDCR_EL2 definition to table
        https://git.kernel.org/kvmarm/kvmarm/c/641630313e9c
[04/18] arm64: sysreg: Add new definitions for ID_AA64DFR0_EL1
        https://git.kernel.org/kvmarm/kvmarm/c/3ecb1fe3842c
[05/18] KVM: arm64: Describe RES0/RES1 bits of MDCR_EL2
        https://git.kernel.org/kvmarm/kvmarm/c/eb609638da55
[06/18] KVM: arm64: nv: Allow coarse-grained trap combos to use complex traps
        https://git.kernel.org/kvmarm/kvmarm/c/18aeeeb57b93
[07/18] KVM: arm64: nv: Rename BEHAVE_FORWARD_ANY
        https://git.kernel.org/kvmarm/kvmarm/c/a4063b5aa0bd
[08/18] KVM: arm64: nv: Reinject traps that take effect in Host EL0
        https://git.kernel.org/kvmarm/kvmarm/c/d97e66fbcba7
[09/18] KVM: arm64: nv: Honor MDCR_EL2.{TPM, TPMCR} in Host EL0
        https://git.kernel.org/kvmarm/kvmarm/c/4ee5d5ff4b4d
[10/18] KVM: arm64: nv: Describe trap behaviour of MDCR_EL2.HPMN
        https://git.kernel.org/kvmarm/kvmarm/c/336afe0c832d
[11/18] KVM: arm64: nv: Advertise support for FEAT_HPMN0
        https://git.kernel.org/kvmarm/kvmarm/c/166b77a2f423
[12/18] KVM: arm64: Rename kvm_pmu_valid_counter_mask()
        https://git.kernel.org/kvmarm/kvmarm/c/a3034dab74fc
[13/18] KVM: arm64: nv: Adjust range of accessible PMCs according to HPMN
        https://git.kernel.org/kvmarm/kvmarm/c/9a1c58cfefb0
[14/18] KVM: arm64: Add helpers to determine if PMC counts at a given EL
        https://git.kernel.org/kvmarm/kvmarm/c/9d15f8290a22
[15/18] KVM: arm64: nv: Honor MDCR_EL2.HPME
        https://git.kernel.org/kvmarm/kvmarm/c/fe827f916662
[16/18] KVM: arm64: nv: Honor MDCR_EL2.HLP
        https://git.kernel.org/kvmarm/kvmarm/c/16535d55e91f
[17/18] KVM: arm64: nv: Apply EL2 event filtering when in hyp context
        https://git.kernel.org/kvmarm/kvmarm/c/8a34979030f6
[18/18] KVM: arm64: nv: Reprogram PMU events affected by nested transition
        https://git.kernel.org/kvmarm/kvmarm/c/ae323e035801

--
Best,
Oliver

