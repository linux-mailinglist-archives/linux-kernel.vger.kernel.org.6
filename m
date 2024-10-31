Return-Path: <linux-kernel+bounces-391252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECA79B8469
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39B31C21C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BC6146A66;
	Thu, 31 Oct 2024 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqOatbGS"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501DF149C55;
	Thu, 31 Oct 2024 20:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406684; cv=none; b=BSU2oCi5mvMn4zbq1Fr25l06ejAyi9Jo8xLnA1QyjKTDdjlD5jrZQs/sNe5WBqwDgQNMPpPmDgSojLthaHdnARuvbPdiMNK+P/OAvweRGvToOZBWGZ+R3DaPJ9TC4OUvMQ4QhAZm3ylqHhamTrNiC+WuOL2XfwhxatzMeezPdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406684; c=relaxed/simple;
	bh=P1bJiXe8GnKyu/ySxojpU6jwUOt2VNjYBJzNu185JFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvNjpKtvFW0jWQvUYETyvuYc1su8qB6auyj6eN3FVBHEWLfWoqHwhu5fbI2152IddO3osZprBUkmKX70FnhgXjJEVsqpzIIMGCj1idZrxGbSnyboZb1rpfOhzs+XYH5qL52i6R7dR+3QUnLePio1xxfXMOiIVMBBcUacLl16ziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqOatbGS; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-50e08caccaaso340886e0c.3;
        Thu, 31 Oct 2024 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730406681; x=1731011481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjKN7tZX5djLcQKARKgrJqvB70L8Avjuss3DvMiTveI=;
        b=GqOatbGSLAQfUKuwxybdQPjKVXPWYCWyl2hEaxV1VHSx7yzg+NHvTA3MK/DovOosp7
         bSPfB6GEScCSIj6USdATOUqDs1J0loRQvgOPCNeBGHDT96g5eeTqiTGNCQ3cYTKuQc/Y
         Q46I6KnbhYxt8nKUxWown9rJUU5GuXI4jhUI1Ok5A2hP0mcsNkDFaGLqpEMir56nWrMi
         GcUvtX+mcHch9S8zI+evrCJVIIBd0DE0yEn361JBHYmWEUKfGEXNYraJ1AUvh9uD/Psa
         k+2XM45DvqFkMGY6fRk4OXB0uVjkkuLCiOOG+gVLZnZQKSLfTckX4a6pU2GSUHh5XYlu
         +mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406681; x=1731011481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjKN7tZX5djLcQKARKgrJqvB70L8Avjuss3DvMiTveI=;
        b=aCGzNrESMQxA0Uv+mlHZi00+fDUZOhxYKkQIZkcY52+UrHxJX7K1buGOWbfMGEgf26
         x5/xxylWJ8wIdE+TVRb/m0AzkIPf0VMmQv6ldJKt4clwDS2NeCet2qzP8w0NWMWSIcbd
         DLfwTEHX0zqUEBzMVZtwoIC6hptFBO7qEH2TJeDbAsk6jlpm06IArX6PQpCrRvkOAaxW
         UB1d6ZnmMVXyREHd4nTxJO5L0+tkXqf41qfoyQnI6C1POaFAfCPuEqNETzCi5uPIvgLF
         AoiPlqMuPozLkvxOfyiKaagjSMnTvHGEi2YT7dpcUIeNqFzuPVEKS5hPanquAGkEYyUj
         cuuw==
X-Forwarded-Encrypted: i=1; AJvYcCU5RqiSBWz2q1DVcvp0nKAjfI+phnjv+ic+SRlf/k2QZFYrAGU6F3migah+hgpKkdxoKdXqfZyQXVTtj+I4@vger.kernel.org, AJvYcCUbB+/ErpebslOZwnuPCd+xClBjM+yT8Sfd/cMGHxvOG59faRLOJLh+KLuAJamphbnSGSs9nd5L9gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxQr+XvxCRalutawmSgpLoex6ZiR9LCRkwzmjC/LJq/nwMwQm
	Ho/kteYu3hAzezm1Zus7j+0XwzOhZk7htnWUUAtIUwICAG2RCE27DtqJinz0Pbw2NewHrdDrpTc
	2RxpwnHKQP9EJ4nJFGnTtpGQlbc8=
X-Google-Smtp-Source: AGHT+IEmyVDhmBiDFywpW0Y5L3JMBL1wCacCAVV6g4W1w/fQzAjSYfRVrCOQVnesEO9IM5y19B5DvolYUSWaCQNk4Gk=
X-Received: by 2002:a05:6122:659a:b0:50d:c2e6:2730 with SMTP id
 71dfb90a1353d-5105d002b39mr10005710e0c.2.1730406681092; Thu, 31 Oct 2024
 13:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030130308.1066299-1-mcanal@igalia.com> <20241030130308.1066299-5-mcanal@igalia.com>
 <CAGsJ_4zMppHY29XXepOVTdEu2-1U6mGyZ8FqXZfP_in+2T3NAA@mail.gmail.com>
 <b31bd54c-400c-4432-8b4b-0ba12bcf8011@igalia.com> <CAGsJ_4wKdCq8HnH=R3dWefZAqbLjyX06WdJ4T_UMogFZDS7Wqg@mail.gmail.com>
 <d3549d00-3f58-4f62-8903-4b7b8b3a42b1@igalia.com> <CAGsJ_4x95s_wkzvJS-Yjy2yyv5NRRSfkQHeoa6sPeWj_pX8s=g@mail.gmail.com>
In-Reply-To: <CAGsJ_4x95s_wkzvJS-Yjy2yyv5NRRSfkQHeoa6sPeWj_pX8s=g@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 1 Nov 2024 09:31:10 +1300
Message-ID: <CAGsJ_4xj2TJuH0Kd8hhRfhmfn2ek+9v-iD8qjZM6pNAHEj8kgQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com, kees@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:27=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> On Fri, Nov 1, 2024 at 1:12=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.co=
m> wrote:
> >
> > +cc Kees Cook
> >
> > Hi Barry,
> >
> > On 31/10/24 09:01, Barry Song wrote:
> > > On Thu, Oct 31, 2024 at 6:55=E2=80=AFPM Ma=C3=ADra Canal <mcanal@igal=
ia.com> wrote:
> > >>
> > >> Hi Barry,
> > >>
> > >> On 30/10/24 20:07, Barry Song wrote:
> > >>> On Thu, Oct 31, 2024 at 2:03=E2=80=AFAM Ma=C3=ADra Canal <mcanal@ig=
alia.com> wrote:
> > >>>>
> > >>>> Replace strcpy() with strscpy() in mm/huge_memory.c
> > >>>>
> > >>>> strcpy() has been deprecated because it is generally unsafe, so he=
lp to
> > >>>> eliminate it from the kernel source.
> > >>>>
> > >>>> Link: https://github.com/KSPP/linux/issues/88
> > >>>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > >>>> ---
> > >>>>    mm/huge_memory.c | 4 ++--
> > >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>
> > >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > >>>> index f92068864469..8f41a694433c 100644
> > >>>> --- a/mm/huge_memory.c
> > >>>> +++ b/mm/huge_memory.c
> > >>>> @@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
> > >>>>
> > >>>>           if (!str || strlen(str) + 1 > PAGE_SIZE)
> > >>>>                   goto err;
> > >>>> -       strcpy(str_dup, str);
> > >>>> +       strscpy(str_dup, str);
> > >>>
> > >>> What is the difference between strcpy and strscpy without a size pa=
rameter?
> > >>>
> > >>> we have already a check and goto err. strcpy() is entirely safe.
> > >>>            if (!str || strlen(str) + 1 > PAGE_SIZE)
> > >>>                    goto err;
> > >>>
> > >>> My understanding is that we don't need this patch.
> > >>
> > >> strcpy() is a deprecated interface [1]. From the GitHub issue I link=
ed
> > >> in the commit description, Kees states: "A lot of kernel code is sti=
ll
> > >> using strcpy(). While the CONFIG_FORTIFY_SOURCE wrapper macros tend =
to
> > >> make its use mostly safe, it would be nice to eliminate the function
> > >> from the kernel entirely."
> > >
> > > I don't see any value added here since strscpy() has no size paramete=
r and
> >
> > As `str_dup` is a sized buffer, we don't need to specify the size
> > parameter.
> >
> > > we have checked strlen(str) + 1 > PAGE_SIZE to avoid parsing any poin=
tless
> > > bootcmd longer than PAGE_SIZE.
> >
> >  From my point of view, this is an extra layer of safety. A developer
> > could change `str_dup` to SZ_4K and leave PAGE_SIZE in the check. This
> > could pass by in a review and we would have a check that allows strings
> > bigger than the destination buffer in systems using 16KB pages.
> >
> > But see that `split_huge_pages_write` uses `strcpy` without any checks.
> >
> > I can remove the internal check from `setup_thp_anon` if you feel it
> > would be more suitable.
>
> My point is that we shouldn't remove the strlen(str) + 1 > PAGE_SIZE
> check, as it could lead to situations like this:
>
> For thp_anon=3DAB, where len(A) =3D PAGE_SIZE and B is illegal, we would
> mistakenly interpret the string as valid by ignoring B after trimming it.
>
> Therefore, if you remove the check, you could instead do:
>
> len =3D strscpy(str_dup, src);
> if (len >=3D sizeof(str_dup))
>       err;

Perhaps -E2BIG ( or < 0) i'm not quite sure :-)

>
> I have no objection to replacing strcpy with strscpy, so feel free to go
> ahead :-)
>
> >
> > Best Regards,
> > - Ma=C3=ADra
> >
> >  > > But I have no objection to this patch if other people like it.
> > >
> > >>
> > >> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#s=
trcpy
> > >>
> > >> Best Regards,
> > >> - Ma=C3=ADra
> > >>
> > >>>
> > >>>>
> > >>>>           always =3D huge_anon_orders_always;
> > >>>>           madvise =3D huge_anon_orders_madvise;
> > >>>> @@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct=
 file *file, const char __user *buf,
> > >>>>
> > >>>>                   tok =3D strsep(&buf, ",");
> > >>>>                   if (tok) {
> > >>>> -                       strcpy(file_path, tok);
> > >>>> +                       strscpy(file_path, tok);
> > >>>>                   } else {
> > >>>>                           ret =3D -EINVAL;
> > >>>>                           goto out;
> > >>>> --
> > >>>> 2.46.2
> > >>>>
> > >>>
> Thanks
> barry

