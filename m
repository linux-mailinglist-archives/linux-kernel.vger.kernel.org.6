Return-Path: <linux-kernel+bounces-430042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 903729E2BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC04B3410D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B751FDE05;
	Tue,  3 Dec 2024 19:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhHC7ruV"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234C13B2B8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253498; cv=none; b=D1/3SS9BrLTzU5wCzIaQmUky8+UEvTfSF0bWC8xzWmmSXB83cKcs15GlBMkau9vqhiLEOIwI38KTVmqqcQsrPR3zj/9lCZ1DUEx6YDGFxzlG5Q6QlpPloLYDuxUe3vSyR3eQCMcU5Ki40NVufM2YPGx5O2L7uQ2HZigez4PokME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253498; c=relaxed/simple;
	bh=kpMHVxFRkUKwDl5U5dxIi/LkFBYl4ClGLBHjgDD3kMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGsljlcRSEzFC3eqHSKtQV7UqZX+f9ZJYykBfoFUsRJNXf868fL4ZOR7vz5mb4a5C8oyzKWt5lMSVjXp+gQVpOefNCmhIwWQChjgR63jvvUG0h9wIGw8p2ZbHNja9PfKb/oXJbd+vDkQjdSiTDkeqIcTQ8AIrpt8Iutys/Bbx/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhHC7ruV; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d87ff6270fso40556986d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 11:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733253496; x=1733858296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mp9MC83gmpclNo8eqEK0RSI0aec4QJvEhb/iElkWT0s=;
        b=MhHC7ruVpGqdmusS4jjz9EUjEMknwka9Wkw4P14BFMAtlcjW8HIE8ZpS88DGLmZFnx
         HIp5+iRCW2l6+KkhTOdOUCFSteaVejxH4eGWnLvULyGgb0W8RgU8DUSisO9n/AA9R3nN
         e2uVRtMLiomUBOu/rx13/a/cYgfenAeD3zEJ5Nf+Y3+pfYCPCXigJ7ENssFkLWEb3dP6
         hZNOlXqFyS+Z9W2BV7/i+wBP6ODUt+Z77bS2nFg6oOIK3H+f06M2o0v4B+wp80ifKErY
         CufC5UoT7NMkpBIT3+Eu72DRBZ5Omdud/i16QRMrIjwt67ypKzs44i+nJpKwwlG4kWK+
         sldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733253496; x=1733858296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mp9MC83gmpclNo8eqEK0RSI0aec4QJvEhb/iElkWT0s=;
        b=HtIn96S9MXwDSpMjO052lbgcN4uDrhkZSVBj3EPy4+mL9SoJKKh2yooGYdEc+tv3iN
         yE8s0xeZirJhXAAc5ZCrUETu5KMmLjGzCRVd6sZ16XOBaPjZ0FLW5myiL5E7ksiakhz3
         MNEH8g7/aSwkqKLRiSPGz2jhcH/um4yXmqSjzG3mbBR2PSA1p4CCKE6n3CLTgJ+l87YQ
         ndk9YjJ/oYWiw+GmYtNcfz3FOOsHkh40IiFg6yFJWwkpSHAukn5i3leI87KHvh/Nmmab
         ejP5HS1O15l+HTU7q2dOaMCHNGv7XA1N72/4GCmlZSI5vh5Sde9RupYEXygMQt4mNR+b
         DkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgepkH09VMSDry5dNdDSQPxsxXmQm1tsWrdMnv4wF+bBtX/rjwQvCVxVPOGg7fQEK4thOhjV+A/tIUd5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0pDEIG5eDXihi4205nLOktvv/2q20/cRsGNvDiI5hxEhHv/V
	FDqpyhicOh0ebDyGZh1xSEFcdJ4VNKeKYxLk4maVeqLYUyDKeRxZunn0rg1ThaD9fB5DxnzX9GB
	zDm/F2HBQV3XhjZyrb1crVjvBgMmS882PfQfn
X-Gm-Gg: ASbGncsBbXz6SOuKkP5CF4qPW6LpnHJXxL1aYAW3CU2eCVAmvgZ+eVjnTjKvPsEnl8s
	vcCFVyYXyTeZozQPd3iaAB9du1cKe
X-Google-Smtp-Source: AGHT+IHeqHeI58UNUW3pQpETjpS6gPoh+s1SmxZW8+KLFGgf3rZ45txlFKhIVGecAd+lNNIHJGjSIXeRs1z9KmIzspo=
X-Received: by 2002:a05:6214:62c:b0:6d8:9e16:d083 with SMTP id
 6a1803df08f44-6d8b72f1a17mr50671206d6.3.1733253495966; Tue, 03 Dec 2024
 11:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202184154.19321-1-ryncsn@gmail.com> <20241202184154.19321-5-ryncsn@gmail.com>
 <CAJD7tkaO2AEeNH9b7utqUqgRqWowLtR-Ud09yC0YAhL5RQU5hw@mail.gmail.com>
 <CAJD7tkaJt19hNF+PhTUuop0rbpsnzWRs7837jTCMpw6=uVTosg@mail.gmail.com> <CAMgjq7CJt21a0=bfzvndfeLB6+9AsLwnF3sQs1-ET5CgOZsLsQ@mail.gmail.com>
In-Reply-To: <CAMgjq7CJt21a0=bfzvndfeLB6+9AsLwnF3sQs1-ET5CgOZsLsQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 3 Dec 2024 11:17:39 -0800
Message-ID: <CAJD7tkZLBG3SidU-tutESjVg=m+j-2b+88LxoAR+rKaL3Lw+8w@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm, swap_cgroup: remove global swap cgroup lock
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <baohua@kernel.org>, Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 10:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Dec 3, 2024 at 4:36=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
> >
> > On Mon, Dec 2, 2024 at 11:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Mon, Dec 2, 2024 at 10:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com=
> wrote:
> > > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > commit e9e58a4ec3b1 ("memcg: avoid use cmpxchg in swap cgroup maint=
ainance")
> > > > replaced the cmpxchg/xchg with a global irq spinlock because some a=
rchs
> > > > doesn't support 2 bytes cmpxchg/xchg. Clearly this won't scale well=
.
> > > >
> > > > And as commented in swap_cgroup.c, this lock is not needed for map
> > > > synchronization.
> > > >
> > > > Emulation of 2 bytes cmpxchg/xchg with atomic isn't hard, so implem=
ent
> > > > it to get rid of this lock.
> > > >
> > > > Testing using 64G brd and build with build kernel with make -j96 in=
 1.5G
> > > > memory cgroup using 4k folios showed below improvement (10 test run=
):
> > > >
> > > > Before this series:
> > > > Sys time: 10730.08 (stdev 49.030728)
> > > > Real time: 171.03 (stdev 0.850355)
> > > >
> > > > After this commit:
> > > > Sys time: 9612.24 (stdev 66.310789), -10.42%
> > > > Real time: 159.78 (stdev 0.577193), -6.57%
> > > >
> > > > With 64k folios and 2G memcg:
> > > > Before this series:
> > > > Sys time: 7626.77 (stdev 43.545517)
> > > > Real time: 136.22 (stdev 1.265544)
> > > >
> > > > After this commit:
> > > > Sys time: 6936.03 (stdev 39.996280), -9.06%
> > > > Real time: 129.65 (stdev 0.880039), -4.82%
> > > >
> > > > Sequential swapout of 8G 4k zero folios (24 test run):
> > > > Before this series:
> > > > 5461409.12 us (stdev 183957.827084)
> > > >
> > > > After this commit:
> > > > 5420447.26 us (stdev 196419.240317)
> > > >
> > > > Sequential swapin of 8G 4k zero folios (24 test run):
> > > > Before this series:
> > > > 19736958.916667 us (stdev 189027.246676)
> > > >
> > > > After this commit:
> > > > 19662182.629630 us (stdev 172717.640614)
> > > >
> > > > Performance is better or at least not worse for all tests above.
> > > >
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > ---
> > > >  mm/swap_cgroup.c | 56 +++++++++++++++++++++++++++++++++++---------=
----
> > > >  1 file changed, 41 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> > > > index a76afdc3666a..028f5e6be3f0 100644
> > > > --- a/mm/swap_cgroup.c
> > > > +++ b/mm/swap_cgroup.c
> > > > @@ -5,6 +5,15 @@
> > > >
> > > >  #include <linux/swapops.h> /* depends on mm.h include */
> > > >
> > > > +#define ID_PER_UNIT (sizeof(atomic_t) / sizeof(unsigned short))
> > > > +struct swap_cgroup_unit {
> > > > +       union {
> > > > +               int raw;
> > > > +               atomic_t val;
> > > > +               unsigned short __id[ID_PER_UNIT];
> > > > +       };
> > > > +};
> > >
> > > This doubles the size of the per-entry data, right?
> >
> > Oh we don't, we just store 2 ids in an int instead of storing each id
> > individually. But the question below still stands, can't we just use
> > cmpxchg() directly on the id?
>
> Hi Yosry,
>
> Last time I checked the xchg status some archs still don't support
> xchg for 2 bytes, I just found things may have changed slightly but it
> seems at least parisc still doesn't support that. And looking at the
> code some arches still don't support cmpxchg of 2 bytes today (And I
> just dropped cmpxchg helper for swap_cgroup so that should be OK). RCU
> just dropped one-byte cmpxchg emulation 2 months ago in d4e287d7caff
> so that area is changing. Lacking such support is exactly the reason
> why there was a global lock previously, so I think the safe move is
> just to emulate the operation manually for now?

+Paul E. McKenney

If there's already work to support 2-byte cmpxchg() I'd rather wait
for that. Alternatively, if it's not too difficult, we should
generalize this emulation to something like cmpxchg_emu_u8() and add
the missing arch support. It doesn't feel right to have our own custom
2-byte cmpxchg() emulation here.

>
> >
> > >
> > > Why do we need this? I thought cmpxchg() supports multiple sizes and
> > > will already do the emulation for us.
> >

