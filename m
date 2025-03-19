Return-Path: <linux-kernel+bounces-568378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F1BA69495
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4273AFD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AAD1A9B5B;
	Wed, 19 Mar 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwz/sI56";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41Ay8Y/y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DF14A09E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400938; cv=none; b=WWWFcp7rvxCUDWVEvxBfylp78YFopyxdqs84KDiHjpap8zGjeMi/6HnF8O2XNnS4tojlIY5HjtbymBTw49tuMzHAkDStuA6HOmIILmN0CC3DU31VrtPokfDP+JpHjGx4RR9o7rshmvwlNm1KovhHBCZ1+IYpvIYn/x5hFr4Eidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400938; c=relaxed/simple;
	bh=9Rm+Ecf93L0QuN4AYxcrohMzWZf9871Yy9GwOrQBZpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PhuzVMDdYkov/UmWu4oNvIeONF4fnoWNcGlHD4Y6xRHubH/uqAtTEZgTEPH65wcJtlNKo5UquZmcvKhN8l+hMIh1HYDrWGHgozwsaJnU+rF5SGZV/1GCx9g5/GcqABAuD6MB3D4D7WWa1tdDUoElcCAhvTJPElB+6LLvEIvp/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uwz/sI56; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41Ay8Y/y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742400934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3bqSNiWlG7o/3DIR8ylymiosqAL0mlKDTpmRL7uU6E=;
	b=uwz/sI56wdvemgwD+2tMjoiAohlfR7RGHsF4HTC6dGhYWU2RpH1KZLQA5TEcvzPa+B+qnf
	8H6P8ihBw/zgUIB8Cty95dOKxTG/yxMYgdVQkMxVeV/hbzXfaW3g62NwvUoAYt2+dS6Pi9
	GyYC5akYM+eRbZVcEfFY3kIGHWAFYPwJJtLdSfI4EiMGfGWvjcwaTHxwtxGePvi7vQz30J
	zYyAWVeK2SrRDOOAZC3fOrg/qF/Ggo8xc01ZroW7KIc8HQu/lsKtbBn2Q8nL2XTp7IE+7+
	gQORQXkpM41ZNnYZXM6MxfAXnxO6XMa1OttJMTaEwkzOmEUIQRax63aKzubuNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742400934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t3bqSNiWlG7o/3DIR8ylymiosqAL0mlKDTpmRL7uU6E=;
	b=41Ay8Y/y/+mcT8ButyDwNemURwZaeqpaMXFmBONDcqjuDnTqa8Y7vCwoi4YNlecC5cgVCB
	JX0TLwXDxlTUCnAQ==
To: wenxiong@linux.ibm.com, linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com
Cc: Wen Xiong <wenxiong@linux.ibm.com>
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <1742386474-13717-1-git-send-email-wenxiong@linux.ibm.com>
References: <1742386474-13717-1-git-send-email-wenxiong@linux.ibm.com>
Date: Wed, 19 Mar 2025 17:15:34 +0100
Message-ID: <87a59h3sk9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 19 2025 at 07:14, wenxiong@linux.ibm.com wrote:
> There is very small window: irqbalance daemon kicks in before ipr driver
> calls pci_restore_state(pdev), irqbalance daemon read back all 0 for that
> msix vector in __pci_read_msi_msg().

You fail to explain how irqbalanced is able to invoke __pci_read_msi_msg().

I assume that this happens in the set_affinity() path, which ends up in
pseries_msi_compose_msg(). pseries_msi_compose_msg() reads back the
message from the device.

> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 396a067a8a56..fcde35efb64c 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -671,7 +671,8 @@ int msi_domain_set_affinity(struct irq_data *irq_data,
>  	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
>  		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
>  		msi_check_level(irq_data->domain, msg);
> -		irq_chip_write_msi_msg(irq_data, msg);
> +		if ((msg->address_lo != 0) && (msg->address_hi != 0))
> +			irq_chip_write_msi_msg(irq_data, msg);

That's just papering over the underlying problem and thereby breaks all
architetures except your machine. address_hi _IS_ zero on most systems
and there is no requirement for address_lo to be non-zero when
address_hi is non-zero. Not going to happen.

The real problem has nothing to do with a remove/add operation. The
problem is solely in the probe function.

It does:

   pci_alloc_irq_vectors();     // Exposes interrupts in /proc/irq/
                                // which makes them visible to
                                // irqbalanced

   pci_save_state();

#A reset_device();              // Clears the config space

#B pci_restore_state();         // Restores the config space

So the driver creates inconsistent state between #A and #B, which is
wrong to begin with when it first sets up resources which are visible
to other entities.

Why are the interrupts set up _before_ the reset? That does not make any
sense.

And no, we are not going to do a random undocumented hack in generic
code to work around such a driver insanity.

Fix the problem where it was created, i.e. at the driver level.

Thanks,

        tglx






