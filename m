Return-Path: <linux-kernel+bounces-422740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521569D9D99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F552283332
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65981DD55A;
	Tue, 26 Nov 2024 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvkBU+uF"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8841D45EF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646748; cv=none; b=geDV0s6i9GTYE3qZUznka6/pOh7e0fQI98p4Yijei+0+v5vQtCfT0Suj91y95cv4SmgHanE3srDTe5WDsF2YRWCEGjLPtcU+wh/+3eMK1iIHKn2gDNWjMS7xflHvTRSj66T2e/h54w1NZiiKygyHqqwlUOy4ERL162J1V3V0/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646748; c=relaxed/simple;
	bh=S5ZPWNcRig2nzYKuWB6cD8RvjU7VkWsbUy8mMaHEwpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nInpXVLUB/iXtNH+Yi03u6Ty0gYK879dL8QscnjJvaC3sxbkilx6zT3RxVPR3KxrEV03Su+LD7DUlq/dEGoElTGSCfUYXS9vTgbeuv5bQD5/uwkfBuWHSZfRo/VzbQy9l9oDO9cdlSkCSNYwEPFku/Z26B1YyB/5USGtDLhjAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvkBU+uF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-466ab386254so11431cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646745; x=1733251545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yin/AHK0HjOHEQ6OVFguR+JKUqHw/4L0Lx/VgQ292o=;
        b=zvkBU+uFmPCJooj9LYlyDSMdqsn8TQ7N8LNo0FMmu+fdXU4U9vNvH1pCfKj2+RnSeK
         AzmTQgiSi27yiDWgxB+2rwR9eVwPILVcneKdnU+1hw88QzqubIBULKuYdfCnlpX8z3Dc
         xWy0QXCNxeq0pvVn/877STCL60LmEWRfvba7LwFqRek0lFJ/5Tmx+5alixuO64BuR6QT
         ZYHXAIx71SC41A1ji+GQkgYdIjei7wtXm5FuXSDZ93WwcBrPkaImUFRdKlQKVAniA3eL
         brdjDNdL2qt7e/ZS4tBHx4jsO7jdnBQMJPCq3abkWq7MVHcIAYSUP09l71TRAFf25Tbu
         Ougg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646745; x=1733251545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yin/AHK0HjOHEQ6OVFguR+JKUqHw/4L0Lx/VgQ292o=;
        b=j9nEnxdI1nskCwvKLDaqYACBe0kD4MKrFX9JPbDyBNWK12mJmpdCZHVC4dKqZlped0
         ZgYYs04rqu7lRcqOdoYFnT3FWEmzaVpqczO5g9OOU5bOJKrCLtP862jkll8dR5xX9h3E
         P17I+f59FJZWl/EPT3cCE/3nm+X8pOTpTFsIeV+OMch3GrLFKB/FLGgkhrkyTerughvE
         LU/Fec/wuDJIfuMIankaYKVTAslieUu/NSVzE6iF2/2lKgRLPKbcbSGDGHpr4OSOsJJz
         Kea/bAJEJTxftTJKwq2Hv12YsOSkM8nbp6HH2WTEz8rAqaHF03fi8eAWknCKdW9TGMnM
         W7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHG3oj6Z+S9ELHsaBF5BshpaMEfI6cp9B989ySuZNInr3igyCvuiR546xK/oTopAcTyLAUpli401YbJZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyReL/8nu8eCENh/c3uhUX86Oo+T6pD1Di7ORcxbC8lDffzCfsK
	4BBei3CFrQXf5+2UrTo2H5784mCEM5eNQGmHeEG2DnfMjYMdd4cOAZMJP9kkBLK/mt3jGzGFKHP
	51l3SbGxM2en0B5nkwWbfC+h3IRGzD/02xQbH
X-Gm-Gg: ASbGnct3pxBsE8il+BVb0WorNoO2v96iT1yMvsH0fCcMhCZFt3UjtTp3w+CSHL0RDmx
	cLkc+5yNXu8TzMaCbg1Vc+EvtfpIjfouaJWEg32djl8nHtT3leaENZKjtEzsl
X-Google-Smtp-Source: AGHT+IHSGIv3YuZT5lZ9n65aGjDVk9hd28J1BK1WWOgNYHR8YG1L9KAUbQRAvajhGDQ0oKrMOieegbgOBVRiOUNH6rk=
X-Received: by 2002:a05:622a:1919:b0:460:f093:f259 with SMTP id
 d75a77b69052e-466b3e13498mr31021cf.22.1732646744819; Tue, 26 Nov 2024
 10:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com> <20241126184021.45292-10-cmllamas@google.com>
In-Reply-To: <20241126184021.45292-10-cmllamas@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Nov 2024 10:45:33 -0800
Message-ID: <CAJuCfpH+B1HrzXtM_3+H9m8NPkTzAX8S4oSwhTEW+07g9JceeQ@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] binder: use per-vma lock in page reclaiming
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 10:40=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> Use per-vma locking in the shrinker's callback when reclaiming pages,
> similar to the page installation logic. This minimizes contention with
> unrelated vmas improving performance. The mmap_sem is still acquired if
> the per-vma lock cannot be obtained.
>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index 339db88c1522..8c10c1a6f459 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1128,19 +1128,28 @@ enum lru_status binder_alloc_free_page(struct lis=
t_head *item,
>         struct mm_struct *mm =3D alloc->mm;
>         struct vm_area_struct *vma;
>         unsigned long page_addr;
> +       int mm_locked =3D 0;
>         size_t index;
>
>         if (!mmget_not_zero(mm))
>                 goto err_mmget;
> -       if (!mmap_read_trylock(mm))
> -               goto err_mmap_read_lock_failed;
> -       if (!mutex_trylock(&alloc->mutex))
> -               goto err_get_alloc_mutex_failed;
>
>         index =3D page->index;
>         page_addr =3D alloc->vm_start + index * PAGE_SIZE;
>
> -       vma =3D vma_lookup(mm, page_addr);
> +       /* attempt per-vma lock first */
> +       vma =3D lock_vma_under_rcu(mm, page_addr);
> +       if (!vma) {
> +               /* fall back to mmap_lock */
> +               if (!mmap_read_trylock(mm))
> +                       goto err_mmap_read_lock_failed;
> +               mm_locked =3D 1;
> +               vma =3D vma_lookup(mm, page_addr);
> +       }
> +
> +       if (!mutex_trylock(&alloc->mutex))
> +               goto err_get_alloc_mutex_failed;
> +
>         /* ensure the vma corresponds to the binder mapping */

You did add a clarifying comment I asked for in
https://lore.kernel.org/all/CAJuCfpESdY4L_sSwiCYVCX+5y1WOuAjLNPw35pEGzTSyoH=
FYPA@mail.gmail.com/

>         if (vma && !binder_alloc_is_mapped(alloc))
>                 goto err_invalid_vma;
> @@ -1163,7 +1172,10 @@ enum lru_status binder_alloc_free_page(struct list=
_head *item,
>         }
>
>         mutex_unlock(&alloc->mutex);
> -       mmap_read_unlock(mm);
> +       if (mm_locked)
> +               mmap_read_unlock(mm);
> +       else
> +               vma_end_read(vma);
>         mmput_async(mm);
>         __free_page(page);
>
> @@ -1172,7 +1184,10 @@ enum lru_status binder_alloc_free_page(struct list=
_head *item,
>  err_invalid_vma:
>         mutex_unlock(&alloc->mutex);
>  err_get_alloc_mutex_failed:
> -       mmap_read_unlock(mm);
> +       if (mm_locked)
> +               mmap_read_unlock(mm);
> +       else
> +               vma_end_read(vma);
>  err_mmap_read_lock_failed:
>         mmput_async(mm);
>  err_mmget:
> --
> 2.47.0.338.g60cca15819-goog
>

