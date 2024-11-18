Return-Path: <linux-kernel+bounces-413250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C82559D15B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B702B2BE8F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55E71BBBC4;
	Mon, 18 Nov 2024 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cc9tbCWX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D079DC7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948421; cv=none; b=QsPj8Kjfpcn+yl8G2ZtrBjC47P4Ns0EPq0klAoCrHK5hIxlNn4eAVeqjY51xXBSKeUX8uLAkYz5UyJifoxutmsVpk98LkL/B45Lc0FvsFhDWqyaeSC71/1c6XQz7xVCavReVK8aTSE77lOxklwTKv/3w1AOZGReW6+LLzr7Hpfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948421; c=relaxed/simple;
	bh=29P/qgZA/YnVFpv/heHDj3lDgK7eJpCh+lKxP/sXY58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tt2L7awL4YqBi8wJ9fq0szP4GVlvStgxcRRO24eY/DYlABI1z6fvTTEWQWIrjbLNH85NaDdUGB1vWAAmq3wuH+cpM+CXddlBIPvVOp3lYa3q5np4BTkwnJClsMPGJ0McijXfc18zc9fRKC+yhbJpqlAgm/g5Aj73uTH2+LIb86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Cc9tbCWX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3CC8340E019C;
	Mon, 18 Nov 2024 16:46:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c6v2K22B5Tnb; Mon, 18 Nov 2024 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731948411; bh=rPDV0OJuPMZjYOAxC/88k5DmzxXHqcjOOoFuf/a7xM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cc9tbCWXLsXSrJi7c1OfRXsQ2qSLXZmGyrD6Ue1nlLUTcaY/vtPzAd8MPRX5vxnmb
	 9ZPBWH22VFOSy107g8yT7ZaHuJaiBzgNuSySoZ2LvQ8Iz/mv5q0cQzkGrILcMx3tpM
	 N5u/p2XCUd7YVYW4WMtcUwToF86Sw8IbCNA6AVzOMCEsPWEXhZg1P2U8MFPk9sBZTl
	 TiPhEeHJh27yOHn8ghqJ2Ph/aMgEDBxGB7NFxSsOQE3oPf8d4ntpH3Gw1Dm4PP9qSE
	 H1mHy8auOJQYKFPFAZsnr7lug81DkxaDgkg/wJO1jsHNud9MxEfHEgUEA//v14tV40
	 I5N3K5PWKjmhbEWdDlRCcEF2GXQNiMu0rZ+GBH3OPXkwAYP6XR/VB1rBeu4o60p7By
	 OOBUtZeL9JVb8w4kwMRllAUQ0VZxDq1Fq0Z9XfmV6Hg+hU5vSAEFf5OxuvswXuMihj
	 YILuCMQ6eyThHcDMGwKPbRRei+FexB+brIHyWwX8yG6OMDtGSHd6jCGM0Ug9aK3vT/
	 2yjMZu8Q42ewHmKMKqPf2daKWoZbiyDN+PqwhsiaAXS2nCKMKjY/TVPvSivoQcvZOE
	 EkMDd+mSyQnvE4qJBtHrURoQqMvMjvfOH488j6ZRiVpzI5AwQkR90P0uA5jRlcA6QF
	 xw5MBqcn5hwajMKsV0d1eX7g=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 47B9840E0163;
	Mon, 18 Nov 2024 16:46:22 +0000 (UTC)
Date: Mon, 18 Nov 2024 17:46:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Chan <ericchancf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kai Huang <kai.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Russell King <linux@armlinux.org.uk>,
	Samuel Holland <samuel.holland@sifive.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv2 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <20241118164616.GAZztvWGs9cOV8t20_@fat_crate.local>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
 <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>

On Mon, Oct 21, 2024 at 01:57:23PM +0300, Kirill A. Shutemov wrote:
> It fixes crash on kexec in TDX guests if CONFIG_EISA is enabled.

Do TDX guests even need EISA?

"The EISA bus saw limited use between 1988 and 1995 when it was made obsolete
by the PCI bus."

Sounds like no to me.

We usually simply stop coco guests from touching such legacy ranges:

f30470c190c2 ("x86/boot: Skip video memory access in the decompressor for SEV-ES/SNP")

so can you do that too?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

