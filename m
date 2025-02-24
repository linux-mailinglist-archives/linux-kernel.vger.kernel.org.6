Return-Path: <linux-kernel+bounces-529570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A801BA427EB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BBB77A4EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30DF262D2A;
	Mon, 24 Feb 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d9JmCcSM"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C125B674
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414630; cv=none; b=Kx2L+uw1OJzbNqzWFHcNKPEc1v+87z76/yWhD4j0m/hAyfII+X1dqE82ZNwKDuWUGcyKXr9tZECWXsvpa5vIgf/SIv0U+6huPBWMo4gsHK2VEUYLi1EAd0scZD1sDWnrc/I+WOJPRSw48qYxPCf1lqTFbOYNc+kOf+l5A2yEuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414630; c=relaxed/simple;
	bh=TTVassHYhWecOjoD9XKV0geJoC9VWUs486i3kWhg8kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZMpHb3hKhKjJw6beRGsnF47FicC8AxSvurPklO7d3SDTW5qusVkiN5bC2QLMr7AzTvpzYeyV1Tabn9nFXEmjkIqe09X4j0nwVmYYxJRRlye/Z0rKbIL4VTwcifH3vqvzn7cGDuLxW9IqQ1lt4pSX6btZkRswIEH4n2Un2M0EJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d9JmCcSM; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e02a5ec-8bf7-4ea3-8e3d-722f7f67aed3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740414616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FF3mSkHdJ/yXoVZIDRtA1yH1mcpw7mPqAi4+n6pHWJI=;
	b=d9JmCcSMjxyFfcKacJk380+J5/KDkHXRR66u4SIkEHt/E0cAPsS9SfpkIYVB+x9GKoGBBm
	3YHMo/C9NUzHk2JvyrJdLCoMVb7ntJp0g6KTjLLdYqFfOKySNIha6bYZivHxwtIxsuS7zU
	Y7WttZ35zcHWVJ/wgccCGpawJysA6kU=
Date: Mon, 24 Feb 2025 11:30:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/23/25 12:28, Maxime Chevallier wrote:
> Hi everyone,
> 
> Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" designed to
> access SFP modules downstream. These controllers are actually SMBus controllers
> that can only perform single-byte accesses for read and write.
> 
> This series adds support for accessing SFP modules through single-byte SMBus,
> which could be relevant for other setups.
> 
> The first patch deals with the SFP module access by itself, for addresses 0x50
> and 0x51.
> 
> The second patch allows accessing embedded PHYs within the module with single-byte
> SMBus, adding this in the mdio-i2c driver.
> 
> As raw i2c transfers are always more efficient, we make sure that the smbus accesses
> are only used if we really have no other choices.
> 
> This has been tested with the following modules (as reported upon module insertion)
> 
> Fiber modules :
> 
> 	UBNT             UF-MM-1G         rev      sn FT20051201212    dc 200512
> 	PROLABS          SFP-1GSXLC-T-C   rev A1   sn PR2109CA1080     dc 220607
> 	CISCOSOLIDOPTICS CWDM-SFP-1490    rev 1.0  sn SOSC49U0891      dc 181008
> 	CISCOSOLIDOPTICS CWDM-SFP-1470    rev 1.0  sn SOSC47U1175      dc 190620
> 	OEM              SFP-10G-SR       rev 02   sn CSSSRIC3174      dc 181201
> 	FINISAR CORP.    FTLF1217P2BTL-HA rev A    sn PA3A0L6          dc 230716
> 	OEM              ES8512-3LCD05    rev 10   sn ESC22SX296055    dc 220722
> 	SOURCEPHOTONICS  SPP10ESRCDFF     rev 10   sn E8G2017450       dc 140715
> 	CXR              SFP-STM1-MM-850  rev 0000 sn K719017031       dc 200720
> 
>  Copper modules
> 
> 	OEM              SFT-7000-RJ45-AL rev 11.0 sn EB1902240862     dc 190313
> 	FINISAR CORP.    FCLF8521P2BTL    rev A    sn P1KBAPD          dc 190508
> 	CHAMPION ONE     1000SFPT         rev -    sn     GBC59750     dc 19110401
> 
> DAC :
> 
> 	OEM              SFP-H10GB-CU1M   rev R    sn CSC200803140115  dc 200827
> 
> In all cases, read/write operations happened without errors, and the internal
> PHY (if any) was always properly detected and accessible
> 
> I haven't tested with any RollBall SFPs though, as I don't have any, and I don't
> have Copper modules with anything else than a Marvell 88e1111 inside. The support
> for the VSC8552 SMBus may follow at some point.
> 
> Thanks,
> 
> Maxime
> 
> Maxime Chevallier (2):
>   net: phy: sfp: Add support for SMBus module access
>   net: mdio: mdio-i2c: Add support for single-byte SMBus operations
> 
>  drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++++-
>  drivers/net/phy/sfp.c       | 65 +++++++++++++++++++++++++++---
>  2 files changed, 138 insertions(+), 6 deletions(-)
> 

For this series:

Tested-by: Sean Anderson <sean.anderson@linux.dev>

With a

FS               SFP-GB-GE-T      rev F    sn F2030222359      dc 200729

See [1] for the original "bug report." Note that as discussed later in
the thread, this is a Fiber Store (fs.com) module and not a Finisar one.

--Sean

[1] https://lore.kernel.org/netdev/55f6cec4-2497-45a4-cb1a-3edafa7d80d3@seco.com/

