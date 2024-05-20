Return-Path: <linux-kernel+bounces-183855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA568C9EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA1CB2258E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA7113699A;
	Mon, 20 May 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcA28TtJ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD48462
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216317; cv=none; b=N6A9yD7l71ezQ+1qKvxLm+n1RONELogHsLUiAONP/5FLZNfSAa7jY8Jnzf9umMM69iDqHr3i4pGvTmbLf544vgLoGdcMSuSk09yjRMH1Sxa+oCLyG1qschmHexHSlYMVKvKXThjtKDOj5vudUX5Wgw0IPFjZYzQD25LLmV7w0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216317; c=relaxed/simple;
	bh=eBqFY/TIoMgxP29NOdWtsaUl5FItN7otD1voKRBdwJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uv4RFCo+Kpsphkt239xVMbx2+5SRHf/t+GuE6HHlBTOvYd2utZzaS6Nq3Aryz5KOWud9GWgmbtCiosxAbCQIj50ay7HyAmcWY7UHku1m/Fe5oS3W4ED6qzf30NLV6XoaNuOsHK4Ad6JROKIfqedFqHShyWl4a0lqb683WIS7I1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcA28TtJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso10532042a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716216314; x=1716821114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeSLRL0OKsRhD4qQFOfBvy1JJv4XgJp3PPoxz2ixx5E=;
        b=AcA28TtJ7BdaxEEHXOULkJDFWJ9a4UvPY9Iyfg7H4pqBNjPRMDU32cn8Bxlj9sh4Ul
         G55KeMtpg/sO94YTbVb/u0ttsOzSkPOqaH+hHma4dlaBmaCsMLtQB27gM5SScB/ZfBRq
         CJXWBCBVacD73pJwuOZMadG7HjUBhW0tTszOQ+5kxEyIN5jClkMCMY8nGjKuL4Z+9pzD
         Z5C12WCnw/UWUWzoASe+qDwhA3gJwhgv4o5QdMCUw9ISbQyg48OA7mC/xoVSIBh0LTsp
         A/PZKG3ZwPwdpaV93JDAcdkBm+nC5sOBpSmKtl0a8WD0wqDkOLRE15wnyAvStPnaWmwx
         7sYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716216314; x=1716821114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeSLRL0OKsRhD4qQFOfBvy1JJv4XgJp3PPoxz2ixx5E=;
        b=DCEHJCBdeFXr90JDxtEW6ETSS8bH1l29vZi4QL6mV8Bavudpi944fSgZFoJ+yBfWud
         iTs+e6uNLqisrSzbHIKSv9jwTMvxUXyvIngsegRaFYul7yQ0p7nYz4p4z7ETq2wLdBnw
         wZu8BXuu1aj524zSVYf6IGc783r3Hp8I9pM83sAX36/8MubYBHTqPg7jEY12bivo9tqr
         ZsHMiBo381oWA16kQQQL9PZWMYMb2epWAbMcCu7liym983LZWEZG3gtjdMN+y6Aqi+AS
         nJ579OfRFtJWWAZwdRn57bSaBkYL1UkKs57y5U/Yt1joss6bKMYUcWBu6lxY1r4FcUPA
         NDgA==
X-Forwarded-Encrypted: i=1; AJvYcCUgS7ZdVVPCYixpIEiCwk3rYQPFCeGzYCbR2qV1GbA4+ZxzZRfZ54OXT6uN2XkZS7H9YHLKmSskXxiZcWXxreMdR4kLYFFJI4JJYL1N
X-Gm-Message-State: AOJu0YywuW4/p5xkTJ5Avoe9eTG3mRndbIOXCJMKuIa+/dahodZ2WKzA
	SZHBIFa6xC6MobgwWhRW31IdaL5oecOEL2e3/XoY0qBR5tjwmmnR7P5Vn5ARvfN4NDbMhrEM4qK
	TYD8RhYH+czfMTu+nS3QbE/QKYVs=
X-Google-Smtp-Source: AGHT+IGDDoObxx9h/znodmfXEVY75Zni6ttTKrQE+oaBai6EzaOM4y8AFd/boO5geigu1S0BoUNrW/+Xk2EHVDvwPRI=
X-Received: by 2002:a05:6402:3486:b0:574:ea61:3b01 with SMTP id
 4fb4d7f45d1cf-574ea613b99mr13223033a12.16.1716216314505; Mon, 20 May 2024
 07:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240518074914.52170-1-libang.li@antgroup.com> <20240518074914.52170-4-libang.li@antgroup.com>
In-Reply-To: <20240518074914.52170-4-libang.li@antgroup.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 20 May 2024 22:45:02 +0800
Message-ID: <CAK1f24=Cm--tn4MsxBQEoBV048OsrGGyVVsy0B2MT1VMn+YoBg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: Use update_mmu_tlb_range() to simplify code
To: Bang Li <libang.li@antgroup.com>
Cc: akpm@linux-foundation.org, chenhuacai@kernel.org, 
	tsbogend@alpha.franken.de, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	chris@zankel.net, jcmvbkbc@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, david@redhat.com, ryan.roberts@arm.com, 
	libang.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 3:51=E2=80=AFPM Bang Li <libang.li@antgroup.com> wr=
ote:
>
> Let us simplify the code by update_mmu_tlb_range().
>

LGTM.
Reviewed-by: Lance Yang <ioworker0@gmail.com>

> Signed-off-by: Bang Li <libang.li@antgroup.com>
> ---
>  mm/memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index eea6e4984eae..2d53e29cf76e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4421,7 +4421,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         vm_fault_t ret =3D 0;
>         int nr_pages =3D 1;
>         pte_t entry;
> -       int i;
>
>         /* File mapping without ->vm_ops ? */
>         if (vma->vm_flags & VM_SHARED)
> @@ -4491,8 +4490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>                 update_mmu_tlb(vma, addr, vmf->pte);
>                 goto release;
>         } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> -               for (i =3D 0; i < nr_pages; i++)
> -                       update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pt=
e + i);
> +               update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>                 goto release;
>         }
>
> --
> 2.19.1.6.gb485710b
>

