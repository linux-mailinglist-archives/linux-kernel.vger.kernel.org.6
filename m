Return-Path: <linux-kernel+bounces-307116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99196486F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3CC283DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76C1AED55;
	Thu, 29 Aug 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bmAEHqlm"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E32B1ABECB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941825; cv=none; b=Nh0iuLTQ35XbSLJ2EWBM1NcP0LHvg6fgwQL/dGMgVBGrrqpLKQ6nVs7NBgTC595QRoIdB4/vuk+zwR32ey5d9jYCvQtp5VrtJ1/aBYMg52ymTnv81ETbqiSopQxtq18/uEGnJXYylf+p7J5PJN7PZatZJG263jd2cOuUy+lh3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941825; c=relaxed/simple;
	bh=WlaIkcR0BAaiuOkAEc+7VcKOT6eXqOffruAh64TxBIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bEIATEOEniaI3eChaUAhzMxKqWY4dESVEiHIkI5yIKSkUliPN68bWmoLEfC0xTYpfy+fXpPztJMR//dTvbU5LEu6esMDwggacHWFX9gVCzYgYlgDERRFnzW41yl0TqwVeuMhpL7qVVNU4pD3ugTVyEV4NrK0lViKs5mSwTRIJcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bmAEHqlm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso1066206e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724941821; x=1725546621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=or4ghMbyYGhdgKHNnt+sKMCIkofo/P/ZwT115uAVzaM=;
        b=bmAEHqlmhEtxmyvp3ENueFIr8ml5Y9QwlnR1LZcuwW50h8Cegf9neSI1+i6AtaCMVi
         G2xXzHRGZGdgsmtHJeXtmJVUZj3Z+nLreKAzMTg7IFpKORhWi/5ujthKzU4cd9+Ud4EA
         Pbm8lP+SYwyO+P+ZtYSPGO7aVm6uBx0fvBeHlQ6p1fXMfy41NyXU6IMspRfmJN42ANR6
         Tv1hyy5MD/PXZV5wTF+kfzxrYLWaJ8fzbpUKWUL5IVCOVkcJnuOYZQDtxNE1AJFzj8FR
         g652DuntKeEt/VlJwMAFA6Ir8o82vllXh6bj73p6p0jec6Q+fu81K5mbA8bWCYSR72qn
         HuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941821; x=1725546621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or4ghMbyYGhdgKHNnt+sKMCIkofo/P/ZwT115uAVzaM=;
        b=bJiVA2h7rjAUcCas6mebu8ycgLtTlpu4PYAFmKDiLCEAUbeRw1pX0TMmCTM6dXYqZ4
         eRufEE8Vs1wkG0Q3fAvCze14sPa0QKS8Hl01kPvab+SBTB6JTyz/RBidNivULHWN1maV
         DrNRg8UOtEBHYtnasEypMp3A7nXFyXMDHV/T43mrQtBF6erqCX4smpRnP9MAeHJr4tIt
         aitvgp01y+orWTbnfLjSd31vzjMxwj0aj6kLRGoq5GLCX2B4JOlx8YN2GyxPY17C6fMj
         4+oPpGnPlPfxXlLR0mfUpZoumQnv3cEgU9XaIBepmMRCUugKl97SA7Ir/qmIX7jVLFFp
         yGIA==
X-Forwarded-Encrypted: i=1; AJvYcCXsg3b2A2THmtmUi63q25/IDA/1nxUFEDavZBejy8t6O65sQH/tgPNMBJvp7llqB4rssV+GbGULviHjULc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTiDXG8/5pkiI1vxr0bXz0ki8c/d8AibWTWDW/KrupJhl/q9o
	eqMbaK9U92ChZ8c76898CSJ4Gu14Hniv5ErU1QzvTfkrLrK+pXVjx7OnGcefzdWVgm8xnuMOHJM
	WGGtq+pXWE7lYejbmFl4kUVbv1ost84MTzx5EZg==
X-Google-Smtp-Source: AGHT+IEuD7+DRiRALY05+3l0QvDxJ+ND2HY5nhwL1zBJJKY+7V2NCB19r4XkEsnz+Z0UnfHXuYV7JUJhmzQ5ssinP9E=
X-Received: by 2002:a05:6512:3b90:b0:52c:e086:7953 with SMTP id
 2adb3069b0e04-5353e53fba3mr2228999e87.4.1724941821324; Thu, 29 Aug 2024
 07:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829101918.3454840-1-hezhongkun.hzk@bytedance.com>
 <ZtBMO1owCU3XmagV@tiehlicka> <CACSyD1Ok62n-SF8fGrDQq_JC4SUSvFb-6QjgjnkD9=JacCJiYg@mail.gmail.com>
 <ZtBglyqZz_uGDnOS@tiehlicka> <CACSyD1NWVe9gjo15xsPnh-JUEsacawf47uoiu439tRO7K+ov5g@mail.gmail.com>
 <ZtB5Vn69L27oodEq@tiehlicka>
In-Reply-To: <ZtB5Vn69L27oodEq@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 29 Aug 2024 22:30:09 +0800
Message-ID: <CACSyD1Ny8OFxZkVPaskpnTDXgWZLBNK04GwjynT2a0ahUwKcAw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/2] Add disable_unmap_file arg to memory.reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, lizefan.x@bytedance.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:36=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 29-08-24 21:15:50, Zhongkun He wrote:
> > On Thu, Aug 29, 2024 at 7:51=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> [...]
> > > Is this some artificial workload or something real world?
> > >
> >
> > This is an artificial workload to show the detail of this case more
> > easily. But we have encountered this problem on our servers.
>
> This is always good to mention in the changelog. If you can observe this
> in real workloads it is good to get numbers from those because
> artificial workloads tend to overshoot the underlying problem and we can
> potentially miss the practical contributors to the problem.

That sounds reasonable. I will try it.

>
> Seeing this my main question is whether we should focus on swappiness
> behavior more than adding a very strange and very targetted reclaim
> mode. After all we have a mapped memory and executables protection in
> place. So in the end this is more about balance between anon vs. file
> LRUs.
>

I  have a question about the swappiness, if set the swappiness=3D0, we can =
only
reclaim the file pages. but we do not have an option to disable the reclaim=
 from
file pages because there are faster storages for the swap without IO, like =
zram
and zswap.  I wonder if we can give it a try in this direction.

> > If the performance of the disk is poor, like HDD, the situation will
> > become even worse.
>
> Doesn't that impact swapin/out as well? Or do you happen to have a
> faster storage for the swap?

Yes, we use ZRAM as the swap storage.

>
> > The delay of the task becomes more serious because reading data will
> > be slower.  Hot pages will thrash repeatedly between the memory and
> > the disk.
>
> Doesn't refault stats and IO cost aspect of the reclaim when balancing
> LRUs dealing with this situation already? Why it doesn't work in your
> case? Have you tried to investigate that?

OK, I'll try to reproduce the problem again. but IIUC, we could not reclaim
pages from one side. Please see this 'commit d483a5dd009  ("mm:
vmscan: limit the range of LRU type balancing")'  [1]

Unless this condition is met:
sc->file_is_tiny =3D
            file + free <=3D total_high_wmark &&
            !(sc->may_deactivate & DEACTIVATE_ANON) &&
            anon >> sc->priority;

[1]: https://lore.kernel.org/all/20200520232525.798933-15-hannes@cmpxchg.or=
g/T/#u

> --
> Michal Hocko
> SUSE Labs

