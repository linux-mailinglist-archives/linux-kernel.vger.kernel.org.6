Return-Path: <linux-kernel+bounces-552351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36935A578E2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076213B2457
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85069183CCA;
	Sat,  8 Mar 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGjsx5x+"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C5B15382E
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741418566; cv=none; b=qGNAn4JAeTrXeVJqPoENc9ZCghx3jbuT9pfZJW+x0NoZbudgZ0wGzUPmSMuPf8rTdNq3eNNJYLtfqo4penn34kTkP3Q316Yo9UJZqnpKW3G/iwqnUw1yefRT92U9dlT2tvYqLLTCZUir6c4xV4IYT7sl8Y0KoYxmmnE3Ni7I8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741418566; c=relaxed/simple;
	bh=Al6AWqwfdo7eRqqCvn1VeWB1PJzel0+sICEjd32iZjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzEIr1k6ePCE77bk6eD+4/1lxeJWOvxU06Hs6PIte1eG/aOFkpbs+oHVhDzgujVXpGTg30ULvIki6ugi10ferfMkMgmzvJnw4suMuk+hPMiTKI/m08GtdKreLRW1JlvNJNvZyu2au93lE9lCFRkIqJoDvUzI5Z8AL0pGDqKgXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGjsx5x+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3061513d353so29064061fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 23:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741418562; x=1742023362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Prhk3Z2Ao6RE1RwSeTidg3bPn/ii2KnJBCu54q4WXE=;
        b=VGjsx5x+TFa7IOgUfp6jXrWn0BJLD+Xyf7LLfeiGorMmQskkCitRbPo64yrMPG1o+S
         S6PLLhZfandsOgcGjvVmy74uF8+cwVSrOz7VaAwl3rbWJQ+u/MsMdqul6RqcF1tbTaYw
         9q8HIo48XEEzUgQ0Z3MXdgrBPNaIuZpSvegji+6fk7Ia+pMISQR83twZpqXmOPxqOdqe
         7exMiHcmaTaa6vBWco8x8+BJPIcFbNeoknuyK+JPU5HVa+bMqOC+lGSK3ZJLmILaXo4v
         DNmfV+tTsObJ8N9BAxSZTNMbSKrv7OicKxg1+oIuU8w7jlIBhNCTqcA7lMzTh+d/bjBJ
         QYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741418562; x=1742023362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Prhk3Z2Ao6RE1RwSeTidg3bPn/ii2KnJBCu54q4WXE=;
        b=FdslbcQaVTvYyZAf/6JKM0XcwXfvA7JeSsvgLxcS5b+uMSaH6OXjACJ+7A0BUy3Kno
         7E2bXFTJ0Rxqb9DRxSEQHyCq8rBbd6K730gcArvYCtz6JuWHZkOwn2QICz4bcAg+MV0s
         B3IcTmzDwOFpX6WFpsBhOM3qrZmkOmVbv3jPoeTEH4/c0sFrltVmluEuXnw4HKcK0u8R
         mUxkU8DGb8h1MRWyZSqPk2KbG8xLPomFTaURNSRDw+dIPv+XFnqlwMgFaAlAGZsXAd96
         BaGV/oJfp63zg7C8fwWwL6BOE2waITX7YdEcgzJZhjqc5i9oyR0XZAyFFtACR24cbgJR
         Dldw==
X-Forwarded-Encrypted: i=1; AJvYcCUcKrXAhHuV4XEmhWERduuerr21yeWCspkQVA+BPrUncC5dmobRNevEnq+OYizIQAEmKe3hy6VJeAX2y/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIGvY8ArG8cc+BVADYM/NUMjZouLp11lSBD4fL+Ff18v0ymRP
	zBvafrpMEmO7rlcLZkgsnIPvBOBPLXL51EaKbNjSTVObbJFPyzlN0/ujPdu55XyqMZIQ7CsNXBZ
	WqklLkdzV5g01NUAd/vA9ETFk87k=
X-Gm-Gg: ASbGncvUabmobMJ8KvFOUYBQYW7Ei3Bw4Ho4SCXUOuD7hjmqjP0SweFFzmbv2RH8cJt
	XBIutpWrx1vCK/SrjH9+pJR2suJqiadI3Y29WD3u+CEuXEvl89ZPpZKS083wwsAR5mlHSpr5MXI
	o4uMJDZuFyZEtXJebRuKk6kiHDZUKZbwY8hSX0
X-Google-Smtp-Source: AGHT+IExJQI9E7A/e/ZpHPeVhyWvLaEYWpDGKCL0AUBkn47frgmmwvm55ai73pYbGbuOX32lXAju7FuqmQWiClPMjzs=
X-Received: by 2002:a2e:be84:0:b0:30b:fd7a:22e9 with SMTP id
 38308e7fff4ca-30bfd7a2457mr9179411fa.13.1741418561537; Fri, 07 Mar 2025
 23:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
 <20250305201429.3026ba9f@pumpkin> <CAFULd4ZzdPcnQAELpukF4vzUnQufteNqV4BzZr3BxuzRG+XK+A@mail.gmail.com>
 <CAFULd4Yuhb-BbV9LAJ+edMRGEi2kTYfcq70=TTMaSXP3oxwfQQ@mail.gmail.com> <Z8ofYTR9nou2650h@gmail.com>
In-Reply-To: <Z8ofYTR9nou2650h@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 8 Mar 2025 08:22:31 +0100
X-Gm-Features: AQ5f1JqMtqeoywImI7JHCuvtAc2W9q0iGnzovT-MVZdUCDm1xGbyGhtCaHgHDvM
Message-ID: <CAFULd4YubNt7vUV2T3McHJb-L4X-Vh=e3QbM7W2i71uRg=J_8Q@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Ingo Molnar <mingo@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Linus Torvalds <torvalds@linuxfoundation.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:19=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Thu, Mar 6, 2025 at 11:45=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
> > >
> > > On Wed, Mar 5, 2025 at 9:14=E2=80=AFPM David Laight
> > > <david.laight.linux@gmail.com> wrote:
> > > >
> > > > On Wed, 5 Mar 2025 07:04:08 -1000
> > > > Linus Torvalds <torvalds@linuxfoundation.org> wrote:
> > > >
> > > > > On Tue, 4 Mar 2025 at 22:54, Uros Bizjak <ubizjak@gmail.com> wrot=
e:
> > > > > >
> > > > > > Even to my surprise, the patch has some noticeable effects on t=
he
> > > > > > performance, please see the attachment in [1] for LMBench data =
or [2]
> > > > > > for some excerpts from the data. So, I think the patch has pote=
ntial
> > > > > > to improve the performance.
> > > > >
> > > > > I suspect some of the performance difference - which looks
> > > > > unexpectedly large - is due to having run them on a CPU with the
> > > > > horrendous indirect return costs, and then inlining can make a hu=
ge
> > > > > difference.
> > > > ...
> > > >
> > > > Another possibility is that the processes are getting bounced aroun=
d
> > > > cpu in a slightly different way.
> > > > An idle cpu might be running at 800MHz, run something that spins on=
 it
> > > > and the clock speed will soon jump to 4GHz.
> > > > But if your 'spinning' process is migrated to a different cpu it st=
arts
> > > > again at 800MHz.
> > > >
> > > > (I had something where a fpga compile when from 12 mins to over 20 =
because
> > > > the kernel RSB stuffing caused the scheduler to behave differently =
even
> > > > though nothing was doing a lot of system calls.)
> > > >
> > > > All sorts of things can affect that - possibly even making some cod=
e faster!
> > > >
> > > > The (IIRC) 30k increase in code size will be a few functions being =
inlined.
> > > > The bloat-o-meter might show which, and forcing a few inlines the s=
ame way
> > > > should reduce that difference.
> > >
> > > bloat-o-meter is an excellent idea, I'll analyse binaries some more
> > > and report my findings.
> >
> > Please find attached bloat.txt where:
> >
> > a) some functions now include once-called functions. These are:
> >
> > copy_process                                6465   10191   +3726
> > balance_dirty_pages_ratelimited_flags        237    2949   +2712
> > icl_plane_update_noarm                      5800    7969   +2169
> > samsung_input_mapping                       3375    5170   +1795
> > ext4_do_update_inode.isra                      -    1526   +1526
> >
> > that now include:
> >
> > ext4_mark_iloc_dirty                        1735     106   -1629
> > samsung_gamepad_input_mapping.isra          2046       -   -2046
> > icl_program_input_csc                       2203       -   -2203
> > copy_mm                                     2242       -   -2242
> > balance_dirty_pages                         2657       -   -2657
> >
> > b) ISRA [interprocedural scalar replacement of aggregates,
> > interprocedural pass that removes unused function return values
> > (turning functions returning a value which is never used into void
> > functions) and removes unused function parameters.  It can also
> > replace an aggregate parameter by a set of other parameters
> > representing part of the original, turning those passed by reference
> > into new ones which pass the value directly.]
> >
> > ext4_do_update_inode.isra                      -    1526   +1526
> > nfs4_begin_drain_session.isra                  -     249    +249
> > nfs4_end_drain_session.isra                    -     168    +168
> > __guc_action_register_multi_lrc_v70.isra     335     500    +165
> > __i915_gem_free_objects.isra                   -     144    +144
> > ...
> > membarrier_register_private_expedited.isra     108       -    -108
> > syncobj_eventfd_entry_func.isra              445     314    -131
> > __ext4_sb_bread_gfp.isra                     140       -    -140
> > class_preempt_notrace_destructor.isra        145       -    -145
> > p9_fid_put.isra                              151       -    -151
> > __mm_cid_try_get.isra                        238       -    -238
> > membarrier_global_expedited.isra             294       -    -294
> > mm_cid_get.isra                              295       -    -295
> > samsung_gamepad_input_mapping.isra.cold      604       -    -604
> > samsung_gamepad_input_mapping.isra          2046       -   -2046
> >
> > c) different split points of hot/cold split that just move code around:
> >
> > samsung_input_mapping.cold                   900    1500    +600
> > __i915_request_reset.cold                    311     389     +78
> > nfs_update_inode.cold                         77     153     +76
> > __do_sys_swapon.cold                         404     455     +51
> > copy_process.cold                              -      45     +45
> > tg3_get_invariants.cold                       73     115     +42
> > ...
> > hibernate.cold                               671     643     -28
> > copy_mm.cold                                  31       -     -31
> > software_resume.cold                         249     207     -42
> > io_poll_wake.cold                            106      54     -52
> > samsung_gamepad_input_mapping.isra.cold      604       -    -604
> >
> > c) full inline of small functions with locking insn (~150 cases).
> > These bring in most of the performance increase because there is no
> > call setup. E.g.:
> >
> > 0000000000a50e10 <release_devnum>:
> >   a50e10:    48 63 07                 movslq (%rdi),%rax
> >   a50e13:    85 c0                    test   %eax,%eax
> >   a50e15:    7e 10                    jle    a50e27 <release_devnum+0x1=
7>
> >   a50e17:    48 8b 4f 50              mov    0x50(%rdi),%rcx
> >   a50e1b:    f0 48 0f b3 41 50        lock btr %rax,0x50(%rcx)
> >   a50e21:    c7 07 ff ff ff ff        movl   $0xffffffff,(%rdi)
> >   a50e27:    e9 00 00 00 00           jmp    a50e2c <release_devnum+0x1=
c>
> >             a50e28: R_X86_64_PLT32    __x86_return_thunk-0x4
> >   a50e2c:    0f 1f 40 00              nopl   0x0(%rax)
> >
> > IMO, for 0.14% code increase, these changes are desirable.
>
> I concur, and it's extra desirable IMHO due to the per function
> overhead of CPU bug mitigations like retpolines.

Thanks!

I will submit a v2 patch next week that will summarize all the
measurements in its commit message.

BR,
Uros.

