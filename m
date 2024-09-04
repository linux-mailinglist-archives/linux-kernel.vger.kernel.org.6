Return-Path: <linux-kernel+bounces-315319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57E96C103
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711D61F23987
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892F31DC054;
	Wed,  4 Sep 2024 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UABL7fnt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9295C96
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461052; cv=none; b=bkw3KjgS5xEdg9ezU9HA95qNHz9BMnjo77KZ0f2P0e4TWWf1e1GcD7xS/+oCadH9vJEvwu7GFwdIUKNPRRKPj0OV6rZivhVp5+S4wmLRddKR3uxnqu3gP1tkMjcfFdAH71XCLlkqjFYrU1Kh8q4m6PBNMbJ6d4OavGptTf9yYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461052; c=relaxed/simple;
	bh=CAIw+4wTPiz65OXVJGs2pAr4a4+dZO5V/QzvwtPHm28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMpsMKzIROGxRFTGy1p5xA9CIocbl0CE5tAcYNBUzx6wFANENngGYXz1ysRqy9/v2zS0Z/cc/qfL0MBAPU+3NBQsKv2UZKq5i2gRzmzSoSHCqwwRoIPY2gC2UyEuE75bL8aifofG5pkr32QtgD+mS+C5EzD3+nQsPlRYHSXUMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UABL7fnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D505C4CEC2;
	Wed,  4 Sep 2024 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725461051;
	bh=CAIw+4wTPiz65OXVJGs2pAr4a4+dZO5V/QzvwtPHm28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UABL7fntSqh2JnXmufZf5K3Z0puGlEAdm2+nVG1MAl9vj0sRB9OyYFflsBOcTM9iS
	 Tj1wlxknPhhJRXJN0oidGBRuQJnIbHs0RE1Nc/Y+sZmgi5ItbyQtnVltoy20qMSlob
	 IEgMTZEQvR/l8wEbQ5UGKEzpGRSb97OYPUFSNsgU=
Date: Wed, 4 Sep 2024 16:44:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 3/3] driver core: bus: Correct API bus_rescan_devices()
 behavior
Message-ID: <2024090410-earphone-financial-9b72@gregkh>
References: <20240904-bus_match_unlikely-v1-0-122318285261@quicinc.com>
 <20240904-bus_match_unlikely-v1-3-122318285261@quicinc.com>
 <2024090403-viewing-snagged-4249@gregkh>
 <1b79fb55-26d7-4966-9260-d3cdf3e0e8c8@icloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b79fb55-26d7-4966-9260-d3cdf3e0e8c8@icloud.com>

On Wed, Sep 04, 2024 at 10:26:39PM +0800, Zijun Hu wrote:
> On 2024/9/4 21:54, Greg Kroah-Hartman wrote:
> > On Wed, Sep 04, 2024 at 08:56:44PM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> API bus_rescan_devices() should ideally scan drivers for a bus's devices
> >> as many as possible, but it really stops scanning for remaining devices
> >> even if a device encounters inconsequential errors such as -EPROBE_DEFER
> > 
> > -EPROBE_DEFER should not be an issue for scanning the bus, that's only
> > for probe errors, so who is returning that mess today?  Let's fix that
> > up please.
> > 
> 
> drivers/amba/bus.c:
> struct bus_type amba_bustype = {
> ...
>         .match          = amba_match,
> ...
> };
> amba_match() may return -EPROBE_DEFER.

Why?  That feels wrong.

> you maybe also look at below AMBA bus related commit.
> Commit: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from
> bus_type.match()"

Ah, ick, clocks.  What a mess.

I don't think we need this anymore with the genric device link stuff
anymore, but I'm not quite sure.

> is it proper to change bus_type match()'s return value type to bool type
> back if this issue is fixed?

Yes, I would like to.  Care to look into it, odds are you can test this
better than I can :)

thanks,

greg k-h

