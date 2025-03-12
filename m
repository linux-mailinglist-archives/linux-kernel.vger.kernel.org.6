Return-Path: <linux-kernel+bounces-557076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B772A5D34E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D626D1895654
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E881233727;
	Tue, 11 Mar 2025 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oSMS2P3i"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443797B3E1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736684; cv=none; b=oPbOVDvBysTrV60ZvWiWxzf9Fa2G5f2ceVF/rkXzmzjz+R1NqjEPNaWKUbdekH/g6Kk1RJ9tt2hgCmSJmbECykk5MLRkEX/WPVCXkq9R67ciX+EahFRYIPe7tbLCrd+aq528vdADq2+Fdc+SVB0hRhEfnDkdKcBWGdp2+ubRTMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736684; c=relaxed/simple;
	bh=b51MerqZisIu4CsCLrU2raVfXD7bPut63futlnMslx0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lu6xdSHSaqMXTIz7ydMocbMyyfbYfecDXZJvIkEFb5FDB9qUSL+MddsIVL89Ja9Ic2zqtMwy44yx/gSx1xrynngnb1ES2h+u9EgDoG5j3q7bMoXoeWPmwFh+Cbl3yDLJeWxCEoJxKWiA74wF8ccuHqLRjcWebQTh/HNM7WOiLJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oSMS2P3i; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741736680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oi1BLbE7r5Jv82rbxY9jzsh/6odGMKYOpVA/m+ctSAs=;
	b=oSMS2P3iID7v+wiMAoAinih2NDgr8K39BTILgxvDMNQ4bTMlDqOjbO4ZVovP48XrnBdkxd
	qMhQiTAjEyPSTOPvpeWC04oEh1iQ30UvNMzRSjX2lcYdOHVBoAYM0aW32Rh6EdNNdo26ZW
	Zq23OYzylV5zqv+GXg9OYrajB7Bxy4U=
From: Oliver Upton <oliver.upton@linux.dev>
To: kvmarm@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	Colton Lewis <coltonlewis@google.com>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v3 00/14] KVM: arm64: FEAT_PMUv3 on Apple hardware
Date: Tue, 11 Mar 2025 16:44:26 -0700
Message-Id: <174173663466.1065484.5411031116504311230.b4-ty@linux.dev>
In-Reply-To: <20250305202641.428114-1-oliver.upton@linux.dev>
References: <20250305202641.428114-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 05 Mar 2025 12:26:27 -0800, Oliver Upton wrote:
> Hopefully close to the last spin, this time addressing Marc's comments
> on v2.
> 
> Full details found in the v1 cover letter.
> 
> v1: https://lore.kernel.org/kvmarm/20241217212048.3709204-1-oliver.upton@linux.dev/
> v2: https://lore.kernel.org/kvmarm/20250203183111.191519-1-oliver.upton@linux.dev/
> 
> [...]

Applied to next, thanks!

[01/14] drivers/perf: apple_m1: Refactor event select/filter configuration
        https://git.kernel.org/kvmarm/kvmarm/c/75ecffc361bb
[02/14] drivers/perf: apple_m1: Support host/guest event filtering
        https://git.kernel.org/kvmarm/kvmarm/c/46573d944f00
[03/14] KVM: arm64: Compute PMCEID from arm_pmu's event bitmaps
        https://git.kernel.org/kvmarm/kvmarm/c/93b01528586b
[04/14] KVM: arm64: Always support SW_INCR PMU event
        https://git.kernel.org/kvmarm/kvmarm/c/ed335722b457
[05/14] KVM: arm64: Use a cpucap to determine if system supports FEAT_PMUv3
        https://git.kernel.org/kvmarm/kvmarm/c/6f34024d185e
[06/14] KVM: arm64: Drop kvm_arm_pmu_available static key
        https://git.kernel.org/kvmarm/kvmarm/c/a38b67d15183
[07/14] KVM: arm64: Use guard() to cleanup usage of arm_pmus_lock
        https://git.kernel.org/kvmarm/kvmarm/c/3d6d9172128e
[08/14] KVM: arm64: Move PMUVer filtering into KVM code
        https://git.kernel.org/kvmarm/kvmarm/c/56290316a443
[09/14] KVM: arm64: Compute synthetic sysreg ESR for Apple PMUv3 traps
        https://git.kernel.org/kvmarm/kvmarm/c/2c433f70dccc
[10/14] KVM: arm64: Advertise PMUv3 if IMPDEF traps are present
        https://git.kernel.org/kvmarm/kvmarm/c/bed9b8ec8c71
[11/14] KVM: arm64: Remap PMUv3 events onto hardware
        https://git.kernel.org/kvmarm/kvmarm/c/1e7dcbfa4b7c
[12/14] drivers/perf: apple_m1: Provide helper for mapping PMUv3 events
        https://git.kernel.org/kvmarm/kvmarm/c/2d00cab849be
[13/14] KVM: arm64: Provide 1 event counter on IMPDEF hardware
        https://git.kernel.org/kvmarm/kvmarm/c/1b92e65f5006
[14/14] arm64: Enable IMP DEF PMUv3 traps on Apple M*
        https://git.kernel.org/kvmarm/kvmarm/c/e1231aacb065

--
Best,
Oliver

