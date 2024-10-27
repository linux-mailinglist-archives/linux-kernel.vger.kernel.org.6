Return-Path: <linux-kernel+bounces-383475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E239B1C3E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 06:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6535C281BDB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2FA36127;
	Sun, 27 Oct 2024 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLYXowk3"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E234545
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730007320; cv=none; b=MAtyrI49xCfcwpAtDiZm4jJeMTgyybCPHZ2UwaI/XqnCX7tOfFNjf1SKkyoycEhkN+lLB6txsb4EYzUAYAWyaeSegpo2UM//XQtLQIPKDTbibQ9lLzYatTkliTh5QzUvq1f2iWSr+QnlzR+u8nG6lVjeYzQOgB1sjWxEttNa/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730007320; c=relaxed/simple;
	bh=dEg/PNen8nK0Db6kHOHSA+vUgGJEDsDlLhB28ucD8tQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tQRUFZlmWaqVdEZYc6bISCc1gwYOEnPIMYkYJZrf9wsIZFDSFbThYpJ1/kZyIv7l8ohS8kH49/TRBwvLPaqhwEVqHMheZNwhelSLjYUE5j4i3w2J4EDkM0idg0o1zJEFPgW1JkCsz0S2SJFz2Q4kJOgenTOtvNlgIt+C0HRyW1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLYXowk3; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so2919598b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 22:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730007317; x=1730612117; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ujd2vHmvdLrfB7KGMHpfvkxuxKVDDWppgd/piDO/ivA=;
        b=FLYXowk3lT/FpAItckC3P8+MMAGMF02tNOQEi16H7UuOKT1IcrAwGD31VvCgVDX7gf
         XnY7kk6JfmNRotZX2nL0FrkTnPlAmX5LHpA/s0Q5ssgf1cVInh6LjqtFVhbNl4QqdPro
         DV11axTbYlCT/5s1ce9EjYoQU5zZU+GyYZFAEbQcVlp+jl8Xj692xK+Krhqh+OSMjMzd
         zqphhqCf/axVGMFMwKGRWidUuSVI8TWQP8+FggKrEoDoOggCGDU3Cwn2TA/3bvCX+Umh
         lWtIQ7seV/5/RPXj6+Iw8avjgE8TdC8kvdbF2dIgTVHOnKhKwZ6FxavZ6GjFQ2SVPtnD
         nLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730007317; x=1730612117;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujd2vHmvdLrfB7KGMHpfvkxuxKVDDWppgd/piDO/ivA=;
        b=lp6qDgxeVyGqKYLS2RSUi2Cls+aWAaGJtq35z80SnbjBPKcnWaODtKhBJkt9Pd8E0d
         a25adfhpRoiu/+cCPyxW+XILJsEypMPOeDSMU7wYR3b9yl1JaV4cXL6+nTCwAjMFQAAc
         UqKBzUC3Qj5kHmJE6LpnbBMQGzMKX2k3wCzwgsdpgMUsJ75e4j0ZJRansKxxrhqSqsm5
         tDtmTRUYc/x3izSwHWoDOuBbi+WSWTmtQFcC9DDmlZ+kbYlcFIltfOumuVKXgClCYouN
         0wnlzso6ETusSjlNKjSAeChyPegNLKFEQ8H8FJK7HhW5ZykueKwx323tw2UWkkkg8QzV
         QIwg==
X-Forwarded-Encrypted: i=1; AJvYcCW0lO/qsnBkTil0GIoaKeW5eb5FOjV8yANgJA3vKqVcA9IcmdXu7eTJcsu2QelyUtF5mMSkwsH8K+UPUC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEg5mzlKjkTAj2WV1IqoF9TBsKZrJvN09HRWE2OwLKwNrJYb2
	9C1LukNKFTbecCBdnpw29PqPIS4hkg5e+se/YgRvszNdtOC2EgaQcWvn5H+wJg==
X-Google-Smtp-Source: AGHT+IE//NA9WfVgQkGQi2jQJBiuU545D5cE7iK7ffFqmasFRKs9aGFtcUD8RKyjHF2+GFKNET7K1g==
X-Received: by 2002:a05:6a00:898a:b0:71e:467e:a75d with SMTP id d2e1a72fcca58-7204545df78mr11820844b3a.12.1730007316724;
        Sat, 26 Oct 2024 22:35:16 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b7basm3520868b3a.109.2024.10.26.22.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 22:35:15 -0700 (PDT)
Date: Sat, 26 Oct 2024 22:35:14 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Yang Shi <shy828301@gmail.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Usama Arif <usamaarif642@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, 
    "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
    Ryan Roberts <ryan.roberts@arm.com>, Nhat Pham <nphamcs@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Chris Li <chrisl@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH hotfix 2/2] mm/thp: fix deferred split unqueue naming
 and locking
In-Reply-To: <CAHbLzkqjO6X_k91xFFRG+5FLkzxvc0UKsUomW0_oYMv68TCHQg@mail.gmail.com>
Message-ID: <88043c2c-0b7c-40e3-c5e7-47720cc66861@google.com>
References: <760237a3-69d6-9197-432d-0306d52c048a@google.com> <7dc6b280-cd87-acd1-1124-e512e3d2217d@google.com> <CAHbLzkoRHcC33vj7iajw_JXVig7yghJRGaTpaHXaxhoni76yPw@mail.gmail.com> <b3e88e26-5bda-50fc-cc55-a62b4b2a4e24@google.com>
 <CAHbLzkqjO6X_k91xFFRG+5FLkzxvc0UKsUomW0_oYMv68TCHQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-943490169-1730007315=:20798"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-943490169-1730007315=:20798
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 25 Oct 2024, Yang Shi wrote:
> On Thu, Oct 24, 2024 at 11:57=E2=80=AFPM Hugh Dickins <hughd@google.com> =
wrote:
> > On Thu, 24 Oct 2024, Yang Shi wrote:
> > > On Wed, Oct 23, 2024 at 9:13=E2=80=AFPM Hugh Dickins <hughd@google.co=
m> wrote:
> > > > --- a/mm/page_alloc.c
> > > > +++ b/mm/page_alloc.c
> > > > @@ -2681,7 +2681,9 @@ void free_unref_folios(struct folio_batch *fo=
lios)
> > > >                 unsigned long pfn =3D folio_pfn(folio);
> > > >                 unsigned int order =3D folio_order(folio);
> > > >
> > > > -               folio_undo_large_rmappable(folio);
> > > > +               if (mem_cgroup_disabled())
> > > > +                       folio_unqueue_deferred_split(folio);
> > >
> > > This looks confusing. It looks all callsites of free_unref_folios()
> > > have folio_unqueue_deferred_split() and memcg uncharge called before
> > > it. If there is any problem, memcg uncharge should catch it. Did I
> > > miss something?
> >
> > I don't understand what you're suggesting there.  But David remarked
> > on it too, so it seems that I do need at least to add some comment.
> >
> > I'd better re-examine the memcg/non-memcg forking paths again: but by
> > strange coincidence (or suggestion?), I'm suddenly now too tired here,
> > precisely where David stopped too.  I'll have to come back to this
> > tomorrow, sorry.
>=20
> I perhaps misunderstood this code. Just feel free to correct me if it
> doesn't make sense to you. But, yes, some comments are definitely
> welcome and helpful for understanding the code and review.

Thanks a lot for challenging that: it was me who misunderstood, not you.

I might just be inventing this excuse, but I think what happened was,
I'd been staring at an earlier release tree, and in that earlier tree
the prior unqueueing was tucked away inside a memcg function, but not
done in the #ifndef CONFIG_MEMCG stub: so I thought that this
folio_unqueue_deferred_split() in free_unref_folios() was needed just
to do it when mem_cgroup_disabled() (either by CONFIG or bootoption).

And I thought the "if (mem_cgroup_disabled())" was comment enough:
except it made no sense to you and David who saw what I was blind to
(and what you describe perfectly clearly above - it depresses me
sometimes, how I cannot even read what someone wrote, until I've
arrived at the same conclusion myself!).

If my story about !memcg stubs is true, then I think Matthew has
been cleaning all that up recently.  Except for put_pages_list()
(where I now see he wanted to insert a VM_BUG_ON(folio_memcg) in
April, but was forced to retreat): that one does not have a
folio_unqueue_deferred_split() in, but the good news is that
it no longer has any callers - I'll send a patch to delete it.

And instead of my misunderstood code above in free_unref_folios(),
just deleting the folio_undo_large_unmappable() line, with a
comment in the commit message.

Thanks!
Hugh
---1463770367-943490169-1730007315=:20798--

