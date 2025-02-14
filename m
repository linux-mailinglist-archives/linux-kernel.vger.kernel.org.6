Return-Path: <linux-kernel+bounces-515414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 027DEA36480
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081471889C00
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFEF268686;
	Fri, 14 Feb 2025 17:24:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28C267F6F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553872; cv=none; b=WVa/TPni1W1IBOoc4N9+sTPR53ggWmyQxJ1emBjgDfW8kKXvrB6eblXvAGY1wkZTlCP+dzKgiEvGvWX2fqkamdocFSPkor/vmn4kL3qbzestMyTTyYTb+osnVypqxioFOJCBLE64x/KQAGEh9TpD3+RvPK+BicCtJ8lreKT3R/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553872; c=relaxed/simple;
	bh=Q0OEuFeXMxIl/M4HKuCdw4CJ8+gHFxwOPjKc2UbWKEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVb8Vxlpkv98H2udWwIteD7WDPeQk0NOUbVRiZobiLNapj8qpWxDoGugLO8lEfplgU5wx135YNkbU9jNk8hwgAUAInUK5UY2JLSyKeShu9A75PS44xpb9Nxeypo8LBtKyJvp7QG1RBzDz5RiGqllhdvtzTbtuLcIdYJixy/GiHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF84C4CED1;
	Fri, 14 Feb 2025 17:24:27 +0000 (UTC)
Date: Fri, 14 Feb 2025 17:24:24 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Morse <james.morse@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, wangkefeng.wang@huawei.com,
	Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH v13 4/5] arm64: support copy_mc_[user]_highpage()
Message-ID: <Z698SFVqHjpGeGC0@arm.com>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
 <20241209024257.3618492-5-tongtiangen@huawei.com>
 <Z6zWSXzKctkpyH7-@arm.com>
 <69955002-c3b1-459d-9b42-8d07475c3fd3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69955002-c3b1-459d-9b42-8d07475c3fd3@huawei.com>

On Fri, Feb 14, 2025 at 10:49:01AM +0800, Tong Tiangen wrote:
> 在 2025/2/13 1:11, Catalin Marinas 写道:
> > On Mon, Dec 09, 2024 at 10:42:56AM +0800, Tong Tiangen wrote:
> > > Currently, many scenarios that can tolerate memory errors when copying page
> > > have been supported in the kernel[1~5], all of which are implemented by
> > > copy_mc_[user]_highpage(). arm64 should also support this mechanism.
> > > 
> > > Due to mte, arm64 needs to have its own copy_mc_[user]_highpage()
> > > architecture implementation, macros __HAVE_ARCH_COPY_MC_HIGHPAGE and
> > > __HAVE_ARCH_COPY_MC_USER_HIGHPAGE have been added to control it.
> > > 
> > > Add new helper copy_mc_page() which provide a page copy implementation with
> > > hardware memory error safe. The code logic of copy_mc_page() is the same as
> > > copy_page(), the main difference is that the ldp insn of copy_mc_page()
> > > contains the fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR, therefore, the
> > > main logic is extracted to copy_page_template.S. In addition, the fixup of
> > > MOPS insn is not considered at present.
> > 
> > Could we not add the exception table entry permanently but ignore the
> > exception table entry if it's not on the do_sea() path? That would save
> > some code duplication.
> 
> I'm sorry, I didn't catch your point, that the do_sea() and non do_sea()
> paths use different exception tables?

No, they would have the same exception table, only that we'd interpret
it differently depending on whether it's a SEA error or not. Or rather
ignore the exception table altogether for non-SEA errors.

> My understanding is that the
> exception table entry problem is fine. After all, the search is
> performed only after a fault trigger. Code duplication can be solved by
> extracting repeated logic to a public file.

If the new exception table entries are only taken into account for SEA
errors, why do we need a duplicate copy_mc_page() function generated?
Isn't the copy_page() and copy_mc_page() code identical (except for the
additional labels to jump to for the exception)?

-- 
Catalin

