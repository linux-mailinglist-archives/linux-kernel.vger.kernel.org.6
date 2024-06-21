Return-Path: <linux-kernel+bounces-224755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7E912683
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E13B24E98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9778B1527AC;
	Fri, 21 Jun 2024 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hZRAwxHn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3F51EB45
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975901; cv=none; b=tqFY+Z5B/MF2GdXeYG17toOZUUJ7YJbFEop8AIwFNeyhFop8X3LuP9IVYsoFygRCZ7PeASjYrJ6gURYnsN+FAB4XQxV5BIpZbYU2Aq136a537ube2Z0Jj7VStaEEp7V7BzTyCVQTA4JBGNZJ12A2VjLMn+H2stneq2rMVwJryG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975901; c=relaxed/simple;
	bh=sqHBALxOEcXUdMLpEKaMQRWH/dDRXChPwcd1d8Bcp6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSB8H9+Ot8OMHPuRkV0dYGO1VdEO4zKaTu5/oYmX7zJMsuqPKBGM0f3Hn2fcuWTAzXqYUwBX2RhNfnBAZ1ffSL1G7s+s9uKr34RAvlT60LvmAvcOoGVL+NdugVgHkgPSHdXJRuv2Znx5Ico8TTG9G1GoZhxJmqKzmxz2UOA3LUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hZRAwxHn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04D9D40E01D6;
	Fri, 21 Jun 2024 13:18:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3Np-3OE6K1rj; Fri, 21 Jun 2024 13:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718975892; bh=JizJndAhaNZaXqVbhXkm0kB9rqgin/WAmKHV7VIfvWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZRAwxHnLicP+AE20iVNYCVwOk7yVR0apQJNRIsX69+EVTcZW+or48HTvNB3v2Kgc
	 7PQBg7eod7g31JcUVfDGuKImJ2ouIaR4gqVrxYiuCZmXvFDBuMntPTtEAmUJ5bo5nn
	 TS6j+XwPuJsakF3knI+Wan6yhW/15meZgW5VgCJcAK/MJgUEU1DPuVhcuCUhUEPR+7
	 XfdrFId+R0WJp/P7m9Rija0Cjf/vVtK2Ur/0MLCvwEg+AeW5fBe6OUoMkqOspJrr0u
	 Cg1mJYrZvRbc7qxg8WBtDHSp4XgmvGrv5AA00D648JoboCARxN5g8eV3pQexFbpVAQ
	 5J3ZzNIUTHi9rd47zZjAp2yLfP/boMtkqJ+3p6ewRAUuiONbv7GfnsFde4IF3JpQ5o
	 5oKarRxdix9ewE4os7Y3WpeiHJaRGlbdiaDHWBQQjGoL9Omk0nB2swgLH4+waE6sRp
	 lHfnRgNHntXdyajmGHFZLzm0fh5WtTNP3br8AWRbfY17S9YvvNM1ZG8CQfUVejfEqn
	 W5JvOx+ib9bHwC+8nhRsw+l9fAv0VP7ifiDQOi2OO+aAOAccPUEviAN+4uT5WdDmbo
	 Yri2zyPPYLihzdEolxx9Ycilcf1Evl/3K+dhVwQfDH0ha8saX1LZFWbJtVyCDhsuQv
	 Jfgexbj7YVxAXVJTWNESiOqo=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5951140E0185;
	Fri, 21 Jun 2024 13:17:47 +0000 (UTC)
Date: Fri, 21 Jun 2024 15:17:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Pavin Joseph <me@pavinjoseph.com>,
	Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <jroedel@suse.de>,
	Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>

On Mon, Jun 17, 2024 at 10:10:32AM -0500, Steve Wahl wrote:
> The first, hardest step is locate a system that is AMD based, SEV
> capable, with a BIOS that chooses to locate the CC_BLOB at addresses
> that do not share a 2M page with other chunks of memory the kernel
> currently adds to the kexec identity map. I.e. This is a stroke of
> luck,

Ya think?

It is more likely that I win the lottery than finding such a beast. ;-\

> and for all I know could depend on configuration such as memory
> size in addition to motherboard and BIOS version.  However, it does
> not seem to change from boot to boot; as system that has the problem
> seems to be consistent about it.
> 
> Second, boot linux including the "nogbpages" command line option.
> 
> Third, kexec -l <kernel image> --append=<command line options>
> --initrd=<initrd>.
> 
> Fourth, kexec -e.
> 
> Systems that have this problem successfully kexec without the
> "nogbpages" parameter, but fail and do a full reboot with the
> "nogbpages" parameter.  
> 
> I wish I could be more exact,

Yes, this doesn't really explain what the culprit is.

So, your 0th message says:

"But the community chose instead to avoid referencing this memory on
non-AMD systems where the problem was reported.

    commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
                          on non-AMD hardware")"

But that patch fixes !AMD systems.

Now you're basically saying that there are some AMD machines out there where
the EFI config table doesn't get mapped because it is somewhere else, outside
of the range of a 2M page or 1G page.

Or even if it is, "nogbpages" supplied on the cmdline would cause the
"overlapping 2M and 1G mapping to not happen, leaving the EFI config table
unmapped.

Am I on the right track here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

