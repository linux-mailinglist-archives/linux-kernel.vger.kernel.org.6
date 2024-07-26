Return-Path: <linux-kernel+bounces-263077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C1593D0A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C21F2200D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53AF176AB8;
	Fri, 26 Jul 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R53dOJVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B214F122;
	Fri, 26 Jul 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721987668; cv=none; b=IbUsbmqybB+KH8iL+WeSuGc9U/Btgf2LEEArAIRH3BZgTgw3TDBaTI/3DLIFRG+sVkaTHbcnqFKclnZ44VAgs1VNPOqs7N1LAR98tZYfIU9fcH+b+gB2nPKUUv3swlrJ9l5azQFSk+NGs30ECvh+idhysKCjIF7Y2HJoPobqhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721987668; c=relaxed/simple;
	bh=cvsanhfs1FsZIe9NYPjX15kOQzhPwoX0O9Rx2P3pw0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHrQrL5PeL3BZI1YCFm0Is9EsO5MpZHujEcCudJVYRtJk5n7J+ANDL3twzziK1McjLskhpuN2K+YBEN9EH4KQvXwsBIfs7JR1CX7nkTzCfy3cm8SC7A7pAYCIlMHWkyEOK/0i+JUqn+fILZps8cFYkry8HrAY+7uSL3pWdW0Nyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R53dOJVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EE0C32782;
	Fri, 26 Jul 2024 09:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721987668;
	bh=cvsanhfs1FsZIe9NYPjX15kOQzhPwoX0O9Rx2P3pw0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R53dOJVwOKs5vDJUZFEAfi6KdN9fD/wFyJkI/HZpt/VJzLzK7K5ge47zYNNiTwgMs
	 cfkDjh4aNzV3r6oZi7fJGctrP143t4l/1sE7I9xHVOgmY1R/7PQUK5yfoZROg74pyL
	 7Jch4sWax5yBYvAic6R7KnqeMLqx/BMWi9igQlWw=
Date: Fri, 26 Jul 2024 11:54:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
Message-ID: <2024072606-outlet-stuffy-259b@gregkh>
References: <2024051912-CVE-2024-35918-3fed@gregkh>
 <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>

On Fri, Jul 26, 2024 at 11:45:59AM +0200, Michal Koutný wrote:
> Hello.
> 
> On Sun, May 19, 2024 at 12:11:12PM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > randomize_kstack: Improve entropy diffusion
> > 
> > The kstack_offset variable was really only ever using the low bits for
> > kernel stack offset entropy. Add a ror32() to increase bit diffusion.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-35918 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 5.15.155 with commit dfb2ce952143
> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.1.86 with commit e80b4980af26
> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.6.27 with commit 300a2b9c2b28
> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.8.6 with commit 6be74b1e21f8
> > 	Issue introduced in 5.13 with commit 39218ff4c625 and fixed in 6.9 with commit 9c573cd31343
> 
> The commit
> 9c573cd313433 ("randomize_kstack: Improve entropy diffusion") v6.9-rc4~35^2
> adds ~2 bits of entropy to stack offsets (+the diffusion, x86_64)
> 
> The commit
> 39218ff4c625d ("stack: Optionally randomize kernel stack offset each syscall") v5.13-rc1~184^2~3
> adds ~8 bit of entropy to stack offsets (there was none before, x86_64)
> 
> Why the former commit has a CVE while the latter doesn't? (2 < 8)
> 
> I'd expect both to be treated equally or even inversely.

If you wish for a CVE to be assigned to 39218ff4c625d, we will be glad
to do so, but it was not on our "old list" of GSD entries to backfill in
CVE entries for, which is why it was not assigned one.

thanks,

greg k-h

