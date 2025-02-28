Return-Path: <linux-kernel+bounces-537845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87821A491BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F933A4E12
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE80A23DE;
	Fri, 28 Feb 2025 06:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ibuJJn3L"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552EB1C3C12
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724909; cv=none; b=molDC4FTMN6Z25eT+y8CQJ46E4GAAR8/CxQI8rY17Zi7XhxltpbeVHbJVHjcnRtnMMsqxNgrQUHlvM8jEt/GJGadBv9Vc1ZPGXCLBiO4pVDwSL2Sc/5vOUHwRqIecUebyJcYtJXr9K2HsRnR8uYy73FUh1hhkROAt+KZLS8DBlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724909; c=relaxed/simple;
	bh=rOwz0bKAjFmlNM797gz5jWGgjA7j0+HQsWD2YlawAKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXFaRuErTJfiZFHIH2+HK7QeHPxhBOjGIgkjoends5cW2+6qXBnBwIwWkevG2NvCbwFEuH+x8xrDDvMwQwEhq6wsKJa99C+9nssOmt4ZKHMC7u3H0bfeeYDtQQiWlTcDHYg0cSH33o4D4GU0OgJE6NHOcIGgzaffNOZ5F04xWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ibuJJn3L; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so1513333fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740724905; x=1741329705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEgij+vFUKJr4iFrcQiCT4KMIk6Vb5FvOpq9/ONScgg=;
        b=ibuJJn3LvrA+6zO51lOJMvh6FD2cIVu760xg9Xytnr7stRBOl1dMtMUnUTzdSt4eNW
         jQ/rnBp9fC6NtZJo7oR/vHoXbDab/aeY6FC8C1g1l/Ziq5Duf8miX15bXkrzcoT1a4Ma
         bPSQtUltCdIxoqpjvBS5GS+N0SraSAfASPwS/Lt1rWXKuP3afs3LZn+Bmt/YAYLWyg3D
         bWeWuE0z4LCuBrxxMj7W0fkqry+N1LIkb4/MBRceeypFBxbu66nMnhmYV2UWETR3TYbq
         pDlbWsFxh+mNhYKkXl8cc8cFLNqj453Hhl3cZ3I3E1y1v0OT91Uf6T/0fhHN/rzjPvU7
         4lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740724905; x=1741329705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEgij+vFUKJr4iFrcQiCT4KMIk6Vb5FvOpq9/ONScgg=;
        b=wYcjgElkMgW2ucEZo/XejYvevgUlePZ9Uw11143Awb/uVYhIo9VMjTzJOp42mtUhvy
         yep92TOVW0E4ao/zxeTzGydRg5JlvipttwR/+6jJDHUz2m7maBSwOdCFtFKonzMitenw
         uDYZIpHLxyf1DqFWsUBUkRwSTlBXqTbACUn1dV5898vXgcoS2zjYYnu1E05NiCU35KuY
         Gc7Mhrw6vu0eV+75FuNGJ+tT2Fguq1+k/6bS5GgnZHi9Uvkq2vyUEdkWXNxlRxIPhV2+
         dl8e255B5f6YiXw5Vpsa4WduabBOCn/9w/v5nZtCmXZW3r/F4waDGBJma/LDv6Dx7S+n
         G8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVX9VJ9aqGUf0t4KW19VB/j6ICzsFTFJ6Dc4ZiT7Gdy5ByIZNP1TiSyNu83otnMM2b8392AIcRPaA2jgH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9CCcn/BvdKVWPi4Ymr0wP/1yLQm+u/UyXCpyiWc3Vp8sbY5De
	Fj8CkWQc8+gnfFQyFOHjmhsJO0icACvwgizgNcSZufdzKvmD2kelq/G0lpEhB5XFfceMqoKWNwe
	TGXVaaRKllIcoXcVFvepJv16W5q2IJ8MhapUfcg==
X-Gm-Gg: ASbGncu4E3RIZp4y8fITF+ZkLIuV2upu10GMsylU+jJE2h6p6xCwIIgz+d024wUi4LN
	4wYKmTQ2eb54fbHe/K9ovTgKkAJ0ptZdOC6O1xvYeELsDtDQPMGVk0SIhrXOgqVJuGgMPg1d1lG
	oabtXiyQQbf8HkNMVnxU2zSzP0
X-Google-Smtp-Source: AGHT+IGpsWGXU4pi9mwh3NHOtEFtRPpdEJclCzQQN3B727Qh8UvZFHsiuMJ2yff1nT/VAt/UJKc28gLWXxaF0LPMHi0=
X-Received: by 2002:a05:6871:521f:b0:2bc:7d6f:fa85 with SMTP id
 586e51a60fabf-2c178381b32mr1335889fac.16.1740724905127; Thu, 27 Feb 2025
 22:41:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201110607.34766-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=uYad7UAedSU4M_L277v=RQGWHpJQwOW-p7W6=hcijsQ@mail.gmail.com> <CAHVXubhW9b6fw8ZvHtn7zmyRSUVt-3JjmFbE-_L42wZ9W6=vKA@mail.gmail.com>
In-Reply-To: <CAHVXubhW9b6fw8ZvHtn7zmyRSUVt-3JjmFbE-_L42wZ9W6=vKA@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 28 Feb 2025 14:41:34 +0800
X-Gm-Features: AQ5f1Joi8eei6BIPpr2-NDt1LLv0lzxhe-reOSOYQ5fHESUpc5vKkKxs7O0Ed-8
Message-ID: <CAEEQ3wmAxF=PkRt_pKFZE5-r9w1SMY7YQtco2mCyE+vus7vufg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: print hartid on bringup
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: apatel@ventanamicro.com, atishp@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com, 
	jassisinghbrar@gmail.com, takakura@valinux.co.jp, 
	valentina.fernandezalanis@microchip.com, ruanjinjie@huawei.com, 
	charlie@rivosinc.com, conor.dooley@microchip.com, haibo1.xu@intel.com, 
	andybnac@gmail.com, ke.zhao@shingroup.cn, tglx@linutronix.de, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Wed, Feb 26, 2025 at 10:58=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosin=
c.com> wrote:
>
> Hi Yunhui,
>
> On Thu, Feb 20, 2025 at 1:54=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi All,
> >
> > Gentle ping. Any comments on this patch?
> >
> > On Sat, Feb 1, 2025 at 7:06=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.=
com> wrote:
> > >
> > > Firmware randomly releases cores, so CPU numbers don't linearly map
> > > to hartids. When the system has an exception, we care more about hart=
ids.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  arch/riscv/kernel/smp.c     | 2 ++
> > >  arch/riscv/kernel/smpboot.c | 4 ++++
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > > index d58b5e751286..e650dec44817 100644
> > > --- a/arch/riscv/kernel/smp.c
> > > +++ b/arch/riscv/kernel/smp.c
> > > @@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
> > >  void __init smp_setup_processor_id(void)
> > >  {
> > >         cpuid_to_hartid_map(0) =3D boot_cpu_hartid;
> > > +
> > > +       pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
> > >  }
> > >
> > >  static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
> > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.=
c
> > > index e36d20205bd7..beba0efb00b9 100644
> > > --- a/arch/riscv/kernel/smpboot.c
> > > +++ b/arch/riscv/kernel/smpboot.c
> > > @@ -231,6 +231,10 @@ asmlinkage __visible void smp_callin(void)
> > >         riscv_ipi_enable();
> > >
> > >         numa_add_cpu(curr_cpuid);
> > > +
> > > +       pr_info("CPU%u: Booted secondary hartid %lu\n", curr_cpuid,
> > > +               cpuid_to_hartid_map(curr_cpuid));
> > > +
> > >         set_cpu_online(curr_cpuid, true);
> > >
> > >         /*
> > > --
> > > 2.39.2
> > >
> >
> > Thanks,
> > Yunhui
>
> IIRC that's a debug feature when you can't reach userspace and use
> cpuinfo, so what about using pr_debug() instead?

Using pr_debug needs enabling #define DEBUG in
arch/riscv/kernel/smpboot.c and adding loglevel=3D8 to cmdline, not
convenient. Can't always cat /proc/cpuinfo before running in user
mode.
It's true that pr_info prints a large amount of information in the
startup logs, especially when there are many CPU cores.

Do you have a better solution?


> Thanks,
>
> Alex

Thanks,
Yunhui

