Return-Path: <linux-kernel+bounces-528302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5133A41607
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC95188AEF4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BBD19ABB6;
	Mon, 24 Feb 2025 07:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WExZ5WrJ"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B52241676
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381121; cv=none; b=DsdEXRZUwhTiWr6WMUH7FPlytzQjLARLYYLfgfRkUUhExYNvFSvNECu15lfHWMQycaYp35tvp3PDpcZZ9msLazy4FDewv0Jrld4Pl5L6B8z/zxPKdrzy2xe5A7n5NEkL4Vbut2fdaEI99mrvssIoFZAj3kl7MkOiUsNkG/sWKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381121; c=relaxed/simple;
	bh=/1UkArgjZHBVNZF0wcs9JPzFXDkQUWusPAcUgb/TvRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuX7fXCflzmErzCaWXA/fPl0q1ZNjG5AgF1VtBTJz4ej2DXphbELbmK/g8t6apj4loquTYGuu7PgAhw3Cs8TLfqoKCpaNi4MjurKL1vJ1zRm++t0VhFUq++z+sotccPIbTe7qmR4yykQPv6YSoHBo7m93/IR6rxKfazzSnrCMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WExZ5WrJ; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-8692998b124so2491090241.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740381118; x=1740985918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIvNwyb9c99qju9CvFMo9HfVex7JVbi6QU5PjcFvET8=;
        b=WExZ5WrJMmVB0tbcf77bUYXC0jfwX/LB22STMDNFz3rNwR9AFICbEmoK6tUsrlPnPV
         YfMtm3gcc4tdT5qdURv/vuRUzrmK1mkcHxb2vy06hvVzEKIzZ+wkb4Aar3JX1xjpR6y9
         bQ/Yknlir8tqbhFV05wIIoHFazs/JUuLFxJVcyNCvjqMX0RhtfAhBUkD0FSicA/tXkuL
         rbn0cXPgmal5HNQ6SY+gZfsRQHpIL7D6PjOGJTXaBHBVRPgF5TbFYdSpu2ODykc5clg5
         F5pWz4SE1M7BMysHulDRybwNkskSbxfLWL0yIqKbni9yERoaM6TUMkbedoPdyKSoJI26
         3dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381118; x=1740985918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIvNwyb9c99qju9CvFMo9HfVex7JVbi6QU5PjcFvET8=;
        b=cGqOUypW6yeUNyajqPuStCTrPF1zatVO4Q4uX0kev0u2kkFOiHVxYSbtl0QRScDQix
         BtswkRZ3Pk9wFkdRlAZBA7fd3BlGlzzTcuYh5urBzySOJnCPsrYTFnfJ8+n3qgdpH4vy
         XQHx0SBULntqbhag9jjMt3REgW5QkZpF7Ct3b+bHPNXEOGS/Q5NTseQ4TRvUFkCeZQVq
         5gYdmhISUATTO+ftj2J8msXDyCDo/+Vgyq8rvoGyJBGn8aCzjFERrZX/nce4yupguSIc
         62t7kJz1oue1uEyQt/vuoRcwXyYs1Y1RtO1NfGkReeaXr/v69CR+V3NZgRxQoOeQKhMW
         4phg==
X-Forwarded-Encrypted: i=1; AJvYcCUl+apUMACUISJB043uCQdCbPlBbNUBBiH5XXhqVEFntLI03XMyaA974n8BZ5pl5snZRUTcdm3B3QA2bxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ijp0fdsu9SvFJPhmeoF+/G1kp/l8FaXHte9yL38DQWTCniMx
	tqNofLuO0vlbzaFvzkNjEe1gpplMABojJJM031js0+iOLhJSsvsBJHKPslMdP/u9qnxb/HQvAkE
	oFoLp7c5p1fM73ZCoI7lbDzJNHnA=
X-Gm-Gg: ASbGncvWlqfXu+ZPxauPiqXHSx27muQ/Sw+zGrW2y36hnk5E4MWyLH8FDqyEFYTp7/6
	aSbGMkxcEAYKPDNj4MghRUOU2naUOLWpDlKjA6P2ja/u6G9Tc885+DWYK6sC1EJBFjjHZ0gU92r
	643Mb9cFE=
X-Google-Smtp-Source: AGHT+IFAWFdhAsiWn8tZVTQlMqHrJNKUqCfhEJP0T3oeRrmv05lMcKz4+5DsgNOnvqVCZuF2D+XbpSDoHQKbWh2pUnI=
X-Received: by 2002:a05:6102:3590:b0:4bb:cbbc:38 with SMTP id
 ada2fe7eead31-4bfc27af44cmr5255329137.5.1740381118541; Sun, 23 Feb 2025
 23:11:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222024617.2790609-1-mawupeng1@huawei.com>
 <Z7lIYzLSACbWxlEM@casper.infradead.org> <2c7dfa44-266a-4aa6-9401-7528368f171e@huawei.com>
 <Z7qK-NFJsqcV0rPw@casper.infradead.org> <CAGsJ_4xHaaf_DHsFZ_zEqEd3Nb9C=7JJjy5gGFo+RhEhQYX_tg@mail.gmail.com>
 <61566a74-04aa-44f1-9aa9-624644f06450@huawei.com>
In-Reply-To: <61566a74-04aa-44f1-9aa9-624644f06450@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 24 Feb 2025 20:11:47 +1300
X-Gm-Features: AWEUYZmed7yyNa1vGcuthB1-aGrOUUAhknAIxzyTspe7dvxQa1il-ggOwjB4yC0
Message-ID: <CAGsJ_4zLw5+A+0gaeubBSLuL1EcaHgFa41dt+BG3VgmPsF=Ocw@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry
 found during do_swap_page
To: mawupeng <mawupeng1@huawei.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	kasong@tencent.com, ryan.roberts@arm.com, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, schatzberg.dan@gmail.com, hanchuanhua@oppo.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:27=E2=80=AFPM mawupeng <mawupeng1@huawei.com> wro=
te:
>
>
>
> On 2025/2/23 14:18, Barry Song wrote:
> > On Sun, Feb 23, 2025 at 3:42=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> >>
> >> On Sat, Feb 22, 2025 at 11:59:53AM +0800, mawupeng wrote:
> >>>
> >>>
> >>> On 2025/2/22 11:45, Matthew Wilcox wrote:
> >>>> On Sat, Feb 22, 2025 at 10:46:17AM +0800, Wupeng Ma wrote:
> >>>>> Digging into the source, we found that the swap entry is invalid du=
e to
> >>>>> unknown reason, and this lead to invalid swap_info_struct. Excessiv=
e log
> >>>>> printing can fill up the prioritized log space, leading to the purg=
ing of
> >>>>> originally valid logs and hindering problem troubleshooting. To mak=
e this
> >>>>> more robust, kill this task.
> >>>>
> >>>> this seems like a very bad way to fix this problem
> >>>
> >>> Sure, It's a bad way to fix this. Just a proper way to make it more r=
obust?
> >>> Since it will produce lots of invalid and same log?
> >>
> >> We have a mechanism to prevent flooding the log: <linux/ratelimit.h>.
> >> If you grep for 'ratelimit' in include, you'll see a number of
> >> convenience functions exist; not sure whether you'll need to use the r=
aw
> >> ratelilmit stuff, or if you can just use one of the prepared ones.
> >>
> >
> > IMHO, I really don=E2=80=99t think log flooding is the issue here; rath=
er, we=E2=80=99re dealing
> > with an endless page fault. For servers, that might mean server is unre=
sponsive
> > , for phones, they could be quickly running out of battery.
>
> Yes, log flooding is not the main issue here, endless #PF is rather a mor=
e serious
> problem.
>

Please send a V2 and update your changelog to accurately describe the real
issue. Additionally, clarify how frequently this occurs and why resolving
the root cause is challenging. Gaoxu reported a similar case on the Android
kernel 6.6, while you're reporting it on 5.10. He observed an occurrence
rate of 1 in 500,000 over a week on customer devices but was unable to
reproduce it in the lab.

BTW, your patch is incorrect, as normally we could have a case _swap_info_g=
et()
returns NULL:
thread 1                                           thread2


1. page fault happens
with entry points to
swapfile;
                                                       swapoff()
2. do_swap_page()

In this scenario, _swap_info_get() may return NULL, which is expected,
and we should not return -ERRNO=E2=80=94the subsequent page fault  will
detect that the PTE has changed. Since you have never enabled any
swap, the appropriate action is to do the following:

        /* Prevent swapoff from happening to us. */
        si =3D get_swap_device(entry);
-       if (unlikely(!si))
+       if unlikely(!si)) {
+                      /*
 +                     * Return VM_FAULT_SIGBUS if the swap entry points to
+                      * a never-enabled swap file, caused by either hardwa=
re
+                      * issues or a kernel bug. Return an error code to pr=
event
+                      * an infinite page fault (#PF) loop.
+               if (WARN_ON_ONCE(!swp_swap_info(entry)))
+                       ret =3D VM_FAULT_SIGBUS;
                goto out;
+       }


> >
> > It=E2=80=99s certainly better to identify the root cause, but it could =
be due
> > to a bit-flip in
> > DDR or memory corruption in the page table. Until we can properly fix i=
t, the
> > patch seems somewhat reasonable=E2=80=94the wrong application gets kill=
ed, it at
> > least has a chance to be restarted by systemd, Android init, etc. A PTE=
 pointing
> > to a non-existent swap file and never being enabled clearly indicates s=
omething
> > has gone seriously wrong - either a hardware issue or a kernel bug.
> > At the very least, it warrants a WARN_ON_ONCE(), even after we identify=
 and fix
> > the root cause, as it still enhances the system's robustness.
> >
> > Gaoxu will certainly encounter the same problem if do_swap_page() execu=
tes
> > earlier than swap_duplicate() where the PTE points to a non-existent sw=
ap
> > file [1]. That means the phone will heat up quickly.
> >
> > [1] https://lore.kernel.org/linux-mm/e223b0e6ba2f4924984b1917cc717bd5@h=
onor.com/
> >

Thanks
Barry

