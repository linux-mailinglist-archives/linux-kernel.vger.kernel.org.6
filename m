Return-Path: <linux-kernel+bounces-517890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254C0A38709
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EDB3A3AF2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40186223321;
	Mon, 17 Feb 2025 14:55:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68321B199
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804140; cv=none; b=GuLvsYlpaZhlaTMxVgF7kl47DPkjHxKPF9l1z+coSBrI0osl5PQfbsDjKaFDm9ntyF3pqFs3xux/6649q2wQlhilx4E5CB4+CEIqOurK7pJAM9+kn8mT3Qsdlmdp7efPXzXAZOFG8yfftxUQEOvVP5rAitIpV2LhXb8MN/gWiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804140; c=relaxed/simple;
	bh=mCmhZKA69/c2eU7LC9F+MUZq2m9KGbt0EwRoFPfhmtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0boiNleDAhVaPQM3LbpHA68CPehKFpkWKaIdENPp2cpxLHvW9Xh8zxdS8VQty2C+uSnZ5etq8eAE33bAWzmY9XCghbUjr+EAFbwdVij/1Y3Xo8tqpaRVCro1jdgiyeH5Ur+/YqvEb14UcSJlR49kWBZNLDQAJuft14jqYluclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453CDC4CED1;
	Mon, 17 Feb 2025 14:55:35 +0000 (UTC)
Date: Mon, 17 Feb 2025 14:55:32 +0000
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
Message-ID: <Z7NN5Pa-c5PtIbcF@arm.com>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
 <20241209024257.3618492-5-tongtiangen@huawei.com>
 <Z6zWSXzKctkpyH7-@arm.com>
 <69955002-c3b1-459d-9b42-8d07475c3fd3@huawei.com>
 <Z698SFVqHjpGeGC0@arm.com>
 <e1d2affb-5c6b-00b5-8209-34bbca36f96b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1d2affb-5c6b-00b5-8209-34bbca36f96b@huawei.com>

On Mon, Feb 17, 2025 at 04:07:49PM +0800, Tong Tiangen wrote:
> 在 2025/2/15 1:24, Catalin Marinas 写道:
> > On Fri, Feb 14, 2025 at 10:49:01AM +0800, Tong Tiangen wrote:
> > > 在 2025/2/13 1:11, Catalin Marinas 写道:
> > > > On Mon, Dec 09, 2024 at 10:42:56AM +0800, Tong Tiangen wrote:
> > > > > Currently, many scenarios that can tolerate memory errors when copying page
> > > > > have been supported in the kernel[1~5], all of which are implemented by
> > > > > copy_mc_[user]_highpage(). arm64 should also support this mechanism.
> > > > > 
> > > > > Due to mte, arm64 needs to have its own copy_mc_[user]_highpage()
> > > > > architecture implementation, macros __HAVE_ARCH_COPY_MC_HIGHPAGE and
> > > > > __HAVE_ARCH_COPY_MC_USER_HIGHPAGE have been added to control it.
> > > > > 
> > > > > Add new helper copy_mc_page() which provide a page copy implementation with
> > > > > hardware memory error safe. The code logic of copy_mc_page() is the same as
> > > > > copy_page(), the main difference is that the ldp insn of copy_mc_page()
> > > > > contains the fixup type EX_TYPE_KACCESS_ERR_ZERO_MEM_ERR, therefore, the
> > > > > main logic is extracted to copy_page_template.S. In addition, the fixup of
> > > > > MOPS insn is not considered at present.
> > > > 
> > > > Could we not add the exception table entry permanently but ignore the
> > > > exception table entry if it's not on the do_sea() path? That would save
> > > > some code duplication.
> > > 
> > > I'm sorry, I didn't catch your point, that the do_sea() and non do_sea()
> > > paths use different exception tables?
> > 
> > No, they would have the same exception table, only that we'd interpret
> > it differently depending on whether it's a SEA error or not. Or rather
> > ignore the exception table altogether for non-SEA errors.
> 
> You mean to use the same exception type (EX_TYPE_KACCESS_ERR_ZERO) and
> then do different processing on SEA errors and non-SEA errors, right?

Right.

> If so, some instructions of copy_page() did not add to the exception
> table will be added to the exception table, and the original logic will
> be affected.
> 
> For example, if an instruction is not added to the exception table, the
> instruction will panic when it triggers a non-SEA error. If this
> instruction is added to the exception table because of SEA processing,
> and then a non-SEA error is triggered, should we fix it?

No, we shouldn't fix it. The exception table entries have a type
associated. For a non-SEA error, we preserve the original behaviour even
if we find a SEA-specific entry in the exception table. You already need
such logic even if you duplicate the code for configurations where you
have MC enabled.

-- 
Catalin

