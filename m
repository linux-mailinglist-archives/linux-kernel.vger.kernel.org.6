Return-Path: <linux-kernel+bounces-338650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D04985B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE5D1F25D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B275199E88;
	Wed, 25 Sep 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZe/bp7W"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14A199937
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265013; cv=none; b=VfZmeF24PCVdfPzBEWfcvvWYmHTD6AE+5ySDOkI2kf45unuT1uJoMUNmauub3Ug4dTX8eC1xJwVcGwBh4ektY5gcmeetdPW1AeGOywSP9jAAljr6B/znu6zCLkPKKdbwgeXkg7MSn4TCnBtX3gsG2/6vN17Ms9j6itH6Od4/R2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265013; c=relaxed/simple;
	bh=H+gsI2joGdRifKrtElCoqBe7xywJACmsoWad01IrgO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twFZXToodG832nQUWAQqYRm6f5iJl2zYjX9skFMu4KsW3V2BTz7kqDooPFmlCrMFmh5c35z0d7pVSW8JmRdTYcawep6eSaSE4k5pzFTMB5sMYVm2CmzZKSsxvS9VmQl9ZSGyP9rR9Y5xthefYsw8tMae209FMBs104kJlzapEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZe/bp7W; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f8c3c83ce0so3350701fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727265010; x=1727869810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axWWiXyzRMbM4Axw/3+vRv92qzmnqSQaWTNdg37rIL8=;
        b=BZe/bp7W71w+CJxjiEC/xgLp8o528DcBPOBjUOl0lwuo6sbzaZpiM5wAs0OcqRHH6z
         AlGKcAb4jVuTlf6M7sauZl4TvjF9GK4Ay/juDx/HhTV0EwxkUEAqsEE5D8Lz42Ey3uHI
         SpaXt1hxcOuNNhvT3mYBYD9Iwxh73+uTgawXQb1mT0P64V9V+s6JQP11QQVGjnZOQell
         EPl9SuoOExg597Y7ms6ExBiOGnQAayN6wTmKrw9xYm8d+Ex/wvJ/ObtaxM5x+DTm6Q9X
         iPqCRescGZx/o6uPsSkHHn6QkZ0ULwVugSydifi7w8d/derA/PIzMro+3eEUDD55u+fm
         k2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727265010; x=1727869810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axWWiXyzRMbM4Axw/3+vRv92qzmnqSQaWTNdg37rIL8=;
        b=gEoQFg6x34P+PQ51QfXMUtZCYvAEJSaOuqSRfUr6hoJDsAm2VzVPvZQiYXDGdURLSU
         QG9TICk+ZqilrXgC5144ijfyGKmJ21PSpXB87htvB96j3oTr6FHo8dhS9+mmBWY9Da9k
         L0esx6pnuJmRLMJ2+BugVPEpf1FOsnXziEaXpawC9p4Lv8pL5HqklQbshReyv3R+khWx
         ycSxp33mAQ/KxzE/DVyZSmFOXK7KFhTN+WNWEXN+VKzr6OoNr5cp2HUc4bS6irYALu2N
         y4DGMLB53HoD8elot3U0awcwvhqcFehoIUrC/hyYRVbzRhWjwWVzyEiw8kqfx4ZbxEUy
         ecLw==
X-Forwarded-Encrypted: i=1; AJvYcCWdSDA8G464rtc2GP13/b5SVBeo9mbnioT58jw4AG7pMn/vMO3TQa5rLYyFtOYEfHXa0N88Vr8a+hEVAOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamGhE9wWODJzzxcZEGBJHwOXiOa0GWUtpnoAR/kR2aP53QqKo
	YnjyX3q+6W4VvRMZG/mXwtXNpVCgSdF+ZM4VKCqMgOvW6R6Z0A6UT4b8IPusB7/KONqe1xlIPJn
	rBwz3QQDGKn9Z4qv9+6RiCNMZ0Jo=
X-Google-Smtp-Source: AGHT+IF8UF9Wbeti2cAKtDua2321UrAXvsnz1+fp+jvpuvrupGkGqOJ1vrY5ZGsW7/LY01nXQcJmi1iha+a+I76tE2E=
X-Received: by 2002:a05:651c:2115:b0:2ef:24a9:6aa8 with SMTP id
 38308e7fff4ca-2f904a76d19mr3985471fa.0.1727265009613; Wed, 25 Sep 2024
 04:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925030225.236143-1-zhaoyang.huang@unisoc.com> <20240925024215.265614f6839e752882b1c28b@linux-foundation.org>
In-Reply-To: <20240925024215.265614f6839e752882b1c28b@linux-foundation.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 25 Sep 2024 19:49:58 +0800
Message-ID: <CAGWkznG40FyJxOzB1jRsBVGPrZhV=ceKWzTQSTq2TbzRLMAZ5w@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate LRU_REFS_MASK bits in folio_migrate_flags
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:42=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 25 Sep 2024 11:02:25 +0800 "zhaoyang.huang" <zhaoyang.huang@uniso=
c.com> wrote:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Bits of LRU_REFS_MASK are not inherited during migration which lead to
> > new_folio start from tier0. Fix this by migrate the bits domain.
>
> I'm having trouble understanding this, sorry.  Please more fully
> describe the runtime effects of this flaw.
Sorry for bringing confusion. According to my understanding, MGLRU
records how many times that vfs access this page in a range of bits
domain(LRU_REFS_MASK) in folio->flags which are not being migrated to
new_folios so far. This commit would like to do so to have the
new_folio inherit these bits from the old folio. Is it right and
worthy to do?
>
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -291,6 +291,12 @@ static inline bool lru_gen_del_folio(struct lruvec=
 *lruvec, struct folio *folio,
> >       return true;
> >  }
> >
> > +static inline void folio_migrate_refs(struct folio *new_folio, struct =
folio *folio)
> > +{
> > +     unsigned long refs =3D READ_ONCE(folio->flags) & LRU_REFS_MASK;
> > +
> > +     set_mask_bits(&new_folio->flags, LRU_REFS_MASK, refs);
> > +}
> >  #else /* !CONFIG_LRU_GEN */
> >
> >  static inline bool lru_gen_enabled(void)
> > @@ -313,6 +319,8 @@ static inline bool lru_gen_del_folio(struct lruvec =
*lruvec, struct folio *folio,
> >       return false;
> >  }
> >
> > +static inline void folio_migrate_refs(struct folio *new_folio, struct =
folio *folio)
> > +{}
> >  #endif /* CONFIG_LRU_GEN */
> >
> >  static __always_inline
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 923ea80ba744..60c97e235ae7 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -618,6 +618,7 @@ void folio_migrate_flags(struct folio *newfolio, st=
ruct folio *folio)
> >       if (folio_test_idle(folio))
> >               folio_set_idle(newfolio);
> >
> > +     folio_migrate_refs(newfolio, folio);
> >       /*
> >        * Copy NUMA information to the new page, to prevent over-eager
> >        * future migrations of this same page.
> > --
> > 2.25.1

