Return-Path: <linux-kernel+bounces-435259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA419E7536
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19691885ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78B520D51A;
	Fri,  6 Dec 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G0WD0QjZ"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA9417A58F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501498; cv=none; b=OiijQkqYa0/cjQsmF5k0kO0IxfMx441VieKZ41cnWxBjI8Sw40wzo9C5Pmow0GERUsMNtQLRy93txxJafuK8gUCVyQUPQEtu6s335vMZYiEhZn9tK0gDXr2FTfDuelRHwQmU7GVc5YhFDI5WF6XSlk7zJHhbBfyJwoaV2t8xEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501498; c=relaxed/simple;
	bh=VWYNgE9pKVhQ5OgZIZ9+/rpckIIqRtpv6qJvrXEStuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=HTOybdPy6rBwQIQDMcONNtXUOTcJHrEfECkDYHRkhJGcOOyKwJqMqjxV/t+D+GlcaeZ/lXuehmvztzcUWxF+h45oGK4odT9w7oYbq9IwZ/EIN4658g9DXXr1MYXoxr3XXe+/34J/TlxKmhXxIzzo3sgPjtJuEwVOLOusoniBMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G0WD0QjZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f1ff63fe9dso55873eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733501496; x=1734106296; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA+yFZiEQVvPrNXcoRRU+QeTGgabAJXB1krFWBWZtOw=;
        b=G0WD0QjZiRTtuNDBfMrilEyOhizZFGDnIPQfhHfikTX3y7e0BNtwd/cY+Le7EhOE8F
         ApD0tIZz6HO4I9FvfQaaLz/skscuOjo7+Xo4rjtNEkYYkpLYSbkDO4pnYEa7CUwM6hrD
         UwOOkFSAHWj6heI0xmNktbuD3YCQDk6lMZc94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501496; x=1734106296;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA+yFZiEQVvPrNXcoRRU+QeTGgabAJXB1krFWBWZtOw=;
        b=t4RA5c8KnrWajdn9yQcPGT1lIzYEtDrWP+Jx19WAGoVNQbmY+blEL0Oa2DOvRUW8hJ
         hTgNBZ6MzCDbulg398RzKrRL5Ugr0rqO5Jw2WIL0/g1k0WOgcw9t3Ln/xT1OOnViLL2g
         JvS+Vqf7BmvWd5fmbKYBcriCIpAGWBPBmhSngux6jf+5yKxkpzQh4Ha2cy81v3EEw3yC
         yVTPkeGEF/3y7nKqYo52iJ6/IS9U1HsCoS+YrTZ400ANNHBg41Q41ZJ7v4i3cRflWXMt
         7vbXbk1RMvXWke39KS4lXoeHxi99yzN6JmF5BlnOEw0Bxm7i/JDbwZZvj4bIGVrikqid
         bWww==
X-Forwarded-Encrypted: i=1; AJvYcCVDMA8QXA9LJf1GJ/suVX86e+kzLRHwqNA5iVre9e/LeQQAiH8jAB/ybgId0dLLDrCkN6va0dYj4jmXMfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjM1SA0qTc8jYdbdkt5x98Zl/KDbBlFGbJywXeEVhxxVR5FNtp
	vob7q+2DOwU1gh+NPnqS40GCV6AtZU/49l1xjS357b18ZB7wHksZJLLEFLycA+MS9sKpU0F4SVt
	+29DyCgHuDSczK8dSYeKfTbUNl8l5/BVseveJ
X-Gm-Gg: ASbGncu/KNNMKhx6iBp9yAYQiJGasyIBgkxsBsSyN54QQZtHeVb/UiI7OGvh8gFPgs8
	kD+kt/g3NGTwAmWz30ZAjVfHd+dM7VTGNmZsOBLh/tU4y1oDj3dJyHF+avCw6H6o6
X-Google-Smtp-Source: AGHT+IHaYff3JMPT81zyBSEM23QKqUx/UbkJQeJCV7Wp12IwDITkCTMpge+kUaz3qXTSTl0EJTZtDpiCttRvnyLy0H8=
X-Received: by 2002:a4a:eb19:0:b0:5e3:b1fe:b1a with SMTP id
 006d021491bc7-5f28700e98amr559652eaf.2.1733501495628; Fri, 06 Dec 2024
 08:11:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206013934.2782793-1-jeffxu@google.com> <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
In-Reply-To: <2m3zmlehfigs5r7rptwcoft3j4fipfkgfxmdrdttpf76hwhwae@vclfa5ulcmv2>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 08:11:23 -0800
Message-ID: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
Subject: Re: [PATCH v1] mseal: move can_do_mseal to mseal.c
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	keescook@chromium.org, pedro.falcato@gmail.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 8:25=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [241205 20:39]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > No code logic change.
> >
> > can_do_mseal is called exclusively by mseal.c,
> > and mseal.c is compiled only when CONFIG_64BIT flag is
> > set in makefile. Therefore, it is unnecessary to have
> > 32 bit stub function in the header file.
>
> There is no reason to keep this function at all; it is used in one
> place, and that place uses three lines of code as well.
>
Sure

> In fact, having it separate from the comment about flags being reserved
> makes the function very puzzling.
>
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  mm/internal.h | 16 ----------------
> >  mm/mseal.c    |  8 ++++++++
> >  2 files changed, 8 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 74dc1c48fa31..5e4ef5ce9c0a 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1457,22 +1457,6 @@ void __meminit __init_single_page(struct page *p=
age, unsigned long pfn,
> >  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *=
memcg,
> >                         int priority);
> >
> > -#ifdef CONFIG_64BIT
> > -static inline int can_do_mseal(unsigned long flags)
> > -{
> > -     if (flags)
> > -             return -EINVAL;
> > -
> > -     return 0;
> > -}
> > -
> > -#else
> > -static inline int can_do_mseal(unsigned long flags)
> > -{
> > -     return -EPERM;
> > -}
> > -#endif
> > -
> >  #ifdef CONFIG_SHRINKER_DEBUG
> >  static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
> >                       struct shrinker *shrinker, const char *fmt, va_li=
st ap)
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 81d6e980e8a9..e167220a0bf0 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -158,6 +158,14 @@ static int apply_mm_seal(unsigned long start, unsi=
gned long end)
> >       return 0;
> >  }
> >
> > +static inline int can_do_mseal(unsigned long flags)
> > +{
> > +     if (flags)
> > +             return -EINVAL;
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * mseal(2) seals the VM's meta data from
> >   * selected syscalls.
> > --
> > 2.47.0.338.g60cca15819-goog
> >

