Return-Path: <linux-kernel+bounces-559051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0189A5EEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5993AABD9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48713263C6A;
	Thu, 13 Mar 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c3Fz9NOI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FE260A3C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856578; cv=none; b=C8aya08BHm5Hlz2HCcN6kgyhagJxOYljFGhUIWdJmUbjtqrsRPgF5Mu2TgAN7lo6fGQxoxsBH+Mwtky0NtgbTdzBzx6zQheUDBK6stFYfecAp1xTXgddOyGtQQgS7WA1xysWcfxiELQkCTfyqgcgb1oEI8XLajcnlmuI3LzCv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856578; c=relaxed/simple;
	bh=tg7DSbFPev/ToBK3Ef+B4kvdMI9TFA2cmy+2Ov/LwAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Blxjv5O3MV28SFBvP2BUsWWoowqSIf6ylHbKjNR/dzAwIjI+q+xmtQnGm4XbkSg5Wamw2rHzOClj+4CA6J3kPiU+vcBk1CqFC5d4SSc5d9UuDOFSK0/0epHliKAtqUOS/XU0GR0AYbAuypF6UGzrY9tkqISrQY65en2M+mOPcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c3Fz9NOI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bf8632052so7040461fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741856574; x=1742461374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg7DSbFPev/ToBK3Ef+B4kvdMI9TFA2cmy+2Ov/LwAA=;
        b=c3Fz9NOIFh/7lQP0J+Lrymt+zaUXJbki7GWDT0lPdCuKCcMCoran2GfYVsFc+RDSxs
         PbhgDS1asQE1P4CJvJT28BNjSEgZWIZ9x992WldY6uTlE18+d+ftuUljvSG6KydnOwma
         4jb/zlpHsNWy+jlqwIvrocrnVAMwHFBvei2OZXqE0jt70gz5mCwGuLAMGBrqQwhsc5zN
         E4KhfQ7TbyIv7rl0j+NwQX/e5InSsxvkplw50604o8RqCzCaGhufHpfNrP/PID2VvS9a
         6i/34H8I8GRzSDoNBLmIK2kSLrGvDUUAW79OHMpdUUYZW4Z9a6qfl+84WTtDGcvGQOLy
         mK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856574; x=1742461374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg7DSbFPev/ToBK3Ef+B4kvdMI9TFA2cmy+2Ov/LwAA=;
        b=IPJp0L7HmJMKdUmJ3B1ea/Db4S9ZoZ52U1cxFuwu1msV6otyj6UFTOGAlJslV0PhIl
         1k9RRbI+WtEEmaBM/Z2qXm7/8fUXfY7bp322ELNxxYdL6OwRkfv7cIbr476KcrRv0VVi
         WBXnyvlEX9Gds41HSE94z8H2/fdhUHW1eWAYX61VZAt8RimrjMKzLcpbnIkHGrC3z3pr
         zsLzxUDmxSZWYKCBRyQn9a2I+9bPHFGVwPDZVDPJIPAxlMltFOW0pAeuprnGuFw44aGm
         9wXzAw5X95wxx7LSDvocK5UT2zjQG/79QHCjExLkoKra5U+luC7g04tTqRRpAveXIRa+
         gTbg==
X-Forwarded-Encrypted: i=1; AJvYcCUzI4NAvN+l4BoN53+f0t0yuFvAxQLtb4RYC7VskVwFK+CrGmrm98A9C+/4KhUcqMgeBgWQVNXmIKRsSPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVRfkRE833jg7oa47R6ad4DWftauDEiq27qDo3MrCRM6KJGms0
	Fpwvc/KkuzsqgVLZvdBA5z+3NGzNio1rXKyFZeLMUnX6tvGoo+qxsseSeSeUCDUbHLPFY50NLGD
	fUbclu8BQaL5GvYe+9ok1cijhbKkV4TIiJPpcQQ==
X-Gm-Gg: ASbGncvvDVn0WJ3dVSZUvAuRgPYakM7VaT1A8Sl/G5fSK/9cO6ZA7EhvOR03YLIT2o6
	e3G5F3/hHQs4Jid93NuKHzW3O+TDWl5ueFR95eO6Q0hhdFP6hlmQGv3cTGU4L3QBa0z+kojKBsE
	DYD33ybPVKMidn7SfsZR3env+ohrePWUKceI+sX6xU
X-Google-Smtp-Source: AGHT+IEvjYCUz8+4rdFfCSurcxSpdJL3vG3Az7HPINb1JM3PerHD1lC7Td2QRd0UxLGyaIs3gOzfVrzXmJ3QkkmoRrw=
X-Received: by 2002:a05:6512:1597:b0:549:8f24:b617 with SMTP id
 2adb3069b0e04-54990e2c019mr8873182e87.4.1741856574247; Thu, 13 Mar 2025
 02:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313034812.3910627-1-hezhongkun.hzk@bytedance.com> <Z9KPzQNctY_ALL0D@tiehlicka>
In-Reply-To: <Z9KPzQNctY_ALL0D@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 13 Mar 2025 17:02:41 +0800
X-Gm-Features: AQ5f1JpXLeTNidzVpI0S8XFw2I56K4hTNHQkbtr22KOqanhQ0XZYUc7wNGjGRos
Message-ID: <CACSyD1M_=knwBkP4RtMqLskv5U3W2oRCwdxdsv_PTvyxr2627Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH V1] mm: vmscan: skip the file folios in
 proactive reclaim if swappiness is MAX
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
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
>

Thanks for your suggestion! I totally agree with you. I'm preparing to send
another patch to do this and a new thread to discuss, because I think the
implementation doesn't conflict with this one. Do you think so ?

> --
> Michal Hocko
> SUSE Labs

