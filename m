Return-Path: <linux-kernel+bounces-416907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE9F9D4C40
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC7EB21E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E187E1D0E06;
	Thu, 21 Nov 2024 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jCciykZI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C061C728F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189840; cv=none; b=RJAtF97bP/c/bpfkJGeejz4jVvGT8qSAxL439MW7MmKCxvyaci98Ouf8kiImMN6u22JxhMG5lx/NEoymNSPohLlA9vM5o3ULKd+pc61xk9qXI9jU47CKh3UpdVb6KCQJCl2ZHsIY5ggM2+tVO1S0i5CPC8t0WuBE181hvnUFS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189840; c=relaxed/simple;
	bh=c2YMnfLupFA8rEp9gwNfpk6zidAFLmRJoFVV2Zo14Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESOrmfi3gCMrG45sNaUPiMkx5EkH/RTP95zTYxY4dQPjvx+SjOY8qsa5Dv01s9sd8S+5f3sgk5JFl7HrVwGrtSNpU7DVIQieZahVCM/MarABtBat+rd+GjOYfuQC0uSruGjLdcp5MjpeFb02Z3o6HjQzdvzI5eguOVWUTyfmnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jCciykZI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3D41B40E0263;
	Thu, 21 Nov 2024 11:50:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fLpGkduEaatw; Thu, 21 Nov 2024 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732189827; bh=17zSb8aYTcL4k10y5LSBGllYzpPsKz6juvWhNwQyQnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCciykZIaXcSfax2oTiL/AHDcWp/6zwpmpENlLcBtPJi4PhXm3OzfyymJmZP+KPu/
	 FmkdsQpwEdzIB2K7HgMtHJj7h2xdGnhI/w/TZHxKtsqrfWiOjY6xVLTmzdjuqL8ZxQ
	 DpMNwJVWwxoU2C5sH7hcS27WezIsgqbQm2B7o60Qdl3h4bk4A6nVgbEF+vQl45pJ32
	 CUE0uNWztqnGHzq1M4OLof7vd+cuZSLAYdrExlyjLzPxVisP3nSUexKbTCPJrrYgGX
	 UifPUBFhiJhKORCt1X9TXfPYZI0r1a7ZeCr9DyV8muro6qDM48ykAeR45akz43MtoX
	 htNzCC+eCOE/d5r7HFAG1yGuOuuPtrxAJBXupgGBMPAFrakPz7v/jTkF2m9AzXPh0N
	 6DQC6aFSqVIxQVHHP5wCZKnETSsS3mzLbzcU4LTpXGiH49yyf0WDNarDcLarM178xG
	 oZyLDGO/7CJkIepMILrLDw79TFda3NH95waLQm4hUzTRvbMWA0VW7BukvQzO9Xl/9L
	 XX/EzBe84rC1FljjBmbKKqv8r9lyF3+Nf40N70ddYxs99pr346ng6730Bab/Rv1v5B
	 j21YIHV4iQBdDe64pBeSp4bAoF2xTBThj2c/5cDggmsZK65+M0YhYgh5Y6yCFNLh6U
	 BAAIlDE8V00NgOkoIWryTe2M=
Received: from zn.tnic (p200300ea9736a1a8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a1a8:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9954940E015F;
	Thu, 21 Nov 2024 11:49:57 +0000 (UTC)
Date: Thu, 21 Nov 2024 12:49:52 +0100
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
Message-ID: <20241121114952.GCZz8eYEVa3yubYQzO@fat_crate.local>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
 <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>
 <20241118164616.GAZztvWGs9cOV8t20_@fat_crate.local>
 <s4frmqwtuvclinuu7ttyzfpe7bj7hju5xgt6sxzy3gyt3prr62@rrgvhkv4lgwv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <s4frmqwtuvclinuu7ttyzfpe7bj7hju5xgt6sxzy3gyt3prr62@rrgvhkv4lgwv>

On Tue, Nov 19, 2024 at 10:21:05AM +0200, Kirill A. Shutemov wrote:
> Sure, we can workaround every place that touches such ranges.

Every place? Which every place? I thought this is only an EISA issue?

Then clearly your changelogs need to expand considerably more what we're
*really* addressing here.

> Or we can address problem at the root and make creating decrypted/shared
> mappings explicit.

What is the problem? That KVM implicitly converts memory to shared? Why does
KVM do that an can it be fixed not to?

Doesn't sound like the guest's problem.

Or maybe this needs a lot more explanation what we're fixing here.

> Such mappings have both functional (as we see here) and security
> implications (VMM can manipulate the guest memory range). We should not
> create decrypted mappings by default on legacy interfaces.

So we're getting closer.

The changes themselves are fine but your text is missing a lot about what
we're fixing here. When I asked, I barely scratched the surface. So can we
elaborate here pls?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

