Return-Path: <linux-kernel+bounces-437185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545D9E9016
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFE9188676A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EC1216E10;
	Mon,  9 Dec 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEPJ12QY"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EBF2165E2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739952; cv=none; b=HwAAui6rgnPT9vo4YUYje4h5CNDECofBYvZj15xPGH0mYp2xU1Fawk9UlQL+N1DuJKvjjgdMyHai8GLRR5EpShJGQVx/zUYRvxPg9H7gr4GSwBbD98sUIaDadGS9vrc2keTpPLeLJOu4dGu5X5qHR+4W3bC8soM4HoZiXrDz9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739952; c=relaxed/simple;
	bh=UqSQ6Mifgozyf7icnoKIVICTD4AIxwFh8AJ+TaGCpzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugrf2S8ZGnT+GeCPcMOVEBIFqc0rjaBkn7tNgpCcBqau6OwiDVn4p5feuz7biSy1Cr9TGN4UIfW1TnmU0PzIsJVy1NOP+qrnTE/HCldFLaTy35M+1Neb/VZBbwl1WuROwKAAwR8qn+da43JaQrYTtYEWEy7Mw/kPMxhLHms5Bh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEPJ12QY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso276399a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733739950; x=1734344750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dr9Twfm9vrYmy+fDm6h/4IwUd/7v2Bef0z21R8+Bodw=;
        b=KEPJ12QY3nEcJ6E2Pz8rc3YqYj7MPeLouPtRP3nq3sXm5hzxmiVzl/9SdVtVX810uQ
         HMVsw0PrY6n+oOkPEBgsVZndnBxLf/hQzxD/VZfxS3eZS0bFWor0xJFjD9YQAuDmwBLr
         aBPSRR+l11wNkHsdm8JYWVIVW7NWbKlCEsA8lVYM+UenCh6QpuXxW2Q+OPNT16gMaxhj
         fAyI3EnsqOYQoKoy3XxW3t7gYTuTNTxtddl6JJDDSyuZLmFcYQpx06p4p06Q970ENbqZ
         vCxZYpAbcE3H5KnkyxwkeIUrZyAHqaOE+kYqWbSY8cZKRCArp/7mkf6ZprklYvck7jv3
         xTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733739950; x=1734344750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dr9Twfm9vrYmy+fDm6h/4IwUd/7v2Bef0z21R8+Bodw=;
        b=nb55GtecQ7gz90Heh0WRDh74w1xJV+9rJrojScgaHNvKyW3GmKAGfCm2U9vSyzddP1
         IzR6cbz0CqPb1x/x7R3T8iBneaCZyS9dPq1oj00THlQKmxq7LwMi8ERgdKDUkE73VbG9
         kkdM1wrUjwn9sIQW2eCBu+1QN8dA4ztqOx6S6+r3m+OgQl7dslqBFR4yyPNvVXctERLu
         +bYdZpmjZszUHjxZVMV5jtOqez4gLa9apfQZyrFETJD2j3LLt8yNGiSgSJkRE2Qq+7XJ
         AlTlSBo22WttxnrlpyhVBIp1zrYmJBSdVdUjw0iBwpJEceC01GJ6cmTlDSkrjzEwrZUT
         /1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhhS4OuRK4zayCRYZ9hGPE9eVMg2/rIo4iy2+v/dfMEjDpMVPbRS77dXU672009CnbvhIP0stMYeSlC7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaZQJLLI97UI/M3gLZS/5tJVqmW96dT1nmAm1TSqy9PuWGj/xo
	A/V2wtykqV2jD0MoFnkCOg72pR8uojql19NQA7Vd7rDDgtkSAcXwMQ2Ox6omFLt3MwcUzAv7vwb
	F+zf0OBs1N4XFfkWlO9paVqAln3w=
X-Gm-Gg: ASbGncu5sdHfcV9MR5GBg3MjIkZd4zSGeFzLkasorsgE+brTn6QpilqTSLG9P4sWjsU
	wACA1dTSjd/JDG4O+Lvm8IAlt2ZtBrl4=
X-Google-Smtp-Source: AGHT+IFDOiSXetDpeoxW0itxt4YB80uVJJ+x7MnO90+xEbOfdXoYtnT8WmgNoYOhPj29jLu6H3v8mMd7Ii2sH/eftt8=
X-Received: by 2002:a05:6402:254e:b0:5d0:d30b:d53e with SMTP id
 4fb4d7f45d1cf-5d3be697749mr12018064a12.19.1733739949366; Mon, 09 Dec 2024
 02:25:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207082931.1707465-1-mjguzik@gmail.com> <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
In-Reply-To: <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 9 Dec 2024 11:25:37 +0100
Message-ID: <CAGudoHEggB=F9j7r+ndQs1WxpRWB4O5VdBo+PLx+yd1xrj4-Ew@mail.gmail.com>
Subject: Re: [PATCH] mm: remove an avoidable load of page refcount in page_ref_add_unless
To: David Hildenbrand <david@redhat.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, willy@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:28=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 07.12.24 09:29, Mateusz Guzik wrote:
> > Explicitly pre-checking the count adds nothing as atomic_add_unless
> > starts with doing the same thing. iow no functional changes.
>
> I recall that we added that check because with the hugetlb vmemmap
> optimization, some of the tail pages we don't ever expect to be modified
>   (because they are fake-duplicated) might be mapped R/O.
>
> If the arch implementation of atomic_add_unless() would trigger an
> unconditional write fault, we'd be in trouble. That would likely only be
> the case if the arch provides a dedicate instruction.
>
> atomic_add_unless()->raw_atomic_add_unless()
>
> Nobody currently defines arch_atomic_add_unless().
>
> raw_atomic_fetch_add_unless()->arch_atomic_fetch_add_unless() is defined
> on some architectures.
>
> I scanned some of the inline-asm, and I think most of them perform a
> check first.
>

Huh.

Some arch triggering a write fault despite not changing the value is
not something I thought about. Sounds pretty broken to me if any arch
was to do it, but then stranger things did happen.

However, if this is seen as a real concern, then I think the best way
forward is to drop the patch (and maybe instead add a comment what's
up with the extra load).
--=20
Mateusz Guzik <mjguzik gmail.com>

