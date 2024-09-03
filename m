Return-Path: <linux-kernel+bounces-313644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05A96A80C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877B21F25448
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025D1D0178;
	Tue,  3 Sep 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tdypDXlu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1F1CCB3D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725394079; cv=none; b=Rg8Nm3raS8XGG2Pq6LaEqTkaA0kJbEpGZbnaKmnKZm8N9rdkB3u2+cYa0CAec4xXj8JwrFBt0nDdhqFPiVJu5gc2o5X9ewxLDiIO8a9LvhPAa8Sv7RRRhirsHs14wWXlAWGl9Mur0d8JRGAwu5vmCnjtdvuOknE7MBKcqOrf7VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725394079; c=relaxed/simple;
	bh=fQAFo9M1O4RDOc+KfzpdXU0fZMbaXUrNjpO0iTtsDXk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e8rO5boeqsWeGgu3vSqudyioYwkutc/XItSOlUtyJoOV8gVrpw11IvzcI5UtvVOKGySzUetOwIYcTRLN5qst5sMx6IJme5iYGtgJCr9IABgMnaD6DjvQUBgr24XQVDMY/BEOScZzs1eoxOxaEM1oNlhtGP6M3a/ggY2HmRtO1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tdypDXlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621B1C4CEC4;
	Tue,  3 Sep 2024 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725394079;
	bh=fQAFo9M1O4RDOc+KfzpdXU0fZMbaXUrNjpO0iTtsDXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tdypDXlugF8gxU6YXJwTUXcQlu15769ykVcnFmgPEgfDlq9YK2vr57n/hw17ICRBE
	 24X0Gy7eQNu155hon6k4beqTF8q82Kpkis4P3GWE91cALUSA9B7ZpvkzU4YMBfLzFC
	 y+8WHiOvstLLt6e6tGRlZHBrBCdiKI6aOHnkiDDQ=
Date: Tue, 3 Sep 2024 13:07:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kairui Song <ryncsn@gmail.com>, hanchuanhua@oppo.com, Usama Arif
 <usamaarif642@gmail.com>, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
 linux-kernel@vger.kernel.org, mhocko@suse.com, minchan@kernel.org,
 nphamcs@gmail.com, ryan.roberts@arm.com, senozhatsky@chromium.org,
 shakeel.butt@linux.dev, shy828301@gmail.com, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, hch@infradead.org
Subject: Re: [PATCH v7 2/2] mm: support large folios swap-in for sync io
 devices
Message-Id: <20240903130757.f584c73f356c03617a2c8804@linux-foundation.org>
In-Reply-To: <CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
References: <20240821074541.516249-1-hanchuanhua@oppo.com>
	<20240821074541.516249-3-hanchuanhua@oppo.com>
	<CAMgjq7BpOqgKoeQEPCL9ai3dvVPv7wJe3k_g1hDjAVeCLpZ=7w@mail.gmail.com>
	<CAJD7tka+ZONNFKw=1FM22b-JTPkiKZaKuM3Upyu6pf4=vN_CRg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 11:38:37 -0700 Yosry Ahmed <yosryahmed@google.com> wrote:

> > [   39.157954] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
> > [   39.158288] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > [   39.158634] R13: 0000000000002b9a R14: 0000000000000000 R15: 00007ffd619d5518
> > [   39.158998]  </TASK>
> > [   39.159226] ---[ end trace 0000000000000000 ]---
> >
> > After reverting this or Usama's "mm: store zero pages to be swapped
> > out in a bitmap", the problem is gone. I think these two patches may
> > have some conflict that needs to be resolved.
> 
> Yup. I saw this conflict coming and specifically asked for this
> warning to be added in Usama's patch to catch it [1]. It served its
> purpose.
> 
> Usama's patch does not handle large folio swapin, because at the time
> it was written we didn't have it. We expected Usama's series to land
> sooner than this one, so the warning was to make sure that this series
> handles large folio swapin in the zeromap code. Now that they are both
> in mm-unstable, we are gonna have to figure this out.
> 
> I suspect Usama's patches are closer to land so it's better to handle
> this in this series, but I will leave it up to Usama and
> Chuanhua/Barry to figure this out :)
> 
> [1]https://lore.kernel.org/lkml/CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com/

Thanks.  To unbreak -next I'll drop the two-patch series "mm: Ignite
large folios swap-in support" for now.

btw, next time can we please call it "enable large folios swap-in
support"?  "ignite" doesn't make much sense here.

