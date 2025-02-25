Return-Path: <linux-kernel+bounces-532545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E331DA44F17
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200D27A81DF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0BA20E711;
	Tue, 25 Feb 2025 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOJjeeM8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00741925B8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519729; cv=none; b=LGnahDK2OBl/ousiM16NZ0YBoSEH43vXrj5ou0amp2AgAgGINqhf+TwzuA7rVWXmhGcaI7WGdy8KAytLPi8QuhejuSZDNBbydOC2Le+w4SZf7+a04ODpGIxwqW79T5PleBCo5kRlm1bFgEX0HTB8UFsm2V0VlaMOZMktocMeNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519729; c=relaxed/simple;
	bh=+m8HxXrazlI5rmU9XsM5YUxoBH4XrRg35pxI1d/+5cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCiLps7Bdq7OS0rhNyXTBBjRceDaTHTle6XO+h0EqLwT+/Vq7QTTrRjN2oLD5zfGcHC0aNxZ++UG+UoHLgWsYX01sTRW7fiRYxV9+qA/oA0Sb68Gy52Own73KraJo95Zl+BCyqZ5A4SCvSI2mMv326VjNiSzMUh9F69pWtkvH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOJjeeM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBFEC4CEDD;
	Tue, 25 Feb 2025 21:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740519729;
	bh=+m8HxXrazlI5rmU9XsM5YUxoBH4XrRg35pxI1d/+5cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lOJjeeM8bJQClIPp8RrESQBwOSYFDx1500jeKeIk+GPFcL47QZ7JeXGKGWo7Lyp81
	 8EnGoKmxJ2VMpPblzx62+Gm/cBxRkHIXneAPEdPiHAJ+UsBw9xbP5to4y7oO3Q9b2E
	 SeZ1hatHcAcRls1jBwD7+wjyGQQiPR78360UU9RP5lXBbEAJAPJ2qlKp59tnYqHpht
	 0teKYCRzKYEzEVGWT4TujBP0rICDzcHLBPDojV7r0pg5mnkOMgDybGpz1IORD0ZW0e
	 fRd9eSAah6J3GFhsix+PrI4jN4BOXlIbQFaJp8+ALnJGDlOUWSkuwFBYb9XVkkzJvp
	 IM6Keyj7W66EA==
Date: Tue, 25 Feb 2025 22:41:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Russell Senior <russell@personaltelco.net>
Cc: Matthew Whitehead <tedheadster@gmail.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, luto@kernel.org,
	Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH] x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC
 systems
Message-ID: <Z745J8VCJ7YNbUiX@gmail.com>
References: <CAHP3WfMgm_rYWBL9DAeWUn0ERsdFjb+ySSFxsRLNkj2us6UNQg@mail.gmail.com>
 <CAHP3WfOgs3Ms4Z+L9i0-iBOE21sdMk5erAiJurPjnrL9LSsgRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP3WfOgs3Ms4Z+L9i0-iBOE21sdMk5erAiJurPjnrL9LSsgRA@mail.gmail.com>


* Russell Senior <russell@personaltelco.net> wrote:

> More poking/prodding and coaching from Jonas Gorski (cc'd), it looks
> like this test patch fixes the problem on my board: Tested against
> v6.6.67 and v4.14.113:
> 
> --- a/arch/x86/kernel/cpu/cyrix.c
> +++ b/arch/x86/kernel/cpu/cyrix.c
> @@ -153,8 +153,8 @@ static void geode_configure(void)
>         u8 ccr3;
>         local_irq_save(flags);
> 
> -       /* Suspend on halt power saving and enable #SUSP pin */
> -       setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
> +       /* Suspend on halt power saving */
> +       setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x08);
> 
>         ccr3 = getCx86(CX86_CCR3);
>         setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);       /* enable MAPEN */

That's really useful - thank you!

I've constructed a fix patch from your mails, attached below. I added 
your Signed-off-by to the fix, let me know if that's OK with you.

I have applied your fix to the x86 tree, if everything goes fine it 
ought to go upstream during the next merge window in ~4 weeks, with 
v6.15.

Thanks,

	Ingo

==========================>
From f5b2656ee7616f595b4e1735893d1371f216619f Mon Sep 17 00:00:00 2001
From: Russell Senior <russell@personaltelco.net>
Date: Tue, 25 Feb 2025 22:31:20 +0100
Subject: [PATCH] x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems

I still have some Soekris net4826 in a Community Wireless Network I
volunteer with. These devices use an AMD SC1100 SoC. I am running
OpenWrt on them, which uses a patched kernel, that naturally has
evolved over time.  I haven't updated the ones in the field in a
number of years (circa 2017), but have one in a test bed, where I have
intermittently tried out test builds.

A few years ago, I noticed some trouble, particularly when "warm
booting", that is, doing a reboot without removing power, and noticed
the device was hanging after the kernel message:

  [    0.081615] Working around Cyrix MediaGX virtual DMA bugs.

If I removed power and then restarted, it would boot fine, continuing
through the message above, thusly:

  [    0.081615] Working around Cyrix MediaGX virtual DMA bugs.
  [    0.090076] Enable Memory-Write-back mode on Cyrix/NSC processor.
  [    0.100000] Enable Memory access reorder on Cyrix/NSC processor.
  [    0.100070] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
  [    0.110058] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
  [    0.120037] CPU: NSC Geode(TM) Integrated Processor by National Semi (family: 0x5, model: 0x9, stepping: 0x1)
  [...]

In order to continue using modern tools, like ssh, to interact with
the software on these old devices, I need modern builds of the OpenWrt
firmware on the devices. I confirmed that the warm boot hang was still
an issue in modern OpenWrt builds (currently using a patched linux
v6.6.65).

Last night, I decided it was time to get to the bottom of the warm
boot hang, and began bisecting. From preserved builds, I narrowed down
the bisection window from late February to late May 2019. During this
period, the OpenWrt builds were using 4.14.x. I was able to build
using period-correct Ubuntu 18.04.6. After a number of bisection
iterations, I identified a kernel bump from 4.14.112 to 4.14.113 as
the commit that introduced the warm boot hang.

  https://github.com/openwrt/openwrt/commit/07aaa7e3d62ad32767d7067107db64b6ade81537

Looking at the upstream changes in the stable kernel between 4.14.112
and 4.14.113 (tig v4.14.112..v4.14.113), I spotted a likely suspect:

  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=20afb90f730982882e65b01fb8bdfe83914339c5

So, I tried reverting just that kernel change on top of the breaking
OpenWrt commit, and my warm boot hang went away.

Presumably, the warm boot hang is due to some register not getting
cleared in the same way that a loss of power does. That is
approximately as much as I understand about the problem.

More poking/prodding and coaching from Jonas Gorski, it looks
like this test patch fixes the problem on my board: Tested against
v6.6.67 and v4.14.113.

Fixes: 18fb053f9b82 ("x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors")
Debugged-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Russell Senior <russell@personaltelco.net>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/CAHP3WfOgs3Ms4Z+L9i0-iBOE21sdMk5erAiJurPjnrL9LSsgRA@mail.gmail.com
Cc: Matthew Whitehead <tedheadster@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/cyrix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cyrix.c b/arch/x86/kernel/cpu/cyrix.c
index 9651275aecd1..dfec2c61e354 100644
--- a/arch/x86/kernel/cpu/cyrix.c
+++ b/arch/x86/kernel/cpu/cyrix.c
@@ -153,8 +153,8 @@ static void geode_configure(void)
 	u8 ccr3;
 	local_irq_save(flags);
 
-	/* Suspend on halt power saving and enable #SUSP pin */
-	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
+	/* Suspend on halt power saving */
+	setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x08);
 
 	ccr3 = getCx86(CX86_CCR3);
 	setCx86(CX86_CCR3, (ccr3 & 0x0f) | 0x10);	/* enable MAPEN */

