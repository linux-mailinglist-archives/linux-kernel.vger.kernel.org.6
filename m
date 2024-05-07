Return-Path: <linux-kernel+bounces-171925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2918BEAB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193F41F26098
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DEE16C855;
	Tue,  7 May 2024 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ten4Eycf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73186E570
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715103525; cv=none; b=olD+119hH9EHWwzgZuFbpY7N2MsVfJqP5PTHX4koGM8YcGZfk14/Ooxf73xVcm+bVpMU9o0chUZOem5Qrob6GJB20nmzRdz4rJnGsE0chZUQCFpuahrk8eLji4RfvKgRyevdTZpJxu0RxHk1yYH0/b4wK6NL01j25Tcy9VrJrkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715103525; c=relaxed/simple;
	bh=Kk5dtahjbr3xZRYks0JLO6NbANU6wiMK62UB4BoVbkA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j26ysRpD6NAC2PvlsOxU6uFQSLGfk8KG/NExJDyGu07dRL2D2jkgHE4Lfe0fpCmmYRS9Reeke/hryiP66ixywUseCF0wVJAZgn+hTgMQHM9Sik3DfsejxdeJXcd7TAqP74mhjscxKo7OoVjzGpzbth9Qj2Wj1orCaDMBkk9Cr14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ten4Eycf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB8CC2BBFC;
	Tue,  7 May 2024 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715103525;
	bh=Kk5dtahjbr3xZRYks0JLO6NbANU6wiMK62UB4BoVbkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ten4EycfJ89RrJXXlLX05LJcpfxrIS+lzOLKwW2O0r1LFLT2lRMhjYR4kJ5AdXzIh
	 mMxn91I6Uzl6t7WZmAGNyDsXaCDbOCBYSPj4GDMzewBJ1DAworDtivTPzQohIZhomb
	 S1sTqTe37Z+jIErKvjB16Ot3WKlt+XVlGaXHuxxU=
Date: Tue, 7 May 2024 10:38:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ziy@nvidia.com, ryan.roberts@arm.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting
 into pagewalk loop
Message-Id: <20240507103843.d15414e356d60612f94ec6ce@linux-foundation.org>
In-Reply-To: <19645506-f17d-4202-807e-f0e5c99af742@redhat.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
	<20240501042700.83974-3-ioworker0@gmail.com>
	<cc9fd23f-7d87-48a7-a737-acbea8e95fb7@linux.alibaba.com>
	<CAK1f24kyCj2Svguuu07wDuVEWYYbcmRc_18ihgVAzSjoJ9ox2A@mail.gmail.com>
	<a8f7a8da-c2e1-443c-9220-a224d97b1c81@redhat.com>
	<CAK1f24=rWdgscbDa6pMqOmTEDOHVLo5NQ=7jOo9TdyJRXahHZg@mail.gmail.com>
	<20240507102241.0a09db69afd62efb5ce84f17@linux-foundation.org>
	<19645506-f17d-4202-807e-f0e5c99af742@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 May 2024 19:33:05 +0200 David Hildenbrand <david@redhat.com> wrote:

> > Well, which series are we talking about?  "mm/madvise: enhance
> > lazyfreeing with mTHP in madvise_free v10" or ""Reclaim lazyfree THP
> > without splitting v4" or both?
> 
> See my other mail, "mm/madvise: enhance lazyfreeing with mTHP in 
> madvise_free v10" is all acked/reviewed and good to go.
> 
> > 
> > And how significant are the needed fixup patches?
> > 
> > And what is our confidence level after those fixups are in place?
> 
> I'm afraid I won't have time to review this series this/next week, so I 
> cannot tell. I already assumed this would not be 6.10 material.

OK, I've dropped the series "Reclaim lazyfree THP without splitting",
v4.  Let's revisit in the next cycle.


