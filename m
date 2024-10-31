Return-Path: <linux-kernel+bounces-390456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A89B7A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BF41F23450
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49C19AD94;
	Thu, 31 Oct 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG7UE4Y7"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9541BC20;
	Thu, 31 Oct 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376093; cv=none; b=DTvGudDRM6Is2aY1CrjPyu1ibk1mtXBWU2KzcCJPwyWRZgW47AY3q+uUX8NV6aVQWLXlSzOhNTVHZC8LUtt2xfH8p+VnwROw6tw9+c3SodLsq9pjhzMubamVgA0lFWKKJ6HTIqVP/LjDw+Z7VFm/CfmTF3t3aXnRuTjQMtdviB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376093; c=relaxed/simple;
	bh=r7+GpHnuSdPyhO2OaQMhiKj1AQUn3TLel5d1jBC32mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJoXz+jJp5EtRQro4TT879W4h/ZOXurgoAPsLW3uorzOdLB4ZPBO1kIdspG4exebi5pTaVTfuMF7aa5OHB0+co1cmGNpbkzqv7O69KHsgT6bxDEpTjjTwr2xpmbeBcnIVMEn7kVm7XVy07Q2afmvuNjv+g9i8UMVFfCw0gFChoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG7UE4Y7; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5101c527611so308437e0c.3;
        Thu, 31 Oct 2024 05:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730376090; x=1730980890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DccZm6fu1sIHt1mYwpXsBPqzqI+zLJSK+Y1vdMw64e0=;
        b=dG7UE4Y7XG8rSImHz3H4c3f2TS4bjnLokSGnLk+y/4tImQ1VS4Ac7n40iI/OQuNSdh
         r+snS+IhVmWh29+BdykWWtZG6J1rV2zBIt8xzal8FYQf0hHRQiV2oT6aqJS2W30ysDvO
         cSS2LhgJKjfLzsDJkJFP6dOzVEfJuiSvvG8sLurZ3jwiFHr2guFXWd/lwom6+itrAn1X
         bsAm47CZQx0cMALap1Bbk0LHYOqjU36M0E5wCmPOPXcxHf/0r7X9FEvZBd8TvnjzU9wt
         N7rCVyW5KkAxhIwkLgmqUIzQcY4uNH9WHcmkIhWV9OlLw5QqKdlzATFDTnLeuvUmzzU6
         CxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730376090; x=1730980890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DccZm6fu1sIHt1mYwpXsBPqzqI+zLJSK+Y1vdMw64e0=;
        b=go2UrfLGfE5bwWTxpLi1E0iFpyr32qK4GBXPjwTReOgX8Qt00kuaKcmre1Fi2Qs6KQ
         3SWWZ1H3BIoWCOYQSP6HYgnUNGRTUWpJNBXQ0xBnJ1E5qRlli7hETu4/fm+0ycssNC1u
         0Am1q2CHKRZbeTPLxtckye83k5kePUSPFjUc5NCLnds1JGutMgfuuTqenrFKw8kg4GSQ
         5VyVJt9TRwZEUjOFbGtVQq5Ro7E63il3FHfmumMmw07joNy9nJxXViGKawuImJBdzE7G
         k5Cp7IQyCQo8qodSvrRPRgpd6ogXxMC/Rhh+cwGzaqsxwItKl0hHUJtLPUTGs3q4FtRK
         ajEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoxtgvrz/eD3sybDpKxl9kPuYPrUn4KG6tP5MzCxh1MXyYb8UE+F/NmpcjtgxZNdJene3RZfVsPfo=@vger.kernel.org, AJvYcCV1DJe6XLcTHtu+gop1NukWvL6Y9Igpze3HY7Swuf/7qZ/++c0vXKjHqFX64S3i1spKAVT36GhKUQa+E/Dr@vger.kernel.org
X-Gm-Message-State: AOJu0YwXe0G+IWDAJ/awVw6fHK/xlqSo9IzDKNYvcYNxAki6/WdsmJUo
	Oi/C0YhaPE3fe7fnRcj6U0HJE5zRWtTDowTJkrwjNAQ4ra/pdY4jzcKI7vZBCkFKNjsFLoQL+e1
	C1vbphukWBwU1SldNxefF3azFSDU=
X-Google-Smtp-Source: AGHT+IEBaEttvI7u3LdInO+YQ+Vkpn3Lv+KP/H2Daw/j31zmZWsRvgO9Er72MOCK7eHokNIxdl3zE1SQqE6leIPRzP4=
X-Received: by 2002:a05:6122:20a1:b0:50c:99da:4f70 with SMTP id
 71dfb90a1353d-51014ff5f49mr18293805e0c.2.1730376089678; Thu, 31 Oct 2024
 05:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030130308.1066299-1-mcanal@igalia.com> <20241030130308.1066299-5-mcanal@igalia.com>
 <CAGsJ_4zMppHY29XXepOVTdEu2-1U6mGyZ8FqXZfP_in+2T3NAA@mail.gmail.com> <b31bd54c-400c-4432-8b4b-0ba12bcf8011@igalia.com>
In-Reply-To: <b31bd54c-400c-4432-8b4b-0ba12bcf8011@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 31 Oct 2024 20:01:16 +0800
Message-ID: <CAGsJ_4wKdCq8HnH=R3dWefZAqbLjyX06WdJ4T_UMogFZDS7Wqg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:55=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Hi Barry,
>
> On 30/10/24 20:07, Barry Song wrote:
> > On Thu, Oct 31, 2024 at 2:03=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia=
.com> wrote:
> >>
> >> Replace strcpy() with strscpy() in mm/huge_memory.c
> >>
> >> strcpy() has been deprecated because it is generally unsafe, so help t=
o
> >> eliminate it from the kernel source.
> >>
> >> Link: https://github.com/KSPP/linux/issues/88
> >> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> ---
> >>   mm/huge_memory.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index f92068864469..8f41a694433c 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
> >>
> >>          if (!str || strlen(str) + 1 > PAGE_SIZE)
> >>                  goto err;
> >> -       strcpy(str_dup, str);
> >> +       strscpy(str_dup, str);
> >
> > What is the difference between strcpy and strscpy without a size parame=
ter?
> >
> > we have already a check and goto err. strcpy() is entirely safe.
> >           if (!str || strlen(str) + 1 > PAGE_SIZE)
> >                   goto err;
> >
> > My understanding is that we don't need this patch.
>
> strcpy() is a deprecated interface [1]. From the GitHub issue I linked
> in the commit description, Kees states: "A lot of kernel code is still
> using strcpy(). While the CONFIG_FORTIFY_SOURCE wrapper macros tend to
> make its use mostly safe, it would be nice to eliminate the function
> from the kernel entirely."

I don't see any value added here since strscpy() has no size parameter and
we have checked strlen(str) + 1 > PAGE_SIZE to avoid parsing any pointless
bootcmd longer than PAGE_SIZE.

But I have no objection to this patch if other people like it.

>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
>
> Best Regards,
> - Ma=C3=ADra
>
> >
> >>
> >>          always =3D huge_anon_orders_always;
> >>          madvise =3D huge_anon_orders_madvise;
> >> @@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct fil=
e *file, const char __user *buf,
> >>
> >>                  tok =3D strsep(&buf, ",");
> >>                  if (tok) {
> >> -                       strcpy(file_path, tok);
> >> +                       strscpy(file_path, tok);
> >>                  } else {
> >>                          ret =3D -EINVAL;
> >>                          goto out;
> >> --
> >> 2.46.2
> >>
> >
Thanks
barry

