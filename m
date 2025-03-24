Return-Path: <linux-kernel+bounces-574467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4DDA6E5A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E352E1887A97
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FD11EA7DF;
	Mon, 24 Mar 2025 21:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wtzVG2so"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E61DED49
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851420; cv=none; b=I1lcX+cYEj3cjrJwTK0mvd1o+Rh+kAYywFD19As32SGe7OWVoHA9yCpPBN1HrFkwr/qOJZaSCcWCWn3w3PdPmxIpdrwOs3KXcEA6MvDYRXqfRCTDnv7UuW4Fd8a04P38wStXOVa5VTfNVuf825S2wdnkkFmoHg34o/x3N4cIa9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851420; c=relaxed/simple;
	bh=9q0ODkVQidS84KHZzHyv5sB0zr3Ltf0bT65GkznigYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YX4pDj7pdY67xeKjdiYF7XqNO+mtlrjNgQuopYX1H4kjwwRjjey+yrMM/cdprABCWfMCaDSErtuetLAvI3jGlXoHyOQJldIB2Qas++uos1Qj7q70SrwlIh7X8bIKW6MSqc37xxv8WDLpHExNNoEuFV4nE78vAB7z8kVChd8lqrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wtzVG2so; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2b899796-b9fc-49ef-a4a7-858baa90a36b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742851416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3m1925IKks24wn+QOG/lyq6S2HBNE+NB9T3y5BDpzw=;
	b=wtzVG2so1rR+/e/i009TM0XljXC88N1i9zynl2njzrQK0THnfeaZJpo1/wihqhaFulTmwZ
	64bwfZ7qeosmxlxwQpJi4I5kkc8rcP6bNoc70YqvnjiYCRSiC5n2x83F69ogA4KjAkjLO5
	Hgrz/QhTBNtarfNGjXmxQSqyRHAVE5U=
Date: Mon, 24 Mar 2025 16:15:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] ASoC: SDCA: Create DAPM widgets and routes from DisCo
To: Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org
Cc: lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
 peter.ujfalusi@linux.intel.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
 <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20250321163928.793301-2-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Thanks for starting this Charles.

> Use the previously parsed DisCo information from ACPI to create DAPM
> widgets and routes representing a SDCA Function. For the most part SDCA
> maps well to the DAPM abstractions.

except when it doesn't, eh?

> The primary point of interest is the SDCA Power Domain Entities
> (PDEs), which actually control the power status of the device. Whilst
> these PDEs are the primary widgets the other parts of the SDCA graph
> are added to maintain a consistency with the hardware abstract, and
> allow routing to take effect.
> 
> Other minor points of slightly complexity include, the Group Entities
> (GEs) these set the value of several other controls, typically
> Selector Units (SUs) for enabling a cetain jack configuration. These
> are easily modelled creating a single control and sharing it among
> the controlled muxes.

It wasn't able to follow the last sentence, what are 'these'?

I am not sure we can expose and control any SUs since their configuration is set in hardware depending on the GE settings. IIRC the SU values should be considered as read-only.
 
> SDCA also has a slight habit of having fully connected paths, relying
> more on activating the PDEs to enable functionality. This doesn't map
> quite so perfectly to DAPM which considers the path a reason to power
> the PDE. Whilst in the current specification Mixer Units are defined as
> fixed-function, in DAPM we create a virtual control for each input. This
> allows paths to be connected/disconnected, providing a more ASoC style
> approach to managing the power.

Humm, maybe my analysis was too naive but the SDCA PDE seemed like a DAPM power supply to me.
When a path becomes active, DAPM turns on the power for you, and power is turned off some time after the path becomes inactive.

Why would we need to have a control to force the power to be turned on? 
And there are quite a few topologies without any Mixer Units so can we depend on a solution that's not applicable across all topologies?
And last PDEs are typically related to terminals, while Mixer Units are usually for host-generated streams.

It would also help to define which power levels you wanted to control for PDEs. For me, only PS0 and PS3 can currently be modeled, I have no idea how PS1 with its degraded quality would be used, and PS2 depends on firmware.



