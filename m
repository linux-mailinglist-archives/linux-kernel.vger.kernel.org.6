Return-Path: <linux-kernel+bounces-357842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E517E9976DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9EF1F2423A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988611A2544;
	Wed,  9 Oct 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zXfSSqJD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDB40849
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506942; cv=none; b=TeGogSkI8nBEFreq/Bx3Asg4IwsOledwbtBpl1AIqcnpEYKXvMXMpyO8elQB+nV3FXKssB5iRWXANuZHyzqEj+KUMmZWCKVZilGihO2GQ395BEsvWLRAeySHOTCpG1PaZqwhBqxUx5/Choc/au13uYlLf0IH2sghbRBdKC+P+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506942; c=relaxed/simple;
	bh=Ak9FDAbWb2MBZ6vEakI7k/F1y9F/l9/DPC9lZv+LEVE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uLPsyFyYIsRNrCtBJc39SxOy0VyZ68mDF4LMCnxJML+o0XJKe/fn1fqFTQGDcnTn+QmqHxNkufgvMUOjPDOlX5NBeaByec7OLEBftr10qo0Uu4wyachntdT+m4KK3p4mhzYlLumoocZYzywMIYZ3taqzM4i7VcHK6hzR0lVJMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zXfSSqJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD29C4CECC;
	Wed,  9 Oct 2024 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728506941;
	bh=Ak9FDAbWb2MBZ6vEakI7k/F1y9F/l9/DPC9lZv+LEVE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zXfSSqJDBv/TS/85VIqvKEzx4cv9xKXT47IrBBPNUimtYz6xCt4upu/nj38G9cBVh
	 QgDLimptmLVFuO+2BCah/6B3M3fHbNMMmqEa+IBcXYb6QO9lIxyPj05bzOySaKO35z
	 e2/QtZ+PLuUF86hpa/9xxdHs7CagDh602Zm4ULqs=
Date: Wed, 9 Oct 2024 13:49:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: sj@kernel.org, minchan@kernel.org, vbabka@suse.cz,
 kaleshsingh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 jaewon31.kim@gmail.com
Subject: Re: [PATCH] vmscan: add a vmscan event for reclaim_pages
Message-Id: <20241009134900.7cd8fe9000a9fafd7ca1c592@linux-foundation.org>
In-Reply-To: <20241009093124.3647359-1-jaewon31.kim@samsung.com>
References: <CGME20241009093133epcas1p39b770ebcc6d2d78cad2f9a522bc6f179@epcas1p3.samsung.com>
	<20241009093124.3647359-1-jaewon31.kim@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 18:31:24 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> The reclaim_folio_list uses a dummy reclaim_stat and is not being
> used. To know the memory stat, add a new trace event. This is useful how
> how many pages are not reclaimed or why.
> 
> This is an example.
> mm_vmscan_reclaim_pages: nr_scanned=17 nr_reclaimed=17 nr_dirty=0 nr_writeback=0 nr_congested=0 nr_immediate=0 nr_activate_anon=0 nr_activate_file=0 nr_ref_keep=0 nr_unmap_fail=0
> 
> Currenlty reclaim_folio_list is only called by reclaim_pages, and
> reclaim_pages is used by damon and madvise. In the latest Android,
> reclaim_pages is also used by shmem to reclaim all pages in a
> address_space.
> 

This looks like it will add some overhead when tracing has been
enabled.  Has this been measured and is it significant?

Also, we're adding a significant amount of code for a simple trace
record.  Do others think this is justifiable?

