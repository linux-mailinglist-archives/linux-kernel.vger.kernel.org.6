Return-Path: <linux-kernel+bounces-435591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9879E79DB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC851657C7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179E51FFC67;
	Fri,  6 Dec 2024 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JGFY4GgO"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D4145B07
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515696; cv=none; b=kOWJpwrZqUdZWSd5muSdpVGyYWoKCYpTkozc7EHGiSQ13t0mXR6/ByJOcES6BOStC4ozwdepOUHLGb3YDS+qINibaOx+2aR1SP0oLxQwqgU4PdbTgb403r9tBxkk7tCHKlkdSbCQZ/qjTDkmMx75Pdj5juTbln4bbR3ElJCMZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515696; c=relaxed/simple;
	bh=z6Wqxq9GQSt08AJI8CDBz7RuSxWl1N8orrd/oG6fcs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c4C89MZCi+dNoCWe8BN41Lh9ukWx9V8XfQ1MWWW88efNu19pGwFk+3UT2Ewn9Ev9WGUY1v2vrPvHkHzOWV0xJXdofp6w2rs1o6QXWcp6HjCglU43F9zV+T3fx542gnKwocuZGVplg2D0G9KK1so54xCOzPjtDqfJgvCdm6GGrN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JGFY4GgO; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71dace65bd4so340807a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733515694; x=1734120494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa40TeoQXNd/EST0klScC6VWGBe0xBrJUCm38PJDQfk=;
        b=JGFY4GgOLiqZSBfIKXbnLqW6QmgiNmw+XnkbwUH+LGodsRlVC3VeQQz5c1d+UBxpSw
         zLYNCOkuqhdhQvzqbKpfYiAKlUzFm1I+dwfrPEf6ninq9ecKuOqMrUpl+TULOsr97Wl+
         LI/i9cUACxVDNCbhIW4mhniAVbxQQp6s5Wv/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515694; x=1734120494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa40TeoQXNd/EST0klScC6VWGBe0xBrJUCm38PJDQfk=;
        b=CVcU24FJiyIob0wAeBJKwKNpMFLX5YOfF5gVs4zp3/L9oJtrnp4b+l2zsTjXiOaXAh
         jhM/c6cu5Z0GbhjBUIuuz+sn10xZ1yfX4frMydvqz17cJb2eJwbISQ8QGwoqv3AvzKPr
         G0o9qY4wN9T5oEf2hIWLdGv8AsCBPAYWoreq/TwieRT+7iiobnbzlghgjuyuaAJKRkGD
         hwix1AhCSAeNukmbRAAiuA+ipdLCl+If0NiVg7Z89aCAJhisbjNDQqgFd2di4R1IW5Rj
         QQiCQTtN0jsl/JwdrOVyfL2wlpgxbaJQ4z7y6qtLsBuCM0QGTSqexzOxB8d324WZMudA
         gyCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbbZk/EhCJ6unKpsgqIRZt7LZO4V71GrUICBN/7uPRjfnqw/CmBSy2QqLSBzHbbDrP3rACfAeYU3LAO58=@vger.kernel.org
X-Gm-Message-State: AOJu0YytRyifGLQvo67XoqmYcTMlJQ9MjJY2hUaA98kClPnh0s1QSvsU
	4NPkG8e76Y2UdJGDVSOmjdjhVF11Il+GhBwW0FOdv425TEF6P7rEo3NzQ7Rbov5se6YAZ7n4+C7
	FXJ9U2p4zo7+xQ3FbQJM96HTPsczQu3jxKS3z
X-Gm-Gg: ASbGncthksuCMWmjvf4EjATIbAY4kwyPyIR9hyeEH4ldYcBroIMg69mmRrVAU42OTw/
	6e4KeQ1YZmrcMhZnoh6bUInobo6UUNWL9TqTTZbll/L/mYHPrTvmyemkzM6g=
X-Google-Smtp-Source: AGHT+IGnhbchndsxQrpOqmx+L6gEP0mz4KnZxPFnbF3cSlHW3yU9Qu5eUura8Gsl1otfULbbGp1jxsGpXke5kG5WBgg=
X-Received: by 2002:a05:6830:3746:b0:718:ff2:c147 with SMTP id
 46e09a7af769-71dcf56a5f3mr987845a34.7.1733515693797; Fri, 06 Dec 2024
 12:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206194839.3030596-1-jeffxu@google.com> <20241206194839.3030596-2-jeffxu@google.com>
 <607a69bb-9b6f-4d0e-83aa-1ec6903c34a5@lucifer.local>
In-Reply-To: <607a69bb-9b6f-4d0e-83aa-1ec6903c34a5@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 12:08:02 -0800
Message-ID: <CABi2SkV2gSx+5p1uS-YZnD90HzV8ZAFkpbsqSUL5usU+EW8HwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal: remove can_do_mseal()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:57=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Dec 06, 2024 at 07:48:39PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > No code logic change.
> >
> > can_do_mseal() is called exclusively by mseal.c, and mseal.c is compile=
d
> > only when CONFIG_64BIT flag is set in makefile.  Therefore, it is
> > unnecessary to have 32 bit stub function in the header file, remove
> > this function and merge the logic into do_mseal().
> >
> > Link: https://lkml.kernel.org/r/20241206013934.2782793-1-jeffxu@google.=
com
Please remove the link field here when applying.
(I pull the mm-unstable and apply my change on top of the existing commit.)


> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> LGTM,
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> > Cc: Jorge Lucangeli Obes <jorgelo@chromium.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Pedro Falcato <pedro.falcato@gmail.com>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> Not sure you should be submitting a S-o-b for Andrew :P I'm thinking this
> is a copy/paste mistake.
>
I realized where this is coming from after seeing this response.
 Thanks for pointing it out


> > ---
> >  mm/internal.h | 16 ----------------
> >  mm/mseal.c    |  6 +++---
> >  2 files changed, 3 insertions(+), 19 deletions(-)
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
> > index 81d6e980e8a9..c27197ac04e8 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -217,9 +217,9 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
> >       unsigned long end;
> >       struct mm_struct *mm =3D current->mm;
> >
> > -     ret =3D can_do_mseal(flags);
> > -     if (ret)
> > -             return ret;
> > +     /* Verify flags not set. */
> > +     if (flags)
> > +             return -EINVAL;
> >
> >       start =3D untagged_addr(start);
> >       if (!PAGE_ALIGNED(start))
> > --
> > 2.47.0.338.g60cca15819-goog
> >

