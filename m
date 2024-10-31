Return-Path: <linux-kernel+bounces-391247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17119B8457
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BAEA283087
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70B1CCEEA;
	Thu, 31 Oct 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO7QTYNh"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A31CC897;
	Thu, 31 Oct 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406455; cv=none; b=FgwQ9Cxm6vp4kWVBFwDtA8YbMcWUxW3aUJitp9vJAfdBdirHX5DxiLXwSfM5kwkFt67l4oxa7BKgOyzTSQ7DP5UtNTz3WqhOWr413q29+4VyE6x/++Z2SWX2UcKHmu5k/oKzkt3YNn425avGfZ9Q5d2s1XtDrWHAtMs04CYzNug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406455; c=relaxed/simple;
	bh=ksbw4OAtdunw38b5pHOwDydUmQIFq4t28QBYB/egqgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar08Bj8UysjKJ5D8KHLZcCZtd0Jtg53Xw3WL6M5ZGE1HYkzweBJPLPZOKoEHGedCOD4WMwXNEfAfOaFtx55cUHgLYp0ari3WEXivf461m+3plRHYO1xnFhZlvvfswyQbEFrjRSOahDxIG0yROfaFAfDRju+6YKlIh5qPMcur8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO7QTYNh; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d4213c5f6so449919e0c.3;
        Thu, 31 Oct 2024 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730406451; x=1731011251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amvcyG4D30V+zPACcGkMCnMlW1VYfRruH76cCv8fQ/Y=;
        b=DO7QTYNhMWQPkb/Vos6ZogsHQvMyy2WTUmNoIwQXNQhlr4wzKrMpNZkk4oLJNzrc6P
         qUymyQnTMACAEt+6QhawNsMNb5ujxGHN/3Aq93P71hClfXeNiL1DtMXgqYytcAF28cgF
         czj7BuVevZueh7ogl4+ZpLDNnzCCcZ/JdXCK3lRBpeyqqXA3uE6Qe2lygQdOCunCzK8W
         6aQTz1lCO2CkiFkw6OsP0lyiU9J83AHarh4qnZo2x/UJHE7N0puzQb0dBzu6qY67tl5x
         s2vLUKzge9XkNEaLn9D+QwnKxwa6Tn5XkwvQtcT4fWoxsRhVYyMWaR+Jr6Lq0e8Yx8bm
         W6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406451; x=1731011251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amvcyG4D30V+zPACcGkMCnMlW1VYfRruH76cCv8fQ/Y=;
        b=VcHRmdSlUbbQ0QRlxCKqsnJzI3ko1y7DBIX2Jr0A/rzNABXKKh8h+8TpXxx0f2ANM+
         /6g+iTsVwj3DIw4BB9fc98f/uH6eNNsY2YYS37sASVvVpPjbKbxAy6puyprk7AuvKTcD
         EEnw6s2vVqTZCFfjqjfgA2GXISAZpBCCB44c6O3cYTKAT27whuFRqy1dxhhF7/EXkWg6
         xu6FqYmL39hywJtkdYBMpSzQFUmlh5GmrQYWA5bXdfcIXNWX4RTfL9QNltVdFV1+KjOg
         fRY0CCmYR75NfhsDT+XaMNct5TjMk3s/rx/ADyZk0sA+uWlI3J28nhuKXrgH9Es/1xtB
         GDvg==
X-Forwarded-Encrypted: i=1; AJvYcCVhCD52ifA+x0QF59nvvZdjI0MhMe+q1OnWi7hfhaTi60S9qSQkaMAQuxZJDAGKcBtRDoFLoIhJfX4=@vger.kernel.org, AJvYcCWuR+SzFnQINUw3pqPmia+nHV58qHhFlFN/Kb8B5xTNU2EEN3ZPsGHgzgM4qE1j64eBYf8OcCSelYjgmcZ/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1KyeT1/rsVyH9Cv49pt110Lv+aJtnkL68YqXedfVUfd11fh0
	MuGaHSdcNEDuar8S80LBIeZE/EtKzRDUrtHbZJEDR/WHnCHCwBqAqZNu5JjGCl/ygfs79PN3ynJ
	orSHJv8/6SOrqEbWGZVj5mWn1C3U=
X-Google-Smtp-Source: AGHT+IEjP5n4EaL/lfyR2Oq4IthrHgwE9IctYNm9yJ0eUDY9obh+WLPxcfQ1PXLfkX2tfzwznjrPSroNST9yVLXbGUA=
X-Received: by 2002:a05:6122:31aa:b0:50d:5be4:c39d with SMTP id
 71dfb90a1353d-5106ad573c6mr5815502e0c.0.1730406451519; Thu, 31 Oct 2024
 13:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030130308.1066299-1-mcanal@igalia.com> <20241030130308.1066299-5-mcanal@igalia.com>
 <CAGsJ_4zMppHY29XXepOVTdEu2-1U6mGyZ8FqXZfP_in+2T3NAA@mail.gmail.com>
 <b31bd54c-400c-4432-8b4b-0ba12bcf8011@igalia.com> <CAGsJ_4wKdCq8HnH=R3dWefZAqbLjyX06WdJ4T_UMogFZDS7Wqg@mail.gmail.com>
 <d3549d00-3f58-4f62-8903-4b7b8b3a42b1@igalia.com>
In-Reply-To: <d3549d00-3f58-4f62-8903-4b7b8b3a42b1@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 1 Nov 2024 09:27:20 +1300
Message-ID: <CAGsJ_4x95s_wkzvJS-Yjy2yyv5NRRSfkQHeoa6sPeWj_pX8s=g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 1:12=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com>=
 wrote:
>
> +cc Kees Cook
>
> Hi Barry,
>
> On 31/10/24 09:01, Barry Song wrote:
> > On Thu, Oct 31, 2024 at 6:55=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igalia=
.com> wrote:
> >>
> >> Hi Barry,
> >>
> >> On 30/10/24 20:07, Barry Song wrote:
> >>> On Thu, Oct 31, 2024 at 2:03=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igal=
ia.com> wrote:
> >>>>
> >>>> Replace strcpy() with strscpy() in mm/huge_memory.c
> >>>>
> >>>> strcpy() has been deprecated because it is generally unsafe, so help=
 to
> >>>> eliminate it from the kernel source.
> >>>>
> >>>> Link: https://github.com/KSPP/linux/issues/88
> >>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >>>> ---
> >>>>    mm/huge_memory.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index f92068864469..8f41a694433c 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
> >>>>
> >>>>           if (!str || strlen(str) + 1 > PAGE_SIZE)
> >>>>                   goto err;
> >>>> -       strcpy(str_dup, str);
> >>>> +       strscpy(str_dup, str);
> >>>
> >>> What is the difference between strcpy and strscpy without a size para=
meter?
> >>>
> >>> we have already a check and goto err. strcpy() is entirely safe.
> >>>            if (!str || strlen(str) + 1 > PAGE_SIZE)
> >>>                    goto err;
> >>>
> >>> My understanding is that we don't need this patch.
> >>
> >> strcpy() is a deprecated interface [1]. From the GitHub issue I linked
> >> in the commit description, Kees states: "A lot of kernel code is still
> >> using strcpy(). While the CONFIG_FORTIFY_SOURCE wrapper macros tend to
> >> make its use mostly safe, it would be nice to eliminate the function
> >> from the kernel entirely."
> >
> > I don't see any value added here since strscpy() has no size parameter =
and
>
> As `str_dup` is a sized buffer, we don't need to specify the size
> parameter.
>
> > we have checked strlen(str) + 1 > PAGE_SIZE to avoid parsing any pointl=
ess
> > bootcmd longer than PAGE_SIZE.
>
>  From my point of view, this is an extra layer of safety. A developer
> could change `str_dup` to SZ_4K and leave PAGE_SIZE in the check. This
> could pass by in a review and we would have a check that allows strings
> bigger than the destination buffer in systems using 16KB pages.
>
> But see that `split_huge_pages_write` uses `strcpy` without any checks.
>
> I can remove the internal check from `setup_thp_anon` if you feel it
> would be more suitable.

My point is that we shouldn't remove the strlen(str) + 1 > PAGE_SIZE
check, as it could lead to situations like this:

For thp_anon=3DAB, where len(A) =3D PAGE_SIZE and B is illegal, we would
mistakenly interpret the string as valid by ignoring B after trimming it.

Therefore, if you remove the check, you could instead do:

len =3D strscpy(str_dup, src);
if (len >=3D sizeof(str_dup))
      err;

I have no objection to replacing strcpy with strscpy, so feel free to go
ahead :-)

>
> Best Regards,
> - Ma=C3=ADra
>
>  > > But I have no objection to this patch if other people like it.
> >
> >>
> >> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#str=
cpy
> >>
> >> Best Regards,
> >> - Ma=C3=ADra
> >>
> >>>
> >>>>
> >>>>           always =3D huge_anon_orders_always;
> >>>>           madvise =3D huge_anon_orders_madvise;
> >>>> @@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct f=
ile *file, const char __user *buf,
> >>>>
> >>>>                   tok =3D strsep(&buf, ",");
> >>>>                   if (tok) {
> >>>> -                       strcpy(file_path, tok);
> >>>> +                       strscpy(file_path, tok);
> >>>>                   } else {
> >>>>                           ret =3D -EINVAL;
> >>>>                           goto out;
> >>>> --
> >>>> 2.46.2
> >>>>
> >>>
Thanks
barry

