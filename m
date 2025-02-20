Return-Path: <linux-kernel+bounces-522761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA757A3CE3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2BF176C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C633985;
	Thu, 20 Feb 2025 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJS89Pjw"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E4A29
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012636; cv=none; b=gV60HRavBJKlrKLa2PCEEkDB6TkNUfkCQ2OyUWf7hepvgqF9YjTDjsEUX+Aw/Tpoma31vYaEXnb58GqZ9hRxJi+JzghIoPUg0SFB71rY5TgHe4sRocmtmkXbgccV7z5IxrJU+JLY4kZsbIk2gw7qQMVyCx1DR1cRnV7FFd/agoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012636; c=relaxed/simple;
	bh=Xum0LGktGzP9b1Ps7W3R57YbTvE6cXnioH7PiaTA9kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEff7HiEYmghIDPY3QuoHmYnaR/DUTuXHL2BBdxBtpcWvr8BDyV4SO6sFSRY05cuidwLpGwzWZGj82ZaLwHECISu0W3Aoedeg80/mUu2ItAZNAWA+bKPykauz+muDQ5U5DPsYH/w9lCOCj5s607YIu/Kp7Uvoxz9yt1pdpJEg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJS89Pjw; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4bd35d4407aso142231137.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740012634; x=1740617434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViaHEAgtY0bIqqAVGwRfr/226V3ljcm3B1tMPGMv7p0=;
        b=DJS89PjwievM65znatJFA+AFlExLxU8GM1IlihXpmt4N8oiFI+qAUiJRe2b5olFglH
         4tMHniuaf33fY0z9D6PI5/Lxa73e6ZFMtOwOlYQk+j/Tsw3WwwFQvz2xpl/wvGg981bh
         odYAI3GdzyuURUaYYeMPkj+RlM1pW3u+Ma9/ssgkmDOuobwHQKc+I3ZXiLH3q2Kri0fj
         pDcSb22XikVFGQ829/V5TIYZU8Ze5+HyJ601+jO9Ieb/qfkweKG2KHMozbPjkKRmH0vD
         cTEY5yVpZ2wr59ALFtU9LW14Q0TWqJQkj034ALR1xHyHqJSOL07I5Z6SnMAkPzanu/NN
         QKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740012634; x=1740617434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViaHEAgtY0bIqqAVGwRfr/226V3ljcm3B1tMPGMv7p0=;
        b=QGDVSKbx7KR3CpRWqNt23wo2VBQcQXHcBBUd7cjA1r8Gyvd+t807jMEOiCb63BKcQ/
         JSMPpOnwEV459EMwnKMYMuzuhfHV9DIca1r9Lj3WgiwcZN17qf94QwBGS4/azDaKFSka
         bBydo+Z9Cr1uwDolQbuvh4solwLYGSfpo9RzJbJZAmeECZFVQglrnTUuP18Gyrtx7fsq
         XUbP7DKbddvrgOooliSKXiQkkeTXKty6uJrqLwkQbhL2q7Qz93cKl1OW7u1M2Sdkvt68
         udtnsOrz5Ved2END66QyheJUg8LcJWKWFRme3agjjCm3R/5RIxZtTUl4GyE6/tM/2WE+
         uQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4FS0ulL1eniV86c/WmpsDit07hrxsCoKBFAw4Gdpa9WXctsmiKnspZhs1Zl5v8ee0A8rUUR1YFJLBayA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkF9TYuY8WTL2Cyygvf8EincQaRBzixh0suWqSVehcIFvf3Rdg
	+jq1DILeYwtntarEPLwbmDHu0ZZfs/ZokaxaU8TnJgLH0TwNFdbYyE09XPYK8LSZoYwaXlyVDb/
	RTbom7mIZAkoHW+lluW+9EynqLvA=
X-Gm-Gg: ASbGncu6o+b7VU4lm7smgOfKB8W+4AhOMZyhZMnkdq1ZSFBCOv87/I9aZ8ykvc6iSvx
	ZL414Le7ViejF4aiV9FLrOAI4USmNNajny6NbVOPGuFNlHd29r3Q0JAu1lh5pZlT4ey9+zZDX
X-Google-Smtp-Source: AGHT+IEM1XvrN3z5Q1qS0zcqv45QxoPXV/d5BCJrRf13CQ/gKhU/g7bHaQ+sEqAD7d3qkgaU4dxYyiCvboV8YS9kOTk=
X-Received: by 2002:a05:6102:5e81:b0:4bb:edc9:f94b with SMTP id
 ada2fe7eead31-4bd3fc7a620mr12175703137.5.1740012634268; Wed, 19 Feb 2025
 16:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219112519.92853-1-21cnbao@gmail.com> <Z7Zbz7_39JZgdLYa@x1.local>
In-Reply-To: <Z7Zbz7_39JZgdLYa@x1.local>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Feb 2025 13:50:23 +1300
X-Gm-Features: AWEUYZmP55ZAL8_aDG4KzX7jajVJSdQhQ0Of-FQ30wRO6SZTV4WNYl3ycgx8GJo
Message-ID: <CAGsJ_4xDX5QFNemckan6FoeEoA8tU75HyX+viVdec2b0qLbPYg@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters swapcache
To: Peter Xu <peterx@redhat.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, zhengtangquan@oppo.com, 
	Barry Song <v-songbaohua@oppo.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Axel Rasmussen <axelrasmussen@google.com>, Brian Geffon <bgeffon@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Nicolas Geoffray <ngeoffray@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Shuah Khan <shuah@kernel.org>, ZhangPeng <zhangpeng362@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 11:31=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Thu, Feb 20, 2025 at 12:25:19AM +1300, Barry Song wrote:
> > @@ -1079,9 +1080,19 @@ static int move_swap_pte(struct mm_struct *mm,
> >                        pmd_t *dst_pmd, pmd_t dst_pmdval,
> >                        spinlock_t *dst_ptl, spinlock_t *src_ptl)
> >  {
> > +     struct folio *folio;
> > +     swp_entry_t entry;
> > +
> >       if (!pte_swp_exclusive(orig_src_pte))
> >               return -EBUSY;
> >
> > +     entry =3D pte_to_swp_entry(orig_src_pte);
> > +     folio =3D filemap_get_folio(swap_address_space(entry), swap_cache=
_index(entry));
>
> [Besides what's being discussed elsewhere..]
>
> swap_cache_get_folio() says:
>
>  * Caller must lock the swap device or hold a reference to keep it valid.
>
> Do we need get_swap_device() too here to avoid swapoff race?
>

Yep, thanks! Let me fix it in v2.

> > +     if (!IS_ERR(folio)) {
> > +             folio_put(folio);
> > +             return -EBUSY;
> > +     }
> > +
> >       double_pt_lock(dst_ptl, src_ptl);
> >
> >       if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src=
_pte,
> > --
> > 2.39.3 (Apple Git-146)
> >
>
> --
> Peter Xu
>

Thanks
Barry

