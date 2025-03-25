Return-Path: <linux-kernel+bounces-576163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD3A70BED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F964177127
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC382676DB;
	Tue, 25 Mar 2025 21:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ze/T5Mo5"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3F26739D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937057; cv=none; b=aMg2xea/0qMmD4lPQMHUQY8DbLeGYzRRhD/RhWmnkbP6eosHo//9sEHir11NLIkTCConLpRZ0AmFOoERH1yIyGVktnCXJt6Ygp7Qj5hj40NrtX0B6pF7Y1faKZuA9RvBCvflCGhvvYKdkRMrnJpC8xzwnp24Xo4QF4cVfwz3f6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937057; c=relaxed/simple;
	bh=DLMj54MhQAZr/E5TGLGxSK0Svq/hCmtaGSmZiDtC0ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkFbxJO0VfR6A2+91lafBCuXPfMmbOVfxqW01o9417WIjdobf0OlBb3Gkn8IhsApclMhArBWc34V8r3/I/DG91MLCvSKyKnEu0G8TiIRSeKgAk7/V+WEwbwK03hulhQmg8QUmTD4LGD/YHWY6QdYx/kCvlEKZz8SJO8+d1YN9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ze/T5Mo5; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a5aa25de-919f-462c-8aab-996fbc381de9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742937043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OtrI6FVeto5Rar/zwFnFYFILAD8TFRYuMC6F4t2WcYk=;
	b=Ze/T5Mo5UOKr3AMZ0t5aV/XB3iu4E8YXgMIszXhx2fu1E/gN6QbhsCSocD4bio37oAtZNY
	lVWfl6zVgzl9Yh1gIlHKcArzR9i3xj+iItZKIS2zLF1zuNU+BGI6adMQpanCI0UVtqkaWq
	ljJd7Y/6uBV15GChJJgzDa3J2uQwi3U=
Date: Tue, 25 Mar 2025 16:10:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] ASoC: SDCA: Create DAPM widgets and routes from DisCo
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 peter.ujfalusi@linux.intel.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
 <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
 <2b899796-b9fc-49ef-a4a7-858baa90a36b@linux.dev>
 <Z+KROae2x3nB6Ov8@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <Z+KROae2x3nB6Ov8@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/25/25 06:19, Charles Keepax wrote:
> On Mon, Mar 24, 2025 at 04:15:24PM -0500, Pierre-Louis Bossart wrote:
>>> The primary point of interest is the SDCA Power Domain Entities
>>> (PDEs), which actually control the power status of the device. Whilst
>>> these PDEs are the primary widgets the other parts of the SDCA graph
>>> are added to maintain a consistency with the hardware abstract, and
>>> allow routing to take effect.
>>>
>>> Other minor points of slightly complexity include, the Group Entities
>>> (GEs) these set the value of several other controls, typically
>>> Selector Units (SUs) for enabling a cetain jack configuration. These
>>> are easily modelled creating a single control and sharing it among
>>> the controlled muxes.
>>
>> It wasn't able to follow the last sentence, what are 'these'?
> 
> I will attempt to rephrase this paragraph a little, but 'these'
> are situations where you have a bunch of SUs controlled by a GE.

In most cases the purpose of a GE is to control multiple SU states. However the SDCA spec took liberties with this concept and added new properties for the NDAI topologies, where a GE is present even if there is a single endpoint. It'd be worth double-checking that the way the GE is exposed in this patchset is forward-compatible with the 1.1 topologies.

>> I am not sure we can expose and control any SUs since their
>> configuration is set in hardware depending on the GE settings. IIRC
>> the SU values should be considered as read-only.
> 
> The SUs are modelled as DAPM widgets but the control linked
> to all of the SUs is the GE control. So yes the SU registers
> are never accessed only the GE register.

How would the state of those DAPM SU widgets be updated though? I think we need to 'translate' the GE settings to tell DAPM which paths can become active, but the SUs state is set by hardware so I could see a possible racy disconnect if we make a path activable but hardware hasn't done so yet.

>>> SDCA also has a slight habit of having fully connected paths, relying
>>> more on activating the PDEs to enable functionality. This doesn't map
>>> quite so perfectly to DAPM which considers the path a reason to power
>>> the PDE. Whilst in the current specification Mixer Units are defined as
>>> fixed-function, in DAPM we create a virtual control for each input. This
>>> allows paths to be connected/disconnected, providing a more ASoC style
>>> approach to managing the power.
>>
>> Humm, maybe my analysis was too naive but the SDCA PDE seemed
>> like a DAPM power supply to me. When a path becomes active,
>> DAPM turns on the power for you, and power is turned off some time
>> after the path becomes inactive.
> 
> Correct, the PDEs are modeled as supply widgets and those are
> powered up when the path is active as normal. The problem
> alluded to in this paragraph is there a couple times where
> SDCA topologies just have a permanently connected path so
> things would always power up.

Ah yes those loops would indeed be problematic, but no more than in existing non-SDCA topologies where we used pin switches to disable such loops. All existing TDM-based solutions used pin switches, I was assuming we'd use them as well for SDCA.

>> Why would we need to have a control to force the power to be turned on?
> 
> We are not having a control to force the power on, that is me
> describing the SDCA view of the world, not the Linux ASoC view
> of the world.
> 
>> And there are quite a few topologies without any Mixer Units so can
>> we depend on a solution that's not applicable across all topologies?
> 
> Most of the time things are fine because most topologies
> generally go between a dataport terminal and a physical
> terminal, so the dataport can trigger power up. There are
> only two cases I am currently aware of where this happens
> at the moment, one is the side-tone path in the UAJ topology,
> which is primarily the one I was concerned about for now. The
> other is the sense path in the SmartAmp topology, which I am
> slightly less concerned about for now.
> 
> The sense path case can't be solved with the mixer switches.
> So eventually I think we will also need to add pin switches
> on the non-dataport terminals as well, but this is thinking I
> was hoping to delay for later.
> 
> However, we should really consider the wider mechanisms defined
> by the specification rather than just the given topologies.
> User-defined topologies are allowed and people will likely make
> small uncompliant diversions from the standard topologies as well.
> 
> My opinion is that even if we end up adding the pin switches as
> well it still makes sense to allow connecting and disconnecting
> the inputs of a Mixer Unit.  These are typically where two
> audio streams come together and having the ability from the
> host side to say if you want that connection or not seems very
> valuable to me. As in SDCA land you basically make that choice by
> directly flipping the PDE.

I have no objection if there are both pin switches and MU switches. 

I view pin switches as a more generic mechanism that userpace has to set to use a specific endpoint. 

The MU switches seem like debug capabilities to isolate which path has a problem. My experience fixing Baytrail issues is that you want a default mixer switch to be on, otherwise you'll get warnings on unconnected items or 'there is no sound' bug reports. In other words, the MU switches are a nice-to-have mechanism to disable default paths, so even if userspace doesn't touch those controls sound can be heard on endpoints.
 
>> And last PDEs are typically related to terminals, while Mixer
>> Units are usually for host-generated streams.
> 
> From the view of DAPM I don't think we need to be too careful
> about that distinction. Its all just connections between widgets.
> 
>> It would also help to define which power levels you wanted to
>> control for PDEs. For me, only PS0 and PS3 can currently be modeled,
>> I have no idea how PS1 with its degraded quality would be used,
>> and PS2 depends on firmware.
> 
> Indeed, currently the code only deals with PS0 and PS3. I will
> update the commit message to call that out as well.

Sounds good.

