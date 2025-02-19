Return-Path: <linux-kernel+bounces-520816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A78A3AF98
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 03:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CBE16E308
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67E1714B2;
	Wed, 19 Feb 2025 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5CRiE0b"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2875809
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 02:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932120; cv=none; b=cNIg+efCMEix+8OY+NtcWqy9UmE3PIJI2o+u32IOaZWEF63qsP5yD8AX4DrTuLyYXY75UF2LynExR4hMou9xAd07tf94wTHkk8bF2EwDe7IVUV4AYOwTM9RiMlP90SkksCkaIloQoFp/IGuyCyBf3aT5ky2ysdzDpRsXgmYjtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932120; c=relaxed/simple;
	bh=xRkf75KrxuUQ9K90xa5R80hKcvMFSLcOnrsPNIoAC6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qrne3zIz3+QFjEDHsjGf50Ky2N6iRV6WAd2WaQaF3XadFGY7mok3UvgPFMauYRMvEMA66ZtMzqvPbtUmeQaooXNHmMUQfTmKWMl38hEC6jkCkwLEJx4lQe0Ds2bQZ8wwvoVnMK+WCgGW8DJkh9BA2prxRPGRZY8nD+oygiyUcPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5CRiE0b; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86911fd168dso1112784241.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739932117; x=1740536917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXPY7rWbpeUpriAscqIJDG8UJsQKnDvVVsHqtrBynO0=;
        b=Q5CRiE0bRHiY56/ZNc3IskcmGEUw+c2i8ojZtzJ4ZKpq/xAwRgiuetZBF/irwMj11O
         6+cTKSzGhdn7TkK2IF91LVl7uj2ihzCJbc3Icg6AJtOeXuNZaR9GdMh+UR0UzgHWd1Pm
         rXU7hYx5jl/e5dxEcoZQ3Tqu+fyQI9l8rCNOgfS0yuBG4K9dzVIf4FxR5rdBIgVp2gpm
         vhe7XE3DyfojZ9rhcpquA6XNJkRaRrdxQvEKUb2ZQkPDJPxrbM7tcrB+1zag57jv7qLQ
         pVV0gCD3r0ge4QCdFnTSh+wY+HaR5YLcBFYQyRA4iZTbL1rIfZnWp+zTpHyMGq7uVths
         blkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739932117; x=1740536917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXPY7rWbpeUpriAscqIJDG8UJsQKnDvVVsHqtrBynO0=;
        b=Uea65lAUIKZuNuBm7hHxaHkTanGBD1IBrbgpnDi2gNeiCDkLGltYLtMfYaBGvtOkll
         OLOdCdVDVZdOZjE7VihFw2FMQ4T2m1sdlNQ/caeI7aFEN1p4wHA2EJI+ldo2EslPnwOC
         H8p533tHzV/GEtRYXyNoPRokbsiO249GN5rzr5GwpK/w6ZMRCSIwrxWeD4wQm3kP5aNo
         39l6FZDtVHXOQ77mvMMc9l1bZ9UQioGY7VkKvQkE8DgN65XARxS7SBjXvwqckJVyUXVI
         1iOSWxRbKSLz4/ALIfGtX1K3yirsdeQO8YOid766CojxUIrrGTmJ63H1s2BRiwuRQWcH
         8NwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjcJQ9WG42Bb0eOPdMVBBXurES66EVMDuSMFRc2sji0amtv467+1cAT2BRujlnF4lt26ruECtBdJEaclo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfa7SbvEalqYegepX4RXbGgHH89UO2fPMzOFRmbAiYDc+0uXeN
	PoUQ4KYcbMHfsYAJiwwj3ydJXFWmn7dXroB0EmCYY6EOcikxmVeRz8O/eNerIU/T4UzYg5IN8rY
	c5P3q0V8Q3YWrgvQSzuLcRQcX1t8=
X-Gm-Gg: ASbGncv46gEIoR3Cn84gBvfuYdpyTqPuD+1ZnIEsl7s5iWbA4HgfNauvSPhM/g1Jbs/
	piEzxqTcE4GMdi+SHJApNSSAcUAiUwfLUChSeNMk06zFLYeiRbA+T35ctWf2Y1UU0Pcsg+WuA
X-Google-Smtp-Source: AGHT+IEhKBc5OFNenjs0BGxnXjDhGPkuBB0OFNsfn7bHnxD7CXQ+/fJXM4wXUmmZYjQ9KgkZUqv3aO/WHOVWl6tYD88=
X-Received: by 2002:a05:6102:e09:b0:4bb:5d61:1288 with SMTP id
 ada2fe7eead31-4be85cede85mr1281142137.23.1739932116865; Tue, 18 Feb 2025
 18:28:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e223b0e6ba2f4924984b1917cc717bd5@honor.com>
In-Reply-To: <e223b0e6ba2f4924984b1917cc717bd5@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 19 Feb 2025 15:28:26 +1300
X-Gm-Features: AWEUYZlRIQVzDzqFW8MzrsssQIcBMPqFq_NuOf0yff_RVp2B746KBILEs0x4wVM
Message-ID: <CAGsJ_4y9eoHRSUSzs96UWUVygEDcoTQqFM1uyEtr_VHcmAmVDw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Fix possible NULL pointer dereference in __swap_duplicate
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:56=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> Add a NULL check on the return value of swp_swap_info in __swap_duplicate
> to prevent crashes caused by NULL pointer dereference.
>
> The reason why swp_swap_info() returns NULL is unclear; it may be due to
> CPU cache issues or DDR bit flips. The probability of this issue is very
> small, and the stack info we encountered is as follows=EF=BC=9A
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000058
> [RB/E]rb_sreason_str_set: sreason_str set null_pointer
> Mem abort info:
>   ESR =3D 0x0000000096000005
>   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>   SET =3D 0, FnV =3D 0
>   EA =3D 0, S1PTW =3D 0
>   FSC =3D 0x05: level 1 translation fault
> Data abort info:
>   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
>   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
>   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000008a80e5000
> [0000000000000058] pgd=3D0000000000000000, p4d=3D0000000000000000,
> pud=3D0000000000000000
> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> Skip md ftrace buffer dump for: 0x1609e0
> ...
> pc : swap_duplicate+0x44/0x164
> lr : copy_page_range+0x508/0x1e78
> sp : ffffffc0f2a699e0
> x29: ffffffc0f2a699e0 x28: ffffff8a5b28d388 x27: ffffff8b06603388
> x26: ffffffdf7291fe70 x25: 0000000000000006 x24: 0000000000100073
> x23: 00000000002d2d2f x22: 0000000000000008 x21: 0000000000000000
> x20: 00000000002d2d2f x19: 18000000002d2d2f x18: ffffffdf726faec0
> x17: 0000000000000000 x16: 0010000000000001 x15: 0040000000000001
> x14: 0400000000000001 x13: ff7ffffffffffb7f x12: ffeffffffffffbff
> x11: ffffff8a5c7e1898 x10: 0000000000000018 x9 : 0000000000000006
> x8 : 1800000000000000 x7 : 0000000000000000 x6 : ffffff8057c01f10
> x5 : 000000000000a318 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000006daf200000 x1 : 0000000000000001 x0 : 18000000002d2d2f
> Call trace:
>  swap_duplicate+0x44/0x164
>  copy_page_range+0x508/0x1e78
>  copy_process+0x1278/0x21cc
>  kernel_clone+0x90/0x438
>  __arm64_sys_clone+0x5c/0x8c
>  invoke_syscall+0x58/0x110
>  do_el0_svc+0x8c/0xe0
>  el0_svc+0x38/0x9c
>  el0t_64_sync_handler+0x44/0xec
>  el0t_64_sync+0x1a8/0x1ac
> Code: 9139c35a 71006f3f 54000568 f8797b55 (f9402ea8)
> ---[ end trace 0000000000000000 ]---
> Kernel panic - not syncing: Oops: Fatal exception
> SMP: stopping secondary CPUs
>
> The patch seems to only provide a workaround, but there are no more
> effective software solutions to handle the bit flips problem. This path
> will change the issue from a system crash to a process exception, thereby
> reducing the impact on the entire machine.
>
> Signed-off-by: gao xu <gaoxu2@honor.com>

Regardless of whether the above statement is 100% accurate or whether
a bit-flip actually exists, providing this check still seems useful,
at least for
defensive programming.

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
> v1 -> v2:
> - Add WARN_ON_ONCE.
> - update the commit info.
> v2 -> v3: Delete the review tags (This is my issue, and I apologize).
> V3 -> v4: Add swap entry logging per Barry Song's suggestion.
> ---
>  mm/swapfile.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 7448a3876..403df1817 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3521,6 +3521,10 @@ static int __swap_duplicate(swp_entry_t entry, uns=
igned char usage, int nr)
>         int err, i;
>
>         si =3D swp_swap_info(entry);
> +       if (WARN_ON_ONCE(!si)) {
> +               pr_err("%s%08lx\n", Bad_file, entry.val);
> +               return -EINVAL;
> +       }
>
>         offset =3D swp_offset(entry);
>         VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> --
> 2.17.1

