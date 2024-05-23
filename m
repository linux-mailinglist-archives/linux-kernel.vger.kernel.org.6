Return-Path: <linux-kernel+bounces-187578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E828CD4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535371C214C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5C114A09C;
	Thu, 23 May 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kj0dScHU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDD1E497
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471155; cv=none; b=VLpVkVfa7j/AaryUDwnX7h23pA3o6n4ozxU1gYaHAj/Nfv9Ocmt/A7dmWEAtwQzabwfrkraand17rdVEiZ5MmowQnmdUzTJUALCGGWqhkFzRxDxMJeU5pz6/mdKaI6YjQxbof0zz1qXbAfnFXUutvQgsvbuFulS2zGfmEq+WA9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471155; c=relaxed/simple;
	bh=mWji3bB8YM3A7MGn2Wx2MlorQvyUHWrqR8hOp/Q99Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiXYkb5tGjH2VU7OGBEPhwI+ydEjRVTh/iH+t8UI8omr9vGXI90MyoQfxpjLzr4wm8nJPoefv7Facbv+Gx2H5Nl9dwDXRsoLx3FD5u+5vy6+QMPkQBF26s8FOUKd9jgtDmppBFLcAJfDgg/JG18/UMvMmmzhsT/qCZQJSdje9tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kj0dScHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F21C2BD10;
	Thu, 23 May 2024 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716471155;
	bh=mWji3bB8YM3A7MGn2Wx2MlorQvyUHWrqR8hOp/Q99Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kj0dScHULS/yut/psGpbpy2vZbUrGtimi6fXbU1EGBOFDGOiY0O/9DH+CZW71fzLX
	 iaY6wl4dqb9/Ieg5SDiS2N4XCJEz89f3N+NQTYKdtk/RLno07mTHddaUPVXgMfKrST
	 6EkeQwmWUSFtyp1J4/2eh4oAuQ+2wcwgCy4t2i/4=
Date: Thu, 23 May 2024 15:32:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-35876: x86/mce: Make sure to grab mce_sysfs_mutex in
 set_bank()
Message-ID: <2024052324-glaucoma-legged-34a4@gregkh>
References: <2024051943-CVE-2024-35876-d9b5@gregkh>
 <3eadcc8c-d302-4a70-a16f-604285c1257d@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eadcc8c-d302-4a70-a16f-604285c1257d@suse.com>

On Thu, May 23, 2024 at 01:24:33PM +0300, Nikolay Borisov wrote:
> 
> 
> On 19.05.24 г. 11:34 ч., Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
> > 
> > Modifying a MCA bank's MCA_CTL bits which control which error types to
> > be reported is done over
> > 
> >    /sys/devices/system/machinecheck/
> >    ├── machinecheck0
> >    │   ├── bank0
> >    │   ├── bank1
> >    │   ├── bank10
> >    │   ├── bank11
> >    ...
> > 
> > sysfs nodes by writing the new bit mask of events to enable.
> > 
> > When the write is accepted, the kernel deletes all current timers and
> > reinits all banks.
> > 
> > Doing that in parallel can lead to initializing a timer which is already
> > armed and in the timer wheel, i.e., in use already:
> > 
> >    ODEBUG: init active (active state 0) object: ffff888063a28000 object
> >    type: timer_list hint: mce_timer_fn+0x0/0x240 arch/x86/kernel/cpu/mce/core.c:2642
> >    WARNING: CPU: 0 PID: 8120 at lib/debugobjects.c:514
> >    debug_print_object+0x1a0/0x2a0 lib/debugobjects.c:514
> > 
> > Fix that by grabbing the sysfs mutex as the rest of the MCA sysfs code
> > does.
> > 
> > Reported by: Yue Sun <samsun1006219@gmail.com>
> > Reported by: xingwei lee <xrivendell7@gmail.com>
> > 
> > The Linux kernel CVE team has assigned CVE-2024-35876 to this issue.
> 
> 
> I'd like to dispute the CVE for this issue. Those sysfs entries are owned by
> root and can only be written by it. There are innumerable ways in which root
> can corrupt/crash the state of the machine and I don't see why this is
> anything special.

Good catch, now rejected, thanks!

greg k-h

