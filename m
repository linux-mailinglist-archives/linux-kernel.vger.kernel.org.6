Return-Path: <linux-kernel+bounces-380928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9799AF7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17E171F226AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862B18BC22;
	Fri, 25 Oct 2024 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="relfQjJB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27612B143
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825793; cv=none; b=CVoTMwm+Itrm80Df4subbZCPfCgKBaCZlp24JufgjK69PmhMbJo9q3jASWOINW+ihqDfw7Ahow2nyQIb50Snd9dzVGRjbbjMBMd9/WsS22ed9oUHuTeMb6apV29B1KLp54C5CGtRmYfCkwTy2c2UyQwioc5xHxsDdYgSMMrWkF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825793; c=relaxed/simple;
	bh=78MOb/n6AmPnRssZ7Xsrssss5fM16DEriOwkW25LgFo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aFflA7Fht7veiX/xNLtuIS19uEj96ONvcgUS2VFd3zPiqWqmeI2Zx0hf95yX3E/7suQxckCJ3545+KSi9w0oPvsqmWBed9WZXv6Hh+D+DccZhe8EHYfN+1sWRTcliwlbK9N46UkoK199l22u16ZjirPr/T77+C04A5yPqdOHKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=relfQjJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CABC4CEE3;
	Fri, 25 Oct 2024 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729825792;
	bh=78MOb/n6AmPnRssZ7Xsrssss5fM16DEriOwkW25LgFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=relfQjJBbUw117pHZiwsJhbi46fGVEbgEdlbtkGb0UdrJhIr6RnGy8Dv0nka43HPj
	 kHZT893yU2frOe07ofRN3YyrJ5LKHYPulUCj3TRZKPh6BGQEBf8NnNDVUHvfUxgRKo
	 qlkT+f6Lh358kS4edvialDyVrsyGn1T3DkrlG7AVtEgbo1rDlIDyY2WTznEwkQLim7
	 x5DA5ZYuOof9IoVpuVxJB64WNnW3flPkdLJ4bP3mRAcavPLGB8prN+/Nu7NK9JKC1M
	 Si0Snyo0tvD+5lzMLUheKJbsi2GeeXCy2VObXBcOZhcpGNRleNmkiq5M2uBXhJ6JCk
	 FrA/xpnnItw8Q==
Date: Fri, 25 Oct 2024 12:09:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Leo Yan <leo.yan@arm.com>, Mikel Rychliski <mikel@mikelr.com>, Viktor
 Malik <vmalik@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] probes: Fixes for v6.12-rc4-2
Message-Id: <20241025120948.916e8c099fee7200e32ae617@kernel.org>
In-Reply-To: <CAHk-=whO+vSH+XVRio8byJU8idAWES0SPGVZ7KAVdc4qrV0VUA@mail.gmail.com>
References: <20241023233600.d309ab5fa8421e97d041bbc0@kernel.org>
	<CAHk-=whO+vSH+XVRio8byJU8idAWES0SPGVZ7KAVdc4qrV0VUA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 14:05:08 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 23 Oct 2024 at 07:36, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > - objpool: Fix choosing allocation for percpu slots
> >
> >   Fixes to allocate objpool's percpu slots correctly according to the
> >   GFP flag. It checks whether "any bit" in GFP_ATOMIC is set to choose
> >   the vmalloc source, but it should check "all bits" in GFP_ATOMIC flag
> >   is set, because GFP_ATOMIC is a combined flag.
> 
> So the old code was buggy, but I don't think the new code is wonderful either.

Agreed.

> 
> For example, it does not recognized GFP_NOWAIT, which has very similar
> characteristics to GFP_ATOMIC (it's basically the same thing as
> GFP_ATOMIC, but without the "try to allocate urgently", and with an
> added "don't warn on failure" as a result).
> 
> So what I think that code *should* test for is "can I sleep".
> 
> Which is indicated by __GFP_IO or __GFP_FS (and, I guess also
> __GFP_DIRECT_RECLAIM).

This code is for switching __vmalloc_node() to kmalloc_node() based on
GFP_ATOMIC, because __vmalloc_node() does not support GFP_ATOMIC.

---
/**
 * __vmalloc_node_range - allocate virtually contiguous memory
...
 *
 * Allocate enough pages to cover @size from the page level
 * allocator with @gfp_mask flags. Please note that the full set of gfp
 * flags are not supported. GFP_KERNEL, GFP_NOFS and GFP_NOIO are all
 * supported.
---

(BTW, the above kerneldoc is a bit outdated, because the function name
has been changed to `__vmalloc_node_range_noprof()`)

As above said, it supports GFP_KENEL & GFP_NOFS & GFP_NOIO, which
means __GFP_RECLAIM (= ___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM) is
required.

Since GFP_ATOMIC is __GFP_HIGH | __GFP_KSWAPD_RECLAIM, the difference
is ___GFP_DIRECT_RECLAIM is not set if GFP_ATOMIC is specified.

But I don't want to touch such bitflags deeper. What about simply
masking with GFP_ATOMIC | GFP_KERNEL? I mean

if ((gfp & (GFP_ATOMIC | GFP_KERNEL)) == GFP_ATOMIC)
	/* use kmalloc_node() because vmalloc does not support GFP_ATOMIC */
	slot = kmalloc_node(...)
else
	slot = __vmalloc_node(...)

Or, simply failback to kmalloc_node() if __vmalloc_node() fails.
(I think this is more robust.)

slot = __vmalloc_node(...)
if (!slot)
	slot = kmalloc_node(...)

(Note that slot is freed by kvfree() so either works)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

