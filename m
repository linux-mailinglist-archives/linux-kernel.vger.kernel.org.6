Return-Path: <linux-kernel+bounces-323467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699FA973D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137531F27E84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F81A3A9C;
	Tue, 10 Sep 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrnsfDkq"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069341A0AFB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986336; cv=none; b=p4cmqcHB50ZgIZwVwmIt/vRjiDOlS6dcjkCuRuYYMSZNNGZ+c/tuhCpv/NNA/jTWIXVR2QmmJsvppCgUFezuqwHh4qkP9Cb0YTW95hTWzNvQ3mV8gcCsA+CbV0qWoJjK0n61yoIo0drrjwOo+KuhRs2nSU7X7H/Phafc5keG8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986336; c=relaxed/simple;
	bh=Qc2iqPV1vRnwIRvIBD1uYrgHpwHjN+WZHb7prLzEOTU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P36kIkb1zhjNwfTUnLy+/ba14Z1MIw1VYQl2MuQNQrj/KjxcKZki9cpzN4fdeEnssR/touWS+1nFCicsCmUQGva9pvBy1phPkH3BxAgGCz5+fB7dOiTmsr8GHVgW3IOZMx4H0reSuisfhQfjRC0eZDyC6ohepgV0wEC+NdLAdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrnsfDkq; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-84876d069acso1508933241.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725986334; x=1726591134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qc2iqPV1vRnwIRvIBD1uYrgHpwHjN+WZHb7prLzEOTU=;
        b=lrnsfDkq0g8iIwHb1qTlXgMr+3i7qUJOTqD9VgUgK2foG9U/Qkwc+HKWDIoJz/bkOL
         I/lHOnNfCAEp7ErsANVykXAAg4lcZuI4AbltRQS0PHhI922GNQrlc+yzZ9YuVKKr91G4
         DcNaTCP8sqFRvp+LCtglh797KN/o5wf0cv/4c8yaBKFDIjowZlIHfoXB0IAaam6hXEN5
         k1DRkwgCRXyGZDp0lLBHeerNm7g9MJeXW3ZprEvyD5tO/G5WLufK/d1dvkSnZebyrF4i
         DPWVexhV18WwDyp7IjcLmJ5PLsqwGIqH3xK0rAPYUbCMkNWeNepEQ1P9FfdnU1xf+X3H
         VDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725986334; x=1726591134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qc2iqPV1vRnwIRvIBD1uYrgHpwHjN+WZHb7prLzEOTU=;
        b=U5hA9QJFekCBsXmgViTEygAHjZdoFnlvG9NNFp5SN2VhmnKs0hXUIxe1kqCSe/9laY
         2m29MQo6NzJg+WpC3J0rAC2qy/zn+Co12Gwj2r75wAqMD4Z3rrZi0WfL4VpJz0Ki2wkp
         ypj5pu/14/D8th139yEExjeWV2kDpzrE9NRl0hvw+lke4MX2CF48wvhZyYTX3J47EKV4
         bZq5vVf1hx9aqgq38o5glWn67rZu85xWgfNIjKg9PBQift03f8pZsSi9yfb0Ve7bTqbX
         rZLfdkVSA9LFTTjmilRfEptRmunMxJt2mjJMLFRhnh/ZeLWJXKtakJsjJqucDarH0KcH
         jfxw==
X-Forwarded-Encrypted: i=1; AJvYcCUoMPkxnpf2J976KlBdZWbraJuzgMT4QVDzKRgigEZd5X1yvsVv4XrjTggWu9P76ra08lc7twFi9+WzBQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0gCGwRbl/5C9uLYMpWsO6zJukp0sZoDyUyH8GDSHUeHOcUBU
	FyHt94igzOjghgJhBQ0kSBXyP6r6gpg7aUZpIaTnjzkTKGZIWHehITqcrRuoT8a7SxDcJp+dW9j
	SF4awUNW/mA7PpC0kwePEm2fpUu8=
X-Google-Smtp-Source: AGHT+IHS0P9uQQvz9DK2yT3CoRqXx1KJWW8gCFk0B4Yuakw0MDhmwWcyqiCo+UAXtHDNnj3CM/jgepFikfKaGOOrhnw=
X-Received: by 2002:a05:6102:54a5:b0:498:d39b:b0ef with SMTP id
 ada2fe7eead31-49bde17d7b5mr13556479137.8.1725986333723; Tue, 10 Sep 2024
 09:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 10 Sep 2024 18:38:42 +0200
Message-ID: <CA+fCnZfFZCCq6ZQuVHoKY2tRJ3z1p0ftPW360-s=1JWd5Rv3JQ@mail.gmail.com>
Subject: Question about freeing of empty per-CPU partial slabs in SLUB
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlastimil (and other SLUB maintainers),

I have a question about freeing of empty per-CPU partial slabs in the
SLUB allocator.

The "Linux SLUB Allocator Internals and Debugging" article [1] states:

"If the partial slab becomes an empty slab after freeing up the
object, it will be left in its current list if the number of partial
slabs for the concerned node is within the limits (i.e < slab cache=E2=80=
=99s
min_partial). This applies to both slabs belonging to a per-cpu
partial slab list and slabs belonging to a per-node partial slab list.
If the number of partial slabs are outside the limit (i.e >=3D slab
cache=E2=80=99s min partial) then the newly available empty slab is freed a=
nd
is removed from the corresponding partial slab list."

The part that seems wrong to me here is the statement that this
applies to the per-CPU partial list. Based on the code in __slab_free,
it looks like it cannot reach the slab_empty label for a slab that is
on the per-CPU partial list.

(I know that an empty per-CPU partial slab can be freed when the list
overflows or via shrinking, the question is about the slab being freed
directly by __slab_free.)

Is the article wrong with regards to this case? Or did this behavior
change recently (I failed found any traces of this)?

Other than this statement, the article seems to be correct about all
other small details that I looked into, so I'm not sure whether my
understanding of the code is wrong of the article is.

I hope you could clarify this.

Thank you!

[1] https://blogs.oracle.com/linux/post/linux-slub-allocator-internals-and-=
debugging-1

