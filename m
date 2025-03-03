Return-Path: <linux-kernel+bounces-541554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9065BA4BE33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7FA188F5AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B241F8692;
	Mon,  3 Mar 2025 11:16:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA72187550
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000594; cv=none; b=EYHmzW7oUOfWHtE8opK0wjrBjinI7/x5u03RuyPjBqBufaAsZK/4HPF7VNMof3eMPie4U1PVINT1lf7iZXhN9LlX9+THBDJFxtvj6jF7oNlUoNCoFuEds+3VO2TvBtQWAJ5ZrDcXWzayhRTZv3zsN+jzIPVGFhsSSSoR9JjJDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000594; c=relaxed/simple;
	bh=0QHtPaQ98QlNVRE7GqZcnxV1R2pOH0/NOPZdOvOZ7Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6grjwYgQmSNB9wRiAmaFjcrZ/En/W2cxIwodrVdzV0F79IwOUjfsSIqyq6RFikaTbXk3Ugd37VBfkqhIjIUMsuxVfEwi3/5rST9cw3cPkEpO2ggpE718rATNM2AAS9cXlRo1G75i6Ii61c7hEFSIavy164wOJinTGtA5K3SszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC8E113E;
	Mon,  3 Mar 2025 03:16:45 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CDCF3F673;
	Mon,  3 Mar 2025 03:16:26 -0800 (PST)
Date: Mon, 3 Mar 2025 11:16:24 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Yicong Yang <yangyicong@huawei.com>, <catalin.marinas@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, <will@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<dietmar.eggemann@arm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>,
	<morten.rasmussen@arm.com>, <msuchanek@suse.de>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
	<xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 3/4] arm64: topology: Support SMT control on ACPI
 based system
Message-ID: <Z8WPiOweOjFZqTwN@bogus>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-4-yangyicong@huawei.com>
 <Z8HAkZiHYRjj97M7@bogus>
 <336e9c4e-cd9c-4449-ba7b-60ee8774115d@arm.com>
 <20250228190641.q23vd53aaw42tcdi@bogus>
 <a52972c7-aadd-4a77-a292-057fa5f8372d@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52972c7-aadd-4a77-a292-057fa5f8372d@arm.com>

On Mon, Mar 03, 2025 at 10:56:12AM +0100, Pierre Gondois wrote:
> On 2/28/25 20:06, Sudeep Holla wrote:
> > > >
> > > > Ditto as previous patch, can get rid if it is default 1.
> > > >
> > >
> > > On non-SMT platforms, not calling cpu_smt_set_num_threads() leaves
> > > cpu_smt_num_threads uninitialized to UINT_MAX:
> > >
> > > smt/active:0
> > > smt/control:-1
> > >
> > > If cpu_smt_set_num_threads() is called:
> > > active:0
> > > control:notsupported
> > >
> > > So it might be slightly better to still initialize max_smt_thread_num.
> > >
> >
> > Sure, what I meant is to have max_smt_thread_num set to 1 by default is
> > that is what needed anyways and the above code does that now.
> >
> > Why not start with initialised to 1 instead ?
> > Of course some current logic needs to change around testing it for zero.
> >
>
> I think there would still be a way to check against the default value.
> If we have:
> unsigned int max_smt_thread_num = 1;
>
> then on a platform with 2 threads, the detection condition would trigger:
> xa_for_each(&hetero_cpu, hetero_id, entry) {
>     if (entry->thread_num != max_smt_thread_num && max_smt_thread_num)     <---- (entry->thread_num=2) and (max_smt_thread_num=1)
>         pr_warn_once("Heterogeneous SMT topology is partly
>                       supported by SMT control\n");
>
> so we would need an additional variable:
> bool is_initialized = false;

Sure, we could do that or skip the check if max_smt_thread_num == 1 ?

I mean
	if (entry->thread_num != max_smt_thread_num && max_smt_thread_num != 1)

I assume entry->thread_num must be set to 1 on single threaded cores
Won't that work ? Am I missing something still ?

--
Regards,
Sudeep

