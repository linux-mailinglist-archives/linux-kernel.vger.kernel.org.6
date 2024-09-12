Return-Path: <linux-kernel+bounces-327092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86889770ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C10EB228D3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1882BAE3;
	Thu, 12 Sep 2024 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLhn2ytt"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314001714CC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167066; cv=none; b=XkoCDUgllEt2ZtekJlgUpGojUkvqx99roDzg/oSzlqRBzG5En6s8p//vN2G1bdcItkxlT4kMTr4DaEQOFt5hxhRD4wHi2sKrWwJ156fY7kuQXTek3e5/bagDkp6DBTHURT5CamPrybhA1ix6agsdFiclMY7ajdIw96uonS4TGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167066; c=relaxed/simple;
	bh=2A/QfAynXKpV+8FU25VEKx2tUcXyN85QQTyRvY+ivQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwcyePmm36Du8YjNc2EBJxOMyCMuwpCx1c3M0pPNXczOTYuW6hSdmXvYMYo6f1fWUtg2CAVxQYT2JW1wQJQTwUb42rGcCR0eSzJx/gx9W5Jzh/YgKDjm6hkCY+UT9KNDpdxRsMUaV/mjuA0oSPB/7TGzxDwdV+mQ6wPjwh7uJZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLhn2ytt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53658f30749so1559063e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167063; x=1726771863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7bWKO38Qf894pq8zFNg+EuWT5DdQohpoosxwSmJBDM=;
        b=FLhn2ytt/EJ6sGiJf2ZdZ54z850+eY3AsQMYNg2bOexynzA5ppZ/6VdEVHFvVtFRe/
         cyqd/k1o7kX1FMtiVwanSRi6m+yGuaoMEYoznUCBh4vON7mjPpBueOfus1pAU21WCZBR
         GRxEPZxsBEEaPN/hTJ/9pyQMUXPAgkxZG5CKKps+Wf1LneLikPJfjLd2sZLVUHY7SUMt
         HZy3twS4hDRTRjN02axBCttku8sDbhpAlq/2AoLS1qt0jgGJ3lFZlyzZEI4Xk60kGkgh
         tpQyFFXRks8I7tOdWJaPvjzXuaJxbkFm9PTKXZs4xVvWXuCG6/GLp3WXblMgqIGkjrM2
         TVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167063; x=1726771863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7bWKO38Qf894pq8zFNg+EuWT5DdQohpoosxwSmJBDM=;
        b=mInHxTnn8AtdT63Pt8uYvFYt3i9x3AtBDQ2LJgTp2IscwpO8CJWWcYRkIjpDpcka5P
         wFzop+CDuWrMjHAI+rDeFNPcCNsIRtemCUwnL6f3HKClltmo+rAzxTDaAAEL95JMHcYP
         V87vDJCW2zfyZtEOicr8YX1kaPtKrwe6jH7DgAE8V/FnchvKccAKmPGlE63IKDbv+l9u
         Jp6+4ltZBCihHC+kX9xWTx2lpXNMSoEdaLbDDFH1PY3riDhx1oWDuW2+5WD7/dG/NK0G
         1TzgG7mQ74WLXfk2uO6e+YpexJjx5D63pdYNyOd3OtoQ9TJgz8C2tPaHQ/wrCTSlrT3j
         j4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWw/tyeFvoaILwHCtY77xAp0PSHEerRdH8coRolC9+Y0MLHMLuEKX2ri0Egd7PiSdVm8dD6sWFLhWLRxyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBZRsybtOhiJlwk8DF6qwfAu5793KNRzG2ng06uD89dTECNaRM
	IhhD6+pWTKUFW7C8hxlourxuSkgj3w8T3lxE9FwpcvIC+hnXAHK7CETxlNxpqpkI3FSAKxm3cDq
	JNPe9wRwyyVkLj7mhQsUGgD8fYftrI1/WsYWA
X-Google-Smtp-Source: AGHT+IGbsQyMnaE2mOrQPBKLZNE9IHxt090oc8KlhsXnAdhsVXdMcywgStpHdkAnRMuzThus9L/uQOrGK/gKgUNwOw8=
X-Received: by 2002:a05:6512:b23:b0:52e:f99e:5dd1 with SMTP id
 2adb3069b0e04-53678feb480mr2327014e87.47.1726167062504; Thu, 12 Sep 2024
 11:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org> <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
 <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org> <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
 <CAKEwX=PTA0OxisvY12Wa95s5KqzvQTXe1rZ7nw29nP+wR2dxkA@mail.gmail.com>
 <CAJD7tkbMph337XbBTbWfF8kp_fStP3-rN77vfR5tcn2+wYfJPQ@mail.gmail.com> <CAKEwX=PcK=kJG-yxaoTYvJGNwQ=eTGo1m=ZraqYy1SyLDs9Asw@mail.gmail.com>
In-Reply-To: <CAKEwX=PcK=kJG-yxaoTYvJGNwQ=eTGo1m=ZraqYy1SyLDs9Asw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Sep 2024 11:50:26 -0700
Message-ID: <CAJD7tkYhOphYbNnwkZfJykii7kAR6PRvZ0pv7R=zhG0vCjxh4A@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Nhat Pham <nphamcs@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mfleming@cloudflare.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:25=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Thu, Sep 12, 2024 at 10:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > >
> > > I'm not, but Joshua from my team is working on it :)
> >
> > Great, thanks for letting me know!
>
> FWIW, I think the zswap_shrinker_count() path is fairly trivial to
> take care of :)  We only need the stats itself, and you don't even
> need any tree traversal tbh - technically it is most accurate to track
> zswap memory usage of the memcg itself - one atomic counter per
> zswap_lruvec_struct should suffice.

Do you mean per-lruvec or per-memcg?

>
> obj_cgroup_may_zswap() could be more troublesome - we need the entire
> subtree data to make the decision, at each level :) How about this:
>
> 1. Add a per-memcg counter to track zswap memory usage.
>
> 2. At obj_cgroup_may_zswap() time, the logic is unchanged - we
> traverse the tree from current memcg to root memcg, grabbing the
> memcg's counter and check for usage.
>
> 3. At obj_cgroup_charge_zswap() time, we have to perform another
> upward traversal again, to increment the counters. Would this be too
> expensive?
>
> We still need the whole obj_cgroup charging spiel, for memory usage
> purposes, but this should allow us to remove the MEMCG_ZSWAP_B.
> Similarly, another set of counters can be introduced to remove
> MEMCG_ZSWAPPED...
>
> Yosry, Joshua, how do you feel about this design? Step 3 is the part
> where I'm least certain about, but it's the only way I can think of
> that would avoid any flushing action. You have to pay the price of
> stat updates at *some* point :)

In (2) obj_cgroup_may_zswap, the upward flush should get cheaper
because we avoid the stats flush, we just read an atomic counter
instead.

In (3) obj_cgroup_charge_zswap(), we will do an upward traversal and
atomic update. In a lot of cases this can be cheaper than the flush we
avoid, but we'd need to measure it with different hierarchies to be
sure. Keep in mind that if we consume_obj_stock() is not successful
and we fallback to obj_cgroup_charge_pages(), and we already do an
upward traversal. So it may be just fine to do the upward traversal.

So I think the plan sounds good. We just need some perf testing to
make sure (3) does not introduce regressions.

