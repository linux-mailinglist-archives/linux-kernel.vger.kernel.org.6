Return-Path: <linux-kernel+bounces-559408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50DA5F382
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27B21692B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7CD266598;
	Thu, 13 Mar 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="j/cmBnbZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26F1FAC4F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866981; cv=none; b=jMLypDF+P+1L+7EQEKTFt83qkWb9z8xCQYJOnsOu6SQny4JJnDr1PIWJYqc48UZwif33Rz0lPMyfv5K0Clgy1Ehupj3wX0ZftacrqkkYnly69rD6ZSu1g8RNVt1wEvaOhsDonVzuAMteTiyt04wRkWnApRPvzuFEQ+wKuQfTgng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866981; c=relaxed/simple;
	bh=8YSFaPnnraz2L8qi2krgso545b8C0btTmDKKAKeG0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzsBO2vXYmbGeWSRGCS7yuv2cz89uF6QIRK2XLTjNUxb54Obc5JVhvuQl5Z5da6LgUbzC3CYJOsgCLde7BiZd3eOsyRPWRHCxjK7sm4FHXFONmplpLOJN5mJJcCnnPZzXn/YjlhZ9r3LE6w/WsZ/7msN5Bwu9qBhSyrHlyrflJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=j/cmBnbZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so990227e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741866977; x=1742471777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBeZSLN5RdC5jHLNiuFJa6YOsMbFeh/krmmMuSB+kdI=;
        b=j/cmBnbZGJOzZY4VhyNSqBHmpd2CSM9/S70vsoJua8plUa3X4elKxNXM0KhshyK1xl
         zIQMxqtVRTC10CzWhCF+UR6bQxs8PrssEyDAhgKApWncR7/+xqWIPBiBwJaq0q5b1FVp
         RPdG2ERc3GPxe65arqxQuWnvkdGgAZv9srw/q76RMQ3fa4gQi9qZvFeCMYCeK0qk0g6M
         MFixs3yt5B+NwM5e9to1kk/m6iI9i6I2EUgzoeyfOoMBHctAVsDC5ztLEXBMnvpu6glQ
         uCKxyo5MoVcpU8ypM3RzmAQsOm7qbDdI160Vi0dCxKlMf09dICflgAEAO6Sn7nGtywgP
         ZM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866977; x=1742471777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBeZSLN5RdC5jHLNiuFJa6YOsMbFeh/krmmMuSB+kdI=;
        b=uV6SliuYXarJoCKD9arTTsn+QHmQ+kRQtDZeNbU+dug1YTPggt3JnJ+HKi/31F7rv6
         Uika143hpZD7osZE0d45iDDh7RSLuyg2voA3yMK/YlWxw0KeVxVaPCJ6dATlOx585PAD
         P/6dtT6+tVyQWDkcViPcCfhI01QAAqquGMuZhQjm1VPJ/b7FCcUjMJEdj7exipryRXaw
         eLLHn2aGInrXCR0O7TuHnRiu5kHcYQq7XRA1ZforZsd9+yLTvcWyluN2h2lT6h4wC688
         1d80MhVa0W5YcsuYsvY4QjfHm7asTCOjymdF6t0hjJgRU6tlcBkwz4UT8J0dqGseabaZ
         wtFg==
X-Forwarded-Encrypted: i=1; AJvYcCXp7eQsW5iub6ZzbAvqZQXjf3ya/Yv8URCN6rf154Zzsg6br2+hmK/bfiOfW5/Ag43MpVloLzGt7vCe1PM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXh1X6zKfPO1pInwElq4KCEvtY7NSQUniiIx7vXiIfkLiUw8+5
	RY6cMzvDoqnC70QUKOD2OtIjTITMpZj+GT1ZblrFbQu9KJd2hL20T2cL2JRhs7ws84gWuiakHX+
	WqryZOi9b8XRKXfxWkZVPa7R14TqhydCufB4ALCtOX7VPnxgxhA66Mg==
X-Gm-Gg: ASbGnctPRgY04lYQBbWySPV+4T53fO5LyarDMdwHom0wp6P+JZ5pXsfj7BoTjbrRhsJ
	CwY1+mzoCvKPEKOCnCCDl5foLAItUFBGmcLYjrzGeSDHnEOPALBz80BbSJ2oem0jI/oDt34cywD
	iPaxsZCHOrHMXHqpvchcT5nCEo2IsagCb88AhzDHc=
X-Google-Smtp-Source: AGHT+IGEyp8QlFUO5iBEQ3+sjvXdhFu8C1RRBX4cpUJB6fBBJ7ZTqWe0E9PLhwuwpOMizy4BKuMJYxz3SiV73Nqw/98=
X-Received: by 2002:a05:6512:2313:b0:549:4416:df02 with SMTP id
 2adb3069b0e04-549910b6194mr7925159e87.41.1741866976644; Thu, 13 Mar 2025
 04:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313034812.3910627-1-hezhongkun.hzk@bytedance.com>
 <Z9KPzQNctY_ALL0D@tiehlicka> <CACSyD1PU59py6rjiZ5snvRL449OmuH9W+RMbNpmOfhO80XuW5Q@mail.gmail.com>
 <Z9KofXR3KOIBXb1A@tiehlicka>
In-Reply-To: <Z9KofXR3KOIBXb1A@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 13 Mar 2025 19:55:39 +0800
X-Gm-Features: AQ5f1Jpo3Xic03LAlbOgUO1vxBJrzOBtSKzzs_8j6CeGNehBeppmpW2K0Q-LMv8
Message-ID: <CACSyD1OHD8oXQcQmi1D9t2f5oeMVDvCQnYZUMQTGbqBz4YYKLQ@mail.gmail.com>
Subject: Re: [External] Re: Re: [PATCH V1] mm: vmscan: skip the file folios in
 proactive reclaim if swappiness is MAX
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, muchun.song@linux.dev, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 5:43=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 13-03-25 16:57:34, Zhongkun He wrote:
> > On Thu, Mar 13, 2025 at 3:57=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Thu 13-03-25 11:48:12, Zhongkun He wrote:
> > > > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg =
to
> > > > memory.reclaim")', we can submit an additional swappiness=3D<val> a=
rgument
> > > > to memory.reclaim. It is very useful because we can dynamically adj=
ust
> > > > the reclamation ratio based on the anonymous folios and file folios=
 of
> > > > each cgroup. For example,when swappiness is set to 0, we only recla=
im
> > > > from file folios.
> > > >
> > > > However,we have also encountered a new issue: when swappiness is se=
t to
> > > > the MAX_SWAPPINESS, it may still only reclaim file folios. This is =
due
> > > > to the knob of cache_trim_mode, which depends solely on the ratio o=
f
> > > > inactive folios, regardless of whether there are a large number of =
cold
> > > > folios in anonymous folio list.
> > > >
> > > > So, we hope to add a new control logic where proactive memory recla=
im only
> > > > reclaims from anonymous folios when swappiness is set to MAX_SWAPPI=
NESS.
> > > > For example, something like this:
> > > >
> > > > echo "2M swappiness=3D200" > /sys/fs/cgroup/memory.reclaim
> > > >
> > > > will perform reclaim on the rootcg with a swappiness setting of 200=
 (max
> > > > swappiness) regardless of the file folios. Users have a more compre=
hensive
> > > > view of the application's memory distribution because there are man=
y
> > > > metrics available. For example, if we find that a certain cgroup ha=
s a
> > > > large number of inactive anon folios, we can reclaim only those and=
 skip
> > > > file folios, because with the zram/zswap, the IO tradeoff that
> > > > cache_trim_mode is making doesn't hold - file refaults will cause I=
O,
> > > > whereas anon decompression will not.
> > > >
> > > > With this patch, the swappiness argument of memory.reclaim has a mo=
re
> > > > precise semantics: 0 means reclaiming only from file pages, while 2=
00
> > > > means reclaiming just from anonymous pages.
> > >
> > > Well, with this patch we have 0 - always swap, 200 - never swap and
> > > anything inbetween behaves more or less arbitrary, right? Not a new
> > > problem with swappiness but would it make more sense to drop all the
> > > heuristics for scanning LRUs and simply use the given swappiness when
> > > doing the pro active reclaim?
> >
> > Thanks for your suggestion! I totally agree with you. I'm preparing to =
send
> > another patch to do this and a new thread to discuss, because I think t=
he
> > implementation doesn't conflict with this one. Do you think so ?
>
> If the change will enforce SCAN_FRACT for proactive reclaim with
> swappiness given then it will make the balancing much smoother but I do
> not think the behavior at both ends of the scale would imply only single
> LRU scanning mode.

Hi Michal, I'am confused about the description that 'I do not think the beh=
avior
at both ends of the scale would imply only single LRU scanning mode.=E2=80=
=99
and what we should do at the max value of swappiness.

Besides that, I have discovered a new issue. If we drop all the heuristics =
for
scanning LRUs, the swappiness value each time will accurately represent the
ratio of memory to be reclaimed. This means that before each pro reclamatio=
n
operation, we would need to have a relatively clear understanding of the cu=
rrent
memory ratio and dynamically changing the swappiness more often because wit=
h
the pro memory reclaim the ratio is alway changing . As a result, the
flexibility
would be reduced.

However, at both ends of the scale, we would have a clearer intention to re=
claim
from a single list. For example, in a cgroup, if we have 10G of anon pages =
and
3G of file pages, I would prefer to set swappiness=3D200 to reclaim anon
pages only.
Once the amount of file and anon pages becomes roughly equal, we can set
swappiness=3D100 and rely on the system's original heuristics to determine =
the
appropriate amount to reclaim. On the other hand, if we have 1g anon, and 1=
0G
page caches, we would like to set swappiness=3D0 to reclaim only from file =
pages
even with cache_trim_mode. At least from the semantic perspective, it
is clear, and
users don=E2=80=99t need to worry about the threshold of cache_trim_mode or=
 even don't
know the existence of cache_trim_mode .

Overall, setting swappiness=3D0 and swappiness=3D200 to reclaim from a sing=
le
LRU list is intended to address the extreme cases we have actually encounte=
red.
As Johannes mentioned above, with the zram/zswap, the IO tradeoff that
cache_trim_mode is making doesn't hold - file refaults will cause IO,
whereas anon
decompression will not.  we would like to set swappiness=3D200 to
reclaim only from
anon list which really makes sense to us.

Thanks.

> --
> Michal Hocko
> SUSE Labs

