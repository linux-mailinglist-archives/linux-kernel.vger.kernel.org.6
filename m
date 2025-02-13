Return-Path: <linux-kernel+bounces-512150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237FA334DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C8C188A152
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69561139566;
	Thu, 13 Feb 2025 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS+/HSS/"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9E80034
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410911; cv=none; b=lcKKppHux2RSDfgNIV49+JOgWFcYaLVsqk/FsTmUPNOrZ30mihAeZVLgxpCO6MtuA9fysi0gJLGkoYm0eghkmPVPW+QPOGTgXCEgxAoohwu0JupvfFl6AIxWUvJLrbMEWbs6BjFRbrIkrX1RkFORjXVBm5j/DmEzi2Xpbrp8KPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410911; c=relaxed/simple;
	bh=gQWHuHIzwH7H+Q1hP8PU/ElLSpTs0VYw1fjTOlVg1rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUzVnBwns10SKN2SWvL9jmieJEhBjM61o3uJhAXO7VaxieCXoXIrqFMR5l9T0rHvbPyyFWjgJrgj9JDJJNTXaCNEsT6IAPWgSRJSo++bluNnpApo3zfj2EP5RVDDxeBNJRIz+1wBB4wdxWrN69Ha/A+jEuQHBZ736xUfX2T+8YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS+/HSS/; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0771a2f3bso29655285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739410909; x=1740015709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBkkofDUNVnQBz0KANHLmHlwBCnbPEtz1NoNEgOCwbw=;
        b=VS+/HSS/D7l/JPacEFRTPBmbzYJNCL9lwpGjDdXEwCIFT147CHS2ovBMxe8+9imymR
         5G/dmOhR66jyIIvlfMLflRghv4DvaEoTvK3vOKjZECkRF9RHCIuGUQRDnUn9PbffOIqw
         wdLnUDKBKsXSyZnwqiuH8ZmtmbQtFGEw3UfFfyn1xdDdAruSjNC950Ifp0k5mXQFCwqY
         ju/p5fLAUQlCqGRmZse5GsxcJ8BaJPyGxzwsnk+WP/fVmMqoCILh9O03vfz8dsgPZMf3
         cJHBp6+Rt7dEg7QSPZkbqUW4mf88SGSMryoEqrmovL1Tq7t0VCIMDxSWDi2tgdgY2s3+
         u0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739410909; x=1740015709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oBkkofDUNVnQBz0KANHLmHlwBCnbPEtz1NoNEgOCwbw=;
        b=iBWRLZeLhwhAWrmdvQsylTYywMnU7XV5XL5RU4+SzkcBpTJZFBtHrh511WuFprAJ0X
         fEHY/51zB2SnsFgtr5J2mv33QgqsemEIcD+MxfNfr2qFrodnxdAff7bcGmTMwrC1Vnh1
         fS5DeqLV5UzLEl77Q8GNyeziIYpZEaJ5dwz7hO4xPwrnAVE7SRCIPMUh49NAaUC3mzqr
         UcsQkZuusHAesE/pBZpnrklIu6x/1OJx+XkIe/K+YBHms9ebFoB43he5defOu+R8+5Vn
         1KToGAh+sa3+o9sMS+zMtRy+hOh0UyWoriInDTzT0sRzqe4Kote3eYMq90xtEeZidNYJ
         0vbA==
X-Forwarded-Encrypted: i=1; AJvYcCVhvK5wtxaDudNcEycsg9d32eOPJacOfx9mOZRcBH5AF8NV+qAdel7WjzGk5mYuhFvERwpj0pxWmMm42MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymDTO2Tiyzvc/H8z9DkH3aGWjTpQTCd3l8+mDcmoBbTCnX33qP
	x2QK/dwZx2HtsANW/CL4ddwWRKlWNZ9d8S2kTHyLmIby9MInJtnxjOwk2lVK0W3SVO3PDdOHY8n
	lVY/P7cwUd1ROyRBUegUb6t/ee9A=
X-Gm-Gg: ASbGnctyJBtXiRiDB1lRiid6SRojOOnU+tdsroEK08HB6PQ/VSSLVmF6NSwRJCGyQxa
	R5ll/ohLtkFC4kdpXny6S0Aw6V2uDuby4wWxZQarJJ5VpnI00NRymIp4S6kRDbSUjUgq7PKKbaZ
	s=
X-Google-Smtp-Source: AGHT+IHNxTk4hVF3BaGlxrxayEkmM0uOUHcr/QV/OUWyQBXPLs1qBfDT3QNk44lukQ9d3Hw+3K0H9itAG1VCJwdFhHA=
X-Received: by 2002:a05:6214:410:b0:6d8:9b20:64e8 with SMTP id
 6a1803df08f44-6e46ed82f7fmr100419916d6.10.1739410908721; Wed, 12 Feb 2025
 17:41:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <44655569e3a1419f800952004f07e714@honor.com>
In-Reply-To: <44655569e3a1419f800952004f07e714@honor.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 12 Feb 2025 17:41:37 -0800
X-Gm-Features: AWEUYZn4m9ca5J-5LnKUbK3SF7NbtB0puCi6HbqaGL_SFOpCyb685SEx4FK6oOk
Message-ID: <CAKEwX=NgTfnU8EzpPmC_h5mY1UePAPR6_W2rrBNGs3EZA96FsQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix possible NULL pointer dereference in __swap_duplicate
To: gaoxu <gaoxu2@honor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Barry Song <21cnbao@gmail.com>, yipengxiang <yipengxiang@honor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 7:14=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> swp_swap_info() may return null; it is necessary to check the return valu=
e
> to avoid NULL pointer dereference. The code for other calls to
> swp_swap_info() includes checks, and __swap_duplicate() should also
> include checks.
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

Yeah this smells like a bug. A bit strange though - I have eyeballed
the code, and we (should have?) locked the PTE before resolving it
into the swap entry format. Which should have been enough to prevent
the swap entry from being unmapped and freed up. Which should have
been enough to prevent swapoff...?

(are you even doing concurrent swapoff?)

Can you provide more context? What kernel version is this, what kind
of workload is this, any reproducer, etc.?

