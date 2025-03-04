Return-Path: <linux-kernel+bounces-545378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71912A4EC32
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379DB18842D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDF266F12;
	Tue,  4 Mar 2025 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEWyyATP"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05421260374
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113326; cv=none; b=g6VGZKvAxYH3U9smHuHM0VuphWU9EszW+oTlukOIJ0RM4f+8SHAVqxtNDZ76/gXs7cc5MpW7c9ipymW17yVchfyt0fnyaQpZcoza8B8DY3MI99TLnN++NunLy7vOAR1waLD48A6CIzJbzdi+yhEDdJ6vUaBE5RMk16pCViucCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113326; c=relaxed/simple;
	bh=rmqIxeLRyZ4MRFodNpW8/HMglrn0z0awEKd7PNYXyd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hx/PRZ8xaEDEI4cAIbo+6eKRPmPvTE3C1llATyybgHyYiVkopN++1UE5HbYsHwf8iziARcLz3oaFPXSxXVQlZA34aH7DVIcPYty/ysQqwCM0hfxso0nJSfbjBzeuNfGSvQgHtXc6chSh4yLh+vkOBPJvYdj1HxYO8WCW9DYzRD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEWyyATP; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-474fdb3212aso26761cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741113324; x=1741718124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sE5nK4GFeJJ6OO4073CP21uOwPN4nuaYHAb6WJCLI3A=;
        b=uEWyyATPX4JAjzb+sX/y3erQfjZ3XKhdIM80A6faJF0wXQw3WwvDzs2cqxlJotQtvc
         0NKSmj76X+eNHmVkgWv25DQHFrrMJ+Oh87zVkZbJsj0fS+/JOYUuhMgUswzYVNkbyR5U
         oiEDpjK9p2maW7FHr0063Nc6x45i+z1ImFXF1mJyhF3NkEng08WcGfeh80uhYDaqq8sW
         ZRgcgBWNp324hEkQ4QIvSg3HxoSUERU/j6ejxgE4jtAvKUyd1Mz/B+CX4XGHmzGwdJgL
         BGgflHg6/6497T/iFEy4T+W+fN/os87MSllbhV6Au1NumJmeVt2GbKI67m5g6EcxOswi
         gSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741113324; x=1741718124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE5nK4GFeJJ6OO4073CP21uOwPN4nuaYHAb6WJCLI3A=;
        b=UVIcxRfyCupauliBql4MDtrOHGWS874rLF9Pg+N/HHceEi0YOsIjP4HXzrBNeTcwXM
         28H75g0V3+OkmDfAZADaQRwPWBGlN9FytdTiY82lvPMTiXhOCfAZzmVrZP3kxM+cX+Ku
         1Ze0iSlM/LaR/Fbzp+MsPNQqrUNHZdiZhzLCQIKEpR6d8+m6jdBOf1jrR2Y2wxeuGrY9
         RYEukBUULIQVy2bxqcnQKX0+or+uzfvxh7ojnfA1XlezcQbfFbl9QGty68/cc+hkKMoC
         9kHIYoVIP5MusX6/6jgE/bqu/jEAixNT7OVzefq0ldDA4upJhX8p1qk7KRUwv4IbBzlA
         /1BA==
X-Forwarded-Encrypted: i=1; AJvYcCWe0jj+69jyBKA260/JJV0RthWWq68ah9SY+84r6orJ1vyP9+C9Xb8sq1zs2Onokf/RFQKPdysMClZwcSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAHLJCZvy7odGlQs57QMDZdLSlo//dD3y+lrM0xzXAGVmGYM5s
	nyCl1TF28ksF9Z74jGQUwDij2PloO1ocBFlM7RA3EmDyfw371MEH2Sv30c8SmMafQGAZ+VpmM6M
	wvug1gzAsu10w0am1NPhDPR+g+N1hIWx5cwBK
X-Gm-Gg: ASbGncszn/oiTc4jKeh9BjZSZPIzZKuvJhnGI81tXJXIBuDkvIjBOIfYAc8d1uNdz9A
	4Fsr6IkJ1zGl9jP9ly+HP23SlCdtt0mkgcbToGyKEbZ+z3hxIZ9esRCT54/5aP0O4zFZkbsK5IP
	BXJehB6Daydm+jFlglImKwE1Cb+VY5qCGnVrOFWK/C0TPXAQRlLwJBjI5+
X-Google-Smtp-Source: AGHT+IE0ojfFK56Nsc3hks2mutUiZjNncnjFf0jJTwub5pXkrgW/XbWDNcjElNzyhKr+WIvjR4oqHA7Mz9eABlzihIM=
X-Received: by 2002:ac8:5e49:0:b0:472:8ac:7d3d with SMTP id
 d75a77b69052e-4750a596138mr793651cf.29.1741113323385; Tue, 04 Mar 2025
 10:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <ztssad52ikws3a2dwodju4o73h6rsutxnvzj5i6vyjjkudkiel@g7c7g5i3l7jd>
 <CAJuCfpHi4Od4K2xQEUFWuG=a4zCKecWBMwBiy_7mVn6QgsTSvA@mail.gmail.com>
 <CAJuCfpEq8P4cz7HXaRVqaagONPBKrFgOSqdigEYU60sGAE4-rg@mail.gmail.com>
 <173d4dbe-399d-4330-944c-9689588f18e8@suse.cz> <CAJuCfpHHXYKGjaOxHcuJcuQbUVO7YqLMpcYeF3HM5Ayxy1fE+g@mail.gmail.com>
 <CAJuCfpE7t83PKWw+8XJLE5538kKJnbhirLg2siDSw=F4sw=9uA@mail.gmail.com> <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
In-Reply-To: <19df9218-c984-4cbc-8b5d-4e0f7658935f@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 4 Mar 2025 10:35:12 -0800
X-Gm-Features: AQ5f1JouTAVSQFXAmbLWqUnRspW1HmqjJwV-_XkDFpiV6uDsQZI3IuNVoE7yJ74
Message-ID: <CAJuCfpG2U0DW2PubJw6aAwf2VLdy8Y9ov5iwt7nkn9XskBc6Ww@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/10] SLUB percpu sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 2:55=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 2/25/25 21:26, Suren Baghdasaryan wrote:
> > On Mon, Feb 24, 2025 at 1:12=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> >>
> >> >
> >> > > The values represent the total time it took to perform mmap syscal=
ls, less is
> >> > > better.
> >> > >
> >> > > (1)                  baseline       control
> >> > > Little core       7.58327       6.614939 (-12.77%)
> >> > > Medium core  2.125315     1.428702 (-32.78%)
> >> > > Big core          0.514673     0.422948 (-17.82%)
> >> > >
> >> > > (2)                  baseline      control
> >> > > Little core       7.58327       5.141478 (-32.20%)
> >> > > Medium core  2.125315     0.427692 (-79.88%)
> >> > > Big core          0.514673    0.046642 (-90.94%)
> >> > >
> >> > > (3)                   baseline      control
> >> > > Little core        7.58327      4.779624 (-36.97%)
> >> > > Medium core   2.125315    0.450368 (-78.81%)
> >> > > Big core           0.514673    0.037776 (-92.66%)
> >
> > (4)                   baseline      control
> > Little core        7.58327      4.642977 (-38.77%)
> > Medium core   2.125315    0.373692 (-82.42%)
> > Big core           0.514673    0.043613 (-91.53%)
> >
> > I think the difference between (3) and (4) is noise.
> > Thanks,
> > Suren.
>
> Hi, as we discussed yesterday, it would be useful to set the baseline to
> include everything before sheaves as that's already on the way to 6.15, s=
o
> we can see more clearly what sheaves do relative to that. So at this poin=
t
> it's the vma lock conversion including TYPESAFE_BY_RCU (that's not undone=
,
> thus like in scenario (4)), and benchmark the following:
>
> - baseline - vma locking conversion with TYPESAFE_BY_RCU
> - baseline+maple tree node reduction from mm-unstable (Liam might point o=
ut
> which patches?)
> - the above + this series + sheaves enabled for vm_area_struct cache
> - the above + full maple node sheaves conversion [1]
> - the above + the top-most patches from [1] that are optimizations with a
> tradeoff (not clear win-win) so it would be good to know if they are usef=
ul
>
> [1] currently the 4 commits here:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/=
?h=3Dslub-percpu-sheaves-v2-maple
> from "maple_tree: Sheaf conversion" to "maple_tree: Clean up sheaf"
> but as Liam noted, they won't cherry pick without conflict once maple tre=
e
> node reduction is backported, but he's working on a rebase
>
> Thanks in advance!

Sure, I'll run the tests and post results sometime later this week.
Thanks!

>
> >> > >
> >> > > Results in (3) vs (2) indicate that using sheaves for vm_area_stru=
ct
> >> > > yields slightly better averages and I noticed that this was mostly=
 due
> >> > > to sheaves results missing occasional spikes that worsened
> >> > > TYPESAFE_BY_RCU averages (the results seemed more stable with
> >> > > sheaves).
> >> >
> >> > Thanks a lot, that looks promising!
> >>
> >> Indeed, that looks better than I expected :)
> >> Cheers!
> >>
> >> >
> >> > > [1] https://lore.kernel.org/all/20250213224655.1680278-1-surenb@go=
ogle.com/
> >> > >
> >> >
>

