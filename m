Return-Path: <linux-kernel+bounces-526721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EADA40268
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7690B1897F02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C06255E36;
	Fri, 21 Feb 2025 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aLBk2Vrc"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F92255E33
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174813; cv=none; b=OLdB2fDXrI/cTv0HKxVhmk/7A8brp7HGD2m6NjFWhD/zmb/QU4W5J83XUdsR8TE191hFGyWv4OK+F6AEJSoQ51W70vRtRBzKlU+mLYAzTsxyf0MW8+jfsVwMYlQ8JeqW7iuUmkIoqbfD0BmacHesCxppZwx0tkbtWfr0sayKSJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174813; c=relaxed/simple;
	bh=jD1UHBj/5BpnuO45s3LMfMn45Ou7M8qSe5D6YffY3wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGPygQ98VQkGWc3PwPtQLAYFrGpVGP4H5mssGGfyIGiIoG09udlcd5XH0K+8irnnoQpf5s8uwrl7RgtdtFK5LOeBs3ZBMHGeAyNmyVBG7ydpv+vq07MAhGJbEsy14j83cSKweLJn+pGlOL1ljNKwz3JW1Ff8t/lRzM1iHMiit8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aLBk2Vrc; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kAP8eop3O7GR+A6CqIyEeQtqDRTGSTC0Z9XT4Ce5THE=; b=aLBk2VrcsBJW7jnMYXuwVda+aV
	Hbzk6iKeWjoj80LZKAtwRv/tgEfohDTqbwsOClXGFp/7UGhfjYsi1SHSgrhFQqVP9++C+G19KjSNE
	GHBlk4BVHMJvenE1hStXZzQl4bELedpgC1H8YUihOjRNBbh32PQ+EnUf5aT9l7Z44qCXdi0lN8L5k
	rLHEVQb8v/+vV9urCzb3lpKzoUSs5BHvmgyK6DrMElRx9SeO7Pudy3M3tumYD/iGsLwDPVrF6k19R
	o92lBFDg/k7amU0VBayeEhFsoSA/d40ueZw0doZpAG08hEDwmWCyTwyTl1Iv3AauZfATN23ITONN2
	7I1iMFxQ==;
Received: from i53875a87.versanet.de ([83.135.90.135] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tlaxV-0000xw-Ha; Fri, 21 Feb 2025 22:53:21 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Chen-Yu Tsai <wens@csie.org>
Subject:
 Re: [PATCH v2] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
Date: Fri, 21 Feb 2025 22:53:20 +0100
Message-ID: <18716872.sWSEgdgrri@diego>
In-Reply-To: <c50c6053-4569-44b0-943d-5450960be147@cherry.de>
References:
 <20250218211044.2256762-1-heiko@sntech.de>
 <c50c6053-4569-44b0-943d-5450960be147@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Freitag, 21. Februar 2025, 17:43:08 MEZ schrieb Quentin Schulz:
> Hi Heiko,
> 
> On 2/18/25 10:10 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > Jaguar has two type-c ports connected to fusb302 controllers that can
> > work both in host and device mode and can also run in display-port
> > altmode.
> > 
> > While these ports can work in dual-role data mode, they do not support
> > powering the device itself as power-sink. This causes issues because
> > the current infrastructure does not cope well with dual-role data
> > without dual-role power.
> > 
> > So add the necessary nodes for the type-c controllers as well
> > as enable the relevant core usb nodes, but limit the mode to host-mode
> > for now until we figure out device mode.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> While the USB functionality does work for both ports, and the 
> orientation is properly reported, it seems like there may be some issue 
> with how the PHY or controller interacts with that info because I do not 
> get USB3 speeds when the device is inserted in reverse orientation, 
> while I do when it's in normal orientation.

I've tested both ports and saw the issue too.
Interestingly on the usbdp-phy side, orientation detection seems correct
and also the sbu pins are set accordingly.


> I assume that's the case for the Rock 5 ITX and Orange Pi 5+ as well and 
> probably has nothing to do with the DT?
> 
> Should we go still go on with trying to merge this patch knowing that? I 
> mean USB2 is still better than no USB at all :)
> 
> +Cc Chen-Yu, owner of an Orange Pi 5+, who may be able to confirm the 
> issue is widespread.
> 
> Cheers,
> Quentin
> 





