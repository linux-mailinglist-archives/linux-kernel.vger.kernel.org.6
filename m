Return-Path: <linux-kernel+bounces-173591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB78C028A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096051C20AF7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925C62E3E8;
	Wed,  8 May 2024 17:04:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C753110953;
	Wed,  8 May 2024 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187848; cv=none; b=frwAoQn2QpArtI/+dqJJa4fRI2GhqGw9mm2fEqCYfrFf7uCowtH6FItBD/bQeeKewKHt14wpbhnvITCdqLtD4h6XgfkflW5FSzOr2PIa0pkbHBcq40h6vZ/VPIK/7FFTumrV/1BUOfHilBSiDADqJW88cGpsa/QEWmJgHV1tKxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187848; c=relaxed/simple;
	bh=Wd3/Y3zb9sUUd0CcUKaAZJQE1xBqGNz2sOTMRrUHTCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk3+HSBgVW2m+mQnLZHst7OaxxmuOdw8djU/CtpL33E7qvyQcAdeLHMHHTqk8AJk+1NNMJPEvga3ZBGRH+8sKUxr/WcQ7oE8A1wc8nftDPc31phHLOOGMjpElnwj7HD2jDcmUPz6odYDgC6cKp3LnOPLuFme78cCUj43xm5tSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 856B81007;
	Wed,  8 May 2024 10:04:30 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B8933F6A8;
	Wed,  8 May 2024 10:04:03 -0700 (PDT)
Date: Wed, 8 May 2024 18:04:00 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/2] firmware: arm_scmi: add notification completion
 channel
Message-ID: <ZjuwgLZ1Sh5jRBWn@pluto>
References: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>

On Tue, May 07, 2024 at 11:34:59PM +0800, Peng Fan (OSS) wrote:
> Per spec:

Hi Peng,

thanks for doing this.

> Completion interrupts This transport supports polling or interrupt driven
> modes of communication. In interrupt mode, when the callee completes
> processing a message, it raises an interrupt to the caller. Hardware
> support for completion interrupts is optional.
> 
> i.MX95 SCMI firmware is fully interrupt driven, so Platform expects
> completion interrupt for Platform to Agent(P2A) notifictions.
> 
> Add another optional mailbox channel for Agent to notify Platform that
> notification message has been accepted
> 
> After notification channel status become freed, Agent will use the
> new mailbox channel to send completion interrupt to Platform.
> 
> Add shmem_channel_intr_enabled to check channel flags.

Glancing through the series I think the bindings and the code are
quite good and sensible to achieve the addition of the optional P2A 
completion interrupt.

Your current solution, though, addresses only the case of a mailbox
controller providing unidirectional channels. (which I suppose is the
one you are using on your platform)

We should take care to add such optional P2A completion interrupt support
also for the case of mailboxes sporting bidirectional channels.

For bidirectional channels we really have already the needed bindings...
..no changes there...you have just to also ring the doorbell on that same P2A
if completion IRQs are requested.

IOW, when the DT description is made by 2 mboxes + 2 shmem, means we have
both A2P and P2A provided via bidirectional channels...we currently
just use the P2A (RX) channel to receive notifs/dresp via rx_callback
(so using only the platform_to_agent direction)...now we should also ring
the P2A doorbell on the existing P2A channel if the FLAG_INTR_ENABLED is set
to signal the completion interrupt on the other direction (agent_to_platform)

Not sure if I have been clear or make it worst with my explanation :P

Thanks,
Cristian


