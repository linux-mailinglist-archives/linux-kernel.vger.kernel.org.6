Return-Path: <linux-kernel+bounces-402446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE0A9C2798
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B79761F22C28
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0761E1051;
	Fri,  8 Nov 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5s5opDr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468DA233D89
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105084; cv=none; b=dljHK5UAPpCg/dlcZEsMFT4jjjSlg1zok+xEX1SpQo4fefKK7DF5ROBGK9LWMoAzTtbGqrVIGFxQDLvjIcKpHRYrY4CAfseUus0DTOOBxQp/IJkFf3D8ejDTRgm0DEZNpSo2f7Ei+OkDidYs8y/2keQqBdeI2/6nwWgWrJvKC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105084; c=relaxed/simple;
	bh=Da8DYYERRzXjNkzkQmhNaPliCXZ9J4fE/GjPE9hxXXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ4OF9TKZiPG7I1YEtQA9g8uSzudqGJpbA//Pwp0vtz5NaXvBL7VeWjymqJopqnHWPyBDaM4DAEy2Up/XdB1tsnb+5cA5xKQg1OaKeLqtNaIaOl5Hbl6VjNrY31cxUzk7yQejPE1Jk3l4IdgA/XjmH26S/dkmk8Uk+QaRdntbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5s5opDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D16C4CECD;
	Fri,  8 Nov 2024 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731105083;
	bh=Da8DYYERRzXjNkzkQmhNaPliCXZ9J4fE/GjPE9hxXXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P5s5opDrtcTv30AsqXDXgFAlS7dBPQ3sMfBT9jheNEAoUbULklO1mJqnxI+4E9iC3
	 MwXfsKkGCxv4bbjr7pNeYpjrSj2mPsLl0JK24rnoRpMu0r+08sTK/AkP/i9VkbcjaR
	 /CsnHQ96dSUOrbWUZVRGq8pgGym7pY/5wpbdjqLdFMPf9mpFW30coXrBl+O19qcVlX
	 0uJSBnjUIhHlF0vpxoFbu/VcY8IVz7Aci6Rqz0N2pZ6AaMU4R9K4rwvT953mK4kfxr
	 aRmc8valIQWR7bRyzjG9N59U9SpRYyl+Fb2nPWp5w2GBNkL/0V0dx+N3hmuUrP2f72
	 1bXe7nTT5uwmQ==
Date: Fri, 8 Nov 2024 12:31:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kernfs: Use RCU for kernfs_node::name lookup.
Message-ID: <Zy6ROmfQhUvYK9YK@slm.duckdns.org>
References: <41619255-cdc2-4573-a360-7794fc3614f7@paulmck-laptop>
 <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
 <20241108100503.H-__545n@linutronix.de>
 <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>
 <20241108222406.n5azgO98@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108222406.n5azgO98@linutronix.de>

Hello, Sebastian.

On Fri, Nov 08, 2024 at 11:24:06PM +0100, Sebastian Andrzej Siewior wrote:
> Instead of using kernfs_rename_lock for lookups of ::name use RCU for
> lookup. Rely on kn's kernfs_root::kernfs_rwsem for update
> synchronisation.
> 
> The .*_locked() have been moved into the callers.
> The lock in kernfs_get_parent() has been dropped, the parent node should
> node vanish underneath us. The RCU read-lock and atomic_inc_not_zero()
> is a safety net in case it does.
> kernfs_fop_readdir() no longer drops kernfs_root::kernfs_rwsem to ensure
> the name pointer does not vanish while the page fault is handled.
> kernfs_notify_workfn() gained the lock for the same reason.

I owe an apology. I was just thinking about cgroups. Sysfs, I think, does
allow moving node a different parent, which IIRC is used by netdevs. How
about something like this:

- Add a KERNFS_ROOT flag indicating that parent-changing moves aren't
  allowed.

- Update kernfs_rename_ns() to trigger warning and fail if the above flag is
  set and new_parent is different from the old one.

- Create a separate interface which uses RCU instead of rename lock for name
  / path lookups. The RCU ones should trigger warning if used when the above
  KERNFS_ROOT flag is not set.

Thanks.

-- 
tejun

