Return-Path: <linux-kernel+bounces-568230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E46A692B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC181B63C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB94211A24;
	Wed, 19 Mar 2025 14:55:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB72421148F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396132; cv=none; b=PdyGvkyO7T+U5RQH6gtBoPBXfaxfMWmal4AHOgLkm47SnSB+rlyTYioFKwddHLzMP39+6F7elziMa253qDvwHBjJn0bGSoe8Mo64AAPX8MxqIi/KhlaY2GxOa/MEkCLZAjUotpmIlpzrCo/HX6njXOJzkr3gv5AbHa4q8edpEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396132; c=relaxed/simple;
	bh=WnQ+FuFaF+koDcvuXC70dNnZjwr287lNrdYcRE2s+ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4VMDDJe1Yrv4Akpuura6dvd/zMm8D2wjE7TJQPX2iNbWJVVs3rsBgXkDKIPVwvI1ibEFVHw0kSXFyziuSgR+jTmzN29Z4dbr+mrY/MTX6Q6SP9a7VV1tRmqNhyUFPK5AccnCO7kCjaDJXCryDodu4aeKBDUJb0Dr/E17cEN8DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66DB0106F;
	Wed, 19 Mar 2025 07:55:37 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FD2D3F694;
	Wed, 19 Mar 2025 07:55:27 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:55:24 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	kvmarm@lists.linux.dev,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Rob Herring <robh@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Fast model boot failure with Linux next-20250312
Message-ID: <Z9ra3I2axii2HRVb@J2N7QTR9R3>
References: <CA+G9fYvPu+MQKhYyPZSSDpAn-zhRGmeHQ8hJksT_cdDdxfbB-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvPu+MQKhYyPZSSDpAn-zhRGmeHQ8hJksT_cdDdxfbB-g@mail.gmail.com>

On Wed, Mar 19, 2025 at 08:07:47PM +0530, Naresh Kamboju wrote:
> Regressions on the arm64 Fast Model (FVP-AEMvA) caused boot failures starting
> with Linux next-20250312 and persisting through next-20250319.
> 
> First seen on the next-20250312
>  Good: next-20250311
>  Bad:  next-20250312 .. next-20250319
> 
> Regressions found on FVP:
>  - boot
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Yes
> 
> Boot regression: Fast model boot failure with Linux next-20250312
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Anders bisected this to this commit id,
> 
> # first bad commit:
>   [858c7bfcb35e1100b58bb63c9f562d86e09418d9]
>   arm64/boot: Enable EL2 requirements for FEAT_PMUv3p9
> 
> NOTE:
>   LKFT is currently running FVP Fast Models version 11.24.
>   Planned upgrade to the Fast Models version 11.28 in this sprint.

What firmware (and version therof) are you running within the model?

For example, if the EL3 firmware lacks support for FEAT_FGT2 or
FEAT_PMUv3p9, the kernel will trap to EL3 early during boot and die.

It would be really helpful if you could capture that in the report in
future.

Mark.

> 
> ## Boot log
>   <No crash log on the console>
> 
> ## Source
> * Kernel version: 6.14.0-rc7
> * Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> * Git sha: ff7f9b199e3f4cc7d61df5a9a26a7cbb5c1492e6
> * Git describe: next-20250319
> * Project details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319
> * DUT: arm64 Fast Model (FVP-AEMvA)
> * Toolchains: gcc-13 and clang-20
> 
> ## Build
> * Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/log
> * Build history:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675685/suite/boot/test/gcc-13-lkftconfig/history/
> * Build details:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250319/testrun/27675691/suite/boot/test/gcc-13-lkftconfig/
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2uX2EtC2pQdmVZ7ccoyhoi01Yy0/config
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

