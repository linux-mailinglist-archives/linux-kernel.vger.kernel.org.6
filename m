Return-Path: <linux-kernel+bounces-387439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A562A9B5158
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5207D1F251A0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273FE1DFE2F;
	Tue, 29 Oct 2024 17:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="I7Zy7hH3"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD3197A77
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730224364; cv=none; b=QbBnz85KZhz4BT8WodZz+GDViGkr7+UqLRI4SXMTckM3PpffO401iVp3qzGBxkJLk+8uD5hkroFtBmHy42M2CfPwU2gRvmTxmK4el8x53qHFsb9TEd3smPSshEdBUG7agR0RYjBOebQq35+2EyRfAG2eI4XIM4KoDrYUA/KNpy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730224364; c=relaxed/simple;
	bh=ckhCM+oqjtXOYCi/PgBB1sMyi0XnHiioDpF/gdoLapo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kS+O2zOZqH18K1qskcnlOyK2e4t3qY9ct1NcFSKoJSigh5l23CEH4R3n4DxAn27JW7GeG+kkl9Qh3NVdTgkipF8BnaVh3lIBqhAwJJiCdlsr14yzVzFQL69rpUV7TbSQWgqYWadgpAWdwweg3S/G9XQHatbtM8nEwP7Jq7uYWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=I7Zy7hH3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730224361;
	bh=ckhCM+oqjtXOYCi/PgBB1sMyi0XnHiioDpF/gdoLapo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I7Zy7hH3FCMNOgCYw8IRpx4H60VVYnk/nLxKPA/RTMeO4ATJ/LMo6HSxoh90SK6cd
	 X/fX0sFZfRUwApEY9r5NQICnyxMuUNeR/ivkIGyv0ZZCTN4YOKHDO25qTdDfYPA5kD
	 2bvGClZkgpcjH41laajsctsOPs8Oddb7+MrurbDmS0G63pfNNG3GGtoJaAgC9iDIlk
	 bYDoCQCBQCHI/kxtlLLtvwpI/aoiDUfnFmNn5e108XZHKtqJYtDBP1jvjblvo7G2eH
	 cU1O86iX2lGY79zddBehVOlhVWXsOyDjjYekM5WKV/SXjrfTO59Oxz7+9cXA4q4wNp
	 DfgjYGkD7bphA==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XdHsN6kJcz166Y;
	Tue, 29 Oct 2024 13:52:40 -0400 (EDT)
Message-ID: <6f394b76-3db4-4a7b-9fdd-737c6812e7ef@efficios.com>
Date: Tue, 29 Oct 2024 13:51:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/membarrier: Fix redundant load of
 membarrier_state
To: "Nysal Jan K.A." <nysal@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@Oracle.com>, Mark Brown <broonie@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20241007053936.833392-1-nysal@linux.ibm.com>
 <20241029055133.121418-1-nysal@linux.ibm.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20241029055133.121418-1-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-29 01:51, Nysal Jan K.A. wrote:
> On architectures where ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> is not selected, sync_core_before_usermode() is a no-op.
> In membarrier_mm_sync_core_before_usermode() the compiler does not
> eliminate redundant branches and load of mm->membarrier_state
> for this case as the atomic_read() cannot be optimized away.
> 
> Here's a snippet of the code generated for finish_task_switch() on powerpc
> prior to this change:
> 
> 1b786c:   ld      r26,2624(r30)   # mm = rq->prev_mm;
> .......
> 1b78c8:   cmpdi   cr7,r26,0
> 1b78cc:   beq     cr7,1b78e4 <finish_task_switch+0xd0>
> 1b78d0:   ld      r9,2312(r13)    # current
> 1b78d4:   ld      r9,1888(r9)     # current->mm
> 1b78d8:   cmpd    cr7,r26,r9
> 1b78dc:   beq     cr7,1b7a70 <finish_task_switch+0x25c>
> 1b78e0:   hwsync
> 1b78e4:   cmplwi  cr7,r27,128
> .......
> 1b7a70:   lwz     r9,176(r26)     # atomic_read(&mm->membarrier_state)
> 1b7a74:   b       1b78e0 <finish_task_switch+0xcc>
> 
> This was found while analyzing "perf c2c" reports on kernels prior
> to commit c1753fd02a00 ("mm: move mm_count into its own cache line")
> where mm_count was false sharing with membarrier_state.
> 
> There is a minor improvement in the size of finish_task_switch().
> The following are results from bloat-o-meter for ppc64le:
> 
> GCC 7.5.0
> ---------
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-32 (-32)
> Function                                     old     new   delta
> finish_task_switch                           884     852     -32
> 
> GCC 12.2.1
> ----------
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-32 (-32)
> Function                                     old     new   delta
> finish_task_switch.isra                      852     820     -32
> 
> LLVM 17.0.6
> -----------
> add/remove: 0/0 grow/shrink: 0/2 up/down: 0/-36 (-36)
> Function                                     old     new   delta
> rt_mutex_schedule                            120     104     -16
> finish_task_switch                           792     772     -20
> 
> Results on aarch64:
> 
> GCC 14.1.1
> ----------
> add/remove: 0/2 grow/shrink: 1/1 up/down: 4/-60 (-56)
> Function                                     old     new   delta
> get_nohz_timer_target                        352     356      +4
> e843419@0b02_0000d7e7_408                      8       -      -8
> e843419@01bb_000021d2_868                      8       -      -8
> finish_task_switch.isra                      592     548     -44
> 
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>

Thanks!

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
> V1 -> V2:
> - Add results for aarch64
> - Add a comment describing the changes
> ---
>   include/linux/sched/mm.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 928a626725e6..b13474825130 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -531,6 +531,13 @@ enum {
>   
>   static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>   {
> +	/*
> +	 * The atomic_read() below prevents CSE. The following should
> +	 * help the compiler generate more efficient code on architectures
> +	 * where sync_core_before_usermode() is a no-op.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE))
> +		return;
>   	if (current->mm != mm)
>   		return;
>   	if (likely(!(atomic_read(&mm->membarrier_state) &

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


