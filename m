Return-Path: <linux-kernel+bounces-290290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6909551DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DF6B22D47
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100C91C2316;
	Fri, 16 Aug 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Eml5clA8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15829B664
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840500; cv=none; b=mW7dMLf3QTISxAQfXB5NmkRtRTcamofCEo9rQNclI3HnlxfcGEXjEzmC3fryd26f79mfH//lBeuRohvzogQeSEDcND5GxL5J5vG0xCbNBnKL3i8j6KsmhIXDKg8EY/clatSiapxEt9FuQdyYHhdYdcfOTUYW7ZE3r8GrA+2jMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840500; c=relaxed/simple;
	bh=mCeKW9dQ6xIGWmmcqv1RuGrMIZNV1U+bDDh5vNR/BqQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GdDiaX8CFUh/Lsi+BMS71PTBBZ7OaXaw/RQPGdJSa+zfXl6ItQN5K9meutE9kysbXg7RUB4uR1092EQ82RHCC4FM1xILzhVEGC/W2KnVrYXqxWA6W1xbIsZA6lkv5GcL4l/IVsGj87vdlVt/XqlOxKewepJbfoQbwwklc04Ca6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Eml5clA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B77BC32782;
	Fri, 16 Aug 2024 20:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723840499;
	bh=mCeKW9dQ6xIGWmmcqv1RuGrMIZNV1U+bDDh5vNR/BqQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Eml5clA8Lo0c0aYiWJ/bqYGkF6M6VGa5pLMpllrNPTDY1GZgAMXNLYLEGV0TWwhTN
	 LciIxvf2U1efNqcSnxys5XlMOqWMxgM8nlMFgI5f38T8SaJbc2p8aCElAZX/otq64s
	 IqZcEl3kih0Br1aRaIBrnd36x3ZVUcZx+7pKWyB8=
Date: Fri, 16 Aug 2024 13:34:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hch@infradead.org,
 hughd@google.com, kaleshsingh@google.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com,
 ryan.roberts@arm.com, senozhatsky@chromium.org, shakeel.butt@linux.dev,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like
 devices
Message-Id: <20240816133458.375e19fc36f61c8fd5d64f28@linux-foundation.org>
In-Reply-To: <CAMgjq7AeVkmOiVFa4-iP4nbyX3LHft_5wfvV_raj_N+twdzMKQ@mail.gmail.com>
References: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com>
	<20240815230612.77266-1-21cnbao@gmail.com>
	<CAMgjq7AeVkmOiVFa4-iP4nbyX3LHft_5wfvV_raj_N+twdzMKQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Aug 2024 00:50:00 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> > --
> > 2.34.1
> >
> 
> Hi Barry
> 
> After the fix the spamming log is gone, thanks for the fix.
> 

Thanks, I'll drop the v6 series.

