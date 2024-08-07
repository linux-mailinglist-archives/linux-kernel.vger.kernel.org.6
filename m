Return-Path: <linux-kernel+bounces-278469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0D294B0A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4822B23490
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0C41465BF;
	Wed,  7 Aug 2024 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="WzdOIO09";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l8ma3b+r"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307271448FF;
	Wed,  7 Aug 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060108; cv=none; b=rgZLOsZDtgcXGPfyMGQYTS0MUm1D/GOanR7aegN/BKTdrWmZYa9tAQxFEdPPSlA22fsUJi2qE1Nq4vCInJcTMSX24XGhwhym1OwWgpheD0vjupo1T2hWeMfbAlOiFkbrPCS/KBICKD1eGqgdVEnBqMdhR7T0r/3TZXS4VDz4pjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060108; c=relaxed/simple;
	bh=AxWnwCIkk1T2IX7npYkbTtiEviZmWYipWVqeuFPz+u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2kGyFRrtR4zC7atU2j35KSnFfZizfRndYjfufqJUOrXidhVPSZhwCt0hA3mzjDeSz9Q6Ok5iopOEqIVOQoC73bymK5QUt0HCx40wTxkGnPH9XSOGXkoBXaFyE/yZpnK8Onk/lYuIRzirSHhTifZNptDNj3innMw4l1pdaszJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=WzdOIO09; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l8ma3b+r; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5214C1151127;
	Wed,  7 Aug 2024 15:48:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 15:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723060105;
	 x=1723146505; bh=WqIAsC3nNZca859GcENtmVYMTR1G28vKUTVcJQ7Y3Ng=; b=
	WzdOIO09v6ZJbT/RLQwC3rKwV8sl9gmCfMfXoaw0iZVqBsBjOJpjxMoQrIXcQ7nI
	Zbyl3xhBdjS910qMmqO9dfgBUeg6lHMwnI1Mi4BfsJeAcckOBwtE+2fQhLR0s20S
	iATHkONVNBxaMRDQgTsjYEXzSvJNodAT9mODHoUaiHSBTLGt5pJ6UkgToA2hHwdu
	aswm1C3jRF/sHtNbQl6daq9cXOCJRXwZTO4riZCuFr6BMkjQYickbEuYTO1TUetw
	uQ8FMrR3+cC3H1U+J2hzK2i7t+AQRSDrsjx5XNdnDJF21+nkSjckIl2Uy3a9X28h
	2/kQq+LDwR1wD0E3CRq8lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723060105; x=
	1723146505; bh=WqIAsC3nNZca859GcENtmVYMTR1G28vKUTVcJQ7Y3Ng=; b=l
	8ma3b+r2CbKRNmGtIol3bjattsK9IFqzqirG7h1EUEkvUrzEY9jf68pPLTuRiVER
	BldvwFSW7xn8ZZYEBx/dmHIL2pscLhMbR1VOh9XUG7UFUTkU8adXdSrfiDSaCKs8
	kjHqWDJYvaFXMfYw/Dvw5zxafGolhd1VX8sWc9vQgD8TYUfbZZPSD2CQD/WmIjZP
	lfIIJ4aEY6kbLA5N3mJOc3Ut8C9JggfrJ0nFlyDrb5yBn80czAbIkeCshNURrjjt
	O68JKhiWHubxtIh//8uXitATkXsUL2DUSOtfRnNwsmDdkloaYbBebZKKn0LYxe96
	AYPw+RoNeJpk0XhduRmfg==
X-ME-Sender: <xms:iM-zZot5iDPkDSCkud4KCnhe6csrkwqBPXdyQTFLbc0gjaANT40mAQ>
    <xme:iM-zZle-aGwATy8QVztMSxW1ZXmS5oNoHzL7yxuDYby5LRVjd8-93h203ulMJSFdP
    SAxyx49xHN1bAWKaOk>
X-ME-Received: <xmr:iM-zZjyNLyXxbukOZcWKvXbJm1cwe-Mou5mlAARMH5jGHn7h1qggfBX5n3xgb8FxDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeftrghf
    rggvlhcuuegvihhmshcuoehrrghfrggvlhessggvihhmshdrmhgvqeenucggtffrrghtth
    gvrhhnpeeuffefgedvkeevudeiieekhfduteegffekfeehleektefhkeegfeelffduheef
    leenucffohhmrghinhepnhigphdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhessggvihhmshdrmhgvpdhnsggprhgt
    phhtthhopedt
X-ME-Proxy: <xmx:iM-zZrN2Vg7Cf3jU_syOcEn4F3meu02PuGRFQJDH1blYxfJBAC-Sow>
    <xmx:ic-zZo8gvayU3JFZs_UVzK6WbMi7yliSf37Tni8UpBnqEYMgZvNaPg>
    <xmx:ic-zZjXzgf6fv7gcH4a4lct2794_Z9injKeGDK6xLqGH61gsX9F5CQ>
    <xmx:ic-zZhe9T7tO-MFvuZTcysJEeFtsuIy3kJMViBt2ahC8K1z7El2oHQ>
    <xmx:ic-zZrevQPH5DQuLYVCzPJmvfrXp4HcHMp4i-O9i-gkfpZRPQgBolIp9>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 15:48:21 -0400 (EDT)
Message-ID: <ee39f8ce-683d-4144-909a-972ce74b95d8@beims.me>
Date: Wed, 7 Aug 2024 16:48:19 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] arm64: dts: imx8-ss-conn: add PPS channel to the
 FEC nodes
To: Francesco Dolcini <francesco@dolcini.it>, Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rafael.beims@toradex.com
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-5-francesco@dolcini.it>
 <ZrOUGLJPYC/K4MlP@lizhi-Precision-Tower-5810>
 <20240807175148.GA299582@francesco-nb>
Content-Language: pt-BR
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <20240807175148.GA299582@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/08/2024 14:51, Francesco Dolcini wrote:
> Hello Frank,
>
> +Rafael
>
> On Wed, Aug 07, 2024 at 11:34:48AM -0400, Frank Li wrote:
>> On Wed, Aug 07, 2024 at 04:43:49PM +0200, Francesco Dolcini wrote:
>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> On i.MX8 the FEC PPS channel is routed to the instance 1, not to the
>>> default 0.
>> According to my understand, it should be board level configuration. FEC
>> support output pps to any one. choose which one by board design.
> This seems different from the information we got from NXP some time ago,
> unfortunately this was happening over some private email exchange and
> not documented anywhere public. But the message was about SoC internal
> routing, not something at the board level, at least for i.MX8 SoCs that
> is what this patch is changing.
>
> For example to use PPS on i.MX8QXP we need to have this
>
> IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET0_PPS 0x06000020
>
> pinctrl configuration _and_ use PPS channel 1. Same is for i.MX8QP.
>
> Maybe Rafael can provide you some more details and the name of the
> person that provided this information.
>
> And maybe you can also try to double check this internally within NXP.
>
> Depending on what we find out we can decide if this patch needs to be
> dropped or not.
>
> Francesco
>
Hello Frank,

We have received the information from NXP support that the iMX8X only 
supports channel 1. Here's the link of the public question I asked:

https://community.nxp.com/t5/i-MX-Processors/IMX8X-PPS-output-configuration/m-p/1552154

Unfortunately, the response came directly to my e-mail address with no 
public update, but you can probably check the internal support case 
number 00500877.

Here's an excerpt from the response:

> I have checked this issue from soc level, the pps signal is routed to 
the 1588_timer1, not routed to 1588_timer0( being used in code default).

At the time, I asked a followup question:

> Can I assume that  IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET1_PPS is connected to 
1588_timer3 then?

To which I got the reply:

> No, ENET1_PPS is also routed through timer1. One can't use ENET0_PPS and 
ENET1_PPS at a same time because of same routing path.

I also asked for confirmation if this behavior was the same on the 
iMX8Q, which I didn't get. However, we had another customer also 
reporting problems getting the PPS output to work on our Apalis iMX8QM 
module, and in this case, the change to channel 1 also made it work. 
This leads me to believe that the iMX8X and iMX8Q are behaving the same 
way in this regard.

We would really appreciate some clarification if we got some of the 
details wrong.

Rafael


