Return-Path: <linux-kernel+bounces-245054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 239E792ADBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CCA1F22054
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9852837D;
	Tue,  9 Jul 2024 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrvrBk7B"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9D110A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720488084; cv=none; b=jOON638zOCFLxrC7QSb//t2LTvTb/fmaK2N4temRIdXFGjn2zasDiynOxo2drmLDRJBpb5CWtX7lgtc9RYfTrOnWOjMux1YNqCJdBFDuKBedAl1xHAeDmYBfOplTj56n/ACnxAmEftdUTEFjMq0h0c47G1usAJb0iIirut1iYAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720488084; c=relaxed/simple;
	bh=zn5i67Ufx0f9aoLiCcd6mWfTOyw3oXWnnNBBd/B+wPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6aU3Mq/0NzlpreDN+SQBE3DEVFnE4Z/1cdb1iMO5ZXcvHW7Hw6y+1WpFQoQwpNzRogoASAkPjC6wi0VG14nPl5RvBfSr/F9pwG6q70ilUu48+X+Y0Rm/XpTB0vgNIMcRdZ8OrynPsvnlgqn7Oy8XjqHrxmx/GdhAc+MFvba8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrvrBk7B; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebed33cb65so57355101fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 18:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720488081; x=1721092881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn5i67Ufx0f9aoLiCcd6mWfTOyw3oXWnnNBBd/B+wPY=;
        b=RrvrBk7BOcAL+sQfBO0YNFiWug7uOFAGUIlwcw7x1e/7pfyozf760rdIkorC7FIOvM
         dPDesMpHGfzt30/sjUq4bMWSPpyngw9ELJaEu4J9EqFZrhWG16g5fbKfiRtyAqM0RdeG
         hccftvWZS+KVmKINQYA7CMp8UH6jEPUtSwEqcdMfMfuUgdxG54oP6sZAuxdJi20ujYlZ
         oOy0v2Q1VSEHMvxSFZAPo9b1gFCtvTiAtlt1W5hle5Rks6C49m3XSI4t2N01FzFif2+S
         lTejajAd/mE2oJXei4gX2QioqwfbePDE4BTH9F3pKDYejxNdF7qZ+jb8fDPUyKqxfSJV
         S7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720488081; x=1721092881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zn5i67Ufx0f9aoLiCcd6mWfTOyw3oXWnnNBBd/B+wPY=;
        b=huJxw0cglT/fggcx1q1LE07gNjH3aV+pxtDmpITxQUDiFKGkuoHWNkewwBncrT0NMC
         BVegq4Me7iEZGlbzIlSIhgHbkfjxS2B4Nc+/13+T6uOZrCtYrz4f2i/aoXcMow5wg8sb
         mTdapWdyqL+s+4qHHjfjl7CUPqGlhYVutKdOaaBdEK4UcG+jJoPPBsJP1ggLAzYnkeSL
         gUcZToMQ8CQPg/JESK68eacIADso7KHbyKko/Hxbk3d/Lq9d5CSePs+QRhTc4+p2VZlv
         Ov6AlnbSpImV4YBkZY0DSn7RNUkUq9T8eygXhZJtxTWtWVZb3yApOOvaGhRiTcgWQwmN
         iNHg==
X-Forwarded-Encrypted: i=1; AJvYcCX9LvxGqiaaCy4eFVa0cwHpbr34vvCfxd44FsHOK72hDYKZGFHCUeCI2MwU6ANbxItEbuqCN021Ks5TtycD7imp2H4S62Yd1fMUz0eg
X-Gm-Message-State: AOJu0YwG9Pr77AfjbgIjYL9TmC4J2ChKo1ytEz3z5SXa3P3PAppRBEJ8
	lkoqn9AJ8GZQvaTySvjI9SV7B2I6xo83mhrYYkX0bOWzLmjwpz5gnMn0NsY5k4sUmqC6lUKNgym
	VVg4N3b16fpQTXzNI+x5qFI5Ktcw=
X-Google-Smtp-Source: AGHT+IFedpKhq134nNvLT4sO6zKdxlPyIoaZtg7bLZUk9g1uZZywwu5F6Od9jvClVSGV9cN6c49MSz9eoMfyzxDU+v8=
X-Received: by 2002:a2e:9b57:0:b0:2ec:5518:9550 with SMTP id
 38308e7fff4ca-2eeb30b4d43mr7584761fa.10.1720488080818; Mon, 08 Jul 2024
 18:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
 <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
 <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com> <10b201b1-53d3-4f62-be8e-996aa95d2b99@redhat.com>
In-Reply-To: <10b201b1-53d3-4f62-be8e-996aa95d2b99@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 9 Jul 2024 09:21:09 +0800
Message-ID: <CAK1f24mjcukbjBnrrO3TLZb1KdVhSxqL4_jsob5E_FAjGD4mdQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 4:50=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.07.24 14:29, Ryan Roberts wrote:
> > On 08/07/2024 12:36, Barry Song wrote:
> >> On Mon, Jul 8, 2024 at 11:24=E2=80=AFPM Ryan Roberts <ryan.roberts@arm=
.com> wrote:
> >>>
> >>> The legacy PMD-sized THP counters at /proc/vmstat include
> >>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
> >>> rather confusingly refer to shmem THP and do not include any other ty=
pes
> >>> of file pages. This is inconsistent since in most other places in the
> >>> kernel, THP counters are explicitly separated for anon, shmem and fil=
e
> >>> flavours. However, we are stuck with it since it constitutes a user A=
BI.
> >>>
> >>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
> >>> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
> >>> same "file_" prefix in the names. But in future, we may want to add
> >>> extra stats to cover actual file pages, at which point, it would all
> >>> become very confusing.
> >>>
> >>> So let's take the opportunity to rename these new counters "shmem_"
> >>> before the change makes it upstream and the ABI becomes immutable.
> >>
> >> Personally, I think this approach is much clearer. However, I recall
> >> we discussed this
> >> before [1], and it seems that inconsistency is a concern?
> >
> > Embarrassingly, I don't recall that converstation at all :-| but at lea=
st what I
> > said then is consistent with what I've done in this patch.
> >
> > I think David's conclusion from that thread was to call them FILE_, and=
 add both
> > shmem and pagecache counts to those counters, meaning we can keep the s=
ame name
> > as legacy THP counters. But those legacy THP counters only count shmem,=
 and I
> > don't think we would get away with adding pagecache counts to those at =
this
> > point? (argument: they have been around for long time and there is a ri=
sk that
> > user space relies on them and if they were to dramatically increase due=
 to
> > pagecache addition now that could break things). In that case, there is=
 still
> > inconsistency, but its worse; the names are consistent but the semantic=
s are
> > inconsistent.
> >
> > So my vote is to change to SHMEM_ as per this patch :)
>
> I also forgot most of the discussion, but these 3 legacy counters are
> really only (currently) incremented for shmem. I think my idea was to
> keep everything as FILE_ for now, maybe at some point make the pagecache
> also use them, and then maybe have separate FILE_ + SHMEM_.
>
> But yeah, likely it's best to only have "shmem" here for now, because
> who knows what we can actually change about the legacy counters. But
> it's always though messing with legacy stuff that is clearly suboptimal .=
..

Couldn't agree more! It's never an easy task to handle such matters :)
Perhaps, the time has come for us to separate FILE_ and SHMEM_.

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

