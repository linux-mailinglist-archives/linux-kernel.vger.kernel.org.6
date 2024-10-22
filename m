Return-Path: <linux-kernel+bounces-376978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBC9AB851
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0ED028498D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A88D1CCEF9;
	Tue, 22 Oct 2024 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuIQIHE+"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E41CCEF5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631758; cv=none; b=kpiMFq5whzxAPV6nzSrE5gcNgXYZy0tHVYhOF+3nUnNJzrzAuz87Fol/8gtNozOqsxgnQvOleCy7ZUJxobx5CDx3ZUpedUp24QjaPQrTswE4wFnoVKE462TOoCBNnkluvObKrL3X9G9sEUatEcj2ZhCtw/TdE6v3R5YEi+pwEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631758; c=relaxed/simple;
	bh=r2jEZ9rg4kKDBi31FwDdcBmXtd9BG0z4ETOMrQsS8KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwmbrsQFnK1oti3H9NN6lLl+TVKkka/idg6sP03flciq80kT3cRIuvzdBnVBnVAqfWumdunLs1xfvT3Xv2k37Xx1Rr77rzfEPrwrUcybtv/g3E0y7dWGcolrRCIgiHTnsMun/L+AfmsimF9NGjvIwKHAWxLpNZ0sdIz/AGDbHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SuIQIHE+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43153c6f70aso25305e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729631755; x=1730236555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdUm3KNWQIjqYQ7AyrEbFp7iBDzg82iIjXFUakJE6os=;
        b=SuIQIHE+OtWaZ6rjDFDhOPS7LZ8Y7xXuW0gJluDrfYPKVn7pNNrfzlp5WIvF6bCW/W
         qcebLYdrfirNDOrp4LaokKB6pRLxgXFJwgS+z0DqwPADh+YPtCpdTAyfc/hXH5eO8ypZ
         nCQbG+9jzYysio6ZF8/DpW2HrFyeCs1xr+z5b/Y2QtXWsnE2VaTTYdZeAwseu7V1o+CT
         SS/kav3pQxPwa/29shHWbzAYXEfvhOsciKmuHDNyS7kRCTaG2JEl8kWLlJ0DlTeTz5sU
         kgeXQspEmc5sZoWbPa0EPoksm5gKCj+uuog7T/t3YSf7f03gbjwi5h1J016q/MuX+/nh
         MkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631755; x=1730236555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdUm3KNWQIjqYQ7AyrEbFp7iBDzg82iIjXFUakJE6os=;
        b=n/tO2U/bPnQ3P07hlcaI+ND/nBXqggchj7NCIbwwXQeDlbs3RaFhvUxwJAcu0MJlap
         KAn3tok4HF+sXQ+VzqV1MdyM5yQtjV8r2AJaREhD+lHrJFDDgBD1ccRq+VgcD2MCdeLZ
         fkWaISKeeawKoQ+Z6xImVtzCFPg5gxHR2/3kKSofqfcAkTn6+yD5Q0weXO4fP0QlAOy9
         /qrjFMBh8pAf6Rg3rg2QTsX+9ik9qv9UX7Qh4fk20Ro5VcRgjiOv3lXJDwcFncsS7G7p
         vHchSZEkVbtH4QxlooGr452UKQAEoiFPtA1PfAT/arNU/LdJuchPPADS4Tu6tCLet3z8
         eiXg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ/uyHDNK/lsfKyvzzGMo/ZNkw/cWlqbqVKGZRy/qEdBnEEtI42GxZBBSqTFvl1RTBrQEFifmroijEroE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZF7q7ItJqlD5rdxTYGzlb5MfVNCOnVHrp4Fg1+wuYZTPxG+rs
	HDLlc0cjA2Xa/QTrmn+Q3Bm2TH9L/8+OmE1Xg4yG2e5SzA/YygJXFuEv16hV9Opql+uxhsrrI7Z
	UPir0s5TYmnCoB3F8D06OL7RTa4Ihy05pqKR4
X-Google-Smtp-Source: AGHT+IGtrqV60ZkV3BGIQyPZYzwOEUmaX+5yYuXLJqZC8XpI8oT/zOjATJNvODovgWW0J2IbZP9DDr391T0f57IVmbg=
X-Received: by 2002:a05:600c:4e12:b0:42b:8ff7:bee2 with SMTP id
 5b1f17b1804b1-431851b8022mr138205e9.5.1729631755169; Tue, 22 Oct 2024
 14:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com> <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 22 Oct 2024 23:15:18 +0200
Message-ID: <CAG48ez0oqGgfF-UTOc9eWC_TrZ-pF1Ek_cUjzArxHEsM_TT2gg@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 3/8] mm: refactor map_deny_write_exec()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:41=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> parameter but rather to accept VMA flags parameters, which allows us to u=
se
> this function early in mmap_region() in a subsequent commit.
>
> While we're here, we refactor the function to be more readable and add so=
me
> additional documentation.
>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() f=
ails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Jann Horn <jannh@google.com>

[..]
> -static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsi=
gned long vm_flags)
> +static inline bool map_deny_write_exec(unsigned long old, unsigned long =
new)
>  {
> +       /* If MDWE is disabled, we have nothing to deny. */
>         if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
>                 return false;
>
> -       if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
> +       /* If the new VMA is not executable, we have nothing to deny. */
> +       if (!(new & VM_EXEC))
> +               return false;
> +
> +       /* Under MDWE we absolutely do not accept writably executable... =
*/
> +       if (new & VM_WRITE)
>                 return true;
>
> -       if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
> +       /* ...nor newly executable VMAs. */

nit: maybe clarify this as "nor existing VMAs newly becoming
executable" or something like that


> +       if (!(old & VM_EXEC))
>                 return true;
>
>         return false;

