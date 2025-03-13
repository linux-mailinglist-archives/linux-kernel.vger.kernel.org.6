Return-Path: <linux-kernel+bounces-559346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E340AA5F285
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31077189280C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62465266B58;
	Thu, 13 Mar 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1jHfb9dz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mrtQStsH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B719259C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865510; cv=none; b=dDZaeeFlkhBRjstiZxXxZZMQxmsvj8PFxNgc7Grebkr9/2KZSwLdNkUrxJKVHIvAqvscY5seYv+w6PVBprzNoyOInOGuwrOszg6aJNXvfNiub9iEuvrCS2PEZSGsV3BMXXkoviCPxGtqo7L8gTGn3YwcFsoVw9jnG8f3U7TBpv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865510; c=relaxed/simple;
	bh=IoA43RceXYtkG5EQDG+mgPkT5/pkAddxeBI+VeMEnQo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dc33ALlp6VJuwfQq7DXJ4S2dj28wq66uJvIj6vgPunmfgpx8KfaUcjcYIx433jNSFpL8QSZpKYxNADmf3jeP5foPudpOMyWuYYw6Fo9jjwxQQIdoyIgAfEJYebqcaQrEC3M5PTVpCIIlWeqTmitRlbpZxzkJuXVcljIxfgXD0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1jHfb9dz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mrtQStsH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBGsHXEvPBYNAf4b8J6AG5kQTKmmeekBmR1459Ip74Q=;
	b=1jHfb9dz27ExF7yn4BoHmDRJo5S/+LVZoz4OrtXlcVaebj2CxvT6wKHI6uN9rwarnw69Dt
	c7gy4chbPdImXGjL0uQLj1Bpa/wtAvN4Uu1VllIaYItVvmu9OgNQQM22pl3r4ctctWp6F4
	GNAgSGV3hsicHKk4hkkHaiP2MyEVRTzgbd9UHFYr/euPZZRV0PgFBjGXAZ8fKiJI9wdckD
	fYuGQFF5mZ0u9REu0wNUvByZ1DDdfrp1fHHxGEWIzkUFAJ85ueUehlKOZpgv/JtzlgzDVA
	NaZWicogp4ULheTPTpEO/lEO+j6xkcbbW5NLJfnaYmDEHejN6HJos1FEj9Ivgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBGsHXEvPBYNAf4b8J6AG5kQTKmmeekBmR1459Ip74Q=;
	b=mrtQStsHXYflDSPySCIdlE0tzqYC4syUeaMrxPpmyP8TwoZh7uPlkHmFeLgA4Zw6nEt6A8
	wtHLXJ239JhXnuBA==
To: ye.xingchen@zte.com.cn
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] genirq: Fix parameter type in declaration and
 definition
In-Reply-To: <20250313161803777QVS2cRAMUHinpoDwqg1XZ@zte.com.cn>
References: <20250313161803777QVS2cRAMUHinpoDwqg1XZ@zte.com.cn>
Date: Thu, 13 Mar 2025 12:31:47 +0100
Message-ID: <87o6y55fq4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 13 2025 at 16:18, ye xingchen wrote:

$Subject: ... Fix ...

There is nothing to fix here. It's correct code.

> This patch aligns the parameter name in the definition with the

See other reply.

> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -2860,7 +2860,7 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
>   *	interrupt controller has per-cpu registers.
>   */
>  int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
> -			  bool val)
> +			  bool state)

Now the kernel doc of that function is inconsistent.

You are not making anything more consistent, you are actively making it
worse. Please stop sending half thought out patches every half an hour.

Thanks,

        tglx




