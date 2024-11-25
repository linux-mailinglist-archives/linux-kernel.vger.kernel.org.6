Return-Path: <linux-kernel+bounces-421603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E7E9D8D76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1A3286B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6081C2454;
	Mon, 25 Nov 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn8m4EDo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6071BBBC8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732566902; cv=none; b=PMsSnGmbbdiSajza3P81zQI6RA74eWf5e5PGO7JJxR3YF1CQFMA6LwKx13u+bwn6OZrdL0lxUDal5VmxCEnZI7iQGP6KrlPyGEkeMQzd8mTCvreWIw/F5pvuoIAN1xkR3OQKvpZ8nAOZqaifgtWcn7jjMx45WcxIjHWNDXXimMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732566902; c=relaxed/simple;
	bh=0xJmV6Fv8F7uZ3U35bZV4ncl1VQmEU7hso9MskULO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjDMaDeh/1jWi3pS2IbItPGac3U7EDOwGLxux6Rx3dnSbHosfpPyCE4aL1JoTLDkAEq3vpOJ8N2m7fHjeoVtZByP3kqp8VAFyIBbXUnCmO7Cy7W9z6EG3Fih1mai9gck97kIE4qWdMm2VR8N9lsSVaop6loCrRhyXcRbOAlJUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn8m4EDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D85C4CED2;
	Mon, 25 Nov 2024 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732566900;
	bh=0xJmV6Fv8F7uZ3U35bZV4ncl1VQmEU7hso9MskULO/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn8m4EDoPqdYRheWzAvmNaWcws2w9cdBCps4+YXKKpWXF1KTrG1RIfyNybZMZhp9H
	 K3kMNgntTQnJNbtASxmGP6IuSWPmcy2uoIRVd3BmOxLlFl2XqUsItbFpIiiQoY1aWg
	 f2yuD1p2dfTj5MeuK3XypG5E7Dvpz1kOffEB8WOmP/m2XjuSAqSA3FGBpYrYNg8KSd
	 t02Mi0uqREOvt01bgYkM8Nkwd4Tggmd6lEhw0KnvXBP63CJLBQjHMlV62VYR74IrLY
	 78Szxonz86bABrxUh3tzQ4GH/HyRKFRXFy847d1/C/LelcmAIRdTJ+0LVulikL7lFb
	 WmeIHV7vGgHDw==
Date: Mon, 25 Nov 2024 21:34:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org
Subject: Re: [RFC PATCH v2 16/16] [DO NOT MERGE] x86/kexec: enable DEBUG
Message-ID: <Z0TfblQeVRnDc-S1@gmail.com>
References: <20241122224715.171751-1-dwmw2@infradead.org>
 <20241122224715.171751-17-dwmw2@infradead.org>
 <Z0RBl6pzNf5irop9@gmail.com>
 <334ae44077315e2b69529b6fef8d85ec55f80ecf.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334ae44077315e2b69529b6fef8d85ec55f80ecf.camel@infradead.org>


* David Woodhouse <dwmw2@infradead.org> wrote:

> > Just curious: did you write this code to debug the series, or was 
> > there some original hair-tearing regression that motivated you? Is 
> > there's an upstream fix to marvel at and be horrified about in 
> > equal measure?
> 
> https://lore.kernel.org/all/2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com/t/#u
> is the upstream fix.

Which ended up being the following upstream commit:

  88a921aa3c6b ("x86/sev: Ensure that RMP table fixups are reserved")

Might make sense to add this commit reference to one of the central 
patches of the GDT/IDT code, to document how this feature is able to 
pin down very hard to debug regressions. (Even if the upstream fix was 
done independently in probably luckier circumstances.)

> [...] It's all the more horrifying because it was already *fixed* 
> upstream before I lost weeks of my life to chasing it. And the 
> trigger which actually made it *happen*, and made our production 
> systems allocate memory within that dangerous 1MiB region adjacent to 
> the RMP table, was a tweak to the NMI watchdog period... leading to 
> an assumption that we were getting stray perf NMIs during the kexec, 
> and a *long* wild goose chase based on that false assumption...

:-/

> Once I'd written the debug code, I just wanted to clean it up a bit 
> and push it out for the benefit of others; that *was* the main point 
> of this series. All the rest of the cleanups are just yak shaving.
> 
> The realisation that we never even explicitly mapped the control code 
> page and always just got lucky because it happened to be in the same 
> 2MiB or 1GiB superpage as something else that we did map... was just 
> a bonus :)

I'm amazed and horrified in equal measure ;-)

> (That one is fixed in v3 which I'll post shortly, and is already in 
> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/kexec-debug
> )
> 
> > I'd argue that this debugging code probably needs a default-off Kconfig 
> > option, even with the obvious hard-coded environmental limitations & 
> > assumptions it has. Could be useful to very early debugging & would 
> > preserve your effort without it bitrotting too obviously.
> 
> Yeah. In v3 I've made it a config option, and made it use the 
> early_printk serial console (as long as that's an I/O based 8250; we 
> can add others too later).

That's lovely!

Thanks,

	Ingo

