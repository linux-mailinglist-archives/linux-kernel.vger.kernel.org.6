Return-Path: <linux-kernel+bounces-412611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D699D0B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB8C1F2412A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CD81714B7;
	Mon, 18 Nov 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KwJYT+1f"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C7613DBBE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920663; cv=none; b=WYRvF9yyg2eLJMWDdHLaaU0toIkYQI77DqD9n8ELmEJWJNxw8fJVytTLA4/7QAbGrdbZDm0XTjun5S84AEBo6NB1Fadl6CmwcjFfvrNhf2QrMHg766cuDHKnjupICpkYoDc8tRw0jH2/6yfH+cEAiO1fAEsx/N5QijFm8Nme/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920663; c=relaxed/simple;
	bh=4BQxpIeuu0nVwUe5p6hnFcoQh6vfzVx7Oksv1WzT3M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuV9gtyWog7qi3qcY/GOuJkhwkZXXt+h2fzvnU8fxct5wV3tut2j6mOOD4ZkKfMlUYeMmwZeViWXbjmhJVAkBcBDTN5RXaRBNpjUUE2puNPuB3v+LoV701IguQGQEJzvdzNCvxZnzdOwNC79uKZGr0TzxnOHD9A//vXDM/Awf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KwJYT+1f; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so284610166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731920660; x=1732525460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws/rbfiwFMNWy8k0tnCWfMeaJzWW6S4EceX0n9OoukE=;
        b=KwJYT+1fceF8Jn5+OtcCy8fP3MngMd6XLXKAYHXjgu7Rls5dmEQZJ9PwT/bKA7nf39
         iYCoN2dMOp4MaFyscgrSRHZz48jxgaJGcXwAdg6NBVN2XaapOezeTgdTqd9YKHG7w78k
         7q/p7O63+EHoSI2EUkuScs1Ww9KBc3oJofEpNCvwvZTTxK79psq3zUmb1F4h8eMCuwJ5
         roLFKudouMPSmkbhVR6EhyV5xOkV92oyQaY3E6oBsU0lhaxvUyYziyEg6N8Bd4FMzpDp
         G2JBh1y3OR+l4Y3OwEHNsAkKGNSyoIYOQVqTWWjI4pIynO3OpluSTTF73Mrz0tFvsrg+
         7Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731920660; x=1732525460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ws/rbfiwFMNWy8k0tnCWfMeaJzWW6S4EceX0n9OoukE=;
        b=asVoboz04OohqNSx0FhirHINv4xeyZ8dPWwL36ooi9/LJ6qiyqd1XfnoZNmQDg0K2/
         EEwHf44HBh6vRWrYD9Eaq9FDmHYQJn/gZ96u4PWCqBaGbW6o+c2TixQ4fqT73vr2/W35
         cRe78fhfbUNhNtuNNk8ZT0cGO8rneqaWVRQ0WeMwks0N9l7yvxCNJdwYT+hfLrztC5nT
         kPQS2rT1LlgEF07TFxOv1W4OosUoL0vr3fBe+IlH8Jh7/FU0BS/UnJHh6vl8Q9H6Lkqs
         laxfFDiYRPKEs76mGK8ay+iTEbiOP08FE94FVl9xU0RZ84S0oYdaQw/88ZmxkVVinfHp
         sHXA==
X-Forwarded-Encrypted: i=1; AJvYcCUNS29Ya0x9HKFCXcIKq8yCFuNijNKyupUuw10RAMciTbJtptcLQalSp+tGJC8Tps2xAWnZIjknpgbts9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZMuaKkETsFeARGzpJnLzEDgNzXJTenmJ2NRDoswC2CYGI2r0
	EqNeNKJKTIzt8AU/GZcM63xXSDzBu2Ke/xSQDil2X/i/lLEeoeUIEsYIZSJ1iSc=
X-Google-Smtp-Source: AGHT+IHiDm/bz3WEh1enyRl0N1th54dk8RHN4GA3K1qzcDnriUz2+DDQ+dD96pBdIfYZ9dcNHYkGjA==
X-Received: by 2002:a17:907:7284:b0:a9e:c263:29a7 with SMTP id a640c23a62f3a-aa483420a9amr1096106266b.23.1731920659889;
        Mon, 18 Nov 2024 01:04:19 -0800 (PST)
Received: from localhost (109-81-88-120.rct.o2.cz. [109.81.88.120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df50defsm513526566b.50.2024.11.18.01.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:04:19 -0800 (PST)
Date: Mon, 18 Nov 2024 10:04:18 +0100
From: Michal Hocko <mhocko@suse.com>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <peterz@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] sched/membarrier: Fix redundant load of
 membarrier_state
Message-ID: <ZzsDEvJn-vauz9gE@tiehlicka>
References: <20241007053936.833392-1-nysal@linux.ibm.com>
 <20241029055133.121418-1-nysal@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029055133.121418-1-nysal@linux.ibm.com>

I do not see this patch staged in any tree (e.g. linux-next). Is this on
its way to be merged?

Thanks!

On Tue 29-10-24 11:21:28, Nysal Jan K.A. wrote:
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
> ---
> V1 -> V2:
> - Add results for aarch64
> - Add a comment describing the changes
> ---
>  include/linux/sched/mm.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 928a626725e6..b13474825130 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -531,6 +531,13 @@ enum {
>  
>  static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
>  {
> +	/*
> +	 * The atomic_read() below prevents CSE. The following should
> +	 * help the compiler generate more efficient code on architectures
> +	 * where sync_core_before_usermode() is a no-op.
> +	 */
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE))
> +		return;
>  	if (current->mm != mm)
>  		return;
>  	if (likely(!(atomic_read(&mm->membarrier_state) &
> -- 
> 2.47.0
> 

-- 
Michal Hocko
SUSE Labs

