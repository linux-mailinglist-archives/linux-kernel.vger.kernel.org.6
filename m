Return-Path: <linux-kernel+bounces-250901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4A092FE48
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69510B2279F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31817623F;
	Fri, 12 Jul 2024 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rf+oiapu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75991DFE3;
	Fri, 12 Jul 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800887; cv=none; b=LqGLEni3bIma2iAfVYaGi4RX3xoXnX3XmtQF4a0xuGLNsCLrdrdAzhp9bDJhIqEdXNacXETroxRH0ifsS3pP1ytkP7Lqt/goxxQ2CLnCCXw/yTCKwdrSmFV7sf7oHRziRmjOZb9tmh1xtOx9CIZQ2zb/FAETtrpZ+Xle2y3Dtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800887; c=relaxed/simple;
	bh=1ul5U7u1q3HCojqZzhYYvG/+4UwWFpVkhRqU+q0icPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evbl0GGCxE7uJOS7ZG/20knXfUPfBaqBlzfJ9AGJdcqkhJSFZQvwOz48z38hGjRFbylSaT/rwghr/svMxIIr1N/+BtJeMg+ANMZTC2kAB1faeuTFcCGDHy+1quY551em+JBJyrM/WM+HthqI1yfSZEiuILw0kARSYWkz/mLmAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rf+oiapu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A85DC4AF0B;
	Fri, 12 Jul 2024 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720800886;
	bh=1ul5U7u1q3HCojqZzhYYvG/+4UwWFpVkhRqU+q0icPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rf+oiapu7Hfpjm1e3uX7XbieRNjVyGgAsQ6cXKGXXKeCVONzKSGYkmdadIUEE89IY
	 KX4q74v9vxy4VakX/FY108lWlKZ8ybjlV2kgva0pz7hlgbcj8K6eBqQ4DeHfqTq5r2
	 ipgJ3kxRizJaXwaJFsVXDGhdwNmE+etSgZJMQRQQ=
Date: Fri, 12 Jul 2024 18:14:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	kernel-janitors@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>,
	LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?G=FCnter_R=F6ck?= <linux@roeck-us.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] eeprom: ee1004: Unlock on error path in probe()
Message-ID: <2024071235-exposure-overkill-356a@gregkh>
References: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
 <19bb8ed0-e783-49aa-a4cd-6a0c3b89f0a8@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19bb8ed0-e783-49aa-a4cd-6a0c3b89f0a8@web.de>

On Fri, Jul 12, 2024 at 05:42:12PM +0200, Markus Elfring wrote:
> > Call mutex_unlock() before returning an error in ee1004_probe()
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(mutex)(&ee1004_bus_lock);”?
> https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/mutex.h#L196
> 
> 
> Would you like to refer to the function name “ee1004_probe” in the summary phrase?


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

