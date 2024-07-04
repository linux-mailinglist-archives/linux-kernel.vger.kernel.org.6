Return-Path: <linux-kernel+bounces-241288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5209927965
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0258D1C21F72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0541B1400;
	Thu,  4 Jul 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aingwe3S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FF91A0721
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105129; cv=none; b=qn9LPzZfZwxblKSJXevOA81l8Txlvjh605yyz221feKWpqir8a4Dcb5qv58cVXXRd+3uF+aTtXhvUNsPN8EoMpzWtU5dNS+D0GVMpqbGk7xkEjEDjG4sor7CMOFV/zoDueEKt/HoopvZIiQ7WchwC1ad0zlSpPhXd7dlRdBfHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105129; c=relaxed/simple;
	bh=ShJwbW3WR/RLZ5Lf9ChwJdrMelDZwDBgn186WpNaogM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCtPOPF8x4J+XjaaR8CXngzrtGyDIJyU3l0noCF5vxQwMkbbpnCib9taZNmIx7sGS1OlhKhlL4m/dVNCRm870ehTgrDJm/ZfwATL25jdgdt5EWRh709GK2AmiXLR+FLoLnQoP4CisKitXad2htESrx4i1CHZGMj6IvvWbJi7kvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aingwe3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8ECC3277B;
	Thu,  4 Jul 2024 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720105129;
	bh=ShJwbW3WR/RLZ5Lf9ChwJdrMelDZwDBgn186WpNaogM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Aingwe3S+0NOyj/n+uzSZ9xFVXWfWKlGl7DQZIR/7qHkZiAQLe+T4vyhQiqq3W5wk
	 4rFU/q5WGg/kDWBsDMzVC84HOlKXBxUU4HXwIKC+yzA0q2xhZdesqIzPoIwId7Rcqn
	 +sCafHz5T1fR32kB4yq85oxFnDiUK8X/HzKrtZAM=
Date: Thu, 4 Jul 2024 16:58:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com,
	Linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, luisbg@kernel.org,
	salah.triki@gmail.com,
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
Message-ID: <2024070419-calamity-blade-02fb@gregkh>
References: <2023082746-antelope-drop-down-5562@gregkh>
 <20240704135057.1174408-1-dvyukov@google.com>
 <2024070416-hatbox-playlist-9886@gregkh>
 <CACT4Y+arKNML2gLvmXzqdfyJY5ydj0yjfk-NbrZpOLgTOTNH6A@mail.gmail.com>
 <2024070430-smell-cornhusk-1d6c@gregkh>
 <CACT4Y+az44BGCQ_DjOoCjfcQHEt6YEPi=pksFCRj=-zMrPwSQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+az44BGCQ_DjOoCjfcQHEt6YEPi=pksFCRj=-zMrPwSQQ@mail.gmail.com>

On Thu, Jul 04, 2024 at 04:13:52PM +0200, Dmitry Vyukov wrote:
> On Thu, 4 Jul 2024 at 16:11, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > On Thu, Jul 04, 2024 at 03:50:57PM +0200, Dmitry Vyukov wrote:
> > > > > Hi,
> > > > >
> > > > > What's the kernel policy for such cases?
> > > >
> > > > What "case"?
> > > >
> > > > There is no context here at all, and I can't find any patch on lore at
> > > > all.
> > > >
> > > > Please always properly quote stuff...
> > >
> > > It's not easy with kernel lists. I used the lore suggested reply-to
> > > command. Here is full thread:
> > > https://lore.kernel.org/all/20240704135057.1174408-1-dvyukov@google.com/
> >
> > I see no patch on lore on this thread :(
> 
> Oh, it wasn't properly threaded, sorry.
> Here is the patch:
> https://lore.kernel.org/all/20230801155823.206985-1-ghandatmanas@gmail.com/

Ah, ok, resend it and cc: the vfs maintainer, it should probably go
through their tree for other abandoned filesystems.

thanks,

greg k-h

