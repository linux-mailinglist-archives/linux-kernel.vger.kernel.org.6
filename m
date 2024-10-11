Return-Path: <linux-kernel+bounces-361479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FAF99A8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B47B22F83
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1981991B9;
	Fri, 11 Oct 2024 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ASAUfGwy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244518C008;
	Fri, 11 Oct 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663711; cv=none; b=sx8qVaeL9AOpbo+SAxlcgHqrocvFohvyroRt/bklndEMMRwEWf41zgMS7mNNlXFp+KdABVHmWoLGwyGkvero9wV2tQWp+7rxqK+psBxfDnKB4CMOppHY+qwT9cu8FeCHszJoxOtiOO161VkqjceSSTweXBx2zei19McCs0LMN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663711; c=relaxed/simple;
	bh=ECupTpD4ARhVG6JGOoFsGZdnvX3iKONH0IXFKqFvXV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeIrvl79y7FTIaYYgq0h+KqC5/3NORSmUzamER1O6nO7jVT1kRYFgeIwK3kUr23h9TOJkzu74a2hR8RPGUyR3Os+0eL852cOEgunUFoe/R/dD1vSt0n4AB44Tz5ii598kg4tMFY2RvPrrw+WZWttgafR8igtZE2zDFAf23OSATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ASAUfGwy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5063B40E0163;
	Fri, 11 Oct 2024 16:21:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gIJqbr9fPyHI; Fri, 11 Oct 2024 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1728663700; bh=YTOw6MvyQfsbbhTtfOUGLF8pwamm/nmExAZ1ApDUoHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASAUfGwyjX5NZeGh/eb3gR8eWY6Xde4fvJf+YcsJ7Ydh/Dp3sZIM5L+WvhGsLrjfO
	 ZW1OCY1chBKLqynzIPeb0pLUNvO2jUAvhHmMiktETe2r4GkBFUxbcN2xugJ7D/kXCf
	 KPCjcWvNVmCITQSit3votd9ylHyajMlpDC67C21P5cdkoOwoUrIrFBUheXx5vKYL6p
	 Ak/fm5jBoLP/hGNK7djA0to0b5iRXCjbW/AZyFy6Tqows0+aAgN9DV3Lbc4gJrc5d3
	 vWxz+jWUw1nQGbvZTyQF5WOeEpIsB+1L9B7vVku6j2T3U2y75BK+EA7IdV4KhRru4Z
	 6P3SZ2vWhfzfQ+AitFERda9rLBfMlB4lNS3pNzehkW2fIr5NktFWXwyj5kahUuvOjf
	 oEQGcza54xuzeyjHJaKla+g78UXjx0kqIrHSUQw//z/9s6ATrwEBHvEqXuLpU5SOAJ
	 2fbvK/+WpuGU6dYIiSkPAWDnX3uMFu2rF5S4IGlJWeTZWM55C+mSl/W1c+UEVFHomK
	 WzczfYiJLRUcvaY+9knswG5Y4sk7v4nCSdnkAS0YO9ngCrN02v343qHV/AViO8/KO+
	 nJTpS4irlTL41CbjYVvxNkkI/fFxHIDVNuxBzELTl5Fukv1V5FSolWdpFGHeLUpNf/
	 J9jiUl0GT133LVclsD0e9dFk=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E58C40E0191;
	Fri, 11 Oct 2024 16:21:26 +0000 (UTC)
Date: Fri, 11 Oct 2024 18:21:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pavan Kumar Paluri <papaluri@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-coco@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Van Tassell <Eric.VanTassell@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dhaval Giani <dhaval.giani@amd.com>
Subject: Re: [PATCH v6 1/2] x86, KVM:SVM: Move sev specific parsing into
 arch/x86/virt/svm
Message-ID: <20241011162120.GDZwlQgKTFi22JZ5If@fat_crate.local>
References: <20241010121455.15795-1-papaluri@amd.com>
 <20241010121455.15795-2-papaluri@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010121455.15795-2-papaluri@amd.com>

On Thu, Oct 10, 2024 at 07:14:54AM -0500, Pavan Kumar Paluri wrote:
> Move SEV specific kernel command line option parsing support from
> arch/x86/coco/sev/core.c to arch/x86/virt/svm/cmdline.c so that both
> host and guest related SEV command line options can be supported.
> 
> No functional changes intended.
> 
> Signed-off-by: Pavan Kumar Paluri <papaluri@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/coco/sev/core.c          | 44 -------------------------------
>  arch/x86/include/asm/sev-common.h | 27 +++++++++++++++++++
>  arch/x86/virt/svm/Makefile        |  1 +
>  arch/x86/virt/svm/cmdline.c       | 32 ++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 44 deletions(-)
>  create mode 100644 arch/x86/virt/svm/cmdline.c

make[5]: *** No rule to make target 'arch/x86/virt/svm/cmdline.o', needed by 'arch/x86/virt/svm/built-in.a'.  Stop.
make[5]: *** Waiting for unfinished jobs....
make[4]: *** [scripts/Makefile.build:478: arch/x86/virt/svm] Error 2
make[3]: *** [scripts/Makefile.build:478: arch/x86/virt] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:478: arch/x86] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/linux/Makefile:1936: .] Error 2
make: *** [Makefile:224: __sub-make] Error 2

$ ls arch/x86/virt/svm/cmdline.c
ls: cannot access 'arch/x86/virt/svm/cmdline.c': No such file or directory

Looks like you forgot to git add cmdline.c before committing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

