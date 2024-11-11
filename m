Return-Path: <linux-kernel+bounces-404041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB58A9C3E66
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2FB1C218E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BEF19C552;
	Mon, 11 Nov 2024 12:25:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B614A62B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327944; cv=none; b=tCV31b+s4hhfpGOZW+7XWUVXEupnVohXPgyMDnAdlp1+I62iRtnsiRo3FgKIy4tL1ZEv+ZQEe9tjofY+8wLz9EiLZYfCRSnABHhrlsdOqP1BXzkWEVQG25ftzXOI8q3t08yBVFu2sk/VmRJd4n7u1zjV/3Ro9ZeiH1ddiJyW+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327944; c=relaxed/simple;
	bh=1oFrpUGivukzVsZON/9Fsd2HBtllmpWCGjpIFBhwDsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtWow48WIkHg6Zk4hG0jFsgHcdxhaseKzbTMnzF3SI6C1Q8lx+2nB6RduZ9iGH3Ld6/xEA8jv4P+QMISKzrTZZfNfnoG6ztCPWl4xSwmf3QVtK9O3uXWxIucKRpuOhBlnpOqzfE2i2nnZEWDmJf4gQN8nBUmA0d6KsR15gv9RqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C6421F37;
	Mon, 11 Nov 2024 04:26:10 -0800 (PST)
Received: from [10.57.89.175] (unknown [10.57.89.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D87D3F6A8;
	Mon, 11 Nov 2024 04:25:37 -0800 (PST)
Message-ID: <046ce0ae-b4d5-4dbd-ad9d-eb8de1bba1b8@arm.com>
Date: Mon, 11 Nov 2024 12:25:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Content-Language: en-GB
To: Petr Tesarik <ptesarik@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241017142752.17f2c816@mordecai.tesarici.cz>
 <aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
 <20241111131442.51738a30@mordecai.tesarici.cz>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241111131442.51738a30@mordecai.tesarici.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr,

On 11/11/2024 12:14, Petr Tesarik wrote:
> Hi Ryan,
> 
> On Thu, 17 Oct 2024 13:32:43 +0100
> Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> [...]
>> I understand that Suse might be able to help with wider performance testing
> 
> Sorry for the delay (vacation, other tasks). Anyway, let me share some
> results with you.

Not at all; thanks for coming back with these results!

> 
> First, I have looked only at 4k pages (constant v. selected at boot
> time) so far.
> 
> Second, the impact of the patch series is much smaller than I expected.
> Most macro-benchmarks (dbench, io-bench) did not see any significant
> slowdown. There appears to be a performance hit of approx. 1-2%, but
> that's within noise, and I can't dedicate my time to running extensive
> tests to find the distribution peak and compare. In short, I suspect a
> slight performance hit, but I cannot quantify it.
> 
> Third, a few micro-benchmarks saw a significant regression.
> 
> Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
> slower with variable page size. I don't know why, but I'm looking into
> it. The system() library call was also about 18% slower, but that might
> be related.

OK, ouch. I think there are some things we can try to optimize the
implementation further. But I'll wait for your analysis before digging myself.

You probably also saw the conversation with Catalin about the cost vs benefit of
this series. Performance regressions will all need to be considered in the cost
column, of course. So understanding the root cause and trying to reduce the
regression as much as possible will increase chances of getting it accepted
upstream.

Thanks,
Ryan

> 
> The dup() syscall was up to 5% slower (depends on underlying filesystem
> type).
> 
> VMA unmap was slower for some sizes, but the pattern seemed random,
> sometimes giving even better performance with variable page size, so
> this micro-benchmark may be too unstable to draw any conclusions.
> 
> Stay tuned
> Petr T


