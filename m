Return-Path: <linux-kernel+bounces-524604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0DA3E512
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9300A7A7F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085682641CA;
	Thu, 20 Feb 2025 19:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaHRufLS"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E012463A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079896; cv=none; b=bhm3jL/z0WV5/56EsRETsgIVW+j9bCFOz29Fcpx52ZOvzVIn9Dyh46OPSo/cXdkvDW8LNVWjOarH0qWK+A56lojEWjArN0nl7NNjIG12Sk9PNVRBHKFDiLGE+7eqBHBjTeQTDc1K2q5P2Bk7GCkd6LYMYFpal+1uHH/QGBIQjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079896; c=relaxed/simple;
	bh=MVq0rSd2W/rQ4EG/nAQY+fo+iAlMg/MrYiWZeK0fCbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFhkz1wqn0/NZOw+Lko0Bdv5O/nPxZc/fTBqAeBa8LLWWYs5M8NKfYrQNAc46sTm5OWtJR6hYVF7hDpQyh+z+mbrVJvpBM8oQ3Ljt+diMfpc/PxflF/8Sc2PzyE1woj1I6B/mTDtepcc7/yNz5qiDlOErEVfFDhPFlgsnZsUJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaHRufLS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e83d65e5so26169275ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740079894; x=1740684694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNqMwP45iYYk0uj0DcAs+5VuYjHL2HKpybnKvS9Q0Q8=;
        b=IaHRufLSvQZngqQVwGbV25xIjHyZZLiFvtUFLBLJadlw9vGU6dZydzT+myueiN4GJt
         8woU0VnpwUs2vAQOM8QUB5XTC6Nahh1rbiWia12oKzDVG3jzeJ4N80pAL7kOgR4CA1dl
         +3fJNxWtmpkPG/cMcguZCKfwATQNiqCJ9KueVF45xt9WyzTqeSxOBAz0ulKDAsl2tuKq
         pfCW3N6X8B9lgWss4+buWuOT61r7j4I0XIwKPANQ5ylyJRq7iZtX50+5jfYUGj8LxkGI
         HDV1e7ZPt8n1hEVXNiBJuQsXqs1uTbUQk+vryHy3zk5R6J2iAk1GSPbUYetNL7O5dfXy
         boag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079894; x=1740684694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNqMwP45iYYk0uj0DcAs+5VuYjHL2HKpybnKvS9Q0Q8=;
        b=I+dJ1CwfQV7fqFq50u5QGc5C8f1nHU2MR9nAqAbWMMsgQHtzo1fvUYlQA/XF9SBb4f
         vD5D+deTJxkhJODWRu+Xx4YYvVrFBJGAgzitNMAjm8fwc9+w1xyBoFAXuqa7djxeCNUV
         vcVjgY9ExFZ+C9GrBbiGQM1yoZcG58MrOfKliz8BWBQOcua0zF9yjN1TOp3dh4GahuQF
         e9vWTjoOzxqGeeeRfjvcnsz1ScQEFt4ndie+NsCj7gkHRPNSVI+VTf13GMZa5aPCFFuc
         D4mvNrBkk43stE880nguPbRsTGveYoMNmthKVdtKIoj5TQTJe1BR3HUQNJ7ef1v6veuQ
         VrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrNwhsiekgGRkKQnqsM1VkZIqjMtkGOYq59ur5Y7DRwFCnGd6ULI1yLFOh8wN8+e7BzitXoIYehbBPfso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz62YVgizcRL8aV0WzqNtmxID742X38tx4DISWeGORDbE8b+EpI
	tkpnHEuRrtjAM1iU0kRjQM0pYZywmhB/vOLG2+jgycbfYqeSfun4rHRxxea3WQ==
X-Gm-Gg: ASbGncum0cjL0/qcdMstSN2iNjS1H4tuQQjNu/ou35MN51ilN5J6zDT0iXc6ZsDCq14
	IfJGU/Hhvz5nEHByHnemQ59i2F8iaDwkjleekllJbmZwzho1beUYUmpqAfj7cmCSdy2wC/GK+e7
	v2QwxeatvPcyF2+hK2z3J6UdEqWV62xcx5OU9zsl5qQ/H4SCNY9Ppkqp57MAqGByO2uxgf5kGOZ
	3YuPrpxZP9sbVFRqZ08L3e09ab+OOGq8u7zZYZoWoQJrklS++fDnaeyDNzUJV+n1MXFhnhR5b1v
	OkDC01Suo8JtdVmWEWpWwRlTT6wvH+vJJ4CShyHNFTKOAGKmV4G/aOLG
X-Google-Smtp-Source: AGHT+IGm0mMkDx5+higAvQTvJgGM6Q5QWoVBcT94T2De4H3OUSImBFKF4r5go8AQeAfrxEm5a+S3bw==
X-Received: by 2002:a17:903:230f:b0:216:4883:fb43 with SMTP id d9443c01a7336-2219ffd2718mr6024575ad.32.1740079892529;
        Thu, 20 Feb 2025 11:31:32 -0800 (PST)
Received: from google.com (139.11.82.34.bc.googleusercontent.com. [34.82.11.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ba5f27sm14323197a91.43.2025.02.20.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:31:31 -0800 (PST)
Date: Thu, 20 Feb 2025 11:31:27 -0800
From: William McVicker <willmcvicker@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Prashanth K <prashanth.k@oss.qualcomm.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, andre.draszik@linaro.org,
	kernel-team@android.com
Subject: Re: [PATCH v2] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
Message-ID: <Z7eDD1PsBYVIYWMY@google.com>
References: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
 <Z7dv4rEILkC9yRwX@google.com>
 <2025022032-cruelness-framing-2a10@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025022032-cruelness-framing-2a10@gregkh>

On 02/20/2025, Greg Kroah-Hartman wrote:
> On Thu, Feb 20, 2025 at 10:09:38AM -0800, William McVicker wrote:
> > Hi Prashanth,
> > 
> > On 02/17/2025, Prashanth K wrote:
> > > Currently the USB gadget will be set as bus-powered based solely
> > > on whether its bMaxPower is greater than 100mA, but this may miss
> > > devices that may legitimately draw less than 100mA but still want
> > > to report as bus-powered. Similarly during suspend & resume, USB
> > > gadget is incorrectly marked as bus/self powered without checking
> > > the bmAttributes field. Fix these by configuring the USB gadget
> > > as self or bus powered based on bmAttributes, and explicitly set
> > > it as bus-powered if it draws more than 100mA.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
> > > Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> > > ---
> > > Changes in v2:
> > > - Didn't change anything from RFC.
> > > - Link to RFC: https://lore.kernel.org/all/20250204105908.2255686-1-prashanth.k@oss.qualcomm.com/
> > > 
> > >  drivers/usb/gadget/composite.c | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> > > index bdda8c74602d..1fb28bbf6c45 100644
> > > --- a/drivers/usb/gadget/composite.c
> > > +++ b/drivers/usb/gadget/composite.c
> > > @@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
> > >  	else
> > >  		usb_gadget_set_remote_wakeup(gadget, 0);
> > >  done:
> > > -	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
> > > -		usb_gadget_set_selfpowered(gadget);
> > > -	else
> > > +	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
> > > +	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
> > >  		usb_gadget_clear_selfpowered(gadget);
> > > +	else
> > > +		usb_gadget_set_selfpowered(gadget);
> > >  
> > >  	usb_gadget_vbus_draw(gadget, power);
> > >  	if (result >= 0 && cdev->delayed_status)
> > > @@ -2615,7 +2616,9 @@ void composite_suspend(struct usb_gadget *gadget)
> > >  
> > >  	cdev->suspended = 1;
> > >  
> > > -	usb_gadget_set_selfpowered(gadget);
> > > +	if (cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
> > > +		usb_gadget_set_selfpowered(gadget);
> > 
> > I'm hitting a null pointer derefence here on my Pixel 6 device on suspend.  I
> > haven't dug deep into it how we get here, but in my case `cdev->config` is
> > NULL. This happens immediate after booting my device. I verified that just
> > adding a NULL check fixes the issue and dwc3 gadget can successfully suspend.
> 
> This was just fixed in my tree today with this commit:
> 	https://lore.kernel.org/r/20250220120314.3614330-1-m.szyprowski@samsung.com
> 
> Hope this helps,
> 
> greg k-h

Yup, works for me. Thanks!

--Will

