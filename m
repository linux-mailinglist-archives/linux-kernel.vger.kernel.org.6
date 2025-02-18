Return-Path: <linux-kernel+bounces-520229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E36A3A73E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D89188D627
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D0F17A308;
	Tue, 18 Feb 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBmWdgaT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617217A316
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906479; cv=none; b=t0eRT9PGi7E5TIv57W6P916iLCyplIWNhiYbfTFuJBymwXmn7dnO7Im6DGqcyMEVM4EkKDcUY/EjbXAaIcPnP4BWOSz7cvGfeN8eujyhryWs9YWtf+5bJX4Z/sUxkFWe0TIcrC5WtIMuXrfwuBXqHqT9t7uH3uBrqwETVs8lvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906479; c=relaxed/simple;
	bh=A3ESgJ41derz8AXMorRdi10dEEcFuyL3g1FcUWdqVV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibnXUTZU0B4YgSI63rF5L7xe1A4fBpt+o+wHE8Db8DULvNjRRTtB4FIwAkn1yEmiZOpAYu5Yz/KBwyQEtNMsPVv/Ljurx6MySi2bw3ce6ExauOsWPiAdQ6eI33zNR4dwpCu6nigmUiWG9BhuzYD+O707ECGjpk2Pb58XPi/WxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBmWdgaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3720AC4CEE4;
	Tue, 18 Feb 2025 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739906479;
	bh=A3ESgJ41derz8AXMorRdi10dEEcFuyL3g1FcUWdqVV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBmWdgaTXjJ0cUlvYWGHpasiUPDRR1+PuCQajh8r9iMaD6u8TR3v1DXEJ1n5a7fdi
	 tqrS/6WirPSsrN58EbJzgrze5ZuomngBdBCUAmCFYu6A53OgQL5s7IMtJ8iKtUWMZC
	 bkea2w9hef//n8nnEXlUpo3VHv7aGRWYu3eopz9aK8GVA+9BeE83Wt5BzkS5hu1TTT
	 pgLmXer9G9AaWsrdkJb7VfxOLXx4iuyYr6ab6EmJNoCB7GzIa4A9XuE6UiFnRlp0jb
	 GiYdzF7mUhf3OecJVPcFFcibzPkpb7VrJ6pQL0UNoLGWgvdk7wq52M7bcyMgdym9wO
	 xFWLPVTEXzryA==
Date: Tue, 18 Feb 2025 09:21:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernfs: Drop kernfs_rwsem while invoking
 lookup_positive_unlocked().
Message-ID: <Z7TdrqJPJh1efhld@slm.duckdns.org>
References: <67b45276.050a0220.173698.004f.GAE@google.com>
 <20250218163938.xmvjlJ0K@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218163938.xmvjlJ0K@linutronix.de>

On Tue, Feb 18, 2025 at 05:39:38PM +0100, Sebastian Andrzej Siewior wrote:
> syzbot reported two warnings:
> - kernfs_node::name was accessed outside of a RCU section so it created
>   warning. The kernfs_rwsem was held so it was okay but it wasn't seen.
> 
> - While kernfs_rwsem was held invoked lookup_positive_unlocked()->
>   kernfs_dop_revalidate() which acquired kernfs_rwsem.
> 
> kernfs_rwsem was both acquired as a read lock so it can be acquired
> twice. However if a writer acquires the lock after the first reader then
> neither the writer nor the second reader can obtain the lock so it
> deadlocks.
> 
> The reason for the lock is to ensure that kernfs_node::name remain
> stable during lookup_positive_unlocked()'s invocation. The function can
> not be invoked within a RCU section because it may sleep.
> 
> Make a temporary copy of the kernfs_node::name under the lock so
> GFP_KERNEL can be used and use this instead.
> 
> Reported-by: syzbot+ecccecbc636b455f9084@syzkaller.appspotmail.com
> Fixes: 5b2fabf7fe8f ("kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

