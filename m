Return-Path: <linux-kernel+bounces-320319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA19708CA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31D2EB20CFF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A1175D2A;
	Sun,  8 Sep 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kNfpkj+k"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E82E634
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725813734; cv=none; b=egg+ck2k2uta0SapKs7MJ5vhIcoZnrmVNgjrRbAeFtLSaz655pnRZr0mQafoXeayxjRrN5F6A9Dc4ESkBwpDneFaZLMmMNO2fj2T6Hwe6PfZW9CWaq6drC1PTEHlu6jT+vHb53FyDQjc8EOwr074zn+Mf4bGz8+QWUSF9xhOGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725813734; c=relaxed/simple;
	bh=RsbodsksiGx1Kg9EEOienx21bR6P1oAVO83w0R0cI58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmHOIy9TLAj6OCZ/I+XdoN4omdxcAPW+EC885wyY066agRxI8g5e6RCQCJuhi2CpK5sn8xl/p/9wkCOWZFMxTT6b9OBp4d+BkXIMuHZAj90F2eF2e9cg86vy0ME184cNf8JHdu9xkQZlxYBtLqJlQGNdm4HvqL4WrjY+susDa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kNfpkj+k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B6C0240E0263;
	Sun,  8 Sep 2024 16:42:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xHKcBQ8YCBLg; Sun,  8 Sep 2024 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1725813724; bh=cXe3UHu1uHfg3U6kXzedWfdOp8uHWZnn+dyweQMb0+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNfpkj+k+Bk7KEf8ced8/i0Je/h3e+dWGJ+DYayQZInEaOwxArGLL24iZb/C6I9Yb
	 WSmYNJR4LOC4x0gYz9LwPxiiqoTGxpZ+NruZ8dGTpEohDoqN2mYmtDFhi0Dc7cvCP7
	 MlW2McHpWSkK2f39oBY9XofzlR5L4IZT3jsAL97SjDrwPas458JfV7FFId3sumWVQR
	 p11yxU+OpjSafcDRZ1PY3h0LxnTgpmK5TbSF/3ACzzAeA3qWQW2Zon7X3uGbOjZJ/H
	 JauCawqH39ln9d6nmy8oPYw3MAtQCWhyXbLcowS0PjJs9r4tE1sFeWMvUbwa1fqUuj
	 CyR896ep/JMitiOq/Up+xtrqJd3uKPtbu4SZ9kdr9Hpatspksys3dCYf+iI0LxeHTm
	 qCKkDNNK9zSKwS+w3yFT9v/wLyg5jGmIsMiMWdxmi/cC9RO34ouVpsMr/5qvXn3wJW
	 1XZ18OybYkgRUyhcVwKKsvWBS6A3tNDxaThpIQs/sUDDD7gEl+JNeUTW7wgQZum3dV
	 M2W5FyY97ausjr6J8wSmQjNlGlTCTOsY1n2XpJUHTJXP3HGOHnDWui6zRR/2WTbJPb
	 xL/4AJknEILZSoXPGf1QzX/l8XU9NY+XBqVKtn1VUJgMS3Ix4Oy7r0CWSL+XlKAdiO
	 wkMWzyTzUhS86MJyTBtpYyEc=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EABCC40E0198;
	Sun,  8 Sep 2024 16:42:00 +0000 (UTC)
Date: Sun, 8 Sep 2024 18:41:53 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] locking/urgent for v6.11-rc7
Message-ID: <20240908164153.GAZt3T0eBCgcecXkmN@fat_crate.local>
References: <20240908090302.GAZt1oRk_8H_68AxCe@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240908090302.GAZt1oRk_8H_68AxCe@fat_crate.local>

Hi,

please ignore this one. There's still trouble with it:

https://lore.kernel.org/r/202409082005.393050e2-oliver.sang@intel.com

Thx.

On Sun, Sep 08, 2024 at 11:03:02AM +0200, Borislav Petkov wrote:
> Hi Linus,
> 
> please pull the locking/urgent lineup for v6.11-rc7.
> 
> Thx.
> 
> ---
> 
> The following changes since commit d33d26036a0274b472299d7dcdaa5fb34329f91b:
> 
>   rtmutex: Drop rt_mutex::wait_lock before scheduling (2024-08-15 15:38:53 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/locking_urgent_for_v6.11_rc7
> 
> for you to fetch changes up to de752774f38bb766941ed1bf910ba5a9f6cc6bf7:
> 
>   jump_label: Fix static_key_slow_dec() yet again (2024-09-06 16:29:22 +0200)
> 
> ----------------------------------------------------------------
> - Correct unwinding the static_call machinery when encountering an error while
>   loading a module due to a mis-assumption in the static_call_del_module()
>   path
> 
> - Replace a WARN_ON in the memory allocation failure path of the static_call
>   module machinery which unnecessarily leads to a panic when panic_on_warn is
>   set
> 
> - Fix an ordering problem in jump_label's static key reference counting code
> 
> ----------------------------------------------------------------
> Peter Zijlstra (1):
>       jump_label: Fix static_key_slow_dec() yet again
> 
> Thomas Gleixner (2):
>       static_call: Handle module init failure correctly in static_call_del_module()
>       static_call: Replace pointless WARN_ON() in static_call_module_notify()
> 
>  kernel/jump_label.c         | 83 +++++++++++++++++++++++++++++----------------
>  kernel/static_call_inline.c | 13 ++++++-
>  2 files changed, 66 insertions(+), 30 deletions(-)
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

