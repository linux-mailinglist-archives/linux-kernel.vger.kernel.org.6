Return-Path: <linux-kernel+bounces-199454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895478D8761
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B1028A09F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335FE13699A;
	Mon,  3 Jun 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K37P7wLI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yq075rAD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6E13541B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432691; cv=none; b=mRE3yOU1jW++heAS+krZWEYHkov6Cz2LXDokZKRLoIhlQFnV9I2g1RjUJLhbgUvbZyexkri8GlEk9i3FwiaVzBpuIJcVQlnIid+299xFRaVKMCdo8Wo5VNYMfjye5TiqswYJ3A/cvYgRGxrAQYoPsnsN0eucufIGpxZ75Hfhpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432691; c=relaxed/simple;
	bh=JoOQFYwq20f6YN5GiixuBNV8lqwmsNmiY+Ko8UeCnIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHuS3YG1btLHW2la8IiX79fd+oxcBTy8Thu3hFhdOTX/sRXGc1+hyPFEmGC50SwsZtbYaaChjQVt9QsckANrXL2gbDclS8g4QKQ0a94QrP6wBhuzTlXN8tKOEi7WyzJWLfiyjGlSwB7nXkHS8WSl6JV/vl1U3Q8C7yLC4B9hGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K37P7wLI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yq075rAD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717432688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg6f1ocuXVfrhbUY0XBH44cgSaMciaYAuuNaspVSgRs=;
	b=K37P7wLIE+RGMCG4x+PN4V+DxQOpX907Fl/zRBD9C0qqLYEJ8kuhEHmEZWdSYh0pA3XDAT
	D2l7G+VwgZZ+QcswHO9wiybv1Yzs7Y2Q8dQCQKJ7lYmmDcTRdstMy9BKw4UcvZfbhIlzBs
	HE3Tpw0gTZagItphDUPgFGAwt6jeBDW9Dzq0NHKEEsB0upqQ7KkPuUCvFgfohodGfEWxyL
	z+XUK5QPPzZvtOerDrqZyNoZ0+Q1/OsUC2f/zTzGL63E0+2jfZeL+IJI1Pa1yC3Hlr811W
	VH7sOMbfevCOcO4WntB5lBT/qgr6ujmrq5mWcT7f7BqUrdpcZwDEdVOLZK/5nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717432688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kg6f1ocuXVfrhbUY0XBH44cgSaMciaYAuuNaspVSgRs=;
	b=yq075rAD98dkF5sO8rtY60ZxHgR2ZCVjTWS/74tVMTtqBSIx+XHd13ECMqn+tRee6+nI05
	5oWfkmjpGiY2hHDw==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] irqdomain: Allow giving name suffix for domain
In-Reply-To: <77c64d75-43fa-47bf-bb3a-e0e49d51189d@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
 <87h6ea72f9.ffs@tglx> <77c64d75-43fa-47bf-bb3a-e0e49d51189d@gmail.com>
Date: Mon, 03 Jun 2024 18:38:07 +0200
Message-ID: <8734pu6ky8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matti!

On Mon, Jun 03 2024 at 15:19, Matti Vaittinen wrote:
> On 6/3/24 13:20, Thomas Gleixner wrote:
>> On Fri, May 24 2024 at 11:18, Matti Vaittinen wrote:
>> Now you start talking about parent interrupts. Can you please make your
>> mind up and concisely explain what this is about?
>
> I hope I can explain what I am after here. I am also very happy when 
> incorrect terminology is pointed out! So, it'd be great to know if I 
> should use 'parent' or 'physical IRQ' here after I explain this further.
>
> What I am dealing with is an I2C device (PMIC) which provides two GPIO 
> IRQ lines for SOC. This is what I meant by "physical IRQs".
>
> ----------------	INTB IRQ	-----------------
> |		|-----------------------|		|
> |	PMIC	|			|    SOC	|
> |		|-----------------------|		|
> -----------------	ERRB IRQ	-----------------
>
>
> Both the INTB and ERRB can report various events, and correct event can 
> be further read from the PMIC registers when IRQ line is asserted. I 
> think this is business as usual.
>
> I'd like to use the regmap_irq for representing these events as separate 
> 'IRQs' (which can be handled using handlers registered with 
> request_threaded_irq() as usual).
>
> Here, when talking about 'parent IRQ', I was referring to ERRB or INTB 
> as 'parent IRQ'. My thinking was that, the regmap IRQ instance uses INTB 
> or ERRB as it's parent IRQ, which it splits (demuxes) to separate "child 
> IRQs" for the rest of the PMIC drivers to use. I'd be grateful if better 
> terms were suggested so that readers can stay on same page with me.
>
> After talking with Mark:
>
> we both thought it'd be cleaner to have separate regmap IRQ instances 
> for the ERRB and INTB lines. This makes sense (to me) because a lot of 
> (almost all of?) the regmap IRQ internal data describe the IRQ line 
> related things like registers related to the IRQ line, IRQ line polarity 
> etc. Hence, making single regmap-IRQ instance to support more than one 
> <please, add what is the correct term for INTB / ERRB like line> would 
> require duplicating a plenty of the regmap data. This would make 
> registering an regmap-IRQ entity much more complex and additionally it'd 
> also complicate the internals of the regmap-IRQ. It'd be a bit like 
> trying to fill and drink a six-pack of lemonade at once, instead of 
> going a bottle by bottle :)

This makes a lot more sense now. So what I read out of this in change
log style is:

  Devices can have subfunctions where each has its own interrupt
  line. Each interrupt line acts as demultiplex interrupt for
  subfunction specific interrupts and has its distinct set of registers.

  regmap can support such a setup, but the interrupt domain code ends up
  to assign the same device name when creating the underlying per
  subfunction interrupt domains. This causes name space collision in the
  debugfs code and also leads to confusion in other places, e.g. 
  /proc/interrupts would show two distinct interrupts with the same
  domain name and hardware interrupt number.

  Instead of working around this in the driver or the regmap code, allow
  to provide a name suffix for the domain name when creating the
  interrupt domains.

  Add the infrastructure to __irq_domain_add() and expose it via
  irq_domain_create_linear_named() which is the only function required
  by the regmap code to support such setups.

Did I get it halfways right?

Thanks,

        tglx

