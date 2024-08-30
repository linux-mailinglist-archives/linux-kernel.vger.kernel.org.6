Return-Path: <linux-kernel+bounces-308617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C07965F89
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207F61F2716A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D04418FDA6;
	Fri, 30 Aug 2024 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WHciq2a6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE518E37C;
	Fri, 30 Aug 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725014758; cv=none; b=ky20ziWFnrHCJpTW2f/+BfVxHVxTZ568Ip78PWaaXgLLH6t+Ie+tMj1TRc1wMbqdWek2T/eaLUQ6fNZ+xyrbmPAmj6MN4q8ouAh+8BzfpI8/VLDxdDu9H7yx32cib16+coWmqkexogYkMW1krk4bSL09sItCtePjFPiZEOl/QtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725014758; c=relaxed/simple;
	bh=8uHCl02cepHsyCMVPBlFTwCKoJ81X1qugU+PWocVpig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIm0Nk+nfcrFfK3UP07CLzTpTcpSbsjxJ0TJHCjezhP8oLLmrQHCCJxmBsP7ipvKUqTiFCiJWFsutMLr3aovj52cahrk6+2o66ybKW/INYouE8MrX4ixG0Y1AKNMNLPiNpJU+NmvVy5CNMwpikruVgEa7Vugvy77aJlkgV4ekTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WHciq2a6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE345C4CEC4;
	Fri, 30 Aug 2024 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725014758;
	bh=8uHCl02cepHsyCMVPBlFTwCKoJ81X1qugU+PWocVpig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHciq2a6bFmNLrKS1oa5ww6xN1hlpl1fvlmsVl6/N+Hv780/NuSTKbmFpGiaDdJtV
	 U+rgqbEJuDg0rqIU7cxrEGQ7KVW+L2b+uAivkNDY3d0N6rYnmOFHoWZR1uzRhOJPTp
	 Bp/5EvZGM8UtBpt89PKXxwui0dMlH4zn4vIZOUNo=
Date: Fri, 30 Aug 2024 12:45:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xia Fukun <xiafukun@huawei.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	"Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>,
	"Chenhui (Judy)" <judy.chenhui@huawei.com>
Subject: Re: CVE-2022-48921: sched/fair: Fix fault in reweight_entity
Message-ID: <2024083045-slinky-chatty-d1fa@gregkh>
References: <2024082218-CVE-2022-48921-5016@gregkh>
 <c0aa1e66-8e85-6aa0-e933-d5b6e3a2e3e7@huawei.com>
 <2024082539-balancing-rematch-d61d@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024082539-balancing-rematch-d61d@gregkh>

On Sun, Aug 25, 2024 at 07:54:40AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 24, 2024 at 05:52:05PM +0800, Xia Fukun wrote:
> > 
> > On 2024/8/22 11:31, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > sched/fair: Fix fault in reweight_entity
> > > 
> > > Syzbot found a GPF in reweight_entity. This has been bisected to
> > > commit 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an invalid
> > > sched_task_group")
> > > 
> > > There is a race between sched_post_fork() and setpriority(PRIO_PGRP)
> > > within a thread group that causes a null-ptr-deref in
> > > reweight_entity() in CFS. The scenario is that the main process spawns
> > > number of new threads, which then call setpriority(PRIO_PGRP, 0, -20),
> > > wait, and exit.  For each of the new threads the copy_process() gets
> > > invoked, which adds the new task_struct and calls sched_post_fork()
> > > for it.
> > > 
> > > 
> > > The Linux kernel CVE team has assigned CVE-2022-48921 to this issue.
> > > 
> > 
> > Commit 13765de8148f ("sched/fair: Fix fault in reweight_entity")
> > is reverted by commit b1e8206582f9 ("sched: Fix yet more sched_fork()
> > races"). Since commit 13765de8148f only fixes a single instance
> > of this problem, not the whole class.
> > 
> > I think the CVE-2022-48921 needs to adjust the corresponding commit
> > to commit b1e8206582f9 ("sched: Fix yet more sched_fork() races").
> 
> I think we just need to assign a new CVE to b1e8206582f9, as that was
> not backported to everywhere that 13765de8148f was applied, right?
> Wouldn't that be the correct thing to do as it did fix things in a
> different way.

CVE-2022-48944 is now assigned for this, thanks.

greg k-h

