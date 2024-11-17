Return-Path: <linux-kernel+bounces-412150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E6B9D0479
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E77B217C3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF211DA0E3;
	Sun, 17 Nov 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="hBH9FqhT"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC15335B5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731856727; cv=none; b=qSZz+SxHUU2sJm55BsL7dcDuiJl1ny2JO5J2YsdCq/fAsXxZeX5OdcBsHbmz1QzhOgmwyNyhIAXtfRAhtOQi3AkS7WCo+ZOewP2rCKEkirAS7+blL8EBoySnLAzGWKRuJdltGEoLqXXIfAqKCzF2MrEB/wkpjPYPtjRLmice6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731856727; c=relaxed/simple;
	bh=A3Y1VPSR2tBt66ItUfNx6b8IZBDbeWm1eBj5C4Qee8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0aPeYj/yto+jDb3TFtBWaJU1V39RvXrt40OuGMggE0BFY3qQWcaFvckLqHJwYzzp3B7M3v+oWFLBiF1sgVc5rcDqaPWnETb1mnRokUVo6bJXuolmecLeWLtL5LMZHsA0wwHRaNNrV10NrMVQ3xc6FCuhl1zjv03tposKE28U8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=hBH9FqhT; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b1434b00a2so110923185a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731856724; x=1732461524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=reI+Fsse4urmMnvSxA388VE7DvEBSJUHhA3f5I4eWkU=;
        b=hBH9FqhT6gVyyVXemNSkLyfpfmUdTrHDU0yLTjQbPw3BjMXJ4/IdTOrJFjg72Br71b
         5yH8m6f2XI9L/TC3s9LeHfM/8IuR4aMhc6hC1dEIOIAePmrDiJ3GJkdoGKz9IervmQ+S
         S0V4X6c65yWNu+2mkSPxFAYovRvXgxjPTIdip5G9p8/s9Vy4g1Im+3ei2hQZUaCLUUHy
         7/j37pFAFsnn6zLQr9UfpHPonBBSl7sBSxzm99nN8Y+b8vUNpgvfM6jFSTjdPpboMdCu
         3Oc725Ojg1iPn3BBB7JB33P1/kxY97bWO05bF+IpJ7+apJPOBgClWdiGnomNoDkHMJXV
         hdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731856725; x=1732461525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reI+Fsse4urmMnvSxA388VE7DvEBSJUHhA3f5I4eWkU=;
        b=LSEZN/BRmB0cfQG2qJ+jFazVLBwS4swJlWivh36b3SFPmKy8igSUWkgc7VK7fROldS
         agy7M3A//EA7RoMoe4bvDxPkG3ylI0aKuqpta8FmnwDPCUw21DZJoosqf97Mrb7bKt9G
         E+dEwfJikJrZplW3asdEu0fVV8dNzzNKy6BtQV2J6V07Uf3HYhcDUx1+xIMEhoVK4ot2
         i2wYO/AtjPHYDzUqtzZRcbbpu6L9/RokmCSdpltsS1+sb+jm8RsJaJlwzrRZs+oJl/wu
         K+MfIUROvokHyeurVRnz12T2X/8+W9DzVGJ52B+GApDUsAvbuQs4NOpZX4Fa0rG3bnqw
         HVxw==
X-Forwarded-Encrypted: i=1; AJvYcCUib/A5PL9bzrwWrQ54LPM91NzR0CMP5ZNNW6n5LYlLPa9F83NNjfMGLtBWZ83kKwfUZrbdH2u2qre5qgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf/cE5JHk538mJ9mTRh6xvz8f+xp1/Pzx0QjM5E+fVILMG0ypK
	G7pVj36MuESxv3r6Tf2nmFmnh6LvALCWTD3aptycFJJdmWa3/r006pWg6tzgUgYjTyIjNJZ2pIk
	=
X-Google-Smtp-Source: AGHT+IEG1JIa9cljwnGia/ZZR9Gio5ypxpTzcCZMH9UIoO9zOsPq/Ro4wtF0pZWOlIYF6p0AgCbGuw==
X-Received: by 2002:a05:620a:1a0a:b0:7b1:49d3:29c7 with SMTP id af79cd13be357-7b3622c6a4cmr1235837085a.2.1731856724725;
        Sun, 17 Nov 2024 07:18:44 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::24f4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40ddd356dsm22160376d6.126.2024.11.17.07.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 07:18:44 -0800 (PST)
Date: Sun, 17 Nov 2024 10:18:40 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Markus Rechberger <linuxusb.ml@sundtek.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Highly critical bug in XHCI Controller
Message-ID: <50f730ae-4918-4dac-88ec-b3632bee67e7@rowland.harvard.edu>
References: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
 <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4239c7b0538e1cd2f2a85307c73299117d5f0e.camel@sundtek.de>

On Sun, Nov 17, 2024 at 08:44:16PM +0800, Markus Rechberger wrote:
> Basically the issue comes from hub_port_connect.
> 
> drivers/usb/core/hub.c
> 
> hub_port_init returns -71 -EPROTO and jumps to loop
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L5450
> 
> I'd question if usb_ep0_reinit is really required in loop which is
> running following functions:

You mean that usb_ep0_reinit() runs the following, not that the loop 
does.

>     usb_disable_endpoint(udev, 0 + USB_DIR_IN, true);
>     usb_disable_endpoint(udev, 0 + USB_DIR_OUT, true);
>     usb_enable_endpoint(udev, &udev->ep0, true);
> 
> this is something only experience over the past decades can tell?

It _is_ necessary, because the maxpacket size of ep0 may change from
one loop iteration to the next.  Therefore the endpoint must be disabled 
and re-enabled each time the loop repeats.

[Now that I go back through the git log, it appears the only reason for 
exporting usb_ep0_reinit was so that the WUSB driver could call it -- 
see commit fc721f5194dc ("wusb: make ep0_reinit available for modules").  
Since the kernel doesn't support WUSB any more, we should be able to 
stop exporting that function.]

> usb_enable_endpoint will trigger xhci_endpoint_reset which doesn't do
> much, but crashes the entire system with the upstream kernel when it
> triggers xhci_check_bw_table).
> 
> I removed usb_ep0_reinit here and devices are still workable under
> various conditions (again I shorted and pulled D+/D- to ground for
> testing).
> The NULL PTR check in xhci_check_bw_table would be a second line of
> defense but as indicated in the first mail it shouldn't even get there.
> 
> 
> 
> As a second issue I found in usb_reset_and_verify device 
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L6131
> 
>         ret = hub_port_init(parent_hub, udev, port1, i, &descriptor);
>         if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV) {
>             break;
>         }
> 
> hub_port_init can also return -71 / -EPROTO, the cases should be very
> rare when usb_reset_and_verify_device is triggered and that happens.

If that happens, the loop which this code sits inside will simply 
perform another iteration.  That's what  it's supposed to do, not an 
issue at all.

Alan Stern

