Return-Path: <linux-kernel+bounces-193485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CAE8D2CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5012F1F26686
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3861D15CD7D;
	Wed, 29 May 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgpZAHKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBE44C77;
	Wed, 29 May 2024 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716962676; cv=none; b=T3c75jHN3dgLvD2y0Zb0B8RVFAqHUt1NAE0SPDRi23FlIK4qGUJE9kcy9p71APNlMS1QFO7N+4cAajkGAUH1H05Y6snIYB8j41JOCApbdBgK7fGCDFLmMQ5jcnX3OrSwI8ns8wgePLPnt7C5ESElcFo5W873Xh2e6mzZivgsXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716962676; c=relaxed/simple;
	bh=+gwgr7olQNeuzmPuNvXS7wMfEbI0mRRGvGfWjEgAgjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdrekn3N4gxjT22QrnNX5DAFkbJQmeFSwwTYdemDNG0rG7LjNHKpyxVAcktItO6xUSHnUEk4J6JgFJQYIxQHTL7e/I3CssApQ3eDk6BkPT+YTAJR5QTcpdbxleOGVX+2kDDDVhbuOUaKIEvAksptOtip/ZFEAlMrcjW33TIeDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgpZAHKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F4EC2BD10;
	Wed, 29 May 2024 06:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716962675;
	bh=+gwgr7olQNeuzmPuNvXS7wMfEbI0mRRGvGfWjEgAgjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgpZAHKHdqtBMSrLA2t0CtHru+BHy9tK4xA9qp3AQJq3kQhrHWReVAzuKsEAzA57n
	 He+itYewCMXuyjpp+hosyLros1+P3fTxwRaaTz7ueOtbiHzI6XrLgnoTczEpXes6rv
	 PQ1hzQ654AEBM5VyLINq+tQjT5pJtEMgvkdJLcpY=
Date: Wed, 29 May 2024 08:04:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Alexey Gladkov <legion@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: PROBLEM: kbd busted in linux 6.10-rc1 (regression)
Message-ID: <2024052901-police-trash-e9f9@gregkh>
References: <ad4e561c-1d49-4f25-882c-7a36c6b1b5c0@draconx.ca>
 <20240529052543.GL2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529052543.GL2118490@ZenIV>

On Wed, May 29, 2024 at 06:25:43AM +0100, Al Viro wrote:
> On Wed, May 29, 2024 at 12:45:56AM -0400, Nick Bowler quoted:
> 
> >        All other headers use _IOC() macros to describe ioctls for a long time
> >        now. This header is stuck in the last century.
> >    
> >        Simply use the _IO() macro. No other changes.
> 
> ... are needed, since _IO() is arch-dependent; this is quite enough to fuck
> alpha and sparc over.  _IO(x,y) is (1<<29) + 256*x + y there; both ports
> got started with compat userland support, so _IO...() family there is
> modelled after OSF/1 and Solaris resp.
> 
> kbd ioctls predate all of that.
> 
> Please, revert 8c467f330059 - commit in question breaks userland on alpha
> and on sparc for no reason whatsoever.  Might be worth adding a comment
> to those definitions at some point, but that can go on top of revert.
> 
> Folks, 0xXYZW is *not* an uncool way to spell _IO(0xXY,0xZW) - if there's
> any chance that those definitions are seen on all architectures, they
> should be left alone.
> 

Ick, I missed that and to be fair, I should have remembered that and not
taken this commit.  I'll get this reverted later tonight when I get back
to my development systems.

thanks,

greg k-h

