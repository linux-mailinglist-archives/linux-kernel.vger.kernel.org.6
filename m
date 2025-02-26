Return-Path: <linux-kernel+bounces-534399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCECCA46644
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294F13B4A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F821CC4E;
	Wed, 26 Feb 2025 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvBkzsM7"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D821CA00
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586299; cv=none; b=ZnzryoWX1YiYzjwCZVwSTHjV1az18S2vJN49ZCQRp7Tnje42d/sqkyEowiEMvrNoqxdYcO84jigM+A1Y4nOZEQOxTQYgNF4aHn9GAjPIwZfKBRfk/tpjTXs91mjSqw7m1Jx8+E3ncO1zfN1I5bhXBW2+vbUkBSxoHOEk6HrwF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586299; c=relaxed/simple;
	bh=dH1lZGfqkY77W5rak/40PWa9BWM0DlLGX1JaYJXfMzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Q1b9EiiZdPOYUlf1d6aGFm9BxL9a0YArYaKe7A3+FNEYP5kKupWUgJ2Havprj2032yHUeZowHR33r7+5ToKAooEyDx9JV+8n6klnTsf8iHZxHe56BVdndEuL2NAsDFNWNvQpCQm4jyW8EJxhW5M6it2g5Fb46DFplI286uPhTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvBkzsM7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-472098e6e75so322831cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740586297; x=1741191097; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwCHfbhicWcn2tnaux2bdmjEmUqHPAmz5QiamhshwXM=;
        b=vvBkzsM7p/uKWW49VUlA+Iw7vsW4rq40TXTvxK7NeOt81NgptCIkMV8hsAILvEndOb
         0l/ekM6Q+haoLzxGfMDmaLBZI10j9nTnP90yBk20vX7qEO8/zp0+Qs/r57FvE4Pw1LdS
         8t3sYbRevRqSfi0wSyLI2FX658LffktXIa//liFrDRL/KtpNKTvX6ldyp8Vhesqn4peQ
         EWNIUhXS+VuBmFyFCrXooma5N0NzdL4v5Ge5O8JAYe/o/Fvf9FkY6+4Xe664+HIg5u3I
         Y72w672oxqIeM6X+zLeI9lbM6ACQ4Jcg8cjKEguWNBJQhRWgMaxNXsV4cIzYwwn+dIR5
         6I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586297; x=1741191097;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwCHfbhicWcn2tnaux2bdmjEmUqHPAmz5QiamhshwXM=;
        b=fVwFixYv6kAWFoHRWsSXgWnJRS34zNrxpGb8+CJqdTiICjfMNZNHNiRZXcb7aAcFCk
         SM7GHgZ31Cs64FeA73lXffFxaUPGUM+ZO6BZgYPLHZOBW48KpCSQ34nJMBsHBQZ6yGsK
         YVfF1PGn+si7VkkI9g2ei3gXZBElXBuNUx4TRHpUC8bjpzTg2B2WFHAde0uL5ql2CPVE
         WRjMtMdoY8hdke3pBwDFyx38A6+cRbTKy8mHEzeurWNK32IgeJB4Ua7R795V6TNTtlzR
         VVyVyQKQMl294g84dPE4FONKMhdn632HLHgUuXvahPJ0RYXhG9Eue7krrZ2RXeDt4GO9
         N5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCXaVZUClaVbqDN3Uvh/A1W+n7NetKVi/mQ5mL8/0D/F6XAo77Y4L7cllDdsjH8flNM2fmziVT+VFZgsACI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5oUEaIpi1vEoKnBwxUSvdCqo8ReLrtlH/E3Eac4ICaf/Ej/z
	r66Cix78vc2/4ClrQxaodRqiRmLkYQrZKkDEKL0S1bN4UbpXFV6mNPLFatn/BzeyJ4XaEGEiCZS
	RqSqwXrzG6MN8xOknEm6AlK6BwPrmW4VH+/6F
X-Gm-Gg: ASbGncv9dcPNpaDhQo8ENHiJcRb5QPJ+ta1Q5r5HyNDzB9WTDh51e07jjmIjew1Eq77
	tYje9AVjFh8cogjSkl3tWbE6cxybJKYQCT4b2i0sqP4Fa0aYr5v509IwVWC0vCc7gl3rPy67bCQ
	Nt2p8+oMI=
X-Google-Smtp-Source: AGHT+IFiCKmdVbYOt2KP//r3n7xxDe7R+UyaTUbVNy3crUUGmdiA3FmByLxZ4eeouS76WocPmOIKx6AeTUR+VOuemys=
X-Received: by 2002:ac8:7e92:0:b0:471:f437:297b with SMTP id
 d75a77b69052e-47376e6ef47mr10126811cf.10.1740586296675; Wed, 26 Feb 2025
 08:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225204613.2316092-1-surenb@google.com> <hdcrjkqb4cevovpw5xprkh7ohykqay5ew27sbtpzg2k7vrm7mx@6ircmivkmkgv>
In-Reply-To: <hdcrjkqb4cevovpw5xprkh7ohykqay5ew27sbtpzg2k7vrm7mx@6ircmivkmkgv>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 26 Feb 2025 08:11:25 -0800
X-Gm-Features: AWEUYZmlMJKFg0nI_cM2J4ea8f_p7WdxOS84BPznEIazPvAF6Hulb6PhIwxyaZA
Message-ID: <CAJuCfpGu3Gx-kCChgQjZMQNOxU=CqzkHuoghfNmbv+Q1UKYPxA@mail.gmail.com>
Subject: Re: [PATCH 1/1] userfaultfd: do not block on locking a large folio
 with raised refcount
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, lokeshgidra@google.com, aarcange@redhat.com, 
	21cnbao@gmail.com, v-songbaohua@oppo.com, david@redhat.com, peterx@redhat.com, 
	willy@infradead.org, lorenzo.stoakes@oracle.com, hughd@google.com, 
	jannh@google.com, kaleshsingh@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 6:59=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250225 15:46]:
> > Lokesh recently raised an issue about UFFDIO_MOVE getting into a deadlo=
ck
> > state when it goes into split_folio() with raised folio refcount.
> > split_folio() expects the reference count to be exactly
> > mapcount + num_pages_in_folio + 1 (see can_split_folio()) and fails wit=
h
> > EAGAIN otherwise. If multiple processes are trying to move the same
> > large folio, they raise the refcount (all tasks succeed in that) then
> > one of them succeeds in locking the folio, while others will block in
> > folio_lock() while keeping the refcount raised. The winner of this
> > race will proceed with calling split_folio() and will fail returning
> > EAGAIN to the caller and unlocking the folio. The next competing proces=
s
> > will get the folio locked and will go through the same flow. In the
> > meantime the original winner will be retried and will block in
> > folio_lock(), getting into the queue of waiting processes only to repea=
t
> > the same path. All this results in a livelock.
> > An easy fix would be to avoid waiting for the folio lock while holding
> > folio refcount, similar to madvise_free_huge_pmd() where folio lock is
> > acquired before raising the folio refcount.
> > Modify move_pages_pte() to try locking the folio first and if that fail=
s
> > and the folio is large then return EAGAIN without touching the folio
> > refcount. If the folio is single-page then split_folio() is not called,
> > so we don't have this issue.
> > Lokesh has a reproducer [1] and I verified that this change fixes the
> > issue.
> >
> > [1] https://github.com/lokeshgidra/uffd_move_ioctl_deadlock
> >
> > Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/userfaultfd.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 867898c4e30b..f17f8290c523 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -1236,6 +1236,7 @@ static int move_pages_pte(struct mm_struct *mm, p=
md_t *dst_pmd, pmd_t *src_pmd,
> >                */
> >               if (!src_folio) {
> >                       struct folio *folio;
> > +                     bool locked;
> >
> >                       /*
> >                        * Pin the page while holding the lock to be sure=
 the
> > @@ -1255,12 +1256,26 @@ static int move_pages_pte(struct mm_struct *mm,=
 pmd_t *dst_pmd, pmd_t *src_pmd,
> >                               goto out;
> >                       }
> >
> > +                     locked =3D folio_trylock(folio);
> > +                     /*
> > +                      * We avoid waiting for folio lock with a raised =
refcount
> > +                      * for large folios because extra refcounts will =
result in
> > +                      * split_folio() failing later and retrying. If m=
ultiple
> > +                      * tasks are trying to move a large folio we can =
end
> > +                      * livelocking.
> > +                      */
> > +                     if (!locked && folio_test_large(folio)) {
> > +                             spin_unlock(src_ptl);
> > +                             err =3D -EAGAIN;
> > +                             goto out;
> > +                     }
> > +
>
> Reversing the locking/folio_get() is okay because of the src_ptl spin
> lock, right?  It might be worth saying something about it in the
> comment?

That is correct. We take both folio lock and refcount before we drop
PTL. I'll add a comment. Thanks!

>
> >                       folio_get(folio);
> >                       src_folio =3D folio;
> >                       src_folio_pte =3D orig_src_pte;
> >                       spin_unlock(src_ptl);
> >
> > -                     if (!folio_trylock(src_folio)) {
> > +                     if (!locked) {
> >                               pte_unmap(&orig_src_pte);
> >                               pte_unmap(&orig_dst_pte);
> >                               src_pte =3D dst_pte =3D NULL;
> >
> > base-commit: 801d47bd96ce22acd43809bc09e004679f707c39
> > --
> > 2.48.1.658.g4767266eb4-goog
> >

