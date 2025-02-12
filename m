Return-Path: <linux-kernel+bounces-510286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A868DA31AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590CE167F26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51D3B667;
	Wed, 12 Feb 2025 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkLp0zfg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53F566A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739321302; cv=none; b=mMPgUbO4fEy9lOpDbZwJON0Dj4O9228P1J6z2PvhM+FewSl/sY9H0wxPGOeAc2IDIE3VwT36lqu11+55O89qDk1XSs11FnLPSMjDqaD4pVf36yT3B9KTDJmAKsBlfPnqgpFX+o/rA70c7GkI3MxhRx/9y3iRpmGzyOdu3zgsysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739321302; c=relaxed/simple;
	bh=qttLKEs05YvL+FLAfg5Pf7cQ3U8NXrrtD5D031o3wVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFQaKgBzy0ZFiqXXaTN6oziWERuTQeae8X3p8ffTGzr9rn93ZvyY1OW0N6qHdf6PEdKRuD2UbW3coi7Q6OEyxWMU6VGDpE5oT6zKsW6LuD05aWv1KIYuzd6B8gs6tgdLycZWTngjjfvjVNmtOe9mZVYX+DE9WryUPQWu3cpZpz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkLp0zfg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739321299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Fqe4muRO3/Q9bWVR2MXSP0LzyWOW0eku7tRVpawwQs=;
	b=bkLp0zfgfs5JVHRFLTpbc2fB8lXCJVdkcwqztZr9aa5jI4BpYzTRIVyCHskDyq/IUBv1Dk
	p+NomlzKQMtJ5Ecj2QvwkN5g7timtgLGUH1bwwdhPKs5UBhu4neSmW4sxzsQAOBxSh/6m+
	0igTSLhd1JsApCcIKTp5Ho3NNYz3kE0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-HzPjE3uLMvWZ7aieG-qloQ-1; Tue,
 11 Feb 2025 19:48:15 -0500
X-MC-Unique: HzPjE3uLMvWZ7aieG-qloQ-1
X-Mimecast-MFC-AGG-ID: HzPjE3uLMvWZ7aieG-qloQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 179E41800873;
	Wed, 12 Feb 2025 00:48:11 +0000 (UTC)
Received: from localhost (unknown [10.22.89.254])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F272D1800877;
	Wed, 12 Feb 2025 00:48:09 +0000 (UTC)
Date: Tue, 11 Feb 2025 21:48:08 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: debug_exception_enter() disables preemption and may call
 sleeping functions on aarch64 with RT
Message-ID: <Z6vvyKZ5eoAS435b@uudg.org>
References: <Z6YW_Kx4S2tmj2BP@uudg.org>
 <Z6n16cK85JMyowDq@J2N7QTR9R3>
 <20250210140657.UAsRw4k8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210140657.UAsRw4k8@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 10, 2025 at 03:06:57PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-10 12:49:45 [+0000], Mark Rutland wrote:
> > Hi,
> Hi,
> 
> > I don't have an immediate suggestion; I'll need to go think about this
> > for a bit. Unfortunatealy, there are several nested cans of worms here.
> > :/
> > 
> > In theory, we can go split out the EL0 "debug exceptions" into separate
> > handlers, and wouldn't generally need to disable preemption for things
> > like BRK or single-step.
> > 
> > However, it's not immediately clear to me how we could handle
> > watchpoints or breakpoints, since for those preemption/interruption
> > could change the HW state under our feet, and we rely on single-step to
> > skip past the watchpoint/breakpoint after it is handled.
> 
> Couldn't you delay sending signals until after the preempt-disable
> section? 

Looking at do_debug_exception,

void do_debug_exception(unsigned long addr_if_watchpoint, unsigned long esr,
			struct pt_regs *regs)
{
	const struct fault_info *inf = esr_to_debug_fault_info(esr);
	unsigned long pc = instruction_pointer(regs);

	debug_exception_enter(regs);

	if (user_mode(regs) && !is_ttbr0_addr(pc))
		arm64_apply_bp_hardening();

	if (inf->fn(addr_if_watchpoint, esr, regs)) {
		arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);
	}

	debug_exception_exit(regs);
}
NOKPROBE_SYMBOL(do_debug_exception);


Do you mean executing the

	arm64_notify_die(inf->name, regs, inf->sig, inf->code, pc, esr);

after re-enabling the preemption or do you mean something more
sophisticated?

Luis


> > That, and last I looked reworking this we'd need to do a larger rework
> > to split out those "debug exceptions" because of that way that currently
> > bounces through the fault handling ligic in arch/arm64/mm/.
> >
> > Mark.
> 
> Sebastian
> 
---end quoted text---


