Return-Path: <linux-kernel+bounces-283625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302094F6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F81C21B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5625518C354;
	Mon, 12 Aug 2024 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6phT4ey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aFwpJmNc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289D18953F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488860; cv=none; b=FCVlJ6SAS9g7I3pbq2pQOqbicsKx2ib8VmwkQ8rMgrRHhDHpBlimkuMGAz32I+/Rvb8B9ISe10PEPIdRi+MsJcAb5vCCfeq/2lgiX4nY6I7cb6z972HMWN/8pAVvYbF3sIBNS1ozFNc9WJGXEb+Xup5l3beBlZGO8fNmQ2C/m+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488860; c=relaxed/simple;
	bh=7T77i/5efbuLYHGQrx/1/9zluKSbqGJwDmtaLPK2kTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4/Jwtk8kqOLHB28VhzpSa7EVedcF5nESGGL+PF6SIdq+pmkPRG4xMeW37Fr4lZkAeufaBZDZHHgxgXdm5orayPPjzs5aEQp47eB5rJDAQBq6H/wIMONVU3MF6Qw1wNpYO/4T59i3dVmRqMilCC2NlAltbKZ5MAUICvIUU0n5Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6phT4ey; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aFwpJmNc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723488857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKheiafekWqvzoP2A7I39jBITIJIx9AtOzfe+CfzLkM=;
	b=p6phT4ey6VI7q581GMc/Y+nbmHWnGiquvMhljM7kArCxXMcI9E9e+h0XKJGU2Ndje5CtPW
	kEwz0+1jy3wMuFUrfsXqQT0BwHoP/FHNIfLUC3YoloCZ49qovlPcjh9vbYVVaBd8xvyiAb
	GlNYl1f5LO6zq3ZgtN9Nq9fnrwbhQsUOOuNvVqh0Yicgr0+0n6HbiTZSzPKFIW37/BuwX6
	ibkV1IHJrkbRR+mV8Ds9T5C874393ocyR5BuRA+C1TiL/4+Ml1a1R8TI0gSau/3lChyLoF
	pDNXcI8T/YtJK+Zz9B+QdmkqzX/lWIXHeVeaUYdr5pog2lMeRPEL+/7YYaP26Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723488857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VKheiafekWqvzoP2A7I39jBITIJIx9AtOzfe+CfzLkM=;
	b=aFwpJmNcv0ZZdM9D4PyHkp2DwcHyMDn4tU9LWRe6Th1fLNYvURcB+uYKCcZXyHVkqPc099
	J4LN8cM746kHbkAw==
To: Florian Rommel <mail@florommel.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Jason Wessel
 <jason.wessel@windriver.com>, Daniel Thompson
 <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>,
 Lorena Kretzschmar <qy15sije@cip.cs.fau.de>, Stefan Saecherl
 <stefan.saecherl@fau.de>, Peter Zijlstra <peterz@infradead.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Randy Dunlap
 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>, kgdb-bugreport@lists.sourceforge.net,
 x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Florian Rommel <mail@florommel.de>
Subject: Re: [PATCH v2 1/2] x86/kgdb: convert early breakpoints to poke
 breakpoints
In-Reply-To: <20240812174338.363838-2-mail@florommel.de>
References: <20240812174338.363838-1-mail@florommel.de>
 <20240812174338.363838-2-mail@florommel.de>
Date: Mon, 12 Aug 2024 20:54:16 +0200
Message-ID: <874j7pshbb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Florian!

On Mon, Aug 12 2024 at 19:43, Florian Rommel wrote:
> On x86, after booting, the kernel text is read-only.  Then, KGDB has to
> use the text_poke mechanism to install software breakpoints.  KGDB
> uses a special (x86-specific) breakpoint type for these kinds of
> breakpoints (BP_POKE_BREAKPOINT).  When removing a breakpoint, KGDB
> always adheres to the breakpoint's original installment method, which is
> determined by its type.
>
> Before this fix, early (non-"poke") breakpoints could not be removed
> after the kernel text was set as read-only since the original code
> patching mechanism was no longer allowed to remove the breakpoints.
> Eventually, this even caused the kernel to hang (loop between int3
> instruction and the function kgdb_skipexception).
>
> With this patch, we convert early breakpoints to "poke" breakpoints
> after the kernel text has been made read-only.  This makes them
> removable later.

Please check Documentation/process/ including maintainers.tip for change
log rules.

But aside of that why having this BP_TYPE dance in the first place?

kgdb_arch_set_breakpoint(...)
{
        if (system_state == SYSTEM_BOOTING) {
        	text_poke_early(...);
                return;
        }
        if (mutex_is_locked(&text_mutex))
        	return -EBUSY;
	text_poke_kgdb(...);
}

See? No breakpoint type, no magic post readonly fixup, nothing.

Similar for arch_remove_breakpoint(). I reply to that gem on the other
patch.

Thanks,

        tglx

