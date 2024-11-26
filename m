Return-Path: <linux-kernel+bounces-422743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4CC9D9D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4640E28326A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FAA1DE3A3;
	Tue, 26 Nov 2024 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObMkY4gM"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05D81DD55A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646777; cv=none; b=B67Z+yXWfsmTtdLa41Bc/DLx3Izf6TTfgxuT25y94mM6DZwrvVmX01pzjWrJ06wEhi3XtzpIbJsd0E+LpuHBmD8KyuCVe1A6Jt3PrE4GPVYo25Do97hNsJrHgjj5Ia0+vUNwlah8ZP+AHsaOsV+0EZICl8MiYC6wzIzusjMlabU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646777; c=relaxed/simple;
	bh=KzaH9VaK2P6cdLznIv73O6E5pwQjyAhQu3VJLdy7c+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bOr7LuYX07vgFfvD3+/qrQpEGQp7tMLX2nnbRfFtfZNcDyG3sLbhzaSyoDeH3Qsrfix+XNHL49Z6j4vbuc/be2Fm6RJaqrUbAuntoXrkUw9EDd6V/tEKgroWxDVVJ7mgeUBFt8Kj6Dqx7U+3Amn58859bPQ0eK3ORlsxljKojTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObMkY4gM; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4668caacfb2so17381cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732646775; x=1733251575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFJu1j/wkqiOvCGVYMAIdwsL+syJswetP7zrQTT0cYk=;
        b=ObMkY4gMW67+tHAjCWib3H5Jxor4JC49VQnPBTF0sZfv+p71bLz4eYw9bU90ccqU7G
         Lwqj+8soQ3DQQUsKENytgOhvj1IuwVFdGKwS6Ao/GqY05RC1V7coP9PkhTGIvcL2JTOu
         I6l4WcXvx5CViu8D0QgiJHuEsEdmcgBmJZ7Tp7QHBekCbk+mzpPt5AxMPa13edW0KRvi
         AP+ff/zvQCzwAwmw9JAjW+3X7tMkCrGcMrHhNkr3M1IWKlBbJvGB6RQDS7FuLn1IkktC
         eyknf/YrBwT6lNaAgEMZmmGFBAn3PECgF+H9lRKBk1/iLBz1QlH5eQsJb15Gw36xDPX0
         TVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646775; x=1733251575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFJu1j/wkqiOvCGVYMAIdwsL+syJswetP7zrQTT0cYk=;
        b=WsZcNvadSTv6jobBPmwdSxBKY9kH2uJStDCuHrSoNdO4puGkmoq99531tqFExppM/D
         c7pOX6gNxIesp8d7dNMGXiTgiE6LU76i/iE0og5/zhfhlVBaBL3Y2/mE7zbkMCHhDwPG
         aea4o6yBHGrF30ArGkzKJEsYkNUIsBMem0ehCLGCOzstVLEUDmt39vPFoG6NSiERugGd
         rHsSfF8c2D5RSOB3t9ewgv7Fk74eCZGp/MjVfsoUXU73XvS1up4F94Pw5CoG6NGC6PZJ
         BwvZ++7X30+Fi4TTXuo5XBdHoyKXRO7qst+aSESLrnSFXJP5Ng5GhIWtyEx4f5sCYcbd
         KroA==
X-Forwarded-Encrypted: i=1; AJvYcCWW9h3+e+/057HNHBuByX9jsrTLgN7SRqbYmoNcC9H4YLCRp2AqRa072NTsPa8F6R4ejxxc9meHwme+a+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPXP+dRE5uwrssetKA6urGMNfTB68J4gWeDaE8T3EXjz/lKGmj
	aB26tJJ5G6SeFz8MStVU7qpW8eOyIhXqYtU15ETtd1a1FrjWCyJ/Px1Wx504u4ee0H8653R/gLu
	uUTQf/yHut8oD8tDww5fYWBzVFk9QCRL1lttN
X-Gm-Gg: ASbGncu0YdJdE0Geip12VkYNbxsHyxMXTPc56p8Zle394OEOcebvlSeph6SwkZISicr
	fViyabQI7RHArePwq6riASKQmLsNVe32nhEmLZPt0UUzVQc9dGgoHH2bKBbvn
X-Google-Smtp-Source: AGHT+IGORmM49kQetY05s3ECfzIEdchhMoxdcPBJAuTlbqo9wAZfTt2LJwU8dHau3kLQ/7T67Ts879jLyAGyCrb6HKM=
X-Received: by 2002:a05:622a:4c85:b0:463:95e2:71f8 with SMTP id
 d75a77b69052e-466a741c804mr4249451cf.15.1732646774433; Tue, 26 Nov 2024
 10:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com> <20241126184021.45292-10-cmllamas@google.com>
 <CAJuCfpH+B1HrzXtM_3+H9m8NPkTzAX8S4oSwhTEW+07g9JceeQ@mail.gmail.com>
In-Reply-To: <CAJuCfpH+B1HrzXtM_3+H9m8NPkTzAX8S4oSwhTEW+07g9JceeQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Nov 2024 10:46:03 -0800
Message-ID: <CAJuCfpHdYPf-WgheBSCK6Md1WakEy_XCiPrw6xTFmPHr7TgnqA@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] binder: use per-vma lock in page reclaiming
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 10:45=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Nov 26, 2024 at 10:40=E2=80=AFAM Carlos Llamas <cmllamas@google.c=
om> wrote:
> >
> > Use per-vma locking in the shrinker's callback when reclaiming pages,
> > similar to the page installation logic. This minimizes contention with
> > unrelated vmas improving performance. The mmap_sem is still acquired if
> > the per-vma lock cannot be obtained.
> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder_alloc.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_al=
loc.c
> > index 339db88c1522..8c10c1a6f459 100644
> > --- a/drivers/android/binder_alloc.c
> > +++ b/drivers/android/binder_alloc.c
> > @@ -1128,19 +1128,28 @@ enum lru_status binder_alloc_free_page(struct l=
ist_head *item,
> >         struct mm_struct *mm =3D alloc->mm;
> >         struct vm_area_struct *vma;
> >         unsigned long page_addr;
> > +       int mm_locked =3D 0;
> >         size_t index;
> >
> >         if (!mmget_not_zero(mm))
> >                 goto err_mmget;
> > -       if (!mmap_read_trylock(mm))
> > -               goto err_mmap_read_lock_failed;
> > -       if (!mutex_trylock(&alloc->mutex))
> > -               goto err_get_alloc_mutex_failed;
> >
> >         index =3D page->index;
> >         page_addr =3D alloc->vm_start + index * PAGE_SIZE;
> >
> > -       vma =3D vma_lookup(mm, page_addr);
> > +       /* attempt per-vma lock first */
> > +       vma =3D lock_vma_under_rcu(mm, page_addr);
> > +       if (!vma) {
> > +               /* fall back to mmap_lock */
> > +               if (!mmap_read_trylock(mm))
> > +                       goto err_mmap_read_lock_failed;
> > +               mm_locked =3D 1;
> > +               vma =3D vma_lookup(mm, page_addr);
> > +       }
> > +
> > +       if (!mutex_trylock(&alloc->mutex))
> > +               goto err_get_alloc_mutex_failed;
> > +
> >         /* ensure the vma corresponds to the binder mapping */
>
> You did add a clarifying comment I asked for in
> https://lore.kernel.org/all/CAJuCfpESdY4L_sSwiCYVCX+5y1WOuAjLNPw35pEGzTSy=
oHFYPA@mail.gmail.com/

s/did/did not


>
> >         if (vma && !binder_alloc_is_mapped(alloc))
> >                 goto err_invalid_vma;
> > @@ -1163,7 +1172,10 @@ enum lru_status binder_alloc_free_page(struct li=
st_head *item,
> >         }
> >
> >         mutex_unlock(&alloc->mutex);
> > -       mmap_read_unlock(mm);
> > +       if (mm_locked)
> > +               mmap_read_unlock(mm);
> > +       else
> > +               vma_end_read(vma);
> >         mmput_async(mm);
> >         __free_page(page);
> >
> > @@ -1172,7 +1184,10 @@ enum lru_status binder_alloc_free_page(struct li=
st_head *item,
> >  err_invalid_vma:
> >         mutex_unlock(&alloc->mutex);
> >  err_get_alloc_mutex_failed:
> > -       mmap_read_unlock(mm);
> > +       if (mm_locked)
> > +               mmap_read_unlock(mm);
> > +       else
> > +               vma_end_read(vma);
> >  err_mmap_read_lock_failed:
> >         mmput_async(mm);
> >  err_mmget:
> > --
> > 2.47.0.338.g60cca15819-goog
> >

