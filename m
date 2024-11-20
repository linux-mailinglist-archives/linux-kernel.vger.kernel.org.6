Return-Path: <linux-kernel+bounces-415511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A119D3731
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C186F1F21982
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE23419AA68;
	Wed, 20 Nov 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VQgphtJc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CDF22318
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095634; cv=none; b=AB+PzPtqJrs8CSNTL3zaM3Gu3nnjjQF2ykYwvgQmLb03gOYS3131ta8liMdfqL7FdNhbR0DujCpXYTvlA9qNr0M27Hxqxaq6jM+N7kZ+35KoGuNWr+gL5029dDpSdyo4pcqu0X8ShaJ1nVMUqov8Z1xTiuoqtUAvslHZWqnctqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095634; c=relaxed/simple;
	bh=bUwhKPDrknXfgtMbi1dapzd5nuEfYyuwJ1a+5yJAli8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtoE7s9z1kP+J5B2u+DpP5l/Ldj12cb7TG1SeWe5VwxPzgohlT1MteveQ4Dx9RnbEi53+omA0qzcSuF+4pUeKxBPZn932qLVE3S9xLi95H/YTyCgRK+Xo05z0kvA8Ue0gGo+BVW29/01+5EsUW4MOfl3e06FTZJGBx7bU6RQB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VQgphtJc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 22B3D40E015F;
	Wed, 20 Nov 2024 09:40:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VJ_SWoWPjbDy; Wed, 20 Nov 2024 09:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732095616; bh=DsmhX85LEZFi2G3546S7o0COpVhXR+lIYjL7r1/E5WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQgphtJcfoEtW37ODuNx4opoiMYBuGvZq8QWNCfZVBb3a/ifSiKjrwdW7sEhgaIrr
	 /W33jq8MN16Ea9SrGyIyT+YCUhxhiu2NgnKJK/c4fxGSbf2wuelfQYIWcEEpLavb+v
	 22BvvT8kR/7eARx1yNuBsO4aOBA/iAB3D7/HCWzQv91HTEXyIj4XmAmsTMeUn42K3v
	 5o0Tu2xVHTa0yAy7I5/fbG+sbl482YBRJrlZ7HXQXGA+JGge8Tuepsvkelj1A6bskl
	 7Zyf09qHRSq8ULWIp87An30QcKDoTomPkOA5xydgMw6YcdClfkBCQ0DAFN09EiUMRh
	 410S1Lto15fLuPpjB18XxCl2SLR53n8estcJOO0ZSxIxO7OmJ18FN7+xp//K80H680
	 ePmq45wqOOD+bACHqzEp/KL8snUmBX62YIRaXej9nD6ouOhl1ClJPi/RMBlg0VhI+I
	 cwJ1etJ/Ul6JW1l/pcmqKWuJnwoecpgHpxaVemGer/bO34sYHJcWouAlBjZ+OLtYeU
	 7gc0ec7Ro8pm78zdesaBPyI/c9z2jx0n7PgGHfy4RZs0sj2lMlCMUkaFTzq/dKvx5U
	 mVih04K7HtX/x7hmNZ0FLd3bSVb/VeTHVHKq73ukVQDRVf/unDcdXxgVMTcFW5xGbi
	 XEjwu0yDm/2ij1Oko8Vgtnvg=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1B51440E015E;
	Wed, 20 Nov 2024 09:40:11 +0000 (UTC)
Date: Wed, 20 Nov 2024 10:40:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] timers/core for v6.13-rc1
Message-ID: <20241120094001.GBZz2ucZDr1F08zton@fat_crate.local>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
 <173195758632.1896928.11371209657780930206.tglx@xen13>
 <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>

On Tue, Nov 19, 2024 at 04:33:45PM -0800, Linus Torvalds wrote:
> Bah. Except the vfs tree didn't take it as a shared branch, but
> instead cherry-picked the commits and as a result they are duplicate
> and caused a (trivial) merge conflict.

Yeah, we were looking at that last night with tglx and he sent me a resolution
(see below) and looking at your tree now, it all looks correct.

commit 6a972393d45dbe3df1e57e2360661990d22c8369
Merge: 183ec5f26b2f cdc905d16b07
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Tue Nov 19 20:58:25 2024 +0100

    Merge branch 'timers/core' into tmp
    
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --cc kernel/cpu.c
index c4aaf73dec9e,895f3287e3f3..6e34b52cb5ce
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@@ -1338,9 -1338,6 +1338,8 @@@ static int takedown_cpu(unsigned int cp
  
  	cpuhp_bp_sync_dead(cpu);
  
 +	lockdep_cleanup_dead_cpu(cpu, idle_thread_get(cpu));
- 	tick_cleanup_dead_cpu(cpu);
 +
  	/*
  	 * Callbacks must be re-integrated right away to the RCU state machine.
  	 * Otherwise an RCU callback could block a further teardown function
diff --cc kernel/time/timekeeping.c
index 18752983e834,d115adebc418..0ca85ff4fbb4
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@@ -445,11 -375,11 +377,11 @@@ static __always_inline u64 __ktime_get_
  	u64 now;
  
  	do {
 -		seq = raw_read_seqcount_latch(&tkf->seq);
 +		seq = read_seqcount_latch(&tkf->seq);
  		tkr = tkf->base + (seq & 0x01);
  		now = ktime_to_ns(tkr->base);
- 		now += __timekeeping_get_ns(tkr);
+ 		now += timekeeping_get_ns(tkr);
 -	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 +	} while (read_seqcount_latch_retry(&tkf->seq, seq));
  
  	return now;
  }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

