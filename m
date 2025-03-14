Return-Path: <linux-kernel+bounces-561066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946BEA60D33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6E73A3D88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F031EC00B;
	Fri, 14 Mar 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fdUkS3dw"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1221DF757
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944328; cv=none; b=JM1Ir84X+YHq7WY6y+X0Hze6VOga9fR8ob1ttiuuoGBpUYn8DD/2xYTs44495eI55+thKkUf/CcR/6bRoCb5254ZKA5LN/RzxGG1ndQMUt/SfizRPNBki1mBjPSsQ8q8KVKMWZTadqM25BrYbahguYkZvIhN1mV+dYft4lqqYWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944328; c=relaxed/simple;
	bh=0i/TUOGKh5zJ1RuoNnpT3g0OxCdYQqEgi9AErd0ye/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jA0cdxCcIJlpQiadtrVYWuShQNyTZmO7SkffbCi0/4B44IMXuPxhkej35dIW1Ihy9k8vVpk4u/wnLD5/Qc8Z/JYeSrGWDUkrlVl4L/74J3JHL78RHq6MTdTk74PwGuyj3SIKIcjgUM4SQWTCP3/h5VUImkje+XO1YIK6aW7JDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fdUkS3dw; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so19304351fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741944324; x=1742549124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdpgR/K+jG8H9Mmix9bCdPdwnrgEiVRubiQLwqas2JE=;
        b=fdUkS3dwQzJ8ujVqPc85pDju9bltqlDJpzF65/Nyoh1KN7aQhBEj9vqb+PNVAB2/mQ
         +29TsE9bKEGXOP4jZWYy3A/JPEcYkRAoDFlssbVLHxcG9w/GlHg6DhzXbM4mAk0T+lQg
         TWnsfSw1NGQwnL+OvZSjPqOdzec8+IlhzPRwNmlfkVfaTD1uP/dN2vbv8+NPDNU/7FLK
         q+Uy8yeQYjPpmJVuIPocDtutSJ0p+G4YPshQCTqlk0vsGzByoOAeb5ZkJPfAc1j5zT2A
         lXmXd89xA7XKjE5Ejn4nvMDMkHqbsMgBsdBF/KVm0D8yNQBl8Hvft0o/Z94Hsf+kdEkK
         ZZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741944324; x=1742549124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdpgR/K+jG8H9Mmix9bCdPdwnrgEiVRubiQLwqas2JE=;
        b=MeKg7zs3EFoKJDIW8q7/A9IW7buagnDu6rJNCcNg6swVgzVcgW5kDFywe64x9kUgS9
         gyE0n+K5yT6HuiRiKYqlqNxV/RtgJN8sx9H8NHaoXuobss203i6fHRix6lGNG8NPL2kh
         9+zucx4+l9umMlNvW3B8whJeQihH/pwFCOI0dj2vDMoKinNVcrBXIN4q1PuAcGrdRAF4
         qmhLaly6WP+voB5f7zbAoGMjgy5mmaczYjDN+Mteb3ZIGldVprdj0UChTHxRaykfCsd+
         PEB7vZl05zElqDJlX0nmqlhsjxHWT7lzLGFJkeLNmfHcjXrHk41BJUim8oaXaH5PgTUM
         8R1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoop0yoeeT4tMAY0k+w4ULg5M+k6m2oFAFqIX6LcsvLTREMbRJdHOaRunlxsTHa4PIqCV+Lg4OLvIByn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykMgYjP+ePh6uf1Lk4uED/+OXY1mJo9v/zXDOqYrbkNbzCXBYN
	dnfzWtC2stIMSdbT1qyGi9ZzbPXPkMQwsOx1UsETQkGs3AXZn1F9+xzVoT0DwazmZP5d75HOHCT
	h4SyoBMR1/oY/tdZ+FwPMzXTqBOfXGiV42lw0+4rUOYFHFlcNFlCAjg==
X-Gm-Gg: ASbGncsE6XtTbJ+rUHJLfCKEbE8ote2ZyM5e3PEquDOvmEcP7nuRfoSFWeaq4r+PhGg
	chtm/QoKoJdeT9caDlpoXLqRqTHIS5ha117GhILBJoWmO0zp7fTVN2rOhxmJ2CqwE9SlbJhx2Zw
	1cUjNbx/3IKlywWkVnTWi1U4eUZP8w4mjCxYjPXs0=
X-Google-Smtp-Source: AGHT+IEjVen50YVpwUrK456NvIgY0rwkW0OYrnlQs6iiVW7g/V8zHkeH6055LHMjUjoDNm/N0Eo8uGzNKzgcUV2w3yg=
X-Received: by 2002:a05:6512:2216:b0:549:38eb:d694 with SMTP id
 2adb3069b0e04-549c3913c35mr566242e87.26.1741944324144; Fri, 14 Mar 2025
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com> <Z9PuXMlHycL6Gco0@tiehlicka>
In-Reply-To: <Z9PuXMlHycL6Gco0@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 14 Mar 2025 17:24:47 +0800
X-Gm-Features: AQ5f1JqB7zSyjpT8_t67e_MWnk5d31Q2OfVpYekPNjXCTE9-Bw2QjQJ5WgPleAU
Message-ID: <CACSyD1NMQp83-38FO-pHXStF=p=R82DqQwNfdx3SBQ-qNuyYUA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH V2] mm: vmscan: skip the file folios in
 proactive reclaim if swappiness is MAX
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev, 
	yosry.ahmed@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 4:53=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 14-03-25 11:33:50, Zhongkun He wrote:
> > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg to
> > memory.reclaim")', we can submit an additional swappiness=3D<val> argum=
ent
> > to memory.reclaim. It is very useful because we can dynamically adjust
> > the reclamation ratio based on the anonymous folios and file folios of
> > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > from file folios.
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
> > metrics available. For example, if we find that a certain cgroup has a
> > large number of inactive anon folios, we can reclaim only those and ski=
p
> > file folios, because with the zram/zswap, the IO tradeoff that
> > cache_trim_mode is making doesn't hold - file refaults will cause IO,
> > whereas anon decompression will not.
> >
> > With this patch, the swappiness argument of memory.reclaim has a more
> > precise semantics: 0 means reclaiming only from file pages, while 200
> > means reclaiming just from anonymous pages.
>
> Haven't you said you will try a slightly different approach and always
> bypass LRU balancing heuristics for pro-active reclaim and swappiness
> provided? What has happened with that?
>

Hi Michal
I'm not sure if we should do that. Because i found a problem that If we
drop all the heuristics for scanning LRUs, the swappiness value each
time will accurately represent the ratio of memory to be reclaimed. This
means that before each pro reclamation operation, we would need to
have relatively clear information of the current memory ratio and dynamical=
ly
changing the swappiness more often because with the pro memory reclaiming,
the ratio of anon and file is alway changing . Therefore, we should adjust =
the
swappiness value more frequently.  The frequency of setting Swappiness to
200 is relatively much lower.

Do you have any commits about this concern?

> --
> Michal Hocko
> SUSE Labs

