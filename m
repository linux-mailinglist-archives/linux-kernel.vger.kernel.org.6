Return-Path: <linux-kernel+bounces-537986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 137C2A49342
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2543B4AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409F8243361;
	Fri, 28 Feb 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="j2zJvDuA"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C560B24291B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730751; cv=none; b=cKWcN/3SzCm/y0AFludPs0uhX3Q9iG0X6i0SAxKu3/q8+DmSmvuSVK7ixaHgPKX2aAWYaCXTyWdCDl+zg4bJXKe+9H8VvQJjghHw1Gm7k2tD1wJhS3XMWBh6XhonLYrSo8jCPPgfDTeKnpFijf7wjF1vAuAM0s2xYLTiolwXxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730751; c=relaxed/simple;
	bh=mYTvRMi3XAXTzqIuEW/y+stOUydMv7mTp+kVUp8C8PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1Mr69KH7FwpMBk2M78D/FzdupRgfCzW0aLaKPVqfFB5eEwABzGCQRmkfkn9CypSiQf6Dc9i9OIdzL9ZWBLQAAZq+z/5fAyVaXby+zClqCCLVsy/AdnOimlQ0Upvs0SR2redT9boi7FKQSiwJE5GLk0BfsdiMYX0FshBmZ/rHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=j2zJvDuA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abec8c122e4so270593166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740730747; x=1741335547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mNzmCKCn4datV8rE5qzgrGyKzfo222+OSdPHcKzM/s=;
        b=j2zJvDuArc3fEi4lCjCnOqQOueweLIItQwgqlwKj7s718ZTuyW3kMObPhBy6Lgaez3
         +2Td3Ar4rjHFRySJ43DZ1E1aosOvCxo4Ng2/wjIBwGZlguByXRi7T9ZGIwU7NfTj1sbz
         NLCESspWQS4sFf7LKC2llDfNbLrQ4CQ0PYlvvMXcp16Bge13RAAeKfHG+nY0dvcOyuS0
         6D8j0ox1FFBwKPn80qWZwPanSz28PNExeuV32HV6kQ/R6yDnw+uMfeb4kFhIpTdLwnQD
         eyxuV9m7Lqqx7UU+UyziAkNPvlCRazs8enf2YpYacNz/bdkDWWiLQ6TX6GX3NcE+HGLE
         sqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730747; x=1741335547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mNzmCKCn4datV8rE5qzgrGyKzfo222+OSdPHcKzM/s=;
        b=hE1sBUyuvObUGfxE6DjQm3kNLE/pNt+wHdGfjZVHrDKWcSud8vbdpQYBafetlnLx8H
         PV5/8yjWE4CKRuXulQB1POWCtkcwwukvK5sqXqFV1qgoPP4dTbz+G8CgzA+3kUN1vZ8s
         6ZPrxWleQypMg185EWC6cbQeZreFYix7kg28yJ8hM+JHMW+znxCo+XLzrR6TniHRSGu3
         4sLUuxH/gkxXyfkqcC9/MGstwshagZwAlQtX/CA8ggvf8FqWUNQnKmgWT/sw2WgPTJcm
         IQGMrbxKopEGXD6DzoJrkdHheoE6KPkLuwH40LcrIcTdg4JfBtuUFt4Tlmqtp+FkeOyI
         fXqA==
X-Forwarded-Encrypted: i=1; AJvYcCW4phcBsISQ3I/8Pdnz73SGlHiFa1Sdwq+u+r7NR6JVlH5sJ1C5ZpQRQD+GsRoD9kIOOwMs1zqylBEK8Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9lCi1nCmUWpdS1xmM4b2c/8BfZaM6Ovj/apW5kISpj8Sl5tR
	tsVdWgEzavL7772KtfMpS8Ryi8CrDtqiorYCd9PfTaNXj4ezBa85Ko7Pk9ZgJhvV6m1WrSCaYRq
	px73Gl+Oec/kb+gnuoNC1gvmM3iafA81nN6VsJw==
X-Gm-Gg: ASbGnctZGEYjOUwOaFRXMl/6oks94nWjRMwG2DGELDueo2hWZ7RruNkdjIgkzJ3Jp5X
	W76QE1Jk91JHr66J5AltlnLJdGilEAI/mCXGIcEnAxPU4cwDQ5sn1rilck7d8c6y8X3Zt7hhBgq
	+EIhjqjeH/CoCHA43QCFEzNZmnlMCO2sTw+TbhQGN3
X-Google-Smtp-Source: AGHT+IENK/26em6Ix/yYp3BQmPoOySQZ6t1Xtb6uiXx+8qhDO/pnk1OtnSnDwrVQfBQRQAUyVwHKwgBYuKumJyaIPds=
X-Received: by 2002:a17:906:4fcc:b0:abb:b1a4:b0fd with SMTP id
 a640c23a62f3a-abf25d94a3fmr267670466b.7.1740730746898; Fri, 28 Feb 2025
 00:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201110607.34766-1-cuiyunhui@bytedance.com>
 <CAEEQ3w=uYad7UAedSU4M_L277v=RQGWHpJQwOW-p7W6=hcijsQ@mail.gmail.com>
 <CAHVXubhW9b6fw8ZvHtn7zmyRSUVt-3JjmFbE-_L42wZ9W6=vKA@mail.gmail.com> <CAEEQ3wmAxF=PkRt_pKFZE5-r9w1SMY7YQtco2mCyE+vus7vufg@mail.gmail.com>
In-Reply-To: <CAEEQ3wmAxF=PkRt_pKFZE5-r9w1SMY7YQtco2mCyE+vus7vufg@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 28 Feb 2025 09:18:54 +0100
X-Gm-Features: AQ5f1JqLrnn4zA3maJFolHaNKWgFyB_WiJOveyerVjOOUMTPfnxW0XKkfqKcFtQ
Message-ID: <CAHVXubiHhDgC4=T7xCxK9hoCG7R2KZ46LRPmS8rgYuT7EiQDcg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: print hartid on bringup
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: apatel@ventanamicro.com, atishp@rivosinc.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, samuel.holland@sifive.com, 
	jassisinghbrar@gmail.com, takakura@valinux.co.jp, 
	valentina.fernandezalanis@microchip.com, ruanjinjie@huawei.com, 
	charlie@rivosinc.com, conor.dooley@microchip.com, haibo1.xu@intel.com, 
	andybnac@gmail.com, ke.zhao@shingroup.cn, tglx@linutronix.de, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunhui,

On Fri, Feb 28, 2025 at 7:41=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Alex,
>
> On Wed, Feb 26, 2025 at 10:58=E2=80=AFPM Alexandre Ghiti <alexghiti@rivos=
inc.com> wrote:
> >
> > Hi Yunhui,
> >
> > On Thu, Feb 20, 2025 at 1:54=E2=80=AFPM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi All,
> > >
> > > Gentle ping. Any comments on this patch?
> > >
> > > On Sat, Feb 1, 2025 at 7:06=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedanc=
e.com> wrote:
> > > >
> > > > Firmware randomly releases cores, so CPU numbers don't linearly map
> > > > to hartids. When the system has an exception, we care more about ha=
rtids.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  arch/riscv/kernel/smp.c     | 2 ++
> > > >  arch/riscv/kernel/smpboot.c | 4 ++++
> > > >  2 files changed, 6 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > > > index d58b5e751286..e650dec44817 100644
> > > > --- a/arch/riscv/kernel/smp.c
> > > > +++ b/arch/riscv/kernel/smp.c
> > > > @@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
> > > >  void __init smp_setup_processor_id(void)
> > > >  {
> > > >         cpuid_to_hartid_map(0) =3D boot_cpu_hartid;
> > > > +
> > > > +       pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
> > > >  }
> > > >
> > > >  static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
> > > > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboo=
t.c
> > > > index e36d20205bd7..beba0efb00b9 100644
> > > > --- a/arch/riscv/kernel/smpboot.c
> > > > +++ b/arch/riscv/kernel/smpboot.c
> > > > @@ -231,6 +231,10 @@ asmlinkage __visible void smp_callin(void)
> > > >         riscv_ipi_enable();
> > > >
> > > >         numa_add_cpu(curr_cpuid);
> > > > +
> > > > +       pr_info("CPU%u: Booted secondary hartid %lu\n", curr_cpuid,
> > > > +               cpuid_to_hartid_map(curr_cpuid));
> > > > +
> > > >         set_cpu_online(curr_cpuid, true);
> > > >
> > > >         /*
> > > > --
> > > > 2.39.2
> > > >
> > >
> > > Thanks,
> > > Yunhui
> >
> > IIRC that's a debug feature when you can't reach userspace and use
> > cpuinfo, so what about using pr_debug() instead?
>
> Using pr_debug needs enabling #define DEBUG in
> arch/riscv/kernel/smpboot.c and adding loglevel=3D8 to cmdline, not
> convenient.

You can also use a kernel command line parameter to enable a
pr_debug() statement
https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html=
#debug-messages-during-boot-process

Alex

> Can't always cat /proc/cpuinfo before running in user
> mode.
> It's true that pr_info prints a large amount of information in the
> startup logs, especially when there are many CPU cores.
>
> Do you have a better solution?
>
>
> > Thanks,
> >
> > Alex
>
> Thanks,
> Yunhui

