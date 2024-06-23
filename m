Return-Path: <linux-kernel+bounces-226477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8DD913EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 00:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431271F221A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6F18508E;
	Sun, 23 Jun 2024 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JzH81ulC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ud+IPWYy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D91184116
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719180923; cv=none; b=jKJkXMPyL1oYGyrZNkMfWSmAOV4GmkC4LanFwhpQvgUgEA2em4cKRHA8c+xAasc1Wbjw9Zmc8EfHOiCaauQ1aoNcp2LPK6KX3ux8rqSvzRIvVfAgGmFWgA2pC42DnrB2TjDYpCKh4svVXIhepJgPxptGczoe95pm2r2nnk9REM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719180923; c=relaxed/simple;
	bh=G3p2opYNc+DuFMrxPluNbQxRt4/mXCcliCMa4kNcSDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jvWsmfi1xCMDzP8zX0bhmixUaU8YQkhXGtEurO4tiDHftcSzftENczyvGkyHP1EQzAxJUGiXxrEHmctfzMeIkcQK/apArdH2U3l+zvs5ykuhmdXRlMowIMqNt3CbEhlHrQ52hchCRsqTIBnZF9kOZavndDp+FOjRoyCaA2pR55k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JzH81ulC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ud+IPWYy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719180919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmbIxEHyudMcmEN/Glce1AdKQowVKBCpY9q1Z9sFbRw=;
	b=JzH81ulCpEtaVeGMI1J2L1R6ji5LvY9zrnwkiucdy7vVwfSnpzVznK+hWi7PqkPNvbV5ke
	A3T3QMOiP5AOuFSzzeBBFe++RG6JTx/mEtgXN6SpTznS6brLjhVwzxK45xZBXhBOAzm8Wz
	djpwyKmqTlT1R81gobd+50pGnMtJzxRNlbElC+0E9Cj4rR0dz9rcpZ8+xprLNzLkr7OXTu
	1Vnx7Ao2beA2Y+cWRp6JuPoxi/zoGFXko8E4STy8dUTa63Xj8DPNbeqf2/k+3lFNO7z3nz
	WCGIu44FWqeDJOsMCDNJjs32hYYH1OjLpC2FsaHaCpGd2PaXU/HuSDBXA4PXew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719180919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmbIxEHyudMcmEN/Glce1AdKQowVKBCpY9q1Z9sFbRw=;
	b=ud+IPWYyKigV7M+ajOikatqcvTn2KDFbbdbnR9EBcmOcUQDu+Vmnnceac5diWI5r5Kr637
	64+jePSVNOx3E0CQ==
To: Antonio Borneo <antonio.borneo@foss.st.com>, Russell King
 <linux@armlinux.org.uk>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] ARM: stm32: allow build irq-stm32mp-exti driver
 as module
In-Reply-To: <2ee5ec54d3aff6e37ec1245eeb019d52e6a3d63f.camel@foss.st.com>
References: <20240620083115.204362-1-antonio.borneo@foss.st.com>
 <20240620083115.204362-8-antonio.borneo@foss.st.com> <87le2va7t5.ffs@tglx>
 <2ee5ec54d3aff6e37ec1245eeb019d52e6a3d63f.camel@foss.st.com>
Date: Mon, 24 Jun 2024 00:15:18 +0200
Message-ID: <87cyo79uh5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 23 2024 at 19:38, Antonio Borneo wrote:
> On Sun, 2024-06-23 at 19:27 +0200, Thomas Gleixner wrote:
>> On Thu, Jun 20 2024 at 10:31, Antonio Borneo wrote:
>> 
>> > Drop auto-selecting the driver, so it can be built either as a
>> > module or built-in.
>> 
>> How is the driver selected then? Has this to be done manually now?
>> 
>> If so, doesn't that break things when starting from an empty config?
>
> In patch 6/8 it is already selected through:
>
> +	depends on (ARCH_STM32 && !ARM_SINGLE_ARMV7M) || COMPILE_TEST
> +	default y

Missed that. Thanks for the clarification!

       tglx

