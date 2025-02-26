Return-Path: <linux-kernel+bounces-534884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49543A46C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AC73AA598
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FCD275617;
	Wed, 26 Feb 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JPK8D0Mz"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D382755E0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601398; cv=none; b=SgwyqD3gL67tJsCImXG8m4eqg/ECAaXK2knD5Bc7+ayL00G0Q281BswJj81tvgUAPdVbq7dH79zm4/zTGwrai+7dtz4eWlPRkCicFwhh7hupq21uUYu04+Gj7y4Rf3cSU7fiTD4FcRSMVwPGI9gYRSewNREB7/gEjM55lpbF0Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601398; c=relaxed/simple;
	bh=yg/kt5zICWodmH/YM0tZUiIOUmm5EUfO3IHUJurpo/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTVcf/edL1Jafv/QivyH1Fq4PvNVv4NXCtVXUJC3r1u7BL5O1U8i0WaraQz8WPwjfheEEW3htHbE5smpju5c4XKxbNr30v7xf0gJPpKPjN+nMMDdz6ErWreqw0BiXMxtbwrQoZ2+GtuxCS9Z6GJhIHCAtVjEqgT4x6mCUgqMQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JPK8D0Mz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PL5FwRJz7ILrOFAPBeIKRMPUecxhNUlQx6/hHWEVlm4=; b=JPK8D0Mz8XZzo/CFbIYqQqzxjY
	U8E54dzP4mfNULiXVwY27h9A0ptiqQxS+A9oWxlOqESCRN2CmzMsFU4h+96CyVm7qEKtyW24vvQdH
	wFaFfJjosJBIa+HlkHjR4IyJFjCqDvdXd3enIhPkAFxchMC6oRhzxrEcKZhyZ9gQNpJ6pHs6jX6Fw
	hKaEQvcUI9ByOj83dzskFRrwWRFTPb5jBziYEbasGcyQPQiPwaFonmShGvYCe9bG996gLGjnNZLNK
	qEsaKgdLEJ8j7CCTaNFEs55j+9PCYEwuQhFntntAIeNNcnsYMS1IY1MvxLMdIL6tr2a45IJmn4tPo
	oryzFyXA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNvy-0000000GERq-2tzK;
	Wed, 26 Feb 2025 20:23:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8D94F300756; Wed, 26 Feb 2025 21:23:09 +0100 (CET)
Date: Wed, 26 Feb 2025 21:23:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/11] Add a percpu subsection for cache hot data
Message-ID: <20250226202309.GB29387@noisy.programming.kicks-ass.net>
References: <20250226180531.1242429-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226180531.1242429-1-brgerst@gmail.com>

On Wed, Feb 26, 2025 at 01:05:19PM -0500, Brian Gerst wrote:
> Add a new percpu subsection for data that is frequently accessed and
> exclusive to each processor.  This replaces the pcpu_hot struct on x86,
> and is available to all architectures and the core kernel.
> 
> ffffffff842fa000 D __per_cpu_hot_start
> ffffffff842fa000 D hardirq_stack_ptr
> ffffffff842fa008 D __ref_stack_chk_guard
> ffffffff842fa008 D __stack_chk_guard
> ffffffff842fa010 D const_cpu_current_top_of_stack
> ffffffff842fa010 D cpu_current_top_of_stack
> ffffffff842fa018 D const_current_task
> ffffffff842fa018 D current_task
> ffffffff842fa020 D __x86_call_depth
> ffffffff842fa028 D this_cpu_off
> ffffffff842fa030 D __preempt_count
> ffffffff842fa034 D cpu_number
> ffffffff842fa038 D __softirq_pending
> ffffffff842fa03a D hardirq_stack_inuse
> ffffffff842fa040 D __per_cpu_hot_end

The above is useful, but not quite as useful as looking at:

$ pahole -C pcpu_hot defconfig-build/vmlinux.o
struct pcpu_hot {
        union {
                struct {
                        struct task_struct * current_task; /*     0     8 */
                        int        preempt_count;        /*     8     4 */
                        int        cpu_number;           /*    12     4 */
                        u64        call_depth;           /*    16     8 */
                        long unsigned int top_of_stack;  /*    24     8 */
                        void *     hardirq_stack_ptr;    /*    32     8 */
                        u16        softirq_pending;      /*    40     2 */
                        bool       hardirq_stack_inuse;  /*    42     1 */
                };                                       /*     0    48 */
                u8                 pad[64];              /*     0    64 */
        };                                               /*     0    64 */

        /* size: 64, cachelines: 1, members: 1 */
};

A slightly more useful variant of your listing would be:

$ readelf -Ws defconfig-build/vmlinux | sort -k 2 | awk 'BEGIN {p=0} /__per_cpu_hot_start/ {p=1} { if (p) print $2 " " $3 " " $8 } /__per_cpu_hot_end/ {p=0}'
ffffffff834f5000 0 __per_cpu_hot_start
ffffffff834f5000 8 hardirq_stack_ptr
ffffffff834f5008 0 __ref_stack_chk_guard
ffffffff834f5008 8 __stack_chk_guard
ffffffff834f5010 0 const_cpu_current_top_of_stack
ffffffff834f5010 8 cpu_current_top_of_stack
ffffffff834f5018 0 const_current_task
ffffffff834f5018 8 current_task
ffffffff834f5020 8 __x86_call_depth
ffffffff834f5028 8 this_cpu_off
ffffffff834f5030 4 __preempt_count
ffffffff834f5034 4 cpu_number
ffffffff834f5038 2 __softirq_pending
ffffffff834f503a 1 hardirq_stack_inuse
ffffffff834f5040 0 __per_cpu_hot_end

as it also gets the size for each symbol. Allowing us to compute the
hole as 0x40-0x3b, or 5 bytes.



