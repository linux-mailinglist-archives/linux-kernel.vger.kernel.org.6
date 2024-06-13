Return-Path: <linux-kernel+bounces-213482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CBF9075E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D571F22DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B516148FFC;
	Thu, 13 Jun 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bsShFnhB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417284A41
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290915; cv=none; b=Zwn5h8bdKmzCthlwavRRwoA3UZCdhQWQF+LQpjcHz1tc7N7YcEKEXA9Hm3gKPVMY3I+Z6HbKHGQJvfCfWI3iL7d9cujyTFynZQWDR+Pmze6onjaZLdX0AdJzy44Fpgmfd4iGJEGLeu7FSCuDBR6F8aXvhHlosO0foHyIzIS4Fxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290915; c=relaxed/simple;
	bh=1qdq6ymdc7aN76IfWBV8BHfAq+mDwXd9aeA2AJ93FrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+dMIqronRglTdCwrqBWXBErrS6S6fBWYYgTSk04jXxU0gDhovWm0ou2Rvj7woiob3zyYRLom0Ps57DFkY2jDU24hbjTMulEdOw7mA+IKnJGwcVru0k7VAt/A6BxV4JzG4HwyGnklV0S7f5XuOzLNEawvEP9y6VnJEp6c0Cq1hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bsShFnhB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AACD140E0176;
	Thu, 13 Jun 2024 15:01:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id C8k6cMmfgF7I; Thu, 13 Jun 2024 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718290908; bh=Bcgfm7HUBn/u9YkmvBONRjv664NEcbHnzWfTQvvxd6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsShFnhBUpaKo7PASfnrCkWUrNQQCmAS9+kg3a8PNEI3luTAxBN1TLeg74k0blu5I
	 EUEgBg5wowYH1aXuzNE8uZuln+2TU/JZlUTvMu3H5Zjeed+qUn1eJjof6a0f3Bce4b
	 Vt/UrHOfaQXL4WhQP/GHDY2XjrlYfECBzKxdiw/XxdswxjhbyGOhxRwUgJ416DKFMF
	 5lGzB62We5OEPZ2w7Tkv9C7jsk0qt2Z85z2xFENWxgIrI9QF3rVEHm4D3fBLuIXDMm
	 oIMOuQYR2NmOmNDEF6Csuxlnwo7oMlMq/AXH41XjXlJWosOgOWXH/6IHZjewxiWhr/
	 d4pERtGera4O9IZY/GJ7gosDyHR0Elh65m3ggtlwrVRIrZ5UcXUPLbbEdXfJMTeKZS
	 kOLrmfakw4tiODhnLUrUpbjsvHCgvhBZepkw87W7K2+iLDFzAAnn2064ZTyfWbEVwu
	 Vk9O/qQ5HPIFt/yK6vleMdNdXIbbailF19eM8NwhLHf6fY8rcBSlYdnBv1hVw8nvMq
	 +rzADCbJYdwvfX1IsDdntcOl39Fkfp2ARB5a3/cnRyvuNlCZFc4coAbyQNJkzhuDSE
	 KcoBbZGmJOW3wYHek25XmqzGsl6l0LJ7yns5/TFGZV6/FYsfHAOCD0YByLrbPpAxRr
	 KcjHxRmujdCXqJSO4U6mv+sk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DF3E40E0081;
	Thu, 13 Jun 2024 15:01:43 +0000 (UTC)
Date: Thu, 13 Jun 2024 17:01:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Narasimhan V <Narasimhan.V@amd.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 7 PID: 0 at kernel/time/timer_migration.c:1332
 tmigr_inactive_up+0xd2/0x190
Message-ID: <20240613150142.GHZmsJ1haFMVkHHjEE@fat_crate.local>
References: <20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local>
 <87h6dwzz1a.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6dwzz1a.fsf@somnus>

Hi Anna-Maria,

On Thu, Jun 13, 2024 at 04:40:33PM +0200, Anna-Maria Behnsen wrote:
> thanks for the report. Is it reproducible?

Narasimhan just tells me that he was NOT able to reproduce it in today's run.
I guess we can wait and see.

> If yes, might it be possible to enable the timer_migration tracepoints and
> provide the trace?

Can you pls give Narasimhan exact instructions what to do the next time it
happens?

@Narasimhan: when you see it next time, you should try to run Anna-Maria's trace
with the same exact kernel and send results.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

