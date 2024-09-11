Return-Path: <linux-kernel+bounces-325175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BA975627
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DDEB2BAB3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA021A305F;
	Wed, 11 Sep 2024 14:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3rjDxk1S"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FCD1A3030;
	Wed, 11 Sep 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065678; cv=none; b=JFLgksTcGlY508HmkzJvzXD/3vScrORtqw3XorzcGAPZAt8pp9GTt1E7rbpPKK++fBohSBqFRtSqDrj9jkKW5pF/X5IcslFXy59TjMw2q/jBpDnQjEdENY+kzuJQgnc6G+bExApZqh86urBDWP+KHGhS+eCyIrj+ZphXxJf4vvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065678; c=relaxed/simple;
	bh=3Z/oed22zgRXX/UWxZEvfrVoDzpUzLNfFriEfxP+4+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJSazqJlcBtMXp42snmPQVjnGc5z2ofBreRIioHY2M0NORJ3K/zU+mxowr2bRnj/GIFJ4VNzs8tCZA+Q2+7mpIC1gtU5xq2IxE8n9amQ/bYZtJaycAoPSxmV3Y5SH7z8hXpYxzAXpxKERQqd3FKD5/BxlrZtIOr4VL/VtDwh3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3rjDxk1S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cwX/d7s8taJ27bBmNgSIlqFsFF6eCFJzdq+jAwfqESY=; b=3rjDxk1S1+AJVgfJlvcVlviosV
	BOHjldbf7yHNBu81t5tp0U5jZGeD0DdqI86y4ED6PLUmTK1jiSMlDQgsuuPevhdlw60oOXn3d4lTm
	fqvXubYxCqsNDlp0l+FIUb5IyD0QaMcy+kjtCzaD6WjyBXSXl+wdKeY8+MFhU88xtwA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soOWl-007DaL-Mq; Wed, 11 Sep 2024 16:41:03 +0200
Date: Wed, 11 Sep 2024 16:41:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com, jdamato@fastly.com,
	horms@kernel.org, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 net-next 11/11] net: add ndo_validate_addr check in
 dev_set_mac_address
Message-ID: <a167de50-9759-4ba6-97a6-96cd6356fdc3@lunn.ch>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
 <20240910075942.1270054-12-shaojijie@huawei.com>
 <CAH-L+nP2oy4Haw1+8Jy3GGgphxBii8m2zD03FXbC0SeR7QdhQg@mail.gmail.com>
 <dbc5f648-4fc0-48f6-be71-cbecd1f54522@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbc5f648-4fc0-48f6-be71-cbecd1f54522@huawei.com>

> This patch may not work as expected.
> 
> ndo_validate_addr() has only one parameter.
> The sa parameter of the MAC address is not transferred to the function.
> So ndo_validate_addr() checks the old MAC address, not the new MAC address.

Yes, i agree. The current API does not lend itself to validation
before change.

> I haven't found a better way to fix it yet.

Maybe in dev_set_mac_address(), make a copy of dev->dev_addr. Call
ops->ndo_set_mac_address(). If there is no error call
ndo_validate_addr(). If that returns an error, call
ops->ndo_set_mac_address() again with the old MAC address, and then
return the error from ndo_validate_addr().

It is not great, but it is the best i can think of.

Since this is not as simple i was expecting, feel free to drop it from
your patchset, and submit it as a standalone patch.

	Andrew

