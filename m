Return-Path: <linux-kernel+bounces-275416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C51948556
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7791F23787
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8081516EB5B;
	Mon,  5 Aug 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lMsvNTL4"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F7155351
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722895957; cv=none; b=mDtfzU9eAOvAxPGPWNGLGeacF7wFmdutrdRxPXz/bozKZbRJjfJtM9n6Zk/50iBGiZq22taWzMN9STORYxcDj2iGadaGm3sSXcvD4v5bKxI5int19m6qHLVyhLC6VOF1HdIcMAqQU2zgUR4yNK15ASoHChIxiYynyuS6xq7ao5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722895957; c=relaxed/simple;
	bh=mP0le3Ecr+q+WaHp0xN16KLmayF7PbiS4tFl1GVsYiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQhhpzR3nQ88gPiUb7HPoQJZENRiYTzYKBKUKh6+jFW4ksq/rX0I6rx4QNME7dSIBkHXBqPew2HB/MPCIozPIFg+7HJ6IpWhcDvaadAY4yJPs/EnVmERz69X94/18ny5Mp3quQ3uBFv2fvkJKEJtOZ6kSZCHHrHSWMExlOW/6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lMsvNTL4; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722895954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xyzz3yd5OYMOps4lsgiuDb1QOK8b+DokzNfK7sphtSc=;
	b=lMsvNTL4tgvYnugYSreQD0DQil/aj1Z4VcmuRh2S6m1J8kAdfZQXJNyGgSspt7h5Qcj4/G
	gFWxljJwEgBQoNQQCaWBGR12dzD5lep0m7vS7UBc0IHaIPOme92o736E5lQF+u7vclZWc9
	tY8I392eK9QG/Zi6HZLHZHIjcXg0ULk=
From: Oliver Upton <oliver.upton@linux.dev>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sebastian Ott <sebott@redhat.com>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/3] KVM: arm64: fix warnings in W=1 build
Date: Mon,  5 Aug 2024 22:12:23 +0000
Message-ID: <172289592799.3403138.16842618894557435476.b4-ty@linux.dev>
In-Reply-To: <20240723101204.7356-1-sebott@redhat.com>
References: <20240723101204.7356-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 23 Jul 2024 12:12:01 +0200, Sebastian Ott wrote:
> Building arch/arm64/kvm/ with W=1 spills out a lot of warnings. When
> changing stuff I try to use as much tooling as possible to make sure
> that I don't screw up - having a clean baseline imho helps with that.
> 
> With the first 2 patches applied make W=1 arch/arm64/kvm/ runs without
> warnings for me (fedora userspace, upstream linux after kvm merge).
> Patch 3 gets rid of sparse lock warnings in arch/arm64/kvm/vgic/.
> 
> [...]

Applied to kvmarm/fixes, thanks!

[1/3] KVM: arm64: fix override-init warnings in W=1 builds
      https://git.kernel.org/kvmarm/kvmarm/c/963a08e586bd
[2/3] KVM: arm64: fix kdoc warnings in W=1 builds
      https://git.kernel.org/kvmarm/kvmarm/c/0aa34b37a78d
[3/3] KVM: arm64: vgic: fix unexpected unlock sparse warnings
      https://git.kernel.org/kvmarm/kvmarm/c/19d837bc881b

--
Best,
Oliver

