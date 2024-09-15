Return-Path: <linux-kernel+bounces-329910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767FE979757
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90471C20CA5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAF1C9848;
	Sun, 15 Sep 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WBAlSpT1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CC11CF93
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726412228; cv=none; b=CpaKqTL69HTH9E1e0u+k1KCoZ8sbbSLuaWiAno81ajMoWITttfsyPVgS3orKizBdLA6k9uy3r640dysMPvACY10FBPVa+RG/j0EiqDEl1eaCFvRV0Jzf1mM+i2/inSEYTaqVC5e0PHVpKceRlyi+ObOE12JODZMCf+M060hGTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726412228; c=relaxed/simple;
	bh=sOxojxoDT9X4oE2v9K+92jOwJIFizkpF2BS7qTBwZBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxAXtP55TzqKGqaphKzBADbpjuOCHjScq8JW/IAkYWYW6mW2VuuEiQd6JZcD2N7Dwxp9kxi6Yenvn8dMXFICuoqH98eHKDG5kXhnZAKcKfJrW1ZvCk7HTaVLbSIGmfJMv+79qJ8UL3OXhUzDYNEivf26FaIXEbQXewLxFpk9dC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WBAlSpT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB944C4CEC3;
	Sun, 15 Sep 2024 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726412228;
	bh=sOxojxoDT9X4oE2v9K+92jOwJIFizkpF2BS7qTBwZBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBAlSpT1tqOfIsYyhA0ifrcFnHSNKAFHp/8Yt9mfAG9Q1SEjTcXJaNb3j2bOZK4Pc
	 NwQv5aUNo89brF48isxbnk7LVuF8Uj2jPReSwEUiB9YaslQRZd0kWcY+da2LvkKuET
	 0wCnxELHXUK+YZjqYLQJJIDmsXh5j79y4Ly/+3N8=
Date: Sun, 15 Sep 2024 16:57:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH] driver core: bus: Mark an impossible error path with
 WARN_ON() in bus_add_driver()
Message-ID: <2024091510-scarcity-roman-4776@gregkh>
References: <20240915-bus_add_driver_fix-v1-1-ce5cf1f66601@quicinc.com>
 <2024091530-antacid-magical-8302@gregkh>
 <8620a8a6-9101-4f53-858f-2e09aa310d16@icloud.com>
 <2024091540-scrubber-navigator-4aae@gregkh>
 <506644dc-4ca2-4284-a557-eb0ef4bf36bd@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <506644dc-4ca2-4284-a557-eb0ef4bf36bd@icloud.com>

On Sun, Sep 15, 2024 at 10:36:44PM +0800, Zijun Hu wrote:
> On 2024/9/15 21:55, Greg Kroah-Hartman wrote:
> > On Sun, Sep 15, 2024 at 09:38:15PM +0800, Zijun Hu wrote:
> >> On 2024/9/15 21:00, Greg Kroah-Hartman wrote:
> >>> On Sun, Sep 15, 2024 at 06:22:05PM +0800, Zijun Hu wrote:
> >>>> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>>>
> >>>> driver_attach() called by bus_add_driver() always returns 0, so its
> >>>> corresponding error path will never happen, hence mark the impossible
> >>>> error path with WARN_ON() to remind readers to disregard it.
> >>>
> >>> So you just caused the machine to crash and reboot if that happens
> >>> (remember, panic-on-warn is enabled in a few billion Linux systems...)
> >>>
> >> are there good way to mark a if condition which is always or mostly
> >> evaluated to false currently without any side effect?
> > 
> > If always, then remove the code involved.  If mostly, just do it
> > normally.
> > 
> >> i think this is a generic requirement since readers may not want to
> >> care about things which will never or rarely happen, below link
> >> involves such discussion:
> >> https://lore.kernel.org/all/2024090444-earmark-showpiece-b3dc@gregkh/
> > 
> > Yes, but likely/unlikely is for performance, not for documentation.
> 
> if you git grep unlikely in current kernel tree, you will find
> that there are too many unlikely usages which should be irrelevant
> performance. you maybe look at drivers/base/devres.c.

Yes, and they should be removed, we have someone that normally sweeps
the tree every few years and runs a tool that can compare if those
actually are correct or not, and usually not.

> so i think one of purpose of unlikely may be for the requirement i
> mentioned.

Nope, sorry, performance only.

thanks,

greg k-h

