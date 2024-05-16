Return-Path: <linux-kernel+bounces-181023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8868C7648
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7C71F2107B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F6A147C74;
	Thu, 16 May 2024 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="saxOtqU6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5B914B97D;
	Thu, 16 May 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862201; cv=none; b=mAjeNZLmWpZCaLYJ/W+GnZAuc8HYY4RLKXKkegGYUwV7qn/X71v5er851WY4BnV5w65vvZ6oMaffU98dJDEfCDmEZn8xNp9QyVVJ0sH3eRIKJx39ii9DHn14VRwJ67j1zNch26XrKye5gwVGGpXOVEewi42Pd71MwTtTD8D75gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862201; c=relaxed/simple;
	bh=7Rb1hI6Ib5ye2Hsj4bedBcii6mULZV87Rt3nDw/naJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n20XW9ifx+RaHtt9tceZNHqrtfha38nqkxVAAaXgMHVjnf4P/rV/dIjJWsmvWc/wfAixdyTJyTzaAFkPiybiz6VQEIVNKDxJGXeLrtclkEZcaXHNrvLTQNuip5epp+B9eCw0gsgf2I6XMVoxSHvPQvhblYzHtv5IX/7aYitv8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=saxOtqU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54FEC4AF08;
	Thu, 16 May 2024 12:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715862201;
	bh=7Rb1hI6Ib5ye2Hsj4bedBcii6mULZV87Rt3nDw/naJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=saxOtqU6dis0ueGCXBp3G5RiHCYia+kBa44UML18S7lbY/V99M7y/FLjGpPr9ncOX
	 iRVRNCsYK+zuesiTgcFuhxKkzWikhinRmZkqYxG+jep4zhCr8ZICpSSxZ8wD7DlzL1
	 mQPw6cG19xJbflbBUBWJAFBikgTbDZZJ+zSS64Gw=
Date: Thu, 16 May 2024 14:23:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Anthony Iliopoulos <ailiop@suse.com>, cve@kernel.org,
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26821: fs: relax mount_setattr() permission checks
Message-ID: <2024051606-imaging-entrench-b327@gregkh>
References: <2024041702-CVE-2024-26821-de6b@gregkh>
 <20240514124939.77984-1-ailiop@suse.com>
 <20240515-faken-gebohrt-b7c4731929fe@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515-faken-gebohrt-b7c4731929fe@brauner>

On Wed, May 15, 2024 at 06:58:38PM +0200, Christian Brauner wrote:
> On Tue, May 14, 2024 at 02:49:39PM +0200, Anthony Iliopoulos wrote:
> > On Wed, Apr 17, 2024 at 11:44:04AM +0200, Greg Kroah-Hartman wrote:
> > > Description
> > > ===========
> > > 
> > > In the Linux kernel, the following vulnerability has been resolved:
> > > 
> > > fs: relax mount_setattr() permission checks
> > > 
> > > When we added mount_setattr() I added additional checks compared to the
> > > legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
> > > mount(2). If that mount had a parent then verify that the caller and the
> > > mount namespace the mount is attached to match and if not make sure that
> > > it's an anonymous mount.
> > > 
> > > The real rootfs falls into neither category. It is neither an anoymous
> > > mount because it is obviously attached to the initial mount namespace
> > > but it also obviously doesn't have a parent mount. So that means legacy
> > > mount(2) allows changing mount properties on the real rootfs but
> > > mount_setattr(2) blocks this. I never thought much about this but of
> > > course someone on this planet of earth changes properties on the real
> > > rootfs as can be seen in [1].
> > > 
> > > Since util-linux finally switched to the new mount api in 2.39 not so
> > > long ago it also relies on mount_setattr() and that surfaced this issue
> > > when Fedora 39 finally switched to it. Fix this.
> > > 
> > > The Linux kernel CVE team has assigned CVE-2024-26821 to this issue.
> > 
> > This one probably needs to be disputed as it isn't an actual
> > vulnerability, but rather a fix for the mount_setattr which previously
> > didn't allow reconfiguring the real rootfs similar to what the mount
> > syscall always allowed to do.
> > 
> > So it merely brings mount_attr up to par with mount in terms of allowing
> > the real rootfs to be reconfigured.
> > 
> > Christian, what do you think ?
> 
> Yeah, it's not security related at all. It just allows _additional_
> functionality. Not sure how that ended up on the CVE list. Thanks for
> pinging about this!

Now rejected, thanks all for reviewing this and letting us know.

greg k-h

