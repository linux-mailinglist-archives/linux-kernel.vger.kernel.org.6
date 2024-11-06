Return-Path: <linux-kernel+bounces-398027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49449BE46F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 497C3B20E97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585CD1DE2CC;
	Wed,  6 Nov 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BFtOy9KN"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50DE1D1753
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889588; cv=none; b=kiNZ+pXlhnRjqCn/LEAD5i4VgvUd+ZN/AT70aCcMbvex0KlZ5nRC/zT6ADi7IHQUu/9eZO37+sQZhq6HsD9Bg4XazA4t6DvJ4jIh46iffVSe2+sSzoqzFyW4jsKnHlXyWcMYsMhLspZyAerXsCyXFwexJq12BnVoyz1i71PP18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889588; c=relaxed/simple;
	bh=Aqmu6eaq53uS3/fJFghKIlGr2umwDBNIXyXuP/ZX0Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRpsymO+Cm8ADTSC4DEPLDHu4zH6XP0FrFhKAVlIde2cFhype20ReUw1HyXXMXxqa00ibRyevGqJ40pOEv4ZImcK1wOW3Y8WgIiVSrlOmooc8/nU+pZqbs6lxrwWcrxXb6MJWlffv9W+HAMyVVAPUBEUwf4i/RffM6AWuScPyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BFtOy9KN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2940140E0191;
	Wed,  6 Nov 2024 10:39:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SEsKVBXiKELr; Wed,  6 Nov 2024 10:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730889578; bh=WW+CbRkv224vvLIbJTOEOGPztZq8JE13r1mOO1uMrKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BFtOy9KN6XWfAVHTcwtkv5uDDHkpiP7ZGQmZ2QoJniXJ00w7V7D0Lz26gCzR1s1X5
	 Vy2thJJeTQOxSmgdQAvdYVCRwCIg210TX61bhnj7Qv67UBpFIkTvDW1VNwq8BEV5+v
	 GM/sfkxHZx6UDdXJkM98m7ojsdKEvh6TgOkTnLfsWGe5+2OguN0INvp2TXHmjYtLMD
	 2pZkt7q/JHpcJfTdeJebsBCIFnzv3i9dQabpqUVnbOGzGxuLsCgYRa3UgrUVBJy52B
	 CVelb9rCTVvlpbLw5ckH71cXWkZ9XLo9jBDbDU5niUyeIbuDtATpfdt/BPpOHva5LG
	 SYDK4IdEdiaHvZjADJf4mjLgxvxud18Q7X2dqWJLT0jS/fb5feXtxJG2T79aZ1npR8
	 5MciXYVj4E7Dfnc/CFoagMWlbFAkrYvSn+dSAvLtWQ7iwxHFhJiyr+RN0w2WNWsPkk
	 80sh5NGOJG4mgJi3FqJbNu2DGJCc6GRd1LeYLNTGdTz1TQuIRoS02zXHnqQbHY2f0Z
	 JaD/t+cYob8Jq8q8pPAb/O6zeY4Fvt3VylHbzCaCk+ndElicKn5YTDOmtBktzY9D4d
	 ZmyBF5/8Xcv1iDEAmcNxKRKom4FzTD9wp/EeY6jk6gGg7GVE7WQYwPNKPd2EVy381N
	 333/IdHppnhFxqE7popX+wgQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D2A5140E0261;
	Wed,  6 Nov 2024 10:39:27 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:39:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Message-ID: <20241106103922.GBZytHWloHcFZ8CNL_@fat_crate.local>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-20-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-20-david.kaplan@amd.com>

On Tue, Nov 05, 2024 at 03:54:39PM -0600, David Kaplan wrote:
> Document the 5 new attack vector command line options, how they
> interact with existing vulnerability controls, and recommendations on
> when they can be disabled.
> 
> Note that while mitigating against untrusted userspace requires both
> mitigate_user_kernel and mitigate_user_user, these are kept separate.
> The kernel can control what code executes inside of it and that may
> affect the risk associated with vulnerabilities especially if new kernel
> mitigations are implemented.  The same isn't typically true of userspace.
> 
> In other words, the risk associated with user_user or guest_guest
> attacks is unlikely to change over time.  While the risk associated with
> user_kernel or guest_host attacks may change.  Therefore, these controls
> are separated.

Right, and this is one of the thing David and I have been bikeshedding on
recently so perhaps it'll be cool to hear some more opinions.

My issue with this is, because I always try to make the user interface as
simple as possible, I'm wondering if we should merge

	user_kernel and user_user

and

	guest_host and guest_guest

each into a single option.

Because user_user and guest_guest each pull in user_kernel and guest_host
respectively, due to how the protections work.

As David says, what user_kernel and guest_host enable for mitigating the
respective vector, will change when we add more involved kernel protection
schemes so their overhead should potentially go down.

While the user_user and guest_guest things should not change that much.

So, provided we always DTRT, what gets enabled behind those vectors will
change but still be sufficient depending on the kernel and its protections.

One of the arguments against those getting merged is, those are not going to
be *vector* controls anymore but something else:

mitigate_user - that will mitigate everything that has to do with executing
user processes

mitigate_guest - same but when running guests

The third one will be the SMT off: mitigate_cross_thread.

Oh and whatever we do now, we can always change it later but that means an
additional change.

Anyway, this should be the gist of our bikeshedding.

Thoughts? Ideas?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

