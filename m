Return-Path: <linux-kernel+bounces-333040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF397C27F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD91C21618
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901CA1BC44;
	Thu, 19 Sep 2024 01:38:14 +0000 (UTC)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4318654
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709894; cv=none; b=UC2ECpbb+c8hIk4E7LwldHgzaJu1sBRSFE+MzBIlqAo/wL7nYnGIksOJ3Zmq66q4lu9qwNw5WsP8OW6/VSHoKn/ZO08BN65Wvg8Q8Z+gQbB+dWwTYTQN51HlDhLbIL4Ow0fcxtc+u7varZmNzY6nm2qZvO7WnE3o/m2W8qaZbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709894; c=relaxed/simple;
	bh=Zdi3ybR3mP53fa/CJa4WxJD91q6pHUzHisCVrKPLbAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He4Hp0XgiPb1/3AFNj4FUYoTh/DIL4rb69fB8kA9DC/vaJQYqtoF+Ene2IB8f+98Dn2+n+r8PvQ2XlYhh9aR4F9P+7GlpTxVBPpSMoXP6z0eqJOLTdoXwaYgv018BaBCtICdZX9J+TmDqQQjsyuixEbfbFT98lMiLbHYmiwVUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-502c0ffd07cso94906e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726709891; x=1727314691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOumTyFzmApDLmcuzvAmkjZjCGRjQy7iz9BhGJngPAs=;
        b=qkYuJE4zPMXT38TlJEBpzEFvy87uHdLOHOEM+t1sFJ1sBEpWUJi46vLH77t9toyY0Z
         ezS3aKPwomCi8eKMP6jTWWfQlOC75uO9r0owIyKuBmN0TqiG89Feebiz1z8lx831Ooap
         kHkC2rX7yDCBjywAImZEopSEJEonYVwvS1C6mkUj2aKVqYgmNEFXOtrEot8apkqkm6nA
         B/+HHbOyVDH+rlEtKeoe+sHjRMkxBBy0TfOnlq8L4NWYIo1GbR7Xl4Ej3B7/FMWxAEwi
         apRSRXnwIID/Dz3+9m9SFbBVdYF0Lk4xrPzBuxlehLX4T3zf5NjLHrtRNjZr1fYvIpBY
         SGYw==
X-Forwarded-Encrypted: i=1; AJvYcCUZqcRirt5jtVn+jw6m3PpKyAGCP1PJl619tsQGYv6f4jw1NZQisRvw59u4Jbc1WFzUFAfMeVkAVDnACW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys47K7Jiblsr0DsYNx0BKfrZkAWWvISb3o9af9sd+wRdR+yuOX
	RHcQcRpTL5CA62PHemAxecmNwKUp2HVTYpW0LEXONqnVn04Z7snovT0n1qysiygRG29xzi4f8jN
	VIAi6+qBQok8/c0D0t8xnRYXIqxg=
X-Google-Smtp-Source: AGHT+IGeaI3XwXhVCcs8TxI+CxKj5y2PoN9gQ5vAHJWzKcaD+balY7FmQ98EIi8Y2Bt/iggITxsbQ88QZD7qSpDURVk=
X-Received: by 2002:a05:6102:510b:b0:49b:fe6b:493e with SMTP id
 ada2fe7eead31-49d4f6ee970mr12877891137.24.1726709891536; Wed, 18 Sep 2024
 18:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916110754.1236200-1-dev.jain@arm.com> <20240916110754.1236200-2-dev.jain@arm.com>
In-Reply-To: <20240916110754.1236200-2-dev.jain@arm.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 19 Sep 2024 13:38:00 +1200
Message-ID: <CAGsJ_4xeNLd9xrQ531xqpKkpwPSsWF_44rzftvMbFAD0-X3ZQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Make pte_range_none() return number of empty PTEs
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, hughd@google.com, 
	ioworker0@gmail.com, wangkefeng.wang@huawei.com, 
	baolin.wang@linux.alibaba.com, gshan@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 11:08=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
> In preparation for the second patch, make pte_range_none() return
> the number of contiguous empty PTEs.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/memory.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 6469ac99f2f7..8bb1236de93c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4617,16 +4617,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         return ret;
>  }
>
> -static bool pte_range_none(pte_t *pte, int nr_pages)
> +static int pte_range_none(pte_t *pte, int nr_pages)
>  {
>         int i;
>
>         for (i =3D 0; i < nr_pages; i++) {
>                 if (!pte_none(ptep_get_lockless(pte + i)))
> -                       return false;
> +                       return i;
>         }
>
> -       return true;
> +       return nr_pages;
>  }
>
>  static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> @@ -4671,7 +4671,7 @@ static struct folio *alloc_anon_folio(struct vm_fau=
lt *vmf)
>         order =3D highest_order(orders);
>         while (orders) {
>                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               if (pte_range_none(pte + pte_index(addr), 1 << order))
> +               if (pte_range_none(pte + pte_index(addr), 1 << order) =3D=
=3D 1 << order)

Minor suggestion: it's a bit odd that we're doing 1 << order twice.
Perhaps consider
introducing a local variable, nr_pages, for clarity.

Otherwise,

Reviewed-by: Barry Song <baohua@kernel.org>


>                         break;
>                 order =3D next_order(&orders, order);
>         }
> @@ -4787,7 +4787,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault=
 *vmf)
>         if (nr_pages =3D=3D 1 && vmf_pte_changed(vmf)) {
>                 update_mmu_tlb(vma, addr, vmf->pte);
>                 goto release;
> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) !=
=3D nr_pages) {
>                 update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>                 goto release;
>         }
> @@ -5121,7 +5121,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>                 update_mmu_tlb(vma, addr, vmf->pte);
>                 ret =3D VM_FAULT_NOPAGE;
>                 goto unlock;
> -       } else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
> +       } else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) !=
=3D nr_pages) {
>                 update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
>                 ret =3D VM_FAULT_NOPAGE;
>                 goto unlock;
> --
> 2.30.2
>

Thanks
Barry

