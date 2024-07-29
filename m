Return-Path: <linux-kernel+bounces-265653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E4D93F40D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 13:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3100EB225FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 11:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3469145B19;
	Mon, 29 Jul 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VPFnkrdy"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996F145FE0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252602; cv=none; b=pjpZgAqTNdguoHonCqSyq1XXiySpyaA8SnNT1dvPlDk3+TdbJd/Sy7FBMLrYmXsUEby1balbYewY8S7ZniSG5clVO7Wyxhv71h7K328Tmgu2LseNFr+oWW5dk4k6PtuyeGq6UhwnvQzRISZR4BZw4yQtYmwPL1Qxw8ObVrU6Cyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252602; c=relaxed/simple;
	bh=TipJLAp0H5sPs0dIPuvouVg0CMwOZ5mJT4nmIW/gW74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKSGpkHKyPYoyNy4RLVykXmR+FLDNGI1jMrZFDKMLokwywM+BJfVSOygkrTHbSMoLXX6Vd2saldD0Kb/YJGW+Av2fgUxp0ceLBqWPx5wNRNxfzoth4gyXO0KOxov5IWkZGJAGl6Z0AnF725TCv/Ne7leGB9/hMOvcGxWj7HYQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VPFnkrdy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2082840E01BB;
	Mon, 29 Jul 2024 11:29:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GHOm4pgWY5FW; Mon, 29 Jul 2024 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722252595; bh=KG8CQ1KpLh65pKJVY3yFSoZNet0pxmhw1NBNwH+ki5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPFnkrdy9eI+mk47prim7u5B0t0009V/erEUG3ooBQFZvphCNy6oo1hhJjCcX6Qpc
	 +cUFDvI34Pr7lVGVRjbXi0KXT09YETU4DyX3KYJ/HF7TsKJuQWEF172FxrD+/aSnvO
	 pekJi6ylLN4isF5860ktgonn//4dB2LDy2yMdiZCUq7sNHlXmamMp3Ot1IIhm5If36
	 AiNWhDNgjCb7NJW667wBRmUJUDj7R+qfMN7qRkBCQ/x1Lx76S4PZ1H3mL2LV7nsHp+
	 NFvSVNv31tkNqjijhIUqCfA7BjFn4ZbgNy0xDFMp0rgvVl+iOUPnNfhpjYOL6BuJ3G
	 9cPQ/zlL+MBustMik0w/Rf1eqOUvKWC6izx+3pjeD+KpSVn0G1E6b0Hei1/3jhG9Nr
	 DAmd/ZeygtcSnqb2sHHY+5B5++jtq4TKwsSxsuPGfs6AXzWI143pbaVm/8Cw61P1OB
	 NBWgPByMVnhvkoKMibfEj7zqZYhvFE17W4jpKU//BGAYgU8eSb24wjU4jzq2QU2cH6
	 Z2K2Trdxx/ciZWAbzR68+93iRqEcGfUybYglzVGcH5mHbmge/ThOp0+wjPtPMrHRt0
	 xaXscIpeEreuimI9Kip4fnf9KRMQssPkz3hPQoro1LfEIbtoHX77CIlx5nshl++zp4
	 YGFwEcqoPWUKTJ/Fzv1di8EI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E173340E00F4;
	Mon, 29 Jul 2024 11:29:38 +0000 (UTC)
Date: Mon, 29 Jul 2024 13:29:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	rafael.j.wysocki@intel.com, catalin.marinas@arm.com,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Terry.bowman@amd.com,
	linuxarm@huawei.com, guohanjun@huawei.com, gshan@redhat.com,
	miguel.luis@oracle.com,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH] x86/aperfmperf: Fix deadlock on cpu_hotplug_lock
Message-ID: <20240729112938.GCZqd9IvTZmKXVGt9T@fat_crate.local>
References: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>

On Mon, Jul 29, 2024 at 11:55:04AM +0100, Jonathan Cameron wrote:
> The broken patch results in a call to init_freq_invariance_cppc() in a CPU
> hotplug handler in both the path for initially present CPUs and those
> hotplugged later.  That function includes a one time call to
> amd_set_max_freq_ratio() which in turn calls freq_invariance_enable() that
> has a static_branch_enable() which takes the cpu_hotlug_lock which is
> already held.
> 
> Avoid the deadlock by using static_branch_enable_cpuslocked() as the lock
> will always be already held.  The equivalent path on Intel does not
> already hold this lock, so take it around the call to
> freq_invariance_enable(), which results in it being held over the call to
> register_syscall_ops, which looks to be safe to do.
> 
> Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/all/CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com/
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

I'll take it through tip if no one objects...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

