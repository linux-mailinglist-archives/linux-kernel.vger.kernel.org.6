Return-Path: <linux-kernel+bounces-437702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821119E9743
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A64283E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA4B1A23B3;
	Mon,  9 Dec 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zr7Uplrv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431001A23AC
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751368; cv=none; b=HF3YNPOhFNLz++yM211Ro5bk/sTyTPKcld4IbWZI9/4JvPdwvBaF276JheRRaYRT6fQ2uiJLiWRcv/wrmwlYBA6ruSMYqP0CvVQlVUnA9cNnID/YUuduD96UXVab4T3bfB6j20Ota/qi3Rh6ahDDUr5fJcY2kwcFrDqORB+zvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751368; c=relaxed/simple;
	bh=FH0c1k5L/sC3t7tsIZpDPPuUO1rDfgsPKgJFYXi9hwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuIXkiQXFIu6s7wGWJRQGSyHCKiyKScKScs73Pw2fPnd6bndEBgJFSICFq03SIsh0MMA3pqDGEaKkhHBU8GVGHoIDCot90ETYzp6qKYp/c9gam13I1y0kSsqEr7cOO0kruzSBxk6K1ib3cpSZwirIidTjuWgbxiJIuAaRmQVyn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zr7Uplrv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso9538a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733751364; x=1734356164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8AMX1CrWxs9b9WMntFK4gIBgEsJoPuRvd4jSSSD+Mw=;
        b=Zr7UplrvpRGgUUUm6VYftELteyPwKXKOjnNbM9id0GDz2A2JQbcJWKdeDvs+sF0Pw/
         R1eyhHeWQRWhbu6W3054bqdB1Zh8ChLk2A0BWH6meS6J7vk4bze5bCb1cy2Nw+VVXxsO
         +UuFlr5PGCiB4om+U0Q8C0zigRkiAsNFXcBJaDRCcavXGAiiD+4OlKkityRi+6M5kdCl
         8idtPNVvUHPm9JvsTwkw2slyWO60NOnRGea/EmH25wL2K+QwINWMYZrarU42AYesoFLN
         0XmozX5++MzEYtKInhcgJzPQVW9KdF2eCFBNF5VPNKbKGeH4tYs2kF8fSZrBK1knQbZ1
         qDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751364; x=1734356164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8AMX1CrWxs9b9WMntFK4gIBgEsJoPuRvd4jSSSD+Mw=;
        b=jBaxcf6irLmiqF0eHzL4isoSo9ejRXHC2Ety3q/EOizgJVyXGWXyq/tGtQG6Drm+Wm
         nN33i5LaMh6vd7ojlNbcDJKCJAIZ251elcQR+C0NlyPrE1FuqTogqyUeM2BYbHvCp9xj
         yRvXaouJFOPC5oX7NpEPIlpD7ZcDMdRFTRTpCugnTWkKiCESExR+VC8HQjxAUTJDngPw
         ur4LXux50IBQ6/EJWxzuaErQ9M1Dv58+pEE47AbCzIhzZ3UXS27rIg76zu9o4ygWzD3z
         0V7ph4WfGWtzzZ8RGF3yeKJinJr1Pd6Fg1Dq+yEH3ted98EYEE2vkT4jwDwyDT7nad8S
         5JYg==
X-Forwarded-Encrypted: i=1; AJvYcCVQgodZHFtkYJSg20eGCcX+b5EQmx0ClIml2ixc7pL/LLhTAS30pGcCTnF+Q2CZu31B/tOTuB9iSAA3+vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfxhDmKqj2p5rWKPYpdbBOlf0yLyke4AodrW4K9FbsZy6qA/Z
	TE7ej4g1MFMxaNQwTPShjbun3iITlvK0yb6+O7fqPabj9nc4p9ggJa5RpVNezCD2h3DQH2tPq10
	IPBv7+OxfrhXSa3aAITsga4VQFgUvMbJjYWeY
X-Gm-Gg: ASbGncvuC/E2NQYNtqNbpj4AKdqdKFHJkOfnDd4bsoLutczr+AtW4Tq0C+WYfmbUUDz
	nuHfUuc2PPm5nehCeop5/uqOmA7zNSooNNNiOOsf9Vv9+lC34hZraPgImt2OQ5yA=
X-Google-Smtp-Source: AGHT+IFCJJrBYRb+4atBVSPqtwkf5YigKbUAY1wQHuD1b5CngmSuHFOQEzHvkxVkPn8OtOhQfbUVLEA6NjXlDEUAJek=
X-Received: by 2002:aa7:c507:0:b0:5d1:10a4:de9 with SMTP id
 4fb4d7f45d1cf-5d3dd9e9216mr133103a12.7.1733751364159; Mon, 09 Dec 2024
 05:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6756d273.050a0220.2477f.003d.GAE@google.com> <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
In-Reply-To: <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Dec 2024 14:35:27 +0100
Message-ID: <CAG48ez1mvwo1gjVstJDgFg=Q9uP7CXBk70MTQfHBwwWa5Nq9VA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] general protection fault in find_mergeable_anon_vma
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.=
ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f85fc0580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50c7a61469c=
e77e7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2d788f4f7cb66=
0dac4b7
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
>
> Points to this being racey.
>
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmli=
nux-feffde68.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb=
/bzImage-feffde68.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
>
> This doesn't make a huge amount of sense to me, the VMA is not 0x400 (1,0=
24)
> bytes in size... and the actual faulting offset seems to be 0xdffffc00000=
00080
> which is 0x80 off from some KASAN-specified value?

If you look at the disassembly, you can see this:

  13: 4d 89 ec              mov    %r13,%r12
  16: 49 c1 ec 03          shr    $0x3,%r12
  1a: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  21: fc ff df
* 24: 41 80 3c 04 00        cmpb   $0x0,(%r12,%rax,1) <-- trapping instruct=
ion

R13 is 0000000000000406, that's the address we're about to access.
This code is trying to read KASAN shadow memory for that address by
reading from 0xdffffc0000000000+address>>3, which for real kernel
addresses gives you an address in the "KASAN shadow memory" range (see
https://kernel.org/doc/html/latest/arch/x86/x86_64/mm.html), but for
addresses in the low half of the address space gives you non-canonical
addresses starting with 0xdfff that cause #GP on access.
The second line "KASAN: null-ptr-deref in range
[0x0000000000000400-0x0000000000000407]" is basically computed by
doing that calculation in reverse.

> This would be vma->vm_file. But that also doesn't really make any sense.
>
> But I wonder...
>
> I see in the report at [0] that there's a failure injection in vm_area_du=
p() on
> fork:
>
> [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> [   73.848496][ T5318]  should_failslab+0xac/0x100
> [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
>
> I also see in the fork logic we have the following code on error path:
>
>         mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
>         mas_store(&vmi.mas, XA_ZERO_ENTRY);
>
> And XA_ZERO_ENTRY is 0x406.

That matches...

