Return-Path: <linux-kernel+bounces-389708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5169B704D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B4F1C214C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A51E32B0;
	Wed, 30 Oct 2024 23:07:58 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEB1C461C;
	Wed, 30 Oct 2024 23:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730329678; cv=none; b=KnZzC0iBp+jTpzMLQfxzmDPb1rJ7VjO4Ho0+H288LxdwaBUyKR2bNkPGcUe5xjQNBL90RquKzNpCoGHERDS2kacSmHFQ27AMFtCbM2zkSoF6UJvp25UpcIM3pNT2qP7p2YYKHWW2S7nbHu+3miuJPurkwOu20Im/WKy/Op3A9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730329678; c=relaxed/simple;
	bh=k04NMNMXrqvRSgu6BgTwsk5XZckCcyxM4DuTyrBThII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iww5Tg2+FFnckzBHywQ+pqdXL8A6QHvQIFNSVgi3Cyd/0RQl2U0nI/+Gq8MBDohYrKOEx9ieFIvGRRFyZMWZr/YB4Z12MjMcOjtAsEAPbIwgIAdXUpcbzz5OwvXORuxhrEGYU388xnFfWqgTzTsYbNz7nOqU1ulEQ0D1PbnS3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4a46f36158cso92896137.2;
        Wed, 30 Oct 2024 16:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730329675; x=1730934475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+cw5OG7++HvTkMSlH1pqCx2RaNzRtRQbppMdg7fFUU=;
        b=WNKePoOyvCS7+OEqP/VwPHuES8pZrnak4jBcG8ZIxHHAaij16zLZ4es6IPqjXE/9iD
         9obz3nnoJOVlFH2MWRAy9dzrl16IjFX8mtW6Zcr8AhnaKL5nAtl+7Xy8kpk8vLfQSvHF
         fJpvyu6tuPKs9rF1K7TbVki7zuBWOPjMVQU7k6iQJA9OGnDmuTixJJ890byXC3Xk0i2r
         fgAiq4QyutsjXVTPUKlHi9oPlJlzNKlpOZ/AxFxZEs8oeTULBcLlznt0ONfQ8y7sTkmA
         PGMQc0o1b4R4oDvGgX6QKF7dzoLFscIGbBXSaFn8SBLO2Oxd4apV1gIa8uk0IqIplm5u
         G2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWybKhio3wzbNyJuPIYPUPy7xXk1P1Izb/tWVO8aNJ5MTgPlFt0G8fG50wOtgHnUfe1hi8XNxSBPPY=@vger.kernel.org, AJvYcCXWP0+iu3WQghF+Mx9yeA5FwKj0cF2PK757bd09MucxB/htLohUhp357lZtrG6b5oUBalOHE22Swok3NsEX@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZ/IpW8l9dmT19/zcxe90xBbUy3cUeuIEQ8sqV9jbbhmuMC6C
	qr+ne8YCHEQNY/PoYUTh77/1JUAr1EUBUmG+HCAcLLAtK8T1/gGEmMhanzuCue3/v8qYquo8oSI
	lkbHRt75CDqEaZVK22qv5D2Ad5VU=
X-Google-Smtp-Source: AGHT+IGMklRUceOybb5U8CHA0gtern1luq2xaMrw4Yb+ytFY1QGuLZnSOWQsuvsCXLhJuiQT5lwa8DbpcFqiKvGY8/M=
X-Received: by 2002:a05:6122:922:b0:50d:9c60:830c with SMTP id
 71dfb90a1353d-5105d041fd0mr5485812e0c.7.1730329675518; Wed, 30 Oct 2024
 16:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030130308.1066299-1-mcanal@igalia.com> <20241030130308.1066299-5-mcanal@igalia.com>
In-Reply-To: <20241030130308.1066299-5-mcanal@igalia.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 31 Oct 2024 12:07:44 +1300
Message-ID: <CAGsJ_4zMppHY29XXepOVTdEu2-1U6mGyZ8FqXZfP_in+2T3NAA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:03=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Replace strcpy() with strscpy() in mm/huge_memory.c
>
> strcpy() has been deprecated because it is generally unsafe, so help to
> eliminate it from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
>  mm/huge_memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f92068864469..8f41a694433c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
>
>         if (!str || strlen(str) + 1 > PAGE_SIZE)
>                 goto err;
> -       strcpy(str_dup, str);
> +       strscpy(str_dup, str);

What is the difference between strcpy and strscpy without a size parameter?

we have already a check and goto err. strcpy() is entirely safe.
         if (!str || strlen(str) + 1 > PAGE_SIZE)
                 goto err;

My understanding is that we don't need this patch.

>
>         always =3D huge_anon_orders_always;
>         madvise =3D huge_anon_orders_madvise;
> @@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct file *=
file, const char __user *buf,
>
>                 tok =3D strsep(&buf, ",");
>                 if (tok) {
> -                       strcpy(file_path, tok);
> +                       strscpy(file_path, tok);
>                 } else {
>                         ret =3D -EINVAL;
>                         goto out;
> --
> 2.46.2
>

Thanks
barry

