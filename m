Return-Path: <linux-kernel+bounces-549988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA68A5598E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2352116EEE9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C197279338;
	Thu,  6 Mar 2025 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/K1kEwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B320969B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741299559; cv=none; b=e5tPOalGZ2NNpkysy7iCXHNInPKCGx/5H+kOXxj3E1sNe7RwjCpieDJ23pAjJjjC1qFEsg1A8mKWnizHKzKuK/SLlIy8vrm6A9u2WAgSmeziDGlnJ7EsM8yQ/PfgyL7AJw2GYPdaczNVsCTJxz15BV9J1Tz+R6z9ontbLEKNjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741299559; c=relaxed/simple;
	bh=FpxQ1xYJ+FPwvnR/byt4lS/xLOZ4V5p42GGK/bWyLpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWaoAbEpPsuRUfa/NObgnTsPfhBsCCurJ2dng4Jk546/p9WdZH31NURsWXGYOZRhuNKVtFbqTZNYXakp8dD0ZFItoAI6GlqeL87aLCqCvhReUCzLtIJRdM21ES3DtrKdmzrhnhRAh+eLXYWTaPYEYvTOWASzdBPlR9gfvlP9Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/K1kEwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFBBC4CEE0;
	Thu,  6 Mar 2025 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741299558;
	bh=FpxQ1xYJ+FPwvnR/byt4lS/xLOZ4V5p42GGK/bWyLpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/K1kEwYsH3Q112IllrPfMRqN/bGUDbxvUkkMh4M0//5sO8PKKT236D3s79Qm6sSC
	 s/qdT3/PLbz0F4eSGCPJOeIUAx7OuqZA6cJflRpX7lGBfkJWwEpD/dEhXL1G8tCvmy
	 JFvyDhY0W4GJLlw5ovDdI0w6vFQIE3NrW0qdqQTnrxpbNlAdS2Nz4eZExxgLAY6aP6
	 lUu21ios0E0ajebfmTUjGSNSOjCsncFXoHCvU80G3+9m/pE+VOSDrvOQKfYlqgEahH
	 Jb5cBcfQ7wFc+OahLpSvaBvvmGg41ASB6gGYpPFhFARl0Vb6L+XmgNFeqyJFoC+QkT
	 H2RYF16hfgwgg==
Date: Thu, 6 Mar 2025 23:19:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8ofYTR9nou2650h@gmail.com>
References: <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
 <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local>
 <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
 <20250305201429.3026ba9f@pumpkin>
 <CAFULd4ZzdPcnQAELpukF4vzUnQufteNqV4BzZr3BxuzRG+XK+A@mail.gmail.com>
 <CAFULd4Yuhb-BbV9LAJ+edMRGEi2kTYfcq70=TTMaSXP3oxwfQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4Yuhb-BbV9LAJ+edMRGEi2kTYfcq70=TTMaSXP3oxwfQQ@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Thu, Mar 6, 2025 at 11:45 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > On Wed, Mar 5, 2025 at 9:14 PM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Wed, 5 Mar 2025 07:04:08 -1000
> > > Linus Torvalds <torvalds@linuxfoundation.org> wrote:
> > >
> > > > On Tue, 4 Mar 2025 at 22:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> > > > >
> > > > > Even to my surprise, the patch has some noticeable effects on the
> > > > > performance, please see the attachment in [1] for LMBench data or [2]
> > > > > for some excerpts from the data. So, I think the patch has potential
> > > > > to improve the performance.
> > > >
> > > > I suspect some of the performance difference - which looks
> > > > unexpectedly large - is due to having run them on a CPU with the
> > > > horrendous indirect return costs, and then inlining can make a huge
> > > > difference.
> > > ...
> > >
> > > Another possibility is that the processes are getting bounced around
> > > cpu in a slightly different way.
> > > An idle cpu might be running at 800MHz, run something that spins on it
> > > and the clock speed will soon jump to 4GHz.
> > > But if your 'spinning' process is migrated to a different cpu it starts
> > > again at 800MHz.
> > >
> > > (I had something where a fpga compile when from 12 mins to over 20 because
> > > the kernel RSB stuffing caused the scheduler to behave differently even
> > > though nothing was doing a lot of system calls.)
> > >
> > > All sorts of things can affect that - possibly even making some code faster!
> > >
> > > The (IIRC) 30k increase in code size will be a few functions being inlined.
> > > The bloat-o-meter might show which, and forcing a few inlines the same way
> > > should reduce that difference.
> >
> > bloat-o-meter is an excellent idea, I'll analyse binaries some more
> > and report my findings.
> 
> Please find attached bloat.txt where:
> 
> a) some functions now include once-called functions. These are:
> 
> copy_process                                6465   10191   +3726
> balance_dirty_pages_ratelimited_flags        237    2949   +2712
> icl_plane_update_noarm                      5800    7969   +2169
> samsung_input_mapping                       3375    5170   +1795
> ext4_do_update_inode.isra                      -    1526   +1526
> 
> that now include:
> 
> ext4_mark_iloc_dirty                        1735     106   -1629
> samsung_gamepad_input_mapping.isra          2046       -   -2046
> icl_program_input_csc                       2203       -   -2203
> copy_mm                                     2242       -   -2242
> balance_dirty_pages                         2657       -   -2657
> 
> b) ISRA [interprocedural scalar replacement of aggregates,
> interprocedural pass that removes unused function return values
> (turning functions returning a value which is never used into void
> functions) and removes unused function parameters.  It can also
> replace an aggregate parameter by a set of other parameters
> representing part of the original, turning those passed by reference
> into new ones which pass the value directly.]
> 
> ext4_do_update_inode.isra                      -    1526   +1526
> nfs4_begin_drain_session.isra                  -     249    +249
> nfs4_end_drain_session.isra                    -     168    +168
> __guc_action_register_multi_lrc_v70.isra     335     500    +165
> __i915_gem_free_objects.isra                   -     144    +144
> ...
> membarrier_register_private_expedited.isra     108       -    -108
> syncobj_eventfd_entry_func.isra              445     314    -131
> __ext4_sb_bread_gfp.isra                     140       -    -140
> class_preempt_notrace_destructor.isra        145       -    -145
> p9_fid_put.isra                              151       -    -151
> __mm_cid_try_get.isra                        238       -    -238
> membarrier_global_expedited.isra             294       -    -294
> mm_cid_get.isra                              295       -    -295
> samsung_gamepad_input_mapping.isra.cold      604       -    -604
> samsung_gamepad_input_mapping.isra          2046       -   -2046
> 
> c) different split points of hot/cold split that just move code around:
> 
> samsung_input_mapping.cold                   900    1500    +600
> __i915_request_reset.cold                    311     389     +78
> nfs_update_inode.cold                         77     153     +76
> __do_sys_swapon.cold                         404     455     +51
> copy_process.cold                              -      45     +45
> tg3_get_invariants.cold                       73     115     +42
> ...
> hibernate.cold                               671     643     -28
> copy_mm.cold                                  31       -     -31
> software_resume.cold                         249     207     -42
> io_poll_wake.cold                            106      54     -52
> samsung_gamepad_input_mapping.isra.cold      604       -    -604
> 
> c) full inline of small functions with locking insn (~150 cases).
> These bring in most of the performance increase because there is no
> call setup. E.g.:
> 
> 0000000000a50e10 <release_devnum>:
>   a50e10:    48 63 07                 movslq (%rdi),%rax
>   a50e13:    85 c0                    test   %eax,%eax
>   a50e15:    7e 10                    jle    a50e27 <release_devnum+0x17>
>   a50e17:    48 8b 4f 50              mov    0x50(%rdi),%rcx
>   a50e1b:    f0 48 0f b3 41 50        lock btr %rax,0x50(%rcx)
>   a50e21:    c7 07 ff ff ff ff        movl   $0xffffffff,(%rdi)
>   a50e27:    e9 00 00 00 00           jmp    a50e2c <release_devnum+0x1c>
>             a50e28: R_X86_64_PLT32    __x86_return_thunk-0x4
>   a50e2c:    0f 1f 40 00              nopl   0x0(%rax)
> 
> IMO, for 0.14% code increase, these changes are desirable.

I concur, and it's extra desirable IMHO due to the per function 
overhead of CPU bug mitigations like retpolines.

The number of function calls executed in a workload can be measured via 
perf on most modern x86 CPUs as well. For example on Zen5 CPUs the 
number of RET instructions can be counted:

  {
    EventName: ex_ret_near_ret,
    EventCode: 0xc8,
    BriefDescription: Retired near returns (RET or RET Iw).
  },

Which ought to be a good proxy for function calls (modulo 
tail-optimized jumps).

Thanks,

	Ingo

