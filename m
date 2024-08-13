Return-Path: <linux-kernel+bounces-285025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD8695084D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A0A1F217B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB4719FA94;
	Tue, 13 Aug 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="funkKdZy"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703619E802
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561110; cv=none; b=q3ugIOd9VUnyzS3MBvj10AexAquNDKrdveeSVRzhxOm8IzcOIOLAvBFYmbWme2DvdAZ1PxdACtZ7uSR8decFGwQ+sbjh9FUHrG5GbFkiEHOLrJWxFruRh0hbRtlFiDdaHkG7G9NM6dJmoGWPagWOB9jMi0S7MvAEfZEKcV7BXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561110; c=relaxed/simple;
	bh=L6Olp5UP8QBsMWyJGhbECCr3P6Sz1Ya5nM3gbCxFOdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUSoVgVlRQucr9Ug3f7ZdFbC7VqjeXiTxyOf8DLEe7RYvQmaF2IlsEl4KqFjbRVJvr0dDkUxQ9d5CjKQGSbnP11ZDyu+6I6QdWFIHfiY1ag7R9dH1dOi66wXb8yYBBmBbg7ELvHNo41RQNhOzv25GFO9cU3Mxz0sZoJYWg1ejRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=funkKdZy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so7332a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723561107; x=1724165907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Px8iqdxxWIK7rvwP9ZrwWvLe40dNsz+A9PyUAYGuJmc=;
        b=funkKdZyW/axRM7uP+DiSJ+A67uEWKicojhZSaudI54RaxHvT8YrYuxN3ZAlzUjp/B
         CUzFixTyWlUmy//wOvdYsHe+VYtSdP/p5rmgaYLf/hXYyab2kcUTO1CdSO64jH95Cajw
         ZO9aQaYZUVc93bYYrkTYeLjsD0Ty0gCOmngqGtmcnXAwx502wcKvWFTLMcMDbfWx6BhO
         upnOQlJZm2w3iyxr8Z+yLQzaU8rLCKnUyDUsPi5NwCSTEAERGuf+MbuSPZ+e2ejQiIDc
         8cH+67ZIVX0A54f1fhlRiUJcQ24YVULEXV7AlnpOtqKw+v9w6LJIy8xcaQlvnVOJCQnv
         41pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561107; x=1724165907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Px8iqdxxWIK7rvwP9ZrwWvLe40dNsz+A9PyUAYGuJmc=;
        b=pSwPMex7SAw3gXup7yPc4kQvHquyFQMnAFTSCxdwIUAXbLDCrk2I+wH0gxrKeW++Ww
         tP5Ts1H1lT+zIze1wMoDmLc9WzzyTYpzTbMYQosHASiaoazU20V6ej4d57dwt2wtqRKA
         XvMk58g8ceOXwKlE/DEeHjMA2vyfybdXjqlQkbJcb/qXxW1e/+RLIG9k4DQSpi2g4jFi
         o15YzA4CbHzLFoxqEXJCRGUaq9I2JMI81JJk5q785eMqVlNf0rVbAf02WWLfjfcY50MM
         AxmslqhQoNP1MEHf77Us8fDV0TdAU7UQtjpdSl4fWZ/WvL5mqaP27Az3guP0y2rJoOGy
         qPcA==
X-Forwarded-Encrypted: i=1; AJvYcCVbgU397+PD5HeT2sGLPXa/vo5LSKRVi3haHZuUiL9AdCWqBOGKNEuc1EiR3+94KgcgrclRcoIFBsKylkTCiz8pmS/yQv+syvtdj1RH
X-Gm-Message-State: AOJu0YymztueA0c9cpIHMA2Xq624IxmWbYXf6TB4s3qvfKh2enDtjUF6
	1h22tnh4e/k+5nCwpQIzAny8RGSWdFDZbLc3vD+VneukwaJNEgGgoa9NF26Du8Dq//zA4V0PlXc
	BEBTou1pjMNhlnlF7YkikvMZlM8EA2cnkeaXf
X-Google-Smtp-Source: AGHT+IGOsd8SzOXCFhPWeyAenAK6WO3rwmgPcyiNCHk3I9lmR9JbamLzSgDR2g8gJ9VBCKK9WwmsBSAZFt+lugxKjpI=
X-Received: by 2002:a05:6402:3493:b0:5b4:df4a:48bb with SMTP id
 4fb4d7f45d1cf-5bd471c09a5mr98555a12.0.1723561106621; Tue, 13 Aug 2024
 07:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
 <20240812-uffd-thp-flip-fix-v1-1-4fc1db7ccdd0@google.com> <59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com>
In-Reply-To: <59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Aug 2024 16:57:48 +0200
Message-ID: <CAG48ez3u4tCaP6MSjxwqZQ70teFJHag7z9wRmd8LJXXee3tTTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] userfaultfd: Fix pmd_trans_huge() recheck race
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pavel Emelianov <xemul@virtuozzo.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 8:19=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> Hi Jann,
>
> On 2024/8/13 00:42, Jann Horn wrote:
> > The following race can occur:
> >
> >    mfill_atomic                other thread
> >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >                                <zap PMD>
> >    pmdp_get_lockless() [reads none pmd]
> >    <bail if trans_huge>
> >    <if none:>
> >                                <pagefault creates transhuge zeropage>
> >      __pte_alloc [no-op]
> >                                <zap PMD>
> >    <bail if pmd_trans_huge(*dst_pmd)>
> >    BUG_ON(pmd_none(*dst_pmd))
> >
> > I have experimentally verified this in a kernel with extra mdelay() cal=
ls;
> > the BUG_ON(pmd_none(*dst_pmd)) triggers.
> >
> > On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
> > pte_offset_map[_lock]() to fail"), this can't lead to anything worse th=
an
> > a BUG_ON(), since the page table access helpers are actually designed t=
o
> > deal with page tables concurrently disappearing; but on older kernels
> > (<=3D6.4), I think we could probably theoretically race past the two BU=
G_ON()
> > checks and end up treating a hugepage as a page table.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_=
COPY|UFFDIO_ZEROPAGE preparation")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >   mm/userfaultfd.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index e54e5c8907fa..ec3750467aa5 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -801,7 +801,8 @@ static __always_inline ssize_t mfill_atomic(struct =
userfaultfd_ctx *ctx,
> >                       break;
> >               }
> >               /* If an huge pmd materialized from under us fail */
> > -             if (unlikely(pmd_trans_huge(*dst_pmd))) {
> > +             dst_pmdval =3D pmdp_get_lockless(dst_pmd);
> > +             if (unlikely(pmd_none(dst_pmdval) || pmd_trans_huge(dst_p=
mdval))) {
>
> Before commit 0d940a9b270b, should we also check for
> is_pmd_migration_entry(), pmd_devmap() and pmd_bad() here?

Oooh. I think you're right that this check is insufficient, thanks for
spotting that.

I think I should probably change the check to something like this?

if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
pmd_devmap(dst_pmdval) || pmd_bad(dst_pmdval))) {

!pmd_present() implies !is_pmd_migration_entry(). And the pmd_bad() at
the end shouldn't be necessary if everything is working right, I'm
just tacking it on to be safe.

I'll send a v2 with this change soon.

(Alternatively, pmd_leaf() might be useful here, but then we'd have to
figure an alternate way of doing this for the backport.)

