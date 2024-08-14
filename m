Return-Path: <linux-kernel+bounces-286540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9C951C42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00836281DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD061B1404;
	Wed, 14 Aug 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WW4OID71";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0MXXTrT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF71E4B2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643560; cv=none; b=AzUY1cxJIESIEA6pbw/IkOZDuoc1RyzHNZ7JsKRo8d79UJyTLpn+fFbFl9qsAdhWYF+ZDbYrOg6uSzqrHWKTRlbQSH/DoVulhM7TLCQGQX43mmchKQ9cTezgZmTrZE+cqJYW7iFzSww1+arJpgbKjXCIoY2Tq36gEHLgQ1Mrsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643560; c=relaxed/simple;
	bh=HtGkSyXsVTyJQSr5taCZMMUuPrjC3Ec6Zc14IKQtPIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k97hK22L3Y0fAO3PsYkt0UW6xpUmjz4YggQMRjbpzaT00ucFMt8a5Ba2hjYu1AjlQRAn7CRGF8eSr0i93Ow7y78TgU0DcO65NbnaEuB/JdY3H4asVX9h49WgytGcGe8z92aAYCbsxctYArT2nq9JJ0Mksgf4q6KwZVwDTpWkGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WW4OID71; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0MXXTrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723643557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3lH/zrHs0dZEgDAAuKDMA+VDNtH0jYEhkmkzFIeHGM=;
	b=WW4OID71h1exgfhXYQJkPer2JXYa9fFEtzzg/DYAHG7C2XTBoJc3OoiAhxthhUHlzXCHSi
	x7Sk1mXRJqpCDz3izZygQ56yErhOYy8k4gImTG4N1+JfNMduM9kQZYpzX8v+xCmlsL7IFr
	+XsiEnrYtvtPCswQN60nKz+kmcxiWqviT6GOaQIHZgZvBj39elj2VQgygdNprE7rgvsvZE
	BvQQ6U7UAwczfVMF6Vq+t08Fl4GJw54DJhd2DYVaJwANiIDDiOZ2b2pDgpBSjHKu3q08s4
	Jlku8Y0l2cwYWuBKbiDBdII7bTkGqOGzHRJzkCbtwbUaxpsfR8iOlnvaOIbf9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723643557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p3lH/zrHs0dZEgDAAuKDMA+VDNtH0jYEhkmkzFIeHGM=;
	b=i0MXXTrTgNyIZt6j6BIJmSszP+iQ+uS2rGFugQJwZq+rOSCN8qn78zDSnpflJ4P8c4CrZS
	CnzJGuXs5JSYirDw==
To: Daniel Thompson <daniel.thompson@linaro.org>, Florian Rommel
 <mail@florommel.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson
 <dianders@chromium.org>, Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
 Stefan Saecherl <stefan.saecherl@fau.de>, Peter Zijlstra
 <peterz@infradead.org>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Randy Dunlap <rdunlap@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>, kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH WIP] x86/kgdb: trampolines for shadowed instructions
In-Reply-To: <20240814102940.GB6016@aspen.lan>
References: <87wmkkpf5v.ffs@tglx>
 <20240814085141.171564-1-mail@florommel.de>
 <20240814102940.GB6016@aspen.lan>
Date: Wed, 14 Aug 2024 15:52:36 +0200
Message-ID: <87zfpfnrdn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14 2024 at 11:29, Daniel Thompson wrote:
> On Wed, Aug 14, 2024 at 10:51:41AM +0200, Florian Rommel wrote:
> That's enough to eventuallyremove the int3 instructions but it relies
> on entering the debug trap handler and there's no limit on how long
> could take before that happens. For that reason I think the core should
> also attempt to transition BP_REMOVE_PENDING breakpoints to BP_REMOVE
> after kgdb_skipexception() returns true. That means if we keep trapping
> on a disabled breakpoint eventually we will hit a window where the
> text_mutex is free and clean things up.

Even when text_mutex is uncontended then text_poke_kgdb() is completely
broken in the KGDB NMI context when the NMI hit into anything related to
mm switching and tlb flushing, which is utilized in __text_poke().

The same problem is obviously true for installing a breakpoint from that
context.

I'm starting to be more convinced that the only sane solution for all of
this is to disable CET when KGDB is on and use CRO.WP to work around all
of this.

Thanks,

        tglx






