Return-Path: <linux-kernel+bounces-548660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE5A547BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14B571717E2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B721FF1AA;
	Thu,  6 Mar 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5CuOfBa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1D2045B3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256791; cv=none; b=agHWTbcsDH1nfidxf70TD5Ra8alns7oR6XI2hddu5w3XcJ8Pd91POz8iFzI14goTRwZcrAFHXEEs6WUgvxX/eJii5G14uDONRNlrYTQBrYrFOqqYLKxtCMhTWGeslSTgAogAx9/prdIpFYjQzynjSsAorlUhaNtgZUfa83it4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256791; c=relaxed/simple;
	bh=Q787s2jxv5/doHm4t4IS5WZIRkquH7vzfqhFs/eXB6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=noSEblNNPu4ucL4qtBzt3sgSvBUeEf59ujzKIS3qzK9/YVljLcbIWIQiJvfhb4qLTgHiK99L5hNakJfAhKlyPwlLJlfXLYMGHTuKRverPsRUtlWIjnPgElGkMKW/C7aat6S3mqoOZTeh9jC+mJ8yl3F3aV+KDdMDzVYeFVtrQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5CuOfBa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bef9b04adso1354091fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256787; x=1741861587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRnObQE+R8un9VECwDH+tyqY1gqdoZYjRs7SdMb9/N0=;
        b=m5CuOfBapgV86tccDjJdeNI7+LUoVuf/Fn/IHqe4YBAIZjA4/0t8EaCrCwuoCIExav
         C0o9T7nSDH4F7OYmlLLa1DVv9FHTi3XHi+2ql9g1LKPI4ZTdqnUVMCzjrJbWpWipuuxM
         0cZJ653KpRMz9K1QOsPfkuoJtSgJ5wf6VogGURATWMx1ttJ+3306rlZz6tKU6j52sJ8H
         x2jFhwCaqTugDphdgULu1PucIzdGwUm6NWAlrdwhsdwKgsjQJ0GGImq4V49fCUy+X63j
         gbIjn3GNzK9lrPbJIu9Dju8xfbLdP21MPSZrBKzImjIo48ORhPqx0knpQNSHaVvOS35H
         YZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256787; x=1741861587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRnObQE+R8un9VECwDH+tyqY1gqdoZYjRs7SdMb9/N0=;
        b=b+REpobB8RwnCZBjV7m6Z9uq0TdvTvDUe7BTTpjJjHkdSCxpHeiuYrZKDAmQjcGzHd
         fGPXSJBco76oyQ2Z1zq7eRYXjevtBIb5aO28yExMKSKORmFkfcFR976AWS9YeWMJPAHn
         w+Y665rtegcB5ufTtfsfVhcqRITjVLLvN5XaWGU96ZAKeNVpSvB0zK5TJHVmX1tqmv9y
         9M9ZVWNcHDo29kX3+3hZ0uL0NSXTiV0+SH/QaV6Mts08D21oD0PG8IOkMgp82Vx9LOpF
         +WeeRzVdOdc539fmnC5jbd3m9zKTiyXN7qkMaRYD/iHH4bjRUB3ICwD5hvbKNSBvqfxb
         DtTw==
X-Forwarded-Encrypted: i=1; AJvYcCXV+FfiQqJKSZZSXVUG6cdRT8px3ry7TxHIjAy1G5x1PMCodE97N58AKVRvgFPOY7hiDn8QZuL7q7kvTFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBavWj+Do9/7rZEwooY8Kw6nxR7UqtGOvQZGqzLpe1ZaWFy2Xi
	ooeJnrF5SPh5j/eLUSFdO4FqzT1ieQ4iXcR9X7kOfh9AjpONtY8ElEG0p7yxAWp0Pte8fI60qs8
	4DCo+KtzFF/gIFCOcSCeufOV/EZI=
X-Gm-Gg: ASbGnctpovlDVKD2gzBG/pcSXO3AgSSXkQl4NDa2UFKxogsst+fWnDJ49HUf++U+zc5
	fR/BEJGaVQQu83j3mD7fsZs5GP1qsA5jCSUmaqsoBZBoQQZsr5gDgDGF47dF/B81TzPb6wBlFFi
	XO8AuLHz3nEunZKy2hmyPstaF3NA==
X-Google-Smtp-Source: AGHT+IGAsNCDn6n0yHd242dn2pz21t5FG/+kN2IDMd6J3ZZ9Nm+HnHfGw8cjCC+lZ6Lj0Ir4AHMvTC2Fd6oi1nj6oQ8=
X-Received: by 2002:a2e:be28:0:b0:30b:c3ce:ea1f with SMTP id
 38308e7fff4ca-30bd7a4f39fmr22187001fa.15.1741256786884; Thu, 06 Mar 2025
 02:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <Z8lxmPmnJhBmPRvl@gmail.com>
In-Reply-To: <Z8lxmPmnJhBmPRvl@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Mar 2025 11:26:24 +0100
X-Gm-Features: AQ5f1Jo2M9Tiz0S5Ub9c6p5p90XCD_rydruAqVEoywNXh7VkKI_AsCqiS3HkZqk
Message-ID: <CAFULd4btTdUrF6fTqafyViuaB+V8QD-s0pLE6XWb7BYzYAPmZA@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 10:57=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > According to:
> >
> >   https://gcc.gnu.org/onlinedocs/gcc/Size-of-an-asm.html
> >
> > the usage of asm pseudo directives in the asm template can confuse
> > the compiler to wrongly estimate the size of the generated
> > code.
> >
> > The LOCK_PREFIX macro expands to several asm pseudo directives, so
> > its usage in atomic locking insns causes instruction length estimate
> > to fail significantly (the specially instrumented compiler reports
> > the estimated length of these asm templates to be 6 instructions long).
> >
> > This incorrect estimate further causes unoptimal inlining decisions,
> > unoptimal instruction scheduling and unoptimal code block alignments
> > for functions that use these locking primitives.
> >
> > Use asm_inline instead:
> >
> >   https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html
> >
> > which is a feature that makes GCC pretend some inline assembler code
> > is tiny (while it would think it is huge), instead of just asm.
> >
> > For code size estimation, the size of the asm is then taken as
> > the minimum size of one instruction, ignoring how many instructions
> > compiler thinks it is.
> >
> > The code size of the resulting x86_64 defconfig object file increases
> > for 33.264 kbytes, representing 1.2% code size increase:
> >
> >    text    data     bss     dec     hex filename
> > 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> > 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
> >
> > mainly due to different inlining decisions of -O2 build.
>
> So my request here would be not more benchmark figures (I don't think
> it's a realistic expectation for contributors to be able to measure
> much of an effect with such a type of change, let alone be certain
> what a macro or micro-benchmark measures is causally connected with
> the patch), but I'd like to ask for some qualitative analysis on the
> code generation side:
>
>  - +1.2% code size increase is a lot, especially if it's under the
>    default build flags of the kernel. Where does the extra code come
>    from?
>
>  - Is there any effect on Clang? Are its inlining decisions around
>    these asm() statements comparable, worse/better?

Bah, apparently I can't calculate... the code increase is in fact
0.14%, but still 33k.

bloat-o-meter shows top grows (> 500 bytes):

add/remove: 82/283 grow/shrink: 870/372 up/down: 76272/-43618 (32654)
Function                                     old     new   delta
copy_process                                6465   10191   +3726
balance_dirty_pages_ratelimited_flags        237    2949   +2712
icl_plane_update_noarm                      5800    7969   +2169
samsung_input_mapping                       3375    5170   +1795
ext4_do_update_inode.isra                      -    1526   +1526
__schedule                                  2416    3472   +1056
__i915_vma_resource_unhold                     -     946    +946
sched_mm_cid_after_execve                    175    1097    +922
__do_sys_membarrier                            -     862    +862
filemap_fault                               2666    3462    +796
nl80211_send_wiphy                         11185   11874    +689
samsung_input_mapping.cold                   900    1500    +600
virtio_gpu_queue_fenced_ctrl_buffer          839    1410    +571
ilk_update_pipe_csc                         1201    1735    +534
enable_step                                    -     525    +525
icl_color_commit_noarm                      1334    1847    +513
tg3_read_bc_ver                                -     501    +501

and top shrinks ( < 500 bytes):

nl80211_send_iftype_data                     580       -    -580
samsung_gamepad_input_mapping.isra.cold      604       -    -604
virtio_gpu_queue_ctrl_sgs                    724       -    -724
tg3_get_invariants                          9218    8376    -842
__i915_vma_resource_unhold.part              899       -    -899
ext4_mark_iloc_dirty                        1735     106   -1629
samsung_gamepad_input_mapping.isra          2046       -   -2046
icl_program_input_csc                       2203       -   -2203
copy_mm                                     2242       -   -2242
balance_dirty_pages                         2657       -   -2657
Total: Before=3D22770320, After=3D22802974, chg +0.14%

> A couple of concrete examples would go a long way:
>
>  - "Function XXX was inlined 3 times before the patch, and it was
>     inlined 30 times after the patch. I have reviewed two such inlining
>     locations, and they have added more code to unlikely or
>     failure-handling branches collected near the function epilogue,
>     while the fast-path of the function was more optimal."
>
> Or you might end up finding:
>
>  - "Function YYY was inlined 3x more frequently after the patch, but
>     the inlining decision increased register pressure and created less
>     optimal code in the fast-path, increasing both code size and likely
>     decreasing fast-path performance."
>
> Obviously we'd be sad about the second case, but it's well within the
> spectrum of possibilities when we look at "+1.2% object code size
> increase".
>
> What we cannot do is to throw up our hands and claim "-O2 trades
> performance for size, and thus this patch improves performance".
> We don't know that for sure and 30 years of kernel development
> created a love-and-hate relationship and a fair level of distrust
> between kernel developers and compiler inlining decisions,
> especially around x86 asm() statements ...
>
> So these are roughly the high level requirements around such patches.
> Does this make sense?

In my opinion, the writing above makes perfect sense. As far as I'm
concerned, I'm able and can do the above code analysis, the
problematic part would be precise performance measurements. Although
with your instructions, I can also try that.

Thanks,
Uros.

