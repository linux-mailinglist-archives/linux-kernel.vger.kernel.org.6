Return-Path: <linux-kernel+bounces-440571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FD9EC11D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8794E166F80
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC194879B;
	Wed, 11 Dec 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aSxA4BCz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648D68489
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878497; cv=none; b=n69WOJ6ktysfQPqhLS/CQn4aIme5dIVButek9jUiLKjf0tRjVauv7/bmwpNQtRKnlJbAVPFFwU5buUqadmffs4OE3rjerubfCSg/Iui+o/iH/T/yahXYVQvQWce6HX2VFj5cxF1/BMxFaqxzVY+jZpKvhrF54LgC1MrQmRQJhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878497; c=relaxed/simple;
	bh=hD6BkfZzStkQWQOnRqIyr4GC4JGfDepS3IhvOhf7AHI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=isU+lqqliRvNMNRxsiNRWotMBsNLh0hS4oC/Ep5djloCde3PP/9X4qFFOHsVeymB35NVhOAgdXv2ZZGCrPldJ6wnzeYz2ns/98UTNh1l3BlOqMbOtJydOIyWeHO2Vx5OQabVtUZe/WHcpmit1FdKsH9HHxlsiqgK7s5ezgSFpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aSxA4BCz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF626C4CED6;
	Wed, 11 Dec 2024 00:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733878496;
	bh=hD6BkfZzStkQWQOnRqIyr4GC4JGfDepS3IhvOhf7AHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aSxA4BCzaHXqBwkHgitdqMq6kUzybOGcJCTukTL84ar7n7XZi6tKZGeiTPs8hlYxJ
	 +gIXeAtwbKETRuJpxk9OrvKJvMBHixcDc7LpzkNFtncLj+GPPffO88RI4tqDsd3joq
	 j+47ZDas5B1mNkNptIjEYGLmgBvVoSyej+1wjxUk=
Date: Tue, 10 Dec 2024 16:54:56 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] zram: cond_resched() in writeback loop
Message-Id: <20241210165456.288ed82b8a66a08ac36a4d15@linux-foundation.org>
In-Reply-To: <20241210105420.1888790-2-senozhatsky@chromium.org>
References: <20241210105420.1888790-1-senozhatsky@chromium.org>
	<20241210105420.1888790-2-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 19:53:55 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Writeback loop can run for quite a while (depending on
> wb device performance, compression algorithm and the
> number of entries we writeback), so we need to do
> cond_resched() there, similarly to what we do in
> recompress loop.
> 
> ...
>
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -889,6 +889,8 @@ static ssize_t writeback_store(struct device *dev,
>  next:
>  		zram_slot_unlock(zram, index);
>  		release_pp_slot(zram, pps);
> +
> +		cond_resched();
>  	}
>  
>  	if (blk_idx)

Should this be treated as a hotfix?  With a -stable backport?

If so, we'd need to explain our reasoning in the changelog.  "Fixes a
watchdog lockup splat when running <workload>".  And a Fixes: would be
nice if appropriate.

