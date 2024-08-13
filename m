Return-Path: <linux-kernel+bounces-284367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF195003B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436611C20994
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46C716EB56;
	Tue, 13 Aug 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkJUGHGi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2Tksopv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3016DEAC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538649; cv=none; b=FHC5ex/RukIDItE3RBl1qQAX7OOALhARjN0PuvjzDj1tN2KYR/GDvLFX+I0B/oaWlY8hqj++rWPmWzkSMpUFyiVL0I8pyNlZ/FKiZz9wWua8Ab/DX9nd4KdlXZa90hRyuaOR/dCJ3/gPN7k5pb6yvRatP9qWGhugL55RMR0UuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538649; c=relaxed/simple;
	bh=boXePfkYg4XqdgNXT4VG4PsHox617vQ6KJjv9fVgWgc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rimmga0dS5wETHoCTiS24J6F92mJsYnyFGy1lMGV9jztG/zOsPxRONxLcldf2E5CqW6Q8voZTjY7MhZXzPiiC4YWnHRxH96iEOxqPbysrv7LjKBJd62DJpl5a7F4dvh3V7FhBiHm6tsRkcKCPYLRhwmv4jegw/+aTegAk9Zco30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JkJUGHGi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2Tksopv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723538645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Db4uTbKrYb5xs3EMUWjkfZCmXCSkbRF3llb4xnZB3c0=;
	b=JkJUGHGiZWM5gwS1QRvb7CYV+kEth1oDzn86LGWILn+wXLI44hK4SZudGgFSxrw/QOSlCI
	iChM5WweRVT7s0UTTHWIQ2FzfvywipuW3EQ9VSB1hNeSQ8879DqnCDd5v/7ZC7mTw1jwST
	qitBwaOXaIIGdbmDHb46/im4+H9RQEuEMc/9Dkq0RrEMrM1dL8ADM8uxIPTaEJhUmm/QUg
	5T2P5ewx3SUVBsHdRJbVJnMm6/quf6MW/lbdVKsOczmJcxzQLQikGuBvrIIfCShrffbbBn
	8uwi5xKR6e8CdcBRPQgoq3JBbEtv0cRlzgGd2udyOgSvBLyMPLItbf4vYT5NPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723538645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Db4uTbKrYb5xs3EMUWjkfZCmXCSkbRF3llb4xnZB3c0=;
	b=N2Tksopvo284NppX1WwI2wDFmFyGSsvVxSu21iPVV2NMBQ0/uQfSREwjsmWCTfoSG9o7ho
	X16LM1zijuL81fDA==
To: Shanker Donthineni <sdonthineni@nvidia.com>, Marc Zyngier
 <maz@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Sudeep Holla
 <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH] irqchip/gic-v3: Allow unused SGIs for drivers/modules
In-Reply-To: <20240813033925.925947-1-sdonthineni@nvidia.com>
References: <20240813033925.925947-1-sdonthineni@nvidia.com>
Date: Tue, 13 Aug 2024 10:44:04 +0200
Message-ID: <87le10rewb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 22:39, Shanker Donthineni wrote:
> The commit 897e9e60c016 ("firmware: arm_ffa: Initial support for scheduler
> receiver interrupt") adds support for SGI interrupts in the FFA driver.
> However, the validation for SGIs in the GICv3 is too strict, causing the
> driver probe to fail.
>
> This patch relaxes the SGI validation check, allowing callers to use SGIs

# git grep "This patch" Documentation/process.

> if the requested SGI number is greater than or equal to MAX_IPI, which
> fixes the TFA driver probe failure.
>
> This issue is observed on NVIDIA server platform with FFA-v1.1.
>  [    7.918099] PTP clock support registered
>  [    7.922110] EDAC MC: Ver: 3.0.0
>  [    7.945063] ARM FF-A: Driver version 1.1
>  [    7.949068] ARM FF-A: Firmware version 1.1 found
>  [    7.977832] GICv3: [Firmware Bug]: Illegal GSI8 translation request
>  [    7.984237] ARM FF-A: Failed to create IRQ mapping!
>  [    7.989220] ARM FF-A: Notification setup failed -61, not enabled
>  [    8.000198] ARM FF-A: Failed to register driver sched callback -95
>  [    8.011322] scmi_core: SCMI protocol bus registered

Please get rid of the time stamps and reduce it to the relevant
parts. Neither the time stamps nor PTP/EDAC/SCMI provide any useful
information.

Thanks,

        tglx

