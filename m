Return-Path: <linux-kernel+bounces-348593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E01D98E96F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D5C2816B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB26942069;
	Thu,  3 Oct 2024 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ht1KebHN"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F21224D1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933933; cv=none; b=pflscCkdYnhNL67oBs7HD4xTjqMI+NdkMYyBwLZaTqd58Ml0+4awlRkwqAfmFEDFknyG3KIZq/glHd5d5mq+hfSK7DLpKILzRE6DPLmqZ0PXsOC9p2AhgpJ4Kted8cwnHXlJdQC7dUiFpuVNUOy/vwKpqep1U0Ue80B5WQQl09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933933; c=relaxed/simple;
	bh=oe0+JV1VGmH2Oziz0rDxTc69NeKMoL9ldZaw4FEpcBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6VG01vJY7cW4rpgZtAsry15wZjeEv/KU9OBxpgMHeia9Lk+R+ZZOiN40ymmdbNvO2iCuJdo99jOPM9pAkmDt1TOVtYL0UMs4BeVrzqhADYUIJOPA1qhCS5jc/xvX1C4tLNuYLRjZvoxiaRWdR9/VjpwgkK62TwK9GzP9GO99xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ht1KebHN; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4a39f7c43a6so163697137.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727933931; x=1728538731; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5vUbpgAuf4ukV4d+K3A2JqlzY0GqMqBxJh0u41jQac=;
        b=ht1KebHN3xRHzRMqyAhhil1V7HCO087ouO3+6v15H4my544SFM50fVQDTzO58JN9JI
         sjRhXjLiMYT3L4DV2gYtkiYbqtJRmGgEd3Xht+kuwGXg8b7rLCfGovYNRq6b5d18TwsE
         BCucIwld2kIEoBpsbUwIk7DLC6KO5UAEK4/uca4RtTGVevMA+UoKHd/xWWFU4nxucYZy
         r/ewwEuH1wbsi5ylzeNVVcnYLDGjA1HN5sqQSa9PC48cOJoiNIntQWKJztL/ZM3lUnhx
         fhVq2fBLIaeMgSp2z6JqOlW+FjqfwFOgN3uzuH2y6lwss4mHbpw9osaBzhcEN1IS60eU
         2PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727933931; x=1728538731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5vUbpgAuf4ukV4d+K3A2JqlzY0GqMqBxJh0u41jQac=;
        b=O9U8+2uoZRLeOPXAYbs3Bd1N43Pt4VcInKlCMVic6yr7qzjMXSdlQiYGCnu42aZPyH
         Njo2adFxi6MpU0xDm2gtZydhI6FZROtfS/3nfnsdn8Ez8y8wb05K16sa507iN1tvvf0U
         uHjF2i+ARxB3HvEiJxR9+x2ehpDaO8wVfQG+S+CpyOfHmOD/FRP3prfSy5pStmRHgln4
         uUrMJ+fu1kXWMGBUUOW9CzDHXSNqxz/tw9xWuhi+TcOzEnfoPqWX9CZ8k4O02vagKEqH
         WBcZKBoUePSmzNxWFBr1Rz/Y7LrgXDy1qwMZnciOvpL8eKLcP3SfFh9aOBtAFfhmLjeV
         Gnlw==
X-Forwarded-Encrypted: i=1; AJvYcCX437Umk89HTXuAiEPuf4H48OQigE7VBAXbd8jqpEdOSNhdqJ5NFDoNIPYHFLgSSwVFJtnm2s/OOn7MhtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCRXWwELMKd6u7111pirZqXYQB6EsfixysPHs0o/MxEgYfbyf
	EKg8PlFEazEi7uFc+/HjgmHVEkHPym7zM1ucHDJztQPm8E9Qhs2CUAQB62pL2busg11eIXyZLAL
	fYn2gPQByu45TGNHeKwfK7Laszi9E+xfm74tUUQ==
X-Google-Smtp-Source: AGHT+IE/udGm3ds/9p2RO6rOSEFkpb2M7UEn+Fb2vf0HPMu89AA8Y6YrRw6hQK0Vrjj2Jj6Mauzen3zuBjj6b49BXG0=
X-Received: by 2002:a05:6102:c46:b0:4a3:cfa9:6c84 with SMTP id
 ada2fe7eead31-4a3e680c40dmr4484322137.3.1727933930644; Wed, 02 Oct 2024
 22:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvo5npQ3o_vgiOX2guHtgafRoFPL__4O8Kcwg2=ssXmKg@mail.gmail.com>
 <e718bc99-e63b-4adb-9e40-2379f48301f5@stanley.mountain> <b22dbfe2-dd29-40de-a4a3-4a0d6b55cd65@stanley.mountain>
 <62a65418-2393-40ec-b462-151605a5efcf@stanley.mountain>
In-Reply-To: <62a65418-2393-40ec-b462-151605a5efcf@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Oct 2024 11:08:39 +0530
Message-ID: <CA+G9fYvdzY+vWhPKPmyPDJNDqvH7AaU4HfKTFtgUwU+KTrD9_Q@mail.gmail.com>
Subject: Re: next-20241001: WARNING: at mm/list_lru.c:77 list_lru_del
 (mm/list_lru.c:212 mm/list_lru.c:200)
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kairui Song <kasong@tencent.com>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 16:58, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Oct 02, 2024 at 02:25:34PM +0300, Dan Carpenter wrote:
> > On Wed, Oct 02, 2024 at 02:24:20PM +0300, Dan Carpenter wrote:
> > > Let's add Kairui Song to the  CC list.
> > >
> > > One simple thing is that we should add a READ_ONCE() to the comparison.  Naresh,
> > > could you test the attached diff?  I don't know that it will fix it but it's
> > > worth checking the easy stuff first.
> > >
> >
> > Actually that's not right.  Let me write a different patch.
>
> Try this one.
>

Thanks for the patch,

I have applied this patch and testing is in progress.
From last night the tests running in a loop did not find the reported warning.


> regards,
> dan carpenter
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 79c2d21504a2..2c429578ed31 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -65,6 +65,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>                        bool irq, bool skip_empty)
>  {
>         struct list_lru_one *l;
> +       long nr_items;
>         rcu_read_lock();
>  again:
>         l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> @@ -73,8 +74,9 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
>                         spin_lock_irq(&l->lock);
>                 else
>                         spin_lock(&l->lock);
> -               if (likely(READ_ONCE(l->nr_items) != LONG_MIN)) {
> -                       WARN_ON(l->nr_items < 0);
> +               nr_items = READ_ONCE(l->nr_items);
> +               if (likely(nr_items != LONG_MIN)) {
> +                       WARN_ON(nr_items < 0);
>                         rcu_read_unlock();
>                         return l;
>                 }

- Naresh

