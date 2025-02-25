Return-Path: <linux-kernel+bounces-532260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F985A44ABB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCDC47A2584
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0EC1A01CC;
	Tue, 25 Feb 2025 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="StJD/FFz"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2414F9C4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508939; cv=none; b=JfgNocCjWrM1clNy4C/MDIsfHsdXTZ0bjK2z39NqYS8IIFQcU2DQ4owaW+lHtjW+1aTWnhxCDuOfx/LKJvaoD69ACHtR4N0no2hHXcxXbQL3xwuxXia2Nzephw8lBLvIy5Cn1TmTH0rn690r2ymLxjHi5qDXaq1sBRo/PwpQaXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508939; c=relaxed/simple;
	bh=GiLzflQqnYT63CKA1QIohp0eMWR5pxFRNdl+pFZXxr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5tgAiIbfpSx8ixfRoMh2MFb57Y0Yqi1wmD+lOWpRjlrjaz//irugILy/MyXFzhNhhW5L8ENwhOrhBVq2Iy6EhWWbj1Erbvzqigea3OafXNR0A5cvMTQP7UgqDJTVcPfTfRI79p0+BIfqjiOPyr+pbGm1tpB9UELYY3YkHH3a7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=StJD/FFz; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd630175-d0e4-41e3-bc4c-41d32647e9ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740508932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poK85tAG9kc5+agyzOdb9jltGXyCsuZa9R+6oO7Rx7U=;
	b=StJD/FFzkuVleq2d0UK1wOXi4UY6DIy8AC91U6gelNR9Z0rFdfrHnLcZgKr78PSvMTpDdy
	BRj27YNyy1Uj6Alu+GcDomRZvOctukjcypF38iok6QeKpWdhXvGMMTCc/JeYL9CqSrNmvX
	ymXe24OwQ6yZic0H6cKguDqJL+FVGpg=
Date: Tue, 25 Feb 2025 13:41:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] net: phy: sfp: Add support for SMBus
 module access
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20250225112043.419189-1-maxime.chevallier@bootlin.com>
 <20250225112043.419189-2-maxime.chevallier@bootlin.com>
 <Z74GLblGUPhHID8a@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <Z74GLblGUPhHID8a@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/25/25 13:04, Russell King (Oracle) wrote:
> On Tue, Feb 25, 2025 at 12:20:39PM +0100, Maxime Chevallier wrote:
>> The SFP module's eeprom and internals are accessible through an i2c bus.
>> However, all the i2c transfers that are performed are SMBus-style
>> transfers for read and write operations.
> 
> Note that there are SFPs that fail if you access them by byte - the
> 3FE46541AA locks the bus if you byte access the emulated EEPROM at
> 0x50, address 0x51. This is documented in sfp_sm_mod_probe().
> 
> So there's a very real reason for adding the warning - this module
> will not work!
> 

I had a look at sfp_sm_mod_probe, and from what I can tell the SFP that
I was having issues with should have been fixed by commit 426c6cbc409c
("net: sfp: add workaround for Realtek RTL8672 and RTL9601C chips"). I
re-tested without this series applied, and the SFP still worked. So I
guess I don't have an SFP module with the issue this series is trying to
address after all.

--Sean

