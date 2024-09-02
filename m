Return-Path: <linux-kernel+bounces-310742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAD9680AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21881F25FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D9155A52;
	Mon,  2 Sep 2024 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XqlsMWPC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0XqcNPHh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8BEAD0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262464; cv=none; b=prMnRWV/69DoDnPbyxvp3k9mafMdwL01xP+POlMnpGCZqE6xrylMVPFkZo1QrfMu/6LshmBeHBz88dxqf/pNMoqcuPPKL4o/MKkmiI58rdFwWQ/3cTibBzRj9JjkFAF32khKzBiwGDxvkhxXXxv7OK5IrsubC6960I7zGFLIaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262464; c=relaxed/simple;
	bh=gHIat7E1OmcsL9++sMcM0lOcZWWlzkQK4RPZ7ULK3Bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CxSgwFR0Kn8OuuTs5Kr1mcdV415Kbl/kVarIiymHml4vDnN7NrZLL35k2FCNcIRz2IHQ/UOGplquxYhDn28Gs+/V2PMwwpi6xQi8gJJzmYfMDpcD5v+3bnk+MV6s65HEu4nI2W91n/A8SfesQWwBkZ1eg7e1tjXC0xLs/b8gRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XqlsMWPC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0XqcNPHh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725262461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXVxKmdLptWcQCY4ZWfrhM8giQpKNSqHBQPRe6/X2nE=;
	b=XqlsMWPC7CLr2RYrAhq7Nu29wOJ5AGzNSm0TFkoIXLyPUuCB2AkiLyLqD+vMHvW9TCuAom
	rNJ3umU5liB/m71EjbTvRW+S0c8qh15pGNWtmExZFRkrT2QPcbbrsjaitsvnybJjfm5vBz
	QI7cmN/nV7FwufKxOvdxm8yg3j7ymt8xoewju9nPkU/xwz7YidTuR7TA4ZkjWv9qYHw+ub
	r+7L9HWYxbzpL/zDTl8+yTuoRDYzWft3M/cXsEITUo1NJ+Blqoutmr201GS+6W4K8hp7E0
	BYi14yi6EXLupC4EVWPs8GJxX/SGAT4Lr0Ijnm/e8OLRjmd3KDha1IbV3/x4DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725262461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yXVxKmdLptWcQCY4ZWfrhM8giQpKNSqHBQPRe6/X2nE=;
	b=0XqcNPHhfwpydVQFoeKRjjSPGdESjrglZ/PFBsSp+pE/BkTDuY25FKIjOmbSvBHQsBuOVQ
	jPPC2UriM1sjLoAA==
To: Richard Clark <richard.xnu.clark@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 torvalds@linux-foundation.org, richard.xnu.clark@gmail.com
Subject: Re: [PATCH] irq: fix the interrupt trigger type override issue
In-Reply-To: <ZtUuYXSq8g2Mphuq@den-build>
References: <ZtUuYXSq8g2Mphuq@den-build>
Date: Mon, 02 Sep 2024 09:34:20 +0200
Message-ID: <87r0a27blv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Richard!

On Mon, Sep 02 2024 at 11:17, Richard Clark wrote:

The subsystem prefix is 'irqdomain' not 'irq'

# git log --online $FILE

gives you a decent hint.

> In current implementation, the trigger type in 'flags' when calling request_irq
> will override the type value get from the firmware(dt/acpi node) if they are
> not consistent, and the overrided trigger type value will be retained by irq_data,
> consequently the type value get from the firmware will not match the retained one
> next time in case the virq is available.
>
> Thus below error message will be observed by the __2nd__ 'insmod' within the
> 'insmod - rmmod - insmod' operation sequence for the same device driver kernel
> module, in which request_irq(..., IRQ_TYPE_LEVEL_HIGH, ...) is used:
>
> 	irq: type mismatch, failed to map hwirq-182 for interrupt-controller!

How so?

1) insmod()
     irq_create_fwspec_mapping(fwspec)
       irq_domain_translate(fwspec, ... &type); <- Sets type to the FW value
     
       virq = irq_find_mapping(domain, hwirq);
       if (virq) {
         // Path not taken
       }

       // Map interrupt
       ...
       
       irqd_set_trigger_type(..., type);

2) rmmod()
     tears down mapping

3) insmod()

      Should be exactly the same as #1 because the previous mapping was
      torn down by rmmod()

Even if the first mapping is not torn down by rmmod(), which is a bug in
itself, then the type is exactly the same as the firmware describes it, no?

So how exactly does that happen what you describe?

> The corresponding 'interrupts' property of that device node is:
> 	interrupts = <0 150 1>;
>
> This commit fixes the above issue by adding a new checker -
> irqd_trigger_type_was_set:

This commit is equaly redundant as 'This patch'

# git grep 'This patch' Documentation/process/

Also 'new checker' is not really a technical term.

Thanks,

        tglx

