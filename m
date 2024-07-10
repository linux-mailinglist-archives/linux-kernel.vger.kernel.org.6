Return-Path: <linux-kernel+bounces-248018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55C92D775
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07D4BB26390
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B0195809;
	Wed, 10 Jul 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uADhgHFF"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D619539F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632560; cv=none; b=hH296DdjPjJqpukZdFbj4p/1HxKqw3I7SnOlJ2vrv1s50xcdvuuhLFAm+N7WIUq4R6BoqJP1Sr6MzwSTNL/sUlPF8elZkDRkQOC/P1A0JEmraVe+TQApO6zgEnCp0j15A107nIhT0vTTeAJAi+/ykSwLin6+KB/VHmctAKOxVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632560; c=relaxed/simple;
	bh=07CFIh48UVDQo3/6l+jorZzGDNHXB5XF1EuHgydrehY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uC3z/JbFbZ3b0+hP9Gj/qTnxBHuOHdKeDval7ALljmRCfMKYbIziCYYTPkBHq5BgaQenrVWh9bpyhfWklDILfCmIfIKASFbBo9j59BMELhV0HHpbP5em1lmdwUIad9ndzdgJTsFhZsL1PmMPu6vP1NIWL7W/DGUR+/CAwYpzOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uADhgHFF; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-651da7c1531so47617b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720632557; x=1721237357; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3iXewCGk4UXaW4hocBhxSKfcWdGSVP/acob1v9TkqC8=;
        b=uADhgHFFin7sjv/RQpux011yayLfpRkYhMRwYG176hg1cdqVz5Wze1X08ULjd+S6LZ
         O3O93qIUtBtjdXJwUt/7wMvj0J5rM2PUKGu0Ev/iKh09tXFrgLFwc6401YU3p12JNwq+
         jn0ZlcNy7SkLmhdatFBEdj+SoajyfFbZdFCBFToBVPGNQhvzDSV0oOmGbzYUo/gyHqYB
         Lyzd+7JawKtrOK9rsFe4pfnOaVWiDPfzQ8rPCXUHJTA3MmY1+VW4ja5J4qetGKAo7kkU
         QtK7Afm1PpRSGH0C6nMjrUEeVIuI2VVviB/B5VSShZyM9ffXkZl6AteQ5KUz51hqGmrn
         RRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632557; x=1721237357;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3iXewCGk4UXaW4hocBhxSKfcWdGSVP/acob1v9TkqC8=;
        b=YTiUyqiOLoqB6r2LLW6xvjP7sET7F55lbfVLuQq+SORyTzL89uC2NEJPerbLggacmy
         AtpsIf37lLbktNbVhXjZYB1PzwQqlooJMKmunPlYIqXLAGK6WqCvAbr00Zja2GApLEBM
         aFypSHzsyVLPcuTfqtgW6EiCKwwY53z0Fpl1CFJlfFEVxUM+R4CG2MIakNskcjLMUkRk
         M4d2JPRZew6aOmo841/93t5sJhU707ZitcjzyKq4Qv5bVYAZw22xIdjzmOMOEAJ4+dxD
         p9RvnxxfxwVFrP8AklwqRmfaFzu0QsIfLYkcUg1tvSXRn5elmCpo/8qQ2glgwjHfKHU9
         0Osw==
X-Forwarded-Encrypted: i=1; AJvYcCWOmKc6UkNIwoQoH9rmIJaE/4Dao168BCbRH1Bo/1X8QinrtmdvfLmYGUq9Kr98e3+8Gqxp2sjMnNyD0Mw6Rp8iSDetvOz/6g2T8Mxw
X-Gm-Message-State: AOJu0YwpSrUjmOwqHbWFPC44T5zit0Irik6+E3IDpnAhTkkmdr/1o1oL
	LZ/OFl5NyMvoBeVHGmQ54u/2RwODH3pURBQpeySHf0mNuKsf4gYoP4WMHmujrAGdVU60owSDjUV
	Y0QzgK0royIDcPKZFAe7qwonFtWTVA4CNhyfB
X-Google-Smtp-Source: AGHT+IEIDiCBHmmpw23IGTQWJ41MQYqaIhSIDn6iqpEnXhLW5tT7MkOR627Dov6cGq5tnj+GsCRbDY7uModenssyYUw=
X-Received: by 2002:a05:690c:630b:b0:64a:3d6c:476d with SMTP id
 00721157ae682-658ef24af88mr78735977b3.25.1720632557191; Wed, 10 Jul 2024
 10:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-7-Liam.Howlett@oracle.com> <f12e65e3-adfb-4140-9aaa-e7b11cab972d@lucifer.local>
 <l6j7mytvepxnpxzq6i4kru4datfxhijf44lzugltbxs5f23f6i@lsfcft2tkg7j> <CAJuCfpG0UQwuuw=u+J8E3=CLKBzFuE=YLh=Hi9eebD9yZHcntg@mail.gmail.com>
In-Reply-To: <CAJuCfpG0UQwuuw=u+J8E3=CLKBzFuE=YLh=Hi9eebD9yZHcntg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 10:29:04 -0700
Message-ID: <CAJuCfpHo2DY4XeR74tSpjcAN+qBfSDzCyi0mPqO-49dZts1uXg@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] mm/mmap: Change munmap to use
 vma_munmap_struct() for accounting and surrounding vmas
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:07=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Jul 5, 2024 at 12:59=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 15:27]:
> > > On Thu, Jul 04, 2024 at 02:27:08PM GMT, Liam R. Howlett wrote:
> > > > Clean up the code by changing the munmap operation to use a structu=
re
> > > > for the accounting and munmap variables.
> > > >
> > > > Since remove_mt() is only called in one location and the contents w=
ill
> > > > be reduce to almost nothing.  The remains of the function can be ad=
ded

nit: s/reduce/reduced

> > > > to vms_complete_munmap_vmas().
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > ---
> > > >  mm/internal.h |  6 ++++
> > > >  mm/mmap.c     | 81 ++++++++++++++++++++++++++---------------------=
----
> > > >  2 files changed, 47 insertions(+), 40 deletions(-)
> > > >
> > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > index f1e6dea2efcf..8cbbbe7d40f3 100644
> > > > --- a/mm/internal.h
> > > > +++ b/mm/internal.h
> > > > @@ -1488,12 +1488,18 @@ struct vma_munmap_struct {
> > > >     struct vma_iterator *vmi;
> > > >     struct mm_struct *mm;
> > > >     struct vm_area_struct *vma;     /* The first vma to munmap */
> > > > +   struct vm_area_struct *next;    /* vma after the munmap area */
> > > > +   struct vm_area_struct *prev;    /* vma before the munmap area *=
/
> > >
> > > I mean this is about as pedantic as it gets, and, admittedly an annoy=
ing
> > > comment to make, but the ordering... can't we at least put prev befor=
e
> > > next? ;)
> >
> > I can do that, no problem.
> > ...
> >
> > >
> > > This is a big improvement overall, very fiddly code.
> > >
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>
> >
> > Thanks!

