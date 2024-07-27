Return-Path: <linux-kernel+bounces-264153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB1193DF8C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 15:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16134B21565
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51316DED9;
	Sat, 27 Jul 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pE8QbT5X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Je/ILuM9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BCF42AAA
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722087458; cv=none; b=slKaUlLBHilcSFEPqG/8AoM/xon13z0kNGHoluD95g1g5mXD8rGFlgQ6TPvfLMDSIRfNUpWOS+wSMtzxcym761Wkb00SvArE7W41VglRzHA9pWI04eKyCJqJF6M1WXlk1Yx9XS62l5tOWKp18jdpmlOWMyq7WhsBJKJRKS3IwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722087458; c=relaxed/simple;
	bh=tzkq8WEcf+3v6PeUm7CO8YqKg0mBewTSgfAsShsKr0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFnOHBTrUnJ+Dpv00GKX0F6Ssracy5D1fIBmyI+JO/c/UztuRkwKahlWjjddnf7Hk+Sx8ut/ZSjqaSJu+tc1rJWktf0Ic20lriQ+70uWX/lriLyerLSCPMcFUbeOLY0XA04XUd2m+QfzZuYzLfsnk02dds0Cd7T2ySZf2NY6Mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pE8QbT5X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Je/ILuM9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722087455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGdRuRyl0hKvI8qEOc756lQsBphS3xH9UJRPPHr88G8=;
	b=pE8QbT5XFqHgUDqtExLHa9kbOe3jVdqjp57voiSOq1+BdfaWGRkTWp2A2O8ST1dPCyY3W+
	OhxkxyqQzTHZMaDgLYXpSnNw+JgVKoSzk/cQ5jbaHIHD44uU9QJGb+4IsLFHK65xm9Ba6Q
	qFLlzvAcfDNrsZvRxYpwoSn1PrkKSRwqB5mJTENhpJjDJC5bQcu9xltblwPzvXBOoBxDgt
	bZxDISTy1DaXvETpOkwFfn9f3+ZMKpBnGjKCkinSKVB9bwf2VBHlD9L8CI1q6k8pbCacPB
	8G1AHOkwPttTWUjc8LcfRURAuammtDBCroo0PSkG5k+4sVTNl8ncxFbT88eVjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722087455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rGdRuRyl0hKvI8qEOc756lQsBphS3xH9UJRPPHr88G8=;
	b=Je/ILuM98zDzFnRBZBwgZYz+a+72f/sXA1LmsAMxPlYCDvjjVc3P/IwMCq9NJi2lRT+8/x
	AWQvU9+X2SAn5UCw==
To: ysionneau@kalrayinc.com, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, Vincent Chardon
 <vincent.chardon@elsys-design.com>, Jules Maselbas <jmaselbas@zdiv.net>
Subject: Re: [RFC PATCH v3 22/37] irqchip: Add kvx-core-intc core interrupt
 controller driver
In-Reply-To: <20240722094226.21602-23-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-23-ysionneau@kalrayinc.com>
Date: Sat, 27 Jul 2024 15:37:35 +0200
Message-ID: <87o76jt0ps.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 22 2024 at 11:41, ysionneau@kalrayinc.com wrote:
> +static int __init
> +kvx_init_core_intc(struct device_node *intc, struct device_node *parent)
> +{
> +	uint32_t core_nr_irqs;
> +	unsigned long cpuid;
> +	int ret;
> +
> +	ret = kvx_of_parent_cpuid(intc, &cpuid);
> +	if (ret)
> +		panic("core intc has no CPU parent\n");
> +
> +	if (smp_processor_id() != cpuid) {
> +		fwnode_dev_initialized(of_fwnode_handle(intc), true);
> +		return 0;
> +	}
> +
> +	if (of_property_read_u32(intc, "kalray,intc-nr-irqs", &core_nr_irqs))
> +		core_nr_irqs = KVX_CORE_INTC_IRQ;
> +
> +	/* We only have up to 32 interrupts,
> +	 * linear is likely to be the best choice

Use proper comment style please.

Thanks,

        tglx

