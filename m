Return-Path: <linux-kernel+bounces-351305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7EC990F83
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8EC1C23128
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0501F9AA0;
	Fri,  4 Oct 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcd0bE5h"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE41F9A82;
	Fri,  4 Oct 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068671; cv=none; b=q3Q/5ujOfSn6BvyP3DT+3R6oMsnwNMIPFiht9LHJWaoqbaSgajBvTUKay2/klFqmGoJfgms9XcV1IbJaEaUtHaxfi6DrnYKBLoa0blCCx5CK5yKgPopreeypEaAopBNZKsFDjaQEBCrVvgdQUMPrhEfqoEADG5aDmz5SS33DDLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068671; c=relaxed/simple;
	bh=38FWtjNG7ztTk0vyl9goaMmj7S+4vdzAmiAK1g8t8Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dx2/gIa7nPt62mNCV9y1TvcBOmjCAJZMKuZ+2nIoDaKJSCKsXJ9yHwQMJGXsw/GhUo6bDypJIV7G8W6MXgTnc1kq3VbJvmiLRmiT3rwDVG2QlraSnlPhShfb8r8DAo23zaHXSP/c3LYkBqOsXzYqsuA+0NydHD0FTqlWXwxtWuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hcd0bE5h; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cdbdbbb1cso1312357f8f.3;
        Fri, 04 Oct 2024 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728068668; x=1728673468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uR17DBK3CgvuTP/A+YeEkLOp8ykg0LTLmIaNQYIZdOk=;
        b=Hcd0bE5hkximu3zCNYhsb8uSZoDDio3JeyKtXxsJy0ZYlNImgSfEpJDHKY2XtPqoOB
         YFRwIQVgq/MaDiz305Ytp6Eb5i2nAn8G3ssWM7VEUziQdsFfIUsNws6OfloABPqm44D1
         +UlwwwQBjBcUb9xfziOw9RTd0qQh4lfdq/h9O25z/IepN1XQgs1i7YORc+Ygsr07kut5
         NyXyjj2VOdt/bM1sXLtGnAAbckpJ56qfur3BmPg2C4gE/sTUdl2UuD/X4iCaCZbxQvHC
         tVyJELn24FhJ3WcL9qjo3KNcd3HeZ4UqT4N4Iw0/ABrhO6KO/4dhj6Qk81ps0qb6dYsC
         EyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728068668; x=1728673468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uR17DBK3CgvuTP/A+YeEkLOp8ykg0LTLmIaNQYIZdOk=;
        b=szQZGI1Xb1n8QDKCA9fnLJhC9KjrHnk8Z1IFCznJ6f+Ie0L2Wa2OfD4nWTGurSjWb9
         4CbJpgbLU6YRFAxMzN7kY5V317RGo6gW0jTtmDq6Ti3DnLxIB38lVuaSD9kjJLdFM1j/
         kpxcsXMDPrtttKts1MsTZVHJ2PwDGQw4S80cTMMVDYT5OsA5pYcVrtbtYx2inFjvtm+c
         600CnVrHYHX+7a4WXIGpt9pcRhpSGQEIL+o1oBaEwrykqpEV70KToGvlRYYtqzRZ15U2
         /ZP2XcrjN8X/22VWP9HGbVT7Oc2wZAtELDa+GeCIj0wahXjyG9LRonozZuajESQMmLR5
         dZ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJn4rrrrmt4nlqWdxRM5F3X1h5MNmF8hfk79cZ3YKMbt1yYWRrXQaUbCiuvjGzrgrK6x6r0ldTgbZy@vger.kernel.org, AJvYcCX18F4Pjn6EvmBr3v3eWWNbO9zqD7B1hlwOiW8VbTzoQgRlrUoUjtL5YFmYRblDrxzyC0wP99VvoYpPuUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz1y6DKvu3iI4Fp6bFaJBXBrRMqjJi+1aFJra3UsWIiw0peyIh
	rVPSoZw8/6CjqjC3U4wLCD0zF3nQQEGFzI9qX+tgTOaMop9U8pAqT+pR5PSd0oo=
X-Google-Smtp-Source: AGHT+IHXWeyAT0Q319kx0ragpDZHMmJzNX5IYvRvTuXIDWVixgz79SC/7C2QuZGKUee2/7nBHGGdlQ==
X-Received: by 2002:a5d:6149:0:b0:37c:cd71:2ba2 with SMTP id ffacd0b85a97d-37d0e7bcdf8mr2106125f8f.38.1728068668374;
        Fri, 04 Oct 2024 12:04:28 -0700 (PDT)
Received: from freebase (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920549sm247106f8f.54.2024.10.04.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 12:04:27 -0700 (PDT)
Date: Fri, 4 Oct 2024 21:04:25 +0200
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Subject: Re: [PATCH] usb: xhci: xhci_setup_port_arrays: early -ENODEV if
 maxports is 0.
Message-ID: <ZwA8OWFJhAuvWDJh@freebase>
References: <20240930052336.80589-1-olivierdautricourt@gmail.com>
 <2024100407-hatless-goofy-bf12@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024100407-hatless-goofy-bf12@gregkh>

Hello,

On Fri, Oct 04, 2024 at 10:07:01AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 30, 2024 at 07:23:29AM +0200, Olivier Dautricourt wrote:
> > If the controller reports HCSPARAMS1.maxports==0 then we can skip the
> > whole function: it would fail later after doing a bunch of unnecessary
> > stuff. It can occur on a buggy hardware (the value is driven by external
> > signals).
> 
> What "buggy hardware" is this that can not pass the USB testing for this
> type of issue?

This is a behaviour found while debugging a custom firmware where this
value happen to be controlled here, i don't know any hardware out there
with such issue, this change should be seen as a software nitpick and is
not trying to fix a specific hardware.

> 
> > 
> > Signed-off-by: Olivier Dautricourt <olivierdautricourt@gmail.com>
> > ---
> >  drivers/usb/host/xhci-mem.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> > index d2900197a49e..e8406db78782 100644
> > --- a/drivers/usb/host/xhci-mem.c
> > +++ b/drivers/usb/host/xhci-mem.c
> > @@ -2160,6 +2160,11 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
> >  	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> >  
> >  	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
> > +	if (num_ports == 0) {
> > +		xhci_warn(xhci, "Host controller has no port enabled\n");
> > +		return -ENODEV;
> > +	}
> 
> Should this be backported to older kernels, if so, how far back if this
> is common hardware?

I don't think this would have to be ported to stable trees: The function
handles the case without failure: the 0 value is propagated until line
2220 and fails on condition:
	if (xhci->usb2_rhub.num_ports == 0 && xhci->usb3_rhub.num_ports == 0) {
		xhci_warn(xhci, "No ports on the roothubs?\n");
		return -ENODEV;
	}

The change merely avoids passing 0 value through kcalloc_node calls and
unnecessary accesses to the capability structures of the controller.

Kr,
Olivier

