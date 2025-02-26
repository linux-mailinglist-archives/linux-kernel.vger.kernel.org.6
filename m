Return-Path: <linux-kernel+bounces-534181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF583A463DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882A13B4507
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B82222C5;
	Wed, 26 Feb 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="upAD++MI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BD221732
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581892; cv=none; b=ufkSbxfJVs0Q7EZYq+6ruhKl0syZ1ZKeqiBx7NkUQN0A7EfdT/HC+YZ35cHVk/H3BpaKG65VvQkSbn4iVst/Cz9TvGjltzjnNz3zx8lPDGQOA+VG99PGbmWLN0Z9o9dH23m/9KnxpMfgPWy5P2KazLZn/LxlmD0ZaW5mDyyPB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581892; c=relaxed/simple;
	bh=3sDxMf9KpRehDKWhVmGfqFxLYxDYhusGFoK9M5P7Qq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQPYK+DeEFbo2K6VAUE0ScTikQDLdz31xh+f5rb6P2IfpW/a569OpJHaK4C9s5Gy0pDkMA2aFfvkruJnfjf33mBTwqAslMe9Qyxx11Zwg6w4OwjUHz8Z4a3nOA9irXHIrCkltufTCAqwKZRq9ofP7RXXsvrCSF9/MolV9PQ3W0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=upAD++MI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so11315594a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740581888; x=1741186688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Cx+xJGKu5N0JmZ2sR9g+qa3HIRq8K6zYLh9TIcwjV0=;
        b=upAD++MIswg7oIajataBNRtmPgyoI0dXMMwG2zKdTfugL/ItCD35wb5YEEYgml/gIH
         gGiZlhX7U6B1nDVxNzw8xfKDGLfVJs1T9Cf4rETSOdjmrNkadzeoqj/JPDGWxu/Ei4Al
         joGb06FWwpCgTjAGyPYrCrTjyaZ2gXtOUB/hx87cdyd0Jkzi2lowKE7D09RQZiTVE3Ft
         RZJwQT+p+Z1TmLphbZS9hLyARbjCbV33SvpOdfhPo6hIRUcBSoVFtg2oU+LCNyqm67gH
         2AI6YVo1LrElVfbUz+xksQHjKzpq0u/TfELSJiiDPWoY0yhCNgYS3qTK+5oAdojcW/j2
         VshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581888; x=1741186688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Cx+xJGKu5N0JmZ2sR9g+qa3HIRq8K6zYLh9TIcwjV0=;
        b=seITp5c1et/Rz0b5gCttstOvPefQCz/mtnXPdrZqPBtwsWLnsA6ppdAlc/WFCvqj9i
         CeWxd5YsOfyvBhhkGpumnjmcVWG59RurOH9p3VHNfiyBrcjZKt5eFh/anW7KjDdXdgYX
         xfF3RlMCGUf8fKs6o/0OFuXA5vullmKoH9DK5mlDunOv2oyR1u61cJiHXAD4WYyJx7kn
         op6xKim4EADDKNw4/UOcH6SYBM4MOFIlPyaGrEbtnC55IjmCpfgg60xqqF73JBaEDKt1
         zKVfQ4YunBsksxUryJ53SdsEo9bwFQjUbW407h7F6iLbUpC2TEx3Fl8+LIWF4Ojigbic
         qg4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiI4yJdiT2AXb1br1ZWIGFUbs4pGyRPM6wtwq0yuaFZdoKQGDafHBJSocsNQxlutXrOQjGpG95Ko/OH+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEeXTvrkT6Oym7yiL8JcWFjtHq9qRg6JdnxH2KUSyTScKpnxz
	ZxzJZlOm0FR+fL1jizYIQoaGrUr6TMzp8pHBM+dJny7npxzfOo45JjoAPVMhtjIf2gJEQEtwdLs
	LqvndKuHMbE3jgII6oaOJrVmY9bGrZvBWl+EoQQ==
X-Gm-Gg: ASbGncuwC32bsiEYw2tBHJMdmm1XoBw8SMYc6wOoy6beHy4P+pWU9DR/5zWhMc5+LZ0
	8NXsepZ1kmX3pIgXXGhAfaeMTjclq50/YkJtKReFnbtHsNmKwbuvkPKlcXysJRE0GFBBfLyF/YL
	HrfFoHJ3drjTsm7NCA6Ev/zTTQkljRo3sPx/gEDu/l
X-Google-Smtp-Source: AGHT+IE5KIbB4z+VdU6KvYCJ8GmmazCYgsdMxoVEY76uzggD9TD+2odB1KQGXMJsPgsKuEa+422vj8CyF4RJmBCfmf0=
X-Received: by 2002:a05:6402:34cc:b0:5dc:cfc5:9305 with SMTP id
 4fb4d7f45d1cf-5e4a0dfc8b9mr4917673a12.25.1740581888192; Wed, 26 Feb 2025
 06:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201110607.34766-1-cuiyunhui@bytedance.com> <CAEEQ3w=uYad7UAedSU4M_L277v=RQGWHpJQwOW-p7W6=hcijsQ@mail.gmail.com>
In-Reply-To: <CAEEQ3w=uYad7UAedSU4M_L277v=RQGWHpJQwOW-p7W6=hcijsQ@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 26 Feb 2025 15:57:56 +0100
X-Gm-Features: AQ5f1Jq3NwdOzWli4GS6uC6Juk-y-5UTRJ8pwcbzU1SmN5IAfAxHrxw4vEUMxl0
Message-ID: <CAHVXubhW9b6fw8ZvHtn7zmyRSUVt-3JjmFbE-_L42wZ9W6=vKA@mail.gmail.com>
Subject: Re: [PATCH] riscv: print hartid on bringup
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

On Thu, Feb 20, 2025 at 1:54=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi All,
>
> Gentle ping. Any comments on this patch?
>
> On Sat, Feb 1, 2025 at 7:06=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedance.co=
m> wrote:
> >
> > Firmware randomly releases cores, so CPU numbers don't linearly map
> > to hartids. When the system has an exception, we care more about hartid=
s.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/kernel/smp.c     | 2 ++
> >  arch/riscv/kernel/smpboot.c | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> > index d58b5e751286..e650dec44817 100644
> > --- a/arch/riscv/kernel/smp.c
> > +++ b/arch/riscv/kernel/smp.c
> > @@ -48,6 +48,8 @@ EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
> >  void __init smp_setup_processor_id(void)
> >  {
> >         cpuid_to_hartid_map(0) =3D boot_cpu_hartid;
> > +
> > +       pr_info("Booting Linux on hartid %lu\n", boot_cpu_hartid);
> >  }
> >
> >  static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index e36d20205bd7..beba0efb00b9 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -231,6 +231,10 @@ asmlinkage __visible void smp_callin(void)
> >         riscv_ipi_enable();
> >
> >         numa_add_cpu(curr_cpuid);
> > +
> > +       pr_info("CPU%u: Booted secondary hartid %lu\n", curr_cpuid,
> > +               cpuid_to_hartid_map(curr_cpuid));
> > +
> >         set_cpu_online(curr_cpuid, true);
> >
> >         /*
> > --
> > 2.39.2
> >
>
> Thanks,
> Yunhui

IIRC that's a debug feature when you can't reach userspace and use
cpuinfo, so what about using pr_debug() instead?

Thanks,

Alex

