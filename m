Return-Path: <linux-kernel+bounces-269787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42E9436E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B32C1C21915
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5D1649BF;
	Wed, 31 Jul 2024 20:11:05 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC149627;
	Wed, 31 Jul 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722456664; cv=none; b=OsnQaH2reg6bSOh1lqAVBlQ0OLCcst6WVIqJCqDDmesBBKcvlIyBMg3EwWVc2ktBn3Nbkp3Z9z/HAFNzDNMhNM7RnYp98etSGq76r89GfRFjvS/k/TqdZ4w0NqfUnbnbXtsq1LC+c1urtkVePMFQEboyyPohz4+nvHQg9n0mFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722456664; c=relaxed/simple;
	bh=/i+TJhra+65mna0gA2/eaKhKujPAlGmCNAqwDnjBLKw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=Orr/6L1tE4de/Ev7AbKcjqn5FTIaohFIQRaijiU3noi+yNbikgIIp0mxdgFPIQafnixYsBmOGRPmduYB+60GCU+EawPwib6/Qs2se7z8TJ2QK7jpFe6+EeJEeBRqf98XGAmqtF6LrLwo0MkNDHIVmigMvpzX8lLag6wQudC7FtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 8A22F540D;
	Wed, 31 Jul 2024 22:11:00 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 31 Jul 2024 22:11:00 +0200
Message-Id: <D33ZXDVKL33Z.1SDI3XDBGZIO8@kernel.org>
Subject: Re: [PATCH] usb: gadget: f_acm: make bInterfaceProtocol
 configurable
Cc: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.16.0
References: <20240730194337.2583784-1-mwalle@kernel.org>
 <2024073151-violator-unskilled-6866@gregkh>
 <D33LLE6K8QGH.1BCZM42INRVEX@kernel.org>
 <2024073145-treat-winnings-3bb4@gregkh>
In-Reply-To: <2024073145-treat-winnings-3bb4@gregkh>

Hi Greg,

On Wed Jul 31, 2024 at 11:16 AM CEST, Greg Kroah-Hartman wrote:
> On Wed, Jul 31, 2024 at 10:57:04AM +0200, Michael Walle wrote:
> > Hi Greg,
> >=20
> > On Wed Jul 31, 2024 at 10:32 AM CEST, Greg Kroah-Hartman wrote:
> > > On Tue, Jul 30, 2024 at 09:43:37PM +0200, Michael Walle wrote:
> > > >  struct f_serial_opts {
> > > >  	struct usb_function_instance func_inst;
> > > >  	u8 port_num;
> > > > +	u8 protocol;
> > > > +
> > > > +	struct mutex lock;
> > > > +	int refcnt;
> > >
> > > Attempting to "roll your own" reference count is almost never a good
> > > idea.  If you really need one, please use the proper in-kernel apis f=
or
> > > this.  But you need to justify it as well, I didn't see why this was
> > > needed at all.
> >=20
> > Honestly, I couldn't grok all that usb gadget magic, so I've looked
> > at similar gadgets and took that from there:
> >   grep refcnt drivers/usb/gadget/function/ -r
> >=20
> > They are all doing the same, so maybe that code is old or didn't use
> > the proper APIs back then.
>
> It's old code, please do things properly.

Sorry, I have to come back to this. What do you have in mind?

The mutex is needed in any case to protect the members of
f_serial_ops from concurrent access between the .bind() and the
configfs write.

Which leaves us with refcnt. I don't think refcount_t is suitable
here. For example, refcount_inc() will warn if you increment from
0; which makes sense for resource reference counting. But doesn't
make sense in this case; there is no resource handling or freeing if
the refcnt is 0. It just prohibits the write to the configfs
attribute if refcnt !=3D 0, that is, there is at least one instance of
the gadget function.

Maybe I should just rename "refcnt" to "users" and add a comment to
the mutex what it will protect.

What do you think?

-michael

