Return-Path: <linux-kernel+bounces-278278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165394AE32
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CFD282E82
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237F13AD1D;
	Wed,  7 Aug 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ymuwBY0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TFx9pehF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448EF2AF10;
	Wed,  7 Aug 2024 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723048324; cv=none; b=VHQKwYKCkXvSfhdOcXSUDpOgif/DbAgQLa0XaAMkw2Bz33FuiUBTD09jXc4rU8ICaEwvdE2bgQB/ycudHF3RC6jKoHfiLRslIf57xEZWz+1XKiUjK2gzhVcz/FT/0nx69M+4XBvf4aGcQOir3/U++m+n9xUVnUKLxD4Ak4X/nfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723048324; c=relaxed/simple;
	bh=3LSXEUaQsGCb0VBTJk669ziSZy/d071js8tL86UMlhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IphKaF5/7+wghz1s8Krky9X9vqKDISzAPAUeuJ4e86B9u5m11xPvhn4zpMlvFFnRVSmgQgRxAL6pWcg3yGVBqKmlSIRXKBY0A3kI0lXH/BrUWNSBY27/tFwJ1ly/c4IYOaCXjTiLI1x6IEWSUGxT9Iq0QUy9wtHEFZPPZ54CxLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ymuwBY0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TFx9pehF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723048321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BeAkNVjCZa48RhpKQ8laD3Odu8hwGA0woN0v4Hf+0zU=;
	b=2ymuwBY0ZbunnEbNjkz/ROmbccp/n0nITKZ69vn/JW1HaMJ9y65/kdeG0g4K0ZHozNOC6m
	6svypGXUU2yUH1zLOEn3BJ1vJRLJwqtHr/BnozoFxUCF+e+fr8xQJBwJQf0pZiPcxLUkPf
	ScBYCjwTok9gAv7yVd1p5i5sOcBSgTNi9Ui2M6pPU0EeorSHgRRPgWxgygszyWAHqG2E4Q
	0sFCUFspTAAdy5w75sInDyXvT4luS43kKvpz54smEyd+zOvVLvPlG6ugqi3dib+7h3RXeE
	uiuyijfjlTIbJpbkhafkXda/pJxEIxBRu0Djhrdn6sm9i1Y5jMJar2vbbDh0bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723048321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BeAkNVjCZa48RhpKQ8laD3Odu8hwGA0woN0v4Hf+0zU=;
	b=TFx9pehFq+iKF3h3D4gEoXl70p9nrXTVl8l7yS/iiWAzWCFZI8CjBX4oHQSSvAp82X5lnd
	MNzBchQ69Pk89pAg==
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
 rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
 yanjiewtw@gmail.com, babu.moger@amd.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Subject: Re: [PATCH v6 01/22] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
In-Reply-To: <72b61576c5101f6d325c2384f838cb475c7aa576.1722981659.git.babu.moger@amd.com>
References: <cover.1722981659.git.babu.moger@amd.com>
 <72b61576c5101f6d325c2384f838cb475c7aa576.1722981659.git.babu.moger@amd.com>
Date: Wed, 07 Aug 2024 18:32:01 +0200
Message-ID: <87le182t1a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 17:00, Babu Moger wrote:
> Users can create as many monitor groups as RMIDs supported by the hardware.
> However, bandwidth monitoring feature on AMD system only guarantees that
> RMIDs currently assigned to a processor will be tracked by hardware. The
> counters of any other RMIDs which are no longer being tracked will be
> reset to zero. The MBM event counters return "Unavailable" for the RMIDs
> that are not tracked by hardware. So, there can be only limited number of
> groups that can give guaranteed monitoring numbers. With ever changing
> configurations there is no way to definitely know which of these groups
> are being tracked for certain point of time. Users do not have the option
> to monitor a group or set of groups for certain period of time without
> worrying about RMID being reset in between.
>
> The ABMC feature provides an option to the user to assign a hardware
> counter to an RMID and monitor the bandwidth as long as it is assigned.
> The assigned RMID will be tracked by the hardware until the user unassigns
> it manually. There is no need to worry about counters being reset during
> this period. Additionally, the user can specify a bitmask identifying the
> specific bandwidth types from the given source to track with the counter.
>
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
>
> Linux resctrl subsystem provides the interface to count maximum of two
> memory bandwidth events per group, from a combination of available total
> and local events. Keeping the current interface, users can enable a maximum
> of 2 ABMC counters per group. User will also have the option to enable only
> one counter to the group. If the system runs out of assignable ABMC
> counters, kernel will display an error. Users need to disable an already
> enabled counter to make space for new assignments.
>
> The feature can be detected via CPUID_Fn80000020_EBX_x00 bit 5.
> Bits Description
> 5    ABMC (Assignable Bandwidth Monitoring Counters)

Can you please update the CPUID database with that new bit:

    https://gitlab.com/x86-cpuid.org/x86-cpuid-db

Thanks,

        tglx

