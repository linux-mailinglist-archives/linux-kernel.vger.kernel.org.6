Return-Path: <linux-kernel+bounces-257504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE7B937AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5365A1F22768
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B627145B01;
	Fri, 19 Jul 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LPeqppCE"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAF1448F6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406359; cv=none; b=uuKwtIHcW3G21py0xcqqn3Gk/qUSpHE8P8PM59CkgJNAHbv7KMiQxVts19zxt86q6rg11SNKhmfMoE2NmnHdFP37gdH0sRFoqZIES4YnClDFtfn43bQPjPv757qGtNN6RhVV/tsD3+a449GlkscMAzqJWMeV27W/ag4z1m2P7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406359; c=relaxed/simple;
	bh=yBmQSIbHflVjTrYCsSRAiTMPSIpmqgjHLtMsSZhH5Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQwdg+YnGvJdiPqARvxbN1AskYc1eED+J8KGjyf1pobCfWQsz5982yabpfqDUqkLYgiiNamGTr+6jdNNp3Lbe5dZXGRGi1EKmv8wsrDZt+7H/odqhye73b92MSZbq/oqhXz29ZB/D1dMqtuOVeSwKSDWy1x9i8ZPo6/jmUtfM7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LPeqppCE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77cbb5e987so211043066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721406355; x=1722011155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDMEak0Z3PlfyxZ36W4lvRYrybLwACF3e0c+AWtbgSY=;
        b=LPeqppCEig9ORAbX0Htv88te/Avy5ORZWk6x7NwKBKpHLSbRqkl4wovvziLLljhkyi
         4v3WGe2rXv1TZQN7/Z0bCPgayxPLYFaVkZEOHda6H9poO/nADyeb8fcClYutyriUdOcO
         ATHuHK4sbJJewkZLACp+m2unFA8KLkWSPQTHxHPjhKqUaaSm0bRXTVak6fzPWfqdmCEf
         EFGoYS6J37GPCMl9hYoXUKofyMFjC1k5aP9Pyn6pMO9MhVbZSwUzc1ZhcsTWjO1F+HBr
         /kXi5/LkjoCWLxkUkKYazaBEuQlOZcCh7E8QMkWVmxCR01Bue6NtpK67oKXvxGGFsTRy
         pwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721406355; x=1722011155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDMEak0Z3PlfyxZ36W4lvRYrybLwACF3e0c+AWtbgSY=;
        b=vdk8TqobdekTXAVe4uQXM45EgYiWMn59mA2bFSQgG4HU1Dn9FEXTOwzzKt4/eqQfkD
         /kBUhSWsfKAkfUz0Hy4CXW8iPt7R7MZ5Q554KUhhn/jgaLq87/EePt6/k6LaVKujmH4C
         uo4ZSrf6PkBAwIY3/8Ugs6h8idslaHp3ilzJYjZmqvn1RB6fYhxmjlwXJREdlp6ko41V
         ZjD3Am3qYt4L/qMtKMWuptyZwldZr7xwXmn8hrT6b0Sia+B8iRDBs2z9ETVcv+XCH2MC
         Ap3f4/eQ8uFcla1gpNOmMMXk2QFf+GRSxvTfygHghqQmlk4HftLFty3bejhMPBeMq6Zl
         vVMg==
X-Forwarded-Encrypted: i=1; AJvYcCUTFjoMXOn/A29ToiyqIZNAnSpZSVKN4ybVysoCXTC3PvqRmTtAJHE2DL+eJu3pswRlMOEWhkooeG55aYE6z5ooQruS04QAn1ybQ97J
X-Gm-Message-State: AOJu0YzfBZibrc8Cn569nulgd+y0cZqI/O5+qRiWXBa8L2CoA0OvwpML
	LRa0EdEzW2BxoeKJ2ZqQF7gK8zIdZksLVGbnuQrVVzhQqHOGz/3B1SN3Oub1ozHHLTRg1aRm+gy
	uEGyQ0eCjxmVgeWTiJ8j74fA5a0CJcYKCJdi4DQ==
X-Google-Smtp-Source: AGHT+IHfY3GcuR4+ZNljmMvpKt2IVp/HAZEiPxvyT0vLI0C1yN86ZknX3h+KQ0x99+E9lz8soKAJai4FqnDzq4uijIM=
X-Received: by 2002:a17:906:309a:b0:a6f:51d0:d226 with SMTP id
 a640c23a62f3a-a7a01353a95mr640153366b.66.1721406355238; Fri, 19 Jul 2024
 09:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718020935.12803-1-cuiyunhui@bytedance.com>
In-Reply-To: <20240718020935.12803-1-cuiyunhui@bytedance.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 19 Jul 2024 18:25:44 +0200
Message-ID: <CAHVXubiYbLs9j=boM7yVg0nRBg3kY9EQiv2R+edLs+B7qJTZug@mail.gmail.com>
Subject: Re: [PATCH] riscv/mm/fault: add show_pte() before die()
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, akpm@linux-foundation.org, surenb@google.com, 
	peterx@redhat.com, willy@infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunhui,

On Thu, Jul 18, 2024 at 4:20=E2=80=AFAM Yunhui Cui <cuiyunhui@bytedance.com=
> wrote:
>
> When the kernel displays "Unable to handle kernel paging request at
> virtual address", we would like to confirm the status of the virtual
> address in the page table. So add show_pte() before die().
>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/mm/fault.c | 47 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 90d4ba36d1d0..dfe3ce38e16b 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -22,6 +22,52 @@
>
>  #include "../kernel/head.h"
>
> +static void show_pte(unsigned long addr)
> +{
> +       pgd_t *pgdp, pgd;
> +       p4d_t *p4dp, p4d;
> +       pud_t *pudp, pud;
> +       pmd_t *pmdp, pmd;
> +       pte_t *ptep, pte;
> +       struct mm_struct *mm =3D current->mm;
> +
> +       if (!mm)
> +               mm =3D &init_mm;
> +       pgdp =3D pgd_offset(mm, addr);
> +       pgd =3D READ_ONCE(*pgdp);
> +       pr_alert("[%016lx] pgd=3D%016lx", addr, pgd_val(pgd));
> +       if (pgd_none(pgd) || pgd_bad(pgd))
> +               goto out;
> +
> +       p4dp =3D p4d_offset(pgdp, addr);
> +       p4d =3D READ_ONCE(*p4dp);
> +       pr_cont(", p4d=3D%016lx", p4d_val(p4d));
> +       if (p4d_none(p4d) || p4d_bad(p4d))
> +               goto out;
> +
> +       pudp =3D pud_offset(p4dp, addr);
> +       pud =3D READ_ONCE(*pudp);
> +       pr_cont(", pud=3D%016lx", pud_val(pud));
> +       if (pud_none(pud) || pud_bad(pud))
> +               goto out;
> +
> +       pmdp =3D pmd_offset(pudp, addr);
> +       pmd =3D READ_ONCE(*pmdp);
> +       pr_cont(", pmd=3D%016lx", pmd_val(pmd));
> +       if (pmd_none(pmd) || pmd_bad(pmd))
> +               goto out;
> +
> +       ptep =3D pte_offset_map(pmdp, addr);
> +       if (!ptep)
> +               goto out;
> +
> +       pte =3D READ_ONCE(*ptep);

All the READ_ONCE() can be replaced by pXXp_get() macros defined here:
https://elixir.bootlin.com/linux/v6.10/source/include/linux/pgtable.h#L315

And we should stop as soon as we encounter a leaf entry using pXd_leaf().

Thanks,

Alex

> +       pr_cont(", pte=3D%016lx", pte_val(pte));
> +       pte_unmap(ptep);
> +out:
> +       pr_cont("\n");
> +}
> +
>  static void die_kernel_fault(const char *msg, unsigned long addr,
>                 struct pt_regs *regs)
>  {
> @@ -31,6 +77,7 @@ static void die_kernel_fault(const char *msg, unsigned =
long addr,
>                 addr);
>
>         bust_spinlocks(0);
> +       show_pte(addr);
>         die(regs, "Oops");
>         make_task_dead(SIGKILL);
>  }
> --
> 2.39.2
>

Otherwise, that's a good idea to print the page table content on fault so:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

