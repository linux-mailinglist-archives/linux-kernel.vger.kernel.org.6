Return-Path: <linux-kernel+bounces-446289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725AE9F2237
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42161886DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32477D299;
	Sun, 15 Dec 2024 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YbryKJZZ"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D80320E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734238130; cv=none; b=XUmD3UDM0/S4u6QD/Gd3eNlJZsoflN53bAQkbIONtzyLzucIbSKq0/EXsfTGw7soHBhI02Qo9L8vng3fL6RFf4WyO22G5eibf2CGanvyFsxjnKUIhD69itZ9EwOcEQZ1+nRd++RXRBHmInn5/yCoQz2b+C+3yuSkas/YP/nfEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734238130; c=relaxed/simple;
	bh=ZsJQ6/a1RyiDEqdWsYdhOrJrCF6dSA9d7ooxLHUZ264=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ65ohAfdzlpsr94rTDlX1fbP2EVDrdoN2/HJ2OfnpjGiFzIlyVl39WAnb032273mVJvzwZLxM6rbTPiSpviU1IhThVDFlQ2yBwrKx9IbfRhEIv1Nwk6tmwPhhhWvu+dTgudzdOXqCzrpArAJWEBygZRU9shwDIoCVWdfdj+McM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YbryKJZZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w6OVlvgOl4jEWyGwV92ae+43hS2e0vPxrf59xsiJAVc=; b=YbryKJZZhXtrNSXv057yH7aHW1
	D59vItLqSJFnIE24LkO3bNt1Hy4ktFBWPuaVemGw7bxcVzK3p7D5ypsusp7vTLmRAFjrNi+bZ2VlI
	bMLa57HDVtdhsdKdjWieESAezdmrwVx6o+2EofI7cR8QsCw5Yu/lLI+GZG3UdpPLR80GK8yUEOP72
	d8rCLD56JiMV2P8/ypEFUGK1wR+xHL3IjO5Iv/UTgztR4U5Rp6SbuaewFxag4TJsy5n4+fGGujS73
	qpjqviiN8C+mcR4czCPQUl3CsKvgSGag+KXPdemaebKnwjoTJZUTHNpfXOhhjCd58M2svdNAIziti
	8LWYwOZA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMgYd-00000008PnL-3OUr;
	Sun, 15 Dec 2024 04:48:43 +0000
Date: Sun, 15 Dec 2024 04:48:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241215044843.GC1977892@ZenIV>
References: <20241214182138.4e7984a2@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214182138.4e7984a2@batman.local.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 14, 2024 at 06:21:38PM -0500, Steven Rostedt wrote:

>   The real fix would be to have microblaze implement the kernel_stack_pointer()
>   function. For now, just make microblaze use the old logic which prints the
>   function graph trampoline in the function tracer.

Correction: kernel_stack_pointer() implementation there would make it _compile_,
but it wouldn't work right.

What it needs is ftrace_regs_get_stack_pointer() *and* HAVE_ARCH_FTRACE_REGS
defined to suppress the use of defaults.

Background, one more time: kernel_stack_pointer() would give you the kernel
stack pointer by struct pt_regs (if that is possible in the first place).
ftrace_regs_get_stack_pointer() gives the kernel stack pointer by whatever
object _mcount() has set up.  *IF* that object is identical to struct pt_regs
and kernel_stack_pointer() exists, you could cast the pointer to a struct pt_regs *
value and feed that to kernel_stack_pointer().  For microblaze _mcount-created
object is *NOT* the same thing as struct pt_regs, so the default would've done
you no good even if kernel_stack_pointer() existed on microblaze.

See arch/microblaze/kernel/mcount.S SAVE_REGS and compare with their
definition of struct pt_regs in arch/microblaze/include/uapi/asm/ptrace.h

IOW, immediate fix is right, but the long-term fix suggested in pull request
is not.

