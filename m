Return-Path: <linux-kernel+bounces-511608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1170FA32D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65643A57C3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD132135A1;
	Wed, 12 Feb 2025 17:18:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8309A205AD9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380709; cv=none; b=MCEBTPYJ52rYJIuqlkYsI1Qh/tUDbTh2T1xsCC7kO8w5dAO52T1qtu9qRpWGLEUQLq8wdYkodrkyyqhJ+wMdxETXZQejvDTc5dHCdm1BchbgLHZtd/1AG2kfLeuVHBfMvBb17OXx3CbE7U+XP8eVAdZjnFybp+WqhbMVfj/J4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380709; c=relaxed/simple;
	bh=ZjYnAE16EGe/YsAAdLaejX/xYM/waPeuGE8ePV6a4+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7XqoUTZhgBKDXJ8SeXnbnjXomNKA7tkgEBJbHnUqj8onGKCZtXn7WbJDbpaIs7terKrQU/grZX4Rq9ca5nni66kAyWLdHJQ4+ZtMSU7SXm8XurO6YQ3ChL4ROMMtY81AI8GghDMsO/SgGbbMRUCKalYk/6VBwqoQM3eS+hGCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15C2C4CEDF;
	Wed, 12 Feb 2025 17:18:23 +0000 (UTC)
Date: Wed, 12 Feb 2025 17:18:21 +0000
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
Subject: Re: [PATCH v13 5/5] arm64: introduce copy_mc_to_kernel()
 implementation
Message-ID: <Z6zX3Ro60sMH7C13@arm.com>
References: <20241209024257.3618492-1-tongtiangen@huawei.com>
 <20241209024257.3618492-6-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209024257.3618492-6-tongtiangen@huawei.com>

On Mon, Dec 09, 2024 at 10:42:57AM +0800, Tong Tiangen wrote:
> The copy_mc_to_kernel() helper is memory copy implementation that handles
> source exceptions. It can be used in memory copy scenarios that tolerate
> hardware memory errors(e.g: pmem_read/dax_copy_to_iter).
> 
> Currently, only x86 and ppc support this helper, Add this for ARM64 as
> well, if ARCH_HAS_COPY_MC is defined, by implementing copy_mc_to_kernel()
> and memcpy_mc() functions.
> 
> Because there is no caller-saved GPR is available for saving "bytes not
> copied" in memcpy(), the memcpy_mc() is referenced to the implementation
> of copy_from_user(). In addition, the fixup of MOPS insn is not considered
> at present.

Same question as on the previous patch, can we not avoid the memcpy()
duplication if the only difference is entries in the exception table?
IIUC in patch 2 fixup_exception() even ignores the new type. The error
must come on the do_sea() path.

-- 
Catalin

