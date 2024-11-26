Return-Path: <linux-kernel+bounces-422366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BAF9D98AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B054163390
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25B1DF49;
	Tue, 26 Nov 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="cGTHpe+P"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E7C8EB;
	Tue, 26 Nov 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628394; cv=none; b=pdESCFL5F5VX/aKO5HLDHX5LaQhiqPfarkSs8uU7qhtCrDW7hoAz+OhAMMTVdzFUcafKjf4eZmxtTvEc3jY791x0YBNkz4rUQiZrGL10i0biCwOr3znhViAi4YfxNgVrgADSn5S/OBegrHQMFy4anPhy9ix9UF20jXAuLQFm6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628394; c=relaxed/simple;
	bh=E9pUbK72JOvDbvWr6iCrPeY/6XaWCCuTh5wTNQ0T4+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmqf/DCUUnaCBI9pDH/dcIfSchBtUFaSUh91/BPixY/7BIYVII93uqtmt9akAyP3+dtFt5t1pLSwGp+EHL3hT5ffCj7i1naetGz926UTsqeJA+mHSkVcgvkpUWrrHhQgsSc4RxePj/kyWi4czorwNLvh7VULHWSkr6SzYffyEVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=cGTHpe+P; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tN0r84mltrzWKXImKJPU4zA3MIm8jfWmB/JmJnj+81A=; b=cGTHpe+PbK5cetpMFRQwt0vOma
	IKOaMrbpCHEttoujvWhb+esxr/IJylAxWpnIf6oPVztXWgiIozWpdwCcf5nlzE+qPrPWhc2VhAZEJ
	9lMJA34Trj5JhmDmUP8Kjgrua3Ij5DkAvWZnZJfr2pA8XO0cCIp4Ip3e64gcjWnzrTZcwJXIPKkku
	0ehWv/PL65V1Tqft1Arq2nPDfKaWG+a/8EcBFJRI6vlcEpojC8hjuayzHEWJC2ckVroBpSWKBYbsF
	fEiNoXJMQXoQXWkUO7WmkS4XTFm15tcnvC+A5qasNX5771F3SNdgtXBC2+igR8zN20Zb/jSMKGS/N
	S3umjoAw==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tFvmZ-0008Sx-N7; Tue, 26 Nov 2024 14:39:11 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 quentin.schulz@cherry.de, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 3/3] drm/rockchip: Add MIPI DSI2 glue driver for RK3588
Date: Tue, 26 Nov 2024 14:39:10 +0100
Message-ID: <9368781.CDJkKcVGEf@diego>
In-Reply-To: <D5F4UD59MUJG.2HFCTRSPELO98@cknow.org>
References:
 <20241106123304.422854-1-heiko@sntech.de>
 <20241106123304.422854-4-heiko@sntech.de>
 <D5F4UD59MUJG.2HFCTRSPELO98@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Mittwoch, 6. November 2024, 14:33:25 CET schrieb Diederik de Haas:
> > +#define IPI_DEPTH_5_6_5_BITS		0x02
> > +#define IPI_DEPTH_6_BITS		0x03
> > +#define IPI_DEPTH_8_BITS		0x05
> > +#define IPI_DEPTH_10_BITS		0x06
> 
> Possibly dumb remark (sorry):
> drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c also defines these
> values, so wouldn't it be better if they're defined in 1 place?

they are quite device-specific, so for me it doesn't really make sense
to try to centralize them. I.e. these are the values that need to go into
the GRF register to select a specific depth and are more or less the
same by chance.

I still remember quite well the answer to why Rockchip hardware engineers
sometimes shuffle around similar grf entries between socs "because they
want to" ;-)

At least for the rk3576, they seem to stay the same for now, though part
of me just expects the values to change in the future.

So personally I'd like to keep them where they are :-)

Heiko



