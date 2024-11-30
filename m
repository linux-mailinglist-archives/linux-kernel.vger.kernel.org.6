Return-Path: <linux-kernel+bounces-426437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FE89DF2F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED4C162CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF41AA78C;
	Sat, 30 Nov 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="0zKLputJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94934132103;
	Sat, 30 Nov 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732998336; cv=none; b=tbFr7AP5NgLrZNQYe+K1JJfkfe0sLRfkeGxjBN9M5tgC6cCd005wxImLjodGk2rtAn5nwCtf9+kNo5G5vAy6b/34N5sG4ZGX4B2TtuZx5uAkK+QtTosIlPxCZ0sL9NhozVJzkv678e2fQ9+u091kLGDxJvq7wP1twwSlz11fPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732998336; c=relaxed/simple;
	bh=uHokISs9XKOrrY5wB5eLy6qU757AOKlXohfQCDsXHdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPunogi+4wBddljlCWu/TPgqTeZcTsoqyf1JkaECENNYqVFgh1QlH7fRczvgXnVQmUNmXgUfJvzAj6RxbkNa0+vxdNxtmC7w/TuGaGkaPq8kvqsggvwgPw+2+C4V5nnXsoavp3m/WpRRdtVogqVTpkMVaCpI5x+E2X3XR2YVOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=0zKLputJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7zLaGCMDGsCJKOc1IwLPI+bZJjfcisw70zunW0yk10M=; b=0zKLputJip9nTRlXLWyCCTQ13n
	1f/TZEKJPD/pkyR4NLE51GUwc7dCni98FZE/XXSaF9f0Ih5jKhQoUMWm2vcG4vAw95L/qERg2x67l
	S/tTkfeWDzDr38USyDKIzP6O9sjp1tWRMpBoYORU8GccFAXgGaqL2rwEihHXg2QhAixwg/fPfAK3K
	7ivms/2XXWzV6dkE8eX6HVMxNkZjX2yXpXFVz193aqEhvOG2i6w8TylQrCdRgFrKRB4K/6hv9tCPj
	7egDlw08oLvW1tEHuAJv819qMZFd1gnkaBft7CofvqxX6l9FROxThpBfvGdWuUY9VXvjqqFZCoPh1
	B4GIpIOg==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tHU1h-0005Ux-7S; Sat, 30 Nov 2024 21:25:13 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rfoss@kernel.org, vkoul@kernel.org, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, l.stach@pengutronix.de,
 andy.yan@rock-chips.com, hjc@rock-chips.com, algea.cao@rock-chips.com,
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
Subject:
 Re: [PATCH v1 04/10] phy: phy-rockchip-samsung-hdptx: Add support for eDP
 mode
Date: Sat, 30 Nov 2024 21:25:12 +0100
Message-ID: <2886747.Y6S9NjorxK@diego>
In-Reply-To: <6e1f35c0-5ea8-414f-b3ea-4e7222c605ef@rock-chips.com>
References:
 <20241127075157.856029-1-damon.ding@rock-chips.com>
 <2131853.KlZ2vcFHjT@diego>
 <6e1f35c0-5ea8-414f-b3ea-4e7222c605ef@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Damon,

Am Freitag, 29. November 2024, 03:43:57 CET schrieb Damon Ding:
> On 2024/11/27 19:04, Heiko St=FCbner wrote:
> > Am Mittwoch, 27. November 2024, 12:00:10 CET schrieb Damon Ding:
> >> On 2024/11/27 17:29, Heiko St=FCbner wrote:
> >>> Am Mittwoch, 27. November 2024, 08:51:51 CET schrieb Damon Ding:
> >>>> +static int rk_hdptx_phy_set_mode(struct phy *phy, enum phy_mode mod=
e,
> >>>> +				 int submode)
> >>>> +{
> >>>> +	return 0;
> >>>> +}
> >>>
> >>> I think it might make sense to go the same way as the DCPHY and also
> >>> naneng combophy, to use #phy-cells =3D 1 to select the phy-mode via D=
T .
> >>>
> >>> See [0] for Sebastians initial suggestion regarding the DC-PHY.
> >>> The naneng combophy already uses that scheme of mode-selection too.
> >>>
> >>> There is of course the issue of backwards-compatibility, but that can=
 be
> >>> worked around in the binding with something like:
> >>>
> >>>    '#phy-cells':
> >>>       enum: [0, 1]
> >>>       description: |
> >>>         If #phy-cells is 0, PHY mode is set to PHY_TYPE_HDMI
> >>>         If #phy-cells is 1 mode is set in the PHY cells. Supported mo=
des are:
> >>>           - PHY_TYPE_HDMI
> >>>           - PHY_TYPE_DP
> >>>         See include/dt-bindings/phy/phy.h for constants.
> >>>
> >>> PHY_TYPE_HDMI needs to be added to include/dt-bindings/phy/phy.h
> >>> but PHY_TYPE_DP is already there.
> >>>
> >>> That way we would standardize on one form of accessing phy-types
> >>> on rk3588 :-) .
> >>>
> >>> Also see the Mediatek CSI rx phy doing this too already [1]
> >>>
> >>>
> >>> Heiko
> >>>
> >>> [0] https://lore.kernel.org/linux-rockchip/udad4qf3o7kt45nuz6gxsvsmpr=
h4rnyfxfogopmih6ucznizih@7oj2jrnlfonz/
> >>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> >>>
> >>
> >> It is really a nice way to separate HDMI and DP modes.
>=20
> I apologize for reopening the discussion about the phy-types setting.

there is definitly no need to apologize. We're trying to find the best
solution afterall :-) .


> With the .set_mode() of struct phy_ops, the HDMI and eDP dynamic=20
> switching can be achieved, which just depends on the right setting of
> enum phy_mode in include/linux/phy/phy.h. So the previous way of=20
> configuring phy mode may be also good.

I think the deciding factor is, is there a use-case for needing to switch
modes at runtime.

I do think the mode for the dc-phy and also the hdptx-phy is pretty much
decided by the board design.

I.e. when you end up in a DP-connector (or eDP-panel) on your board you
need DP mode, and when you end up in a hdmi-connector you need the
HDMI phy mode.

So I think the phy-mode for the hdptx-phy is largely dictated by the static
board definition (like devicetree), hence going with the dt-argument for
the mode.

Like similar to the Naneng combophy, selecting its mode via argument
because deciding if it ends up in a sata port is a board-design thing.


Is there a use-case where you need to switch at runtime between
hdmi and eDP? Like starting the phy in eDP mode but then needing
to switch to HDMI mode, while the device is running?


> And other phys may want to support dynamic switching too, like the=20
> Rockchip USBDP combo phy.

I guess USBDP is special in that in also does both modes dynamical
depending on its use (like type-c with option DP altmode)


Have a great weekend
Heiko



