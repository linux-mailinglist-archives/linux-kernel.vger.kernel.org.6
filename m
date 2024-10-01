Return-Path: <linux-kernel+bounces-346722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B3498C7F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE64428622B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EBC1C3314;
	Tue,  1 Oct 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AC+YzHU8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2495199FCE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727820279; cv=none; b=XAeevHCbSk7HhIgiJOR7cz8kHWR+oIX7GsJ3aujbXBJrAnX/wLAE7se++Ucs5iD0tZBRf+v4IBEV3lo2iPqZcn1g809JOhuWE1ZyIUo4QILo+5oCA/vxIiUWPIj4nFsrr3f3JJijsmSpdhVZhSdxhjkZb/ToCCf0GUA7ayTg7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727820279; c=relaxed/simple;
	bh=A+MVeG5VL58i8Luj1L2tLWQOv70M3mGJmVOJtGoKQJY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ej4WtyTIr6HRvAkGOn+JWbThoU2kT/sc8FaNpnQiVr4uaRjEP65pnkPIa4JREup8EMUsewNrd8xGh3O+cMJYmXyyNVeU7dCCoPATxFCUZiwHor1CQ6W3az3oN5h0NAItH0iZuhFxRhOXqawWukbj4Gtz8bQdi9JEazKgLjPCKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AC+YzHU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1263C4CEC6;
	Tue,  1 Oct 2024 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727820279;
	bh=A+MVeG5VL58i8Luj1L2tLWQOv70M3mGJmVOJtGoKQJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AC+YzHU8leL8i+EYVMpSqsmzKiAwgAUWMET8Zqi8/r/s8NWsptyd0RLJpkHu/dkeg
	 yE5o/jIS3/0wrBOJqH8nAI31EIgqyKG/Buryxe6dxC8NZ6ldLsBi50O/YR1m6wLYrZ
	 jkL5JMORWiTOkihdNedepP5CwwgakNGzN1jONoiU=
Date: Tue, 1 Oct 2024 15:04:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Patrick Roy <roypat@amazon.co.uk>
Cc: <rppt@kernel.org>, <david@redhat.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <graf@amazon.com>, <jgowans@amazon.com>
Subject: Re: [PATCH] secretmem: disable memfd_secret() if arch cannot set
 direct map
Message-Id: <20241001150438.017b7bb4cd1baceb53a764bf@linux-foundation.org>
In-Reply-To: <20241001080056.784735-1-roypat@amazon.co.uk>
References: <20241001080056.784735-1-roypat@amazon.co.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 09:00:41 +0100 Patrick Roy <roypat@amazon.co.uk> wrote:

> Return -ENOSYS from memfd_secret() syscall if !can_set_direct_map().
> This is the case for example on some arm64 configurations, where marking
> 4k PTEs in the direct map not present can only be done if the direct map
> is set up at 4k granularity in the first place (as ARM's
> break-before-make semantics do not easily allow breaking apart
> large/gigantic pages).
> 
> More precisely, on arm64 systems with !can_set_direct_map(),
> set_direct_map_invalid_noflush() is a no-op, however it returns success
> (0) instead of an error. This means that memfd_secret will seemingly
> "work" (e.g. syscall succeeds, you can mmap the fd and fault in pages),
> but it does not actually achieve its goal of removing its memory from
> the direct map.
> 
> Note that with this patch, memfd_secret() will start erroring on systems
> where can_set_direct_map() returns false (arm64 with
> CONFIG_RODATA_FULL_DEFAULT_ENABLED=n, CONFIG_DEBUG_PAGEALLOC=n and
> CONFIG_KFENCE=n), but that still seems better than the current silent
> failure. Since CONFIG_RODATA_FULL_DEFAULT_ENABLED defaults to 'y', most
> arm64 systems actually have a working memfd_secret() and aren't be
> affected.
> 
> >From going through the iterations of the original memfd_secret patch
> series, it seems that disabling the syscall in these scenarios was the
> intended behavior [1] (preferred over having
> set_direct_map_invalid_noflush return an error as that would result in
> SIGBUSes at page-fault time), however the check for it got dropped
> between v16 [2] and v17 [3], when secretmem moved away from CMA
> allocations.
> 
> [1]: https://lore.kernel.org/lkml/20201124164930.GK8537@kernel.org/
> [2]: https://lore.kernel.org/lkml/20210121122723.3446-11-rppt@kernel.org/#t
> [3]: https://lore.kernel.org/lkml/20201125092208.12544-10-rppt@kernel.org/

Thanks.

> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")

So I'm thinking this fix should be backported into kernels which
contain 1507f51255c9, agree?


