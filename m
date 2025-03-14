Return-Path: <linux-kernel+bounces-560627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D045CA60771
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9323B7AD19C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 02:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E038F82;
	Fri, 14 Mar 2025 02:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CP49vXR9"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675D2E337C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741918864; cv=none; b=dSLkR5wwrUBphSAsrfUQRYRw7WmQI4xkiXFSULjIvJZtwLzw5+0X6+Bk8q/nRspP0KtO0on3H7SR4yeR1tQVFmYEc/8TpMxkFK6LnwyFmnCpLxFYU181HlkJIUcWzOe1Ig4WyK2WYdOyXU7SeQ7dpv2J4T7ps7mosyDrghlhv3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741918864; c=relaxed/simple;
	bh=HJDMDz0CiZl9AfGnk3V9PTSAVcMWoVMzTqWgk1eiCi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAI8C8IjpTsh3DJJCY4k5IY3piOFa5Z374Q7CUjxNSDlY6fTPj0rzxjv7lyYrH5r81nEpqCMaR12qI+lePTC7syQdTZQ4tjtNj5Xw0nTsVN1mYqTWDpk+lsMe27VKmhhklL5CHJPI+2ET2sysXf7ilncWQszAbWN4Q2ekj56Cb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CP49vXR9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5498c742661so1809964e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741918860; x=1742523660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhvEgULRCeABMBBVLY/qi5SSG7BfaBYoCdPiyeDpY/s=;
        b=CP49vXR9/n8Yw2c9+gFMqiXB7nwTubZfxXcnlbDIGcx6K3pOF4s3KGNzju8hyRXLHW
         PWKSNA6PzvK6YSPIqPpKsyw8fPzzKiRz3PIaGMnjgm4qXztHM7X32hYR6tbjhS+xuqAU
         m5wbPPbQZuCsVEVJvzyXG9Fq2I/ggG66mqgR5LgdowkIOWBJdvOFQ0K2g6kpUBABXlKQ
         gwMw8k+WoaHmjjpPfMorBsJtq6dLURS2wMpJVT7ZAlZutNwT4mOR4e/XeSl/bIxGcMau
         NPzjBsMwmZF+kH8j+w08oCo5454xZiJz3+AEtQ8W0qbpQnwYE32NpgzEWmqJ4Em6Fglu
         y0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741918860; x=1742523660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhvEgULRCeABMBBVLY/qi5SSG7BfaBYoCdPiyeDpY/s=;
        b=p9glCpTC7N5YeRTcBMCzNUb/jQIT8pYr9BJlfCX10z13eHwupw6jOs0krwfmLNPHqW
         It5otzdD2anla7n2hSayVYAbtxcC6NOkANe6q3OhvLB5Odsx7gupBH1Xv+M9029TLKRq
         ucqAm3w1u9x1yO6Q51xYOV1RoOuNVDt/YfdZaoj6JGFXwNrvaSeAr36Fy+XZrLS8ngHW
         igDbeA93LeGvTo0Cl4oSycIQG+n+d/VaWEGn1bBeVT0lZkBxQ+qOpkL4P0ZlLjY/7Vz5
         PFkjFz5dn9ku6AqTwoxHLfrOHmwmE4P9cBkz7IfJXKPuteGUATnRMKMSe8oENY15rxNG
         n38w==
X-Forwarded-Encrypted: i=1; AJvYcCUsgdcMNi1yHSFtAnUa38FMpCvrbh8w/ZDa6y9OuGEd4piDhJF3PNojnpFMcPSSvfov4Z7SQvzmp/1V3VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWTmjhgRus6tE6H25EM5cSRUU7BXsEUnyqgnYB/5WS0NYBcxi
	Lx1ieaQpSaHpP/2hsoKhEHcTntnfzMxkIYhLSKtXUbK8i19NDg4CoalONVF+oIkBIgAdY6fqG5/
	g9cCeXIGIjoKdluHqv7O/wB3RDXc7wIcI6L2gDw==
X-Gm-Gg: ASbGncv5LN1FqgsUaIJR1u1lullN860Tv5yNYzAnkgLE0q7KgL+VKieVir+BtokVoX0
	tjY4AwV9hgMC7QH3MMrz/2tB4l4C5cAYkHup3VEda7qLYl3zIl4zkU7IrntU6QYZ1VIFhwqs2hA
	gT4niMg+au9/nEi088EVCwwh1+/Ng8D4n/f9EUKpwW
X-Google-Smtp-Source: AGHT+IEQU3O4OvJAPMBVbp+9v3wiBt3lm6Z3gqLTilJ9zNqtvYkgmwPglVyR3QyNU8ynw0ua8c8Xt/QXuPoDakLUlUs=
X-Received: by 2002:a05:6512:234f:b0:545:3dd:aa69 with SMTP id
 2adb3069b0e04-549c3969f3bmr221089e87.36.1741918859813; Thu, 13 Mar 2025
 19:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com> <Z9N1ntdaKpxlrq26@google.com>
In-Reply-To: <Z9N1ntdaKpxlrq26@google.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 14 Mar 2025 10:20:23 +0800
X-Gm-Features: AQ5f1JrqaVlfn6VtonAFOuMAO3DY1FI2fmUUcsILkYntOGv_rkxwA5SUOWwgiiY
Message-ID: <CACSyD1PvaqLVuYS9ZVc8UDGqDmabTkaySrRog-ELOdJCwkj3PQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: vmscan: skip the file folios in
 proactive reclaim if swappiness is MAX
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	muchun.song@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 8:17=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Wed, Mar 12, 2025 at 05:43:37PM +0800, Zhongkun He wrote:
> > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg to
> > memory.reclaim")', we can submit an additional swappiness=3D<val> argum=
ent
> > to memory.reclaim. It is very useful because we can dynamically adjust
> > the reclamation ratio based on the anonymous folios and file folios of
> > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > from file pages.
> >
> > However,we have also encountered a new issue: when swappiness is set to
> > the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
> > to the knob of cache_trim_mode, which depends solely on the ratio of
> > inactive folios, regardless of whether there are a large number of cold
> > folios in anonymous folio list.
> >
> > So, we hope to add a new control logic where proactive memory reclaim o=
nly
> > reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS=
.
> > For example, something like this:
> >
> > echo "2M swappiness=3D200" > /sys/fs/cgroup/memory.reclaim
> >
> > will perform reclaim on the rootcg with a swappiness setting of 200 (ma=
x
> > swappiness) regardless of the file folios. Users have a more comprehens=
ive
> > view of the application's memory distribution because there are many
> > metrics available.
> >
> > With this patch, the swappiness argument of memory.reclaim has a more
> > precise semantics: 0 means reclaiming only from file pages, while 200
> > means reclaiming just from anonymous pages.
> >
> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>
> Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Thanks for your time, Yosry.

>
> > ---
> >  mm/vmscan.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c767d71c43d7..f4312b41e0e0 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2438,6 +2438,16 @@ static void get_scan_count(struct lruvec *lruvec=
, struct scan_control *sc,
> >               goto out;
> >       }
> >
> > +     /*
> > +      * Do not bother scanning file folios if the memory reclaim
> > +      * invoked by userspace through memory.reclaim and the
> > +      * swappiness is MAX_SWAPPINESS.
> > +      */
> > +     if (sc->proactive && (swappiness =3D=3D MAX_SWAPPINESS)) {
> > +             scan_balance =3D SCAN_ANON;
> > +             goto out;
> > +     }
> > +
> >       /*
> >        * Do not apply any pressure balancing cleverness when the
> >        * system is close to OOM, scan both anon and file equally
> > --
> > 2.39.5
> >
> >

