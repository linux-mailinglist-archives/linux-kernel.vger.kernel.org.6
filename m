Return-Path: <linux-kernel+bounces-408030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FDB9C7925
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47EA1F239D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916311FDF92;
	Wed, 13 Nov 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BzMqWY6p"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07301DEFC1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516281; cv=none; b=l2rPaKIWrOQ+F02Iwm3JX27g5CqZVmqzmzcv84L1wVleAFESSN8vZQ12t8I0Ni6aJL6tq7FgciPG9uKHOkc0DNebMG2DEwESTULnztmhmdl/+k6YEmRJcO3SbR7Afuzo14OXILbbJqHyGlcbmUpYg45UnCIaEOy4UAdwr9IuuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516281; c=relaxed/simple;
	bh=e5nJkTR7J5hdCp6LwUJ/ZxsG80P30xGos64u7r8MAMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=K0nj8H3b/1nkPLhwFozDovdwFVzEkNIq2Qym5qgBLDC7Zht7QkbPIKFbexbQccKuX/pa1gt16iFZfbA/zqmPr3CYM6KYVv3WphNbHM1rULT8EYnwdDSLyvjRlHtgpddoedSU4712MsWEJigXx8MfCVkr+HMIGPjkjsTnms+XHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BzMqWY6p; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so6835a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731516277; x=1732121077; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K41601Aj1DwCT3LWzGLI16qz80eqGD+NEopptWi0zDE=;
        b=BzMqWY6p90wF3dE0/fhp+bbt1M45+rPcR1TaY32SGeKrTm3fTl6ATb2pQNRkhzxDj3
         3pAHxSGBvQEVACbQ1a+PkRhcuk27aMfdSfA9w+yFtdvTCTivUuld/qb/7puaM11of3L5
         wjVGg1idD4vT1MbWPbQir9OUdk09TJvvF/3kbNnxxl8UuzUSJfRMfHJi5/HXugwqGZfK
         ywOUmVGIrtnyS9KDV/Shiosllx5fhx2YeVzQh9G9UGgJRq5QCmYowCFHBTGQeJlWl29X
         JqkPCO93B63aipZvhkDAavIVTP9JZld1PwjFNdi2PmWuy/tKnxvIpHQTFfAk+/cmOvmH
         S14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516277; x=1732121077;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K41601Aj1DwCT3LWzGLI16qz80eqGD+NEopptWi0zDE=;
        b=EGwWzQRf8/9ioPg5N32JnpwcHpyGVvR3pqy+V1Iguos4bkw3eeMuV7SCk1kv3h/uRn
         SrF0G+xkWXKTSNr6aE1WtlQpDc8dBwc66+tOfwwQfYj/+irtjw2PiOv5Shxb/5QrPaIv
         0eRWY/EilJy1UqLECcRqQREq4IvEcYRRHVoeHkVUsVsnbdFBVox6tCe8/CJz2W+YM5Gg
         xrQRftIDjMZ7oMEzYRU56T7Ee6oS0Vq0y1aWPASmoqTsL9EP5MxMs8Hpf2yWbbMg6W58
         2DuJib+3lGU7f3tvFvdAo3W329zq1U19dc3/lU8+AKA/GOzuhOXgeEbS9SCJ7G0YlprV
         HnVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVunSdjx1U9EqKdkuJzUUhQhzIMbpit2qnDl+EuARlV5H8eC6uSVTlEc8XAyhTu9rD90ARfdyMforWVyN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx532U1J4TsxbMhL1KCh+blfXUbz4+SNYABVsEEe8WBkF9TlIfb
	NAy8i7rcesnMrPmLkwa47AlECUIM4lWHq5WAHysRNmLn1dJ8IHvjpSgQkgFhdw/DdWdTPlP2o85
	PepEOtRN7kSLAg3OAPHbW+LMnM0XNHqAyCDB6
X-Gm-Gg: ASbGncu/FscA3/MQ9TSPG8uAgUZLBEdbP4m160WihK5mxBaPeQ8KFM9UPaA7ojNxwP8
	aLwlcG1VR04bp0WjHZYdEE2BAOqfCHmMnxydSpTVPBzklOTUgNE6bEAnh9s9A
X-Google-Smtp-Source: AGHT+IFmW5EY8yv++uV6rWC8b84oqe+r4WcblS74tlvDXju2LG8ZJr1TrcaWUFb2AMJlbTIPMvZYMZs+C5PWC/0DTn8=
X-Received: by 2002:aa7:cb8c:0:b0:5cb:6849:b30e with SMTP id
 4fb4d7f45d1cf-5cf656c49efmr93291a12.3.1731516276879; Wed, 13 Nov 2024
 08:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz> <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org> <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
In-Reply-To: <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
From: Jann Horn <jannh@google.com>
Date: Wed, 13 Nov 2024 17:44:00 +0100
Message-ID: <CAG48ez29OcD=NL0EqW3hO+3VNzkZce5REcYev5-M09-_HOqsDA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:23=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> * Matthew Wilcox <willy@infradead.org> [241113 08:57]:
> > On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote:
> > > > Hi, I was wondering if we actually need the detached flag. Couldn't
> > > > "detached" simply mean vma->vm_mm =3D=3D NULL and we save 4 bytes? =
Do we ever
> > > > need a vma that's detached but still has a mm pointer? I'd hope the=
 places
> > > > that set detached to false have the mm pointer around so it's not i=
nconvenient.
> > >
> > > I think the gate vmas ruin this plan.
> >
> > But the gate VMAs aren't to be found in the VMA tree.  Used to be that
> > was because the VMA tree was the injective RB tree and so VMAs could
> > only be in one tree at a time.  We could change that now!
>
> \o/
>
> >
> > Anyway, we could use (void *)1 instead of NULL to indicate a "detached"
> > VMA if we need to distinguish between a detached VMA and a gate VMA.
>
> I was thinking a pointer to itself vma->vm_mm =3D vma, then a check for
> this, instead of null like we do today.

Sidenote:
Something like NULL or (void*)1 is fine with me but please don't do
pointer-to-itself - we shouldn't unnecessarily store a pointer to an
object of one type in a pointer field of an incompatible type, that
increases the risk of creating type confusion issues (both in the
memory corruption sense and in the Spectre sense). I know MM already
has several places where similar stuff can happen (in particular
page->mapping), but here it seems like unnecessary risk to me.

