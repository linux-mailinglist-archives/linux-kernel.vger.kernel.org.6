Return-Path: <linux-kernel+bounces-432023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE799E43E0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438E8283D0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132931A8F9C;
	Wed,  4 Dec 2024 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XniwEMlf"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902CF1A8F96
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733338660; cv=none; b=UEh9GIlyWf8tA8H2w9lN5BgVNg5oP5Jeruw1j2lzxHhHDf1YGl4yM+k+hezVbfJmrDx4GUJAck2dsGYYcKgcrqD2DzIFrX2wnX13X/O1gVIAnj9n6rJFt3AnfyLj2k6P+Tk4BTaQQ0lmEo9jGThv2TmzscTffCt4gGi3I79FV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733338660; c=relaxed/simple;
	bh=OV3hp2V8eKCEXAaPuUls1lIqtHVVMRU96BImUZmQbm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iKN3UXeuX/armvICOL2VnwF51PSv24roHXbC+hGzJm0g0+Dka3GA510g5DE7eyaqk2lq8uyyjptoLnASbf8GqQ+Fyxtn58nLSP0Vay0P9Ex7UOiGPx+mbgeRfgyxVYp7LRvtI1+ALdNl70rtVDcR8oxIq8BNvdHMDQL9EiL6FSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XniwEMlf; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d8c7349401so987696d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 10:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733338657; x=1733943457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PShsGKOP5A/4kSqaxEWpemov0e3wuEnAMDVyESQ3RB4=;
        b=XniwEMlfXdCFsltgZAA9xyBqGc2kmDrs5vLvFBHhAKKxy4RacZKsBJEM6WjQqLQeW0
         dHAFWjsxZ5YdFbWcnUDfIPrteZP0xSe2ul3/DKQRcarVkkmczDBcB4xNX6XBll1TUk7y
         tjjyjY1iwna/RPTKRn6tb60f4YiRCd+Fw2Q2xCcyHMJdkKilUAzmtNu+IaK7i2DxLOUV
         ChOK57o+KF9w03TmCayANX0/GBC6WMTMLx1clHu3Kyn/+1Mj0d5j9Ygyxyt1H3hVLYUh
         N9XaaC48UDKqQb7j4/wPkXF37zhpaXcSVjRZuxvRI/ttkv3k7Gf9o8nYbqGwiSMhK9Pl
         DPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733338657; x=1733943457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PShsGKOP5A/4kSqaxEWpemov0e3wuEnAMDVyESQ3RB4=;
        b=Qkkifjtf/iiCY+Sif20jOXwGIWvSvtbz5Mot80Kq/tMONI9Zfl3BAw0QIbXwB9iUqd
         Pv5bus7TesYK3+HP/WUB27EOcTiencL2Pm+/IQ9NXdcVuCU0cWNNaQsoVqyMrsf3Lgt5
         LSr+0KdenWQfBj5Jo/sUhNO6y5xwQ3m98jPGHo1ZzFCCAYSGG2+uViIYADOvB/0BPuOe
         GC4OL7DlzBrjemYGYS5hFkCQZmncpfepixFjlvy48dLt//rENAjo496hDYC9d/8+OgJz
         8Kikf2xk2FvQkP4ScYLDVEy9/0FJUq45UW7vt9tswO23nCAYsfcOYSw/xj3C8r62K68a
         TGcg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Qar8ZWPUbjhAWJaz09lJGc6OiBtMIE6lE0tnz9ebMyn+cdN+EAVPt5b7NOv/pqo5M4Id+czLk06JKPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXk6Mfr33pel6oKLltMqHzLmsn9gdQCxnTj4vqv2J3IuXug+GE
	SyAvcxxE7V4VulUi9XVIL18Ws4mWPUV1YXd4QyC0cjZX+5NwwUUMyudqIhJOaCSKB/mLpLqXp2g
	jHyMy6vGU9b43L2O+x4yjT7nZhHHatic6KWhR
X-Gm-Gg: ASbGncu7ww45QJzNAQwBHH+e/J9EBTclDvRinxnVqBJO3frNbfjc2LofkS/idXEz4FV
	+fIhTaEH/fZXXPJnBnN9cSbtG/1/P
X-Google-Smtp-Source: AGHT+IE0nEyhaK3PznGX7U3n2gojmNdZ8qVyGVv+V0HdgDaiSIR5GA7Vt+Cs1aj0M9chqIf5AMk4w5sj3jZT2vKC7ao=
X-Received: by 2002:ad4:5aee:0:b0:6d4:2806:1765 with SMTP id
 6a1803df08f44-6d8b740e273mr101125466d6.34.1733338657345; Wed, 04 Dec 2024
 10:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
 <CAJD7tkaO2AEeNH9b7utqUqgRqWowLtR-Ud09yC0YAhL5RQU5hw@mail.gmail.com>
 <CAJD7tkaJt19hNF+PhTUuop0rbpsnzWRs7837jTCMpw6=uVTosg@mail.gmail.com>
 <CAMgjq7CJt21a0=bfzvndfeLB6+9AsLwnF3sQs1-ET5CgOZsLsQ@mail.gmail.com>
 <CAJD7tkZLBG3SidU-tutESjVg=m+j-2b+88LxoAR+rKaL3Lw+8w@mail.gmail.com> <CAMgjq7ANFkvLWtvAHfzL1g6QTOULB9o5iJ28ot3_idFB3QPOEQ@mail.gmail.com>
In-Reply-To: <CAMgjq7ANFkvLWtvAHfzL1g6QTOULB9o5iJ28ot3_idFB3QPOEQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Dec 2024 10:57:00 -0800
Message-ID: <CAJD7tkZTWLyK6n+S_iWHwXVOWCO=jzUSDjpTdwA4WNc5MgQEMA@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <ryncsn@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Hugh Dickins <hughd@google.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 9:58=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Wed, Dec 4, 2024 at 3:18=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Tue, Dec 3, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Tue, Dec 3, 2024 at 4:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > > >
> > > > On Mon, Dec 2, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail=
.com> wrote:
> > > > > >
> > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > >
> > > > > > commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup m=
aintainance")
> > > > > > replaced the cmpxchg/xchg with a global irq spinlock because so=
me archs
> > > > > > doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale =
well.
> > > > > >
> > > > > > And as commented in swap_cgroup.c, this lock is not needed for =
map
> > > > > > synchronization.
> > > > > >
> > > > > > Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so im=
plement
> > > > > > it to get rid of this lock.
> > > > > >
> > > > > > Testing using 64G brd and build with build kernel with make -j9=
6 in 1.5G
> > > > > > memory cgroup using 4k folios showed below improvement (10 test=
 run):
> > > > > >
> > > > > > Before this series:
> > > > > > Sys time: 10730.08 (stdev 49.030728)
> > > > > > Real time: 171.03 (stdev 0.850355)
> > > > > >
> > > > > > After this commit:
> > > > > > Sys time: 9612.24 (stdev 66.310789), -10.42%
> > > > > > Real time: 159.78 (stdev 0.577193), -6.57%
> > > > > >
> > > > > > With 64k folios and 2G memcg:
> > > > > > Before this series:
> > > > > > Sys time: 7626.77 (stdev 43.545517)
> > > > > > Real time: 136.22 (stdev 1.265544)
> > > > > >
> > > > > > After this commit:
> > > > > > Sys time: 6936.03 (stdev 39.996280), -9.06%
> > > > > > Real time: 129.65 (stdev 0.880039), -4.82%
> > > > > >
> > > > > > Sequential swapout of 8G 4k zero folios (24 test run):
> > > > > > Before this series:
> > > > > > 5461409.12 us (stdev 183957.827084)
> > > > > >
> > > > > > After this commit:
> > > > > > 5420447.26 us (stdev 196419.240317)
> > > > > >
> > > > > > Sequential swapin of 8G 4k zero folios (24 test run):
> > > > > > Before this series:
> > > > > > 19736958.916667 us (stdev 189027.246676)
> > > > > >
> > > > > > After this commit:
> > > > > > 19662182.629630 us (stdev 172717.640614)
> > > > > >
> > > > > > Performance is better or at least not worse for all tests above=
.
> > > > > >
> > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > ---
> > > > > >  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-----=
--------
> > > > > >  1 file changed, 41 insertions(+), 15 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > > > > > index a76afdc3666a..028f5e6be3f0 100644
> > > > > > --- a/mm/swap_cgroup.c
> > > > > > +++ b/mm/swap_cgroup.c
> > > > > > @@ -5,6 +5,15 @@
> > > > > >
> > > > > >  #include <linux/swapops.h> /* depends on mm.h include */
> > > > > >
> > > > > > +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short)=
)
> > > > > > +struct swap_cgroup_unit {
> > > > > > +       union {
> > > > > > +               int raw;
> > > > > > +               atomic_t val;
> > > > > > +               unsigned short __id[ID_PER_UNIT];
> > > > > > +       };
> > > > > > +};
> > > > >
> > > > > This doubles the size of the per-entry data, right?
> > > >
> > > > Oh we don't, we just store 2 ids in an int instead of storing each =
id
> > > > individually. But the question below still stands, can't we just us=
e
> > > > cmpxchg() directly on the id?
> > >
> > > Hi Yosry,
> > >
> > > Last time I checked the xchg status some archs still don't support
> > > xchg for 2 bytes, I just found things may have changed slightly but i=
t
> > > seems at least parisc still doesn't support that. And looking at the
> > > code some arches still don't support cmpxchg of 2 bytes today (And I
> > > just dropped cmpxchg helper for swap_cgroup so that should be OK). RC=
U
> > > just dropped one-byte cmpxchg emulation 2 months ago in d4e287d7caff
> > > so that area is changing. Lacking such support is exactly the reason
> > > why there was a global lock previously, so I think the safe move is
> > > just to emulate the operation manually for now?
> >
> > +Paul E. McKenney
> >
> > If there's already work to support 2-byte cmpxchg() I'd rather wait
> > for that. Alternatively, if it's not too difficult, we should
> > generalize this emulation to something like cmpxchg_emu_u8() and add
> > the missing arch support. It doesn't feel right to have our own custom
> > 2-byte cmpxchg() emulation here.
>
> Actually here we need 2-byte xchg, not cmpxchg. I'm not exactly sure
> if any arch still has anything missing for that support, or is there a
> plan to support it for all archs?

Not sure to be honest.

Taking a step back, with swap_cgroup_cmpxchg() do we still need the
synchronization to begin with? It seems like swap_cgroup_record() is
the only modifier now, could multiple callers be racing for the same
swap slot?

