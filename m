Return-Path: <linux-kernel+bounces-547157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A826A50390
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBAF3A67DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A6D24EF6B;
	Wed,  5 Mar 2025 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kt5KBG8k"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4424BC1D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189057; cv=none; b=Goz5QbiTiLBKdpSkaVNxtCOPj38FG7vwi0ucX6Bzw9dp5/od0rGEyy9inePwEFa5dy+DOsVw19dyDBHJnKTA39j6DeHUggPn4kxaEqicYb4i/Z1B/a7HkyP44GGAJpkx6DySOqOnGR2Tv6mj4u6lZNgFk8bazSzvVh++3ZpqKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189057; c=relaxed/simple;
	bh=T05Tf/QER+2B3uyiRrb3oGJiSXIIiXYe151KYuhR6LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8fGMjFuTL/3HM2PFWJYx4kG8+G+b+cmVik9+1zc2oKxAbs5lGgGBvRuraU052yQbVQbaYJqI9/GYuR7SBHLFq0j2fS0lWa+FTOLs+0KcHdEKwfRzCNEUhp7nG4nnXX17cAWvSZu4q8FhPUNXUFHPqt62kCF3bM1bWa2jG9FaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kt5KBG8k; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9E68040E020E;
	Wed,  5 Mar 2025 15:37:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2Zl2o_fkxKQ1; Wed,  5 Mar 2025 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741189041; bh=L2dUdIEw0DbDt1xr546DxoHPLcS95w6uM9w0F4osfpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kt5KBG8kYAUFOqGmjFxy+oLiMwF0iv3L05RqRcKRBRD1oSFKQ84UadhNS9GbP/2H0
	 Wl8BaeFZlr2WcLaLdmDklqRkmMFpb7mqs31bBneBjryRD/t4r8aomy+P/KoFr669BY
	 7s2+CW1GrLPCfsJtT3XHDBcYwtf4+Is3zKNP47qatNbQ2k70Kq9kwJ3TSJN/clSeqH
	 rPGdMLoWXvrPE8wSI9kraV3sahkHFOdkmcyOnbj0bYTVr+z0btrT45DCn0ynrT2j9z
	 nrURnNdNjVs7Ai0n6M3c9OS018WsS7gzBOYYlrL1OHAc84o2C4p0O1+cU0v/ugpbVu
	 F5cJ32wmsRXPJf8BMbUPpIUc65tkUG9XbxwYYgzjsCMosRcaaTx5wFBFxtEjk5NB0G
	 7Gn6U2zodRwIW9Pmx9MDMRm7rGrhujUioE47/722t2q2w+etG6hGlC0Jf0eqd0qjbK
	 hFH8LpAwbeVNF85A3uOJ8xRGZYGuB1RleME0gSeOQB1c/I8o8H+XZrLb/gfH8NJuH2
	 cHuxnCU38QyBFaf1bW+xVaU1XbvA3HebvsBZoKORZRZ0RsWZf+jp1fzpErx125Sm3x
	 GewiVfRd0rEL9x9NIoTxQts/kRvUlIWbfxdjpuidJqEaY9n2hwcqkwdVdoZQ9DDfiN
	 H68mYsHrfmy0OU6IokakvhyE=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FC1840E01AD;
	Wed,  5 Mar 2025 15:37:10 +0000 (UTC)
Date: Wed, 5 Mar 2025 16:37:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joerg Roedel <jroedel@suse.de>, Dave Hansen <dave.hansen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	x86@kernel.org, hpa@zytor.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	Larry.Dewey@amd.com
Subject: Re: [PATCH] x86/sev: Make SEV_STATUS available via SYSFS
Message-ID: <20250305153705.GKZ8hvoaz2GPt2rGtu@fat_crate.local>
References: <20250305105234.235553-1-joro@8bytes.org>
 <20250305111251.GBZ8gxs_6O7g3gLVEh@fat_crate.local>
 <Z8g01YhM_FtdB5n6@gmail.com>
 <20250305113155.GCZ8g2K1XEdgynTA9D@fat_crate.local>
 <Z8g4sU_dsZgY0PuS@gmail.com>
 <20250305115035.GEZ8g6i7NTiSfkxk7J@fat_crate.local>
 <Z8hYEsHvwUwlOold@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8hYEsHvwUwlOold@suse.de>

On Wed, Mar 05, 2025 at 02:56:34PM +0100, Joerg Roedel wrote:
> On Wed, Mar 05, 2025 at 12:50:35PM +0100, Borislav Petkov wrote:
> > On Wed, Mar 05, 2025 at 12:42:41PM +0100, Ingo Molnar wrote:
> > > So if the convenience of tooling is the argument, the raw feature mask 
> > > exposed is the best option overall.
> > 
> > The convenience of tooling *and* user. I want both. I want to be able to boot
> > a guest and see what features are enabled without needing a tool.
> > 
> > And, at the same time, tools should be able to use the same interface.
> > 
> > Exactly like we *and glibc* use /proc/cpuinfo today. Now think the same thing
> > but for confidential guests.
> 
> So this question boils down to whether the parsing of the bits happens
> in kernel- or user-space. Actually there is already parsing in
> kernel-space to print the status bits into the kernel log:
> 
> 	SEV: Status: SEV SEV-ES SEV-SNP
> 
> ... which is great for a quick glance without needing any tools. The
> user-space tools which already exist have their own parsing of the bits
> and for them it is much easier to consume the raw value of the
> SEV_STATUS MSR. See my changes to snpguest:
> 
> 	https://github.com/virtee/snpguest/pull/88/files

Well, I guess we can do both:

cat /sys/...

SEV_STATUS(0xdeadbeef): SEV SEV-ES SEV-SNP

So that people don't have to pick apart the MSR hex value.

> Btw, what is the equivalent on the Intel TDX side for these feature
> bits?

There is none, AFAICT. That's why the whole discussion.

Lemme add TDX folks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

