Return-Path: <linux-kernel+bounces-440057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14A9EB81E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF9E1668C8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038423ED4D;
	Tue, 10 Dec 2024 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="hahVgA0T"
Received: from mxout6.mail.janestreet.com (mxout6.mail.janestreet.com [64.215.233.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874B623ED40
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851067; cv=none; b=s9Yajmyw9qpUnCZaufQbkg6zIcJ7WEPTtLuONBnZd015Nwy4+LFmihbLpMTuVl+vxzA+kO0t/WIozjJ9j1APTwoVqU2JMjKFzJBkXFGq2LkbP8P5VMXi8gJyI9ysWZM+EQd1kxQD4Ma2b43LtugtYjr1ZkNTkYjcfg/uuuC2HGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851067; c=relaxed/simple;
	bh=3oFTMiR1Jda2131qBxt33N+IF3sGk7jD/jaRHajpzFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On+K0a9AJ+phdCAe5iOy3FrVv8RvzN9dliJ2cqMcTfndyBX19i4yKAnj6C+61PBPyjWmteGTOi0hxCxd++3fULo9kB7yUBIzcB5MihimccTduJeKuVdQhAexpYjaEpFcctuS1zrRdfsOiUe2aFV8e7/lWZgticyEcdogQGJPYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=hahVgA0T; arc=none smtp.client-ip=64.215.233.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Tue, 10 Dec 2024 12:12:30 -0500
From: Nikhil Jha <njha@janestreet.com>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: propagate fileid changed errors back to syscall
Message-ID: <20241210A1712306692debd.njha@janestreet.com>
References: <Z1cra8/5H5HvJ5Sw@igm-qws-u22929a.delacy.com>
  <C71642EC-B9F9-4A7D-AD11-D169268460FE@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C71642EC-B9F9-4A7D-AD11-D169268460FE@redhat.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1733850750;
  bh=rWqs/6mT7CMgk2PnjqVe5Pu7979o27uZXxcsQ9TbmfY=;
  h=Date:From:To:Cc:Subject:References:In-Reply-To;
  b=hahVgA0TrQ+62p05KfdC/jd5zXie3T9hy1yJHBjfeG0PO0RnPvHd04QE4vUzcT31V
  vWDwPV4pcpMySOE+8yczSKT29W8teOxqI/SYqde5NyC4tHLK8VtUx2NU+7FMgRDkFD
  IbdDmGOU/ZLgwyWpVusbTiUqr+tvhOnegejJmsXMqtXWd8kN0SCSHISFSRttaWczx7
  CQMOJiWM2dopeniXvFu4e7p+kcLXtqxUwod/ElHTImUQqJiRPWCt9C10MNznKZi9PA
  djhtVylxiEpKTi0Z/9MrSocH86eRWChNJf2uC6RWaFPp1aOnbQCSfT56fStVZQpnOc
  R6yyxLz+QaVdg==

On Tue, Dec 10, 2024 at 07:11:43AM -0500, Benjamin Coddington wrote:
> On 9 Dec 2024, at 12:39, Nikhil Jha wrote:
> 
> > Hello! This is the first kernel patch I have tried to upstream. I'm
> > following along with the kernel newbies guide but apologies if I got
> > anything wrong.
> >
> > Currently, if there is a mismatch in the request and response fileids in
> > an NFS request, the kernel logs an error and attempts to return ESTALE.
> > However, this error is currently dropped before it makes it all the way
> > to userspace. This appears to be a mistake, since as far as I can tell
> > that ESTALE value is never consumed from anywhere.
> >
> > Callstack for async NFS write, at time of error:
> >
> >         nfs_update_inode <- returns -ESTALE
> >         nfs_refresh_inode_locked
> >         nfs_writeback_update_inode <- error is dropped here
> >         nfs3_write_done
> >         nfs_writeback_done
> >         nfs_pgio_result <- other errors are collected here
> >         rpc_exit_task
> >         __rpc_execute
> >         rpc_async_schedule
> >         process_one_work
> >         worker_thread
> >         kthread
> >         ret_from_fork
> >
> > We ran into this issue ourselves, and seeing the -ESTALE in the kernel
> > source code but not from userspace was surprising.
> >
> > I tested a rebased version of this patch on an el8 kernel (v6.1.114),
> > and it seems to correctly propagate this error.
> >
> >> 8------------------------------------------------------8<
> >
> > If an NFS server returns a response with a different file id to the
> > response, the kernel currently prints out an error and attempts to
> > return -ESTALE. However, this -ESTALE value is never surfaced anywhere.
> 
> Hi Nikhil Jha,
> 
> Will this cause us to return -ESTALE to the application even if the WRITE
> was successful?
> 
> Ben
> 

Hi Ben,

Hmm.. I'm not sure how to answer that question exactly. A fileid is only
mismatched between a request RPC and response RPC when something really
weird is going on (i.e. a bug in the NFS server), so it's hard to reason
about if a WRITE was successful or not.

The `return -ESTALE` was already in the kernel code, but this particular
codepath seems to have accidentally dropped that error.

Nikhil


