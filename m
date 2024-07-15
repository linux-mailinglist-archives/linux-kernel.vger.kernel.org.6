Return-Path: <linux-kernel+bounces-252530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFF99314A0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBED1C217F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB618C330;
	Mon, 15 Jul 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieQoWpZ/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQJw2MX7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42CB291E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721047660; cv=none; b=FuzRTUqyDJ88mnI1tp6Smc3qCVG2SL/I71giagDZyzCrqi3w7oGwtMgRiq0+sD+Xs0bRMWtxtlC/qeQa2RL1HnNJM4x9kyE/731wmz43V9bHkVGFAaxwamB3uKewhhnjVHMisvWWHc54q5+p0hqwORNFrqcB19mAuWyfp0hXRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721047660; c=relaxed/simple;
	bh=9I1oOnHdeQDPPriM/AY5QNoAOHLqsqlQTcuGAFr/R/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fnw23zvyxLblZTXxQbCo7xonbBHEmPHgV+kANI9RrJPgMKYKSnUFGQlmyZxD3rXsc/dgOCC1QSqmwz3UoxOgrWHy6iIiBTw4MJ8bIBX7KTeteQCpZQYSNVrW0xvC5v3GNcHC06AL6o1T0ApVfQFlO0jketiRqPomp7wKRcS9Bpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ieQoWpZ/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQJw2MX7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721047651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gud188d0RhjEMW9xxheVMvW5Cyc350/S2inVZljY5Tw=;
	b=ieQoWpZ/VmqBfzgaY6xmiud+2Sy05rzleH2fWRdtPEl6ynOTEPkfK80X0bQAMzsrBuvaIH
	rhMlo8pFdtUkP9bloSOV+MmSQeelfSF26GTCrpTiH9YJxs87PBpKQDMspBPQkGHEONsQqy
	8Gcg6WEVmXCi7gbgBBIgmruuhY/eH7HV3B7Kjl51AfyITU3l1c6tfenwTIgTJwp4ao6I+G
	Y0snYgQ9TZVqyucarmLzyoZsHH8FlXT8mbp8R6AxXLos+p6JQQSDjIGXDju2tua7HfBKfZ
	h8FxbaF77+DG8pHjI0cUjOK0yaR19uJetxyJb5G0NtNYgfmCv9psa3FWLZlMNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721047651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gud188d0RhjEMW9xxheVMvW5Cyc350/S2inVZljY5Tw=;
	b=TQJw2MX7baLAkvhjsIqZpjerUlU259OAd35jcyFI+J2opzm9JcsilALliXaphnjQX0l5Dc
	F5PiZAcS5kJUTiAw==
To: Johan Hovold <johan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] irq/core for v6.11-rc1
In-Reply-To: <ZpUHuugPspWjwu49@hovoldconsulting.com>
References: <172099001487.1942258.17671805941963584080.tglx@xen13>
 <172099001665.1942258.758282869896052475.tglx@xen13>
 <ZpUHuugPspWjwu49@hovoldconsulting.com>
Date: Mon, 15 Jul 2024 14:47:31 +0200
Message-ID: <87o76yrfdo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 15 2024 at 13:27, Johan Hovold wrote:
> On Sun, Jul 14, 2024 at 10:50:06PM +0200, Thomas Gleixner wrote:
>>       Aside of that it paves the way for ARM/ARM64 to utilize the dynamic
>>       allocation of PCI/MSI interrupts and to support the upcoming non
>>       standard IMS (Interrupt Message Store) mechanism on PCIe devices
>
> This only showed up in linux-next last Friday and broke PCI/MSI
> interrupts on Qualcomm machines like the Lenovo ThinkPad X13s as I just
> reported here:

Bah. It got late into next because we asked people for weeks to test it...

> 	https://lore.kernel.org/all/ZpUFl4uMCT8YwkUE@hovoldconsulting.com/
>
> I have not had time to debug this further, but it may be worth holding
> off on merging until we've taken a closer at look at the breakage.

Yes. Linus please ignore that branch for now.

Thanks,

        tglx

