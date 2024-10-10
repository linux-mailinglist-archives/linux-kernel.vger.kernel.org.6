Return-Path: <linux-kernel+bounces-359981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF5999334
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E62F1C22C34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D751CF5C5;
	Thu, 10 Oct 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HFaHqye8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17461CBEAB;
	Thu, 10 Oct 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589998; cv=none; b=CnGx/1d/XW1rVArpsm+yfKIzulCMC2lYYAcushFlDJ8VYqX9kq1lB7SXb0n9aPqPS65HQNaNuxKw9Tum8RQ+bbriFPGzIcsUaHeyuVX4xIyRjeJ4Qu86V5CpaYHxGuuGDP3IezHiX3LVuEppUBYX4sjvFZhnbHdyhjM3eySazJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589998; c=relaxed/simple;
	bh=gLLejnF18JRaBdqLMMz0kV/sqCjBfUTWGoq1CF3hyso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuvH+wlfxQLEJ17l1aRIskwiSOJWuGQxM+w41taZXWHYJOdkGbjhwq3PHelZHo1p6kUhTHXd4tPgbpxUU5LDMU2kdHtgTte1LoOKvo9KP9z6H7mh2MUPzAOCV+9QezKnw7LIoba/sYZlhcrzcV3/Q8FKkm2xPciEHcc6AqQnFR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HFaHqye8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oPrHANtDfaFu++DyXSV355UVRr83DEBqjiYMk9rKCkk=; b=HFaHqye8gT7FD1vFqxAaukg2ij
	OGo85Yu7PRdhCVVbXMx0lu6YUYURb+nG4LaY1duqe5AWsCxD+Moe6nE7ax1Yg6vGX6b+1CBWb09Rv
	m7lRHcEUujVeKsgCQ7GFvQ3Yg1QA//JbZIG366o+QSvBtm+6AMuq7CjYDU9c1Qvmkl4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syzDb-009eKH-4z; Thu, 10 Oct 2024 21:53:03 +0200
Date: Thu, 10 Oct 2024 21:53:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Iulian Gilca <igilca1980@gmail.com>
Cc: igilca@outlook.com, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: net: Add option for random mac address
Message-ID: <b4d4090a-2197-40ce-9bb5-1d651496d414@lunn.ch>
References: <20241010190508.196894-1-igilca1980@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010190508.196894-1-igilca1980@gmail.com>

On Thu, Oct 10, 2024 at 03:05:03PM -0400, Iulian Gilca wrote:
> Embedded devices that may not have fixed mac address
> may want to use a randomly generated one.
> DSA switch ports are some of these.

Sorry, i don't follow what this patch is doing. You are looking in DT
for a property "random-address". DT is static, so how is it going to
be random?

I also don't understand you use case. Generally, a MAC driver will try
to find a fixed MAC address. If one cannot be found, it generates a
random one.

For DSA, it takes the MAC address from the conduit interface for the
user interfaces. If userspace whats to use come other MAC address on
user ports, it can change the MAC address in the usual way.

	Andrew

