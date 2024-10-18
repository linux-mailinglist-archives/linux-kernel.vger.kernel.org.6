Return-Path: <linux-kernel+bounces-371371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EDA9A3A28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24A27B22A24
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966B1F5833;
	Fri, 18 Oct 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xlOcfpWw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28E139587;
	Fri, 18 Oct 2024 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244275; cv=none; b=eOpF9PCFjpMCLPDbR3JI8kqIO/7r1nOXN08FAO46eTuEUR228wNNsiA68dW83MJb4HMT1uGbLnJCF4wAz4ArFNg9NlUpg14dtMbJovBizaIcZ7SBceubgxGhDdwFRUSYIyyUjGxa9dFTl9LiKQ+6xuGeAQ3ZN9pEeVD/LGECakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244275; c=relaxed/simple;
	bh=DOVQmhBf4K2P08mBoEzv7BzUo6saLfW36OYYo+ll4XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqekK3T91DNoXfEelaF5lesPiV+qh8nLQctOVp1McvVKNYiU0O06rRXKeGrTDKq6onf7NM/k0iEqOyzwRcdR5700nKuAkEmTzgsN/4wP6MlmknnJj+pFB2wE9ZMJtHaTZYvDqLFOgo2tBGCN+7+l+0JS27cy4b5TxTzLLNbE3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xlOcfpWw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qouiPpn6YX1/1IcGgtK9bT+Ht7HWLyCulNlPM8Iwk6I=; b=xlOcfpWwGRohG4z1NAUaxGZA1/
	NvM1tupAENJpjtgEBrJCMbFKfDkb+/8L2uChgGznhbjIS8T47Wl8lnW1Nj3Il59B/nCAESqQ/72j7
	al51RGLk2HTgyKzXC1pclRBKepoBEQkPPPzv3ZffHXfF2oJkS+KcY80XCOG5NXlM487rTCue7yvD3
	E4gYQ1qrpCBCVWrIlw6jnTEYd73dn0CdZQ8A+GhwoqkuTCmqDLjrrJaVHy72jO8aRzGaCAOzRRUca
	8+IG+pCCSW6Ac5Kn7ifMeE6pXwtBmNg0y5K8g9xbIQF5yKu6NJnHtAPHQ6zaPtFIGf9vJNtSTe23s
	IYEugtVw==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t1jQW-00072T-2A; Fri, 18 Oct 2024 11:37:44 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject:
 Re: (subset) [PATCH v2 0/4] rockchip: Fix several DT validation errors
Date: Fri, 18 Oct 2024 11:37:42 +0200
Message-ID: <4604343.LvFx2qVVIh@diego>
In-Reply-To: <D4YTW4DVRT68.1Z97ZHDYWTKHT@cknow.org>
References:
 <20241008113344.23957-1-didi.debian@cknow.org>
 <D4X8GJV0W6JL.32E469JSATFEP@cknow.org> <D4YTW4DVRT68.1Z97ZHDYWTKHT@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey,

Am Freitag, 18. Oktober 2024, 11:35:51 CEST schrieb Diederik de Haas:
> Hi Heiko,
> 
> On Wed Oct 16, 2024 at 2:35 PM CEST, Diederik de Haas wrote:
> > On Wed Oct 16, 2024 at 11:41 AM CEST, Diederik de Haas wrote:
> > > On Tue Oct 8, 2024 at 9:28 PM CEST, Heiko Stuebner wrote:
> > > > On Tue, 8 Oct 2024 13:15:35 +0200, Diederik de Haas wrote:
> > > > > This is a set of 4 small device-tree validation fixes.
> > > > > 
> > > > > Patch 1 adds the power-domains property to the csi dphy node on rk356x.
> > > > > Patch 2 removes the 2nd interrupt from the hdmi node on rk3328.
> > > > > Patch 3 replaces 'wake' with 'wakeup' on PineNote BT node.
> > > > > Patch 4 replaces 'reset-gpios' with 'shutdown-gpios' on brcm BT nodes.
> > > >
> > > > Applied, thanks!
> > > >
> > > > [2/4] arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
> > > >       commit: de50a7e3681771c6b990238af82bf1dea9b11b21
> > > > [3/4] arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
> > > >       commit: 87299d6ee95a37d2d576dd8077ea6860f77ad8e2
> > > > [4/4] arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
> > > >       commit: 2b6a3f857550e52b1cd4872ebb13cb3e3cf12f5f
> > >
> > > Please revert the 4th patch.
> > >
> > > I must have messed up my testing previously, but BT does not work on the
> > > PineNote with the 4th patch applied and does work with it reverted.
> >
> > FWIW, I figured out what went wrong.
> > My testing was correct, but redo-ing the implementation to make it ready
> > for submission wasn't very smart.
> >
> > With ``shutdown-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;``
> > it does work correctly, but I forgot to change GPIO_ACTIVE_LOW to
> > GPIO_ACTIVE_HIGH before submitting.
> >
> > I'll first figure out a better procedure before making a new submission,
> > so the revert is still the best approach IMO.
> 
> I've now done a new submission:
> https://lore.kernel.org/linux-rockchip/20241018092237.6774-1-didi.debian@cknow.org/
> 
> So please don't revert the 4th patch now.

hehe ok :-) .
I meant to ask if the fix wasn't simply toggling the gpio polarity, and
I guess with your patch you were faster than my question.

Heiko



