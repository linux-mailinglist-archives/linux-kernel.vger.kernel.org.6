Return-Path: <linux-kernel+bounces-195042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907478D46B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6939B22B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AA3152527;
	Thu, 30 May 2024 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQtUrnwZ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6C9150996
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056501; cv=none; b=LioCwdMwNDJ+m7wz/MorgIEMKAFWUBWDxcPdR/Dzzj4x5RCgaAs4lKhFOqUzQJw2EHZ5SiwfUumCbON6XaHMXD9iUGVqCXowc550WsO8jOkvG1qQcDIee670VWoYOfnZpRUBt++oi6YroVEGGiNgHNyz8MufmAPlG1vfnJ5vAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056501; c=relaxed/simple;
	bh=k0ZBEeRh0XWyWlSOxsnf9VcY8uTBB9L1XhwNW0u7CGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWb085QSazgl5oEycJMQDAWGlVoAE7sEKIv/jvYDXng5ZYHDrret1SRgIbEbs3GxIGooIZvEfm0wfoE5kNC8tSS3/Eu+TMAxIFEcRcfLyXuExJPWVrc3GKLtxC51sEPgAgGtACb34yfFpp97UNGW9n7mM+A773U66qHkTIZRqSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQtUrnwZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso6677141fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717056498; x=1717661298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfKMyMYhLm5TkN6bYgjnafVY1Qip0F79Hn2SwhSUVBc=;
        b=bQtUrnwZySFoG+nR0rTOeJEiKky2ZlIn33tI10t+Swnm4kPOa8bKA9eO6ZBno9CjsG
         NKnoOkAAUdHhcibCj1ohpo9ROjUxVGZIMtV4+CZOB+d/OsvWp0FVyNbJ/1Vl47TVOwV9
         yRUQfn6t7nkCYL9bAq/xL6y7RGgebTvPWrCZ5ljhcoJoYzNEhalQfOX/FjfnV96hdS7U
         AATFMuqCyK4V5aryQOZbE35JyIhNpoIIXfSBaoWXpGzqTpjIqVIkrWE+sDaZA1D7Z0IY
         wHvIKtfB55ftDLM+j1im8qzXsflojvhZJkpg+C7pDY0zTBCav++qRFVNZhZBj7jeNqxz
         3DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717056498; x=1717661298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfKMyMYhLm5TkN6bYgjnafVY1Qip0F79Hn2SwhSUVBc=;
        b=JXF6rf+8PWdxz8WS2mJdDZFtoF8rXrr1KiBtSKxVUAD13o2C1FnuVKjPXk69lx/yq9
         O60HeA0j5xq1XsjoM7yXUbANf4J8HgL8Rgb1vKiHdX16VMCGorgC8VuqpX3W4W4COfQJ
         XNWa2JQNnbwMmMcLZQUZ7o7L2zLddYzNzuZrjexLUR3YXifLoWJ2wkGehB9pkL3x3Wf8
         BDRqUy43EKdffIIu3CjHQhqKk/0JuEwR0+luR5D5F98+pl+ruMJ+kBsiqcNnZFnvELNr
         46u1qS68yseEpRPv7mW4fZjF0ahdmZp9sXwzz8uubACwjgQZUOlnKmDwP8h98WdwMhGv
         yXGg==
X-Forwarded-Encrypted: i=1; AJvYcCXefRR18QhRI+iZQA/p/rELBz82JvqdXc0a0lY84XYazxuknNnQZnMsPvGjYN6qT2DMuuneJs1wKbtxLt2fFIx43RqisG+UPFdLm28d
X-Gm-Message-State: AOJu0YyGrZ+tMd9vDuljsTpw/+04jvd1JvP8FhJvueyEgy4E+XPmyZvD
	4MussM66sh5bfKyK4Ve/xJZZb+HuvPpYVgakV7dWRuPewdtF4o21pVlOg1JZgLlhg5i4Is9lZp4
	9/QFNMFp91LrvxTVrripYzno1r+oUxRnL
X-Google-Smtp-Source: AGHT+IEGSmC/noP/5Mjx/gVtFSofe9jPz4+grh9k7k93qRBTcGFy+pJETqSw477sKKOLSUx59OJYTDq+9LHxLZDmD6U=
X-Received: by 2002:a2e:99d6:0:b0:2da:9ed:9b43 with SMTP id
 38308e7fff4ca-2ea84824837mr8587261fa.31.1717056497579; Thu, 30 May 2024
 01:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <87cyp5575y.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuN8HWLpv7=abVM2=M247KGZ92HLDxfgxWZD6JS47iZwZA@mail.gmail.com>
 <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875xuw1062.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 30 May 2024 16:08:01 +0800
Message-ID: <CAMgjq7AoCL3yqBiys+ksoKQVZW_AopzhuXk7xzQzSwBxHZumeQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster order
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 10:54=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Chris Li <chrisl@kernel.org> writes:
>
> > Hi Ying,
> >
> > On Wed, May 29, 2024 at 1:57=E2=80=AFAM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Chris Li <chrisl@kernel.org> writes:
> >>
> >> > I am spinning a new version for this series to address two issues
> >> > found in this series:
> >> >
> >> > 1) Oppo discovered a bug in the following line:
> >> > +               ci =3D si->cluster_info + tmp;
> >> > Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
> >> > That is a serious bug but trivial to fix.
> >> >
> >> > 2) order 0 allocation currently blindly scans swap_map disregarding
> >> > the cluster->order.
> >>
> >> IIUC, now, we only scan swap_map[] only if
> >> !list_empty(&si->free_clusters) && !list_empty(&si->nonfull_clusters[o=
rder]).
> >> That is, if you doesn't run low swap free space, you will not do that.
> >
> > You can still swap space in order 0 clusters while order 4 runs out of
> > free_cluster
> > or nonfull_clusters[order]. For Android that is a common case.
>
> When we fail to allocate order 4, we will fallback to order 0.  Still
> don't need to scan swap_map[].  But after looking at your below reply, I
> realized that the swap space is almost full at most times in your cases.
> Then, it's possible that we run into scanning swap_map[].
> list_empty(&si->free_clusters) &&
> list_empty(&si->nonfull_clusters[order]) will become true, if we put too
> many clusters in si->percpu_cluster.  So, if we want to avoid to scan
> swap_map[], we can stop add clusters in si->percpu_cluster when swap
> space runs low.  And maybe take clusters out of si->percpu_cluster
> sometimes.

Stop adding when it runs low seems too late, there could still be a
free cluster stuck on a CPU, and not getting scanned, right?

> Another issue is nonfull_cluster[order1] cannot be used for
> nonfull_cluster[order2].  In definition, we should not fail order 0
> allocation, we need to steal nonfull_cluster[order>0] for order 0
> allocation.  This can avoid to scan swap_map[] too.  This may be not
> perfect, but it is the simplest first step implementation.  You can
> optimize based on it further.

This can be extended to allow any order < MAX_ORDER to steal from
higher order, which might increase fragmentation though.

So this is looking more and more like a buddy allocator, and that
should be the long term solution.

