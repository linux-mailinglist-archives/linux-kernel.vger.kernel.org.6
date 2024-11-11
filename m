Return-Path: <linux-kernel+bounces-404392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 559269C4332
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F5FB22173
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269AA1A3A80;
	Mon, 11 Nov 2024 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eVRL0dlP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1oudpA56"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7C12AF1C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731344695; cv=none; b=KgBst2NBN4ARAdQsBTqXGhLWnABKwrhnkvscGdKLzI/ciAdo6uq1ELw7F6+m4R4E77nBg/4lg9YmRttY7aX5l2p7nfiOUUM1nZ14aVMJF6ftgVmPmtadrf8fTYcVctdtX9mNpvLnAsqHMhCo+iG0UtzOVtoB0IVaNi4jWsO/WRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731344695; c=relaxed/simple;
	bh=/cQSO12xjoXZeCu3GfeRSnSVBAnVS5PQ4CLchFp837o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxKGD8ISH/6/XJjioftF2FQJ/ooSEePnJ9+utOuSxToxyv7BhR9nzC5JwolFrzyPAuUsLLtMxdJC904wz5h6JjDMorWwYU7R/NHrZ8M1hXceNisjYzr23dxLXJ/TyaN1xdmHIabf6lGyMTAmj0P2yw5N2SV05UwSZCyGKMdRz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eVRL0dlP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1oudpA56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 18:04:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731344691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebwGfJO17+1+k7VTbKQrJt2zHv2/RjHTI4fHgxadG3k=;
	b=eVRL0dlPa8p/yztz6h7G5ujB3HP/E2dsGjabQIg9mmpIq7aMjebm4LEowpjz0SWFkoSYmE
	JWEvjgaGUOS0PrnHX+l03g3TVmTw5hzdKA6ifPygLPcWoePvuOUtnusMJwcF2/IAf+cgty
	p3fw4H91d2CYB0nNRCLZjgxd9/1/grAgL4EvJ1rmFAgPrQHcCueZYFoEm/T/v5ciyq5aCQ
	ZbFZrcL6lf+IHIT/0zgZWrqkY1GHbtOi7XTLy/XTi6WH7VAs+jcKuHPF4X8SSqhe3ZpkVx
	LTGhDfE/uuZQELBK7gM7i0frGPTIxuTZY7Lz8s+aiaL02/wWi9AkRrZPT1Hmxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731344691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ebwGfJO17+1+k7VTbKQrJt2zHv2/RjHTI4fHgxadG3k=;
	b=1oudpA56vIGLxv0+UdZtEXTUjii/bpmnxK5aigAjLUzaKpz9zK9k9VGTzOp0TEPP3t4F7J
	CCajMsZqS7Yn9+AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de,
	syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kernfs: Use RCU for kernfs_node::name lookup.
Message-ID: <20241111170450.mUxDpLiW@linutronix.de>
References: <e06d69c9-f067-45c6-b604-fd340c3bd612@suse.cz>
 <ZyK0YPgtWExT4deh@elver.google.com>
 <66a745bb-d381-471c-aeee-3800a504f87d@paulmck-laptop>
 <20241102001224.2789-1-hdanton@sina.com>
 <ZyV2DfuIPsISds-1@Boquns-Mac-mini.local>
 <ZykNhbMOrlgCXFYJ@slm.duckdns.org>
 <20241108100503.H-__545n@linutronix.de>
 <Zy5EIHUwoXjK1sAJ@slm.duckdns.org>
 <20241108222406.n5azgO98@linutronix.de>
 <Zy6ROmfQhUvYK9YK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zy6ROmfQhUvYK9YK@slm.duckdns.org>

On 2024-11-08 12:31:22 [-1000], Tejun Heo wrote:
> Hello, Sebastian.
Hi Tejun,

> On Fri, Nov 08, 2024 at 11:24:06PM +0100, Sebastian Andrzej Siewior wrote:
> > Instead of using kernfs_rename_lock for lookups of ::name use RCU for
> > lookup. Rely on kn's kernfs_root::kernfs_rwsem for update
> > synchronisation.
> >=20
> > The .*_locked() have been moved into the callers.
> > The lock in kernfs_get_parent() has been dropped, the parent node should
> > node vanish underneath us. The RCU read-lock and atomic_inc_not_zero()
> > is a safety net in case it does.
> > kernfs_fop_readdir() no longer drops kernfs_root::kernfs_rwsem to ensure
> > the name pointer does not vanish while the page fault is handled.
> > kernfs_notify_workfn() gained the lock for the same reason.
>=20
> I owe an apology. I was just thinking about cgroups. Sysfs, I think, does

no worries.

> allow moving node a different parent, which IIRC is used by netdevs. How
> about something like this:
>=20
> - Add a KERNFS_ROOT flag indicating that parent-changing moves aren't
>   allowed.
>=20
> - Update kernfs_rename_ns() to trigger warning and fail if the above flag=
 is
>   set and new_parent is different from the old one.
>=20
> - Create a separate interface which uses RCU instead of rename lock for n=
ame
>   / path lookups. The RCU ones should trigger warning if used when the ab=
ove
>   KERNFS_ROOT flag is not set.

Let me check if I understood. We have three users of kernfs:

- cgroup
  cgroup1_rename(): parent check (would get the new KERNFS_ROOT flag)

- resctrl
  rdtgroup_rename(): seems to allow any "mon group" directory
  different parent possible.

- sysfs
  sysfs_move_dir_ns(): reame to a different parent

That new RCU interface would be used by cgroup only and sysfs/ resctrl
would remain using the "old" code?
If so, would you  prefer=20
|struct kernfs_node {
|	=E2=80=A6
|	union {
|		const char              name;
|		const char              __rcu *name_rcu;
|	}

to avoid patching resctrl + sysfs for for the rcu_derference name
lookup?

> Thanks.

Sebastian

