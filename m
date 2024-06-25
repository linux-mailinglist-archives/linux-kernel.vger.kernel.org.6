Return-Path: <linux-kernel+bounces-228098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6110915AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7A91F22240
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137845BE3;
	Tue, 25 Jun 2024 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaBl1qe9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E467C152
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273624; cv=none; b=KTlWgiKxFvWDxecPrYZBaKlUhlPJnZJIygQ/RmAG/Anc7UIy2JSCoPFrNXj281vfxSkz75R/slpedKgyrC/hFkMJFsQlsdUwM4gQJXLIFFghWjj12/oOl30Fbbct05T6KJV1kYRh0p68xSTcKi4GBR90tjTohijXnmCb5xZAT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273624; c=relaxed/simple;
	bh=4OGcOyY6mudiQPcCYZvpLulrxeK2TlvhfZKf6QT3kH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEbpzDpxRseb1yvmpZDtGABlzXAGa9/MPLGG/N5f/4P+E6igiyDaTl0qtCu3V/X0UBmqE1rRk4KTDhZFkZSw8neyHhw+WDgNXisR0Z3MUYDlniOMDfdoqpH5o5vdjrZmW5y9B3ZVewa0qSbkgYjo7lYMwnKxG3pYyPu3QChNmHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaBl1qe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDE7C2BBFC;
	Tue, 25 Jun 2024 00:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719273623;
	bh=4OGcOyY6mudiQPcCYZvpLulrxeK2TlvhfZKf6QT3kH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaBl1qe9odfJ+kK0MGeYW5ZtFtTDUjM60X7rSUOIOZkf6IZIlDp01P4G6cydiOrhm
	 pMh3ncO+cMALyyAYijdU4mJR6zzk8Ko+Y5K1jLE64TK+u4zWQwAhSs+ZvFwu6uPvre
	 19qBKSZ7XcoxMltqDNfYo20Pa8fbhJ3au4rfTw4soIWZlimB0Z43zIKS9mo4+jc9+s
	 CGZqiSbxC0F2zeT/iY20fPmyFvYqrqBob4IsoIzoJOVxJr9hha14kNBCT1yTKTMn9f
	 KtN5E4cCN0eKhZXjDTQn4NdCgkHIP5CdY/ZZ4ca4tLFIUCmVr0m4uKVrkcxd7Ao9FI
	 a1bGE7LJEgoPQ==
Date: Tue, 25 Jun 2024 02:00:20 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 0/5] timer_migration: Fix two possible races and an
 improvement
Message-ID: <ZnoIlO22habOyQRe@lothringen>
References: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624-tmigr-fixes-v2-0-3eb4c0604790@linutronix.de>

On Mon, Jun 24, 2024 at 04:53:52PM +0200, Anna-Maria Behnsen wrote:
> Borislav reported a warning in timer migration deactive path
> 
>   https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local
> 
> Sadly it doesn't reproduce directly. But with the change of timing (by
> adding a trace prinkt before the warning), it is possible to trigger the
> warning reliable at least in my test setup. The problem here is a racy
> check agains group->parent pointer. This is also used in other places in
> the code and fixing this racy usage is adressed by the first patch.
> 
> There was another race reported by Frederic in setup path:
> 
>   https://lore.kernel.org/r/ZnWOswTMML6ShzYO@localhost.localdomain
> 
> It is addressed patch 2-4. Patch 2 is an already existing patch of v1
> (improve tracing) and makes the fix easier. Patch 3 is also a preparation
> patch for the final fix and Patch 4 is then the real fix. (I labelled all
> those three patches with Fixes tag to be easier selectable.)
> 
> While working with the code, I saw that the update of per cpu group wakeup
> value could be improved. This improvement is adressed by the last patch.

Another possible issue with the CPU up code is the fact that child->parent and
child->childmask updates and reads are unordered.

So it's possible that a CPU going (in-)active sees the new parent but doesn't
observe yet the update to child->childmask. This may result to calling
tmigr_(in-)active_up() with a zero data->childmask with all sorts of
consequences.

Or am I missing something that prevents from that?

Thanks.

