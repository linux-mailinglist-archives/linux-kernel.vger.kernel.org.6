Return-Path: <linux-kernel+bounces-290052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B88954EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46761C22F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F161BD51E;
	Fri, 16 Aug 2024 16:31:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD947364A0;
	Fri, 16 Aug 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825899; cv=none; b=IfP3cIJqT80Ws+c1nrivq1/oG+imwKyy6Y04oyKKWY9W0a84ssYJGlKfgQAUMqJQ2n5rJVA6ex/yuRE0e60bngtl3LFo1bP1mnLWYABaF/6HmR8e2AIQvGYrngPgXFCEEdRbwiM4uLAwfyGYuruE93mwsejSGJ39y9/ehIIX/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825899; c=relaxed/simple;
	bh=9PT3gNpyR9fSzfxTZR3Nyw668zUlJjUTQe2irAaX7G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLUG5MMIb8BiJS9+otPuZwhYB2oYHwTmshdUnVi0U61Z2P1uCq/U/Q9oTLu5/LiA6aKFE13YVOcK51vn2oE+CtqO4xzdV1oRHGhitV5+FVCOEfgnaHhKSNPr5jJBz+dMwjDP5o2ZInrHSXKSMpRoS7aqxKiYqv5p8UxYeSlC0KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D4BB152B;
	Fri, 16 Aug 2024 09:32:03 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0563F58B;
	Fri, 16 Aug 2024 09:31:33 -0700 (PDT)
Message-ID: <983fded5-48f8-439d-8afe-45b60841985a@arm.com>
Date: Fri, 16 Aug 2024 17:31:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/22] x86/resctrl: Introduce the interface to switch
 between monitor modes
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, mingo@redhat.com,
 bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
 fenghua.yu@intel.com, reinette.chatre@intel.com, tglx@linutronix.de
References: <cover.1722981659.git.babu.moger@amd.com>
 <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <784eaa900b9e0778ddc534c04c7ded9466bfd19b.1722981659.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Babu,

On 06/08/2024 23:00, Babu Moger wrote:
> Introduce interface to switch between ABMC and legacy modes.
> 
> By default ABMC is enabled on boot if the feature is available.
> Provide the interface to go back to legacy mode if required.

I may have missed it on an earlier version ... why would anyone want the non-ABMC
behaviour on hardware that requires it: counters randomly reset and randomly return
'Unavailable'... is that actually useful?

You default this to on, so there isn't a backward compatibility argument here.

It seems like being able to disable this is a source of complexity - is it needed?


For MPAM I'm looking at enabling this on any platform that is short of monitors. If
user-space disables it I don't have a "at random" hardware behaviour to fall back on - its
extra work to invent a behaviour I'm not sure is useful...


> $ cat /sys/fs/resctrl/info/L3_MON/mbm_mode
> [mbm_cntr_assign]
> legacy
> 
> To enable the "mbm_cntr_assign" mode:
> $ echo "mbm_cntr_assign" > /sys/fs/resctrl/info/L3_MON/mbm_mode
> 
> To enable the legacy monitoring feature:
> $ echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
> 
> MBM event counters will reset when mbm_mode is changed.


Thanks,

James

