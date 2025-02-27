Return-Path: <linux-kernel+bounces-536187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D620DA47C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0A8188D83A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974D922A1CF;
	Thu, 27 Feb 2025 11:49:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973146FB0;
	Thu, 27 Feb 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656945; cv=none; b=LaPOkO8bE3JpGSjJWk2VH+Rgk1dlQSVE2NNMTfWzJHAKwGu2+fHWY0KJJ+syCGDwQlehwtn/pW4SzIf9dqIFN0THq54huOvaAySWy7yw9NdV0+FOKhoTVRNc39vvDEV7pnJEx1gm3CnTf5ngejYLKBSh5cAMlw2G2Z+X1V+IPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656945; c=relaxed/simple;
	bh=4JDTmRQCr6VhgsN3fSabBjy3RyKaEaYTDKQFgq/ii64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ4wgZcG/uj+dbB7LrRjfFLHoMREvS7q1jCPUtedwZ2AXaKPXpCTdtDjKwT8RJvYDHkozqKaxEmxnGCZJF7YKc02p2mwnIfVPUskCp3tmIllDWsecKCEciaf2F1q1v5Pk2/QSvz2zjVDF2h2T7zdo46XKRbf8hLZKodjKDuVobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82B831688;
	Thu, 27 Feb 2025 03:49:18 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 015903F6A8;
	Thu, 27 Feb 2025 03:49:00 -0800 (PST)
Date: Thu, 27 Feb 2025 11:48:51 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, saravanak@google.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <Z8BRFezgiWDtmdd4@pluto>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226094456.2351571-1-peng.fan@oss.nxp.com>

On Wed, Feb 26, 2025 at 05:44:56PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add compatible string for the protocols by adding new nodes
> The current nodename pattern is "protocol@[0-9a-f]+$", the new node

Hi Peng,

> name will be "scmi-[a-z\-]+$".
> With compatible string and new nodename, cpufreq and devfreq could be
> separated into two nodes. And fwdevlink could correctly link suppliers
> and consumers.

beside the backward compatibility issues that Rob mentioned, the thing
that worries me most is that, while the current bindings describe the
SCMI protocols because the protocols are WHAT the platform FW exposes
(and that is all that is needed by drivers to refer to a protocol and
its resources)...here you are getting rid of all of this, and moving to
describe basically the various devices that will use a protocol,
potentially the same protocol, just to have a distinct fw_node ...
(...I mean my understanding is that there wont be any protocol nodes
left when the scmi- variant are present and, once, somehow, we will
have transitioned into this...right ?)

I haven't really had the time to go through properly your proposed
solution to understand fully all its possible side-effects and how
many SCMI features could be destroyed by removing protocol nodes
descriptor as a whole...but...off the top of my head, as a quick
example, how you will define a per-protocol dedicated transport
channel in this new scenario ?
...because You wont have anymore a protocol descriptor where to fit
this AND you could have multiple DT nodes describing drivers that use
that SAME protocol, so using this new nodes to fit the same
transport-chan descriptors wont be possible either....

IOW, sincerely, I understand you want to resolve the problem with
fw_devlink (me too), but nuking down everything, while loosing, possibly,
a number of the existing functionalities of the SCMI stack just to make
it work with fw_devlink at all cost it does not seem to me an acceptable
trade-off...

...killing the whole existing protocols descriptors structure seems to
me a recipe for disaster, also because, it just goes against the very
essence of the objects that the FW exposes and the bindings can describe:
as an example, the SCMI platform server manage and exposes PERF_PROTOCOL
and its related DOMAINS (all fully discoverable without any bindings),
so, THAT is what is described in the bindings and referred by SCMI driver
users: SCMI FW does NOT handle/expose TWO distinct perf devices, like the
cpufreq/devfreq-device that you are trying to describe...

As Sudeep mentioned, IMHO this seems mostly an *unsolved* implementation
problem more than an actual issue with the bindings and how we describe
SCMI resources that we need to refer to..

> With compatible string, and driver updated.
> - Differnet vendor drivers with same SCMI protocol ID could be built in
>   without concerning vendor A's driver got probed when using vendor B's
>   SoC

as said, this is a corner case that is easily solvable with the current
layout (and I will post a patch soon-ish to addess this...)

> - NXP scmi pinctrl and ARM scmi pinctrl could be both built in, without
>   concerning arm scmi platform takes nxp scmi pinctrl node as supplier.
> 

..the only real issue is the general fw_devlink issue as in cpufreq vs
devfreq...

Thanks,
Cristian

