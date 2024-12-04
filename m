Return-Path: <linux-kernel+bounces-431937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4AC9E42E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD872834DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0EC20E700;
	Wed,  4 Dec 2024 17:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoYt0Zmk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6BE20E6FD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335133; cv=none; b=QN6bglDbRwtDscniizD0SpKh4Lih8LJN2+Ynty0borDfhZ8oJU0k8jkVi1Q3j0m0L4K1Df+oHd7ftofC6MQwfaWKToDZbeUp197IFK2CJl4EWcP6OvkjvREV+T7fPxU+5eHE7bZ1S2mLHXSUrtwujHb2c2yRp/Y1OVevtDkc3q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335133; c=relaxed/simple;
	bh=ZeDjHz/4HNUfAV8na48fIb/KCWnjUV7iBOUhn/IZYdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNv10OhQy+h783FGQWFFj9GbOay1XBi2MElGwh1K6iTToIzPlP/GY0TWTBahGrEBMfwo8OoiN7Gy2mSj5W7qxOdfkDvGQXjCe1pjnmFx9j4hdMYfwwP0J5gy+avnqW7l/NSVMfwcZofjIIdsBK+SVRsVjAfmN72HUn7yeYFp0mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoYt0Zmk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd57589c8so1293414e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335130; x=1733939930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWCeFLTJpj0LgE0RztJm+OwymY9MAnHMbb9v/QBj95I=;
        b=YoYt0ZmkGyxt1IifeL/HX7Er/wkfSTpjwQsaXPzeyH0sLYNrBAurOTmYi2zdMxrk8s
         tpC2iorN+dFB5rAUI9g8otMh1uA1XREgEy75GLQS2VAj6jKG+FItkFuHmgrG7V9J7vdo
         24zpbs1N+L1QUptvljsbNyP79uyw7ja25TWhG1gN/9I7YNI994WTCboqplu0Zx/LoDcO
         xbMphwqTIZiiyLzLby0dr0EMwav0ptugRIhLq7y2SyuPJO0Ge6bZD8bl660NQot2Nz8d
         dVR4B6gSZmd/7Uo0DRiWSiLqt7byie0+ZSqUHOYmQGlx3/kgn5OvUeiO5NZ0YdJNh0wM
         xsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335130; x=1733939930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWCeFLTJpj0LgE0RztJm+OwymY9MAnHMbb9v/QBj95I=;
        b=wpocAGYpFivGU1BGbQuHb3XjtxmkLJLKneRwa0MvBhq954ZeK3YNaF49iPDPJFxqu6
         M4U5GB1TNWvWbTWqEGSGiX22g5GERRLh1wOMPQOsb5vwX4Cn+csaCOhCv3+joywQLkYu
         SMw6YPOYr/BOVyoXB6R7wCIDfXLCEUPM6ZRi64IdEDb7hFMP93jmxLtlRcpBFDtk9IzM
         in3Rhsfi8dcpDzArxHKWdn4sm8wHFyqcqQD5MFUsYnfsTGW//H1RuR7IDMqnE1FyQe48
         LHXombbfy5g/BZAAtskfU/AyBj8s5cOqBp5lijI1aLk+hzH0lU25hhgyb6gw9UdYfutf
         AA4g==
X-Forwarded-Encrypted: i=1; AJvYcCUj5anD1tKjWvvjA5ZWESWcgImYTipiqxkRlGzsDlBzsjyEc6XS2OaA3rYsJXYkEB+AyLAC1DSPJ9THmvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFTt1kXNBdYdw/thf9J3YM00d0NbqoXB0SV9QQuxAicjAtbJfd
	rwWR2ZAylmqwuK6Hd+oa92iBS6+K4iyr9613KiAxAb7HSkgGHFI7LG0Er8gS7csghOpnFZG5B2k
	0F4yKq+p4MGXxlNyxYCGOwr9QDNXPKQri
X-Gm-Gg: ASbGnctu7xrBJzTEOpZES/HsOcmRERDTqpmnc6X3WtMt3Nz4aMkEX0UuwKmWwhExZYh
	3vpAn4eJp2ueLXlWhcXrwUkgcOAy9Aao=
X-Google-Smtp-Source: AGHT+IFb0L2TrCMXYydUplgGTCybAyBQnEPdAK8jOzKnUov9HVMSNjjn8/1RlxaHaPjQvcwkRXkcNwcg4JT7riXj21w=
X-Received: by 2002:a05:6512:224b:b0:53d:f8aa:abaf with SMTP id
 2adb3069b0e04-53e216fb0cfmr79476e87.9.1733335129568; Wed, 04 Dec 2024
 09:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
 <CAJD7tkaO2AEeNH9b7utqUqgRqWowLtR-Ud09yC0YAhL5RQU5hw@mail.gmail.com>
 <CAJD7tkaJt19hNF+PhTUuop0rbpsnzWRs7837jTCMpw6=uVTosg@mail.gmail.com>
 <CAMgjq7CJt21a0=bfzvndfeLB6+9AsLwnF3sQs1-ET5CgOZsLsQ@mail.gmail.com> <CAJD7tkZLBG3SidU-tutESjVg=m+j-2b+88LxoAR+rKaL3Lw+8w@mail.gmail.com>
In-Reply-To: <CAJD7tkZLBG3SidU-tutESjVg=m+j-2b+88LxoAR+rKaL3Lw+8w@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 5 Dec 2024 01:58:33 +0800
Message-ID: <CAMgjq7ANFkvLWtvAHfzL1g6QTOULB9o5iJ28ot3_idFB3QPOEQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Yosry Ahmed <yosryahmed@google.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 3:18=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Dec 3, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Tue, Dec 3, 2024 at 4:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > On Mon, Dec 2, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup mai=
ntainance")
> > > > > replaced the cmpxchg/xchg with a global irq spinlock because some=
 archs
> > > > > doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale we=
ll.
> > > > >
> > > > > And as commented in swap_cgroup.c, this lock is not needed for ma=
p
> > > > > synchronization.
> > > > >
> > > > > Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so impl=
ement
> > > > > it to get rid of this lock.
> > > > >
> > > > > Testing using 64G brd and build with build kernel with make -j96 =
in 1.5G
> > > > > memory cgroup using 4k folios showed below improvement (10 test r=
un):
> > > > >
> > > > > Before this series:
> > > > > Sys time: 10730.08 (stdev 49.030728)
> > > > > Real time: 171.03 (stdev 0.850355)
> > > > >
> > > > > After this commit:
> > > > > Sys time: 9612.24 (stdev 66.310789), -10.42%
> > > > > Real time: 159.78 (stdev 0.577193), -6.57%
> > > > >
> > > > > With 64k folios and 2G memcg:
> > > > > Before this series:
> > > > > Sys time: 7626.77 (stdev 43.545517)
> > > > > Real time: 136.22 (stdev 1.265544)
> > > > >
> > > > > After this commit:
> > > > > Sys time: 6936.03 (stdev 39.996280), -9.06%
> > > > > Real time: 129.65 (stdev 0.880039), -4.82%
> > > > >
> > > > > Sequential swapout of 8G 4k zero folios (24 test run):
> > > > > Before this series:
> > > > > 5461409.12 us (stdev 183957.827084)
> > > > >
> > > > > After this commit:
> > > > > 5420447.26 us (stdev 196419.240317)
> > > > >
> > > > > Sequential swapin of 8G 4k zero folios (24 test run):
> > > > > Before this series:
> > > > > 19736958.916667 us (stdev 189027.246676)
> > > > >
> > > > > After this commit:
> > > > > 19662182.629630 us (stdev 172717.640614)
> > > > >
> > > > > Performance is better or at least not worse for all tests above.
> > > > >
> > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > ---
> > > > >  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++-------=
------
> > > > >  1 file changed, 41 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > > > > index a76afdc3666a..028f5e6be3f0 100644
> > > > > --- a/mm/swap_cgroup.c
> > > > > +++ b/mm/swap_cgroup.c
> > > > > @@ -5,6 +5,15 @@
> > > > >
> > > > >  #include <linux/swapops.h> /* depends on mm.h include */
> > > > >
> > > > > +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))
> > > > > +struct swap_cgroup_unit {
> > > > > +       union {
> > > > > +               int raw;
> > > > > +               atomic_t val;
> > > > > +               unsigned short __id[ID_PER_UNIT];
> > > > > +       };
> > > > > +};
> > > >
> > > > This doubles the size of the per-entry data, right?
> > >
> > > Oh we don't, we just store 2 ids in an int instead of storing each id
> > > individually. But the question below still stands, can't we just use
> > > cmpxchg() directly on the id?
> >
> > Hi Yosry,
> >
> > Last time I checked the xchg status some archs still don't support
> > xchg for 2 bytes, I just found things may have changed slightly but it
> > seems at least parisc still doesn't support that. And looking at the
> > code some arches still don't support cmpxchg of 2 bytes today (And I
> > just dropped cmpxchg helper for swap_cgroup so that should be OK). RCU
> > just dropped one-byte cmpxchg emulation 2 months ago in d4e287d7caff
> > so that area is changing. Lacking such support is exactly the reason
> > why there was a global lock previously, so I think the safe move is
> > just to emulate the operation manually for now?
>
> +Paul E. McKenney
>
> If there's already work to support 2-byte cmpxchg() I'd rather wait
> for that. Alternatively, if it's not too difficult, we should
> generalize this emulation to something like cmpxchg_emu_u8() and add
> the missing arch support. It doesn't feel right to have our own custom
> 2-byte cmpxchg() emulation here.

Actually here we need 2-byte xchg, not cmpxchg. I'm not exactly sure
if any arch still has anything missing for that support, or is there a
plan to support it for all archs?

