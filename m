Return-Path: <linux-kernel+bounces-548967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D3A54B87
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220D81897CAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1320C005;
	Thu,  6 Mar 2025 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjV95Odn"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93D209F44
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266433; cv=none; b=WCo4FPUHAwQnIpO1mIE0zq4buP9XEaXy12XaK1Mflz22v/wYcXkmIStJ4yHmZIZminzd9gqFSHseEe/MzSkSx0chkNP6/Xr6F0/1cq08u3wFRTouv7u4ehk8UGUnJmpzC2Hpkg6DgdrhbMGBnQ5FVMS62W4bwxkxhYfqLiKsoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266433; c=relaxed/simple;
	bh=izxWAABTxo4N4U3TqRmpgPhzKRqunJun4BLbtGNwvGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHTx9kE3G15GqdkvSI9LJcXLjsh5zK4n+faGHoJT8jMPxJCpl96ynticHIpj56T0VHTP+EynZ8bMya5KngQDMTSv7bctSmmLRyY3GoL7CVdyoO98QJmFG56m+VYhXUDONMZVD4aCEF9nxf18nary4A7uefNZq4HBYH4IjdgrgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjV95Odn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bee1cb370so3194511fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741266430; x=1741871230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=myuXgVECo4O2ZkDnkBbhrEnRJL/mdeDLITjn96+P1/Q=;
        b=DjV95OdnaItxY4gG+G0bDY+Z0L9WGqQkqP46ZbwlE0OR91nms+MZObYCK7e4X8EM0q
         s7+7ZesjqtRg+OSQvFWXUMj9eqNdzzjmd4sqXK66bswUzSANV1OpZN9dLhbPBV9UD6Hr
         Z8MCu+XSGNphpGfoo6Vq4Akzw01ys+27085e/nYpVzCPo9t0kg15z81S3apFMG1BQZJn
         bliQwav9ofdxU7FPT39X+CgBqSz2z5mkS1FOD79ZsC2Dk944ht0KqUT11Twpten5A5BX
         sORlSrVA+YVNcB3uiroh0XDqsZOGqLDaTv+/of67G8P3Mbb7O9jb8ds6/aZYthLUAxyK
         jzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741266430; x=1741871230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myuXgVECo4O2ZkDnkBbhrEnRJL/mdeDLITjn96+P1/Q=;
        b=vyXvufktYJflGoM1+S2RVEZwGTQnPtHKGCCg6I1WxcLwE9G6JplALJGIPt9DSCpUGI
         b0978cVNJqnBPpqe3hkgXm1Qe9mwzdr3BWh87wVqKdbX0+kA0ywYLeoLlaeuHuFczXSg
         6blhkDlyQmL/m/v0Og5VTeVfn2rvEtQigN5p6eVD2ODMHeg8SpPFTJ23vWqOu3i0ZWbU
         fFwCPhqxsB/kR8KMKjip2zjqaT0uw0Qr5JgiH1LXqoQvf3+1T+qX1M3AxtarCk3YXBV6
         +uR26FwCUmHrC5Ia6EDdPNpzfi0oHKGJdgeJTnb4LChMVSEvoxI6IrMwxsZYOcd7hF4O
         dOgg==
X-Forwarded-Encrypted: i=1; AJvYcCWxTStIyX/L6OqOAbm+B1VlvTW/uJtIVFOZ4QRD4kf4rnlYqha+RH9tQjq+oZNFfGi6m3SDeHizGlP4Mok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLkml/5lfomrs4ove4P3adZDbcmxyts6E82MSiBqTE5JYJlfa
	0ip8MGiSCc/4g1o7xaHpKLZ815NFmp8TSzl9Q/HdE2FOq9w5YvEebmk4Ow++8SieEEuaqDi58t0
	mFshPVy5V2xsya++POjlzZ2BjorY=
X-Gm-Gg: ASbGnctQhigA2c40HF9JErGtHE5iOtawA2b6aZSMXN2kuT5kTKpVhVnDKJWxEt4nwOW
	JVS+UY4c6ZXtYQA/rp2HnMehSEvQZecjfSgi8rD4OJrg9lt8LxTlSjIBtWCCjipoCRfNsZI3m6V
	BWzwxVA6hj03ND6ovPCxAqlHDZ+Q==
X-Google-Smtp-Source: AGHT+IF7bBJbF/hWNRKNCu7w09jPNVzUf2hh+YlLeSJGlRciSMz+2YBSjHgTrtBR5yHkAo7Q0dKxtazSzLSZFJOAWxA=
X-Received: by 2002:a2e:be05:0:b0:30b:b852:2f85 with SMTP id
 38308e7fff4ca-30bd7a3dbd6mr29421121fa.13.1741266427832; Thu, 06 Mar 2025
 05:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com>
 <20250305201429.3026ba9f@pumpkin> <CAFULd4ZzdPcnQAELpukF4vzUnQufteNqV4BzZr3BxuzRG+XK+A@mail.gmail.com>
In-Reply-To: <CAFULd4ZzdPcnQAELpukF4vzUnQufteNqV4BzZr3BxuzRG+XK+A@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Mar 2025 14:07:03 +0100
X-Gm-Features: AQ5f1JrlRQjZIa5q5CrhOnHxZazA1o4c5jytE_iTxxGK68aYJNqsl9PQ__iHgCU
Message-ID: <CAFULd4Yuhb-BbV9LAJ+edMRGEi2kTYfcq70=TTMaSXP3oxwfQQ@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: multipart/mixed; boundary="000000000000e446aa062fac2e8a"

--000000000000e446aa062fac2e8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:45=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Wed, Mar 5, 2025 at 9:14=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Wed, 5 Mar 2025 07:04:08 -1000
> > Linus Torvalds <torvalds@linuxfoundation.org> wrote:
> >
> > > On Tue, 4 Mar 2025 at 22:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> > > >
> > > > Even to my surprise, the patch has some noticeable effects on the
> > > > performance, please see the attachment in [1] for LMBench data or [=
2]
> > > > for some excerpts from the data. So, I think the patch has potentia=
l
> > > > to improve the performance.
> > >
> > > I suspect some of the performance difference - which looks
> > > unexpectedly large - is due to having run them on a CPU with the
> > > horrendous indirect return costs, and then inlining can make a huge
> > > difference.
> > ...
> >
> > Another possibility is that the processes are getting bounced around
> > cpu in a slightly different way.
> > An idle cpu might be running at 800MHz, run something that spins on it
> > and the clock speed will soon jump to 4GHz.
> > But if your 'spinning' process is migrated to a different cpu it starts
> > again at 800MHz.
> >
> > (I had something where a fpga compile when from 12 mins to over 20 beca=
use
> > the kernel RSB stuffing caused the scheduler to behave differently even
> > though nothing was doing a lot of system calls.)
> >
> > All sorts of things can affect that - possibly even making some code fa=
ster!
> >
> > The (IIRC) 30k increase in code size will be a few functions being inli=
ned.
> > The bloat-o-meter might show which, and forcing a few inlines the same =
way
> > should reduce that difference.
>
> bloat-o-meter is an excellent idea, I'll analyse binaries some more
> and report my findings.

Please find attached bloat.txt where:

a) some functions now include once-called functions. These are:

copy_process                                6465   10191   +3726
balance_dirty_pages_ratelimited_flags        237    2949   +2712
icl_plane_update_noarm                      5800    7969   +2169
samsung_input_mapping                       3375    5170   +1795
ext4_do_update_inode.isra                      -    1526   +1526

that now include:

ext4_mark_iloc_dirty                        1735     106   -1629
samsung_gamepad_input_mapping.isra          2046       -   -2046
icl_program_input_csc                       2203       -   -2203
copy_mm                                     2242       -   -2242
balance_dirty_pages                         2657       -   -2657

b) ISRA [interprocedural scalar replacement of aggregates,
interprocedural pass that removes unused function return values
(turning functions returning a value which is never used into void
functions) and removes unused function parameters.  It can also
replace an aggregate parameter by a set of other parameters
representing part of the original, turning those passed by reference
into new ones which pass the value directly.]

ext4_do_update_inode.isra                      -    1526   +1526
nfs4_begin_drain_session.isra                  -     249    +249
nfs4_end_drain_session.isra                    -     168    +168
__guc_action_register_multi_lrc_v70.isra     335     500    +165
__i915_gem_free_objects.isra                   -     144    +144
...
membarrier_register_private_expedited.isra     108       -    -108
syncobj_eventfd_entry_func.isra              445     314    -131
__ext4_sb_bread_gfp.isra                     140       -    -140
class_preempt_notrace_destructor.isra        145       -    -145
p9_fid_put.isra                              151       -    -151
__mm_cid_try_get.isra                        238       -    -238
membarrier_global_expedited.isra             294       -    -294
mm_cid_get.isra                              295       -    -295
samsung_gamepad_input_mapping.isra.cold      604       -    -604
samsung_gamepad_input_mapping.isra          2046       -   -2046

c) different split points of hot/cold split that just move code around:

samsung_input_mapping.cold                   900    1500    +600
__i915_request_reset.cold                    311     389     +78
nfs_update_inode.cold                         77     153     +76
__do_sys_swapon.cold                         404     455     +51
copy_process.cold                              -      45     +45
tg3_get_invariants.cold                       73     115     +42
...
hibernate.cold                               671     643     -28
copy_mm.cold                                  31       -     -31
software_resume.cold                         249     207     -42
io_poll_wake.cold                            106      54     -52
samsung_gamepad_input_mapping.isra.cold      604       -    -604

c) full inline of small functions with locking insn (~150 cases).
These bring in most of the performance increase because there is no
call setup. E.g.:

0000000000a50e10 <release_devnum>:
  a50e10:    48 63 07                 movslq (%rdi),%rax
  a50e13:    85 c0                    test   %eax,%eax
  a50e15:    7e 10                    jle    a50e27 <release_devnum+0x17>
  a50e17:    48 8b 4f 50              mov    0x50(%rdi),%rcx
  a50e1b:    f0 48 0f b3 41 50        lock btr %rax,0x50(%rcx)
  a50e21:    c7 07 ff ff ff ff        movl   $0xffffffff,(%rdi)
  a50e27:    e9 00 00 00 00           jmp    a50e2c <release_devnum+0x1c>
            a50e28: R_X86_64_PLT32    __x86_return_thunk-0x4
  a50e2c:    0f 1f 40 00              nopl   0x0(%rax)

IMO, for 0.14% code increase, these changes are desirable.

Thanks,
Uros.

--000000000000e446aa062fac2e8a
Content-Type: application/x-xz; name="bloat.txt.xz"
Content-Disposition: attachment; filename="bloat.txt.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_m7xc71xi0>
X-Attachment-Id: f_m7xc71xi0

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
9rEGnsSt0bHEZ/sCAAAAAARZWg==
--000000000000e446aa062fac2e8a--

