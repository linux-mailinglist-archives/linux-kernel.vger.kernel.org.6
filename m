Return-Path: <linux-kernel+bounces-196811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2F8D6207
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863A71F278C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231A158D83;
	Fri, 31 May 2024 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmPVMcPJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF31586CF
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159232; cv=none; b=u/ZmrL+PaJtA7o2x+Dh7cqcEHu/39mF3HFmRSnC+Suk3IS5MT79rvUdEXq6E1oGcZdL747daVbl/vYClrtwczHe1MNxc6T3oEdr7SO5kOZgnSk6k20rCtr/0JHJCfK1sE20cTvZEUvjXninCyePhwLfw4WQC6lZU+RFknnVSd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159232; c=relaxed/simple;
	bh=zmrvUqwKLF3eL7ycYOa1UigDxM0bOqHzXB4ejPMkYFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omF7HZRKFRZc2XJiB3CKxhslzDdz2FGoQF9mlem2ICR6IRttXWjHiytceiMyq3Nn58rYUscSCajBagV/+GdNY8JiYKRVacI7gbJ3eEmmvCNy8/C834GuJdl8zAlB2HkCO6sSbFw//uAivplkS7+DrT/Ud5pTR6WfUn208ObH5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmPVMcPJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso16929441fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717159228; x=1717764028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfnILgMvH7GxtH3T/3UXsRnKvHnmj7OrwjW6Wjae0T4=;
        b=YmPVMcPJNvPV9v3IATRHsEBHC0CDEANTjCj+UFaOCkP3AqUuDCcVBCJUZcvTZgSpQk
         e2KUWmGcy5xhWOHICrtJWfqHzGDWbtdBcV6Yjf2SSm/Ih4q+WeXWxkwIQkcKMNl1uvfH
         m5TaUJHmvk5FSVCEA65UeGoHgrFMmQsVdcx98VGbRLNjqw4QtY8Wv0ulmh1MvPX+w9FL
         PsLVzyc9+CfygiUPI8/W0IEC0LU9/FiIOOE3I6BfOWrW34CKIsC6GdMPZRkyP+ZiYKwV
         s6HtdtSZa5nzau+R1MMYMB+mySe8Ejxra1C8OJIXqfiv95EF7WMyrmF8mKgW+h/ormom
         SS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717159228; x=1717764028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfnILgMvH7GxtH3T/3UXsRnKvHnmj7OrwjW6Wjae0T4=;
        b=K2DGzATlGN9kQ+KboFnLLY+VCXSFJz5EZBLI4UNQu6aLy0cyancpdkN5JbRvEOg58b
         QbtS1Un0+izkStsVX3EowRiIHN1Kw++IyLSo72uOpIq5A3ROWS3BRDsr5ejolhb/q8sR
         Fjr0ghMDskeA9CfqmevLlYN959IDKtYKPO2G2/AfJj+nq77tNvi12tjlsFv0/Q/4TPox
         r4c4ilAmlMSL3EUWfiPM0Oxxe2J2y4TkT/YE8Gqw1gNQ4ocNN/KOmU5ERTuMsZRklEaM
         ROZZ/fhzs8pmiMc7hi/R/wfeUKfmf812Djv3zndiSZ4ctE7Nwq0nZHYG9nxMmnHZTIMS
         XPAg==
X-Forwarded-Encrypted: i=1; AJvYcCX72SY9YoQEgfCIkgfs+oiw/acAQ8HiMQoGlX3h+cgEfJxUt+4uE1gbasm8nohq2JDGEN8dh3Rrj4lyVX6I2w4TS324LL1zTQfSPNWb
X-Gm-Message-State: AOJu0YzQ/KQihxTC1oIOYsmPLnx2rjV6tbU/o/m4synzsVhOVAq/8QhR
	xeMKSHPX50Ejpw943FwzI+j9xptqIpyvWrb+mkA75jp6Dbno80QIjGqQR1JyxaQhUVxQaPGVgcf
	o5H18USSmTaHnhfARcOLwighg4e0=
X-Google-Smtp-Source: AGHT+IHS2MTlto8RHe3AquZRlNJ0TIGzIQU7XbotZgQe2qCpma2vav7K0JxoFnoSzDubHtZ1cyUJCwZ7qsWSeh5ZrP0=
X-Received: by 2002:a2e:9ac4:0:b0:2e1:c97b:6f25 with SMTP id
 38308e7fff4ca-2ea950a723cmr5984231fa.1.1717159228227; Fri, 31 May 2024
 05:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuMc3sXKarq3hMPYGFfeqyo81Q63HrE0XtztK9uQkcZacA@mail.gmail.com>
 <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o78mzp24.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 31 May 2024 20:40:11 +0800
Message-ID: <CAMgjq7C+rtbbnH+utGkUmwaTzB82zrO8qvotPx9Z6A4fMiO_4A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 10:37=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > On Wed, May 29, 2024 at 7:54=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > Hi Ying,
> >> >
> >> > On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Chris Li <chrisl@kernel.org> writes:
> >> >>
> >> >> > I am spinning a new version for this series to address two issues
> >> >> > found in this series:
> >> >> >
> >> >> > 1) Oppo discovered a bug in the following line:
> >> >> > +               ci =3D si->cluster_info + tmp;
> >> >> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
> >> >> > That is a serious bug but trivial to fix.
> >> >> >
> >> >> > 2) order 0 allocation currently blindly scans swap_map disregardi=
ng
> >> >> > the cluster->order.
> >> >>
> >> >> IIUC, now, we only scan swap_map[] only if
> >> >> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_cluster=
s[order]).
> >> >> That is, if you doesn't run low swap free space, you will not do th=
at.
> >> >
> >> > You can still swap space in order 0 clusters while order 4 runs out =
of
> >> > free_cluster
> >> > or nonfull_clusters[order]. For Android that is a common case.
> >>
> >> When we fail to allocate order 4, we will fallback to order 0.  Still
> >> don't need to scan swap_map[].  But after looking at your below reply,=
 I
> >> realized that the swap space is almost full at most times in your case=
s.
> >> Then, it's possible that we run into scanning swap_map[].
> >> list_empty(&si->free_clusters) &&
> >> list_empty(&si->nonfull_clusters[order]) will become true, if we put t=
oo
> >> many clusters in si->percpu_cluster.  So, if we want to avoid to scan
> >> swap_map[], we can stop add clusters in si->percpu_cluster when swap
> >> space runs low.  And maybe take clusters out of si->percpu_cluster
> >> sometimes.
> >
> > One idea after reading your reply. If we run out of the
> > nonfull_cluster[order], we should be able to use other cpu's
> > si->percpu_cluster[] as well. That is a very small win for Android,
>
> This will be useful in general.  The number CPU may be large, and
> multiple orders may be used.
>
> > because android does not have too many cpu. We are talking about a
> > handful of clusters, which might not justify the code complexity. It
> > does not change the behavior that order 0 can pollut higher order.
>
> I have a feeling that you don't really know why swap_map[] is scanned.
> I suggest you to do more test and tracing to find out the reason.  I
> suspect that there are some non-full cluster collection issues.
>
> >> Another issue is nonfull_cluster[order1] cannot be used for
> >> nonfull_cluster[order2].  In definition, we should not fail order 0
> >> allocation, we need to steal nonfull_cluster[order>0] for order 0
> >> allocation.  This can avoid to scan swap_map[] too.  This may be not
> >> perfect, but it is the simplest first step implementation.  You can
> >> optimize based on it further.
> >
> > Yes, that is listed as the limitation of this cluster order approach.
> > Initially we need to support one order well first. We might choose
> > what order that is, 16K or 64K folio. 4K pages are too small, 2M pages
> > are too big. The sweet spot might be some there in between.  If we can
> > support one order well, we can demonstrate the value of the mTHP. We
> > can worry about other mix orders later.
> >
> > Do you have any suggestions for how to prevent the order 0 polluting
> > the higher order cluster? If we allow that to happen, then it defeats
> > the goal of being able to allocate higher order swap entries. The
> > tricky question is we don't know how much swap space we should reserve
> > for each order. We can always break higher order clusters to lower
> > order, but can't do the reserves. The current patch series lets the
> > actual usage determine the percentage of the cluster for each order.
> > However that seems not enough for the test case Barry has. When the
> > app gets OOM kill that is where a large swing of order 0 swap will
> > show up and not enough higher order usage for the brief moment. The
> > order 0 swap entry will pollute the high order cluster. We are
> > currently debating a "knob" to be able to reserve a certain % of swap
> > space for a certain order. Those reservations will be guaranteed and
> > order 0 swap entry can't pollute them even when it runs out of swap
> > space. That can make the mTHP at least usable for the Android case.
>
> IMO, the bottom line is that order-0 allocation is the first class
> citizen, we must keep it optimized.  And, OOM with free swap space isn't
> acceptable.  Please consider the policy we used for page allocation.
>
> > Do you see another way to protect the high order cluster polluted by
> > lower order one?
>
> If we use high-order page allocation as reference, we need something
> like compaction to guarantee high-order allocation finally.  But we are
> too far from that.
>
> For specific configuration, I believe that we can get reasonable
> high-order swap entry allocation success rate for specific use cases.
> For example, if we only do limited maximum number order-0 swap entries
> allocation, can we keep high-order clusters?

Isn't limiting order-0 allocation breaks the bottom line that order-0
allocation is the first class citizen, and should not fail if there is
space?

Just my two cents...

I had a try locally based on Chris's work, allowing order 0 to use
nonfull_clusters as Ying has suggested, and starting with low order
and increase the order until nonfull_cluster[order] is not empty, that
way higher order is just better protected, because unless we ran out
of free_cluster and nonfull_cluster, direct scan won't happen.

More concretely, I applied the following changes, which didn't change
the code much:
- In scan_swap_map_try_ssd_cluster, check nonfull_cluster first, then
free_clusters, then discard_cluster.
- If it's order 0, also check for (int i =3D 0; i < SWAP_NR_ORDERS; ++i)
nonfull_clusters[i] cluster before scan_swap_map_try_ssd_cluster
returns false.

A quick test still using the memtier test, but decreased the swap
device size from 10G to 8g for higher pressure.

Before:
hugepages-32kB/stats/swpout:34013
hugepages-32kB/stats/swpout_fallback:266
hugepages-512kB/stats/swpout:0
hugepages-512kB/stats/swpout_fallback:77
hugepages-2048kB/stats/swpout:0
hugepages-2048kB/stats/swpout_fallback:1
hugepages-1024kB/stats/swpout:0
hugepages-1024kB/stats/swpout_fallback:0
hugepages-64kB/stats/swpout:35088
hugepages-64kB/stats/swpout_fallback:66
hugepages-16kB/stats/swpout:31848
hugepages-16kB/stats/swpout_fallback:402
hugepages-256kB/stats/swpout:390
hugepages-256kB/stats/swpout_fallback:7244
hugepages-128kB/stats/swpout:28573
hugepages-128kB/stats/swpout_fallback:474

After:
hugepages-32kB/stats/swpout:31448
hugepages-32kB/stats/swpout_fallback:3354
hugepages-512kB/stats/swpout:30
hugepages-512kB/stats/swpout_fallback:33
hugepages-2048kB/stats/swpout:2
hugepages-2048kB/stats/swpout_fallback:0
hugepages-1024kB/stats/swpout:0
hugepages-1024kB/stats/swpout_fallback:0
hugepages-64kB/stats/swpout:31255
hugepages-64kB/stats/swpout_fallback:3112
hugepages-16kB/stats/swpout:29931
hugepages-16kB/stats/swpout_fallback:3397
hugepages-256kB/stats/swpout:5223
hugepages-256kB/stats/swpout_fallback:2351
hugepages-128kB/stats/swpout:25600
hugepages-128kB/stats/swpout_fallback:2194

High order (256k) swapout rate are significantly higher, 512k is now
possible, which indicate high orders are better protected, lower
orders are sacrificed but seems worth it.

