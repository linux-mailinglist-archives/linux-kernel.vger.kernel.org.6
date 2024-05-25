Return-Path: <linux-kernel+bounces-189238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799AE8CED7C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 04:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D112821CB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 02:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE51FB5;
	Sat, 25 May 2024 02:24:33 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 8718410E3
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716603873; cv=none; b=kuXXY1oPX0dWKeXFbbSUG59IJXEttjGTVJhRSqgJi3IsUK+EY46sHGQGMsdBIVDqGNsBrTgZBZwWXwFQ9G4zSfcqo9oRudYS0cf52jnVgbp/9tB0AJQeGkRbnAq9quI/JF3tzJDa5ecj2YF6xfc9bXQoWed7CJBdgmtyXhv6Pl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716603873; c=relaxed/simple;
	bh=7tUhIHfBn34z7qtBCeiL2raRXN+auBPYGV8rte3VEp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtQPgHhRfZcmAg5IQZPxd+NByeD8oNbigX3u1kqDNn2bOwZtcJNUZM9xW205C77j+A05BVbV4R5+gvU8fTXKR4YIlzVEeO2LCSX7CrVTgmVhCQeoMO5Ua1wnXPm5ianxLzf+BVbBPrsBvSkH2kL7JJEReQhoERzTTXUWBmdkfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 594160 invoked by uid 1000); 24 May 2024 22:24:24 -0400
Date: Fri, 24 May 2024 22:24:24 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: shichao lai <shichaorai@gmail.com>
Cc: gregkh@linuxfoundation.org, oneukum@suse.com, linux-usb@vger.kernel.org,
  usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
  xingwei lee <xrivendell7@gmail.com>, yue sun <samsun1006219@gmail.com>
Subject: Re: [PATCHv2] Check whether divisor is non-zero before division
Message-ID: <e1e593b2-fc50-4303-a01f-b7f7bf467c4e@rowland.harvard.edu>
References: <20240523092608.874986-1-shichaorai@gmail.com>
 <a0afa88b-f84c-4b45-a265-2e6bcbb84b35@rowland.harvard.edu>
 <bb581989-4ac5-4ffe-9f80-01b5f993146f@rowland.harvard.edu>
 <CACjpba5iJ5dC=rB_Ckaqe4BKesrAN2VmsDCPZJ=frufNgA96Uw@mail.gmail.com>
 <eb995078-1923-43d5-a20f-9d4a7edee719@rowland.harvard.edu>
 <CACjpba55sPDba9GfpMqe_GUgAtv=6MzWAnsgov-PdpFPEDxwGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACjpba55sPDba9GfpMqe_GUgAtv=6MzWAnsgov-PdpFPEDxwGQ@mail.gmail.com>

On Fri, May 24, 2024 at 10:13:45AM +0800, shichao lai wrote:
> On Fri, May 24, 2024 at 12:30 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > Good work!  So the problem is that the driver believes the status[0] &
> > 0x08 test.
> >
> > The way to fix this is to add an "initialized" flag to the alauda_info
> > structure.  Then alauda_check_media() should call alauda_init_media() if
> > the 0x08 bit is set in status[0] _or_ if info->initialized is 0.  And of
> > course, alauda_check_media() should then set info->initialized to 1 if
> > the alauda_init_media() call succeeds.
> >
> > Would you like to write and test a patch that does this?
> >
> > Alan Stern
> 
> I tried to do this. And the workflow can enter alauda_init_media(),
> but there are still many conditions to satisfy in alauda_init_media().
> Unfortunately alauda_init_media() stop and return here before
> initializing uzonesize:
> 
> if (data[0] != 0x14) {
>     usb_stor_dbg(us, "Media not ready after ack\n");
>     return USB_STOR_TRANSPORT_ERROR;
> }

That's an error return.

> The data[0] is status[0] showed before, and it was 0x0036.
> I am not familiar with the status code of alauda.
> How can I deal with this condition?
> Is it ok to pass this condition when info->initialized == false, even
> if the data[0] != 0x14?

If alauda_init_media() returns an error, leave info->initialized 
unchanged.  alauda_check_media() will return an error also, so the bad 
division won't take place.

Alan Stern

