Return-Path: <linux-kernel+bounces-309629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F56966D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 02:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829C128307C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23EC179AE;
	Sat, 31 Aug 2024 00:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I4axDld3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DF2C9A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725064695; cv=none; b=pfvSg0nmb5rJxGexM1Xsfx3CCKd8L0VzHbxeGXMEGyxWZHQYClF31El+W3Tk7xxwuCxKsfhHXqASRpLhW6lSMWSjyjl8nPBBOuocI1WwE5Oh+xkK0RgLWtjHzT9SZZA0BMj5ODYb7yhdGWk419unYn8FslC2daN5gHxkvGSy8pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725064695; c=relaxed/simple;
	bh=41QhoOH043vB3lz1p4/QFHetCaG4BRSFEdl5XSgn20o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bog2TGyj5j5V7pS6gEUJ0phjBsoCMT/wjZbdvSH6fnNQdih+a3UmrykZqELV1agp4yREbEbMK4Ft4EdhpOrm0qhnydq9faUrew39SZxOl2brwwir23nTXS79qul8Q8XVeDqwsDuBePj0I3ZB6NQ82po3NKgRtJgIx0cmP4ycCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I4axDld3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54827C4CEC2;
	Sat, 31 Aug 2024 00:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725064694;
	bh=41QhoOH043vB3lz1p4/QFHetCaG4BRSFEdl5XSgn20o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4axDld3rFxM/mIdfbjlATcUOo6WidbcUVzr40cusz+DMssOens3X3GyvPkj8kqKv
	 GMoWx6THtCgUzQty2MKBncRUTTpqspOO/4hDLgTi1FhcX2MLduJ+mtC+Nv6rBtq8dK
	 CTuo2lYV3058JjLZLHwlcbJeET35X6mPRE0My5eI=
Date: Fri, 30 Aug 2024 17:38:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>, linux-mm@kvack.org, Yu
 Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, "T . J . Mercier"
 <tjmercier@google.com>, Kairui Song <kasong@tencent.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
Message-Id: <20240830173813.c53769f62bf72116266f42ca@linux-foundation.org>
In-Reply-To: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com>
References: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 18:25:43 +0800 Jingxiang Zeng <jingxiangzeng.cas@gmail.com> wrote:

> From: Zeng Jingxiang <linuszeng@tencent.com>
> 
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering
> OOM when encountering many dirty pages during reclamation on MGLRU.
> 
> This leads to premature OOM if there are too many dirty pages in cgroup:
> Killed
> 
> ...
>
> The flusher wake up was removed to decrease SSD wearing, but if we are 
> seeing all dirty folios at the tail of an LRU, not waking up the flusher 
> could lead to thrashing easily. So wake it up when a mem cgroups is 
> about to OOM due to dirty caches.

Thanks, I'll queue this for testing and review.  Could people please
consider whether we should backport this into -stable kernels.

> MGLRU still suffers OOM issue on latest mm tree, so the test is done
> with another fix merged [1].
> 
> Link: https://lore.kernel.org/linux-mm/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/ [1]

This one is already queued for -stable.



