Return-Path: <linux-kernel+bounces-327359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78802977497
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FDB1F251B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808D1C32EA;
	Thu, 12 Sep 2024 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LStdggoP"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D2A1C2DBD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181800; cv=none; b=mMmBkpF73er/ytR0KN3XIN1/l2gCuSLqgQpIzocbfsPj0vmShnQNrqIoR2st9bi29J4SJdxyP2/FMi6WPKWcuJt29nx9DLbrcddk4S6TW8FbmPEp30UiIkNSwqWonkxWwME4ja4oIc4UAVYVWrLsbbz8rOTS9xoTPM9qAUBbk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181800; c=relaxed/simple;
	bh=FC6yVrbFwid+khyb8rzsz+6/2arbcCP7+SVedlt7ft0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPA4M1bl/3ZUYdwpkZW4p3UhZHyixnyfsaOYRFDoh240pkH3JzZQ8IVGzlFesGtpUbxioukfoDYFvEdDAl52RW/gtYIwJ7DyAZTByf/2m1oOk0DMe1zgmCGDbCHwz13Fy7pOCd0GEft0y1zkRAcHEnsaRgS6LnE4aKT6P/kDsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LStdggoP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so1862849a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726181796; x=1726786596; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5oSHOzzc4kY1d0eewmzi0Wbpuaj3BjPn9DNZ4NK/40=;
        b=LStdggoPpFQ7uBV9FzlTnDldMT4uTArLEEgbJHQEOk7akAJSQkfuMUuhzeQv6EeLVt
         MW3PbmDUdq6DatMngZFPXmLWzAQ04++uLY8CuJjM1VTYQ0pfEwNCMFbWYOrErSJ+QnqZ
         QoZNg4RjFmOrv9kEWFUEG+92fLz8n8601Dkhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181796; x=1726786596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5oSHOzzc4kY1d0eewmzi0Wbpuaj3BjPn9DNZ4NK/40=;
        b=XqseW6NdRg3Bd2f5ri323H+3Z61RZpfAifnKOdupPktFEtcd631rtmpbdMSgS9iuVa
         hrpy6GdOaYaOL4JM5khS1psvjTqUtdtTxFaTTo4cfPw0ABAMNsZzABPdFU54sTqcroXd
         y1eDF/qS9xr+jVQe8mBv+t9/3nykc0amvkaOWNR8b40J6wKeSXp+hSQKLDh6qGC6NG7I
         rDcWcVbLqpFYY53MxPjLW6gpzVYAUra/HlSBv9FTzPPPh4BVcNigd7yJwwtkI065fwuQ
         ikv1B9cFCYSGXwZITVbzhmHv9VC00v7T1iYDdqudZyT7dqCErp/S0Q96CkEKhF9oe9cw
         VE/A==
X-Forwarded-Encrypted: i=1; AJvYcCXTYUqCXitDBaijCiTqz7dJRmu3+KyZgGRR//k3kJEwiBqfJAAUELUXr/iVnCTzaVbBQAWcHVDEOO1XP0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdos4gBGhgLo/ybXc79BzDUfG5p94Ky39+lETgqrYqKy5Yv5M
	Ehe6CpFZzpuegnES8uSHl5mcs1H3iuiqb6TjFDTym7ZZbQIUkm0vLfCEHJJkz7iz5AvydkQUnF5
	+jPA=
X-Google-Smtp-Source: AGHT+IGGsSDpB3p+zStyMAiTM2GXJKzrHpkz/5wKpOFLRmbP0INgwba6d2tNLwns3ZFSmhnCcbTKgg==
X-Received: by 2002:a17:907:f74f:b0:a8a:8127:4af with SMTP id a640c23a62f3a-a90294ad65dmr433600766b.39.1726181795981;
        Thu, 12 Sep 2024 15:56:35 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d547e5sm800117766b.201.2024.09.12.15.56.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 15:56:34 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3d209db94so1782344a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:56:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnM1l1i/lqVfQOkCowj7kQY9hvUz4lF4rROxlHQsnaojAaKECUQdI6/1YY9M9/GYH7hMSV68AqlTdcNuQ=@vger.kernel.org
X-Received: by 2002:a05:6402:274a:b0:5c3:d8fd:9a3b with SMTP id
 4fb4d7f45d1cf-5c413e4d06cmr4158380a12.28.1726181793913; Thu, 12 Sep 2024
 15:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org> <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com> <415b0e1a-c92f-4bf9-bccd-613f903f3c75@kernel.dk>
In-Reply-To: <415b0e1a-c92f-4bf9-bccd-613f903f3c75@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Sep 2024 15:56:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg51pT_b+tgHuAaO6O0PT19WY9p3CXEqTn=LO8Zjaf=7A@mail.gmail.com>
Message-ID: <CAHk-=wg51pT_b+tgHuAaO6O0PT19WY9p3CXEqTn=LO8Zjaf=7A@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	Dave Chinner <david@fromorbit.com>, clm@meta.com, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 15:30, Jens Axboe <axboe@kernel.dk> wrote:
>
> It might be an iomap thing... Other file systems do use it, but to
> various degrees, and XFS is definitely the primary user.

I have to say, I looked at the iomap code, and it's disgusting.

The "I don't support large folios" check doesn't even say "don't do
large folios". That's what the regular __filemap_get_folio() code does
for reads, and that's the sane thing to do. But that's not what the
iomap code does. AT ALL.

No, the iomap code limits "len" of a write in iomap_write_begin() to
be within one page, and then magically depends on

 (a) __iomap_get_folio() using that length to decide how big a folio to allocate

 (b) iomap_write_begin() doing its own "what is the real length:" based on that.

 (c) the *caller* then having to do the same thing, to see what length
iomap_write_begin() _actually_ used (because it wasn't the 'bytes'
that was passed in).

Honestly, the iomap code is just odd. Having these kinds of subtle
interdependencies doesn't make sense. The two code sequences don't
even use the same logic, with iomap_write_begin() doing

        if (!mapping_large_folio_support(iter->inode->i_mapping))
                len = min_t(size_t, len, PAGE_SIZE - offset_in_page(pos));
        [... alloc folio ...]
        if (pos + len > folio_pos(folio) + folio_size(folio))
                len = folio_pos(folio) + folio_size(folio) - pos;

and the caller (iomap_write_iter) doing

                offset = offset_in_folio(folio, pos);
                if (bytes > folio_size(folio) - offset)
                        bytes = folio_size(folio) - offset;

and yes, the two completely different ways of picking 'len' (called
'bytes' in the second case) had *better* match.

I do think they match, but code shouldn't be organized this way.

It's not just the above kind of odd thing either, it's things like
iomap_get_folio() using that fgf_set_order(len), which does

        unsigned int shift = ilog2(size);

        if (shift <= PAGE_SHIFT)
                return 0;

so now it has done that potentially expensive ilog2() for the common
case of "len < PAGE_SIZE", but dammit, it should never have even
bothered looking at 'len' if the inode didn't support large folios in
the first place, and we shouldn't have had that special odd 'len =
min_t(..)" magic rule to force an order-0 thing, because

Yeah, yeah, modern CPU's all have reasonably cheap bit finding
instructions. But the code simply shouldn't have this kind of thing in
the first place.

The folio should have been allocated *before* iomap_write_begin(), the
"no large folios" should just have fixed the order to zero there, and
the actual real-life length of the write should have been limited in
*one* piece of code after the allocation point instead of then having
two different pieces of code depending on matching (subtle and
undocumented) logic.

Put another way: I most certainly don't see the bug here - it may look
_odd_, but not wrong - but at the same time, looking at that code
doesn't make me get the warm and fuzzies about the iomap large-folio
situation either.

                Linus

