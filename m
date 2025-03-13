Return-Path: <linux-kernel+bounces-559041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 280EDA5EEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC701653B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC69C2641FE;
	Thu, 13 Mar 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Eh1Za3yo"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2326281F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856270; cv=none; b=VZrIkL+V5fgdxl82vi2UuL/TinxlUsa0j1AN/B2d1rWnfq+Jxsot0NbkKo+IUhItWpYOTWNbQmQWP61BVOgomjDo2hoJL8Qt7x/EGEWarTWLhBSQCEz6mwDQbi+vNRXxHleBTE6ezO7inPzzPr92E7lUjaP1WRfBNTM0pUklLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856270; c=relaxed/simple;
	bh=oNVte8lvt8b44yuQA7mpFTfd90aDPPxxo5o7QBnVwxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtweRFWdnWyuIjsHtDg0F2YXfpGLyvlktls9oAb/Cx0SD2kZYXK4glbCK5avL6kKDgKpBLZmQna/Umeq6oOWYM/Mw4QQncTqYC7u1ig46y2kaPX7XVK4d/lYIo5UaMHRl4v4IchgLofrz/YDYthPVfxSb+hrbOlM+jCP35I+5qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Eh1Za3yo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5495c1e1b63so811848e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741856266; x=1742461066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNVte8lvt8b44yuQA7mpFTfd90aDPPxxo5o7QBnVwxo=;
        b=Eh1Za3yoD9bVLY0ugfFRHJwUy3EKr+pWvscBKj2a7e/p2o5uDLEAcrC3tDoOzps9ed
         AcEDPeC6X1PNgMpIYy+A4DTOVDz/2H8u9Dw4PYodnPb66demZXn+1xS3sOEnSAhk7Z0v
         jdsuobrUPK/V3pzK15VidTaCj9MFBZGBnVmAnBt2+zrFRyVW48ljLPk2piiXnr2OufpJ
         Hv7dIpsb+qlbEKrfXm3rz1neOUcjAarQ2q8YLG2bI89N3Jps/BrfQAwsn/8AN9BOollS
         fUwDr27XpBtjr5jRKQ133hzNM93Y/GtUjiyUqBY4yGGxNAvy7kj9W+LNixmn10qTm/QL
         yFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856266; x=1742461066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNVte8lvt8b44yuQA7mpFTfd90aDPPxxo5o7QBnVwxo=;
        b=r3CkFRINqy8waTnJpo7jmaXMqdaC5BYHlikVQEEiVAGaxpCeSmpUD2/XVtwbjN6Khk
         Y9XQ20JCo3mope7MyOfnED9raR8FZy8aAvOgN+s83JM9WjmM+KwhMIElzAeoBJx4kYaJ
         yn1KlV4duV5e8LjvlITWrvM1o7sigoPje49VJVNX2kJzFCf9Jv4ULLJPw4KCGcXIlGCP
         t9WkYFLQBpzzgtXXdlpqig1E8AoCMCgiDkyk+VzJXqVm5bsCgcAwzxAVT1yJNakq0Tor
         La6rw+oO1XADfnAU5VPXcdsnk8JqF6NRjYpj15DdGTlUMjQMzvvukvTzZrUl5gfmS47m
         KBAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/+T27fiZgPMOwNfj4qFRND8wuDFnEw42GpagPjuS+kNLEyIpsbfazWPPEzIuZtq0PUfKRr27CjKDKaD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3Kq9MmNvw1EAlEkCawPuoMI4tK4gBMGj4Tn3WGDhVamVYdHX
	JBS1bgIBFZp0fbysgMwZQmvQ2Z00cJ8yijl0X6/uI+1Po+IFssN/df0BLbPfkXMU3CDvLSAIJRB
	WJqoGybLKsZ6NolciD0fYP6JugjnV97eC4JU5qlSexQNQXAx8UzgBzg==
X-Gm-Gg: ASbGncvxLvLH/ZCM5G7iLAO1QJ2Avf9t6GUBekJZE2GdsKPwR9KqmjscCcLbDPYOCNU
	KwolMguhp3eXqH1FlOVxqrADiuUbYw2WRnuRc9LxpiRMTdQA6ojJzA/r+It7rgY3p8Aa7wJkSD4
	uKUudfF/M2VcaOaIlnfcByDy+rMwMLa+7QpB8sFvuvJmO58mYDpDQ=
X-Google-Smtp-Source: AGHT+IHrHgCaZK4KN9oZUVm2A3FprVTQvoB4+X6fONU0XmSiN2PgvVRMZuCwOSd4wSdmwbJZwo+uEPVOSQjD46oRw9k=
X-Received: by 2002:a05:6512:3b9c:b0:549:4de9:c23 with SMTP id
 2adb3069b0e04-549abaaad89mr3687097e87.9.1741856266079; Thu, 13 Mar 2025
 01:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313034812.3910627-1-hezhongkun.hzk@bytedance.com> <Z9KPzQNctY_ALL0D@tiehlicka>
In-Reply-To: <Z9KPzQNctY_ALL0D@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 13 Mar 2025 16:57:34 +0800
X-Gm-Features: AQ5f1Jo6rW2JENj9_ZucQSXxIKOzDShDlUIMTYmxGFUKf9EuY47aXkvY1bGOAW8
Message-ID: <CACSyD1PU59py6rjiZ5snvRL449OmuH9W+RMbNpmOfhO80XuW5Q@mail.gmail.com>
Subject: Re: Re: [PATCH V1] mm: vmscan: skip the file folios in proactive
 reclaim if swappiness is MAX
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, muchun.song@linux.dev, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 3:57=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 13-03-25 11:48:12, Zhongkun He wrote:
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
> Well, with this patch we have 0 - always swap, 200 - never swap and
> anything inbetween behaves more or less arbitrary, right? Not a new
> problem with swappiness but would it make more sense to drop all the
> heuristics for scanning LRUs and simply use the given swappiness when
> doing the pro active reclaim?

Thanks for your suggestion! I totally agree with you. I'm preparing to send
another patch to do this and a new thread to discuss, because I think the
implementation doesn't conflict with this one. Do you think so ?

>
> --
> Michal Hocko
> SUSE Labs

