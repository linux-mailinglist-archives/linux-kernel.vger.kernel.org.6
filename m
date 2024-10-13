Return-Path: <linux-kernel+bounces-362842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69799B9E1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13D7281775
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DFD1EB2E;
	Sun, 13 Oct 2024 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrrmxv7i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9748145A07;
	Sun, 13 Oct 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728831621; cv=none; b=XS44UYLSGnLcAZ2B0C6actYdd7P7o0LW315IF4VccHUwlq9+o2tCqEot53ZOKrFZ1FIn06nY8Wh50TuTUOn68rIF1bGfXGDVRxHLX0Uv4+L2y0O+rRtykWQxxxgLSOEDU0hnyF8XF2jev+s0UjxGRXrd+H3WeRnSyq7D7QOEaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728831621; c=relaxed/simple;
	bh=oeWYAEUcd4WSXlgWqfX2kUJ0/1+J5uZulgzHfxS3sM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF6Z+yzZhBJnP98sTS8UHxca9WOhm/M7d0O3GwUuUyYOO92/fCtiunioZynaG8qmo7h5J2nQQdqIPXcklOT95ICyXezFz5z0oWyPkfJkNTZgfBuluCVi/Pi+ykDX9bgPHXujsS1bGqLRnO1txox4vJ+ZRIrJ4fn7CM5StIiNTrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nrrmxv7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ED6C4CEC7;
	Sun, 13 Oct 2024 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728831620;
	bh=oeWYAEUcd4WSXlgWqfX2kUJ0/1+J5uZulgzHfxS3sM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrrmxv7isohxfktURheDOpWAib2r5E28LfrZYQDba1kppMn+rkKHYlUHHf2OoPsvI
	 AMLAXAsyzqaR7bkdlXAvED1tc3AWUhR+csBN5MjnN6DNs4KoN3xztP4tiJr57sJoxA
	 P4cQKcvBh8oEfr5WD1iBs/FOlBos4MRISpDzmep0=
Date: Sun, 13 Oct 2024 17:00:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: rafael.j.wysocki@intel.com, tj@kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2] driver core: Fix userspace expectations of
 uevent_show() as a probe barrier
Message-ID: <2024101356-gauntlet-sludge-7b76@gregkh>
References: <172790598832.1168608.4519484276671503678.stgit@dwillia2-xfh.jf.intel.com>
 <67047c516045d_964fe294b1@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67047c516045d_964fe294b1@dwillia2-xfh.jf.intel.com.notmuch>

On Mon, Oct 07, 2024 at 05:26:57PM -0700, Dan Williams wrote:
> Dan Williams wrote:
> > Changes since v1 [1]:
> > - Move the new "locked" infrastructure to private header files to make
> >   it clear it is not approved for general usage (Greg)
> 
> Greg, per the 0day report and further testing I am missing something
> subtle in using kernfs open files to pin device objects. So hold off on
> this for now until I can get that root caused. If someone else can spot
> what I missed feel free to chime in, but otherwise I will circle back.

Ok, I'll drop this for now and wait for a follow-on patch to come for
whatever you decide.

thanks,

greg k-h

