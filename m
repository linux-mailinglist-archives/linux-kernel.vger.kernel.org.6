Return-Path: <linux-kernel+bounces-278367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A837C94AF58
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B31B2279C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0377D13E02E;
	Wed,  7 Aug 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ufnjhZ9"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72113C689
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053818; cv=none; b=h9l9MFomPShAQsgN/g4jVz5yAl4pZ+gwwbsZi1CXFle4uT8VlLzSk3jv7jipo+WXpApManOBHSys5qX6S8XZhtdWmmVcdzYHZk+WRh/aFKceIil4YEWuJ/0cAq2t73XHh+cyrPMGTJ/l6T2EBGFqIDY67Spx+n6ZerM6/pKRD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053818; c=relaxed/simple;
	bh=/igLW5cGKyvrc8xeJe9spHKRE8+5cRBzFIFSVqv7Cd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjKQtKa8RHnSAdffiXQZ+AERd2ab5KG39EV/zYTIKRAE07TRevN4ciWrTZMGxyzg5MRzJL+jwxT+InbFQ5RFCc5B5pz2d/Wm5UPaUFddi0lMnIG96qL4KXKr/tQAnctxiWviRSAaMLWqc8wgHA7qkurFmN8lmotSHQPpe5CwiZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ufnjhZ9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so1995a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723053815; x=1723658615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyQtOF1vxDhDuNycgpsX5NQIqDKmQIL//+OA3nFwfHM=;
        b=3ufnjhZ96PTsUkxMdHTxgQQu15Op4lb7FHtEybxD5WpVn5GmhQcEn1kUsWDFJX4U88
         riiDWEa22mlSzz5TWRygjZzgldCvz/bvfBC1U/rnmuDutm6W6KgfKqzOArEM/A8a8zv/
         gpXW/oQx0oCJn123trJX9u1HV6SC6pQC6HBPHLRLcr0oJHUhX4LDqG0lfBDyRc4hApFm
         a5ud5twZ1Gn/fH0UXgOQGnE0ac8FiOGkJA+e/B1D5OMp608nK3s5QssRwwEjhGTSi86q
         WXbSplftxr4d8fqq0olX5ypI48BzMELLigrDxK4Rwh/oezyFQ7YjPTzvcU8S0vCvUogU
         Ax3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723053815; x=1723658615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyQtOF1vxDhDuNycgpsX5NQIqDKmQIL//+OA3nFwfHM=;
        b=muZb2uLHF/2yF39fqcxNcaAk1fOg+5s7aSbcwno26qbov15qtvBIyLKfePo4j1fFE9
         ZjPGg44iZdu+/loxOhXAvaQ2cxHOTBC+OxwurrUCEsD1HUVLO3sFLPRTHKutSSh/KyT3
         VehFR0eHERwSKzEKizTptR3nWa/PpvS0AXZBfY1bWiMievco2ndpzVNAfCyIC4l5T30A
         IsP7muZ5rOCQYWgIY2fxjEtZpaAthbqd0MvmWcC5LNKZRmDj5JxcHzs8KkpqFk4fwqyU
         +p1WKYuki8jXXjIgZmIoc0eGGrJtCPBFYcWia+CPlJb1g0bVx1hRMBDPHUGT6DvUh02Y
         uY9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbkQdEAEVI/59/0qDXfK0gA7ZiIljH9IiKpYZ4kJYJqO5wl8bKOwAfKmGHv0N+uBZnHAx0tDbbHDHvNz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0BPGXXwVHXFdR1YXtxo1CdyRRAhC3CV2+akJMY1uV2j9Lc5q
	MjW/hVF7mzrp1iHG3f+FB6tTm9buAaYgJpdBTg9mhDXxGirRXzDgEg2TQYdNXD/JXzuQ7ntrW2n
	7vZXZACZPLoZB5TJsWPcYCiueMZl/nZIGzpmhjWwVky3nRty74k7l
X-Google-Smtp-Source: AGHT+IHNgXjgqrAbiQnTxyfIC4MSApJgByOFffPeEqrpJGfxkuZ/yQYeD3R3pXQSk7hIuBatYSkKH+LlCFukduDyhC8=
X-Received: by 2002:a05:6402:2751:b0:58b:93:b623 with SMTP id
 4fb4d7f45d1cf-5bbb002ac8dmr3758a12.5.1723053814540; Wed, 07 Aug 2024 11:03:34
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807153544.2754247-1-jeffxu@chromium.org> <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
In-Reply-To: <CAKbZUD2xDdbxOTvR3-P=636jvhG_JPO3h79tgB59dfPmv046hg@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 11:02:54 -0700
Message-ID: <CALmYWFvDH=8U8wsaSjMrfCg1__S66SS-9Zo0f826XJDJT7hOSQ@mail.gmail.com>
Subject: Re: [PATCH v1] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, dave.hansen@intel.com, linux-hardening@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:38=E2=80=AFAM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 4:35=E2=80=AFPM <jeffxu@chromium.org> wrote:
> <snip>
> >         /* shrink from 4 pages to 2 pages. */
> > -       ret2 =3D mremap(ptr, size, 2 * page_size, 0, 0);
> > +       ret2 =3D sys_mremap(ptr, size, 2 * page_size, 0, 0);
> >         if (seal) {
> > -               FAIL_TEST_IF_FALSE(ret2 =3D=3D MAP_FAILED);
> > +               FAIL_TEST_IF_FALSE(ret2 =3D=3D (void *) MAP_FAILED);
>
> MAP_FAILED is already void *
>
> <snip>
> > @@ -1449,18 +1457,16 @@ static void test_seal_mremap_move_dontunmap_any=
addr(bool seal)
> >         }
> >
> >         /*
> > -        * The 0xdeaddead should not have effect on dest addr
> > +        * The 0xdead0000 should not have effect on dest addr
> >          * when MREMAP_DONTUNMAP is set.
> >          */
> > -       ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUN=
MAP,
> > -                       0xdeaddead);
> > +       ret2 =3D sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DO=
NTUNMAP,
> > +                       (void *) 0xdead0000);
>
> You still didn't explain why this test is actually needed. Why are you
> testing MREMAP_DONTUNMAP's hint system?

I responded in my previous email. The test is to make sure when
sealing is applied, the call fails with correct error code. I will
update the comment in v2 to clarify that.

> This has nothing to do with mseal, you already test the
> MREMAP_DONTUNMAP and MREMAP_FIXED paths in other tests.
The remap code path is quite tricky, with many flags directing the call flo=
w.
The difference might not be that obvious:

test_seal_mremap_move_dontunmap use 0 as new_addr, 0 indicates
allocating a new memory.
test_seal_mremap_move_dontunmap_anyaddr uses any arbitrary address as
a new address.

> You also don't know if 0xdead0000 is a valid page (hexagon for
> instance seems to support 256KiB and 1MiB pages, so does ppc32, and
> this is not something that should be hardcoded).
>
usually hardcode value is not good practice, but the point of this
test is to show
mremap can really relocate the mapping to an arbitrary address.

Do you have any suggestions here ? I can think of two options to choose fro=
m:

1> use 0xd0000000
2> allocate a memory then free it, reuse the ptr.

Thanks
-Jeff

