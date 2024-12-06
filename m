Return-Path: <linux-kernel+bounces-435469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A4B9E7844
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B3418869C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829731DA612;
	Fri,  6 Dec 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adytRsIQ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C31D6DB1
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733510610; cv=none; b=GepJqMp/zRAUsw5AeUhLUZKY7mWDnCz4q6XdayEw+ohIlRtug6OQ/8I3bU+t2F+KN0EhXgGRlCM9PERdooxkDndNYsH72tdWPpkvKStpc7rL4YAlpb8LhH/tDG6dZO7CL6cNs/etsy4plDMouBFDu/ccDYOns4XwIy9UWa0eYK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733510610; c=relaxed/simple;
	bh=iQcm115gWE6WA4WBEAY5qj+MCjWx6Fk8a4BOCCaxeFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDxmF8VO30iLFkDHygLyFRWWCE9T9Yi9LMHYG4ztD3fwTowjmuabQ6+asqs7zLfwNHoAy3NiVedau51OY6T9Z/qtqpAZlJdKGjgYiMSGIhKqu3whY5AwxoeP2erZ8ORcnb6zQdYsVH8hiPeVvBueX0nZsUI4oQSbPpZM3U2zg8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adytRsIQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d0c939ab78so317a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 10:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733510607; x=1734115407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQcm115gWE6WA4WBEAY5qj+MCjWx6Fk8a4BOCCaxeFw=;
        b=adytRsIQbTXDHQYjFUhTRaMsA0+TmGAS9YK3S5y+eaIQjj0DChQj4rgY9k9vNRcWGs
         WAnN3rm9g/sIJ0SaDQ95gYhCTuBtUn2XYFYULJQm32vRaGTyQjsG9+7ErwToxfNL4ueH
         MhlawbEPTrG5POKnZLEtEnTaUo7IUmsn3PL6HsK/z8pjNmK9IdDA2piYV9VOKJD75poT
         awAR9Z+YccSi1gGocAhULOpl3+0gnl8tAmBBbG1VWErddxBEFbAukrCnYOoCOU8w0K3R
         YB+t9yI4Xt2SbMPQ5vfkqYLQk0Me35os6fktosoB1LjoICTsu3RcObemH0umQNkRVvJk
         IsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733510607; x=1734115407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQcm115gWE6WA4WBEAY5qj+MCjWx6Fk8a4BOCCaxeFw=;
        b=tUV5qwM/ZCCjquxnUKgGnekagHZrDC2H6Tpr9w91m99w7TcHxfUSA19yUqYbfPgNZX
         qvGTRt0kJyTA6Xjmkw2KPOzBfAXGD1+G4Cn16igJmo4g5RG6Nn+/miEU2by1mRJSMTq4
         OGDo48cBnlMBKIVxioHJoYCtFvK769heH1atNyWdCsacrxxBLsAYrVHp7wJlp5ZcB1yi
         96ZoOobx1R9G2E/gktV7klBcdlQ1Y/j0gNF2KEUV78SIa5g42fX1UOBGgTCF+FT+LcBQ
         rezziha7kkCWd+g2nfTtEW5zYlHjLlXgfwLJSkpFcUfkYnOjaBSID3Tc5q95W2pwLl/0
         zpNg==
X-Forwarded-Encrypted: i=1; AJvYcCVihpmz7Aox2gn6YVrof5mgaued0zq4a2HkU6LT6w2p9nXIJnBDdfRIXR4by3n+dUiOp7TBy9ECx37ZauI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgq+sffJVT4xd9R+SbrKnt2zhVmJrBVnghFA3Y3ahZ78Q2Ijf
	SjyoHG3dtsVqRk9iiJLnKOj08MZfET+oaINJmSxVneVmW9H2vBKH4ormf56gQspubY+SBJYPryE
	EU+3mrX1Mpm7ZzaoT/2Q84RXStBOfUqqbG/Sb
X-Gm-Gg: ASbGnctoTfKxpASY43HS5AsIGtrVEE7qOXu2b7I6cXE42k/bczQbYGNBTaWXzI/vrlQ
	r+BqtnkEugLCLnNWraADjS1R3xECL6XUV6G7Zhh42J6z5d3zwJkoKXoNGBq8=
X-Google-Smtp-Source: AGHT+IG4ty4Jterfb/i6aBrFMav0nkL0Jeq7yVrGMkkkhYQ2+NYQpzP0AUUmDy8KcjUWwLhusQV9LocshbtbteglR9k=
X-Received: by 2002:a05:6402:c0d:b0:5d0:b20c:2063 with SMTP id
 4fb4d7f45d1cf-5d3c2673469mr86340a12.7.1733510607054; Fri, 06 Dec 2024
 10:43:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206152032.1222067-1-bgeffon@google.com>
In-Reply-To: <20241206152032.1222067-1-bgeffon@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Dec 2024 19:42:51 +0100
Message-ID: <CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mremap: Fix newaddr hint with MREMAP_DONTUNMAP
To: Brian Geffon <bgeffon@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Marco Vanotti <mvanotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+mmap maintainers (maybe mm/mremap.c should be added to the file
pattern for "MEMORY MAPPING" in "MAINTAINERS"? I'm not sure)

On Fri, Dec 6, 2024 at 4:20=E2=80=AFPM Brian Geffon <bgeffon@google.com> wr=
ote:
> mmap(2) allows for a destination address to be specified without
> MAP_FIXED and in this situation it's a hint to get_unmapped_area().
> This address need not be page aligned because get_unmapped_area() will
> align the hint.
>
> In the case of mremap(2) with MREMAP_DONTUNMAP it shares a code path
> with MREMAP_FIXED in mremap_to(), which means this function can be
> called in 3 different scenarios: MREMAP_FIXED only, MREMAP_DONTUNMAP
> only, or MREMAP_FIXED | MREMAP_DONTUNMAP. In the second case when only
> MREMAP_DONTUNMAP is specified we don't need to do alignment or size
> checks on newaddr because they will be passed to get_unmapped_area() and
> dealt with appropriately.
>
> This patch corrects that behavior to match what non-MREMAP_DONTUNMAP
> mremap(2) and mmap(2) do. This odd behavioral difference was reported by
> Marco Vanotti. Additionally, I've included a self test to validate this
> behavior.

Marco pointed me to this; I had no idea mremap() had this undocumented
behavior where it takes a hint address. The mremap() manpage is
currently wrong about this, it sort of implies that the new_address
argument is only used if MREMAP_FIXED is set.

Marco also noticed that upstream glibc now assumes this behavior:
https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D6c40cb0e9f893d49dc=
7caee580a055de53562206

Debian also has a test that explicitly checks for this behavior:
https://sources.debian.org/src/glibc/2.40-4/debian/patches/git-updates.diff=
/?hl=3D22820#L22818

I guess it's too late to remove that behavior at this point, and the
right thing to do is to update the manpage?

