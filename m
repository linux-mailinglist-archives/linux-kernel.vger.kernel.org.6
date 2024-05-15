Return-Path: <linux-kernel+bounces-180297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC08C6C96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E134B23270
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A971591EC;
	Wed, 15 May 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="srPJpvhI"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666572F877
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715800040; cv=none; b=j3F7YQVzn5ee2hxcXmZ6GzXv5mj5DR2zF99QGXSGTPHQHETvow0OAGDwYU5nR9CMDQyLu40QzzrgCirRe3HQ5Qfr7Zd5YH+u3Nx9S9/B8EI45filc1iRgMbVPhpZyvxallrVHeQmG4NRQ3/KY1MneqGchZ0ZVuxiJBiOOnY3kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715800040; c=relaxed/simple;
	bh=tk5uTVYQT3weltjLan/BDNDkY5zDoxMl7K/36dn8IgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz7vGgIncxiW14LDXcKQb+xEu9csKsEoCwDyxcQkGd1aNCnfulHkXrF8RjMGPCz33rIAhMQmJa9bZMBz5NDr0/5KFbhH+iVXYyfRtErkLi/TTUAEIewsuB7FjIyHW6+jeVP2WHvoUII57DJjknTHr1Is6DAETtN3XgzBxb02PW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=srPJpvhI reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M/w6GkeQt/XaEdjcw8Y0xT97aSOW32pAvB+kDsbumAQ=; b=srPJpvhIbm9xQpNrAWPW+yaqXA
	6JLuykHwc+6wjMnv7aJiShhlTfbJ1VkxlkDJ4z2zY25ma/TOpO+akThdm3c49GeBEoPe/6XVdx6vI
	ie2qaW3rgj1jkDxv1SfE6ksTIds8zoTy0X5ZRHHBqlC4D8AT18XIqn6zkIIrdKqPjLfkQwlhPJi4P
	Bs8taJxWpf8txVf/IMB7pHSZ/duNwY7dAAzwcyCZ+wKei4mprNz51DnYPymCqcGFsozx8+ZiTFCO8
	V1/YFKrsDlufl+6NWcJQd/6i/sKvITAxvffHOgE1J+exnOgVUmcjEXe9RLr10j8CoVuyPge8eC2Td
	rRG6/S1g==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s7Jxz-007gXi-02;
	Wed, 15 May 2024 19:07:07 +0000
Date: Wed, 15 May 2024 12:07:03 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] configfs_{un,}register_group() semantics
Message-ID: <ZkUH1yMcJml9oeCJ@google.com>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
References: <20240512043012.GG2118490@ZenIV>
 <20240512043509.GH2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512043509.GH2118490@ZenIV>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Sun, May 12, 2024 at 05:35:09AM +0100, Al Viro wrote:
> [now with hopefully correct address of Daniel Baluta]
> 
> On Sun, May 12, 2024 at 05:30:12AM +0100, Al Viro wrote:
> > 	Folks, could you confirm if the following is correct?

Recovering state on the dynamic group code...

> > 
> > 1. configfs_unregister_group() callers are supposed to prevent
> > having it called when some items/groups had been created under it.
> > The original one (in iio) *does* prevent that (the call chains come
> > through the module_exit() of modules pinned by ->make_group() for
> > the added subdirectory), but I don't see that documented anywhere and
> > AFAICS at least in one case (drivers/pci/endpoint/pci-ep-cfs.c) that is
> > not guaranteed.  The same goes for symlinks created in or to those.

I would expect configfs_unregister_group() to fail if there are
items/groups created underneath it.  Specifically, in all of the
rmdir/unregister paths, configfs_detach_prep() is responsible for
verifying that the subtree only contains default/generated entitities.
Looking at the code, I notice that configfs_detach_prep() is called
from configfs_unregister_group() without checking the return code.
This means the prep can be left in a partial state (only some parts of
the subtree have CONFIGFS_USET_DROPPING still set), and
configfs_detach_rollback() is also not called to clean that up.

Naively, I'd prefer the operations correctly fail (-ENOTEMPTY if coming
from a user's rmdir(2) on a parent that the user had initially created,
BUG_ON for kernel coding errors).

> > 
> > 2. rmdir on directory added by configfs_register_group() is supposed to
> > fail (is it even supposed to be used inside the stuff created by mkdir?
> > Original use was inside a subsystem, AFAICS).

That is correct, rmdir(2) on directories created by the machinery is
supposed to fail.  It checks for CONFIGFS_USET_DEFAULT and returns
EPERM.  This should be working -- configfs_register_group() calls
create_default_group(), which sets CONFIGFS_USET_DEFAULT.

> > 
> > 3. rmdir that would've taken out the parent group is supposed to take
> > the added one out (again, are they even supposed to be used inside the
> > stuff created by mkdir?)

Yes, if the user does `mkdir pathA`, and the default/registered group
structure automatically builds pathA/{subpathB,subpathC}, then `rmdir
pathA`

> > 
> > 4. one is *NOT* supposed to use have ->make_group() schedule creation of
> > subdirectories via configfs_register_group(); configfs_add_default_group()
> > ought to be used instead.

I presume you mean configfs_register_default_group().  My general
thoughts would be to agree, that sub-groups should be configured via
registered default groups, not added in the caller's code, because that
allows configfs to control the lifecycle.

But in that case, I don't remember exactly why configfs_register_group()
is exported at all.  Daniel, what was the distinction between using
default groups vs creating them in the client code?

> > 
> > drivers/pci/endpoint/pci-ep-cfs.c:pci_epf_make() has this:
> >         INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
> >         queue_delayed_work(system_wq, &epf_group->cfs_work,
> >                            msecs_to_jiffies(1));
> > 
> >         return &epf_group->group;
> > 
> > with pci_epf_cfs_work() allocating several config_group and calling
> > configfs_register_group() to link those in.  I really doubt that this
> > kind of "let's hope that configfs_mkdir() will get through directory
> > creation in less than 1ms after ->make_group() returns" is the way it
> > is supposed to be done; at a guess, configfs_add_default_group()
> > should've been used (synchronously), but I might be missing something
> > subtle here.

The creation and linkage needs to happen under the locking and lifecycle
of the configfs tree.  I don't see how one could safely drop it on a
workqueue and not violate either code safety (doing it outside the
correct locks or CONFIGFS_USET_XXX state markers) or atomicity (a period
when userspace can see the parent group but not the child groups).

Even if we presume the client doing an explicit
create_group()+configfs_register_group() is the right method, rather
than registering a default group and letting that machinery do the
work, the client's operation needs to be completed under the make_grup()
call.  This would imply synchronously.

Thanks,
Joel

-- 

Life's Little Instruction Book #252

	"Take good care of those you love."

			http://www.jlbec.org/
			jlbec@evilplan.org

