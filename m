Return-Path: <linux-kernel+bounces-421288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9A9D8921
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9E71612D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3101B3930;
	Mon, 25 Nov 2024 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR3rS21M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0501A0AF0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548129; cv=none; b=TSlDEVWbk+WqrLoo2+uIAgURupM/TgpINrMTjJ7hpSy1GqrnmZz4Qslu9X9qrCaHYKbg3H/j+FiBdAh/HrHsM7srGTk9q7Nq8iv3pfOdyEGqgV6S5E7ueidlu1OF6tEGDXy/827Eww/0PtY7x1qLnMOj4pA3QSL3cfb42HE1ggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548129; c=relaxed/simple;
	bh=dy2fUC3Stp8CrKtZQSEcsiEhBheaz3FIUb1u3DlnIdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc3NlQOSr4AaQEFHjQBU9enO0zaU2IB8j94/+s4PFVP6UVRneK+QepdfobRzbAbB4T1x7nJMVNTYHSx1uYIALMhddxoBcFy9IhqyT6vpjNC9TP+qgo0SKEtwgBfBqG8t6bJSR9892r9DuA1p22mkcIxfI0s0whBOFAICjxhSN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR3rS21M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42357C4CECE;
	Mon, 25 Nov 2024 15:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732548129;
	bh=dy2fUC3Stp8CrKtZQSEcsiEhBheaz3FIUb1u3DlnIdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QR3rS21M2KGkHEHHH8+vdXJI0OSl9SBbDyKKk7PcozxHkk3zUnqUIaDOpxeeetRgg
	 kBNBSbIwXN7917M36RVEDC5JrNihq/Kk2RUcbG/XKlHhOom1iK5Z5RUAqpnmXRcZv1
	 l9Ht9LmV1UkcMDcgeq6CArGanLjiQbZ+t/H9yhDVBqpB+YRHXy/GmV062UcVbRq9JD
	 ckMwZcOGpnLlGqBbLxVjlgw4cNfxg8uakhCZ2RBlf9fXpHw4vtE+eXwKEB3sCzehHP
	 /FS5qlpVU048kOl5H2NvfPMFCg2tlR+CuM3cuMFPEJDe7UgQpLw6XOpo8rE9xoQMML
	 kGB8VEBsmgAsQ==
Date: Mon, 25 Nov 2024 15:22:03 +0000
From: Will Deacon <will@kernel.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nanyong Sun <sunnanyong@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] mm/arm64: re-enable HVO
Message-ID: <20241125152203.GA954@willie-the-truck>
References: <20241107202033.2721681-1-yuzhao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107202033.2721681-1-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Yu Zhao,

On Thu, Nov 07, 2024 at 01:20:27PM -0700, Yu Zhao wrote:
> HVO was disabled by commit 060a2c92d1b6 ("arm64: mm: hugetlb: Disable
> HUGETLB_PAGE_OPTIMIZE_VMEMMAP") due to the following reason:
> 
>   This is deemed UNPREDICTABLE by the Arm architecture without a
>   break-before-make sequence (make the PTE invalid, TLBI, write the
>   new valid PTE). However, such sequence is not possible since the
>   vmemmap may be concurrently accessed by the kernel.
> 
> This series presents one of the previously discussed approaches to
> re-enable HugeTLB Vmemmap Optimization (HVO) on arm64.

Before jumping into the new mechanisms here, I'd really like to
understand how the current code is intended to work in the relatively
simple case where the vmemmap is page-mapped to start with (i.e. when we
don't need to worry about block-splitting).

In that case, who are the concurrent users of the vmemmap that we need
to worry about? Is it solely speculative references via
page_ref_add_unless() or are there others?

Looking at page_ref_add_unless(), what serialises that against
__hugetlb_vmemmap_restore_folio()? I see there's a synchronize_rcu()
call in the latter, but what prevents an RCU reader coming in
immediately after that?

Even if we resolve the BBM issues, we still need to get the
synchronisation right so that we don't e.g. attempt a cmpxchg() to a
read-only mapping, as the CAS instruction requires write permission on
arm64 even if the comparison ultimately fails.

So please help me to understand the basics of HVO before we get bogged
down by the block-splitting on arm64.

Cheers,

Will

