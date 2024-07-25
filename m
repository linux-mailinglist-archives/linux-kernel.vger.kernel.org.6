Return-Path: <linux-kernel+bounces-262528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F0193C84D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B073B283889
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865E2C1B4;
	Thu, 25 Jul 2024 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="joz9LKTP"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760A210F8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721931811; cv=none; b=Khdpg3iBrGWApYak4CM5WkJphBGD7rRmImGTu9C9r82eRqLsCgaks4dVNLPMM8PudNgCGpCulGmobMeHlFJHe3qCTy9EfOqGJaC+eWQzY0XfbdAjWnaLAzs9Xe/grfDsNpWpauZ7oC3WmZY1Z5W01/7Vd6xrhdB75clPPKch3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721931811; c=relaxed/simple;
	bh=EgEtuaM1w9SIxRjRrGQqJpo1WaJB9BUCujCEJzAr99M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC7FcOKCrallm11a5N/T841STvYJ2QHbCR019zbNXg53NWCZZOosrF3PnLcGO5UGFhgnqyRJpjmh6sKt1I0VSrY50hW61y7ABzozhLX2WjQNJfHLBk7P5GUNnjDkvx2TRC7wrFlwnMowzCWb8tR1tAOb3Uh3uKxpBiE0bOccaGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=joz9LKTP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1dcc7bc05so21277385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1721931808; x=1722536608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AyvNjjqobDzo2nVAxqnhjliyH8DNl57hvC/5geRPhII=;
        b=joz9LKTPe27qKHQmOUzHt34AK2cvzZotNlU/91GswfS+nQxwVMheNF/jNgpitSe/IZ
         VoW0uh00uqgoITWimH3eB4s4h811fuMrSbXLy65tBooeK0iqnI83z0isxzpHJjUmpTpy
         gVq35OWEwRUZzU2Nat6Hh47VE0pHfS6RUqTGCVuNOVHQXmi4Rc7QrYPrbqv0u+oShA/w
         LR0MrwqH/F5heo1OyWVIoSVA9w9uB40uOkPyv2ZztJC1j7zIT54HudNeEty96sr4koi0
         nX2HH/EUWcic4JwKf+jLYYrdDybzls4eG3tyBH2YnSHi3F21iIMrE0wpWEIlyCrXzv/d
         OuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721931808; x=1722536608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyvNjjqobDzo2nVAxqnhjliyH8DNl57hvC/5geRPhII=;
        b=fnm2127kyzBTsfBWcsLmjXLyJzGSI+M/5Eiys/Mwt3j3glQz2iHehqg6XRtsLPatkt
         bsEQd4tIcootMiXbkJebTODo38aDiBLDbjZWGFUePQ+hXuH6sUH82U1W0LRLceRWRWeV
         RKDWIPoDlVdNItYSvbc4NAQSurSwW9+BWM2au7zdGRNkP00/EQ8kJ0MW7S6KaGbmJJ56
         ROFvey9m+uCQCVdLNiWZTHNLhMO5dQvweKBJNrkb3jKKG0zZFvS6/ZTkLImjKN9IVoV5
         xZ4pnIGtLtvoByr3je8LRxLg8FbX/2cvdj0PSm/xGOqDZr9Uv9PHhcmKc8xO7kYrBwID
         Ti2w==
X-Forwarded-Encrypted: i=1; AJvYcCUIs/C1xyV46s+OcVGThQGSOUlqBA4uEb1xmvmBRpdBCkek2BLVmVS6qqHdLtUSU2DpsS7D3XLszAq9/MjJT9w7NwjDdhooFiZBHyRK
X-Gm-Message-State: AOJu0YyG0dO5V6pjFJsYoHNVdzfhZeBR4y07xDP9KEDybatEqu2CxqRf
	ZBsSHQLN7H/zQoYvsEtNE3okKFixNB5zzaK24DyBgsLJlEtBNYmv1urN/Y82fA==
X-Google-Smtp-Source: AGHT+IEM5Pm5c6CfZSOAnNl7b0CiQM8WJGV7l2L9UCEWETuR+l2rd0k3fr8sk+NF2+488kFRGVVLKg==
X-Received: by 2002:a05:620a:1a9f:b0:7a1:d08d:e2fa with SMTP id af79cd13be357-7a1d455dce1mr540124285a.1.1721931808130;
        Thu, 25 Jul 2024 11:23:28 -0700 (PDT)
Received: from rowland.harvard.edu (iolanthe.rowland.org. [192.131.102.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b1e6csm106939985a.32.2024.07.25.11.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:23:27 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:23:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: crwulff@gmail.com, linux-usb@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: core: Check for unset descriptor
Message-ID: <d24a4b7f-0d3a-4c24-9de3-5f14297b0904@rowland.harvard.edu>
References: <20240725010419.314430-2-crwulff@gmail.com>
 <2024072512-arguably-creole-a017@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072512-arguably-creole-a017@gregkh>

On Thu, Jul 25, 2024 at 06:56:19AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 24, 2024 at 09:04:20PM -0400, crwulff@gmail.com wrote:
> > From: Chris Wulff <crwulff@gmail.com>
> > 
> > Make sure the descriptor has been set before looking at maxpacket.
> > This fixes a null pointer panic in this case.
> > 
> > This may happen if the gadget doesn't properly set up the endpoint
> > for the current speed, or the gadget descriptors are malformed and
> > the descriptor for the speed/endpoint are not found.
> > 
> > No current gadget driver is known to have this problem, but this
> > may cause a hard-to-find bug during development of new gadgets.
> > 
> > Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chris Wulff <crwulff@gmail.com>
> > ---
> > v2: Added WARN_ONCE message & clarification on causes
> > v1: https://lore.kernel.org/all/20240721192048.3530097-2-crwulff@gmail.com/
> > ---
> >  drivers/usb/gadget/udc/core.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index 2dfae7a17b3f..81f9140f3681 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -118,12 +118,10 @@ int usb_ep_enable(struct usb_ep *ep)
> >  		goto out;
> >  
> >  	/* UDC drivers can't handle endpoints with maxpacket size 0 */
> > -	if (usb_endpoint_maxp(ep->desc) == 0) {
> > -		/*
> > -		 * We should log an error message here, but we can't call
> > -		 * dev_err() because there's no way to find the gadget
> > -		 * given only ep.
> > -		 */
> > +	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
> > +		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
> > +			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
> 
> So you just rebooted a machine that hit this, that's not good at all.
> Please log the error and recover, don't crash a system (remember,
> panic-on-warn is enabled in billions of Linux systems.)

That should not be a problem.  This WARN_ONCE is expected never to be 
triggered except by a buggy gadget driver.  It's a debugging tool; the 
developer will get an indication in the kernel log of where the problem 
is instead of just a panic.

However, if you feel strongly about this, Chris probably won't mind 
changing it to pr_err() plus dump_stack() instead of WARN_ONCE().

Alan Stern

