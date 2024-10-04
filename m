Return-Path: <linux-kernel+bounces-350419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA49904F3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18371F22DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD12212F15;
	Fri,  4 Oct 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vRNqnUrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C275156678;
	Fri,  4 Oct 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050167; cv=none; b=M4WWFbPXpShczEfn/IfMLozycEoqOxn937XAgiOgVkTcEogVOsWq23aKZuzdw+RWIQJK80HqVT4MZCRLdYg87q8TNW30NAOnDU7hLLvag5VHNkhNNXAxoyDpHKVf4LFTDlWmP4oqBRmuc3nkyeQvDiZEXzirtca4Wy8M5/Vuqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050167; c=relaxed/simple;
	bh=YuOS9ER2LZDu+JGX1nEdbQygW4nZ+0/WtrzohHesm+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTDwDAOjpZz72yop431eAIIo6TF0GJjH0O1e8Qjm5Ob+gU6CTbCn2vVohx9Rz/JswVNf4IgIrRUfN+7hCUAkJUIjgpD9L47nj0WfVR0qSedk1sI1r9jPV+oMe5R/M4TB0WkGDHRwugrwM6mKd39B6zzBjF4wku1x/pX5uHwCGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vRNqnUrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D98CC4CEC6;
	Fri,  4 Oct 2024 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728050166;
	bh=YuOS9ER2LZDu+JGX1nEdbQygW4nZ+0/WtrzohHesm+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRNqnUrMpkXaXaJAfDxq7ydDhuunKPbn2pTDft6tjypV1sCK7Dv7otvY9G+Zg7PLS
	 ZCqskOy8bNhhhW7zTZUKblA1p6rmC4+3B2GHmhiUlcTMOuyt0YwjgqbJx64D2OvlNc
	 cv7V23x8qr0dThyyMTpP5WDdoxQCao9YhALGreP0=
Date: Fri, 4 Oct 2024 15:56:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Potapenko <glider@google.com>
Cc: bemenboshra2001@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	nogikh@google.com, dvyukov@google.com, elver@google.com,
	pimyn@google.com,
	syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: usbtmc: initialize memory written to device
Message-ID: <2024100449-guiding-pesky-566a@gregkh>
References: <20241004123313.2463701-1-bemenboshra2001@gmail.com>
 <2024100452-echo-chokehold-f6fa@gregkh>
 <CAG_fn=Vmn1UotDhpHr48_ENd+d12y0G-qR5Q4m5aTODN+tH8uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=Vmn1UotDhpHr48_ENd+d12y0G-qR5Q4m5aTODN+tH8uw@mail.gmail.com>

On Fri, Oct 04, 2024 at 03:41:22PM +0200, Alexander Potapenko wrote:
> On Fri, Oct 4, 2024 at 2:57 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Oct 04, 2024 at 12:33:13PM +0000, Pimyn@web.codeaurora.org wrote:
> 
> Just curious, what's up with this @web.codeaurora.org address? It
> wasn't in the original patch, where did it come from? :)

You tell me, look at the original patch, it's in the email...

> > > Avoid kernel-usb-infoleak by initializing all memory written to device.
> > > The buffer length uses 32bit alignment which might cause some buffer
> > > data to be read without any initialization.
> > >
> > > Reported-by: syzbot+8f282cce71948071c335@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/0000000000006f6622061eb52dba@google.com/T/
> > > Signed-off-by: Pimyn Girgis <bemenboshra2001@gmail.com> (Google)
> > > ---
> > >  drivers/usb/class/usbtmc.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> >
> > The "From:" line of this commit is obviously not correct and does not
> > match this signed-off-by line.
> 
> Sorry, does it mean the "(Google)" part should be present in the From:
> line as well?

A valid email address should be in the "From:" line.

> > Also, as you are from google, just use your google.com email address
> > please.
> 
> Unfortunately Pimyn cannot send emails outside the @google.com domain.

Google has well-known facilities and abilities to handle this, please
use them and do not hide behind gmail accounts.

thanks,

greg k-h

