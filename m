Return-Path: <linux-kernel+bounces-415477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA089D36D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DBC1F261D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08870199943;
	Wed, 20 Nov 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NdSDYVLo"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2E31865E1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732094212; cv=none; b=C8z91lU3glETJS6YjeL7eJdBglSjDFnmC03nG5PvyoN3HbhYWy66soYP/lO7I+ycxmoubGQ/vQiRh88eTkuTI8ifDrhHRGRcQQ0WhTEu+cYGUcAa7o3T6HyBUx3O7zfxcordFHMeBc9vbjuft3oUr+U5f1qOEKF3xkDcWSqxb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732094212; c=relaxed/simple;
	bh=ZpByQMwmmWUqUCrhi4pK94CzqA3vVsdCx4OnACYInBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMNs6LgwRtzNpdEUYyP7rmq3iT0dixLMcYfgf9O0hhB3BqjQn5azBp0eoXHt4fAler365PWX2EGJI2veYnjk2ZDDyjUAooZLCi7TEv9XRn2HCfgmw6ifKxY2/UXZZdU/jiPE8BOVCGobww7hLL8SaFnuGvOkj1hkpqhf/ySC/40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NdSDYVLo; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 09:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732094207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tIPpHPyISSClh/FBZwmso93xc+iFIzjr1637smd/Ql4=;
	b=NdSDYVLo6jjFxxrU7eb0XWXnCtK1025ElAvHSIpqwMkW71rEgmMBcZQILLQbrZArKj8jWD
	Ma93bd5EkBt7gr8nidj01Fxi3y5FuF0YfUwpl1wDGlZuBQgyBbo/bXUzSMEm56m55bf4b6
	lsDi8Wuao9RAS6KSmCz/Wo3gC/ICw3M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: James Clark <james.clark@linaro.org>
Cc: suzuki.poulose@arm.com, coresight@lists.linaro.org,
	kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Fuad Tabba <tabba@google.com>, James Morse <james.morse@arm.com>,
	Shiqi Liu <shiqiliu@hust.edu.cn>, Mark Brown <broonie@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/12] KVM: arm64: arm_spe: Give SPE enabled state to
 KVM
Message-ID: <Zz2o9XryCezwAf61@linux.dev>
References: <20241112103717.589952-1-james.clark@linaro.org>
 <20241112103717.589952-8-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112103717.589952-8-james.clark@linaro.org>
X-Migadu-Flow: FLOW_OUT

Hi James,

On Tue, Nov 12, 2024 at 10:37:06AM +0000, James Clark wrote:
> Currently in nVHE, KVM has to check if SPE is enabled on every guest
> switch even if it was never used. Because it's a debug feature and is
> more likely to not be used than used, give KVM the SPE buffer status to
> allow a much simpler and faster do-nothing path in the hyp.
> 
> This is always called with preemption disabled except for probe/hotplug
> which gets wrapped with preempt_disable().

Unless the performance penalty of checking if SPE is measurably bad, I'd
rather we keep things as-is.

Folks that want to go fast are probably using VHE to begin with. As you
note below, we need the hypervisor to decide if SPE is enabled based on
hardware in protected mode anyway. Using a common flow for protected and
non-protected configs keeps complexity down and increases the likelihood
SPE save/restore code actually gets tested.

-- 
Thanks,
Oliver

