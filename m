Return-Path: <linux-kernel+bounces-404876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A159D9C49A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597241F231B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1640A1714BC;
	Mon, 11 Nov 2024 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4rR9/Iz"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119C158A31
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367176; cv=none; b=VFEpBEMaDNCI2cOAq5HiandJGw4QW9GfBvhNIafM62F8qaj3UOzMs0cFGJldO6d5264SSv7/GFk21q/icF2LozFn0AIHpJkeAFlsxnHKrzER0cx1vq+DjejNz6S3H0wnvs/rukK1Jt20UFz8T+teT3D0UrCccMsWDtmtNYmx5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367176; c=relaxed/simple;
	bh=qbrwfDgUxbdDSES2yhtB78VnKGsb17TFeBb2a4z4m54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j6HiTgVjFV4E6kRfH42UCXScFK5Jg5x9J+OBKu52C+S+eJ6DtZ3MZ0cgYV/9CpDVaVdjqQl2IzkWw28lPmojTa/tELDKI1dm/Qt6k/3XjaF90ip6ll7qAgc1EjpEjz7D+kBjfrABGi3Du85di16MFj1CP1SauZlqHi8tgkLNkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4rR9/Iz; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a6c3bdbebcso19455ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 15:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731367174; x=1731971974; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cckibaKiKNSOfZ/m75CIbHIvVaalZEyDHgB5Y3tCiHg=;
        b=W4rR9/Izgds0GJ0y+glImxg3IhgcUp5Ph5Xe3DqJPJy+A6sQHKQAzRCTW7/6ixtNbV
         b6PiqKFOq2Z4P72w3TnHSo/4AycqN0OU26qFikRzfrHDhV3DisShn+ZXd5v4qwOCjxmM
         B19p4Xhuu+DclofJQLTmV+Rvgnb5OavjPKMkRjmp7aPFes4L0ah0mTi+6JjlQCB9otRV
         ydJpnnRUQ/8OAasilUEjAu6jWd2+nQfNA2kgCv1NxSP15xSB7guSNxZyxX4m9bl+d1WX
         vy1AykoKYcQBkFW44zDMukXV1pUlUZCLkW/GYR6NMnh/jkIwErp3nxWQuuaWpWpO80TJ
         Z8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731367174; x=1731971974;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cckibaKiKNSOfZ/m75CIbHIvVaalZEyDHgB5Y3tCiHg=;
        b=izttAh2uM+meV50gmA2keVspLtkWa+YRC7bcgTPJPgo7LpJYynSTaXwWK0LDWri6mV
         gkUuQIE/kaxKAbfx5LBa49JYk3g0GKiqvaHuFDHO+tk6H5cWykotydNIZxDcG0KO7MB5
         9ai9CukOv9ZC3Tp2qaU7h9DIp6XYlfmOCQ8UBY7ErAdo5ZrUIip8WcpmK5UlJKicm++t
         GeBVzqvTTOZra1e/xnxg0Yr6BtVpDIp9y+BrEdKkYJZIXACYA9M2S6qZ+gS7iVuiJLU7
         Z82yHqIZP2Q8bg12V8AlQTSd/3NFHvCHXeJpaclz0QG5uA+6trYt6f4WflcZB4FRq2Q6
         XbyA==
X-Forwarded-Encrypted: i=1; AJvYcCVRnyk9iBk/D2bg0Ja5GtfAq/mN8mbLiuQYOHsm3LWx7kYXqqFmc9uClMiecd7nBRdsVu1sIhD0tabVr80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTwN78Yes4NlXYdyjynmcBZc9GvUTKv8cFm90E8xsAaL4rt6r
	4x1XBS9ULdQI3aXaayVs8RTAj5DhwsDjVaO5TwHzpzxk6Bk1VPj+hC6iIJnORARaevf00k8gqQv
	HiKbzj9FOTgYuo7gTHimhUbQPGJavzCb9WKCq
X-Gm-Gg: ASbGncv7zRFczbfhZVZLRvnv1U5IfjZlKrr/d/i8JcZsphHeQejWjuUrZhZZrtmkKO4
	tvPq82SjNAVa0YzeeXU6R58/9K60kCH8=
X-Google-Smtp-Source: AGHT+IGeh9r23ezmUSk7kTjdXoTQAzjQbjGWun7emtM/lg8qMNJnpD269veSSX8de0tnPclONJLxCn+Nr4lnTv7OXmY=
X-Received: by 2002:a05:6e02:1b06:b0:3a0:a9a3:8a74 with SMTP id
 e9e14a558f8ab-3a70c4ba422mr1007725ab.15.1731367173840; Mon, 11 Nov 2024
 15:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111221839.w4rqqlvvkm42jdgm@offworld>
In-Reply-To: <20241111221839.w4rqqlvvkm42jdgm@offworld>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 15:19:22 -0800
Message-ID: <CAJuCfpGw1Nnh3nonDHv-UAeqTB=-3z1+hJk9Opy4X-6mbvdEhw@mail.gmail.com>
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, willy@infradead.org, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 2:18=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Mon, 11 Nov 2024, Suren Baghdasaryan wrote:
>
> >To minimize memory overhead, vm_lock implementation is changed from
> >using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> >vm_area_struct members are moved into the last cacheline, resulting
> >in a less fragmented structure:
>
> I am not a fan of building a custom lock, replacing a standard one.

Understandable.

> How much do we really care about this?

In the Android world I got complaints after introducing per-vma locks.
More specifically, moving from 5.15 to 6.1 kernel, where we first
started using these locks, the memory usage increased by 10MB on
average. Not a huge deal but if we can trim it without too much
complexity, that would be definitely appreciated.

>  rwsems are quite optimized and are known to heavily affect mm performanc=
e altogether.

I know, that's why I spent an additional week profiling the new
implementation. I asked Oliver (CC'ed) to rerun the tests he used in
https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/ to
confirm no regressions.

>
> ...
>
> >Performance measurements using pft test on x86 do not show considerable
> >difference, on Pixel 6 running Android it results in 3-5% improvement in
> >faults per second.
>
> pft is a very micro benchmark, these results do not justify this change, =
imo.

I'm not really trying to claim performance gains here. I just want to
make sure there are no regressions.
Thanks,
Suren.

>
> Thanks,
> Davidlohr

