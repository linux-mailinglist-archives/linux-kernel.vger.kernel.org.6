Return-Path: <linux-kernel+bounces-380075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D0B9AE89B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74827B266F9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7B1F6662;
	Thu, 24 Oct 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uVZINMTj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3E11E1A35;
	Thu, 24 Oct 2024 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779684; cv=none; b=VeERy9ID/p2mzbP8eqhqeyQfnY2bP/7iwABzIOWV12s1j33bKe3jeUuuvE+zE1GXwhrUrWBrT9C8TKpd0sUcYq/GOjhuue5yC0LiCWUrZYFaZjBkeKKZyMqjWxoKFqKfoukyaUJ+HshkSaVCCVMEu++0dE9MRuX9wWoPwRtQvOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779684; c=relaxed/simple;
	bh=VSTofTOBFBNIB24uAHSI5Juoady2wnezw+kYexDKOYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4RM+DcICHznTiY2ARB/pKUfeGizuv5mfVv3oXfx7alUnJ7O7mtkU6RcTAoPS8KcUSZ/9gFaCvzR2C2FWySNt1fD//8JLzrjzXo9bFqH9AT9CWZqv1+X3CpcXldkTGCPJBoI54yXLLzrN+BRlhxDDs1zrkLI+CClFBT9tiRzAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uVZINMTj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sQ8rUKi6u7FkGXvPVgc/LRKFKYmZc+1EaLUn74M7zfI=; b=uVZINMTj9yFVdiKRROvTAZc9aM
	BkX0uVp8P0JeAOcEG3Rql44PZkv0l+n42LomOJWHXWs2jfvXQYdD0es1nDV5Jy0ntcBqja2dIAYvl
	diY71XjiaT2H/1+Al+SWLs9rThYDvMsCQ/GdU4Zg5XTHSzRpbHAWOYvQ0mNLgbRli1/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3yi7-00B8IK-9k; Thu, 24 Oct 2024 16:21:11 +0200
Date: Thu, 24 Oct 2024 16:21:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add debugfs supported in this
 module
Message-ID: <6a231891-7780-4cf4-97d9-679c67e18474@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-3-shaojijie@huawei.com>
 <924e9c5c-f4a8-4db5-bbe8-964505191849@lunn.ch>
 <5375ce1b-8778-4696-a530-1a002f7ec4c7@huawei.com>
 <6103ee00-175d-4a35-9081-2c500ad3c123@lunn.ch>
 <0c0de40c-7bf3-4d98-9d25-9b4f36a91e0b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0de40c-7bf3-4d98-9d25-9b4f36a91e0b@huawei.com>

On Thu, Oct 24, 2024 at 10:06:14PM +0800, Jijie Shao wrote:
> 
> on 2024/10/24 20:05, Andrew Lunn wrote:
> > > > > +	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);
> > > > Is this interesting? Are you clocking it greater than 2.5MHz?
> > > MDIO controller supports 1MHz, 2.5MHz, 12.5MHz, and 25MHz
> > > Of course, we chose and tested 2.5M in actual work, but this can be modified.
> > How? What API are you using it allow it to be modified? Why cannot you
> > get the value using the same API?
> 
> This frequency cannot be modified dynamically.
> There are some specification registers that store some initialization configuration parameters
> written by the BMC, such as the default MAC address and hardware FIFO size and mdio frequency.
> 
> When the device is in prob, the driver reads the related configuration information and
> initializes the device based on the configuration.

Does the BMC have an API to set these values? And show these values?

	Andrew

