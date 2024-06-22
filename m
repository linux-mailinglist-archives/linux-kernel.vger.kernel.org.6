Return-Path: <linux-kernel+bounces-225857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3742913624
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 23:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F07B22367
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98726F513;
	Sat, 22 Jun 2024 21:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJ6CItV/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaYvvJyV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C3F4597A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719091794; cv=none; b=gX3cTF9cUdlMogYoLWP0SWq+kqoIaiP8dl15l0M3DL1M+MFudf4iVTOLAQBwkY1buHp6XxJ5TdibmY6e1hmFyDv51u47eYpmmQrRtsrSzeEbSIqgePRAOdursqSmxil0OSbol6MIyn3KPV8i3UIZBm7/Hqpxd3hm7BRpMTtkv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719091794; c=relaxed/simple;
	bh=Y6LLum72Z1Yd7mcihDvGn4NvoQncY5WO+4iOOaHWaoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d9AANubciOfwFxLzGzTOoOcf6FXewQ32hCkmK56NcMRxnxnafwBmA5oE2RsSjGnyLQTZfjbmz1jxTCW66uOgI0Wc/hFvQT6TW3CHwCGp8TvHXrzJ+jpUxEoJYINALycJ/IXpId4Ozp3FQcuc7zQOUVGnb7Zfurb/uVjrdONpzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJ6CItV/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaYvvJyV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719091790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KQ2EoR3wFdtA88jBwv51Wj99EFEpegqAlD2wICqBgA=;
	b=HJ6CItV/bhV2MZubgdpvd+W5le/hslxM5tQd3iSUkJgvTVMRvzVthQIa02BgGdY+NWNJWT
	+4LoyZgJXNJ13uqZGFq6JeLDKENQtUdLeeIkUsT0j5JhAsIcLj7fpRnn6BFfyVnUwmUqoS
	oON9dJ0zElu7epDqtggV4VnnL0dKOrA/BIdTAQIHbZ+WVH4qfhkVP5VmdMSns66nMDqtjY
	R+rCVsluHAnDaoYFbTqg+JYtjOoh/UrUmXHPVrL/apvAzW8sLyT3RDA1q9i7NxKIsCCVgW
	ANtwuiGyjNBkMftPHZ58o+kVHSRll1Ge5ZcpHEVZujLeUpESkFpKgY9+KYDYug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719091790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KQ2EoR3wFdtA88jBwv51Wj99EFEpegqAlD2wICqBgA=;
	b=JaYvvJyVsRVexyd4EuAWuWSbRS1qscIqGsBDjFg9p4nCrn3glfVXoWH2RbcnUJf3SymR5P
	5Pu+Dx+khj6+VxBg==
To: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
 <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 alexandru.elisei@arm.com, linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH v2 0/5] arm64: irqchip/gic-v3: Use compiletime constant
 PMR values
In-Reply-To: <ZnW3yAjsxutJAEih@arm.com>
References: <20240617111841.2529370-1-mark.rutland@arm.com>
 <ZnW3yAjsxutJAEih@arm.com>
Date: Sat, 22 Jun 2024 23:29:50 +0200
Message-ID: <87h6dkzmwh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jun 21 2024 at 18:26, Catalin Marinas wrote:
> On Mon, Jun 17, 2024 at 12:18:36PM +0100, Mark Rutland wrote:
>> Mark Rutland (5):
>>   wordpart.h: Add REPEAT_BYTE_U32()
>>   irqchip/gic-common: Remove sync_access callback
>>   irqchip/gic-v3: Make distributor priorities variables
>>   irqchip/gic-v3: Detect GICD_CTRL.DS and SCR_EL3.FIQ earlier
>>   arm64: irqchip/gic-v3: Select priorities at boot time
>> 
>>  arch/arm64/include/asm/arch_gicv3.h     |  15 --
>>  arch/arm64/include/asm/ptrace.h         |  35 +---
>>  arch/arm64/kernel/image-vars.h          |   5 -
>>  drivers/irqchip/irq-gic-common.c        |  22 +--
>>  drivers/irqchip/irq-gic-common.h        |   7 +-
>>  drivers/irqchip/irq-gic-v3-its.c        |  11 +-
>>  drivers/irqchip/irq-gic-v3.c            | 225 ++++++++++++------------
>>  drivers/irqchip/irq-gic.c               |  10 +-
>>  drivers/irqchip/irq-hip04.c             |   6 +-
>>  include/linux/irqchip/arm-gic-common.h  |   4 -
>>  include/linux/irqchip/arm-gic-v3-prio.h |  52 ++++++
>>  include/linux/irqchip/arm-gic-v3.h      |   2 +-
>>  include/linux/wordpart.h                |   8 +
>>  13 files changed, 201 insertions(+), 201 deletions(-)
>>  create mode 100644 include/linux/irqchip/arm-gic-v3-prio.h
>
> Are you ok for these patches to go through the arm64 tree (I can put
> them on a stable branch) or you'd rather get them through the irqchip
> tree? Either way, I don't expect (major) conflicts with the arm64 tree.

Take them through your tree with my Acked-by. Yes a branch would be
appreciated just in case.

There is also

      https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@huawei.com

which fiddles with the GIC but most of this is not irqchip code. No idea
how that is supposed to find it's way into the tree.

Thanks,

        tglx

