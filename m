Return-Path: <linux-kernel+bounces-260168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D1C93A40D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8171F24335
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D7F15748C;
	Tue, 23 Jul 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7dgmhZc"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB80157468
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721750118; cv=none; b=TIEDeZ0tdrYXWH23BrBJNohWhfkyxbW3I3m57hmw5uPhzTnk2DH5j6s524/bg6IdL3wbBXvG2Ztlz49g313MHLv5Xyl0FlZT+srAS+6GtW7RmitBA6OXkN41Z4lMde85E6+mlGQM5S7i8Bg8BKpA/7Jz/1pbJK1uzD4llUbhXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721750118; c=relaxed/simple;
	bh=RZkEaxN/z9e7hvb9NP1WJhh1EmsYqNqHkyNHYv9Fc08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XblBZ0OQMcCJ8BCi/WtzJNUe7day5N8zGbRZ9iDcOKGaL/MBg3mlE4HswcG09rfDCM4FvMBkb6qL89GmeeK0yTyYDkfrTZEaYmOnoqHZ9ayxP3uYnv2felC1+m3KQjCGAdVdD5HjmbfJhueOU1SaGMGBq/cfhb4kChYTeGAMpig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7dgmhZc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b7a3773a95so32207326d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721750116; x=1722354916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlo3FLz9xK1G/CZV2cifLKY4AM9ZahhXzfqe65WlZU8=;
        b=S7dgmhZcg5sLccdmUEJOwoGlE3NE6pib2/TiukSCLK2q2+Q3J7PXyHc8RKuNzvct5S
         RI+t9gbqFjUJ2DPemyG1sMXO/Cqf0MxJOnS2xTJTpo80qq0Mj0PPYJMWXZtss74VSMzH
         5lr2jOYJdDARzLibFZA6OD5A+29NbLxUBCGp7B23FDfSgKDFUMbSpjMVoB9VlbWysZBX
         7W8FlBT0BuPrSofa1ghZdb9T20yDlJCxH9SMj3vynH+CEESZ3ZvlarLlWV+YwdR09G5v
         F39+3DcELSFtlLlwM7FT1PEIDRuF/XzH01Dj2O8iOlTW+B+KMpiuQZmk3/rsckbxzQE8
         cLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721750116; x=1722354916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlo3FLz9xK1G/CZV2cifLKY4AM9ZahhXzfqe65WlZU8=;
        b=ECjzkMZY2F5n5nxaFiZhir2QfyfOnjivOV1lPp0aalnLljBS8GWMWIPWZu0pfhxP21
         0Zlg8YpCH2iNRGUb3HOu2WWbYJHwbutW6o5QwoJsVm9klRkYdtvENCq0zJ+cXOWxwEHn
         mOlPdBKCvTli8H35S4burCJt4BzO/0wEvPctPRsyAnp+pTHz+ax+G39otWBjIEz0WBv7
         c+2zZ0sRbhTy/JO/x5PCAr3bjHVhXsr1DdHHF8t1hyYHa6pTeUiDuoOWCwWnsMZj+5ul
         gTOnrIauLFjFfiJdLcF1lefJ9iS66vWiUvl35wjABkwX/zEEAC2w7tGOJZHEoOLp40ta
         on/w==
X-Forwarded-Encrypted: i=1; AJvYcCUeYH++NlCcPJj/vrrObzlbUj/RPFQe/jwnbXzqxkqYenFgvZx6AhGPmbhiZzz5d41BspDfeDEMLgzvVJbsTlOIZzwQVylWp17bTzRZ
X-Gm-Message-State: AOJu0YwF8J/Hx3Gd9de4/xpSp+IpJ0aRDzKkuajxcBf7R1+wsANEVIkp
	UjEPC8OxhNDiEuPa1KOVCyiX91xGe8iZ0adIY2sOuRRbxngRP6okwYhPVcK1+0NWl7Av0PvKyHU
	qP/lV+KM4nDCk93S1sVHQSZNQyxs=
X-Google-Smtp-Source: AGHT+IEl/qD7wLHTnMv7KvwlqOpK4Lk/pt/aps8dtOgZTCgEB2C8QGUtwEFpn7vAyw97G0Q2OuV6++2J5BPLyeuqWD0=
X-Received: by 2002:a05:6214:1253:b0:6b5:dfc2:6699 with SMTP id
 6a1803df08f44-6b98ed24a83mr8416d6.5.1721750116121; Tue, 23 Jul 2024 08:55:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240720044127.508042-1-flintglass@gmail.com> <20240720044127.508042-2-flintglass@gmail.com>
 <CAKEwX=NGu_MM3bzT9eXAAJhvCvv+x4Qvf77=_RFD-M7zxKFriA@mail.gmail.com> <CAPpoddeGo3o4vWLYCwi2g0zs7RGi__QYuLBAVi1Y0gzP1X+7Gg@mail.gmail.com>
In-Reply-To: <CAPpoddeGo3o4vWLYCwi2g0zs7RGi__QYuLBAVi1Y0gzP1X+7Gg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 23 Jul 2024 08:55:05 -0700
Message-ID: <CAKEwX=OpNXsR7FTBq2J8pwusnAOOCvEXuATLvHFMMT1DDt9kog@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: zswap: fix global shrinker memcg iteration
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 8:35=E2=80=AFAM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B47=E6=9C=8823=E6=97=A5(=E7=81=AB) 6:39 Nhat Pham <nphamcs@gma=
il.com>:
> >
> > On Fri, Jul 19, 2024 at 9:41=E2=80=AFPM Takero Funaki <flintglass@gmail=
.com> wrote:
> > >
> > > This patch fixes an issue where the zswap global shrinker stopped
> > > iterating through the memcg tree.
> > >
> > > The problem was that shrink_worker() would stop iterating when a memc=
g
> > > was being offlined and restart from the tree root.  Now, it properly
> > > handles the offline memcg and continues shrinking with the next memcg=
.
> > >
> > > To avoid holding refcount of offline memcg encountered during the mem=
cg
> > > tree walking, shrink_worker() must continue iterating to release the
> > > offline memcg to ensure the next memcg stored in the cursor is online=
.
> > >
> > > The offline memcg cleaner has also been changed to avoid the same iss=
ue.
> > > When the next memcg of the offlined memcg is also offline, the refcou=
nt
> > > stored in the iteration cursor was held until the next shrink_worker(=
)
> > > run. The cleaner must release the offline memcg recursively.
> > >
> > > Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> > > Signed-off-by: Takero Funaki <flintglass@gmail.com>
> > Hmm LGTM for the most part - a couple nits
> > [...]
> > > +                       zswap_next_shrink =3D mem_cgroup_iter(NULL,
> > > +                                       zswap_next_shrink, NULL);
> > nit: this can fit in a single line right? Looks like it's exactly 80 ch=
aracters.
>
> Isn't that over 90 chars? But yes, we can reduce line breaks using
> memcg as temporary, like:

Huh. Weird. I applied the patch locally, and it looked 80 chars to me ha.

Anyway - just some nits. If checkpatch complains then yeah no need to fix t=
his.

