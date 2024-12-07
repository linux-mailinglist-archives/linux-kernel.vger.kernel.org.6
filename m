Return-Path: <linux-kernel+bounces-435880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020419E7E31
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4A286717
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95F52F88;
	Sat,  7 Dec 2024 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MDn6GOgv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD41F481B1;
	Sat,  7 Dec 2024 04:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733545747; cv=none; b=Csg4IHnfbNwUsb6yllQOU8ZqQ2BjeOvh/780i+zFoxeLqTVgzjh7JlQFtcCtxDL1BB+Dfk7x/PDlIs3VrjvnL/nXW/JLIogHhxFWcFmL/B01geG4J9pt1y+hilR1MWpIW2qnz01SiOReuXMtIvvuNBEriDS57dN6MPkCySyr52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733545747; c=relaxed/simple;
	bh=7ujOXHiY2JcriC2wOuNhv6HLkcewVN8yC452wdStT/0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T7YjAzkuK+EkhfLXOxUXWc31+LXJF21pVPhuGgZJPHov3RRtE7XmBDFZZBTT9FtV5FfE+DY0sXQ1hLvDLWSanxOxU824z966Yy8UBbXbhFcttsgEMKgLzVGJaHcs1tRgluJJmd8yS4SlHNvzaPDUHhyks5UMmYdYjtmMrK/wib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MDn6GOgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D27AC4CECD;
	Sat,  7 Dec 2024 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733545746;
	bh=7ujOXHiY2JcriC2wOuNhv6HLkcewVN8yC452wdStT/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDn6GOgvQqCGCYf9EL+Jkrm9535UtanJ5AFtgX+yVnNqXgg5bh3UX+F8mbDrJ12b8
	 eMs4cq0vn59NaF+iEAhMI8eqU/qK3WMN8jeyH8HQWn/8vxOXK4jqr90oI45CloWmbO
	 VMms735LHpGCHKGEnWh7E1iLptdRTW2a++ta6cg0=
Date: Fri, 6 Dec 2024 20:29:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
 hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
 mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
 oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org,
 dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
 souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH v5 0/6] move per-vma lock into vm_area_struct
Message-Id: <20241206202904.e685764837504d97cbc3cf62@linux-foundation.org>
In-Reply-To: <20241206225204.4008261-1-surenb@google.com>
References: <20241206225204.4008261-1-surenb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 14:51:57 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> Back when per-vma locks were introduces, vm_lock was moved out of
> vm_area_struct in [1] because of the performance regression caused by
> false cacheline sharing. Recent investigation [2] revealed that the
> regressions is limited to a rather old Broadwell microarchitecture and
> even there it can be mitigated by disabling adjacent cacheline
> prefetching, see [3].
> 
> ...
>
> Patch applies over linux-next (due to vm_lock change [5] not in mm tree).
> 
> ...
>
> [5] https://lore.kernel.org/all/20241122174416.1367052-2-surenb@google.com/

Well that's awkward.  I added the "seqlock: add raw_seqcount_try_begin"
series to mm.git.  Peter, please drop your copy from linux-next?

