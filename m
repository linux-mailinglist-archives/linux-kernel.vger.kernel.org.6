Return-Path: <linux-kernel+bounces-330883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADCB97A5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BFE1F292C9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7361591F1;
	Mon, 16 Sep 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5VxAWkbo"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2E158520;
	Mon, 16 Sep 2024 16:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502622; cv=none; b=TBJc46B8oixDbx6OR4TBhw/o4IanMRtnPhtT9LIH7QKkOj0BdfVpv806Mq2yZS1MA/TO1mxcVHh6XzIrJc+LNWIEEeBq/lIf6iHKI/0WyrOUipeqyPG24ayPWWLNIYUrtnJ+Tupjo95kWOiG3aSsnaaoHPaOJCtk8QTX1xfWVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502622; c=relaxed/simple;
	bh=wcfB+gPOVUTa+awJpkFA79RAeDVF6c7E9J8W3qRJpIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbydDraAV/C1XXY8eWCthGJgHfF+mcm7HJNA8nVx/Bqk2AbL+bWd26fjSUNtaYAkimw7IduUzIT+UycyXK3zQ17Fy/pm2gADZTjedjAvq+4yKiCn8tUaqCclSWrWlYofmzY45AKnC7yrpYrIfmaqUTxePz4PWPt7Ah9lvaIDCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5VxAWkbo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bE5B17akHYElzJ5mR3GWqx1CMfkku2Z6ZeebTYLXWuU=; b=5VxAWkboIbe3zj6/1xtYThiM19
	KYevRZQ/Ys0TaZWHWrWhkaBlc5xe/wz6+sFeCWBpD9TFUpW0ATTJ3jLi4+6O7VZtNy6g76LcahwVX
	TesyemiaEtWFKPPNG7ESq2wSdwQt7F5q9nMZEOCxv0ptaPndDaAKm+AtgYt1+6EcD8lk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sqECN-007Zhc-9E; Mon, 16 Sep 2024 18:03:35 +0200
Date: Mon, 16 Sep 2024 18:03:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	John Crispin <john@phrozen.org>
Subject: Re: ethtool settings and SFP modules with PHYs
Message-ID: <ebfeeabd-7f4a-4a80-ba76-561711a9d776@lunn.ch>
References: <ZuhQjx2137ZC_DCz@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuhQjx2137ZC_DCz@makrotopia.org>

On Mon, Sep 16, 2024 at 04:36:47PM +0100, Daniel Golle wrote:
> Hi,
> 
> I'm wondering how (or rahter: when?) one is supposed to apply ethtool
> settings, such as modifying advertisement of speed, duplex, ..., with
> SFP modules containing a PHY.

It should actually be more generic than that. You might also want to
change the settings for Fibre modules. You have a 2.5G capable module
and MAC, but the link partner can only do 1G. You need to force it
down to 1G in order to get link.

> Do you think it would make sense to keep the user selection of
> advertised modes for each networking device accross removal or insertion
> of an SFP module?

No, you have no idea if the same module has been inserted, at least
with the current code. You could maybe stash the EEPROM contents and
see if it is the same, but that does not seem reliable to me, what do
you do when it is different?

> Alternatively we could of course also introduce a dedicated NETLINK_ROUTE
> event which fires exactly one time once a new is PHY attached.

Something like that. I would probably also do it on remove.

It does not seem too unreasonable to call netdev_state_change() on
module insert/remove. But maybe also add an additional property
indicating if the SFP cage is empty/occupied. The plumbing for that is
a bit more interesting.

	Andrew


