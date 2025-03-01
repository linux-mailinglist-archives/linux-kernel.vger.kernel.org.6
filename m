Return-Path: <linux-kernel+bounces-539850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EADDA4A9E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14E067AA706
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C171C5D79;
	Sat,  1 Mar 2025 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXJ1eOGu"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39871A317C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740819960; cv=none; b=e5MjtOW59oG3Gbf3sLVUNKWfw5p09r18/i16kYxa9WzgUi6bRXu95PhUThnXZ/T9Sk28JnPSMUfSw+8feY5JjDF9sOt5iJAOBEvesvdbZqXLg+Do4x/E253U864q5DslzTfGgFMKlsuhltdQ4dnWh1rKCGbP5zsi6AItMBtw+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740819960; c=relaxed/simple;
	bh=1PxuCO5m03ueYu2+f2xDHAB1PjA0h8RGsA23gtoYqno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STksDaafmsKizgI1r/SaSlWF+sWRR+SD9H+WoCb/LRxrwxSAP5NcJR2V3nZQxPeWckpVlnHQ1T8dlg5arJmUzzQEw87fSYpkLa8ClhVc/73VSHPkwrqxHX/F5YvuTQ5wy8Z5WXqNAhwCJGpE1qy/2XLKPHCa8zC1bE24KkwEyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXJ1eOGu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so29223621fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 01:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740819957; x=1741424757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXFzqgX4NRG3gCXz7PgzcgJLn75U3QR8MBIw9FMuNWQ=;
        b=IXJ1eOGupMRz+T5MY3+9NbPixSefIjk4FevgIy5KMljMOSmu4/UdBBk+VCCBIKUi6c
         7CKlS97JZ6Q8zRMIxJC/XmcPANp6512AXsRfdUdG2VnvkWaOtfjP+EEh5avkS/0sgorv
         589hFKlXV3xYhsXhPTr90cLFuU7ARKPbnz3RVxf5WyXu+fwVNd/OlQhCMxnwLrmLhGp1
         heNalX0v65u/9BFDUgncJVHhvBmcdbPwvWi9mXi4di/GWSUvgLsZyZkSxy/+0FtArX9b
         K/NVywGItJu3YbuBIunXAVKQROyYeyK7DcjBYQ4QpdhCF/s97lL0IZ4T3myHXUo64WIN
         KHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740819957; x=1741424757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXFzqgX4NRG3gCXz7PgzcgJLn75U3QR8MBIw9FMuNWQ=;
        b=Jsq2mB1PxPOo9X1x2buvTIah6Sp4K0u2YNO3nv/DO6hewdxdlhd4fl4UTeI1pweWHN
         EqXyU5ToerRUv0Z3o9kTs7xklo7a1Kj03hWcOCBf8D2YsTKU6EZTH4LHWHP4qdqrYWhH
         P8VAZSc9kyKWlizPnGZUe8JC/nOKDqJSP17cwM828mQYOgD8nf8Yk0i2oae50hTO1X2F
         9WwkFhlxI0X86BSjL8TjW6lUlYSOmtK4vce7yC5QMJ93CB3JfKjpm/QivmWAoUz2N1Cl
         78Qh9Rk3I6eLsJBl5VR64L3Mo/aVKbTmjNXo2IwAQy2ibi8KzlS3FdhkJaoU/OYJsjzQ
         wAlw==
X-Forwarded-Encrypted: i=1; AJvYcCUbKWjNF1CNmnW9OmGGGH1EFSECVKI2dgXzapoWrwRs6xNmmSkOck/Igs6Ez8YQwkKo1YO6H/Q0zGQ2Bx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvbNhoExEKAGaikMhB6tOrNvUp87pLdRRFfbR2gbQh0sIuh0l
	2azUYn+sOF/2n3gERkjy+Grn07QVuRE4RBSyaUdI5oZg4dVVS7aT6nyXchrf7yc9egqAs0vPQlQ
	tsKh3akaSsdNR0BM6YcavWS1Td+M=
X-Gm-Gg: ASbGncsXe+05TuVYaDstOXjPgAt1c4z7zKPT6uMYk5wRLfL3rCkMu9d+vqIzPruDA97
	Lxteai2Jkl/73Nf68pLt9vYVxBQttZaBqdJ/o4ydZ9pwgJO5l0dm12E36GmA+hakGMLGfwKmKWO
	wzfdAhncDmGKYYMrCCV3VmMUb2CA==
X-Google-Smtp-Source: AGHT+IEfr2ALblo6ivzHzVxryVhL2Y6DvxdWA+1rUutSX56BH3/164bb0YM5U0fvsd39WgPksoB3amqN9ZEPRiyrlEk=
X-Received: by 2002:a05:651c:501:b0:308:f75f:457 with SMTP id
 38308e7fff4ca-30b9322fd96mr22270111fa.12.1740819956669; Sat, 01 Mar 2025
 01:05:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com> <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
In-Reply-To: <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 1 Mar 2025 10:05:56 +0100
X-Gm-Features: AQ5f1JroxjHaZHeLCcl3c8W5zsMU1FzNdQrLNCSclG0JFHgf944aIZJVtNsB34o
Message-ID: <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 11:58=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 2/28/25 14:31, Uros Bizjak wrote:
> > On Fri, Feb 28, 2025 at 5:48=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> >>
> >> On 2/28/25 04:35, Uros Bizjak wrote:
> >>> The code size of the resulting x86_64 defconfig object file increases
> >>> for 33.264 kbytes, representing 1.2% code size increase:
> >>>
> >>>    text    data     bss     dec     hex filename
> >>> 27450107        4633332  814148 32897587        1f5fa33 vmlinux-old.o
> >>> 27483371        4633784  814148 32931303        1f67de7 vmlinux-new.o
> >>
> >> So, first of all, thank you for including some objective measurement o=
f
> >> the impact if your patches. It's much appreciated.
> >>
> >> But I think the patches need to come with a solid theory of why they'r=
e
> >> good. The minimum bar for that, I think, is *some* kind of actual
> >> real-world performance test. I'm not picky. Just *something* that spen=
ds
> >> a lot of time in the kernel and ideally where a profile points at some
> >> of the code you're poking here.
> >>
> >> I'm seriously not picky: will-it-scale, lmbench, dbench, kernel
> >> compiles. *ANYTHING*. *ANY* hardware. Run it on your laptop.
> >>
> >> But performance patches need to come with performance *numbers*.
> >
> > I don't consider this patch a performance patch, it is more a patch
> > that fixes a correctness issue. The compiler estimates the number of
> > instructions in the asm template wrong, so the patch instructs the
> > compiler that everything in the template in fact results in a single
> > instruction, no matter the pseudos there. The correct estimation then
> > allows the compiler to do its job better (e.g. better scheduling,
> > better inlining decisions, etc...).
>
> Why does it matter if the compiler does its job better?

Please read the long thread [1], especially part [1.1], that was the
reason for gcc to implement asm inline [2].

[1] https://lore.kernel.org/lkml/20181003213100.189959-1-namit@vmware.com/
[1.1] https://lore.kernel.org/lkml/20181007091805.GA30687@zn.tnic/
[2] https://gcc.gnu.org/pipermail/gcc-patches/2018-December/512349.html

Accurate inline decisions are just one of compiler optimizations that
depend on code growth factor, tail duplication [3] is another one,
there are also code hoisting, function cloning, block reordering,
basic block copying, to name a few from the top of my head.

[3] https://gcc.gnu.org/projects/sched-treegion.html

These all work better with accurate input data. These optimizations
are also the reason for 1% code growth with -O2: additional code
blocks now fall under the code size threshold that enables the
mentioned optimizations, under the assumption of -O2 code
size/performance tradeoffs. OTOH, -Os, where different code
size/performance heuristics are used, now performs better w.r.t code
size.

Uros.

