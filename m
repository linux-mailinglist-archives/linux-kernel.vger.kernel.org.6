Return-Path: <linux-kernel+bounces-406578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BF9C60F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DEAF1F218BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7E2185B8;
	Tue, 12 Nov 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N07ZiG6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544D230994
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731438174; cv=none; b=FOJDX/NHAF7HuuTyZd3p8OT+fu1xo4/Yy/kYrT+2L7hQvZFkH9rRIapB78WwHXNGPAK0f+yyY3ihUC9QNv8NM4gkwzK0WANTymAV06mzfHk1Pk9od2Oy9gZf8sKPyz5bus3tbbMv09axCUxhTPC4AgN8rfBcv1i6BL9nqZst1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731438174; c=relaxed/simple;
	bh=bXQK6+F9U+3y68nQst8utZuX1+MTQHrxjDYqgLbuL7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVFEloGD6fu/iIfsjoFLyxhkv27Dfst0iYE3ZiZJPo+CbSwosITXpcnongjGB4wh1Vup0McMGLRwbzloyF9NavoPW4VbkNZ57XSY1d8DYpdqRk5sS5XFGwy0Vhc1wNcysJnCcv0HEeLMDzDvkYi7cIQV23PIKLeVMdHiYWrO8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N07ZiG6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65815C4CECD;
	Tue, 12 Nov 2024 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731438174;
	bh=bXQK6+F9U+3y68nQst8utZuX1+MTQHrxjDYqgLbuL7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N07ZiG6nj9Rpu1nLN/5IAmAcVxWUJYJ0rv3khYomgvONZT7kCdMFS3gd3zlos1A1m
	 VSiCUPrCAscYxwYZX+E5yZdtUEz69A3pTjzulNqDPlhNsfozkjqZWHFjmh0Zi57UH4
	 z2voXs5bfLVGVsG4eQIr6vBRKz7jvFaScIeXB9VliyhtwjtHvzFCTjUNB1RKA2+Qpw
	 dASbCYt9tegbygWniqp+r1hfcCUh6RJVn40rI+jgaGnPQupLoE4HvkCjgutBI4c1Ds
	 Xp57GmCF2KEGg53t+rXzpVK8gknWuKPc1aiDezTmmMxD5ZHrZ9uPfcmQUmjkse0n1H
	 2TyjVqPJwEM3A==
Date: Tue, 12 Nov 2024 09:02:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kernfs: Use RCU for kernfs_node::name lookup.
Message-ID: <ZzOmXbpO3apRH0Cz@slm.duckdns.org>
References: <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
 <20241108100503.H-__545n@linutronix.de>
 <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>
 <20241108222406.n5azgO98@linutronix.de>
 <Zy6ROmfQhUvYK9YK@slm.duckdns.org>
 <20241111170450.mUxDpLiW@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111170450.mUxDpLiW@linutronix.de>

Hello, Sebastian.

Sorry about late reply. Have been sick for a bit.

On Mon, Nov 11, 2024 at 06:04:50PM +0100, Sebastian Andrzej Siewior wrote:
...
> Let me check if I understood. We have three users of kernfs:
> 
> - cgroup
>   cgroup1_rename(): parent check (would get the new KERNFS_ROOT flag)
> 
> - resctrl
>   rdtgroup_rename(): seems to allow any "mon group" directory
>   different parent possible.
> 
> - sysfs
>   sysfs_move_dir_ns(): reame to a different parent

I'm not sure about resctrl but here we just need to add that flag to cgroup,
right?

> That new RCU interface would be used by cgroup only and sysfs/ resctrl
> would remain using the "old" code?
> If so, would you  prefer 
> |struct kernfs_node {
> |	…
> |	union {
> |		const char              name;
> |		const char              __rcu *name_rcu;
> |	}
> 
> to avoid patching resctrl + sysfs for for the rcu_derference name
> lookup?

As replied on the patches, it probably is cleaner to always use __rcu and
apply the additional locking on the reader side if renaming across different
parents is allowed.

Thanks.

-- 
tejun

