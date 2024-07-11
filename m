Return-Path: <linux-kernel+bounces-249327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E941C92EA13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A5B24734
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A101662E4;
	Thu, 11 Jul 2024 13:59:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E801161314
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706395; cv=none; b=YcokNRn9XRXqo3t16pabD5rxcLob6pQYOP0d939HywldiN08++ZgO0EpipmZU6HLVFVqhYWQdx6k/dsfxSp4B6iANMdr4FGWpouF0GpoE84fTLUWtXS0JvFXWpvBB+kmRZntlPMdTMYkYR7vLssjzzSdEFX0t92RHILyG7jFk6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706395; c=relaxed/simple;
	bh=7dV4ckuhGGV0wUAI/+cK+Tifo24B23NojR32tXkLDiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZxLeBkju56OQmBCaGIdoJbbFWLFYjlyDIzoUqrM3qkhPkEoRoZhEdYnCaN1udZDfERr1iOyBgZMAQoTht2s0VQdUvF6JsjZy7lbA59O6GMyHixewtTzpR/Y8U0sKkNHZr/vjSUKQPVkF7DTOV6+ju7kmCnPUTGZaiVK91Pvx9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B094DFEC;
	Thu, 11 Jul 2024 07:00:18 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 727983F766;
	Thu, 11 Jul 2024 06:59:50 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:59:19 +0200
From: Beata Michalska <beata.michalska@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org,
	vincent.guittot@linaro.org, vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com, yang@os.amperecomputing.com,
	lihuisong@huawei.com, viresh.kumar@linaro.org, rafael@kernel.org
Subject: Re: [PATCH v6 0/4] Add support for AArch64 AMUv1-based
 arch_freq_get_on_cpu
Message-ID: <Zo_lN8jdgADwqvor@arm.com>
References: <20240603082154.3830591-1-beata.michalska@arm.com>
 <ZowdalL3DfkHtaCg@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZowdalL3DfkHtaCg@arm.com>

Hi Catalin,

On Mon, Jul 08, 2024 at 06:10:02PM +0100, Catalin Marinas wrote:
> Hi Beata,
> 
> On Mon, Jun 03, 2024 at 09:21:50AM +0100, Beata Michalska wrote:
> > Introducing arm64 specific version of arch_freq_get_on_cpu, cashing on
> > existing implementation for FIE and AMUv1 support: the frequency scale
> > factor, updated on each sched tick, serves as a base for retrieving
> > the frequency for a given CPU, representing an average frequency
> > reported between the ticks - thus its accuracy is limited.
> > 
> > The changes have been rather lightly (due to some limitations) tested on
> > an FVP model. Note that some small discrepancies have been observed while
> > testing (on the model) and this is currently being investigated, though it
> > should not have any significant impact on the overall results.
> 
> What's the plan with this series? Are you still investigating those
> discrepancies or is it good to go?
>
Overall it should be good to go with small caveat:
as per discussion [1] we might need to provide new sysfs attribute exposing an
average frequency instead of plugging new code under existing cpuinfo_cur_freq.
This is to avoid messing up with other archs and make a clean distinction on
which attribute provides what information. 
As such, the arch_freq_get_on_cpu implementation provided within this series
[PATCH v6 3/4] will most probably be shifted to a new function.

Hopefully will be able to send those changes soon.

---
[1] https://lore.kernel.org/all/ZmrB_DqtmVpvG30l@arm.com/
---
BR
Beata

> -- 
> Catalin

