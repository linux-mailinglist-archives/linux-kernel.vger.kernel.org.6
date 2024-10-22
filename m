Return-Path: <linux-kernel+bounces-377102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067B9AB9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A55B21E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EBD1CDFB9;
	Tue, 22 Oct 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCSLpsy8"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B361527B1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638288; cv=none; b=Xp3Wxlj833mh1aR6oLfBohMnONdF8A4f+H316Bn+enClpHU+HXjryZWBE7s4AZrMQbPhI9o08uYOdkpQKngWZ2pywjoimsgrd2euLQItMGWDB9Gv+gsTHJEMeycZXBPCmN1oVohedh6ZCBa4luoiLQEjPeRkm1vrWrlXZgvRK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638288; c=relaxed/simple;
	bh=GtQd2yYLPo6ESP5Na+Gt7dWhqJMr9GtZHBn0RzoLfwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpeeIDyl/aDz+bkgIdoc08XVWXTui+HUyEPLNgwL9TfkjxfSvPmlv6RY9NTxBbug6TTZgVRsc4g+U+qXpQJKjdPAeuuZs9JX/VU99cvIUt5j/65yN5dBYuEIRAAyPkh9ayjXBws0rcdEdICCxUQBrN9sfRcVxCZZeSz0YoX58vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCSLpsy8; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4608dddaa35so126921cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729638285; x=1730243085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bVSD09bB3faYt4CVbD26hdRycfzJMqJ+dyf4YHR0wQ=;
        b=tCSLpsy8W9X3iTKxDDopsf2dxx8+WDgswvVRZVMzpf5dbAaSQa7+Lt8g4w0PivXg1Q
         b/1QegCuE55iroe4N/W+v/L1OcuGnZwdJTKKLb5HRKuDR+Vy4GROQ85/FddjpWE1cz9Q
         gUerdIqh68wQpH3OPQhlAPQm8M4g5ngqLCpYKW7W71WPR0sJKBujMzX728QSF00szU1K
         CjZ+Azyk7Gjhg1J5qmWPhONtPu7tdszO6vP5gqIjT/qNJTDudBjFdJWPrTdBCjTz4Y9R
         Ckx5aMq4cNhMmqeA+SVIMNCsGnpuGhGNo5yM272ANrlVXJ6uQOQTdAa5EUEuN/k/Q/gA
         P24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729638285; x=1730243085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bVSD09bB3faYt4CVbD26hdRycfzJMqJ+dyf4YHR0wQ=;
        b=wpRH03k7kvpCXHUrGTwz7CQnL2hQFGoTZj/S6ltfMORME9L6mfnN3Ac8Szenq9DCIG
         O1muJ7FhPmGWH8tNN8XwglsuQUrjEfj6w8uiFDnoJWBVl+sttpHSyzKGRSS1pIQwLMW/
         45gHqPGSVr4Bk4J3lDcud5IJkTqNGi3HYBU8R+KsW4fEmeRK5nJIyWYkUqPiJrYgRrYh
         LDVUGUtw4+/MKrGXFw1PP9sZHw+gBA8ZmKZXehAXqo/i+o2BBGVDteYj0tprWdNZmxWe
         v54E55r6istLXJs+gZAqJ6nk69J70FNxHTvJY2CJBYpRcPs6/9yxKrbmldqOzSX2uZvJ
         JFgA==
X-Forwarded-Encrypted: i=1; AJvYcCUF+qECJUsiDjjbghpw55/NZHbKlHLZmtgha6gmI+qM7hagHL8WCfFg6Yvu4yLUj44SVC0jr4fnVMK+FeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMlKt+Ls7imiU4AqGa7dHrkiFUkiKAGRf8SZGZlKfxF+iTzbF
	cvt1Cbl96foWC+maG44kVy8UPcmB/yk+Jdt58qYh/Jn2EWwHreg7GuCmAnVGLfE8HwwjqqsVt1q
	qbURQ18TIh2rwQyoPSateXif6aUlpeZT8dLkO
X-Google-Smtp-Source: AGHT+IGKkOi4J8lTlYZdHUzI9kAHBuz9nhLGV8Ib23f+FNH2f8NHlazCJ4EMPsRH8Q2vBoyyCBiccjnJLfL428i4Gaw=
X-Received: by 2002:ac8:7d08:0:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-46113b19040mr1860901cf.10.1729638285185; Tue, 22 Oct 2024
 16:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022205622.133697-1-souravpanda@google.com> <CA+CK2bCnLyEpT-Tr_GGqTzWcNOviE93cyb=WQ09ksYexbzJ7_A@mail.gmail.com>
In-Reply-To: <CA+CK2bCnLyEpT-Tr_GGqTzWcNOviE93cyb=WQ09ksYexbzJ7_A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Oct 2024 16:04:31 -0700
Message-ID: <CAJuCfpHpyCMWSpf_+JZgVNoQ5UMHdo9b258aathkou0dgGPung@mail.gmail.com>
Subject: Re: [PATCH] mm/codetag: fix arg in pgalloc_tag_copy alloc_tag_sub
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sourav Panda <souravpanda@google.com>, akpm@linux-foundation.org, yuzhao@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 2:03=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Tue, Oct 22, 2024 at 4:56=E2=80=AFPM Sourav Panda <souravpanda@google.=
com> wrote:
> >
> > alloc_tag_sub() takes bytes as opposed to number of pages as argument.
> >
> > Currently pgalloc_tag_copy() passes the number of pages. This fix passe=
s
> > the current unit, which is the number of bytes allocated.
> >
> > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > Signed-off-by: Sourav Panda <souravpanda@google.com>
>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Oops... Thanks for the fix!

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks,
> Pasha
>
> > ---
> >  include/linux/mm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ecf63d2b0582..2890001c8b97 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4203,7 +4203,7 @@ static inline void pgalloc_tag_copy(struct folio =
*new, struct folio *old)
> >         /* Clear the old ref to the original allocation tag. */
> >         clear_page_tag_ref(&old->page);
> >         /* Decrement the counters of the tag on get_new_folio. */
> > -       alloc_tag_sub(ref, folio_nr_pages(new));
> > +       alloc_tag_sub(ref, folio_size(new));
> >
> >         __alloc_tag_ref_set(ref, tag);
> >
> > --
> > 2.47.0.105.g07ac214952-goog
> >

