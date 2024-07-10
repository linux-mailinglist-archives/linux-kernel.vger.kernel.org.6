Return-Path: <linux-kernel+bounces-247900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729DB92D61A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2210A1F278D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CDD196D9E;
	Wed, 10 Jul 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/Hg8bdc"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629D1953BA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628157; cv=none; b=n0xW4PZd0MsglsAnzH8q5kYu0p335XkjAHgBljGT189oghbdyerhKDoP66xOCSwL3p/Iy9LZffbqzU7d0mfasfBuUfK35IoHM5kovCR1w6ro2SK2Mx/zb/E95cEO4To+8XhxeHFmMfW7K8s0GIVysRtEu02GlZaEpk5TDha2yNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628157; c=relaxed/simple;
	bh=TgOKlANK2h/PGDdeOGOPxmFLAyYqKVcQrEFN0PRUTFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM3LMpy3lBKt4HWpzy1R1ExKu/82MCLQIpOBa2PYR3Qt1jLgi6fGYyyJGtppTxGEr0NoysocVRUU0X4X9VMUC24zGhNY8JIMi7Vg/eVWqVSUhXCcdE7IJIWYhSKOrPmv2EhEFeAoH+0DQL7gDTeXUJnM0A/iUI8H0glSf6kThmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/Hg8bdc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-64b29539d86so59364037b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720628154; x=1721232954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4xVThAQgk7n6R5xLRV2ywFddDRqebZaKIPSQDVaDtw=;
        b=I/Hg8bdcxXSu1n2xs2lWKCmIQG3yjbEtM2Ir5dpFj30zMh0zobzDcNLUzdR4nL0TTL
         WphqTlN0Q/FvYmsKQmPep1A7VzK40NqiQ5uu/s0tbRmCHQi7jJACvc5xFw9hzRwqGxlb
         +HnW1hZC/tsveRzLRcBRiAOW03yKSvCWvv2PskQnmLL9ixKsHGHPyB7k2YnFZrtDS13+
         Q2Ikf3p2w41sxmhgP20bMOBe0A0rS/0NCoceOHmLaO5scMllTt2VYQiwYsCyTzkeIbPv
         lBywIUedsG+p2DemJaOpu5JQA0wkCvWcy72vMqJm6vd9Zam8x6AdYWl4hOkeVkjPnxw2
         CByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628154; x=1721232954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4xVThAQgk7n6R5xLRV2ywFddDRqebZaKIPSQDVaDtw=;
        b=cdSQHrNmlkmIgkK8Wco7LVfgbvu5jx/d4SHtSfMiiGv8W2LP8TshrZCGf9vVb0QtPe
         THqdP90bMRMg5sQDlBL/FxFHTlnitqHqCRhFj+Stlw+w6KQytCBXe2bK+BpbsjCUJ1Fy
         RRPGjd/PLessZyG9YNqrT+VAEQ6duu0ES+gHpVVWHs4l44a2Z5/e07UDn8/J0jq/QjUH
         ptz2gDxY3rI5+0JsbD4cDLdU4dVqfhWS/73bDv7IWX+U66R4nzj2X+bz2wug2OwSsqDg
         47BpB6IsXERmY/ZP0Hhrmey8N6BJ5AUT6v7leq2LM72AhQDTx+L+sZNfUji6ALz7l5SI
         9FCA==
X-Forwarded-Encrypted: i=1; AJvYcCWNrcKIpcyFUWx5mKPtHVkoPSJx8dBgxr0di6OhVoNy33QmAH5mI0S2zV5M5Z9O1CS538DwF/jqAIqKxPOnTEkvl7Eq3K5R/z6inrTa
X-Gm-Message-State: AOJu0YwGeGbntYjHaJk7ygYKXmZCxBWz36jozrPnwIEYCT9AoVAQ9vq8
	n5gbRXlmbZmIMHMg3yZP8LWiSiaenmzuXTNPSJxalkDXayB4a0OzLDSyZhPSxiH9X9qkPhqKlgD
	kEcN4gUpjXq7ulV0o6C0T6Sz7b8Eg8+yDe5TA
X-Google-Smtp-Source: AGHT+IGCoqOolpEeqhQMOEIsEQnyWipG02ffK00hOOo8l2FHKvLvFsXzjXv1yEHKYMw/uXlDNKaotNWQ+7BvNWHYkRA=
X-Received: by 2002:a81:69c3:0:b0:650:279f:8c67 with SMTP id
 00721157ae682-658f0fb30f1mr69528697b3.46.1720628153459; Wed, 10 Jul 2024
 09:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com> <20240704182718.2653918-9-Liam.Howlett@oracle.com>
In-Reply-To: <20240704182718.2653918-9-Liam.Howlett@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:15:42 -0700
Message-ID: <CAJuCfpFNJ1j7Kcf3Z6efBB0xmvpRCWnfZhnNOuD_hBZmKc-bqA@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] mm/mmap: Inline munmap operation in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 11:27=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> mmap_region is already passed sanitized addr and len, so change the
> call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
> checks.

Hmm. I think such refactoring when you want to skip some checks would
be done a bit differently... You would introduce a __do_vmi_munmap()
function which is called at the end of do_vmi_munmap() after the
checks and then call __do_vmi_munmap() directly wherever you want to
skip the checks. That would avoid code duplication. Any reason that
can't be done here?

>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8d9be791997a..e9858ca8bbd4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2937,12 +2937,20 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>                         return -ENOMEM;
>         }
>
> -       /* Unmap any existing mapping in the area */
> -       error =3D do_vmi_munmap(&vmi, mm, addr, len, uf, false);
> -       if (error =3D=3D -EPERM)
> -               return error;
> -       else if (error)
> -               return -ENOMEM;
> +
> +       if (unlikely(!can_modify_mm(mm, addr, end)))
> +               return -EPERM;
> +
> +        /* arch_unmap() might do unmaps itself.  */
> +       arch_unmap(mm, addr, end);
> +
> +       /* Find the first overlapping VMA */
> +       vma =3D vma_find(&vmi, end);
> +       if (vma) {
> +               if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, fal=
se))
> +                       return -ENOMEM;
> +               vma =3D NULL;
> +       }
>
>         /*
>          * Private writable mapping: check memory availability
> --
> 2.43.0
>

