Return-Path: <linux-kernel+bounces-241178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8559277E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5952855F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490761AEFEE;
	Thu,  4 Jul 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l5hlhnUY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D61AEFD2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102304; cv=none; b=Gb90OBP1H+HOcUWgmuMbbLxiAcFCxsQ2eSxm251keXZMvJLnQjTLyhdKUoZdV8ObmkanEVBMINnVf9Gaj9/WXckyl5Zk9iDjkGEcpVYl59myPL/orZr8A3cIs0+Zo3mv4RKh2O3T3c0vaUpLWemIyuWrdlPky7xtQ5dxM515heY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102304; c=relaxed/simple;
	bh=XRhdpgAgJQksM+hc2XSPvPPm8ujHiKZ7UFJm+iVlieI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbcnRBtGzdaYmiVsuxSHsi6Rtpp3VO5vOCtsu1gNT0MrtPm1ypMFn7sHxzvxJscskUVmN3OM/XPo9YYYywhb7da0WPfKRJbhS8JkvZ8s8FhmRZaxW7+HCKGSudCvpxKJBskqwiN+ET0wPIcOVYzpEROt+U9H/s2rnqFc9B6dc+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l5hlhnUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A79BC4AF0A;
	Thu,  4 Jul 2024 14:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720102304;
	bh=XRhdpgAgJQksM+hc2XSPvPPm8ujHiKZ7UFJm+iVlieI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5hlhnUYn9Y4JyZ+q8JUvXmtll3REWvSFFkRAoFD0YZP7c+vynGmtPcpJg6njkKbB
	 ubKgteGytW0Gpj2ppYpvfrSwU9FHnlhBcKai/48YfORtKQMU0OHVWSkcHkBDj3Q5v/
	 3myNGJYmMoUF65ty2diScWuauKaGrztLdhk9o48I=
Date: Thu, 4 Jul 2024 16:11:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: 88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com,
	Linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, luisbg@kernel.org,
	salah.triki@gmail.com,
	syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs/befs: fix shift-out-of-bounds in befs_check_sb
Message-ID: <2024070430-smell-cornhusk-1d6c@gregkh>
References: <2023082746-antelope-drop-down-5562@gregkh>
 <20240704135057.1174408-1-dvyukov@google.com>
 <2024070416-hatbox-playlist-9886@gregkh>
 <CACT4Y+arKNML2gLvmXzqdfyJY5ydj0yjfk-NbrZpOLgTOTNH6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+arKNML2gLvmXzqdfyJY5ydj0yjfk-NbrZpOLgTOTNH6A@mail.gmail.com>

On Thu, Jul 04, 2024 at 04:08:40PM +0200, Dmitry Vyukov wrote:
> On Thu, 4 Jul 2024 at 16:04, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 04, 2024 at 03:50:57PM +0200, Dmitry Vyukov wrote:
> > > Hi,
> > >
> > > What's the kernel policy for such cases?
> >
> > What "case"?
> >
> > There is no context here at all, and I can't find any patch on lore at
> > all.
> >
> > Please always properly quote stuff...
> 
> It's not easy with kernel lists. I used the lore suggested reply-to
> command. Here is full thread:
> https://lore.kernel.org/all/20240704135057.1174408-1-dvyukov@google.com/

I see no patch on lore on this thread :(

