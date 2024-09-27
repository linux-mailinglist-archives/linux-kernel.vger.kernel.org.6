Return-Path: <linux-kernel+bounces-341870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F941988784
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C635EB216FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E831C0DD2;
	Fri, 27 Sep 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="bYiorruj"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7F158521
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727448506; cv=none; b=haHDbf0rWPRoOYipZQfSm8RM69iXRPOFG7veaqt8Ion519Fv3Mc/b7m7SIobpL9cIQPwgwvdGtJVxfav/PIITFP1/ycLchuKrEsY1EEJbyUTfppW+QEeafJlr63LUvZfvSiRAhs06vfsEHgO615ux817YpSaFQmVlVU386e0+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727448506; c=relaxed/simple;
	bh=d7zc+uqiXFPitn+KyLsTdoo2A6Uo6JRLD0/ngQQeyMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0IHwPi4vcOqNaZEEUNTt9tarh3mTIRXLLOXBzkifDzYKwvzLw2SzNZiMjw+NH2yTBNNdRPSib8hRzGL6KpCiSaNU0IXZsnXC18ksUX+cFvBFz/1k6DiZztOGFh0cxozcS0+oexbuG867ZpFFewKedwFhHhpu86xFDH0jxX7zb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=bYiorruj; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e7+ejxWy+FeNgwZderI1+RcWjnrYFg9VpnRoJUCKCvM=; b=bYiorrujtwke8PNwVODF4XACP2
	ZhKpOflMsOponGRFEPKZSMfOqy5+wVzPAeQDK4eriIysfZrYS8nS2nO8BB+C2Kjxe9Tb8LFSNloQB
	ZvkkSmZXRVV1QvkaLCyd17FsXfxj/WvYvzu3UP5ou6kX/Zel4CbjNRvntxRRFI5Dx0XdyzGGl+mGO
	6SaPBUOFv66UlsRL1dCD4PXfsF6Bx5LMTOcb7VLjTDokuLeUBb0w1XMihUiTdNRPo5QV7CFUpnr+I
	ESpNVcZvsvurjKD+w0C7KUv4EhtFKDr1Ancok/q0xbc31hD0JoPeLf7xuPbhj7lqoSeko7hmklrxF
	Ykba9Nfw==;
Received: from 85-160-70-253.reb.o2.cz ([85.160.70.253] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1suCGd-0006Q4-EV; Fri, 27 Sep 2024 16:48:23 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jakob Unterwurzacher <jakobunt@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add attiny_rst_gate to Ringneck
Date: Fri, 27 Sep 2024 16:48:21 +0200
Message-ID: <2507281.uoxibFcf9D@phil>
In-Reply-To: <75946cd5-8f6f-40fd-a218-66d399a0da19@cherry.de>
References:
 <69f79284-b52e-496e-a286-d7e5ce3d90ce@cherry.de> <3885598.FjKLVJYuhi@phil>
 <75946cd5-8f6f-40fd-a218-66d399a0da19@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey Quentin,

Am Freitag, 27. September 2024, 11:50:46 CEST schrieb Quentin Schulz:
> On 9/27/24 11:39 AM, Heiko Stuebner wrote:
> > Am Donnerstag, 26. September 2024, 15:24:03 CEST schrieb Quentin Schulz:
> >> Hi Jakob,
> >>
> >> On 9/26/24 3:20 PM, Jakob Unterwurzacher wrote:
> >>> Ringneck v1.4 can contain (placement option) an on-board ATtiny
> >>> microcontroller instead of an STM32. In normal operation, this
> >>> is transparent to the software, as both microcontrollers emulate
> >>> the same ICs (amc6821 and isl1208).
> >>>
> >>> For flashing the ATtiny, the SWITCH_REG1 regulator of the board's PMIC is
> >>> used to enable the ATtiny UPDI debug interface. If the STM32 is placed, or if
> >>> we are running on an older Ringneck revision, SWITCH_REG1 is not connected
> >>> and has no effect.
> >>>
> >>> Add attiny-updi-gate-regulator so userspace can control it via sysfs
> >>> (needs CONFIG_REGULATOR_USERSPACE_CONSUMER):
> >>>
> >>>     echo enabled > /sys/devices/platform/attiny-updi-gate-regulator/state
> >>>
> >>> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> >>> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> This is a candidate for backporting to stable branches as well I assume,
> >> @Heiko?
> > 
> > That is more on the darker side of gray here.
> > 
> > Looking at the stable-kernel-rules [0] the criteria is
> >    "It must either fix a real bug that bothers people or just add a device ID"
> > 
> > This change instead is adding a new feature to allow said flashing from a
> > running system.
> > 
> 
> This does mean that the new version of the device won't work as well 
> with an older kernel though.

"new version of the device" being the key here ;-) .

You also would not expect a new board dts or a new board variant to be
added to stable-kernels.


Heiko



