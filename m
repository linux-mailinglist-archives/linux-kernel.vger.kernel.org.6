Return-Path: <linux-kernel+bounces-382897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787B29B149E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418EA282A10
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BD415C139;
	Sat, 26 Oct 2024 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xv0qaT2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831D80604
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729916690; cv=none; b=n8EvZ8Oj0AQe8kakxptLmXt6CKmbsGdSM8zbe11WNiIepMn+1aMt+pEFMGX0ScL98YNhiRc0WY6L+ew1LQjDzkVdwxlPnnQjNdlGs1Rx44RtXtbGryKNam7U6cN88NIcrJ7Q7RLqXTzub4UpxYFCpC7ayZdXyTcLBwAvqMkNRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729916690; c=relaxed/simple;
	bh=R8rB4NVIXDBOEydwcINIV7CZ0hDYYET+vpVc9feAhC4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LHGPyvf5q0nqXAnmflvmoTMPyR8V7wx6IQYG+GE9TZvp9FR12VLtOFlRF+tB8fU7vnnc2/yKm2VVozcIL7M0Majm14N+TJ0ou0ObFy40z/Lc+iM7TaO8+oB+O0ZBRyJyEOZMZZLEvQKD9PRDaHlpwbRoOr5uukYSLT2c1ZHV49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xv0qaT2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780D4C4CEC6;
	Sat, 26 Oct 2024 04:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729916689;
	bh=R8rB4NVIXDBOEydwcINIV7CZ0hDYYET+vpVc9feAhC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xv0qaT2QIVfkwK4h2ETIav75GmLJJKW9kx+fjQFs3cugcISut3h6DP77YW0AVrDIe
	 ykm8iIH3fyYiafgVuC5YSd+qvyoIIbmjFxeoRPceztjerO4+/WX3hlHxbjInHbBT0O
	 wMCLuhEjJ+zsxBeHF/IBEeNux+/8hxp8OjR1dUt8=
Date: Fri, 25 Oct 2024 21:24:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Link Lin
 <linkl@google.com>
Subject: Re: [PATCH mm-unstable v2] mm/page_alloc: keep track of free
 highatomic
Message-Id: <20241025212448.b1a9069d71df5b497e1b0190@linux-foundation.org>
In-Reply-To: <20241026033625.2237102-1-yuzhao@google.com>
References: <20241026033625.2237102-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 21:36:25 -0600 Yu Zhao <yuzhao@google.com> wrote:

> OOM kills due to vastly overestimated free highatomic reserves were
> observed:
> 
>   ... invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE), order=0 ...
>   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high:1068392kB reserved_highatomic:1073152KB ...
>   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME) 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*2048kB 0*4096kB = 1477408kB

Under what circumstances?

> The second line above shows that the OOM kill was due to the following
> condition:
> 
>   free (1482936kB) - reserved_highatomic (1073152kB) = 409784KB < min (410416kB)
> 
> And the third line shows there were no free pages in any
> MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> 'H'. Therefore __zone_watermark_unusable_free() underestimated the
> usable free memory by over 1GB, which resulted in the unnecessary OOM
> kill above.
> 
> The comments in __zone_watermark_unusable_free() warns about the
> potential risk, i.e.,
> 
>   If the caller does not have rights to reserves below the min
>   watermark then subtract the high-atomic reserves. This will
>   over-estimate the size of the atomic reserve but it avoids a search.
> 
> However, it is possible to keep track of free pages in reserved
> highatomic pageblocks with a new per-zone counter nr_free_highatomic
> protected by the zone lock, to avoid a search when calculating the
> usable free memory. And the cost would be minimal, i.e., simple
> arithmetics in the highatomic alloc/free/move paths.

Is a -stable backport needed?

If so, is a Fixes: target identifiable?



