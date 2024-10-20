Return-Path: <linux-kernel+bounces-373309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1409A5501
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5DF282738
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 16:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AA192D9C;
	Sun, 20 Oct 2024 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="c6cgzzdh"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2219340C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440804; cv=none; b=odcYGlm6ez6Mnu90xdRoKrwK080T2HcLDiS58S1Nk3H5lthof0V0n2tiRT1OmmD5ZbAIBdIizYJX/8kUa4BzZCaJi5AYWOM4TUWPqAimHw1eRQV2QKAQoGRXkZRoMxfJhFTan8rtLrQX/F3VclOR+XBbKtrRnYXF3ubeUUYarVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440804; c=relaxed/simple;
	bh=Jr080UKrqlyoEhlUdzVJnbBwGjHN9wTpqm4I1lxn+/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1oTBE4RuWuyazsFwd+DnIOcjkArEZEIbsVSYHwSBZ+dP61jOJazowPqKEl8DkuL4eC6WH94XuQQUI8O6z70HZEaFInXGkyE5ZRgBy1EJMUQkIoD6PpQOpBGZDUGLJ8iszeQOUsYh9AcadPQWvcXi3p52w2QMw5mWWXSBAIP5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=c6cgzzdh; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729440761; x=1729699961;
	bh=Jr080UKrqlyoEhlUdzVJnbBwGjHN9wTpqm4I1lxn+/k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c6cgzzdhm9xhOOh2KvmfejNxKIKvsrmP8jewJ9fQvFWEqQxcWFYKdmj/eGQ2vCgUS
	 nQAavkBP5grZkYUmi8+KBLrvl9qSAda2G0LzG6a2pBY2aA1AHTnDg1QvyAQetTDmUX
	 huoZGij+iuSiO9GvUWQ17L2hvEpcv75qkpTU8timeQxlbPvU+ATjS9WkrnNMXCDS9b
	 GKhPey3BgiW3AiGqnEbu86c6VmnlVTQfkRdl9NiUfNqw6fTrUqb6ov7w8ZnVRTWzlP
	 KaR6He5EfyCMUftZJQv/OMsDa50gv4qdUp3lWXfhGf+xo94XOsOEl5NwPlhagiNx6X
	 6W2Cb0HrbUA+Q==
Date: Sun, 20 Oct 2024 16:12:35 +0000
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Linux Driver Project Developer List <driverdev-devel@linuxdriverproject.org>, Kalle Valo <kvalo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Larry Finger <Larry.Finger@lwfinger.net>, Arnd Bergmann <arnd@arndb.de>, Xingquan Liu <b1n@b1n.io>, Tudor Gheorghiu <tudor.reda@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>, Manisha Singh <masingh.linux@gmail.com>, Dorine Tipo <dorine.a.tipo@gmail.com>, Tchadel Icard <hello@tchadelicard.fr>, Felix Yan <felixonmars@archlinux.org>, Moon Yeounsu <yyyynoom@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, Roshan Khatri <topofeverest8848@gmail.com>, Nam Cao <namcao@linutronix.de>, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] staging: rtl8712: Remove driver using deprecated API wext
Message-ID: <LWRaS-lEuHJabt1la0OVOa4KCH5kHtcEK0AjfSjDonWZbrrRm39kOiFCIJ1hhGV92jG4U7FgfiBRhD8_EIujeVxsJm5dfBBJwbdyIrxFewc=@protonmail.com>
In-Reply-To: <20241020144933.10956-1-philipp.g.hortmann@gmail.com>
References: <20241020144933.10956-1-philipp.g.hortmann@gmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: a965b2931e39365033b6d071a61e1f227d0563c9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, October 20th, 2024 at 16:49, Philipp Hortmann <philipp.g.hortman=
n@gmail.com> wrote:
>=20
>=20
> This driver is in the staging area since 2010.
>=20
> The following reasons lead to the removal:
> - This driver generates maintenance workload for itself and for API wext
> - A MAC80211 driver was available in 2016 time frame; This driver does
> not compile anymore but would be a better starting point than the
> current driver. Here the note from the TODO file:
> A replacement for this driver with MAC80211 support is available
> at https://github.com/chunkeey/rtl8192su
> - no progress changing to mac80211
> - Using this hardware is security wise not state of the art as WPA3 is
> not supported.
>=20
> The longterm kernels will still support this hardware for years.
>=20
> Find further discussions in the Link below.
>=20
> Link: https://lore.kernel.org/linux-staging/a02e3e0b-8a9b-47d5-87cf-2c957=
a474daa@gmail.com/T/#t
> Signed-off-by: Philipp Hortmann philipp.g.hortmann@gmail.com
>=20
> ---
> Artifacts of rtl8712 in MAINTAINERS are removed with this patch.
> Removed artifacts in Makefile and Kconfig.
> ---
> MAINTAINERS | 5 -
> drivers/staging/Kconfig | 2 -
> drivers/staging/Makefile | 1 -
> drivers/staging/rtl8712/Kconfig | 21 -
> drivers/staging/rtl8712/Makefile | 35 -
> drivers/staging/rtl8712/TODO | 12 -
> drivers/staging/rtl8712/basic_types.h | 28 -
> drivers/staging/rtl8712/drv_types.h | 175 --
> drivers/staging/rtl8712/ethernet.h | 21 -
> drivers/staging/rtl8712/hal_init.c | 401 ---
> drivers/staging/rtl8712/ieee80211.c | 415 ---
> drivers/staging/rtl8712/ieee80211.h | 165 --
> drivers/staging/rtl8712/mlme_linux.c | 161 --
> drivers/staging/rtl8712/mlme_osdep.h | 31 -
> drivers/staging/rtl8712/mp_custom_oid.h | 287 ---
> drivers/staging/rtl8712/os_intfs.c | 482 ----
> drivers/staging/rtl8712/osdep_intf.h | 32 -
> drivers/staging/rtl8712/osdep_service.h | 60 -
> drivers/staging/rtl8712/recv_linux.c | 139 -
> drivers/staging/rtl8712/recv_osdep.h | 39 -
> drivers/staging/rtl8712/rtl8712_bitdef.h | 26 -
> drivers/staging/rtl8712/rtl8712_cmd.c | 409 ---
> drivers/staging/rtl8712/rtl8712_cmd.h | 231 --
> .../staging/rtl8712/rtl8712_cmdctrl_bitdef.h | 95 -
> .../staging/rtl8712/rtl8712_cmdctrl_regdef.h | 19 -
> .../rtl8712/rtl8712_debugctrl_bitdef.h | 41 -
> .../rtl8712/rtl8712_debugctrl_regdef.h | 32 -
> .../rtl8712/rtl8712_edcasetting_bitdef.h | 65 -
> .../rtl8712/rtl8712_edcasetting_regdef.h | 24 -
> drivers/staging/rtl8712/rtl8712_efuse.c | 563 ----
> drivers/staging/rtl8712/rtl8712_efuse.h | 44 -
> drivers/staging/rtl8712/rtl8712_event.h | 86 -
> .../staging/rtl8712/rtl8712_fifoctrl_bitdef.h | 131 -
> .../staging/rtl8712/rtl8712_fifoctrl_regdef.h | 61 -
> drivers/staging/rtl8712/rtl8712_gp_bitdef.h | 68 -
> drivers/staging/rtl8712/rtl8712_gp_regdef.h | 29 -
> drivers/staging/rtl8712/rtl8712_hal.h | 142 -
> .../rtl8712/rtl8712_interrupt_bitdef.h | 44 -
> drivers/staging/rtl8712/rtl8712_io.c | 99 -
> drivers/staging/rtl8712/rtl8712_led.c | 1830 -------------
> .../rtl8712/rtl8712_macsetting_bitdef.h | 31 -
> .../rtl8712/rtl8712_macsetting_regdef.h | 20 -
> .../rtl8712/rtl8712_powersave_bitdef.h | 39 -
> .../rtl8712/rtl8712_powersave_regdef.h | 26 -
> .../staging/rtl8712/rtl8712_ratectrl_bitdef.h | 36 -
> .../staging/rtl8712/rtl8712_ratectrl_regdef.h | 43 -
> drivers/staging/rtl8712/rtl8712_recv.c | 1075 --------
> drivers/staging/rtl8712/rtl8712_recv.h | 145 --
> drivers/staging/rtl8712/rtl8712_regdef.h | 32 -
> .../staging/rtl8712/rtl8712_security_bitdef.h | 34 -
> drivers/staging/rtl8712/rtl8712_spec.h | 121 -
> .../staging/rtl8712/rtl8712_syscfg_bitdef.h | 163 --
> .../staging/rtl8712/rtl8712_syscfg_regdef.h | 42 -
> .../staging/rtl8712/rtl8712_timectrl_bitdef.h | 49 -
> .../staging/rtl8712/rtl8712_timectrl_regdef.h | 26 -
> drivers/staging/rtl8712/rtl8712_wmac_bitdef.h | 49 -
> drivers/staging/rtl8712/rtl8712_wmac_regdef.h | 36 -
> drivers/staging/rtl8712/rtl8712_xmit.c | 732 ------
> drivers/staging/rtl8712/rtl8712_xmit.h | 108 -
> drivers/staging/rtl8712/rtl871x_cmd.c | 750 ------
> drivers/staging/rtl8712/rtl871x_cmd.h | 750 ------
> drivers/staging/rtl8712/rtl871x_debug.h | 130 -
> drivers/staging/rtl8712/rtl871x_eeprom.c | 220 --
> drivers/staging/rtl8712/rtl871x_eeprom.h | 88 -
> drivers/staging/rtl8712/rtl871x_event.h | 109 -
> drivers/staging/rtl8712/rtl871x_ht.h | 33 -
> drivers/staging/rtl8712/rtl871x_io.c | 147 --
> drivers/staging/rtl8712/rtl871x_io.h | 236 --
> drivers/staging/rtl8712/rtl871x_ioctl.h | 94 -
> drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 2276 -----------------
> drivers/staging/rtl8712/rtl871x_ioctl_rtl.c | 519 ----
> drivers/staging/rtl8712/rtl871x_ioctl_rtl.h | 109 -
> drivers/staging/rtl8712/rtl871x_ioctl_set.c | 355 ---
> drivers/staging/rtl8712/rtl871x_ioctl_set.h | 45 -
> drivers/staging/rtl8712/rtl871x_led.h | 118 -
> drivers/staging/rtl8712/rtl871x_mlme.c | 1711 -------------
> drivers/staging/rtl8712/rtl871x_mlme.h | 205 --
> drivers/staging/rtl8712/rtl871x_mp.c | 724 ------
> drivers/staging/rtl8712/rtl871x_mp.h | 275 --
> drivers/staging/rtl8712/rtl871x_mp_ioctl.c | 883 -------
> drivers/staging/rtl8712/rtl871x_mp_ioctl.h | 328 ---
> .../staging/rtl8712/rtl871x_mp_phy_regdef.h | 1034 --------
> drivers/staging/rtl8712/rtl871x_pwrctrl.c | 234 --
> drivers/staging/rtl8712/rtl871x_pwrctrl.h | 113 -
> drivers/staging/rtl8712/rtl871x_recv.c | 671 -----
> drivers/staging/rtl8712/rtl871x_recv.h | 208 --
> drivers/staging/rtl8712/rtl871x_rf.h | 55 -
> drivers/staging/rtl8712/rtl871x_security.c | 1386 ----------
> drivers/staging/rtl8712/rtl871x_security.h | 223 --
> drivers/staging/rtl8712/rtl871x_sta_mgt.c | 263 --
> drivers/staging/rtl8712/rtl871x_wlan_sme.h | 35 -
> drivers/staging/rtl8712/rtl871x_xmit.c | 1056 --------
> drivers/staging/rtl8712/rtl871x_xmit.h | 287 ---
> drivers/staging/rtl8712/sta_info.h | 132 -
> drivers/staging/rtl8712/usb_halinit.c | 307 ---
> drivers/staging/rtl8712/usb_intf.c | 638 -----
> drivers/staging/rtl8712/usb_ops.c | 195 --
> drivers/staging/rtl8712/usb_ops.h | 38 -
> drivers/staging/rtl8712/usb_ops_linux.c | 508 ----
> drivers/staging/rtl8712/usb_osintf.h | 35 -
> drivers/staging/rtl8712/wifi.h | 196 --
> drivers/staging/rtl8712/wlan_bssdef.h | 223 --
> drivers/staging/rtl8712/xmit_linux.c | 181 --
> drivers/staging/rtl8712/xmit_osdep.h | 52 -
> 104 files changed, 27533 deletions(-)
> delete mode 100644 drivers/staging/rtl8712/Kconfig
> delete mode 100644 drivers/staging/rtl8712/Makefile
> delete mode 100644 drivers/staging/rtl8712/TODO
> delete mode 100644 drivers/staging/rtl8712/basic_types.h
> delete mode 100644 drivers/staging/rtl8712/drv_types.h
> delete mode 100644 drivers/staging/rtl8712/ethernet.h
> delete mode 100644 drivers/staging/rtl8712/hal_init.c
> delete mode 100644 drivers/staging/rtl8712/ieee80211.c
> delete mode 100644 drivers/staging/rtl8712/ieee80211.h
> delete mode 100644 drivers/staging/rtl8712/mlme_linux.c
> delete mode 100644 drivers/staging/rtl8712/mlme_osdep.h
> delete mode 100644 drivers/staging/rtl8712/mp_custom_oid.h
> delete mode 100644 drivers/staging/rtl8712/os_intfs.c
> delete mode 100644 drivers/staging/rtl8712/osdep_intf.h
> delete mode 100644 drivers/staging/rtl8712/osdep_service.h
> delete mode 100644 drivers/staging/rtl8712/recv_linux.c
> delete mode 100644 drivers/staging/rtl8712/recv_osdep.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_cmd.c
> delete mode 100644 drivers/staging/rtl8712/rtl8712_cmd.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_efuse.c
> delete mode 100644 drivers/staging/rtl8712/rtl8712_efuse.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_event.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_gp_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_gp_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_hal.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_io.c
> delete mode 100644 drivers/staging/rtl8712/rtl8712_led.c
> delete mode 100644 drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_powersave_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_recv.c
> delete mode 100644 drivers/staging/rtl8712/rtl8712_recv.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_security_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_spec.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_wmac_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl8712_xmit.c
> delete mode 100644 drivers/staging/rtl8712/rtl8712_xmit.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_cmd.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_cmd.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_debug.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_eeprom.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_eeprom.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_event.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_ht.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_io.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_io.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_set.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_ioctl_set.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_led.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_mlme.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_mlme.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_mp.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_mp.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_mp_ioctl.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_mp_ioctl.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_pwrctrl.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_pwrctrl.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_recv.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_recv.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_rf.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_security.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_security.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_sta_mgt.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_wlan_sme.h
> delete mode 100644 drivers/staging/rtl8712/rtl871x_xmit.c
> delete mode 100644 drivers/staging/rtl8712/rtl871x_xmit.h
> delete mode 100644 drivers/staging/rtl8712/sta_info.h
> delete mode 100644 drivers/staging/rtl8712/usb_halinit.c
> delete mode 100644 drivers/staging/rtl8712/usb_intf.c
> delete mode 100644 drivers/staging/rtl8712/usb_ops.c
> delete mode 100644 drivers/staging/rtl8712/usb_ops.h
> delete mode 100644 drivers/staging/rtl8712/usb_ops_linux.c
> delete mode 100644 drivers/staging/rtl8712/usb_osintf.h
> delete mode 100644 drivers/staging/rtl8712/wifi.h
> delete mode 100644 drivers/staging/rtl8712/wlan_bssdef.h
> delete mode 100644 drivers/staging/rtl8712/xmit_linux.c
> delete mode 100644 drivers/staging/rtl8712/xmit_osdep.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4300175d3ee6..b609f40e1420 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21955,11 +21955,6 @@ L: linux-tegra@vger.kernel.org
> S: Maintained
> F: drivers/staging/nvec/
>=20
> -STAGING - REALTEK RTL8712U DRIVERS
> -M: Florian Schilhabel florian.c.schilhabel@googlemail.com.
>=20
> -S: Odd Fixes
> -F: drivers/staging/rtl8712/
> -
> STAGING - SEPS525 LCD CONTROLLER DRIVERS
> M: Michael Hennerich michael.hennerich@analog.com
>=20
> L: linux-fbdev@vger.kernel.org
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 1f9783df641c..4018f95a31bc 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -26,8 +26,6 @@ if STAGING
>=20
> source "drivers/staging/rtl8723bs/Kconfig"
>=20
> -source "drivers/staging/rtl8712/Kconfig"
> -
> source "drivers/staging/octeon/Kconfig"
>=20
> source "drivers/staging/iio/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index d25e352d32bd..f29d66da02eb 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -3,7 +3,6 @@
>=20
> obj-y +=3D media/
> obj-$(CONFIG_RTL8723BS) +=3D rtl8723bs/
> -obj-$(CONFIG_R8712U) +=3D rtl8712/
> obj-$(CONFIG_OCTEON_ETHERNET) +=3D octeon/
> obj-$(CONFIG_VME_BUS) +=3D vme_user/
> obj-$(CONFIG_IIO) +=3D iio/
> diff --git a/drivers/staging/rtl8712/Kconfig b/drivers/staging/rtl8712/Kc=
onfig
> deleted file mode 100644
> index 8de26425225b..000000000000
> --- a/drivers/staging/rtl8712/Kconfig
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -config R8712U
> - tristate "RealTek RTL8712U (RTL8192SU) Wireless LAN NIC driver"
> - depends on WLAN && USB && CFG80211
> - select WIRELESS_EXT
> - select WEXT_PRIV
> - select FW_LOADER
> - help
> - This option adds the Realtek RTL8712 USB device such as the
> - D-Link DWA-130.
> -
> - If built as a module, it will be called r8712u.
> -
> -config R8712_TX_AGGR
> - bool "Realtek RTL8712U Transmit Aggregation code"
> - depends on R8712U && BROKEN
> - help
> - This option provides transmit aggregation for the Realtek
> - RTL8712 USB device.
> -
> -
> diff --git a/drivers/staging/rtl8712/Makefile b/drivers/staging/rtl8712/M=
akefile
> deleted file mode 100644
> index 3ae216b6621b..000000000000
> --- a/drivers/staging/rtl8712/Makefile
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -r8712u-y :=3D \
> - rtl871x_cmd.o \
> - rtl8712_cmd.o \
> - rtl871x_security.o \
> - rtl871x_eeprom.o \
> - rtl8712_efuse.o \
> - hal_init.o \
> - usb_halinit.o \
> - usb_ops.o \
> - usb_ops_linux.o \
> - rtl871x_io.o \
> - rtl8712_io.o \
> - rtl871x_ioctl_linux.o \
> - rtl871x_ioctl_rtl.o \
> - rtl871x_ioctl_set.o \
> - rtl8712_led.o \
> - rtl871x_mlme.o \
> - ieee80211.o \
> - rtl871x_mp_ioctl.o \
> - rtl871x_mp.o \
> - mlme_linux.o \
> - recv_linux.o \
> - xmit_linux.o \
> - usb_intf.o \
> - os_intfs.o \
> - rtl871x_pwrctrl.o \
> - rtl8712_recv.o \
> - rtl871x_recv.o \
> - rtl871x_sta_mgt.o \
> - rtl871x_xmit.o \
> - rtl8712_xmit.o
> -
> -obj-$(CONFIG_R8712U) :=3D r8712u.o
> -
> diff --git a/drivers/staging/rtl8712/TODO b/drivers/staging/rtl8712/TODO
> deleted file mode 100644
> index 5aed36efa7cb..000000000000
> --- a/drivers/staging/rtl8712/TODO
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -TODO:
> -- merge Realtek's bugfixes and new features into the driver
> -- switch to use MAC80211
> -- checkpatch.pl fixes - only a few remain
> -
> -A replacement for this driver with MAC80211 support is available
> -at https://github.com/chunkeey/rtl8192su
> -
> -Please send any patches to Greg Kroah-Hartman gregkh@linuxfoundation.org=
,
>=20
> -Larry Finger Larry.Finger@lwfinger.net,
>=20
> -Florian Schilhabel florian.c.schilhabel@googlemail.com and
>=20
> -Linux Driver Project Developer List driverdev-devel@linuxdriverproject.o=
rg.
>=20
> diff --git a/drivers/staging/rtl8712/basic_types.h b/drivers/staging/rtl8=
712/basic_types.h
> deleted file mode 100644
> index aecded87dd4c..000000000000
> --- a/drivers/staging/rtl8712/basic_types.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef BASIC_TYPES_H
> -#define BASIC_TYPES_H
> -
> -#include <linux/types.h>
>=20
> -
> -#define sint signed int
> -
> -/* Should we extend this to be host_addr_t and target_addr_t for case:
> - * host : x86_64
> - * target : mips64
> - /
> -#define addr_t unsigned long
> -
> -#endif /BASIC_TYPES_H/
> -
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl871=
2/drv_types.h
> deleted file mode 100644
> index 76ac798642bd..000000000000
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ /dev/null
> @@ -1,175 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -/ ---------------------------------------------------------------------
> - *
> - * For type defines and data structure defines
> - *
> - * ---------------------------------------------------------------------
> - */
> -#ifndef DRV_TYPES_H
> -#define DRV_TYPES_H
> -
> -struct _adapter;
> -
> -#include "osdep_service.h"
> -#include "wlan_bssdef.h"
> -#include "rtl8712_spec.h"
> -#include "rtl8712_hal.h"
> -#include <linux/mutex.h>
>=20
> -#include <linux/completion.h>
>=20
> -
> -enum _NIC_VERSION {
> - RTL8711_NIC,
> - RTL8712_NIC,
> - RTL8713_NIC,
> - RTL8716_NIC
> -};
> -
> -struct qos_priv {
> - /* bit mask option: u-apsd, s-apsd, ts, block ack... /
> - unsigned int qos_option;
> -};
> -
> -#include "rtl871x_ht.h"
> -#include "rtl871x_cmd.h"
> -#include "rtl871x_xmit.h"
> -#include "rtl871x_recv.h"
> -#include "rtl871x_security.h"
> -#include "rtl871x_pwrctrl.h"
> -#include "rtl871x_io.h"
> -#include "rtl871x_eeprom.h"
> -#include "sta_info.h"
> -#include "rtl871x_mlme.h"
> -#include "rtl871x_mp.h"
> -#include "rtl871x_debug.h"
> -#include "rtl871x_rf.h"
> -#include "rtl871x_event.h"
> -#include "rtl871x_led.h"
> -
> -#define SPEC_DEV_ID_DISABLE_HT BIT(1)
> -
> -struct specific_device_id {
> - u32 flags;
> - u16 idVendor;
> - u16 idProduct;
> -
> -};
> -
> -struct registry_priv {
> - u8 chip_version;
> - u8 rfintfs;
> - u8 lbkmode;
> - u8 hci;
> - u8 network_mode; /infra, ad-hoc, auto/
> - struct ndis_802_11_ssid ssid;
> - u8 channel;/ ad-hoc support requirement /
> - u8 wireless_mode;/ A, B, G, auto /
> - u8 vrtl_carrier_sense; /Enable, Disable, Auto/
> - u8 vcs_type;/RTS/CTS, CTS-to-self/
> - u16 rts_thresh;
> - u16 frag_thresh;
> - u8 preamble;/long, short, auto/
> - u8 scan_mode;/active, passive/
> - u8 adhoc_tx_pwr;
> - u8 soft_ap;
> - u8 smart_ps;
> - u8 power_mgnt;
> - u8 radio_enable;
> - u8 long_retry_lmt;
> - u8 short_retry_lmt;
> - u16 busy_thresh;
> - u8 ack_policy;
> - u8 mp_mode;
> - u8 software_encrypt;
> - u8 software_decrypt;
> - / UAPSD */
> - u8 wmm_enable;
> - u8 uapsd_enable;
> - u8 uapsd_max_sp;
> - u8 uapsd_acbk_en;
> - u8 uapsd_acbe_en;
> - u8 uapsd_acvi_en;
> - u8 uapsd_acvo_en;
> -
> - struct wlan_bssid_ex dev_network;
> -
> - u8 ht_enable;
> - u8 cbw40_enable;
> - u8 ampdu_enable;/for tx/
> - u8 rf_config;
> - u8 low_power;
> - u8 wifi_test;
> -};
> -
> -struct dvobj_priv {
> - struct _adapter *padapter;
> - u32 nr_endpoint;
> - u8 ishighspeed;
> - uint (*inirp_init)(struct _adapter *adapter);
> - uint (*inirp_deinit)(struct _adapter adapter);
> - struct usb_device pusbdev;
> -};
> -
> -/
> - * struct _adapter - the main adapter structure for this device.
> - *
> - * bup: True indicates that the interface is up.
> - */
> -struct _adapter {
> - struct dvobj_priv dvobjpriv;
> - struct mlme_priv mlmepriv;
> - struct cmd_priv cmdpriv;
> - struct evt_priv evtpriv;
> - struct io_queue *pio_queue;
> - struct xmit_priv xmitpriv;
> - struct recv_priv recvpriv;
> - struct sta_priv stapriv;
> - struct security_priv securitypriv;
> - struct registry_priv registrypriv;
> - struct wlan_acl_pool acl_list;
> - struct pwrctrl_priv pwrctrlpriv;
> - struct eeprom_priv eeprompriv;
> - struct hal_priv halpriv;
> - struct led_priv ledpriv;
> - struct mp_priv mppriv;
> - bool driver_stopped;
> - bool surprise_removed;
> - bool suspended;
> - u8 eeprom_address_size;
> - u8 hw_init_completed;
> - struct task_struct *cmd_thread;
> - uint (*dvobj_init)(struct _adapter *adapter);
> - void (*dvobj_deinit)(struct _adapter *adapter);
> - struct net_device *pnetdev;
> - int bup;
> - struct net_device_stats stats;
> - struct iw_statistics iwstats;
> - int pid; /process id from UI/
> - struct work_struct wk_filter_rx_ff0;
> - const struct firmware *fw;
> - struct usb_interface *pusb_intf;
> - struct mutex mutex_start;
> - struct completion rtl8712_fw_ready;
> - struct completion rx_filter_ready;
> -};
> -
> -static inline u8 *myid(struct eeprom_priv *peepriv)
> -{
> - return peepriv->mac_addr;
>=20
> -}
> -
> -u8 r8712_usb_hal_bus_init(struct _adapter adapter);
> -
> -#endif /DRV_TYPES_H/
> -
> diff --git a/drivers/staging/rtl8712/ethernet.h b/drivers/staging/rtl8712=
/ethernet.h
> deleted file mode 100644
> index 4b9b8a97a0bc..000000000000
> --- a/drivers/staging/rtl8712/ethernet.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef __INC_ETHERNET_H
> -#define __INC_ETHERNET_H
> -
> -#define ETHERNET_HEADER_SIZE 14 /!< Ethernet Header Length/
> -#define LLC_HEADER_SIZE 6 /!< LLC Header Length/
> -
> -#endif / #ifndef __INC_ETHERNET_H /
> -
> diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712=
/hal_init.c
> deleted file mode 100644
> index 1148075f0cd6..000000000000
> --- a/drivers/staging/rtl8712/hal_init.c
> +++ /dev/null
> @@ -1,401 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/****
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define HAL_INIT_C
> -
> -#include <linux/usb.h>
>=20
> -#include <linux/device.h>
>=20
> -#include <linux/usb/ch9.h>
>=20
> -#include <linux/firmware.h>
>=20
> -#include <linux/module.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "usb_osintf.h"
> -
> -#define FWBUFF_ALIGN_SZ 512
> -#define MAX_DUMP_FWSZ (48 * 1024)
> -
> -static void rtl871x_load_fw_fail(struct _adapter *adapter)
> -{
> - struct usb_device *udev =3D adapter->dvobjpriv.pusbdev;
>=20
> - struct device *dev =3D &udev->dev;
>=20
> - struct device *parent =3D dev->parent;
>=20
> -
> - complete(&adapter->rtl8712_fw_ready);
>=20
> -
> - dev_err(&udev->dev, "r8712u: Firmware request failed\n");
>=20
> -
> - if (parent)
> - device_lock(parent);
> -
> - device_release_driver(dev);
> -
> - if (parent)
> - device_unlock(parent);
> -}
> -
> -static void rtl871x_load_fw_cb(const struct firmware *firmware, void *co=
ntext)
> -{
> - struct _adapter *adapter =3D context;
> -
> - if (!firmware) {
> - rtl871x_load_fw_fail(adapter);
> - return;
> - }
> - adapter->fw =3D firmware;
>=20
> - /* firmware available - start netdev */
> - register_netdev(adapter->pnetdev);
>=20
> - complete(&adapter->rtl8712_fw_ready);
>=20
> -}
> -
> -static const char firmware_file[] =3D "rtlwifi/rtl8712u.bin";
> -
> -int rtl871x_load_fw(struct _adapter *padapter)
> -{
> - struct device *dev =3D &padapter->dvobjpriv.pusbdev->dev;
>=20
> - int rc;
> -
> - init_completion(&padapter->rtl8712_fw_ready);
>=20
> - dev_info(dev, "r8712u: Loading firmware from \"%s\"\n", firmware_file);
> - rc =3D request_firmware_nowait(THIS_MODULE, 1, firmware_file, dev,
> - GFP_KERNEL, padapter, rtl871x_load_fw_cb);
> - if (rc)
> - dev_err(dev, "r8712u: Firmware request error %d\n", rc);
> - return rc;
> -}
> -MODULE_FIRMWARE("rtlwifi/rtl8712u.bin");
> -
> -static u32 rtl871x_open_fw(struct _adapter *adapter, const u8 **mappedfw=
)
> -{
> - if (adapter->fw->size > 200000) {
>=20
> - dev_err(&adapter->pnetdev->dev, "r8712u: Bad fw->size of %zu\n",
>=20
> - adapter->fw->size);
>=20
> - return 0;
> - }
> - *mappedfw =3D adapter->fw->data;
>=20
> - return adapter->fw->size;
>=20
> -}
> -
> -static void fill_fwpriv(struct _adapter *adapter, struct fw_priv *fwpriv=
)
> -{
> - struct dvobj_priv *dvobj =3D &adapter->dvobjpriv;
>=20
> - struct registry_priv *regpriv =3D &adapter->registrypriv;
>=20
> -
> - memset(fwpriv, 0, sizeof(struct fw_priv));
> - /* todo: check if needs endian conversion */
> - fwpriv->hci_sel =3D RTL8712_HCI_TYPE_72USB;
>=20
> - fwpriv->usb_ep_num =3D (u8)dvobj->nr_endpoint;
>=20
> - fwpriv->bw_40MHz_en =3D regpriv->cbw40_enable;
>=20
> - switch (regpriv->rf_config) {
>=20
> - case RTL8712_RF_1T1R:
> - fwpriv->rf_config =3D RTL8712_RFC_1T1R;
>=20
> - break;
> - case RTL8712_RF_2T2R:
> - fwpriv->rf_config =3D RTL8712_RFC_2T2R;
>=20
> - break;
> - case RTL8712_RF_1T2R:
> - default:
> - fwpriv->rf_config =3D RTL8712_RFC_1T2R;
>=20
> - }
> - fwpriv->mp_mode =3D (regpriv->mp_mode =3D=3D 1);
>=20
> - /* 0:off 1:on 2:auto */
> - fwpriv->vcs_type =3D regpriv->vrtl_carrier_sense;
>=20
> - fwpriv->vcs_mode =3D regpriv->vcs_type; /* 1:RTS/CTS 2:CTS to self */
>=20
> - /* default enable turbo_mode */
> - fwpriv->turbo_mode =3D (regpriv->wifi_test !=3D 1);
>=20
> - fwpriv->low_power_mode =3D regpriv->low_power;
>=20
> -}
> -
> -static void update_fwhdr(struct fw_hdr *pfwhdr, const u8 pmappedfw)
> -{
> - pfwhdr->signature =3D le16_to_cpu((__le16 *)pmappedfw);
>=20
> - pfwhdr->version =3D le16_to_cpu(*(__le16 *)(pmappedfw + 2));
>=20
> - /* define the size of boot loader /
> - pfwhdr->dmem_size =3D le32_to_cpu((__le32 *)(pmappedfw + 4));
>=20
> - /* define the size of FW in IMEM /
> - pfwhdr->img_IMEM_size =3D le32_to_cpu((__le32 *)(pmappedfw + 8));
>=20
> - /* define the size of FW in SRAM /
> - pfwhdr->img_SRAM_size =3D le32_to_cpu((__le32 *)(pmappedfw + 12));
>=20
> - /* define the size of DMEM variable /
> - pfwhdr->fw_priv_sz =3D le32_to_cpu((__le32 *)(pmappedfw + 16));
>=20
> -}
> -
> -static u8 chk_fwhdr(struct fw_hdr pfwhdr, u32 ulfilelength)
> -{
> - u32 fwhdrsz, fw_sz;
> -
> - / check signature */
> - if ((pfwhdr->signature !=3D 0x8712) && (pfwhdr->signature !=3D 0x8192))
>=20
> - return _FAIL;
> - /* check fw_priv_sze & sizeof(struct fw_priv) */
> - if (pfwhdr->fw_priv_sz !=3D sizeof(struct fw_priv))
>=20
> - return _FAIL;
> - /* check fw_sz & image_fw_sz */
> - fwhdrsz =3D offsetof(struct fw_hdr, fwpriv) + pfwhdr->fw_priv_sz;
>=20
> - fw_sz =3D fwhdrsz + pfwhdr->img_IMEM_size + pfwhdr->img_SRAM_size +
>=20
> - pfwhdr->dmem_size;
>=20
> - if (fw_sz !=3D ulfilelength)
> - return _FAIL;
> - return _SUCCESS;
> -}
> -
> -static u8 rtl8712_dl_fw(struct _adapter adapter)
> -{
> - sint i;
> - u8 tmp8, tmp8_a;
> - u16 tmp16;
> - u32 maxlen =3D 0; / for compare usage /
> - uint dump_imem_sz, imem_sz, dump_emem_sz, emem_sz; / max =3D 49152; /
> - struct fw_hdr fwhdr;
> - u32 ulfilelength; / FW file size */
> - const u8 *mappedfw =3D NULL;
> - u8 *tmpchar =3D NULL, *payload, *ptr;
> - struct tx_desc *txdesc;
> - u32 txdscp_sz =3D sizeof(struct tx_desc);
> - u8 ret =3D _FAIL;
> -
> - ulfilelength =3D rtl871x_open_fw(adapter, &mappedfw);
> - if (mappedfw && (ulfilelength > 0)) {
>=20
> - update_fwhdr(&fwhdr, mappedfw);
> - if (chk_fwhdr(&fwhdr, ulfilelength) =3D=3D _FAIL)
> - return ret;
> - fill_fwpriv(adapter, &fwhdr.fwpriv);
> - /* firmware check ok */
> - maxlen =3D (fwhdr.img_IMEM_size > fwhdr.img_SRAM_size) ?
>=20
> - fwhdr.img_IMEM_size : fwhdr.img_SRAM_size;
> - maxlen +=3D txdscp_sz;
> - tmpchar =3D kmalloc(maxlen + FWBUFF_ALIGN_SZ, GFP_KERNEL);
> - if (!tmpchar)
> - return ret;
> -
> - txdesc =3D (struct tx_desc *)(tmpchar + FWBUFF_ALIGN_SZ -
> - ((addr_t)(tmpchar) & (FWBUFF_ALIGN_SZ - 1)));
> - payload =3D (u8 *)(txdesc) + txdscp_sz;
> - ptr =3D (u8 )mappedfw + offsetof(struct fw_hdr, fwpriv) +
> - fwhdr.fw_priv_sz;
> - / Download FirmWare /
> - / 1. determine IMEM code size and Load IMEM Code Section */
> - imem_sz =3D fwhdr.img_IMEM_size;
> - do {
> - memset(txdesc, 0, TXDESC_SIZE);
> - if (imem_sz > MAX_DUMP_FWSZ/49152/) {
>=20
> - dump_imem_sz =3D MAX_DUMP_FWSZ;
> - } else {
> - dump_imem_sz =3D imem_sz;
> - txdesc->txdw0 |=3D cpu_to_le32(BIT(28));
>=20
> - }
> - txdesc->txdw0 |=3D cpu_to_le32(dump_imem_sz &
>=20
> - 0x0000ffff);
> - memcpy(payload, ptr, dump_imem_sz);
> - r8712_write_mem(adapter, RTL8712_DMA_VOQ,
> - dump_imem_sz + TXDESC_SIZE,
> - (u8 *)txdesc);
> - ptr +=3D dump_imem_sz;
> - imem_sz -=3D dump_imem_sz;
> - } while (imem_sz > 0);
>=20
> - i =3D 10;
> - tmp16 =3D r8712_read16(adapter, TCR);
> - while (((tmp16 & _IMEM_CODE_DONE) =3D=3D 0) && (i > 0)) {
>=20
> - usleep_range(10, 1000);
> - tmp16 =3D r8712_read16(adapter, TCR);
> - i--;
> - }
> - if (i =3D=3D 0 || (tmp16 & _IMEM_CHK_RPT) =3D=3D 0)
> - goto exit_fail;
> -
> - /* 2.Download EMEM code size and Load EMEM Code Section /
> - emem_sz =3D fwhdr.img_SRAM_size;
> - do {
> - memset(txdesc, 0, TXDESC_SIZE);
> - if (emem_sz > MAX_DUMP_FWSZ) { / max=3D48k */
>=20
> - dump_emem_sz =3D MAX_DUMP_FWSZ;
> - } else {
> - dump_emem_sz =3D emem_sz;
> - txdesc->txdw0 |=3D cpu_to_le32(BIT(28));
>=20
> - }
> - txdesc->txdw0 |=3D cpu_to_le32(dump_emem_sz &
>=20
> - 0x0000ffff);
> - memcpy(payload, ptr, dump_emem_sz);
> - r8712_write_mem(adapter, RTL8712_DMA_VOQ,
> - dump_emem_sz + TXDESC_SIZE,
> - (u8 *)txdesc);
> - ptr +=3D dump_emem_sz;
> - emem_sz -=3D dump_emem_sz;
> - } while (emem_sz > 0);
>=20
> - i =3D 5;
> - tmp16 =3D r8712_read16(adapter, TCR);
> - while (((tmp16 & _EMEM_CODE_DONE) =3D=3D 0) && (i > 0)) {
>=20
> - usleep_range(10, 1000);
> - tmp16 =3D r8712_read16(adapter, TCR);
> - i--;
> - }
> - if (i =3D=3D 0 || (tmp16 & _EMEM_CHK_RPT) =3D=3D 0)
> - goto exit_fail;
> -
> - /* 3.Enable CPU /
> - tmp8 =3D r8712_read8(adapter, SYS_CLKR);
> - r8712_write8(adapter, SYS_CLKR, tmp8 | BIT(2));
> - tmp8_a =3D r8712_read8(adapter, SYS_CLKR);
> - if (tmp8_a !=3D (tmp8 | BIT(2)))
> - goto exit_fail;
> -
> - tmp8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - r8712_write8(adapter, SYS_FUNC_EN + 1, tmp8 | BIT(2));
> - tmp8_a =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - if (tmp8_a !=3D (tmp8 | BIT(2)))
> - goto exit_fail;
> -
> - r8712_read32(adapter, TCR);
> -
> - / 4.polling IMEM Ready */
> - i =3D 100;
> - tmp16 =3D r8712_read16(adapter, TCR);
> - while (((tmp16 & _IMEM_RDY) =3D=3D 0) && (i > 0)) {
>=20
> - msleep(20);
> - tmp16 =3D r8712_read16(adapter, TCR);
> - i--;
> - }
> - if (i =3D=3D 0) {
> - r8712_write16(adapter, 0x10250348, 0xc000);
> - r8712_write16(adapter, 0x10250348, 0xc001);
> - r8712_write16(adapter, 0x10250348, 0x2000);
> - r8712_write16(adapter, 0x10250348, 0x2001);
> - r8712_write16(adapter, 0x10250348, 0x2002);
> - r8712_write16(adapter, 0x10250348, 0x2003);
> - goto exit_fail;
> - }
> - /* 5.Download DMEM code size and Load EMEM Code Section */
> - memset(txdesc, 0, TXDESC_SIZE);
> - txdesc->txdw0 |=3D cpu_to_le32(fwhdr.fw_priv_sz & 0x0000ffff);
>=20
> - txdesc->txdw0 |=3D cpu_to_le32(BIT(28));
>=20
> - memcpy(payload, &fwhdr.fwpriv, fwhdr.fw_priv_sz);
> - r8712_write_mem(adapter, RTL8712_DMA_VOQ,
> - fwhdr.fw_priv_sz + TXDESC_SIZE, (u8 )txdesc);
> -
> - / polling dmem code done */
> - i =3D 100;
> - tmp16 =3D r8712_read16(adapter, TCR);
> - while (((tmp16 & _DMEM_CODE_DONE) =3D=3D 0) && (i > 0)) {
>=20
> - msleep(20);
> - tmp16 =3D r8712_read16(adapter, TCR);
> - i--;
> - }
> - if (i =3D=3D 0)
> - goto exit_fail;
> -
> - tmp8 =3D r8712_read8(adapter, 0x1025000A);
> - if (tmp8 & BIT(4)) /* When boot from EEPROM,
> - * & FW need more time to read EEPROM
> - /
> - i =3D 60;
> - else / boot from EFUSE */
> - i =3D 30;
> - tmp16 =3D r8712_read16(adapter, TCR);
> - while (((tmp16 & _FWRDY) =3D=3D 0) && (i > 0)) {
>=20
> - msleep(100);
> - tmp16 =3D r8712_read16(adapter, TCR);
> - i--;
> - }
> - if (i =3D=3D 0)
> - goto exit_fail;
> - } else {
> - goto exit_fail;
> - }
> - ret =3D _SUCCESS;
> -
> -exit_fail:
> - kfree(tmpchar);
> - return ret;
> -}
> -
> -uint rtl8712_hal_init(struct _adapter padapter)
> -{
> - u32 val32;
> - int i;
> -
> - / r8712 firmware download */
> - if (rtl8712_dl_fw(padapter) !=3D _SUCCESS)
> - return _FAIL;
> -
> - netdev_info(padapter->pnetdev, "1 RCR=3D0x%x\n",
>=20
> - r8712_read32(padapter, RCR));
> - val32 =3D r8712_read32(padapter, RCR);
> - r8712_write32(padapter, RCR, (val32 | BIT(26))); /* Enable RX TCP
> - * Checksum offload
> - */
> - netdev_info(padapter->pnetdev, "2 RCR=3D0x%x\n",
>=20
> - r8712_read32(padapter, RCR));
> - val32 =3D r8712_read32(padapter, RCR);
> - r8712_write32(padapter, RCR, (val32 | BIT(25))); /* Append PHY status /
> - val32 =3D r8712_read32(padapter, 0x10250040);
> - r8712_write32(padapter, 0x10250040, (val32 & 0x00FFFFFF));
> - / for usb rx aggregation /
> - r8712_write8(padapter, 0x102500B5, r8712_read8(padapter, 0x102500B5) |
> - BIT(0)); / page =3D 128bytes /
> - r8712_write8(padapter, 0x102500BD, r8712_read8(padapter, 0x102500BD) |
> - BIT(7)); / enable usb rx aggregation /
> - r8712_write8(padapter, 0x102500D9, 1); / TH=3D1 =3D> means that invalid=
ate
>=20
> - * usb rx aggregation
> - /
> - r8712_write8(padapter, 0x1025FE5B, 0x04); / 1.7ms/4 /
> - / Fix the RX FIFO issue(USB error) */
> - r8712_write8(padapter, 0x1025fe5C, r8712_read8(padapter, 0x1025fe5C)
> - | BIT(7));
> - for (i =3D 0; i < ETH_ALEN; i++)
> - padapter->eeprompriv.mac_addr[i] =3D r8712_read8(padapter,
>=20
> - MACID + i);
> - return _SUCCESS;
> -}
> -
> -uint rtl8712_hal_deinit(struct _adapter padapter)
> -{
> - r8712_write8(padapter, RF_CTRL, 0x00);
> - / Turn off BB /
> - msleep(20);
> - / Turn off MAC /
> - r8712_write8(padapter, SYS_CLKR + 1, 0x38); / Switch Control Path /
> - r8712_write8(padapter, SYS_FUNC_EN + 1, 0x70);
> - r8712_write8(padapter, PMC_FSM, 0x06); / Enable Loader Data Keep /
> - r8712_write8(padapter, SYS_ISO_CTRL, 0xF9); / Isolation signals from
> - * CORE, PLL
> - /
> - r8712_write8(padapter, SYS_ISO_CTRL + 1, 0xe8); / Enable EFUSE 1.2V /
> - r8712_write8(padapter, AFE_PLL_CTRL, 0x00); / Disable AFE PLL. /
> - r8712_write8(padapter, LDOA15_CTRL, 0x54); / Disable A15V /
> - r8712_write8(padapter, SYS_FUNC_EN + 1, 0x50); / Disable E-Fuse 1.2V /
> - r8712_write8(padapter, LDOV12D_CTRL, 0x24); / Disable LDO12(for CE) /
> - r8712_write8(padapter, AFE_MISC, 0x30); / Disable AFE BG&MB /
> - / Option for Disable 1.6V LDO. /
> - r8712_write8(padapter, SPS0_CTRL, 0x56); / Disable 1.6V LDO /
> - r8712_write8(padapter, SPS0_CTRL + 1, 0x43); / Set SW PFM */
> - return _SUCCESS;
> -}
> -
> -uint rtl871x_hal_init(struct _adapter *padapter)
> -{
> - padapter->hw_init_completed =3D false;
>=20
> - if (!padapter->halpriv.hal_bus_init)
>=20
> - return _FAIL;
> - if (padapter->halpriv.hal_bus_init(padapter) !=3D _SUCCESS)
>=20
> - return _FAIL;
> - if (rtl8712_hal_init(padapter) =3D=3D _SUCCESS) {
> - padapter->hw_init_completed =3D true;
>=20
> - } else {
> - padapter->hw_init_completed =3D false;
>=20
> - return _FAIL;
> - }
> - return _SUCCESS;
> -}
> diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl871=
2/ieee80211.c
> deleted file mode 100644
> index 7d8f1a29d18a..000000000000
> --- a/drivers/staging/rtl8712/ieee80211.c
> +++ /dev/null
> @@ -1,415 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************************************=
*******
> - * ieee80211.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -
> -#define _IEEE80211_C
> -
> -#include "drv_types.h"
> -#include "ieee80211.h"
> -#include "wifi.h"
> -#include "osdep_service.h"
> -#include "wlan_bssdef.h"
> -
> -static const u8 WPA_OUI_TYPE[] =3D {0x00, 0x50, 0xf2, 1};
> -static const u8 WPA_CIPHER_SUITE_NONE[] =3D {0x00, 0x50, 0xf2, 0};
> -static const u8 WPA_CIPHER_SUITE_WEP40[] =3D {0x00, 0x50, 0xf2, 1};
> -static const u8 WPA_CIPHER_SUITE_TKIP[] =3D {0x00, 0x50, 0xf2, 2};
> -static const u8 WPA_CIPHER_SUITE_CCMP[] =3D {0x00, 0x50, 0xf2, 4};
> -static const u8 WPA_CIPHER_SUITE_WEP104[] =3D {0x00, 0x50, 0xf2, 5};
> -
> -static const u8 RSN_CIPHER_SUITE_NONE[] =3D {0x00, 0x0f, 0xac, 0};
> -static const u8 RSN_CIPHER_SUITE_WEP40[] =3D {0x00, 0x0f, 0xac, 1};
> -static const u8 RSN_CIPHER_SUITE_TKIP[] =3D {0x00, 0x0f, 0xac, 2};
> -static const u8 RSN_CIPHER_SUITE_CCMP[] =3D {0x00, 0x0f, 0xac, 4};
> -static const u8 RSN_CIPHER_SUITE_WEP104[] =3D {0x00, 0x0f, 0xac, 5};
> -
> -/-----------------------------------------------------------
> - * for adhoc-master to generate ie and provide supported-rate to fw
> - *-----------------------------------------------------------
> - */
> -
> -static u8 WIFI_CCKRATES[] =3D {
> - (IEEE80211_CCK_RATE_1MB | IEEE80211_BASIC_RATE_MASK),
> - (IEEE80211_CCK_RATE_2MB | IEEE80211_BASIC_RATE_MASK),
> - (IEEE80211_CCK_RATE_5MB | IEEE80211_BASIC_RATE_MASK),
> - (IEEE80211_CCK_RATE_11MB | IEEE80211_BASIC_RATE_MASK)
> -};
> -
> -static u8 WIFI_OFDMRATES[] =3D {
> - (IEEE80211_OFDM_RATE_6MB),
> - (IEEE80211_OFDM_RATE_9MB),
> - (IEEE80211_OFDM_RATE_12MB),
> - (IEEE80211_OFDM_RATE_18MB),
> - (IEEE80211_OFDM_RATE_24MB),
> - (IEEE80211_OFDM_RATE_36MB),
> - (IEEE80211_OFDM_RATE_48MB),
> - (IEEE80211_OFDM_RATE_54MB)
> -};
> -
> -uint r8712_is_cckrates_included(u8 *rate)
> -{
> - u32 i =3D 0;
> -
> - while (rate[i] !=3D 0) {
> - if ((((rate[i]) & 0x7f) =3D=3D 2) || (((rate[i]) & 0x7f) =3D=3D 4) ||
> - (((rate[i]) & 0x7f) =3D=3D 11) || (((rate[i]) & 0x7f) =3D=3D 22))
> - return true;
> - i++;
> - }
> - return false;
> -}
> -
> -uint r8712_is_cckratesonly_included(u8 rate)
> -{
> - u32 i =3D 0;
> -
> - while (rate[i] !=3D 0) {
> - if ((((rate[i]) & 0x7f) !=3D 2) && (((rate[i]) & 0x7f) !=3D 4) &&
> - (((rate[i]) & 0x7f) !=3D 11) && (((rate[i]) & 0x7f) !=3D 22))
> - return false;
> - i++;
> - }
> - return true;
> -}
> -
> -/ r8712_set_ie will update frame length */
> -u8 *r8712_set_ie(u8 *pbuf, sint index, uint len, u8 *source, uint *frlen=
)
> -{
> - *pbuf =3D (u8)index;
> - *(pbuf + 1) =3D (u8)len;
> - if (len > 0)
>=20
> - memcpy((void *)(pbuf + 2), (void *)source, len);
> - *frlen =3D frlen + (len + 2);
> - return pbuf + len + 2;
> -}
> -
> -/ ----------------------------------------------------------------------=
-----
> - * index: the information element id index, limit is the limit for searc=
h
> - * ---------------------------------------------------------------------=
------
> - */
> -u8 *r8712_get_ie(u8 *pbuf, sint index, uint *len, sint limit)
> -{
> - sint tmp, i;
> - u8 *p;
> -
> - if (limit < 1)
> - return NULL;
> - p =3D pbuf;
> - i =3D 0;
> - *len =3D 0;
> - while (1) {
> - if (*p =3D=3D index) {
> - *len =3D *(p + 1);
> - return p;
> - }
> - tmp =3D *(p + 1);
> - p +=3D (tmp + 2);
> - i +=3D (tmp + 2);
> - if (i >=3D limit)
>=20
> - break;
> - }
> - return NULL;
> -}
> -
> -static void set_supported_rate(u8 *rates, uint mode)
> -{
> - memset(rates, 0, NDIS_802_11_LENGTH_RATES_EX);
> - switch (mode) {
> - case WIRELESS_11B:
> - memcpy(rates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
> - break;
> - case WIRELESS_11G:
> - case WIRELESS_11A:
> - memcpy(rates, WIFI_OFDMRATES, IEEE80211_NUM_OFDM_RATESLEN);
> - break;
> - case WIRELESS_11BG:
> - memcpy(rates, WIFI_CCKRATES, IEEE80211_CCK_RATE_LEN);
> - memcpy(rates + IEEE80211_CCK_RATE_LEN, WIFI_OFDMRATES,
> - IEEE80211_NUM_OFDM_RATESLEN);
> - break;
> - }
> -}
> -
> -static uint r8712_get_rateset_len(u8 *rateset)
> -{
> - uint i =3D 0;
> -
> - while (1) {
> - if ((rateset[i]) =3D=3D 0)
> - break;
> - if (i > 12)
>=20
> - break;
> - i++;
> - }
> - return i;
> -}
> -
> -int r8712_generate_ie(struct registry_priv *registrypriv)
> -{
> - int rate_len;
> - uint sz =3D 0;
> - struct wlan_bssid_ex *dev_network =3D &registrypriv->dev_network;
>=20
> - u8 *ie =3D dev_network->IEs;
>=20
> - u16 beacon_period =3D (u16)dev_network->Configuration.BeaconPeriod;
>=20
> -
> - /timestamp will be inserted by hardware/
> - sz +=3D 8;
> - ie +=3D sz;
> - /beacon interval : 2bytes/
> - *(__le16 *)ie =3D cpu_to_le16(beacon_period);
> - sz +=3D 2;
> - ie +=3D 2;
> - /capability info/
> - *(u16 *)ie =3D 0;
> - *(__le16 *)ie |=3D cpu_to_le16(WLAN_CAPABILITY_IBSS);
> - if (registrypriv->preamble =3D=3D PREAMBLE_SHORT)
>=20
> - *(__le16 *)ie |=3D cpu_to_le16(WLAN_CAPABILITY_SHORT_PREAMBLE);
> - if (dev_network->Privacy)
>=20
> - *(__le16 *)ie |=3D cpu_to_le16(WLAN_CAPABILITY_PRIVACY);
> - sz +=3D 2;
> - ie +=3D 2;
> - /SSID/
> - ie =3D r8712_set_ie(ie, WLAN_EID_SSID, dev_network->Ssid.SsidLength,
>=20
> - dev_network->Ssid.Ssid, &sz);
>=20
> - /supported rates/
> - set_supported_rate(dev_network->rates, registrypriv->wireless_mode);
>=20
> - rate_len =3D r8712_get_rateset_len(dev_network->rates);
>=20
> - if (rate_len > 8) {
>=20
> - ie =3D r8712_set_ie(ie, WLAN_EID_SUPP_RATES, 8,
> - dev_network->rates, &sz);
>=20
> - ie =3D r8712_set_ie(ie, WLAN_EID_EXT_SUPP_RATES, (rate_len - 8),
> - (dev_network->rates + 8), &sz);
>=20
> - } else {
> - ie =3D r8712_set_ie(ie, WLAN_EID_SUPP_RATES,
> - rate_len, dev_network->rates, &sz);
>=20
> - }
> - /DS parameter set/
> - ie =3D r8712_set_ie(ie, WLAN_EID_DS_PARAMS, 1,
> - (u8 *)&dev_network->Configuration.DSConfig, &sz);
>=20
> - /IBSS Parameter Set/
> - ie =3D r8712_set_ie(ie, WLAN_EID_IBSS_PARAMS, 2,
> - (u8 *)&dev_network->Configuration.ATIMWindow, &sz);
>=20
> - return sz;
> -}
> -
> -unsigned char *r8712_get_wpa_ie(unsigned char *ie, uint *wpa_ie_len, int=
 limit)
> -{
> - u32 len;
> - u16 val16;
> - unsigned char wpa_oui_type[] =3D {0x00, 0x50, 0xf2, 0x01};
> - u8 *buf =3D ie;
> -
> - while (1) {
> - buf =3D r8712_get_ie(buf, WPA_IE_ID, &len, limit);
> - if (buf) {
> - /check if oui matches.../
> - if (memcmp((buf + 2), wpa_oui_type,
> - sizeof(wpa_oui_type)))
> - goto check_next_ie;
> - /check version.../
> - memcpy((u8 *)&val16, (buf + 6), sizeof(val16));
> - le16_to_cpus(&val16);
> - if (val16 !=3D 0x0001)
> - goto check_next_ie;
> - *wpa_ie_len =3D *(buf + 1);
> - return buf;
> - }
> - *wpa_ie_len =3D 0;
> - return NULL;
> -check_next_ie:
> - limit =3D limit - (buf - ie) - 2 - len;
> - if (limit <=3D 0)
> - break;
> - buf +=3D (2 + len);
> - }
> - *wpa_ie_len =3D 0;
> - return NULL;
> -}
> -
> -unsigned char *r8712_get_wpa2_ie(unsigned char *pie, uint *rsn_ie_len,
> - int limit)
> -{
> - return r8712_get_ie(pie, WPA2_IE_ID, rsn_ie_len, limit);
> -}
> -
> -static int r8712_get_wpa_cipher_suite(u8 *s)
> -{
> - if (!memcmp(s, (void *)WPA_CIPHER_SUITE_NONE, WPA_SELECTOR_LEN))
> - return WPA_CIPHER_NONE;
> - if (!memcmp(s, (void *)WPA_CIPHER_SUITE_WEP40, WPA_SELECTOR_LEN))
> - return WPA_CIPHER_WEP40;
> - if (!memcmp(s, (void *)WPA_CIPHER_SUITE_TKIP, WPA_SELECTOR_LEN))
> - return WPA_CIPHER_TKIP;
> - if (!memcmp(s, (void *)WPA_CIPHER_SUITE_CCMP, WPA_SELECTOR_LEN))
> - return WPA_CIPHER_CCMP;
> - if (!memcmp(s, (void *)WPA_CIPHER_SUITE_WEP104, WPA_SELECTOR_LEN))
> - return WPA_CIPHER_WEP104;
> - return 0;
> -}
> -
> -static int r8712_get_wpa2_cipher_suite(u8 *s)
> -{
> - if (!memcmp(s, (void *)RSN_CIPHER_SUITE_NONE, RSN_SELECTOR_LEN))
> - return WPA_CIPHER_NONE;
> - if (!memcmp(s, (void *)RSN_CIPHER_SUITE_WEP40, RSN_SELECTOR_LEN))
> - return WPA_CIPHER_WEP40;
> - if (!memcmp(s, (void *)RSN_CIPHER_SUITE_TKIP, RSN_SELECTOR_LEN))
> - return WPA_CIPHER_TKIP;
> - if (!memcmp(s, (void *)RSN_CIPHER_SUITE_CCMP, RSN_SELECTOR_LEN))
> - return WPA_CIPHER_CCMP;
> - if (!memcmp(s, (void *)RSN_CIPHER_SUITE_WEP104, RSN_SELECTOR_LEN))
> - return WPA_CIPHER_WEP104;
> - return 0;
> -}
> -
> -int r8712_parse_wpa_ie(u8 *wpa_ie, int wpa_ie_len, int *group_cipher,
> - int *pairwise_cipher)
> -{
> - int i;
> - int left, count;
> - u8 pos;
> -
> - if (wpa_ie_len <=3D 0) {
> - / No WPA IE - fail silently */
> - return -EINVAL;
> - }
> - if ((wpa_ie !=3D WPA_IE_ID) ||
> - ((wpa_ie + 1) !=3D (u8)(wpa_ie_len - 2)) ||
> - (memcmp(wpa_ie + 2, (void *)WPA_OUI_TYPE, WPA_SELECTOR_LEN)))
> - return -EINVAL;
> - pos =3D wpa_ie;
> - pos +=3D 8;
> - left =3D wpa_ie_len - 8;
> - /group_cipher/
> - if (left >=3D WPA_SELECTOR_LEN) {
>=20
> - *group_cipher =3D r8712_get_wpa_cipher_suite(pos);
> - pos +=3D WPA_SELECTOR_LEN;
> - left -=3D WPA_SELECTOR_LEN;
> - } else if (left > 0) {
>=20
> - return -EINVAL;
> - }
> - /pairwise_cipher/
> - if (left >=3D 2) {
>=20
> - count =3D le16_to_cpu(*(__le16 *)pos);
> - pos +=3D 2;
> - left -=3D 2;
> - if (count =3D=3D 0 || left < count * WPA_SELECTOR_LEN)
> - return -EINVAL;
> - for (i =3D 0; i < count; i++) {
> - *pairwise_cipher |=3D r8712_get_wpa_cipher_suite(pos);
> - pos +=3D WPA_SELECTOR_LEN;
> - left -=3D WPA_SELECTOR_LEN;
> - }
> - } else if (left =3D=3D 1) {
> - return -EINVAL;
> - }
> - return 0;
> -}
> -
> -int r8712_parse_wpa2_ie(u8 *rsn_ie, int rsn_ie_len, int *group_cipher,
> - int *pairwise_cipher)
> -{
> - int i;
> - int left, count;
> - u8 pos;
> -
> - if (rsn_ie_len <=3D 0) {
> - / No RSN IE - fail silently */
> - return -EINVAL;
> - }
> - if ((rsn_ie !=3D WPA2_IE_ID) ||
> - ((rsn_ie + 1) !=3D (u8)(rsn_ie_len - 2)))
> - return -EINVAL;
> - pos =3D rsn_ie;
> - pos +=3D 4;
> - left =3D rsn_ie_len - 4;
> - /group_cipher/
> - if (left >=3D RSN_SELECTOR_LEN) {
>=20
> - *group_cipher =3D r8712_get_wpa2_cipher_suite(pos);
> - pos +=3D RSN_SELECTOR_LEN;
> - left -=3D RSN_SELECTOR_LEN;
> - } else if (left > 0) {
>=20
> - return -EINVAL;
> - }
> - /pairwise_cipher/
> - if (left >=3D 2) {
>=20
> - count =3D le16_to_cpu((__le16 )pos);
> - pos +=3D 2;
> - left -=3D 2;
> - if (count =3D=3D 0 || left < count * RSN_SELECTOR_LEN)
> - return -EINVAL;
> - for (i =3D 0; i < count; i++) {
> - pairwise_cipher |=3D r8712_get_wpa2_cipher_suite(pos);
> - pos +=3D RSN_SELECTOR_LEN;
> - left -=3D RSN_SELECTOR_LEN;
> - }
> - } else if (left =3D=3D 1) {
> - return -EINVAL;
> - }
> - return 0;
> -}
> -
> -int r8712_get_sec_ie(u8 in_ie, uint in_len, u8 rsn_ie, u16 rsn_len,
> - u8 wpa_ie, u16 wpa_len)
> -{
> - u8 authmode;
> - u8 wpa_oui[4] =3D {0x0, 0x50, 0xf2, 0x01};
> - uint cnt;
> -
> - /Search required WPA or WPA2 IE and copy to sec_ie[ ]/
> - cnt =3D TIMESTAMP + BEACON_ITERVAL + CAPABILITY;
> - while (cnt < in_len) {
> - authmode =3D in_ie[cnt];
> - if ((authmode =3D=3D WPA_IE_ID) &&
> - (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
> - memcpy(wpa_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
> - wpa_len =3D in_ie[cnt + 1] + 2;
> - cnt +=3D in_ie[cnt + 1] + 2; /get next /
> - } else {
> - if (authmode =3D=3D WPA2_IE_ID) {
> - memcpy(rsn_ie, &in_ie[cnt],
> - in_ie[cnt + 1] + 2);
> - rsn_len =3D in_ie[cnt + 1] + 2;
> - cnt +=3D in_ie[cnt + 1] + 2; /get next/
> - } else {
> - cnt +=3D in_ie[cnt + 1] + 2; /get next/
> - }
> - }
> - }
> - return rsn_len + wpa_len;
> -}
> -
> -int r8712_get_wps_ie(u8 in_ie, uint in_len, u8 wps_ie, uint wps_ielen)
> -{
> - int match;
> - uint cnt;
> - u8 eid, wps_oui[4] =3D {0x0, 0x50, 0xf2, 0x04};
> -
> - cnt =3D 12;
> - match =3D false;
> - while (cnt < in_len) {
> - eid =3D in_ie[cnt];
> - if ((eid =3D=3D WPA_IE_ID) &&
> - (!memcmp(&in_ie[cnt + 2], wps_oui, 4))) {
> - memcpy(wps_ie, &in_ie[cnt], in_ie[cnt + 1] + 2);
> - wps_ielen =3D in_ie[cnt + 1] + 2;
> - cnt +=3D in_ie[cnt + 1] + 2;
> - match =3D true;
> - break;
> - }
> - cnt +=3D in_ie[cnt + 1] + 2; / goto next /
> - }
> - return match;
> -}
> diff --git a/drivers/staging/rtl8712/ieee80211.h b/drivers/staging/rtl871=
2/ieee80211.h
> deleted file mode 100644
> index 65ceaca9b51e..000000000000
> --- a/drivers/staging/rtl8712/ieee80211.h
> +++ /dev/null
> @@ -1,165 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/************************************************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef __IEEE80211_H
> -#define __IEEE80211_H
> -
> -#include <linux/ieee80211.h>
>=20
> -
> -#define IEEE_CMD_SET_WPA_PARAM 1
> -#define IEEE_CMD_SET_WPA_IE 2
> -#define IEEE_CMD_SET_ENCRYPTION 3
> -#define IEEE_CMD_MLME 4
> -
> -#define IEEE_PARAM_WPA_ENABLED 1
> -#define IEEE_PARAM_TKIP_COUNTERMEASURES 2
> -#define IEEE_PARAM_DROP_UNENCRYPTED 3
> -#define IEEE_PARAM_PRIVACY_INVOKED 4
> -#define IEEE_PARAM_AUTH_ALGS 5
> -#define IEEE_PARAM_IEEE_802_1X 6
> -#define IEEE_PARAM_WPAX_SELECT 7
> -
> -#define AUTH_ALG_OPEN_SYSTEM 0x1
> -#define AUTH_ALG_SHARED_KEY 0x2
> -#define AUTH_ALG_LEAP 0x00000004
> -
> -#define IEEE_MLME_STA_DEAUTH 1
> -#define IEEE_MLME_STA_DISASSOC 2
> -
> -#define IEEE_CRYPT_ERR_UNKNOWN_ALG 2
> -#define IEEE_CRYPT_ERR_UNKNOWN_ADDR 3
> -#define IEEE_CRYPT_ERR_CRYPT_INIT_FAILED 4
> -#define IEEE_CRYPT_ERR_KEY_SET_FAILED 5
> -#define IEEE_CRYPT_ERR_TX_KEY_SET_FAILED 6
> -#define IEEE_CRYPT_ERR_CARD_CONF_FAILED 7
> -
> -#define IEEE_CRYPT_ALG_NAME_LEN 16
> -
> -#define WPA_CIPHER_NONE BIT(0)
> -#define WPA_CIPHER_WEP40 BIT(1)
> -#define WPA_CIPHER_WEP104 BIT(2)
> -#define WPA_CIPHER_TKIP BIT(3)
> -#define WPA_CIPHER_CCMP BIT(4)
> -
> -#define WPA_SELECTOR_LEN 4
> -#define RSN_HEADER_LEN 4
> -
> -#define RSN_SELECTOR_LEN 4
> -
> -enum NETWORK_TYPE {
> - WIRELESS_INVALID =3D 0,
> - WIRELESS_11B =3D 1,
> - WIRELESS_11G =3D 2,
> - WIRELESS_11BG =3D (WIRELESS_11B | WIRELESS_11G),
> - WIRELESS_11A =3D 4,
> - WIRELESS_11N =3D 8,
> - WIRELESS_11GN =3D (WIRELESS_11G | WIRELESS_11N),
> - WIRELESS_11BGN =3D (WIRELESS_11B | WIRELESS_11G | WIRELESS_11N),
> -};
> -
> -struct ieee_param {
> - u32 cmd;
> - u8 sta_addr[ETH_ALEN];
> - union {
> - struct {
> - u8 name;
> - u32 value;
> - } wpa_param;
> - struct {
> - u32 len;
> - u8 reserved[32];
> - u8 data[];
> - } wpa_ie;
> - struct {
> - int command;
> - int reason_code;
> - } mlme;
> - struct {
> - u8 alg[IEEE_CRYPT_ALG_NAME_LEN];
> - u8 set_tx;
> - u32 err;
> - u8 idx;
> - u8 seq[8]; /* sequence counter (set: RX, get: TX) /
> - u16 key_len;
> - u8 key[];
> - } crypt;
> - } u;
> -};
> -
> -#define MIN_FRAG_THRESHOLD 256U
> -#define MAX_FRAG_THRESHOLD 2346U
> -
> -/ QoS,QOS /
> -#define NORMAL_ACK 0
> -
> -/ IEEE 802.11 defines /
> -
> -#define P80211_OUI_LEN 3
> -
> -struct ieee80211_snap_hdr {
> - u8 dsap; / always 0xAA /
> - u8 ssap; / always 0xAA /
> - u8 ctrl; / always 0x03 /
> - u8 oui[P80211_OUI_LEN]; / organizational universal id /
> -} __packed;
> -
> -#define SNAP_SIZE sizeof(struct ieee80211_snap_hdr)
> -
> -#define IEEE80211_CCK_RATE_LEN 4
> -#define IEEE80211_NUM_OFDM_RATESLEN 8
> -
> -#define IEEE80211_CCK_RATE_1MB 0x02
> -#define IEEE80211_CCK_RATE_2MB 0x04
> -#define IEEE80211_CCK_RATE_5MB 0x0B
> -#define IEEE80211_CCK_RATE_11MB 0x16
> -#define IEEE80211_OFDM_RATE_6MB 0x0C
> -#define IEEE80211_OFDM_RATE_9MB 0x12
> -#define IEEE80211_OFDM_RATE_12MB 0x18
> -#define IEEE80211_OFDM_RATE_18MB 0x24
> -#define IEEE80211_OFDM_RATE_24MB 0x30
> -#define IEEE80211_OFDM_RATE_36MB 0x48
> -#define IEEE80211_OFDM_RATE_48MB 0x60
> -#define IEEE80211_OFDM_RATE_54MB 0x6C
> -#define IEEE80211_BASIC_RATE_MASK 0x80
> -
> -#define WEP_KEYS 4
> -
> -/ MAX_RATES_LENGTH needs to be 12. The spec says 8, and many APs
> - * only use 8, and then use extended rates for the remaining supported
> - * rates. Other APs, however, stick all of their supported rates on the
> - * main rates information element...
> - /
> -#define MAX_RATES_LENGTH ((u8)12)
> -#define MAX_WPA_IE_LEN 128
> -
> -struct registry_priv;
> -
> -u8 r8712_set_ie(u8 pbuf, sint index, uint len, u8 source, uint frlen);
> -u8 r8712_get_ie(u8 pbuf, sint index, uint len, sint limit);
> -unsigned char r8712_get_wpa_ie(unsigned char pie, uint rsn_ie_len,
> - int limit);
> -unsigned char r8712_get_wpa2_ie(unsigned char pie, uint rsn_ie_len,
> - int limit);
> -int r8712_parse_wpa_ie(u8 wpa_ie, int wpa_ie_len, int group_cipher,
> - int pairwise_cipher);
> -int r8712_parse_wpa2_ie(u8 wpa_ie, int wpa_ie_len, int group_cipher,
> - int pairwise_cipher);
> -int r8712_get_sec_ie(u8 in_ie, uint in_len, u8 rsn_ie, u16 rsn_len,
> - u8 wpa_ie, u16 wpa_len);
> -int r8712_get_wps_ie(u8 in_ie, uint in_len, u8 wps_ie, uint wps_ielen);
> -int r8712_generate_ie(struct registry_priv pregistrypriv);
> -uint r8712_is_cckrates_included(u8 rate);
> -uint r8712_is_cckratesonly_included(u8 rate);
> -
> -#endif / IEEE80211_H /
> -
> diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl87=
12/mlme_linux.c
> deleted file mode 100644
> index fcd2e0a9487a..000000000000
> --- a/drivers/staging/rtl8712/mlme_linux.c
> +++ /dev/null
> @@ -1,161 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************
> - * mlme_linux.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define MLME_OSDEP_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "mlme_osdep.h"
> -#include "rtl871x_security.h"
> -
> -static void sitesurvey_ctrl_handler(struct timer_list *t)
> -{
> - struct _adapter *adapter =3D
> - from_timer(adapter, t,
> - mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer);
> -
> - _r8712_sitesurvey_ctrl_handler(adapter);
> - mod_timer(&adapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer,
>=20
> - jiffies + msecs_to_jiffies(3000));
> -}
> -
> -static void join_timeout_handler (struct timer_list *t)
> -{
> - struct _adapter *adapter =3D
> - from_timer(adapter, t, mlmepriv.assoc_timer);
> -
> - _r8712_join_timeout_handler(adapter);
> -}
> -
> -static void _scan_timeout_handler (struct timer_list *t)
> -{
> - struct _adapter *adapter =3D
> - from_timer(adapter, t, mlmepriv.scan_to_timer);
> -
> - r8712_scan_timeout_handler(adapter);
> -}
> -
> -static void dhcp_timeout_handler (struct timer_list *t)
> -{
> - struct _adapter *adapter =3D
> - from_timer(adapter, t, mlmepriv.dhcp_timer);
> -
> - _r8712_dhcp_timeout_handler(adapter);
> -}
> -
> -static void wdg_timeout_handler (struct timer_list *t)
> -{
> - struct _adapter *adapter =3D
> - from_timer(adapter, t, mlmepriv.wdg_timer);
> -
> - r8712_wdg_wk_cmd(adapter);
> -
> - mod_timer(&adapter->mlmepriv.wdg_timer,
>=20
> - jiffies + msecs_to_jiffies(2000));
> -}
> -
> -void r8712_init_mlme_timer(struct _adapter *adapter)
> -{
> - struct mlme_priv *mlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - timer_setup(&mlmepriv->assoc_timer, join_timeout_handler, 0);
>=20
> - timer_setup(&mlmepriv->sitesurveyctrl.sitesurvey_ctrl_timer,
>=20
> - sitesurvey_ctrl_handler, 0);
> - timer_setup(&mlmepriv->scan_to_timer, _scan_timeout_handler, 0);
>=20
> - timer_setup(&mlmepriv->dhcp_timer, dhcp_timeout_handler, 0);
>=20
> - timer_setup(&mlmepriv->wdg_timer, wdg_timeout_handler, 0);
>=20
> -}
> -
> -void r8712_os_indicate_connect(struct _adapter *adapter)
> -{
> - r8712_indicate_wx_assoc_event(adapter);
> - netif_carrier_on(adapter->pnetdev);
>=20
> -}
> -
> -static struct RT_PMKID_LIST backup_PMKID_list[NUM_PMKID_CACHE];
> -void r8712_os_indicate_disconnect(struct _adapter *adapter)
> -{
> - u8 backup_PMKID_index =3D 0;
> - u8 backup_TKIP_countermeasure =3D 0x00;
> -
> - r8712_indicate_wx_disassoc_event(adapter);
> - netif_carrier_off(adapter->pnetdev);
>=20
> - if (adapter->securitypriv.auth_algorithm =3D=3D AUTH_8021x) {
>=20
> - /* We have to backup the PMK information for WiFi PMK Caching
> - * test item. Backup the btkip_countermeasure information.
> - * When the countermeasure is trigger, the driver have to
> - * disconnect with AP for 60 seconds.
> - */
> -
> - memcpy(&backup_PMKID_list[0],
> - &adapter->securitypriv.PMKIDList[0],
>=20
> - sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
> - backup_PMKID_index =3D adapter->securitypriv.PMKIDIndex;
>=20
> - backup_TKIP_countermeasure =3D
> - adapter->securitypriv.btkip_countermeasure;
>=20
> - memset((unsigned char *)&adapter->securitypriv, 0,
>=20
> - sizeof(struct security_priv));
> - timer_setup(&adapter->securitypriv.tkip_timer,
>=20
> - r8712_use_tkipkey_handler, 0);
> - /* Restore the PMK information to securitypriv structure
> - * for the following connection.
> - */
> - memcpy(&adapter->securitypriv.PMKIDList[0],
>=20
> - &backup_PMKID_list[0],
> - sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
> - adapter->securitypriv.PMKIDIndex =3D backup_PMKID_index;
>=20
> - adapter->securitypriv.btkip_countermeasure =3D
>=20
> - backup_TKIP_countermeasure;
> - } else { /reset values in securitypriv/
> - struct security_priv *sec_priv =3D &adapter->securitypriv;
>=20
> -
> - sec_priv->auth_algorithm =3D AUTH_OPEN_SYSTEM;
>=20
> - sec_priv->privacy_algorithm =3D NO_PRIVACY;
>=20
> - sec_priv->PrivacyKeyIndex =3D 0;
>=20
> - sec_priv->XGrpPrivacy =3D NO_PRIVACY;
>=20
> - sec_priv->XGrpKeyid =3D 1;
>=20
> - sec_priv->ndisauthtype =3D Ndis802_11AuthModeOpen;
>=20
> - sec_priv->ndisencryptstatus =3D Ndis802_11WEPDisabled;
>=20
> - sec_priv->wps_phase =3D false;
>=20
> - }
> -}
> -
> -void r8712_report_sec_ie(struct _adapter *adapter, u8 authmode, u8 *sec_=
ie)
> -{
> - uint len;
> - u8 *buff, *p, i;
> - union iwreq_data wrqu;
> -
> - buff =3D NULL;
> - if (authmode =3D=3D WPA_IE_ID) {
> - buff =3D kzalloc(IW_CUSTOM_MAX, GFP_ATOMIC);
> - if (!buff)
> - return;
> - p =3D buff;
> - p +=3D sprintf(p, "ASSOCINFO(ReqIEs=3D");
> - len =3D sec_ie[1] + 2;
> - len =3D (len < IW_CUSTOM_MAX) ? len : IW_CUSTOM_MAX;
> - for (i =3D 0; i < len; i++)
> - p +=3D sprintf(p, "%02x", sec_ie[i]);
> - p +=3D sprintf(p, ")");
> - memset(&wrqu, 0, sizeof(wrqu));
> - wrqu.data.length =3D p - buff;
> - wrqu.data.length =3D (wrqu.data.length < IW_CUSTOM_MAX) ?
> - wrqu.data.length : IW_CUSTOM_MAX;
> - wireless_send_event(adapter->pnetdev, IWEVCUSTOM, &wrqu, buff);
>=20
> - kfree(buff);
> - }
> -}
> diff --git a/drivers/staging/rtl8712/mlme_osdep.h b/drivers/staging/rtl87=
12/mlme_osdep.h
> deleted file mode 100644
> index a02c782588dd..000000000000
> --- a/drivers/staging/rtl8712/mlme_osdep.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - *******/
> -#ifndef _MLME_OSDEP_H
> -#define _MLME_OSDEP_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -void r8712_init_mlme_timer(struct _adapter padapter);
> -void r8712_os_indicate_disconnect(struct _adapter adapter);
> -void r8712_os_indicate_connect(struct _adapter adapter);
> -void r8712_report_sec_ie(struct _adapter adapter, u8 authmode, u8 sec_ie=
);
> -int r8712_recv_indicatepkts_in_order(struct _adapter adapter,
> - struct recv_reorder_ctrl precvreorder_ctrl,
> - int bforced);
> -void r8712_indicate_wx_assoc_event(struct _adapter padapter);
> -void r8712_indicate_wx_disassoc_event(struct _adapter padapter);
> -
> -#endif /MLME_OSDEP_H/
> -
> diff --git a/drivers/staging/rtl8712/mp_custom_oid.h b/drivers/staging/rt=
l8712/mp_custom_oid.h
> deleted file mode 100644
> index a9fac87fcabc..000000000000
> --- a/drivers/staging/rtl8712/mp_custom_oid.h
> +++ /dev/null
> @@ -1,287 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - **/
> -#ifndef __CUSTOM_OID_H
> -#define __CUSTOM_OID_H
> -
> -/ 0xFF818000 - 0xFF81802F RTL8180 Mass Production Kit
> - * 0xFF818500 - 0xFF81850F RTL8185 Setup Utility
> - * 0xFF818580 - 0xFF81858F RTL8185 Phy Status Utility
> - *
> - * by Owen for Production Kit
> - * For Production Kit with Agilent Equipments
> - * in order to make our custom oids hopefully somewhat unique
> - * we will use 0xFF (indicating implementation specific OID)
> - * 81(first byte of non zero Realtek unique identifier)
> - * 80 (second byte of non zero Realtek unique identifier)
> - * XX (the custom OID number - providing 255 possible custom oids)
> - /
> -#define OID_RT_PRO_RESET_DUT 0xFF818000
> -#define OID_RT_PRO_SET_DATA_RATE 0xFF818001
> -#define OID_RT_PRO_START_TEST 0xFF818002
> -#define OID_RT_PRO_STOP_TEST 0xFF818003
> -#define OID_RT_PRO_SET_PREAMBLE 0xFF818004
> -#define OID_RT_PRO_SET_SCRAMBLER 0xFF818005
> -#define OID_RT_PRO_SET_FILTER_BB 0xFF818006
> -#define OID_RT_PRO_SET_MANUAL_DIVERSITY_BB 0xFF818007
> -#define OID_RT_PRO_SET_CHANNEL_DIRECT_CALL 0xFF818008
> -#define OID_RT_PRO_SET_SLEEP_MODE_DIRECT_CALL 0xFF818009
> -#define OID_RT_PRO_SET_WAKE_MODE_DIRECT_CALL 0xFF81800A
> -
> -#define OID_RT_PRO_SET_TX_ANTENNA_BB 0xFF81800D
> -#define OID_RT_PRO_SET_ANTENNA_BB 0xFF81800E
> -#define OID_RT_PRO_SET_CR_SCRAMBLER 0xFF81800F
> -#define OID_RT_PRO_SET_CR_NEW_FILTER 0xFF818010
> -#define OID_RT_PRO_SET_TX_POWER_CONTROL 0xFF818011
> -#define OID_RT_PRO_SET_CR_TX_CONFIG 0xFF818012
> -#define OID_RT_PRO_GET_TX_POWER_CONTROL 0xFF818013
> -#define OID_RT_PRO_GET_CR_SIGNAL_QUALITY 0xFF818014
> -#define OID_RT_PRO_SET_CR_SETPOINT 0xFF818015
> -#define OID_RT_PRO_SET_INTEGRATOR 0xFF818016
> -#define OID_RT_PRO_SET_SIGNAL_QUALITY 0xFF818017
> -#define OID_RT_PRO_GET_INTEGRATOR 0xFF818018
> -#define OID_RT_PRO_GET_SIGNAL_QUALITY 0xFF818019
> -#define OID_RT_PRO_QUERY_EEPROM_TYPE 0xFF81801A
> -#define OID_RT_PRO_WRITE_MAC_ADDRESS 0xFF81801B
> -#define OID_RT_PRO_READ_MAC_ADDRESS 0xFF81801C
> -#define OID_RT_PRO_WRITE_CIS_DATA 0xFF81801D
> -#define OID_RT_PRO_READ_CIS_DATA 0xFF81801E
> -#define OID_RT_PRO_WRITE_POWER_CONTROL 0xFF81801F
> -#define OID_RT_PRO_READ_POWER_CONTROL 0xFF818020
> -#define OID_RT_PRO_WRITE_EEPROM 0xFF818021
> -#define OID_RT_PRO_READ_EEPROM 0xFF818022
> -#define OID_RT_PRO_RESET_TX_PACKET_SENT 0xFF818023
> -#define OID_RT_PRO_QUERY_TX_PACKET_SENT 0xFF818024
> -#define OID_RT_PRO_RESET_RX_PACKET_RECEIVED 0xFF818025
> -#define OID_RT_PRO_QUERY_RX_PACKET_RECEIVED 0xFF818026
> -#define OID_RT_PRO_QUERY_RX_PACKET_CRC32_ERROR 0xFF818027
> -#define OID_RT_PRO_QUERY_CURRENT_ADDRESS 0xFF818028
> -#define OID_RT_PRO_QUERY_PERMANENT_ADDRESS 0xFF818029
> -#define OID_RT_PRO_SET_PHILIPS_RF_PARAMETERS 0xFF81802A
> -#define OID_RT_PRO_RECEIVE_PACKET 0xFF81802C
> -#define OID_RT_PRO_WRITE_EEPROM_BYTE 0xFF81802D
> -#define OID_RT_PRO_READ_EEPROM_BYTE 0xFF81802E
> -#define OID_RT_PRO_SET_MODULATION 0xFF81802F
> -#define OID_RT_DRIVER_OPTION 0xFF818080
> -#define OID_RT_RF_OFF 0xFF818081
> -#define OID_RT_AUTH_STATUS 0xFF818082
> -#define OID_RT_PRO_SET_CONTINUOUS_TX 0xFF81800B
> -#define OID_RT_PRO_SET_SINGLE_CARRIER_TX 0xFF81800C
> -#define OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX 0xFF81802B
> -#define OID_RT_PRO_SET_SINGLE_TONE_TX 0xFF818043
> -#define OID_RT_UTILITY_FALSE_ALARM_COUNTERS 0xFF818580
> -#define OID_RT_UTILITY_SELECT_DEBUG_MODE 0xFF818581
> -#define OID_RT_UTILITY_SELECT_SUBCARRIER_NUMBER 0xFF818582
> -#define OID_RT_UTILITY_GET_RSSI_STATUS 0xFF818583
> -#define OID_RT_UTILITY_GET_FRAME_DETECTION_STATUS 0xFF818584
> -#define OID_RT_UTILITY_GET_AGC_AND_FREQUENCY_OFFSET_ESTIMATION_STATUS \
> - 0xFF818585
> -#define OID_RT_UTILITY_GET_CHANNEL_ESTIMATION_STATUS 0xFF818586
> -#define OID_RT_WIRELESS_MODE 0xFF818500
> -#define OID_RT_SUPPORTED_RATES 0xFF818501
> -#define OID_RT_DESIRED_RATES 0xFF818502
> -#define OID_RT_WIRELESS_MODE_STARTING_ADHOC 0xFF818503
> -#define OID_RT_GET_CONNECT_STATE 0xFF030001
> -#define OID_RT_RESCAN 0xFF030002
> -#define OID_RT_SET_KEY_LENGTH 0xFF030003
> -#define OID_RT_SET_DEFAULT_KEY_ID 0xFF030004
> -#define OID_RT_SET_CHANNEL 0xFF010182
> -#define OID_RT_SET_SNIFFER_MODE 0xFF010183
> -#define OID_RT_GET_SIGNAL_QUALITY 0xFF010184
> -#define OID_RT_GET_SMALL_PACKET_CRC 0xFF010185
> -#define OID_RT_GET_MIDDLE_PACKET_CRC 0xFF010186
> -#define OID_RT_GET_LARGE_PACKET_CRC 0xFF010187
> -#define OID_RT_GET_TX_RETRY 0xFF010188
> -#define OID_RT_GET_RX_RETRY 0xFF010189
> -#define OID_RT_PRO_SET_FW_DIG_STATE 0xFF01018A
> -#define OID_RT_PRO_SET_FW_RA_STATE 0xFF01018B
> -#define OID_RT_GET_RX_TOTAL_PACKET 0xFF010190
> -#define OID_RT_GET_TX_BEACON_OK 0xFF010191
> -#define OID_RT_GET_TX_BEACON_ERR 0xFF010192
> -#define OID_RT_GET_RX_ICV_ERR 0xFF010193
> -#define OID_RT_SET_ENCRYPTION_ALGORITHM 0xFF010194
> -#define OID_RT_SET_NO_AUTO_RESCAN 0xFF010195
> -#define OID_RT_GET_PREAMBLE_MODE 0xFF010196
> -#define OID_RT_GET_DRIVER_UP_DELTA_TIME 0xFF010197
> -#define OID_RT_GET_AP_IP 0xFF010198
> -#define OID_RT_GET_CHANNELPLAN 0xFF010199
> -#define OID_RT_SET_PREAMBLE_MODE 0xFF01019A
> -#define OID_RT_SET_BCN_INTVL 0xFF01019B
> -#define OID_RT_GET_RF_VENDER 0xFF01019C
> -#define OID_RT_DEDICATE_PROBE 0xFF01019D
> -#define OID_RT_PRO_RX_FILTER_PATTERN 0xFF01019E
> -#define OID_RT_GET_DCST_CURRENT_THRESHOLD 0xFF01019F
> -#define OID_RT_GET_CCA_ERR 0xFF0101A0
> -#define OID_RT_GET_CCA_UPGRADE_THRESHOLD 0xFF0101A1
> -#define OID_RT_GET_CCA_FALLBACK_THRESHOLD 0xFF0101A2
> -#define OID_RT_GET_CCA_UPGRADE_EVALUATE_TIMES 0xFF0101A3
> -#define OID_RT_GET_CCA_FALLBACK_EVALUATE_TIMES 0xFF0101A4
> -#define OID_RT_SET_RATE_ADAPTIVE 0xFF0101A5
> -#define OID_RT_GET_DCST_EVALUATE_PERIOD 0xFF0101A5
> -#define OID_RT_GET_DCST_TIME_UNIT_INDEX 0xFF0101A6
> -#define OID_RT_GET_TOTAL_TX_BYTES 0xFF0101A7
> -#define OID_RT_GET_TOTAL_RX_BYTES 0xFF0101A8
> -#define OID_RT_CURRENT_TX_POWER_LEVEL 0xFF0101A9
> -#define OID_RT_GET_ENC_KEY_MISMATCH_COUNT 0xFF0101AA
> -#define OID_RT_GET_ENC_KEY_MATCH_COUNT 0xFF0101AB
> -#define OID_RT_GET_CHANNEL 0xFF0101AC
> -#define OID_RT_SET_CHANNELPLAN 0xFF0101AD
> -#define OID_RT_GET_HARDWARE_RADIO_OFF 0xFF0101AE
> -#define OID_RT_CHANNELPLAN_BY_COUNTRY 0xFF0101AF
> -#define OID_RT_SCAN_AVAILABLE_BSSID 0xFF0101B0
> -#define OID_RT_GET_HARDWARE_VERSION 0xFF0101B1
> -#define OID_RT_GET_IS_ROAMING 0xFF0101B2
> -#define OID_RT_GET_IS_PRIVACY 0xFF0101B3
> -#define OID_RT_GET_KEY_MISMATCH 0xFF0101B4
> -#define OID_RT_SET_RSSI_ROAM_TRAFFIC_TH 0xFF0101B5
> -#define OID_RT_SET_RSSI_ROAM_SIGNAL_TH 0xFF0101B6
> -#define OID_RT_RESET_LOG 0xFF0101B7
> -#define OID_RT_GET_LOG 0xFF0101B8
> -#define OID_RT_SET_INDICATE_HIDDEN_AP 0xFF0101B9
> -#define OID_RT_GET_HEADER_FAIL 0xFF0101BA
> -#define OID_RT_SUPPORTED_WIRELESS_MODE 0xFF0101BB
> -#define OID_RT_GET_CHANNEL_LIST 0xFF0101BC
> -#define OID_RT_GET_SCAN_IN_PROGRESS 0xFF0101BD
> -#define OID_RT_GET_TX_INFO 0xFF0101BE
> -#define OID_RT_RF_READ_WRITE_OFFSET 0xFF0101BF
> -#define OID_RT_RF_READ_WRITE 0xFF0101C0
> -#define OID_RT_FORCED_DATA_RATE 0xFF0101C1
> -#define OID_RT_WIRELESS_MODE_FOR_SCAN_LIST 0xFF0101C2
> -#define OID_RT_GET_BSS_WIRELESS_MODE 0xFF0101C3
> -#define OID_RT_SCAN_WITH_MAGIC_PACKET 0xFF0101C4
> -#define OID_RT_PRO_RX_FILTER 0xFF0111C0
> -#define OID_CE_USB_WRITE_REGISTRY 0xFF0111C1
> -#define OID_CE_USB_READ_REGISTRY 0xFF0111C2
> -#define OID_RT_PRO_SET_INITIAL_GAIN 0xFF0111C3
> -#define OID_RT_PRO_SET_BB_RF_STANDBY_MODE 0xFF0111C4
> -#define OID_RT_PRO_SET_BB_RF_SHUTDOWN_MODE 0xFF0111C5
> -#define OID_RT_PRO_SET_TX_CHARGE_PUMP 0xFF0111C6
> -#define OID_RT_PRO_SET_RX_CHARGE_PUMP 0xFF0111C7
> -#define OID_RT_PRO_RF_WRITE_REGISTRY 0xFF0111C8
> -#define OID_RT_PRO_RF_READ_REGISTRY 0xFF0111C9
> -#define OID_RT_PRO_QUERY_RF_TYPE 0xFF0111CA
> -#define OID_RT_AP_GET_ASSOCIATED_STATION_LIST 0xFF010300
> -#define OID_RT_AP_GET_CURRENT_TIME_STAMP 0xFF010301
> -#define OID_RT_AP_SWITCH_INTO_AP_MODE 0xFF010302
> -#define OID_RT_AP_SET_DTIM_PERIOD 0xFF010303
> -#define OID_RT_AP_SUPPORTED 0xFF010304
> -#define OID_RT_AP_SET_PASSPHRASE 0xFF010305
> -#define OID_RT_PRO8187_WI_POLL 0xFF818780
> -#define OID_RT_PRO_WRITE_BB_REG 0xFF818781
> -#define OID_RT_PRO_READ_BB_REG 0xFF818782
> -#define OID_RT_PRO_WRITE_RF_REG 0xFF818783
> -#define OID_RT_PRO_READ_RF_REG 0xFF818784
> -#define OID_RT_MH_VENDER_ID 0xFFEDC100
> -#define OID_RT_PRO8711_JOIN_BSS 0xFF871100
> -#define OID_RT_PRO_READ_REGISTER 0xFF871101
> -#define OID_RT_PRO_WRITE_REGISTER 0xFF871102
> -#define OID_RT_PRO_BURST_READ_REGISTER 0xFF871103
> -#define OID_RT_PRO_BURST_WRITE_REGISTER 0xFF871104
> -#define OID_RT_PRO_WRITE_TXCMD 0xFF871105
> -#define OID_RT_PRO_READ16_EEPROM 0xFF871106
> -#define OID_RT_PRO_WRITE16_EEPROM 0xFF871107
> -#define OID_RT_PRO_H2C_SET_COMMAND 0xFF871108
> -#define OID_RT_PRO_H2C_QUERY_RESULT 0xFF871109
> -#define OID_RT_PRO8711_WI_POLL 0xFF87110A
> -#define OID_RT_PRO8711_PKT_LOSS 0xFF87110B
> -#define OID_RT_RD_ATTRIB_MEM 0xFF87110C
> -#define OID_RT_WR_ATTRIB_MEM 0xFF87110D
> -/Method 2 for H2C/C2H/
> -#define OID_RT_PRO_H2C_CMD_MODE 0xFF871110
> -#define OID_RT_PRO_H2C_CMD_RSP_MODE 0xFF871111
> -#define OID_RT_PRO_H2C_CMD_EVENT_MODE 0xFF871112
> -#define OID_RT_PRO_WAIT_C2H_EVENT 0xFF871113
> -#define OID_RT_PRO_RW_ACCESS_PROTOCOL_TEST 0xFF871114
> -#define OID_RT_PRO_SCSI_ACCESS_TEST 0xFF871115
> -#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_OUT 0xFF871116
> -#define OID_RT_PRO_SCSI_TCPIPOFFLOAD_IN 0xFF871117
> -#define OID_RT_RRO_RX_PKT_VIA_IOCTRL 0xFF871118
> -#define OID_RT_RRO_RX_PKTARRAY_VIA_IOCTRL 0xFF871119
> -#define OID_RT_RPO_SET_PWRMGT_TEST 0xFF87111A
> -#define OID_RT_PRO_QRY_PWRMGT_TEST 0XFF87111B
> -#define OID_RT_RPO_ASYNC_RWIO_TEST 0xFF87111C
> -#define OID_RT_RPO_ASYNC_RWIO_POLL 0xFF87111D
> -#define OID_RT_PRO_SET_RF_INTFS 0xFF87111E
> -#define OID_RT_POLL_RX_STATUS 0xFF87111F
> -#define OID_RT_PRO_CFG_DEBUG_MESSAGE 0xFF871120
> -#define OID_RT_PRO_SET_DATA_RATE_EX 0xFF871121
> -#define OID_RT_PRO_SET_BASIC_RATE 0xFF871122
> -#define OID_RT_PRO_READ_TSSI 0xFF871123
> -#define OID_RT_PRO_SET_POWER_TRACKING 0xFF871124
> -#define OID_RT_PRO_QRY_PWRSTATE 0xFF871150
> -#define OID_RT_PRO_SET_PWRSTATE 0xFF871151
> -/Method 2 , using workitem /
> -#define OID_RT_SET_READ_REG 0xFF871181
> -#define OID_RT_SET_WRITE_REG 0xFF871182
> -#define OID_RT_SET_BURST_READ_REG 0xFF871183
> -#define OID_RT_SET_BURST_WRITE_REG 0xFF871184
> -#define OID_RT_SET_WRITE_TXCMD 0xFF871185
> -#define OID_RT_SET_READ16_EEPROM 0xFF871186
> -#define OID_RT_SET_WRITE16_EEPROM 0xFF871187
> -#define OID_RT_QRY_POLL_WKITEM 0xFF871188
> -
> -/For SDIO INTERFACE only/
> -#define OID_RT_PRO_SYNCPAGERW_SRAM 0xFF8711A0
> -#define OID_RT_PRO_871X_DRV_EXT 0xFF8711A1
> -
> -/For USB INTERFACE only/
> -#define OID_RT_PRO_USB_VENDOR_REQ 0xFF8711B0
> -#define OID_RT_PRO_SCSI_AUTO_TEST 0xFF8711B1
> -#define OID_RT_PRO_USB_MAC_AC_FIFO_WRITE 0xFF8711B2
> -#define OID_RT_PRO_USB_MAC_RX_FIFO_READ 0xFF8711B3
> -#define OID_RT_PRO_USB_MAC_RX_FIFO_POLLING 0xFF8711B4
> -
> -#define OID_RT_PRO_H2C_SET_RATE_TABLE 0xFF8711FB
> -#define OID_RT_PRO_H2C_GET_RATE_TABLE 0xFF8711FC
> -#define OID_RT_PRO_H2C_C2H_LBK_TEST 0xFF8711FE
> -
> -#define OID_RT_PRO_ENCRYPTION_CTRL 0xFF871200
> -#define OID_RT_PRO_ADD_STA_INFO 0xFF871201
> -#define OID_RT_PRO_DELE_STA_INFO 0xFF871202
> -#define OID_RT_PRO_QUERY_DR_VARIABLE 0xFF871203
> -
> -#define OID_RT_PRO_RX_PACKET_TYPE 0xFF871204
> -
> -#define OID_RT_PRO_READ_EFUSE 0xFF871205
> -#define OID_RT_PRO_WRITE_EFUSE 0xFF871206
> -#define OID_RT_PRO_RW_EFUSE_PGPKT 0xFF871207
> -#define OID_RT_GET_EFUSE_CURRENT_SIZE 0xFF871208
> -
> -#define OID_RT_SET_BANDWIDTH 0xFF871209
> -#define OID_RT_SET_CRYSTAL_CAP 0xFF87120A
> -
> -#define OID_RT_SET_RX_PACKET_TYPE 0xFF87120B
> -
> -#define OID_RT_GET_EFUSE_MAX_SIZE 0xFF87120C
> -
> -#define OID_RT_PRO_SET_TX_AGC_OFFSET 0xFF87120D
> -
> -#define OID_RT_PRO_SET_PKT_TEST_MODE 0xFF87120E
> -
> -#define OID_RT_PRO_FOR_EVM_TEST_SETTING 0xFF87120F
> -
> -#define OID_RT_PRO_GET_THERMAL_METER 0xFF871210
> -
> -#define OID_RT_RESET_PHY_RX_PACKET_COUNT 0xFF871211
> -#define OID_RT_GET_PHY_RX_PACKET_RECEIVED 0xFF871212
> -#define OID_RT_GET_PHY_RX_PACKET_CRC32_ERROR 0xFF871213
> -
> -#define OID_RT_SET_POWER_DOWN 0xFF871214
> -
> -#define OID_RT_GET_POWER_MODE 0xFF871215
> -
> -#define OID_RT_PRO_EFUSE 0xFF871216
> -#define OID_RT_PRO_EFUSE_MAP 0xFF871217
> -
> -#endif /#ifndef __CUSTOM_OID_H /
> -
> diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712=
/os_intfs.c
> deleted file mode 100644
> index 1b11f8b04e13..000000000000
> --- a/drivers/staging/rtl8712/os_intfs.c
> +++ /dev/null
> @@ -1,482 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * os_intfs.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define OS_INTFS_C
> -
> -#include <linux/module.h>
>=20
> -#include <linux/kthread.h>
>=20
> -#include <linux/firmware.h>
>=20
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "xmit_osdep.h"
> -#include "recv_osdep.h"
> -#include "rtl871x_ioctl.h"
> -#include "usb_osintf.h"
> -
> -MODULE_LICENSE("GPL");
> -MODULE_DESCRIPTION("rtl871x wireless lan driver");
> -MODULE_AUTHOR("Larry Finger");
> -
> -static char ifname[IFNAMSIZ] =3D "wlan%d";
> -
> -/* module param defaults /
> -static int chip_version =3D RTL8712_2ndCUT;
> -static int rfintfs =3D HWPI;
> -static int lbkmode =3D RTL8712_AIR_TRX;
> -static int hci =3D RTL8712_USB;
> -static int ampdu_enable =3D 1;/for enable tx_ampdu/
> -
> -/ The video_mode variable is for video mode./
> -/ It may be specify when inserting module with video_mode=3D1 parameter.=
/
> -static int video_mode =3D 1; / enable video mode*/
> -
> -/Ndis802_11Infrastructure; infra, ad-hoc, auto/
> -static int network_mode =3D Ndis802_11IBSS;
> -static int channel =3D 1;/ad-hoc support requirement/
> -static int wireless_mode =3D WIRELESS_11BG;
> -static int vrtl_carrier_sense =3D AUTO_VCS;
> -static int vcs_type =3D RTS_CTS;
> -static int frag_thresh =3D 2346;
> -static int preamble =3D PREAMBLE_LONG;/long, short, auto/
> -static int scan_mode =3D 1;/active, passive/
> -static int adhoc_tx_pwr =3D 1;
> -static int soft_ap;
> -static int smart_ps =3D 1;
> -static int power_mgnt =3D PS_MODE_ACTIVE;
> -static int radio_enable =3D 1;
> -static int long_retry_lmt =3D 7;
> -static int short_retry_lmt =3D 7;
> -static int busy_thresh =3D 40;
> -static int ack_policy =3D NORMAL_ACK;
> -static int mp_mode;
> -static int software_encrypt;
> -static int software_decrypt;
> -
> -static int wmm_enable;/* default is set to disable the wmm./
> -static int uapsd_enable;
> -static int uapsd_max_sp =3D NO_LIMIT;
> -static int uapsd_acbk_en;
> -static int uapsd_acbe_en;
> -static int uapsd_acvi_en;
> -static int uapsd_acvo_en;
> -
> -static int ht_enable =3D 1;
> -static int cbw40_enable =3D 1;
> -static int rf_config =3D RTL8712_RF_1T2R; / 1T2R*/
> -static int low_power;
> -/* mac address to use instead of the one stored in Efuse */
> -char *r8712_initmac;
> -static char initmac;
> -/ if wifi_test =3D 1, driver will disable the turbo mode and pass it to
> - * firmware private.
> - */
> -static int wifi_test;
> -
> -module_param_string(ifname, ifname, sizeof(ifname), 0644);
> -module_param(wifi_test, int, 0644);
> -module_param(initmac, charp, 0644);
> -module_param(video_mode, int, 0644);
> -module_param(chip_version, int, 0644);
> -module_param(rfintfs, int, 0644);
> -module_param(lbkmode, int, 0644);
> -module_param(hci, int, 0644);
> -module_param(network_mode, int, 0644);
> -module_param(channel, int, 0644);
> -module_param(mp_mode, int, 0644);
> -module_param(wmm_enable, int, 0644);
> -module_param(vrtl_carrier_sense, int, 0644);
> -module_param(vcs_type, int, 0644);
> -module_param(busy_thresh, int, 0644);
> -module_param(ht_enable, int, 0644);
> -module_param(cbw40_enable, int, 0644);
> -module_param(ampdu_enable, int, 0644);
> -module_param(rf_config, int, 0644);
> -module_param(power_mgnt, int, 0644);
> -module_param(low_power, int, 0644);
> -
> -MODULE_PARM_DESC(ifname, " Net interface name, wlan%d=3Ddefault");
> -MODULE_PARM_DESC(initmac, "MAC-Address, default: use FUSE");
> -
> -static int netdev_open(struct net_device *pnetdev);
> -static int netdev_close(struct net_device *pnetdev);
> -
> -static void loadparam(struct _adapter *padapter, struct net_device *pnet=
dev)
> -{
> - struct registry_priv *registry_par =3D &padapter->registrypriv;
>=20
> -
> - registry_par->chip_version =3D (u8)chip_version;
>=20
> - registry_par->rfintfs =3D (u8)rfintfs;
>=20
> - registry_par->lbkmode =3D (u8)lbkmode;
>=20
> - registry_par->hci =3D (u8)hci;
>=20
> - registry_par->network_mode =3D (u8)network_mode;
>=20
> - memcpy(registry_par->ssid.Ssid, "ANY", 3);
>=20
> - registry_par->ssid.SsidLength =3D 3;
>=20
> - registry_par->channel =3D (u8)channel;
>=20
> - registry_par->wireless_mode =3D (u8)wireless_mode;
>=20
> - registry_par->vrtl_carrier_sense =3D (u8)vrtl_carrier_sense;
>=20
> - registry_par->vcs_type =3D (u8)vcs_type;
>=20
> - registry_par->frag_thresh =3D (u16)frag_thresh;
>=20
> - registry_par->preamble =3D (u8)preamble;
>=20
> - registry_par->scan_mode =3D (u8)scan_mode;
>=20
> - registry_par->adhoc_tx_pwr =3D (u8)adhoc_tx_pwr;
>=20
> - registry_par->soft_ap =3D (u8)soft_ap;
>=20
> - registry_par->smart_ps =3D (u8)smart_ps;
>=20
> - registry_par->power_mgnt =3D (u8)power_mgnt;
>=20
> - registry_par->radio_enable =3D (u8)radio_enable;
>=20
> - registry_par->long_retry_lmt =3D (u8)long_retry_lmt;
>=20
> - registry_par->short_retry_lmt =3D (u8)short_retry_lmt;
>=20
> - registry_par->busy_thresh =3D (u16)busy_thresh;
>=20
> - registry_par->ack_policy =3D (u8)ack_policy;
>=20
> - registry_par->mp_mode =3D (u8)mp_mode;
>=20
> - registry_par->software_encrypt =3D (u8)software_encrypt;
>=20
> - registry_par->software_decrypt =3D (u8)software_decrypt;
>=20
> - /UAPSD/
> - registry_par->wmm_enable =3D (u8)wmm_enable;
>=20
> - registry_par->uapsd_enable =3D (u8)uapsd_enable;
>=20
> - registry_par->uapsd_max_sp =3D (u8)uapsd_max_sp;
>=20
> - registry_par->uapsd_acbk_en =3D (u8)uapsd_acbk_en;
>=20
> - registry_par->uapsd_acbe_en =3D (u8)uapsd_acbe_en;
>=20
> - registry_par->uapsd_acvi_en =3D (u8)uapsd_acvi_en;
>=20
> - registry_par->uapsd_acvo_en =3D (u8)uapsd_acvo_en;
>=20
> - registry_par->ht_enable =3D (u8)ht_enable;
>=20
> - registry_par->cbw40_enable =3D (u8)cbw40_enable;
>=20
> - registry_par->ampdu_enable =3D (u8)ampdu_enable;
>=20
> - registry_par->rf_config =3D (u8)rf_config;
>=20
> - registry_par->low_power =3D (u8)low_power;
>=20
> - registry_par->wifi_test =3D (u8)wifi_test;
>=20
> - r8712_initmac =3D initmac;
> -}
> -
> -static int r871x_net_set_mac_address(struct net_device *pnetdev, void *p=
)
> -{
> - struct _adapter *padapter =3D netdev_priv(pnetdev);
> - struct sockaddr *addr =3D p;
> -
> - if (!padapter->bup)
>=20
> - eth_hw_addr_set(pnetdev, addr->sa_data);
>=20
> - return 0;
> -}
> -
> -static struct net_device_stats *r871x_net_get_stats(struct net_device *p=
netdev)
> -{
> - struct _adapter *padapter =3D netdev_priv(pnetdev);
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct recv_priv *precvpriv =3D &padapter->recvpriv;
>=20
> -
> - padapter->stats.tx_packets =3D pxmitpriv->tx_pkts;
>=20
> - padapter->stats.rx_packets =3D precvpriv->rx_pkts;
>=20
> - padapter->stats.tx_dropped =3D pxmitpriv->tx_drop;
>=20
> - padapter->stats.rx_dropped =3D precvpriv->rx_drop;
>=20
> - padapter->stats.tx_bytes =3D pxmitpriv->tx_bytes;
>=20
> - padapter->stats.rx_bytes =3D precvpriv->rx_bytes;
>=20
> - return &padapter->stats;
>=20
> -}
> -
> -static const struct net_device_ops rtl8712_netdev_ops =3D {
> - .ndo_open =3D netdev_open,
> - .ndo_stop =3D netdev_close,
> - .ndo_start_xmit =3D r8712_xmit_entry,
> - .ndo_set_mac_address =3D r871x_net_set_mac_address,
> - .ndo_get_stats =3D r871x_net_get_stats,
> - .ndo_do_ioctl =3D r871x_ioctl,
> -};
> -
> -struct net_device *r8712_init_netdev(void)
> -{
> - struct _adapter *padapter;
> - struct net_device *pnetdev;
> -
> - pnetdev =3D alloc_etherdev(sizeof(struct _adapter));
> - if (!pnetdev)
> - return NULL;
> - if (dev_alloc_name(pnetdev, ifname) < 0) {
> - strscpy(ifname, "wlan%d", sizeof(ifname));
> - dev_alloc_name(pnetdev, ifname);
> - }
> - padapter =3D netdev_priv(pnetdev);
> - padapter->pnetdev =3D pnetdev;
>=20
> - pr_info("r8712u: register rtl8712_netdev_ops to netdev_ops\n");
> - pnetdev->netdev_ops =3D &rtl8712_netdev_ops;
>=20
> - pnetdev->watchdog_timeo =3D HZ; /* 1 second timeout */
>=20
> - pnetdev->wireless_handlers =3D (struct iw_handler_def *)
>=20
> - &r871x_handlers_def;
> - loadparam(padapter, pnetdev);
> - netif_carrier_off(pnetdev);
> - padapter->pid =3D 0; /* Initial the PID value used for HW PBC.*/
>=20
> - return pnetdev;
> -}
> -
> -static u32 start_drv_threads(struct _adapter *padapter)
> -{
> - padapter->cmd_thread =3D kthread_run(r8712_cmd_thread, padapter, "%s",
>=20
> - padapter->pnetdev->name);
>=20
> - if (IS_ERR(padapter->cmd_thread))
>=20
> - return _FAIL;
> - return _SUCCESS;
> -}
> -
> -void r8712_stop_drv_threads(struct _adapter *padapter)
> -{
> - struct completion *completion =3D
> - &padapter->cmdpriv.terminate_cmdthread_comp;
>=20
> -
> - /Below is to terminate r8712_cmd_thread & event_thread.../
> - complete(&padapter->cmdpriv.cmd_queue_comp);
>=20
> - if (padapter->cmd_thread)
>=20
> - wait_for_completion_interruptible(completion);
> - padapter->cmdpriv.cmd_seq =3D 1;
>=20
> -}
> -
> -static void start_drv_timers(struct _adapter *padapter)
> -{
> - mod_timer(&padapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer,
>=20
> - jiffies + msecs_to_jiffies(5000));
> - mod_timer(&padapter->mlmepriv.wdg_timer,
>=20
> - jiffies + msecs_to_jiffies(2000));
> -}
> -
> -void r8712_stop_drv_timers(struct _adapter *padapter)
> -{
> - del_timer_sync(&padapter->mlmepriv.assoc_timer);
>=20
> - del_timer_sync(&padapter->securitypriv.tkip_timer);
>=20
> - del_timer_sync(&padapter->mlmepriv.scan_to_timer);
>=20
> - del_timer_sync(&padapter->mlmepriv.dhcp_timer);
>=20
> - del_timer_sync(&padapter->mlmepriv.wdg_timer);
>=20
> - del_timer_sync(&padapter->mlmepriv.sitesurveyctrl.sitesurvey_ctrl_timer=
);
>=20
> -}
> -
> -static void init_default_value(struct _adapter *padapter)
> -{
> - struct registry_priv *pregistrypriv =3D &padapter->registrypriv;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> -
> - /xmit_priv/
> - pxmitpriv->vcs_setting =3D pregistrypriv->vrtl_carrier_sense;
>=20
> - pxmitpriv->vcs =3D pregistrypriv->vcs_type;
>=20
> - pxmitpriv->vcs_type =3D pregistrypriv->vcs_type;
>=20
> - pxmitpriv->rts_thresh =3D pregistrypriv->rts_thresh;
>=20
> - pxmitpriv->frag_len =3D pregistrypriv->frag_thresh;
>=20
> - /* mlme_priv /
> - / Maybe someday we should rename this variable to "active_mode"(Jeff)/
> - pmlmepriv->passive_mode =3D 1; / 1: active, 0: passive. */
>=20
> - /ht_priv/
> - {
> - int i;
> - struct ht_priv *phtpriv =3D &pmlmepriv->htpriv;
>=20
> -
> - phtpriv->ampdu_enable =3D false;/set to disabled/
>=20
> - for (i =3D 0; i < 16; i++)
> - phtpriv->baddbareq_issued[i] =3D false;
>=20
> - }
> - /security_priv/
> - psecuritypriv->sw_encrypt =3D pregistrypriv->software_encrypt;
>=20
> - psecuritypriv->sw_decrypt =3D pregistrypriv->software_decrypt;
>=20
> - psecuritypriv->binstallGrpkey =3D _FAIL;
>=20
> - /pwrctrl_priv/
> - /registry_priv/
> - r8712_init_registrypriv_dev_network(padapter);
> - r8712_update_registrypriv_dev_network(padapter);
> - /misc./
> -}
> -
> -int r8712_init_drv_sw(struct _adapter *padapter)
> -{
> - int ret;
> -
> - ret =3D r8712_init_cmd_priv(&padapter->cmdpriv);
>=20
> - if (ret)
> - return ret;
> - padapter->cmdpriv.padapter =3D padapter;
>=20
> - ret =3D r8712_init_evt_priv(&padapter->evtpriv);
>=20
> - if (ret)
> - goto free_cmd;
> - ret =3D r8712_init_mlme_priv(padapter);
> - if (ret)
> - goto free_evt;
> - ret =3D _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
>=20
> - if (ret)
> - goto free_mlme;
> - ret =3D _r8712_init_recv_priv(&padapter->recvpriv, padapter);
>=20
> - if (ret)
> - goto free_xmit;
> - memset((unsigned char *)&padapter->securitypriv, 0,
>=20
> - sizeof(struct security_priv));
> - timer_setup(&padapter->securitypriv.tkip_timer,
>=20
> - r8712_use_tkipkey_handler, 0);
> - ret =3D _r8712_init_sta_priv(&padapter->stapriv);
>=20
> - if (ret)
> - goto free_recv;
> - padapter->stapriv.padapter =3D padapter;
>=20
> - r8712_init_bcmc_stainfo(padapter);
> - r8712_init_pwrctrl_priv(padapter);
> - mp871xinit(padapter);
> - init_default_value(padapter);
> - r8712_InitSwLeds(padapter);
> - mutex_init(&padapter->mutex_start);
>=20
> -
> - return 0;
> -
> -free_recv:
> - _r8712_free_recv_priv(&padapter->recvpriv);
>=20
> -free_xmit:
> - _free_xmit_priv(&padapter->xmitpriv);
>=20
> -free_mlme:
> - r8712_free_mlme_priv(&padapter->mlmepriv);
>=20
> -free_evt:
> - r8712_free_evt_priv(&padapter->evtpriv);
>=20
> -free_cmd:
> - r8712_free_cmd_priv(&padapter->cmdpriv);
>=20
> - return ret;
> -}
> -
> -void r8712_free_drv_sw(struct _adapter *padapter)
> -{
> - r8712_free_cmd_priv(&padapter->cmdpriv);
>=20
> - r8712_free_evt_priv(&padapter->evtpriv);
>=20
> - r8712_DeInitSwLeds(padapter);
> - r8712_free_mlme_priv(&padapter->mlmepriv);
>=20
> - _free_xmit_priv(&padapter->xmitpriv);
>=20
> - _r8712_free_sta_priv(&padapter->stapriv);
>=20
> - _r8712_free_recv_priv(&padapter->recvpriv);
>=20
> - mp871xdeinit(padapter);
> -}
> -
> -static void enable_video_mode(struct _adapter padapter, int cbw40_value)
> -{
> - / bit 8:
> - * 1 -> enable video mode to 96B AP
>=20
> - * 0 -> disable video mode to 96B AP
>=20
> - * bit 9:
> - * 1 -> enable 40MHz mode
>=20
> - * 0 -> disable 40MHz mode
>=20
> - * bit 10:
> - * 1 -> enable STBC
>=20
> - * 0 -> disable STBC
>=20
> - /
> - u32 intcmd =3D 0xf4000500; / enable bit8, bit10*/
> -
> - if (cbw40_value) {
> - /* if the driver supports the 40M bandwidth,
> - * we can enable the bit 9.
> - /
> - intcmd |=3D 0x200;
> - }
> - r8712_fw_cmd(padapter, intcmd);
> -}
> -
> -/
> - *
> - * This function intends to handle the activation of an interface
> - * i.e. when it is brought Up/Active from a Down state.
> - *
> - */
> -static int netdev_open(struct net_device *pnetdev)
> -{
> - struct _adapter *padapter =3D netdev_priv(pnetdev);
> -
> - mutex_lock(&padapter->mutex_start);
>=20
> - if (!padapter->bup) {
>=20
> - padapter->driver_stopped =3D false;
>=20
> - padapter->surprise_removed =3D false;
>=20
> - padapter->bup =3D true;
>=20
> - if (rtl871x_hal_init(padapter) !=3D _SUCCESS)
> - goto netdev_open_error;
> - if (!r8712_initmac) {
> - /* Use the mac address stored in the Efuse */
> - eth_hw_addr_set(pnetdev,
> - padapter->eeprompriv.mac_addr);
>=20
> - } else {
> - /* We have to inform f/w to use user-supplied MAC
> - * address.
> - */
> - msleep(200);
> - r8712_setMacAddr_cmd(padapter,
> - (const u8 *)pnetdev->dev_addr);
>=20
> - /*
> - * The "myid" function will get the wifi mac address
> - * from eeprompriv structure instead of netdev
> - * structure. So, we have to overwrite the mac_addr
> - * stored in the eeprompriv structure. In this case,
> - * the real mac address won't be used anymore. So that,
> - * the eeprompriv.mac_addr should store the mac which
> - * users specify.
> - */
> - memcpy(padapter->eeprompriv.mac_addr,
>=20
> - pnetdev->dev_addr, ETH_ALEN);
>=20
> - }
> - if (start_drv_threads(padapter) !=3D _SUCCESS)
> - goto netdev_open_error;
> - if (!padapter->dvobjpriv.inirp_init)
>=20
> - goto netdev_open_error;
> - else
> - padapter->dvobjpriv.inirp_init(padapter);
>=20
> - r8712_set_ps_mode(padapter, padapter->registrypriv.power_mgnt,
>=20
> - padapter->registrypriv.smart_ps);
>=20
> - }
> - if (!netif_queue_stopped(pnetdev))
> - netif_start_queue(pnetdev);
> - else
> - netif_wake_queue(pnetdev);
> -
> - if (video_mode)
> - enable_video_mode(padapter, cbw40_enable);
> - /* start driver mlme relation timer */
> - start_drv_timers(padapter);
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_NO_LINK);
>=20
> - mutex_unlock(&padapter->mutex_start);
>=20
> - return 0;
> -netdev_open_error:
> - padapter->bup =3D false;
>=20
> - netif_carrier_off(pnetdev);
> - netif_stop_queue(pnetdev);
> - mutex_unlock(&padapter->mutex_start);
>=20
> - return -1;
> -}
> -
> -/*
> - *
> - * This function intends to handle the shutdown of an interface
> - * i.e. when it is brought Down from an Up/Active state.
> - *
> - */
> -static int netdev_close(struct net_device pnetdev)
> -{
> - struct _adapter padapter =3D netdev_priv(pnetdev);
> -
> - / Close LED/
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_POWER_OFF);
>=20
> - msleep(200);
> -
> - /s1./
> - if (pnetdev) {
> - if (!netif_queue_stopped(pnetdev))
> - netif_stop_queue(pnetdev);
> - }
> - /s2./
> - /s2-1. issue disassoc_cmd to fw/
> - r8712_disassoc_cmd(padapter);
> - /s2-2. indicate disconnect to os/
> - r8712_ind_disconnect(padapter);
> - /s2-3./
> - r8712_free_assoc_resources(padapter);
> - /s2-4./
> - r8712_free_network_queue(padapter);
> - return 0;
> -}
> -
> -#include "mlme_osdep.h"
> diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl87=
12/osdep_intf.h
> deleted file mode 100644
> index 9e75116c987e..000000000000
> --- a/drivers/staging/rtl8712/osdep_intf.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef _OSDEP_INTF_H
> -#define _OSDEP_INTF_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -#define RND4(x) (((x >> 2) + ((x & 3) !=3D 0)) << 2)
>=20
> -
> -struct intf_priv {
> - u8 intf_dev;
> - / when in USB, IO is through interrupt in/out endpoints /
> - struct usb_device udev;
> - struct urb piorw_urb;
> - struct completion io_retevt_comp;
> -};
> -
> -int r871x_ioctl(struct net_device dev, struct ifreq rq, int cmd);
> -
> -#endif /OSDEP_INTF_H/
> diff --git a/drivers/staging/rtl8712/osdep_service.h b/drivers/staging/rt=
l8712/osdep_service.h
> deleted file mode 100644
> index 0d9bb42cbc58..000000000000
> --- a/drivers/staging/rtl8712/osdep_service.h
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
****
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef _OSDEP_SERVICE_H
> -#define _OSDEP_SERVICE_H
> -
> -#define _SUCCESS 1
> -#define _FAIL 0
> -
> -#include <linux/spinlock.h>
>=20
> -
> -#include <linux/interrupt.h>
>=20
> -#include <linux/semaphore.h>
>=20
> -#include <linux/sched/signal.h>
>=20
> -#include <linux/sem.h>
>=20
> -#include <linux/netdevice.h>
>=20
> -#include <linux/etherdevice.h>
>=20
> -#include <net/iw_handler.h>
>=20
> -#include <linux/proc_fs.h> /* Necessary because we use the proc fs */
>=20
> -
> -#include "basic_types.h"
> -
> -struct __queue {
> - struct list_head queue;
> - spinlock_t lock;
> -};
> -
> -#define _pkt struct sk_buff
> -#define _buffer unsigned char
> -
> -#define _init_queue(pqueue) \
> - do { \
> - INIT_LIST_HEAD(&((pqueue)->queue)); \
>=20
> - spin_lock_init(&((pqueue)->lock)); \
>=20
> - } while (0)
> -
> -static inline u32 end_of_queue_search(struct list_head head,
> - struct list_head plist)
> -{
> - return (head =3D=3D plist);
> -}
> -
> -static inline void flush_signals_thread(void)
> -{
> - if (signal_pending(current))
> - flush_signals(current);
> -}
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/recv_linux.c b/drivers/staging/rtl87=
12/recv_linux.c
> deleted file mode 100644
> index 215fca4abb3a..000000000000
> --- a/drivers/staging/rtl8712/recv_linux.c
> +++ /dev/null
> @@ -1,139 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************************************=
*****
> - * recv_linux.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RECV_OSDEP_C
> -
> -#include <linux/usb.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "wifi.h"
> -#include "recv_osdep.h"
> -#include "osdep_intf.h"
> -#include "ethernet.h"
> -#include <linux/if_arp.h>
>=20
> -#include "usb_ops.h"
> -
> -/init os related resource in struct recv_priv/
> -/alloc os related resource in union recv_frame/
> -void r8712_os_recv_resource_alloc(struct _adapter *padapter,
> - union recv_frame *precvframe)
> -{
> - precvframe->u.hdr.pkt_newalloc =3D NULL;
>=20
> - precvframe->u.hdr.pkt =3D NULL;
>=20
> -}
> -
> -/alloc os related resource in struct recv_buf/
> -int r8712_os_recvbuf_resource_alloc(struct _adapter *padapter,
> - struct recv_buf *precvbuf)
> -{
> - int res =3D 0;
> -
> - precvbuf->irp_pending =3D false;
>=20
> - precvbuf->purb =3D usb_alloc_urb(0, GFP_KERNEL);
>=20
> - if (!precvbuf->purb)
>=20
> - res =3D -ENOMEM;
> - precvbuf->pskb =3D NULL;
>=20
> - precvbuf->pallocated_buf =3D NULL;
>=20
> - precvbuf->pbuf =3D NULL;
>=20
> - precvbuf->pdata =3D NULL;
>=20
> - precvbuf->phead =3D NULL;
>=20
> - precvbuf->ptail =3D NULL;
>=20
> - precvbuf->pend =3D NULL;
>=20
> - precvbuf->transfer_len =3D 0;
>=20
> - precvbuf->len =3D 0;
>=20
> - return res;
> -}
> -
> -/free os related resource in struct recv_buf/
> -void r8712_os_recvbuf_resource_free(struct _adapter *padapter,
> - struct recv_buf *precvbuf)
> -{
> - if (precvbuf->pskb)
>=20
> - dev_kfree_skb_any(precvbuf->pskb);
>=20
> - if (precvbuf->purb) {
>=20
> - usb_kill_urb(precvbuf->purb);
>=20
> - usb_free_urb(precvbuf->purb);
>=20
> - }
> -}
> -
> -void r8712_handle_tkip_mic_err(struct _adapter *adapter, u8 bgroup)
> -{
> - union iwreq_data wrqu;
> - struct iw_michaelmicfailure ev;
> - struct mlme_priv *mlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - memset(&ev, 0x00, sizeof(ev));
> - if (bgroup)
> - ev.flags |=3D IW_MICFAILURE_GROUP;
> - else
> - ev.flags |=3D IW_MICFAILURE_PAIRWISE;
> - ev.src_addr.sa_family =3D ARPHRD_ETHER;
> - ether_addr_copy(ev.src_addr.sa_data, &mlmepriv->assoc_bssid[0]);
>=20
> - memset(&wrqu, 0x00, sizeof(wrqu));
> - wrqu.data.length =3D sizeof(ev);
> - wireless_send_event(adapter->pnetdev, IWEVMICHAELMICFAILURE, &wrqu,
>=20
> - (char *)&ev);
> -}
> -
> -void r8712_recv_indicatepkt(struct _adapter *adapter,
> - union recv_frame *recvframe)
> -{
> - struct recv_priv *recvpriv;
> - struct __queue *free_recv_queue;
> - _pkt *skb;
> - struct rx_pkt_attrib *attrib =3D &recvframe->u.hdr.attrib;
>=20
> -
> - recvpriv =3D &adapter->recvpriv;
>=20
> - free_recv_queue =3D &recvpriv->free_recv_queue;
>=20
> - skb =3D recvframe->u.hdr.pkt;
>=20
> - if (!skb)
> - goto _recv_indicatepkt_drop;
> - skb->data =3D recvframe->u.hdr.rx_data;
>=20
> - skb->len =3D recvframe->u.hdr.len;
>=20
> - skb_set_tail_pointer(skb, skb->len);
>=20
> - if ((attrib->tcpchk_valid =3D=3D 1) && (attrib->tcp_chkrpt =3D=3D 1))
>=20
> - skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>=20
> - else
> - skb->ip_summed =3D CHECKSUM_NONE;
>=20
> - skb->dev =3D adapter->pnetdev;
>=20
> - skb->protocol =3D eth_type_trans(skb, adapter->pnetdev);
>=20
> - netif_rx(skb);
> - recvframe->u.hdr.pkt =3D NULL; /* pointers to NULL before
>=20
> - * r8712_free_recvframe()
> - */
> - r8712_free_recvframe(recvframe, free_recv_queue);
> - return;
> -_recv_indicatepkt_drop:
> - /enqueue back to free_recv_queue/
> - if (recvframe)
> - r8712_free_recvframe(recvframe, free_recv_queue);
> - recvpriv->rx_drop++;
>=20
> -}
> -
> -static void _r8712_reordering_ctrl_timeout_handler (struct timer_list *t=
)
> -{
> - struct recv_reorder_ctrl *reorder_ctrl =3D
> - from_timer(reorder_ctrl, t, reordering_ctrl_timer);
> -
> - r8712_reordering_ctrl_timeout_handler(reorder_ctrl);
> -}
> -
> -void r8712_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
> -{
> - timer_setup(&preorder_ctrl->reordering_ctrl_timer,
>=20
> - _r8712_reordering_ctrl_timeout_handler, 0);
> -}
> diff --git a/drivers/staging/rtl8712/recv_osdep.h b/drivers/staging/rtl87=
12/recv_osdep.h
> deleted file mode 100644
> index fbe3f2868506..000000000000
> --- a/drivers/staging/rtl8712/recv_osdep.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef _RECV_OSDEP_H
> -#define _RECV_OSDEP_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include <linux/skbuff.h>
>=20
> -
> -int _r8712_init_recv_priv(struct recv_priv precvpriv,
> - struct _adapter padapter);
> -void _r8712_free_recv_priv(struct recv_priv precvpriv);
> -void r8712_recv_entry(union recv_frame precv_frame);
> -void r8712_recv_indicatepkt(struct _adapter adapter,
> - union recv_frame precv_frame);
> -void r8712_handle_tkip_mic_err(struct _adapter padapter, u8 bgroup);
> -int r8712_init_recv_priv(struct recv_priv precvpriv,
> - struct _adapter padapter);
> -void r8712_free_recv_priv(struct recv_priv precvpriv);
> -void r8712_os_recv_resource_alloc(struct _adapter padapter,
> - union recv_frame precvframe);
> -int r8712_os_recvbuf_resource_alloc(struct _adapter padapter,
> - struct recv_buf precvbuf);
> -void r8712_os_recvbuf_resource_free(struct _adapter padapter,
> - struct recv_buf precvbuf);
> -void r8712_init_recv_timer(struct recv_reorder_ctrl preorder_ctrl);
> -
> -#endif
> diff --git a/drivers/staging/rtl8712/rtl8712_bitdef.h b/drivers/staging/r=
tl8712/rtl8712_bitdef.h
> deleted file mode 100644
> index a4a687dcc2e7..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_bitdef.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/*************************************************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -
> -#ifndef RTL8712_BITDEF_H
> -#define RTL8712_BITDEF_H
> -
> -#include "rtl8712_cmdctrl_bitdef.h"
> -#include "rtl8712_syscfg_bitdef.h"
> -#include "rtl8712_macsetting_bitdef.h"
> -#include "rtl8712_timectrl_bitdef.h"
> -#include "rtl8712_fifoctrl_bitdef.h"
> -#include "rtl8712_ratectrl_bitdef.h"
> -#include "rtl8712_edcasetting_bitdef.h"
> -#include "rtl8712_wmac_bitdef.h"
> -#include "rtl8712_security_bitdef.h"
> -#include "rtl8712_powersave_bitdef.h"
> -#include "rtl8712_gp_bitdef.h"
> -#include "rtl8712_interrupt_bitdef.h"
> -#include "rtl8712_debugctrl_bitdef.h"
> -
> -#endif / RTL8712_BITDEF_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8=
712/rtl8712_cmd.c
> deleted file mode 100644
> index bb7db96ed821..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_cmd.c
> +++ /dev/null
> @@ -1,409 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl8712_cmd.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL8712_CMD_C
> -
> -#include <linux/compiler.h>
>=20
> -#include <linux/kernel.h>
>=20
> -#include <linux/errno.h>
>=20
> -#include <linux/slab.h>
>=20
> -#include <linux/sched/signal.h>
>=20
> -#include <linux/module.h>
>=20
> -#include <linux/kref.h>
>=20
> -#include <linux/netdevice.h>
>=20
> -#include <linux/skbuff.h>
>=20
> -#include <linux/usb.h>
>=20
> -#include <linux/usb/ch9.h>
>=20
> -#include <linux/circ_buf.h>
>=20
> -#include <linux/uaccess.h>
>=20
> -#include <asm/byteorder.h>
>=20
> -#include <linux/atomic.h>
>=20
> -#include <linux/semaphore.h>
>=20
> -#include <linux/rtnetlink.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "recv_osdep.h"
> -#include "mlme_osdep.h"
> -#include "rtl871x_ioctl_set.h"
> -
> -static void check_hw_pbc(struct _adapter padapter)
> -{
> - u8 tmp1byte;
> -
> - r8712_write8(padapter, MAC_PINMUX_CTRL, (GPIOMUX_EN | GPIOSEL_GPIO));
> - tmp1byte =3D r8712_read8(padapter, GPIO_IO_SEL);
> - tmp1byte &=3D ~(HAL_8192S_HW_GPIO_WPS_BIT);
> - r8712_write8(padapter, GPIO_IO_SEL, tmp1byte);
> - tmp1byte =3D r8712_read8(padapter, GPIO_CTRL);
> - if (tmp1byte =3D=3D 0xff)
> - return;
> - if (tmp1byte & HAL_8192S_HW_GPIO_WPS_BIT) {
> - / Here we only set bPbcPressed to true
> - * After trigger PBC, the variable will be set to false
> - */
> - netdev_dbg(padapter->pnetdev, "CheckPbcGPIO - PBC is pressed !!!!\n");
>=20
> - /* 0 is the default value and it means the application monitors
> - * the HW PBC doesn't provide its pid to driver.
> - */
> - if (padapter->pid =3D=3D 0)
>=20
> - return;
> - kill_pid(find_vpid(padapter->pid), SIGUSR1, 1);
>=20
> - }
> -}
> -
> -/* query rx phy status from fw.
> - * Adhoc mode: beacon.
> - * Infrastructure mode: beacon , data.
> - */
> -static void query_fw_rx_phy_status(struct _adapter *padapter)
> -{
> - u32 val32 =3D 0;
> - int pollingcnts =3D 50;
> -
> - if (check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
>=20
> - r8712_write32(padapter, IOCMD_CTRL_REG, 0xf4000001);
> - msleep(100);
> - /* Wait FW complete IO Cmd */
> - while ((r8712_read32(padapter, IOCMD_CTRL_REG)) &&
> - (pollingcnts > 0)) {
>=20
> - pollingcnts--;
> - msleep(20);
> - }
> - if (pollingcnts !=3D 0)
> - val32 =3D r8712_read32(padapter, IOCMD_DATA_REG);
> - else /* time out */
> - val32 =3D 0;
> - val32 >>=3D 4;
>=20
> - padapter->recvpriv.fw_rssi =3D
>=20
> - (u8)r8712_signal_scale_mapping(val32);
> - }
> -}
> -
> -/* check mlme, hw, phy, or dynamic algorithm status. */
> -static void StatusWatchdogCallback(struct _adapter *padapter)
> -{
> - check_hw_pbc(padapter);
> - query_fw_rx_phy_status(padapter);
> -}
> -
> -static void r871x_internal_cmd_hdl(struct _adapter *padapter, u8 *pbuf)
> -{
> - struct drvint_cmd_parm *pdrvcmd;
> -
> - if (!pbuf)
> - return;
> - pdrvcmd =3D (struct drvint_cmd_parm *)pbuf;
> - switch (pdrvcmd->i_cid) {
>=20
> - case WDG_WK_CID:
> - StatusWatchdogCallback(padapter);
> - break;
> - default:
> - break;
> - }
> - kfree(pdrvcmd->pbuf);
>=20
> -}
> -
> -static u8 read_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
> -{
> - struct cmd_obj *pcmd =3D (struct cmd_obj *)pbuf;
> -
> - r8712_free_cmd_obj(pcmd);
> - return H2C_SUCCESS;
> -}
> -
> -static u8 write_bbreg_hdl(struct _adapter *padapter, u8 *pbuf)
> -{
> - void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
> - struct cmd_obj *pcmd =3D (struct cmd_obj *)pbuf;
> -
> - pcmd_callback =3D cmd_callback[pcmd->cmdcode].callback;
>=20
> - if (!pcmd_callback)
> - r8712_free_cmd_obj(pcmd);
> - else
> - pcmd_callback(padapter, pcmd);
> - return H2C_SUCCESS;
> -}
> -
> -static u8 read_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
> -{
> - u32 val;
> - void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
> - struct cmd_obj *pcmd =3D (struct cmd_obj *)pbuf;
> -
> - if (pcmd->rsp && pcmd->rspsz > 0)
>=20
> - memcpy(pcmd->rsp, (u8 *)&val, pcmd->rspsz);
>=20
> - pcmd_callback =3D cmd_callback[pcmd->cmdcode].callback;
>=20
> - if (!pcmd_callback)
> - r8712_free_cmd_obj(pcmd);
> - else
> - pcmd_callback(padapter, pcmd);
> - return H2C_SUCCESS;
> -}
> -
> -static u8 write_rfreg_hdl(struct _adapter *padapter, u8 *pbuf)
> -{
> - void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
> - struct cmd_obj *pcmd =3D (struct cmd_obj *)pbuf;
> -
> - pcmd_callback =3D cmd_callback[pcmd->cmdcode].callback;
>=20
> - if (!pcmd_callback)
> - r8712_free_cmd_obj(pcmd);
> - else
> - pcmd_callback(padapter, pcmd);
> - return H2C_SUCCESS;
> -}
> -
> -static u8 sys_suspend_hdl(struct _adapter *padapter, u8 *pbuf)
> -{
> - struct cmd_obj *pcmd =3D (struct cmd_obj *)pbuf;
> -
> - r8712_free_cmd_obj(pcmd);
> - return H2C_SUCCESS;
> -}
> -
> -static struct cmd_obj *cmd_hdl_filter(struct _adapter *padapter,
> - struct cmd_obj *pcmd)
> -{
> - struct cmd_obj *pcmd_r;
> -
> - if (!pcmd)
> - return pcmd;
> - pcmd_r =3D NULL;
> -
> - switch (pcmd->cmdcode) {
>=20
> - case GEN_CMD_CODE(_Read_BBREG):
> - read_bbreg_hdl(padapter, (u8 *)pcmd);
> - break;
> - case GEN_CMD_CODE(_Write_BBREG):
> - write_bbreg_hdl(padapter, (u8 *)pcmd);
> - break;
> - case GEN_CMD_CODE(_Read_RFREG):
> - read_rfreg_hdl(padapter, (u8 *)pcmd);
> - break;
> - case GEN_CMD_CODE(_Write_RFREG):
> - write_rfreg_hdl(padapter, (u8 *)pcmd);
> - break;
> - case GEN_CMD_CODE(_SetUsbSuspend):
> - sys_suspend_hdl(padapter, (u8 )pcmd);
> - break;
> - case GEN_CMD_CODE(_JoinBss):
> - r8712_joinbss_reset(padapter);
> - / Before set JoinBss_CMD to FW, driver must ensure FW is in
> - * PS_MODE_ACTIVE. Directly write rpwm to radio on and assign
> - * new pwr_mode to Driver, instead of use workitem to change
> - * state.
> - */
> - if (padapter->pwrctrlpriv.pwr_mode > PS_MODE_ACTIVE) {
>=20
> - padapter->pwrctrlpriv.pwr_mode =3D PS_MODE_ACTIVE;
>=20
> - mutex_lock(&padapter->pwrctrlpriv.mutex_lock);
>=20
> - r8712_set_rpwm(padapter, PS_STATE_S4);
> - mutex_unlock(&padapter->pwrctrlpriv.mutex_lock);
>=20
> - }
> - pcmd_r =3D pcmd;
> - break;
> - case DRV_INT_CMD:
> - r871x_internal_cmd_hdl(padapter, pcmd->parmbuf);
>=20
> - r8712_free_cmd_obj(pcmd);
> - pcmd_r =3D NULL;
> - break;
> - default:
> - pcmd_r =3D pcmd;
> - break;
> - }
> - return pcmd_r; /* if returning pcmd_r =3D=3D NULL, pcmd must be free. *=
/
> -}
> -
> -u8 r8712_fw_cmd(struct _adapter *pAdapter, u32 cmd)
> -{
> - int pollingcnts =3D 50;
> -
> - r8712_write32(pAdapter, IOCMD_CTRL_REG, cmd);
> - msleep(100);
> - while ((r8712_read32(pAdapter, IOCMD_CTRL_REG !=3D 0)) &&
> - (pollingcnts > 0)) {
>=20
> - pollingcnts--;
> - msleep(20);
> - }
> - if (pollingcnts =3D=3D 0)
> - return false;
> - return true;
> -}
> -
> -void r8712_fw_cmd_data(struct _adapter *pAdapter, u32 value, u8 flag)
> -{
> - if (flag =3D=3D 0) / set */
> - r8712_write32(pAdapter, IOCMD_DATA_REG, value);
> - else / query */
> - *value =3D r8712_read32(pAdapter, IOCMD_DATA_REG);
> -}
> -
> -int r8712_cmd_thread(void *context)
> -{
> - struct cmd_obj *pcmd;
> - unsigned int cmdsz, wr_sz;
> - __le32 *pcmdbuf;
> - struct tx_desc *pdesc;
> - void (*pcmd_callback)(struct _adapter *dev, struct cmd_obj *pcmd);
> - struct _adapter *padapter =3D context;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct completion *cmd_queue_comp =3D
> - &pcmdpriv->cmd_queue_comp;
>=20
> - struct mutex *pwctrl_lock =3D &padapter->pwrctrlpriv.mutex_lock;
>=20
> -
> - allow_signal(SIGTERM);
> - while (1) {
> - if (wait_for_completion_interruptible(cmd_queue_comp))
> - break;
> - if (padapter->driver_stopped || padapter->surprise_removed)
>=20
> - break;
> - if (r8712_register_cmd_alive(padapter))
> - continue;
> -_next:
> - pcmd =3D r8712_dequeue_cmd(&pcmdpriv->cmd_queue);
>=20
> - if (!(pcmd)) {
> - r8712_unregister_cmd_alive(padapter);
> - continue;
> - }
> - pcmdbuf =3D (__le32 *)pcmdpriv->cmd_buf;
>=20
> - pdesc =3D (struct tx_desc )pcmdbuf;
> - memset(pdesc, 0, TXDESC_SIZE);
> - pcmd =3D cmd_hdl_filter(padapter, pcmd);
> - if (pcmd) { / if pcmd !=3D NULL, cmd will be handled by f/w */
> - struct dvobj_priv *pdvobj =3D &padapter->dvobjpriv;
>=20
> - u8 blnPending =3D 0;
> - u16 cmdcode =3D pcmd->cmdcode;
>=20
> -
> - pcmdpriv->cmd_issued_cnt++;
>=20
> - cmdsz =3D round_up(pcmd->cmdsz, 8);
>=20
> - wr_sz =3D TXDESC_SIZE + 8 + cmdsz;
> - pdesc->txdw0 |=3D cpu_to_le32((wr_sz - TXDESC_SIZE) &
>=20
> - 0x0000ffff);
> - if (pdvobj->ishighspeed) {
>=20
> - if ((wr_sz % 512) =3D=3D 0)
> - blnPending =3D 1;
> - } else {
> - if ((wr_sz % 64) =3D=3D 0)
> - blnPending =3D 1;
> - }
> - if (blnPending) { /* 32 bytes for TX Desc - 8 offset */
> - pdesc->txdw0 |=3D cpu_to_le32(((TXDESC_SIZE +
>=20
> - OFFSET_SZ + 8) << OFFSET_SHT) &
> - 0x00ff0000);
> - } else {
> - pdesc->txdw0 |=3D cpu_to_le32(((TXDESC_SIZE +
>=20
> - OFFSET_SZ) <<
> - OFFSET_SHT) &
> - 0x00ff0000);
> - }
> - pdesc->txdw0 |=3D cpu_to_le32(OWN | FSG | LSG);
>=20
> - pdesc->txdw1 |=3D cpu_to_le32((0x13 << QSEL_SHT) &
>=20
> - 0x00001f00);
> - pcmdbuf +=3D (TXDESC_SIZE >> 2);
>=20
> - *pcmdbuf =3D cpu_to_le32((cmdsz & 0x0000ffff) |
> - (pcmd->cmdcode << 16) |
>=20
> - (pcmdpriv->cmd_seq << 24));
>=20
> - pcmdbuf +=3D 2; /* 8 bytes alignment */
> - memcpy((u8 *)pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
>=20
> - if (blnPending)
> - wr_sz +=3D 8; /* Append 8 bytes */
> - r8712_write_mem(padapter, RTL8712_DMA_H2CCMD, wr_sz,
> - (u8 *)pdesc);
> - pcmdpriv->cmd_seq++;
>=20
> - if (cmdcode =3D=3D GEN_CMD_CODE(_CreateBss)) {
> - pcmd->res =3D H2C_SUCCESS;
>=20
> - pcmd_callback =3D cmd_callback[cmdcode].callback;
> - if (pcmd_callback)
> - pcmd_callback(padapter, pcmd);
> - continue;
> - }
> - if (cmdcode =3D=3D GEN_CMD_CODE(_SetPwrMode)) {
> - if (padapter->pwrctrlpriv.bSleep) {
>=20
> - mutex_lock(pwctrl_lock);
> - r8712_set_rpwm(padapter, PS_STATE_S2);
> - mutex_unlock(pwctrl_lock);
> - }
> - }
> - r8712_free_cmd_obj(pcmd);
> - if (list_empty(&pcmdpriv->cmd_queue.queue)) {
>=20
> - r8712_unregister_cmd_alive(padapter);
> - continue;
> - } else {
> - goto _next;
> - }
> - } else {
> - goto _next;
> - }
> - flush_signals_thread();
> - }
> - /* free all cmd_obj resources */
> - do {
> - pcmd =3D r8712_dequeue_cmd(&pcmdpriv->cmd_queue);
>=20
> - if (!pcmd)
> - break;
> - r8712_free_cmd_obj(pcmd);
> - } while (1);
> - complete(&pcmdpriv->terminate_cmdthread_comp);
>=20
> - return 0;
> -}
> -
> -void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf)
> -{
> - u8 evt_code, evt_seq;
> - u16 evt_sz;
> - void (*event_callback)(struct _adapter *dev, u8 *pbuf);
> - struct evt_priv *pevt_priv =3D &padapter->evtpriv;
>=20
> -
> - if (!peventbuf)
> - goto abort_event;
> - evt_sz =3D (u16)(le32_to_cpu(*peventbuf) & 0xffff);
> - evt_seq =3D (u8)((le32_to_cpu(*peventbuf) >> 24) & 0x7f);
>=20
> - evt_code =3D (u8)((le32_to_cpu(*peventbuf) >> 16) & 0xff);
>=20
> - /* checking event sequence... */
> - if ((evt_seq & 0x7f) !=3D pevt_priv->event_seq) {
>=20
> - pevt_priv->event_seq =3D ((evt_seq + 1) & 0x7f);
>=20
> - goto abort_event;
> - }
> - /* checking if event code is valid */
> - if (evt_code >=3D MAX_C2HEVT) {
>=20
> - pevt_priv->event_seq =3D ((evt_seq + 1) & 0x7f);
>=20
> - goto abort_event;
> - } else if ((evt_code =3D=3D GEN_EVT_CODE(_Survey)) &&
> - (evt_sz > sizeof(struct wlan_bssid_ex))) {
>=20
> - pevt_priv->event_seq =3D ((evt_seq + 1) & 0x7f);
>=20
> - goto abort_event;
> - }
> - /* checking if event size match the event parm size */
> - if ((wlanevents[evt_code].parmsize) &&
> - (wlanevents[evt_code].parmsize !=3D evt_sz)) {
> - pevt_priv->event_seq =3D ((evt_seq + 1) & 0x7f);
>=20
> - goto abort_event;
> - } else if ((evt_sz =3D=3D 0) && (evt_code !=3D GEN_EVT_CODE(_WPS_PBC)))=
 {
> - pevt_priv->event_seq =3D ((evt_seq + 1) & 0x7f);
>=20
> - goto abort_event;
> - }
> - pevt_priv->event_seq++; /* update evt_seq */
>=20
> - if (pevt_priv->event_seq > 127)
>=20
> - pevt_priv->event_seq =3D 0;
>=20
> - /* move to event content, 8 bytes alignment */
> - peventbuf =3D peventbuf + 2;
> - event_callback =3D wlanevents[evt_code].event_callback;
> - if (event_callback)
> - event_callback(padapter, (u8 *)peventbuf);
> - pevt_priv->evt_done_cnt++;
>=20
> -abort_event:
> - return;
> -}
> diff --git a/drivers/staging/rtl8712/rtl8712_cmd.h b/drivers/staging/rtl8=
712/rtl8712_cmd.h
> deleted file mode 100644
> index a34d0dd023f3..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_cmd.h
> +++ /dev/null
> @@ -1,231 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef _RTL8712_CMD_H
> -#define _RTL8712_CMD_H
> -
> -#define CMD_HDR_SZ 8
> -
> -u8 r8712_fw_cmd(struct _adapter pAdapter, u32 cmd);
> -void r8712_fw_cmd_data(struct _adapter pAdapter, u32 value, u8 flag);
> -
> -struct cmd_hdr {
> - u32 cmd_dw0;
> - u32 cmd_dw1;
> -};
> -
> -enum rtl8712_h2c_cmd {
> - GEN_CMD_CODE(_Read_MACREG), /0/
> - GEN_CMD_CODE(_Write_MACREG),
> - GEN_CMD_CODE(_Read_BBREG),
> - GEN_CMD_CODE(_Write_BBREG),
> - GEN_CMD_CODE(_Read_RFREG),
> - GEN_CMD_CODE(_Write_RFREG), /5/
> - GEN_CMD_CODE(_Read_EEPROM),
> - GEN_CMD_CODE(_Write_EEPROM),
> - GEN_CMD_CODE(_Read_EFUSE),
> - GEN_CMD_CODE(_Write_EFUSE),
> -
> - GEN_CMD_CODE(_Read_CAM), /10/
> - GEN_CMD_CODE(_Write_CAM),
> - GEN_CMD_CODE(_setBCNITV),
> - GEN_CMD_CODE(_setMBIDCFG),
> - GEN_CMD_CODE(_JoinBss), /14/
> - GEN_CMD_CODE(_DisConnect), /15/
> - GEN_CMD_CODE(_CreateBss),
> - GEN_CMD_CODE(_SetOpMode),
> - GEN_CMD_CODE(_SiteSurvey), /18/
> - GEN_CMD_CODE(_SetAuth),
> -
> - GEN_CMD_CODE(_SetKey), /20/
> - GEN_CMD_CODE(_SetStaKey),
> - GEN_CMD_CODE(_SetAssocSta),
> - GEN_CMD_CODE(_DelAssocSta),
> - GEN_CMD_CODE(_SetStaPwrState),
> - GEN_CMD_CODE(_SetBasicRate), /25/
> - GEN_CMD_CODE(_GetBasicRate),
> - GEN_CMD_CODE(_SetDataRate),
> - GEN_CMD_CODE(_GetDataRate),
> - GEN_CMD_CODE(_SetPhyInfo),
> -
> - GEN_CMD_CODE(_GetPhyInfo), /30/
> - GEN_CMD_CODE(_SetPhy),
> - GEN_CMD_CODE(_GetPhy),
> - GEN_CMD_CODE(_readRssi),
> - GEN_CMD_CODE(_readGain),
> - GEN_CMD_CODE(_SetAtim), /35/
> - GEN_CMD_CODE(_SetPwrMode),
> - GEN_CMD_CODE(_JoinbssRpt),
> - GEN_CMD_CODE(_SetRaTable),
> - GEN_CMD_CODE(_GetRaTable),
> -
> - GEN_CMD_CODE(_GetCCXReport), /40/
> - GEN_CMD_CODE(_GetDTMReport),
> - GEN_CMD_CODE(_GetTXRateStatistics),
> - GEN_CMD_CODE(_SetUsbSuspend),
> - GEN_CMD_CODE(_SetH2cLbk),
> - GEN_CMD_CODE(_AddBAReq), /45/
> -
> - GEN_CMD_CODE(_SetChannel), /46/
> -/ MP_OFFLOAD Start (47~54)/
> - GEN_CMD_CODE(_SetTxPower),
> - GEN_CMD_CODE(_SwitchAntenna),
> - GEN_CMD_CODE(_SetCrystalCap),
> - GEN_CMD_CODE(_SetSingleCarrierTx), /50/
> - GEN_CMD_CODE(_SetSingleToneTx),
> - GEN_CMD_CODE(_SetCarrierSuppressionTx),
> - GEN_CMD_CODE(_SetContinuousTx),
> - GEN_CMD_CODE(_SwitchBandwidth), /54/
> -/ MP_OFFLOAD End/
> - GEN_CMD_CODE(_TX_Beacon), /55/
> - GEN_CMD_CODE(_SetPowerTracking),
> - GEN_CMD_CODE(_AMSDU_TO_AMPDU), /57/
> - GEN_CMD_CODE(_SetMacAddress), /58/
> -
> - GEN_CMD_CODE(_DisconnectCtrl), /59/
> - GEN_CMD_CODE(_SetChannelPlan), /60/
> - GEN_CMD_CODE(_DisconnectCtrlEx), /61/
> -
> - / To do, modify these h2c cmd, add or delete /
> - GEN_CMD_CODE(_GetH2cLbk),
> -
> - / WPS extra IE /
> - GEN_CMD_CODE(_SetProbeReqExtraIE),
> - GEN_CMD_CODE(_SetAssocReqExtraIE),
> - GEN_CMD_CODE(_SetProbeRspExtraIE),
> - GEN_CMD_CODE(_SetAssocRspExtraIE),
> -
> - / the following is driver will do /
> - GEN_CMD_CODE(_GetCurDataRate),
> -
> - GEN_CMD_CODE(_GetTxRetrycnt), / to record times that Tx retry to
> - * transmit packet after association
> - /
> - GEN_CMD_CODE(_GetRxRetrycnt), / to record total number of the
> - * received frame with ReTry bit set in
> - * the WLAN header
> - /
> -
> - GEN_CMD_CODE(_GetBCNOKcnt),
> - GEN_CMD_CODE(_GetBCNERRcnt),
> - GEN_CMD_CODE(_GetCurTxPwrLevel),
> -
> - GEN_CMD_CODE(_SetDIG),
> - GEN_CMD_CODE(_SetRA),
> - GEN_CMD_CODE(_SetPT),
> - GEN_CMD_CODE(_ReadTSSI),
> -
> - MAX_H2CCMD
> -};
> -
> -#define GetBBReg_CMD Read_BBREG_CMD
> -#define SetBBReg_CMD Write_BBREG_CMD
> -#define GetRFReg_CMD Read_RFREG_CMD
> -#define SetRFReg_CMD Write_RFREG_CMD
> -#define DRV_INT_CMD (MAX_H2CCMD + 1)
> -#define SetRFIntFs_CMD (MAX_H2CCMD + 2)
> -
> -#ifdef RTL8712_CMD_C
> -static struct _cmd_callback cmd_callback[] =3D {
> - {GEN_CMD_CODE(_Read_MACREG), NULL}, /0/
> - {GEN_CMD_CODE(_Write_MACREG), NULL},
> - {GEN_CMD_CODE(_Read_BBREG), NULL},
> - {GEN_CMD_CODE(_Write_BBREG), NULL},
> - {GEN_CMD_CODE(_Read_RFREG), &r8712_getbbrfreg_cmdrsp_callback},
> - {GEN_CMD_CODE(_Write_RFREG), NULL}, /5/
> - {GEN_CMD_CODE(_Read_EEPROM), NULL},
> - {GEN_CMD_CODE(_Write_EEPROM), NULL},
> - {GEN_CMD_CODE(_Read_EFUSE), NULL},
> - {GEN_CMD_CODE(_Write_EFUSE), NULL},
> -
> - {GEN_CMD_CODE(_Read_CAM), NULL}, /10/
> - {GEN_CMD_CODE(_Write_CAM), NULL},
> - {GEN_CMD_CODE(_setBCNITV), NULL},
> - {GEN_CMD_CODE(_setMBIDCFG), NULL},
> - {GEN_CMD_CODE(_JoinBss), &r8712_joinbss_cmd_callback}, /14/
> - {GEN_CMD_CODE(_DisConnect), &r8712_disassoc_cmd_callback}, /15/
> - {GEN_CMD_CODE(_CreateBss), &r8712_createbss_cmd_callback},
> - {GEN_CMD_CODE(_SetOpMode), NULL},
> - {GEN_CMD_CODE(_SiteSurvey), &r8712_survey_cmd_callback}, /18/
> - {GEN_CMD_CODE(_SetAuth), NULL},
> -
> - {GEN_CMD_CODE(_SetKey), NULL}, /20/
> - {GEN_CMD_CODE(_SetStaKey), &r8712_setstaKey_cmdrsp_callback},
> - {GEN_CMD_CODE(_SetAssocSta), &r8712_setassocsta_cmdrsp_callback},
> - {GEN_CMD_CODE(_DelAssocSta), NULL},
> - {GEN_CMD_CODE(_SetStaPwrState), NULL},
> - {GEN_CMD_CODE(_SetBasicRate), NULL}, /25/
> - {GEN_CMD_CODE(_GetBasicRate), NULL},
> - {GEN_CMD_CODE(_SetDataRate), NULL},
> - {GEN_CMD_CODE(_GetDataRate), NULL},
> - {GEN_CMD_CODE(_SetPhyInfo), NULL},
> -
> - {GEN_CMD_CODE(_GetPhyInfo), NULL}, /30/
> - {GEN_CMD_CODE(_SetPhy), NULL},
> - {GEN_CMD_CODE(_GetPhy), NULL},
> - {GEN_CMD_CODE(_readRssi), NULL},
> - {GEN_CMD_CODE(_readGain), NULL},
> - {GEN_CMD_CODE(_SetAtim), NULL}, /35/
> - {GEN_CMD_CODE(_SetPwrMode), NULL},
> - {GEN_CMD_CODE(_JoinbssRpt), NULL},
> - {GEN_CMD_CODE(_SetRaTable), NULL},
> - {GEN_CMD_CODE(_GetRaTable), NULL},
> -
> - {GEN_CMD_CODE(_GetCCXReport), NULL}, /40/
> - {GEN_CMD_CODE(_GetDTMReport), NULL},
> - {GEN_CMD_CODE(_GetTXRateStatistics), NULL},
> - {GEN_CMD_CODE(_SetUsbSuspend), NULL},
> - {GEN_CMD_CODE(_SetH2cLbk), NULL},
> - {GEN_CMD_CODE(_AddBAReq), NULL}, /45/
> -
> - {GEN_CMD_CODE(_SetChannel), NULL}, /46/
> -/ MP_OFFLOAD Start (47~54)/
> - {GEN_CMD_CODE(_SetTxPower), NULL},
> - {GEN_CMD_CODE(_SwitchAntenna), NULL},
> - {GEN_CMD_CODE(_SetCrystalCap), NULL},
> - {GEN_CMD_CODE(_SetSingleCarrierTx), NULL}, /50/
> - {GEN_CMD_CODE(_SetSingleToneTx), NULL},
> - {GEN_CMD_CODE(_SetCarrierSuppressionTx), NULL},
> - {GEN_CMD_CODE(_SetContinuousTx), NULL},
> - {GEN_CMD_CODE(_SwitchBandwidth), NULL}, /54/
> -/ MP_OFFLOAD End/
> - {GEN_CMD_CODE(_TX_Beacon), NULL}, /55/
> - {GEN_CMD_CODE(_SetPowerTracking), NULL},
> - {GEN_CMD_CODE(_AMSDU_TO_AMPDU), NULL}, /57/
> - {GEN_CMD_CODE(_SetMacAddress), NULL}, /58/
> -
> - {GEN_CMD_CODE(_DisconnectCtrl), NULL}, /59/
> - {GEN_CMD_CODE(_SetChannelPlan), NULL}, /60/
> - {GEN_CMD_CODE(_DisconnectCtrlEx), NULL}, /61/
> -
> - / To do, modify these h2c cmd, add or delete /
> - {GEN_CMD_CODE(_GetH2cLbk), NULL},
> -
> - {SetProbeReqExtraIE_CMD, NULL},
> - {SetAssocReqExtraIE_CMD, NULL},
> - {SetProbeRspExtraIE_CMD, NULL},
> - {SetAssocRspExtraIE_CMD, NULL},
> - {GetCurDataRate_CMD, NULL},
> - {GetTxRetrycnt_CMD, NULL},
> - {GetRxRetrycnt_CMD, NULL},
> - {GetBCNOKcnt_CMD, NULL},
> - {GetBCNERRcnt_CMD, NULL},
> - {GetCurTxPwrLevel_CMD, NULL},
> - {SetDIG_CMD, NULL},
> - {SetRA_CMD, NULL},
> - {SetPT_CMD, NULL},
> - {GEN_CMD_CODE(_ReadTSSI), &r8712_readtssi_cmdrsp_callback}
> -};
> -#endif
> -
> -#endif
> diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h b/drivers/s=
taging/rtl8712/rtl8712_cmdctrl_bitdef.h
> deleted file mode 100644
> index 68bdec07f51e..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_cmdctrl_bitdef.h
> +++ /dev/null
> @@ -1,95 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/*****
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_CMDCTRL_BITDEF_H
> -#define RTL8712_CMDCTRL_BITDEF_H
> -
> -/
> - * 2. Command Control Registers (Offset: 0x0040 - 0x004F)
> - /
> -/-----------------------------------------------------------------------=
---/
> -/ 8192S (CMD) command register bits (Offset 0x40, 16 bits)/
> -/-----------------------------------------------------------------------=
---/
> -#define _APSDOFF_STATUS BIT(15)
> -#define _APSDOFF BIT(14)
> -#define _BBRSTn BIT(13) /Enable OFDM/CCK/
> -#define _BB_GLB_RSTn BIT(12) /Enable BB/
> -#define _SCHEDULE_EN BIT(10) /Enable MAC scheduler/
> -#define _MACRXEN BIT(9)
> -#define _MACTXEN BIT(8)
> -#define _DDMA_EN BIT(7) /FW off load function enable/
> -#define _FW2HW_EN BIT(6) /MAC every module reset /
> -#define _RXDMA_EN BIT(5)
> -#define _TXDMA_EN BIT(4)
> -#define _HCI_RXDMA_EN BIT(3)
> -#define _HCI_TXDMA_EN BIT(2)
> -
> -/TXPAUSE/
> -#define _STOPHCCA BIT(6)
> -#define _STOPHIGH BIT(5)
> -#define _STOPMGT BIT(4)
> -#define _STOPVO BIT(3)
> -#define _STOPVI BIT(2)
> -#define _STOPBE BIT(1)
> -#define _STOPBK BIT(0)
> -
> -/TCR/
> -#define _DISCW BIT(20)
> -#define _ICV BIT(19)
> -#define _CFEND_FMT BIT(17)
> -#define _CRC BIT(16)
> -#define _FWRDY BIT(7)
> -#define _BASECHG BIT(6)
> -#define _IMEM_RDY BIT(5)
> -#define _DMEM_CODE_DONE BIT(4)
> -#define _EMEM_CHK_RPT BIT(3)
> -#define _EMEM_CODE_DONE BIT(2)
> -#define _IMEM_CHK_RPT BIT(1)
> -#define _IMEM_CODE_DONE BIT(0)
> -
> -#define _TXDMA_INIT_VALUE (_IMEM_CHK_RPT | _EMEM_CHK_RPT)
> -
> -/RCR/
> -#define _ENMBID BIT(27)
> -#define _APP_PHYST_RXFF BIT(25)
> -#define _APP_PHYST_STAFF BIT(24)
> -#define _CBSSID BIT(23)
> -#define _APWRMGT BIT(22)
> -#define _ADD3 BIT(21)
> -#define _AMF BIT(20)
> -#define _ACF BIT(19)
> -#define _ADF BIT(18)
> -#define _APP_MIC BIT(17)
> -#define _APP_ICV BIT(16)
> -#define _RXFTH_MSK 0x0000E000
> -#define _RXFTH_SHT 13
> -#define _AICV BIT(12)
> -#define _RXPKTLMT_MSK 0x00000FC0
> -#define _RXPKTLMT_SHT 6
> -#define _ACRC32 BIT(5)
> -#define _AB BIT(3)
> -#define _AM BIT(2)
> -#define _APM BIT(1)
> -#define _AAP BIT(0)
> -
> -/MSR/
> -#define _NETTYPE_MSK 0x03
> -#define _NETTYPE_SHT 0
> -
> -/BT/
> -#define _BTMODE_MSK 0x06
> -#define _BTMODE_SHT 1
> -#define _ENBT BIT(0)
> -
> -/MBIDCTRL/
> -#define _ENMBID_MODE BIT(15)
> -#define _BCNNO_MSK 0x7000
> -#define _BCNNO_SHT 12
> -#define _BCNSPACE_MSK 0x0FFF
> -#define _BCNSPACE_SHT 0
> -
> -#endif / RTL8712_CMDCTRL_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h b/drivers/s=
taging/rtl8712/rtl8712_cmdctrl_regdef.h
> deleted file mode 100644
> index fc67771c89b7..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_cmdctrl_regdef.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_CMDCTRL_REGDEF_H
> -#define RTL8712_CMDCTRL_REGDEF_H
> -
> -#define CR (RTL8712_CMDCTRL_ + 0x0000)
> -#define TXPAUSE (RTL8712_CMDCTRL_ + 0x0002)
> -#define TCR (RTL8712_CMDCTRL_ + 0x0004)
> -#define RCR (RTL8712_CMDCTRL_ + 0x0008)
> -#define MSR (RTL8712_CMDCTRL_ + 0x000C)
> -#define SYSF_CFG (RTL8712_CMDCTRL_ + 0x000D)
> -#define MBIDCTRL (RTL8712_CMDCTRL_ + 0x000E)
> -
> -#endif / RTL8712_CMDCTRL_REGDEF_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h b/drivers=
/staging/rtl8712/rtl8712_debugctrl_bitdef.h
> deleted file mode 100644
> index bb3863467f0d..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_debugctrl_bitdef.h
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_DEBUGCTRL_BITDEF_H
> -#define RTL8712_DEBUGCTRL_BITDEF_H
> -
> -/BIST/
> -#define _BIST_RST BIT(0)
> -
> -/LMS/
> -#define _LMS_MSK 0x03
> -
> -/WDG_CTRL/
> -#define _OVSEL_MSK 0x0600
> -#define _OVSEL_SHT 9
> -#define _WDGCLR BIT(8)
> -#define _WDGEN_MSK 0x00FF
> -#define _WDGEN_SHT 0
> -
> -/INTM/
> -#define _TXTIMER_MSK 0xF000
> -#define _TXTIMER_SHT 12
> -#define _TXNUM_MSK 0x0F00
> -#define _TXNUM_SHT 8
> -#define _RXTIMER_MSK 0x00F0
> -#define _RXTIMER_SHT 4
> -#define _RXNUM_MSK 0x000F
> -#define _RXNUM_SHT 0
> -
> -/FDLOCKTURN0/
> -/FDLOCKTURN1/
> -#define _TURN1 BIT(0)
> -
> -/FDLOCKFLAG0/
> -/FDLOCKFLAG1/
> -#define _LOCKFLAG1_MSK 0x03
> -
> -#endif / RTL8712_DEBUGCTRL_BITDEF_H /
> diff --git a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h b/drivers=
/staging/rtl8712/rtl8712_debugctrl_regdef.h
> deleted file mode 100644
> index 319220e9d53d..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_debugctrl_regdef.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_DEBUGCTRL_REGDEF_H
> -#define RTL8712_DEBUGCTRL_REGDEF_H
> -
> -#define BIST (RTL8712_DEBUGCTRL_ + 0x00)
> -#define DBS (RTL8712_DEBUGCTRL_ + 0x04)
> -#define LMS (RTL8712_DEBUGCTRL_ + 0x05)
> -#define CPUINST (RTL8712_DEBUGCTRL_ + 0x08)
> -#define CPUCAUSE (RTL8712_DEBUGCTRL_ + 0x0C)
> -#define LBUS_ERR_ADDR (RTL8712_DEBUGCTRL_ + 0x10)
> -#define LBUS_ERR_CMD (RTL8712_DEBUGCTRL_ + 0x14)
> -#define LBUS_ERR_DATA_L (RTL8712_DEBUGCTRL_ + 0x18)
> -#define LBUS_ERR_DATA_H (RTL8712_DEBUGCTRL_ + 0x1C)
> -#define LBUS_EXCEPTION_ADDR (RTL8712_DEBUGCTRL_ + 0x20)
> -#define WDG_CTRL (RTL8712_DEBUGCTRL_ + 0x24)
> -#define INTMTU (RTL8712_DEBUGCTRL_ + 0x28)
> -#define INTM (RTL8712_DEBUGCTRL_ + 0x2A)
> -#define FDLOCKTURN0 (RTL8712_DEBUGCTRL_ + 0x2C)
> -#define FDLOCKTURN1 (RTL8712_DEBUGCTRL_ + 0x2D)
> -#define FDLOCKFLAG0 (RTL8712_DEBUGCTRL_ + 0x2E)
> -#define FDLOCKFLAG1 (RTL8712_DEBUGCTRL_ + 0x2F)
> -#define TRXPKTBUF_DBG_DATA (RTL8712_DEBUGCTRL_ + 0x30)
> -#define TRXPKTBUF_DBG_CTRL (RTL8712_DEBUGCTRL_ + 0x38)
> -#define DPLL_MON (RTL8712_DEBUGCTRL_ + 0x3A)
> -
> -#endif / RTL8712_DEBUGCTRL_REGDEF_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h b/drive=
rs/staging/rtl8712/rtl8712_edcasetting_bitdef.h
> deleted file mode 100644
> index 9048d6a65296..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_edcasetting_bitdef.h
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_EDCASETTING_BITDEF_H
> -#define RTL8712_EDCASETTING_BITDEF_H
> -
> -/EDCAPARAM/
> -#define _TXOPLIMIT_MSK 0xFFFF0000
> -#define _TXOPLIMIT_SHT 16
> -#define _ECWIN_MSK 0x0000FF00
> -#define _ECWIN_SHT 8
> -#define _AIFS_MSK 0x000000FF
> -#define _AIFS_SHT 0
> -
> -/BCNTCFG/
> -#define _BCNECW_MSK 0xFF00
> -#define _BCNECW_SHT 8
> -#define _BCNIFS_MSK 0x00FF
> -#define _BCNIFS_SHT 0
> -
> -/CWRR/
> -#define _CWRR_MSK 0x03FF
> -
> -/ACMAVG/
> -#define _AVG_TIME_UP BIT(3)
> -#define _AVGPERIOD_MSK 0x03
> -
> -/ACMHWCTRL/
> -#define _VOQ_ACM_STATUS BIT(6)
> -#define _VIQ_ACM_STATUS BIT(5)
> -#define _BEQ_ACM_STATUS BIT(4)
> -#define _VOQ_ACM_EN BIT(3)
> -#define _VIQ_ACM_EN BIT(2)
> -#define _BEQ_ACM_EN BIT(1)
> -#define _ACMHWEN BIT(0)
> -
> -/VO_ADMTIME/
> -#define _VO_ACM_RUT BIT(18)
> -#define _VO_ADMTIME_MSK 0x0003FFF
> -
> -/VI_ADMTIME/
> -#define _VI_ACM_RUT BIT(18)
> -#define _VI_ADMTIME_MSK 0x0003FFF
> -
> -/BE_ADMTIME/
> -#define _BE_ACM_RUT BIT(18)
> -#define _BE_ADMTIME_MSK 0x0003FFF
> -
> -/Retry limit reg/
> -#define _SRL_MSK 0xFF00
> -#define _SRL_SHT 8
> -#define _LRL_MSK 0x00FF
> -#define _LRL_SHT 0
> -
> -#endif / RTL8712_EDCASETTING_BITDEF_H/
> diff --git a/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h b/drive=
rs/staging/rtl8712/rtl8712_edcasetting_regdef.h
> deleted file mode 100644
> index 02ec9f3bba66..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_edcasetting_regdef.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - ***********************************************************************=
******/
> -#ifndef RTL8712_EDCASETTING_REGDEF_H
> -#define RTL8712_EDCASETTING_REGDEF_H
> -
> -#define EDCA_VO_PARAM (RTL8712_EDCASETTING_ + 0x00)
> -#define EDCA_VI_PARAM (RTL8712_EDCASETTING_ + 0x04)
> -#define EDCA_BE_PARAM (RTL8712_EDCASETTING_ + 0x08)
> -#define EDCA_BK_PARAM (RTL8712_EDCASETTING_ + 0x0C)
> -#define BCNTCFG (RTL8712_EDCASETTING_ + 0x10)
> -#define CWRR (RTL8712_EDCASETTING_ + 0x12)
> -#define ACMAVG (RTL8712_EDCASETTING_ + 0x16)
> -#define ACMHWCTRL (RTL8712_EDCASETTING_ + 0x17)
> -#define VO_ADMTIME (RTL8712_EDCASETTING_ + 0x18)
> -#define VI_ADMTIME (RTL8712_EDCASETTING_ + 0x1C)
> -#define BE_ADMTIME (RTL8712_EDCASETTING_ + 0x20)
> -#define RL (RTL8712_EDCASETTING_ + 0x24)
> -
> -#endif / RTL8712_EDCASETTING_REGDEF_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rt=
l8712/rtl8712_efuse.c
> deleted file mode 100644
> index a39d6c06648f..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_efuse.c
> +++ /dev/null
> @@ -1,563 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl8712_efuse.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -
> -#define RTL8712_EFUSE_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "rtl8712_efuse.h"
> -
> -/ reserve 3 bytes for HW stop read */
> -static int efuse_available_max_size =3D EFUSE_MAX_SIZE - 3 /0x1FD/;
> -
> -static void efuse_reg_ctrl(struct _adapter adapter, u8 bPowerOn)
> -{
> - u8 tmpu8 =3D 0;
> -
> - if (bPowerOn) {
> - / -----------------e-fuse pwr & clk reg ctrl ---------------
> - * Enable LDOE25 Macro Block
> - /
> - tmpu8 =3D r8712_read8(adapter, EFUSE_TEST + 3);
> - tmpu8 |=3D 0x80;
> - r8712_write8(adapter, EFUSE_TEST + 3, tmpu8);
> - msleep(20); / for some platform , need some delay time /
> - / Change Efuse Clock for write action to 40MHZ /
> - r8712_write8(adapter, EFUSE_CLK_CTRL, 0x03);
> - msleep(20); / for some platform , need some delay time /
> - } else {
> - / -----------------e-fuse pwr & clk reg ctrl -----------------
> - * Disable LDOE25 Macro Block
> - /
> - tmpu8 =3D r8712_read8(adapter, EFUSE_TEST + 3);
> - tmpu8 &=3D 0x7F;
> - r8712_write8(adapter, EFUSE_TEST + 3, tmpu8);
> - / Change Efuse Clock for write action to 500K /
> - r8712_write8(adapter, EFUSE_CLK_CTRL, 0x02);
> - }
> -}
> -
> -/
> - * Before write E-Fuse, this function must be called.
> - */
> -u8 r8712_efuse_reg_init(struct _adapter *adapter)
> -{
> - return true;
> -}
> -
> -void r8712_efuse_reg_uninit(struct _adapter *adapter)
> -{
> - efuse_reg_ctrl(adapter, false);
> -}
> -
> -static u8 efuse_one_byte_read(struct _adapter *adapter, u16 addr, u8 dat=
a)
> -{
> - u8 tmpidx =3D 0, bResult;
> -
> - / -----------------e-fuse reg ctrl --------------------------------- /
> - r8712_write8(adapter, EFUSE_CTRL + 1, (u8)(addr & 0xFF)); / address */
> - r8712_write8(adapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
>=20
> - (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC));
> - r8712_write8(adapter, EFUSE_CTRL + 3, 0x72); /* read cmd /
> - / wait for complete */
> - while (!(0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) &&
> - (tmpidx < 100))
> - tmpidx++;
> - if (tmpidx < 100) {
> - *data =3D r8712_read8(adapter, EFUSE_CTRL);
> - bResult =3D true;
> - } else {
> - *data =3D 0xff;
> - bResult =3D false;
> - }
> - return bResult;
> -}
> -
> -static u8 efuse_one_byte_write(struct _adapter adapter, u16 addr, u8 dat=
a)
> -{
> - u8 tmpidx =3D 0, bResult;
> -
> - / -----------------e-fuse reg ctrl -------------------------------- /
> - r8712_write8(adapter, EFUSE_CTRL + 1, (u8)(addr & 0xFF)); / address */
> - r8712_write8(adapter, EFUSE_CTRL + 2, ((u8)((addr >> 8) & 0x03)) |
>=20
> - (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC));
> - r8712_write8(adapter, EFUSE_CTRL, data); /* data /
> - r8712_write8(adapter, EFUSE_CTRL + 3, 0xF2); / write cmd /
> - / wait for complete */
> - while ((0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) &&
> - (tmpidx < 100))
> - tmpidx++;
> - if (tmpidx < 100)
> - bResult =3D true;
> - else
> - bResult =3D false;
> - return bResult;
> -}
> -
> -static u8 efuse_one_byte_rw(struct _adapter *adapter, u8 bRead, u16 addr=
,
> - u8 data)
> -{
> - u8 tmpidx =3D 0, tmpv8 =3D 0, bResult;
> -
> - / -----------------e-fuse reg ctrl --------------------------------- /
> - r8712_write8(adapter, EFUSE_CTRL + 1, (u8)(addr & 0xFF)); / address */
> - tmpv8 =3D ((u8)((addr >> 8) & 0x03)) |
>=20
> - (r8712_read8(adapter, EFUSE_CTRL + 2) & 0xFC);
> - r8712_write8(adapter, EFUSE_CTRL + 2, tmpv8);
> - if (bRead) {
> - r8712_write8(adapter, EFUSE_CTRL + 3, 0x72); /* read cmd */
> - while (!(0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) &&
> - (tmpidx < 100))
> - tmpidx++;
> - if (tmpidx < 100) {
> - *data =3D r8712_read8(adapter, EFUSE_CTRL);
> - bResult =3D true;
> - } else {
> - *data =3D 0;
> - bResult =3D false;
> - }
> - } else {
> - r8712_write8(adapter, EFUSE_CTRL, data); / data /
> - r8712_write8(adapter, EFUSE_CTRL + 3, 0xF2); / write cmd */
> - while ((0x80 & r8712_read8(adapter, EFUSE_CTRL + 3)) &&
> - (tmpidx < 100))
> - tmpidx++;
> - if (tmpidx < 100)
> - bResult =3D true;
> - else
> - bResult =3D false;
> - }
> - return bResult;
> -}
> -
> -static u8 efuse_is_empty(struct _adapter *adapter, u8 empty)
> -{
> - u8 value, ret =3D true;
> -
> - / read one byte to check if E-Fuse is empty */
> - if (efuse_one_byte_rw(adapter, true, 0, &value)) {
> - if (value =3D=3D 0xFF)
> - *empty =3D true;
> - else
> - *empty =3D false;
> - } else {
> - ret =3D false;
> - }
> - return ret;
> -}
> -
> -void r8712_efuse_change_max_size(struct _adapter *adapter)
> -{
> - u16 pre_pg_data_saddr =3D 0x1FB;
> - u16 i;
> - u16 pre_pg_data_size =3D 5;
> - u8 pre_pg_data[5];
> -
> - for (i =3D 0; i < pre_pg_data_size; i++)
> - efuse_one_byte_read(adapter, pre_pg_data_saddr + i,
> - &pre_pg_data[i]);
> - if ((pre_pg_data[0] =3D=3D 0x03) && (pre_pg_data[1] =3D=3D 0x00) &&
> - (pre_pg_data[2] =3D=3D 0x00) && (pre_pg_data[3] =3D=3D 0x00) &&
> - (pre_pg_data[4] =3D=3D 0x0C))
> - efuse_available_max_size -=3D pre_pg_data_size;
> -}
> -
> -int r8712_efuse_get_max_size(struct _adapter adapter)
> -{
> - return efuse_available_max_size;
> -}
> -
> -static u8 calculate_word_cnts(const u8 word_en)
> -{
> - u8 word_cnts =3D 0;
> - u8 word_idx;
> -
> - for (word_idx =3D 0; word_idx < PGPKG_MAX_WORDS; word_idx++)
> - if (!(word_en & BIT(word_idx)))
> - word_cnts++; / 0 : write enable */
> - return word_cnts;
> -}
> -
> -static void pgpacket_copy_data(const u8 word_en, const u8 *sourdata,
> - u8 *targetdata)
> -{
> - u8 tmpindex =3D 0;
> - u8 word_idx, byte_idx;
> -
> - for (word_idx =3D 0; word_idx < PGPKG_MAX_WORDS; word_idx++) {
> - if (!(word_en & BIT(word_idx))) {
> - byte_idx =3D word_idx * 2;
> - targetdata[byte_idx] =3D sourdata[tmpindex++];
> - targetdata[byte_idx + 1] =3D sourdata[tmpindex++];
> - }
> - }
> -}
> -
> -u16 r8712_efuse_get_current_size(struct _adapter adapter)
> -{
> - int bContinual =3D true;
> - u16 efuse_addr =3D 0;
> - u8 hworden =3D 0;
> - u8 efuse_data, word_cnts =3D 0;
> -
> - while (bContinual && efuse_one_byte_read(adapter, efuse_addr, &efuse_da=
ta) &&
> - (efuse_addr < efuse_available_max_size)) {
> - if (efuse_data !=3D 0xFF) {
> - hworden =3D efuse_data & 0x0F;
> - word_cnts =3D calculate_word_cnts(hworden);
> - / read next header */
> - efuse_addr =3D efuse_addr + (word_cnts * 2) + 1;
> - } else {
> - bContinual =3D false;
> - }
> - }
> - return efuse_addr;
> -}
> -
> -u8 r8712_efuse_pg_packet_read(struct _adapter *adapter, u8 offset, u8 *d=
ata)
> -{
> - u8 hoffset =3D 0, hworden =3D 0, word_cnts =3D 0;
> - u16 efuse_addr =3D 0;
> - u8 efuse_data;
> - u8 tmpidx =3D 0;
> - u8 tmpdata[PGPKT_DATA_SIZE];
> - u8 ret =3D true;
> -
> - if (!data)
> - return false;
> - if (offset > 0x0f)
>=20
> - return false;
> - memset(data, 0xFF, sizeof(u8) * PGPKT_DATA_SIZE);
> - while (efuse_addr < efuse_available_max_size) {
> - if (efuse_one_byte_read(adapter, efuse_addr, &efuse_data)) {
> - if (efuse_data =3D=3D 0xFF)
> - break;
> - hoffset =3D (efuse_data >> 4) & 0x0F;
>=20
> - hworden =3D efuse_data & 0x0F;
> - word_cnts =3D calculate_word_cnts(hworden);
> - if (hoffset =3D=3D offset) {
> - memset(tmpdata, 0xFF, PGPKT_DATA_SIZE);
> - for (tmpidx =3D 0; tmpidx < word_cnts * 2;
> - tmpidx++) {
> - if (efuse_one_byte_read(adapter, efuse_addr + 1 + tmpidx,
> - &efuse_data)) {
> - tmpdata[tmpidx] =3D efuse_data;
> - } else {
> - ret =3D false;
> - }
> - }
> - pgpacket_copy_data(hworden, tmpdata, data);
> - }
> - efuse_addr +=3D 1 + (word_cnts * 2);
> - } else {
> - ret =3D false;
> - break;
> - }
> - }
> - return ret;
> -}
> -
> -static u8 fix_header(struct _adapter *adapter, u8 header, u16 header_add=
r)
> -{
> - struct PGPKT_STRUCT pkt;
> - u8 offset, word_en, value;
> - u16 addr;
> - int i;
> - u8 ret =3D true;
> -
> - pkt.offset =3D GET_EFUSE_OFFSET(header);
> - pkt.word_en =3D GET_EFUSE_WORD_EN(header);
> - addr =3D header_addr + 1 + calculate_word_cnts(pkt.word_en) * 2;
> - if (addr > efuse_available_max_size)
>=20
> - return false;
> - /* retrieve original data /
> - addr =3D 0;
> - while (addr < header_addr) {
> - if (!efuse_one_byte_read(adapter, addr++, &value)) {
> - ret =3D false;
> - break;
> - }
> - offset =3D GET_EFUSE_OFFSET(value);
> - word_en =3D GET_EFUSE_WORD_EN(value);
> - if (pkt.offset !=3D offset) {
> - addr +=3D calculate_word_cnts(word_en) * 2;
> - continue;
> - }
> - for (i =3D 0; i < PGPKG_MAX_WORDS; i++) {
> - if (!(BIT(i) & word_en))
> - continue;
> - if (BIT(i) & pkt.word_en) {
> - if (efuse_one_byte_read(adapter,
> - addr,
> - &value))
> - pkt.data[i * 2] =3D value;
> - else
> - return false;
> - if (efuse_one_byte_read(adapter,
> - addr + 1,
> - &value))
> - pkt.data[i * 2 + 1] =3D value;
> - else
> - return false;
> - }
> - addr +=3D 2;
> - }
> - }
> - if (addr !=3D header_addr)
> - return false;
> - addr++;
> - / fill original data /
> - for (i =3D 0; i < PGPKG_MAX_WORDS; i++) {
> - if (BIT(i) & pkt.word_en) {
> - efuse_one_byte_write(adapter, addr, pkt.data[i * 2]);
> - efuse_one_byte_write(adapter, addr + 1,
> - pkt.data[i * 2 + 1]);
> - / additional check /
> - if (!efuse_one_byte_read(adapter, addr, &value)) {
> - ret =3D false;
> - } else if (pkt.data[i * 2] !=3D value) {
> - ret =3D false;
> - if (value =3D=3D 0xFF) / write again /
> - efuse_one_byte_write(adapter, addr,
> - pkt.data[i * 2]);
> - }
> - if (!efuse_one_byte_read(adapter, addr + 1, &value)) {
> - ret =3D false;
> - } else if (pkt.data[i * 2 + 1] !=3D value) {
> - ret =3D false;
> - if (value =3D=3D 0xFF) / write again */
> - efuse_one_byte_write(adapter, addr + 1,
> - pkt.data[i * 2 +
> - 1]);
> - }
> - }
> - addr +=3D 2;
> - }
> - return ret;
> -}
> -
> -u8 r8712_efuse_pg_packet_write(struct _adapter *adapter, const u8 offset=
,
> - const u8 word_en, const u8 data)
> -{
> - u8 pg_header =3D 0;
> - u16 efuse_addr =3D 0, curr_size =3D 0;
> - u8 efuse_data, target_word_cnts =3D 0;
> - int repeat_times;
> - int sub_repeat;
> - u8 bResult =3D true;
> -
> - / check if E-Fuse Clock Enable and E-Fuse Clock is 40M */
> - efuse_data =3D r8712_read8(adapter, EFUSE_CLK_CTRL);
> - if (efuse_data !=3D 0x03)
> - return false;
> - pg_header =3D MAKE_EFUSE_HEADER(offset, word_en);
> - target_word_cnts =3D calculate_word_cnts(word_en);
> - repeat_times =3D 0;
> - efuse_addr =3D 0;
> - while (efuse_addr < efuse_available_max_size) {
> - curr_size =3D r8712_efuse_get_current_size(adapter);
> - if ((curr_size + 1 + target_word_cnts * 2) >
>=20
> - efuse_available_max_size)
> - return false; /target_word_cnts + pg header(1 byte)/
> - efuse_addr =3D curr_size; /* current size is also the last addr*/
> - efuse_one_byte_write(adapter, efuse_addr, pg_header); /hdr/
> - sub_repeat =3D 0;
> - /* check if what we read is what we write */
> - while (!efuse_one_byte_read(adapter, efuse_addr,
> - &efuse_data)) {
> - if (++sub_repeat > REPEAT_THRESHOLD) {
>=20
> - bResult =3D false; /* continue to blind write /
> - break; / continue to blind write */
> - }
> - }
> - if ((sub_repeat > REPEAT_THRESHOLD) ||
>=20
> - (pg_header =3D=3D efuse_data)) {
> - /* write header ok OR can't check header(creep) /
> - u8 i;
> -
> - / go to next address /
> - efuse_addr++;
> - for (i =3D 0; i < target_word_cnts * 2; i++) {
> - efuse_one_byte_write(adapter,
> - efuse_addr + i,
> - (data + i));
> - if (!efuse_one_byte_read(adapter,
> - efuse_addr + i,
> - &efuse_data))
> - bResult =3D false;
> - else if ((data + i) !=3D efuse_data) / fail /
> - bResult =3D false;
> - }
> - break;
> - }
> - / write header fail /
> - bResult =3D false;
> - if (efuse_data =3D=3D 0xFF)
> - return bResult; / nothing damaged. /
> - / call rescue procedure /
> - if (!fix_header(adapter, efuse_data, efuse_addr))
> - return false; / rescue fail /
> -
> - if (++repeat_times > REPEAT_THRESHOLD) / fail */
>=20
> - break;
> - /* otherwise, take another risk... */
> - }
> - return bResult;
> -}
> -
> -u8 r8712_efuse_access(struct _adapter *adapter, u8 bRead, u16 start_addr=
,
> - u16 cnts, u8 *data)
> -{
> - int i;
> - u8 res =3D true;
> -
> - if (start_addr > EFUSE_MAX_SIZE)
>=20
> - return false;
> - if (!bRead && ((start_addr + cnts) >
>=20
> - efuse_available_max_size))
> - return false;
> - if (!bRead && !r8712_efuse_reg_init(adapter))
> - return false;
> - /* -----------------e-fuse one byte read / write ---------------------*=
/
> - for (i =3D 0; i < cnts; i++) {
> - if ((start_addr + i) > EFUSE_MAX_SIZE) {
>=20
> - res =3D false;
> - break;
> - }
> - res =3D efuse_one_byte_rw(adapter, bRead, start_addr + i,
> - data + i);
> - if (!bRead && !res)
> - break;
> - }
> - if (!bRead)
> - r8712_efuse_reg_uninit(adapter);
> - return res;
> -}
> -
> -u8 r8712_efuse_map_read(struct _adapter *adapter, u16 addr, u16 cnts, u8=
 *data)
> -{
> - u8 offset, ret =3D true;
> - u8 pktdata[PGPKT_DATA_SIZE];
> - int i, idx;
> -
> - if ((addr + cnts) > EFUSE_MAP_MAX_SIZE)
>=20
> - return false;
> - if (efuse_is_empty(adapter, &offset) && offset) {
> - for (i =3D 0; i < cnts; i++)
> - data[i] =3D 0xFF;
> - return ret;
> - }
> - offset =3D (addr >> 3) & 0xF;
>=20
> - ret =3D r8712_efuse_pg_packet_read(adapter, offset, pktdata);
> - i =3D addr & 0x7; /* pktdata index /
> - idx =3D 0; / data index */
> -
> - do {
> - for (; i < PGPKT_DATA_SIZE; i++) {
> - data[idx++] =3D pktdata[i];
> - if (idx =3D=3D cnts)
> - return ret;
> - }
> - offset++;
> - if (!r8712_efuse_pg_packet_read(adapter, offset, pktdata))
> - ret =3D false;
> - i =3D 0;
> - } while (1);
> - return ret;
> -}
> -
> -u8 r8712_efuse_map_write(struct _adapter *adapter, u16 addr, u16 cnts,
> - u8 *data)
> -{
> - u8 offset, word_en, empty;
> - u8 pktdata[PGPKT_DATA_SIZE], newdata[PGPKT_DATA_SIZE];
> - int i, j, idx;
> -
> - if ((addr + cnts) > EFUSE_MAP_MAX_SIZE)
>=20
> - return false;
> - /* check if E-Fuse Clock Enable and E-Fuse Clock is 40M */
> - empty =3D r8712_read8(adapter, EFUSE_CLK_CTRL);
> - if (empty !=3D 0x03)
> - return false;
> - if (efuse_is_empty(adapter, &empty)) {
> - if (empty)
> - memset(pktdata, 0xFF, PGPKT_DATA_SIZE);
> - } else {
> - return false;
> - }
> - offset =3D (addr >> 3) & 0xF;
>=20
> - if (!empty)
> - if (!r8712_efuse_pg_packet_read(adapter, offset, pktdata))
> - return false;
> - word_en =3D 0xF;
> - memset(newdata, 0xFF, PGPKT_DATA_SIZE);
> - i =3D addr & 0x7; /* pktdata index /
> - j =3D 0; / newdata index /
> - idx =3D 0; / data index /
> -
> - if (i & 0x1) {
> - / odd start */
> - if (data[idx] !=3D pktdata[i]) {
> - word_en &=3D ~BIT(i >> 1);
>=20
> - newdata[j++] =3D pktdata[i - 1];
> - newdata[j++] =3D data[idx];
> - }
> - i++;
> - idx++;
> - }
> - do {
> - for (; i < PGPKT_DATA_SIZE; i +=3D 2) {
> - if ((cnts - idx) =3D=3D 1) {
> - if (data[idx] !=3D pktdata[i]) {
> - word_en &=3D ~BIT(i >> 1);
>=20
> - newdata[j++] =3D data[idx];
> - newdata[j++] =3D pktdata[1 + 1];
> - }
> - idx++;
> - break;
> - }
> -
> - if ((data[idx] !=3D pktdata[i]) || (data[idx + 1] !=3D
> - pktdata[i + 1])) {
> - word_en &=3D ~BIT(i >> 1);
>=20
> - newdata[j++] =3D data[idx];
> - newdata[j++] =3D data[idx + 1];
> - }
> - idx +=3D 2;
> -
> - if (idx =3D=3D cnts)
> - break;
> - }
> -
> - if (word_en !=3D 0xF)
> - if (!r8712_efuse_pg_packet_write(adapter, offset,
> - word_en, newdata))
> - return false;
> - if (idx =3D=3D cnts)
> - break;
> - offset++;
> - if (!empty)
> - if (!r8712_efuse_pg_packet_read(adapter, offset,
> - pktdata))
> - return false;
> - i =3D 0;
> - j =3D 0;
> - word_en =3D 0xF;
> - memset(newdata, 0xFF, PGPKT_DATA_SIZE);
> - } while (1);
> -
> - return true;
> -}
> diff --git a/drivers/staging/rtl8712/rtl8712_efuse.h b/drivers/staging/rt=
l8712/rtl8712_efuse.h
> deleted file mode 100644
> index 7a49740212eb..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_efuse.h
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -#ifndef RTL8712_EFUSE_H
> -#define RTL8712_EFUSE_H
> -
> -#include "osdep_service.h"
> -
> -#define REPEAT_THRESHOLD 3
> -
> -#define EFUSE_MAX_SIZE 512
> -#define EFUSE_MAP_MAX_SIZE 128
> -
> -#define PGPKG_MAX_WORDS 4
> -#define PGPKT_DATA_SIZE 8 / PGPKG_MAX_WORDS2; BYTES sizeof(u8)8/
> -#define MAX_PGPKT_SIZE 9 / 1 + PGPKT_DATA_SIZE; header + 2 * 4 words (BY=
TES)*/
> -
> -#define GET_EFUSE_OFFSET(header) ((header & 0xF0) >> 4)
>=20
> -#define GET_EFUSE_WORD_EN(header) (header & 0x0F)
> -#define MAKE_EFUSE_HEADER(offset, word_en) ((((offset) & 0x0F) << 4) | \
> - ((word_en) & 0x0F))
> -/-----------------------------------------------------------------------=
---/
> -struct PGPKT_STRUCT {
> - u8 offset;
> - u8 word_en;
> - u8 data[PGPKT_DATA_SIZE];
> -};
> -
> -/-----------------------------------------------------------------------=
---/
> -u8 r8712_efuse_reg_init(struct _adapter padapter);
> -void r8712_efuse_reg_uninit(struct _adapter padapter);
> -u16 r8712_efuse_get_current_size(struct _adapter padapter);
> -int r8712_efuse_get_max_size(struct _adapter padapter);
> -void r8712_efuse_change_max_size(struct _adapter padapter);
> -u8 r8712_efuse_pg_packet_read(struct _adapter padapter,
> - u8 offset, u8 data);
> -u8 r8712_efuse_pg_packet_write(struct _adapter padapter,
> - const u8 offset, const u8 word_en,
> - const u8 data);
> -u8 r8712_efuse_access(struct _adapter padapter, u8 bRead,
> - u16 start_addr, u16 cnts, u8 data);
> -u8 r8712_efuse_map_read(struct _adapter padapter, u16 addr,
> - u16 cnts, u8 data);
> -u8 r8712_efuse_map_write(struct _adapter padapter, u16 addr,
> - u16 cnts, u8 data);
> -#endif
> diff --git a/drivers/staging/rtl8712/rtl8712_event.h b/drivers/staging/rt=
l8712/rtl8712_event.h
> deleted file mode 100644
> index 0d3e5feadcc0..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_event.h
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***************************************************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - **/
> -#ifndef RTL8712_EVENT_H
> -#define RTL8712_EVENT_H
> -
> -void r8712_event_handle(struct _adapter padapter, __le32 peventbuf);
> -void r8712_got_addbareq_event_callback(struct _adapter adapter, u8 pbuf)=
;
> -
> -enum rtl8712_c2h_event {
> - GEN_EVT_CODE(_Read_MACREG) =3D 0, /0/
> - GEN_EVT_CODE(_Read_BBREG),
> - GEN_EVT_CODE(_Read_RFREG),
> - GEN_EVT_CODE(_Read_EEPROM),
> - GEN_EVT_CODE(_Read_EFUSE),
> - GEN_EVT_CODE(_Read_CAM), /5/
> - GEN_EVT_CODE(_Get_BasicRate),
> - GEN_EVT_CODE(_Get_DataRate),
> - GEN_EVT_CODE(_Survey), /8/
> - GEN_EVT_CODE(_SurveyDone), /9/
> -
> - GEN_EVT_CODE(_JoinBss), /10/
> - GEN_EVT_CODE(_AddSTA),
> - GEN_EVT_CODE(_DelSTA),
> - GEN_EVT_CODE(_AtimDone),
> - GEN_EVT_CODE(_TX_Report),
> - GEN_EVT_CODE(_CCX_Report), /15/
> - GEN_EVT_CODE(_DTM_Report),
> - GEN_EVT_CODE(_TX_Rate_Statistics),
> - GEN_EVT_CODE(_C2HLBK),
> - GEN_EVT_CODE(_FWDBG),
> - GEN_EVT_CODE(_C2HFEEDBACK), /20/
> - GEN_EVT_CODE(_ADDBA),
> - GEN_EVT_CODE(_C2HBCN),
> - GEN_EVT_CODE(_ReportPwrState), /filen: only for PCIE, USB/
> - GEN_EVT_CODE(_WPS_PBC), /24/
> - GEN_EVT_CODE(_ADDBAReq_Report), /25/
> - MAX_C2HEVT
> -};
> -
> -#ifdef RTL8712_CMD_C
> -
> -static struct fwevent wlanevents[] =3D {
> - {0, NULL}, /0/
> - {0, NULL},
> - {0, NULL},
> - {0, NULL},
> - {0, NULL},
> - {0, NULL},
> - {0, NULL},
> - {0, NULL},
> - {0, &r8712_survey_event_callback}, /8/
> - {sizeof(struct surveydone_event),
> - &r8712_surveydone_event_callback}, /9/
> -
> - {0, &r8712_joinbss_event_callback}, /10/
> - {sizeof(struct stassoc_event), &r8712_stassoc_event_callback},
> - {sizeof(struct stadel_event), &r8712_stadel_event_callback},
> - {0, &r8712_atimdone_event_callback},
> - {0, NULL},
> - {0, NULL}, /15/
> - {0, NULL},
> - {0, NULL},
> - {0, NULL},
> - {0, NULL}, /fwdbg_event_callback},/
> - {0, NULL}, /20/
> - {0, NULL},
> - {0, NULL},
> - {0, &r8712_cpwm_event_callback},
> - {0, &r8712_wpspbc_event_callback},
> - {0, &r8712_got_addbareq_event_callback},
> -};
> -
> -#endif/RTL8712_CMD_C/
> -
> -#endif
> diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h b/drivers/=
staging/rtl8712/rtl8712_fifoctrl_bitdef.h
> deleted file mode 100644
> index f09645fa1886..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_fifoctrl_bitdef.h
> +++ /dev/null
> @@ -1,131 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_FIFOCTRL_BITDEF_H
> -#define RTL8712_FIFOCTRL_BITDEF_H
> -
> -/PBP/
> -#define _PSTX_MSK 0xF0
> -#define _PSTX_SHT 4
> -#define _PSRX_MSK 0x0F
> -#define _PSRX_SHT 0
> -
> -/TXFF_STATUS/
> -#define _TXSTATUS_OVF BIT(15)
> -
> -/RXFF_STATUS/
> -#define _STATUSFF1_OVF BIT(7)
> -#define _STATUSFF1_EMPTY BIT(6)
> -#define _STATUSFF0_OVF BIT(5)
> -#define _STATUSFF0_EMPTY BIT(4)
> -#define _RXFF1_OVF BIT(3)
> -#define _RXFF1_EMPTY BIT(2)
> -#define _RXFF0_OVF BIT(1)
> -#define _RXFF0_EMPTY BIT(0)
> -
> -/TXFF_EMPTY_TH/
> -#define _BKQ_EMPTY_TH_MSK 0x0F0000
> -#define _BKQ_EMPTY_TH_SHT 16
> -#define _BEQ_EMPTY_TH_MSK 0x00F000
> -#define _BEQ_EMPTY_TH_SHT 12
> -#define _VIQ_EMPTY_TH_MSK 0x000F00
> -#define _VIQ_EMPTY_TH_SHT 8
> -#define _VOQ_EMPTY_TH_MSK 0x0000F0
> -#define _VOQ_EMPTY_TH_SHT 4
> -#define _BMCQ_EMPTY_TH_MSK 0x00000F
> -#define _BMCQ_EMPTY_TH_SHT 0
> -
> -/SDIO_RX_BLKSZ/
> -#define _SDIO_RX_BLKSZ_MSK 0x07
> -
> -/RXDMA_CTRL/
> -#define _C2HFF_POLL BIT(4)
> -#define _RXPKT_POLL BIT(0)
> -
> -/RXPKT_NUM/
> -#define _RXCMD_NUM_MSK 0xFF00
> -#define _RXCMD_NUM_SHT 8
> -#define _RXFF0_NUM_MSK 0x00FF
> -#define _RXFF0_NUM_SHT 0
> -
> -/FIFOPAGE2/
> -#define _PUB_AVAL_PG_MSK 0xFFFF0000
> -#define _PUB_AVAL_PG_SHT 16
> -#define _BCN_AVAL_PG_MSK 0x0000FFFF
> -#define _BCN_AVAL_PG_SHT 0
> -
> -/RX0PKTNUM/
> -#define _RXFF0_DEC_POLL BIT(15)
> -#define _RXFF0_PKT_DEC_NUM_MSK 0x3F00
> -#define _RXFF0_PKT_DEC_NUM_SHT 8
> -#define _RXFF0_PKTNUM_RPT_MSK 0x00FF
> -#define _RXFF0_PKTNUM_RPT_SHT 0
> -
> -/RX1PKTNUM/
> -#define _RXFF1_DEC_POLL BIT(15)
> -#define _RXFF1_PKT_DEC_NUM_MSK 0x3F00
> -#define _RXFF1_PKT_DEC_NUM_SHT 8
> -#define _RXFF1_PKTNUM_RPT_MSK 0x00FF
> -#define _RXFF1_PKTNUM_RPT_SHT 0
> -
> -/RXFLTMAP0/
> -#define _MGTFLT13EN BIT(13)
> -#define _MGTFLT12EN BIT(12)
> -#define _MGTFLT11EN BIT(11)
> -#define _MGTFLT10EN BIT(10)
> -#define _MGTFLT9EN BIT(9)
> -#define _MGTFLT8EN BIT(8)
> -#define _MGTFLT5EN BIT(5)
> -#define _MGTFLT4EN BIT(4)
> -#define _MGTFLT3EN BIT(3)
> -#define _MGTFLT2EN BIT(2)
> -#define _MGTFLT1EN BIT(1)
> -#define _MGTFLT0EN BIT(0)
> -
> -/RXFLTMAP1/
> -#define _CTRLFLT15EN BIT(15)
> -#define _CTRLFLT14EN BIT(14)
> -#define _CTRLFLT13EN BIT(13)
> -#define _CTRLFLT12EN BIT(12)
> -#define _CTRLFLT11EN BIT(11)
> -#define _CTRLFLT10EN BIT(10)
> -#define _CTRLFLT9EN BIT(9)
> -#define _CTRLFLT8EN BIT(8)
> -#define _CTRLFLT7EN BIT(7)
> -#define _CTRLFLT6EN BIT(6)
> -
> -/RXFLTMAP2/
> -#define _DATAFLT15EN BIT(15)
> -#define _DATAFLT14EN BIT(14)
> -#define _DATAFLT13EN BIT(13)
> -#define _DATAFLT12EN BIT(12)
> -#define _DATAFLT11EN BIT(11)
> -#define _DATAFLT10EN BIT(10)
> -#define _DATAFLT9EN BIT(9)
> -#define _DATAFLT8EN BIT(8)
> -#define _DATAFLT7EN BIT(7)
> -#define _DATAFLT6EN BIT(6)
> -#define _DATAFLT5EN BIT(5)
> -#define _DATAFLT4EN BIT(4)
> -#define _DATAFLT3EN BIT(3)
> -#define _DATAFLT2EN BIT(2)
> -#define _DATAFLT1EN BIT(1)
> -#define _DATAFLT0EN BIT(0)
> -
> -/RXFLTMAP3/
> -#define _MESHAFLT1EN BIT(1)
> -#define _MESHAFLT0EN BIT(0)
> -
> -/TXPKT_NUM_CTRL/
> -#define _TXPKTNUM_DEC BIT(8)
> -#define _TXPKTNUM_MSK 0x00FF
> -#define _TXPKTNUM_SHT 0
> -
> -/TXFF_PG_NUM/
> -#define _TXFF_PG_NUM_MSK 0x0FFF
> -
> -#endif / RTL8712_FIFOCTRL_BITDEF_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h b/drivers/=
staging/rtl8712/rtl8712_fifoctrl_regdef.h
> deleted file mode 100644
> index 189fdeb16d7d..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_fifoctrl_regdef.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_FIFOCTRL_REGDEF_H
> -#define RTL8712_FIFOCTRL_REGDEF_H
> -
> -#define RQPN (RTL8712_FIFOCTRL_ + 0x00)
> -#define RXFF_BNDY (RTL8712_FIFOCTRL_ + 0x0C)
> -#define RXRPT_BNDY (RTL8712_FIFOCTRL_ + 0x10)
> -#define TXPKTBUF_PGBNDY (RTL8712_FIFOCTRL_ + 0x14)
> -#define PBP (RTL8712_FIFOCTRL_ + 0x15)
> -#define RX_DRVINFO_SZ (RTL8712_FIFOCTRL_ + 0x16)
> -#define TXFF_STATUS (RTL8712_FIFOCTRL_ + 0x17)
> -#define RXFF_STATUS (RTL8712_FIFOCTRL_ + 0x18)
> -#define TXFF_EMPTY_TH (RTL8712_FIFOCTRL_ + 0x19)
> -#define SDIO_RX_BLKSZ (RTL8712_FIFOCTRL_ + 0x1C)
> -#define RXDMA_RXCTRL (RTL8712_FIFOCTRL_ + 0x1D)
> -#define RXPKT_NUM (RTL8712_FIFOCTRL_ + 0x1E)
> -#define RXPKT_NUM_C2H (RTL8712_FIFOCTRL_ + 0x1F)
> -#define C2HCMD_UDT_SIZE (RTL8712_FIFOCTRL_ + 0x20)
> -#define C2HCMD_UDT_ADDR (RTL8712_FIFOCTRL_ + 0x22)
> -#define FIFOPAGE2 (RTL8712_FIFOCTRL_ + 0x24)
> -#define FIFOPAGE1 (RTL8712_FIFOCTRL_ + 0x28)
> -#define FW_RSVD_PG_CTRL (RTL8712_FIFOCTRL_ + 0x30)
> -#define TXRPTFF_RDPTR (RTL8712_FIFOCTRL_ + 0x40)
> -#define TXRPTFF_WTPTR (RTL8712_FIFOCTRL_ + 0x44)
> -#define C2HFF_RDPTR (RTL8712_FIFOCTRL_ + 0x48)
> -#define C2HFF_WTPTR (RTL8712_FIFOCTRL_ + 0x4C)
> -#define RXFF0_RDPTR (RTL8712_FIFOCTRL_ + 0x50)
> -#define RXFF0_WTPTR (RTL8712_FIFOCTRL_ + 0x54)
> -#define RXFF1_RDPTR (RTL8712_FIFOCTRL_ + 0x58)
> -#define RXFF1_WTPTR (RTL8712_FIFOCTRL_ + 0x5C)
> -#define RXRPT0FF_RDPTR (RTL8712_FIFOCTRL_ + 0x60)
> -#define RXRPT0FF_WTPTR (RTL8712_FIFOCTRL_ + 0x64)
> -#define RXRPT1FF_RDPTR (RTL8712_FIFOCTRL_ + 0x68)
> -#define RXRPT1FF_WTPTR (RTL8712_FIFOCTRL_ + 0x6C)
> -#define RX0PKTNUM (RTL8712_FIFOCTRL_ + 0x72)
> -#define RX1PKTNUM (RTL8712_FIFOCTRL_ + 0x74)
> -#define RXFLTMAP0 (RTL8712_FIFOCTRL_ + 0x76)
> -#define RXFLTMAP1 (RTL8712_FIFOCTRL_ + 0x78)
> -#define RXFLTMAP2 (RTL8712_FIFOCTRL_ + 0x7A)
> -#define RXFLTMAP3 (RTL8712_FIFOCTRL_ + 0x7c)
> -#define TBDA (RTL8712_FIFOCTRL_ + 0x84)
> -#define THPDA (RTL8712_FIFOCTRL_ + 0x88)
> -#define TCDA (RTL8712_FIFOCTRL_ + 0x8C)
> -#define TMDA (RTL8712_FIFOCTRL_ + 0x90)
> -#define HDA (RTL8712_FIFOCTRL_ + 0x94)
> -#define TVODA (RTL8712_FIFOCTRL_ + 0x98)
> -#define TVIDA (RTL8712_FIFOCTRL_ + 0x9C)
> -#define TBEDA (RTL8712_FIFOCTRL_ + 0xA0)
> -#define TBKDA (RTL8712_FIFOCTRL_ + 0xA4)
> -#define RCDA (RTL8712_FIFOCTRL_ + 0xA8)
> -#define RDSA (RTL8712_FIFOCTRL_ + 0xAC)
> -#define TXPKT_NUM_CTRL (RTL8712_FIFOCTRL_ + 0xB0)
> -#define TXQ_PGADD (RTL8712_FIFOCTRL_ + 0xB3)
> -#define TXFF_PG_NUM (RTL8712_FIFOCTRL_ + 0xB4)
> -
> -#endif / RTL8712_FIFOCTRL_REGDEF_H /
> diff --git a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h b/drivers/stagin=
g/rtl8712/rtl8712_gp_bitdef.h
> deleted file mode 100644
> index ee651fb3fde3..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_gp_bitdef.h
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_GP_BITDEF_H
> -#define RTL8712_GP_BITDEF_H
> -
> -/GPIO_CTRL/
> -#define _GPIO_MOD_MSK 0xFF000000
> -#define _GPIO_MOD_SHT 24
> -#define _GPIO_IO_SEL_MSK 0x00FF0000
> -#define _GPIO_IO_SEL_SHT 16
> -#define _GPIO_OUT_MSK 0x0000FF00
> -#define _GPIO_OUT_SHT 8
> -#define _GPIO_IN_MSK 0x000000FF
> -#define _GPIO_IN_SHT 0
> -
> -/SYS_PINMUX_CFG/
> -#define _GPIOSEL_MSK 0x0003
> -#define _GPIOSEL_SHT 0
> -
> -/LED_CFG/
> -#define _LED1SV BIT(7)
> -#define _LED1CM_MSK 0x0070
> -#define _LED1CM_SHT 4
> -#define _LED0SV BIT(3)
> -#define _LED0CM_MSK 0x0007
> -#define _LED0CM_SHT 0
> -
> -/PHY_REG/
> -#define _HST_RDRDY_SHT 0
> -#define _HST_RDRDY_MSK 0xFF
> -#define _HST_RDRDY BIT(_HST_RDRDY_SHT)
> -#define _CPU_WTBUSY_SHT 1
> -#define _CPU_WTBUSY_MSK 0xFF
> -#define _CPU_WTBUSY BIT(_CPU_WTBUSY_SHT)
> -
> -/ 11. General Purpose Registers (Offset: 0x02E0 - 0x02FF)/
> -
> -/ 8192S GPIO Config Setting (offset 0x2F1, 1 byte)/
> -
> -/-----------------------------------------------------------------------=
-----/
> -
> -#define GPIOMUX_EN BIT(3) / When this bit is set to "1",
> - * GPIO PINs will switch to MAC
> - * GPIO Function
> - /
> -#define GPIOSEL_GPIO 0 / UART or JTAG or pure GPIO/
> -#define GPIOSEL_PHYDBG 1 / PHYDBG/
> -#define GPIOSEL_BT 2 / BT_coex/
> -#define GPIOSEL_WLANDBG 3 / WLANDBG/
> -#define GPIOSEL_GPIO_MASK (~(BIT(0) | BIT(1)))
> -/ HW Radio OFF switch (GPIO BIT) /
> -#define HAL_8192S_HW_GPIO_OFF_BIT BIT(3)
> -#define HAL_8192S_HW_GPIO_OFF_MASK 0xF7
> -#define HAL_8192S_HW_GPIO_WPS_BIT BIT(4)
> -
> -#endif /RTL8712_GP_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_gp_regdef.h b/drivers/stagin=
g/rtl8712/rtl8712_gp_regdef.h
> deleted file mode 100644
> index 892a7fb13923..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_gp_regdef.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/****************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_GP_REGDEF_H
> -#define RTL8712_GP_REGDEF_H
> -
> -#define PSTIMER (RTL8712_GP_ + 0x00)
> -#define TIMER1 (RTL8712_GP_ + 0x04)
> -#define TIMER2 (RTL8712_GP_ + 0x08)
> -#define GPIO_CTRL (RTL8712_GP_ + 0x0C)
> -#define GPIO_IO_SEL (RTL8712_GP_ + 0x0E)
> -#define GPIO_INTCTRL (RTL8712_GP_ + 0x10)
> -#define MAC_PINMUX_CTRL (RTL8712_GP_ + 0x11)
> -#define LEDCFG (RTL8712_GP_ + 0x12)
> -#define PHY_REG_RPT (RTL8712_GP_ + 0x13)
> -#define PHY_REG_DATA (RTL8712_GP_ + 0x14)
> -
> -#endif /RTL8712_GP_REGDEF_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_hal.h b/drivers/staging/rtl8=
712/rtl8712_hal.h
> deleted file mode 100644
> index 66cc4645e2d1..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_hal.h
> +++ /dev/null
> @@ -1,142 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_HAL_H
> -#define RTL8712_HAL_H
> -
> -enum _HW_VERSION {
> - RTL8712_FPGA,
> - RTL8712_1stCUT, /A Cut (RTL8712_ASIC)/
> - RTL8712_2ndCUT, /B Cut/
> - RTL8712_3rdCUT, /C Cut/
> -};
> -
> -enum _LOOPBACK_TYPE {
> - RTL8712_AIR_TRX =3D 0,
> - RTL8712_MAC_LBK,
> - RTL8712_BB_LBK,
> - RTL8712_MAC_FW_LBK =3D 4,
> - RTL8712_BB_FW_LBK =3D 8,
> -};
> -
> -enum RTL871X_HCI_TYPE {
> - RTL8712_SDIO,
> - RTL8712_USB,
> -};
> -
> -enum RTL8712_RF_CONFIG {
> - RTL8712_RF_1T1R,
> - RTL8712_RF_1T2R,
> - RTL8712_RF_2T2R
> -};
> -
> -enum RTL8712_HCI_TYPE {
> - RTL8712_HCI_TYPE_PCIE =3D 0x01,
> - RTL8712_HCI_TYPE_AP_PCIE =3D 0x81,
> - RTL8712_HCI_TYPE_USB =3D 0x02,
> - RTL8712_HCI_TYPE_92USB =3D 0x02,
> - RTL8712_HCI_TYPE_AP_USB =3D 0x82,
> - RTL8712_HCI_TYPE_72USB =3D 0x12,
> - RTL8712_HCI_TYPE_SDIO =3D 0x04,
> - RTL8712_HCI_TYPE_72SDIO =3D 0x14
> -};
> -
> -struct fw_priv { /8-bytes alignment required/
> - /--- long word 0 ----/
> - unsigned char signature_0; /0x12: CE product, 0x92: IT product/
> - unsigned char signature_1; /0x87: CE product, 0x81: IT product/
> - unsigned char hci_sel; /0x81: PCI-AP, 01:PCIe, 02: 92S-U, 0x82: USB-AP,
> - * 0x12: 72S-U, 03:SDIO
> - /
> - unsigned char chip_version; /the same value as register value/
> - unsigned char customer_ID_0; /customer ID low byte/
> - unsigned char customer_ID_1; /customer ID high byte/
> - unsigned char rf_config; /0x11: 1T1R, 0x12: 1T2R, 0x92: 1T2R turbo,
> - * 0x22: 2T2R
> - /
> - unsigned char usb_ep_num; / 4: 4EP, 6: 6EP, 11: 11EP/
> - /--- long word 1 ----/
> - unsigned char regulatory_class_0; /regulatory class bit map 0/
> - unsigned char regulatory_class_1; /regulatory class bit map 1/
> - unsigned char regulatory_class_2; /regulatory class bit map 2/
> - unsigned char regulatory_class_3; /regulatory class bit map 3/
> - unsigned char rfintfs; / 0:SWSI, 1:HWSI, 2:HWPI/
> - unsigned char def_nettype;
> - unsigned char turbo_mode;
> - unsigned char low_power_mode;/ 0: normal mode, 1: low power mode/
> - /--- long word 2 ----/
> - unsigned char lbk_mode; /0x00: normal, 0x03: MACLBK, 0x01: PHYLBK/
> - unsigned char mp_mode; / 1: for MP use, 0: for normal driver /
> - unsigned char vcs_type; / 0:off 1:on 2:auto /
> - unsigned char vcs_mode; / 1:RTS/CTS 2:CTS to self /
> - unsigned char rsvd022;
> - unsigned char rsvd023;
> - unsigned char rsvd024;
> - unsigned char rsvd025;
> - /--- long word 3 ----/
> - unsigned char qos_en; /1: QoS enable/
> - unsigned char bw_40MHz_en; /1: 40MHz BW enable/
> - unsigned char AMSDU2AMPDU_en; /1: 4181 convert AMSDU to AMPDU,
> - * 0: disable
> - /
> - unsigned char AMPDU_en; /1: 11n AMPDU enable/
> - unsigned char rate_control_offload; /1: FW offloads,0: driver handles/
> - unsigned char aggregation_offload; /1: FW offloads,0: driver handles/
> - unsigned char rsvd030;
> - unsigned char rsvd031;
> - /--- long word 4 ----/
> - unsigned char beacon_offload; / 1. FW offloads, 0: driver handles/
> - unsigned char MLME_offload; / 2. FW offloads, 0: driver handles/
> - unsigned char hwpc_offload; / 3. FW offloads, 0: driver handles/
> - unsigned char tcp_checksum_offload; /4. FW offloads,0: driver handles/
> - unsigned char tcp_offload; / 5. FW offloads, 0: driver handles/
> - unsigned char ps_control_offload; / 6. FW offloads, 0: driver handles/
> - unsigned char WWLAN_offload; / 7. FW offloads, 0: driver handles/
> - unsigned char rsvd040;
> - /--- long word 5 ----/
> - unsigned char tcp_tx_frame_len_L; /tcp tx packet length low byte/
> - unsigned char tcp_tx_frame_len_H; /tcp tx packet length high byte/
> - unsigned char tcp_rx_frame_len_L; /tcp rx packet length low byte/
> - unsigned char tcp_rx_frame_len_H; /tcp rx packet length high byte/
> - unsigned char rsvd050;
> - unsigned char rsvd051;
> - unsigned char rsvd052;
> - unsigned char rsvd053;
> -};
> -
> -struct fw_hdr {/8-byte alignment required/
> - unsigned short signature;
> - unsigned short version; / 0x8000 ~ 0x8FFF for FPGA version,
> - * 0x0000 ~ 0x7FFF for ASIC version,
> - /
> - unsigned int dmem_size; /define the size of boot loader/
> - unsigned int img_IMEM_size; /define the size of FW in IMEM/
> - unsigned int img_SRAM_size; /define the size of FW in SRAM/
> - unsigned int fw_priv_sz; /define the size of DMEM variable/
> - unsigned short efuse_addr;
> - unsigned short h2ccnd_resp_addr;
> - unsigned int SVNRevision;
> - unsigned int release_time; /Mon:Day:Hr:Min/
> - struct fw_priv fwpriv;
> -};
> -
> -struct hal_priv {
> - /Endpoint handles/
> - struct net_device pipehdls_r8712[10];
> - u8 (hal_bus_init)(struct _adapter adapter);
> -};
> -
> -uint rtl8712_hal_init(struct _adapter padapter);
> -int rtl871x_load_fw(struct _adapter padapter);
> -
> -#endif
> diff --git a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h b/drivers=
/staging/rtl8712/rtl8712_interrupt_bitdef.h
> deleted file mode 100644
> index e9732a1bcd7e..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_interrupt_bitdef.h
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/*******************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_INTERRUPT_BITDEF_H
> -#define RTL8712_INTERRUPT_BITDEF_H
> -
> -/HIMR/
> -/HISR/
> -#define _CPUERR BIT(29)
> -#define _ATIMEND BIT(28)
> -#define _TXBCNOK BIT(27)
> -#define _TXBCNERR BIT(26)
> -#define _BCNDMAINT4 BIT(25)
> -#define _BCNDMAINT3 BIT(24)
> -#define _BCNDMAINT2 BIT(23)
> -#define _BCNDMAINT1 BIT(22)
> -#define _BCNDOK4 BIT(21)
> -#define _BCNDOK3 BIT(20)
> -#define _BCNDOK2 BIT(19)
> -#define _BCNDOK1 BIT(18)
> -#define _TIMEOUT2 BIT(17)
> -#define _TIMEOUT1 BIT(16)
> -#define _TXFOVW BIT(15)
> -#define _PSTIMEOUT BIT(14)
> -#define _BCNDMAINT0 BIT(13)
> -#define _FOVW BIT(12)
> -#define _RDU BIT(11)
> -#define _RXCMDOK BIT(10)
> -#define _BCNDOK0 BIT(9)
> -#define _HIGHDOK BIT(8)
> -#define _COMDOK BIT(7)
> -#define _MGTDOK BIT(6)
> -#define _HCCADOK BIT(5)
> -#define _BKDOK BIT(4)
> -#define _BEDOK BIT(3)
> -#define _VIDOK BIT(2)
> -#define _VODOK BIT(1)
> -#define _RXOK BIT(0)
> -
> -#endif /RTL8712_INTERRUPT_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_io.c b/drivers/staging/rtl87=
12/rtl8712_io.c
> deleted file mode 100644
> index 384cbdb05e19..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_io.c
> +++ /dev/null
> @@ -1,99 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**
> - * rtl8712_io.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com.
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL8712_IO_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "rtl871x_io.h"
> -#include "osdep_intf.h"
> -#include "usb_ops.h"
> -
> -u8 r8712_read8(struct _adapter *adapter, u32 addr)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - return hdl->io_ops._read8(hdl, addr);
>=20
> -}
> -
> -u16 r8712_read16(struct _adapter *adapter, u32 addr)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - return hdl->io_ops._read16(hdl, addr);
>=20
> -}
> -
> -u32 r8712_read32(struct _adapter *adapter, u32 addr)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - return hdl->io_ops._read32(hdl, addr);
>=20
> -}
> -
> -void r8712_write8(struct _adapter *adapter, u32 addr, u8 val)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - hdl->io_ops._write8(hdl, addr, val);
>=20
> -}
> -
> -void r8712_write16(struct _adapter *adapter, u32 addr, u16 val)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - hdl->io_ops._write16(hdl, addr, val);
>=20
> -}
> -
> -void r8712_write32(struct _adapter *adapter, u32 addr, u32 val)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - hdl->io_ops._write32(hdl, addr, val);
>=20
> -}
> -
> -void r8712_read_mem(struct _adapter *adapter, u32 addr, u32 cnt, u8 *pme=
m)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - if (adapter->driver_stopped || adapter->surprise_removed)
>=20
> - return;
> -
> - hdl->io_ops._read_mem(hdl, addr, cnt, pmem);
>=20
> -}
> -
> -void r8712_write_mem(struct _adapter *adapter, u32 addr, u32 cnt, u8 *pm=
em)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - hdl->io_ops._write_mem(hdl, addr, cnt, pmem);
>=20
> -}
> -
> -void r8712_read_port(struct _adapter *adapter, u32 addr, u32 cnt, u8 *pm=
em)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - if (adapter->driver_stopped || adapter->surprise_removed)
>=20
> - return;
> -
> - hdl->io_ops._read_port(hdl, addr, cnt, pmem);
>=20
> -}
> -
> -void r8712_write_port(struct _adapter *adapter, u32 addr, u32 cnt, u8 *p=
mem)
> -{
> - struct intf_hdl *hdl =3D &adapter->pio_queue->intf;
>=20
> -
> - hdl->io_ops._write_port(hdl, addr, cnt, pmem);
>=20
> -}
> diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8=
712/rtl8712_led.c
> deleted file mode 100644
> index 6d9be5dec4e7..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_led.c
> +++ /dev/null
> @@ -1,1830 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************************************=
*******
> - * rtl8712_led.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -
> -#include "drv_types.h"
> -
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * Constant.
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -
> - *
> - * Default LED behavior.
> - /
> -#define LED_BLINK_NORMAL_INTERVAL 100
> -#define LED_BLINK_SLOWLY_INTERVAL 200
> -#define LED_BLINK_LONG_INTERVAL 400
> -
> -#define LED_BLINK_NO_LINK_INTERVAL_ALPHA 1000
> -#define LED_BLINK_LINK_INTERVAL_ALPHA 500
> -#define LED_BLINK_SCAN_INTERVAL_ALPHA 180
> -#define LED_BLINK_FASTER_INTERVAL_ALPHA 50
> -#define LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA 5000
> -
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * LED object.
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - /
> -enum _LED_STATE_871x {
> - LED_UNKNOWN =3D 0,
> - LED_STATE_ON =3D 1,
> - LED_STATE_OFF =3D 2,
> - LED_BLINK_NORMAL =3D 3,
> - LED_BLINK_SLOWLY =3D 4,
> - LED_POWER_ON_BLINK =3D 5,
> - LED_SCAN_BLINK =3D 6, / LED is blinking during scanning period,
> - * the # of times to blink is depend on time
> - * for scanning.
> - /
> - LED_NO_LINK_BLINK =3D 7, / LED is blinking during no link state. /
> - LED_BLINK_StartToBlink =3D 8,/ Customized for Sercomm Printer
> - * Server case
> - /
> - LED_BLINK_WPS =3D 9, / LED is blinkg during WPS communication */
> - LED_TXRX_BLINK =3D 10,
> - LED_BLINK_WPS_STOP =3D 11, /*for ALPHA */
> - LED_BLINK_WPS_STOP_OVERLAP =3D 12, /*for BELKIN /
> -};
> -
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * Prototype of protected function.
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - */
> -static void BlinkTimerCallback(struct timer_list *t);
> -
> -static void BlinkWorkItemCallback(struct work_struct work);
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * LED_819xUsb routines.
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - *
> - *
> - *
> - * Description:
> - * Initialize an LED_871x object.
> - */
> -static void InitLed871x(struct _adapter *padapter, struct LED_871x *pLed=
,
> - enum LED_PIN_871x LedPin)
> -{
> - pLed->padapter =3D padapter;
>=20
> - pLed->LedPin =3D LedPin;
>=20
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->bLedOn =3D false;
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - pLed->BlinkTimes =3D 0;
>=20
> - pLed->BlinkingLedState =3D LED_UNKNOWN;
>=20
> - timer_setup(&pLed->BlinkTimer, BlinkTimerCallback, 0);
>=20
> - INIT_WORK(&pLed->BlinkWorkItem, BlinkWorkItemCallback);
>=20
> -}
> -
> -/*
> - * Description:
> - * DeInitialize an LED_871x object.
> - */
> -static void DeInitLed871x(struct LED_871x *pLed)
> -{
> - del_timer_sync(&pLed->BlinkTimer);
>=20
> - /* We should reset bLedBlinkInProgress if we cancel
> - * the LedControlTimer,
> - */
> - pLed->bLedBlinkInProgress =3D false;
>=20
> -}
> -
> -/*
> - * Description:
> - * Turn on LED according to LedPin specified.
> - */
> -static void SwLedOn(struct _adapter *padapter, struct LED_871x *pLed)
> -{
> - u8 LedCfg;
> -
> - if (padapter->surprise_removed || padapter->driver_stopped)
>=20
> - return;
> - LedCfg =3D r8712_read8(padapter, LEDCFG);
> - switch (pLed->LedPin) {
>=20
> - case LED_PIN_GPIO0:
> - break;
> - case LED_PIN_LED0:
> - /* SW control led0 on./
> - r8712_write8(padapter, LEDCFG, LedCfg & 0xf0);
> - break;
> - case LED_PIN_LED1:
> - / SW control led1 on.*/
> - r8712_write8(padapter, LEDCFG, LedCfg & 0x0f);
> - break;
> - default:
> - break;
> - }
> - pLed->bLedOn =3D true;
>=20
> -}
> -
> -/*
> - * Description:
> - * Turn off LED according to LedPin specified.
> - */
> -static void SwLedOff(struct _adapter *padapter, struct LED_871x *pLed)
> -{
> - u8 LedCfg;
> -
> - if (padapter->surprise_removed || padapter->driver_stopped)
>=20
> - return;
> - LedCfg =3D r8712_read8(padapter, LEDCFG);
> - switch (pLed->LedPin) {
>=20
> - case LED_PIN_GPIO0:
> - break;
> - case LED_PIN_LED0:
> - LedCfg &=3D 0xf0; /* Set to software control./
> - r8712_write8(padapter, LEDCFG, (LedCfg | BIT(3)));
> - break;
> - case LED_PIN_LED1:
> - LedCfg &=3D 0x0f; / Set to software control.*/
> - r8712_write8(padapter, LEDCFG, (LedCfg | BIT(7)));
> - break;
> - default:
> - break;
> - }
> - pLed->bLedOn =3D false;
>=20
> -}
> -
> -/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * Interface to manipulate LED objects.
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - *
> - * Description:
> - * Initialize all LED_871x objects.
> - */
> -void r8712_InitSwLeds(struct _adapter *padapter)
> -{
> - struct led_priv *pledpriv =3D &padapter->ledpriv;
>=20
> -
> - pledpriv->LedControlHandler =3D LedControl871x;
>=20
> - InitLed871x(padapter, &pledpriv->SwLed0, LED_PIN_LED0);
>=20
> - InitLed871x(padapter, &pledpriv->SwLed1, LED_PIN_LED1);
>=20
> -}
> -
> -/* Description:
> - * DeInitialize all LED_819xUsb objects.
> - */
> -void r8712_DeInitSwLeds(struct _adapter *padapter)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> -
> - DeInitLed871x(&ledpriv->SwLed0);
>=20
> - DeInitLed871x(&ledpriv->SwLed1);
>=20
> -}
> -
> -/* Description:
> - * Implementation of LED blinking behavior.
> - * It toggle off LED and schedule corresponding timer if necessary.
> - */
> -static void SwLedBlink(struct LED_871x *pLed)
> -{
> - struct _adapter *padapter =3D pLed->padapter;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - u8 bStopBlinking =3D false;
> -
> - /* Change LED according to BlinkingLedState specified. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - SwLedOn(padapter, pLed);
> - else
> - SwLedOff(padapter, pLed);
> - /* Determine if we shall change LED state again. */
> - pLed->BlinkTimes--;
>=20
> - switch (pLed->CurrLedState) {
>=20
> - case LED_BLINK_NORMAL:
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - break;
> - case LED_BLINK_StartToBlink:
> - if (check_fwstate(pmlmepriv, _FW_LINKED) &&
> - (pmlmepriv->fw_state & WIFI_STATION_STATE))
>=20
> - bStopBlinking =3D true;
> - if (check_fwstate(pmlmepriv, _FW_LINKED) &&
> - ((pmlmepriv->fw_state & WIFI_ADHOC_STATE) ||
>=20
> - (pmlmepriv->fw_state & WIFI_ADHOC_MASTER_STATE)))
>=20
> - bStopBlinking =3D true;
> - else if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - break;
> - case LED_BLINK_WPS:
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - break;
> - default:
> - bStopBlinking =3D true;
> - break;
> - }
> - if (bStopBlinking) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED) &&
> - !pLed->bLedOn)
>=20
> - SwLedOn(padapter, pLed);
> - else if (check_fwstate(pmlmepriv, _FW_LINKED) && pLed->bLedOn)
>=20
> - SwLedOff(padapter, pLed);
> - pLed->BlinkTimes =3D 0;
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - } else {
> - /* Assign LED state to toggle. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> -
> - /* Schedule a timer to toggle LED state. */
> - switch (pLed->CurrLedState) {
>=20
> - case LED_BLINK_NORMAL:
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - break;
> - case LED_BLINK_SLOWLY:
> - case LED_BLINK_StartToBlink:
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
> - break;
> - case LED_BLINK_WPS:
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_LONG_INTERVAL));
> - break;
> - default:
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
> - break;
> - }
> - }
> -}
> -
> -static void SwLedBlink1(struct LED_871x *pLed)
> -{
> - struct _adapter *padapter =3D pLed->padapter;
>=20
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct eeprom_priv *peeprompriv =3D &padapter->eeprompriv;
>=20
> - struct LED_871x *pLed1 =3D &ledpriv->SwLed1;
>=20
> - u8 bStopBlinking =3D false;
> -
> - if (peeprompriv->CustomerID =3D=3D RT_CID_819x_CAMEO)
>=20
> - pLed =3D &ledpriv->SwLed1;
>=20
> - /* Change LED according to BlinkingLedState specified. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - SwLedOn(padapter, pLed);
> - else
> - SwLedOff(padapter, pLed);
> - if (peeprompriv->CustomerID =3D=3D RT_CID_DEFAULT) {
>=20
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - if (!pLed1->bSWLedCtrl) {
>=20
> - SwLedOn(padapter, pLed1);
> - pLed1->bSWLedCtrl =3D true;
>=20
> - } else if (!pLed1->bLedOn) {
>=20
> - SwLedOn(padapter, pLed1);
> - }
> - } else {
> - if (!pLed1->bSWLedCtrl) {
>=20
> - SwLedOff(padapter, pLed1);
> - pLed1->bSWLedCtrl =3D true;
>=20
> - } else if (pLed1->bLedOn) {
>=20
> - SwLedOff(padapter, pLed1);
> - }
> - }
> - }
> - switch (pLed->CurrLedState) {
>=20
> - case LED_BLINK_SLOWLY:
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - break;
> - case LED_BLINK_NORMAL:
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
> - break;
> - case LED_SCAN_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->bLedLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_NORMAL;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
> - } else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - }
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_TXRX_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->bLedLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_NORMAL;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
> - } else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - }
> - pLed->BlinkTimes =3D 0;
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_BLINK_WPS:
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - break;
> - case LED_BLINK_WPS_STOP: /* WPS success */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
> - bStopBlinking =3D false;
> - } else {
> - bStopBlinking =3D true;
> - }
> - if (bStopBlinking) {
> - pLed->bLedLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_NORMAL;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
> - }
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedBlink2(struct LED_871x *pLed)
> -{
> - struct _adapter *padapter =3D pLed->padapter;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - u8 bStopBlinking =3D false;
> -
> - /* Change LED according to BlinkingLedState specified. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - SwLedOn(padapter, pLed);
> - else
> - SwLedOff(padapter, pLed);
> - switch (pLed->CurrLedState) {
>=20
> - case LED_SCAN_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - SwLedOn(padapter, pLed);
> - } else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - SwLedOff(padapter, pLed);
> - }
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_TXRX_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - SwLedOn(padapter, pLed);
> - } else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - SwLedOff(padapter, pLed);
> - }
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedBlink3(struct LED_871x *pLed)
> -{
> - struct _adapter *padapter =3D pLed->padapter;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - u8 bStopBlinking =3D false;
> -
> - /* Change LED according to BlinkingLedState specified. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - SwLedOn(padapter, pLed);
> - else
> - if (pLed->CurrLedState !=3D LED_BLINK_WPS_STOP)
>=20
> - SwLedOff(padapter, pLed);
> - switch (pLed->CurrLedState) {
>=20
> - case LED_SCAN_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - if (!pLed->bLedOn)
>=20
> - SwLedOn(padapter, pLed);
> - } else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedOn)
>=20
> - SwLedOff(padapter, pLed);
> - }
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_TXRX_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - if (!pLed->bLedOn)
>=20
> - SwLedOn(padapter, pLed);
> - } else if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedOn)
>=20
> - SwLedOff(padapter, pLed);
> - }
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_BLINK_WPS:
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - break;
> - case LED_BLINK_WPS_STOP: /WPS success/
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
> - bStopBlinking =3D false;
> - } else {
> - bStopBlinking =3D true;
> - }
> - if (bStopBlinking) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - SwLedOn(padapter, pLed);
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedBlink4(struct LED_871x *pLed)
> -{
> - struct _adapter *padapter =3D pLed->padapter;
>=20
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct LED_871x *pLed1 =3D &ledpriv->SwLed1;
>=20
> - u8 bStopBlinking =3D false;
> -
> - /* Change LED according to BlinkingLedState specified. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - SwLedOn(padapter, pLed);
> - else
> - SwLedOff(padapter, pLed);
> - if (!pLed1->bLedWPSBlinkInProgress &&
>=20
> - pLed1->BlinkingLedState =3D=3D LED_UNKNOWN) {
>=20
> - pLed1->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - pLed1->CurrLedState =3D LED_STATE_OFF;
>=20
> - SwLedOff(padapter, pLed1);
> - }
> - switch (pLed->CurrLedState) {
>=20
> - case LED_BLINK_SLOWLY:
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - break;
> - case LED_BLINK_StartToBlink:
> - if (pLed->bLedOn) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
> - } else {
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - }
> - break;
> - case LED_SCAN_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_TXRX_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_BLINK_WPS:
> - if (pLed->bLedOn) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
> - } else {
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - }
> - break;
> - case LED_BLINK_WPS_STOP: /WPS authentication fail/
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - break;
> - case LED_BLINK_WPS_STOP_OVERLAP: /*WPS session overlap */
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0) {
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkTimes =3D 1;
>=20
> - else
> - bStopBlinking =3D true;
> - }
> - if (bStopBlinking) {
> - pLed->BlinkTimes =3D 10;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - }
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedBlink5(struct LED_871x *pLed)
> -{
> - struct _adapter *padapter =3D pLed->padapter;
>=20
> - u8 bStopBlinking =3D false;
> -
> - /* Change LED according to BlinkingLedState specified. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - SwLedOn(padapter, pLed);
> - else
> - SwLedOff(padapter, pLed);
> - switch (pLed->CurrLedState) {
>=20
> - case LED_SCAN_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - if (!pLed->bLedOn)
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_TXRX_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - if (!pLed->bLedOn)
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedBlink6(struct LED_871x *pLed)
> -{
> - struct _adapter *padapter =3D pLed->padapter;
>=20
> - u8 bStopBlinking =3D false;
> -
> - /* Change LED according to BlinkingLedState specified. */
> - if (pLed->BlinkingLedState =3D=3D LED_STATE_ON)
>=20
> - SwLedOn(padapter, pLed);
> - else
> - SwLedOff(padapter, pLed);
> - switch (pLed->CurrLedState) {
>=20
> - case LED_TXRX_BLINK:
> - pLed->BlinkTimes--;
>=20
> - if (pLed->BlinkTimes =3D=3D 0)
>=20
> - bStopBlinking =3D true;
> - if (bStopBlinking) {
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - if (!pLed->bLedOn)
>=20
> - SwLedOn(padapter, pLed);
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - } else {
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_BLINK_WPS:
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - break;
> -
> - default:
> - break;
> - }
> -}
> -
> -/* Description:
> - * Callback function of LED BlinkTimer,
> - * it just schedules to corresponding BlinkWorkItem.
> - */
> -static void BlinkTimerCallback(struct timer_list *t)
> -{
> - struct LED_871x pLed =3D from_timer(pLed, t, BlinkTimer);
> -
> - / This fixed the crash problem on Fedora 12 when trying to do the
> - * insmod;ifconfig up;rmmod commands.
> - */
> - if (pLed->padapter->surprise_removed || pLed->padapter->driver_stopped)
>=20
> - return;
> - schedule_work(&pLed->BlinkWorkItem);
>=20
> -}
> -
> -/* Description:
> - * Callback function of LED BlinkWorkItem.
> - * We dispatch actual LED blink action according to LedStrategy.
> - */
> -static void BlinkWorkItemCallback(struct work_struct *work)
> -{
> - struct LED_871x *pLed =3D container_of(work, struct LED_871x,
> - BlinkWorkItem);
> - struct led_priv *ledpriv =3D &pLed->padapter->ledpriv;
>=20
> -
> - switch (ledpriv->LedStrategy) {
>=20
> - case SW_LED_MODE0:
> - SwLedBlink(pLed);
> - break;
> - case SW_LED_MODE1:
> - SwLedBlink1(pLed);
> - break;
> - case SW_LED_MODE2:
> - SwLedBlink2(pLed);
> - break;
> - case SW_LED_MODE3:
> - SwLedBlink3(pLed);
> - break;
> - case SW_LED_MODE4:
> - SwLedBlink4(pLed);
> - break;
> - case SW_LED_MODE5:
> - SwLedBlink5(pLed);
> - break;
> - case SW_LED_MODE6:
> - SwLedBlink6(pLed);
> - break;
> - default:
> - SwLedBlink(pLed);
> - break;
> - }
> -}
> -
> -/*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> - * Default LED behavior.
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> - *
> - * Description:
> - * Implement each led action for SW_LED_MODE0.
> - * This is default strategy.
> - */
> -
> -static void SwLedControlMode1(struct _adapter *padapter,
> - enum LED_CTL_MODE LedAction)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct LED_871x *pLed =3D &ledpriv->SwLed0;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct sitesurvey_ctrl *psitesurveyctrl =3D &pmlmepriv->sitesurveyctrl;
>=20
> -
> - if (padapter->eeprompriv.CustomerID =3D=3D RT_CID_819x_CAMEO)
>=20
> - pLed =3D &ledpriv->SwLed1;
>=20
> - switch (LedAction) {
> - case LED_CTL_START_TO_LINK:
> - case LED_CTL_NO_LINK:
> - if (!pLed->bLedNoLinkBlinkInProgress) {
>=20
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_LINK:
> - if (!pLed->bLedLinkBlinkInProgress) {
>=20
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_NORMAL;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_LINK_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_SITE_SURVEY:
> - if (psitesurveyctrl->traffic_busy &&
>=20
> - check_fwstate(pmlmepriv, _FW_LINKED))
> - ; /* dummy branch */
> - else if (!pLed->bLedScanBlinkInProgress) {
>=20
> - if (IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedScanBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_SCAN_BLINK;
>=20
> - pLed->BlinkTimes =3D 24;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_TX:
> - case LED_CTL_RX:
> - if (!pLed->bLedBlinkInProgress) {
>=20
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedLinkBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_TXRX_BLINK;
>=20
> - pLed->BlinkTimes =3D 2;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> -
> - case LED_CTL_START_WPS: /*wait until xinpin finish */
> - case LED_CTL_START_WPS_BOTTON:
> - if (!pLed->bLedWPSBlinkInProgress) {
>=20
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_WPS;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_STOP_WPS:
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedWPSBlinkInProgress)
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - else
> - pLed->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_WPS_STOP;
>=20
> - if (pLed->bLedOn) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
> - } else {
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - break;
> - case LED_CTL_STOP_WPS_FAIL:
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - break;
> - case LED_CTL_POWER_OFF:
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedControlMode2(struct _adapter *padapter,
> - enum LED_CTL_MODE LedAction)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct LED_871x *pLed =3D &ledpriv->SwLed0;
>=20
> -
> - switch (LedAction) {
> - case LED_CTL_SITE_SURVEY:
> - if (pmlmepriv->sitesurveyctrl.traffic_busy)
>=20
> - ; /* dummy branch */
> - else if (!pLed->bLedScanBlinkInProgress) {
>=20
> - if (IS_LED_WPS_BLINKING(pLed))
> - return;
> -
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedScanBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_SCAN_BLINK;
>=20
> - pLed->BlinkTimes =3D 24;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> -
> - case LED_CTL_TX:
> - case LED_CTL_RX:
> - if (!pLed->bLedBlinkInProgress &&
>=20
> - check_fwstate(pmlmepriv, _FW_LINKED)) {
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - pLed->bLedBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_TXRX_BLINK;
>=20
> - pLed->BlinkTimes =3D 2;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> -
> - case LED_CTL_LINK:
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> -
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> -
> - case LED_CTL_START_WPS: /wait until xinpin finish/
> - case LED_CTL_START_WPS_BOTTON:
> - if (!pLed->bLedWPSBlinkInProgress) {
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - break;
> -
> - case LED_CTL_STOP_WPS:
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> -
> - case LED_CTL_STOP_WPS_FAIL:
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> -
> - case LED_CTL_START_TO_LINK:
> - case LED_CTL_NO_LINK:
> - if (!IS_LED_BLINKING(pLed)) {
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - break;
> - case LED_CTL_POWER_OFF:
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedControlMode3(struct _adapter *padapter,
> - enum LED_CTL_MODE LedAction)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct LED_871x *pLed =3D &ledpriv->SwLed0;
>=20
> -
> - switch (LedAction) {
> - case LED_CTL_SITE_SURVEY:
> - if (pmlmepriv->sitesurveyctrl.traffic_busy)
>=20
> - ; /* dummy branch */
> - else if (!pLed->bLedScanBlinkInProgress) {
>=20
> - if (IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedScanBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_SCAN_BLINK;
>=20
> - pLed->BlinkTimes =3D 24;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_TX:
> - case LED_CTL_RX:
> - if (!pLed->bLedBlinkInProgress &&
>=20
> - check_fwstate(pmlmepriv, _FW_LINKED)) {
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - pLed->bLedBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_TXRX_BLINK;
>=20
> - pLed->BlinkTimes =3D 2;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_LINK:
> - if (IS_LED_WPS_BLINKING(pLed))
> - return;
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> - case LED_CTL_START_WPS: /* wait until xinpin finish */
> - case LED_CTL_START_WPS_BOTTON:
> - if (!pLed->bLedWPSBlinkInProgress) {
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_WPS;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_STOP_WPS:
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - } else {
> - pLed->bLedWPSBlinkInProgress =3D true;
>=20
> - }
> - pLed->CurrLedState =3D LED_BLINK_WPS_STOP;
>=20
> - if (pLed->bLedOn) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_WPS_SUCCESS_INTERVAL_ALPHA));
> - } else {
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - break;
> - case LED_CTL_STOP_WPS_FAIL:
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> - case LED_CTL_START_TO_LINK:
> - case LED_CTL_NO_LINK:
> - if (!IS_LED_BLINKING(pLed)) {
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - break;
> - case LED_CTL_POWER_OFF:
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedControlMode4(struct _adapter *padapter,
> - enum LED_CTL_MODE LedAction)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct LED_871x *pLed =3D &ledpriv->SwLed0;
>=20
> - struct LED_871x *pLed1 =3D &ledpriv->SwLed1;
>=20
> -
> - switch (LedAction) {
> - case LED_CTL_START_TO_LINK:
> - if (pLed1->bLedWPSBlinkInProgress) {
>=20
> - pLed1->bLedWPSBlinkInProgress =3D false;
>=20
> - del_timer(&pLed1->BlinkTimer);
>=20
> - pLed1->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - pLed1->CurrLedState =3D LED_STATE_OFF;
>=20
> - if (pLed1->bLedOn)
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - if (!pLed->bLedStartToLinkBlinkInProgress) {
>=20
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedStartToLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_StartToBlink;
>=20
> - if (pLed->bLedOn) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
> - } else {
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - }
> - }
> - break;
> - case LED_CTL_LINK:
> - case LED_CTL_NO_LINK:
> - /LED1 settings/
> - if (LedAction =3D=3D LED_CTL_LINK) {
> - if (pLed1->bLedWPSBlinkInProgress) {
>=20
> - pLed1->bLedWPSBlinkInProgress =3D false;
>=20
> - del_timer(&pLed1->BlinkTimer);
>=20
> - pLed1->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - pLed1->CurrLedState =3D LED_STATE_OFF;
>=20
> - if (pLed1->bLedOn)
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - }
> - if (!pLed->bLedNoLinkBlinkInProgress) {
>=20
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_SITE_SURVEY:
> - if (pmlmepriv->sitesurveyctrl.traffic_busy &&
>=20
> - check_fwstate(pmlmepriv, _FW_LINKED))
> - ;
> - else if (!pLed->bLedScanBlinkInProgress) {
>=20
> - if (IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedScanBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_SCAN_BLINK;
>=20
> - pLed->BlinkTimes =3D 24;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_TX:
> - case LED_CTL_RX:
> - if (!pLed->bLedBlinkInProgress) {
>=20
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK ||
>=20
> - IS_LED_WPS_BLINKING(pLed))
> - return;
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_TXRX_BLINK;
>=20
> - pLed->BlinkTimes =3D 2;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_START_WPS: /wait until xinpin finish/
> - case LED_CTL_START_WPS_BOTTON:
> - if (pLed1->bLedWPSBlinkInProgress) {
>=20
> - pLed1->bLedWPSBlinkInProgress =3D false;
>=20
> - del_timer(&pLed1->BlinkTimer);
>=20
> - pLed1->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - pLed1->CurrLedState =3D LED_STATE_OFF;
>=20
> - if (pLed1->bLedOn)
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - }
> - if (!pLed->bLedWPSBlinkInProgress) {
>=20
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_WPS;
>=20
> - if (pLed->bLedOn) {
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SLOWLY_INTERVAL));
> - } else {
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - }
> - }
> - break;
> - case LED_CTL_STOP_WPS: /WPS connect success/
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - break;
> - case LED_CTL_STOP_WPS_FAIL: /WPS authentication fail/
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - /LED1 settings/
> - if (pLed1->bLedWPSBlinkInProgress)
>=20
> - del_timer(&pLed1->BlinkTimer);
>=20
> - else
> - pLed1->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed1->CurrLedState =3D LED_BLINK_WPS_STOP;
>=20
> - if (pLed1->bLedOn)
>=20
> - pLed1->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed1->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - break;
> - case LED_CTL_STOP_WPS_FAIL_OVERLAP: /WPS session overlap/
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedNoLinkBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_SLOWLY;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NO_LINK_INTERVAL_ALPHA));
> - /LED1 settings/
> - if (pLed1->bLedWPSBlinkInProgress)
>=20
> - del_timer(&pLed1->BlinkTimer);
>=20
> - else
> - pLed1->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed1->CurrLedState =3D LED_BLINK_WPS_STOP_OVERLAP;
>=20
> - pLed1->BlinkTimes =3D 10;
>=20
> - if (pLed1->bLedOn)
>=20
> - pLed1->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed1->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_NORMAL_INTERVAL));
> - break;
> - case LED_CTL_POWER_OFF:
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedNoLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedNoLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedScanBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedScanBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedStartToLinkBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedStartToLinkBlinkInProgress =3D false;
>=20
> - }
> - if (pLed1->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed1->BlinkTimer);
>=20
> - pLed1->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - pLed1->BlinkingLedState =3D LED_UNKNOWN;
>=20
> - SwLedOff(padapter, pLed);
> - SwLedOff(padapter, pLed1);
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedControlMode5(struct _adapter *padapter,
> - enum LED_CTL_MODE LedAction)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct LED_871x *pLed =3D &ledpriv->SwLed0;
>=20
> -
> - if (padapter->eeprompriv.CustomerID =3D=3D RT_CID_819x_CAMEO)
>=20
> - pLed =3D &ledpriv->SwLed1;
>=20
> -
> - switch (LedAction) {
> - case LED_CTL_POWER_ON:
> - case LED_CTL_NO_LINK:
> - case LED_CTL_LINK: /* solid blue */
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK)
>=20
> - return;
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> - case LED_CTL_SITE_SURVEY:
> - if (pmlmepriv->sitesurveyctrl.traffic_busy &&
>=20
> - check_fwstate(pmlmepriv, _FW_LINKED))
> - ; /* dummy branch */
> - else if (!pLed->bLedScanBlinkInProgress) {
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedScanBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_SCAN_BLINK;
>=20
> - pLed->BlinkTimes =3D 24;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_TX:
> - case LED_CTL_RX:
> - if (!pLed->bLedBlinkInProgress) {
>=20
> - if (pLed->CurrLedState =3D=3D LED_SCAN_BLINK)
>=20
> - return;
> - pLed->bLedBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_TXRX_BLINK;
>=20
> - pLed->BlinkTimes =3D 2;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_POWER_OFF:
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - SwLedOff(padapter, pLed);
> - break;
> - default:
> - break;
> - }
> -}
> -
> -static void SwLedControlMode6(struct _adapter *padapter,
> - enum LED_CTL_MODE LedAction)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct LED_871x *pLed =3D &ledpriv->SwLed0;
>=20
> -
> - switch (LedAction) {
> - case LED_CTL_POWER_ON:
> - case LED_CTL_NO_LINK:
> - case LED_CTL_LINK: /solid blue/
> - case LED_CTL_SITE_SURVEY:
> - if (IS_LED_WPS_BLINKING(pLed))
> - return;
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies + msecs_to_jiffies(0));
>=20
> - break;
> - case LED_CTL_TX:
> - case LED_CTL_RX:
> - if (!pLed->bLedBlinkInProgress &&
>=20
> - check_fwstate(pmlmepriv, _FW_LINKED)) {
> - if (IS_LED_WPS_BLINKING(pLed))
> - return;
> - pLed->bLedBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_TXRX_BLINK;
>=20
> - pLed->BlinkTimes =3D 2;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_FASTER_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_START_WPS: /wait until xinpin finish/
> - case LED_CTL_START_WPS_BOTTON:
> - if (!pLed->bLedWPSBlinkInProgress) {
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - pLed->bLedWPSBlinkInProgress =3D true;
>=20
> - pLed->CurrLedState =3D LED_BLINK_WPS;
>=20
> - if (pLed->bLedOn)
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - else
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer, jiffies +
>=20
> - msecs_to_jiffies(LED_BLINK_SCAN_INTERVAL_ALPHA));
> - }
> - break;
> - case LED_CTL_STOP_WPS_FAIL:
> - case LED_CTL_STOP_WPS:
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - pLed->CurrLedState =3D LED_STATE_ON;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_ON;
>=20
> - mod_timer(&pLed->BlinkTimer,
>=20
> - jiffies + msecs_to_jiffies(0));
> - break;
> - case LED_CTL_POWER_OFF:
> - pLed->CurrLedState =3D LED_STATE_OFF;
>=20
> - pLed->BlinkingLedState =3D LED_STATE_OFF;
>=20
> - if (pLed->bLedBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedBlinkInProgress =3D false;
>=20
> - }
> - if (pLed->bLedWPSBlinkInProgress) {
>=20
> - del_timer(&pLed->BlinkTimer);
>=20
> - pLed->bLedWPSBlinkInProgress =3D false;
>=20
> - }
> - SwLedOff(padapter, pLed);
> - break;
> - default:
> - break;
> - }
> -}
> -
> -/* Description:
> - * Dispatch LED action according to pHalData->LedStrategy.
>=20
> - */
> -void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedActi=
on)
> -{
> - struct led_priv *ledpriv =3D &padapter->ledpriv;
>=20
> -
> - if (!ledpriv->bRegUseLed)
>=20
> - return;
> - switch (ledpriv->LedStrategy) {
>=20
> - case SW_LED_MODE0:
> - break;
> - case SW_LED_MODE1:
> - SwLedControlMode1(padapter, LedAction);
> - break;
> - case SW_LED_MODE2:
> - SwLedControlMode2(padapter, LedAction);
> - break;
> - case SW_LED_MODE3:
> - SwLedControlMode3(padapter, LedAction);
> - break;
> - case SW_LED_MODE4:
> - SwLedControlMode4(padapter, LedAction);
> - break;
> - case SW_LED_MODE5:
> - SwLedControlMode5(padapter, LedAction);
> - break;
> - case SW_LED_MODE6:
> - SwLedControlMode6(padapter, LedAction);
> - break;
> - default:
> - break;
> - }
> -}
> -
> -void r8712_flush_led_works(struct _adapter *padapter)
> -{
> - struct led_priv *pledpriv =3D &padapter->ledpriv;
>=20
> -
> - flush_work(&pledpriv->SwLed0.BlinkWorkItem);
>=20
> - flush_work(&pledpriv->SwLed1.BlinkWorkItem);
>=20
> -}
> diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h b/driver=
s/staging/rtl8712/rtl8712_macsetting_bitdef.h
> deleted file mode 100644
> index 46d758d3f3a4..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_macsetting_bitdef.h
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_MACSETTING_BITDEF_H
> -#define RTL8712_MACSETTING_BITDEF_H
> -
> -/MACID/
> -/BSSID/
> -
> -/HWVID/
> -#define _HWVID_MSK 0x0F
> -
> -/MAR/
> -/MBIDCANCONTENT/
> -
> -/MBIDCANCFG/
> -#define _POOLING BIT(31)
> -#define _WRITE_EN BIT(16)
> -#define _CAM_ADDR_MSK 0x001F
> -#define _CAM_ADDR_SHT 0
> -
> -/BUILDTIME/
> -#define _BUILDTIME_MSK 0x3FFFFFFF
> -
> -/BUILDUSER/
> -
> -#endif / RTL8712_MACSETTING_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h b/driver=
s/staging/rtl8712/rtl8712_macsetting_regdef.h
> deleted file mode 100644
> index 64740d99c252..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_macsetting_regdef.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_MACSETTING_REGDEF_H
> -#define RTL8712_MACSETTING_REGDEF_H
> -
> -#define MACID (RTL8712_MACIDSETTING_ + 0x0000)
> -#define BSSIDR (RTL8712_MACIDSETTING_ + 0x0008)
> -#define HWVID (RTL8712_MACIDSETTING_ + 0x000E)
> -#define MAR (RTL8712_MACIDSETTING_ + 0x0010)
> -#define MBIDCANCONTENT (RTL8712_MACIDSETTING_ + 0x0018)
> -#define MBIDCANCFG (RTL8712_MACIDSETTING_ + 0x0020)
> -#define BUILDTIME (RTL8712_MACIDSETTING_ + 0x0024)
> -#define BUILDUSER (RTL8712_MACIDSETTING_ + 0x0028)
> -
> -#endif /RTL8712_MACSETTING_REGDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h b/drivers=
/staging/rtl8712/rtl8712_powersave_bitdef.h
> deleted file mode 100644
> index 53e0d6b440f3..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_powersave_bitdef.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_POWERSAVE_BITDEF_H
> -#define RTL8712_POWERSAVE_BITDEF_H
> -
> -/WOWCTRL/
> -#define _UWF BIT(3)
> -#define _MAGIC BIT(2)
> -#define _WOW_EN BIT(1)
> -#define _PMEN BIT(0)
> -
> -/PSSTATUS/
> -#define _PSSTATUS_SEL_MSK 0x0F
> -
> -/PSSWITCH/
> -#define _PSSWITCH_ACT BIT(7)
> -#define _PSSWITCH_SEL_MSK 0x0F
> -#define _PSSWITCH_SEL_SHT 0
> -
> -/LPNAV_CTRL/
> -#define _LPNAV_EN BIT(31)
> -#define _LPNAV_EARLY_MSK 0x7FFF0000
> -#define _LPNAV_EARLY_SHT 16
> -#define _LPNAV_TH_MSK 0x0000FFFF
> -#define _LPNAV_TH_SHT 0
> -
> -/RPWM/
> -/CPWM/
> -#define _TOGGLING BIT(7)
> -#define _WWLAN BIT(3)
> -#define _RPS_ST BIT(2)
> -#define _WLAN_TRX BIT(1)
> -#define _SYS_CLK BIT(0)
> -
> -#endif / RTL8712_POWERSAVE_BITDEF_H/
> diff --git a/drivers/staging/rtl8712/rtl8712_powersave_regdef.h b/drivers=
/staging/rtl8712/rtl8712_powersave_regdef.h
> deleted file mode 100644
> index 1bcfde4b1c11..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_powersave_regdef.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_POWERSAVE_REGDEF_H
> -#define RTL8712_POWERSAVE_REGDEF_H
> -
> -#define WOWCTRL (RTL8712_POWERSAVE_ + 0x00)
> -#define PSSTATUS (RTL8712_POWERSAVE_ + 0x01)
> -#define PSSWITCH (RTL8712_POWERSAVE_ + 0x02)
> -#define MIMOPS_WAITPERIOD (RTL8712_POWERSAVE_ + 0x03)
> -#define LPNAV_CTRL (RTL8712_POWERSAVE_ + 0x04)
> -#define WFM0 (RTL8712_POWERSAVE_ + 0x10)
> -#define WFM1 (RTL8712_POWERSAVE_ + 0x20)
> -#define WFM2 (RTL8712_POWERSAVE_ + 0x30)
> -#define WFM3 (RTL8712_POWERSAVE_ + 0x40)
> -#define WFM4 (RTL8712_POWERSAVE_ + 0x50)
> -#define WFM5 (RTL8712_POWERSAVE_ + 0x60)
> -#define WFCRC (RTL8712_POWERSAVE_ + 0x70)
> -#define RPWM (RTL8712_POWERSAVE_ + 0x7C)
> -#define CPWM (RTL8712_POWERSAVE_ + 0x7D)
> -
> -#endif / RTL8712_POWERSAVE_REGDEF_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h b/drivers/=
staging/rtl8712/rtl8712_ratectrl_bitdef.h
> deleted file mode 100644
> index 1de51c48f9c1..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_ratectrl_bitdef.h
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_RATECTRL_BITDEF_H
> -#define RTL8712_RATECTRL_BITDEF_H
> -
> -/INIRTSMCS_SEL/
> -#define _INIRTSMCS_SEL_MSK 0x3F
> -
> -/ RRSR/
> -#define _RRSR_SHORT BIT(23)
> -#define _RRSR_RSC_MSK 0x600000
> -#define _RRSR_RSC_SHT 21
> -#define _RRSR_BITMAP_MSK 0x0FFFFF
> -#define _RRSR_BITMAP_SHT 0
> -
> -/ AGGLEN_LMT_H/
> -#define _AGGLMT_MCS32_MSK 0xF0
> -#define _AGGLMT_MCS32_SHT 4
> -#define _AGGLMT_MCS15_SGI_MSK 0x0F
> -#define _AGGLMT_MCS15_SGI_SHT 0
> -
> -/ DARFRC/
> -/ RARFRC/
> -/ MCS_TXAGC/
> -/ CCK_TXAGC/
> -#define _CCK_MSK 0xFF00
> -#define _CCK_SHT 8
> -#define _BARKER_MSK 0x00FF
> -#define _BARKER_SHT 0
> -
> -#endif / RTL8712_RATECTRL_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h b/drivers/=
staging/rtl8712/rtl8712_ratectrl_regdef.h
> deleted file mode 100644
> index 9ed5653f3f7f..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_ratectrl_regdef.h
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_RATECTRL_REGDEF_H
> -#define RTL8712_RATECTRL_REGDEF_H
> -
> -#define INIMCS_SEL (RTL8712_RATECTRL_ + 0x00)
> -#define INIRTSMCS_SEL (RTL8712_RATECTRL_ + 0x20)
> -#define RRSR (RTL8712_RATECTRL_ + 0x21)
> -#define ARFR0 (RTL8712_RATECTRL_ + 0x24)
> -#define ARFR1 (RTL8712_RATECTRL_ + 0x28)
> -#define ARFR2 (RTL8712_RATECTRL_ + 0x2C)
> -#define ARFR3 (RTL8712_RATECTRL_ + 0x30)
> -#define ARFR4 (RTL8712_RATECTRL_ + 0x34)
> -#define ARFR5 (RTL8712_RATECTRL_ + 0x38)
> -#define ARFR6 (RTL8712_RATECTRL_ + 0x3C)
> -#define ARFR7 (RTL8712_RATECTRL_ + 0x40)
> -#define AGGLEN_LMT_H (RTL8712_RATECTRL_ + 0x47)
> -#define AGGLEN_LMT_L (RTL8712_RATECTRL_ + 0x48)
> -#define DARFRC (RTL8712_RATECTRL_ + 0x50)
> -#define RARFRC (RTL8712_RATECTRL_ + 0x58)
> -#define MCS_TXAGC0 (RTL8712_RATECTRL_ + 0x60)
> -#define MCS_TXAGC1 (RTL8712_RATECTRL_ + 0x61)
> -#define MCS_TXAGC2 (RTL8712_RATECTRL_ + 0x62)
> -#define MCS_TXAGC3 (RTL8712_RATECTRL_ + 0x63)
> -#define MCS_TXAGC4 (RTL8712_RATECTRL_ + 0x64)
> -#define MCS_TXAGC5 (RTL8712_RATECTRL_ + 0x65)
> -#define MCS_TXAGC6 (RTL8712_RATECTRL_ + 0x66)
> -#define MCS_TXAGC7 (RTL8712_RATECTRL_ + 0x67)
> -#define CCK_TXAGC (RTL8712_RATECTRL_ + 0x68)
> -
> -#endif /RTL8712_RATECTRL_REGDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl=
8712/rtl8712_recv.c
> deleted file mode 100644
> index ab344d676bb9..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ /dev/null
> @@ -1,1075 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**
> - * rtl8712_recv.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL8712_RECV_C
> -
> -#include <linux/if_ether.h>
>=20
> -#include <linux/ip.h>
>=20
> -#include <net/cfg80211.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "recv_osdep.h"
> -#include "mlme_osdep.h"
> -#include "ethernet.h"
> -#include "usb_ops.h"
> -#include "wifi.h"
> -
> -static void recv_tasklet(struct tasklet_struct *t);
> -
> -int r8712_init_recv_priv(struct recv_priv *precvpriv,
> - struct _adapter *padapter)
> -{
> - int i;
> - struct recv_buf *precvbuf;
> - addr_t tmpaddr =3D 0;
> - int alignment =3D 0;
> - struct sk_buff *pskb =3D NULL;
> -
> - /init recv_buf/
> - _init_queue(&precvpriv->free_recv_buf_queue);
>=20
> - precvpriv->pallocated_recv_buf =3D
>=20
> - kzalloc(NR_RECVBUFF * sizeof(struct recv_buf) + 4, GFP_ATOMIC);
> - if (!precvpriv->pallocated_recv_buf)
>=20
> - return -ENOMEM;
> - precvpriv->precv_buf =3D precvpriv->pallocated_recv_buf + 4 -
>=20
> - ((addr_t)(precvpriv->pallocated_recv_buf) & 3);
>=20
> - precvbuf =3D (struct recv_buf *)precvpriv->precv_buf;
>=20
> - for (i =3D 0; i < NR_RECVBUFF; i++) {
> - INIT_LIST_HEAD(&precvbuf->list);
>=20
> - spin_lock_init(&precvbuf->recvbuf_lock);
>=20
> - if (r8712_os_recvbuf_resource_alloc(padapter, precvbuf))
> - break;
> - precvbuf->ref_cnt =3D 0;
>=20
> - precvbuf->adapter =3D padapter;
>=20
> - list_add_tail(&precvbuf->list,
>=20
> - &precvpriv->free_recv_buf_queue.queue);
>=20
> - precvbuf++;
> - }
> - precvpriv->free_recv_buf_queue_cnt =3D NR_RECVBUFF;
>=20
> - tasklet_setup(&precvpriv->recv_tasklet, recv_tasklet);
>=20
> - skb_queue_head_init(&precvpriv->rx_skb_queue);
>=20
> -
> - skb_queue_head_init(&precvpriv->free_recv_skb_queue);
>=20
> - for (i =3D 0; i < NR_PREALLOC_RECV_SKB; i++) {
> - pskb =3D netdev_alloc_skb(padapter->pnetdev, MAX_RECVBUF_SZ +
>=20
> - RECVBUFF_ALIGN_SZ);
> - if (pskb) {
> - tmpaddr =3D (addr_t)pskb->data;
>=20
> - alignment =3D tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
> - skb_reserve(pskb, (RECVBUFF_ALIGN_SZ - alignment));
> - skb_queue_tail(&precvpriv->free_recv_skb_queue, pskb);
>=20
> - }
> - pskb =3D NULL;
> - }
> - return 0;
> -}
> -
> -void r8712_free_recv_priv(struct recv_priv *precvpriv)
> -{
> - int i;
> - struct recv_buf *precvbuf;
> - struct _adapter *padapter =3D precvpriv->adapter;
>=20
> -
> - precvbuf =3D (struct recv_buf *)precvpriv->precv_buf;
>=20
> - for (i =3D 0; i < NR_RECVBUFF; i++) {
> - r8712_os_recvbuf_resource_free(padapter, precvbuf);
> - precvbuf++;
> - }
> - kfree(precvpriv->pallocated_recv_buf);
>=20
> - skb_queue_purge(&precvpriv->rx_skb_queue);
>=20
> - if (skb_queue_len(&precvpriv->rx_skb_queue))
>=20
> - netdev_warn(padapter->pnetdev, "r8712u: rx_skb_queue not empty\n");
>=20
> - skb_queue_purge(&precvpriv->free_recv_skb_queue);
>=20
> - if (skb_queue_len(&precvpriv->free_recv_skb_queue))
>=20
> - netdev_warn(padapter->pnetdev, "r8712u: free_recv_skb_queue not empty %=
d\n",
>=20
> - skb_queue_len(&precvpriv->free_recv_skb_queue));
>=20
> -}
> -
> -void r8712_init_recvbuf(struct _adapter *padapter, struct recv_buf *prec=
vbuf)
> -{
> - precvbuf->transfer_len =3D 0;
>=20
> - precvbuf->len =3D 0;
>=20
> - precvbuf->ref_cnt =3D 0;
>=20
> - if (precvbuf->pbuf) {
>=20
> - precvbuf->pdata =3D precvbuf->pbuf;
>=20
> - precvbuf->phead =3D precvbuf->pbuf;
>=20
> - precvbuf->ptail =3D precvbuf->pbuf;
>=20
> - precvbuf->pend =3D precvbuf->pdata + MAX_RECVBUF_SZ;
>=20
> - }
> -}
> -
> -void r8712_free_recvframe(union recv_frame *precvframe,
> - struct __queue *pfree_recv_queue)
> -{
> - unsigned long irqL;
> - struct _adapter *padapter =3D precvframe->u.hdr.adapter;
>=20
> - struct recv_priv *precvpriv =3D &padapter->recvpriv;
>=20
> -
> - if (precvframe->u.hdr.pkt) {
>=20
> - dev_kfree_skb_any(precvframe->u.hdr.pkt);/free skb by driver/
>=20
> - precvframe->u.hdr.pkt =3D NULL;
>=20
> - }
> - spin_lock_irqsave(&pfree_recv_queue->lock, irqL);
>=20
> - list_del_init(&precvframe->u.hdr.list);
>=20
> - list_add_tail(&precvframe->u.hdr.list, &pfree_recv_queue->queue);
>=20
> - if (padapter) {
> - if (pfree_recv_queue =3D=3D &precvpriv->free_recv_queue)
>=20
> - precvpriv->free_recvframe_cnt++;
>=20
> - }
> - spin_unlock_irqrestore(&pfree_recv_queue->lock, irqL);
>=20
> -}
> -
> -static void update_recvframe_attrib_from_recvstat(struct rx_pkt_attrib *=
pattrib,
> - struct recv_stat *prxstat)
> -{
> - /*TODO:
> - * Offset 0
> - */
> - pattrib->bdecrypted =3D (le32_to_cpu(prxstat->rxdw0) & BIT(27)) =3D=3D =
0;
>=20
> - pattrib->crc_err =3D (le32_to_cpu(prxstat->rxdw0) & BIT(14)) !=3D 0;
>=20
> - /Offset 4/
> - /Offset 8/
> - /Offset 12/
> - if (le32_to_cpu(prxstat->rxdw3) & BIT(13)) {
>=20
> - pattrib->tcpchk_valid =3D 1; /* valid */
>=20
> - if (le32_to_cpu(prxstat->rxdw3) & BIT(11))
>=20
> - pattrib->tcp_chkrpt =3D 1; /* correct */
>=20
> - else
> - pattrib->tcp_chkrpt =3D 0; /* incorrect */
>=20
> - if (le32_to_cpu(prxstat->rxdw3) & BIT(12))
>=20
> - pattrib->ip_chkrpt =3D 1; /* correct */
>=20
> - else
> - pattrib->ip_chkrpt =3D 0; /* incorrect */
>=20
> - } else {
> - pattrib->tcpchk_valid =3D 0; /* invalid */
>=20
> - }
> - pattrib->mcs_rate =3D (u8)((le32_to_cpu(prxstat->rxdw3)) & 0x3f);
>=20
> - pattrib->htc =3D (u8)((le32_to_cpu(prxstat->rxdw3) >> 14) & 0x1);
>=20
> - /Offset 16/
> - /Offset 20/
> - /phy_info/
> -}
> -
> -/perform defrag/
> -static union recv_frame *recvframe_defrag(struct _adapter *adapter,
> - struct __queue *defrag_q)
> -{
> - struct list_head *plist, *phead;
> - u8 wlanhdr_offset;
> - u8 curfragnum;
> - struct recv_frame_hdr *pfhdr, *pnfhdr;
> - union recv_frame *prframe, *pnextrframe;
> - struct __queue *pfree_recv_queue;
> -
> - pfree_recv_queue =3D &adapter->recvpriv.free_recv_queue;
>=20
> - phead =3D &defrag_q->queue;
>=20
> - plist =3D phead->next;
>=20
> - prframe =3D container_of(plist, union recv_frame, u.list);
> - list_del_init(&prframe->u.list);
>=20
> - pfhdr =3D &prframe->u.hdr;
>=20
> - curfragnum =3D 0;
> - if (curfragnum !=3D pfhdr->attrib.frag_num) {
>=20
> - /*the first fragment number must be 0
> - *free the whole queue
> - */
> - r8712_free_recvframe(prframe, pfree_recv_queue);
> - r8712_free_recvframe_queue(defrag_q, pfree_recv_queue);
> - return NULL;
> - }
> - curfragnum++;
> - plist =3D &defrag_q->queue;
>=20
> - plist =3D plist->next;
>=20
> - while (!end_of_queue_search(phead, plist)) {
> - pnextrframe =3D container_of(plist, union recv_frame, u.list);
> - pnfhdr =3D &pnextrframe->u.hdr;
>=20
> - /*check the fragment sequence (2nd ~n fragment frame) */
> - if (curfragnum !=3D pnfhdr->attrib.frag_num) {
>=20
> - /* the fragment number must increase (after decache)
> - * release the defrag_q & prframe
> - /
> - r8712_free_recvframe(prframe, pfree_recv_queue);
> - r8712_free_recvframe_queue(defrag_q, pfree_recv_queue);
> - return NULL;
> - }
> - curfragnum++;
> - / copy the 2nd~n fragment frame's payload to the first fragment
> - * get the 2nd~last fragment frame's payload
> - */
> - wlanhdr_offset =3D pnfhdr->attrib.hdrlen + pnfhdr->attrib.iv_len;
>=20
> - recvframe_pull(pnextrframe, wlanhdr_offset);
> - /* append to first fragment frame's tail (if privacy frame,
> - * pull the ICV)
> - */
> - recvframe_pull_tail(prframe, pfhdr->attrib.icv_len);
>=20
> - memcpy(pfhdr->rx_tail, pnfhdr->rx_data, pnfhdr->len);
>=20
> - recvframe_put(prframe, pnfhdr->len);
>=20
> - pfhdr->attrib.icv_len =3D pnfhdr->attrib.icv_len;
>=20
> - plist =3D plist->next;
>=20
> - }
> - /* free the defrag_q queue and return the prframe /
> - r8712_free_recvframe_queue(defrag_q, pfree_recv_queue);
> - return prframe;
> -}
> -
> -/ check if need to defrag, if needed queue the frame to defrag_q */
> -union recv_frame *r8712_recvframe_chk_defrag(struct _adapter *padapter,
> - union recv_frame *precv_frame)
> -{
> - u8 ismfrag;
> - u8 fragnum;
> - u8 *psta_addr;
> - struct recv_frame_hdr *pfhdr;
> - struct sta_info *psta;
> - struct sta_priv *pstapriv;
> - struct list_head *phead;
> - union recv_frame *prtnframe =3D NULL;
> - struct __queue *pfree_recv_queue, *pdefrag_q;
> -
> - pstapriv =3D &padapter->stapriv;
>=20
> - pfhdr =3D &precv_frame->u.hdr;
>=20
> - pfree_recv_queue =3D &padapter->recvpriv.free_recv_queue;
>=20
> - /* need to define struct of wlan header frame ctrl */
> - ismfrag =3D pfhdr->attrib.mfrag;
>=20
> - fragnum =3D pfhdr->attrib.frag_num;
>=20
> - psta_addr =3D pfhdr->attrib.ta;
>=20
> - psta =3D r8712_get_stainfo(pstapriv, psta_addr);
> - if (!psta)
> - pdefrag_q =3D NULL;
> - else
> - pdefrag_q =3D &psta->sta_recvpriv.defrag_q;
>=20
> -
> - if ((ismfrag =3D=3D 0) && (fragnum =3D=3D 0))
> - prtnframe =3D precv_frame;/isn't a fragment frame/
> - if (ismfrag =3D=3D 1) {
> - /* 0~(n-1) fragment frame
> - * enqueue to defraf_g
> - */
> - if (pdefrag_q) {
> - if (fragnum =3D=3D 0) {
> - /the first fragment/
> - if (!list_empty(&pdefrag_q->queue)) {
>=20
> - /*free current defrag_q /
> - r8712_free_recvframe_queue(pdefrag_q, pfree_recv_queue);
> - }
> - }
> - / Then enqueue the 0~(n-1) fragment to the defrag_q */
> - phead =3D &pdefrag_q->queue;
>=20
> - list_add_tail(&pfhdr->list, phead);
>=20
> - prtnframe =3D NULL;
> - } else {
> - /* can't find this ta's defrag_queue, so free this
> - * recv_frame
> - /
> - r8712_free_recvframe(precv_frame, pfree_recv_queue);
> - prtnframe =3D NULL;
> - }
> - }
> - if ((ismfrag =3D=3D 0) && (fragnum !=3D 0)) {
> - / the last fragment frame
> - * enqueue the last fragment
> - */
> - if (pdefrag_q) {
> - phead =3D &pdefrag_q->queue;
>=20
> - list_add_tail(&pfhdr->list, phead);
>=20
> - /call recvframe_defrag to defrag/
> - precv_frame =3D recvframe_defrag(padapter, pdefrag_q);
> - prtnframe =3D precv_frame;
> - } else {
> - /* can't find this ta's defrag_queue, so free this
> - * recv_frame
> - */
> - r8712_free_recvframe(precv_frame, pfree_recv_queue);
> - prtnframe =3D NULL;
> - }
> - }
> - if (prtnframe && (prtnframe->u.hdr.attrib.privacy)) {
>=20
> - /* after defrag we must check tkip mic code */
> - if (r8712_recvframe_chkmic(padapter, prtnframe) =3D=3D _FAIL) {
> - r8712_free_recvframe(prtnframe, pfree_recv_queue);
> - prtnframe =3D NULL;
> - }
> - }
> - return prtnframe;
> -}
> -
> -static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *p=
rframe)
> -{
> - int a_len, padding_len;
> - u16 eth_type, nSubframe_Length;
> - u8 nr_subframes, i;
> - unsigned char *pdata;
> - struct rx_pkt_attrib *pattrib;
> - _pkt *sub_skb, *subframes[MAX_SUBFRAME_COUNT];
> - struct recv_priv *precvpriv =3D &padapter->recvpriv;
>=20
> - struct __queue *pfree_recv_queue =3D &precvpriv->free_recv_queue;
>=20
> -
> - nr_subframes =3D 0;
> - pattrib =3D &prframe->u.hdr.attrib;
>=20
> - recvframe_pull(prframe, prframe->u.hdr.attrib.hdrlen);
>=20
> - if (prframe->u.hdr.attrib.iv_len > 0)
>=20
> - recvframe_pull(prframe, prframe->u.hdr.attrib.iv_len);
>=20
> - a_len =3D prframe->u.hdr.len;
>=20
> - pdata =3D prframe->u.hdr.rx_data;
>=20
> - while (a_len > ETH_HLEN) {
>=20
> - /* Offset 12 denote 2 mac address */
> - nSubframe_Length =3D ((u16 )(pdata + 12));
> - /=3D=3Dm=3D=3D>change the length order/
>=20
> - nSubframe_Length =3D (nSubframe_Length >> 8) +
>=20
> - (nSubframe_Length << 8);
> - if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
> - netdev_warn(padapter->pnetdev, "r8712u: nRemain_Length is %d and nSubfr=
ame_Length is: %d\n",
>=20
> - a_len, nSubframe_Length);
> - goto exit;
> - }
> - /* move the data point to data content /
> - pdata +=3D ETH_HLEN;
> - a_len -=3D ETH_HLEN;
> - / Allocate new skb for releasing to upper layer */
> - sub_skb =3D dev_alloc_skb(nSubframe_Length + 12);
> - if (!sub_skb)
> - break;
> - skb_reserve(sub_skb, 12);
> - skb_put_data(sub_skb, pdata, nSubframe_Length);
> - subframes[nr_subframes++] =3D sub_skb;
> - if (nr_subframes >=3D MAX_SUBFRAME_COUNT) {
>=20
> - netdev_warn(padapter->pnetdev, "r8712u: ParseSubframe(): Too many Subfr=
ames! Packets dropped!\n");
>=20
> - break;
> - }
> - pdata +=3D nSubframe_Length;
> - a_len -=3D nSubframe_Length;
> - if (a_len !=3D 0) {
> - padding_len =3D 4 - ((nSubframe_Length + ETH_HLEN) & 3);
> - if (padding_len =3D=3D 4)
> - padding_len =3D 0;
> - if (a_len < padding_len)
> - goto exit;
> - pdata +=3D padding_len;
> - a_len -=3D padding_len;
> - }
> - }
> - for (i =3D 0; i < nr_subframes; i++) {
> - sub_skb =3D subframes[i];
> - /* convert hdr + possible LLC headers into Ethernet header */
> - eth_type =3D (sub_skb->data[6] << 8) | sub_skb->data[7];
>=20
> - if (sub_skb->len >=3D 8 &&
>=20
> - ((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
>=20
> - eth_type !=3D ETH_P_AARP && eth_type !=3D ETH_P_IPX) ||
> - !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
>=20
> - /* remove RFC1042 or Bridge-Tunnel encapsulation and
> - * replace EtherType
> - */
> - skb_pull(sub_skb, SNAP_SIZE);
> - memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src,
>=20
> - ETH_ALEN);
> - memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst,
>=20
> - ETH_ALEN);
> - } else {
> - __be16 len;
> - /* Leave Ethernet header part of hdr and full payload */
> - len =3D htons(sub_skb->len);
>=20
> - memcpy(skb_push(sub_skb, 2), &len, 2);
> - memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src,
>=20
> - ETH_ALEN);
> - memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst,
>=20
> - ETH_ALEN);
> - }
> - /* Indicate the packets to upper layer */
> - if (sub_skb) {
> - sub_skb->protocol =3D
>=20
> - eth_type_trans(sub_skb, padapter->pnetdev);
>=20
> - sub_skb->dev =3D padapter->pnetdev;
>=20
> - if ((pattrib->tcpchk_valid =3D=3D 1) &&
>=20
> - (pattrib->tcp_chkrpt =3D=3D 1)) {
>=20
> - sub_skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>=20
> - } else {
> - sub_skb->ip_summed =3D CHECKSUM_NONE;
>=20
> - }
> - netif_rx(sub_skb);
> - }
> - }
> -exit:
> - prframe->u.hdr.len =3D 0;
>=20
> - r8712_free_recvframe(prframe, pfree_recv_queue);
> -}
> -
> -void r8712_rxcmd_event_hdl(struct _adapter *padapter, void *prxcmdbuf)
> -{
> - __le32 voffset;
> - u8 *poffset;
> - u16 cmd_len, drvinfo_sz;
> - struct recv_stat *prxstat;
> -
> - poffset =3D prxcmdbuf;
> - voffset =3D *(__le32 *)poffset;
> - prxstat =3D prxcmdbuf;
> - drvinfo_sz =3D (le32_to_cpu(prxstat->rxdw0) & 0x000f0000) >> 16;
>=20
> - drvinfo_sz <<=3D 3;
> - poffset +=3D RXDESC_SIZE + drvinfo_sz;
> - do {
> - voffset =3D *(__le32 *)poffset;
> - cmd_len =3D (u16)(le32_to_cpu(voffset) & 0xffff);
> - r8712_event_handle(padapter, (__le32 *)poffset);
> - poffset +=3D (cmd_len + 8);/8 bytes alignment/
> - } while (le32_to_cpu(voffset) & BIT(31));
> -}
> -
> -static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl,
> - u16 seq_num)
> -{
> - u8 wsize =3D preorder_ctrl->wsize_b;
>=20
> - u16 wend =3D (preorder_ctrl->indicate_seq + wsize - 1) % 4096;
>=20
> -
> - /* Rx Reorder initialize condition.*/
> - if (preorder_ctrl->indicate_seq =3D=3D 0xffff)
>=20
> - preorder_ctrl->indicate_seq =3D seq_num;
>=20
> - /* Drop out the packet which SeqNum is smaller than WinStart */
> - if (SN_LESS(seq_num, preorder_ctrl->indicate_seq))
>=20
> - return false;
> - /*
> - * Sliding window manipulation. Conditions includes:
> - * 1. Incoming SeqNum is equal to WinStart =3D>Window shift 1
>=20
> - * 2. Incoming SeqNum is larger than the WinEnd =3D> Window shift N
>=20
> - */
> - if (SN_EQUAL(seq_num, preorder_ctrl->indicate_seq))
>=20
> - preorder_ctrl->indicate_seq =3D (preorder_ctrl->indicate_seq +
>=20
> - 1) % 4096;
> - else if (SN_LESS(wend, seq_num)) {
> - if (seq_num >=3D (wsize - 1))
>=20
> - preorder_ctrl->indicate_seq =3D seq_num + 1 - wsize;
>=20
> - else
> - preorder_ctrl->indicate_seq =3D 4095 - (wsize -
>=20
> - (seq_num + 1)) + 1;
> - }
> - return true;
> -}
> -
> -static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_=
ctrl,
> - union recv_frame *prframe)
> -{
> - struct list_head *phead, *plist;
> - union recv_frame *pnextrframe;
> - struct rx_pkt_attrib *pnextattrib;
> - struct __queue *ppending_recvframe_queue =3D
> - &preorder_ctrl->pending_recvframe_queue;
>=20
> - struct rx_pkt_attrib *pattrib =3D &prframe->u.hdr.attrib;
>=20
> -
> - phead =3D &ppending_recvframe_queue->queue;
>=20
> - plist =3D phead->next;
>=20
> - while (!end_of_queue_search(phead, plist)) {
> - pnextrframe =3D container_of(plist, union recv_frame, u.list);
> - pnextattrib =3D &pnextrframe->u.hdr.attrib;
>=20
> -
> - if (SN_EQUAL(pnextattrib->seq_num, pattrib->seq_num))
>=20
> - return false;
> -
> - if (SN_LESS(pnextattrib->seq_num, pattrib->seq_num))
>=20
> - plist =3D plist->next;
>=20
> - else
> - break;
> - }
> - list_del_init(&prframe->u.hdr.list);
>=20
> - list_add_tail(&prframe->u.hdr.list, plist);
>=20
> - return true;
> -}
> -
> -int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
> - struct recv_reorder_ctrl *preorder_ctrl,
> - int bforced)
> -{
> - struct list_head *phead, *plist;
> - union recv_frame *prframe;
> - struct rx_pkt_attrib *pattrib;
> - int bPktInBuf =3D false;
> - struct __queue *ppending_recvframe_queue =3D
> - &preorder_ctrl->pending_recvframe_queue;
>=20
> -
> - phead =3D &ppending_recvframe_queue->queue;
>=20
> - plist =3D phead->next;
>=20
> - /* Handling some condition for forced indicate case.*/
> - if (bforced) {
> - if (list_empty(phead))
> - return true;
> -
> - prframe =3D container_of(plist, union recv_frame, u.list);
> - pattrib =3D &prframe->u.hdr.attrib;
>=20
> - preorder_ctrl->indicate_seq =3D pattrib->seq_num;
>=20
> - }
> - /* Prepare indication list and indication.
> - * Check if there is any packet need indicate.
> - */
> - while (!list_empty(phead)) {
> - prframe =3D container_of(plist, union recv_frame, u.list);
> - pattrib =3D &prframe->u.hdr.attrib;
>=20
> - if (!SN_LESS(preorder_ctrl->indicate_seq, pattrib->seq_num)) {
>=20
> - plist =3D plist->next;
>=20
> - list_del_init(&prframe->u.hdr.list);
>=20
> - if (SN_EQUAL(preorder_ctrl->indicate_seq,
>=20
> - pattrib->seq_num))
>=20
> - preorder_ctrl->indicate_seq =3D
>=20
> - (preorder_ctrl->indicate_seq + 1) % 4096;
>=20
> - /indicate this recv_frame/
> - if (!pattrib->amsdu) {
>=20
> - if (!padapter->driver_stopped &&
>=20
> - !padapter->surprise_removed) {
>=20
> - /* indicate this recv_frame */
> - r8712_recv_indicatepkt(padapter,
> - prframe);
> - }
> - } else if (pattrib->amsdu =3D=3D 1) {
>=20
> - amsdu_to_msdu(padapter, prframe);
> - }
> - /* Update local variables. */
> - bPktInBuf =3D false;
> - } else {
> - bPktInBuf =3D true;
> - break;
> - }
> - }
> - return bPktInBuf;
> -}
> -
> -static int recv_indicatepkt_reorder(struct _adapter *padapter,
> - union recv_frame *prframe)
> -{
> - unsigned long irql;
> - struct rx_pkt_attrib *pattrib =3D &prframe->u.hdr.attrib;
>=20
> - struct recv_reorder_ctrl *preorder_ctrl =3D prframe->u.hdr.preorder_ctr=
l;
>=20
> - struct __queue *ppending_recvframe_queue =3D
> - &preorder_ctrl->pending_recvframe_queue;
>=20
> -
> - if (!pattrib->amsdu) {
>=20
> - /* s1. */
> - r8712_wlanhdr_to_ethhdr(prframe);
> - if (pattrib->qos !=3D 1) {
>=20
> - if (!padapter->driver_stopped &&
>=20
> - !padapter->surprise_removed) {
>=20
> - r8712_recv_indicatepkt(padapter, prframe);
> - return 0;
> - } else {
> - return -EINVAL;
> - }
> - }
> - }
> - spin_lock_irqsave(&ppending_recvframe_queue->lock, irql);
>=20
> - /s2. check if winstart_b(indicate_seq) needs to be updated/
> - if (!check_indicate_seq(preorder_ctrl, pattrib->seq_num))
>=20
> - goto _err_exit;
> - /s3. Insert all packet into Reorder Queue to maintain its ordering./
> - if (!enqueue_reorder_recvframe(preorder_ctrl, prframe))
> - goto _err_exit;
> - /*s4.
> - * Indication process.
> - * After Packet dropping and Sliding Window shifting as above, we can
> - * now just indicate the packets with the SeqNum smaller than latest
> - * WinStart and buffer other packets.
> - *
> - * For Rx Reorder condition:
> - * 1. All packets with SeqNum smaller than WinStart =3D> Indicate
>=20
> - * 2. All packets with SeqNum larger than or equal to
> - * WinStart =3D> Buffer it.
>=20
> - */
> - if (r8712_recv_indicatepkts_in_order(padapter, preorder_ctrl, false)) {
> - mod_timer(&preorder_ctrl->reordering_ctrl_timer,
>=20
> - jiffies + msecs_to_jiffies(REORDER_WAIT_TIME));
> - spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql);
>=20
> - } else {
> - spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql);
>=20
> - del_timer(&preorder_ctrl->reordering_ctrl_timer);
>=20
> - }
> - return 0;
> -_err_exit:
> - spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql);
>=20
> - return -ENOMEM;
> -}
> -
> -void r8712_reordering_ctrl_timeout_handler(void *pcontext)
> -{
> - unsigned long irql;
> - struct recv_reorder_ctrl *preorder_ctrl =3D pcontext;
> - struct _adapter *padapter =3D preorder_ctrl->padapter;
>=20
> - struct __queue *ppending_recvframe_queue =3D
> - &preorder_ctrl->pending_recvframe_queue;
>=20
> -
> - if (padapter->driver_stopped || padapter->surprise_removed)
>=20
> - return;
> - spin_lock_irqsave(&ppending_recvframe_queue->lock, irql);
>=20
> - r8712_recv_indicatepkts_in_order(padapter, preorder_ctrl, true);
> - spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql);
>=20
> -}
> -
> -static int r8712_process_recv_indicatepkts(struct _adapter *padapter,
> - union recv_frame *prframe)
> -{
> - int retval =3D _SUCCESS;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct ht_priv *phtpriv =3D &pmlmepriv->htpriv;
>=20
> -
> - if (phtpriv->ht_option =3D=3D 1) { /B/G/N Mode/
>=20
> - if (recv_indicatepkt_reorder(padapter, prframe)) {
> - /* including perform A-MPDU Rx Ordering Buffer Control*/
> - if (!padapter->driver_stopped &&
>=20
> - !padapter->surprise_removed)
>=20
> - return _FAIL;
> - }
> - } else { /B/G mode/
> - retval =3D r8712_wlanhdr_to_ethhdr(prframe);
> - if (retval)
> - return _FAIL;
> - if (!padapter->driver_stopped && !padapter->surprise_removed) {
>=20
> - /* indicate this recv_frame */
> - r8712_recv_indicatepkt(padapter, prframe);
> - } else {
> - return _FAIL;
> - }
> - }
> - return retval;
> -}
> -
> -static u8 query_rx_pwr_percentage(s8 antpower)
> -{
> - if ((antpower <=3D -100) || (antpower >=3D 20))
>=20
> - return 0;
> - else if (antpower >=3D 0)
>=20
> - return 100;
> - else
> - return 100 + antpower;
> -}
> -
> -static u8 evm_db2percentage(s8 value)
> -{
> - /*
> - * -33dB~0dB to 0%~99%
> - */
> - s8 ret_val =3D clamp(-value, 0, 33) * 3;
> -
> - if (ret_val =3D=3D 99)
> - ret_val =3D 100;
> -
> - return ret_val;
> -}
> -
> -s32 r8712_signal_scale_mapping(s32 cur_sig)
> -{
> - s32 ret_sig;
> -
> - if (cur_sig >=3D 51 && cur_sig <=3D 100)
>=20
> - ret_sig =3D 100;
> - else if (cur_sig >=3D 41 && cur_sig <=3D 50)
>=20
> - ret_sig =3D 80 + ((cur_sig - 40) * 2);
> - else if (cur_sig >=3D 31 && cur_sig <=3D 40)
>=20
> - ret_sig =3D 66 + (cur_sig - 30);
> - else if (cur_sig >=3D 21 && cur_sig <=3D 30)
>=20
> - ret_sig =3D 54 + (cur_sig - 20);
> - else if (cur_sig >=3D 10 && cur_sig <=3D 20)
>=20
> - ret_sig =3D 42 + (((cur_sig - 10) * 2) / 3);
> - else if (cur_sig >=3D 5 && cur_sig <=3D 9)
>=20
> - ret_sig =3D 22 + (((cur_sig - 5) * 3) / 2);
> - else if (cur_sig >=3D 1 && cur_sig <=3D 4)
>=20
> - ret_sig =3D 6 + (((cur_sig - 1) * 3) / 2);
> - else
> - ret_sig =3D cur_sig;
> - return ret_sig;
> -}
> -
> -static s32 translate2dbm(struct _adapter padapter, u8 signal_strength_id=
x)
> -{
> - s32 signal_power; / in dBm./
> - / Translate to dBm (x=3D0.5y-95).*/
> - signal_power =3D (s32)((signal_strength_idx + 1) >> 1);
>=20
> - signal_power -=3D 95;
> - return signal_power;
> -}
> -
> -static void query_rx_phy_status(struct _adapter *padapter,
> - union recv_frame *prframe)
> -{
> - u8 i, max_spatial_stream, evm;
> - struct recv_stat *prxstat =3D (struct recv_stat *)prframe->u.hdr.rx_hea=
d;
>=20
> - struct phy_stat *pphy_stat =3D (struct phy_stat *)(prxstat + 1);
> - u8 *pphy_head =3D (u8 )(prxstat + 1);
> - s8 rx_pwr[4], rx_pwr_all;
> - u8 pwdb_all;
> - u32 rssi, total_rssi =3D 0;
> - u8 bcck_rate =3D 0, rf_rx_num =3D 0, cck_highpwr =3D 0;
> - struct phy_cck_rx_status pcck_buf;
> - u8 sq;
> -
> - / Record it for next packet processing/
> - bcck_rate =3D (prframe->u.hdr.attrib.mcs_rate <=3D 3 ? 1 : 0);
>=20
> - if (bcck_rate) {
> - u8 report;
> -
> - /* CCK Driver info Structure is not the same as OFDM packet.*/
> - pcck_buf =3D (struct phy_cck_rx_status )pphy_stat;
> - / (1)Hardware does not provide RSSI for CCK
> - * (2)PWDB, Average PWDB calculated by hardware
> - * (for rate adaptive)
> - */
> - if (!cck_highpwr) {
> - report =3D pcck_buf->cck_agc_rpt & 0xc0;
>=20
> - report >>=3D 6;
>=20
> - switch (report) {
> - /* Modify the RF RNA gain value to -40, -20,
> - * -2, 14 by Jenyu's suggestion
> - * Note: different RF with the different
> - * RNA gain.
> - */
> - case 0x3:
> - rx_pwr_all =3D -40 - (pcck_buf->cck_agc_rpt &
>=20
> - 0x3e);
> - break;
> - case 0x2:
> - rx_pwr_all =3D -20 - (pcck_buf->cck_agc_rpt &
>=20
> - 0x3e);
> - break;
> - case 0x1:
> - rx_pwr_all =3D -2 - (pcck_buf->cck_agc_rpt &
>=20
> - 0x3e);
> - break;
> - case 0x0:
> - rx_pwr_all =3D 14 - (pcck_buf->cck_agc_rpt &
>=20
> - 0x3e);
> - break;
> - }
> - } else {
> - report =3D ((u8)(le32_to_cpu(pphy_stat->phydw1) >> 8)) &
>=20
> - 0x60;
> - report >>=3D 5;
>=20
> - switch (report) {
> - case 0x3:
> - rx_pwr_all =3D -40 - ((pcck_buf->cck_agc_rpt &
>=20
> - 0x1f) << 1);
> - break;
> - case 0x2:
> - rx_pwr_all =3D -20 - ((pcck_buf->cck_agc_rpt &
>=20
> - 0x1f) << 1);
> - break;
> - case 0x1:
> - rx_pwr_all =3D -2 - ((pcck_buf->cck_agc_rpt &
>=20
> - 0x1f) << 1);
> - break;
> - case 0x0:
> - rx_pwr_all =3D 14 - ((pcck_buf->cck_agc_rpt &
>=20
> - 0x1f) << 1);
> - break;
> - }
> - }
> - pwdb_all =3D query_rx_pwr_percentage(rx_pwr_all);
> - /* CCK gain is smaller than OFDM/MCS gain,/
> - / so we add gain diff by experiences, the val is 6 */
> - pwdb_all +=3D 6;
> - if (pwdb_all > 100)
>=20
> - pwdb_all =3D 100;
> - /* modify the offset to make the same gain index with OFDM.*/
> - if (pwdb_all > 34 && pwdb_all <=3D 42)
>=20
> - pwdb_all -=3D 2;
> - else if (pwdb_all > 26 && pwdb_all <=3D 34)
>=20
> - pwdb_all -=3D 6;
> - else if (pwdb_all > 14 && pwdb_all <=3D 26)
>=20
> - pwdb_all -=3D 8;
> - else if (pwdb_all > 4 && pwdb_all <=3D 14)
>=20
> - pwdb_all -=3D 4;
> - /*
> - * (3) Get Signal Quality (EVM)
> - */
> - if (pwdb_all > 40) {
>=20
> - sq =3D 100;
> - } else {
> - sq =3D pcck_buf->sq_rpt;
>=20
> - if (pcck_buf->sq_rpt > 64)
>=20
> - sq =3D 0;
> - else if (pcck_buf->sq_rpt < 20)
>=20
> - sq =3D 100;
> - else
> - sq =3D ((64 - sq) * 100) / 44;
> - }
> - prframe->u.hdr.attrib.signal_qual =3D sq;
>=20
> - prframe->u.hdr.attrib.rx_mimo_signal_qual[0] =3D sq;
>=20
> - prframe->u.hdr.attrib.rx_mimo_signal_qual[1] =3D -1;
>=20
> - } else {
> - /* (1)Get RSSI for HT rate */
> - for (i =3D 0; i < ((padapter->registrypriv.rf_config) &
>=20
> - 0x0f); i++) {
> - rf_rx_num++;
> - rx_pwr[i] =3D ((pphy_head[PHY_STAT_GAIN_TRSW_SHT + i]
> - & 0x3F) * 2) - 110;
> - /* Translate DBM to percentage. /
> - rssi =3D query_rx_pwr_percentage(rx_pwr[i]);
> - total_rssi +=3D rssi;
> - }
> - / (2)PWDB, Average PWDB calculated by hardware (for
> - * rate adaptive)
> - */
> - rx_pwr_all =3D (((pphy_head[PHY_STAT_PWDB_ALL_SHT]) >> 1) & 0x7f)
>=20
> - - 106;
> - pwdb_all =3D query_rx_pwr_percentage(rx_pwr_all);
> -
> - {
> - /* (3)EVM of HT rate */
> - if (prframe->u.hdr.attrib.htc &&
>=20
> - prframe->u.hdr.attrib.mcs_rate >=3D 20 &&
>=20
> - prframe->u.hdr.attrib.mcs_rate <=3D 27) {
>=20
> - /* both spatial stream make sense /
> - max_spatial_stream =3D 2;
> - } else {
> - / only spatial stream 1 makes sense */
> - max_spatial_stream =3D 1;
> - }
> - for (i =3D 0; i < max_spatial_stream; i++) {
> - evm =3D evm_db2percentage((pphy_head
> - [PHY_STAT_RXEVM_SHT + i]));/dbm/
> - prframe->u.hdr.attrib.signal_qual =3D
>=20
> - (u8)(evm & 0xff);
> - prframe->u.hdr.attrib.rx_mimo_signal_qual[i] =3D
>=20
> - (u8)(evm & 0xff);
> - }
> - }
> - }
> - /* UI BSS List signal strength(in percentage), make it good looking,
> - * from 0~100. It is assigned to the BSS List in
> - * GetValueFromBeaconOrProbeRsp().
> - */
> - if (bcck_rate) {
> - prframe->u.hdr.attrib.signal_strength =3D
>=20
> - (u8)r8712_signal_scale_mapping(pwdb_all);
> - } else {
> - if (rf_rx_num !=3D 0)
> - prframe->u.hdr.attrib.signal_strength =3D
>=20
> - (u8)(r8712_signal_scale_mapping(total_rssi /=3D
> - rf_rx_num));
> - }
> -}
> -
> -static void process_link_qual(struct _adapter *padapter,
> - union recv_frame *prframe)
> -{
> - u32 last_evm =3D 0, avg_val;
> - struct rx_pkt_attrib *pattrib;
> - struct smooth_rssi_data *sqd =3D &padapter->recvpriv.signal_qual_data;
>=20
> -
> - if (!prframe || !padapter)
> - return;
> - pattrib =3D &prframe->u.hdr.attrib;
>=20
> - if (pattrib->signal_qual !=3D 0) {
>=20
> - /*
> - * 1. Record the general EVM to the sliding window.
> - */
> - if (sqd->total_num++ >=3D PHY_LINKQUALITY_SLID_WIN_MAX) {
>=20
> - sqd->total_num =3D PHY_LINKQUALITY_SLID_WIN_MAX;
>=20
> - last_evm =3D sqd->elements[sqd->index];
>=20
> - sqd->total_val -=3D last_evm;
>=20
> - }
> - sqd->total_val +=3D pattrib->signal_qual;
>=20
> - sqd->elements[sqd->index++] =3D pattrib->signal_qual;
>=20
> - if (sqd->index >=3D PHY_LINKQUALITY_SLID_WIN_MAX)
>=20
> - sqd->index =3D 0;
>=20
> -
> - /* <1> Showed on UI for user, in percentage. */
>=20
> - avg_val =3D sqd->total_val / sqd->total_num;
>=20
> - padapter->recvpriv.signal =3D (u8)avg_val;
>=20
> - }
> -}
> -
> -static void process_rssi(struct _adapter *padapter, union recv_frame *pr=
frame)
> -{
> - u32 last_rssi, tmp_val;
> - struct rx_pkt_attrib *pattrib =3D &prframe->u.hdr.attrib;
>=20
> - struct smooth_rssi_data *ssd =3D &padapter->recvpriv.signal_strength_da=
ta;
>=20
> -
> - if (ssd->total_num++ >=3D PHY_RSSI_SLID_WIN_MAX) {
>=20
> - ssd->total_num =3D PHY_RSSI_SLID_WIN_MAX;
>=20
> - last_rssi =3D ssd->elements[ssd->index];
>=20
> - ssd->total_val -=3D last_rssi;
>=20
> - }
> - ssd->total_val +=3D pattrib->signal_strength;
>=20
> - ssd->elements[ssd->index++] =3D pattrib->signal_strength;
>=20
> - if (ssd->index >=3D PHY_RSSI_SLID_WIN_MAX)
>=20
> - ssd->index =3D 0;
>=20
> - tmp_val =3D ssd->total_val / ssd->total_num;
>=20
> - padapter->recvpriv.rssi =3D (s8)translate2dbm(padapter, (u8)tmp_val);
>=20
> -}
> -
> -static void process_phy_info(struct _adapter *padapter,
> - union recv_frame *prframe)
> -{
> - query_rx_phy_status(padapter, prframe);
> - process_rssi(padapter, prframe);
> - process_link_qual(padapter, prframe);
> -}
> -
> -int recv_func(struct _adapter *padapter, void *pcontext)
> -{
> - struct rx_pkt_attrib *pattrib;
> - union recv_frame *prframe, *orig_prframe;
> - int retval =3D _SUCCESS;
> - struct __queue *pfree_recv_queue =3D &padapter->recvpriv.free_recv_queu=
e;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - prframe =3D pcontext;
> - orig_prframe =3D prframe;
> - pattrib =3D &prframe->u.hdr.attrib;
>=20
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
> - if (pattrib->crc_err =3D=3D 1)
>=20
> - padapter->mppriv.rx_crcerrpktcount++;
>=20
> - else
> - padapter->mppriv.rx_pktcount++;
>=20
> - if (!check_fwstate(pmlmepriv, WIFI_MP_LPBK_STATE)) {
> - /* free this recv_frame /
> - r8712_free_recvframe(orig_prframe, pfree_recv_queue);
> - goto _exit_recv_func;
> - }
> - }
> - / check the frame crtl field and decache /
> - retval =3D r8712_validate_recv_frame(padapter, prframe);
> - if (retval !=3D _SUCCESS) {
> - / free this recv_frame */
> - r8712_free_recvframe(orig_prframe, pfree_recv_queue);
> - goto _exit_recv_func;
> - }
> - process_phy_info(padapter, prframe);
> - prframe =3D r8712_decryptor(padapter, prframe);
> - if (!prframe) {
> - retval =3D _FAIL;
> - goto _exit_recv_func;
> - }
> - prframe =3D r8712_recvframe_chk_defrag(padapter, prframe);
> - if (!prframe)
> - goto _exit_recv_func;
> - prframe =3D r8712_portctrl(padapter, prframe);
> - if (!prframe) {
> - retval =3D _FAIL;
> - goto _exit_recv_func;
> - }
> - retval =3D r8712_process_recv_indicatepkts(padapter, prframe);
> - if (retval !=3D _SUCCESS) {
> - r8712_free_recvframe(orig_prframe, pfree_recv_queue);
> - goto _exit_recv_func;
> - }
> -_exit_recv_func:
> - return retval;
> -}
> -
> -static void recvbuf2recvframe(struct _adapter *padapter, struct sk_buff =
*pskb)
> -{
> - u8 *pbuf, shift_sz =3D 0;
> - u8 frag, mf;
> - uint pkt_len;
> - u32 transfer_len;
> - struct recv_stat *prxstat;
> - u16 pkt_cnt, drvinfo_sz, pkt_offset, tmp_len, alloc_sz;
> - struct __queue *pfree_recv_queue;
> - _pkt *pkt_copy =3D NULL;
> - union recv_frame *precvframe =3D NULL;
> - struct recv_priv *precvpriv =3D &padapter->recvpriv;
>=20
> -
> - pfree_recv_queue =3D &precvpriv->free_recv_queue;
>=20
> - pbuf =3D pskb->data;
>=20
> - prxstat =3D (struct recv_stat *)pbuf;
> - pkt_cnt =3D (le32_to_cpu(prxstat->rxdw2) >> 16) & 0xff;
>=20
> - pkt_len =3D le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
>=20
> - transfer_len =3D pskb->len;
>=20
> - /* Test throughput with Netgear 3700 (No security) with Chariot 3T3R
> - * pairs. The packet count will be a big number so that the containing
> - * packet will effect the Rx reordering.
> - /
> - if (transfer_len < pkt_len) {
> - / In this case, it means the MAX_RECVBUF_SZ is too small to
> - * get the data from 8712u.
> - */
> - return;
> - }
> - do {
> - prxstat =3D (struct recv_stat *)pbuf;
> - pkt_len =3D le32_to_cpu(prxstat->rxdw0) & 0x00003fff;
>=20
> - /* more fragment bit */
> - mf =3D (le32_to_cpu(prxstat->rxdw1) >> 27) & 0x1;
>=20
> - /* ragmentation number */
> - frag =3D (le32_to_cpu(prxstat->rxdw2) >> 12) & 0xf;
>=20
> - /* uint 2^3 =3D 8 bytes */
> - drvinfo_sz =3D (le32_to_cpu(prxstat->rxdw0) & 0x000f0000) >> 16;
>=20
> - drvinfo_sz <<=3D 3;
> - if (pkt_len <=3D 0)
> - return;
> - /* Qos data, wireless lan header length is 26 */
> - if ((le32_to_cpu(prxstat->rxdw0) >> 23) & 0x01)
>=20
> - shift_sz =3D 2;
> - precvframe =3D r8712_alloc_recvframe(pfree_recv_queue);
> - if (!precvframe)
> - return;
> - INIT_LIST_HEAD(&precvframe->u.hdr.list);
>=20
> - precvframe->u.hdr.precvbuf =3D NULL; /can't access the precvbuf/
>=20
> - precvframe->u.hdr.len =3D 0;
>=20
> - tmp_len =3D pkt_len + drvinfo_sz + RXDESC_SIZE;
> - pkt_offset =3D (u16)round_up(tmp_len, 128);
> - /* for first fragment packet, driver need allocate 1536 +
> - * drvinfo_sz + RXDESC_SIZE to defrag packet.
> - /
> - if ((mf =3D=3D 1) && (frag =3D=3D 0))
> - /1658+6=3D1664, 1664 is 128 alignment./
> - alloc_sz =3D max_t(u16, tmp_len, 1658);
> - else
> - alloc_sz =3D tmp_len;
> - / 2 is for IP header 4 bytes alignment in QoS packet case.
> - * 4 is for skb->data 4 bytes alignment.
>=20
> - */
> - alloc_sz +=3D 6;
> - pkt_copy =3D netdev_alloc_skb(padapter->pnetdev, alloc_sz);
>=20
> - if (!pkt_copy)
> - return;
> -
> - precvframe->u.hdr.pkt =3D pkt_copy;
>=20
> - skb_reserve(pkt_copy, 4 - ((addr_t)(pkt_copy->data) % 4));
>=20
> - skb_reserve(pkt_copy, shift_sz);
> - memcpy(pkt_copy->data, pbuf, tmp_len);
>=20
> - precvframe->u.hdr.rx_head =3D pkt_copy->data;
>=20
> - precvframe->u.hdr.rx_data =3D pkt_copy->data;
>=20
> - precvframe->u.hdr.rx_tail =3D pkt_copy->data;
>=20
> - precvframe->u.hdr.rx_end =3D pkt_copy->data + alloc_sz;
>=20
> -
> - recvframe_put(precvframe, tmp_len);
> - recvframe_pull(precvframe, drvinfo_sz + RXDESC_SIZE);
> - /* because the endian issue, driver avoid reference to the
> - * rxstat after calling update_recvframe_attrib_from_recvstat();
> - */
> - update_recvframe_attrib_from_recvstat(&precvframe->u.hdr.attrib,
>=20
> - prxstat);
> - r8712_recv_entry(precvframe);
> - transfer_len -=3D pkt_offset;
> - pbuf +=3D pkt_offset;
> - pkt_cnt--;
> - precvframe =3D NULL;
> - pkt_copy =3D NULL;
> - } while ((transfer_len > 0) && pkt_cnt > 0);
>=20
> -}
> -
> -static void recv_tasklet(struct tasklet_struct *t)
> -{
> - struct sk_buff *pskb;
> - struct _adapter *padapter =3D from_tasklet(padapter, t,
> - recvpriv.recv_tasklet);
> - struct recv_priv *precvpriv =3D &padapter->recvpriv;
>=20
> -
> - while (NULL !=3D (pskb =3D skb_dequeue(&precvpriv->rx_skb_queue))) {
>=20
> - recvbuf2recvframe(padapter, pskb);
> - skb_reset_tail_pointer(pskb);
> - pskb->len =3D 0;
>=20
> - if (!skb_cloned(pskb))
> - skb_queue_tail(&precvpriv->free_recv_skb_queue, pskb);
>=20
> - else
> - consume_skb(pskb);
> - }
> -}
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.h b/drivers/staging/rtl=
8712/rtl8712_recv.h
> deleted file mode 100644
> index a1360dcf91ce..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_recv.h
> +++ /dev/null
> @@ -1,145 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
****/
> -#ifndef RTL8712_RECV_H
> -#define RTL8712_RECV_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -/ Realtek's v2.6.6 reduced this to 4. However, under heavy network and C=
PU
> - * loads, even 8 receive buffers might not be enough; cutting it to 4 se=
emed
> - * unwise.
> - /
> -#define NR_RECVBUFF (8)
> -
> -#define NR_PREALLOC_RECV_SKB (8)
> -#define RXDESC_SIZE 24
> -#define RXDESC_OFFSET RXDESC_SIZE
> -#define RECV_BLK_SZ 512
> -#define RECV_BLK_CNT 16
> -#define RECV_BLK_TH RECV_BLK_CNT
> -#define MAX_RECVBUF_SZ 9100
> -#define RECVBUFF_ALIGN_SZ 512
> -#define RSVD_ROOM_SZ (0)
> -/These definition is used for Rx packet reordering./
> -#define SN_LESS(a, b) (((a-b) & 0x800) !=3D 0)
> -#define SN_EQUAL(a, b) (a =3D=3D b)
> -#define REORDER_WAIT_TIME 30 / (ms)/
> -
> -struct recv_stat {
> - __le32 rxdw0;
> - __le32 rxdw1;
> - __le32 rxdw2;
> - __le32 rxdw3;
> - __le32 rxdw4;
> - __le32 rxdw5;
> -};
> -
> -struct phy_cck_rx_status {
> - / For CCK rate descriptor. This is a unsigned 8:1 variable.
> - * LSB bit present 0.5. And MSB 7 bts present a signed value.
> - * Range from -64~+63.5.
> - */
> - u8 adc_pwdb_X[4];
> - u8 sq_rpt;
> - u8 cck_agc_rpt;
> -};
> -
> -struct phy_stat {
> - __le32 phydw0;
> - __le32 phydw1;
> - __le32 phydw2;
> - __le32 phydw3;
> - __le32 phydw4;
> - __le32 phydw5;
> - __le32 phydw6;
> - __le32 phydw7;
> -};
> -
> -#define PHY_STAT_GAIN_TRSW_SHT 0
> -#define PHY_STAT_PWDB_ALL_SHT 4
> -#define PHY_STAT_CFOSHO_SHT 5
> -#define PHY_STAT_CCK_AGC_RPT_SHT 5
> -#define PHY_STAT_CFOTAIL_SHT 9
> -#define PHY_STAT_RXEVM_SHT 13
> -#define PHY_STAT_RXSNR_SHT 15
> -#define PHY_STAT_PDSNR_SHT 19
> -#define PHY_STAT_CSI_CURRENT_SHT 21
> -#define PHY_STAT_CSI_TARGET_SHT 23
> -#define PHY_STAT_SIGEVM_SHT 25
> -#define PHY_STAT_MAX_EX_PWR_SHT 26
> -
> -union recvstat {
> - struct recv_stat recv_stat;
> - unsigned int value[RXDESC_SIZE >> 2];
>=20
> -};
> -
> -struct recv_buf {
> - struct list_head list;
> - spinlock_t recvbuf_lock;
> - u32 ref_cnt;
> - struct _adapter *adapter;
> - struct urb *purb;
> - _pkt *pskb;
> - u8 irp_pending;
> - u32 transfer_len;
> - uint len;
> - u8 *phead;
> - u8 *pdata;
> - u8 *ptail;
> - u8 *pend;
> - u8 *pbuf;
> - u8 pallocated_buf;
> -};
> -
> -/
> - * head ----->
>=20
> - * data ----->
>=20
> - * payload
> - * tail ----->
>=20
> - * end ----->
>=20
> - * len =3D (unsigned int )(tail - data);
> - /
> -struct recv_frame_hdr {
> - struct list_head list;
> - _pkt pkt;
> - _pkt pkt_newalloc;
> - struct _adapter adapter;
> - u8 fragcnt;
> - struct rx_pkt_attrib attrib;
> - uint len;
> - u8 rx_head;
> - u8 rx_data;
> - u8 rx_tail;
> - u8 rx_end;
> - void precvbuf;
> - struct sta_info psta;
> - /for A-MPDU Rx reordering buffer control/
> - struct recv_reorder_ctrl preorder_ctrl;
> -};
> -
> -union recv_frame {
> - union {
> - struct list_head list;
> - struct recv_frame_hdr hdr;
> - } u;
> -};
> -
> -void r8712_init_recvbuf(struct _adapter padapter, struct recv_buf precvb=
uf);
> -void r8712_rxcmd_event_hdl(struct _adapter padapter, void prxcmdbuf);
> -s32 r8712_signal_scale_mapping(s32 cur_sig);
> -void r8712_reordering_ctrl_timeout_handler(void pcontext);
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_regdef.h b/drivers/staging/r=
tl8712/rtl8712_regdef.h
> deleted file mode 100644
> index 28aec9aa539f..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_regdef.h
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**************************************************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_REGDEF_H
> -#define RTL8712_REGDEF_H
> -
> -#include "rtl8712_syscfg_regdef.h"
> -#include "rtl8712_cmdctrl_regdef.h"
> -#include "rtl8712_macsetting_regdef.h"
> -#include "rtl8712_timectrl_regdef.h"
> -#include "rtl8712_fifoctrl_regdef.h"
> -#include "rtl8712_ratectrl_regdef.h"
> -#include "rtl8712_edcasetting_regdef.h"
> -#include "rtl8712_wmac_regdef.h"
> -#include "rtl8712_powersave_regdef.h"
> -#include "rtl8712_gp_regdef.h"
> -#include "rtl8712_debugctrl_regdef.h"
> -
> -#define HIMR (RTL8712_INTERRUPT_ + 0x08)
> -
> -#endif / RTL8712_REGDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_security_bitdef.h b/drivers/=
staging/rtl8712/rtl8712_security_bitdef.h
> deleted file mode 100644
> index 44275ef455a0..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_security_bitdef.h
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_SECURITY_BITDEF_H
> -#define RTL8712_SECURITY_BITDEF_H
> -
> -/CAMCMD/
> -#define _SECCAM_POLLING BIT(31)
> -#define _SECCAM_CLR BIT(30)
> -#define _SECCAM_WE BIT(16)
> -#define _SECCAM_ADR_MSK 0x000000FF
> -#define _SECCAM_ADR_SHT 0
> -
> -/CAMDBG/
> -#define _SECCAM_INFO BIT(31)
> -#define _SEC_KEYFOUND BIT(30)
> -#define _SEC_CONFIG_MSK 0x3F000000
> -#define _SEC_CONFIG_SHT 24
> -#define _SEC_KEYCONTENT_MSK 0x00FFFFFF
> -#define _SEC_KEYCONTENT_SHT 0
> -
> -/SECCFG/
> -#define _NOSKMC BIT(5)
> -#define _SKBYA2 BIT(4)
> -#define _RXDEC BIT(3)
> -#define _TXENC BIT(2)
> -#define _RXUSEDK BIT(1)
> -#define _TXUSEDK BIT(0)
> -
> -#endif /RTL8712_SECURITY_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_spec.h b/drivers/staging/rtl=
8712/rtl8712_spec.h
> deleted file mode 100644
> index 613a410e5714..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_spec.h
> +++ /dev/null
> @@ -1,121 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_SPEC_H
> -#define RTL8712_SPEC_H
> -
> -#define RTL8712_IOBASE_TXPKT 0x10200000 /IOBASE_TXPKT/
> -#define RTL8712_IOBASE_RXPKT 0x10210000 /IOBASE_RXPKT/
> -#define RTL8712_IOBASE_RXCMD 0x10220000 /IOBASE_RXCMD/
> -#define RTL8712_IOBASE_TXSTATUS 0x10230000 /IOBASE_TXSTATUS/
> -#define RTL8712_IOBASE_RXSTATUS 0x10240000 /IOBASE_RXSTATUS/
> -#define RTL8712_IOBASE_IOREG 0x10250000 /IOBASE_IOREG ADDR/
> -#define RTL8712_IOBASE_SCHEDULER 0x10260000 /IOBASE_SCHEDULE/
> -
> -#define RTL8712_IOBASE_TRXDMA 0x10270000 /IOBASE_TRXDMA/
> -#define RTL8712_IOBASE_TXLLT 0x10280000 /IOBASE_TXLLT/
> -#define RTL8712_IOBASE_WMAC 0x10290000 /IOBASE_WMAC/
> -#define RTL8712_IOBASE_FW2HW 0x102A0000 /IOBASE_FW2HW/
> -#define RTL8712_IOBASE_ACCESS_PHYREG 0x102B0000 /IOBASE_ACCESS_PHYREG/
> -
> -#define RTL8712_IOBASE_FF 0x10300000 /IOBASE_FIFO 0x1031000~0x103AFFFF/
> -
> -/IOREG Offset for 8712/
> -#define RTL8712_SYSCFG_ RTL8712_IOBASE_IOREG
> -#define RTL8712_CMDCTRL_ (RTL8712_IOBASE_IOREG + 0x40)
> -#define RTL8712_MACIDSETTING_ (RTL8712_IOBASE_IOREG + 0x50)
> -#define RTL8712_TIMECTRL_ (RTL8712_IOBASE_IOREG + 0x80)
> -#define RTL8712_FIFOCTRL_ (RTL8712_IOBASE_IOREG + 0xA0)
> -#define RTL8712_RATECTRL_ (RTL8712_IOBASE_IOREG + 0x160)
> -#define RTL8712_EDCASETTING_ (RTL8712_IOBASE_IOREG + 0x1D0)
> -#define RTL8712_WMAC_ (RTL8712_IOBASE_IOREG + 0x200)
> -#define RTL8712_SECURITY_ (RTL8712_IOBASE_IOREG + 0x240)
> -#define RTL8712_POWERSAVE_ (RTL8712_IOBASE_IOREG + 0x260)
> -#define RTL8712_GP_ (RTL8712_IOBASE_IOREG + 0x2E0)
> -#define RTL8712_INTERRUPT_ (RTL8712_IOBASE_IOREG + 0x300)
> -#define RTL8712_DEBUGCTRL_ (RTL8712_IOBASE_IOREG + 0x310)
> -#define RTL8712_OFFLOAD_ (RTL8712_IOBASE_IOREG + 0x2D0)
> -
> -/FIFO for 8712/
> -#define RTL8712_DMA_BCNQ (RTL8712_IOBASE_FF + 0x10000)
> -#define RTL8712_DMA_MGTQ (RTL8712_IOBASE_FF + 0x20000)
> -#define RTL8712_DMA_BMCQ (RTL8712_IOBASE_FF + 0x30000)
> -#define RTL8712_DMA_VOQ (RTL8712_IOBASE_FF + 0x40000)
> -#define RTL8712_DMA_VIQ (RTL8712_IOBASE_FF + 0x50000)
> -#define RTL8712_DMA_BEQ (RTL8712_IOBASE_FF + 0x60000)
> -#define RTL8712_DMA_BKQ (RTL8712_IOBASE_FF + 0x70000)
> -#define RTL8712_DMA_RX0FF (RTL8712_IOBASE_FF + 0x80000)
> -#define RTL8712_DMA_H2CCMD (RTL8712_IOBASE_FF + 0x90000)
> -#define RTL8712_DMA_C2HCMD (RTL8712_IOBASE_FF + 0xA0000)
> -
> -/------------------------------/
> -
> -/BIT 16 15/
> -#define DID_SDIO_LOCAL 0 / 0 0/
> -#define DID_WLAN_IOREG 1 / 0 1/
> -#define DID_WLAN_FIFO 3 / 1 1/
> -#define DID_UNDEFINE (-1)
> -
> -#define CMD_ADDR_MAPPING_SHIFT 2 /SDIO CMD ADDR MAPPING,
> - shift 2 bit for match
> - * offset[14:2]
> - /
> -
> -/Offset for SDIO LOCAL/
> -#define OFFSET_SDIO_LOCAL 0x0FFF
> -
> -/Offset for WLAN IOREG/
> -#define OFFSET_WLAN_IOREG 0x0FFF
> -
> -/Offset for WLAN FIFO/
> -#define OFFSET_TX_BCNQ 0x0300
> -#define OFFSET_TX_HIQ 0x0310
> -#define OFFSET_TX_CMDQ 0x0320
> -#define OFFSET_TX_MGTQ 0x0330
> -#define OFFSET_TX_HCCAQ 0x0340
> -#define OFFSET_TX_VOQ 0x0350
> -#define OFFSET_TX_VIQ 0x0360
> -#define OFFSET_TX_BEQ 0x0370
> -#define OFFSET_TX_BKQ 0x0380
> -#define OFFSET_RX_RX0FFQ 0x0390
> -#define OFFSET_RX_C2HFFQ 0x03A0
> -
> -#define BK_QID_01 1
> -#define BK_QID_02 2
> -#define BE_QID_01 0
> -#define BE_QID_02 3
> -#define VI_QID_01 4
> -#define VI_QID_02 5
> -#define VO_QID_01 6
> -#define VO_QID_02 7
> -#define HCCA_QID_01 8
> -#define HCCA_QID_02 9
> -#define HCCA_QID_03 10
> -#define HCCA_QID_04 11
> -#define HCCA_QID_05 12
> -#define HCCA_QID_06 13
> -#define HCCA_QID_07 14
> -#define HCCA_QID_08 15
> -#define HI_QID 17
> -#define CMD_QID 19
> -#define MGT_QID 18
> -#define BCN_QID 16
> -
> -#include "rtl8712_regdef.h"
> -
> -#include "rtl8712_bitdef.h"
> -
> -#include "basic_types.h"
> -
> -#endif / RTL8712_SPEC_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h b/drivers/st=
aging/rtl8712/rtl8712_syscfg_bitdef.h
> deleted file mode 100644
> index d92df3fbd2b1..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_syscfg_bitdef.h
> +++ /dev/null
> @@ -1,163 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/*****
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_SYSCFG_BITDEF_H
> -#define RTL8712_SYSCFG_BITDEF_H
> -
> -/SYS_PWR_CTRL/
> -/SRCTRL0/
> -/SRCTRL1/
> -/SYS_CLKR/
> -
> -/SYS_IOS_CTRL/
> -#define iso_LDR2RP_SHT 8 / EE Loader to Retention Path/
> -#define iso_LDR2RP BIT(iso_LDR2RP_SHT) / 1:isolation, 0:attach/
> -
> -/SYS_CTRL/
> -#define FEN_DIO_SDIO_SHT 0
> -#define FEN_DIO_SDIO BIT(FEN_DIO_SDIO_SHT)
> -#define FEN_SDIO_SHT 1
> -#define FEN_SDIO BIT(FEN_SDIO_SHT)
> -#define FEN_USBA_SHT 2
> -#define FEN_USBA BIT(FEN_USBA_SHT)
> -#define FEN_UPLL_SHT 3
> -#define FEN_UPLL BIT(FEN_UPLL_SHT)
> -#define FEN_USBD_SHT 4
> -#define FEN_USBD BIT(FEN_USBD_SHT)
> -#define FEN_DIO_PCIE_SHT 5
> -#define FEN_DIO_PCIE BIT(FEN_DIO_PCIE_SHT)
> -#define FEN_PCIEA_SHT 6
> -#define FEN_PCIEA BIT(FEN_PCIEA_SHT)
> -#define FEN_PPLL_SHT 7
> -#define FEN_PPLL BIT(FEN_PPLL_SHT)
> -#define FEN_PCIED_SHT 8
> -#define FEN_PCIED BIT(FEN_PCIED_SHT)
> -#define FEN_CPUEN_SHT 10
> -#define FEN_CPUEN BIT(FEN_CPUEN_SHT)
> -#define FEN_DCORE_SHT 11
> -#define FEN_DCORE BIT(FEN_DCORE_SHT)
> -#define FEN_ELDR_SHT 12
> -#define FEN_ELDR BIT(FEN_ELDR_SHT)
> -#define PWC_DV2LDR_SHT 13
> -#define PWC_DV2LDR BIT(PWC_DV2LDR_SHT) / Loader Power Enable/
> -
> -/=3D=3D=3D SYS_CLKR =3D=3D=3D/
> -#define SYS_CLKSEL_SHT 0
> -#define SYS_CLKSEL BIT(SYS_CLKSEL_SHT) / System Clock 80MHz/
> -#define PS_CLKSEL_SHT 1
> -#define PS_CLKSEL BIT(PS_CLKSEL_SHT) /System power save
> - * clock select.
> - /
> -#define CPU_CLKSEL_SHT 2
> -#define CPU_CLKSEL BIT(CPU_CLKSEL_SHT) / System Clock select,
> - * 1: AFE source,
> - * 0: System clock(L-Bus)
> - /
> -#define INT32K_EN_SHT 3
> -#define INT32K_EN BIT(INT32K_EN_SHT)
> -#define MACSLP_SHT 4
> -#define MACSLP BIT(MACSLP_SHT)
> -#define MAC_CLK_EN_SHT 11
> -#define MAC_CLK_EN BIT(MAC_CLK_EN_SHT) / MAC Clock Enable./
> -#define SYS_CLK_EN_SHT 12
> -#define SYS_CLK_EN BIT(SYS_CLK_EN_SHT)
> -#define RING_CLK_EN_SHT 13
> -#define RING_CLK_EN BIT(RING_CLK_EN_SHT)
> -#define SWHW_SEL_SHT 14
> -#define SWHW_SEL BIT(SWHW_SEL_SHT) / Load done,
> - * control path switch.
> - /
> -#define FWHW_SEL_SHT 15
> -#define FWHW_SEL BIT(FWHW_SEL_SHT) / Sleep exit,
> - * control path switch.
> - /
> -
> -/9346CR/
> -#define _VPDIDX_MSK 0xFF00
> -#define _VPDIDX_SHT 8
> -#define _EEM_MSK 0x00C0
> -#define _EEM_SHT 6
> -#define _EEM0 BIT(6)
> -#define _EEM1 BIT(7)
> -#define _EEPROM_EN BIT(5)
> -#define _9356SEL BIT(4)
> -#define _EECS BIT(3)
> -#define _EESK BIT(2)
> -#define _EEDI BIT(1)
> -#define _EEDO BIT(0)
> -
> -/AFE_MISC/
> -#define AFE_MISC_USB_MBEN_SHT 7
> -#define AFE_MISC_USB_MBEN BIT(AFE_MISC_USB_MBEN_SHT)
> -#define AFE_MISC_USB_BGEN_SHT 6
> -#define AFE_MISC_USB_BGEN BIT(AFE_MISC_USB_BGEN_SHT)
> -#define AFE_MISC_LD12_VDAJ_SHT 4
> -#define AFE_MISC_LD12_VDAJ_MSK 0X0030
> -#define AFE_MISC_LD12_VDAJ BIT(AFE_MISC_LD12_VDAJ_SHT)
> -#define AFE_MISC_I32_EN_SHT 3
> -#define AFE_MISC_I32_EN BIT(AFE_MISC_I32_EN_SHT)
> -#define AFE_MISC_E32_EN_SHT 2
> -#define AFE_MISC_E32_EN BIT(AFE_MISC_E32_EN_SHT)
> -#define AFE_MISC_MBEN_SHT 1
> -#define AFE_MISC_MBEN BIT(AFE_MISC_MBEN_SHT)/ Enable AFE Macro
> - * Block's Mbias.
> - /
> -#define AFE_MISC_BGEN_SHT 0
> -#define AFE_MISC_BGEN BIT(AFE_MISC_BGEN_SHT)/ Enable AFE Macro
> - * Block's Bandgap.
> - /
> -
> -/-----------------------------------------------------------------------=
---/
> -/ SPS1_CTRL bits (Offset 0x18-1E, 56bits)/
> -/-----------------------------------------------------------------------=
---/
> -#define SPS1_SWEN BIT(1) / Enable vsps18 SW Macro Block./
> -#define SPS1_LDEN BIT(0) / Enable VSPS12 LDO Macro block./
> -
> -/-----------------------------------------------------------------------=
-----/
> -/ LDOA15_CTRL bits (Offset 0x20, 8bits)/
> -/-----------------------------------------------------------------------=
-----/
> -#define LDA15_EN BIT(0) / Enable LDOA15 Macro Block/
> -
> -/-----------------------------------------------------------------------=
-----/
> -/ 8192S LDOV12D_CTRL bit (Offset 0x21, 8bits)/
> -/-----------------------------------------------------------------------=
-----/
> -#define LDV12_EN BIT(0) / Enable LDOVD12 Macro Block/
> -#define LDV12_SDBY BIT(1) / LDOVD12 standby mode/
> -
> -/CLK_PS_CTRL/
> -#define _CLK_GATE_EN BIT(0)
> -
> -/ EFUSE_CTRL/
> -#define EF_FLAG BIT(31) / Access Flag, Write:1;
> - * Read:0
> - /
> -#define EF_PGPD 0x70000000 / E-fuse Program time/
> -#define EF_RDT 0x0F000000 / E-fuse read time: in the
> - * unit of cycle time
> - /
> -#define EF_PDN_EN BIT(19) / EFuse Power down enable/
> -#define ALD_EN BIT(18) / Autoload Enable/
> -#define EF_ADDR 0x0003FF00 / Access Address/
> -#define EF_DATA 0x000000FF / Access Data/
> -
> -/ EFUSE_TEST/
> -#define LDOE25_EN BIT(31) / Enable LDOE25 Macro Block/
> -
> -/ EFUSE_CLK_CTRL/
> -#define EFUSE_CLK_EN BIT(1) / E-Fuse Clock Enable/
> -#define EFUSE_CLK_SEL BIT(0) / E-Fuse Clock Select,
> - * 0:500K, 1:40M
> - /
> -
> -#endif /RTL8712_SYSCFG_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h b/drivers/st=
aging/rtl8712/rtl8712_syscfg_regdef.h
> deleted file mode 100644
> index da5efcdedabe..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_syscfg_regdef.h
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/************************************************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_SYSCFG_REGDEF_H
> -#define RTL8712_SYSCFG_REGDEF_H
> -
> -#define SYS_ISO_CTRL (RTL8712_SYSCFG_ + 0x0000)
> -#define SYS_FUNC_EN (RTL8712_SYSCFG_ + 0x0002)
> -#define PMC_FSM (RTL8712_SYSCFG_ + 0x0004)
> -#define SYS_CLKR (RTL8712_SYSCFG_ + 0x0008)
> -#define EE_9346CR (RTL8712_SYSCFG_ + 0x000A)
> -#define EE_VPD (RTL8712_SYSCFG_ + 0x000C)
> -#define AFE_MISC (RTL8712_SYSCFG_ + 0x0010)
> -#define SPS0_CTRL (RTL8712_SYSCFG_ + 0x0011)
> -#define SPS1_CTRL (RTL8712_SYSCFG_ + 0x0018)
> -#define RF_CTRL (RTL8712_SYSCFG_ + 0x001F)
> -#define LDOA15_CTRL (RTL8712_SYSCFG_ + 0x0020)
> -#define LDOV12D_CTRL (RTL8712_SYSCFG_ + 0x0021)
> -#define LDOHCI12_CTRL (RTL8712_SYSCFG_ + 0x0022)
> -#define LDO_USB_CTRL (RTL8712_SYSCFG_ + 0x0023)
> -#define LPLDO_CTRL (RTL8712_SYSCFG_ + 0x0024)
> -#define AFE_XTAL_CTRL (RTL8712_SYSCFG_ + 0x0026)
> -#define AFE_PLL_CTRL (RTL8712_SYSCFG_ + 0x0028)
> -#define EFUSE_CTRL (RTL8712_SYSCFG_ + 0x0030)
> -#define EFUSE_TEST (RTL8712_SYSCFG_ + 0x0034)
> -#define PWR_DATA (RTL8712_SYSCFG_ + 0x0038)
> -#define DPS_TIMER (RTL8712_SYSCFG_ + 0x003C)
> -#define RCLK_MON (RTL8712_SYSCFG_ + 0x003E)
> -#define EFUSE_CLK_CTRL (RTL8712_SYSCFG_ + 0x02F8)
> -
> -#endif /RTL8712_SYSCFG_REGDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h b/drivers/=
staging/rtl8712/rtl8712_timectrl_bitdef.h
> deleted file mode 100644
> index d7bc9dd5cecd..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_timectrl_bitdef.h
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_TIMECTRL_BITDEF_H
> -#define RTL8712_TIMECTRL_BITDEF_H
> -
> -/TSFTR/
> -/SLOT/
> -/USTIME/
> -
> -/TUBASE/
> -#define _TUBASE_MSK 0x07FF
> -
> -/SIFS_CCK/
> -#define _SIFS_CCK_TRX_MSK 0xFF00
> -#define _SIFS_CCK_TRX_SHT 0x8
> -#define _SIFS_CCK_CTX_MSK 0x00FF
> -#define _SIFS_CCK_CTX_SHT 0
> -
> -/SIFS_OFDM/
> -#define _SIFS_OFDM_TRX_MSK 0xFF00
> -#define _SIFS_OFDM_TRX_SHT 0x8
> -#define _SIFS_OFDM_CTX_MSK 0x00FF
> -#define _SIFS_OFDM_CTX_SHT 0
> -
> -/PIFS/
> -/ACKTO/
> -/EIFS/
> -/BCNITV/
> -/ATIMWND/
> -
> -/DRVERLYINT/
> -#define _ENSWBCN BIT(15)
> -#define _DRVERLY_TU_MSK 0x0FF0
> -#define _DRVERLY_TU_SHT 4
> -#define _DRVERLY_US_MSK 0x000F
> -#define _DRVERLY_US_SHT 0
> -
> -/BCNDMATIM/
> -#define _BCNDMATIM_MSK 0x03FF
> -
> -/BCNERRTH/
> -/MLT/
> -
> -#endif / RTL8712_TIMECTRL_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h b/drivers/=
staging/rtl8712/rtl8712_timectrl_regdef.h
> deleted file mode 100644
> index b51603f1b880..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_timectrl_regdef.h
> +++ /dev/null
> @@ -1,26 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL8712_TIMECTRL_REGDEF_H
> -#define RTL8712_TIMECTRL_REGDEF_H
> -
> -#define TSFTR (RTL8712_TIMECTRL_ + 0x00)
> -#define USTIME (RTL8712_TIMECTRL_ + 0x08)
> -#define SLOT (RTL8712_TIMECTRL_ + 0x09)
> -#define TUBASE (RTL8712_TIMECTRL_ + 0x0A)
> -#define SIFS_CCK (RTL8712_TIMECTRL_ + 0x0C)
> -#define SIFS_OFDM (RTL8712_TIMECTRL_ + 0x0E)
> -#define PIFS (RTL8712_TIMECTRL_ + 0x10)
> -#define ACKTO (RTL8712_TIMECTRL_ + 0x11)
> -#define EIFS (RTL8712_TIMECTRL_ + 0x12)
> -#define BCNITV (RTL8712_TIMECTRL_ + 0x14)
> -#define ATIMWND (RTL8712_TIMECTRL_ + 0x16)
> -#define DRVERLYINT (RTL8712_TIMECTRL_ + 0x18)
> -#define BCNDMATIM (RTL8712_TIMECTRL_ + 0x1A)
> -#define BCNERRTH (RTL8712_TIMECTRL_ + 0x1C)
> -#define MLT (RTL8712_TIMECTRL_ + 0x1D)
> -
> -#endif / RTL8712_TIMECTRL_REGDEF_H /
> diff --git a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h b/drivers/stag=
ing/rtl8712/rtl8712_wmac_bitdef.h
> deleted file mode 100644
> index ea164e482347..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_wmac_bitdef.h
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_WMAC_BITDEF_H
> -#define RTL8712_WMAC_BITDEF_H
> -
> -/NAVCTRL/
> -#define _NAV_UPPER_EN BIT(18)
> -#define _NAV_MTO_EN BIT(17)
> -#define _NAV_UPPER BIT(16)
> -#define _NAV_MTO_MSK 0xFF00
> -#define _NAV_MTO_SHT 8
> -#define _RTSRST_MSK 0x00FF
> -#define _RTSRST_SHT 0
> -
> -/BWOPMODE/
> -#define _20MHZBW BIT(2)
> -
> -/BACAMCMD/
> -#define _BACAM_POLL BIT(31)
> -#define _BACAM_RST BIT(17)
> -#define _BACAM_RW BIT(16)
> -#define _BACAM_ADDR_MSK 0x0000007F
> -#define _BACAM_ADDR_SHT 0
> -
> -/LBDLY/
> -#define _LBDLY_MSK 0x1F
> -
> -/FWDLY/
> -#define _FWDLY_MSK 0x0F
> -
> -/RXERR_RPT/
> -#define _RXERR_RPT_SEL_MSK 0xF0000000
> -#define _RXERR_RPT_SEL_SHT 28
> -#define _RPT_CNT_MSK 0x000FFFFF
> -#define _RPT_CNT_SHT 0
> -
> -#endif /RTL8712_WMAC_BITDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h b/drivers/stag=
ing/rtl8712/rtl8712_wmac_regdef.h
> deleted file mode 100644
> index dfe3e9fbed43..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_wmac_regdef.h
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL8712_WMAC_REGDEF_H
> -#define RTL8712_WMAC_REGDEF_H
> -
> -#define NAVCTRL (RTL8712_WMAC_ + 0x00)
> -#define BWOPMODE (RTL8712_WMAC_ + 0x03)
> -#define BACAMCMD (RTL8712_WMAC_ + 0x04)
> -#define BACAMCONTENT (RTL8712_WMAC_ + 0x08)
> -#define LBDLY (RTL8712_WMAC_ + 0x10)
> -#define FWDLY (RTL8712_WMAC_ + 0x11)
> -#define HWPC_RX_CTRL (RTL8712_WMAC_ + 0x18)
> -#define MQ (RTL8712_WMAC_ + 0x20)
> -#define MA (RTL8712_WMAC_ + 0x22)
> -#define MS (RTL8712_WMAC_ + 0x24)
> -#define CLM_RESULT (RTL8712_WMAC_ + 0x27)
> -#define NHM_RPI_CNT (RTL8712_WMAC_ + 0x28)
> -#define RXERR_RPT (RTL8712_WMAC_ + 0x30)
> -#define NAV_PROT_LEN (RTL8712_WMAC_ + 0x34)
> -#define CFEND_TH (RTL8712_WMAC_ + 0x36)
> -#define AMPDU_MIN_SPACE (RTL8712_WMAC_ + 0x37)
> -#define TXOP_STALL_CTRL (RTL8712_WMAC_ + 0x38)
> -
> -#endif /RTL8712_WMAC_REGDEF_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl=
8712/rtl8712_xmit.c
> deleted file mode 100644
> index 12f2fdb1b3cb..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_xmit.c
> +++ /dev/null
> @@ -1,732 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**
> - * rtl8712_xmit.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL8712_XMIT_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "wifi.h"
> -#include "osdep_intf.h"
> -#include "usb_ops.h"
> -
> -static void dump_xframe(struct _adapter *padapter,
> - struct xmit_frame *pxmitframe);
> -static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int=
 sz);
> -
> -sint _r8712_init_hw_txqueue(struct hw_txqueue *phw_txqueue, u8 ac_tag)
> -{
> - phw_txqueue->ac_tag =3D ac_tag;
>=20
> - switch (ac_tag) {
> - case BE_QUEUE_INX:
> - phw_txqueue->ff_hwaddr =3D RTL8712_DMA_BEQ;
>=20
> - break;
> - case BK_QUEUE_INX:
> - phw_txqueue->ff_hwaddr =3D RTL8712_DMA_BKQ;
>=20
> - break;
> - case VI_QUEUE_INX:
> - phw_txqueue->ff_hwaddr =3D RTL8712_DMA_VIQ;
>=20
> - break;
> - case VO_QUEUE_INX:
> - phw_txqueue->ff_hwaddr =3D RTL8712_DMA_VOQ;
>=20
> - break;
> - case BMC_QUEUE_INX:
> - phw_txqueue->ff_hwaddr =3D RTL8712_DMA_BEQ;
>=20
> - break;
> - }
> - return _SUCCESS;
> -}
> -
> -int r8712_txframes_sta_ac_pending(struct _adapter *padapter,
> - struct pkt_attrib *pattrib)
> -{
> - struct sta_info *psta;
> - struct tx_servq *ptxservq;
> - int priority =3D pattrib->priority;
>=20
> -
> - psta =3D pattrib->psta;
>=20
> - switch (priority) {
> - case 1:
> - case 2:
> - ptxservq =3D &psta->sta_xmitpriv.bk_q;
>=20
> - break;
> - case 4:
> - case 5:
> - ptxservq =3D &psta->sta_xmitpriv.vi_q;
>=20
> - break;
> - case 6:
> - case 7:
> - ptxservq =3D &psta->sta_xmitpriv.vo_q;
>=20
> - break;
> - case 0:
> - case 3:
> - default:
> - ptxservq =3D &psta->sta_xmitpriv.be_q;
>=20
> - break;
> - }
> - return ptxservq->qcnt;
>=20
> -}
> -
> -static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
> -{
> - u32 addr =3D 0;
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> - struct _adapter *padapter =3D pxmitframe->padapter;
>=20
> - struct dvobj_priv *pdvobj =3D &padapter->dvobjpriv;
>=20
> -
> - if (pxmitframe->frame_tag =3D=3D TXAGG_FRAMETAG) {
>=20
> - addr =3D RTL8712_DMA_H2CCMD;
> - } else if (pxmitframe->frame_tag =3D=3D MGNT_FRAMETAG) {
>=20
> - addr =3D RTL8712_DMA_MGTQ;
> - } else if (pdvobj->nr_endpoint =3D=3D 6) {
>=20
> - switch (pattrib->priority) {
>=20
> - case 0:
> - case 3:
> - addr =3D RTL8712_DMA_BEQ;
> - break;
> - case 1:
> - case 2:
> - addr =3D RTL8712_DMA_BKQ;
> - break;
> - case 4:
> - case 5:
> - addr =3D RTL8712_DMA_VIQ;
> - break;
> - case 6:
> - case 7:
> - addr =3D RTL8712_DMA_VOQ;
> - break;
> - case 0x10:
> - case 0x11:
> - case 0x12:
> - case 0x13:
> - addr =3D RTL8712_DMA_H2CCMD;
> - break;
> - default:
> - addr =3D RTL8712_DMA_BEQ;
> - break;
> - }
> - } else if (pdvobj->nr_endpoint =3D=3D 4) {
>=20
> - switch (pattrib->qsel) {
>=20
> - case 0:
> - case 3:
> - case 1:
> - case 2:
> - addr =3D RTL8712_DMA_BEQ;/RTL8712_EP_LO;/
> - break;
> - case 4:
> - case 5:
> - case 6:
> - case 7:
> - addr =3D RTL8712_DMA_VOQ;/RTL8712_EP_HI;/
> - break;
> - case 0x10:
> - case 0x11:
> - case 0x12:
> - case 0x13:
> - addr =3D RTL8712_DMA_H2CCMD;
> - break;
> - default:
> - addr =3D RTL8712_DMA_BEQ;/RTL8712_EP_LO;/
> - break;
> - }
> - }
> - return addr;
> -}
> -
> -static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitp=
riv,
> - struct hw_xmit *phwxmit, struct tx_servq *ptxservq,
> - struct __queue *pframe_queue)
> -{
> - struct list_head *xmitframe_plist, *xmitframe_phead;
> - struct xmit_frame *pxmitframe =3D NULL;
> -
> - xmitframe_phead =3D &pframe_queue->queue;
>=20
> - xmitframe_plist =3D xmitframe_phead->next;
>=20
> - if (!end_of_queue_search(xmitframe_phead, xmitframe_plist)) {
> - pxmitframe =3D container_of(xmitframe_plist,
> - struct xmit_frame, list);
> - list_del_init(&pxmitframe->list);
>=20
> - ptxservq->qcnt--;
>=20
> - phwxmit->txcmdcnt++;
>=20
> - }
> - return pxmitframe;
> -}
> -
> -static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
> - struct hw_xmit *phwxmit_i, sint entry)
> -{
> - unsigned long irqL0;
> - struct list_head *sta_plist, *sta_phead;
> - struct hw_xmit *phwxmit;
> - struct tx_servq *ptxservq =3D NULL;
> - struct __queue *pframe_queue =3D NULL;
> - struct xmit_frame *pxmitframe =3D NULL;
> - int i, inx[4];
> - int j, acirp_cnt[4];
> -
> - /entry indx: 0->vo, 1->vi, 2->be, 3->bk./
>=20
> - inx[0] =3D 0; acirp_cnt[0] =3D pxmitpriv->voq_cnt;
>=20
> - inx[1] =3D 1; acirp_cnt[1] =3D pxmitpriv->viq_cnt;
>=20
> - inx[2] =3D 2; acirp_cnt[2] =3D pxmitpriv->beq_cnt;
>=20
> - inx[3] =3D 3; acirp_cnt[3] =3D pxmitpriv->bkq_cnt;
>=20
> - for (i =3D 0; i < 4; i++) {
> - for (j =3D i + 1; j < 4; j++) {
> - if (acirp_cnt[j] < acirp_cnt[i]) {
> - swap(acirp_cnt[i], acirp_cnt[j]);
> - swap(inx[i], inx[j]);
> - }
> - }
> - }
> - spin_lock_irqsave(&pxmitpriv->lock, irqL0);
>=20
> - for (i =3D 0; i < entry; i++) {
> - phwxmit =3D phwxmit_i + inx[i];
> - sta_phead =3D &phwxmit->sta_queue->queue;
>=20
> - sta_plist =3D sta_phead->next;
>=20
> - while (!end_of_queue_search(sta_phead, sta_plist)) {
> - ptxservq =3D container_of(sta_plist, struct tx_servq, tx_pending);
> - pframe_queue =3D &ptxservq->sta_pending;
>=20
> - pxmitframe =3D dequeue_one_xmitframe(pxmitpriv, phwxmit, ptxservq,
> - pframe_queue);
> - if (pxmitframe) {
> - phwxmit->accnt--;
>=20
> - goto exit_dequeue_xframe_ex;
> - }
> - sta_plist =3D sta_plist->next;
>=20
> - /Remove sta node when there are no pending packets./
> - if (list_empty(&pframe_queue->queue)) {
>=20
> - /* must be done after sta_plist->next
>=20
> - * and before break
> - */
> - list_del_init(&ptxservq->tx_pending);
>=20
> - }
> - }
> - }
> -exit_dequeue_xframe_ex:
> - spin_unlock_irqrestore(&pxmitpriv->lock, irqL0);
>=20
> - return pxmitframe;
> -}
> -
> -void r8712_do_queue_select(struct _adapter *padapter, struct pkt_attrib =
*pattrib)
> -{
> - unsigned int qsel =3D 0;
> - struct dvobj_priv *pdvobj =3D &padapter->dvobjpriv;
>=20
> -
> - if (pdvobj->nr_endpoint =3D=3D 6) {
>=20
> - qsel =3D (unsigned int)pattrib->priority;
>=20
> - } else if (pdvobj->nr_endpoint =3D=3D 4) {
>=20
> - qsel =3D (unsigned int)pattrib->priority;
>=20
> - if (qsel =3D=3D 0 || qsel =3D=3D 3)
> - qsel =3D 3;
> - else if (qsel =3D=3D 1 || qsel =3D=3D 2)
> - qsel =3D 1;
> - else if (qsel =3D=3D 4 || qsel =3D=3D 5)
> - qsel =3D 5;
> - else if (qsel =3D=3D 6 || qsel =3D=3D 7)
> - qsel =3D 7;
> - else
> - qsel =3D 3;
> - }
> - pattrib->qsel =3D qsel;
>=20
> -}
> -
> -#ifdef CONFIG_R8712_TX_AGGR
> -void r8712_construct_txaggr_cmd_desc(struct xmit_buf *pxmitbuf)
> -{
> - struct tx_desc *ptx_desc =3D (struct tx_desc *)pxmitbuf->pbuf;
>=20
> -
> - /* Fill up TxCmd Descriptor according as USB FW Tx Aggregation info./
> - / dw0 */
> - ptx_desc->txdw0 =3D cpu_to_le32(CMD_HDR_SZ & 0xffff);
>=20
> - ptx_desc->txdw0 |=3D
>=20
> - cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) &
> - 0x00ff0000);
> - ptx_desc->txdw0 |=3D cpu_to_le32(OWN | FSG | LSG);
>=20
> -
> - /* dw1 */
> - ptx_desc->txdw1 |=3D cpu_to_le32((0x13 << QSEL_SHT) & 0x00001f00);
>=20
> -}
> -
> -void r8712_construct_txaggr_cmd_hdr(struct xmit_buf *pxmitbuf)
> -{
> - struct xmit_frame *pxmitframe =3D (struct xmit_frame *)
> - pxmitbuf->priv_data;
>=20
> - struct _adapter *padapter =3D pxmitframe->padapter;
>=20
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct cmd_hdr *pcmd_hdr =3D (struct cmd_hdr *)
> - (pxmitbuf->pbuf + TXDESC_SIZE);
>=20
> -
> - /* Fill up Cmd Header for USB FW Tx Aggregation./
> - / dw0 */
> - pcmd_hdr->cmd_dw0 =3D cpu_to_le32((GEN_CMD_CODE(_AMSDU_TO_AMPDU) << 16)=
 |
>=20
> - (pcmdpriv->cmd_seq << 24));
>=20
> - pcmdpriv->cmd_seq++;
>=20
> -}
> -
> -void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
> - struct xmit_frame *pxmitframe)
> -{
> - struct _adapter *padapter =3D pxmitframe->padapter;
>=20
> - struct tx_desc *ptx_desc =3D (struct tx_desc *)pxmitbuf->pbuf;
>=20
> - int last_txcmdsz =3D 0;
> - int padding_sz =3D 0;
> -
> - /* 802.3->802.11 converter */
>=20
> - r8712_xmitframe_coalesce(padapter, pxmitframe->pkt, pxmitframe);
>=20
> - /* free skb struct */
> - r8712_xmit_complete(padapter, pxmitframe);
> - if (pxmitframe->attrib.ether_type !=3D 0x0806) {
>=20
> - if ((pxmitframe->attrib.ether_type !=3D 0x888e) &&
>=20
> - (pxmitframe->attrib.dhcp_pkt !=3D 1)) {
>=20
> - r8712_issue_addbareq_cmd(padapter, pxmitframe->attrib.priority);
>=20
> - }
> - }
> - pxmitframe->last[0] =3D 1;
>=20
> - update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr), pxmitframe->a=
ttrib.last_txcmdsz);
>=20
> - /*padding zero */
> - last_txcmdsz =3D pxmitframe->attrib.last_txcmdsz;
>=20
> - padding_sz =3D (8 - (last_txcmdsz % 8));
> - if ((last_txcmdsz % 8) !=3D 0) {
> - int i;
> -
> - for (i =3D 0; i < padding_sz; i++)
> - *(pxmitframe->buf_addr + TXDESC_SIZE + last_txcmdsz +
>=20
> - i) =3D 0;
> - }
> - /* Add the new mpdu's length */
> - ptx_desc->txdw0 =3D cpu_to_le32((ptx_desc->txdw0 & 0xffff0000) |
>=20
> - ((ptx_desc->txdw0 & 0x0000ffff) +
>=20
> - ((TXDESC_SIZE + last_txcmdsz + padding_sz) &
> - 0x0000ffff)));
> -}
> -
> -void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
> - struct xmit_frame pxmitframe)
> -{
> - / linux complete context doesn't need to protect */
> - pxmitframe->pxmitbuf =3D pxmitbuf;
>=20
> - pxmitbuf->priv_data =3D pxmitframe;
>=20
> - pxmitframe->pxmit_urb[0] =3D pxmitbuf->pxmit_urb[0];
>=20
> - /* buffer addr assoc */
> - pxmitframe->buf_addr =3D pxmitbuf->pbuf + TXDESC_SIZE + CMD_HDR_SZ;
>=20
> - /*RTL8712_DMA_H2CCMD */
> - r8712_construct_txaggr_cmd_desc(pxmitbuf);
> - r8712_construct_txaggr_cmd_hdr(pxmitbuf);
> - r8712_append_mpdu_unit(pxmitbuf, pxmitframe);
> - pxmitbuf->aggr_nr =3D 1;
>=20
> -}
> -
> -u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf, struct xmit_fra=
me *pxmitframe)
> -{
> - pxmitframe->pxmitbuf =3D pxmitbuf;
>=20
> - pxmitbuf->priv_data =3D pxmitframe;
>=20
> - pxmitframe->pxmit_urb[0] =3D pxmitbuf->pxmit_urb[0];
>=20
> - /* buffer addr assoc */
> - pxmitframe->buf_addr =3D pxmitbuf->pbuf + TXDESC_SIZE +
>=20
> - (((struct tx_desc *)pxmitbuf->pbuf)->txdw0 & 0x0000ffff);
>=20
> - r8712_append_mpdu_unit(pxmitbuf, pxmitframe);
> - r8712_free_xmitframe_ex(&pxmitframe->padapter->xmitpriv,
>=20
> - pxmitframe);
> - pxmitbuf->aggr_nr++;
>=20
> -
> - return TXDESC_SIZE +
> - (((struct tx_desc *)pxmitbuf->pbuf)->txdw0 & 0x0000ffff);
>=20
> -}
> -
> -void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
> - struct xmit_frame *pxmitframe)
> -{
> - struct _adapter *padapter =3D pxmitframe->padapter;
>=20
> - struct dvobj_priv *pdvobj =3D &padapter->dvobjpriv;
>=20
> - struct tx_desc *ptxdesc =3D pxmitbuf->pbuf;
>=20
> - struct cmd_hdr *pcmd_hdr =3D (struct cmd_hdr *)
> - (pxmitbuf->pbuf + TXDESC_SIZE);
>=20
> - u16 total_length =3D (u16)(ptxdesc->txdw0 & 0xffff);
>=20
> -
> - /* use 1st xmitframe as media */
> - xmitframe_xmitbuf_attach(pxmitframe, pxmitbuf);
> - pcmd_hdr->cmd_dw0 =3D cpu_to_le32(((total_length - CMD_HDR_SZ) &
>=20
> - 0x0000ffff) | (pcmd_hdr->cmd_dw0 &
>=20
> - 0xffff0000));
> -
> - /* urb length in cmd_dw1 */
> - pcmd_hdr->cmd_dw1 =3D cpu_to_le32((pxmitbuf->aggr_nr & 0xff) |
>=20
> - ((total_length + TXDESC_SIZE) << 16));
> - pxmitframe->last[0] =3D 1;
>=20
> - pxmitframe->bpending[0] =3D false;
>=20
> - pxmitframe->mem_addr =3D pxmitbuf->pbuf;
>=20
> -
> - if ((pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) % 0x200) =3D=
=3D 0) ||
>=20
> - ((!pdvobj->ishighspeed && ((total_length + TXDESC_SIZE) %
>=20
> - 0x40) =3D=3D 0))) {
> - ptxdesc->txdw0 |=3D cpu_to_le32
>=20
> - (((TXDESC_SIZE + OFFSET_SZ + 8) << OFFSET_SHT) &
> - 0x00ff0000);
> - /32 bytes for TX Desc + 8 bytes pending/
> - } else {
> - ptxdesc->txdw0 |=3D cpu_to_le32
>=20
> - (((TXDESC_SIZE + OFFSET_SZ) << OFFSET_SHT) &
> - 0x00ff0000);
> - /default =3D 32 bytes for TX Desc/
> - }
> - r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD, total_length=
 + TXDESC_SIZE,
>=20
> - (u8 *)pxmitframe);
> -}
> -
> -#endif
> -
> -static void update_txdesc(struct xmit_frame *pxmitframe, uint *pmem, int=
 sz)
> -{
> - uint qsel;
> - struct _adapter *padapter =3D pxmitframe->padapter;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct qos_priv *pqospriv =3D &pmlmepriv->qospriv;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> - struct tx_desc *ptxdesc =3D (struct tx_desc *)pmem;
> - struct dvobj_priv *pdvobj =3D &padapter->dvobjpriv;
>=20
> -#ifdef CONFIG_R8712_TX_AGGR
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -#endif
> - u8 blnSetTxDescOffset;
> - bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
>=20
> - struct ht_priv *phtpriv =3D &pmlmepriv->htpriv;
>=20
> - struct tx_desc txdesc_mp;
> -
> - memcpy(&txdesc_mp, ptxdesc, sizeof(struct tx_desc));
> - memset(ptxdesc, 0, sizeof(struct tx_desc));
> - /* offset 0 */
> - ptxdesc->txdw0 |=3D cpu_to_le32(sz & 0x0000ffff);
>=20
> - if (pdvobj->ishighspeed) {
>=20
> - if (((sz + TXDESC_SIZE) % 512) =3D=3D 0)
> - blnSetTxDescOffset =3D 1;
> - else
> - blnSetTxDescOffset =3D 0;
> - } else {
> - if (((sz + TXDESC_SIZE) % 64) =3D=3D 0)
> - blnSetTxDescOffset =3D 1;
> - else
> - blnSetTxDescOffset =3D 0;
> - }
> - if (blnSetTxDescOffset) {
> - /* 32 bytes for TX Desc + 8 bytes pending */
> - ptxdesc->txdw0 |=3D cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ + 8) <<
>=20
> - OFFSET_SHT) & 0x00ff0000);
> - } else {
> - /* default =3D 32 bytes for TX Desc */
> - ptxdesc->txdw0 |=3D cpu_to_le32(((TXDESC_SIZE + OFFSET_SZ) <<
>=20
> - OFFSET_SHT) & 0x00ff0000);
> - }
> - ptxdesc->txdw0 |=3D cpu_to_le32(OWN | FSG | LSG);
>=20
> - if (pxmitframe->frame_tag =3D=3D DATA_FRAMETAG) {
>=20
> - /* offset 4 */
> - ptxdesc->txdw1 |=3D cpu_to_le32((pattrib->mac_id) & 0x1f);
>=20
> -
> -#ifdef CONFIG_R8712_TX_AGGR
> - /* dirty workaround, need to check if it is aggr cmd. */
> - if ((u8 *)pmem !=3D (u8 *)pxmitframe->pxmitbuf->pbuf) {
>=20
> - ptxdesc->txdw0 |=3D cpu_to_le32
>=20
> - ((0x3 << TYPE_SHT) & TYPE_MSK);
> - qsel =3D (uint)(pattrib->qsel & 0x0000001f);
>=20
> - if (qsel =3D=3D 2)
> - qsel =3D 0;
> - ptxdesc->txdw1 |=3D cpu_to_le32
>=20
> - ((qsel << QSEL_SHT) & 0x00001f00);
> - ptxdesc->txdw2 =3D cpu_to_le32
>=20
> - ((qsel << RTS_RC_SHT) & 0x001f0000);
> - ptxdesc->txdw6 |=3D cpu_to_le32
>=20
> - ((0x5 << RSVD6_SHT) & RSVD6_MSK);
> - } else {
> - ptxdesc->txdw0 |=3D cpu_to_le32
>=20
> - ((0x3 << TYPE_SHT) & TYPE_MSK);
> - ptxdesc->txdw1 |=3D cpu_to_le32
>=20
> - ((0x13 << QSEL_SHT) & 0x00001f00);
> - qsel =3D (uint)(pattrib->qsel & 0x0000001f);
>=20
> - if (qsel =3D=3D 2)
> - qsel =3D 0;
> - ptxdesc->txdw2 =3D cpu_to_le32
>=20
> - ((qsel << RTS_RC_SHT) & 0x0001f000);
> - ptxdesc->txdw7 |=3D cpu_to_le32
>=20
> - (pcmdpriv->cmd_seq << 24);
>=20
> - pcmdpriv->cmd_seq++;
>=20
> - }
> - pattrib->qsel =3D 0x13;
>=20
> -#else
> - qsel =3D (uint)(pattrib->qsel & 0x0000001f);
>=20
> - ptxdesc->txdw1 |=3D cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
>=20
> -#endif
> - if (!pqospriv->qos_option)
>=20
> - ptxdesc->txdw1 |=3D cpu_to_le32(BIT(16));/Non-QoS/
>=20
> - if ((pattrib->encrypt > 0) && !pattrib->bswenc) {
>=20
> - switch (pattrib->encrypt) { /SEC_TYPE/
>=20
> - case WEP40:
> - case WEP104:
> - ptxdesc->txdw1 |=3D cpu_to_le32((0x01 << 22) &
>=20
> - 0x00c00000);
> - /KEY_ID when WEP is used;/
> - ptxdesc->txdw1 |=3D
>=20
> - cpu_to_le32((psecuritypriv->PrivacyKeyIndex << 17) &
>=20
> - 0x00060000);
> - break;
> - case TKIP:
> - case TKIP_WTMIC:
> - ptxdesc->txdw1 |=3D cpu_to_le32((0x02 << 22) &
>=20
> - 0x00c00000);
> - break;
> - case AES:
> - ptxdesc->txdw1 |=3D cpu_to_le32((0x03 << 22) &
>=20
> - 0x00c00000);
> - break;
> - case NO_PRIVACY:
> - default:
> - break;
> - }
> - }
> - /offset 8/
> - if (bmcst)
> - ptxdesc->txdw2 |=3D cpu_to_le32(BMC);
>=20
> -
> - /offset 12/
> - /* f/w will increase the seqnum by itself, driver pass the
> - * correct priority to fw.
> - * fw will check the correct priority for increasing the
> - * seqnum per tid. about usb using 4-endpoint, qsel points out
> - * the correct mapping between AC&Endpoint,
> - * the purpose is that correct mapping lets the MAC release
> - * the AC Queue list correctly.
> - */
> - ptxdesc->txdw3 =3D cpu_to_le32((pattrib->priority << SEQ_SHT) &
>=20
> - 0x0fff0000);
> - if ((pattrib->ether_type !=3D 0x888e) &&
>=20
> - (pattrib->ether_type !=3D 0x0806) &&
>=20
> - (pattrib->dhcp_pkt !=3D 1)) {
>=20
> - /Not EAP & ARP type data packet/
> - if (phtpriv->ht_option =3D=3D 1) { /B/G/N Mode/
>=20
> - if (!phtpriv->ampdu_enable)
>=20
> - ptxdesc->txdw2 |=3D cpu_to_le32(BK);
>=20
> - }
> - } else {
> - /* EAP data packet and ARP packet.
> - * Use the 1M data rate to send the EAP/ARP packet.
> - * This will maybe make the handshake smooth.
> - */
> - /driver uses data rate/
> - ptxdesc->txdw4 =3D cpu_to_le32(0x80000000);
>=20
> - ptxdesc->txdw5 =3D cpu_to_le32(0x001f8000);/1M/
>=20
> - }
> - if (pattrib->pctrl =3D=3D 1) { /* mp tx packets */
>=20
> - struct tx_desc ptxdesc_mp;
> -
> - ptxdesc_mp =3D &txdesc_mp;
> - / offset 8 */
> - ptxdesc->txdw2 =3D ptxdesc_mp->txdw2;
>=20
> - if (bmcst)
> - ptxdesc->txdw2 |=3D cpu_to_le32(BMC);
>=20
> - ptxdesc->txdw2 |=3D cpu_to_le32(BK);
>=20
> - /* offset 16 */
> - ptxdesc->txdw4 =3D ptxdesc_mp->txdw4;
>=20
> - /* offset 20 */
> - ptxdesc->txdw5 =3D ptxdesc_mp->txdw5;
>=20
> - pattrib->pctrl =3D 0;/* reset to zero; */
>=20
> - }
> - } else if (pxmitframe->frame_tag =3D=3D MGNT_FRAMETAG) {
>=20
> - /* offset 4 /
> - / CAM_ID(MAC_ID), default=3D5; */
> - ptxdesc->txdw1 |=3D cpu_to_le32((0x05) & 0x1f);
>=20
> - qsel =3D (uint)(pattrib->qsel & 0x0000001f);
>=20
> - ptxdesc->txdw1 |=3D cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
>=20
> - ptxdesc->txdw1 |=3D cpu_to_le32(BIT(16));/* Non-QoS */
>=20
> - /* offset 8 */
> - if (bmcst)
> - ptxdesc->txdw2 |=3D cpu_to_le32(BMC);
>=20
> - /* offset 12 /
> - / f/w will increase the seqnum by itself, driver pass the
> - * correct priority to fw.
> - * fw will check the correct priority for increasing the seqnum
> - * per tid. about usb using 4-endpoint, qsel points out the
> - * correct mapping between AC&Endpoint,
> - * the purpose is that correct mapping let the MAC releases
> - * the AC Queue list correctly.
> - */
> - ptxdesc->txdw3 =3D cpu_to_le32((pattrib->priority << SEQ_SHT) &
>=20
> - 0x0fff0000);
> - /* offset 16 */
> - ptxdesc->txdw4 =3D cpu_to_le32(0x80002040);/gtest/
>=20
> - /* offset 20 /
> - ptxdesc->txdw5 =3D cpu_to_le32(0x001f8000);/ gtest 1M */
>=20
> - } else if (pxmitframe->frame_tag =3D=3D TXAGG_FRAMETAG) {
>=20
> - /* offset 4 */
> - qsel =3D 0x13;
> - ptxdesc->txdw1 |=3D cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
>=20
> - } else {
> - /* offset 4 */
> - qsel =3D (uint)(pattrib->priority & 0x0000001f);
>=20
> - ptxdesc->txdw1 |=3D cpu_to_le32((qsel << QSEL_SHT) & 0x00001f00);
>=20
> - /offset 8/
> - /offset 12/
> - ptxdesc->txdw3 =3D cpu_to_le32((pattrib->seqnum << SEQ_SHT) &
>=20
> - 0x0fff0000);
> - /offset 16/
> - ptxdesc->txdw4 =3D cpu_to_le32(0x80002040);/gtest/
>=20
> - /offset 20/
> - ptxdesc->txdw5 =3D cpu_to_le32(0x001f9600);/gtest/
>=20
> - }
> -}
> -
> -int r8712_xmitframe_complete(struct _adapter *padapter,
> - struct xmit_priv *pxmitpriv,
> - struct xmit_buf *pxmitbuf)
> -{
> - struct hw_xmit *phwxmits;
> - sint hwentry;
> - struct xmit_frame *pxmitframe =3D NULL;
> -#ifdef CONFIG_R8712_TX_AGGR
> - struct xmit_frame *p2ndxmitframe =3D NULL;
> -#else
> - int res =3D _SUCCESS;
> -#endif
> -
> - phwxmits =3D pxmitpriv->hwxmits;
>=20
> - hwentry =3D pxmitpriv->hwxmit_entry;
>=20
> - if (!pxmitbuf) {
> - pxmitbuf =3D r8712_alloc_xmitbuf(pxmitpriv);
> - if (!pxmitbuf)
> - return false;
> -#ifdef CONFIG_R8712_TX_AGGR
> - pxmitbuf->aggr_nr =3D 0;
>=20
> -#endif
> - }
> - /* 1st frame dequeued /
> - pxmitframe =3D dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
> - / need to remember the 1st frame /
> - if (pxmitframe) {
> -#ifdef CONFIG_R8712_TX_AGGR
> - / 1. dequeue 2nd frame
> - * 2. aggr if 2nd xframe is dequeued, else dump directly
> - */
> - if (AGGR_NR_HIGH_BOUND > 1)
>=20
> - p2ndxmitframe =3D dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
> - if (pxmitframe->frame_tag !=3D DATA_FRAMETAG) {
>=20
> - r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
> - return false;
> - }
> - if (p2ndxmitframe)
> - if (p2ndxmitframe->frame_tag !=3D DATA_FRAMETAG) {
>=20
> - r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
> - return false;
> - }
> - r8712_xmitframe_aggr_1st(pxmitbuf, pxmitframe);
> - if (p2ndxmitframe) {
> - u16 total_length;
> -
> - total_length =3D r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
> - do {
> - p2ndxmitframe =3D dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
> - if (p2ndxmitframe)
> - total_length =3D
> - r8712_xmitframe_aggr_next(pxmitbuf, p2ndxmitframe);
> - else
> - break;
> - } while (total_length <=3D 0x1800 &&
> - pxmitbuf->aggr_nr <=3D AGGR_NR_HIGH_BOUND);
>=20
> - }
> - if (pxmitbuf->aggr_nr > 0)
>=20
> - r8712_dump_aggr_xframe(pxmitbuf, pxmitframe);
> -
> -#else
> -
> - xmitframe_xmitbuf_attach(pxmitframe, pxmitbuf);
> - if (pxmitframe->frame_tag =3D=3D DATA_FRAMETAG) {
>=20
> - if (pxmitframe->attrib.priority <=3D 15)
>=20
> - res =3D r8712_xmitframe_coalesce(padapter, pxmitframe->pkt,
>=20
> - pxmitframe);
> - /* always return ndis_packet after
> - * r8712_xmitframe_coalesce
> - /
> - r8712_xmit_complete(padapter, pxmitframe);
> - }
> - if (res =3D=3D _SUCCESS)
> - dump_xframe(padapter, pxmitframe);
> - else
> - r8712_free_xmitframe_ex(pxmitpriv, pxmitframe);
> -#endif
> -
> - } else { / pxmitframe =3D=3D NULL && p2ndxmitframe =3D=3D NULL */
> - r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
> - return false;
> - }
> - return true;
> -}
> -
> -static void dump_xframe(struct _adapter *padapter,
> - struct xmit_frame *pxmitframe)
> -{
> - int t, sz, w_sz;
> - u8 *mem_addr;
> - u32 ff_hwaddr;
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> -
> - if (pxmitframe->attrib.ether_type !=3D 0x0806) {
>=20
> - if (pxmitframe->attrib.ether_type !=3D 0x888e)
>=20
> - r8712_issue_addbareq_cmd(padapter, pattrib->priority);
>=20
> - }
> - mem_addr =3D pxmitframe->buf_addr;
>=20
> - for (t =3D 0; t < pattrib->nr_frags; t++) {
>=20
> - if (t !=3D (pattrib->nr_frags - 1)) {
>=20
> - sz =3D pxmitpriv->frag_len;
>=20
> - sz =3D sz - 4 - (psecuritypriv->sw_encrypt ? 0 :
>=20
> - pattrib->icv_len);
>=20
> - pxmitframe->last[t] =3D 0;
>=20
> - } else {
> - sz =3D pattrib->last_txcmdsz;
>=20
> - pxmitframe->last[t] =3D 1;
>=20
> - }
> - update_txdesc(pxmitframe, (uint *)mem_addr, sz);
> - w_sz =3D sz + TXDESC_SIZE;
> - pxmitframe->mem_addr =3D mem_addr;
>=20
> - pxmitframe->bpending[t] =3D false;
>=20
> - ff_hwaddr =3D get_ff_hwaddr(pxmitframe);
> -#ifdef CONFIG_R8712_TX_AGGR
> - r8712_write_port(padapter, RTL8712_DMA_H2CCMD, w_sz,
> - (unsigned char *)pxmitframe);
> -#else
> - r8712_write_port(padapter, ff_hwaddr, w_sz,
> - (unsigned char *)pxmitframe);
> -#endif
> - mem_addr +=3D w_sz;
> - mem_addr =3D (u8 *)RND4(((addr_t)(mem_addr)));
> - }
> -}
> -
> -void r8712_xmit_direct(struct _adapter *padapter, struct xmit_frame *pxm=
itframe)
> -{
> - int res;
> -
> - res =3D r8712_xmitframe_coalesce(padapter, pxmitframe->pkt, pxmitframe)=
;
>=20
> - pxmitframe->pkt =3D NULL;
>=20
> - if (res =3D=3D _SUCCESS)
> - dump_xframe(padapter, pxmitframe);
> -}
> -
> -int r8712_xmit_enqueue(struct _adapter *padapter, struct xmit_frame *pxm=
itframe)
> -{
> - if (r8712_xmit_classifier(padapter, pxmitframe)) {
> - pxmitframe->pkt =3D NULL;
>=20
> - return _FAIL;
> - }
> - return _SUCCESS;
> -}
> diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl=
8712/rtl8712_xmit.h
> deleted file mode 100644
> index 5cd651a0de75..000000000000
> --- a/drivers/staging/rtl8712/rtl8712_xmit.h
> +++ /dev/null
> @@ -1,108 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -#ifndef RTL8712_XMIT_H
> -#define RTL8712_XMIT_H
> -
> -#define HWXMIT_ENTRY 4
> -
> -#define VO_QUEUE_INX 0
> -#define VI_QUEUE_INX 1
> -#define BE_QUEUE_INX 2
> -#define BK_QUEUE_INX 3
> -#define TS_QUEUE_INX 4
> -#define MGT_QUEUE_INX 5
> -#define BMC_QUEUE_INX 6
> -#define BCN_QUEUE_INX 7
> -
> -#define HW_QUEUE_ENTRY 8
> -
> -#define TXDESC_SIZE 32
> -#define TXDESC_OFFSET TXDESC_SIZE
> -
> -#define NR_AMSDU_XMITFRAME 8
> -#define NR_TXAGG_XMITFRAME 8
> -
> -#define MAX_AMSDU_XMITBUF_SZ 8704
> -#define MAX_TXAGG_XMITBUF_SZ 16384 /16k/
> -
> -#define tx_cmd tx_desc
> -
> -/
> - *defined for TX DESC Operation
> - */
> -
> -#define MAX_TID (15)
> -
> -/OFFSET 0/
> -#define OFFSET_SZ (0)
> -#define OFFSET_SHT (16)
> -#define OWN BIT(31)
> -#define FSG BIT(27)
> -#define LSG BIT(26)
> -#define TYPE_SHT (24)
> -#define TYPE_MSK (0x03000000)
> -
> -/OFFSET 4/
> -#define PKT_OFFSET_SZ (0)
> -#define QSEL_SHT (8)
> -#define HWPC BIT(31)
> -
> -/OFFSET 8/
> -#define BMC BIT(7)
> -#define BK BIT(30)
> -#define AGG_EN BIT(29)
> -#define RTS_RC_SHT (16)
> -
> -/OFFSET 12/
> -#define SEQ_SHT (16)
> -
> -/OFFSET 16/
> -#define TXBW BIT(18)
> -
> -/OFFSET 20/
> -#define DISFB BIT(15)
> -#define RSVD6_MSK (0x00E00000)
> -#define RSVD6_SHT (21)
> -
> -struct tx_desc {
> - /DWORD 0/
> - __le32 txdw0;
> - __le32 txdw1;
> - __le32 txdw2;
> - __le32 txdw3;
> - __le32 txdw4;
> - __le32 txdw5;
> - __le32 txdw6;
> - __le32 txdw7;
> -};
> -
> -union txdesc {
> - struct tx_desc txdesc;
> - unsigned int value[TXDESC_SIZE >> 2];
>=20
> -};
> -
> -int r8712_xmitframe_complete(struct _adapter padapter,
> - struct xmit_priv pxmitpriv,
> - struct xmit_buf pxmitbuf);
> -void r8712_do_queue_select(struct _adapter padapter,
> - struct pkt_attrib pattrib);
> -
> -#ifdef CONFIG_R8712_TX_AGGR
> -void r8712_xmitframe_aggr_1st(struct xmit_buf pxmitbuf,
> - struct xmit_frame pxmitframe);
> -void r8712_dump_aggr_xframe(struct xmit_buf pxmitbuf,
> - struct xmit_frame pxmitframe);
> -#endif
> -
> -#endif
> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.c b/drivers/staging/rtl8=
712/rtl871x_cmd.c
> deleted file mode 100644
> index 21e00ec83a19..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_cmd.c
> +++ /dev/null
> @@ -1,750 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*********************************************************************
> - * rtl871x_cmd.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_CMD_C
> -
> -#include <linux/compiler.h>
>=20
> -#include <linux/kernel.h>
>=20
> -#include <linux/errno.h>
>=20
> -#include <linux/slab.h>
>=20
> -#include <linux/module.h>
>=20
> -#include <linux/kref.h>
>=20
> -#include <linux/netdevice.h>
>=20
> -#include <linux/skbuff.h>
>=20
> -#include <linux/usb.h>
>=20
> -#include <linux/usb/ch9.h>
>=20
> -#include <linux/circ_buf.h>
>=20
> -#include <linux/uaccess.h>
>=20
> -#include <asm/byteorder.h>
>=20
> -#include <linux/atomic.h>
>=20
> -#include <linux/semaphore.h>
>=20
> -#include <linux/rtnetlink.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "recv_osdep.h"
> -#include "mlme_osdep.h"
> -
> -/*
> - * Caller and the r8712_cmd_thread can protect cmd_q by spin_lock.
> - * No irqsave is necessary.
> - */
> -
> -int r8712_init_cmd_priv(struct cmd_priv *pcmdpriv)
> -{
> - init_completion(&pcmdpriv->cmd_queue_comp);
>=20
> - init_completion(&pcmdpriv->terminate_cmdthread_comp);
>=20
> -
> - _init_queue(&pcmdpriv->cmd_queue);
>=20
> -
> - /* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
> - pcmdpriv->cmd_seq =3D 1;
>=20
> - pcmdpriv->cmd_allocated_buf =3D kmalloc(MAX_CMDSZ + CMDBUFF_ALIGN_SZ,
>=20
> - GFP_ATOMIC);
> - if (!pcmdpriv->cmd_allocated_buf)
>=20
> - return -ENOMEM;
> - pcmdpriv->cmd_buf =3D pcmdpriv->cmd_allocated_buf + CMDBUFF_ALIGN_SZ -
>=20
> - ((addr_t)(pcmdpriv->cmd_allocated_buf) &
>=20
> - (CMDBUFF_ALIGN_SZ - 1));
> - pcmdpriv->rsp_allocated_buf =3D kmalloc(MAX_RSPSZ + 4, GFP_ATOMIC);
>=20
> - if (!pcmdpriv->rsp_allocated_buf) {
>=20
> - kfree(pcmdpriv->cmd_allocated_buf);
>=20
> - pcmdpriv->cmd_allocated_buf =3D NULL;
>=20
> - return -ENOMEM;
> - }
> - pcmdpriv->rsp_buf =3D pcmdpriv->rsp_allocated_buf + 4 -
>=20
> - ((addr_t)(pcmdpriv->rsp_allocated_buf) & 3);
>=20
> - pcmdpriv->cmd_issued_cnt =3D 0;
>=20
> - pcmdpriv->cmd_done_cnt =3D 0;
>=20
> - pcmdpriv->rsp_cnt =3D 0;
>=20
> - return 0;
> -}
> -
> -int r8712_init_evt_priv(struct evt_priv pevtpriv)
> -{
> - / allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
> - pevtpriv->event_seq =3D 0;
>=20
> - pevtpriv->evt_allocated_buf =3D kmalloc(MAX_EVTSZ + 4, GFP_ATOMIC);
>=20
> -
> - if (!pevtpriv->evt_allocated_buf)
>=20
> - return -ENOMEM;
> - pevtpriv->evt_buf =3D pevtpriv->evt_allocated_buf + 4 -
>=20
> - ((addr_t)(pevtpriv->evt_allocated_buf) & 3);
>=20
> - pevtpriv->evt_done_cnt =3D 0;
>=20
> - return 0;
> -}
> -
> -void r8712_free_evt_priv(struct evt_priv *pevtpriv)
> -{
> - kfree(pevtpriv->evt_allocated_buf);
>=20
> -}
> -
> -void r8712_free_cmd_priv(struct cmd_priv *pcmdpriv)
> -{
> - if (pcmdpriv) {
> - kfree(pcmdpriv->cmd_allocated_buf);
>=20
> - kfree(pcmdpriv->rsp_allocated_buf);
>=20
> - }
> -}
> -
> -/*
> - * Calling Context:
> - *
> - * r8712_enqueue_cmd can only be called between kernel thread,
> - * since only spin_lock is used.
> - *
> - * ISR/Call-Back functions can't call this sub-function.
> - *
> - */
> -
> -void r8712_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *obj)
> -{
> - struct __queue *queue;
> - unsigned long irqL;
> -
> - if (pcmdpriv->padapter->eeprompriv.bautoload_fail_flag)
>=20
> - return;
> - if (!obj)
> - return;
> - queue =3D &pcmdpriv->cmd_queue;
>=20
> - spin_lock_irqsave(&queue->lock, irqL);
>=20
> - list_add_tail(&obj->list, &queue->queue);
>=20
> - spin_unlock_irqrestore(&queue->lock, irqL);
>=20
> - complete(&pcmdpriv->cmd_queue_comp);
>=20
> -}
> -
> -struct cmd_obj *r8712_dequeue_cmd(struct __queue *queue)
> -{
> - unsigned long irqL;
> - struct cmd_obj *obj;
> -
> - spin_lock_irqsave(&queue->lock, irqL);
>=20
> - obj =3D list_first_entry_or_null(&queue->queue,
>=20
> - struct cmd_obj, list);
> - if (obj)
> - list_del_init(&obj->list);
>=20
> - spin_unlock_irqrestore(&queue->lock, irqL);
>=20
> - return obj;
> -}
> -
> -void r8712_enqueue_cmd_ex(struct cmd_priv *pcmdpriv, struct cmd_obj *obj=
)
> -{
> - unsigned long irqL;
> - struct __queue *queue;
> -
> - if (!obj)
> - return;
> - if (pcmdpriv->padapter->eeprompriv.bautoload_fail_flag)
>=20
> - return;
> - queue =3D &pcmdpriv->cmd_queue;
>=20
> - spin_lock_irqsave(&queue->lock, irqL);
>=20
> - list_add_tail(&obj->list, &queue->queue);
>=20
> - spin_unlock_irqrestore(&queue->lock, irqL);
>=20
> - complete(&pcmdpriv->cmd_queue_comp);
>=20
> -}
> -
> -void r8712_free_cmd_obj(struct cmd_obj *pcmd)
> -{
> - if ((pcmd->cmdcode !=3D JoinBss_CMD) &&
>=20
> - (pcmd->cmdcode !=3D CreateBss_CMD))
>=20
> - kfree(pcmd->parmbuf);
>=20
> - if (pcmd->rsp) {
>=20
> - if (pcmd->rspsz !=3D 0)
>=20
> - kfree(pcmd->rsp);
>=20
> - }
> - kfree(pcmd);
> -}
> -
> -u8 r8712_sitesurvey_cmd(struct _adapter *padapter,
> - struct ndis_802_11_ssid *pssid)
> - __must_hold(&padapter->mlmepriv.lock)
>=20
> -{
> - struct cmd_obj *ph2c;
> - struct sitesurvey_parm *psurveyPara;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return _FAIL;
> - psurveyPara =3D kmalloc(sizeof(*psurveyPara), GFP_ATOMIC);
> - if (!psurveyPara) {
> - kfree(ph2c);
> - return _FAIL;
> - }
> - init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara,
> - GEN_CMD_CODE(_SiteSurvey));
> - psurveyPara->bsslimit =3D cpu_to_le32(48);
>=20
> - psurveyPara->passive_mode =3D cpu_to_le32(pmlmepriv->passive_mode);
>=20
> - psurveyPara->ss_ssidlen =3D 0;
>=20
> - memset(psurveyPara->ss_ssid, 0, IW_ESSID_MAX_SIZE + 1);
>=20
> - if (pssid && pssid->SsidLength) {
>=20
> - int len =3D min_t(int, pssid->SsidLength, IW_ESSID_MAX_SIZE);
>=20
> -
> - memcpy(psurveyPara->ss_ssid, pssid->Ssid, len);
>=20
> - psurveyPara->ss_ssidlen =3D cpu_to_le32(len);
>=20
> - }
> - set_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> - mod_timer(&pmlmepriv->scan_to_timer,
>=20
> - jiffies + msecs_to_jiffies(SCANNING_TIMEOUT));
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_SITE_SURVEY);
>=20
> - complete(&padapter->rx_filter_ready);
>=20
> - return _SUCCESS;
> -}
> -
> -int r8712_setdatarate_cmd(struct _adapter *padapter, u8 *rateset)
> -{
> - struct cmd_obj *ph2c;
> - struct setdatarate_parm *pbsetdataratepara;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return -ENOMEM;
> - pbsetdataratepara =3D kmalloc(sizeof(*pbsetdataratepara), GFP_ATOMIC);
> - if (!pbsetdataratepara) {
> - kfree(ph2c);
> - return -ENOMEM;
> - }
> - init_h2fwcmd_w_parm_no_rsp(ph2c, pbsetdataratepara,
> - GEN_CMD_CODE(_SetDataRate));
> - pbsetdataratepara->mac_id =3D 5;
>=20
> - memcpy(pbsetdataratepara->datarates, rateset, NumRates);
>=20
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> - return 0;
> -}
> -
> -void r8712_set_chplan_cmd(struct _adapter *padapter, int chplan)
> -{
> - struct cmd_obj *ph2c;
> - struct SetChannelPlan_param *psetchplanpara;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return;
> - psetchplanpara =3D kmalloc(sizeof(*psetchplanpara), GFP_ATOMIC);
> - if (!psetchplanpara) {
> - kfree(ph2c);
> - return;
> - }
> - init_h2fwcmd_w_parm_no_rsp(ph2c, psetchplanpara, GEN_CMD_CODE(_SetChann=
elPlan));
> - psetchplanpara->ChannelPlan =3D chplan;
>=20
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> -}
> -
> -int r8712_setrfreg_cmd(struct _adapter *padapter, u8 offset, u32 val)
> -{
> - struct cmd_obj *ph2c;
> - struct writeRF_parm *pwriterfparm;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return -ENOMEM;
> - pwriterfparm =3D kmalloc(sizeof(*pwriterfparm), GFP_ATOMIC);
> - if (!pwriterfparm) {
> - kfree(ph2c);
> - return -ENOMEM;
> - }
> - init_h2fwcmd_w_parm_no_rsp(ph2c, pwriterfparm, GEN_CMD_CODE(_SetRFReg))=
;
> - pwriterfparm->offset =3D offset;
>=20
> - pwriterfparm->value =3D val;
>=20
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> - return 0;
> -}
> -
> -int r8712_getrfreg_cmd(struct _adapter *padapter, u8 offset, u8 *pval)
> -{
> - struct cmd_obj *ph2c;
> - struct readRF_parm *prdrfparm;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return -ENOMEM;
> - prdrfparm =3D kmalloc(sizeof(*prdrfparm), GFP_ATOMIC);
> - if (!prdrfparm) {
> - kfree(ph2c);
> - return -ENOMEM;
> - }
> - INIT_LIST_HEAD(&ph2c->list);
>=20
> - ph2c->cmdcode =3D GEN_CMD_CODE(_GetRFReg);
>=20
> - ph2c->parmbuf =3D (unsigned char *)prdrfparm;
>=20
> - ph2c->cmdsz =3D sizeof(struct readRF_parm);
>=20
> - ph2c->rsp =3D pval;
>=20
> - ph2c->rspsz =3D sizeof(struct readRF_rsp);
>=20
> - prdrfparm->offset =3D offset;
>=20
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> - return 0;
> -}
> -
> -void r8712_getbbrfreg_cmdrsp_callback(struct _adapter *padapter,
> - struct cmd_obj *pcmd)
> -{
> - kfree(pcmd->parmbuf);
>=20
> - kfree(pcmd);
> - padapter->mppriv.workparam.bcompleted =3D true;
>=20
> -}
> -
> -void r8712_readtssi_cmdrsp_callback(struct _adapter *padapter, struct cm=
d_obj *pcmd)
> -{
> - kfree(pcmd->parmbuf);
>=20
> - kfree(pcmd);
> -
> - padapter->mppriv.workparam.bcompleted =3D true;
>=20
> -}
> -
> -int r8712_createbss_cmd(struct _adapter *padapter)
> -{
> - struct cmd_obj *pcmd;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct wlan_bssid_ex *pdev_network =3D
> - &padapter->registrypriv.dev_network;
>=20
> -
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_START_TO_LINK);
>=20
> - pcmd =3D kmalloc(sizeof(*pcmd), GFP_ATOMIC);
> - if (!pcmd)
> - return -ENOMEM;
> - INIT_LIST_HEAD(&pcmd->list);
>=20
> - pcmd->cmdcode =3D CreateBss_CMD;
>=20
> - pcmd->parmbuf =3D (unsigned char *)pdev_network;
>=20
> - pcmd->cmdsz =3D r8712_get_wlan_bssid_ex_sz(pdev_network);
>=20
> - pcmd->rsp =3D NULL;
>=20
> - pcmd->rspsz =3D 0;
>=20
> - /* notes: translate IELength & Length after assign to cmdsz; */
> - pdev_network->Length =3D pcmd->cmdsz;
>=20
> - pdev_network->IELength =3D pdev_network->IELength;
>=20
> - pdev_network->Ssid.SsidLength =3D pdev_network->Ssid.SsidLength;
>=20
> - r8712_enqueue_cmd(pcmdpriv, pcmd);
> - return 0;
> -}
> -
> -int r8712_joinbss_cmd(struct _adapter *padapter, struct wlan_network *pn=
etwork)
> -{
> - struct wlan_bssid_ex *psecnetwork;
> - struct cmd_obj *pcmd;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct qos_priv *pqospriv =3D &pmlmepriv->qospriv;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - struct registry_priv *pregistrypriv =3D &padapter->registrypriv;
>=20
> - enum NDIS_802_11_NETWORK_INFRASTRUCTURE ndis_network_mode =3D
> - pnetwork->network.InfrastructureMode;
>=20
> -
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_START_TO_LINK);
>=20
> - pcmd =3D kmalloc(sizeof(pcmd), GFP_ATOMIC);
> - if (!pcmd)
> - return -ENOMEM;
> -
> - / for hidden ap to set fw_state here */
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_ADHOC_STATE) !=
=3D
> - true) {
> - switch (ndis_network_mode) {
> - case Ndis802_11IBSS:
> - pmlmepriv->fw_state |=3D WIFI_ADHOC_STATE;
>=20
> - break;
> - case Ndis802_11Infrastructure:
> - pmlmepriv->fw_state |=3D WIFI_STATION_STATE;
>=20
> - break;
> - case Ndis802_11APMode:
> - case Ndis802_11AutoUnknown:
> - case Ndis802_11InfrastructureMax:
> - break;
> - }
> - }
> - psecnetwork =3D &psecuritypriv->sec_bss;
>=20
> - memcpy(psecnetwork, &pnetwork->network, sizeof(*psecnetwork));
>=20
> - psecuritypriv->authenticator_ie[0] =3D (unsigned char)
>=20
> - psecnetwork->IELength;
>=20
> - if ((psecnetwork->IELength - 12) < (256 - 1))
>=20
> - memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12],
>=20
> - psecnetwork->IELength - 12);
>=20
> - else
> - memcpy(&psecuritypriv->authenticator_ie[1], &psecnetwork->IEs[12], (256=
 - 1));
>=20
> - psecnetwork->IELength =3D 0;
>=20
> - /*
> - * If the driver wants to use the bssid to create the connection.
> - * If not, we copy the connecting AP's MAC address to it so that
> - * the driver just has the bssid information for PMKIDList searching.
> - */
> - if (!pmlmepriv->assoc_by_bssid)
>=20
> - ether_addr_copy(&pmlmepriv->assoc_bssid[0],
>=20
> - &pnetwork->network.MacAddress[0]);
>=20
> - psecnetwork->IELength =3D r8712_restruct_sec_ie(padapter, &pnetwork->ne=
twork.IEs[0],
>=20
> - &psecnetwork->IEs[0], pnetwork->network.IELength);
>=20
> - pqospriv->qos_option =3D 0;
>=20
> - if (pregistrypriv->wmm_enable) {
>=20
> - u32 tmp_len;
> -
> - tmp_len =3D r8712_restruct_wmm_ie(padapter, &pnetwork->network.IEs[0],
>=20
> - &psecnetwork->IEs[0], pnetwork->network.IELength,
>=20
> - psecnetwork->IELength);
>=20
> - if (psecnetwork->IELength !=3D tmp_len) {
>=20
> - psecnetwork->IELength =3D tmp_len;
>=20
> - pqospriv->qos_option =3D 1; /* WMM IE in beacon */
>=20
> - } else {
> - pqospriv->qos_option =3D 0; /* no WMM IE in beacon */
>=20
> - }
> - }
> - if (pregistrypriv->ht_enable) {
>=20
> - /*
> - * For WEP mode, we will use the bg mode to do the connection
> - * to avoid some IOT issues, especially for Realtek 8192u
> - * SoftAP.
> - */
> - if ((padapter->securitypriv.privacy_algorithm !=3D WEP40) &&
>=20
> - (padapter->securitypriv.privacy_algorithm !=3D WEP104)) {
>=20
> - /* restructure_ht_ie */
> - r8712_restructure_ht_ie(padapter,
> - &pnetwork->network.IEs[0],
>=20
> - &psecnetwork->IEs[0],
>=20
> - pnetwork->network.IELength,
>=20
> - &psecnetwork->IELength);
>=20
> - }
> - }
> - psecuritypriv->supplicant_ie[0] =3D (u8)psecnetwork->IELength;
>=20
> - if (psecnetwork->IELength < 255)
>=20
> - memcpy(&psecuritypriv->supplicant_ie[1], &psecnetwork->IEs[0],
>=20
> - psecnetwork->IELength);
>=20
> - else
> - memcpy(&psecuritypriv->supplicant_ie[1], &psecnetwork->IEs[0],
>=20
> - 255);
> - /* get cmdsz before endian conversion */
> - pcmd->cmdsz =3D r8712_get_wlan_bssid_ex_sz(psecnetwork);
>=20
> -#ifdef __BIG_ENDIAN
> - /* wlan_network endian conversion */
> - psecnetwork->Length =3D cpu_to_le32(psecnetwork->Length);
>=20
> - psecnetwork->Ssid.SsidLength =3D cpu_to_le32(psecnetwork->Ssid.SsidLeng=
th);
>=20
> - psecnetwork->Privacy =3D cpu_to_le32(psecnetwork->Privacy);
>=20
> - psecnetwork->Rssi =3D cpu_to_le32(psecnetwork->Rssi);
>=20
> - psecnetwork->NetworkTypeInUse =3D cpu_to_le32(psecnetwork->NetworkTypeI=
nUse);
>=20
> - psecnetwork->Configuration.ATIMWindow =3D cpu_to_le32(psecnetwork->Conf=
iguration.ATIMWindow);
>=20
> - psecnetwork->Configuration.BeaconPeriod =3D cpu_to_le32(psecnetwork->Co=
nfiguration.BeaconPeriod);
>=20
> - psecnetwork->Configuration.DSConfig =3D cpu_to_le32(psecnetwork->Config=
uration.DSConfig);
>=20
> - psecnetwork->Configuration.FHConfig.DwellTime =3D cpu_to_le32(psecnetwo=
rk->Configuration.FHConfig.DwellTime);
>=20
> - psecnetwork->Configuration.FHConfig.HopPattern =3D cpu_to_le32(psecnetw=
ork->Configuration.FHConfig.HopPattern);
>=20
> - psecnetwork->Configuration.FHConfig.HopSet =3D cpu_to_le32(psecnetwork-=
>Configuration.FHConfig.HopSet);
>=20
> - psecnetwork->Configuration.FHConfig.Length =3D cpu_to_le32(psecnetwork-=
>Configuration.FHConfig.Length);
>=20
> - psecnetwork->Configuration.Length =3D cpu_to_le32(psecnetwork->Configur=
ation.Length);
>=20
> - psecnetwork->InfrastructureMode =3D cpu_to_le32(psecnetwork->Infrastruc=
tureMode);
>=20
> - psecnetwork->IELength =3D cpu_to_le32(psecnetwork->IELength);
>=20
> -#endif
> - INIT_LIST_HEAD(&pcmd->list);
>=20
> - pcmd->cmdcode =3D JoinBss_CMD;
>=20
> - pcmd->parmbuf =3D (unsigned char *)psecnetwork;
>=20
> - pcmd->rsp =3D NULL;
>=20
> - pcmd->rspsz =3D 0;
>=20
> - r8712_enqueue_cmd(pcmdpriv, pcmd);
> - return 0;
> -}
> -
> -void r8712_disassoc_cmd(struct _adapter padapter) / for sta_mode */
> -{
> - struct cmd_obj *pdisconnect_cmd;
> - struct disconnect_parm *pdisconnect;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - pdisconnect_cmd =3D kmalloc(sizeof(*pdisconnect_cmd), GFP_ATOMIC);
> - if (!pdisconnect_cmd)
> - return;
> - pdisconnect =3D kmalloc(sizeof(*pdisconnect), GFP_ATOMIC);
> - if (!pdisconnect) {
> - kfree(pdisconnect_cmd);
> - return;
> - }
> - init_h2fwcmd_w_parm_no_rsp(pdisconnect_cmd, pdisconnect, DisConnect_CMD=
);
> - r8712_enqueue_cmd(pcmdpriv, pdisconnect_cmd);
> -}
> -
> -void r8712_setopmode_cmd(struct _adapter *padapter,
> - enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype)
> -{
> - struct cmd_obj *ph2c;
> - struct setopmode_parm *psetop;
> -
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return;
> - psetop =3D kmalloc(sizeof(*psetop), GFP_ATOMIC);
> - if (!psetop) {
> - kfree(ph2c);
> - return;
> - }
> - init_h2fwcmd_w_parm_no_rsp(ph2c, psetop, SetOpMode_CMD);
> - psetop->mode =3D (u8)networktype;
>=20
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> -}
> -
> -void r8712_setstakey_cmd(struct _adapter *padapter, u8 *psta, u8 unicast=
_key)
> -{
> - struct cmd_obj *ph2c;
> - struct set_stakey_parm *psetstakey_para;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct set_stakey_rsp *psetstakey_rsp =3D NULL;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - struct sta_info *sta =3D (struct sta_info *)psta;
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return;
> - psetstakey_para =3D kmalloc(sizeof(*psetstakey_para), GFP_ATOMIC);
> - if (!psetstakey_para) {
> - kfree(ph2c);
> - return;
> - }
> - psetstakey_rsp =3D kmalloc(sizeof(*psetstakey_rsp), GFP_ATOMIC);
> - if (!psetstakey_rsp) {
> - kfree(ph2c);
> - kfree(psetstakey_para);
> - return;
> - }
> - init_h2fwcmd_w_parm_no_rsp(ph2c, psetstakey_para, SetStaKey_CMD);
> - ph2c->rsp =3D (u8 *)psetstakey_rsp;
>=20
> - ph2c->rspsz =3D sizeof(struct set_stakey_rsp);
>=20
> - ether_addr_copy(psetstakey_para->addr, sta->hwaddr);
>=20
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> - psetstakey_para->algorithm =3D (unsigned char)
>=20
> - psecuritypriv->privacy_algorithm;
>=20
> - else
> - GET_ENCRY_ALGO(psecuritypriv, sta, psetstakey_para->algorithm, false);
>=20
> - if (unicast_key)
> - memcpy(&psetstakey_para->key, &sta->x_UncstKey, 16);
>=20
> - else
> - memcpy(&psetstakey_para->key,
>=20
> - &psecuritypriv->XGrpKey[psecuritypriv->XGrpKeyid - 1].skey,
>=20
> - 16);
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> -}
> -
> -void r8712_setMacAddr_cmd(struct _adapter *padapter, const u8 *mac_addr)
> -{
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct cmd_obj *ph2c;
> - struct SetMacAddr_param *psetMacAddr_para;
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return;
> - psetMacAddr_para =3D kmalloc(sizeof(*psetMacAddr_para), GFP_ATOMIC);
> - if (!psetMacAddr_para) {
> - kfree(ph2c);
> - return;
> - }
> - init_h2fwcmd_w_parm_no_rsp(ph2c, psetMacAddr_para, SetMacAddress_CMD);
> - ether_addr_copy(psetMacAddr_para->MacAddr, mac_addr);
>=20
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> -}
> -
> -void r8712_addbareq_cmd(struct _adapter *padapter, u8 tid)
> -{
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> - struct cmd_obj *ph2c;
> - struct addBaReq_parm *paddbareq_parm;
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return;
> - paddbareq_parm =3D kmalloc(sizeof(*paddbareq_parm), GFP_ATOMIC);
> - if (!paddbareq_parm) {
> - kfree(ph2c);
> - return;
> - }
> - paddbareq_parm->tid =3D tid;
>=20
> - init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm, GEN_CMD_CODE(_AddBAReq=
));
> - r8712_enqueue_cmd_ex(pcmdpriv, ph2c);
> -}
> -
> -void r8712_wdg_wk_cmd(struct _adapter *padapter)
> -{
> - struct cmd_obj *ph2c;
> - struct drvint_cmd_parm *pdrvintcmd_param;
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return;
> - pdrvintcmd_param =3D kmalloc(sizeof(*pdrvintcmd_param), GFP_ATOMIC);
> - if (!pdrvintcmd_param) {
> - kfree(ph2c);
> - return;
> - }
> - pdrvintcmd_param->i_cid =3D WDG_WK_CID;
>=20
> - pdrvintcmd_param->sz =3D 0;
>=20
> - pdrvintcmd_param->pbuf =3D NULL;
>=20
> - init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvintcmd_param, DRV_INT_CMD);
> - r8712_enqueue_cmd_ex(pcmdpriv, ph2c);
> -}
> -
> -void r8712_survey_cmd_callback(struct _adapter *padapter, struct cmd_obj=
 *pcmd)
> -{
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - if (pcmd->res !=3D H2C_SUCCESS)
>=20
> - clr_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
> - r8712_free_cmd_obj(pcmd);
> -}
> -
> -void r8712_disassoc_cmd_callback(struct _adapter *padapter,
> - struct cmd_obj *pcmd)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - if (pcmd->res !=3D H2C_SUCCESS) {
>=20
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - set_fwstate(pmlmepriv, _FW_LINKED);
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - return;
> - }
> - r8712_free_cmd_obj(pcmd);
> -}
> -
> -void r8712_joinbss_cmd_callback(struct _adapter *padapter, struct cmd_ob=
j *pcmd)
> -{
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - if (pcmd->res !=3D H2C_SUCCESS)
>=20
> - mod_timer(&pmlmepriv->assoc_timer, jiffies + msecs_to_jiffies(1));
>=20
> - r8712_free_cmd_obj(pcmd);
> -}
> -
> -void r8712_createbss_cmd_callback(struct _adapter *padapter, struct cmd_=
obj *pcmd)
> -{
> - unsigned long irqL;
> - struct sta_info *psta =3D NULL;
> - struct wlan_network *pwlan =3D NULL;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_bssid_ex *pnetwork =3D (struct wlan_bssid_ex *)pcmd->parmbu=
f;
>=20
> - struct wlan_network *tgt_network =3D &pmlmepriv->cur_network;
>=20
> -
> - if (pcmd->res !=3D H2C_SUCCESS)
>=20
> - mod_timer(&pmlmepriv->assoc_timer, jiffies + msecs_to_jiffies(1));
>=20
> - del_timer(&pmlmepriv->assoc_timer);
>=20
> -#ifdef __BIG_ENDIAN
> - /* endian_convert */
> - pnetwork->Length =3D le32_to_cpu(pnetwork->Length);
>=20
> - pnetwork->Ssid.SsidLength =3D le32_to_cpu(pnetwork->Ssid.SsidLength);
>=20
> - pnetwork->Privacy =3D le32_to_cpu(pnetwork->Privacy);
>=20
> - pnetwork->Rssi =3D le32_to_cpu(pnetwork->Rssi);
>=20
> - pnetwork->NetworkTypeInUse =3D le32_to_cpu(pnetwork->NetworkTypeInUse);
>=20
> - pnetwork->Configuration.ATIMWindow =3D le32_to_cpu(pnetwork->Configurat=
ion.ATIMWindow);
>=20
> - pnetwork->Configuration.DSConfig =3D le32_to_cpu(pnetwork->Configuratio=
n.DSConfig);
>=20
> - pnetwork->Configuration.FHConfig.DwellTime =3D le32_to_cpu(pnetwork->Co=
nfiguration.FHConfig.DwellTime);
>=20
> - pnetwork->Configuration.FHConfig.HopPattern =3D le32_to_cpu(pnetwork->C=
onfiguration.FHConfig.HopPattern);
>=20
> - pnetwork->Configuration.FHConfig.HopSet =3D le32_to_cpu(pnetwork->Confi=
guration.FHConfig.HopSet);
>=20
> - pnetwork->Configuration.FHConfig.Length =3D le32_to_cpu(pnetwork->Confi=
guration.FHConfig.Length);
>=20
> - pnetwork->Configuration.Length =3D le32_to_cpu(pnetwork->Configuration.=
Length);
>=20
> - pnetwork->InfrastructureMode =3D le32_to_cpu(pnetwork->InfrastructureMo=
de);
>=20
> - pnetwork->IELength =3D le32_to_cpu(pnetwork->IELength);
>=20
> -#endif
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if ((pmlmepriv->fw_state) & WIFI_AP_STATE) {
>=20
> - psta =3D r8712_get_stainfo(&padapter->stapriv, pnetwork->MacAddress);
>=20
> - if (!psta) {
> - psta =3D r8712_alloc_stainfo(&padapter->stapriv, pnetwork->MacAddress);
>=20
> - if (!psta)
> - goto createbss_cmd_fail;
> - }
> - r8712_indicate_connect(padapter);
> - } else {
> - pwlan =3D _r8712_alloc_network(pmlmepriv);
> - if (!pwlan) {
> - pwlan =3D r8712_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
>=20
> - if (!pwlan)
> - goto createbss_cmd_fail;
> - pwlan->last_scanned =3D jiffies;
>=20
> - } else {
> - list_add_tail(&pwlan->list, &pmlmepriv->scanned_queue.queue);
>=20
> - }
> - pnetwork->Length =3D r8712_get_wlan_bssid_ex_sz(pnetwork);
>=20
> - memcpy(&pwlan->network, pnetwork, pnetwork->Length);
>=20
> - pwlan->fixed =3D true;
>=20
> - memcpy(&tgt_network->network, pnetwork, (r8712_get_wlan_bssid_ex_sz(pne=
twork)));
>=20
> - if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
>=20
> - pmlmepriv->fw_state ^=3D _FW_UNDER_LINKING;
>=20
> - /*
> - * we will set _FW_LINKED when there is one more sat to
> - * join us (stassoc_event_callback)
> - */
> - }
> -createbss_cmd_fail:
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - r8712_free_cmd_obj(pcmd);
> -}
> -
> -void r8712_setstaKey_cmdrsp_callback(struct _adapter *padapter, struct c=
md_obj *pcmd)
> -{
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> - struct set_stakey_rsp *psetstakey_rsp =3D (struct set_stakey_rsp *) (pc=
md->rsp);
>=20
> - struct sta_info *psta =3D r8712_get_stainfo(pstapriv, psetstakey_rsp->a=
ddr);
>=20
> -
> - if (!psta)
> - goto exit;
> - psta->aid =3D psta->mac_id =3D psetstakey_rsp->keyid; /CAM_ID(CAM_ENTRY=
)/
>=20
> -exit:
> - r8712_free_cmd_obj(pcmd);
> -}
> -
> -void r8712_setassocsta_cmdrsp_callback(struct _adapter *padapter,
> - struct cmd_obj *pcmd)
> -{
> - unsigned long irqL;
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct set_assocsta_parm *passocsta_parm =3D (struct set_assocsta_parm =
*)(pcmd->parmbuf);
>=20
> - struct set_assocsta_rsp *passocsta_rsp =3D (struct set_assocsta_rsp *) =
(pcmd->rsp);
>=20
> - struct sta_info *psta =3D r8712_get_stainfo(pstapriv, passocsta_parm->a=
ddr);
>=20
> -
> - if (!psta)
> - return;
> - psta->aid =3D psta->mac_id =3D passocsta_rsp->cam_id;
>=20
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if ((check_fwstate(pmlmepriv, WIFI_MP_STATE)) && (check_fwstate(pmlmepr=
iv, _FW_UNDER_LINKING)))
> - pmlmepriv->fw_state ^=3D _FW_UNDER_LINKING;
>=20
> - set_fwstate(pmlmepriv, _FW_LINKED);
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - r8712_free_cmd_obj(pcmd);
> -}
> -
> -void r8712_disconnectCtrlEx_cmd(struct _adapter *adapter, u32 enableDrvC=
trl, u32 tryPktCnt,
> - u32 tryPktInterval, u32 firstStageTO)
> -{
> - struct cmd_obj *ph2c;
> - struct DisconnectCtrlEx_param *param;
> - struct cmd_priv *pcmdpriv =3D &adapter->cmdpriv;
>=20
> -
> - ph2c =3D kmalloc(sizeof(*ph2c), GFP_ATOMIC);
> - if (!ph2c)
> - return;
> - param =3D kzalloc(sizeof(*param), GFP_ATOMIC);
> - if (!param) {
> - kfree(ph2c);
> - return;
> - }
> -
> - param->EnableDrvCtrl =3D (unsigned char)enableDrvCtrl;
>=20
> - param->TryPktCnt =3D (unsigned char)tryPktCnt;
>=20
> - param->TryPktInterval =3D (unsigned char)tryPktInterval;
>=20
> - param->FirstStageTO =3D (unsigned int)firstStageTO;
>=20
> -
> - init_h2fwcmd_w_parm_no_rsp(ph2c, param, GEN_CMD_CODE(_DisconnectCtrlEx)=
);
> - r8712_enqueue_cmd(pcmdpriv, ph2c);
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8=
712/rtl871x_cmd.h
> deleted file mode 100644
> index 268844af57f0..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_cmd.h
> +++ /dev/null
> @@ -1,750 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -#ifndef _RTL871X_CMD_H
> -#define _RTL871X_CMD_H
> -
> -#include "wlan_bssdef.h"
> -#include "rtl871x_rf.h"
> -#define C2H_MEM_SZ (161024)
> -
> -#include "osdep_service.h"
> -#include "ieee80211.h"
> -
> -#define FREE_CMDOBJ_SZ 128
> -#define MAX_CMDSZ 512
> -#define MAX_RSPSZ 512
> -#define MAX_EVTSZ 1024
> -#define CMDBUFF_ALIGN_SZ 512
> -
> -struct cmd_obj {
> - u16 cmdcode;
> - u8 res;
> - u8 *parmbuf;
> - u32 cmdsz;
> - u8 *rsp;
> - u32 rspsz;
> - struct list_head list;
> -};
> -
> -struct cmd_priv {
> - struct completion cmd_queue_comp;
> - struct completion terminate_cmdthread_comp;
> - struct __queue cmd_queue;
> - u8 cmd_seq;
> - u8 *cmd_buf; /shall be non-paged, and 4 bytes aligned/
> - u8 *cmd_allocated_buf;
> - u8 *rsp_buf; /shall be non-paged, and 4 bytes aligned/
> - u8 *rsp_allocated_buf;
> - u32 cmd_issued_cnt;
> - u32 cmd_done_cnt;
> - u32 rsp_cnt;
> - struct _adapter *padapter;
> -};
> -
> -struct evt_obj {
> - u16 evtcode;
> - u8 res;
> - u8 *parmbuf;
> - u32 evtsz;
> - struct list_head list;
> -};
> -
> -struct evt_priv {
> - struct __queue evt_queue;
> - u8 event_seq;
> - u8 *evt_buf; /shall be non-paged, and 4 bytes aligned/
> - u8 *evt_allocated_buf;
> - u32 evt_done_cnt;
> -};
> -
> -#define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
> -do {\
> - INIT_LIST_HEAD(&pcmd->list);\
>=20
> - pcmd->cmdcode =3D code;\
>=20
> - pcmd->parmbuf =3D (u8 *)(pparm);\
>=20
> - pcmd->cmdsz =3D sizeof(*pparm);\
>=20
> - pcmd->rsp =3D NULL;\
>=20
> - pcmd->rspsz =3D 0;\
>=20
> -} while (0)
> -
> -void r8712_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *obj);
> -void r8712_enqueue_cmd_ex(struct cmd_priv *pcmdpriv, struct cmd_obj *obj=
);
> -struct cmd_obj *r8712_dequeue_cmd(struct __queue *queue);
> -void r8712_free_cmd_obj(struct cmd_obj *pcmd);
> -int r8712_cmd_thread(void *context);
> -int r8712_init_cmd_priv(struct cmd_priv *pcmdpriv);
> -void r8712_free_cmd_priv(struct cmd_priv *pcmdpriv);
> -int r8712_init_evt_priv(struct evt_priv *pevtpriv);
> -void r8712_free_evt_priv(struct evt_priv pevtpriv);
> -
> -enum rtl871x_drvint_cid {
> - NONE_WK_CID,
> - WDG_WK_CID,
> - MAX_WK_CID
> -};
> -
> -enum RFINTFS {
> - SWSI,
> - HWSI,
> - HWPI,
> -};
> -
> -/
> - * Caller Mode: Infra, Ad-HoC(C)
> - * Notes: To enter USB suspend mode
> - * Command Mode
> - /
> -struct usb_suspend_parm {
> - u32 action; / 1: sleep, 0:resume /
> -};
> -
> -/
> - * Caller Mode: Infra, Ad-HoC(C)
> - * Notes: To disconnect the current associated BSS
> - * Command Mode
> - /
> -struct disconnect_parm {
> - u32 rsvd;
> -};
> -
> -/
> - * Caller Mode: AP, Ad-HoC, Infra
> - * Notes: To set the NIC mode of RTL8711
> - * Command Mode
> - * The definition of mode:
> - *
> - * #define IW_MODE_AUTO 0 // Let the driver decides which AP to join
> - * #define IW_MODE_ADHOC 1 // Single cell network (Ad-Hoc Clients)
> - * #define IW_MODE_INFRA 2 // Multi cell network, roaming, ..
> - * #define IW_MODE_MASTER 3 // Synchronisation master or AP
> - * #define IW_MODE_REPEAT 4 // Wireless Repeater (forwarder)
> - * #define IW_MODE_SECOND 5 // Secondary master/repeater (backup)
> - * #define IW_MODE_MONITOR 6 // Passive monitor (listen only)
> - /
> -struct setopmode_parm {
> - u8 mode;
> - u8 rsvd[3];
> -};
> -
> -/
> - * Caller Mode: AP, Ad-HoC, Infra
> - * Notes: To ask RTL8711 performing site-survey
> - * Command-Event Mode
> - */
> -struct sitesurvey_parm {
> - __le32 passive_mode; /*active: 1, passive: 0 /
> - __le32 bsslimit; / 1 ~ 48 /
> - __le32 ss_ssidlen;
> - u8 ss_ssid[IW_ESSID_MAX_SIZE + 1];
> -};
> -
> -/
> - * Caller Mode: Any
> - * Notes: To set the auth type of RTL8711. open/shared/802.1x
> - * Command Mode
> - /
> -struct setauth_parm {
> - u8 mode; /0: legacy open, 1: legacy shared 2: 802.1x/
> - u8 _1x; /0: PSK, 1: TLS/
> - u8 rsvd[2];
> -};
> -
> -/
> - * Caller Mode: Infra
> - * a. algorithm: wep40, wep104, tkip & aes
> - * b. keytype: grp key/unicast key
> - * c. key contents
> - *
> - * when shared key =3D=3D> keyid is the camid
>=20
> - * when 802.1x =3D=3D> keyid [0:1] =3D=3D> grp key
>=20
> - * when 802.1x =3D=3D> keyid > 2 =3D=3D> unicast key
>=20
> - /
> -struct setkey_parm {
> - u8 algorithm; / encryption algorithm, could be none, wep40,
> - * TKIP, CCMP, wep104
> - /
> - u8 keyid;
> - u8 grpkey; / 1: this is the grpkey for 802.1x.
> - * 0: this is the unicast key for 802.1x
> - /
> - u8 key[16]; / this could be 40 or 104 /
> -};
> -
> -/
> - * When in AP or Ad-Hoc mode, this is used to
> - * allocate an sw/hw entry for a newly associated sta.
> - * Command
> - * when shared key =3D=3D> algorithm/keyid
>=20
> - /
> -struct set_stakey_parm {
> - u8 addr[ETH_ALEN];
> - u8 algorithm;
> - u8 key[16];
> -};
> -
> -struct set_stakey_rsp {
> - u8 addr[ETH_ALEN];
> - u8 keyid;
> - u8 rsvd;
> -};
> -
> -struct SetMacAddr_param {
> - u8 MacAddr[ETH_ALEN];
> -};
> -
> -/
> - * Caller Ad-Hoc/AP
> - *
> - * Command -Rsp(AID =3D=3D CAMID) mode
> - *
> - * This is to force fw to add an sta_data entry per driver's request.
> - *
> - * FW will write an cam entry associated with it.
> - *
> - /
> -struct set_assocsta_parm {
> - u8 addr[ETH_ALEN];
> -};
> -
> -struct set_assocsta_rsp {
> - u8 cam_id;
> - u8 rsvd[3];
> -};
> -
> -/
> - * Caller Ad-Hoc/AP
> - *
> - * Command mode
> - *
> - * This is to force fw to del an sta_data entry per driver's request
> - *
> - * FW will invalidate the cam entry associated with it.
> - *
> - /
> -struct del_assocsta_parm {
> - u8 addr[ETH_ALEN];
> -};
> -
> -/
> - * Caller Mode: AP/Ad-HoC(M)
> - *
> - * Notes: To notify fw that given staid has changed its power state
> - *
> - * Command Mode
> - *
> - /
> -struct setstapwrstate_parm {
> - u8 staid;
> - u8 status;
> - u8 hwaddr[6];
> -};
> -
> -/
> - * Caller Mode: Any
> - *
> - * Notes: To setup the basic rate of RTL8711
> - *
> - * Command Mode
> - *
> - /
> -struct setbasicrate_parm {
> - u8 basicrates[NumRates];
> -};
> -
> -/
> - * Caller Mode: Any
> - *
> - * Notes: To read the current basic rate
> - *
> - * Command-Rsp Mode
> - *
> - /
> -struct getbasicrate_parm {
> - u32 rsvd;
> -};
> -
> -struct getbasicrate_rsp {
> - u8 basicrates[NumRates];
> -};
> -
> -/
> - * Caller Mode: Any
> - *
> - * Notes: To setup the data rate of RTL8711
> - *
> - * Command Mode
> - *
> - /
> -struct setdatarate_parm {
> - u8 mac_id;
> - u8 datarates[NumRates];
> -};
> -
> -enum _RT_CHANNEL_DOMAIN {
> - RT_CHANNEL_DOMAIN_FCC =3D 0,
> - RT_CHANNEL_DOMAIN_IC =3D 1,
> - RT_CHANNEL_DOMAIN_ETSI =3D 2,
> - RT_CHANNEL_DOMAIN_SPAIN =3D 3,
> - RT_CHANNEL_DOMAIN_FRANCE =3D 4,
> - RT_CHANNEL_DOMAIN_MKK =3D 5,
> - RT_CHANNEL_DOMAIN_MKK1 =3D 6,
> - RT_CHANNEL_DOMAIN_ISRAEL =3D 7,
> - RT_CHANNEL_DOMAIN_TELEC =3D 8,
> -
> - / Be compatible with old channel plan. No good! /
> - RT_CHANNEL_DOMAIN_MIC =3D 9,
> - RT_CHANNEL_DOMAIN_GLOBAL_DOAMIN =3D 10,
> - RT_CHANNEL_DOMAIN_WORLD_WIDE_13 =3D 11,
> - RT_CHANNEL_DOMAIN_TELEC_NETGEAR =3D 12,
> -
> - RT_CHANNEL_DOMAIN_NCC =3D 13,
> - RT_CHANNEL_DOMAIN_5G =3D 14,
> - RT_CHANNEL_DOMAIN_5G_40M =3D 15,
> - /=3D=3D=3D=3D=3D Add new channel plan above this line=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D/
> - RT_CHANNEL_DOMAIN_MAX,
> -};
> -
> -struct SetChannelPlan_param {
> - enum _RT_CHANNEL_DOMAIN ChannelPlan;
> -};
> -
> -/
> - * Caller Mode: Any
> - *
> - * Notes: To read the current data rate
> - *
> - * Command-Rsp Mode
> - *
> - /
> -struct getdatarate_parm {
> - u32 rsvd;
> -
> -};
> -
> -struct getdatarate_rsp {
> - u8 datarates[NumRates];
> -};
> -
> -/
> - * Caller Mode: Any
> - * AP: AP can use the info for the contents of beacon frame
> - * Infra: STA can use the info when sitesurveying
> - * Ad-HoC(M): Like AP
> - * Ad-HoC(C): Like STA
> - *
> - *
> - * Notes: To set the phy capability of the NIC
> - *
> - * Command Mode
> - *
> - /
> -
> -/
> - * Caller Mode: Any
> - *
> - * Notes: To set the channel/modem/band
> - * This command will be used when channel/modem/band is changed.
> - *
> - * Command Mode
> - *
> - /
> -/
> - * Caller Mode: Any
> - *
> - * Notes: To get the current setting of channel/modem/band
> - *
> - * Command-Rsp Mode
> - *
> - /
> -struct getphy_rsp {
> - u8 rfchannel;
> - u8 modem;
> -};
> -
> -struct readBB_parm {
> - u8 offset;
> -};
> -
> -struct readBB_rsp {
> - u8 value;
> -};
> -
> -struct readTSSI_parm {
> - u8 offset;
> -};
> -
> -struct readTSSI_rsp {
> - u8 value;
> -};
> -
> -struct writeBB_parm {
> - u8 offset;
> - u8 value;
> -};
> -
> -struct writePTM_parm {
> - u8 type;
> -};
> -
> -struct readRF_parm {
> - u8 offset;
> -};
> -
> -struct readRF_rsp {
> - u32 value;
> -};
> -
> -struct writeRF_parm {
> - u32 offset;
> - u32 value;
> -};
> -
> -struct setrfintfs_parm {
> - u8 rfintfs;
> -};
> -
> -struct getrfintfs_parm {
> - u8 rfintfs;
> -};
> -
> -/
> - * Notes: This command is used for H2C/C2H loopback testing
> - *
> - * mac[0] =3D=3D 0
> - * =3D=3D> CMD mode, return H2C_SUCCESS.
>=20
> - * The following condition must be true under CMD mode
> - * mac[1] =3D=3D mac[4], mac[2] =3D=3D mac[3], mac[0]=3Dmac[5]=3D 0;
> - * s0 =3D=3D 0x1234, s1 =3D=3D 0xabcd, w0 =3D=3D 0x78563412, w1 =3D=3D 0=
x5aa5def7;
> - * s2 =3D=3D (b1 << 8 | b0);
> - *
> - * mac[0] =3D=3D 1
> - * =3D=3D> CMD_RSP mode, return H2C_SUCCESS_RSP
>=20
> - *
> - * The rsp layout shall be:
> - * rsp: parm:
> - * mac[0] =3D mac[5];
> - * mac[1] =3D mac[4];
> - * mac[2] =3D mac[3];
> - * mac[3] =3D mac[2];
> - * mac[4] =3D mac[1];
> - * mac[5] =3D mac[0];
> - * s0 =3D s1;
> - * s1 =3D swap16(s0);
> - * w0 =3D swap32(w1);
> - * b0 =3D b1
> - * s2 =3D s0 + s1
> - * b1 =3D b0
> - * w1 =3D w0
> - *
> - * mac[0] =3D=3D 2
> - * =3D=3D> CMD_EVENT mode, return H2C_SUCCESS
>=20
> - * The event layout shall be:
> - * event: parm:
> - * mac[0] =3D mac[5];
> - * mac[1] =3D mac[4];
> - * mac[2] =3D event's sequence number, starting from 1 to parm's marc[3]
> - * mac[3] =3D mac[2];
> - * mac[4] =3D mac[1];
> - * mac[5] =3D mac[0];
> - * s0 =3D swap16(s0) - event.mac[2];
> - * s1 =3D s1 + event.mac[2];
> - * w0 =3D swap32(w0);
> - * b0 =3D b1
> - * s2 =3D s0 + event.mac[2]
> - * b1 =3D b0
> - * w1 =3D swap32(w1) - event.mac[2];
> - *
> - * parm->mac[3] is the total event counts that host requested.
>=20
> - *
> - *
> - * event will be the same with the cmd's param.
> - *
> - /
> -
> -/ CMD param Formart for DRV INTERNAL CMD HDL*/
> -struct drvint_cmd_parm {
> - int i_cid; /internal cmd id/
> - int sz; /* buf sz*/
> - unsigned char pbuf;
> -};
> -
> -/------------------- Below are used for RF/BB tuning -------------------=
--/
> -
> -struct setantenna_parm {
> - u8 tx_antset;
> - u8 rx_antset;
> - u8 tx_antenna;
> - u8 rx_antenna;
> -};
> -
> -struct enrateadaptive_parm {
> - u32 en;
> -};
> -
> -struct settxagctbl_parm {
> - u32 txagc[MAX_RATES_LENGTH];
> -};
> -
> -struct gettxagctbl_parm {
> - u32 rsvd;
> -};
> -
> -struct gettxagctbl_rsp {
> - u32 txagc[MAX_RATES_LENGTH];
> -};
> -
> -struct setagcctrl_parm {
> - u32 agcctrl; / 0: pure hw, 1: fw /
> -};
> -
> -struct setssup_parm {
> - u32 ss_ForceUp[MAX_RATES_LENGTH];
> -};
> -
> -struct getssup_parm {
> - u32 rsvd;
> -};
> -
> -struct getssup_rsp {
> - u8 ss_ForceUp[MAX_RATES_LENGTH];
> -};
> -
> -struct setssdlevel_parm {
> - u8 ss_DLevel[MAX_RATES_LENGTH];
> -};
> -
> -struct getssdlevel_parm {
> - u32 rsvd;
> -};
> -
> -struct getssdlevel_rsp {
> - u8 ss_DLevel[MAX_RATES_LENGTH];
> -};
> -
> -struct setssulevel_parm {
> - u8 ss_ULevel[MAX_RATES_LENGTH];
> -};
> -
> -struct getssulevel_parm {
> - u32 rsvd;
> -};
> -
> -struct getssulevel_rsp {
> - u8 ss_ULevel[MAX_RATES_LENGTH];
> -};
> -
> -struct setcountjudge_parm {
> - u8 count_judge[MAX_RATES_LENGTH];
> -};
> -
> -struct getcountjudge_parm {
> - u32 rsvd;
> -};
> -
> -struct getcountjudge_rsp {
> - u8 count_judge[MAX_RATES_LENGTH];
> -};
> -
> -struct setpwrmode_parm {
> - u8 mode;
> - u8 flag_low_traffic_en;
> - u8 flag_lpnav_en;
> - u8 flag_rf_low_snr_en;
> - u8 flag_dps_en; / 1: dps, 0: 32k /
> - u8 bcn_rx_en;
> - u8 bcn_pass_cnt; / fw report one beacon information to
> - * driver when it receives bcn_pass_cnt
> - * beacons.
> - /
> - u8 bcn_to; / beacon TO (ms). =C2=A1=C2=A7=3D0=C2=A1=C2=A8 no limit./
> - u16 bcn_itv;
> - u8 app_itv; / only for VOIP mode. /
> - u8 awake_bcn_itv;
> - u8 smart_ps;
> - u8 bcn_pass_time; / unit: 100ms /
> -};
> -
> -struct setatim_parm {
> - u8 op; /0: add, 1:del/
> - u8 txid; / id of dest station./
> -};
> -
> -struct setratable_parm {
> - u8 ss_ForceUp[NumRates];
> - u8 ss_ULevel[NumRates];
> - u8 ss_DLevel[NumRates];
> - u8 count_judge[NumRates];
> -};
> -
> -struct getratable_parm {
> - uint rsvd;
> -};
> -
> -struct getratable_rsp {
> - u8 ss_ForceUp[NumRates];
> - u8 ss_ULevel[NumRates];
> - u8 ss_DLevel[NumRates];
> - u8 count_judge[NumRates];
> -};
> -
> -/to get TX,RX retry count/
> -struct gettxretrycnt_parm {
> - unsigned int rsvd;
> -};
> -
> -struct gettxretrycnt_rsp {
> - unsigned long tx_retrycnt;
> -};
> -
> -struct getrxretrycnt_parm {
> - unsigned int rsvd;
> -};
> -
> -struct getrxretrycnt_rsp {
> - unsigned long rx_retrycnt;
> -};
> -
> -/to get BCNOK,BCNERR count/
> -struct getbcnokcnt_parm {
> - unsigned int rsvd;
> -};
> -
> -struct getbcnokcnt_rsp {
> - unsigned long bcnokcnt;
> -};
> -
> -struct getbcnerrcnt_parm {
> - unsigned int rsvd;
> -};
> -
> -struct getbcnerrcnt_rsp {
> - unsigned long bcnerrcnt;
> -};
> -
> -/ to get current TX power level*/
> -struct getcurtxpwrlevel_parm {
> - unsigned int rsvd;
> -};
> -
> -struct getcurtxpwrlevel_rsp {
> - unsigned short tx_power;
> -};
> -
> -/dynamic on/off DIG/
> -struct setdig_parm {
> - unsigned char dig_on; /* 1:on , 0:off /
> -};
> -
> -/dynamic on/off RA/
> -struct setra_parm {
> - unsigned char ra_on; / 1:on , 0:off /
> -};
> -
> -struct setprobereqextraie_parm {
> - unsigned char e_id;
> - unsigned char ie_len;
> - unsigned char ie[];
> -};
> -
> -struct setassocreqextraie_parm {
> - unsigned char e_id;
> - unsigned char ie_len;
> - unsigned char ie[];
> -};
> -
> -struct setproberspextraie_parm {
> - unsigned char e_id;
> - unsigned char ie_len;
> - unsigned char ie[];
> -};
> -
> -struct setassocrspextraie_parm {
> - unsigned char e_id;
> - unsigned char ie_len;
> - unsigned char ie[];
> -};
> -
> -struct addBaReq_parm {
> - unsigned int tid;
> -};
> -
> -/H2C Handler index: 46 /
> -struct SetChannel_parm {
> - u32 curr_ch;
> -};
> -
> -/H2C Handler index: 61 /
> -struct DisconnectCtrlEx_param {
> - / MAXTIME =3D (2 * FirstStageTO) + (TryPktCnt * TryPktInterval) /
> - unsigned char EnableDrvCtrl;
> - unsigned char TryPktCnt;
> - unsigned char TryPktInterval; / Unit: ms /
> - unsigned char rsvd;
> - unsigned int FirstStageTO; / Unit: ms /
> -};
> -
> -#define GEN_CMD_CODE(cmd) cmd ## CMD
> -
> -/
> - * Result:
> - * 0x00: success
> - * 0x01: success, and check Response.
> - * 0x02: cmd ignored due to duplicated sequence number
> - * 0x03: cmd dropped due to invalid cmd code
> - * 0x04: reserved.
> - /
> -
> -#define H2C_RSP_OFFSET 512
> -#define H2C_SUCCESS 0x00
> -#define H2C_SUCCESS_RSP 0x01
> -#define H2C_DUPLICATED 0x02
> -#define H2C_DROPPED 0x03
> -#define H2C_PARAMETERS_ERROR 0x04
> -#define H2C_REJECTED 0x05
> -#define H2C_CMD_OVERFLOW 0x06
> -#define H2C_RESERVED 0x07
> -
> -void r8712_setMacAddr_cmd(struct _adapter padapter, const u8 mac_addr);
> -u8 r8712_sitesurvey_cmd(struct _adapter padapter, struct ndis_802_11_ssi=
d pssid);
> -int r8712_createbss_cmd(struct _adapter padapter);
> -void r8712_setstakey_cmd(struct _adapter padapter, u8 psta, u8 unicast_k=
ey);
> -int r8712_joinbss_cmd(struct _adapter padapter, struct wlan_network pnet=
work);
> -void r8712_disassoc_cmd(struct _adapter padapter);
> -void r8712_setopmode_cmd(struct _adapter padapter, enum NDIS_802_11_NETW=
ORK_INFRASTRUCTURE networktype);
> -int r8712_setdatarate_cmd(struct _adapter padapter, u8 rateset);
> -void r8712_set_chplan_cmd(struct _adapter padapter, int chplan);
> -int r8712_getrfreg_cmd(struct _adapter padapter, u8 offset, u8 pval);
> -int r8712_setrfreg_cmd(struct _adapter padapter, u8 offset, u32 val);
> -void r8712_addbareq_cmd(struct _adapter padapter, u8 tid);
> -void r8712_wdg_wk_cmd(struct _adapter padapter);
> -void r8712_survey_cmd_callback(struct _adapter padapter, struct cmd_obj =
pcmd);
> -void r8712_disassoc_cmd_callback(struct _adapter padapter, struct cmd_ob=
j pcmd);
> -void r8712_joinbss_cmd_callback(struct _adapter padapter, struct cmd_obj=
 pcmd);
> -void r8712_createbss_cmd_callback(struct _adapter padapter, struct cmd_o=
bj pcmd);
> -void r8712_getbbrfreg_cmdrsp_callback(struct _adapter padapter, struct c=
md_obj pcmd);
> -void r8712_readtssi_cmdrsp_callback(struct _adapter padapter, struct cmd=
_obj pcmd);
> -void r8712_setstaKey_cmdrsp_callback(struct _adapter padapter, struct cm=
d_obj pcmd);
> -void r8712_setassocsta_cmdrsp_callback(struct _adapter padapter, struct =
cmd_obj pcmd);
> -void r8712_disconnectCtrlEx_cmd(struct _adapter adapter, u32 enableDrvCt=
rl, u32 tryPktCnt,
> - u32 tryPktInterval, u32 firstStageTO);
> -
> -struct _cmd_callback {
> - u32 cmd_code;
> - void (callback)(struct _adapter padapter, struct cmd_obj cmd);
> -};
> -
> -#include "rtl8712_cmd.h"
> -
> -#endif / CMD_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_debug.h b/drivers/staging/rt=
l8712/rtl871x_debug.h
> deleted file mode 100644
> index 69c631af2a2a..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_debug.h
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**********************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL871X_DEBUG_H
> -#define RTL871X_DEBUG_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -#define drv_emerg 1
> -#define drv_alert 2
> -#define drv_crit 3
> -#define drv_err 4
> -#define drv_warning 5
> -#define drv_notice 6
> -#define drv_info 7
> -#define drv_dump 8
> -#define drv_debug 9
> -
> -#define module_rtl871x_xmit_c BIT(0)
> -#define module_xmit_osdep_c BIT(1)
> -#define module_rtl871x_recv_c BIT(2)
> -#define module_recv_osdep_c BIT(3)
> -#define module_rtl871x_mlme_c BIT(4)
> -#define module_mlme_osdep_c BIT(5)
> -#define module_rtl871x_sta_mgt_c BIT(6)
> -#define module_rtl871x_cmd_c BIT(7)
> -#define module_cmd_osdep_c BIT(8)
> -#define module_rtl871x_io_c BIT(9)
> -#define module_io_osdep_c BIT(10)
> -#define module_os_intfs_c BIT(11)
> -#define module_rtl871x_security_c BIT(12)
> -#define module_rtl871x_eeprom_c BIT(13)
> -#define module_hal_init_c BIT(14)
> -#define module_hci_hal_init_c BIT(15)
> -#define module_rtl871x_ioctl_c BIT(16)
> -#define module_rtl871x_ioctl_set_c BIT(17)
> -#define module_rtl871x_pwrctrl_c BIT(19)
> -#define module_hci_intfs_c BIT(20)
> -#define module_hci_ops_c BIT(21)
> -#define module_osdep_service_c BIT(22)
> -#define module_rtl871x_mp_ioctl_c BIT(23)
> -#define module_hci_ops_os_c BIT(24)
> -#define _module_rtl871x_ioctl_os_c BIT(25)
> -#define module_rtl8712_cmd_c BIT(26)
> -#define module_rtl871x_mp_c BIT(27)
> -#define module_rtl8712_xmit_c BIT(28)
> -#define module_rtl8712_efuse_c BIT(29)
> -#define module_rtl8712_recv_c BIT(30)
> -#define module_rtl8712_led_c BIT(31)
> -
> -#undef MODULE_DEFINE
> -
> -#if defined RTL871X_XMIT_C
> - #define MODULE_DEFINE module_rtl871x_xmit_c
> -#elif defined XMIT_OSDEP_C
> - #define MODULE_DEFINE module_xmit_osdep_c
> -#elif defined RTL871X_RECV_C
> - #define MODULE_DEFINE module_rtl871x_recv_c
> -#elif defined RECV_OSDEP_C
> - #define MODULE_DEFINE module_recv_osdep_c
> -#elif defined RTL871X_MLME_C
> - #define MODULE_DEFINE module_rtl871x_mlme_c
> -#elif defined MLME_OSDEP_C
> - #define MODULE_DEFINE module_mlme_osdep_c
> -#elif defined RTL871X_STA_MGT_C
> - #define MODULE_DEFINE module_rtl871x_sta_mgt_c
> -#elif defined RTL871X_CMD_C
> - #define MODULE_DEFINE module_rtl871x_cmd_c
> -#elif defined CMD_OSDEP_C
> - #define MODULE_DEFINE module_cmd_osdep_c
> -#elif defined RTL871X_IO_C
> - #define MODULE_DEFINE module_rtl871x_io_c
> -#elif defined IO_OSDEP_C
> - #define MODULE_DEFINE module_io_osdep_c
> -#elif defined OS_INTFS_C
> - #define MODULE_DEFINE module_os_intfs_c
> -#elif defined RTL871X_SECURITY_C
> - #define MODULE_DEFINE module_rtl871x_security_c
> -#elif defined RTL871X_EEPROM_C
> - #define MODULE_DEFINE module_rtl871x_eeprom_c
> -#elif defined HAL_INIT_C
> - #define MODULE_DEFINE module_hal_init_c
> -#elif defined HCI_HAL_INIT_C
> - #define MODULE_DEFINE module_hci_hal_init_c
> -#elif defined RTL871X_IOCTL_C
> - #define MODULE_DEFINE module_rtl871x_ioctl_c
> -#elif defined RTL871X_IOCTL_SET_C
> - #define MODULE_DEFINE module_rtl871x_ioctl_set_c
> -#elif defined RTL871X_PWRCTRL_C
> - #define MODULE_DEFINE module_rtl871x_pwrctrl_c
> -#elif defined HCI_INTF_C
> - #define MODULE_DEFINE module_hci_intfs_c
> -#elif defined HCI_OPS_C
> - #define MODULE_DEFINE module_hci_ops_c
> -#elif defined OSDEP_HCI_INTF_C
> - #define MODULE_DEFINE module_hci_intfs_c
> -#elif defined OSDEP_SERVICE_C
> - #define MODULE_DEFINE module_osdep_service_c
> -#elif defined RTL871X_MP_IOCTL_C
> - #define MODULE_DEFINE module_rtl871x_mp_ioctl_c
> -#elif defined HCI_OPS_OS_C
> - #define MODULE_DEFINE module_hci_ops_os_c
> -#elif defined RTL871X_IOCTL_LINUX_C
> - #define MODULE_DEFINE _module_rtl871x_ioctl_os_c
> -#elif defined RTL871X_MP_C
> - #define MODULE_DEFINE module_rtl871x_mp_c
> -#elif defined RTL8712_CMD_C
> - #define MODULE_DEFINE module_rtl8712_cmd_c
> -#elif defined RTL8712_XMIT_C
> - #define MODULE_DEFINE module_rtl8712_xmit_c
> -#elif defined RTL8712_EFUSE_C
> - #define MODULE_DEFINE module_rtl8712_efuse_c
> -#elif defined RTL8712_RECV_C
> - #define MODULE_DEFINE module_rtl8712_recv_c
> -#else
> - #undef MODULE_DEFINE
> -#endif
> -
> -#endif /RTL871X_DEBUG_H/
> diff --git a/drivers/staging/rtl8712/rtl871x_eeprom.c b/drivers/staging/r=
tl8712/rtl871x_eeprom.c
> deleted file mode 100644
> index 221bf92e1b1c..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_eeprom.c
> +++ /dev/null
> @@ -1,220 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**
> - * rtl871x_eeprom.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_EEPROM_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -static void up_clk(struct _adapter *padapter, u16 *x)
> -{
> - *x =3D *x | _EESK;
> - r8712_write8(padapter, EE_9346CR, (u8)*x);
> - udelay(CLOCK_RATE);
> -}
> -
> -static void down_clk(struct _adapter *padapter, u16 *x)
> -{
> - *x =3D *x & ~_EESK;
> - r8712_write8(padapter, EE_9346CR, (u8)*x);
> - udelay(CLOCK_RATE);
> -}
> -
> -static void shift_out_bits(struct _adapter *padapter, u16 data, u16 coun=
t)
> -{
> - u16 x, mask;
> -
> - if (padapter->surprise_removed)
>=20
> - goto out;
> - mask =3D 0x01 << (count - 1);
> - x =3D r8712_read8(padapter, EE_9346CR);
> - x &=3D ~(_EEDO | _EEDI);
> - do {
> - x &=3D ~_EEDI;
> - if (data & mask)
> - x |=3D _EEDI;
> - if (padapter->surprise_removed)
>=20
> - goto out;
> - r8712_write8(padapter, EE_9346CR, (u8)x);
> - udelay(CLOCK_RATE);
> - up_clk(padapter, &x);
> - down_clk(padapter, &x);
> - mask >>=3D 1;
>=20
> - } while (mask);
> - if (padapter->surprise_removed)
>=20
> - goto out;
> - x &=3D ~_EEDI;
> - r8712_write8(padapter, EE_9346CR, (u8)x);
> -out:;
> -}
> -
> -static u16 shift_in_bits(struct _adapter *padapter)
> -{
> - u16 x, d =3D 0, i;
> -
> - if (padapter->surprise_removed)
>=20
> - goto out;
> - x =3D r8712_read8(padapter, EE_9346CR);
> - x &=3D ~(_EEDO | _EEDI);
> - d =3D 0;
> - for (i =3D 0; i < 16; i++) {
> - d <<=3D 1;
> - up_clk(padapter, &x);
> - if (padapter->surprise_removed)
>=20
> - goto out;
> - x =3D r8712_read8(padapter, EE_9346CR);
> - x &=3D ~(_EEDI);
> - if (x & _EEDO)
> - d |=3D 1;
> - down_clk(padapter, &x);
> - }
> -out:
> - return d;
> -}
> -
> -static void standby(struct _adapter *padapter)
> -{
> - u8 x;
> -
> - x =3D r8712_read8(padapter, EE_9346CR);
> - x &=3D ~(_EECS | _EESK);
> - r8712_write8(padapter, EE_9346CR, x);
> - udelay(CLOCK_RATE);
> - x |=3D _EECS;
> - r8712_write8(padapter, EE_9346CR, x);
> - udelay(CLOCK_RATE);
> -}
> -
> -static u16 wait_eeprom_cmd_done(struct _adapter *padapter)
> -{
> - u8 x;
> - u16 i;
> -
> - standby(padapter);
> - for (i =3D 0; i < 200; i++) {
> - x =3D r8712_read8(padapter, EE_9346CR);
> - if (x & _EEDO)
> - return true;
> - udelay(CLOCK_RATE);
> - }
> - return false;
> -}
> -
> -static void eeprom_clean(struct _adapter *padapter)
> -{
> - u16 x;
> -
> - if (padapter->surprise_removed)
>=20
> - return;
> - x =3D r8712_read8(padapter, EE_9346CR);
> - if (padapter->surprise_removed)
>=20
> - return;
> - x &=3D ~(_EECS | _EEDI);
> - r8712_write8(padapter, EE_9346CR, (u8)x);
> - if (padapter->surprise_removed)
>=20
> - return;
> - up_clk(padapter, &x);
> - if (padapter->surprise_removed)
>=20
> - return;
> - down_clk(padapter, &x);
> -}
> -
> -void r8712_eeprom_write16(struct _adapter *padapter, u16 reg, u16 data)
> -{
> - u8 x;
> - u8 tmp8_ori, tmp8_new, tmp8_clk_ori, tmp8_clk_new;
> -
> - tmp8_ori =3D r8712_read8(padapter, 0x102502f1);
> - tmp8_new =3D tmp8_ori & 0xf7;
> - if (tmp8_ori !=3D tmp8_new)
> - r8712_write8(padapter, 0x102502f1, tmp8_new);
> - tmp8_clk_ori =3D r8712_read8(padapter, 0x10250003);
> - tmp8_clk_new =3D tmp8_clk_ori | 0x20;
> - if (tmp8_clk_new !=3D tmp8_clk_ori)
> - r8712_write8(padapter, 0x10250003, tmp8_clk_new);
> - x =3D r8712_read8(padapter, EE_9346CR);
> - x &=3D ~(_EEDI | _EEDO | _EESK | _EEM0);
> - x |=3D _EEM1 | _EECS;
> - r8712_write8(padapter, EE_9346CR, x);
> - shift_out_bits(padapter, EEPROM_EWEN_OPCODE, 5);
> - if (padapter->eeprom_address_size =3D=3D 8) /CF+ and SDIO/
>=20
> - shift_out_bits(padapter, 0, 6);
> - else /* USB /
> - shift_out_bits(padapter, 0, 4);
> - standby(padapter);
> - / Erase this particular word. Write the erase opcode and register
> - * number in that order. The opcode is 3bits in length; reg is 6
> - * bits long.
> - /
> - standby(padapter);
> - / write the new word to the EEPROM
> - * send the write opcode the EEPORM
> - /
> - shift_out_bits(padapter, EEPROM_WRITE_OPCODE, 3);
> - / select which word in the EEPROM that we are writing to. */
> - shift_out_bits(padapter, reg, padapter->eeprom_address_size);
>=20
> - /* write the data to the selected EEPROM word. */
> - shift_out_bits(padapter, data, 16);
> - if (wait_eeprom_cmd_done(padapter)) {
> - standby(padapter);
> - shift_out_bits(padapter, EEPROM_EWDS_OPCODE, 5);
> - shift_out_bits(padapter, reg, 4);
> - eeprom_clean(padapter);
> - }
> - if (tmp8_clk_new !=3D tmp8_clk_ori)
> - r8712_write8(padapter, 0x10250003, tmp8_clk_ori);
> - if (tmp8_new !=3D tmp8_ori)
> - r8712_write8(padapter, 0x102502f1, tmp8_ori);
> -}
> -
> -u16 r8712_eeprom_read16(struct _adapter *padapter, u16 reg) /ReadEEprom/
> -{
> - u16 x;
> - u16 data =3D 0;
> - u8 tmp8_ori, tmp8_new, tmp8_clk_ori, tmp8_clk_new;
> -
> - tmp8_ori =3D r8712_read8(padapter, 0x102502f1);
> - tmp8_new =3D tmp8_ori & 0xf7;
> - if (tmp8_ori !=3D tmp8_new)
> - r8712_write8(padapter, 0x102502f1, tmp8_new);
> - tmp8_clk_ori =3D r8712_read8(padapter, 0x10250003);
> - tmp8_clk_new =3D tmp8_clk_ori | 0x20;
> - if (tmp8_clk_new !=3D tmp8_clk_ori)
> - r8712_write8(padapter, 0x10250003, tmp8_clk_new);
> - if (padapter->surprise_removed)
>=20
> - goto out;
> - /* select EEPROM, reset bits, set _EECS */
> - x =3D r8712_read8(padapter, EE_9346CR);
> - if (padapter->surprise_removed)
>=20
> - goto out;
> - x &=3D ~(_EEDI | _EEDO | _EESK | _EEM0);
> - x |=3D _EEM1 | _EECS;
> - r8712_write8(padapter, EE_9346CR, (unsigned char)x);
> - /* write the read opcode and register number in that order
> - * The opcode is 3bits in length, reg is 6 bits long
> - */
> - shift_out_bits(padapter, EEPROM_READ_OPCODE, 3);
> - shift_out_bits(padapter, reg, padapter->eeprom_address_size);
>=20
> - /* Now read the data (16 bits) in from the selected EEPROM word /
> - data =3D shift_in_bits(padapter);
> - eeprom_clean(padapter);
> -out:
> - if (tmp8_clk_new !=3D tmp8_clk_ori)
> - r8712_write8(padapter, 0x10250003, tmp8_clk_ori);
> - if (tmp8_new !=3D tmp8_ori)
> - r8712_write8(padapter, 0x102502f1, tmp8_ori);
> - return data;
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_eeprom.h b/drivers/staging/r=
tl8712/rtl871x_eeprom.h
> deleted file mode 100644
> index 7bdeb2aaa025..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_eeprom.h
> +++ /dev/null
> @@ -1,88 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - /
> -#ifndef RTL871X_EEPROM_H
> -#define RTL871X_EEPROM_H
> -
> -#include "osdep_service.h"
> -
> -#define RTL8712_EEPROM_ID 0x8712
> -#define EEPROM_MAX_SIZE 256
> -#define CLOCK_RATE 50 /100us/
> -
> -/- EEPROM opcodes/
> -#define EEPROM_READ_OPCODE 06
> -#define EEPROM_WRITE_OPCODE 05
> -#define EEPROM_ERASE_OPCODE 07
> -#define EEPROM_EWEN_OPCODE 19 / Erase/write enable/
> -#define EEPROM_EWDS_OPCODE 16 / Erase/write disable/
> -
> -#define EEPROM_CID_DEFAULT 0x0
> -#define EEPROM_CID_ALPHA 0x1
> -#define EEPROM_CID_Senao 0x3
> -#define EEPROM_CID_NetCore 0x5
> -#define EEPROM_CID_CAMEO 0X8
> -#define EEPROM_CID_SITECOM 0x9
> -#define EEPROM_CID_COREGA 0xB
> -#define EEPROM_CID_EDIMAX_BELKIN 0xC
> -#define EEPROM_CID_SERCOMM_BELKIN 0xE
> -#define EEPROM_CID_CAMEO1 0xF
> -#define EEPROM_CID_WNC_COREGA 0x12
> -#define EEPROM_CID_CLEVO 0x13
> -#define EEPROM_CID_WHQL 0xFE
> -
> -enum RT_CUSTOMER_ID {
> - RT_CID_DEFAULT =3D 0,
> - RT_CID_8187_ALPHA0 =3D 1,
> - RT_CID_8187_SERCOMM_PS =3D 2,
> - RT_CID_8187_HW_LED =3D 3,
> - RT_CID_8187_NETGEAR =3D 4,
> - RT_CID_WHQL =3D 5,
> - RT_CID_819x_CAMEO =3D 6,
> - RT_CID_819x_RUNTOP =3D 7,
> - RT_CID_819x_Senao =3D 8,
> - RT_CID_TOSHIBA =3D 9,
> - RT_CID_819x_Netcore =3D 10,
> - RT_CID_Nettronix =3D 11,
> - RT_CID_DLINK =3D 12,
> - RT_CID_PRONET =3D 13,
> - RT_CID_COREGA =3D 14,
> - RT_CID_819x_ALPHA =3D 15,
> - RT_CID_819x_Sitecom =3D 16,
> - RT_CID_CCX =3D 17,
> - RT_CID_819x_Lenovo =3D 18,
> - RT_CID_819x_QMI =3D 19,
> - RT_CID_819x_Edimax_Belkin =3D 20,
> - RT_CID_819x_Sercomm_Belkin =3D 21,
> - RT_CID_819x_CAMEO1 =3D 22,
> - RT_CID_819x_MSI =3D 23,
> - RT_CID_819x_Acer =3D 24,
> - RT_CID_819x_AzWave_ASUS =3D 25,
> - RT_CID_819x_AzWave =3D 26,
> - RT_CID_819x_WNC_COREGA =3D 27,
> - RT_CID_819x_CLEVO =3D 28,
> -};
> -
> -struct eeprom_priv {
> - u8 bautoload_fail_flag;
> - u8 bempty;
> - u8 sys_config;
> - u8 mac_addr[6];
> - u8 config0;
> - u16 channel_plan;
> - u8 country_string[3];
> - u8 tx_power_b[15];
> - u8 tx_power_g[15];
> - u8 tx_power_a[201];
> - u8 efuse_eeprom_data[EEPROM_MAX_SIZE];
> - enum RT_CUSTOMER_ID CustomerID;
> -};
> -
> -void r8712_eeprom_write16(struct _adapter padapter, u16 reg, u16 data);
> -u16 r8712_eeprom_read16(struct _adapter padapter, u16 reg);
> -
> -#endif /RTL871X_EEPROM_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rt=
l8712/rtl871x_event.h
> deleted file mode 100644
> index 0cc780cf4341..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_event.h
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef RTL871x_EVENT_H
> -#define RTL871x_EVENT_H
> -
> -#include "osdep_service.h"
> -
> -#include "wlan_bssdef.h"
> -#include <linux/semaphore.h>
>=20
> -#include <linux/sem.h>
>=20
> -
> -/*
> - * Used to report a bss has been scanned
> - /
> -struct survey_event {
> - struct wlan_bssid_ex bss;
> -};
> -
> -/
> - * Used to report that the requested site survey has been done.
> - * bss_cnt indicates the number of bss that has been reported.
> - /
> -struct surveydone_event {
> - unsigned int bss_cnt;
> -
> -};
> -
> -/
> - * Used to report the link result of joining the given bss
> - * join_res:
> - * -1: authentication fail
> - * -2: association fail
> - * > 0: TID
>=20
> - /
> -struct joinbss_event {
> - struct wlan_network network;
> -};
> -
> -/
> - * Used to report a given STA has joinned the created BSS.
> - * It is used in AP/Ad-HoC(M) mode.
> - /
> -struct stassoc_event {
> - unsigned char macaddr[6];
> - unsigned char rsvd[2];
> - __le32 cam_id;
> -};
> -
> -struct stadel_event {
> - unsigned char macaddr[6];
> - unsigned char rsvd[2];
> -};
> -
> -struct addba_event {
> - unsigned int tid;
> -};
> -
> -#define GEN_EVT_CODE(event) event ## EVT
> -
> -struct fwevent {
> - u32 parmsize;
> - void (event_callback)(struct _adapter dev, u8 pbuf);
> -};
> -
> -#define C2HEVENT_SZ 32
> -struct event_node {
> - unsigned char node;
> - unsigned char evt_code;
> - unsigned short evt_sz;
> - /volatile/ int caller_ff_tail;
> - int caller_ff_sz;
> -};
> -
> -struct c2hevent_queue {
> - /volatile/ int head;
> - /volatile/ int tail;
> - struct event_node nodes[C2HEVENT_SZ];
> - unsigned char seq;
> -};
> -
> -#define NETWORK_QUEUE_SZ 4
> -
> -struct network_queue {
> - /volatile/ int head;
> - /volatile/ int tail;
> - struct wlan_bssid_ex networks[NETWORK_QUEUE_SZ];
> -};
> -
> -struct ADDBA_Req_Report_parm {
> - unsigned char MacAddress[ETH_ALEN];
> - unsigned short StartSeqNum;
> - unsigned char tid;
> -};
> -
> -#include "rtl8712_event.h"
> -
> -#endif / WLANEVENT_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_ht.h b/drivers/staging/rtl87=
12/rtl871x_ht.h
> deleted file mode 100644
> index ebd78665775d..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_ht.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
*
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - **/
> -#ifndef RTL871X_HT_H
> -#define RTL871X_HT_H
> -
> -#include "osdep_service.h"
> -#include "wifi.h"
> -
> -struct ht_priv {
> - unsigned int ht_option;
> - unsigned int ampdu_enable;/for enable Tx A-MPDU/
> - unsigned char baddbareq_issued[16];
> - unsigned int tx_amsdu_enable;/for enable Tx A-MSDU /
> - unsigned int tx_amdsu_maxlen; / 1: 8k, 0:4k ; default:8k, for tx /
> - unsigned int rx_ampdu_maxlen; / for rx reordering ctrl win_sz,
> - * updated when join_callback.
> - /
> - struct ieee80211_ht_cap ht_cap;
> -};
> -
> -#endif /RTL871X_HT_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl87=
12/rtl871x_io.c
> deleted file mode 100644
> index 20e080e284dd..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_io.c
> +++ /dev/null
> @@ -1,147 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl871x_io.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -/
> - *
> - * The purpose of rtl871x_io.c
> - *
> - * a. provides the API
> - * b. provides the protocol engine
> - * c. provides the software interface between caller and the hardware in=
terface
> - *
> - * For r8712u, both sync/async operations are provided.
> - *
> - * Only sync read/write_mem operations are provided.
> - *
> - */
> -
> -#define RTL871X_IO_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "rtl871x_io.h"
> -#include "osdep_intf.h"
> -#include "usb_ops.h"
> -
> -static uint _init_intf_hdl(struct _adapter *padapter,
> - struct intf_hdl *pintf_hdl)
> -{
> - struct intf_priv *pintf_priv;
> - void (*set_intf_option)(u32 *poption) =3D NULL;
> - void (*set_intf_funs)(struct intf_hdl *pintf_hdl);
> - void (*set_intf_ops)(struct _io_ops *pops);
> - uint (*init_intf_priv)(struct intf_priv *pintfpriv);
> -
> - set_intf_option =3D &(r8712_usb_set_intf_option);
> - set_intf_funs =3D &(r8712_usb_set_intf_funs);
> - set_intf_ops =3D &r8712_usb_set_intf_ops;
> - init_intf_priv =3D &r8712_usb_init_intf_priv;
> - pintf_priv =3D kmalloc(sizeof(*pintf_priv), GFP_ATOMIC);
> - pintf_hdl->pintfpriv =3D pintf_priv;
>=20
> - if (!pintf_priv)
> - goto _init_intf_hdl_fail;
> - pintf_hdl->adapter =3D (u8 *)padapter;
>=20
> - set_intf_option(&pintf_hdl->intf_option);
>=20
> - set_intf_funs(pintf_hdl);
> - set_intf_ops(&pintf_hdl->io_ops);
>=20
> - pintf_priv->intf_dev =3D (u8 *)&padapter->dvobjpriv;
>=20
> - if (init_intf_priv(pintf_priv) =3D=3D _FAIL)
> - goto _init_intf_hdl_fail;
> - return _SUCCESS;
> -_init_intf_hdl_fail:
> - kfree(pintf_priv);
> - return _FAIL;
> -}
> -
> -static void _unload_intf_hdl(struct intf_priv *pintfpriv)
> -{
> - void (*unload_intf_priv)(struct intf_priv *pintfpriv);
> -
> - unload_intf_priv =3D &r8712_usb_unload_intf_priv;
> - unload_intf_priv(pintfpriv);
> - kfree(pintfpriv);
> -}
> -
> -static uint register_intf_hdl(u8 *dev, struct intf_hdl *pintfhdl)
> -{
> - struct _adapter *adapter =3D (struct _adapter *)dev;
> -
> - pintfhdl->intf_option =3D 0;
>=20
> - pintfhdl->adapter =3D dev;
>=20
> - pintfhdl->intf_dev =3D (u8 *)&adapter->dvobjpriv;
>=20
> - if (!_init_intf_hdl(adapter, pintfhdl))
> - goto register_intf_hdl_fail;
> - return _SUCCESS;
> -register_intf_hdl_fail:
> - return false;
> -}
> -
> -static void unregister_intf_hdl(struct intf_hdl *pintfhdl)
> -{
> - _unload_intf_hdl(pintfhdl->pintfpriv);
>=20
> - memset((u8 *)pintfhdl, 0, sizeof(struct intf_hdl));
> -}
> -
> -uint r8712_alloc_io_queue(struct _adapter *adapter)
> -{
> - u32 i;
> - struct io_queue *pio_queue;
> - struct io_req *pio_req;
> -
> - pio_queue =3D kmalloc(sizeof(*pio_queue), GFP_ATOMIC);
> - if (!pio_queue)
> - goto alloc_io_queue_fail;
> - INIT_LIST_HEAD(&pio_queue->free_ioreqs);
>=20
> - INIT_LIST_HEAD(&pio_queue->processing);
>=20
> - INIT_LIST_HEAD(&pio_queue->pending);
>=20
> - spin_lock_init(&pio_queue->lock);
>=20
> - pio_queue->pallocated_free_ioreqs_buf =3D kzalloc(NUM_IOREQ *
>=20
> - (sizeof(struct io_req)) + 4,
> - GFP_ATOMIC);
> - if ((pio_queue->pallocated_free_ioreqs_buf) =3D=3D NULL)
>=20
> - goto alloc_io_queue_fail;
> - pio_queue->free_ioreqs_buf =3D pio_queue->pallocated_free_ioreqs_buf + =
4
>=20
> - - ((addr_t)(pio_queue->pallocated_free_ioreqs_buf)
>=20
> - & 3);
> - pio_req =3D (struct io_req *)(pio_queue->free_ioreqs_buf);
>=20
> - for (i =3D 0; i < NUM_IOREQ; i++) {
> - INIT_LIST_HEAD(&pio_req->list);
>=20
> - list_add_tail(&pio_req->list, &pio_queue->free_ioreqs);
>=20
> - pio_req++;
> - }
> - if ((register_intf_hdl((u8 *)adapter, &pio_queue->intf)) =3D=3D _FAIL)
>=20
> - goto alloc_io_queue_fail;
> - adapter->pio_queue =3D pio_queue;
>=20
> - return _SUCCESS;
> -alloc_io_queue_fail:
> - if (pio_queue) {
> - kfree(pio_queue->pallocated_free_ioreqs_buf);
>=20
> - kfree(pio_queue);
> - }
> - adapter->pio_queue =3D NULL;
>=20
> - return _FAIL;
> -}
> -
> -void r8712_free_io_queue(struct _adapter *adapter)
> -{
> - struct io_queue *pio_queue =3D adapter->pio_queue;
>=20
> -
> - if (pio_queue) {
> - kfree(pio_queue->pallocated_free_ioreqs_buf);
>=20
> - adapter->pio_queue =3D NULL;
>=20
> - unregister_intf_hdl(&pio_queue->intf);
>=20
> - kfree(pio_queue);
> - }
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_io.h b/drivers/staging/rtl87=
12/rtl871x_io.h
> deleted file mode 100644
> index f09d50a29b82..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_io.h
> +++ /dev/null
> @@ -1,236 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - *****************************************************/
> -#ifndef RTL871X_IO_H
> -#define RTL871X_IO_H
> -
> -#include "osdep_service.h"
> -#include "osdep_intf.h"
> -
> -#define NUM_IOREQ 8
> -
> -#define MAX_PROT_SZ (64-16)
> -
> -#define _IOREADY 0
> -#define _IO_WAIT_COMPLETE 1
> -#define _IO_WAIT_RSP 2
> -
> -/ IO COMMAND TYPE /
> -#define IOSZ_MASK (0x7F)
> -#define IO_WRITE BIT(7)
> -#define IO_FIXED BIT(8)
> -#define IO_BURST BIT(9)
> -#define IO_BYTE BIT(10)
> -#define IO_HW BIT(11)
> -#define IO_WORD BIT(12)
> -#define IO_SYNC BIT(13)
> -#define IO_CMDMASK (0x1F80)
> -
> -/
> - * For prompt mode accessing, caller shall free io_req
> - * Otherwise, io_handler will free io_req
> - /
> -/ IO STATUS TYPE /
> -#define IO_ERR BIT(2)
> -#define IO_SUCCESS BIT(1)
> -#define IO_DONE BIT(0)
> -#define IO_RD32 (IO_SYNC | IO_WORD)
> -#define IO_RD16 (IO_SYNC | IO_HW)
> -#define IO_RD8 (IO_SYNC | IO_BYTE)
> -#define IO_RD32_ASYNC (IO_WORD)
> -#define IO_RD16_ASYNC (IO_HW)
> -#define IO_RD8_ASYNC (IO_BYTE)
> -#define IO_WR32 (IO_WRITE | IO_SYNC | IO_WORD)
> -#define IO_WR16 (IO_WRITE | IO_SYNC | IO_HW)
> -#define IO_WR8 (IO_WRITE | IO_SYNC | IO_BYTE)
> -#define IO_WR32_ASYNC (IO_WRITE | IO_WORD)
> -#define IO_WR16_ASYNC (IO_WRITE | IO_HW)
> -#define IO_WR8_ASYNC (IO_WRITE | IO_BYTE)
> -/
> - * Only Sync. burst accessing is provided.
> - /
> -#define IO_WR_BURST(x) (IO_WRITE_ | IO_SYNC | IO_BURST | \
> - ((x) & IOSZ_MASK))
> -#define IO_RD_BURST(x) (IO_SYNC | IO_BURST | ((x) & IOSZ_MASK))
> -/below is for the intf_option bit definition.../
> -#define INTF_ASYNC BIT(0) /support async io/
> -struct intf_priv;
> -struct intf_hdl;
> -struct io_queue;
> -struct _io_ops {
> - uint (_sdbus_read_bytes_to_membuf)(struct intf_priv pintfpriv,
> - u32 addr, u32 cnt, u8 pbuf);
> - uint (_sdbus_read_blocks_to_membuf)(struct intf_priv pintfpriv,
> - u32 addr, u32 cnt, u8 pbuf);
> - u8 (_read8)(struct intf_hdl pintfhdl, u32 addr);
> - u16 (_read16)(struct intf_hdl pintfhdl, u32 addr);
> - u32 (_read32)(struct intf_hdl pintfhdl, u32 addr);
> - uint (_sdbus_write_blocks_from_membuf)(struct intf_priv pintfpriv,
> - u32 addr, u32 cnt, u8 pbuf,
> - u8 async);
> - uint (_sdbus_write_bytes_from_membuf)(struct intf_priv pintfpriv,
> - u32 addr, u32 cnt, u8 pbuf);
> - u8 (_cmd52r)(struct intf_priv pintfpriv, u32 addr);
> - void (_cmd52w)(struct intf_priv pintfpriv, u32 addr, u8 val8);
> - u8 (_cmdfunc152r)(struct intf_priv pintfpriv, u32 addr);
> - void (_cmdfunc152w)(struct intf_priv pintfpriv, u32 addr, u8 val8);
> - void (_write8)(struct intf_hdl pintfhdl, u32 addr, u8 val);
> - void (_write16)(struct intf_hdl pintfhdl, u32 addr, u16 val);
> - void (_write32)(struct intf_hdl pintfhdl, u32 addr, u32 val);
> - void (_read_mem)(struct intf_hdl pintfhdl, u32 addr, u32 cnt,
> - u8 pmem);
> - void (_write_mem)(struct intf_hdl pintfhdl, u32 addr, u32 cnt,
> - u8 pmem);
> - void (_sync_irp_protocol_rw)(struct io_queue pio_q);
> - u32 (_read_port)(struct intf_hdl pintfhdl, u32 addr, u32 cnt,
> - u8 pmem);
> - u32 (_write_port)(struct intf_hdl pintfhdl, u32 addr, u32 cnt,
> - u8 pmem);
> -};
> -
> -struct io_req {
> - struct list_head list;
> - u32 addr;
> - /volatile/ u32 val;
> - u32 command;
> - u32 status;
> - u8 pbuf;
> - void (_async_io_callback)(struct _adapter padapter,
> - struct io_req pio_req, u8 cnxt);
> - u8 cnxt;
> -};
> -
> -struct intf_hdl {
> - u32 intf_option;
> - u8 adapter;
> - u8 intf_dev;
> - struct intf_priv pintfpriv;
> - void (intf_hdl_init)(u8 priv);
> - void (intf_hdl_unload)(u8 priv);
> - void (intf_hdl_open)(u8 priv);
> - void (intf_hdl_close)(u8 priv);
> - struct _io_ops io_ops;
> -};
> -
> -struct reg_protocol_rd {
> -#ifdef __LITTLE_ENDIAN
> - / DW1 /
> - u32 NumOfTrans:4;
> - u32 Reserved1:4;
> - u32 Reserved2:24;
> - / DW2 /
> - u32 ByteCount:7;
> - u32 WriteEnable:1; /0:read, 1:write/
> - u32 FixOrContinuous:1; /0:continuous, 1: Fix/
> - u32 BurstMode:1;
> - u32 Byte1Access:1;
> - u32 Byte2Access:1;
> - u32 Byte4Access:1;
> - u32 Reserved3:3;
> - u32 Reserved4:16;
> - /DW3/
> - u32 BusAddress;
> - /DW4/
> -#else
> -/DW1/
> - u32 Reserved1:4;
> - u32 NumOfTrans:4;
> - u32 Reserved2:24;
> - /DW2/
> - u32 WriteEnable:1;
> - u32 ByteCount:7;
> - u32 Reserved3:3;
> - u32 Byte4Access:1;
> - u32 Byte2Access:1;
> - u32 Byte1Access:1;
> - u32 BurstMode:1;
> - u32 FixOrContinuous:1;
> - u32 Reserved4:16;
> - /DW3/
> - u32 BusAddress;
> - /DW4/
> -#endif
> -};
> -
> -struct reg_protocol_wt {
> -#ifdef __LITTLE_ENDIAN
> - /DW1/
> - u32 NumOfTrans:4;
> - u32 Reserved1:4;
> - u32 Reserved2:24;
> - /DW2/
> - u32 ByteCount:7;
> - u32 WriteEnable:1; /0:read, 1:write/
> - u32 FixOrContinuous:1; /0:continuous, 1: Fix/
> - u32 BurstMode:1;
> - u32 Byte1Access:1;
> - u32 Byte2Access:1;
> - u32 Byte4Access:1;
> - u32 Reserved3:3;
> - u32 Reserved4:16;
> - /DW3/
> - u32 BusAddress;
> - /DW4/
> - u32 Value;
> -#else
> - /DW1/
> - u32 Reserved1:4;
> - u32 NumOfTrans:4;
> - u32 Reserved2:24;
> - /DW2/
> - u32 WriteEnable:1;
> - u32 ByteCount:7;
> - u32 Reserved3:3;
> - u32 Byte4Access:1;
> - u32 Byte2Access:1;
> - u32 Byte1Access:1;
> - u32 BurstMode:1;
> - u32 FixOrContinuous:1;
> - u32 Reserved4:16;
> - /DW3/
> - u32 BusAddress;
> - /DW4/
> - u32 Value;
> -#endif
> -};
> -
> -/
> - * Below is the data structure used by _io_handler
> - /
> -
> -struct io_queue {
> - spinlock_t lock;
> - struct list_head free_ioreqs;
> - /The io_req list that will be served in the single protocol r/w./
> - struct list_head pending;
> - struct list_head processing;
> - u8 free_ioreqs_buf; / 4-byte aligned /
> - u8 pallocated_free_ioreqs_buf;
> - struct intf_hdl intf;
> -};
> -
> -u8 r8712_read8(struct _adapter adapter, u32 addr);
> -u16 r8712_read16(struct _adapter adapter, u32 addr);
> -u32 r8712_read32(struct _adapter adapter, u32 addr);
> -void r8712_read_mem(struct _adapter adapter, u32 addr, u32 cnt, u8 pmem)=
;
> -void r8712_read_port(struct _adapter adapter, u32 addr, u32 cnt, u8 pmem=
);
> -void r8712_write8(struct _adapter adapter, u32 addr, u8 val);
> -void r8712_write16(struct _adapter adapter, u32 addr, u16 val);
> -void r8712_write32(struct _adapter adapter, u32 addr, u32 val);
> -void r8712_write_mem(struct _adapter adapter, u32 addr, u32 cnt, u8 pmem=
);
> -void r8712_write_port(struct _adapter adapter, u32 addr, u32 cnt, u8 pme=
m);
> -/ioreq /
> -uint r8712_alloc_io_queue(struct _adapter adapter);
> -void r8712_free_io_queue(struct _adapter adapter);
> -
> -#endif /RTL871X_IO_H/
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl.h b/drivers/staging/rt=
l8712/rtl871x_ioctl.h
> deleted file mode 100644
> index d6332a8c7f4f..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_ioctl.h
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -#ifndef __IOCTL_H
> -#define __IOCTL_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -#ifndef OID_802_11_CAPABILITY
> - #define OID_802_11_CAPABILITY 0x0d010122
> -#endif
> -
> -#ifndef OID_802_11_PMKID
> - #define OID_802_11_PMKID 0x0d010123
> -#endif
> -
> -/ For DDK-defined OIDs/
> -#define OID_NDIS_SEG1 0x00010100
> -#define OID_NDIS_SEG2 0x00010200
> -#define OID_NDIS_SEG3 0x00020100
> -#define OID_NDIS_SEG4 0x01010100
> -#define OID_NDIS_SEG5 0x01020100
> -#define OID_NDIS_SEG6 0x01020200
> -#define OID_NDIS_SEG7 0xFD010100
> -#define OID_NDIS_SEG8 0x0D010100
> -#define OID_NDIS_SEG9 0x0D010200
> -#define OID_NDIS_SEG10 0x0D020200
> -#define SZ_OID_NDIS_SEG1 23
> -#define SZ_OID_NDIS_SEG2 3
> -#define SZ_OID_NDIS_SEG3 6
> -#define SZ_OID_NDIS_SEG4 6
> -#define SZ_OID_NDIS_SEG5 4
> -#define SZ_OID_NDIS_SEG6 8
> -#define SZ_OID_NDIS_SEG7 7
> -#define SZ_OID_NDIS_SEG8 36
> -#define SZ_OID_NDIS_SEG9 24
> -#define SZ_OID_NDIS_SEG10 19
> -
> -/ For Realtek-defined OIDs/
> -#define OID_MP_SEG1 0xFF871100
> -#define OID_MP_SEG2 0xFF818000
> -#define OID_MP_SEG3 0xFF818700
> -#define OID_MP_SEG4 0xFF011100
> -
> -enum oid_type {
> - QUERY_OID,
> - SET_OID
> -};
> -
> -struct oid_funs_node {
> - unsigned int oid_start; /the starting number for OID/
> - unsigned int oid_end; /the ending number for OID/
> - struct oid_obj_priv node_array;
> - unsigned int array_sz; /the size of node_array/
> - int query_counter; /count the number of query hits for this segment/
> - int set_counter; /count the number of set hits for this segment/
> -};
> -
> -struct oid_par_priv {
> - void adapter_context;
> - uint oid;
> - void information_buf;
> - unsigned long information_buf_len;
> - unsigned long bytes_rw;
> - unsigned long bytes_needed;
> - enum oid_type type_of_oid;
> - unsigned int dbg;
> -};
> -
> -struct oid_obj_priv {
> - unsigned char dbg; / 0: without OID debug message
> - * 1: with OID debug message
> - /
> - uint (oidfuns)(struct oid_par_priv poid_par_priv);
> -};
> -
> -uint oid_null_function(struct oid_par_priv poid_par_priv);
> -
> -extern struct iw_handler_def r871x_handlers_def;
> -
> -uint drv_query_info(struct net_device MiniportAdapterContext,
> - uint Oid,
> - void InformationBuffer,
> - u32 InformationBufferLength,
> - u32 BytesWritten,
> - u32 BytesNeeded);
> -
> -uint drv_set_info(struct net_device MiniportAdapterContext,
> - uint Oid,
> - void InformationBuffer,
> - u32 InformationBufferLength,
> - u32 BytesRead,
> - u32 BytesNeeded);
> -
> -#endif
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/stag=
ing/rtl8712/rtl871x_ioctl_linux.c
> deleted file mode 100644
> index 832c6c64aa68..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> +++ /dev/null
> @@ -1,2276 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl871x_ioctl_linux.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_IOCTL_LINUX_C
> -#define RTL871X_MP_IOCTL_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "wlan_bssdef.h"
> -#include "rtl871x_debug.h"
> -#include "wifi.h"
> -#include "rtl871x_mlme.h"
> -#include "rtl871x_ioctl.h"
> -#include "rtl871x_ioctl_set.h"
> -#include "rtl871x_mp_ioctl.h"
> -#include "rtl871x_security.h"
> -#include "mlme_osdep.h"
> -#include <linux/wireless.h>
>=20
> -#include <linux/module.h>
>=20
> -#include <linux/kernel.h>
>=20
> -#include <linux/io.h>
>=20
> -#include <linux/semaphore.h>
>=20
> -#include <net/iw_handler.h>
>=20
> -#include <linux/if_arp.h>
>=20
> -#include <linux/etherdevice.h>
>=20
> -
> -#define RTL_IOCTL_WPA_SUPPLICANT (SIOCIWFIRSTPRIV + 0x1E)
> -
> -#define SCAN_ITEM_SIZE 768
> -#define MAX_CUSTOM_LEN 64
> -#define RATE_COUNT 4
> -
> -static const u32 rtl8180_rates[] =3D {1000000, 2000000, 5500000, 1100000=
0,
> - 6000000, 9000000, 12000000, 18000000,
> - 24000000, 36000000, 48000000, 54000000};
> -
> -static const long ieee80211_wlan_frequencies[] =3D {
> - 2412, 2417, 2422, 2427,
> - 2432, 2437, 2442, 2447,
> - 2452, 2457, 2462, 2467,
> - 2472, 2484
> -};
> -
> -void r8712_indicate_wx_assoc_event(struct _adapter *padapter)
> -{
> - union iwreq_data wrqu;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - wrqu.ap_addr.sa_family =3D ARPHRD_ETHER;
> - memcpy(wrqu.ap_addr.sa_data, pmlmepriv->cur_network.network.MacAddress,=
 ETH_ALEN);
>=20
> - wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
>=20
> -}
> -
> -void r8712_indicate_wx_disassoc_event(struct _adapter *padapter)
> -{
> - union iwreq_data wrqu;
> -
> - wrqu.ap_addr.sa_family =3D ARPHRD_ETHER;
> - eth_zero_addr(wrqu.ap_addr.sa_data);
> - wireless_send_event(padapter->pnetdev, SIOCGIWAP, &wrqu, NULL);
>=20
> -}
> -
> -static inline void handle_pairwise_key(struct sta_info *psta,
> - struct ieee_param *param,
> - struct _adapter padapter)
> -{
> - / pairwise key */
> - memcpy(psta->x_UncstKey.skey, param->u.crypt.key,
>=20
> - (param->u.crypt. key_len > 16 ? 16 : param->u.crypt.key_len));
>=20
> - if (strcmp(param->u.crypt.alg, "TKIP") =3D=3D 0) { /* set mic key */
>=20
> - memcpy(psta->tkiptxmickey. skey,
>=20
> - &param->u.crypt.key[16], 8);
>=20
> - memcpy(psta->tkiprxmickey. skey,
>=20
> - &param->u.crypt.key[24], 8);
>=20
> - padapter->securitypriv. busetkipkey =3D false;
>=20
> - mod_timer(&padapter->securitypriv.tkip_timer,
>=20
> - jiffies + msecs_to_jiffies(50));
> - }
> - r8712_setstakey_cmd(padapter, (unsigned char *)psta, true);
> -}
> -
> -static inline void handle_group_key(struct ieee_param *param,
> - struct _adapter *padapter)
> -{
> - union Keytype *gk =3D padapter->securitypriv.XGrpKey;
>=20
> - union Keytype *gtk =3D padapter->securitypriv.XGrptxmickey;
>=20
> - union Keytype *grk =3D padapter->securitypriv.XGrprxmickey;
>=20
> -
> - if (param->u.crypt.idx > 0 &&
>=20
> - param->u.crypt.idx < 3) {
>=20
> - /* group key idx is 1 or 2 */
> - memcpy(gk[param->u.crypt.idx - 1].skey,
>=20
> - param->u.crypt.key,
>=20
> - (param->u.crypt.key_len > 16 ? 16 :
>=20
> - param->u.crypt.key_len));
>=20
> - memcpy(gtk[param->u.crypt.idx - 1].skey,
>=20
> - &param->u.crypt.key[16], 8);
>=20
> - memcpy(grk[param->u.crypt.idx - 1].skey,
>=20
> - &param->u.crypt.key[24], 8);
>=20
> - padapter->securitypriv.binstallGrpkey =3D true;
>=20
> - r8712_set_key(padapter, &padapter->securitypriv, param->u.crypt.idx);
>=20
> - if (padapter->registrypriv.power_mgnt > PS_MODE_ACTIVE) {
>=20
> - if (padapter->registrypriv.power_mgnt !=3D padapter->pwrctrlpriv.pwr_mo=
de)
>=20
> - mod_timer(&padapter->mlmepriv.dhcp_timer,
>=20
> - jiffies + msecs_to_jiffies(60000));
> - }
> - }
> -}
> -
> -static noinline_for_stack char *translate_scan_wpa(struct iw_request_inf=
o *info,
> - struct wlan_network *pnetwork,
> - struct iw_event *iwe,
> - char *start, char stop)
> -{
> - / parsing WPA/WPA2 IE */
> - u8 buf[MAX_WPA_IE_LEN];
> - u8 wpa_ie[255], rsn_ie[255];
> - u16 wpa_len =3D 0, rsn_len =3D 0;
> - int n, i;
> -
> - r8712_get_sec_ie(pnetwork->network.IEs,
>=20
> - pnetwork->network.IELength, rsn_ie, &rsn_len,
>=20
> - wpa_ie, &wpa_len);
> - if (wpa_len > 0) {
>=20
> - memset(buf, 0, MAX_WPA_IE_LEN);
> - n =3D sprintf(buf, "wpa_ie=3D");
> - for (i =3D 0; i < wpa_len; i++) {
> - n +=3D scnprintf(buf + n, MAX_WPA_IE_LEN - n,
> - "%02x", wpa_ie[i]);
> - if (n =3D=3D MAX_WPA_IE_LEN - 1)
> - break;
> - }
> - memset(iwe, 0, sizeof(*iwe));
> - iwe->cmd =3D IWEVCUSTOM;
>=20
> - iwe->u.data.length =3D (u16)strlen(buf);
>=20
> - start =3D iwe_stream_add_point(info, start, stop, iwe, buf);
> - memset(iwe, 0, sizeof(*iwe));
> - iwe->cmd =3D IWEVGENIE;
>=20
> - iwe->u.data.length =3D (u16)wpa_len;
>=20
> - start =3D iwe_stream_add_point(info, start, stop, iwe, wpa_ie);
> - }
> - if (rsn_len > 0) {
>=20
> - memset(buf, 0, MAX_WPA_IE_LEN);
> - n =3D sprintf(buf, "rsn_ie=3D");
> - for (i =3D 0; i < rsn_len; i++) {
> - n +=3D scnprintf(buf + n, MAX_WPA_IE_LEN - n,
> - "%02x", rsn_ie[i]);
> - if (n =3D=3D MAX_WPA_IE_LEN - 1)
> - break;
> - }
> - memset(iwe, 0, sizeof(*iwe));
> - iwe->cmd =3D IWEVCUSTOM;
>=20
> - iwe->u.data.length =3D strlen(buf);
>=20
> - start =3D iwe_stream_add_point(info, start, stop, iwe, buf);
> - memset(iwe, 0, sizeof(*iwe));
> - iwe->cmd =3D IWEVGENIE;
>=20
> - iwe->u.data.length =3D rsn_len;
>=20
> - start =3D iwe_stream_add_point(info, start, stop, iwe, rsn_ie);
> - }
> -
> - return start;
> -}
> -
> -static noinline_for_stack char *translate_scan_wps(struct iw_request_inf=
o *info,
> - struct wlan_network *pnetwork,
> - struct iw_event *iwe,
> - char *start, char stop)
> -{
> - / parsing WPS IE */
> - u8 wps_ie[512];
> - uint wps_ielen;
> -
> - if (r8712_get_wps_ie(pnetwork->network.IEs, pnetwork->network.IELength,=
 wps_ie, &wps_ielen)) {
>=20
> - if (wps_ielen > 2) {
>=20
> - iwe->cmd =3D IWEVGENIE;
>=20
> - iwe->u.data.length =3D (u16)wps_ielen;
>=20
> - start =3D iwe_stream_add_point(info, start, stop, iwe, wps_ie);
> - }
> - }
> -
> - return start;
> -}
> -
> -static char *translate_scan(struct _adapter *padapter,
> - struct iw_request_info *info,
> - struct wlan_network *pnetwork,
> - char *start, char *stop)
> -{
> - struct iw_event iwe;
> - char *current_val;
> - s8 *p;
> - u32 i =3D 0, ht_ielen =3D 0;
> - u16 cap, ht_cap =3D false;
> - u8 rssi;
> -
> - if ((pnetwork->network.Configuration.DSConfig < 1) ||
>=20
> - (pnetwork->network.Configuration.DSConfig > 14)) {
>=20
> - if (pnetwork->network.Configuration.DSConfig < 1)
>=20
> - pnetwork->network.Configuration.DSConfig =3D 1;
>=20
> - else
> - pnetwork->network.Configuration.DSConfig =3D 14;
>=20
> - }
> - /* AP MAC address */
> - iwe.cmd =3D SIOCGIWAP;
> - iwe.u.ap_addr.sa_family =3D ARPHRD_ETHER;
> - ether_addr_copy(iwe.u.ap_addr.sa_data, pnetwork->network.MacAddress);
>=20
> - start =3D iwe_stream_add_event(info, start, stop, &iwe, IW_EV_ADDR_LEN)=
;
> - /* Add the ESSID */
> - iwe.cmd =3D SIOCGIWESSID;
> - iwe.u.data.flags =3D 1;
> - iwe.u.data.length =3D min_t(u32, pnetwork->network.Ssid.SsidLength, 32)=
;
>=20
> - start =3D iwe_stream_add_point(info, start, stop, &iwe,
> - pnetwork->network.Ssid.Ssid);
>=20
> - /* parsing HT_CAP_IE */
> - p =3D r8712_get_ie(&pnetwork->network.IEs[12], WLAN_EID_HT_CAPABILITY,
>=20
> - &ht_ielen, pnetwork->network.IELength - 12);
>=20
> - if (p && ht_ielen > 0)
>=20
> - ht_cap =3D true;
> - /* Add the protocol name */
> - iwe.cmd =3D SIOCGIWNAME;
> - if (r8712_is_cckratesonly_included(pnetwork->network.rates)) {
>=20
> - if (ht_cap)
> - snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bn");
> - else
> - snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11b");
> - } else if (r8712_is_cckrates_included(pnetwork->network.rates)) {
>=20
> - if (ht_cap)
> - snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bgn");
> - else
> - snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bg");
> - } else {
> - if (ht_cap)
> - snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11gn");
> - else
> - snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11g");
> - }
> - start =3D iwe_stream_add_event(info, start, stop, &iwe, IW_EV_CHAR_LEN)=
;
> - /* Add mode */
> - iwe.cmd =3D SIOCGIWMODE;
> - memcpy((u8 *)&cap, r8712_get_capability_from_ie(pnetwork->network.IEs),=
 2);
>=20
> - le16_to_cpus(&cap);
> - if (cap & (WLAN_CAPABILITY_IBSS | WLAN_CAPABILITY_ESS)) {
> - if (cap & WLAN_CAPABILITY_ESS)
> - iwe.u.mode =3D (u32)IW_MODE_MASTER;
> - else
> - iwe.u.mode =3D (u32)IW_MODE_ADHOC;
> - start =3D iwe_stream_add_event(info, start, stop, &iwe, IW_EV_UINT_LEN)=
;
> - }
> - /* Add frequency/channel /
> - iwe.cmd =3D SIOCGIWFREQ;
> - {
> - / check legal index */
> - u8 dsconfig =3D pnetwork->network.Configuration.DSConfig;
>=20
> -
> - if (dsconfig >=3D 1 && dsconfig <=3D sizeof(ieee80211_wlan_frequencies)=
 / sizeof(long))
>=20
> - iwe.u.freq.m =3D (s32)(ieee80211_wlan_frequencies[dsconfig - 1] * 10000=
0);
> - else
> - iwe.u.freq.m =3D 0;
> - }
> - iwe.u.freq.e =3D (s16)1;
> - iwe.u.freq.i =3D (u8)pnetwork->network.Configuration.DSConfig;
>=20
> - start =3D iwe_stream_add_event(info, start, stop, &iwe,
> - IW_EV_FREQ_LEN);
> - /* Add encryption capability */
> - iwe.cmd =3D SIOCGIWENCODE;
> - if (cap & WLAN_CAPABILITY_PRIVACY)
> - iwe.u.data.flags =3D (u16)(IW_ENCODE_ENABLED | IW_ENCODE_NOKEY);
> - else
> - iwe.u.data.flags =3D (u16)(IW_ENCODE_DISABLED);
> - iwe.u.data.length =3D (u16)0;
> - start =3D iwe_stream_add_point(info, start, stop, &iwe, pnetwork->netwo=
rk.Ssid.Ssid);
>=20
> - /*Add basic and extended rates */
> - current_val =3D start + iwe_stream_lcp_len(info);
> - iwe.cmd =3D SIOCGIWRATE;
> - iwe.u.bitrate.fixed =3D 0;
> - iwe.u.bitrate.disabled =3D 0;
> - iwe.u.bitrate.value =3D 0;
> - i =3D 0;
> - while (pnetwork->network.rates[i] !=3D 0) {
>=20
> - /* Bit rate given in 500 kb/s units */
> - iwe.u.bitrate.value =3D (pnetwork->network.rates[i++] & 0x7F) * 500000;
>=20
> - current_val =3D iwe_stream_add_value(info, start, current_val, stop, &i=
we,
> - IW_EV_PARAM_LEN);
> - }
> - /* Check if we added any event */
> - if ((current_val - start) > iwe_stream_lcp_len(info))
>=20
> - start =3D current_val;
> -
> - start =3D translate_scan_wpa(info, pnetwork, &iwe, start, stop);
> -
> - start =3D translate_scan_wps(info, pnetwork, &iwe, start, stop);
> -
> - /* Add quality statistics */
> - iwe.cmd =3D IWEVQUAL;
> - rssi =3D r8712_signal_scale_mapping(pnetwork->network.Rssi);
>=20
> - /* we only update signal_level (signal strength) that is rssi. /
> - iwe.u.qual.updated =3D (u8)(IW_QUAL_QUAL_INVALID | IW_QUAL_LEVEL_UPDATE=
D | IW_QUAL_NOISE_INVALID);
> - iwe.u.qual.level =3D rssi; / signal strength /
> - iwe.u.qual.qual =3D 0; / signal quality /
> - iwe.u.qual.noise =3D 0; / noise level /
> - start =3D iwe_stream_add_event(info, start, stop, &iwe, IW_EV_QUAL_LEN)=
;
> - / how to translate rssi to ?% */
> - return start;
> -}
> -
> -static int wpa_set_auth_algs(struct net_device *dev, u32 value)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - int ret =3D 0;
> -
> - if ((value & AUTH_ALG_SHARED_KEY) && (value & AUTH_ALG_OPEN_SYSTEM)) {
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption1Enabled;
> - padapter->securitypriv.ndisauthtype =3D
>=20
> - Ndis802_11AuthModeAutoSwitch;
> - padapter->securitypriv.auth_algorithm =3D AUTH_AUTHSWITCH;
>=20
> - } else if (value & AUTH_ALG_SHARED_KEY) {
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption1Enabled;
> - padapter->securitypriv.ndisauthtype =3D Ndis802_11AuthModeShared;
>=20
> - padapter->securitypriv.auth_algorithm =3D AUTH_SHARED_SYSTEM;
>=20
> - } else if (value & AUTH_ALG_OPEN_SYSTEM) {
> - if (padapter->securitypriv.ndisauthtype <
>=20
> - Ndis802_11AuthModeWPAPSK) {
> - padapter->securitypriv.ndisauthtype =3D
>=20
> - Ndis802_11AuthModeOpen;
> - padapter->securitypriv.auth_algorithm =3D AUTH_OPEN_SYSTEM;
>=20
> - }
> - } else {
> - ret =3D -EINVAL;
> - }
> - return ret;
> -}
> -
> -static int wpa_set_encryption(struct net_device *dev, struct ieee_param =
*param,
> - u32 param_len)
> -{
> - int ret =3D 0;
> - u32 wep_key_idx, wep_key_len =3D 0;
> - struct NDIS_802_11_WEP *pwep =3D NULL;
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> -
> - param->u.crypt.err =3D 0;
>=20
> - param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] =3D '\0';
>=20
> - if (param_len !=3D (u32)((u8 *) param->u.crypt.key - (u8 *)param) +
>=20
> - param->u.crypt.key_len)
>=20
> - return -EINVAL;
> - if (!is_broadcast_ether_addr(param->sta_addr))
>=20
> - return -EINVAL;
> -
> - if (param->u.crypt.idx >=3D WEP_KEYS) {
>=20
> - /* for large key indices, set the default (0) */
> - param->u.crypt.idx =3D 0;
>=20
> - }
> - if (strcmp(param->u.crypt.alg, "WEP") =3D=3D 0) {
>=20
> - netdev_info(dev, "r8712u: %s: crypt.alg =3D WEP\n", func);
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption1Enabled;
> - padapter->securitypriv.privacy_algorithm =3D WEP40;
>=20
> - padapter->securitypriv.XGrpPrivacy =3D WEP40;
>=20
> - wep_key_idx =3D param->u.crypt.idx;
>=20
> - wep_key_len =3D param->u.crypt.key_len;
>=20
> - if (wep_key_idx >=3D WEP_KEYS)
>=20
> - wep_key_idx =3D 0;
> - if (wep_key_len <=3D 0)
> - return -EINVAL;
> -
> - wep_key_len =3D wep_key_len <=3D 5 ? 5 : 13;
> - pwep =3D kzalloc(sizeof(*pwep), GFP_ATOMIC);
> - if (!pwep)
> - return -ENOMEM;
> - pwep->KeyLength =3D wep_key_len;
>=20
> - pwep->Length =3D wep_key_len +
>=20
> - offsetof(struct NDIS_802_11_WEP, KeyMaterial);
> - if (wep_key_len =3D=3D 13) {
> - padapter->securitypriv.privacy_algorithm =3D WEP104;
>=20
> - padapter->securitypriv.XGrpPrivacy =3D WEP104;
>=20
> - }
> - pwep->KeyIndex =3D wep_key_idx;
>=20
> - pwep->KeyIndex |=3D 0x80000000;
>=20
> - memcpy(pwep->KeyMaterial, param->u.crypt.key, pwep->KeyLength);
>=20
> - if (param->u.crypt.set_tx) {
>=20
> - if (r8712_set_802_11_add_wep(padapter, pwep))
> - ret =3D -EOPNOTSUPP;
> - } else {
> - /* don't update "psecuritypriv->privacy_algorithm" and
>=20
> - * "psecuritypriv->PrivacyKeyIndex=3Dkeyid", but can
>=20
> - * r8712_set_key to fw/cam
> - */
> - if (wep_key_idx >=3D WEP_KEYS) {
>=20
> - ret =3D -EOPNOTSUPP;
> - goto exit;
> - }
> - memcpy(&psecuritypriv->DefKey[wep_key_idx].skey[0],
>=20
> - pwep->KeyMaterial,
>=20
> - pwep->KeyLength);
>=20
> - psecuritypriv->DefKeylen[wep_key_idx] =3D
>=20
> - pwep->KeyLength;
>=20
> - r8712_set_key(padapter, psecuritypriv, wep_key_idx);
> - }
> - goto exit;
> - }
> - if (padapter->securitypriv.auth_algorithm =3D=3D AUTH_8021x) {
>=20
> - struct sta_info *psta, *pbcmc_sta;
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> - struct security_priv *spriv =3D &padapter->securitypriv;
>=20
> -
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE |
> - WIFI_MP_STATE)) { /* sta mode */
> - psta =3D r8712_get_stainfo(pstapriv,
> - get_bssid(pmlmepriv));
> - if (psta) {
> - psta->ieee8021x_blocked =3D false;
>=20
> - if (spriv->ndisencryptstatus =3D=3D
>=20
> - Ndis802_11Encryption2Enabled ||
> - spriv->ndisencryptstatus =3D=3D
>=20
> - Ndis802_11Encryption3Enabled)
> - psta->XPrivacy =3D spriv->privacy_algorithm;
>=20
> - if (param->u.crypt.set_tx =3D=3D 1)
>=20
> - handle_pairwise_key(psta, param,
> - padapter);
> - else /* group key */
> - handle_group_key(param, padapter);
> - }
> - pbcmc_sta =3D r8712_get_bcmc_stainfo(padapter);
> - if (pbcmc_sta) {
> - pbcmc_sta->ieee8021x_blocked =3D false;
>=20
> - if (spriv->ndisencryptstatus =3D=3D
>=20
> - Ndis802_11Encryption2Enabled ||
> - spriv->ndisencryptstatus =3D=3D
>=20
> - Ndis802_11Encryption3Enabled)
> - pbcmc_sta->XPrivacy =3D
>=20
> - spriv->privacy_algorithm;
>=20
> - }
> - }
> - }
> -exit:
> - kfree(pwep);
> - return ret;
> -}
> -
> -static int r871x_set_wpa_ie(struct _adapter *padapter, char *pie,
> - unsigned short ielen)
> -{
> - u8 *buf =3D NULL;
> - int group_cipher =3D 0, pairwise_cipher =3D 0;
> - int ret =3D 0;
> -
> - if (ielen > MAX_WPA_IE_LEN || !pie)
>=20
> - return -EINVAL;
> - if (ielen) {
> - buf =3D kmemdup(pie, ielen, GFP_ATOMIC);
> - if (!buf)
> - return -ENOMEM;
> - if (ielen < RSN_HEADER_LEN) {
> - ret =3D -EINVAL;
> - goto exit;
> - }
> - if (r8712_parse_wpa_ie(buf, ielen, &group_cipher,
> - &pairwise_cipher) =3D=3D 0) {
> - padapter->securitypriv.auth_algorithm =3D AUTH_8021x;
>=20
> - padapter->securitypriv.ndisauthtype =3D
>=20
> - Ndis802_11AuthModeWPAPSK;
> - }
> - if (r8712_parse_wpa2_ie(buf, ielen, &group_cipher,
> - &pairwise_cipher) =3D=3D 0) {
> - padapter->securitypriv.auth_algorithm =3D AUTH_8021x;
>=20
> - padapter->securitypriv.ndisauthtype =3D
>=20
> - Ndis802_11AuthModeWPA2PSK;
> - }
> - switch (group_cipher) {
> - case WPA_CIPHER_NONE:
> - padapter->securitypriv.XGrpPrivacy =3D NO_PRIVACY;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11EncryptionDisabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_WEP40:
> - padapter->securitypriv.XGrpPrivacy =3D WEP40;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption1Enabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_TKIP:
> - padapter->securitypriv.XGrpPrivacy =3D TKIP;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption2Enabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_CCMP:
> - padapter->securitypriv.XGrpPrivacy =3D AES;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption3Enabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_WEP104:
> - padapter->securitypriv.XGrpPrivacy =3D WEP104;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption1Enabl=
ed;
>=20
> - break;
> - }
> - switch (pairwise_cipher) {
> - case WPA_CIPHER_NONE:
> - padapter->securitypriv.privacy_algorithm =3D NO_PRIVACY;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11EncryptionDisabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_WEP40:
> - padapter->securitypriv.privacy_algorithm =3D WEP40;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption1Enabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_TKIP:
> - padapter->securitypriv.privacy_algorithm =3D TKIP;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption2Enabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_CCMP:
> - padapter->securitypriv.privacy_algorithm =3D AES;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption3Enabl=
ed;
>=20
> - break;
> - case WPA_CIPHER_WEP104:
> - padapter->securitypriv.privacy_algorithm =3D WEP104;
>=20
> - padapter->securitypriv.ndisencryptstatus =3D Ndis802_11Encryption1Enabl=
ed;
>=20
> - break;
> - }
> - padapter->securitypriv.wps_phase =3D false;
>=20
> - {/* set wps_ie */
> - u16 cnt =3D 0;
> - u8 eid, wps_oui[4] =3D {0x0, 0x50, 0xf2, 0x04};
> -
> - while (cnt < ielen) {
> - eid =3D buf[cnt];
> -
> - if ((eid =3D=3D WLAN_EID_VENDOR_SPECIFIC) &&
> - (!memcmp(&buf[cnt + 2], wps_oui, 4))) {
> - netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE\n");
>=20
> - padapter->securitypriv.wps_ie_len =3D
>=20
> - ((buf[cnt + 1] + 2) <
> - (MAX_WPA_IE_LEN << 2)) ?
> - (buf[cnt + 1] + 2) :
> - (MAX_WPA_IE_LEN << 2);
> - memcpy(padapter->securitypriv.wps_ie,
>=20
> - &buf[cnt],
> - padapter->securitypriv.wps_ie_len);
>=20
> - padapter->securitypriv.wps_phase =3D
>=20
> - true;
> - netdev_info(padapter->pnetdev, "r8712u: SET WPS_IE, wps_phase=3D=3Dtrue=
\n");
>=20
> - cnt +=3D buf[cnt + 1] + 2;
> - break;
> - }
> -
> - cnt +=3D buf[cnt + 1] + 2;
> - }
> - }
> - }
> -exit:
> - kfree(buf);
> - return ret;
> -}
> -
> -static int r8711_wx_get_name(struct net_device *dev, struct iw_request_i=
nfo *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - u32 ht_ielen =3D 0;
> - char *p;
> - u8 ht_cap =3D false;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_bssid_ex *pcur_bss =3D &pmlmepriv->cur_network.network;
>=20
> - u8 prates;
> -
> - if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE) =3D=
=3D true) {
> - / parsing HT_CAP_IE */
> - p =3D r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY,
>=20
> - &ht_ielen, pcur_bss->IELength - 12);
>=20
> - if (p && ht_ielen > 0)
>=20
> - ht_cap =3D true;
> - prates =3D pcur_bss->rates;
>=20
> - if (r8712_is_cckratesonly_included(prates)) {
> - if (ht_cap)
> - snprintf(wrqu->name, IFNAMSIZ,
>=20
> - "IEEE 802.11bn");
> - else
> - snprintf(wrqu->name, IFNAMSIZ,
>=20
> - "IEEE 802.11b");
> - } else if (r8712_is_cckrates_included(prates)) {
> - if (ht_cap)
> - snprintf(wrqu->name, IFNAMSIZ,
>=20
> - "IEEE 802.11bgn");
> - else
> - snprintf(wrqu->name, IFNAMSIZ,
>=20
> - "IEEE 802.11bg");
> - } else {
> - if (ht_cap)
> - snprintf(wrqu->name, IFNAMSIZ,
>=20
> - "IEEE 802.11gn");
> - else
> - snprintf(wrqu->name, IFNAMSIZ,
>=20
> - "IEEE 802.11g");
> - }
> - } else {
> - snprintf(wrqu->name, IFNAMSIZ, "unassociated");
>=20
> - }
> - return 0;
> -}
> -
> -static const long frequency_list[] =3D {
> - 2412, 2417, 2422, 2427, 2432, 2437, 2442, 2447, 2452, 2457, 2462,
> - 2467, 2472, 2484, 4915, 4920, 4925, 4935, 4940, 4945, 4960, 4980,
> - 5035, 5040, 5045, 5055, 5060, 5080, 5170, 5180, 5190, 5200, 5210,
> - 5220, 5230, 5240, 5260, 5280, 5300, 5320, 5500, 5520, 5540, 5560,
> - 5580, 5600, 5620, 5640, 5660, 5680, 5700, 5745, 5765, 5785, 5805,
> - 5825
> -};
> -
> -static int r8711_wx_set_freq(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_freq *fwrq =3D &wrqu->freq;
>=20
> - int rc =3D 0;
> -
> -/* If setting by frequency, convert to a channel */
> - if ((fwrq->e =3D=3D 1) && (fwrq->m >=3D 241200000) && (fwrq->m <=3D 248=
700000)) {
>=20
> - int f =3D fwrq->m / 100000;
>=20
> - int c =3D 0;
> -
> - while ((c < 14) && (f !=3D frequency_list[c]))
> - c++;
> - fwrq->e =3D 0;
>=20
> - fwrq->m =3D c + 1;
>=20
> - }
> - /* Setting by channel number */
> - if ((fwrq->m > 14) || (fwrq->e > 0)) {
>=20
> - rc =3D -EOPNOTSUPP;
> - } else {
> - int channel =3D fwrq->m;
>=20
> -
> - if ((channel < 1) || (channel > 14)) {
>=20
> - rc =3D -EINVAL;
> - } else {
> - /* Yes ! We can set it !!! */
> - padapter->registrypriv.channel =3D channel;
>=20
> - }
> - }
> - return rc;
> -}
> -
> -static int r8711_wx_get_freq(struct net_device *dev, struct iw_request_i=
nfo *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_bssid_ex *pcur_bss =3D &pmlmepriv->cur_network.network;
>=20
> -
> - if (!check_fwstate(pmlmepriv, _FW_LINKED))
> - return -ENOLINK;
> -
> - wrqu->freq.m =3D ieee80211_wlan_frequencies[
>=20
> - pcur_bss->Configuration.DSConfig - 1] * 100000;
>=20
> - wrqu->freq.e =3D 1;
>=20
> - wrqu->freq.i =3D pcur_bss->Configuration.DSConfig;
>=20
> -
> - return 0;
> -}
> -
> -static int r8711_wx_set_mode(struct net_device *dev,
> - struct iw_request_info *a,
> - union iwreq_data *wrqu, char *b)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - enum NDIS_802_11_NETWORK_INFRASTRUCTURE networkType;
> -
> - switch (wrqu->mode) {
>=20
> - case IW_MODE_AUTO:
> - networkType =3D Ndis802_11AutoUnknown;
> - break;
> - case IW_MODE_ADHOC:
> - networkType =3D Ndis802_11IBSS;
> - break;
> - case IW_MODE_MASTER:
> - networkType =3D Ndis802_11APMode;
> - break;
> - case IW_MODE_INFRA:
> - networkType =3D Ndis802_11Infrastructure;
> - break;
> - default:
> - return -EINVAL;
> - }
> - if (Ndis802_11APMode =3D=3D networkType)
> - r8712_setopmode_cmd(padapter, networkType);
> - else
> - r8712_setopmode_cmd(padapter, Ndis802_11AutoUnknown);
> -
> - r8712_set_802_11_infrastructure_mode(padapter, networkType);
> - return 0;
> -}
> -
> -static int r8711_wx_get_mode(struct net_device *dev, struct iw_request_i=
nfo *a,
> - union iwreq_data *wrqu, char *b)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> - wrqu->mode =3D IW_MODE_INFRA;
>=20
> - else if (check_fwstate(pmlmepriv,
> - WIFI_ADHOC_MASTER_STATE | WIFI_ADHOC_STATE))
> - wrqu->mode =3D IW_MODE_ADHOC;
>=20
> - else if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
> - wrqu->mode =3D IW_MODE_MASTER;
>=20
> - else
> - wrqu->mode =3D IW_MODE_AUTO;
>=20
> - return 0;
> -}
> -
> -static int r871x_wx_set_pmkid(struct net_device *dev, struct iw_request_=
info *a,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - struct iw_pmksa *pPMK =3D (struct iw_pmksa *) extra;
> - struct RT_PMKID_LIST *pl =3D psecuritypriv->PMKIDList;
>=20
> - u8 strZeroMacAddress[ETH_ALEN] =3D {0x00};
> - u8 strIssueBssid[ETH_ALEN] =3D {0x00};
> - u8 j, blInserted =3D false;
> - int intReturn =3D false;
> -
> -/*
> - * There are the BSSID information in the bssid.sa_data array.
> - * If cmd is IW_PMKSA_FLUSH, it means the wpa_supplicant wants to clear
> - * all the PMKID information. If cmd is IW_PMKSA_ADD, it means the
> - * wpa_supplicant wants to add a PMKID/BSSID to driver.
> - * If cmd is IW_PMKSA_REMOVE, it means the wpa_supplicant wants to
> - * remove a PMKID/BSSID from driver.
> - */
> - if (!pPMK)
> - return -EINVAL;
> - memcpy(strIssueBssid, pPMK->bssid.sa_data, ETH_ALEN);
>=20
> - switch (pPMK->cmd) {
>=20
> - case IW_PMKSA_ADD:
> - if (!memcmp(strIssueBssid, strZeroMacAddress, ETH_ALEN))
> - return intReturn;
> - intReturn =3D true;
> - blInserted =3D false;
> - /* overwrite PMKID /
> - for (j =3D 0; j < NUM_PMKID_CACHE; j++) {
> - if (!memcmp(pl[j].Bssid, strIssueBssid, ETH_ALEN)) {
> - / BSSID is matched, the same AP =3D> rewrite
>=20
> - * with new PMKID.
> - */
> - netdev_info(dev, "r8712u: %s: BSSID exists in the PMKList.\n",
> - func);
> - memcpy(pl[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
>=20
> - pl[j].bUsed =3D true;
> - psecuritypriv->PMKIDIndex =3D j + 1;
>=20
> - blInserted =3D true;
> - break;
> - }
> - }
> - if (!blInserted) {
> - /* Find a new entry */
> - netdev_info(dev, "r8712u: %s: Use the new entry index =3D %d for this P=
MKID.\n",
> - func, psecuritypriv->PMKIDIndex);
>=20
> - memcpy(pl[psecuritypriv->PMKIDIndex].Bssid,
>=20
> - strIssueBssid, ETH_ALEN);
> - memcpy(pl[psecuritypriv->PMKIDIndex].PMKID,
>=20
> - pPMK->pmkid, IW_PMKID_LEN);
>=20
> - pl[psecuritypriv->PMKIDIndex].bUsed =3D true;
>=20
> - psecuritypriv->PMKIDIndex++;
>=20
> - if (psecuritypriv->PMKIDIndex =3D=3D NUM_PMKID_CACHE)
>=20
> - psecuritypriv->PMKIDIndex =3D 0;
>=20
> - }
> - break;
> - case IW_PMKSA_REMOVE:
> - intReturn =3D true;
> - for (j =3D 0; j < NUM_PMKID_CACHE; j++) {
> - if (!memcmp(pl[j].Bssid, strIssueBssid, ETH_ALEN)) {
> - /* BSSID is matched, the same AP =3D> Remove
>=20
> - * this PMKID information and reset it.
> - */
> - eth_zero_addr(pl[j].Bssid);
> - pl[j].bUsed =3D false;
> - break;
> - }
> - }
> - break;
> - case IW_PMKSA_FLUSH:
> - memset(psecuritypriv->PMKIDList, 0,
>=20
> - sizeof(struct RT_PMKID_LIST) * NUM_PMKID_CACHE);
> - psecuritypriv->PMKIDIndex =3D 0;
>=20
> - intReturn =3D true;
> - break;
> - default:
> - netdev_info(dev, "r8712u: %s: unknown Command\n", func);
> - intReturn =3D false;
> - break;
> - }
> - return intReturn;
> -}
> -
> -static int r8711_wx_get_sens(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - wrqu->sens.value =3D 0;
>=20
> - wrqu->sens.fixed =3D 0; /* no auto select */
>=20
> - wrqu->sens.disabled =3D 1;
>=20
> - return 0;
> -}
> -
> -static int r8711_wx_get_range(struct net_device *dev, struct iw_request_=
info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct iw_range *range =3D (struct iw_range *)extra;
> - u16 val;
> - int i;
> -
> - wrqu->data.length =3D sizeof(*range);
>=20
> - memset(range, 0, sizeof(range));
> - / Let's try to keep this struct in the same order as in
> - * linux/include/wireless.h
> - /
> -
> - / TODO: See what values we can set, and remove the ones we can't
> - * set, or fill them with some default data.
> - /
> - / ~5 Mb/s real (802.11b) */
> - range->throughput =3D 5 * 1000 * 1000;
>=20
> - /* TODO: 8711 sensitivity ? /
> - / signal level threshold range /
> - / percent values between 0 and 100. */
> - range->max_qual.qual =3D 100;
>=20
> - range->max_qual.level =3D 100;
>=20
> - range->max_qual.noise =3D 100;
>=20
> - range->max_qual.updated =3D 7; /* Updated all three */
>=20
> - range->avg_qual.qual =3D 92; /* > 8% missed beacons is 'bad' */
>=20
> - /* TODO: Find real 'good' to 'bad' threshold value for RSSI */
> - range->avg_qual.level =3D 0x100 - 78;
>=20
> - range->avg_qual.noise =3D 0;
>=20
> - range->avg_qual.updated =3D 7; /* Updated all three */
>=20
> - range->num_bitrates =3D RATE_COUNT;
>=20
> - for (i =3D 0; i < RATE_COUNT && i < IW_MAX_BITRATES; i++)
> - range->bitrate[i] =3D rtl8180_rates[i];
>=20
> - range->min_frag =3D MIN_FRAG_THRESHOLD;
>=20
> - range->max_frag =3D MAX_FRAG_THRESHOLD;
>=20
> - range->pm_capa =3D 0;
>=20
> - range->we_version_compiled =3D WIRELESS_EXT;
>=20
> - range->we_version_source =3D 16;
>=20
> - range->num_channels =3D 14;
>=20
> - for (i =3D 0, val =3D 0; i < 14; i++) {
> - /* Include only legal frequencies for some countries */
> - range->freq[val].i =3D i + 1;
>=20
> - range->freq[val].m =3D ieee80211_wlan_frequencies[i] * 100000;
>=20
> - range->freq[val].e =3D 1;
>=20
> - val++;
> - if (val =3D=3D IW_MAX_FREQUENCIES)
> - break;
> - }
> - range->num_frequency =3D val;
>=20
> - range->enc_capa =3D IW_ENC_CAPA_WPA |
>=20
> - IW_ENC_CAPA_WPA2 |
> - IW_ENC_CAPA_CIPHER_TKIP |
> - IW_ENC_CAPA_CIPHER_CCMP;
> - return 0;
> -}
> -
> -static int r8711_wx_get_rate(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra);
> -
> -static int r871x_wx_set_priv(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *awrq,
> - char *extra)
> -{
> - int ret =3D 0, len =3D 0;
> - char *ext;
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_point *dwrq =3D (struct iw_point *)awrq;
> -
> - len =3D dwrq->length;
>=20
> - ext =3D strndup_user(dwrq->pointer, len);
>=20
> - if (IS_ERR(ext))
> - return PTR_ERR(ext);
> -
> - if (!strcasecmp(ext, "RSSI")) {
> - /*Return received signal strength indicator in -db for /
> - / current AP /
> - /<ssid> Rssi xx */
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_network *pcur_network =3D &pmlmepriv->cur_network;
>=20
> - /*static u8 xxxx; */
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - sprintf(ext, "%s rssi %d",
> - pcur_network->network.Ssid.Ssid,
>=20
> - /*(xxxx=3Dxxxx+10) */
> - ((padapter->recvpriv.fw_rssi) >> 1) - 95
>=20
> - /*pcur_network->network.Rssi */
>=20
> - );
> - } else {
> - sprintf(ext, "OK");
> - }
> - } else if (!strcasecmp(ext, "LINKSPEED")) {
> - /*Return link speed in MBPS */
> - /*LinkSpeed xx */
> - union iwreq_data wrqd;
> - int ret_inner;
> - int mbps;
> -
> - ret_inner =3D r8711_wx_get_rate(dev, info, &wrqd, extra);
> - if (ret_inner !=3D 0)
> - mbps =3D 0;
> - else
> - mbps =3D wrqd.bitrate.value / 1000000;
> - sprintf(ext, "LINKSPEED %d", mbps);
> - } else if (!strcasecmp(ext, "MACADDR")) {
> - /*Return mac address of the station /
> - / Macaddr =3D xx:xx:xx:xx:xx:xx */
> - sprintf(ext, "MACADDR =3D %pM", dev->dev_addr);
>=20
> - } else if (!strcasecmp(ext, "SCAN-ACTIVE")) {
> - /*Set scan type to active */
> - /*OK if successful */
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - pmlmepriv->passive_mode =3D 1;
>=20
> - sprintf(ext, "OK");
> - } else if (!strcasecmp(ext, "SCAN-PASSIVE")) {
> - /*Set scan type to passive */
> - /*OK if successful */
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - pmlmepriv->passive_mode =3D 0;
>=20
> - sprintf(ext, "OK");
> - } else if (!strncmp(ext, "DCE-E", 5)) {
> - /*Set scan type to passive */
> - /*OK if successful */
> - r8712_disconnectCtrlEx_cmd(padapter
> - , 1 /*u32 enableDrvCtrl */
> - , 5 /*u32 tryPktCnt */
> - , 100 /*u32 tryPktInterval */
> - , 5000 /*u32 firstStageTO */
> - );
> - sprintf(ext, "OK");
> - } else if (!strncmp(ext, "DCE-D", 5)) {
> - /*Set scan type to passive */
> - /*OK if successfu */
> - r8712_disconnectCtrlEx_cmd(padapter
> - , 0 /*u32 enableDrvCtrl */
> - , 5 /*u32 tryPktCnt */
> - , 100 /*u32 tryPktInterval */
> - , 5000 /*u32 firstStageTO */
> - );
> - sprintf(ext, "OK");
> - } else {
> - netdev_info(dev, "r8712u: %s: unknown Command %s.\n", func, ext);
> - goto FREE_EXT;
> - }
> - if (copy_to_user(dwrq->pointer, ext, min(dwrq->length, (__u16)(strlen(e=
xt) + 1))))
>=20
> - ret =3D -EFAULT;
> -
> -FREE_EXT:
> - kfree(ext);
> - return ret;
> -}
> -
> -/* set bssid flow
> - * s1. set_802_11_infrastructure_mode()
> - * s2. set_802_11_authentication_mode()
> - * s3. set_802_11_encryption_mode()
> - * s4. set_802_11_bssid()
> - *
> - * This function intends to handle the Set AP command, which specifies t=
he
> - * MAC# of a preferred Access Point.
> - * Currently, the request comes via Wireless Extensions' SIOCSIWAP ioctl=
.
> - *
> - * For this operation to succeed, there is no need for the interface to =
be up.
> - *
> - */
> -static int r8711_wx_set_wap(struct net_device *dev, struct iw_request_in=
fo *info,
> - union iwreq_data *awrq, char *extra)
> -{
> - int ret =3D -EINPROGRESS;
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct __queue *queue =3D &pmlmepriv->scanned_queue;
>=20
> - struct sockaddr *temp =3D (struct sockaddr *)awrq;
> - unsigned long irqL;
> - struct list_head *phead;
> - u8 *dst_bssid;
> - struct wlan_network *pnetwork =3D NULL;
> - enum NDIS_802_11_AUTHENTICATION_MODE authmode;
> -
> - if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
> - return -EBUSY;
> - if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
> - return ret;
> - if (temp->sa_family !=3D ARPHRD_ETHER)
>=20
> - return -EINVAL;
> - authmode =3D padapter->securitypriv.ndisauthtype;
>=20
> - spin_lock_irqsave(&queue->lock, irqL);
>=20
> - phead =3D &queue->queue;
>=20
> - pmlmepriv->pscanned =3D phead->next;
>=20
> - while (1) {
> - if (end_of_queue_search(phead, pmlmepriv->pscanned))
>=20
> - break;
> - pnetwork =3D container_of(pmlmepriv->pscanned,
>=20
> - struct wlan_network, list);
> - pmlmepriv->pscanned =3D pmlmepriv->pscanned->next;
>=20
> - dst_bssid =3D pnetwork->network.MacAddress;
>=20
> - if (!memcmp(dst_bssid, temp->sa_data, ETH_ALEN)) {
>=20
> - r8712_set_802_11_infrastructure_mode(padapter,
> - pnetwork->network.InfrastructureMode);
>=20
> - break;
> - }
> - }
> - spin_unlock_irqrestore(&queue->lock, irqL);
>=20
> - if (!ret) {
> - if (!r8712_set_802_11_authentication_mode(padapter, authmode)) {
> - ret =3D -ENOMEM;
> - } else {
> - if (!r8712_set_802_11_bssid(padapter, temp->sa_data))
>=20
> - ret =3D -1;
> - }
> - }
> - return ret;
> -}
> -
> -static int r8711_wx_get_wap(struct net_device *dev, struct iw_request_in=
fo *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_bssid_ex *pcur_bss =3D &pmlmepriv->cur_network.network;
>=20
> -
> - wrqu->ap_addr.sa_family =3D ARPHRD_ETHER;
>=20
> - if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE | WIF=
I_AP_STATE))
> - ether_addr_copy(wrqu->ap_addr.sa_data, pcur_bss->MacAddress);
>=20
> - else
> - eth_zero_addr(wrqu->ap_addr.sa_data);
>=20
> - return 0;
> -}
> -
> -static int r871x_wx_set_mlme(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - int ret =3D 0;
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_mlme *mlme =3D (struct iw_mlme *) extra;
> -
> - if (!mlme)
> - return -1;
> - switch (mlme->cmd) {
>=20
> - case IW_MLME_DEAUTH:
> - if (!r8712_set_802_11_disassociate(padapter))
> - ret =3D -1;
> - break;
> - case IW_MLME_DISASSOC:
> - if (!r8712_set_802_11_disassociate(padapter))
> - ret =3D -1;
> - break;
> - default:
> - return -EOPNOTSUPP;
> - }
> - return ret;
> -}
> -
> -/*
> - *
> - * This function intends to handle the Set Scan command.
> - * Currently, the request comes via Wireless Extensions' SIOCSIWSCAN ioc=
tl.
> - *
> - * For this operation to succeed, the interface is brought Up beforehand=
.
> - *
> - */
> -static int r8711_wx_set_scan(struct net_device *dev, struct iw_request_i=
nfo *a,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - u8 status =3D true;
> -
> - if (padapter->driver_stopped) {
>=20
> - netdev_info(dev, "In %s: driver_stopped=3D%d\n",
> - func, padapter->driver_stopped);
>=20
> - return -1;
> - }
> - if (!padapter->bup)
>=20
> - return -ENETDOWN;
> - if (!padapter->hw_init_completed)
>=20
> - return -1;
> - if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) ||
> - (pmlmepriv->sitesurveyctrl.traffic_busy))
>=20
> - return 0;
> - if (wrqu->data.length =3D=3D sizeof(struct iw_scan_req)) {
>=20
> - struct iw_scan_req *req =3D (struct iw_scan_req *)extra;
> -
> - if (wrqu->data.flags & IW_SCAN_THIS_ESSID) {
>=20
> - struct ndis_802_11_ssid ssid;
> - unsigned long irqL;
> - u32 len =3D min_t(u8, req->essid_len, IW_ESSID_MAX_SIZE);
>=20
> -
> - memset((unsigned char *)&ssid, 0, sizeof(struct ndis_802_11_ssid));
> - memcpy(ssid.Ssid, req->essid, len);
>=20
> - ssid.SsidLength =3D len;
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if ((check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
> - _FW_UNDER_LINKING)) ||
> - (pmlmepriv->sitesurveyctrl.traffic_busy)) {
>=20
> - if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
> - status =3D false;
> - } else {
> - status =3D r8712_sitesurvey_cmd(padapter, &ssid);
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - }
> - } else {
> - status =3D r8712_set_802_11_bssid_list_scan(padapter);
> - }
> - if (!status)
> - return -1;
> - return 0;
> -}
> -
> -static int r8711_wx_get_scan(struct net_device *dev, struct iw_request_i=
nfo *a,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct __queue *queue =3D &pmlmepriv->scanned_queue;
>=20
> - struct wlan_network *pnetwork =3D NULL;
> - unsigned long irqL;
> - struct list_head *plist, *phead;
> - char *ev =3D extra;
> - char *stop =3D ev + wrqu->data.length;
>=20
> - u32 ret =3D 0, cnt =3D 0;
> -
> - if (padapter->driver_stopped)
>=20
> - return -EINVAL;
> - while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) =
{
> - msleep(30);
> - cnt++;
> - if (cnt > 100)
>=20
> - break;
> - }
> - spin_lock_irqsave(&queue->lock, irqL);
>=20
> - phead =3D &queue->queue;
>=20
> - plist =3D phead->next;
>=20
> - while (1) {
> - if (end_of_queue_search(phead, plist))
> - break;
> - if ((stop - ev) < SCAN_ITEM_SIZE) {
> - ret =3D -E2BIG;
> - break;
> - }
> - pnetwork =3D container_of(plist, struct wlan_network, list);
> - ev =3D translate_scan(padapter, a, pnetwork, ev, stop);
> - plist =3D plist->next;
>=20
> - }
> - spin_unlock_irqrestore(&queue->lock, irqL);
>=20
> - wrqu->data.length =3D ev - extra;
>=20
> - wrqu->data.flags =3D 0;
>=20
> - return ret;
> -}
> -
> -/* set ssid flow
> - * s1. set_802_11_infrastructure_mode()
> - * s2. set_802_11_authenticaion_mode()
> - * s3. set_802_11_encryption_mode()
> - * s4. set_802_11_ssid()
> - *
> - * This function intends to handle the Set ESSID command.
> - * Currently, the request comes via the Wireless Extensions' SIOCSIWESSI=
D ioctl.
> - *
> - * For this operation to succeed, there is no need for the interface to =
be Up.
> - *
> - */
> -static int r8711_wx_set_essid(struct net_device *dev, struct iw_request_=
info *a,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct __queue *queue =3D &pmlmepriv->scanned_queue;
>=20
> - struct wlan_network *pnetwork =3D NULL;
> - enum NDIS_802_11_AUTHENTICATION_MODE authmode;
> - struct ndis_802_11_ssid ndis_ssid;
> - u8 *dst_ssid, *src_ssid;
> - struct list_head *phead;
> - u32 len;
> -
> - if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
> - return -EBUSY;
> - if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
> - return 0;
> - if (wrqu->essid.length > IW_ESSID_MAX_SIZE)
>=20
> - return -E2BIG;
> - authmode =3D padapter->securitypriv.ndisauthtype;
>=20
> - if (wrqu->essid.flags && wrqu->essid.length) {
>=20
> - len =3D (wrqu->essid.length < IW_ESSID_MAX_SIZE) ?
>=20
> - wrqu->essid.length : IW_ESSID_MAX_SIZE;
>=20
> - memset(&ndis_ssid, 0, sizeof(struct ndis_802_11_ssid));
> - ndis_ssid.SsidLength =3D len;
> - memcpy(ndis_ssid.Ssid, extra, len);
> - src_ssid =3D ndis_ssid.Ssid;
> - phead =3D &queue->queue;
>=20
> - pmlmepriv->pscanned =3D phead->next;
>=20
> - while (1) {
> - if (end_of_queue_search(phead, pmlmepriv->pscanned))
>=20
> - break;
> - pnetwork =3D container_of(pmlmepriv->pscanned,
>=20
> - struct wlan_network, list);
> - pmlmepriv->pscanned =3D pmlmepriv->pscanned->next;
>=20
> - dst_ssid =3D pnetwork->network.Ssid.Ssid;
>=20
> - if ((!memcmp(dst_ssid, src_ssid, ndis_ssid.SsidLength))
> - && (pnetwork->network.Ssid.SsidLength =3D=3D
>=20
> - ndis_ssid.SsidLength)) {
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> - if (pnetwork->network.
>=20
> - InfrastructureMode
> - !=3D
> - padapter->mlmepriv.
>=20
> - cur_network.network.
> - InfrastructureMode)
> - continue;
> - }
> -
> - r8712_set_802_11_infrastructure_mode(
> - padapter,
> - pnetwork->network.InfrastructureMode);
>=20
> - break;
> - }
> - }
> - r8712_set_802_11_authentication_mode(padapter, authmode);
> - r8712_set_802_11_ssid(padapter, &ndis_ssid);
> - }
> - return -EINPROGRESS;
> -}
> -
> -static int r8711_wx_get_essid(struct net_device *dev, struct iw_request_=
info *a,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_bssid_ex *pcur_bss =3D &pmlmepriv->cur_network.network;
>=20
> - u32 len, ret =3D 0;
> -
> - if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
> - len =3D pcur_bss->Ssid.SsidLength;
>=20
> - wrqu->essid.length =3D len;
>=20
> - memcpy(extra, pcur_bss->Ssid.Ssid, len);
>=20
> - wrqu->essid.flags =3D 1;
>=20
> - } else {
> - ret =3D -ENOLINK;
> - }
> - return ret;
> -}
> -
> -static int r8711_wx_set_rate(struct net_device *dev, struct iw_request_i=
nfo *a,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - u32 target_rate =3D wrqu->bitrate.value;
>=20
> - u32 fixed =3D wrqu->bitrate.fixed;
>=20
> - u32 ratevalue =3D 0;
> - u8 datarates[NumRates];
> - u8 mpdatarate[NumRates] =3D {11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0xff=
};
> - int i;
> -
> - if (target_rate =3D=3D -1) {
> - ratevalue =3D 11;
> - goto set_rate;
> - }
> - target_rate =3D target_rate / 100000;
> - switch (target_rate) {
> - case 10:
> - ratevalue =3D 0;
> - break;
> - case 20:
> - ratevalue =3D 1;
> - break;
> - case 55:
> - ratevalue =3D 2;
> - break;
> - case 60:
> - ratevalue =3D 3;
> - break;
> - case 90:
> - ratevalue =3D 4;
> - break;
> - case 110:
> - ratevalue =3D 5;
> - break;
> - case 120:
> - ratevalue =3D 6;
> - break;
> - case 180:
> - ratevalue =3D 7;
> - break;
> - case 240:
> - ratevalue =3D 8;
> - break;
> - case 360:
> - ratevalue =3D 9;
> - break;
> - case 480:
> - ratevalue =3D 10;
> - break;
> - case 540:
> - ratevalue =3D 11;
> - break;
> - default:
> - ratevalue =3D 11;
> - break;
> - }
> -set_rate:
> - for (i =3D 0; i < NumRates; i++) {
> - if (ratevalue =3D=3D mpdatarate[i]) {
> - datarates[i] =3D mpdatarate[i];
> - if (fixed =3D=3D 0)
> - break;
> - } else {
> - datarates[i] =3D 0xff;
> - }
> - }
> - return r8712_setdatarate_cmd(padapter, datarates);
> -}
> -
> -static int r8711_wx_get_rate(struct net_device *dev, struct iw_request_i=
nfo *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_bssid_ex *pcur_bss =3D &pmlmepriv->cur_network.network;
>=20
> - struct ieee80211_ht_cap *pht_capie;
> - unsigned char rf_type =3D padapter->registrypriv.rf_config;
>=20
> - int i;
> - u8 *p;
> - u16 rate, max_rate =3D 0, ht_cap =3D false;
> - u32 ht_ielen =3D 0;
> - u8 bw_40MHz =3D 0, short_GI =3D 0;
> - u16 mcs_rate =3D 0;
> -
> - i =3D 0;
> - if (!check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE))
> - return -ENOLINK;
> - p =3D r8712_get_ie(&pcur_bss->IEs[12], WLAN_EID_HT_CAPABILITY, &ht_iele=
n,
>=20
> - pcur_bss->IELength - 12);
>=20
> - if (p && ht_ielen > 0) {
>=20
> - ht_cap =3D true;
> - pht_capie =3D (struct ieee80211_ht_cap *)(p + 2);
> - memcpy(&mcs_rate, &pht_capie->mcs, 2);
>=20
> - bw_40MHz =3D (le16_to_cpu(pht_capie->cap_info) &
>=20
> - IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
> - short_GI =3D (le16_to_cpu(pht_capie->cap_info) &
>=20
> - (IEEE80211_HT_CAP_SGI_20 |
> - IEEE80211_HT_CAP_SGI_40)) ? 1 : 0;
> - }
> - while ((pcur_bss->rates[i] !=3D 0) &&
>=20
> - (pcur_bss->rates[i] !=3D 0xFF)) {
>=20
> - rate =3D pcur_bss->rates[i] & 0x7F;
>=20
> - if (rate > max_rate)
>=20
> - max_rate =3D rate;
> - wrqu->bitrate.fixed =3D 0; /* no auto select */
>=20
> - wrqu->bitrate.value =3D rate * 500000;
>=20
> - i++;
> - }
> - if (ht_cap) {
> - if (mcs_rate & 0x8000 /* MCS15 /
> - &&
> - rf_type =3D=3D RTL8712_RF_2T2R)
> - max_rate =3D (bw_40MHz) ? ((short_GI) ? 300 : 270) :
> - ((short_GI) ? 144 : 130);
> - else / default MCS7 */
> - max_rate =3D (bw_40MHz) ? ((short_GI) ? 150 : 135) :
> - ((short_GI) ? 72 : 65);
> - max_rate =3D 2; / Mbps/2 */
> - }
> - wrqu->bitrate.value =3D max_rate * 500000;
>=20
> - return 0;
> -}
> -
> -static int r8711_wx_get_rts(struct net_device *dev, struct iw_request_in=
fo *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - wrqu->rts.value =3D padapter->registrypriv.rts_thresh;
>=20
> - wrqu->rts.fixed =3D 0; /* no auto select */
>=20
> - return 0;
> -}
> -
> -static int r8711_wx_set_frag(struct net_device *dev, struct iw_request_i=
nfo *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - if (wrqu->frag.disabled) {
>=20
> - padapter->xmitpriv.frag_len =3D MAX_FRAG_THRESHOLD;
>=20
> - } else {
> - if (wrqu->frag.value < MIN_FRAG_THRESHOLD ||
>=20
> - wrqu->frag.value > MAX_FRAG_THRESHOLD)
>=20
> - return -EINVAL;
> - padapter->xmitpriv.frag_len =3D wrqu->frag.value & ~0x1;
>=20
> - }
> - return 0;
> -}
> -
> -static int r8711_wx_get_frag(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - wrqu->frag.value =3D padapter->xmitpriv.frag_len;
>=20
> - wrqu->frag.fixed =3D 0; /* no auto select */
>=20
> - return 0;
> -}
> -
> -static int r8711_wx_get_retry(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - wrqu->retry.value =3D 7;
>=20
> - wrqu->retry.fixed =3D 0; /* no auto select */
>=20
> - wrqu->retry.disabled =3D 1;
>=20
> - return 0;
> -}
> -
> -static int r8711_wx_set_enc(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *keybuf)
> -{
> - u32 key;
> - u32 keyindex_provided;
> - struct NDIS_802_11_WEP wep;
> - enum NDIS_802_11_AUTHENTICATION_MODE authmode;
> - struct iw_point *erq =3D &wrqu->encoding;
>=20
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - key =3D erq->flags & IW_ENCODE_INDEX;
>=20
> - memset(&wep, 0, sizeof(struct NDIS_802_11_WEP));
> - if (erq->flags & IW_ENCODE_DISABLED) {
>=20
> - netdev_info(dev, "r8712u: %s: EncryptionDisabled\n", func);
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11EncryptionDisabled;
> - padapter->securitypriv.privacy_algorithm =3D NO_PRIVACY;
>=20
> - padapter->securitypriv.XGrpPrivacy =3D NO_PRIVACY;
>=20
> - padapter->securitypriv.auth_algorithm =3D AUTH_OPEN_SYSTEM;
>=20
> - authmode =3D Ndis802_11AuthModeOpen;
> - padapter->securitypriv.ndisauthtype =3D authmode;
>=20
> - return 0;
> - }
> - if (key) {
> - if (key > WEP_KEYS)
>=20
> - return -EINVAL;
> - key--;
> - keyindex_provided =3D 1;
> - } else {
> - keyindex_provided =3D 0;
> - key =3D padapter->securitypriv.PrivacyKeyIndex;
>=20
> - }
> - /* set authentication mode */
> - if (erq->flags & IW_ENCODE_OPEN) {
>=20
> - netdev_info(dev, "r8712u: %s: IW_ENCODE_OPEN\n", func);
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption1Enabled;
> - padapter->securitypriv.auth_algorithm =3D AUTH_OPEN_SYSTEM;
>=20
> - padapter->securitypriv.privacy_algorithm =3D NO_PRIVACY;
>=20
> - padapter->securitypriv.XGrpPrivacy =3D NO_PRIVACY;
>=20
> - authmode =3D Ndis802_11AuthModeOpen;
> - padapter->securitypriv.ndisauthtype =3D authmode;
>=20
> - } else if (erq->flags & IW_ENCODE_RESTRICTED) {
>=20
> - netdev_info(dev,
> - "r8712u: %s: IW_ENCODE_RESTRICTED\n", func);
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption1Enabled;
> - padapter->securitypriv.auth_algorithm =3D AUTH_SHARED_SYSTEM;
>=20
> - padapter->securitypriv.privacy_algorithm =3D WEP40;
>=20
> - padapter->securitypriv.XGrpPrivacy =3D WEP40;
>=20
> - authmode =3D Ndis802_11AuthModeShared;
> - padapter->securitypriv.ndisauthtype =3D authmode;
>=20
> - } else {
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption1Enabled;
> - padapter->securitypriv.auth_algorithm =3D AUTH_OPEN_SYSTEM;
>=20
> - padapter->securitypriv.privacy_algorithm =3D NO_PRIVACY;
>=20
> - padapter->securitypriv.XGrpPrivacy =3D NO_PRIVACY;
>=20
> - authmode =3D Ndis802_11AuthModeOpen;
> - padapter->securitypriv.ndisauthtype =3D authmode;
>=20
> - }
> - wep.KeyIndex =3D key;
> - if (erq->length > 0) {
>=20
> - wep.KeyLength =3D erq->length <=3D 5 ? 5 : 13;
>=20
> - wep.Length =3D wep.KeyLength +
> - offsetof(struct NDIS_802_11_WEP, KeyMaterial);
> - } else {
> - wep.KeyLength =3D 0;
> - if (keyindex_provided =3D=3D 1) { /* set key_id only, no given
> - * KeyMaterial(erq->length=3D=3D0).
>=20
> - */
> - padapter->securitypriv.PrivacyKeyIndex =3D key;
>=20
> - switch (padapter->securitypriv.DefKeylen[key]) {
>=20
> - case 5:
> - padapter->securitypriv.privacy_algorithm =3D
>=20
> - WEP40;
> - break;
> - case 13:
> - padapter->securitypriv.privacy_algorithm =3D
>=20
> - WEP104;
> - break;
> - default:
> - padapter->securitypriv.privacy_algorithm =3D
>=20
> - NO_PRIVACY;
> - break;
> - }
> - return 0;
> - }
> - }
> - wep.KeyIndex |=3D 0x80000000; /* transmit key */
> - memcpy(wep.KeyMaterial, keybuf, wep.KeyLength);
> - if (r8712_set_802_11_add_wep(padapter, &wep))
> - return -EOPNOTSUPP;
> - return 0;
> -}
> -
> -static int r8711_wx_get_enc(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *keybuf)
> -{
> - uint key;
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_point *erq =3D &wrqu->encoding;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - union Keytype *dk =3D padapter->securitypriv.DefKey;
>=20
> -
> - if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - if (!check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
> - erq->length =3D 0;
>=20
> - erq->flags |=3D IW_ENCODE_DISABLED;
>=20
> - return 0;
> - }
> - }
> - key =3D erq->flags & IW_ENCODE_INDEX;
>=20
> - if (key) {
> - if (key > WEP_KEYS)
>=20
> - return -EINVAL;
> - key--;
> - } else {
> - key =3D padapter->securitypriv.PrivacyKeyIndex;
>=20
> - }
> - erq->flags =3D key + 1;
>=20
> - switch (padapter->securitypriv.ndisencryptstatus) {
>=20
> - case Ndis802_11EncryptionNotSupported:
> - case Ndis802_11EncryptionDisabled:
> - erq->length =3D 0;
>=20
> - erq->flags |=3D IW_ENCODE_DISABLED;
>=20
> - break;
> - case Ndis802_11Encryption1Enabled:
> - erq->length =3D padapter->securitypriv.DefKeylen[key];
>=20
> - if (erq->length) {
>=20
> - memcpy(keybuf, dk[key].skey,
> - padapter->securitypriv.DefKeylen[key]);
>=20
> - erq->flags |=3D IW_ENCODE_ENABLED;
>=20
> - if (padapter->securitypriv.ndisauthtype =3D=3D
>=20
> - Ndis802_11AuthModeOpen)
> - erq->flags |=3D IW_ENCODE_OPEN;
>=20
> - else if (padapter->securitypriv.ndisauthtype =3D=3D
>=20
> - Ndis802_11AuthModeShared)
> - erq->flags |=3D IW_ENCODE_RESTRICTED;
>=20
> - } else {
> - erq->length =3D 0;
>=20
> - erq->flags |=3D IW_ENCODE_DISABLED;
>=20
> - }
> - break;
> - case Ndis802_11Encryption2Enabled:
> - case Ndis802_11Encryption3Enabled:
> - erq->length =3D 16;
>=20
> - erq->flags |=3D (IW_ENCODE_ENABLED | IW_ENCODE_OPEN |
>=20
> - IW_ENCODE_NOKEY);
> - break;
> - default:
> - erq->length =3D 0;
>=20
> - erq->flags |=3D IW_ENCODE_DISABLED;
>=20
> - break;
> - }
> - return 0;
> -}
> -
> -static int r8711_wx_get_power(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - wrqu->power.value =3D 0;
>=20
> - wrqu->power.fixed =3D 0; /* no auto select */
>=20
> - wrqu->power.disabled =3D 1;
>=20
> - return 0;
> -}
> -
> -static int r871x_wx_set_gen_ie(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - return r871x_set_wpa_ie(padapter, extra, wrqu->data.length);
>=20
> -}
> -
> -static int r871x_wx_set_auth(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_param *param =3D (struct iw_param *)&wrqu->param;
>=20
> - int paramid;
> - int paramval;
> - int ret =3D 0;
> -
> - paramid =3D param->flags & IW_AUTH_INDEX;
>=20
> - paramval =3D param->value;
>=20
> - switch (paramid) {
> - case IW_AUTH_WPA_VERSION:
> - break;
> - case IW_AUTH_CIPHER_PAIRWISE:
> - break;
> - case IW_AUTH_CIPHER_GROUP:
> - break;
> - case IW_AUTH_KEY_MGMT:
> - /*
> - * ??? does not use these parameters
> - /
> - break;
> - case IW_AUTH_TKIP_COUNTERMEASURES:
> - if (paramval) {
> - / wpa_supplicant is enabling tkip countermeasure. */
> - padapter->securitypriv.btkip_countermeasure =3D true;
>=20
> - } else {
> - /* wpa_supplicant is disabling tkip countermeasure. */
> - padapter->securitypriv.btkip_countermeasure =3D false;
>=20
> - }
> - break;
> - case IW_AUTH_DROP_UNENCRYPTED:
> - /* HACK:
> - *
> - * wpa_supplicant calls set_wpa_enabled when the driver
> - * is loaded and unloaded, regardless of if WPA is being
> - * used. No other calls are made which can be used to
> - * determine if encryption will be used or not prior to
> - * association being expected. If encryption is not being
> - * used, drop_unencrypted is set to false, else true -- we
> - * can use this to determine if the CAP_PRIVACY_ON bit should
> - * be set.
> - */
> - if (padapter->securitypriv.ndisencryptstatus =3D=3D
>=20
> - Ndis802_11Encryption1Enabled) {
> - /* it means init value, or using wep,
> - * ndisencryptstatus =3D
> - * Ndis802_11Encryption1Enabled,
> - * then it needn't reset it;
> - */
> - break;
> - }
> -
> - if (paramval) {
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11EncryptionDisabled;
> - padapter->securitypriv.privacy_algorithm =3D
>=20
> - NO_PRIVACY;
> - padapter->securitypriv.XGrpPrivacy =3D
>=20
> - NO_PRIVACY;
> - padapter->securitypriv.auth_algorithm =3D AUTH_OPEN_SYSTEM;
>=20
> - padapter->securitypriv.ndisauthtype =3D
>=20
> - Ndis802_11AuthModeOpen;
> - }
> - break;
> - case IW_AUTH_80211_AUTH_ALG:
> - ret =3D wpa_set_auth_algs(dev, (u32)paramval);
> - break;
> - case IW_AUTH_WPA_ENABLED:
> - break;
> - case IW_AUTH_RX_UNENCRYPTED_EAPOL:
> - break;
> - case IW_AUTH_PRIVACY_INVOKED:
> - break;
> - default:
> - return -EOPNOTSUPP;
> - }
> -
> - return ret;
> -}
> -
> -static int r871x_wx_set_enc_ext(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct iw_point *pencoding =3D &wrqu->encoding;
>=20
> - struct iw_encode_ext *pext =3D (struct iw_encode_ext *)extra;
> - struct ieee_param *param =3D NULL;
> - char *alg_name;
> - u32 param_len;
> - int ret =3D 0;
> -
> - switch (pext->alg) {
>=20
> - case IW_ENCODE_ALG_NONE:
> - alg_name =3D "none";
> - break;
> - case IW_ENCODE_ALG_WEP:
> - alg_name =3D "WEP";
> - break;
> - case IW_ENCODE_ALG_TKIP:
> - alg_name =3D "TKIP";
> - break;
> - case IW_ENCODE_ALG_CCMP:
> - alg_name =3D "CCMP";
> - break;
> - default:
> - return -EINVAL;
> - }
> -
> - param_len =3D sizeof(struct ieee_param) + pext->key_len;
>=20
> - param =3D kzalloc(param_len, GFP_ATOMIC);
> - if (!param)
> - return -ENOMEM;
> - param->cmd =3D IEEE_CMD_SET_ENCRYPTION;
>=20
> - eth_broadcast_addr(param->sta_addr);
>=20
> - strscpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
>=20
> - if (pext->ext_flags & IW_ENCODE_EXT_GROUP_KEY)
>=20
> - param->u.crypt.set_tx =3D 0;
>=20
> - if (pext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY)
>=20
> - param->u.crypt.set_tx =3D 1;
>=20
> - param->u.crypt.idx =3D (pencoding->flags & 0x00FF) - 1;
>=20
> - if (pext->ext_flags & IW_ENCODE_EXT_RX_SEQ_VALID)
>=20
> - memcpy(param->u.crypt.seq, pext->rx_seq, 8);
>=20
> - if (pext->key_len) {
>=20
> - param->u.crypt.key_len =3D pext->key_len;
>=20
> - memcpy(param + 1, pext + 1, pext->key_len);
>=20
> - }
> - ret =3D wpa_set_encryption(dev, param, param_len);
> - kfree(param);
> - return ret;
> -}
> -
> -static int r871x_wx_get_nick(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - if (extra) {
> - wrqu->data.length =3D 8;
>=20
> - wrqu->data.flags =3D 1;
>=20
> - memcpy(extra, "rtl_wifi", 8);
> - }
> - return 0;
> -}
> -
> -static int r8711_wx_read32(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *keybuf)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - u32 addr;
> - u32 data32;
> -
> - get_user(addr, (u32 __user *)wrqu->data.pointer);
>=20
> - data32 =3D r8712_read32(padapter, addr);
> - put_user(data32, (u32 __user *)wrqu->data.pointer);
>=20
> - wrqu->data.length =3D (data32 & 0xffff0000) >> 16;
>=20
> - wrqu->data.flags =3D data32 & 0xffff;
>=20
> - get_user(addr, (u32 __user *)wrqu->data.pointer);
>=20
> - return 0;
> -}
> -
> -static int r8711_wx_write32(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *keybuf)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - u32 addr;
> - u32 data32;
> -
> - get_user(addr, (u32 __user *)wrqu->data.pointer);
>=20
> - data32 =3D ((u32)wrqu->data.length << 16) | (u32)wrqu->data.flags;
>=20
> - r8712_write32(padapter, addr, data32);
> - return 0;
> -}
> -
> -static int dummy(struct net_device *dev,
> - struct iw_request_info *a,
> - union iwreq_data *wrqu, char *b)
> -{
> - return -EINVAL;
> -}
> -
> -static int r8711_drvext_hdl(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - return 0;
> -}
> -
> -static int r871x_mp_ioctl_hdl(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_point *p =3D &wrqu->data;
>=20
> - struct oid_par_priv oid_par;
> - struct mp_ioctl_handler *phandler;
> - struct mp_ioctl_param *poidparam;
> - unsigned long BytesRead, BytesWritten, BytesNeeded;
> - u8 *pparmbuf, bset;
> - u16 len;
> - uint status;
> - int ret =3D 0;
> -
> - if ((!p->length) || (!p->pointer))
>=20
> - return -EINVAL;
> -
> - bset =3D (u8)(p->flags & 0xFFFF);
>=20
> - len =3D p->length;
>=20
> - pparmbuf =3D memdup_user(p->pointer, len);
>=20
> - if (IS_ERR(pparmbuf))
> - return PTR_ERR(pparmbuf);
> -
> - poidparam =3D (struct mp_ioctl_param *)pparmbuf;
> - if (poidparam->subcode >=3D MAX_MP_IOCTL_SUBCODE) {
>=20
> - ret =3D -EINVAL;
> - goto _r871x_mp_ioctl_hdl_exit;
> - }
> - phandler =3D mp_ioctl_hdl + poidparam->subcode;
>=20
> - if ((phandler->paramsize !=3D 0) &&
>=20
> - (poidparam->len < phandler->paramsize)) {
>=20
> - ret =3D -EINVAL;
> - goto _r871x_mp_ioctl_hdl_exit;
> - }
> - if (phandler->oid =3D=3D 0 && phandler->handler) {
>=20
> - status =3D phandler->handler(&oid_par);
>=20
> - } else if (phandler->handler) {
>=20
> - oid_par.adapter_context =3D padapter;
> - oid_par.oid =3D phandler->oid;
>=20
> - oid_par.information_buf =3D poidparam->data;
>=20
> - oid_par.information_buf_len =3D poidparam->len;
>=20
> - oid_par.dbg =3D 0;
> - BytesWritten =3D 0;
> - BytesNeeded =3D 0;
> - if (bset) {
> - oid_par.bytes_rw =3D &BytesRead;
> - oid_par.bytes_needed =3D &BytesNeeded;
> - oid_par.type_of_oid =3D SET_OID;
> - } else {
> - oid_par.bytes_rw =3D &BytesWritten;
> - oid_par.bytes_needed =3D &BytesNeeded;
> - oid_par.type_of_oid =3D QUERY_OID;
> - }
> - status =3D phandler->handler(&oid_par);
>=20
> - /* todo:check status, BytesNeeded, etc. */
> - } else {
> - netdev_info(dev, "r8712u: %s: err!, subcode=3D%d, oid=3D%d, handler=3D%=
p\n",
> - func, poidparam->subcode, phandler->oid,
>=20
> - phandler->handler);
>=20
> - ret =3D -EFAULT;
> - goto _r871x_mp_ioctl_hdl_exit;
> - }
> - if (bset =3D=3D 0x00) { /* query info */
> - if (copy_to_user(p->pointer, pparmbuf, len))
>=20
> - ret =3D -EFAULT;
> - }
> - if (status) {
> - ret =3D -EFAULT;
> - goto _r871x_mp_ioctl_hdl_exit;
> - }
> -_r871x_mp_ioctl_hdl_exit:
> - kfree(pparmbuf);
> - return ret;
> -}
> -
> -static int r871x_get_ap_info(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct __queue *queue =3D &pmlmepriv->scanned_queue;
>=20
> - struct iw_point *pdata =3D &wrqu->data;
>=20
> - struct wlan_network *pnetwork =3D NULL;
> - u32 cnt =3D 0, wpa_ielen;
> - unsigned long irqL;
> - struct list_head *plist, *phead;
> - unsigned char *pbuf;
> - u8 bssid[ETH_ALEN];
> - char data[33];
> -
> - if (padapter->driver_stopped || !pdata)
>=20
> - return -EINVAL;
> - while (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
> - _FW_UNDER_LINKING)) {
> - msleep(30);
> - cnt++;
> - if (cnt > 100)
>=20
> - break;
> - }
> - pdata->flags =3D 0;
>=20
> - if (pdata->length < 32)
>=20
> - return -EINVAL;
> - if (copy_from_user(data, pdata->pointer, 32))
>=20
> - return -EINVAL;
> - data[32] =3D 0;
> -
> - spin_lock_irqsave(&pmlmepriv->scanned_queue.lock, irqL);
>=20
> - phead =3D &queue->queue;
>=20
> - plist =3D phead->next;
>=20
> - while (1) {
> - if (end_of_queue_search(phead, plist))
> - break;
> - pnetwork =3D container_of(plist, struct wlan_network, list);
> - if (!mac_pton(data, bssid)) {
> - netdev_info(dev, "r8712u: Invalid BSSID '%s'.\n",
> - (u8 *)data);
> - spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock,
>=20
> - irqL);
> - return -EINVAL;
> - }
> - netdev_info(dev, "r8712u: BSSID:%pM\n", bssid);
> - if (ether_addr_equal(bssid, pnetwork->network.MacAddress)) {
>=20
> - /* BSSID match, then check if supporting wpa/wpa2 */
> - pbuf =3D r8712_get_wpa_ie(&pnetwork->network.IEs[12],
>=20
> - &wpa_ielen, pnetwork->network.IELength - 12);
>=20
> - if (pbuf && (wpa_ielen > 0)) {
>=20
> - pdata->flags =3D 1;
>=20
> - break;
> - }
> - pbuf =3D r8712_get_wpa2_ie(&pnetwork->network.IEs[12],
>=20
> - &wpa_ielen, pnetwork->network.IELength - 12);
>=20
> - if (pbuf && (wpa_ielen > 0)) {
>=20
> - pdata->flags =3D 2;
>=20
> - break;
> - }
> - }
> - plist =3D plist->next;
>=20
> - }
> - spin_unlock_irqrestore(&pmlmepriv->scanned_queue.lock, irqL);
>=20
> - if (pdata->length >=3D 34) {
>=20
> - if (copy_to_user((u8 __user *)pdata->pointer + 32,
>=20
> - (u8 *)&pdata->flags, 1))
>=20
> - return -EINVAL;
> - }
> - return 0;
> -}
> -
> -static int r871x_set_pid(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_point *pdata =3D &wrqu->data;
>=20
> -
> - if (padapter->driver_stopped || !pdata)
>=20
> - return -EINVAL;
> - if (copy_from_user(&padapter->pid, pdata->pointer, sizeof(int)))
>=20
> - return -EINVAL;
> - return 0;
> -}
> -
> -static int r871x_set_chplan(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - int ret =3D 0;
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_point *pdata =3D &wrqu->data;
>=20
> - int ch_plan =3D -1;
> -
> - if (padapter->driver_stopped || !pdata) {
>=20
> - ret =3D -EINVAL;
> - goto exit;
> - }
> - ch_plan =3D (int)*extra;
> - r8712_set_chplan_cmd(padapter, ch_plan);
> -
> -exit:
> -
> - return ret;
> -}
> -
> -static int r871x_wps_start(struct net_device *dev,
> - struct iw_request_info *info,
> - union iwreq_data *wrqu, char *extra)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_point *pdata =3D &wrqu->data;
>=20
> - u32 u32wps_start =3D 0;
> -
> - if (padapter->driver_stopped || !pdata)
>=20
> - return -EINVAL;
> - if (copy_from_user((void *)&u32wps_start, pdata->pointer, 4))
>=20
> - return -EFAULT;
> - if (u32wps_start =3D=3D 0)
> - u32wps_start =3D extra;
> - if (u32wps_start =3D=3D 1) / WPS Start */
> - padapter->ledpriv.LedControlHandler(padapter,
>=20
> - LED_CTL_START_WPS);
> - else if (u32wps_start =3D=3D 2) /* WPS Stop because of wps success */
> - padapter->ledpriv.LedControlHandler(padapter,
>=20
> - LED_CTL_STOP_WPS);
> - else if (u32wps_start =3D=3D 3) /* WPS Stop because of wps fail */
> - padapter->ledpriv.LedControlHandler(padapter,
>=20
> - LED_CTL_STOP_WPS_FAIL);
> - return 0;
> -}
> -
> -static int wpa_set_param(struct net_device *dev, u8 name, u32 value)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - switch (name) {
> - case IEEE_PARAM_WPA_ENABLED:
> - padapter->securitypriv.auth_algorithm =3D AUTH_8021x;
>=20
> - switch ((value) & 0xff) {
> - case 1: /* WPA */
> - padapter->securitypriv.ndisauthtype =3D
>=20
> - Ndis802_11AuthModeWPAPSK; /* WPA_PSK */
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption2Enabled;
> - break;
> - case 2: /* WPA2 */
> - padapter->securitypriv.ndisauthtype =3D
>=20
> - Ndis802_11AuthModeWPA2PSK; /* WPA2_PSK */
> - padapter->securitypriv.ndisencryptstatus =3D
>=20
> - Ndis802_11Encryption3Enabled;
> - break;
> - }
> - break;
> - case IEEE_PARAM_TKIP_COUNTERMEASURES:
> - break;
> - case IEEE_PARAM_DROP_UNENCRYPTED:
> - /* HACK:
> - *
> - * wpa_supplicant calls set_wpa_enabled when the driver
> - * is loaded and unloaded, regardless of if WPA is being
> - * used. No other calls are made which can be used to
> - * determine if encryption will be used or not prior to
> - * association being expected. If encryption is not being
> - * used, drop_unencrypted is set to false, else true -- we
> - * can use this to determine if the CAP_PRIVACY_ON bit should
> - * be set.
> - /
> - break;
> - case IEEE_PARAM_PRIVACY_INVOKED:
> - break;
> - case IEEE_PARAM_AUTH_ALGS:
> - return wpa_set_auth_algs(dev, value);
> - case IEEE_PARAM_IEEE_802_1X:
> - break;
> - case IEEE_PARAM_WPAX_SELECT:
> - / added for WPA2 mixed mode */
> - break;
> - default:
> - return -EOPNOTSUPP;
> - }
> - return 0;
> -}
> -
> -static int wpa_mlme(struct net_device *dev, u32 command, u32 reason)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - switch (command) {
> - case IEEE_MLME_STA_DEAUTH:
> - if (!r8712_set_802_11_disassociate(padapter))
> - return -1;
> - break;
> - case IEEE_MLME_STA_DISASSOC:
> - if (!r8712_set_802_11_disassociate(padapter))
> - return -1;
> - break;
> - default:
> - return -EOPNOTSUPP;
> - }
> - return 0;
> -}
> -
> -static int wpa_supplicant_ioctl(struct net_device *dev, struct iw_point =
*p)
> -{
> - struct ieee_param *param;
> - int ret =3D 0;
> - struct _adapter *padapter =3D netdev_priv(dev);
> -
> - if (p->length < sizeof(struct ieee_param) || !p->pointer)
>=20
> - return -EINVAL;
> - param =3D memdup_user(p->pointer, p->length);
>=20
> - if (IS_ERR(param))
> - return PTR_ERR(param);
> - switch (param->cmd) {
>=20
> - case IEEE_CMD_SET_WPA_PARAM:
> - ret =3D wpa_set_param(dev, param->u.wpa_param.name,
>=20
> - param->u.wpa_param.value);
>=20
> - break;
> - case IEEE_CMD_SET_WPA_IE:
> - ret =3D r871x_set_wpa_ie(padapter, (char *)param->u.wpa_ie.data,
>=20
> - (u16)param->u.wpa_ie.len);
>=20
> - break;
> - case IEEE_CMD_SET_ENCRYPTION:
> - ret =3D wpa_set_encryption(dev, param, p->length);
>=20
> - break;
> - case IEEE_CMD_MLME:
> - ret =3D wpa_mlme(dev, param->u.mlme.command,
>=20
> - param->u.mlme.reason_code);
>=20
> - break;
> - default:
> - ret =3D -EOPNOTSUPP;
> - break;
> - }
> - if (ret =3D=3D 0 && copy_to_user(p->pointer, param, p->length))
>=20
> - ret =3D -EFAULT;
> - kfree(param);
> - return ret;
> -}
> -
> -/* based on "driver_ipw" and for hostapd */
> -int r871x_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> -{
> - struct iwreq *wrq =3D (struct iwreq *)rq;
> -
> - switch (cmd) {
> - case RTL_IOCTL_WPA_SUPPLICANT:
> - return wpa_supplicant_ioctl(dev, &wrq->u.data);
>=20
> - default:
> - return -EOPNOTSUPP;
> - }
> - return 0;
> -}
> -
> -static iw_handler r8711_handlers[] =3D {
> - NULL, /* SIOCSIWCOMMIT /
> - r8711_wx_get_name, / SIOCGIWNAME /
> - dummy, / SIOCSIWNWID /
> - dummy, / SIOCGIWNWID /
> - r8711_wx_set_freq, / SIOCSIWFREQ /
> - r8711_wx_get_freq, / SIOCGIWFREQ /
> - r8711_wx_set_mode, / SIOCSIWMODE /
> - r8711_wx_get_mode, / SIOCGIWMODE /
> - dummy, / SIOCSIWSENS /
> - r8711_wx_get_sens, / SIOCGIWSENS /
> - NULL, / SIOCSIWRANGE /
> - r8711_wx_get_range, / SIOCGIWRANGE /
> - r871x_wx_set_priv, / SIOCSIWPRIV /
> - NULL, / SIOCGIWPRIV /
> - NULL, / SIOCSIWSTATS /
> - NULL, / SIOCGIWSTATS /
> - dummy, / SIOCSIWSPY /
> - dummy, / SIOCGIWSPY /
> - NULL, / SIOCGIWTHRSPY /
> - NULL, / SIOCWIWTHRSPY /
> - r8711_wx_set_wap, / SIOCSIWAP /
> - r8711_wx_get_wap, / SIOCGIWAP /
> - r871x_wx_set_mlme, / request MLME operation;
> - * uses struct iw_mlme
> - /
> - dummy, / SIOCGIWAPLIST -- deprecated /
> - r8711_wx_set_scan, / SIOCSIWSCAN /
> - r8711_wx_get_scan, / SIOCGIWSCAN /
> - r8711_wx_set_essid, / SIOCSIWESSID /
> - r8711_wx_get_essid, / SIOCGIWESSID /
> - dummy, / SIOCSIWNICKN /
> - r871x_wx_get_nick, / SIOCGIWNICKN /
> - NULL, / -- hole -- /
> - NULL, / -- hole -- /
> - r8711_wx_set_rate, / SIOCSIWRATE /
> - r8711_wx_get_rate, / SIOCGIWRATE /
> - dummy, / SIOCSIWRTS /
> - r8711_wx_get_rts, / SIOCGIWRTS /
> - r8711_wx_set_frag, / SIOCSIWFRAG /
> - r8711_wx_get_frag, / SIOCGIWFRAG /
> - dummy, / SIOCSIWTXPOW /
> - dummy, / SIOCGIWTXPOW /
> - dummy, / SIOCSIWRETRY /
> - r8711_wx_get_retry, / SIOCGIWRETRY /
> - r8711_wx_set_enc, / SIOCSIWENCODE /
> - r8711_wx_get_enc, / SIOCGIWENCODE /
> - dummy, / SIOCSIWPOWER /
> - r8711_wx_get_power, / SIOCGIWPOWER /
> - NULL, /---hole---/
> - NULL, /---hole---/
> - r871x_wx_set_gen_ie, / SIOCSIWGENIE /
> - NULL, / SIOCGIWGENIE /
> - r871x_wx_set_auth, / SIOCSIWAUTH /
> - NULL, / SIOCGIWAUTH /
> - r871x_wx_set_enc_ext, / SIOCSIWENCODEEXT /
> - NULL, / SIOCGIWENCODEEXT /
> - r871x_wx_set_pmkid, / SIOCSIWPMKSA /
> - NULL, /---hole---*/
> -};
> -
> -static const struct iw_priv_args r8711_private_args[] =3D {
> - {
> - SIOCIWFIRSTPRIV + 0x0,
> - IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "read32"
> - },
> - {
> - SIOCIWFIRSTPRIV + 0x1,
> - IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "write32"
> - },
> - {
> - SIOCIWFIRSTPRIV + 0x2, 0, 0, "driver_ext"
> - },
> - {
> - SIOCIWFIRSTPRIV + 0x3, 0, 0, "mp_ioctl"
> - },
> - {
> - SIOCIWFIRSTPRIV + 0x4,
> - IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "apinfo"
> - },
> - {
> - SIOCIWFIRSTPRIV + 0x5,
> - IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "setpid"
> - },
> - {
> - SIOCIWFIRSTPRIV + 0x6,
> - IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "wps_start"
> - },
> - {
> - SIOCIWFIRSTPRIV + 0x7,
> - IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1, 0, "chplan"
> - }
> -};
> -
> -static iw_handler r8711_private_handler[] =3D {
> - r8711_wx_read32,
> - r8711_wx_write32,
> - r8711_drvext_hdl,
> - r871x_mp_ioctl_hdl,
> - r871x_get_ap_info, /for MM DTV platform/
> - r871x_set_pid,
> - r871x_wps_start,
> - r871x_set_chplan
> -};
> -
> -static struct iw_statistics *r871x_get_wireless_stats(struct net_device =
*dev)
> -{
> - struct _adapter *padapter =3D netdev_priv(dev);
> - struct iw_statistics *piwstats =3D &padapter->iwstats;
>=20
> - int tmp_level =3D 0;
> - int tmp_qual =3D 0;
> - int tmp_noise =3D 0;
> -
> - if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) !=3D true) {
>=20
> - piwstats->qual.qual =3D 0;
>=20
> - piwstats->qual.level =3D 0;
>=20
> - piwstats->qual.noise =3D 0;
>=20
> - } else {
> - /* show percentage, we need transfer dbm to original value. */
> - tmp_level =3D padapter->recvpriv.fw_rssi;
>=20
> - tmp_qual =3D padapter->recvpriv.signal;
>=20
> - tmp_noise =3D padapter->recvpriv.noise;
>=20
> - piwstats->qual.level =3D tmp_level;
>=20
> - piwstats->qual.qual =3D tmp_qual;
>=20
> - piwstats->qual.noise =3D tmp_noise;
>=20
> - }
> - piwstats->qual.updated =3D IW_QUAL_ALL_UPDATED;
>=20
> - return &padapter->iwstats;
>=20
> -}
> -
> -struct iw_handler_def r871x_handlers_def =3D {
> - .standard =3D r8711_handlers,
> - .num_standard =3D ARRAY_SIZE(r8711_handlers),
> - .private =3D r8711_private_handler,
> - .private_args =3D (struct iw_priv_args )r8711_private_args,
> - .num_private =3D ARRAY_SIZE(r8711_private_handler),
> - .num_private_args =3D sizeof(r8711_private_args) /
> - sizeof(struct iw_priv_args),
> - .get_wireless_stats =3D r871x_get_wireless_stats
> -};
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_rtl.c
> deleted file mode 100644
> index f9b5588fe4d6..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.c
> +++ /dev/null
> @@ -1,519 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************************************=
******
> - * rtl871x_ioctl_rtl.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_IOCTL_RTL_C
> -
> -#include <linux/rndis.h>
>=20
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "wlan_bssdef.h"
> -#include "wifi.h"
> -#include "rtl871x_ioctl.h"
> -#include "rtl871x_ioctl_set.h"
> -#include "rtl871x_ioctl_rtl.h"
> -#include "mp_custom_oid.h"
> -#include "rtl871x_mp.h"
> -#include "rtl871x_mp_ioctl.h"
> -
> -uint oid_rt_get_signal_quality_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_small_packet_crc_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - padapter->recvpriv.rx_smallpacket_crcerr;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_middle_packet_crc_hdl(struct oid_par_priv *poid_par_priv=
)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - padapter->recvpriv.rx_middlepacket_crcerr;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_large_packet_crc_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - padapter->recvpriv.rx_largepacket_crcerr;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_tx_retry_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_rx_retry_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_rx_total_packet_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - padapter->recvpriv.rx_pkts +
>=20
> - padapter->recvpriv.rx_drop;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_tx_beacon_ok_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_tx_beacon_err_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_rx_icv_err_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - *(uint *)poid_par_priv->information_buf =3D
>=20
> - padapter->recvpriv.rx_icv_err;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_set_encryption_algorithm_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_preamble_mode_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> - u32 preamblemode =3D 0;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - if (padapter->registrypriv.preamble =3D=3D PREAMBLE_LONG)
>=20
> - preamblemode =3D 0;
> - else if (padapter->registrypriv.preamble =3D=3D PREAMBLE_AUTO)
>=20
> - preamblemode =3D 1;
> - else if (padapter->registrypriv.preamble =3D=3D PREAMBLE_SHORT)
>=20
> - preamblemode =3D 2;
> - *(u32 *)poid_par_priv->information_buf =3D preamblemode;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_ap_ip_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_channelplan_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> - struct eeprom_priv *peeprompriv =3D &padapter->eeprompriv;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - *(u16 *)poid_par_priv->information_buf =3D peeprompriv->channel_plan;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_set_channelplan_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> - struct eeprom_priv *peeprompriv =3D &padapter->eeprompriv;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - peeprompriv->channel_plan =3D *(u16 *)poid_par_priv->information_buf;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_set_preamble_mode_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> - u32 preamblemode =3D 0;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - preamblemode =3D *(u32 *)poid_par_priv->information_buf;
>=20
> - if (preamblemode =3D=3D 0)
> - padapter->registrypriv.preamble =3D PREAMBLE_LONG;
>=20
> - else if (preamblemode =3D=3D 1)
> - padapter->registrypriv.preamble =3D PREAMBLE_AUTO;
>=20
> - else if (preamblemode =3D=3D 2)
> - padapter->registrypriv.preamble =3D PREAMBLE_SHORT;
>=20
> - *(u32 *)poid_par_priv->information_buf =3D preamblemode;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_set_bcn_intvl_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_dedicate_probe_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_total_tx_bytes_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - padapter->xmitpriv.tx_bytes;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_total_rx_bytes_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - padapter->recvpriv.rx_bytes;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_current_tx_power_level_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_enc_key_mismatch_count_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_enc_key_match_count_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_channel_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct NDIS_802_11_CONFIGURATION *pnic_Config;
> - u32 channelnum;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (check_fwstate(pmlmepriv, _FW_LINKED) ||
> - check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE))
> - pnic_Config =3D &pmlmepriv->cur_network.network.Configuration;
>=20
> - else
> - pnic_Config =3D &padapter->registrypriv.dev_network.Configuration;
>=20
> - channelnum =3D pnic_Config->DSConfig;
>=20
> - *(u32 *)poid_par_priv->information_buf =3D channelnum;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_hardware_radio_off_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_key_mismatch_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_supported_wireless_mode_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - u32 ulInfo =3D 0;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len >=3D sizeof(u32)) {
>=20
> - ulInfo |=3D 0x0100; /* WIRELESS_MODE_B /
> - ulInfo |=3D 0x0200; / WIRELESS_MODE_G /
> - ulInfo |=3D 0x0400; / WIRELESS_MODE_A */
> - *(u32 *) poid_par_priv->information_buf =3D ulInfo;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_channel_list_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_scan_in_progress_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_forced_data_rate_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_wireless_mode_for_scan_list_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_bss_wireless_mode_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_scan_with_magic_packet_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_ap_get_associated_station_list_hdl(struct oid_par_priv
> - *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_ap_switch_into_ap_mode_hdl(struct oid_par_priv*
> - poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_ap_supported_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_ap_set_passphrase_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_rf_write_registry_hdl(struct oid_par_priv*
> - poid_par_priv)
> -{
> - uint status =3D RNDIS_STATUS_SUCCESS;
> - struct _adapter *Adapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID) /* QUERY_OID */
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len =3D=3D
>=20
> - (sizeof(unsigned long) * 3)) {
> - if (r8712_setrfreg_cmd(Adapter,
> - *(unsigned char *)poid_par_priv->information_buf,
>=20
> - (unsigned long)(*((unsigned long *)
> - poid_par_priv->information_buf + 2))))
>=20
> - status =3D RNDIS_STATUS_NOT_ACCEPTED;
> - } else {
> - status =3D RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return status;
> -}
> -
> -uint oid_rt_pro_rf_read_registry_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - uint status =3D RNDIS_STATUS_SUCCESS;
> - struct _adapter *Adapter =3D poid_par_priv->adapter_context;
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID) /* QUERY_OID */
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len =3D=3D (sizeof(unsigned long) *
>=20
> - 3)) {
> - if (Adapter->mppriv.act_in_progress) {
>=20
> - status =3D RNDIS_STATUS_NOT_ACCEPTED;
> - } else {
> - /* init workparam */
> - Adapter->mppriv.act_in_progress =3D true;
>=20
> - Adapter->mppriv.workparam.bcompleted =3D false;
>=20
> - Adapter->mppriv.workparam.act_type =3D MPT_READ_RF;
>=20
> - Adapter->mppriv.workparam.io_offset =3D *(unsigned long *)
>=20
> - poid_par_priv->information_buf;
>=20
> - Adapter->mppriv.workparam.io_value =3D 0xcccccccc;
>=20
> -
> - /* RegOffsetValue - The offset of RF register to read.
> - * RegDataWidth - The data width of RF register to read.
> - * RegDataValue - The value to read.
> - * RegOffsetValue =3D *((unsigned long *)InformationBuffer);
> - * RegDataWidth =3D *((unsigned long *)InformationBuffer+1);
> - * RegDataValue =3D *((unsigned long *)InformationBuffer+2);
> - */
> - if (r8712_getrfreg_cmd(Adapter,
> - *(unsigned char *)poid_par_priv->information_buf,
>=20
> - (unsigned char *)&Adapter->mppriv.workparam.io_value
>=20
> - ))
> - status =3D RNDIS_STATUS_NOT_ACCEPTED;
> - }
> - } else {
> - status =3D RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return status;
> -}
> -
> -enum CONNECT_STATE {
> - CHECKINGSTATUS,
> - ASSOCIATED,
> - ADHOCMODE,
> - NOTASSOCIATED
> -};
> -
> -uint oid_rt_get_connect_state_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *padapter =3D poid_par_priv->adapter_context;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - u32 ulInfo;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - /* nStatus=3D=3D0 CheckingStatus
> - * nStatus=3D=3D1 Associated
> - * nStatus=3D=3D2 AdHocMode
> - * nStatus=3D=3D3 NotAssociated
> - */
> - if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
> - ulInfo =3D CHECKINGSTATUS;
> - else if (check_fwstate(pmlmepriv, _FW_LINKED))
> - ulInfo =3D ASSOCIATED;
> - else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE))
> - ulInfo =3D ADHOCMODE;
> - else
> - ulInfo =3D NOTASSOCIATED;
> - *(u32 *)poid_par_priv->information_buf =3D ulInfo;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_set_default_key_id_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_rtl.h
> deleted file mode 100644
> index 7c0b880ac686..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_rtl.h
> +++ /dev/null
> @@ -1,109 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***************************************/
> -#ifndef _RTL871X_IOCTL_RTL_H
> -#define _RTL871X_IOCTL_RTL_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -/ oid_rtl_seg_01_01 /
> -uint oid_rt_get_signal_quality_hdl(
> - struct oid_par_priv poid_par_priv);/84/
> -uint oid_rt_get_small_packet_crc_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_middle_packet_crc_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_large_packet_crc_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_tx_retry_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_rx_retry_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_rx_total_packet_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_tx_beacon_ok_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_tx_beacon_err_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_rx_icv_err_hdl(
> - struct oid_par_priv poid_par_priv);/93/
> -uint oid_rt_set_encryption_algorithm_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_preamble_mode_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_ap_ip_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_channelplan_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_set_channelplan_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_set_preamble_mode_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_set_bcn_intvl_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_dedicate_probe_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_total_tx_bytes_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_total_rx_bytes_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_current_tx_power_level_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_enc_key_mismatch_count_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_enc_key_match_count_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_channel_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_hardware_radio_off_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_key_mismatch_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_supported_wireless_mode_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_channel_list_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_scan_in_progress_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_forced_data_rate_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_wireless_mode_for_scan_list_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_bss_wireless_mode_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_scan_with_magic_packet_hdl(
> - struct oid_par_priv poid_par_priv);
> -
> -/ oid_rtl_seg_01_03 section start /
> -uint oid_rt_ap_get_associated_station_list_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_ap_switch_into_ap_mode_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_ap_supported_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_ap_set_passphrase_hdl(
> - struct oid_par_priv poid_par_priv);
> -/ oid_rtl_seg_01_11 /
> -uint oid_rt_pro_rf_write_registry_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_rf_read_registry_hdl(
> - struct oid_par_priv poid_par_priv);
> -/ oid_rtl_seg_03_00 section start /
> -uint oid_rt_get_connect_state_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_set_default_key_id_hdl(
> - struct oid_par_priv poid_par_priv);
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.c b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_set.c
> deleted file mode 100644
> index 9ddfe7a1d715..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_set.c
> +++ /dev/null
> @@ -1,355 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl871x_ioctl_set.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_IOCTL_SET_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "rtl871x_ioctl_set.h"
> -#include "rtl871x_security.h"
> -#include "usb_osintf.h"
> -#include "usb_ops.h"
> -
> -static u8 validate_ssid(struct ndis_802_11_ssid *ssid)
> -{
> - u8 i;
> -
> - if (ssid->SsidLength > 32)
>=20
> - return false;
> - for (i =3D 0; i < ssid->SsidLength; i++) {
>=20
> - /* wifi, printable ascii code must be supported */
> - if (!((ssid->Ssid[i] >=3D 0x20) && (ssid->Ssid[i] <=3D 0x7e)))
>=20
> - return false;
> - }
> - return true;
> -}
> -
> -static u8 do_join(struct _adapter *padapter)
> -{
> - struct list_head *plist, *phead;
> - u8 *pibss =3D NULL;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct __queue *queue =3D &pmlmepriv->scanned_queue;
>=20
> - int ret;
> -
> - phead =3D &queue->queue;
>=20
> - plist =3D phead->next;
>=20
> - pmlmepriv->cur_network.join_res =3D -2;
>=20
> - pmlmepriv->fw_state |=3D _FW_UNDER_LINKING;
>=20
> - pmlmepriv->pscanned =3D plist;
>=20
> - pmlmepriv->to_join =3D true;
>=20
> -
> - /* adhoc mode will start with an empty queue, but skip checking */
> - if (!check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) &&
> - list_empty(&queue->queue)) {
>=20
> - if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
>=20
> - pmlmepriv->fw_state ^=3D _FW_UNDER_LINKING;
>=20
> - /* when set_ssid/set_bssid for do_join(), but scanning queue
> - * is empty we try to issue sitesurvey firstly
> - */
> - if (!pmlmepriv->sitesurveyctrl.traffic_busy)
>=20
> - r8712_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid);
>=20
> - return true;
> - }
> -
> - ret =3D r8712_select_and_join_from_scan(pmlmepriv);
> - if (!ret) {
> - mod_timer(&pmlmepriv->assoc_timer,
>=20
> - jiffies + msecs_to_jiffies(MAX_JOIN_TIMEOUT));
> - } else {
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> - /* submit r8712_createbss_cmd to change to an
> - * ADHOC_MASTER pmlmepriv->lock has been
>=20
> - * acquired by caller...
> - */
> - struct wlan_bssid_ex *pdev_network =3D
> - &padapter->registrypriv.dev_network;
>=20
> - pmlmepriv->fw_state =3D WIFI_ADHOC_MASTER_STATE;
>=20
> - pibss =3D padapter->registrypriv.dev_network.MacAddress;
>=20
> - memcpy(&pdev_network->Ssid,
>=20
> - &pmlmepriv->assoc_ssid,
>=20
> - sizeof(struct ndis_802_11_ssid));
> - r8712_update_registrypriv_dev_network(padapter);
> - r8712_generate_random_ibss(pibss);
> - if (r8712_createbss_cmd(padapter))
> - return false;
> - pmlmepriv->to_join =3D false;
>=20
> - } else {
> - /* can't associate ; reset under-linking */
> - if (pmlmepriv->fw_state & _FW_UNDER_LINKING)
>=20
> - pmlmepriv->fw_state ^=3D
>=20
> - _FW_UNDER_LINKING;
> - /* when set_ssid/set_bssid for do_join(), but
> - * there are no desired bss in scanning queue
> - * we try to issue sitesurvey first
> - */
> - if (!pmlmepriv->sitesurveyctrl.traffic_busy)
>=20
> - r8712_sitesurvey_cmd(padapter,
> - &pmlmepriv->assoc_ssid);
>=20
> - }
> - }
> - return true;
> -}
> -
> -u8 r8712_set_802_11_bssid(struct _adapter *padapter, u8 *bssid)
> -{
> - unsigned long irqL;
> - u8 status =3D true;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - if (is_zero_ether_addr(bssid) || is_broadcast_ether_addr(bssid)) {
> - status =3D false;
> - return status;
> - }
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY |
> - _FW_UNDER_LINKING)) {
> - status =3D check_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - goto _Abort_Set_BSSID;
> - }
> - if (check_fwstate(pmlmepriv,
> - _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
> - if (!memcmp(&pmlmepriv->cur_network.network.MacAddress, bssid,
>=20
> - ETH_ALEN)) {
> - if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> - /* driver is in
> - * WIFI_ADHOC_MASTER_STATE
> - */
> - goto _Abort_Set_BSSID;
> - } else {
> - r8712_disassoc_cmd(padapter);
> - if (check_fwstate(pmlmepriv, _FW_LINKED))
> - r8712_ind_disconnect(padapter);
> - r8712_free_assoc_resources(padapter);
> - if ((check_fwstate(pmlmepriv,
> - WIFI_ADHOC_MASTER_STATE))) {
> - clr_fwstate(pmlmepriv,
> - WIFI_ADHOC_MASTER_STATE);
> - set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
> - }
> - }
> - }
> - memcpy(&pmlmepriv->assoc_bssid, bssid, ETH_ALEN);
>=20
> - pmlmepriv->assoc_by_bssid =3D true;
>=20
> - status =3D do_join(padapter);
> - goto done;
> -_Abort_Set_BSSID:
> -done:
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - return status;
> -}
> -
> -void r8712_set_802_11_ssid(struct _adapter *padapter,
> - struct ndis_802_11_ssid *ssid)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_network *pnetwork =3D &pmlmepriv->cur_network;
>=20
> -
> - if (!padapter->hw_init_completed)
>=20
> - return;
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING)) {
> - check_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - goto _Abort_Set_SSID;
> - }
> - if (check_fwstate(pmlmepriv, _FW_LINKED | WIFI_ADHOC_MASTER_STATE)) {
> - if ((pmlmepriv->assoc_ssid.SsidLength =3D=3D ssid->SsidLength) &&
>=20
> - (!memcmp(&pmlmepriv->assoc_ssid.Ssid, ssid->Ssid,
>=20
> - ssid->SsidLength))) {
>=20
> - if (!check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> - if (!r8712_is_same_ibss(padapter,
> - pnetwork)) {
> - /* if in WIFI_ADHOC_MASTER_STATE or
> - * WIFI_ADHOC_STATE, create bss or
> - * rejoin again
> - /
> - r8712_disassoc_cmd(padapter);
> - if (check_fwstate(pmlmepriv,
> - _FW_LINKED))
> - r8712_ind_disconnect(padapter);
> - r8712_free_assoc_resources(padapter);
> - if (check_fwstate(pmlmepriv,
> - WIFI_ADHOC_MASTER_STATE)) {
> - clr_fwstate(pmlmepriv,
> - WIFI_ADHOC_MASTER_STATE);
> - set_fwstate(pmlmepriv,
> - WIFI_ADHOC_STATE);
> - }
> - } else {
> - / driver is in
> - * WIFI_ADHOC_MASTER_STATE
> - */
> - goto _Abort_Set_SSID;
> - }
> - }
> - } else {
> - r8712_disassoc_cmd(padapter);
> - if (check_fwstate(pmlmepriv, _FW_LINKED))
> - r8712_ind_disconnect(padapter);
> - r8712_free_assoc_resources(padapter);
> - if (check_fwstate(pmlmepriv,
> - WIFI_ADHOC_MASTER_STATE)) {
> - clr_fwstate(pmlmepriv,
> - WIFI_ADHOC_MASTER_STATE);
> - set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
> - }
> - }
> - }
> - if (padapter->securitypriv.btkip_countermeasure)
>=20
> - goto _Abort_Set_SSID;
> - if (!validate_ssid(ssid))
> - goto _Abort_Set_SSID;
> - memcpy(&pmlmepriv->assoc_ssid, ssid, sizeof(struct ndis_802_11_ssid));
>=20
> - pmlmepriv->assoc_by_bssid =3D false;
>=20
> - do_join(padapter);
> - goto done;
> -_Abort_Set_SSID:
> -done:
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> -}
> -
> -void r8712_set_802_11_infrastructure_mode(struct _adapter *padapter,
> - enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_network *cur_network =3D &pmlmepriv->cur_network;
>=20
> - enum NDIS_802_11_NETWORK_INFRASTRUCTURE *pold_state =3D
> - &cur_network->network.InfrastructureMode;
>=20
> -
> - if (*pold_state !=3D networktype) {
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, _FW_LINKED) ||
> - (*pold_state =3D=3D Ndis802_11IBSS))
> - r8712_disassoc_cmd(padapter);
> - if (check_fwstate(pmlmepriv,
> - _FW_LINKED | WIFI_ADHOC_MASTER_STATE))
> - r8712_free_assoc_resources(padapter);
> - if (check_fwstate(pmlmepriv, _FW_LINKED) ||
> - (*pold_state =3D=3D Ndis802_11Infrastructure) ||
> - (pold_state =3D=3D Ndis802_11IBSS)) {
> - / will clr Linked_state before this function,
> - * we must have checked whether issue dis-assoc_cmd or
> - * not
> - */
> - r8712_ind_disconnect(padapter);
> - }
> - pold_state =3D networktype;
> - / clear WIFI_STATION_STATE; WIFI_AP_STATE; WIFI_ADHOC_STATE;
> - * WIFI_ADHOC_MASTER_STATE
> - */
> - clr_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE |
> - WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE);
> - switch (networktype) {
> - case Ndis802_11IBSS:
> - set_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
> - break;
> - case Ndis802_11Infrastructure:
> - set_fwstate(pmlmepriv, WIFI_STATION_STATE);
> - break;
> - case Ndis802_11APMode:
> - set_fwstate(pmlmepriv, WIFI_AP_STATE);
> - break;
> - case Ndis802_11AutoUnknown:
> - case Ndis802_11InfrastructureMax:
> - break;
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - }
> -}
> -
> -u8 r8712_set_802_11_disassociate(struct _adapter *padapter)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - r8712_disassoc_cmd(padapter);
> - r8712_ind_disconnect(padapter);
> - r8712_free_assoc_resources(padapter);
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - return true;
> -}
> -
> -u8 r8712_set_802_11_bssid_list_scan(struct _adapter *padapter)
> -{
> - struct mlme_priv *pmlmepriv =3D NULL;
> - unsigned long irqL;
> - u8 ret =3D true;
> -
> - if (!padapter)
> - return false;
> - pmlmepriv =3D &padapter->mlmepriv;
>=20
> - if (!padapter->hw_init_completed)
>=20
> - return false;
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY | _FW_UNDER_LINKING) ||
> - pmlmepriv->sitesurveyctrl.traffic_busy) {
>=20
> - /* Scan or linking is in progress, do nothing. */
> - ret =3D (u8)check_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
> - } else {
> - r8712_free_network_queue(padapter);
> - ret =3D r8712_sitesurvey_cmd(padapter, NULL);
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - return ret;
> -}
> -
> -u8 r8712_set_802_11_authentication_mode(struct _adapter *padapter,
> - enum NDIS_802_11_AUTHENTICATION_MODE authmode)
> -{
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - u8 ret;
> -
> - psecuritypriv->ndisauthtype =3D authmode;
>=20
> - if (psecuritypriv->ndisauthtype > 3)
>=20
> - psecuritypriv->auth_algorithm =3D AUTH_8021x;
>=20
> - if (r8712_set_auth(padapter, psecuritypriv))
> - ret =3D false;
> - else
> - ret =3D true;
> - return ret;
> -}
> -
> -int r8712_set_802_11_add_wep(struct _adapter *padapter,
> - struct NDIS_802_11_WEP *wep)
> -{
> - sint keyid;
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> -
> - keyid =3D wep->KeyIndex & 0x3fffffff;
>=20
> - if (keyid >=3D WEP_KEYS)
>=20
> - return -EINVAL;
> - switch (wep->KeyLength) {
>=20
> - case 5:
> - psecuritypriv->privacy_algorithm =3D WEP40;
>=20
> - break;
> - case 13:
> - psecuritypriv->privacy_algorithm =3D WEP104;
>=20
> - break;
> - default:
> - psecuritypriv->privacy_algorithm =3D NO_PRIVACY;
>=20
> - break;
> - }
> - memcpy(psecuritypriv->DefKey[keyid].skey, &wep->KeyMaterial,
>=20
> - wep->KeyLength);
>=20
> - psecuritypriv->DefKeylen[keyid] =3D wep->KeyLength;
>=20
> - psecuritypriv->PrivacyKeyIndex =3D keyid;
>=20
> - return r8712_set_key(padapter, psecuritypriv, keyid);
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_set.h b/drivers/stagin=
g/rtl8712/rtl871x_ioctl_set.h
> deleted file mode 100644
> index e2de820f61d9..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_set.h
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - **********/
> -#ifndef __IOCTL_SET_H
> -#define __IOCTL_SET_H
> -
> -#include "drv_types.h"
> -
> -typedef u8 NDIS_802_11_PMKID_VALUE[16];
> -
> -struct BSSIDInfo {
> - unsigned char BSSID[6];
> - NDIS_802_11_PMKID_VALUE PMKID;
> -};
> -
> -u8 r8712_set_802_11_authentication_mode(struct _adapter pdapter,
> - enum NDIS_802_11_AUTHENTICATION_MODE authmode);
> -
> -u8 r8712_set_802_11_bssid(struct _adapter padapter, u8 bssid);
> -
> -int r8712_set_802_11_add_wep(struct _adapter padapter,
> - struct NDIS_802_11_WEP wep);
> -
> -u8 r8712_set_802_11_disassociate(struct _adapter padapter);
> -
> -u8 r8712_set_802_11_bssid_list_scan(struct _adapter padapter);
> -
> -void r8712_set_802_11_infrastructure_mode(struct _adapter padapter,
> - enum NDIS_802_11_NETWORK_INFRASTRUCTURE networktype);
> -
> -void r8712_set_802_11_ssid(struct _adapter padapter,
> - struct ndis_802_11_ssid ssid);
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_led.h b/drivers/staging/rtl8=
712/rtl871x_led.h
> deleted file mode 100644
> index 2f0768132ad8..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_led.h
> +++ /dev/null
> @@ -1,118 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -#ifndef __RTL8712_LED_H
> -#define __RTL8712_LED_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * LED customization.
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - */
> -enum LED_CTL_MODE {
> - LED_CTL_POWER_ON =3D 1,
> - LED_CTL_LINK =3D 2,
> - LED_CTL_NO_LINK =3D 3,
> - LED_CTL_TX =3D 4,
> - LED_CTL_RX =3D 5,
> - LED_CTL_SITE_SURVEY =3D 6,
> - LED_CTL_POWER_OFF =3D 7,
> - LED_CTL_START_TO_LINK =3D 8,
> - LED_CTL_START_WPS =3D 9,
> - LED_CTL_STOP_WPS =3D 10,
> - LED_CTL_START_WPS_BOTTON =3D 11,
> - LED_CTL_STOP_WPS_FAIL =3D 12,
> - LED_CTL_STOP_WPS_FAIL_OVERLAP =3D 13,
> -};
> -
> -#define IS_LED_WPS_BLINKING(_LED_871x) \
> - (((struct LED_871x *)_LED_871x)->CurrLedState =3D=3D LED_BLINK_WPS \
>=20
> - || ((struct LED_871x *)_LED_871x)->CurrLedState =3D=3D LED_BLINK_WPS_ST=
OP \
>=20
> - || ((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress)
>=20
> -
> -#define IS_LED_BLINKING(_LED_871x) \
> - (((struct LED_871x *)_LED_871x)->bLedWPSBlinkInProgress \
>=20
> - || ((struct LED_871x *)_LED_871x)->bLedScanBlinkInProgress)
>=20
> -
> -enum LED_PIN_871x {
> - LED_PIN_GPIO0,
> - LED_PIN_LED0,
> - LED_PIN_LED1
> -};
> -
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * LED customization.
> - =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - /
> -enum LED_STRATEGY_871x {
> - SW_LED_MODE0, / SW control 1 LED via GPIO0. It is default option. /
> - SW_LED_MODE1, / 2 LEDs, through LED0 and LED1. For ALPHA. /
> - SW_LED_MODE2, / SW control 1 LED via GPIO0,
> - * custom for AzWave 8187 minicard.
> - /
> - SW_LED_MODE3, / SW control 1 LED via GPIO0,
> - * customized for Sercomm Printer Server case.
> - /
> - SW_LED_MODE4, /for Edimax / Belkin/
> - SW_LED_MODE5, /for Sercomm / Belkin/
> - SW_LED_MODE6, /for WNC / Corega/
> - HW_LED, / HW control 2 LEDs, LED0 and LED1 (there are 4 different
> - * control modes, see MAC.CONFIG1 for details.)
> - /
> -};
> -
> -struct LED_871x {
> - struct _adapter padapter;
> - enum LED_PIN_871x LedPin; / Implementation for this SW led. /
> - u32 CurrLedState; / Current LED state. /
> - u8 bLedOn; / true if LED is ON /
> - u8 bSWLedCtrl;
> - u8 bLedBlinkInProgress; /true if blinking /
> - u8 bLedNoLinkBlinkInProgress;
> - u8 bLedLinkBlinkInProgress;
> - u8 bLedStartToLinkBlinkInProgress;
> - u8 bLedScanBlinkInProgress;
> - u8 bLedWPSBlinkInProgress;
> - u32 BlinkTimes; / No. times to toggle for blink./
> - u32 BlinkingLedState; / Next state for blinking,
> - * either LED_ON or OFF.
> - /
> -
> - struct timer_list BlinkTimer; / Timer object for led blinking./
> - struct work_struct BlinkWorkItem; / Workitem used by BlinkTimer /
> -};
> -
> -struct led_priv {
> - / add for led control /
> - struct LED_871x SwLed0;
> - struct LED_871x SwLed1;
> - enum LED_STRATEGY_871x LedStrategy;
> - u8 bRegUseLed;
> - void (LedControlHandler)(struct _adapter padapter,
> - enum LED_CTL_MODE LedAction);
> - / add for led control /
> -};
> -
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - * Interface to manipulate LED objects.
> - =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> - /
> -void r8712_InitSwLeds(struct _adapter padapter);
> -void r8712_DeInitSwLeds(struct _adapter padapter);
> -void LedControl871x(struct _adapter padapter, enum LED_CTL_MODE LedActio=
n);
> -void r8712_flush_led_works(struct _adapter padapter);
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl=
8712/rtl871x_mlme.c
> deleted file mode 100644
> index 1ca94e90dfe6..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_mlme.c
> +++ /dev/null
> @@ -1,1711 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*********************************************************************
> - * rtl871x_mlme.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_MLME_C
> -
> -#include <linux/etherdevice.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "recv_osdep.h"
> -#include "xmit_osdep.h"
> -#include "mlme_osdep.h"
> -#include "rtl871x_security.h"
> -#include "sta_info.h"
> -#include "wifi.h"
> -#include "wlan_bssdef.h"
> -
> -static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_le=
n);
> -
> -int r8712_init_mlme_priv(struct _adapter *padapter)
> -{
> - sint i;
> - u8 *pbuf;
> - struct wlan_network *pnetwork;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - memset((u8 *)pmlmepriv, 0, sizeof(struct mlme_priv));
> - pmlmepriv->nic_hdl =3D (u8 *)padapter;
>=20
> - pmlmepriv->pscanned =3D NULL;
>=20
> - pmlmepriv->fw_state =3D 0;
>=20
> - pmlmepriv->cur_network.network.InfrastructureMode =3D
>=20
> - Ndis802_11AutoUnknown;
> - /* Maybe someday we should rename this variable to "active_mode"(Jeff)/
> - pmlmepriv->passive_mode =3D 1; / 1: active, 0: passive. */
>=20
> - spin_lock_init(&pmlmepriv->lock);
>=20
> - spin_lock_init(&pmlmepriv->lock2);
>=20
> - _init_queue(&pmlmepriv->free_bss_pool);
>=20
> - _init_queue(&pmlmepriv->scanned_queue);
>=20
> - set_scanned_network_val(pmlmepriv, 0);
> - memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
>=20
> - pbuf =3D kmalloc_array(MAX_BSS_CNT, sizeof(struct wlan_network),
> - GFP_ATOMIC);
> - if (!pbuf)
> - return -ENOMEM;
> - pmlmepriv->free_bss_buf =3D pbuf;
>=20
> - pnetwork =3D (struct wlan_network *)pbuf;
> - for (i =3D 0; i < MAX_BSS_CNT; i++) {
> - INIT_LIST_HEAD(&pnetwork->list);
>=20
> - list_add_tail(&pnetwork->list,
>=20
> - &pmlmepriv->free_bss_pool.queue);
>=20
> - pnetwork++;
> - }
> - pmlmepriv->sitesurveyctrl.last_rx_pkts =3D 0;
>=20
> - pmlmepriv->sitesurveyctrl.last_tx_pkts =3D 0;
>=20
> - pmlmepriv->sitesurveyctrl.traffic_busy =3D false;
>=20
> - /* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
> - r8712_init_mlme_timer(padapter);
> - return 0;
> -}
> -
> -struct wlan_network *_r8712_alloc_network(struct mlme_priv *pmlmepriv)
> -{
> - unsigned long irqL;
> - struct wlan_network *pnetwork;
> - struct __queue *free_queue =3D &pmlmepriv->free_bss_pool;
>=20
> -
> - spin_lock_irqsave(&free_queue->lock, irqL);
>=20
> - pnetwork =3D list_first_entry_or_null(&free_queue->queue,
>=20
> - struct wlan_network, list);
> - if (pnetwork) {
> - list_del_init(&pnetwork->list);
>=20
> - pnetwork->last_scanned =3D jiffies;
>=20
> - pmlmepriv->num_of_scanned++;
>=20
> - }
> - spin_unlock_irqrestore(&free_queue->lock, irqL);
>=20
> - return pnetwork;
> -}
> -
> -static void _free_network(struct mlme_priv *pmlmepriv,
> - struct wlan_network *pnetwork)
> -{
> - u32 curr_time, delta_time;
> - unsigned long irqL;
> - struct __queue *free_queue =3D &pmlmepriv->free_bss_pool;
>=20
> -
> - if (!pnetwork)
> - return;
> - if (pnetwork->fixed)
>=20
> - return;
> - curr_time =3D jiffies;
> - delta_time =3D (curr_time - (u32)pnetwork->last_scanned) / HZ;
>=20
> - if (delta_time < SCANQUEUE_LIFETIME)
> - return;
> - spin_lock_irqsave(&free_queue->lock, irqL);
>=20
> - list_del_init(&pnetwork->list);
>=20
> - list_add_tail(&pnetwork->list, &free_queue->queue);
>=20
> - pmlmepriv->num_of_scanned--;
>=20
> - spin_unlock_irqrestore(&free_queue->lock, irqL);
>=20
> -}
> -
> -static void free_network_nolock(struct mlme_priv *pmlmepriv,
> - struct wlan_network *pnetwork)
> -{
> - struct __queue *free_queue =3D &pmlmepriv->free_bss_pool;
>=20
> -
> - if (!pnetwork)
> - return;
> - if (pnetwork->fixed)
>=20
> - return;
> - list_del_init(&pnetwork->list);
>=20
> - list_add_tail(&pnetwork->list, &free_queue->queue);
>=20
> - pmlmepriv->num_of_scanned--;
>=20
> -}
> -
> -/* return the wlan_network with the matching addr
> - * Shall be called under atomic context...
> - * to avoid possible racing condition...
> - */
> -static struct wlan_network *r8712_find_network(struct __queue *scanned_q=
ueue,
> - u8 *addr)
> -{
> - unsigned long irqL;
> - struct list_head *phead, *plist;
> - struct wlan_network *pnetwork =3D NULL;
> -
> - if (is_zero_ether_addr(addr))
> - return NULL;
> - spin_lock_irqsave(&scanned_queue->lock, irqL);
>=20
> - phead =3D &scanned_queue->queue;
>=20
> - list_for_each(plist, phead) {
> - pnetwork =3D list_entry(plist, struct wlan_network, list);
> - if (!memcmp(addr, pnetwork->network.MacAddress, ETH_ALEN))
>=20
> - break;
> - }
> - if (plist =3D=3D phead)
> - pnetwork =3D NULL;
> - spin_unlock_irqrestore(&scanned_queue->lock, irqL);
>=20
> - return pnetwork;
> -}
> -
> -void r8712_free_network_queue(struct _adapter *padapter)
> -{
> - unsigned long irqL;
> - struct list_head *phead, *plist;
> - struct wlan_network *pnetwork;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct __queue *scanned_queue =3D &pmlmepriv->scanned_queue;
>=20
> -
> - spin_lock_irqsave(&scanned_queue->lock, irqL);
>=20
> - phead =3D &scanned_queue->queue;
>=20
> - plist =3D phead->next;
>=20
> - while (!end_of_queue_search(phead, plist)) {
> - pnetwork =3D container_of(plist, struct wlan_network, list);
> - plist =3D plist->next;
>=20
> - _free_network(pmlmepriv, pnetwork);
> - }
> - spin_unlock_irqrestore(&scanned_queue->lock, irqL);
>=20
> -}
> -
> -sint r8712_if_up(struct _adapter *padapter)
> -{
> - sint res;
> -
> - if (padapter->driver_stopped || padapter->surprise_removed ||
>=20
> - !check_fwstate(&padapter->mlmepriv, _FW_LINKED)) {
>=20
> - res =3D false;
> - } else {
> - res =3D true;
> - }
> - return res;
> -}
> -
> -void r8712_generate_random_ibss(u8 *pibss)
> -{
> - u32 curtime =3D jiffies;
> -
> - pibss[0] =3D 0x02; /*in ad-hoc mode bit1 must set to 1 */
> - pibss[1] =3D 0x11;
> - pibss[2] =3D 0x87;
> - pibss[3] =3D (u8)(curtime & 0xff);
> - pibss[4] =3D (u8)((curtime >> 8) & 0xff);
>=20
> - pibss[5] =3D (u8)((curtime >> 16) & 0xff);
>=20
> -}
> -
> -uint r8712_get_wlan_bssid_ex_sz(struct wlan_bssid_ex *bss)
> -{
> - return sizeof(*bss) + bss->IELength - MAX_IE_SZ;
>=20
> -}
> -
> -u8 *r8712_get_capability_from_ie(u8 *ie)
> -{
> - return ie + 8 + 2;
> -}
> -
> -void r8712_free_mlme_priv(struct mlme_priv *pmlmepriv)
> -{
> - kfree(pmlmepriv->free_bss_buf);
>=20
> -}
> -
> -static struct wlan_network *alloc_network(struct mlme_priv *pmlmepriv)
> -{
> - return _r8712_alloc_network(pmlmepriv);
> -}
> -
> -int r8712_is_same_ibss(struct _adapter *adapter, struct wlan_network *pn=
etwork)
> -{
> - int ret =3D true;
> - struct security_priv *psecuritypriv =3D &adapter->securitypriv;
>=20
> -
> - if ((psecuritypriv->privacy_algorithm !=3D NO_PRIVACY) &&
>=20
> - (pnetwork->network.Privacy =3D=3D cpu_to_le32(0)))
>=20
> - ret =3D false;
> - else if ((psecuritypriv->privacy_algorithm =3D=3D NO_PRIVACY) &&
>=20
> - (pnetwork->network.Privacy =3D=3D cpu_to_le32(1)))
>=20
> - ret =3D false;
> - else
> - ret =3D true;
> - return ret;
> -
> -}
> -
> -static int is_same_network(struct wlan_bssid_ex *src,
> - struct wlan_bssid_ex *dst)
> -{
> - u16 s_cap, d_cap;
> -
> - memcpy((u8 *)&s_cap, r8712_get_capability_from_ie(src->IEs), 2);
>=20
> - memcpy((u8 *)&d_cap, r8712_get_capability_from_ie(dst->IEs), 2);
>=20
> - return (src->Ssid.SsidLength =3D=3D dst->Ssid.SsidLength) &&
>=20
> - (src->Configuration.DSConfig =3D=3D
>=20
> - dst->Configuration.DSConfig) &&
>=20
> - ((!memcmp(src->MacAddress, dst->MacAddress,
>=20
> - ETH_ALEN))) &&
> - ((!memcmp(src->Ssid.Ssid,
>=20
> - dst->Ssid.Ssid,
>=20
> - src->Ssid.SsidLength))) &&
>=20
> - ((s_cap & WLAN_CAPABILITY_IBSS) =3D=3D
> - (d_cap & WLAN_CAPABILITY_IBSS)) &&
> - ((s_cap & WLAN_CAPABILITY_ESS) =3D=3D
> - (d_cap & WLAN_CAPABILITY_ESS));
> -
> -}
> -
> -struct wlan_network *r8712_get_oldest_wlan_network(
> - struct __queue *scanned_queue)
> -{
> - struct list_head *plist, *phead;
> - struct wlan_network *pwlan =3D NULL;
> - struct wlan_network *oldest =3D NULL;
> -
> - phead =3D &scanned_queue->queue;
>=20
> - plist =3D phead->next;
>=20
> - while (1) {
> - if (end_of_queue_search(phead, plist))
> - break;
> - pwlan =3D container_of(plist, struct wlan_network, list);
> - if (!pwlan->fixed) {
>=20
> - if (!oldest ||
> - time_after((unsigned long)oldest->last_scanned,
>=20
> - (unsigned long)pwlan->last_scanned))
>=20
> - oldest =3D pwlan;
> - }
> - plist =3D plist->next;
>=20
> - }
> - return oldest;
> -}
> -
> -static void update_network(struct wlan_bssid_ex *dst,
> - struct wlan_bssid_ex *src,
> - struct _adapter *padapter)
> -{
> - u32 last_evm =3D 0, tmpVal;
> - struct smooth_rssi_data *sqd =3D &padapter->recvpriv.signal_qual_data;
>=20
> -
> - if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) &&
>=20
> - is_same_network(&padapter->mlmepriv.cur_network.network, src)) {
>=20
> - if (padapter->recvpriv.signal_qual_data.total_num++ >=3D
>=20
> - PHY_LINKQUALITY_SLID_WIN_MAX) {
> - padapter->recvpriv.signal_qual_data.total_num =3D
>=20
> - PHY_LINKQUALITY_SLID_WIN_MAX;
> - last_evm =3D sqd->elements[sqd->index];
>=20
> - padapter->recvpriv.signal_qual_data.total_val -=3D
>=20
> - last_evm;
> - }
> - padapter->recvpriv.signal_qual_data.total_val +=3D src->Rssi;
>=20
> -
> - sqd->elements[sqd->index++] =3D src->Rssi;
>=20
> - if (padapter->recvpriv.signal_qual_data.index >=3D
>=20
> - PHY_LINKQUALITY_SLID_WIN_MAX)
> - padapter->recvpriv.signal_qual_data.index =3D 0;
>=20
> - /* <1> Showed on UI for user, in percentage. */
>=20
> - tmpVal =3D padapter->recvpriv.signal_qual_data.total_val /
>=20
> - padapter->recvpriv.signal_qual_data.total_num;
>=20
> - padapter->recvpriv.signal =3D (u8)tmpVal;
>=20
> -
> - src->Rssi =3D padapter->recvpriv.signal;
>=20
> - } else {
> - src->Rssi =3D (src->Rssi + dst->Rssi) / 2;
>=20
> - }
> - memcpy((u8 *)dst, (u8 *)src, r8712_get_wlan_bssid_ex_sz(src));
> -}
> -
> -static void update_current_network(struct _adapter *adapter,
> - struct wlan_bssid_ex *pnetwork)
> -{
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - if (is_same_network(&pmlmepriv->cur_network.network, pnetwork)) {
>=20
> - update_network(&pmlmepriv->cur_network.network,
>=20
> - pnetwork, adapter);
> - r8712_update_protection(adapter,
> - (pmlmepriv->cur_network.network.IEs) +
>=20
> - sizeof(struct NDIS_802_11_FIXED_IEs),
> - pmlmepriv->cur_network.network.IELength);
>=20
> - }
> -}
> -
> -/* Caller must hold pmlmepriv->lock first */
>=20
> -static void update_scanned_network(struct _adapter *adapter,
> - struct wlan_bssid_ex *target)
> -{
> - struct list_head *plist, *phead;
> -
> - u32 bssid_ex_sz;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - struct __queue *queue =3D &pmlmepriv->scanned_queue;
>=20
> - struct wlan_network *pnetwork =3D NULL;
> - struct wlan_network *oldest =3D NULL;
> -
> - phead =3D &queue->queue;
>=20
> - plist =3D phead->next;
>=20
> -
> - while (1) {
> - if (end_of_queue_search(phead, plist))
> - break;
> -
> - pnetwork =3D container_of(plist, struct wlan_network, list);
> - if (is_same_network(&pnetwork->network, target))
>=20
> - break;
> - if ((oldest =3D=3D ((struct wlan_network *)0)) ||
> - time_after((unsigned long)oldest->last_scanned,
>=20
> - (unsigned long)pnetwork->last_scanned))
>=20
> - oldest =3D pnetwork;
> -
> - plist =3D plist->next;
>=20
> - }
> -
> - /* If we didn't find a match, then get a new network slot to initialize
> - * with this beacon's information
> - */
> - if (end_of_queue_search(phead, plist)) {
> - if (list_empty(&pmlmepriv->free_bss_pool.queue)) {
>=20
> - /* If there are no more slots, expire the oldest */
> - pnetwork =3D oldest;
> - target->Rssi =3D (pnetwork->network.Rssi +
>=20
> - target->Rssi) / 2;
>=20
> - memcpy(&pnetwork->network, target,
>=20
> - r8712_get_wlan_bssid_ex_sz(target));
> - pnetwork->last_scanned =3D jiffies;
>=20
> - } else {
> - /* Otherwise just pull from the free list /
> - / update scan_time */
> - pnetwork =3D alloc_network(pmlmepriv);
> - if (!pnetwork)
> - return;
> - bssid_ex_sz =3D r8712_get_wlan_bssid_ex_sz(target);
> - target->Length =3D bssid_ex_sz;
>=20
> - memcpy(&pnetwork->network, target, bssid_ex_sz);
>=20
> - list_add_tail(&pnetwork->list, &queue->queue);
>=20
> - }
> - } else {
> - /* we have an entry and we are going to update it. But
> - * this entry may be already expired. In this case we
> - * do the same as we found a new net and call the new_net
> - * handler
> - */
> - update_network(&pnetwork->network, target, adapter);
>=20
> - pnetwork->last_scanned =3D jiffies;
>=20
> - }
> -}
> -
> -static void rtl8711_add_network(struct _adapter *adapter,
> - struct wlan_bssid_ex *pnetwork)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &(((struct _adapter *)adapter)->mlmepri=
v);
>=20
> - struct __queue *queue =3D &pmlmepriv->scanned_queue;
>=20
> -
> - spin_lock_irqsave(&queue->lock, irqL);
>=20
> - update_current_network(adapter, pnetwork);
> - update_scanned_network(adapter, pnetwork);
> - spin_unlock_irqrestore(&queue->lock, irqL);
>=20
> -}
> -
> -/*select the desired network based on the capability of the (i)bss.
> - * check items: (1) security
> - * (2) network_type
> - * (3) WMM
> - * (4) HT
> - * (5) others
> - */
> -static int is_desired_network(struct _adapter *adapter,
> - struct wlan_network *pnetwork)
> -{
> - u8 wps_ie[512];
> - uint wps_ielen;
> - int bselected =3D true;
> - struct security_priv *psecuritypriv =3D &adapter->securitypriv;
>=20
> -
> - if (psecuritypriv->wps_phase) {
>=20
> - if (r8712_get_wps_ie(pnetwork->network.IEs,
>=20
> - pnetwork->network.IELength, wps_ie,
>=20
> - &wps_ielen))
> - return true;
> - return false;
> - }
> - if ((psecuritypriv->privacy_algorithm !=3D NO_PRIVACY) &&
>=20
> - (pnetwork->network.Privacy =3D=3D 0))
>=20
> - bselected =3D false;
> - if (check_fwstate(&adapter->mlmepriv, WIFI_ADHOC_STATE)) {
>=20
> - if (pnetwork->network.InfrastructureMode !=3D
>=20
> - adapter->mlmepriv.cur_network.network.InfrastructureMode)
>=20
> - bselected =3D false;
> - }
> - return bselected;
> -}
> -
> -/* TODO: Perry : For Power Management */
> -void r8712_atimdone_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> -}
> -
> -void r8712_survey_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> - unsigned long flags;
> - u32 len;
> - struct wlan_bssid_ex *pnetwork;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - pnetwork =3D (struct wlan_bssid_ex )pbuf;
> -#ifdef __BIG_ENDIAN
> - / endian_convert */
> - pnetwork->Length =3D le32_to_cpu(pnetwork->Length);
>=20
> - pnetwork->Ssid.SsidLength =3D le32_to_cpu(pnetwork->Ssid.SsidLength);
>=20
> - pnetwork->Privacy =3D le32_to_cpu(pnetwork->Privacy);
>=20
> - pnetwork->Rssi =3D le32_to_cpu(pnetwork->Rssi);
>=20
> - pnetwork->NetworkTypeInUse =3D le32_to_cpu(pnetwork->NetworkTypeInUse);
>=20
> - pnetwork->Configuration.ATIMWindow =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.ATIMWindow);
>=20
> - pnetwork->Configuration.BeaconPeriod =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.BeaconPeriod);
>=20
> - pnetwork->Configuration.DSConfig =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.DSConfig);
>=20
> - pnetwork->Configuration.FHConfig.DwellTime =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.FHConfig.DwellTime);
>=20
> - pnetwork->Configuration.FHConfig.HopPattern =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.FHConfig.HopPattern);
>=20
> - pnetwork->Configuration.FHConfig.HopSet =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.FHConfig.HopSet);
>=20
> - pnetwork->Configuration.FHConfig.Length =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.FHConfig.Length);
>=20
> - pnetwork->Configuration.Length =3D
>=20
> - le32_to_cpu(pnetwork->Configuration.Length);
>=20
> - pnetwork->InfrastructureMode =3D
>=20
> - le32_to_cpu(pnetwork->InfrastructureMode);
>=20
> - pnetwork->IELength =3D le32_to_cpu(pnetwork->IELength);
>=20
> -#endif
> - len =3D r8712_get_wlan_bssid_ex_sz(pnetwork);
> - if (len > sizeof(struct wlan_bssid_ex))
>=20
> - return;
> - spin_lock_irqsave(&pmlmepriv->lock2, flags);
>=20
> - /* update IBSS_network 's timestamp */
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
> - if (!memcmp(&pmlmepriv->cur_network.network.MacAddress,
>=20
> - pnetwork->MacAddress, ETH_ALEN)) {
>=20
> - struct wlan_network *ibss_wlan =3D NULL;
> -
> - memcpy(pmlmepriv->cur_network.network.IEs,
>=20
> - pnetwork->IEs, 8);
>=20
> - ibss_wlan =3D r8712_find_network(
> - &pmlmepriv->scanned_queue,
>=20
> - pnetwork->MacAddress);
>=20
> - if (ibss_wlan) {
> - memcpy(ibss_wlan->network.IEs,
>=20
> - pnetwork->IEs, 8);
>=20
> - goto exit;
> - }
> - }
> - }
> - /* lock pmlmepriv->lock when you accessing network_q */
>=20
> - if (!check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
> - if (pnetwork->Ssid.Ssid[0] !=3D 0) {
>=20
> - rtl8711_add_network(adapter, pnetwork);
> - } else {
> - pnetwork->Ssid.SsidLength =3D 8;
>=20
> - memcpy(pnetwork->Ssid.Ssid, "<hidden>", 8);
>=20
> - rtl8711_add_network(adapter, pnetwork);
> - }
> - }
> -exit:
> - spin_unlock_irqrestore(&pmlmepriv->lock2, flags);
>=20
> -}
> -
> -void r8712_surveydone_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> -
> - if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY)) {
> - del_timer(&pmlmepriv->scan_to_timer);
>=20
> -
> - clr_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
> - }
> -
> - if (pmlmepriv->to_join) {
>=20
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> - if (!check_fwstate(pmlmepriv, _FW_LINKED)) {
> - set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> -
> - if (!r8712_select_and_join_from_scan(pmlmepriv)) {
> - mod_timer(&pmlmepriv->assoc_timer, jiffies +
>=20
> - msecs_to_jiffies(MAX_JOIN_TIMEOUT));
> - } else {
> - struct wlan_bssid_ex *pdev_network =3D
> - &adapter->registrypriv.dev_network;
>=20
> - u8 *pibss =3D
> - adapter->registrypriv.dev_network.MacAddress;
>=20
> - pmlmepriv->fw_state ^=3D _FW_UNDER_SURVEY;
>=20
> - memcpy(&pdev_network->Ssid,
>=20
> - &pmlmepriv->assoc_ssid,
>=20
> - sizeof(struct
> - ndis_802_11_ssid));
> - r8712_update_registrypriv_dev_network
> - (adapter);
> - r8712_generate_random_ibss(pibss);
> - pmlmepriv->fw_state =3D
>=20
> - WIFI_ADHOC_MASTER_STATE;
> - pmlmepriv->to_join =3D false;
>=20
> - }
> - }
> - } else {
> - pmlmepriv->to_join =3D false;
>=20
> - set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - if (!r8712_select_and_join_from_scan(pmlmepriv))
> - mod_timer(&pmlmepriv->assoc_timer, jiffies +
>=20
> - msecs_to_jiffies(MAX_JOIN_TIMEOUT));
> - else
> - clr_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - }
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> -}
> -
> -/*
> - *r8712_free_assoc_resources: the caller has to lock pmlmepriv->lock
>=20
> - */
> -void r8712_free_assoc_resources(struct _adapter *adapter)
> -{
> - unsigned long irqL;
> - struct wlan_network *pwlan =3D NULL;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - struct sta_priv *pstapriv =3D &adapter->stapriv;
>=20
> - struct wlan_network *tgt_network =3D &pmlmepriv->cur_network;
>=20
> -
> - pwlan =3D r8712_find_network(&pmlmepriv->scanned_queue,
>=20
> - tgt_network->network.MacAddress);
>=20
> -
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE | WIFI_AP_STATE)) {
> - struct sta_info *psta;
> -
> - psta =3D r8712_get_stainfo(&adapter->stapriv,
>=20
> - tgt_network->network.MacAddress);
>=20
> -
> - spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
>=20
> - r8712_free_stainfo(adapter, psta);
> - spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
>=20
> - }
> -
> - if (check_fwstate(pmlmepriv,
> - WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE | WIFI_AP_STATE))
> - r8712_free_all_stainfo(adapter);
> - if (pwlan)
> - pwlan->fixed =3D false;
>=20
> -
> - if (((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) &&
> - (adapter->stapriv.asoc_sta_count =3D=3D 1)))
>=20
> - free_network_nolock(pmlmepriv, pwlan);
> -}
> -
> -/*
> - * r8712_indicate_connect: the caller has to lock pmlmepriv->lock
>=20
> - */
> -void r8712_indicate_connect(struct _adapter *padapter)
> -{
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - pmlmepriv->to_join =3D false;
>=20
> - set_fwstate(pmlmepriv, _FW_LINKED);
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_LINK);
>=20
> - r8712_os_indicate_connect(padapter);
> - if (padapter->registrypriv.power_mgnt > PS_MODE_ACTIVE)
>=20
> - mod_timer(&pmlmepriv->dhcp_timer,
>=20
> - jiffies + msecs_to_jiffies(60000));
> -}
> -
> -/*
> - * r8712_ind_disconnect: the caller has to lock pmlmepriv->lock
>=20
> - */
> -void r8712_ind_disconnect(struct _adapter *padapter)
> -{
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> -
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - clr_fwstate(pmlmepriv, _FW_LINKED);
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_NO_LINK);
>=20
> - r8712_os_indicate_disconnect(padapter);
> - }
> - if (padapter->pwrctrlpriv.pwr_mode !=3D
>=20
> - padapter->registrypriv.power_mgnt) {
>=20
> - del_timer(&pmlmepriv->dhcp_timer);
>=20
> - r8712_set_ps_mode(padapter, padapter->registrypriv.power_mgnt,
>=20
> - padapter->registrypriv.smart_ps);
>=20
> - }
> -}
> -
> -/*Notes:
> - *pnetwork : returns from r8712_joinbss_event_callback
> - *ptarget_wlan: found from scanned_queue
> - *if join_res > 0, for (fw_state=3D=3DWIFI_STATION_STATE), we check if
>=20
> - * "ptarget_sta" & "ptarget_wlan" exist.
> - *if join_res > 0, for (fw_state=3D=3DWIFI_ADHOC_STATE), we only check
>=20
> - * if "ptarget_wlan" exist.
> - *if join_res > 0, update "cur_network->network" from
>=20
> - * "pnetwork->network" if (ptarget_wlan !=3DNULL).
>=20
> - */
> -void r8712_joinbss_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> - unsigned long irqL =3D 0, irqL2;
> - struct sta_info *ptarget_sta =3D NULL, *pcur_sta =3D NULL;
> - struct sta_priv *pstapriv =3D &adapter->stapriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - struct wlan_network *cur_network =3D &pmlmepriv->cur_network;
>=20
> - struct wlan_network *pcur_wlan =3D NULL, *ptarget_wlan =3D NULL;
> - unsigned int the_same_macaddr =3D false;
> - struct wlan_network *pnetwork;
> -
> - if (sizeof(struct list_head) =3D=3D 4 * sizeof(u32)) {
> - pnetwork =3D kmalloc(sizeof(struct wlan_network), GFP_ATOMIC);
> - if (!pnetwork)
> - return;
> - memcpy((u8 *)pnetwork + 16, (u8 *)pbuf + 8,
> - sizeof(struct wlan_network) - 16);
> - } else {
> - pnetwork =3D (struct wlan_network )pbuf;
> - }
> -
> -#ifdef __BIG_ENDIAN
> - / endian_convert */
> - pnetwork->join_res =3D le32_to_cpu(pnetwork->join_res);
>=20
> - pnetwork->network_type =3D le32_to_cpu(pnetwork->network_type);
>=20
> - pnetwork->network.Length =3D le32_to_cpu(pnetwork->network.Length);
>=20
> - pnetwork->network.Ssid.SsidLength =3D
>=20
> - le32_to_cpu(pnetwork->network.Ssid.SsidLength);
>=20
> - pnetwork->network.Privacy =3D le32_to_cpu(pnetwork->network.Privacy);
>=20
> - pnetwork->network.Rssi =3D le32_to_cpu(pnetwork->network.Rssi);
>=20
> - pnetwork->network.NetworkTypeInUse =3D
>=20
> - le32_to_cpu(pnetwork->network.NetworkTypeInUse);
>=20
> - pnetwork->network.Configuration.ATIMWindow =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.ATIMWindow);
>=20
> - pnetwork->network.Configuration.BeaconPeriod =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.BeaconPeriod);
>=20
> - pnetwork->network.Configuration.DSConfig =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.DSConfig);
>=20
> - pnetwork->network.Configuration.FHConfig.DwellTime =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.FHConfig.DwellTime);
>=20
> - pnetwork->network.Configuration.FHConfig.HopPattern =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopPattern);
>=20
> - pnetwork->network.Configuration.FHConfig.HopSet =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.FHConfig.HopSet);
>=20
> - pnetwork->network.Configuration.FHConfig.Length =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.FHConfig.Length);
>=20
> - pnetwork->network.Configuration.Length =3D
>=20
> - le32_to_cpu(pnetwork->network.Configuration.Length);
>=20
> - pnetwork->network.InfrastructureMode =3D
>=20
> - le32_to_cpu(pnetwork->network.InfrastructureMode);
>=20
> - pnetwork->network.IELength =3D le32_to_cpu(pnetwork->network.IELength);
>=20
> -#endif
> -
> - the_same_macaddr =3D !memcmp(pnetwork->network.MacAddress,
>=20
> - cur_network->network.MacAddress, ETH_ALEN);
>=20
> - pnetwork->network.Length =3D
>=20
> - r8712_get_wlan_bssid_ex_sz(&pnetwork->network);
>=20
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (pnetwork->network.Length > sizeof(struct wlan_bssid_ex))
>=20
> - goto ignore_joinbss_callback;
> - if (pnetwork->join_res > 0) {
>=20
> - if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
> - /s1. find ptarget_wlan/
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - if (the_same_macaddr) {
> - ptarget_wlan =3D
> - r8712_find_network(&pmlmepriv->scanned_queue,
>=20
> - cur_network->network.MacAddress);
>=20
> - } else {
> - pcur_wlan =3D
> - r8712_find_network(&pmlmepriv->scanned_queue,
>=20
> - cur_network->network.MacAddress);
>=20
> - if (pcur_wlan)
> - pcur_wlan->fixed =3D false;
>=20
> -
> - pcur_sta =3D r8712_get_stainfo(pstapriv,
> - cur_network->network.MacAddress);
>=20
> - spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL2);
>=20
> - r8712_free_stainfo(adapter, pcur_sta);
> - spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL2);
>=20
> -
> - ptarget_wlan =3D
> - r8712_find_network(&pmlmepriv->scanned_queue,
>=20
> - pnetwork->network.MacAddress);
>=20
> - if (ptarget_wlan)
> - ptarget_wlan->fixed =3D true;
>=20
> - }
> - } else {
> - ptarget_wlan =3D r8712_find_network(&pmlmepriv->scanned_queue,
>=20
> - pnetwork->network.MacAddress);
>=20
> - if (ptarget_wlan)
> - ptarget_wlan->fixed =3D true;
>=20
> - }
> -
> - if (!ptarget_wlan) {
> - if (check_fwstate(pmlmepriv,
> - _FW_UNDER_LINKING))
> - pmlmepriv->fw_state ^=3D
>=20
> - _FW_UNDER_LINKING;
> - goto ignore_joinbss_callback;
> - }
> -
> - /s2. find ptarget_sta & update ptarget_sta/
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> - if (the_same_macaddr) {
> - ptarget_sta =3D
> - r8712_get_stainfo(pstapriv,
> - pnetwork->network.MacAddress);
>=20
> - if (!ptarget_sta)
> - ptarget_sta =3D
> - r8712_alloc_stainfo(pstapriv,
> - pnetwork->network.MacAddress);
>=20
> - } else {
> - ptarget_sta =3D
> - r8712_alloc_stainfo(pstapriv,
> - pnetwork->network.MacAddress);
>=20
> - }
> - if (ptarget_sta) /update ptarget_sta/ {
> - ptarget_sta->aid =3D pnetwork->join_res;
>=20
> - ptarget_sta->qos_option =3D 1;
>=20
> - ptarget_sta->mac_id =3D 5;
>=20
> - if (adapter->securitypriv.auth_algorithm =3D=3D AUTH_8021x) {
>=20
> - adapter->securitypriv.binstallGrpkey =3D false;
>=20
> - adapter->securitypriv.busetkipkey =3D false;
>=20
> - adapter->securitypriv.bgrpkey_handshake =3D false;
>=20
> - ptarget_sta->ieee8021x_blocked =3D true;
>=20
> - ptarget_sta->XPrivacy =3D
>=20
> - adapter->securitypriv.privacy_algorithm;
>=20
> - memset((u8 *)&ptarget_sta->x_UncstKey,
>=20
> - 0,
> - sizeof(union Keytype));
> - memset((u8 *)&ptarget_sta->tkiprxmickey,
>=20
> - 0,
> - sizeof(union Keytype));
> - memset((u8 *)&ptarget_sta->tkiptxmickey,
>=20
> - 0,
> - sizeof(union Keytype));
> - memset((u8 *)&ptarget_sta->txpn,
>=20
> - 0,
> - sizeof(union pn48));
> - memset((u8 *)&ptarget_sta->rxpn,
>=20
> - 0,
> - sizeof(union pn48));
> - }
> - } else {
> - if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
> - pmlmepriv->fw_state ^=3D
>=20
> - _FW_UNDER_LINKING;
> - goto ignore_joinbss_callback;
> - }
> - }
> -
> - /s3. update cur_network & indicate connect/
> - memcpy(&cur_network->network, &pnetwork->network,
>=20
> - pnetwork->network.Length);
>=20
> - cur_network->aid =3D pnetwork->join_res;
>=20
> - /update fw_state will clr _FW_UNDER_LINKING/
> - switch (pnetwork->network.InfrastructureMode) {
>=20
> - case Ndis802_11Infrastructure:
> - pmlmepriv->fw_state =3D WIFI_STATION_STATE;
>=20
> - break;
> - case Ndis802_11IBSS:
> - pmlmepriv->fw_state =3D WIFI_ADHOC_STATE;
>=20
> - break;
> - default:
> - pmlmepriv->fw_state =3D WIFI_NULL_STATE;
>=20
> - break;
> - }
> - r8712_update_protection(adapter,
> - (cur_network->network.IEs) +
>=20
> - sizeof(struct NDIS_802_11_FIXED_IEs),
> - (cur_network->network.IELength));
>=20
> - /TODO: update HT_Capability/
> - update_ht_cap(adapter, cur_network->network.IEs,
>=20
> - cur_network->network.IELength);
>=20
> - /indicate connect/
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> - r8712_indicate_connect(adapter);
> - del_timer(&pmlmepriv->assoc_timer);
>=20
> - } else {
> - goto ignore_joinbss_callback;
> - }
> - } else {
> - if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING)) {
> - mod_timer(&pmlmepriv->assoc_timer,
>=20
> - jiffies + msecs_to_jiffies(1));
> - clr_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - }
> - }
> -ignore_joinbss_callback:
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - if (sizeof(struct list_head) =3D=3D 4 * sizeof(u32))
> - kfree(pnetwork);
> -}
> -
> -void r8712_stassoc_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> - unsigned long irqL;
> - struct sta_info *psta;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - struct stassoc_event *pstassoc =3D (struct stassoc_event )pbuf;
> -
> - / to do: */
> - if (!r8712_access_ctrl(&adapter->acl_list, pstassoc->macaddr))
>=20
> - return;
> - psta =3D r8712_get_stainfo(&adapter->stapriv, pstassoc->macaddr);
>=20
> - if (psta) {
> - /*the sta have been in sta_info_queue =3D> do nothing
>=20
> - *(between drv has received this event before and
> - * fw have not yet to set key to CAM_ENTRY)
> - */
> - return;
> - }
> -
> - psta =3D r8712_alloc_stainfo(&adapter->stapriv, pstassoc->macaddr);
>=20
> - if (!psta)
> - return;
> - /* to do : init sta_info variable */
> - psta->qos_option =3D 0;
>=20
> - psta->mac_id =3D le32_to_cpu(pstassoc->cam_id);
>=20
> - /* psta->aid =3D (uint)pstassoc->cam_id; */
>=20
> -
> - if (adapter->securitypriv.auth_algorithm =3D=3D AUTH_8021x)
>=20
> - psta->XPrivacy =3D adapter->securitypriv.privacy_algorithm;
>=20
> - psta->ieee8021x_blocked =3D false;
>=20
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE) ||
> - check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> - if (adapter->stapriv.asoc_sta_count =3D=3D 2) {
>=20
> - /* a sta + bc/mc_stainfo (not Ibss_stainfo) */
> - r8712_indicate_connect(adapter);
> - }
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> -}
> -
> -void r8712_stadel_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> - unsigned long irqL, irqL2;
> - struct sta_info *psta;
> - struct wlan_network *pwlan =3D NULL;
> - struct wlan_bssid_ex *pdev_network =3D NULL;
> - u8 *pibss =3D NULL;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - struct stadel_event *pstadel =3D (struct stadel_event *)pbuf;
> - struct sta_priv *pstapriv =3D &adapter->stapriv;
>=20
> - struct wlan_network *tgt_network =3D &pmlmepriv->cur_network;
>=20
> -
> - spin_lock_irqsave(&pmlmepriv->lock, irqL2);
>=20
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> - r8712_ind_disconnect(adapter);
> - r8712_free_assoc_resources(adapter);
> - }
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE |
> - WIFI_ADHOC_STATE)) {
> - psta =3D r8712_get_stainfo(&adapter->stapriv, pstadel->macaddr);
>=20
> - spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
>=20
> - r8712_free_stainfo(adapter, psta);
> - spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
>=20
> - if (adapter->stapriv.asoc_sta_count =3D=3D 1) {
>=20
> - /*a sta + bc/mc_stainfo (not Ibss_stainfo) */
> - pwlan =3D r8712_find_network(&pmlmepriv->scanned_queue,
>=20
> - tgt_network->network.MacAddress);
>=20
> - if (pwlan) {
> - pwlan->fixed =3D false;
>=20
> - free_network_nolock(pmlmepriv, pwlan);
> - }
> - /re-create ibss/
> - pdev_network =3D &adapter->registrypriv.dev_network;
>=20
> - pibss =3D adapter->registrypriv.dev_network.MacAddress;
>=20
> - memcpy(pdev_network, &tgt_network->network,
>=20
> - r8712_get_wlan_bssid_ex_sz(&tgt_network->network));
>=20
> - memcpy(&pdev_network->Ssid,
>=20
> - &pmlmepriv->assoc_ssid,
>=20
> - sizeof(struct ndis_802_11_ssid));
> - r8712_update_registrypriv_dev_network(adapter);
> - r8712_generate_random_ibss(pibss);
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)) {
> - clr_fwstate(pmlmepriv, WIFI_ADHOC_STATE);
> - set_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE);
> - }
> - }
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL2);
>=20
> -}
> -
> -void r8712_cpwm_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> - struct reportpwrstate_parm *preportpwrstate =3D
> - (struct reportpwrstate_parm *)pbuf;
> -
> - preportpwrstate->state |=3D (u8)(adapter->pwrctrlpriv.cpwm_tog + 0x80);
>=20
> - r8712_cpwm_int_hdl(adapter, preportpwrstate);
> -}
> -
> -/* When the Netgear 3500 AP is with WPA2PSK-AES mode, it will send
> - * the ADDBA req frame with start seq control =3D 0 to wifi client after
> - * the WPA handshake and the sequence number of following data packet
> - * will be 0. In this case, the Rx reorder sequence is not longer than 0
> - * and the WiFi client will drop the data with seq number 0.
> - * So, the 8712 firmware has to inform driver with receiving the
> - * ADDBA-Req frame so that the driver can reset the
> - * sequence value of Rx reorder control.
> - */
> -void r8712_got_addbareq_event_callback(struct _adapter *adapter, u8 *pbu=
f)
> -{
> - struct ADDBA_Req_Report_parm *pAddbareq_pram =3D
> - (struct ADDBA_Req_Report_parm *)pbuf;
> - struct sta_info *psta;
> - struct sta_priv *pstapriv =3D &adapter->stapriv;
>=20
> - struct recv_reorder_ctrl *precvreorder_ctrl =3D NULL;
> -
> - psta =3D r8712_get_stainfo(pstapriv, pAddbareq_pram->MacAddress);
>=20
> - if (psta) {
> - precvreorder_ctrl =3D
> - &psta->recvreorder_ctrl[pAddbareq_pram->tid];
>=20
> - /* set the indicate_seq to 0xffff so that the rx reorder
> - * can store any following data packet.
> - */
> - precvreorder_ctrl->indicate_seq =3D 0xffff;
>=20
> - }
> -}
> -
> -void r8712_wpspbc_event_callback(struct _adapter *adapter, u8 *pbuf)
> -{
> - if (!adapter->securitypriv.wps_hw_pbc_pressed)
>=20
> - adapter->securitypriv.wps_hw_pbc_pressed =3D true;
>=20
> -}
> -
> -void _r8712_sitesurvey_ctrl_handler(struct _adapter *adapter)
> -{
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - struct sitesurvey_ctrl *psitesurveyctrl =3D &pmlmepriv->sitesurveyctrl;
>=20
> - struct registry_priv *pregistrypriv =3D &adapter->registrypriv;
>=20
> - u64 current_tx_pkts;
> - uint current_rx_pkts;
> -
> - current_tx_pkts =3D (adapter->xmitpriv.tx_pkts) -
>=20
> - (psitesurveyctrl->last_tx_pkts);
>=20
> - current_rx_pkts =3D (adapter->recvpriv.rx_pkts) -
>=20
> - (psitesurveyctrl->last_rx_pkts);
>=20
> - psitesurveyctrl->last_tx_pkts =3D adapter->xmitpriv.tx_pkts;
>=20
> - psitesurveyctrl->last_rx_pkts =3D adapter->recvpriv.rx_pkts;
>=20
> - if ((current_tx_pkts > pregistrypriv->busy_thresh) ||
>=20
> - (current_rx_pkts > pregistrypriv->busy_thresh))
>=20
> - psitesurveyctrl->traffic_busy =3D true;
>=20
> - else
> - psitesurveyctrl->traffic_busy =3D false;
>=20
> -}
> -
> -void _r8712_join_timeout_handler(struct _adapter *adapter)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - if (adapter->driver_stopped || adapter->surprise_removed)
>=20
> - return;
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - clr_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - pmlmepriv->to_join =3D false;
>=20
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - r8712_os_indicate_disconnect(adapter);
> - clr_fwstate(pmlmepriv, _FW_LINKED);
> - }
> - if (adapter->pwrctrlpriv.pwr_mode !=3D adapter->registrypriv.power_mgnt=
) {
>=20
> - r8712_set_ps_mode(adapter, adapter->registrypriv.power_mgnt,
>=20
> - adapter->registrypriv.smart_ps);
>=20
> - }
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> -}
> -
> -void r8712_scan_timeout_handler (struct _adapter *adapter)
> -{
> - unsigned long irqL;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - clr_fwstate(pmlmepriv, _FW_UNDER_SURVEY);
> - pmlmepriv->to_join =3D false; /* scan fail, so clear to_join flag */
>=20
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> -}
> -
> -void _r8712_dhcp_timeout_handler (struct _adapter *adapter)
> -{
> - if (adapter->driver_stopped || adapter->surprise_removed)
>=20
> - return;
> - if (adapter->pwrctrlpriv.pwr_mode !=3D adapter->registrypriv.power_mgnt=
)
>=20
> - r8712_set_ps_mode(adapter, adapter->registrypriv.power_mgnt,
>=20
> - adapter->registrypriv.smart_ps);
>=20
> -}
> -
> -int r8712_select_and_join_from_scan(struct mlme_priv *pmlmepriv)
> -{
> - struct list_head *phead;
> - unsigned char *dst_ssid, *src_ssid;
> - struct _adapter *adapter;
> - struct __queue *queue =3D NULL;
> - struct wlan_network *pnetwork =3D NULL;
> - struct wlan_network *pnetwork_max_rssi =3D NULL;
> -
> - adapter =3D (struct _adapter *)pmlmepriv->nic_hdl;
>=20
> - queue =3D &pmlmepriv->scanned_queue;
>=20
> - phead =3D &queue->queue;
>=20
> - pmlmepriv->pscanned =3D phead->next;
>=20
> - while (1) {
> - if (end_of_queue_search(phead, pmlmepriv->pscanned)) {
>=20
> - if (pmlmepriv->assoc_by_rssi && pnetwork_max_rssi) {
>=20
> - pnetwork =3D pnetwork_max_rssi;
> - goto ask_for_joinbss;
> - }
> - return -EINVAL;
> - }
> - pnetwork =3D container_of(pmlmepriv->pscanned,
>=20
> - struct wlan_network, list);
> - pmlmepriv->pscanned =3D pmlmepriv->pscanned->next;
>=20
> - if (pmlmepriv->assoc_by_bssid) {
>=20
> - dst_ssid =3D pnetwork->network.MacAddress;
>=20
> - src_ssid =3D pmlmepriv->assoc_bssid;
>=20
> - if (!memcmp(dst_ssid, src_ssid, ETH_ALEN)) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - if (is_same_network(&pmlmepriv->cur_network.network,
>=20
> - &pnetwork->network)) {
>=20
> - clr_fwstate(pmlmepriv,
> - _FW_UNDER_LINKING);
> - /r8712_indicate_connect again/
> - r8712_indicate_connect(adapter);
> - return 2;
> - }
> - r8712_disassoc_cmd(adapter);
> - r8712_ind_disconnect(adapter);
> - r8712_free_assoc_resources(adapter);
> - }
> - goto ask_for_joinbss;
> - }
> - } else if (pmlmepriv->assoc_ssid.SsidLength =3D=3D 0) {
>=20
> - goto ask_for_joinbss;
> - }
> - dst_ssid =3D pnetwork->network.Ssid.Ssid;
>=20
> - src_ssid =3D pmlmepriv->assoc_ssid.Ssid;
>=20
> - if ((pnetwork->network.Ssid.SsidLength =3D=3D
>=20
> - pmlmepriv->assoc_ssid.SsidLength) &&
>=20
> - (!memcmp(dst_ssid, src_ssid,
> - pmlmepriv->assoc_ssid.SsidLength))) {
>=20
> - if (pmlmepriv->assoc_by_rssi) {
>=20
> - /* if the ssid is the same, select the bss
> - * which has the max rssi
> - */
> - if (pnetwork_max_rssi) {
> - if (pnetwork->network.Rssi >
>=20
> - pnetwork_max_rssi->network.Rssi)
>=20
> - pnetwork_max_rssi =3D pnetwork;
> - } else {
> - pnetwork_max_rssi =3D pnetwork;
> - }
> - } else if (is_desired_network(adapter, pnetwork)) {
> - if (check_fwstate(pmlmepriv, _FW_LINKED)) {
> - r8712_disassoc_cmd(adapter);
> - r8712_free_assoc_resources(adapter);
> - }
> - goto ask_for_joinbss;
> - }
> - }
> - }
> -
> -ask_for_joinbss:
> - return r8712_joinbss_cmd(adapter, pnetwork);
> -}
> -
> -int r8712_set_auth(struct _adapter *adapter,
> - struct security_priv *psecuritypriv)
> -{
> - struct cmd_priv *pcmdpriv =3D &adapter->cmdpriv;
>=20
> - struct cmd_obj *pcmd;
> - struct setauth_parm *psetauthparm;
> -
> - pcmd =3D kmalloc(sizeof(*pcmd), GFP_ATOMIC);
> - if (!pcmd)
> - return -ENOMEM;
> -
> - psetauthparm =3D kzalloc(sizeof(*psetauthparm), GFP_ATOMIC);
> - if (!psetauthparm) {
> - kfree(pcmd);
> - return -ENOMEM;
> - }
> - psetauthparm->mode =3D (u8)psecuritypriv->auth_algorithm;
>=20
> - pcmd->cmdcode =3D SetAuth_CMD;
>=20
> - pcmd->parmbuf =3D (unsigned char *)psetauthparm;
>=20
> - pcmd->cmdsz =3D sizeof(struct setauth_parm);
>=20
> - pcmd->rsp =3D NULL;
>=20
> - pcmd->rspsz =3D 0;
>=20
> - INIT_LIST_HEAD(&pcmd->list);
>=20
> - r8712_enqueue_cmd(pcmdpriv, pcmd);
> - return 0;
> -}
> -
> -int r8712_set_key(struct _adapter *adapter,
> - struct security_priv *psecuritypriv,
> - sint keyid)
> -{
> - struct cmd_priv *pcmdpriv =3D &adapter->cmdpriv;
>=20
> - struct cmd_obj *pcmd;
> - struct setkey_parm *psetkeyparm;
> - u8 keylen;
> - int ret;
> -
> - pcmd =3D kmalloc(sizeof(*pcmd), GFP_ATOMIC);
> - if (!pcmd)
> - return -ENOMEM;
> - psetkeyparm =3D kzalloc(sizeof(*psetkeyparm), GFP_ATOMIC);
> - if (!psetkeyparm) {
> - ret =3D -ENOMEM;
> - goto err_free_cmd;
> - }
> - if (psecuritypriv->auth_algorithm =3D=3D AUTH_8021x) {
>=20
> - psetkeyparm->algorithm =3D
>=20
> - (u8)psecuritypriv->XGrpPrivacy;
>=20
> - } else { /* WEP */
> - psetkeyparm->algorithm =3D
>=20
> - (u8)psecuritypriv->privacy_algorithm;
>=20
> - }
> - psetkeyparm->keyid =3D (u8)keyid;
>=20
> -
> - switch (psetkeyparm->algorithm) {
>=20
> - case WEP40:
> - keylen =3D 5;
> - memcpy(psetkeyparm->key,
>=20
> - psecuritypriv->DefKey[keyid].skey, keylen);
>=20
> - break;
> - case WEP104:
> - keylen =3D 13;
> - memcpy(psetkeyparm->key,
>=20
> - psecuritypriv->DefKey[keyid].skey, keylen);
>=20
> - break;
> - case TKIP:
> - if (keyid < 1 || keyid > 2) {
>=20
> - ret =3D -EINVAL;
> - goto err_free_parm;
> - }
> - keylen =3D 16;
> - memcpy(psetkeyparm->key,
>=20
> - &psecuritypriv->XGrpKey[keyid - 1], keylen);
>=20
> - psetkeyparm->grpkey =3D 1;
>=20
> - break;
> - case AES:
> - if (keyid < 1 || keyid > 2) {
>=20
> - ret =3D -EINVAL;
> - goto err_free_parm;
> - }
> - keylen =3D 16;
> - memcpy(psetkeyparm->key,
>=20
> - &psecuritypriv->XGrpKey[keyid - 1], keylen);
>=20
> - psetkeyparm->grpkey =3D 1;
>=20
> - break;
> - default:
> - ret =3D -EINVAL;
> - goto err_free_parm;
> - }
> - pcmd->cmdcode =3D SetKey_CMD;
>=20
> - pcmd->parmbuf =3D (u8 *)psetkeyparm;
>=20
> - pcmd->cmdsz =3D (sizeof(struct setkey_parm));
>=20
> - pcmd->rsp =3D NULL;
>=20
> - pcmd->rspsz =3D 0;
>=20
> - INIT_LIST_HEAD(&pcmd->list);
>=20
> - r8712_enqueue_cmd(pcmdpriv, pcmd);
> - return 0;
> -
> -err_free_parm:
> - kfree(psetkeyparm);
> -err_free_cmd:
> - kfree(pcmd);
> - return ret;
> -}
> -
> -/* adjust IEs for r8712_joinbss_cmd in WMM */
> -int r8712_restruct_wmm_ie(struct _adapter *adapter, u8 *in_ie, u8 out_ie=
,
> - uint in_len, uint initial_out_len)
> -{
> - unsigned int ielength =3D 0;
> - unsigned int i, j;
> -
> - i =3D 12; / after the fixed IE /
> - while (i < in_len) {
> - ielength =3D initial_out_len;
> - if (in_ie[i] =3D=3D 0xDD && in_ie[i + 2] =3D=3D 0x00 &&
> - in_ie[i + 3] =3D=3D 0x50 && in_ie[i + 4] =3D=3D 0xF2 &&
> - in_ie[i + 5] =3D=3D 0x02 && i + 5 < in_len) {
> - /WMM element ID and OUI/
> - for (j =3D i; j < i + 9; j++) {
> - out_ie[ielength] =3D in_ie[j];
> - ielength++;
> - }
> - out_ie[initial_out_len + 1] =3D 0x07;
> - out_ie[initial_out_len + 6] =3D 0x00;
> - out_ie[initial_out_len + 8] =3D 0x00;
> - break;
> - }
> - i +=3D (in_ie[i + 1] + 2); / to the next IE element /
> - }
> - return ielength;
> -}
> -
> -/
> - * Ported from 8185: IsInPreAuthKeyList().
> - *
> - * Search by BSSID,
> - * Return Value:
> - * -1 :if there is no pre-auth key in the table
> - * >=3D0 :if there is pre-auth key, and return the entry id
>=20
> - */
> -static int SecIsInPMKIDList(struct _adapter *Adapter, u8 *bssid)
> -{
> - struct security_priv *p =3D &Adapter->securitypriv;
>=20
> - int i;
> -
> - for (i =3D 0; i < NUM_PMKID_CACHE; i++)
> - if (p->PMKIDList[i].bUsed && !memcmp(p->PMKIDList[i].Bssid, bssid, ETH_=
ALEN))
>=20
> - return i;
> - return -1;
> -}
> -
> -sint r8712_restruct_sec_ie(struct _adapter *adapter, u8 *in_ie,
> - u8 *out_ie, uint in_len)
> -{
> - u8 authmode =3D 0, match;
> - u8 sec_ie[IW_CUSTOM_MAX], uncst_oui[4], bkup_ie[255];
> - u8 wpa_oui[4] =3D {0x0, 0x50, 0xf2, 0x01};
> - uint ielength, cnt, remove_cnt;
> - int iEntry;
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - struct security_priv *psecuritypriv =3D &adapter->securitypriv;
>=20
> - uint ndisauthmode =3D psecuritypriv->ndisauthtype;
>=20
> - uint ndissecuritytype =3D psecuritypriv->ndisencryptstatus;
>=20
> -
> - if ((ndisauthmode =3D=3D Ndis802_11AuthModeWPA) ||
> - (ndisauthmode =3D=3D Ndis802_11AuthModeWPAPSK)) {
> - authmode =3D WPA_IE_ID;
> - uncst_oui[0] =3D 0x0;
> - uncst_oui[1] =3D 0x50;
> - uncst_oui[2] =3D 0xf2;
> - }
> - if ((ndisauthmode =3D=3D Ndis802_11AuthModeWPA2) ||
> - (ndisauthmode =3D=3D Ndis802_11AuthModeWPA2PSK)) {
> - authmode =3D WPA2_IE_ID;
> - uncst_oui[0] =3D 0x0;
> - uncst_oui[1] =3D 0x0f;
> - uncst_oui[2] =3D 0xac;
> - }
> - switch (ndissecuritytype) {
> - case Ndis802_11Encryption1Enabled:
> - case Ndis802_11Encryption1KeyAbsent:
> - uncst_oui[3] =3D 0x1;
> - break;
> - case Ndis802_11Encryption2Enabled:
> - case Ndis802_11Encryption2KeyAbsent:
> - uncst_oui[3] =3D 0x2;
> - break;
> - case Ndis802_11Encryption3Enabled:
> - case Ndis802_11Encryption3KeyAbsent:
> - uncst_oui[3] =3D 0x4;
> - break;
> - default:
> - break;
> - }
> - /*Search required WPA or WPA2 IE and copy to sec_ie[] */
> - cnt =3D 12;
> - match =3D false;
> - while (cnt < in_len) {
> - if (in_ie[cnt] =3D=3D authmode) {
> - if ((authmode =3D=3D WPA_IE_ID) &&
> - (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) {
> - memcpy(&sec_ie[0], &in_ie[cnt],
> - in_ie[cnt + 1] + 2);
> - match =3D true;
> - break;
> - }
> - if (authmode =3D=3D WPA2_IE_ID) {
> - memcpy(&sec_ie[0], &in_ie[cnt],
> - in_ie[cnt + 1] + 2);
> - match =3D true;
> - break;
> - }
> - if (((authmode =3D=3D WPA_IE_ID) &&
> - (!memcmp(&in_ie[cnt + 2], &wpa_oui[0], 4))) ||
> - (authmode =3D=3D WPA2_IE_ID))
> - memcpy(&bkup_ie[0], &in_ie[cnt],
> - in_ie[cnt + 1] + 2);
> - }
> - cnt +=3D in_ie[cnt + 1] + 2; /get next/
> - }
> - /*restruct WPA IE or WPA2 IE in sec_ie[] /
> - if (match) {
> - if (sec_ie[0] =3D=3D WPA_IE_ID) {
> - / parsing SSN IE to select required encryption
> - * algorithm, and set the bc/mc encryption algorithm
> - /
> - while (true) {
> - /check wpa_oui tag/
> - if (memcmp(&sec_ie[2], &wpa_oui[0], 4)) {
> - match =3D false;
> - break;
> - }
> - if ((sec_ie[6] !=3D 0x01) || (sec_ie[7] !=3D 0x0)) {
> - /IE Ver error/
> - match =3D false;
> - break;
> - }
> - if (!memcmp(&sec_ie[8], &wpa_oui[0], 3)) {
> - / get bc/mc encryption type (group
> - * key type)
> - */
> - switch (sec_ie[11]) {
> - case 0x0: /none/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - NO_PRIVACY;
> - break;
> - case 0x1: /WEP_40/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - WEP40;
> - break;
> - case 0x2: /TKIP/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - TKIP;
> - break;
> - case 0x3: /AESCCMP/
> - case 0x4:
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - AES;
> - break;
> - case 0x5: /WEP_104/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - WEP104;
> - break;
> - }
> - } else {
> - match =3D false;
> - break;
> - }
> - if (sec_ie[12] =3D=3D 0x01) {
> - /check the unicast encryption type/
> - if (memcmp(&sec_ie[14],
> - &uncst_oui[0], 4)) {
> - match =3D false;
> - break;
> -
> - } /else the uncst_oui is match/
> - } else { /mixed mode, unicast_enc_type > 1/
>=20
> - /*select the uncst_oui and remove
> - * the other uncst_oui
> - /
> - cnt =3D sec_ie[12];
> - remove_cnt =3D (cnt - 1) * 4;
> - sec_ie[12] =3D 0x01;
> - memcpy(&sec_ie[14], &uncst_oui[0], 4);
> - /remove the other unicast suit/
> - memcpy(&sec_ie[18],
> - &sec_ie[18 + remove_cnt],
> - sec_ie[1] - 18 + 2 -
> - remove_cnt);
> - sec_ie[1] =3D sec_ie[1] - remove_cnt;
> - }
> - break;
> - }
> - }
> - if (authmode =3D=3D WPA2_IE_ID) {
> - / parsing RSN IE to select required encryption
> - * algorithm, and set the bc/mc encryption algorithm
> - */
> - while (true) {
> - if ((sec_ie[2] !=3D 0x01) || (sec_ie[3] !=3D 0x0)) {
> - /IE Ver error/
> - match =3D false;
> - break;
> - }
> - if (!memcmp(&sec_ie[4], &uncst_oui[0], 3)) {
> - /get bc/mc encryption type/
> - switch (sec_ie[7]) {
> - case 0x1: /WEP_40/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - WEP40;
> - break;
> - case 0x2: /TKIP/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - TKIP;
> - break;
> - case 0x4: /AESWRAP/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - AES;
> - break;
> - case 0x5: /WEP_104/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - WEP104;
> - break;
> - default: /one/
> - psecuritypriv->XGrpPrivacy =3D
>=20
> - NO_PRIVACY;
> - break;
> - }
> - } else {
> - match =3D false;
> - break;
> - }
> - if (sec_ie[8] =3D=3D 0x01) {
> - /check the unicast encryption type/
> - if (memcmp(&sec_ie[10],
> - &uncst_oui[0], 4)) {
> - match =3D false;
> - break;
> - } /else the uncst_oui is match/
> - } else { /mixed mode, unicast_enc_type > 1/
>=20
> - /*select the uncst_oui and remove the
> - * other uncst_oui
> - */
> - cnt =3D sec_ie[8];
> - remove_cnt =3D (cnt - 1) * 4;
> - sec_ie[8] =3D 0x01;
> - memcpy(&sec_ie[10], &uncst_oui[0], 4);
> - /remove the other unicast suit/
> - memcpy(&sec_ie[14],
> - &sec_ie[14 + remove_cnt],
> - (sec_ie[1] - 14 + 2 -
> - remove_cnt));
> - sec_ie[1] =3D sec_ie[1] - remove_cnt;
> - }
> - break;
> - }
> - }
> - }
> - if ((authmode =3D=3D WPA_IE_ID) || (authmode =3D=3D WPA2_IE_ID)) {
> - /copy fixed ie/
> - memcpy(out_ie, in_ie, 12);
> - ielength =3D 12;
> - /copy RSN or SSN/
> - if (match) {
> - memcpy(&out_ie[ielength], &sec_ie[0], sec_ie[1] + 2);
> - ielength +=3D sec_ie[1] + 2;
> - if (authmode =3D=3D WPA2_IE_ID) {
> - /the Pre-Authentication bit should be zero/
> - out_ie[ielength - 1] =3D 0;
> - out_ie[ielength - 2] =3D 0;
> - }
> - r8712_report_sec_ie(adapter, authmode, sec_ie);
> - }
> - } else {
> - /copy fixed ie only/
> - memcpy(out_ie, in_ie, 12);
> - ielength =3D 12;
> - if (psecuritypriv->wps_phase) {
>=20
> - memcpy(out_ie + ielength, psecuritypriv->wps_ie,
>=20
> - psecuritypriv->wps_ie_len);
>=20
> - ielength +=3D psecuritypriv->wps_ie_len;
>=20
> - }
> - }
> - iEntry =3D SecIsInPMKIDList(adapter, pmlmepriv->assoc_bssid);
>=20
> - if (iEntry < 0)
> - return ielength;
> - if (authmode =3D=3D WPA2_IE_ID) {
> - out_ie[ielength] =3D 1;
> - ielength++;
> - out_ie[ielength] =3D 0; /PMKID count =3D 0x0100/
> - ielength++;
> - memcpy(&out_ie[ielength],
> - &psecuritypriv->PMKIDList[iEntry].PMKID, 16);
>=20
> - ielength +=3D 16;
> - out_ie[13] +=3D 18;/PMKID length =3D 2+16/
> - }
> - return ielength;
> -}
> -
> -void r8712_init_registrypriv_dev_network(struct _adapter *adapter)
> -{
> - struct registry_priv *pregistrypriv =3D &adapter->registrypriv;
>=20
> - struct eeprom_priv *peepriv =3D &adapter->eeprompriv;
>=20
> - struct wlan_bssid_ex *pdev_network =3D &pregistrypriv->dev_network;
>=20
> - u8 *myhwaddr =3D myid(peepriv);
> -
> - memcpy(pdev_network->MacAddress, myhwaddr, ETH_ALEN);
>=20
> - memcpy(&pdev_network->Ssid, &pregistrypriv->ssid,
>=20
> - sizeof(struct ndis_802_11_ssid));
> - pdev_network->Configuration.Length =3D
>=20
> - sizeof(struct NDIS_802_11_CONFIGURATION);
> - pdev_network->Configuration.BeaconPeriod =3D 100;
>=20
> - pdev_network->Configuration.FHConfig.Length =3D 0;
>=20
> - pdev_network->Configuration.FHConfig.HopPattern =3D 0;
>=20
> - pdev_network->Configuration.FHConfig.HopSet =3D 0;
>=20
> - pdev_network->Configuration.FHConfig.DwellTime =3D 0;
>=20
> -}
> -
> -void r8712_update_registrypriv_dev_network(struct _adapter *adapter)
> -{
> - int sz =3D 0;
> - struct registry_priv *pregistrypriv =3D &adapter->registrypriv;
>=20
> - struct wlan_bssid_ex *pdev_network =3D &pregistrypriv->dev_network;
>=20
> - struct security_priv *psecuritypriv =3D &adapter->securitypriv;
>=20
> - struct wlan_network *cur_network =3D &adapter->mlmepriv.cur_network;
>=20
> -
> - pdev_network->Privacy =3D cpu_to_le32(psecuritypriv->privacy_algorithm
>=20
> - > 0 ? 1 : 0); /* adhoc no 802.1x */
>=20
> - pdev_network->Rssi =3D 0;
>=20
> - switch (pregistrypriv->wireless_mode) {
>=20
> - case WIRELESS_11B:
> - pdev_network->NetworkTypeInUse =3D Ndis802_11DS;
>=20
> - break;
> - case WIRELESS_11G:
> - case WIRELESS_11BG:
> - pdev_network->NetworkTypeInUse =3D Ndis802_11OFDM24;
>=20
> - break;
> - case WIRELESS_11A:
> - pdev_network->NetworkTypeInUse =3D Ndis802_11OFDM5;
>=20
> - break;
> - default:
> - /* TODO */
> - break;
> - }
> - pdev_network->Configuration.DSConfig =3D pregistrypriv->channel;
>=20
> - if (cur_network->network.InfrastructureMode =3D=3D Ndis802_11IBSS)
>=20
> - pdev_network->Configuration.ATIMWindow =3D 3;
>=20
> - pdev_network->InfrastructureMode =3D cur_network->network.Infrastructur=
eMode;
>=20
> - /* 1. Supported rates
> - * 2. IE
> - */
> - sz =3D r8712_generate_ie(pregistrypriv);
> - pdev_network->IELength =3D sz;
>=20
> - pdev_network->Length =3D r8712_get_wlan_bssid_ex_sz(pdev_network);
>=20
> -}
> -
> -/the function is at passive_level/
> -void r8712_joinbss_reset(struct _adapter *padapter)
> -{
> - int i;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct ht_priv *phtpriv =3D &pmlmepriv->htpriv;
>=20
> -
> - /* todo: if you want to do something io/reg/hw setting before join_bss,
> - * please add code here
> - */
> - phtpriv->ampdu_enable =3D false;/reset to disabled/
>=20
> - for (i =3D 0; i < 16; i++)
> - phtpriv->baddbareq_issued[i] =3D false;/reset it/
>=20
> - if (phtpriv->ht_option) {
>=20
> - /* validate usb rx aggregation /
> - r8712_write8(padapter, 0x102500D9, 48);/TH =3D 48 pages, 6k/
> - } else {
> - / invalidate usb rx aggregation /
> - / TH=3D1 =3D> means that invalidate usb rx aggregation */
>=20
> - r8712_write8(padapter, 0x102500D9, 1);
> - }
> -}
> -
> -/the function is >=3D passive_level/
>=20
> -unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_i=
e,
> - u8 *out_ie, uint in_len, uint *pout_len)
> -{
> - u32 ielen, out_len;
> - unsigned char *p;
> - struct ieee80211_ht_cap ht_capie;
> - unsigned char WMM_IE[] =3D {0x00, 0x50, 0xf2, 0x02, 0x00, 0x01, 0x00};
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct qos_priv *pqospriv =3D &pmlmepriv->qospriv;
>=20
> - struct ht_priv *phtpriv =3D &pmlmepriv->htpriv;
>=20
> -
> - phtpriv->ht_option =3D 0;
>=20
> - p =3D r8712_get_ie(in_ie + 12, WLAN_EID_HT_CAPABILITY, &ielen, in_len -=
 12);
> - if (p && (ielen > 0)) {
>=20
> - if (pqospriv->qos_option =3D=3D 0) {
>=20
> - out_len =3D *pout_len;
> - r8712_set_ie(out_ie + out_len, WLAN_EID_VENDOR_SPECIFIC,
> - WMM_IE_Length, WMM_IE, pout_len);
> - pqospriv->qos_option =3D 1;
>=20
> - }
> - out_len =3D *pout_len;
> - memset(&ht_capie, 0, sizeof(struct ieee80211_ht_cap));
> - ht_capie.cap_info =3D cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
> - IEEE80211_HT_CAP_SGI_20 |
> - IEEE80211_HT_CAP_SGI_40 |
> - IEEE80211_HT_CAP_TX_STBC |
> - IEEE80211_HT_CAP_MAX_AMSDU |
> - IEEE80211_HT_CAP_DSSSCCK40);
> - ht_capie.ampdu_params_info =3D (IEEE80211_HT_AMPDU_PARM_FACTOR &
> - 0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
> - r8712_set_ie(out_ie + out_len, WLAN_EID_HT_CAPABILITY,
> - sizeof(struct ieee80211_ht_cap),
> - (unsigned char *)&ht_capie, pout_len);
> - phtpriv->ht_option =3D 1;
>=20
> - }
> - return phtpriv->ht_option;
>=20
> -}
> -
> -/* the function is > passive_level (in critical_section) */
>=20
> -static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_le=
n)
> -{
> - u8 *p, max_ampdu_sz;
> - int i;
> - uint len;
> - struct sta_info *bmc_sta, *psta;
> - struct ieee80211_ht_cap *pht_capie;
> - struct recv_reorder_ctrl *preorder_ctrl;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct ht_priv *phtpriv =3D &pmlmepriv->htpriv;
>=20
> - struct registry_priv *pregistrypriv =3D &padapter->registrypriv;
>=20
> - struct wlan_network *pcur_network =3D &pmlmepriv->cur_network;
>=20
> -
> - if (!phtpriv->ht_option)
>=20
> - return;
> - /* maybe needs check if ap supports rx ampdu. */
> - if (!phtpriv->ampdu_enable &&
>=20
> - (pregistrypriv->ampdu_enable =3D=3D 1))
>=20
> - phtpriv->ampdu_enable =3D true;
>=20
> - /check Max Rx A-MPDU Size/
> - len =3D 0;
> - p =3D r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
> - WLAN_EID_HT_CAPABILITY,
> - &len, ie_len -
> - sizeof(struct NDIS_802_11_FIXED_IEs));
> - if (p && len > 0) {
>=20
> - pht_capie =3D (struct ieee80211_ht_cap *)(p + 2);
> - max_ampdu_sz =3D (pht_capie->ampdu_params_info &
>=20
> - IEEE80211_HT_AMPDU_PARM_FACTOR);
> - /* max_ampdu_sz (kbytes); */
> - max_ampdu_sz =3D 1 << (max_ampdu_sz + 3);
> - phtpriv->rx_ampdu_maxlen =3D max_ampdu_sz;
>=20
> - }
> - /* for A-MPDU Rx reordering buffer control for bmc_sta & sta_info
> - * if A-MPDU Rx is enabled, resetting rx_ordering_ctrl
> - * wstart_b(indicate_seq) to default value=3D0xffff
> - * todo: check if AP can send A-MPDU packets
> - */
> - bmc_sta =3D r8712_get_bcmc_stainfo(padapter);
> - if (bmc_sta) {
> - for (i =3D 0; i < 16; i++) {
> - preorder_ctrl =3D &bmc_sta->recvreorder_ctrl[i];
>=20
> - preorder_ctrl->indicate_seq =3D 0xffff;
>=20
> - preorder_ctrl->wend_b =3D 0xffff;
>=20
> - }
> - }
> - psta =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - pcur_network->network.MacAddress);
>=20
> - if (psta) {
> - for (i =3D 0; i < 16; i++) {
> - preorder_ctrl =3D &psta->recvreorder_ctrl[i];
>=20
> - preorder_ctrl->indicate_seq =3D 0xffff;
>=20
> - preorder_ctrl->wend_b =3D 0xffff;
>=20
> - }
> - }
> - len =3D 0;
> - p =3D r8712_get_ie(pie + sizeof(struct NDIS_802_11_FIXED_IEs),
> - WLAN_EID_HT_OPERATION, &len,
> - ie_len - sizeof(struct NDIS_802_11_FIXED_IEs));
> -}
> -
> -void r8712_issue_addbareq_cmd(struct _adapter *padapter, int priority)
> -{
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct ht_priv *phtpriv =3D &pmlmepriv->htpriv;
>=20
> -
> - if ((phtpriv->ht_option =3D=3D 1) && (phtpriv->ampdu_enable)) {
>=20
> - if (!phtpriv->baddbareq_issued[priority]) {
>=20
> - r8712_addbareq_cmd(padapter, (u8)priority);
> - phtpriv->baddbareq_issued[priority] =3D true;
>=20
> - }
> - }
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_mlme.h b/drivers/staging/rtl=
8712/rtl871x_mlme.h
> deleted file mode 100644
> index d7d25f240111..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_mlme.h
> +++ /dev/null
> @@ -1,205 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
/
> -#ifndef _RTL871X_MLME_H
> -#define _RTL871X_MLME_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "wlan_bssdef.h"
> -
> -#define MAX_BSS_CNT 64
> -#define MAX_JOIN_TIMEOUT 6000
> -
> -#define SCANNING_TIMEOUT 4500
> -
> -#define SCANQUEUE_LIFETIME 20 / unit:sec /
> -
> -#define WIFI_NULL_STATE 0x00000000
> -#define WIFI_ASOC_STATE 0x00000001 / Under Linked state.../
> -#define WIFI_REASOC_STATE 0x00000002
> -#define WIFI_SLEEP_STATE 0x00000004
> -#define WIFI_STATION_STATE 0x00000008
> -#define WIFI_AP_STATE 0x00000010
> -#define WIFI_ADHOC_STATE 0x00000020
> -#define WIFI_ADHOC_MASTER_STATE 0x00000040
> -#define WIFI_UNDER_LINKING 0x00000080
> -#define WIFI_SITE_MONITOR 0x00000800 / to indicate the station
> - * is under site surveying
> - /
> -#define WIFI_MP_STATE 0x00010000
> -#define WIFI_MP_CTX_BACKGROUND 0x00020000 / in cont. tx background/
> -#define WIFI_MP_CTX_ST 0x00040000 / in cont. tx with
> - * single-tone
> - /
> -#define WIFI_MP_CTX_BACKGROUND_PENDING 0x00080000 / pending in cont, tx
> - * background due
> - * to out of skb
> - /
> -#define WIFI_MP_CTX_CCK_HW 0x00100000 / in continuous tx/
> -#define WIFI_MP_CTX_CCK_CS 0x00200000 / in cont, tx with carrier
> - * suppression
> - /
> -#define WIFI_MP_LPBK_STATE 0x00400000
> -
> -#define _FW_UNDER_LINKING WIFI_UNDER_LINKING
> -#define _FW_LINKED WIFI_ASOC_STATE
> -#define _FW_UNDER_SURVEY WIFI_SITE_MONITOR
> -
> -/
> - * there are several "locks" in mlme_priv,
> - * since mlme_priv is a shared resource between many threads,
> - * like ISR/Call-Back functions, the OID handlers, and even timer functi=
ons.
> - * Each _queue has its own locks, already.
> - * Other items are protected by mlme_priv.lock.
> - * To avoid possible dead lock, any thread trying to modify mlme_priv
> - * SHALL not lock up more than one lock at a time!
> - */
> -
> -#define traffic_threshold 10
> -#define traffic_scan_period 500
> -
> -struct sitesurvey_ctrl {
> - u64 last_tx_pkts;
> - uint last_rx_pkts;
> - sint traffic_busy;
> - struct timer_list sitesurvey_ctrl_timer;
> -};
> -
> -struct mlme_priv {
> - spinlock_t lock;
> - spinlock_t lock2;
> - sint fw_state; /*shall we protect this variable? */
> - u8 to_join; /flag/
> - u8 *nic_hdl;
> - struct list_head pscanned;
> - struct __queue free_bss_pool;
> - struct __queue scanned_queue;
> - u8 free_bss_buf;
> - unsigned long num_of_scanned;
> - u8 passive_mode; /add for Android's SCAN-ACTIVE/SCAN-PASSIVE /
> - struct ndis_802_11_ssid assoc_ssid;
> - u8 assoc_bssid[6];
> - struct wlan_network cur_network;
> - struct sitesurvey_ctrl sitesurveyctrl;
> - struct timer_list assoc_timer;
> - uint assoc_by_bssid;
> - uint assoc_by_rssi;
> - struct timer_list scan_to_timer; / driver handles scan_timeout./
> - struct timer_list dhcp_timer; / set dhcp to if driver in ps mode./
> - struct qos_priv qospriv;
> - struct ht_priv htpriv;
> - struct timer_list wdg_timer; /watchdog periodic timer/
> -};
> -
> -static inline u8 *get_bssid(struct mlme_priv *pmlmepriv)
> -{
> - return pmlmepriv->cur_network.network.MacAddress;
>=20
> -}
> -
> -static inline u8 check_fwstate(struct mlme_priv *pmlmepriv, sint state)
> -{
> - if (pmlmepriv->fw_state & state)
>=20
> - return true;
> - return false;
> -}
> -
> -static inline sint get_fwstate(struct mlme_priv *pmlmepriv)
> -{
> - return pmlmepriv->fw_state;
>=20
> -}
> -
> -/*
> - * No Limit on the calling context,
> - * therefore set it to be the critical section...
> - *
> - * ### NOTE:#### (!!!!)
> - * TAKE CARE BEFORE CALLING THIS FUNC, LOCK pmlmepriv->lock
>=20
> - */
> -static inline void set_fwstate(struct mlme_priv *pmlmepriv, sint state)
> -{
> - pmlmepriv->fw_state |=3D state;
>=20
> -}
> -
> -static inline void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
> -{
> - pmlmepriv->fw_state &=3D ~state;
>=20
> -}
> -
> -/*
> - * No Limit on the calling context,
> - * therefore set it to be the critical section...
> - */
> -static inline void clr_fwstate(struct mlme_priv *pmlmepriv, sint state)
> -{
> - unsigned long irqL;
> -
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, state))
> - pmlmepriv->fw_state ^=3D state;
>=20
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> -}
> -
> -static inline void set_scanned_network_val(struct mlme_priv *pmlmepriv,
> - sint val)
> -{
> - unsigned long irqL;
> -
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - pmlmepriv->num_of_scanned =3D val;
>=20
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> -}
> -
> -void r8712_survey_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_surveydone_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_joinbss_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_stassoc_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_stadel_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_atimdone_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_cpwm_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_wpspbc_event_callback(struct _adapter adapter, u8 pbuf);
> -void r8712_free_network_queue(struct _adapter adapter);
> -int r8712_init_mlme_priv(struct _adapter adapter);
> -void r8712_free_mlme_priv(struct mlme_priv pmlmepriv);
> -int r8712_select_and_join_from_scan(struct mlme_priv pmlmepriv);
> -int r8712_set_key(struct _adapter adapter,
> - struct security_priv psecuritypriv, sint keyid);
> -int r8712_set_auth(struct _adapter adapter,
> - struct security_priv psecuritypriv);
> -uint r8712_get_wlan_bssid_ex_sz(struct wlan_bssid_ex bss);
> -void r8712_generate_random_ibss(u8 pibss);
> -u8 r8712_get_capability_from_ie(u8 ie);
> -struct wlan_network r8712_get_oldest_wlan_network(
> - struct __queue scanned_queue);
> -void r8712_free_assoc_resources(struct _adapter adapter);
> -void r8712_ind_disconnect(struct _adapter adapter);
> -void r8712_indicate_connect(struct _adapter adapter);
> -int r8712_restruct_sec_ie(struct _adapter adapter, u8 in_ie,
> - u8 out_ie, uint in_len);
> -int r8712_restruct_wmm_ie(struct _adapter adapter, u8 in_ie,
> - u8 out_ie, uint in_len, uint initial_out_len);
> -void r8712_init_registrypriv_dev_network(struct _adapter adapter);
> -void r8712_update_registrypriv_dev_network(struct _adapter adapter);
> -void _r8712_sitesurvey_ctrl_handler(struct _adapter adapter);
> -void _r8712_join_timeout_handler(struct _adapter adapter);
> -void r8712_scan_timeout_handler(struct _adapter adapter);
> -void _r8712_dhcp_timeout_handler(struct _adapter adapter);
> -struct wlan_network _r8712_alloc_network(struct mlme_priv pmlmepriv);
> -sint r8712_if_up(struct _adapter padapter);
> -void r8712_joinbss_reset(struct _adapter padapter);
> -unsigned int r8712_restructure_ht_ie(struct _adapter padapter, u8 in_ie,
> - u8 out_ie, uint in_len, uint pout_len);
> -void r8712_issue_addbareq_cmd(struct _adapter padapter, int priority);
> -int r8712_is_same_ibss(struct _adapter adapter, struct wlan_network pnet=
work);
> -
> -#endif /_RTL871X_MLME_H/
> diff --git a/drivers/staging/rtl8712/rtl871x_mp.c b/drivers/staging/rtl87=
12/rtl871x_mp.c
> deleted file mode 100644
> index c6bc7b546166..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_mp.c
> +++ /dev/null
> @@ -1,724 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#define RTL871X_MP_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "rtl871x_mp_phy_regdef.h"
> -#include "rtl8712_cmd.h"
> -
> -static void init_mp_priv(struct mp_priv *pmp_priv)
> -{
> - pmp_priv->mode =3D LOOPBOOK_MODE;
>=20
> - pmp_priv->curr_ch =3D 1;
>=20
> - pmp_priv->curr_modem =3D MIXED_PHY;
>=20
> - pmp_priv->curr_rateidx =3D 0;
>=20
> - pmp_priv->curr_txpoweridx =3D 0x14;
>=20
> - pmp_priv->antenna_tx =3D ANTENNA_A;
>=20
> - pmp_priv->antenna_rx =3D ANTENNA_AB;
>=20
> - pmp_priv->check_mp_pkt =3D 0;
>=20
> - pmp_priv->tx_pktcount =3D 0;
>=20
> - pmp_priv->rx_pktcount =3D 0;
>=20
> - pmp_priv->rx_crcerrpktcount =3D 0;
>=20
> -}
> -
> -static int init_mp_priv(struct mp_priv *pmp_priv)
> -{
> - int i;
> - struct mp_xmit_frame *pmp_xmitframe;
> -
> - init_mp_priv(pmp_priv);
> - _init_queue(&pmp_priv->free_mp_xmitqueue);
>=20
> - pmp_priv->pallocated_mp_xmitframe_buf =3D NULL;
>=20
> - pmp_priv->pallocated_mp_xmitframe_buf =3D kmalloc(NR_MP_XMITFRAME *
>=20
> - sizeof(struct mp_xmit_frame) + 4,
> - GFP_ATOMIC);
> - if (!pmp_priv->pallocated_mp_xmitframe_buf)
>=20
> - return -ENOMEM;
> -
> - pmp_priv->pmp_xmtframe_buf =3D pmp_priv->pallocated_mp_xmitframe_buf +
>=20
> - 4 -
> - ((addr_t)(pmp_priv->pallocated_mp_xmitframe_buf) & 3);
>=20
> - pmp_xmitframe =3D (struct mp_xmit_frame *)pmp_priv->pmp_xmtframe_buf;
>=20
> - for (i =3D 0; i < NR_MP_XMITFRAME; i++) {
> - INIT_LIST_HEAD(&pmp_xmitframe->list);
>=20
> - list_add_tail(&pmp_xmitframe->list,
>=20
> - &pmp_priv->free_mp_xmitqueue.queue);
>=20
> - pmp_xmitframe->pkt =3D NULL;
>=20
> - pmp_xmitframe->frame_tag =3D MP_FRAMETAG;
>=20
> - pmp_xmitframe->padapter =3D pmp_priv->papdater;
>=20
> - pmp_xmitframe++;
> - }
> - pmp_priv->free_mp_xmitframe_cnt =3D NR_MP_XMITFRAME;
>=20
> - return 0;
> -}
> -
> -static int free_mp_priv(struct mp_priv *pmp_priv)
> -{
> - kfree(pmp_priv->pallocated_mp_xmitframe_buf);
>=20
> - return 0;
> -}
> -
> -void mp871xinit(struct _adapter *padapter)
> -{
> - struct mp_priv *pmppriv =3D &padapter->mppriv;
>=20
> -
> - pmppriv->papdater =3D padapter;
>=20
> - init_mp_priv(pmppriv);
> -}
> -
> -void mp871xdeinit(struct _adapter *padapter)
> -{
> - struct mp_priv *pmppriv =3D &padapter->mppriv;
>=20
> -
> - free_mp_priv(pmppriv);
> -}
> -
> -/*
> - * Special for bb and rf reg read/write
> - */
> -static u32 fw_iocmd_read(struct _adapter *pAdapter, struct IOCMD_STRUCT =
iocmd)
> -{
> - u32 cmd32 =3D 0, val32 =3D 0;
> - u8 iocmd_class =3D iocmd.cmdclass;
> - u16 iocmd_value =3D iocmd.value;
> - u8 iocmd_idx =3D iocmd.index;
> -
> - cmd32 =3D (iocmd_class << 24) | (iocmd_value << 8) | iocmd_idx;
> - if (r8712_fw_cmd(pAdapter, cmd32))
> - r8712_fw_cmd_data(pAdapter, &val32, 1);
> - else
> - val32 =3D 0;
> - return val32;
> -}
> -
> -static u8 fw_iocmd_write(struct _adapter pAdapter,
> - struct IOCMD_STRUCT iocmd, u32 value)
> -{
> - u32 cmd32 =3D 0;
> - u8 iocmd_class =3D iocmd.cmdclass;
> - u32 iocmd_value =3D iocmd.value;
> - u8 iocmd_idx =3D iocmd.index;
> -
> - r8712_fw_cmd_data(pAdapter, &value, 0);
> - msleep(100);
> - cmd32 =3D (iocmd_class << 24) | (iocmd_value << 8) | iocmd_idx;
> - return r8712_fw_cmd(pAdapter, cmd32);
> -}
> -
> -/ offset : 0X800~0XFFF */
> -u32 r8712_bb_reg_read(struct _adapter pAdapter, u16 offset)
> -{
> - u8 shift =3D offset & 0x0003; / 4 byte access /
> - u16 bb_addr =3D offset & 0x0FFC; / 4 byte access */
> - u32 bb_val =3D 0;
> - struct IOCMD_STRUCT iocmd;
> -
> - iocmd.cmdclass =3D IOCMD_CLASS_BB_RF;
> - iocmd.value =3D bb_addr;
> - iocmd.index =3D IOCMD_BB_READ_IDX;
> - bb_val =3D fw_iocmd_read(pAdapter, iocmd);
> - if (shift !=3D 0) {
> - u32 bb_val2 =3D 0;
> -
> - bb_val >>=3D (shift * 8);
>=20
> - iocmd.value +=3D 4;
> - bb_val2 =3D fw_iocmd_read(pAdapter, iocmd);
> - bb_val2 <<=3D ((4 - shift) * 8);
> - bb_val |=3D bb_val2;
> - }
> - return bb_val;
> -}
> -
> -/* offset : 0X800~0XFFF */
> -u8 r8712_bb_reg_write(struct _adapter pAdapter, u16 offset, u32 value)
> -{
> - u8 shift =3D offset & 0x0003; / 4 byte access /
> - u16 bb_addr =3D offset & 0x0FFC; / 4 byte access */
> - struct IOCMD_STRUCT iocmd;
> -
> - iocmd.cmdclass =3D IOCMD_CLASS_BB_RF;
> - iocmd.value =3D bb_addr;
> - iocmd.index =3D IOCMD_BB_WRITE_IDX;
> - if (shift !=3D 0) {
> - u32 oldValue =3D 0;
> - u32 newValue =3D value;
> -
> - oldValue =3D r8712_bb_reg_read(pAdapter, iocmd.value);
> - oldValue &=3D (0xFFFFFFFF >> ((4 - shift) * 8));
>=20
> - value =3D oldValue | (newValue << (shift * 8));
> - if (!fw_iocmd_write(pAdapter, iocmd, value))
> - return false;
> - iocmd.value +=3D 4;
> - oldValue =3D r8712_bb_reg_read(pAdapter, iocmd.value);
> - oldValue &=3D (0xFFFFFFFF << (shift * 8));
> - value =3D oldValue | (newValue >> ((4 - shift) * 8));
>=20
> - }
> - return fw_iocmd_write(pAdapter, iocmd, value);
> -}
> -
> -/* offset : 0x00 ~ 0xFF */
> -u32 r8712_rf_reg_read(struct _adapter *pAdapter, u8 path, u8 offset)
> -{
> - u16 rf_addr =3D (path << 8) | offset;
> - struct IOCMD_STRUCT iocmd;
> -
> - iocmd.cmdclass =3D IOCMD_CLASS_BB_RF;
> - iocmd.value =3D rf_addr;
> - iocmd.index =3D IOCMD_RF_READ_IDX;
> - return fw_iocmd_read(pAdapter, iocmd);
> -}
> -
> -u8 r8712_rf_reg_write(struct _adapter *pAdapter, u8 path, u8 offset, u32=
 value)
> -{
> - u16 rf_addr =3D (path << 8) | offset;
> - struct IOCMD_STRUCT iocmd;
> -
> - iocmd.cmdclass =3D IOCMD_CLASS_BB_RF;
> - iocmd.value =3D rf_addr;
> - iocmd.index =3D IOCMD_RF_WRIT_IDX;
> - return fw_iocmd_write(pAdapter, iocmd, value);
> -}
> -
> -static u32 bitshift(u32 bitmask)
> -{
> - u32 i;
> -
> - for (i =3D 0; i <=3D 31; i++)
> - if (((bitmask >> i) & 0x1) =3D=3D 1)
>=20
> - break;
> - return i;
> -}
> -
> -static u32 get_bb_reg(struct _adapter *pAdapter, u16 offset, u32 bitmask=
)
> -{
> - u32 org_value, bit_shift;
> -
> - org_value =3D r8712_bb_reg_read(pAdapter, offset);
> - bit_shift =3D bitshift(bitmask);
> - return (org_value & bitmask) >> bit_shift;
>=20
> -}
> -
> -static u8 set_bb_reg(struct _adapter *pAdapter,
> - u16 offset,
> - u32 bitmask,
> - u32 value)
> -{
> - u32 org_value, bit_shift, new_value;
> -
> - if (bitmask !=3D bMaskDWord) {
> - org_value =3D r8712_bb_reg_read(pAdapter, offset);
> - bit_shift =3D bitshift(bitmask);
> - new_value =3D (org_value & (~bitmask)) | (value << bit_shift);
> - } else {
> - new_value =3D value;
> - }
> - return r8712_bb_reg_write(pAdapter, offset, new_value);
> -}
> -
> -static u32 get_rf_reg(struct _adapter *pAdapter, u8 path, u8 offset,
> - u32 bitmask)
> -{
> - u32 org_value, bit_shift;
> -
> - org_value =3D r8712_rf_reg_read(pAdapter, path, offset);
> - bit_shift =3D bitshift(bitmask);
> - return (org_value & bitmask) >> bit_shift;
>=20
> -}
> -
> -static u8 set_rf_reg(struct _adapter pAdapter, u8 path, u8 offset, u32 b=
itmask,
> - u32 value)
> -{
> - u32 org_value, bit_shift, new_value;
> -
> - if (bitmask !=3D bMaskDWord) {
> - org_value =3D r8712_rf_reg_read(pAdapter, path, offset);
> - bit_shift =3D bitshift(bitmask);
> - new_value =3D (org_value & (~bitmask)) | (value << bit_shift);
> - } else {
> - new_value =3D value;
> - }
> - return r8712_rf_reg_write(pAdapter, path, offset, new_value);
> -}
> -
> -/
> - * SetChannel
> - * Description
> - * Use H2C command to change channel,
> - * not only modify rf register, but also other setting need to be done.
> - */
> -void r8712_SetChannel(struct _adapter *pAdapter)
> -{
> - struct cmd_priv *pcmdpriv =3D &pAdapter->cmdpriv;
>=20
> - struct cmd_obj *pcmd =3D NULL;
> - struct SetChannel_parm *pparm =3D NULL;
> - u16 code =3D GEN_CMD_CODE(_SetChannel);
> -
> - pcmd =3D kmalloc(sizeof(*pcmd), GFP_ATOMIC);
> - if (!pcmd)
> - return;
> - pparm =3D kmalloc(sizeof(*pparm), GFP_ATOMIC);
> - if (!pparm) {
> - kfree(pcmd);
> - return;
> - }
> - pparm->curr_ch =3D pAdapter->mppriv.curr_ch;
>=20
> - init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code);
> - r8712_enqueue_cmd(pcmdpriv, pcmd);
> -}
> -
> -static void SetCCKTxPower(struct _adapter *pAdapter, u8 TxPower)
> -{
> - u16 TxAGC =3D 0;
> -
> - TxAGC =3D TxPower;
> - set_bb_reg(pAdapter, rTxAGC_CCK_Mcs32, bTxAGCRateCCK, TxAGC);
> -}
> -
> -static void SetOFDMTxPower(struct _adapter *pAdapter, u8 TxPower)
> -{
> - u32 TxAGC =3D 0;
> -
> - TxAGC |=3D ((TxPower << 24) | (TxPower << 16) | (TxPower << 8) |
> - TxPower);
> - set_bb_reg(pAdapter, rTxAGC_Rate18_06, bTxAGCRate18_06, TxAGC);
> - set_bb_reg(pAdapter, rTxAGC_Rate54_24, bTxAGCRate54_24, TxAGC);
> - set_bb_reg(pAdapter, rTxAGC_Mcs03_Mcs00, bTxAGCRateMCS3_MCS0, TxAGC);
> - set_bb_reg(pAdapter, rTxAGC_Mcs07_Mcs04, bTxAGCRateMCS7_MCS4, TxAGC);
> - set_bb_reg(pAdapter, rTxAGC_Mcs11_Mcs08, bTxAGCRateMCS11_MCS8, TxAGC);
> - set_bb_reg(pAdapter, rTxAGC_Mcs15_Mcs12, bTxAGCRateMCS15_MCS12, TxAGC);
> -}
> -
> -void r8712_SetTxPower(struct _adapter *pAdapter)
> -{
> - u8 TxPower =3D pAdapter->mppriv.curr_txpoweridx;
>=20
> -
> - SetCCKTxPower(pAdapter, TxPower);
> - SetOFDMTxPower(pAdapter, TxPower);
> -}
> -
> -void r8712_SetTxAGCOffset(struct _adapter *pAdapter, u32 ulTxAGCOffset)
> -{
> - u32 TxAGCOffset_B, TxAGCOffset_C, TxAGCOffset_D, tmpAGC;
> -
> - TxAGCOffset_B =3D ulTxAGCOffset & 0x000000ff;
> - TxAGCOffset_C =3D (ulTxAGCOffset & 0x0000ff00) >> 8;
>=20
> - TxAGCOffset_D =3D (ulTxAGCOffset & 0x00ff0000) >> 16;
>=20
> - tmpAGC =3D TxAGCOffset_D << 8 | TxAGCOffset_C << 4 | TxAGCOffset_B;
> - set_bb_reg(pAdapter, rFPGA0_TxGainStage,
> - (bXBTxAGC | bXCTxAGC | bXDTxAGC), tmpAGC);
> -}
> -
> -void r8712_SetDataRate(struct _adapter *pAdapter)
> -{
> - u8 path =3D RF_PATH_A;
> - u8 offset =3D RF_SYN_G2;
> - u32 value;
> -
> - value =3D (pAdapter->mppriv.curr_rateidx < 4) ? 0x4440 : 0xF200;
>=20
> - r8712_rf_reg_write(pAdapter, path, offset, value);
> -}
> -
> -void r8712_SwitchBandwidth(struct _adapter pAdapter)
> -{
> - / 3 1.Set MAC register : BWOPMODE bit2:1 20MhzBW */
> - u8 regBwOpMode =3D 0;
> - u8 Bandwidth =3D pAdapter->mppriv.curr_bandwidth;
>=20
> -
> - regBwOpMode =3D r8712_read8(pAdapter, 0x10250203);
> - if (Bandwidth =3D=3D HT_CHANNEL_WIDTH_20)
> - regBwOpMode |=3D BIT(2);
> - else
> - regBwOpMode &=3D ~(BIT(2));
> - r8712_write8(pAdapter, 0x10250203, regBwOpMode);
> - /* 3 2.Set PHY related register /
> - switch (Bandwidth) {
> - / 20 MHz channel*/
> - case HT_CHANNEL_WIDTH_20:
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bRFMOD, 0x0);
> - set_bb_reg(pAdapter, rFPGA1_RFMOD, bRFMOD, 0x0);
> - /* Use PHY_REG.txt default value. Do not need to change.
> - * Correct the tx power for CCK rate in 40M.
> - * It is set in Tx descriptor for 8192x series
> - /
> - set_bb_reg(pAdapter, rFPGA0_AnalogParameter2, bMaskDWord, 0x58);
> - break;
> - / 40 MHz channel*/
> - case HT_CHANNEL_WIDTH_40:
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bRFMOD, 0x1);
> - set_bb_reg(pAdapter, rFPGA1_RFMOD, bRFMOD, 0x1);
> - /* Use PHY_REG.txt default value. Do not need to change.
> - * Correct the tx power for CCK rate in 40M.
> - * Set Control channel to upper or lower. These settings are
> - * required only for 40MHz
> - */
> - set_bb_reg(pAdapter, rCCK0_System, bCCKSideBand,
> - (HAL_PRIME_CHNL_OFFSET_DONT_CARE >> 1));
>=20
> - set_bb_reg(pAdapter, rOFDM1_LSTF, 0xC00,
> - HAL_PRIME_CHNL_OFFSET_DONT_CARE);
> - set_bb_reg(pAdapter, rFPGA0_AnalogParameter2, bMaskDWord, 0x18);
> - break;
> - default:
> - break;
> - }
> -
> - /* 3 3.Set RF related register /
> - switch (Bandwidth) {
> - case HT_CHANNEL_WIDTH_20:
> - set_rf_reg(pAdapter, RF_PATH_A, RF_CHNLBW,
> - BIT(10) | BIT(11), 0x01);
> - break;
> - case HT_CHANNEL_WIDTH_40:
> - set_rf_reg(pAdapter, RF_PATH_A, RF_CHNLBW,
> - BIT(10) | BIT(11), 0x00);
> - break;
> - default:
> - break;
> - }
> -}
> -
> -/------------------------------Define structure-------------------------=
---*/
> -struct R_ANTENNA_SELECT_OFDM {
> - u32 r_tx_antenna:4;
> - u32 r_ant_l:4;
> - u32 r_ant_non_ht:4;
> - u32 r_ant_ht1:4;
> - u32 r_ant_ht2:4;
> - u32 r_ant_ht_s1:4;
> - u32 r_ant_non_ht_s1:4;
> - u32 OFDM_TXSC:2;
> - u32 Reserved:2;
> -};
> -
> -struct R_ANTENNA_SELECT_CCK {
> - u8 r_cckrx_enable_2:2;
> - u8 r_cckrx_enable:2;
> - u8 r_ccktx_enable:4;
> -};
> -
> -void r8712_SwitchAntenna(struct _adapter *pAdapter)
> -{
> - u32 ofdm_tx_en_val =3D 0, ofdm_tx_ant_sel_val =3D 0;
> - u8 ofdm_rx_ant_sel_val =3D 0;
> - u8 cck_ant_select_val =3D 0;
> - u32 cck_ant_sel_val =3D 0;
> - struct R_ANTENNA_SELECT_CCK *p_cck_txrx;
> -
> - p_cck_txrx =3D (struct R_ANTENNA_SELECT_CCK *)&cck_ant_select_val;
> -
> - switch (pAdapter->mppriv.antenna_tx) {
>=20
> - case ANTENNA_A:
> - /* From SD3 Willis suggestion !!! Set RF A=3DTX and B as standby*/
> - set_bb_reg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 2);
> - set_bb_reg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 1);
> - ofdm_tx_en_val =3D 0x3;
> - ofdm_tx_ant_sel_val =3D 0x11111111;/* Power save */
> - p_cck_txrx->r_ccktx_enable =3D 0x8;
>=20
> - break;
> - case ANTENNA_B:
> - set_bb_reg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 1);
> - set_bb_reg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 2);
> - ofdm_tx_en_val =3D 0x3;
> - ofdm_tx_ant_sel_val =3D 0x22222222;/* Power save */
> - p_cck_txrx->r_ccktx_enable =3D 0x4;
>=20
> - break;
> - case ANTENNA_AB: /* For 8192S /
> - set_bb_reg(pAdapter, rFPGA0_XA_HSSIParameter2, 0xe, 2);
> - set_bb_reg(pAdapter, rFPGA0_XB_HSSIParameter2, 0xe, 2);
> - ofdm_tx_en_val =3D 0x3;
> - ofdm_tx_ant_sel_val =3D 0x3321333; / Disable Power save */
> - p_cck_txrx->r_ccktx_enable =3D 0xC;
>=20
> - break;
> - default:
> - break;
> - }
> - /OFDM Tx/
> - set_bb_reg(pAdapter, rFPGA1_TxInfo, 0xffffffff, ofdm_tx_ant_sel_val);
> - /OFDM Tx/
> - set_bb_reg(pAdapter, rFPGA0_TxInfo, 0x0000000f, ofdm_tx_en_val);
> - switch (pAdapter->mppriv.antenna_rx) {
>=20
> - case ANTENNA_A:
> - ofdm_rx_ant_sel_val =3D 0x1; /* A /
> - p_cck_txrx->r_cckrx_enable =3D 0x0; / default: A */
>=20
> - p_cck_txrx->r_cckrx_enable_2 =3D 0x0; /* option: A */
>=20
> - break;
> - case ANTENNA_B:
> - ofdm_rx_ant_sel_val =3D 0x2; /* B /
> - p_cck_txrx->r_cckrx_enable =3D 0x1; / default: B */
>=20
> - p_cck_txrx->r_cckrx_enable_2 =3D 0x1; /* option: B */
>=20
> - break;
> - case ANTENNA_AB:
> - ofdm_rx_ant_sel_val =3D 0x3; /* AB /
> - p_cck_txrx->r_cckrx_enable =3D 0x0; / default:A */
>=20
> - p_cck_txrx->r_cckrx_enable_2 =3D 0x1; /* option:B */
>=20
> - break;
> - default:
> - break;
> - }
> - /OFDM Rx/
> - set_bb_reg(pAdapter, rOFDM0_TRxPathEnable, 0x0000000f,
> - ofdm_rx_ant_sel_val);
> - /OFDM Rx/
> - set_bb_reg(pAdapter, rOFDM1_TRxPathEnable, 0x0000000f,
> - ofdm_rx_ant_sel_val);
> -
> - cck_ant_sel_val =3D cck_ant_select_val;
> - /CCK TxRx/
> - set_bb_reg(pAdapter, rCCK0_AFESetting, bMaskByte3, cck_ant_sel_val);
> -}
> -
> -static void TriggerRFThermalMeter(struct _adapter pAdapter)
> -{
> - / 0x24: RF Reg[6:5] */
> - set_rf_reg(pAdapter, RF_PATH_A, RF_T_METER, bRFRegOffsetMask, 0x60);
> -}
> -
> -static u32 ReadRFThermalMeter(struct _adapter pAdapter)
> -{
> - / 0x24: RF Reg[4:0] */
> - return get_rf_reg(pAdapter, RF_PATH_A, RF_T_METER, 0x1F);
> -}
> -
> -void r8712_GetThermalMeter(struct _adapter pAdapter, u32 value)
> -{
> - TriggerRFThermalMeter(pAdapter);
> - msleep(1000);
> - value =3D ReadRFThermalMeter(pAdapter);
> -}
> -
> -void r8712_SetSingleCarrierTx(struct _adapter pAdapter, u8 bStart)
> -{
> - if (bStart) { / Start Single Carrier. /
> - / 1. if OFDM block on? /
> - if (!get_bb_reg(pAdapter, rFPGA0_RFMOD, bOFDMEn))
> - /set OFDM block on/
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bOFDMEn, bEnable);
> - / 2. set CCK test mode off, set to CCK normal mode /
> - set_bb_reg(pAdapter, rCCK0_System, bCCKBBMode, bDisable);
> - / 3. turn on scramble setting /
> - set_bb_reg(pAdapter, rCCK0_System, bCCKScramble, bEnable);
> - / 4. Turn On Single Carrier Tx and off the other test modes. /
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bEnable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
> - } else { / Stop Single Carrier./
> - / Turn off all test modes./
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier,
> - bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
> - msleep(20);
> - /BB Reset/
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
> - }
> -}
> -
> -void r8712_SetSingleToneTx(struct _adapter *pAdapter, u8 bStart)
> -{
> - u8 rfPath;
> -
> - switch (pAdapter->mppriv.antenna_tx) {
>=20
> - case ANTENNA_B:
> - rfPath =3D RF_PATH_B;
> - break;
> - case ANTENNA_A:
> - default:
> - rfPath =3D RF_PATH_A;
> - break;
> - }
> - if (bStart) { /* Start Single Tone./
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bCCKEn, bDisable);
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bOFDMEn, bDisable);
> - set_rf_reg(pAdapter, rfPath, RF_TX_G2, bRFRegOffsetMask,
> - 0xd4000);
> - msleep(100);
> - / PAD all on./
> - set_rf_reg(pAdapter, rfPath, RF_AC, bRFRegOffsetMask, 0x2001f);
> - msleep(100);
> - } else { / Stop Single Tone./
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bCCKEn, bEnable);
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bOFDMEn, bEnable);
> - set_rf_reg(pAdapter, rfPath, RF_TX_G2, bRFRegOffsetMask,
> - 0x54000);
> - msleep(100);
> - / PAD all on./
> - set_rf_reg(pAdapter, rfPath, RF_AC, bRFRegOffsetMask, 0x30000);
> - msleep(100);
> - }
> -}
> -
> -void r8712_SetCarrierSuppressionTx(struct _adapter pAdapter, u8 bStart)
> -{
> - if (bStart) { / Start Carrier Suppression./
> - if (pAdapter->mppriv.curr_rateidx <=3D MPT_RATE_11M) {
>=20
> - /* 1. if CCK block on? /
> - if (!get_bb_reg(pAdapter, rFPGA0_RFMOD, bCCKEn)) {
> - /set CCK block on/
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bCCKEn,
> - bEnable);
> - }
> - / Turn Off All Test Mode /
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx,
> - bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier,
> - bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone,
> - bDisable);
> - /transmit mode/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKBBMode, 0x2);
> - /turn off scramble setting/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKScramble,
> - bDisable);
> - /Set CCK Tx Test Rate/
> - /Set FTxRate to 1Mbps/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKTxRate, 0x0);
> - }
> - } else { / Stop Carrier Suppression. */
> - if (pAdapter->mppriv.curr_rateidx <=3D MPT_RATE_11M) {
>=20
> - /normal mode/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKBBMode, 0x0);
> - /turn on scramble setting/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKScramble,
> - bEnable);
> - /BB Reset/
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
> - }
> - }
> -}
> -
> -static void SetCCKContinuousTx(struct _adapter pAdapter, u8 bStart)
> -{
> - u32 cckrate;
> -
> - if (bStart) {
> - / 1. if CCK block on? /
> - if (!get_bb_reg(pAdapter, rFPGA0_RFMOD, bCCKEn)) {
> - /set CCK block on/
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bCCKEn, bEnable);
> - }
> - / Turn Off All Test Mode */
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
> - /Set CCK Tx Test Rate/
> - cckrate =3D pAdapter->mppriv.curr_rateidx;
>=20
> - set_bb_reg(pAdapter, rCCK0_System, bCCKTxRate, cckrate);
> - /transmit mode/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKBBMode, 0x2);
> - /turn on scramble setting/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKScramble, bEnable);
> - } else {
> - /normal mode/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKBBMode, 0x0);
> - /turn on scramble setting/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKScramble, bEnable);
> - /BB Reset/
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
> - }
> -} /* mpt_StartCckContTx /
> -
> -static void SetOFDMContinuousTx(struct _adapter pAdapter, u8 bStart)
> -{
> - if (bStart) {
> - / 1. if OFDM block on? /
> - if (!get_bb_reg(pAdapter, rFPGA0_RFMOD, bOFDMEn)) {
> - /set OFDM block on/
> - set_bb_reg(pAdapter, rFPGA0_RFMOD, bOFDMEn, bEnable);
> - }
> - / 2. set CCK test mode off, set to CCK normal mode/
> - set_bb_reg(pAdapter, rCCK0_System, bCCKBBMode, bDisable);
> - /* 3. turn on scramble setting /
> - set_bb_reg(pAdapter, rCCK0_System, bCCKScramble, bEnable);
> - / 4. Turn On Continue Tx and turn off the other test modes./
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bEnable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier, bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
> - } else {
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMContinueTx, bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleCarrier,
> - bDisable);
> - set_bb_reg(pAdapter, rOFDM1_LSTF, bOFDMSingleTone, bDisable);
> - msleep(20);
> - /BB Reset/
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x0);
> - set_bb_reg(pAdapter, rPMAC_Reset, bBBResetB, 0x1);
> - }
> -} / mpt_StartOfdmContTx */
> -
> -void r8712_SetContinuousTx(struct _adapter pAdapter, u8 bStart)
> -{
> - / ADC turn off [bit24-21] adc port0 ~ port1 */
> - if (bStart) {
> - r8712_bb_reg_write(pAdapter, rRx_Wait_CCCA,
> - r8712_bb_reg_read(pAdapter,
> - rRx_Wait_CCCA) & 0xFE1FFFFF);
> - msleep(100);
> - }
> - if (pAdapter->mppriv.curr_rateidx <=3D MPT_RATE_11M)
>=20
> - SetCCKContinuousTx(pAdapter, bStart);
> - else if ((pAdapter->mppriv.curr_rateidx >=3D MPT_RATE_6M) &&
>=20
> - (pAdapter->mppriv.curr_rateidx <=3D MPT_RATE_MCS15))
>=20
> - SetOFDMContinuousTx(pAdapter, bStart);
> - /* ADC turn on [bit24-21] adc port0 ~ port1 /
> - if (!bStart)
> - r8712_bb_reg_write(pAdapter, rRx_Wait_CCCA,
> - r8712_bb_reg_read(pAdapter,
> - rRx_Wait_CCCA) | 0x01E00000);
> -}
> -
> -void r8712_ResetPhyRxPktCount(struct _adapter pAdapter)
> -{
> - u32 i, phyrx_set =3D 0;
> -
> - for (i =3D OFDM_PPDU_BIT; i <=3D HT_MPDU_FAIL_BIT; i++) {
> - phyrx_set =3D 0;
> - phyrx_set |=3D (i << 28); /select/
> - phyrx_set |=3D 0x08000000; / set counter to zero/
> - r8712_write32(pAdapter, RXERR_RPT, phyrx_set);
> - }
> -}
> -
> -static u32 GetPhyRxPktCounts(struct _adapter pAdapter, u32 selbit)
> -{
> - /selection/
> - u32 phyrx_set =3D 0;
> - u32 SelectBit;
> -
> - SelectBit =3D selbit << 28;
> - phyrx_set |=3D (SelectBit & 0xF0000000);
> - r8712_write32(pAdapter, RXERR_RPT, phyrx_set);
> - /Read packet count/
> - return r8712_read32(pAdapter, RXERR_RPT) & RPTMaxCount;
> -}
> -
> -u32 r8712_GetPhyRxPktReceived(struct _adapter pAdapter)
> -{
> - u32 OFDM_cnt =3D GetPhyRxPktCounts(pAdapter, OFDM_MPDU_OK_BIT);
> - u32 CCK_cnt =3D GetPhyRxPktCounts(pAdapter, CCK_MPDU_OK_BIT);
> - u32 HT_cnt =3D GetPhyRxPktCounts(pAdapter, HT_MPDU_OK_BIT);
> -
> - return OFDM_cnt + CCK_cnt + HT_cnt;
> -}
> -
> -u32 r8712_GetPhyRxPktCRC32Error(struct _adapter pAdapter)
> -{
> - u32 OFDM_cnt =3D GetPhyRxPktCounts(pAdapter, OFDM_MPDU_FAIL_BIT);
> - u32 CCK_cnt =3D GetPhyRxPktCounts(pAdapter, CCK_MPDU_FAIL_BIT);
> - u32 HT_cnt =3D GetPhyRxPktCounts(pAdapter, HT_MPDU_FAIL_BIT);
> -
> - return OFDM_cnt + CCK_cnt + HT_cnt;
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_mp.h b/drivers/staging/rtl87=
12/rtl871x_mp.h
> deleted file mode 100644
> index 0a60b1e6ccaf..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_mp.h
> +++ /dev/null
> @@ -1,275 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
****
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ******************************/
> -#ifndef _RTL871X_MP_H
> -#define _RTL871X_MP_H
> -
> -#define MPT_NOOP 0
> -#define MPT_READ_MAC_1BYTE 1
> -#define MPT_READ_MAC_2BYTE 2
> -#define MPT_READ_MAC_4BYTE 3
> -#define MPT_WRITE_MAC_1BYTE 4
> -#define MPT_WRITE_MAC_2BYTE 5
> -#define MPT_WRITE_MAC_4BYTE 6
> -#define MPT_READ_BB_CCK 7
> -#define MPT_WRITE_BB_CCK 8
> -#define MPT_READ_BB_OFDM 9
> -#define MPT_WRITE_BB_OFDM 10
> -#define MPT_READ_RF 11
> -#define MPT_WRITE_RF 12
> -#define MPT_READ_EEPROM_1BYTE 13
> -#define MPT_WRITE_EEPROM_1BYTE 14
> -#define MPT_READ_EEPROM_2BYTE 15
> -#define MPT_WRITE_EEPROM_2BYTE 16
> -#define MPT_SET_CSTHRESHOLD 21
> -#define MPT_SET_INITGAIN 22
> -#define MPT_SWITCH_BAND 23
> -#define MPT_SWITCH_CHANNEL 24
> -#define MPT_SET_DATARATE 25
> -#define MPT_SWITCH_ANTENNA 26
> -#define MPT_SET_TX_POWER 27
> -#define MPT_SET_CONT_TX 28
> -#define MPT_SET_SINGLE_CARRIER 29
> -#define MPT_SET_CARRIER_SUPPRESSION 30
> -#define MPT_GET_RATE_TABLE 31
> -#define MPT_READ_TSSI 32
> -#define MPT_GET_THERMAL_METER 33
> -#define MAX_MP_XMITBUF_SZ 2048
> -#define NR_MP_XMITFRAME 8
> -
> -struct mp_xmit_frame {
> - struct list_head list;
> - struct pkt_attrib attrib;
> - _pkt pkt;
> - int frame_tag;
> - struct _adapter padapter;
> - u8 mem_addr;
> - u16 sz[8];
> - struct urb pxmit_urb[8];
> - u8 bpending[8];
> - u8 last[8];
> -};
> -
> -struct mp_wiparam {
> - u32 bcompleted;
> - u32 act_type;
> - u32 io_offset;
> - u32 io_value;
> -};
> -
> -struct mp_priv {
> - struct _adapter papdater;
> - /OID cmd handler/
> - struct mp_wiparam workparam;
> - u8 act_in_progress;
> - /Tx Section/
> - u8 TID;
> - u32 tx_pktcount;
> - /Rx Section/
> - u32 rx_pktcount;
> - u32 rx_crcerrpktcount;
> - u32 rx_pktloss;
> - struct recv_stat rxstat;
> - /RF/BB relative/
> - u32 curr_ch;
> - u32 curr_rateidx;
> - u8 curr_bandwidth;
> - u8 curr_modem;
> - u8 curr_txpoweridx;
> - u32 curr_crystalcap;
> - u16 antenna_tx;
> - u16 antenna_rx;
> - u8 curr_rfpath;
> - u8 check_mp_pkt;
> - uint ForcedDataRate;
> - struct wlan_network mp_network;
> - unsigned char network_macaddr[6];
> - /Testing Flag/
> - u32 mode;/0 for normal type packet,
> - * 1 for loopback packet (16bytes TXCMD)
> - /
> - sint prev_fw_state;
> - u8 pallocated_mp_xmitframe_buf;
> - u8 pmp_xmtframe_buf;
> - struct __queue free_mp_xmitqueue;
> - u32 free_mp_xmitframe_cnt;
> -};
> -
> -struct IOCMD_STRUCT {
> - u8 cmdclass;
> - u16 value;
> - u8 index;
> -};
> -
> -struct rf_reg_param {
> - u32 path;
> - u32 offset;
> - u32 value;
> -};
> -
> -struct bb_reg_param {
> - u32 offset;
> - u32 value;
> -};
> -
> -/ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D /
> -
> -#define LOWER true
> -#define RAISE false
> -#define IOCMD_CTRL_REG 0x10250370
> -#define IOCMD_DATA_REG 0x10250374
> -#define IOCMD_GET_THERMAL_METER 0xFD000028
> -#define IOCMD_CLASS_BB_RF 0xF0
> -#define IOCMD_BB_READ_IDX 0x00
> -#define IOCMD_BB_WRITE_IDX 0x01
> -#define IOCMD_RF_READ_IDX 0x02
> -#define IOCMD_RF_WRIT_IDX 0x03
> -#define BB_REG_BASE_ADDR 0x800
> -#define RF_PATH_A 0
> -#define RF_PATH_B 1
> -#define RF_PATH_C 2
> -#define RF_PATH_D 3
> -#define MAX_RF_PATH_NUMS 2
> -#define 2MAC_MODE 0
> -#define LOOPBOOK_MODE 1
> -
> -/ MP set force data rate base on the definition. /
> -enum {
> - / CCK rate. /
> - MPT_RATE_1M, / 0 /
> - MPT_RATE_2M,
> - MPT_RATE_55M,
> - MPT_RATE_11M, / 3 /
> -
> - / OFDM rate. /
> - MPT_RATE_6M, / 4 /
> - MPT_RATE_9M,
> - MPT_RATE_12M,
> - MPT_RATE_18M,
> - MPT_RATE_24M,
> - MPT_RATE_36M,
> - MPT_RATE_48M,
> - MPT_RATE_54M, / 11 /
> -
> - / HT rate. /
> - MPT_RATE_MCS0, / 12 /
> - MPT_RATE_MCS1,
> - MPT_RATE_MCS2,
> - MPT_RATE_MCS3,
> - MPT_RATE_MCS4,
> - MPT_RATE_MCS5,
> - MPT_RATE_MCS6,
> - MPT_RATE_MCS7, / 19 /
> - MPT_RATE_MCS8,
> - MPT_RATE_MCS9,
> - MPT_RATE_MCS10,
> - MPT_RATE_MCS11,
> - MPT_RATE_MCS12,
> - MPT_RATE_MCS13,
> - MPT_RATE_MCS14,
> - MPT_RATE_MCS15, / 27 /
> - MPT_RATE_LAST
> -};
> -
> -/ Represent Channel Width in HT Capabilities /
> -enum HT_CHANNEL_WIDTH {
> - HT_CHANNEL_WIDTH_20 =3D 0,
> - HT_CHANNEL_WIDTH_40 =3D 1,
> -};
> -
> -#define MAX_TX_PWR_INDEX_N_MODE 64 / 0x3F /
> -
> -enum POWER_MODE {
> - POWER_LOW =3D 0,
> - POWER_NORMAL
> -};
> -
> -#define RX_PKT_BROADCAST 1
> -#define RX_PKT_DEST_ADDR 2
> -#define RX_PKT_PHY_MATCH 3
> -
> -#define RPTMaxCount 0x000FFFFF
> -
> -/ parameter 1 : BitMask
> - * bit 0 : OFDM PPDU
> - * bit 1 : OFDM False Alarm
> - * bit 2 : OFDM MPDU OK
> - * bit 3 : OFDM MPDU Fail
> - * bit 4 : CCK PPDU
> - * bit 5 : CCK False Alarm
> - * bit 6 : CCK MPDU ok
> - * bit 7 : CCK MPDU fail
> - * bit 8 : HT PPDU counter
> - * bit 9 : HT false alarm
> - * bit 10 : HT MPDU total
> - * bit 11 : HT MPDU OK
> - * bit 12 : HT MPDU fail
> - * bit 15 : RX full drop
> - /
> -enum RXPHY_BITMASK {
> - OFDM_PPDU_BIT =3D 0,
> - OFDM_MPDU_OK_BIT,
> - OFDM_MPDU_FAIL_BIT,
> - CCK_PPDU_BIT,
> - CCK_MPDU_OK_BIT,
> - CCK_MPDU_FAIL_BIT,
> - HT_PPDU_BIT,
> - HT_MPDU_BIT,
> - HT_MPDU_OK_BIT,
> - HT_MPDU_FAIL_BIT,
> -};
> -
> -enum ENCRY_CTRL_STATE {
> - HW_CONTROL, /hw encryption& decryption/
> - SW_CONTROL, /sw encryption& decryption/
> - HW_ENCRY_SW_DECRY, /hw encryption & sw decryption/
> - SW_ENCRY_HW_DECRY /sw encryption & hw decryption/
> -};
> -
> -/ Bandwidth Offset /
> -#define HAL_PRIME_CHNL_OFFSET_DONT_CARE 0
> -#define HAL_PRIME_CHNL_OFFSET_LOWER 1
> -#define HAL_PRIME_CHNL_OFFSET_UPPER 2
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/
> -void mp871xinit(struct _adapter padapter);
> -void mp871xdeinit(struct _adapter padapter);
> -u32 r8712_bb_reg_read(struct _adapter Adapter, u16 offset);
> -u8 r8712_bb_reg_write(struct _adapter Adapter, u16 offset, u32 value);
> -u32 r8712_rf_reg_read(struct _adapter Adapter, u8 path, u8 offset);
> -u8 r8712_rf_reg_write(struct _adapter Adapter, u8 path,
> - u8 offset, u32 value);
> -u32 r8712_get_bb_reg(struct _adapter Adapter, u16 offset, u32 bitmask);
> -u8 r8712_set_bb_reg(struct _adapter Adapter, u16 offset,
> - u32 bitmask, u32 value);
> -u32 r8712_get_rf_reg(struct _adapter Adapter, u8 path, u8 offset,
> - u32 bitmask);
> -u8 r8712_set_rf_reg(struct _adapter Adapter, u8 path, u8 offset,
> - u32 bitmask, u32 value);
> -
> -void r8712_SetChannel(struct _adapter pAdapter);
> -void r8712_SetTxPower(struct _adapter pAdapte);
> -void r8712_SetTxAGCOffset(struct _adapter pAdapter, u32 ulTxAGCOffset);
> -void r8712_SetDataRate(struct _adapter pAdapter);
> -void r8712_SwitchBandwidth(struct _adapter pAdapter);
> -void r8712_SwitchAntenna(struct _adapter pAdapter);
> -void r8712_GetThermalMeter(struct _adapter pAdapter, u32 value);
> -void r8712_SetContinuousTx(struct _adapter pAdapter, u8 bStart);
> -void r8712_SetSingleCarrierTx(struct _adapter pAdapter, u8 bStart);
> -void r8712_SetSingleToneTx(struct _adapter pAdapter, u8 bStart);
> -void r8712_SetCarrierSuppressionTx(struct _adapter pAdapter, u8 bStart);
> -void r8712_ResetPhyRxPktCount(struct _adapter pAdapter);
> -u32 r8712_GetPhyRxPktReceived(struct _adapter pAdapter);
> -u32 r8712_GetPhyRxPktCRC32Error(struct _adapter pAdapter);
> -
> -#endif /_RTL871X_MP_H/
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c b/drivers/staging=
/rtl8712/rtl871x_mp_ioctl.c
> deleted file mode 100644
> index 26fa09b45c90..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.c
> +++ /dev/null
> @@ -1,883 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl871x_mp_ioctl.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#include <linux/rndis.h>
>=20
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "mlme_osdep.h"
> -#include "rtl871x_mp.h"
> -#include "rtl871x_mp_ioctl.h"
> -
> -uint oid_null_function(struct oid_par_priv *poid_par_priv)
> -{
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_wireless_mode_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - uint status =3D RNDIS_STATUS_SUCCESS;
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid =3D=3D SET_OID) {
>=20
> - if (poid_par_priv->information_buf_len >=3D sizeof(u8))
>=20
> - Adapter->registrypriv.wireless_mode =3D
>=20
> - *(u8 *)poid_par_priv->information_buf;
>=20
> - else
> - status =3D RNDIS_STATUS_INVALID_LENGTH;
> - } else if (poid_par_priv->type_of_oid =3D=3D QUERY_OID) {
>=20
> - if (poid_par_priv->information_buf_len >=3D sizeof(u8)) {
>=20
> - *(u8 *)poid_par_priv->information_buf =3D
>=20
> - Adapter->registrypriv.wireless_mode;
>=20
> - *poid_par_priv->bytes_rw =3D
>=20
> - poid_par_priv->information_buf_len;
>=20
> - } else {
> - status =3D RNDIS_STATUS_INVALID_LENGTH;
> - }
> - } else {
> - status =3D RNDIS_STATUS_NOT_ACCEPTED;
> - }
> - return status;
> -}
> -
> -uint oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - struct bb_reg_param *pbbreg;
> - u16 offset;
> - u32 value;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(struct bb_reg_param))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - pbbreg =3D (struct bb_reg_param *)(poid_par_priv->information_buf);
>=20
> - offset =3D (u16)(pbbreg->offset) & 0xFFF; /0ffset :0x800~0xfff/
>=20
> - if (offset < BB_REG_BASE_ADDR)
> - offset |=3D BB_REG_BASE_ADDR;
> - value =3D pbbreg->value;
>=20
> - r8712_bb_reg_write(Adapter, offset, value);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - struct bb_reg_param *pbbreg;
> - u16 offset;
> - u32 value;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(struct bb_reg_param))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - pbbreg =3D (struct bb_reg_param *)(poid_par_priv->information_buf);
>=20
> - offset =3D (u16)(pbbreg->offset) & 0xFFF; /0ffset :0x800~0xfff/
>=20
> - if (offset < BB_REG_BASE_ADDR)
> - offset |=3D BB_REG_BASE_ADDR;
> - value =3D r8712_bb_reg_read(Adapter, offset);
> - pbbreg->value =3D value;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - struct rf_reg_param *pbbreg;
> - u8 path;
> - u8 offset;
> - u32 value;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(struct rf_reg_param))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - pbbreg =3D (struct rf_reg_param *)(poid_par_priv->information_buf);
>=20
> - path =3D (u8)pbbreg->path;
>=20
> - if (path > RF_PATH_B)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - offset =3D (u8)pbbreg->offset;
>=20
> - value =3D pbbreg->value;
>=20
> - r8712_rf_reg_write(Adapter, path, offset, value);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - struct rf_reg_param *pbbreg;
> - u8 path;
> - u8 offset;
> - u32 value;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(struct rf_reg_param))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - pbbreg =3D (struct rf_reg_param *)(poid_par_priv->information_buf);
>=20
> - path =3D (u8)pbbreg->path;
>=20
> - if (path > RF_PATH_B) /* 1T2R path_a /path_b */
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - offset =3D (u8)pbbreg->offset;
>=20
> - value =3D r8712_rf_reg_read(Adapter, path, offset);
> - pbbreg->value =3D value;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -/This function initializes the DUT to the MP test mode/
> -static int mp_start_test(struct _adapter *padapter)
> -{
> - struct mp_priv *pmppriv =3D &padapter->mppriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_network *tgt_network =3D &pmlmepriv->cur_network;
>=20
> - struct wlan_bssid_ex *bssid;
> - struct sta_info *psta;
> - unsigned long length;
> - unsigned long irqL;
> - int res =3D 0;
> -
> - bssid =3D kzalloc(sizeof(bssid), GFP_KERNEL);
> - if (!bssid)
> - return -ENOMEM;
> -
> - / 3 1. initialize a new struct wlan_bssid_ex */
> - memcpy(bssid->MacAddress, pmppriv->network_macaddr, ETH_ALEN);
>=20
> - bssid->Ssid.SsidLength =3D 16;
>=20
> - memcpy(bssid->Ssid.Ssid, (unsigned char *)"mp_pseudo_adhoc",
>=20
> - bssid->Ssid.SsidLength);
>=20
> - bssid->InfrastructureMode =3D Ndis802_11IBSS;
>=20
> - bssid->NetworkTypeInUse =3D Ndis802_11DS;
>=20
> - bssid->IELength =3D 0;
>=20
> - length =3D r8712_get_wlan_bssid_ex_sz(bssid);
> - if (length % 4) {
> - /round up to multiple of 4 bytes./
> - bssid->Length =3D ((length >> 2) + 1) << 2;
>=20
> - } else {
> - bssid->Length =3D length;
>=20
> - }
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
> - goto end_of_mp_start_test;
> - /init mp_start_test status/
> - pmppriv->prev_fw_state =3D get_fwstate(pmlmepriv);
>=20
> - pmlmepriv->fw_state =3D WIFI_MP_STATE;
>=20
> - if (pmppriv->mode =3D=3D LOOPBOOK_MODE)
>=20
> - set_fwstate(pmlmepriv, WIFI_MP_LPBK_STATE); /append txdesc/
> - set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - /* 3 2. create a new psta for mp driver /
> - / clear psta in the cur_network, if any */
> - psta =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - tgt_network->network.MacAddress);
>=20
> - if (psta)
> - r8712_free_stainfo(padapter, psta);
> - psta =3D r8712_alloc_stainfo(&padapter->stapriv, bssid->MacAddress);
>=20
> - if (!psta) {
> - res =3D -ENOMEM;
> - goto end_of_mp_start_test;
> - }
> - /* 3 3. join pseudo AdHoc */
> - tgt_network->join_res =3D 1;
>=20
> - tgt_network->aid =3D psta->aid =3D 1;
>=20
> - memcpy(&tgt_network->network, bssid, length);
>=20
> - clr_fwstate(pmlmepriv, _FW_UNDER_LINKING);
> - r8712_os_indicate_connect(padapter);
> - /* Set to LINKED STATE for MP TRX Testing */
> - set_fwstate(pmlmepriv, _FW_LINKED);
> -end_of_mp_start_test:
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - kfree(bssid);
> - return res;
> -}
> -
> -/*This function change the DUT from the MP test mode into normal mode */
> -static int mp_stop_test(struct _adapter *padapter)
> -{
> - struct mp_priv *pmppriv =3D &padapter->mppriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct wlan_network *tgt_network =3D &pmlmepriv->cur_network;
>=20
> - struct sta_info *psta;
> - unsigned long irqL;
> -
> - spin_lock_irqsave(&pmlmepriv->lock, irqL);
>=20
> - if (!check_fwstate(pmlmepriv, WIFI_MP_STATE))
> - goto end_of_mp_stop_test;
> - /* 3 1. disconnect pseudo AdHoc /
> - r8712_os_indicate_disconnect(padapter);
> - / 3 2. clear psta used in mp test mode. */
> - psta =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - tgt_network->network.MacAddress);
>=20
> - if (psta)
> - r8712_free_stainfo(padapter, psta);
> - /* 3 3. return to normal state (default:station mode) /
> - pmlmepriv->fw_state =3D pmppriv->prev_fw_state; / WIFI_STATION_STATE;*/
>=20
> - /flush the cur_network/
> - memset(tgt_network, 0, sizeof(struct wlan_network));
> -end_of_mp_stop_test:
> - spin_unlock_irqrestore(&pmlmepriv->lock, irqL);
>=20
> - return _SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_data_rate_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 ratevalue;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len !=3D sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - ratevalue =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - if (ratevalue >=3D MPT_RATE_LAST)
>=20
> - return RNDIS_STATUS_INVALID_DATA;
> - Adapter->mppriv.curr_rateidx =3D ratevalue;
>=20
> - r8712_SetDataRate(Adapter);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_start_test_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - uint status =3D RNDIS_STATUS_SUCCESS;
> - u32 mode;
> - u8 val8;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - mode =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - Adapter->mppriv.mode =3D mode;/* 1 for loopback*/
>=20
> - if (mp_start_test(Adapter))
> - status =3D RNDIS_STATUS_NOT_ACCEPTED;
> - r8712_write8(Adapter, MSR, 1); /* Link in ad hoc network, 0x1025004C /
> - r8712_write8(Adapter, RCR, 0); / RCR : disable all pkt, 0x10250048 /
> - / RCR disable Check BSSID, 0x1025004a /
> - r8712_write8(Adapter, RCR + 2, 0x57);
> - / disable RX filter map , mgt frames will put in RX FIFO 0 */
> - r8712_write16(Adapter, RXFLTMAP0, 0x0);
> - val8 =3D r8712_read8(Adapter, EE_9346CR);
> - if (!(val8 & _9356SEL)) { /boot from EFUSE/
> - r8712_efuse_reg_init(Adapter);
> - r8712_efuse_change_max_size(Adapter);
> - r8712_efuse_reg_uninit(Adapter);
> - }
> - return status;
> -}
> -
> -uint oid_rt_pro_stop_test_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (mp_stop_test(Adapter) =3D=3D _FAIL)
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_channel_direct_call_hdl(struct oid_par_priv *poid_pa=
r_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 Channel;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len !=3D sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - Channel =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - if (Channel > 14)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - Adapter->mppriv.curr_ch =3D Channel;
>=20
> - r8712_SetChannel(Adapter);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_antenna_bb_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 antenna;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len !=3D sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - antenna =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - Adapter->mppriv.antenna_tx =3D (u16)((antenna & 0xFFFF0000) >> 16);
>=20
> - Adapter->mppriv.antenna_rx =3D (u16)(antenna & 0x0000FFFF);
>=20
> - r8712_SwitchAntenna(Adapter);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_tx_power_control_hdl(struct oid_par_priv *poid_par_p=
riv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 tx_pwr_idx;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len !=3D sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - tx_pwr_idx =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - if (tx_pwr_idx > MAX_TX_PWR_INDEX_N_MODE)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - Adapter->mppriv.curr_txpoweridx =3D (u8)tx_pwr_idx;
>=20
> - r8712_SetTxPower(Adapter);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_query_tx_packet_sent_hdl(struct oid_par_priv *poid_par_p=
riv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> -
> - if (poid_par_priv->information_buf_len =3D=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - Adapter->mppriv.tx_pktcount;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_query_rx_packet_received_hdl(struct oid_par_priv *poid_p=
ar_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> -
> - if (poid_par_priv->information_buf_len =3D=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - Adapter->mppriv.rx_pktcount;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_query_rx_packet_crc32_error_hdl(struct oid_par_priv *poi=
d_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> -
> - if (poid_par_priv->information_buf_len =3D=3D sizeof(u32)) {
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - Adapter->mppriv.rx_crcerrpktcount;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_reset_tx_packet_sent_hdl(struct oid_par_priv *poid_par_p=
riv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - Adapter->mppriv.tx_pktcount =3D 0;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_reset_rx_packet_received_hdl(struct oid_par_priv *poid_p=
ar_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len =3D=3D sizeof(u32)) {
>=20
> - Adapter->mppriv.rx_pktcount =3D 0;
>=20
> - Adapter->mppriv.rx_crcerrpktcount =3D 0;
>=20
> - } else {
> - return RNDIS_STATUS_INVALID_LENGTH;
> - }
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_reset_phy_rx_packet_count_hdl(struct oid_par_priv *poid_par_=
priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - r8712_ResetPhyRxPktCount(Adapter);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_phy_rx_packet_received_hdl(struct oid_par_priv *poid_par=
_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len !=3D sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - r8712_GetPhyRxPktReceived(Adapter);
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_phy_rx_packet_crc32_error_hdl(struct oid_par_priv *poid_=
par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len !=3D sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - r8712_GetPhyRxPktCRC32Error(Adapter);
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> -
> - Adapter->mppriv.curr_modem =3D *((u8 *)poid_par_priv->information_buf);
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_continuous_tx_hdl(struct oid_par_priv *poid_par_priv=
)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 bStartTest;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - bStartTest =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - r8712_SetContinuousTx(Adapter, (u8)bStartTest);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_single_carrier_tx_hdl(struct oid_par_priv *poid_par_=
priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 bStartTest;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - bStartTest =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - r8712_SetSingleCarrierTx(Adapter, (u8)bStartTest);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_carrier_suppression_tx_hdl(struct oid_par_priv *poid=
_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 bStartTest;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - bStartTest =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - r8712_SetCarrierSuppressionTx(Adapter, (u8)bStartTest);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_set_single_tone_tx_hdl(struct oid_par_priv *poid_par_pri=
v)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 bStartTest;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - bStartTest =3D *((u32 *)poid_par_priv->information_buf);
>=20
> - r8712_SetSingleToneTx(Adapter, (u8)bStartTest);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_read_register_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - uint status =3D RNDIS_STATUS_SUCCESS;
> - struct mp_rw_reg *RegRWStruct;
> - u16 offset;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - RegRWStruct =3D (struct mp_rw_reg *)poid_par_priv->information_buf;
>=20
> - if ((RegRWStruct->offset >=3D 0x10250800) &&
>=20
> - (RegRWStruct->offset <=3D 0x10250FFF)) {
>=20
> - /baseband register/
> - /0ffset :0x800~0xfff/
> - offset =3D (u16)(RegRWStruct->offset) & 0xFFF;
>=20
> - RegRWStruct->value =3D r8712_bb_reg_read(Adapter, offset);
>=20
> - } else {
> - switch (RegRWStruct->width) {
>=20
> - case 1:
> - RegRWStruct->value =3D r8712_read8(Adapter,
>=20
> - RegRWStruct->offset);
>=20
> - break;
> - case 2:
> - RegRWStruct->value =3D r8712_read16(Adapter,
>=20
> - RegRWStruct->offset);
>=20
> - break;
> - case 4:
> - RegRWStruct->value =3D r8712_read32(Adapter,
>=20
> - RegRWStruct->offset);
>=20
> - break;
> - default:
> - status =3D RNDIS_STATUS_NOT_ACCEPTED;
> - break;
> - }
> - }
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return status;
> -}
> -
> -uint oid_rt_pro_write_register_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - uint status =3D RNDIS_STATUS_SUCCESS;
> - struct mp_rw_reg *RegRWStruct;
> - u16 offset;
> - u32 value;
> - u32 oldValue =3D 0;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - RegRWStruct =3D (struct mp_rw_reg *)poid_par_priv->information_buf;
>=20
> - if ((RegRWStruct->offset >=3D 0x10250800) &&
>=20
> - (RegRWStruct->offset <=3D 0x10250FFF)) {
>=20
> - /baseband register/
> - offset =3D (u16)(RegRWStruct->offset) & 0xFFF;
>=20
> - value =3D RegRWStruct->value;
>=20
> - switch (RegRWStruct->width) {
>=20
> - case 1:
> - oldValue =3D r8712_bb_reg_read(Adapter, offset);
> - oldValue &=3D 0xFFFFFF00;
> - value &=3D 0x000000FF;
> - value |=3D oldValue;
> - break;
> - case 2:
> - oldValue =3D r8712_bb_reg_read(Adapter, offset);
> - oldValue &=3D 0xFFFF0000;
> - value &=3D 0x0000FFFF;
> - value |=3D oldValue;
> - break;
> - }
> - r8712_bb_reg_write(Adapter, offset, value);
> - } else {
> - switch (RegRWStruct->width) {
>=20
> - case 1:
> - r8712_write8(Adapter, RegRWStruct->offset,
>=20
> - (unsigned char)RegRWStruct->value);
>=20
> - break;
> - case 2:
> - r8712_write16(Adapter, RegRWStruct->offset,
>=20
> - (unsigned short)RegRWStruct->value);
>=20
> - break;
> - case 4:
> - r8712_write32(Adapter, RegRWStruct->offset,
>=20
> - (unsigned int)RegRWStruct->value);
>=20
> - break;
> - default:
> - status =3D RNDIS_STATUS_NOT_ACCEPTED;
> - break;
> - }
> - }
> - return status;
> -}
> -
> -uint oid_rt_get_thermal_meter_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> -
> - if (Adapter->mppriv.act_in_progress)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> -
> - if (poid_par_priv->information_buf_len < sizeof(u8))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - /init workparam/
> - Adapter->mppriv.act_in_progress =3D true;
>=20
> - Adapter->mppriv.workparam.bcompleted =3D false;
>=20
> - Adapter->mppriv.workparam.act_type =3D MPT_GET_THERMAL_METER;
>=20
> - Adapter->mppriv.workparam.io_offset =3D 0;
>=20
> - Adapter->mppriv.workparam.io_value =3D 0xFFFFFFFF;
>=20
> - r8712_GetThermalMeter(Adapter, &Adapter->mppriv.workparam.io_value);
>=20
> - Adapter->mppriv.workparam.bcompleted =3D true;
>=20
> - Adapter->mppriv.act_in_progress =3D false;
>=20
> - *(u32 *)poid_par_priv->information_buf =3D
>=20
> - Adapter->mppriv.workparam.io_value;
>=20
> - *poid_par_priv->bytes_rw =3D sizeof(u32);
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_read_efuse_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - uint status =3D RNDIS_STATUS_SUCCESS;
> -
> - struct EFUSE_ACCESS_STRUCT *pefuse;
> - u8 *data;
> - u16 addr =3D 0, cnts =3D 0;
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len <
>=20
> - sizeof(struct EFUSE_ACCESS_STRUCT))
> - return RNDIS_STATUS_INVALID_LENGTH;
> - pefuse =3D (struct EFUSE_ACCESS_STRUCT *)poid_par_priv->information_buf=
;
>=20
> - addr =3D pefuse->start_addr;
>=20
> - cnts =3D pefuse->cnts;
>=20
> - data =3D pefuse->data;
>=20
> - memset(data, 0xFF, cnts);
> - if ((addr > 511) || (cnts < 1) || (cnts > 512) || (addr + cnts) >
>=20
> - EFUSE_MAX_SIZE)
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (!r8712_efuse_access(Adapter, true, addr, cnts, data))
> - status =3D RNDIS_STATUS_FAILURE;
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return status;
> -}
> -
> -/-----------------------------------------------------------------------=
-/
> -uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - uint status =3D RNDIS_STATUS_SUCCESS;
> -
> - struct EFUSE_ACCESS_STRUCT *pefuse;
> - u8 *data;
> - u16 addr =3D 0, cnts =3D 0;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> -
> - pefuse =3D (struct EFUSE_ACCESS_STRUCT *)poid_par_priv->information_buf=
;
>=20
> - addr =3D pefuse->start_addr;
>=20
> - cnts =3D pefuse->cnts;
>=20
> - data =3D pefuse->data;
>=20
> -
> - if ((addr > 511) || (cnts < 1) || (cnts > 512) ||
>=20
> - (addr + cnts) > r8712_efuse_get_max_size(Adapter))
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (!r8712_efuse_access(Adapter, false, addr, cnts, data))
> - status =3D RNDIS_STATUS_FAILURE;
> - return status;
> -}
> -
> -/----------------------------------------------------------------------/
> -
> -uint oid_rt_get_efuse_current_size_hdl(struct oid_par_priv *poid_par_pri=
v)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(int))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - r8712_efuse_reg_init(Adapter);
> - *(int *)poid_par_priv->information_buf =3D
>=20
> - r8712_efuse_get_current_size(Adapter);
> - r8712_efuse_reg_uninit(Adapter);
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_get_efuse_max_size_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - *(int *)poid_par_priv->information_buf =3D
>=20
> - r8712_efuse_get_max_size(Adapter);
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_pro_efuse_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - uint status =3D RNDIS_STATUS_SUCCESS;
> -
> - if (poid_par_priv->type_of_oid =3D=3D QUERY_OID)
>=20
> - status =3D oid_rt_pro_read_efuse_hdl(poid_par_priv);
> - else
> - status =3D oid_rt_pro_write_efuse_hdl(poid_par_priv);
> - return status;
> -}
> -
> -uint oid_rt_pro_efuse_map_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - uint status =3D RNDIS_STATUS_SUCCESS;
> - u8 *data;
> -
> - *poid_par_priv->bytes_rw =3D 0;
>=20
> - if (poid_par_priv->information_buf_len < EFUSE_MAP_MAX_SIZE)
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - data =3D (u8 *)poid_par_priv->information_buf;
>=20
> - if (poid_par_priv->type_of_oid =3D=3D QUERY_OID) {
>=20
> - if (r8712_efuse_map_read(Adapter, 0, EFUSE_MAP_MAX_SIZE, data))
> - *poid_par_priv->bytes_rw =3D EFUSE_MAP_MAX_SIZE;
>=20
> - else
> - status =3D RNDIS_STATUS_FAILURE;
> - } else {
> - /* SET_OID */
> - if (r8712_efuse_reg_init(Adapter)) {
> - if (r8712_efuse_map_write(Adapter, 0,
> - EFUSE_MAP_MAX_SIZE, data))
> - *poid_par_priv->bytes_rw =3D EFUSE_MAP_MAX_SIZE;
>=20
> - else
> - status =3D RNDIS_STATUS_FAILURE;
> - r8712_efuse_reg_uninit(Adapter);
> - } else {
> - status =3D RNDIS_STATUS_FAILURE;
> - }
> - }
> - return status;
> -}
> -
> -uint oid_rt_set_bandwidth_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u32 bandwidth;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - bandwidth =3D *((u32 *)poid_par_priv->information_buf);/4/
>=20
> - if (bandwidth !=3D HT_CHANNEL_WIDTH_20)
> - bandwidth =3D HT_CHANNEL_WIDTH_40;
> - Adapter->mppriv.curr_bandwidth =3D (u8)bandwidth;
>=20
> - r8712_SwitchBandwidth(Adapter);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -uint oid_rt_set_rx_packet_type_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> - u8 rx_pkt_type;
> - u32 rcr_val32;
> -
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(u8))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - rx_pkt_type =3D *((u8 *)poid_par_priv->information_buf);/4/
>=20
> - rcr_val32 =3D r8712_read32(Adapter, RCR);/RCR =3D 0x10250048/
> - rcr_val32 &=3D ~(RCR_CBSSID | RCR_AB | RCR_AM | RCR_APM | RCR_AAP);
> - switch (rx_pkt_type) {
> - case RX_PKT_BROADCAST:
> - rcr_val32 |=3D (RCR_AB | RCR_AM | RCR_APM | RCR_AAP | RCR_ACRC32);
> - break;
> - case RX_PKT_DEST_ADDR:
> - rcr_val32 |=3D (RCR_AB | RCR_AM | RCR_APM | RCR_AAP | RCR_ACRC32);
> - break;
> - case RX_PKT_PHY_MATCH:
> - rcr_val32 |=3D (RCR_APM | RCR_ACRC32);
> - break;
> - default:
> - rcr_val32 &=3D ~(RCR_AAP |
> - RCR_APM |
> - RCR_AM |
> - RCR_AB |
> - RCR_ACRC32);
> - break;
> - }
> - if (rx_pkt_type =3D=3D RX_PKT_DEST_ADDR)
> - Adapter->mppriv.check_mp_pkt =3D 1;
>=20
> - else
> - Adapter->mppriv.check_mp_pkt =3D 0;
>=20
> - r8712_write32(Adapter, RCR, rcr_val32);
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -/-----------------------------------------------------------------------=
---/
> -/Linux/
> -unsigned int mp_ioctl_xmit_packet_hdl(struct oid_par_priv poid_par_priv)
> -{
> - return _SUCCESS;
> -}
> -
> -/-----------------------------------------------------------------------=
--*/
> -uint oid_rt_set_power_down_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - if (poid_par_priv->type_of_oid !=3D SET_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - /CALL the power_down function/
> - return RNDIS_STATUS_SUCCESS;
> -}
> -
> -/*----------------------------------------------------------------------=
---- */
> -uint oid_rt_get_power_mode_hdl(struct oid_par_priv *poid_par_priv)
> -{
> - struct _adapter *Adapter =3D (struct _adapter *)
> - (poid_par_priv->adapter_context);
>=20
> -
> - if (poid_par_priv->type_of_oid !=3D QUERY_OID)
>=20
> - return RNDIS_STATUS_NOT_ACCEPTED;
> - if (poid_par_priv->information_buf_len < sizeof(u32))
>=20
> - return RNDIS_STATUS_INVALID_LENGTH;
> - *(int *)poid_par_priv->information_buf =3D
>=20
> - Adapter->registrypriv.low_power ? POWER_LOW : POWER_NORMAL;
>=20
> - *poid_par_priv->bytes_rw =3D poid_par_priv->information_buf_len;
>=20
> - return RNDIS_STATUS_SUCCESS;
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h b/drivers/staging=
/rtl8712/rtl871x_mp_ioctl.h
> deleted file mode 100644
> index aa4d5ce471f2..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_mp_ioctl.h
> +++ /dev/null
> @@ -1,328 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ****************************************/
> -#ifndef _RTL871X_MP_IOCTL_H
> -#define _RTL871X_MP_IOCTL_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "mp_custom_oid.h"
> -#include "rtl871x_ioctl.h"
> -#include "rtl871x_ioctl_rtl.h"
> -#include "rtl8712_efuse.h"
> -
> -#define TESTFWCMDNUMBER 1000000
> -#define TEST_H2CINT_WAIT_TIME 500
> -#define TEST_C2HINT_WAIT_TIME 500
> -#define HCI_TEST_SYSCFG_HWMASK 1
> -#define _BUSCLK_40M (4 << 2)
> -
> -struct CFG_DBG_MSG_STRUCT {
> - u32 DebugLevel;
> - u32 DebugComponent_H32;
> - u32 DebugComponent_L32;
> -};
> -
> -struct mp_rw_reg {
> - uint offset;
> - uint width;
> - u32 value;
> -};
> -
> -/ for OID_RT_PRO_READ16_EEPROM & OID_RT_PRO_WRITE16_EEPROM /
> -struct eeprom_rw_param {
> - uint offset;
> - u16 value;
> -};
> -
> -struct EFUSE_ACCESS_STRUCT {
> - u16 start_addr;
> - u16 cnts;
> - u8 data[];
> -};
> -
> -struct burst_rw_reg {
> - uint offset;
> - uint len;
> - u8 Data[256];
> -};
> -
> -struct usb_vendor_req {
> - u8 bRequest;
> - u16 wValue;
> - u16 wIndex;
> - u16 wLength;
> - u8 u8Dir;/0:OUT, 1:IN /
> - u8 u8InData;
> -};
> -
> -struct DR_VARIABLE_STRUCT {
> - u8 offset;
> - u32 variable;
> -};
> -
> -/ oid_rtl_seg_87_11_00 /
> -uint oid_rt_pro_read_register_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_write_register_hdl(struct oid_par_priv poid_par_priv);
> -/ oid_rtl_seg_81_80_00 /
> -uint oid_rt_pro_set_data_rate_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_start_test_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_stop_test_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_channel_direct_call_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_antenna_bb_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_tx_power_control_hdl(
> - struct oid_par_priv poid_par_priv);
> -/ oid_rtl_seg_81_80_20 /
> -uint oid_rt_pro_query_tx_packet_sent_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_query_rx_packet_received_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_query_rx_packet_crc32_error_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_reset_tx_packet_sent_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_reset_rx_packet_received_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_modulation_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_continuous_tx_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_single_carrier_tx_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_carrier_suppression_tx_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_set_single_tone_tx_hdl(
> - struct oid_par_priv poid_par_priv);
> -/ oid_rtl_seg_81_87 /
> -uint oid_rt_pro_write_bb_reg_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_read_bb_reg_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_write_rf_reg_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_read_rf_reg_hdl(struct oid_par_priv poid_par_priv);
> -/ oid_rtl_seg_81_85 /
> -uint oid_rt_wireless_mode_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_read_efuse_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_write_efuse_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_efuse_current_size_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_efuse_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_pro_efuse_map_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_set_bandwidth_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_set_rx_packet_type_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_efuse_max_size_hdl(struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_thermal_meter_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_reset_phy_rx_packet_count_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_phy_rx_packet_received_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_phy_rx_packet_crc32_error_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_set_power_down_hdl(
> - struct oid_par_priv poid_par_priv);
> -uint oid_rt_get_power_mode_hdl(
> - struct oid_par_priv poid_par_priv);
> -#ifdef RTL871X_MP_IOCTL_C / CAUTION!!! /
> -/ This ifdef MUST be left in!! /
> -
> -#else / RTL871X_MP_IOCTL_C /
> -extern struct oid_obj_priv oid_rtl_seg_81_87[5];
> -extern struct oid_obj_priv oid_rtl_seg_87_11_00[32];
> -extern struct oid_obj_priv oid_rtl_seg_87_11_20[5];
> -extern struct oid_obj_priv oid_rtl_seg_87_11_50[2];
> -extern struct oid_obj_priv oid_rtl_seg_87_11_80[1];
> -extern struct oid_obj_priv oid_rtl_seg_87_11_B0[1];
> -extern struct oid_obj_priv oid_rtl_seg_87_11_F0[16];
> -extern struct oid_obj_priv oid_rtl_seg_87_12_00[32];
> -
> -#endif / RTL871X_MP_IOCTL_C /
> -
> -enum MP_MODE {
> - MP_START_MODE,
> - MP_STOP_MODE,
> - MP_ERR_MODE
> -};
> -
> -struct rwreg_param {
> - unsigned int offset;
> - unsigned int width;
> - unsigned int value;
> -};
> -
> -struct bbreg_param {
> - unsigned int offset;
> - unsigned int phymask;
> - unsigned int value;
> -};
> -
> -struct txpower_param {
> - unsigned int pwr_index;
> -};
> -
> -struct datarate_param {
> - unsigned int rate_index;
> -};
> -
> -struct rfintfs_parm {
> - unsigned int rfintfs;
> -};
> -
> -struct mp_xmit_packet {
> - unsigned int len;
> -};
> -
> -struct psmode_param {
> - unsigned int ps_mode;
> - unsigned int smart_ps;
> -};
> -
> -struct mp_ioctl_handler {
> - unsigned int paramsize;
> - unsigned int (handler)(struct oid_par_priv poid_par_priv);
> - unsigned int oid;
> -};
> -
> -struct mp_ioctl_param {
> - unsigned int subcode;
> - unsigned int len;
> - unsigned char data[];
> -};
> -
> -#define GEN_MP_IOCTL_SUBCODE(code) MP_IOCTL ## code ## CMD
> -
> -enum RTL871X_MP_IOCTL_SUBCODE {
> - GEN_MP_IOCTL_SUBCODE(MP_START), /0/
> - GEN_MP_IOCTL_SUBCODE(MP_STOP), /1/
> - GEN_MP_IOCTL_SUBCODE(READ_REG), /2/
> - GEN_MP_IOCTL_SUBCODE(WRITE_REG),
> - GEN_MP_IOCTL_SUBCODE(SET_CHANNEL), /4/
> - GEN_MP_IOCTL_SUBCODE(SET_TXPOWER), /5/
> - GEN_MP_IOCTL_SUBCODE(SET_DATARATE), /6/
> - GEN_MP_IOCTL_SUBCODE(READ_BB_REG), /7/
> - GEN_MP_IOCTL_SUBCODE(WRITE_BB_REG),
> - GEN_MP_IOCTL_SUBCODE(READ_RF_REG), /9/
> - GEN_MP_IOCTL_SUBCODE(WRITE_RF_REG),
> - GEN_MP_IOCTL_SUBCODE(SET_RF_INTFS),
> - GEN_MP_IOCTL_SUBCODE(IOCTL_XMIT_PACKET), /12/
> - GEN_MP_IOCTL_SUBCODE(PS_STATE), /13/
> - GEN_MP_IOCTL_SUBCODE(READ16_EEPROM), /14/
> - GEN_MP_IOCTL_SUBCODE(WRITE16_EEPROM), /15/
> - GEN_MP_IOCTL_SUBCODE(SET_PTM), /16/
> - GEN_MP_IOCTL_SUBCODE(READ_TSSI), /17/
> - GEN_MP_IOCTL_SUBCODE(CNTU_TX), /18/
> - GEN_MP_IOCTL_SUBCODE(SET_BANDWIDTH), /19/
> - GEN_MP_IOCTL_SUBCODE(SET_RX_PKT_TYPE), /20/
> - GEN_MP_IOCTL_SUBCODE(RESET_PHY_RX_PKT_CNT), /21/
> - GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_RECV), /22/
> - GEN_MP_IOCTL_SUBCODE(GET_PHY_RX_PKT_ERROR), /23/
> - GEN_MP_IOCTL_SUBCODE(SET_POWER_DOWN), /24/
> - GEN_MP_IOCTL_SUBCODE(GET_THERMAL_METER), /25/
> - GEN_MP_IOCTL_SUBCODE(GET_POWER_MODE), /26/
> - GEN_MP_IOCTL_SUBCODE(EFUSE), /27/
> - GEN_MP_IOCTL_SUBCODE(EFUSE_MAP), /28/
> - GEN_MP_IOCTL_SUBCODE(GET_EFUSE_MAX_SIZE), /29/
> - GEN_MP_IOCTL_SUBCODE(GET_EFUSE_CURRENT_SIZE), /30/
> - GEN_MP_IOCTL_SUBCODE(SC_TX), /31/
> - GEN_MP_IOCTL_SUBCODE(CS_TX), /32/
> - GEN_MP_IOCTL_SUBCODE(ST_TX), /33/
> - GEN_MP_IOCTL_SUBCODE(SET_ANTENNA), /34/
> - MAX_MP_IOCTL_SUBCODE,
> -};
> -
> -unsigned int mp_ioctl_xmit_packet_hdl(struct oid_par_priv poid_par_priv)=
;
> -
> -#ifdef RTL871X_MP_IOCTL_C / CAUTION!!! /
> -/ This ifdef MUST be left in!! /
> -
> -static struct mp_ioctl_handler mp_ioctl_hdl[] =3D {
> - {sizeof(u32), oid_rt_pro_start_test_hdl,
> - OID_RT_PRO_START_TEST},/0/
> - {sizeof(u32), oid_rt_pro_stop_test_hdl,
> - OID_RT_PRO_STOP_TEST},/1/
> - {sizeof(struct rwreg_param),
> - oid_rt_pro_read_register_hdl,
> - OID_RT_PRO_READ_REGISTER},/2/
> - {sizeof(struct rwreg_param),
> - oid_rt_pro_write_register_hdl,
> - OID_RT_PRO_WRITE_REGISTER},
> - {sizeof(u32),
> - oid_rt_pro_set_channel_direct_call_hdl,
> - OID_RT_PRO_SET_CHANNEL_DIRECT_CALL},
> - {sizeof(struct txpower_param),
> - oid_rt_pro_set_tx_power_control_hdl,
> - OID_RT_PRO_SET_TX_POWER_CONTROL},
> - {sizeof(u32),
> - oid_rt_pro_set_data_rate_hdl,
> - OID_RT_PRO_SET_DATA_RATE},
> - {sizeof(struct bb_reg_param),
> - oid_rt_pro_read_bb_reg_hdl,
> - OID_RT_PRO_READ_BB_REG},/7/
> - {sizeof(struct bb_reg_param),
> - oid_rt_pro_write_bb_reg_hdl,
> - OID_RT_PRO_WRITE_BB_REG},
> - {sizeof(struct rwreg_param),
> - oid_rt_pro_read_rf_reg_hdl,
> - OID_RT_PRO_RF_READ_REGISTRY},/9/
> - {sizeof(struct rwreg_param),
> - oid_rt_pro_write_rf_reg_hdl,
> - OID_RT_PRO_RF_WRITE_REGISTRY},
> - {sizeof(struct rfintfs_parm), NULL, 0},
> - {0, mp_ioctl_xmit_packet_hdl, 0},/12/
> - {sizeof(struct psmode_param), NULL, 0},/13/
> - {sizeof(struct eeprom_rw_param), NULL, 0},/14/
> - {sizeof(struct eeprom_rw_param), NULL, 0},/15/
> - {sizeof(unsigned char), NULL, 0},/16/
> - {sizeof(u32), NULL, 0},/17/
> - {sizeof(u32), oid_rt_pro_set_continuous_tx_hdl,
> - OID_RT_PRO_SET_CONTINUOUS_TX},/18/
> - {sizeof(u32), oid_rt_set_bandwidth_hdl,
> - OID_RT_SET_BANDWIDTH},/19/
> - {sizeof(u32), oid_rt_set_rx_packet_type_hdl,
> - OID_RT_SET_RX_PACKET_TYPE},/20/
> - {0, oid_rt_reset_phy_rx_packet_count_hdl,
> - OID_RT_RESET_PHY_RX_PACKET_COUNT},/21/
> - {sizeof(u32), oid_rt_get_phy_rx_packet_received_hdl,
> - OID_RT_GET_PHY_RX_PACKET_RECEIVED},/22/
> - {sizeof(u32), oid_rt_get_phy_rx_packet_crc32_error_hdl,
> - OID_RT_GET_PHY_RX_PACKET_CRC32_ERROR},/23/
> - {sizeof(unsigned char), oid_rt_set_power_down_hdl,
> - OID_RT_SET_POWER_DOWN},/24/
> - {sizeof(u32), oid_rt_get_thermal_meter_hdl,
> - OID_RT_PRO_GET_THERMAL_METER},/25/
> - {sizeof(u32), oid_rt_get_power_mode_hdl,
> - OID_RT_GET_POWER_MODE},/26/
> - {sizeof(struct EFUSE_ACCESS_STRUCT),
> - oid_rt_pro_efuse_hdl, OID_RT_PRO_EFUSE},/27/
> - {EFUSE_MAP_MAX_SIZE, oid_rt_pro_efuse_map_hdl,
> - OID_RT_PRO_EFUSE_MAP},/28/
> - {sizeof(u32), oid_rt_get_efuse_max_size_hdl,
> - OID_RT_GET_EFUSE_MAX_SIZE},/29/
> - {sizeof(u32), oid_rt_get_efuse_current_size_hdl,
> - OID_RT_GET_EFUSE_CURRENT_SIZE},/30/
> - {sizeof(u32), oid_rt_pro_set_single_carrier_tx_hdl,
> - OID_RT_PRO_SET_SINGLE_CARRIER_TX},/31/
> - {sizeof(u32), oid_rt_pro_set_carrier_suppression_tx_hdl,
> - OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX},/32/
> - {sizeof(u32), oid_rt_pro_set_single_tone_tx_hdl,
> - OID_RT_PRO_SET_SINGLE_TONE_TX},/33/
> - {sizeof(u32), oid_rt_pro_set_antenna_bb_hdl,
> - OID_RT_PRO_SET_ANTENNA_BB},/34/
> -};
> -
> -#else / RTL871X_MP_IOCTL_C /
> -extern struct mp_ioctl_handler mp_ioctl_hdl[];
> -#endif / RTL871X_MP_IOCTL_C /
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h b/drivers/st=
aging/rtl8712/rtl871x_mp_phy_regdef.h
> deleted file mode 100644
> index bb9f83d58225..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_mp_phy_regdef.h
> +++ /dev/null
> @@ -1,1034 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - * Copyright(c) 2008, RealTEK Technology Inc. All Right Reserved.
> - *
> - * Module: __INC_HAL8192SPHYREG_H
> - *
> - *
> - * Note: 1. Define PMAC/BB register map
> - * 2. Define RF register map
> - * 3. PMAC/BB register bit mask.
> - * 4. RF reg bit mask.
> - * 5. Other BB/RF relative definition.
> - *
> - *
> - * Export: Constants, macro, functions(API), global variables(None).
> - *
> - * Abbrev:
> - *
> - * History:
> - * Data Who Remark
> - * 08/07/2007 MHC 1. Porting from 9x series PHYCFG.h.
> - * 2. Reorganize code architecture.
> - * 09/25/2008 MH 1. Add RL6052 register definition
> - *
> - ***********************************************************************=
******/
> -#ifndef __RTL871X_MP_PHY_REGDEF_H
> -#define __RTL871X_MP_PHY_REGDEF_H
> -
> -/--------------------------Define Parameters----------------------------=
---/
> -
> -/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * 8192S Register offset definition
> - *=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - *
> - *
> - * BB-PHY register PMAC 0x100 PHY 0x800 - 0xEFF
> - * 1. PMAC duplicate register due to connection: RF_Mode, TRxRN, NumOf L=
-STF
> - * 2. 0x800/0x900/0xA00/0xC00/0xD00/0xE00
> - * 3. RF register 0x00-2E
> - * 4. Bit Mask for BB/RF register
> - * 5. Other definition for BB/RF R/W
> - *
> - * 1. PMAC duplicate register due to connection: RF_Mode, TRxRN, NumOf L=
-STF
> - * 1. Page1(0x100)
> - /
> -#define rPMAC_Reset 0x100
> -#define rPMAC_TxStart 0x104
> -#define rPMAC_TxLegacySIG 0x108
> -#define rPMAC_TxHTSIG1 0x10c
> -#define rPMAC_TxHTSIG2 0x110
> -#define rPMAC_PHYDebug 0x114
> -#define rPMAC_TxPacketNum 0x118
> -#define rPMAC_TxIdle 0x11c
> -#define rPMAC_TxMACHeader0 0x120
> -#define rPMAC_TxMACHeader1 0x124
> -#define rPMAC_TxMACHeader2 0x128
> -#define rPMAC_TxMACHeader3 0x12c
> -#define rPMAC_TxMACHeader4 0x130
> -#define rPMAC_TxMACHeader5 0x134
> -#define rPMAC_TxDataType 0x138
> -#define rPMAC_TxRandomSeed 0x13c
> -#define rPMAC_CCKPLCPPreamble 0x140
> -#define rPMAC_CCKPLCPHeader 0x144
> -#define rPMAC_CCKCRC16 0x148
> -#define rPMAC_OFDMRxCRC32OK 0x170
> -#define rPMAC_OFDMRxCRC32Er 0x174
> -#define rPMAC_OFDMRxParityEr 0x178
> -#define rPMAC_OFDMRxCRC8Er 0x17c
> -#define rPMAC_CCKCRxRC16Er 0x180
> -#define rPMAC_CCKCRxRC32Er 0x184
> -#define rPMAC_CCKCRxRC32OK 0x188
> -#define rPMAC_TxStatus 0x18c
> -
> -/
> - * 2. Page2(0x200)
> - *
> - * The following two definition are only used for USB interface.
> - *#define RF_BB_CMD_ADDR 0x02c0 // RF/BB read/write command address.
> - *#define RF_BB_CMD_DATA 0x02c4 // RF/BB read/write command data.
> - *
> - *
> - * 3. Page8(0x800)
> - */
> -#define rFPGA0_RFMOD 0x800 /*RF mode & CCK TxSC RF
> - * BW Setting??
> - /
> -#define rFPGA0_TxInfo 0x804 / Status report?? /
> -#define rFPGA0_PSDFunction 0x808
> -#define rFPGA0_TxGainStage 0x80c / Set TX PWR init gain? /
> -#define rFPGA0_RFTiming1 0x810 / Useless now /
> -#define rFPGA0_RFTiming2 0x814
> -#define rFPGA0_XA_HSSIParameter1 0x820 / RF 3 wire register /
> -#define rFPGA0_XA_HSSIParameter2 0x824
> -#define rFPGA0_XB_HSSIParameter1 0x828
> -#define rFPGA0_XB_HSSIParameter2 0x82c
> -#define rFPGA0_XC_HSSIParameter1 0x830
> -#define rFPGA0_XC_HSSIParameter2 0x834
> -#define rFPGA0_XD_HSSIParameter1 0x838
> -#define rFPGA0_XD_HSSIParameter2 0x83c
> -#define rFPGA0_XA_LSSIParameter 0x840
> -#define rFPGA0_XB_LSSIParameter 0x844
> -#define rFPGA0_XC_LSSIParameter 0x848
> -#define rFPGA0_XD_LSSIParameter 0x84c
> -
> -#define rFPGA0_RFWakeUpParameter 0x850 / Useless now /
> -#define rFPGA0_RFSleepUpParameter 0x854
> -
> -#define rFPGA0_XAB_SwitchControl 0x858 / RF Channel switch /
> -#define rFPGA0_XCD_SwitchControl 0x85c
> -
> -#define rFPGA0_XA_RFInterfaceOE 0x860 / RF Channel switch /
> -#define rFPGA0_XB_RFInterfaceOE 0x864
> -#define rFPGA0_XC_RFInterfaceOE 0x868
> -#define rFPGA0_XD_RFInterfaceOE 0x86c
> -#define rFPGA0_XAB_RFInterfaceSW 0x870 / RF Interface Software Ctrl /
> -#define rFPGA0_XCD_RFInterfaceSW 0x874
> -
> -#define rFPGA0_XAB_RFParameter 0x878 / RF Parameter /
> -#define rFPGA0_XCD_RFParameter 0x87c
> -
> -#define rFPGA0_AnalogParameter1 0x880 / Crystal cap setting
> - * RF-R/W protection
> - * for parameter4??
> - /
> -#define rFPGA0_AnalogParameter2 0x884
> -#define rFPGA0_AnalogParameter3 0x888 / Useless now /
> -#define rFPGA0_AnalogParameter4 0x88c
> -
> -#define rFPGA0_XA_LSSIReadBack 0x8a0 / Transceiver LSSI Readback /
> -#define rFPGA0_XB_LSSIReadBack 0x8a4
> -#define rFPGA0_XC_LSSIReadBack 0x8a8
> -#define rFPGA0_XD_LSSIReadBack 0x8ac
> -
> -#define rFPGA0_PSDReport 0x8b4 / Useless now /
> -#define rFPGA0_XAB_RFInterfaceRB 0x8e0 / Useless now /
> -#define rFPGA0_XCD_RFInterfaceRB 0x8e4 / Useless now /
> -
> -/
> - * 4. Page9(0x900)
> - /
> -#define rFPGA1_RFMOD 0x900 / RF mode & OFDM TxSC /
> -
> -#define rFPGA1_TxBlock 0x904 / Useless now /
> -#define rFPGA1_DebugSelect 0x908 / Useless now /
> -#define rFPGA1_TxInfo 0x90c / Useless now /
> -
> -/
> - * 5. PageA(0xA00)
> - *
> - * Set Control channel to upper or lower.
> - * These settings are required only for 40MHz
> - /
> -#define rCCK0_System 0xa00
> -
> -#define rCCK0_AFESetting 0xa04 / Disable init gain now /
> -#define rCCK0_CCA 0xa08 / Disable init gain now /
> -
> -#define rCCK0_RxAGC1 0xa0c
> -/ AGC default value, saturation level
> - * Antenna Diversity, RX AGC, LNA Threshold, RX LNA Threshold useless no=
w.
> - * Not the same as 90 series
> - /
> -#define rCCK0_RxAGC2 0xa10 / AGC & DAGC /
> -
> -#define rCCK0_RxHP 0xa14
> -
> -#define rCCK0_DSPParameter1 0xa18 / Timing recovery & Channel
> - * estimation threshold
> - /
> -#define rCCK0_DSPParameter2 0xa1c / SQ threshold /
> -
> -#define rCCK0_TxFilter1 0xa20
> -#define rCCK0_TxFilter2 0xa24
> -#define rCCK0_DebugPort 0xa28 / debug port and Tx filter3 /
> -#define rCCK0_FalseAlarmReport 0xa2c / 0xa2d useless now 0xa30-a4f
> - * channel report
> - /
> -#define rCCK0_TRSSIReport 0xa50
> -#define rCCK0_RxReport 0xa54 / 0xa57 /
> -#define rCCK0_FACounterLower 0xa5c / 0xa5b /
> -#define rCCK0_FACounterUpper 0xa58 / 0xa5c /
> -
> -/
> - * 6. PageC(0xC00)
> - */
> -#define rOFDM0_LSTF 0xc00
> -#define rOFDM0_TRxPathEnable 0xc04
> -#define rOFDM0_TRMuxPar 0xc08
> -#define rOFDM0_TRSWIsolation 0xc0c
> -
> -/*RxIQ DC offset, Rx digital filter, DC notch filter /
> -#define rOFDM0_XARxAFE 0xc10
> -#define rOFDM0_XARxIQImbalance 0xc14 / RxIQ imbalance matrix /
> -#define rOFDM0_XBRxAFE 0xc18
> -#define rOFDM0_XBRxIQImbalance 0xc1c
> -#define rOFDM0_XCRxAFE 0xc20
> -#define rOFDM0_XCRxIQImbalance 0xc24
> -#define rOFDM0_XDRxAFE 0xc28
> -#define rOFDM0_XDRxIQImbalance 0xc2c
> -
> -#define rOFDM0_RxDetector1 0xc30 / PD,BW & SBD DM tune
> - * init gain
> - /
> -#define rOFDM0_RxDetector2 0xc34 / SBD & Fame Sync. /
> -#define rOFDM0_RxDetector3 0xc38 / Frame Sync. /
> -#define rOFDM0_RxDetector4 0xc3c / PD, SBD, Frame Sync &
> - * Short-GI
> - /
> -
> -#define rOFDM0_RxDSP 0xc40 / Rx Sync Path /
> -#define rOFDM0_CFOandDAGC 0xc44 / CFO & DAGC /
> -#define rOFDM0_CCADropThreshold 0xc48 / CCA Drop threshold /
> -#define rOFDM0_ECCAThreshold 0xc4c / energy CCA /
> -
> -#define rOFDM0_XAAGCCore1 0xc50 / DIG /
> -#define rOFDM0_XAAGCCore2 0xc54
> -#define rOFDM0_XBAGCCore1 0xc58
> -#define rOFDM0_XBAGCCore2 0xc5c
> -#define rOFDM0_XCAGCCore1 0xc60
> -#define rOFDM0_XCAGCCore2 0xc64
> -#define rOFDM0_XDAGCCore1 0xc68
> -#define rOFDM0_XDAGCCore2 0xc6c
> -#define rOFDM0_AGCParameter1 0xc70
> -#define rOFDM0_AGCParameter2 0xc74
> -#define rOFDM0_AGCRSSITable 0xc78
> -#define rOFDM0_HTSTFAGC 0xc7c
> -
> -#define rOFDM0_XATxIQImbalance 0xc80 / TX PWR TRACK and DIG /
> -#define rOFDM0_XATxAFE 0xc84
> -#define rOFDM0_XBTxIQImbalance 0xc88
> -#define rOFDM0_XBTxAFE 0xc8c
> -#define rOFDM0_XCTxIQImbalance 0xc90
> -#define rOFDM0_XCTxAFE 0xc94
> -#define rOFDM0_XDTxIQImbalance 0xc98
> -#define rOFDM0_XDTxAFE 0xc9c
> -
> -#define rOFDM0_RxHPParameter 0xce0
> -#define rOFDM0_TxPseudoNoiseWgt 0xce4
> -#define rOFDM0_FrameSync 0xcf0
> -#define rOFDM0_DFSReport 0xcf4
> -#define rOFDM0_TxCoeff1 0xca4
> -#define rOFDM0_TxCoeff2 0xca8
> -#define rOFDM0_TxCoeff3 0xcac
> -#define rOFDM0_TxCoeff4 0xcb0
> -#define rOFDM0_TxCoeff5 0xcb4
> -#define rOFDM0_TxCoeff6 0xcb8
> -
> -/
> - * 7. PageD(0xD00)
> - /
> -#define rOFDM1_LSTF 0xd00
> -#define rOFDM1_TRxPathEnable 0xd04
> -
> -#define rOFDM1_CFO 0xd08 / No setting now /
> -#define rOFDM1_CSI1 0xd10
> -#define rOFDM1_SBD 0xd14
> -#define rOFDM1_CSI2 0xd18
> -#define rOFDM1_CFOTracking 0xd2c
> -#define rOFDM1_TRxMesaure1 0xd34
> -#define rOFDM1_IntfDet 0xd3c
> -#define rOFDM1_PseudoNoiseStateAB 0xd50
> -#define rOFDM1_PseudoNoiseStateCD 0xd54
> -#define rOFDM1_RxPseudoNoiseWgt 0xd58
> -
> -#define rOFDM_PHYCounter1 0xda0 / cca, parity fail /
> -#define rOFDM_PHYCounter2 0xda4 / rate illegal, crc8 fail /
> -#define rOFDM_PHYCounter3 0xda8 / MCS not support /
> -#define rOFDM_ShortCFOAB 0xdac / No setting now /
> -#define rOFDM_ShortCFOCD 0xdb0
> -#define rOFDM_LongCFOAB 0xdb4
> -#define rOFDM_LongCFOCD 0xdb8
> -#define rOFDM_TailCFOAB 0xdbc
> -#define rOFDM_TailCFOCD 0xdc0
> -#define rOFDM_PWMeasure1 0xdc4
> -#define rOFDM_PWMeasure2 0xdc8
> -#define rOFDM_BWReport 0xdcc
> -#define rOFDM_AGCReport 0xdd0
> -#define rOFDM_RxSNR 0xdd4
> -#define rOFDM_RxEVMCSI 0xdd8
> -#define rOFDM_SIGReport 0xddc
> -
> -/
> - * 8. PageE(0xE00)
> - /
> -#define rTxAGC_Rate18_06 0xe00
> -#define rTxAGC_Rate54_24 0xe04
> -#define rTxAGC_CCK_Mcs32 0xe08
> -#define rTxAGC_Mcs03_Mcs00 0xe10
> -#define rTxAGC_Mcs07_Mcs04 0xe14
> -#define rTxAGC_Mcs11_Mcs08 0xe18
> -#define rTxAGC_Mcs15_Mcs12 0xe1c
> -
> -/ Analog- control in RX_WAIT_CCA : REG: EE0
> - * [Analog- Power & Control Register]
> - /
> -#define rRx_Wait_CCCA 0xe70
> -#define rAnapar_Ctrl_BB 0xee0
> -
> -/
> - * 7. RF Register 0x00-0x2E (RF 8256)
> - * RF-0222D 0x00-3F
> - *
> - * Zebra1
> - /
> -#define rZebra1_HSSIEnable 0x0 / Useless now /
> -#define rZebra1_TRxEnable1 0x1
> -#define rZebra1_TRxEnable2 0x2
> -#define rZebra1_AGC 0x4
> -#define rZebra1_ChargePump 0x5
> -#define rZebra1_Channel 0x7 / RF channel switch /
> -#define rZebra1_TxGain 0x8 / Useless now /
> -#define rZebra1_TxLPF 0x9
> -#define rZebra1_RxLPF 0xb
> -#define rZebra1_RxHPFCorner 0xc
> -
> -/ Zebra4 /
> -#define rGlobalCtrl 0 / Useless now /
> -#define rRTL8256_TxLPF 19
> -#define rRTL8256_RxLPF 11
> -
> -/ RTL8258 /
> -#define rRTL8258_TxLPF 0x11 / Useless now /
> -#define rRTL8258_RxLPF 0x13
> -#define rRTL8258_RSSILPF 0xa
> -
> -/ RL6052 Register definition /
> -#define RF_AC 0x00
> -#define RF_IQADJ_G1 0x01
> -#define RF_IQADJ_G2 0x02
> -#define RF_POW_TRSW 0x05
> -
> -#define RF_GAIN_RX 0x06
> -#define RF_GAIN_TX 0x07
> -
> -#define RF_TXM_IDAC 0x08
> -#define RF_BS_IQGEN 0x0F
> -
> -#define RF_MODE1 0x10
> -#define RF_MODE2 0x11
> -
> -#define RF_RX_AGC_HP 0x12
> -#define RF_TX_AGC 0x13
> -#define RF_BIAS 0x14
> -#define RF_IPA 0x15
> -#define RF_POW_ABILITY 0x17
> -#define RF_MODE_AG 0x18
> -#define rRfChannel 0x18 / RF channel and BW switch /
> -#define RF_CHNLBW 0x18 / RF channel and BW switch /
> -#define RF_TOP 0x19
> -#define RF_RX_G1 0x1A
> -#define RF_RX_G2 0x1B
> -#define RF_RX_BB2 0x1C
> -#define RF_RX_BB1 0x1D
> -
> -#define RF_RCK1 0x1E
> -#define RF_RCK2 0x1F
> -
> -#define RF_TX_G1 0x20
> -#define RF_TX_G2 0x21
> -#define RF_TX_G3 0x22
> -
> -#define RF_TX_BB1 0x23
> -#define RF_T_METER 0x24
> -
> -#define RF_SYN_G1 0x25 / RF TX Power control /
> -#define RF_SYN_G2 0x26 / RF TX Power control /
> -#define RF_SYN_G3 0x27 / RF TX Power control /
> -#define RF_SYN_G4 0x28 / RF TX Power control /
> -#define RF_SYN_G5 0x29 / RF TX Power control /
> -#define RF_SYN_G6 0x2A / RF TX Power control /
> -#define RF_SYN_G7 0x2B / RF TX Power control /
> -#define RF_SYN_G8 0x2C / RF TX Power control /
> -
> -#define RF_RCK_OS 0x30 / RF TX PA control /
> -
> -#define RF_TXPA_G1 0x31 / RF TX PA control /
> -#define RF_TXPA_G2 0x32 / RF TX PA control /
> -#define RF_TXPA_G3 0x33 / RF TX PA control /
> -
> -/
> - * Bit Mask
> - *
> - * 1. Page1(0x100)
> - /
> -#define bBBResetB 0x100 / Useless now? */
> -#define bGlobalResetB 0x200
> -#define bOFDMTxStart 0x4
> -#define bCCKTxStart 0x8
> -#define bCRC32Debug 0x100
> -#define bPMACLoopback 0x10
> -#define bTxLSIG 0xffffff
> -#define bOFDMTxRate 0xf
> -#define bOFDMTxReserved 0x10
> -#define bOFDMTxLength 0x1ffe0
> -#define bOFDMTxParity 0x20000
> -#define bTxHTSIG1 0xffffff
> -#define bTxHTMCSRate 0x7f
> -#define bTxHTBW 0x80
> -#define bTxHTLength 0xffff00
> -#define bTxHTSIG2 0xffffff
> -#define bTxHTSmoothing 0x1
> -#define bTxHTSounding 0x2
> -#define bTxHTReserved 0x4
> -#define bTxHTAggreation 0x8
> -#define bTxHTSTBC 0x30
> -#define bTxHTAdvanceCoding 0x40
> -#define bTxHTShortGI 0x80
> -#define bTxHTNumberHT_LTF 0x300
> -#define bTxHTCRC8 0x3fc00
> -#define bCounterReset 0x10000
> -#define bNumOfOFDMTx 0xffff
> -#define bNumOfCCKTx 0xffff0000
> -#define bTxIdleInterval 0xffff
> -#define bOFDMService 0xffff0000
> -#define bTxMACHeader 0xffffffff
> -#define bTxDataInit 0xff
> -#define bTxHTMode 0x100
> -#define bTxDataType 0x30000
> -#define bTxRandomSeed 0xffffffff
> -#define bCCKTxPreamble 0x1
> -#define bCCKTxSFD 0xffff0000
> -#define bCCKTxSIG 0xff
> -#define bCCKTxService 0xff00
> -#define bCCKLengthExt 0x8000
> -#define bCCKTxLength 0xffff0000
> -#define bCCKTxCRC16 0xffff
> -#define bCCKTxStatus 0x1
> -#define bOFDMTxStatus 0x2
> -#define IS_BB_REG_OFFSET_92S(_Offset) ((_Offset >=3D 0x800) && \
>=20
> - (_Offset <=3D 0xfff))
> -
> -/* 2. Page8(0x800) /
> -#define bRFMOD 0x1 / Reg 0x800 rFPGA0_RFMOD /
> -#define bJapanMode 0x2
> -#define bCCKTxSC 0x30
> -#define bCCKEn 0x1000000
> -#define bOFDMEn 0x2000000
> -
> -#define bOFDMRxADCPhase 0x10000 / Useless now /
> -#define bOFDMTxDACPhase 0x40000
> -#define bXATxAGC 0x3f
> -#define bXBTxAGC 0xf00 / Reg 80c rFPGA0_TxGainStage /
> -#define bXCTxAGC 0xf000
> -#define bXDTxAGC 0xf0000
> -
> -#define bPAStart 0xf0000000 / Useless now /
> -#define bTRStart 0x00f00000
> -#define bRFStart 0x0000f000
> -#define bBBStart 0x000000f0
> -#define bBBCCKStart 0x0000000f
> -#define bPAEnd 0xf / Reg0x814 /
> -#define bTREnd 0x0f000000
> -#define bRFEnd 0x000f0000
> -#define bCCAMask 0x000000f0 / T2R /
> -#define bR2RCCAMask 0x00000f00
> -#define bHSSI_R2TDelay 0xf8000000
> -#define bHSSI_T2RDelay 0xf80000
> -#define bContTxHSSI 0x400 / change gain at continue Tx /
> -#define bIGFromCCK 0x200
> -#define bAGCAddress 0x3f
> -#define bRxHPTx 0x7000
> -#define bRxHPT2R 0x38000
> -#define bRxHPCCKIni 0xc0000
> -#define bAGCTxCode 0xc00000
> -#define bAGCRxCode 0x300000
> -#define b3WireDataLength 0x800 / Reg 0x820~84f rFPGA0_XA_HSSIParm1 /
> -#define b3WireAddressLength 0x400
> -#define b3WireRFPowerDown 0x1 / Useless now /
> -#define b5GPAPEPolarity 0x40000000
> -#define b2GPAPEPolarity 0x80000000
> -#define bRFSW_TxDefaultAnt 0x3
> -#define bRFSW_TxOptionAnt 0x30
> -#define bRFSW_RxDefaultAnt 0x300
> -#define bRFSW_RxOptionAnt 0x3000
> -#define bRFSI_3WireData 0x1
> -#define bRFSI_3WireClock 0x2
> -#define bRFSI_3WireLoad 0x4
> -#define bRFSI_3WireRW 0x8
> -#define bRFSI_3Wire 0xf
> -#define bRFSI_RFENV 0x10 / Reg 0x870 rFPGA0_XAB_RFInterfaceSW /
> -#define bRFSI_TRSW 0x20 / Useless now /
> -#define bRFSI_TRSWB 0x40
> -#define bRFSI_ANTSW 0x100
> -#define bRFSI_ANTSWB 0x200
> -#define bRFSI_PAPE 0x400
> -#define bRFSI_PAPE5G 0x800
> -#define bBandSelect 0x1
> -#define bHTSIG2_GI 0x80
> -#define bHTSIG2_Smoothing 0x01
> -#define bHTSIG2_Sounding 0x02
> -#define bHTSIG2_Aggreaton 0x08
> -#define bHTSIG2_STBC 0x30
> -#define bHTSIG2_AdvCoding 0x40
> -#define bHTSIG2_NumOfHTLTF 0x300
> -#define bHTSIG2_CRC8 0x3fc
> -#define bHTSIG1_MCS 0x7f
> -#define bHTSIG1_BandWidth 0x80
> -#define bHTSIG1_HTLength 0xffff
> -#define bLSIG_Rate 0xf
> -#define bLSIG_Reserved 0x10
> -#define bLSIG_Length 0x1fffe
> -#define bLSIG_Parity 0x20
> -#define bCCKRxPhase 0x4
> -#define bLSSIReadAddress 0x7f800000 / T65 RF /
> -#define bLSSIReadEdge 0x80000000 / LSSI "Read" edge signal /
> -#define bLSSIReadBackData 0xfffff / T65 RF /
> -#define bLSSIReadOKFlag 0x1000 / Useless now /
> -#define bCCKSampleRate 0x8 /0: 44MHz, 1:88MHz/
> -#define bRegulator0Standby 0x1
> -#define bRegulatorPLLStandby 0x2
> -#define bRegulator1Standby 0x4
> -#define bPLLPowerUp 0x8
> -#define bDPLLPowerUp 0x10
> -#define bDA10PowerUp 0x20
> -#define bAD7PowerUp 0x200
> -#define bDA6PowerUp 0x2000
> -#define bXtalPowerUp 0x4000
> -#define b40MDClkPowerUP 0x8000
> -#define bDA6DebugMode 0x20000
> -#define bDA6Swing 0x380000
> -
> -/ Reg 0x880 rFPGA0_AnalogParameter1 20/40 CCK support switch 40/80 BB MH=
Z /
> -#define bADClkPhase 0x4000000
> -
> -#define b80MClkDelay 0x18000000 / Useless /
> -#define bAFEWatchDogEnable 0x20000000
> -
> -/ Reg 0x884 rFPGA0_AnalogParameter2 Crystal cap /
> -#define bXtalCap01 0xc0000000
> -#define bXtalCap23 0x3
> -#define bXtalCap92x 0x0f000000
> -#define bXtalCap 0x0f000000
> -#define bIntDifClkEnable 0x400 / Useless /
> -#define bExtSigClkEnable 0x800
> -#define bBandgapMbiasPowerUp 0x10000
> -#define bAD11SHGain 0xc0000
> -#define bAD11InputRange 0x700000
> -#define bAD11OPCurrent 0x3800000
> -#define bIPathLoopback 0x4000000
> -#define bQPathLoopback 0x8000000
> -#define bAFELoopback 0x10000000
> -#define bDA10Swing 0x7e0
> -#define bDA10Reverse 0x800
> -#define bDAClkSource 0x1000
> -#define bAD7InputRange 0x6000
> -#define bAD7Gain 0x38000
> -#define bAD7OutputCMMode 0x40000
> -#define bAD7InputCMMode 0x380000
> -#define bAD7Current 0xc00000
> -#define bRegulatorAdjust 0x7000000
> -#define bAD11PowerUpAtTx 0x1
> -#define bDA10PSAtTx 0x10
> -#define bAD11PowerUpAtRx 0x100
> -#define bDA10PSAtRx 0x1000
> -#define bCCKRxAGCFormat 0x200
> -#define bPSDFFTSamplepPoint 0xc000
> -#define bPSDAverageNum 0x3000
> -#define bIQPathControl 0xc00
> -#define bPSDFreq 0x3ff
> -#define bPSDAntennaPath 0x30
> -#define bPSDIQSwitch 0x40
> -#define bPSDRxTrigger 0x400000
> -#define bPSDTxTrigger 0x80000000
> -#define bPSDSineToneScale 0x7f000000
> -#define bPSDReport 0xffff
> -
> -/ 3. Page9(0x900) /
> -#define bOFDMTxSC 0x30000000 / Useless /
> -#define bCCKTxOn 0x1
> -#define bOFDMTxOn 0x2
> -#define bDebugPage 0xfff / reset debug page and HWord, LWord /
> -#define bDebugItem 0xff / reset debug page and LWord /
> -#define bAntL 0x10
> -#define bAntNonHT 0x100
> -#define bAntHT1 0x1000
> -#define bAntHT2 0x10000
> -#define bAntHT1S1 0x100000
> -#define bAntNonHTS1 0x1000000
> -
> -/ 4. PageA(0xA00) /
> -#define bCCKBBMode 0x3 / Useless /
> -#define bCCKTxPowerSaving 0x80
> -#define bCCKRxPowerSaving 0x40
> -
> -#define bCCKSideBand 0x10 / Reg 0xa00 rCCK0_System 20/40 switch*/
> -#define bCCKScramble 0x8 /* Useless /
> -#define bCCKAntDiversity 0x8000
> -#define bCCKCarrierRecovery 0x4000
> -#define bCCKTxRate 0x3000
> -#define bCCKDCCancel 0x0800
> -#define bCCKISICancel 0x0400
> -#define bCCKMatchFilter 0x0200
> -#define bCCKEqualizer 0x0100
> -#define bCCKPreambleDetect 0x800000
> -#define bCCKFastFalseCCA 0x400000
> -#define bCCKChEstStart 0x300000
> -#define bCCKCCACount 0x080000
> -#define bCCKcs_lim 0x070000
> -#define bCCKBistMode 0x80000000
> -#define bCCKCCAMask 0x40000000
> -#define bCCKTxDACPhase 0x4
> -#define bCCKRxADCPhase 0x20000000 / r_rx_clk /
> -#define bCCKr_cp_mode0 0x0100
> -#define bCCKTxDCOffset 0xf0
> -#define bCCKRxDCOffset 0xf
> -#define bCCKCCAMode 0xc000
> -#define bCCKFalseCS_lim 0x3f00
> -#define bCCKCS_ratio 0xc00000
> -#define bCCKCorgBit_sel 0x300000
> -#define bCCKPD_lim 0x0f0000
> -#define bCCKNewCCA 0x80000000
> -#define bCCKRxHPofIG 0x8000
> -#define bCCKRxIG 0x7f00
> -#define bCCKLNAPolarity 0x800000
> -#define bCCKRx1stGain 0x7f0000
> -#define bCCKRFExtend 0x20000000 / CCK Rx initial gain polarity /
> -#define bCCKRxAGCSatLevel 0x1f000000
> -#define bCCKRxAGCSatCount 0xe0
> -#define bCCKRxRFSettle 0x1f / AGCsamp_dly /
> -#define bCCKFixedRxAGC 0x8000
> -#define bCCKAntennaPolarity 0x2000
> -#define bCCKTxFilterType 0x0c00
> -#define bCCKRxAGCReportType 0x0300
> -#define bCCKRxDAGCEn 0x80000000
> -#define bCCKRxDAGCPeriod 0x20000000
> -#define bCCKRxDAGCSatLevel 0x1f000000
> -#define bCCKTimingRecovery 0x800000
> -#define bCCKTxC0 0x3f0000
> -#define bCCKTxC1 0x3f000000
> -#define bCCKTxC2 0x3f
> -#define bCCKTxC3 0x3f00
> -#define bCCKTxC4 0x3f0000
> -#define bCCKTxC5 0x3f000000
> -#define bCCKTxC6 0x3f
> -#define bCCKTxC7 0x3f00
> -#define bCCKDebugPort 0xff0000
> -#define bCCKDACDebug 0x0f000000
> -#define bCCKFalseAlarmEnable 0x8000
> -#define bCCKFalseAlarmRead 0x4000
> -#define bCCKTRSSI 0x7f
> -#define bCCKRxAGCReport 0xfe
> -#define bCCKRxReport_AntSel 0x80000000
> -#define bCCKRxReport_MFOff 0x40000000
> -#define bCCKRxRxReport_SQLoss 0x20000000
> -#define bCCKRxReport_Pktloss 0x10000000
> -#define bCCKRxReport_Lockedbit 0x08000000
> -#define bCCKRxReport_RateError 0x04000000
> -#define bCCKRxReport_RxRate 0x03000000
> -#define bCCKRxFACounterLower 0xff
> -#define bCCKRxFACounterUpper 0xff000000
> -#define bCCKRxHPAGCStart 0xe000
> -#define bCCKRxHPAGCFinal 0x1c00
> -#define bCCKRxFalseAlarmEnable 0x8000
> -#define bCCKFACounterFreeze 0x4000
> -#define bCCKTxPathSel 0x10000000
> -#define bCCKDefaultRxPath 0xc000000
> -#define bCCKOptionRxPath 0x3000000
> -
> -/ 5. PageC(0xC00) /
> -#define bNumOfSTF 0x3 / Useless /
> -#define bShift_L 0xc0
> -#define bGI_TH 0xc
> -#define bRxPathA 0x1
> -#define bRxPathB 0x2
> -#define bRxPathC 0x4
> -#define bRxPathD 0x8
> -#define bTxPathA 0x1
> -#define bTxPathB 0x2
> -#define bTxPathC 0x4
> -#define bTxPathD 0x8
> -#define bTRSSIFreq 0x200
> -#define bADCBackoff 0x3000
> -#define bDFIRBackoff 0xc000
> -#define bTRSSILatchPhase 0x10000
> -#define bRxIDCOffset 0xff
> -#define bRxQDCOffset 0xff00
> -#define bRxDFIRMode 0x1800000
> -#define bRxDCNFType 0xe000000
> -#define bRXIQImb_A 0x3ff
> -#define bRXIQImb_B 0xfc00
> -#define bRXIQImb_C 0x3f0000
> -#define bRXIQImb_D 0xffc00000
> -#define bDC_dc_Notch 0x60000
> -#define bRxNBINotch 0x1f000000
> -#define bPD_TH 0xf
> -#define bPD_TH_Opt2 0xc000
> -#define bPWED_TH 0x700
> -#define bIfMF_Win_L 0x800
> -#define bPD_Option 0x1000
> -#define bMF_Win_L 0xe000
> -#define bBW_Search_L 0x30000
> -#define bwin_enh_L 0xc0000
> -#define bBW_TH 0x700000
> -#define bED_TH2 0x3800000
> -#define bBW_option 0x4000000
> -#define bRatio_TH 0x18000000
> -#define bWindow_L 0xe0000000
> -#define bSBD_Option 0x1
> -#define bFrame_TH 0x1c
> -#define bFS_Option 0x60
> -#define bDC_Slope_check 0x80
> -#define bFGuard_Counter_DC_L 0xe00
> -#define bFrame_Weight_Short 0x7000
> -#define bSub_Tune 0xe00000
> -#define bFrame_DC_Length 0xe000000
> -#define bSBD_start_offset 0x30000000
> -#define bFrame_TH_2 0x7
> -#define bFrame_GI2_TH 0x38
> -#define bGI2_Sync_en 0x40
> -#define bSarch_Short_Early 0x300
> -#define bSarch_Short_Late 0xc00
> -#define bSarch_GI2_Late 0x70000
> -#define bCFOAntSum 0x1
> -#define bCFOAcc 0x2
> -#define bCFOStartOffset 0xc
> -#define bCFOLookBack 0x70
> -#define bCFOSumWeight 0x80
> -#define bDAGCEnable 0x10000
> -#define bTXIQImb_A 0x3ff
> -#define bTXIQImb_B 0xfc00
> -#define bTXIQImb_C 0x3f0000
> -#define bTXIQImb_D 0xffc00000
> -#define bTxIDCOffset 0xff
> -#define bTxQDCOffset 0xff00
> -#define bTxDFIRMode 0x10000
> -#define bTxPesudoNoiseOn 0x4000000
> -#define bTxPesudoNoise_A 0xff
> -#define bTxPesudoNoise_B 0xff00
> -#define bTxPesudoNoise_C 0xff0000
> -#define bTxPesudoNoise_D 0xff000000
> -#define bCCADropOption 0x20000
> -#define bCCADropThres 0xfff00000
> -#define bEDCCA_H 0xf
> -#define bEDCCA_L 0xf0
> -#define bLambda_ED 0x300
> -#define bRxInitialGain 0x7f
> -#define bRxAntDivEn 0x80
> -#define bRxAGCAddressForLNA 0x7f00
> -#define bRxHighPowerFlow 0x8000
> -#define bRxAGCFreezeThres 0xc0000
> -#define bRxFreezeStep_AGC1 0x300000
> -#define bRxFreezeStep_AGC2 0xc00000
> -#define bRxFreezeStep_AGC3 0x3000000
> -#define bRxFreezeStep_AGC0 0xc000000
> -#define bRxRssi_Cmp_En 0x10000000
> -#define bRxQuickAGCEn 0x20000000
> -#define bRxAGCFreezeThresMode 0x40000000
> -#define bRxOverFlowCheckType 0x80000000
> -#define bRxAGCShift 0x7f
> -#define bTRSW_Tri_Only 0x80
> -#define bPowerThres 0x300
> -#define bRxAGCEn 0x1
> -#define bRxAGCTogetherEn 0x2
> -#define bRxAGCMin 0x4
> -#define bRxHP_Ini 0x7
> -#define bRxHP_TRLNA 0x70
> -#define bRxHP_RSSI 0x700
> -#define bRxHP_BBP1 0x7000
> -#define bRxHP_BBP2 0x70000
> -#define bRxHP_BBP3 0x700000
> -#define bRSSI_H 0x7f0000 / the threshold for high power /
> -#define bRSSI_Gen 0x7f000000 / the threshold for ant divers /
> -#define bRxSettle_TRSW 0x7
> -#define bRxSettle_LNA 0x38
> -#define bRxSettle_RSSI 0x1c0
> -#define bRxSettle_BBP 0xe00
> -#define bRxSettle_RxHP 0x7000
> -#define bRxSettle_AntSW_RSSI 0x38000
> -#define bRxSettle_AntSW 0xc0000
> -#define bRxProcessTime_DAGC 0x300000
> -#define bRxSettle_HSSI 0x400000
> -#define bRxProcessTime_BBPPW 0x800000
> -#define bRxAntennaPowerShift 0x3000000
> -#define bRSSITableSelect 0xc000000
> -#define bRxHP_Final 0x7000000
> -#define bRxHTSettle_BBP 0x7
> -#define bRxHTSettle_HSSI 0x8
> -#define bRxHTSettle_RxHP 0x70
> -#define bRxHTSettle_BBPPW 0x80
> -#define bRxHTSettle_Idle 0x300
> -#define bRxHTSettle_Reserved 0x1c00
> -#define bRxHTRxHPEn 0x8000
> -#define bRxHTAGCFreezeThres 0x30000
> -#define bRxHTAGCTogetherEn 0x40000
> -#define bRxHTAGCMin 0x80000
> -#define bRxHTAGCEn 0x100000
> -#define bRxHTDAGCEn 0x200000
> -#define bRxHTRxHP_BBP 0x1c00000
> -#define bRxHTRxHP_Final 0xe0000000
> -#define bRxPWRatioTH 0x3
> -#define bRxPWRatioEn 0x4
> -#define bRxMFHold 0x3800
> -#define bRxPD_Delay_TH1 0x38
> -#define bRxPD_Delay_TH2 0x1c0
> -#define bRxPD_DC_COUNT_MAX 0x600
> -#define bRxPD_Delay_TH 0x8000
> -#define bRxProcess_Delay 0xf0000
> -#define bRxSearchrange_GI2_Early 0x700000
> -#define bRxFrame_Guard_Counter_L 0x3800000
> -#define bRxSGI_Guard_L 0xc000000
> -#define bRxSGI_Search_L 0x30000000
> -#define bRxSGI_TH 0xc0000000
> -#define bDFSCnt0 0xff
> -#define bDFSCnt1 0xff00
> -#define bDFSFlag 0xf0000
> -#define bMFWeightSum 0x300000
> -#define bMinIdxTH 0x7f000000
> -#define bDAFormat 0x40000
> -#define bTxChEmuEnable 0x01000000
> -#define bTRSWIsolation_A 0x7f
> -#define bTRSWIsolation_B 0x7f00
> -#define bTRSWIsolation_C 0x7f0000
> -#define bTRSWIsolation_D 0x7f000000
> -#define bExtLNAGain 0x7c00
> -
> -/ 6. PageE(0xE00) /
> -#define bSTBCEn 0x4 / Useless /
> -#define bAntennaMapping 0x10
> -#define bNss 0x20
> -#define bCFOAntSumD 0x200
> -#define bPHYCounterReset 0x8000000
> -#define bCFOReportGet 0x4000000
> -#define bOFDMContinueTx 0x10000000
> -#define bOFDMSingleCarrier 0x20000000
> -#define bOFDMSingleTone 0x40000000
> -#define bHTDetect 0x100
> -#define bCFOEn 0x10000
> -#define bCFOValue 0xfff00000
> -#define bSigTone_Re 0x3f
> -#define bSigTone_Im 0x7f00
> -#define bCounter_CCA 0xffff
> -#define bCounter_ParityFail 0xffff0000
> -#define bCounter_RateIllegal 0xffff
> -#define bCounter_CRC8Fail 0xffff0000
> -#define bCounter_MCSNoSupport 0xffff
> -#define bCounter_FastSync 0xffff
> -#define bShortCFO 0xfff
> -#define bShortCFOTLength 12 / total /
> -#define bShortCFOFLength 11 / fraction /
> -#define bLongCFO 0x7ff
> -#define bLongCFOTLength 11
> -#define bLongCFOFLength 11
> -#define bTailCFO 0x1fff
> -#define bTailCFOTLength 13
> -#define bTailCFOFLength 12
> -#define bmax_en_pwdB 0xffff
> -#define bCC_power_dB 0xffff0000
> -#define bnoise_pwdB 0xffff
> -#define bPowerMeasTLength 10
> -#define bPowerMeasFLength 3
> -#define bRx_HT_BW 0x1
> -#define bRxSC 0x6
> -#define bRx_HT 0x8
> -#define bNB_intf_det_on 0x1
> -#define bIntf_win_len_cfg 0x30
> -#define bNB_Intf_TH_cfg 0x1c0
> -#define bRFGain 0x3f
> -#define bTableSel 0x40
> -#define bTRSW 0x80
> -#define bRxSNR_A 0xff
> -#define bRxSNR_B 0xff00
> -#define bRxSNR_C 0xff0000
> -#define bRxSNR_D 0xff000000
> -#define bSNREVMTLength 8
> -#define bSNREVMFLength 1
> -#define bCSI1st 0xff
> -#define bCSI2nd 0xff00
> -#define bRxEVM1st 0xff0000
> -#define bRxEVM2nd 0xff000000
> -#define bSIGEVM 0xff
> -#define bPWDB 0xff00
> -#define bSGIEN 0x10000
> -
> -#define bSFactorQAM1 0xf / Useless /
> -#define bSFactorQAM2 0xf0
> -#define bSFactorQAM3 0xf00
> -#define bSFactorQAM4 0xf000
> -#define bSFactorQAM5 0xf0000
> -#define bSFactorQAM6 0xf0000
> -#define bSFactorQAM7 0xf00000
> -#define bSFactorQAM8 0xf000000
> -#define bSFactorQAM9 0xf0000000
> -#define bCSIScheme 0x100000
> -
> -#define bNoiseLvlTopSet 0x3 / Useless /
> -#define bChSmooth 0x4
> -#define bChSmoothCfg1 0x38
> -#define bChSmoothCfg2 0x1c0
> -#define bChSmoothCfg3 0xe00
> -#define bChSmoothCfg4 0x7000
> -#define bMRCMode 0x800000
> -#define bTHEVMCfg 0x7000000
> -
> -#define bLoopFitType 0x1 / Useless /
> -#define bUpdCFO 0x40
> -#define bUpdCFOOffData 0x80
> -#define bAdvUpdCFO 0x100
> -#define bAdvTimeCtrl 0x800
> -#define bUpdClko 0x1000
> -#define bFC 0x6000
> -#define bTrackingMode 0x8000
> -#define bPhCmpEnable 0x10000
> -#define bUpdClkoLTF 0x20000
> -#define bComChCFO 0x40000
> -#define bCSIEstiMode 0x80000
> -#define bAdvUpdEqz 0x100000
> -#define bUChCfg 0x7000000
> -#define bUpdEqz 0x8000000
> -
> -#define bTxAGCRate18_06 0x7f7f7f7f / Useless /
> -#define bTxAGCRate54_24 0x7f7f7f7f
> -#define bTxAGCRateMCS32 0x7f
> -#define bTxAGCRateCCK 0x7f00
> -#define bTxAGCRateMCS3_MCS0 0x7f7f7f7f
> -#define bTxAGCRateMCS7_MCS4 0x7f7f7f7f
> -#define bTxAGCRateMCS11_MCS8 0x7f7f7f7f
> -#define bTxAGCRateMCS15_MCS12 0x7f7f7f7f
> -
> -/ Rx Pseduo noise /
> -#define bRxPesudoNoiseOn 0x20000000 / Useless /
> -#define bRxPesudoNoise_A 0xff
> -#define bRxPesudoNoise_B 0xff00
> -#define bRxPesudoNoise_C 0xff0000
> -#define bRxPesudoNoise_D 0xff000000
> -#define bPesudoNoiseState_A 0xffff
> -#define bPesudoNoiseState_B 0xffff0000
> -#define bPesudoNoiseState_C 0xffff
> -#define bPesudoNoiseState_D 0xffff0000
> -
> -/ 7. RF Register
> - * Zebra1
> - /
> -#define bZebra1_HSSIEnable 0x8 / Useless /
> -#define bZebra1_TRxControl 0xc00
> -#define bZebra1_TRxGainSetting 0x07f
> -#define bZebra1_RxCorner 0xc00
> -#define bZebra1_TxChargePump 0x38
> -#define bZebra1_RxChargePump 0x7
> -#define bZebra1_ChannelNum 0xf80
> -#define bZebra1_TxLPFBW 0x400
> -#define bZebra1_RxLPFBW 0x600
> -
> -/Zebra4 /
> -#define bRTL8256RegModeCtrl1 0x100 / Useless /
> -#define bRTL8256RegModeCtrl0 0x40
> -#define bRTL8256_TxLPFBW 0x18
> -#define bRTL8256_RxLPFBW 0x600
> -
> -/ RTL8258 /
> -#define bRTL8258_TxLPFBW 0xc / Useless /
> -#define bRTL8258_RxLPFBW 0xc00
> -#define bRTL8258_RSSILPFBW 0xc0
> -
> -/
> - * Other Definition
> - /
> -
> -/ byte endable for sb_write /
> -#define bByte0 0x1 / Useless /
> -#define bByte1 0x2
> -#define bByte2 0x4
> -#define bByte3 0x8
> -#define bWord0 0x3
> -#define bWord1 0xc
> -#define bDWord 0xf
> -
> -/ for PutRegsetting & GetRegSetting BitMask /
> -#define bMaskByte0 0xff / Reg 0xc50 rOFDM0_XAAGCCore~0xC6f /
> -#define bMaskByte1 0xff00
> -#define bMaskByte2 0xff0000
> -#define bMaskByte3 0xff000000
> -#define bMaskHWord 0xffff0000
> -#define bMaskLWord 0x0000ffff
> -#define bMaskDWord 0xffffffff
> -
> -/ for PutRFRegsetting & GetRFRegSetting BitMask /
> -#define bRFRegOffsetMask 0xfffff
> -#define bEnable 0x1 / Useless /
> -#define bDisable 0x0
> -
> -#define LeftAntenna 0x0 / Useless /
> -#define RightAntenna 0x1
> -
> -#define tCheckTxStatus 500 / 500ms Useless /
> -#define tUpdateRxCounter 100 / 100ms /
> -
> -#define rateCCK 0 / Useless /
> -#define rateOFDM 1
> -#define rateHT 2
> -
> -/ define Register-End /
> -#define bPMAC_End 0x1ff / Useless /
> -#define bFPGAPHY0_End 0x8ff
> -#define bFPGAPHY1_End 0x9ff
> -#define bCCKPHY0_End 0xaff
> -#define bOFDMPHY0_End 0xcff
> -#define bOFDMPHY1_End 0xdff
> -
> -#define bPMACControl 0x0 / Useless /
> -#define bWMACControl 0x1
> -#define bWNICControl 0x2
> -
> -#define ANTENNA_A 0x1 / Useless /
> -#define ANTENNA_B 0x2
> -#define ANTENNA_AB 0x3 / ANTENNA_A |ANTENNA_B /
> -
> -#define ANTENNA_C 0x4
> -#define ANTENNA_D 0x8
> -
> -/ accept all physical address /
> -#define RCR_AAP BIT(0)
> -#define RCR_APM BIT(1) / accept physical match /
> -#define RCR_AM BIT(2) / accept multicast /
> -#define RCR_AB BIT(3) / accept broadcast /
> -#define RCR_ACRC32 BIT(5) / accept error packet /
> -#define RCR_9356SEL BIT(6)
> -#define RCR_AICV BIT(12) / Accept ICV error packet /
> -#define RCR_RXFTH0 (BIT(13)|BIT(14)|BIT(15)) / Rx FIFO threshold /
> -#define RCR_ADF BIT(18) / Accept Data(frame type) frame /
> -#define RCR_ACF BIT(19) / Accept control frame /
> -#define RCR_AMF BIT(20) / Accept management frame /
> -#define RCR_ADD3 BIT(21)
> -#define RCR_APWRMGT BIT(22) / Accept power management packet /
> -#define RCR_CBSSID BIT(23) / Accept BSSID match packet /
> -#define RCR_ENMARP BIT(28) / enable mac auto reset phy /
> -#define RCR_EnCS1 BIT(29) / enable carrier sense method 1 /
> -#define RCR_EnCS2 BIT(30) / enable carrier sense method 2 /
> -/ Rx Early mode is performed for packet size greater than 1536 /
> -#define RCR_OnlyErlPkt BIT(31)
> -
> -/--------------------------Define Parameters----------------------------=
---/
> -
> -#endif /__INC_HAL8192SPHYREG_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.c b/drivers/staging/=
rtl8712/rtl871x_pwrctrl.c
> deleted file mode 100644
> index b22129f5d4f9..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_pwrctrl.c
> +++ /dev/null
> @@ -1,234 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************************************=
******
> - * rtl871x_pwrctrl.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_PWRCTRL_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "osdep_intf.h"
> -
> -#define RTL8712_SDIO_LOCAL_BASE 0X10100000
> -#define SDIO_HCPWM (RTL8712_SDIO_LOCAL_BASE + 0x0081)
> -
> -void r8712_set_rpwm(struct _adapter *padapter, u8 val8)
> -{
> - u8 rpwm;
> - struct pwrctrl_priv *pwrpriv =3D &padapter->pwrctrlpriv;
>=20
> -
> - if (pwrpriv->rpwm =3D=3D val8) {
>=20
> - if (pwrpriv->rpwm_retry =3D=3D 0)
>=20
> - return;
> - }
> - if (padapter->driver_stopped || padapter->surprise_removed)
>=20
> - return;
> - rpwm =3D val8 | pwrpriv->tog;
>=20
> - switch (val8) {
> - case PS_STATE_S1:
> - pwrpriv->cpwm =3D val8;
>=20
> - break;
> - case PS_STATE_S2:/* only for USB normal powersave mode use,
> - * temp mark some code.
> - */
> - case PS_STATE_S3:
> - case PS_STATE_S4:
> - pwrpriv->cpwm =3D val8;
>=20
> - break;
> - default:
> - break;
> - }
> - pwrpriv->rpwm_retry =3D 0;
>=20
> - pwrpriv->rpwm =3D val8;
>=20
> - r8712_write8(padapter, 0x1025FE58, rpwm);
> - pwrpriv->tog +=3D 0x80;
>=20
> -}
> -
> -void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode, uint sma=
rt_ps)
> -{
> - struct pwrctrl_priv *pwrpriv =3D &padapter->pwrctrlpriv;
>=20
> -
> - if (ps_mode > PM_Card_Disable)
>=20
> - return;
> - /* if driver is in active state, we dont need set smart_ps.*/
> - if (ps_mode =3D=3D PS_MODE_ACTIVE)
> - smart_ps =3D 0;
> - if ((pwrpriv->pwr_mode !=3D ps_mode) || (pwrpriv->smart_ps !=3D smart_p=
s)) {
>=20
> - if (pwrpriv->pwr_mode =3D=3D PS_MODE_ACTIVE)
>=20
> - pwrpriv->bSleep =3D true;
>=20
> - else
> - pwrpriv->bSleep =3D false;
>=20
> - pwrpriv->pwr_mode =3D ps_mode;
>=20
> - pwrpriv->smart_ps =3D smart_ps;
>=20
> - schedule_work(&pwrpriv->SetPSModeWorkItem);
>=20
> - }
> -}
> -
> -/*
> - * Caller:ISR handler...
> - *
> - * This will be called when CPWM interrupt is up.
> - *
> - * using to update cpwn of drv; and drv will make a decision to up or
> - * down pwr level
> - */
> -void r8712_cpwm_int_hdl(struct _adapter *padapter,
> - struct reportpwrstate_parm *preportpwrstate)
> -{
> - struct pwrctrl_priv *pwrpriv =3D &padapter->pwrctrlpriv;
>=20
> - struct cmd_priv *pcmdpriv =3D &padapter->cmdpriv;
>=20
> -
> - if (pwrpriv->cpwm_tog =3D=3D ((preportpwrstate->state) & 0x80))
>=20
> - return;
> - del_timer(&padapter->pwrctrlpriv.rpwm_check_timer);
>=20
> - mutex_lock(&pwrpriv->mutex_lock);
>=20
> - pwrpriv->cpwm =3D (preportpwrstate->state) & 0xf;
>=20
> - if (pwrpriv->cpwm >=3D PS_STATE_S2) {
>=20
> - if (pwrpriv->alives & CMD_ALIVE)
>=20
> - complete(&pcmdpriv->cmd_queue_comp);
>=20
> - }
> - pwrpriv->cpwm_tog =3D (preportpwrstate->state) & 0x80;
>=20
> - mutex_unlock(&pwrpriv->mutex_lock);
>=20
> -}
> -
> -static inline void register_task_alive(struct pwrctrl_priv *pwrctrl, uin=
t tag)
> -{
> - pwrctrl->alives |=3D tag;
>=20
> -}
> -
> -static inline void unregister_task_alive(struct pwrctrl_priv *pwrctrl, u=
int tag)
> -{
> - if (pwrctrl->alives & tag)
>=20
> - pwrctrl->alives ^=3D tag;
>=20
> -}
> -
> -static void _rpwm_check_handler (struct _adapter *padapter)
> -{
> - struct pwrctrl_priv *pwrpriv =3D &padapter->pwrctrlpriv;
>=20
> -
> - if (padapter->driver_stopped || padapter->surprise_removed)
>=20
> - return;
> - if (pwrpriv->cpwm !=3D pwrpriv->rpwm)
>=20
> - schedule_work(&pwrpriv->rpwm_workitem);
>=20
> -}
> -
> -static void SetPSModeWorkItemCallback(struct work_struct *work)
> -{
> - struct pwrctrl_priv *pwrpriv =3D container_of(work,
> - struct pwrctrl_priv, SetPSModeWorkItem);
> - struct _adapter *padapter =3D container_of(pwrpriv,
> - struct _adapter, pwrctrlpriv);
> - if (!pwrpriv->bSleep) {
>=20
> - mutex_lock(&pwrpriv->mutex_lock);
>=20
> - if (pwrpriv->pwr_mode =3D=3D PS_MODE_ACTIVE)
>=20
> - r8712_set_rpwm(padapter, PS_STATE_S4);
> - mutex_unlock(&pwrpriv->mutex_lock);
>=20
> - }
> -}
> -
> -static void rpwm_workitem_callback(struct work_struct *work)
> -{
> - struct pwrctrl_priv *pwrpriv =3D container_of(work,
> - struct pwrctrl_priv, rpwm_workitem);
> - struct _adapter *padapter =3D container_of(pwrpriv,
> - struct _adapter, pwrctrlpriv);
> - if (pwrpriv->cpwm !=3D pwrpriv->rpwm) {
>=20
> - mutex_lock(&pwrpriv->mutex_lock);
>=20
> - r8712_read8(padapter, SDIO_HCPWM);
> - pwrpriv->rpwm_retry =3D 1;
>=20
> - r8712_set_rpwm(padapter, pwrpriv->rpwm);
>=20
> - mutex_unlock(&pwrpriv->mutex_lock);
>=20
> - }
> -}
> -
> -static void rpwm_check_handler (struct timer_list *t)
> -{
> - struct _adapter *adapter =3D
> - from_timer(adapter, t, pwrctrlpriv.rpwm_check_timer);
> -
> - _rpwm_check_handler(adapter);
> -}
> -
> -void r8712_init_pwrctrl_priv(struct _adapter *padapter)
> -{
> - struct pwrctrl_priv *pwrctrlpriv =3D &padapter->pwrctrlpriv;
>=20
> -
> - memset((unsigned char *)pwrctrlpriv, 0, sizeof(struct pwrctrl_priv));
> - mutex_init(&pwrctrlpriv->mutex_lock);
>=20
> - pwrctrlpriv->cpwm =3D PS_STATE_S4;
>=20
> - pwrctrlpriv->pwr_mode =3D PS_MODE_ACTIVE;
>=20
> - pwrctrlpriv->smart_ps =3D 0;
>=20
> - pwrctrlpriv->tog =3D 0x80;
>=20
> -/* clear RPWM to ensure driver and fw back to initial state. */
> - r8712_write8(padapter, 0x1025FE58, 0);
> - INIT_WORK(&pwrctrlpriv->SetPSModeWorkItem, SetPSModeWorkItemCallback);
>=20
> - INIT_WORK(&pwrctrlpriv->rpwm_workitem, rpwm_workitem_callback);
>=20
> - timer_setup(&pwrctrlpriv->rpwm_check_timer, rpwm_check_handler, 0);
>=20
> -}
> -
> -/*
> - * Caller: r8712_cmd_thread
> - * Check if the fw_pwrstate is okay for issuing cmd.
> - * If not (cpwm should be is less than P2 state), then the sub-routine
> - * will raise the cpwm to be greater than or equal to P2.
> - * Calling Context: Passive
> - * Return Value:
> - * 0: r8712_cmd_thread can issue cmds to firmware afterwards.
> - * -EINVAL: r8712_cmd_thread can not do anything.
> - */
> -int r8712_register_cmd_alive(struct _adapter *padapter)
> -{
> - int res =3D 0;
> - struct pwrctrl_priv *pwrctrl =3D &padapter->pwrctrlpriv;
>=20
> -
> - mutex_lock(&pwrctrl->mutex_lock);
>=20
> - register_task_alive(pwrctrl, CMD_ALIVE);
> - if (pwrctrl->cpwm < PS_STATE_S2) {
>=20
> - r8712_set_rpwm(padapter, PS_STATE_S3);
> - res =3D -EINVAL;
> - }
> - mutex_unlock(&pwrctrl->mutex_lock);
>=20
> - return res;
> -}
> -
> -/*
> - * Caller: ISR
> - * If ISR's txdone,
> - * No more pkts for TX,
> - * Then driver shall call this fun. to power down firmware again.
> - */
> -void r8712_unregister_cmd_alive(struct _adapter *padapter)
> -{
> - struct pwrctrl_priv *pwrctrl =3D &padapter->pwrctrlpriv;
>=20
> -
> - mutex_lock(&pwrctrl->mutex_lock);
>=20
> - unregister_task_alive(pwrctrl, CMD_ALIVE);
> - if ((pwrctrl->cpwm > PS_STATE_S2) &&
>=20
> - (pwrctrl->pwr_mode > PS_MODE_ACTIVE)) {
>=20
> - if ((pwrctrl->alives =3D=3D 0) &&
>=20
> - (check_fwstate(&padapter->mlmepriv,
>=20
> - _FW_UNDER_LINKING) !=3D true)) {
> - r8712_set_rpwm(padapter, PS_STATE_S0);
> - }
> - }
> - mutex_unlock(&pwrctrl->mutex_lock);
>=20
> -}
> -
> -void r8712_flush_rwctrl_works(struct _adapter *padapter)
> -{
> - struct pwrctrl_priv *pwrctrl =3D &padapter->pwrctrlpriv;
>=20
> -
> - flush_work(&pwrctrl->SetPSModeWorkItem);
>=20
> - flush_work(&pwrctrl->rpwm_workitem);
>=20
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/=
rtl8712/rtl871x_pwrctrl.h
> deleted file mode 100644
> index b35b9c7920eb..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
> +++ /dev/null
> @@ -1,113 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
******/
> -#ifndef _RTL871X_PWRCTRL_H
> -#define _RTL871X_PWRCTRL_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -#define CMD_ALIVE BIT(2)
> -
> -enum Power_Mgnt {
> - PS_MODE_ACTIVE =3D 0,
> - PS_MODE_MIN,
> - PS_MODE_MAX,
> - PS_MODE_DTIM,
> - PS_MODE_VOIP,
> - PS_MODE_UAPSD_WMM,
> - PS_MODE_UAPSD,
> - PS_MODE_IBSS,
> - PS_MODE_WWLAN,
> - PM_Radio_Off,
> - PM_Card_Disable,
> - PS_MODE_NUM
> -};
> -
> -/
> - * BIT[2:0] =3D HW state
> - * BIT[3] =3D Protocol PS state, 0: register active state,
> - * 1: register sleep state
> - * BIT[4] =3D sub-state
> - /
> -
> -#define PS_DPS BIT(0)
> -#define PS_LCLK (PS_DPS)
> -#define PS_RF_OFF BIT(1)
> -#define PS_ALL_ON BIT(2)
> -#define PS_ST_ACTIVE BIT(3)
> -#define PS_LP BIT(4) / low performance /
> -
> -#define PS_STATE_MASK (0x0F)
> -#define PS_STATE_HW_MASK (0x07)
> -#define PS_SEQ_MASK (0xc0)
> -
> -#define PS_STATE(x) (PS_STATE_MASK & (x))
> -#define PS_STATE_HW(x) (PS_STATE_HW_MASK & (x))
> -#define PS_SEQ(x) (PS_SEQ_MASK & (x))
> -
> -#define PS_STATE_S0 (PS_DPS)
> -#define PS_STATE_S1 (PS_LCLK)
> -#define PS_STATE_S2 (PS_RF_OFF)
> -#define PS_STATE_S3 (PS_ALL_ON)
> -#define PS_STATE_S4 ((PS_ST_ACTIVE) | (PS_ALL_ON))
> -
> -#define PS_IS_RF_ON(x) ((x) & (PS_ALL_ON))
> -#define PS_IS_ACTIVE(x) ((x) & (PS_ST_ACTIVE))
> -#define CLR_PS_STATE(x) ((x) =3D ((x) & (0xF0)))
> -
> -struct reportpwrstate_parm {
> - unsigned char mode;
> - unsigned char state; / the CPWM value /
> - unsigned short rsvd;
> -};
> -
> -struct pwrctrl_priv {
> - struct mutex mutex_lock;
> - /volatile/ u8 rpwm; / requested power state for fw /
> - / fw current power state. updated when 1. read from HCPWM or
> - * 2. driver lowers power level
> - /
> - /volatile/ u8 cpwm;
> - /volatile/ u8 tog; / toggling /
> - /volatile/ u8 cpwm_tog; / toggling /
> - /volatile/ u8 tgt_rpwm; / wanted power state /
> - uint pwr_mode;
> - uint smart_ps;
> - uint alives;
> - uint ImrContent; / used to store original imr. /
> - uint bSleep; / sleep -> active is different from active -> sleep. */
>=20
> -
> - struct work_struct SetPSModeWorkItem;
> - struct work_struct rpwm_workitem;
> - struct timer_list rpwm_check_timer;
> - u8 rpwm_retry;
> - uint bSetPSModeWorkItemInProgress;
> -
> - spinlock_t pnp_pwr_mgnt_lock;
> - s32 pnp_current_pwr_state;
> - u8 pnp_bstop_trx;
> - u8 pnp_wwirp_pending;
> -};
> -
> -void r8712_init_pwrctrl_priv(struct _adapter adapter);
> -int r8712_register_cmd_alive(struct _adapter padapter);
> -void r8712_unregister_cmd_alive(struct _adapter padapter);
> -void r8712_cpwm_int_hdl(struct _adapter padapter,
> - struct reportpwrstate_parm preportpwrstate);
> -void r8712_set_ps_mode(struct _adapter padapter, uint ps_mode,
> - uint smart_ps);
> -void r8712_set_rpwm(struct _adapter padapter, u8 val8);
> -void r8712_flush_rwctrl_works(struct _adapter padapter);
> -
> -#endif / _RTL871X_PWRCTRL_H /
> diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl=
8712/rtl871x_recv.c
> deleted file mode 100644
> index 3fb5cd746273..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_recv.c
> +++ /dev/null
> @@ -1,671 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**********************************************************************
> - * rtl871x_recv.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_RECV_C
> -
> -#include <linux/ip.h>
>=20
> -#include <linux/if_ether.h>
>=20
> -#include <linux/etherdevice.h>
>=20
> -#include <linux/ieee80211.h>
>=20
> -#include <net/cfg80211.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "recv_osdep.h"
> -#include "mlme_osdep.h"
> -#include "ethernet.h"
> -#include "usb_ops.h"
> -#include "wifi.h"
> -
> -static const u8 SNAP_ETH_TYPE_IPX[2] =3D {0x81, 0x37};
> -
> -/* Datagram Delivery Protocol */
> -static const u8 SNAP_ETH_TYPE_APPLETALK_AARP[2] =3D {0x80, 0xf3};
> -
> -void _r8712_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
> -{
> - memset((u8 *)psta_recvpriv, 0, sizeof(struct sta_recv_priv));
> - spin_lock_init(&psta_recvpriv->lock);
>=20
> - _init_queue(&psta_recvpriv->defrag_q);
>=20
> -}
> -
> -int _r8712_init_recv_priv(struct recv_priv *precvpriv,
> - struct _adapter *padapter)
> -{
> - int ret;
> - sint i;
> - union recv_frame *precvframe;
> -
> - memset((unsigned char *)precvpriv, 0, sizeof(struct recv_priv));
> - spin_lock_init(&precvpriv->lock);
>=20
> - _init_queue(&precvpriv->free_recv_queue);
>=20
> - _init_queue(&precvpriv->recv_pending_queue);
>=20
> - precvpriv->adapter =3D padapter;
>=20
> - precvpriv->free_recvframe_cnt =3D NR_RECVFRAME;
>=20
> - precvpriv->pallocated_frame_buf =3D kzalloc(NR_RECVFRAME *
>=20
> - sizeof(union recv_frame) + RXFRAME_ALIGN_SZ,
> - GFP_ATOMIC);
> - if (!precvpriv->pallocated_frame_buf)
>=20
> - return -ENOMEM;
> - precvpriv->precv_frame_buf =3D precvpriv->pallocated_frame_buf +
>=20
> - RXFRAME_ALIGN_SZ -
> - ((addr_t)(precvpriv->pallocated_frame_buf) &
>=20
> - (RXFRAME_ALIGN_SZ - 1));
> - precvframe =3D (union recv_frame *)precvpriv->precv_frame_buf;
>=20
> - for (i =3D 0; i < NR_RECVFRAME; i++) {
> - INIT_LIST_HEAD(&precvframe->u.list);
>=20
> - list_add_tail(&precvframe->u.list,
>=20
> - &precvpriv->free_recv_queue.queue);
>=20
> - r8712_os_recv_resource_alloc(padapter, precvframe);
> - precvframe->u.hdr.adapter =3D padapter;
>=20
> - precvframe++;
> - }
> - precvpriv->rx_pending_cnt =3D 1;
>=20
> - ret =3D r8712_init_recv_priv(precvpriv, padapter);
> - if (ret)
> - kfree(precvpriv->pallocated_frame_buf);
>=20
> -
> - return ret;
> -}
> -
> -void _r8712_free_recv_priv(struct recv_priv *precvpriv)
> -{
> - kfree(precvpriv->pallocated_frame_buf);
>=20
> - r8712_free_recv_priv(precvpriv);
> -}
> -
> -union recv_frame *r8712_alloc_recvframe(struct __queue *pfree_recv_queue=
)
> -{
> - unsigned long irqL;
> - union recv_frame *precvframe;
> - struct _adapter *padapter;
> - struct recv_priv *precvpriv;
> -
> - spin_lock_irqsave(&pfree_recv_queue->lock, irqL);
>=20
> - precvframe =3D list_first_entry_or_null(&pfree_recv_queue->queue,
>=20
> - union recv_frame, u.hdr.list);
> - if (precvframe) {
> - list_del_init(&precvframe->u.hdr.list);
>=20
> - padapter =3D precvframe->u.hdr.adapter;
>=20
> - if (padapter) {
> - precvpriv =3D &padapter->recvpriv;
>=20
> - if (pfree_recv_queue =3D=3D &precvpriv->free_recv_queue)
>=20
> - precvpriv->free_recvframe_cnt--;
>=20
> - }
> - }
> - spin_unlock_irqrestore(&pfree_recv_queue->lock, irqL);
>=20
> - return precvframe;
> -}
> -
> -/*
> - * caller : defrag; recvframe_chk_defrag in recv_thread (passive)
> - * pframequeue: defrag_queue : will be accessed in recv_thread (passive)
> - * using spin_lock to protect
> - */
> -void r8712_free_recvframe_queue(struct __queue *pframequeue,
> - struct __queue *pfree_recv_queue)
> -{
> - union recv_frame *precvframe;
> - struct list_head *plist, *phead;
> -
> - spin_lock(&pframequeue->lock);
>=20
> - phead =3D &pframequeue->queue;
>=20
> - plist =3D phead->next;
>=20
> - while (!end_of_queue_search(phead, plist)) {
> - precvframe =3D container_of(plist, union recv_frame, u.list);
> - plist =3D plist->next;
>=20
> - r8712_free_recvframe(precvframe, pfree_recv_queue);
> - }
> - spin_unlock(&pframequeue->lock);
>=20
> -}
> -
> -sint r8712_recvframe_chkmic(struct _adapter *adapter,
> - union recv_frame *precvframe)
> -{
> - sint i, res =3D _SUCCESS;
> - u32 datalen;
> - u8 miccode[8];
> - u8 bmic_err =3D false;
> - u8 *pframe, *payload, *pframemic;
> - u8 *mickey, idx, *iv;
> - struct sta_info *stainfo;
> - struct rx_pkt_attrib *prxattrib =3D &precvframe->u.hdr.attrib;
>=20
> - struct security_priv *psecuritypriv =3D &adapter->securitypriv;
>=20
> -
> - stainfo =3D r8712_get_stainfo(&adapter->stapriv, &prxattrib->ta[0]);
>=20
> - if (prxattrib->encrypt =3D=3D TKIP) {
>=20
> - /* calculate mic code */
> - if (stainfo) {
> - if (is_multicast_ether_addr(prxattrib->ra)) {
>=20
> - iv =3D precvframe->u.hdr.rx_data +
>=20
> - prxattrib->hdrlen;
>=20
> - idx =3D iv[3];
> - mickey =3D &psecuritypriv->XGrprxmickey[(((idx >>
>=20
> - 6) & 0x3)) - 1].skey[0];
> - if (!psecuritypriv->binstallGrpkey)
>=20
> - return _FAIL;
> - } else {
> - mickey =3D &stainfo->tkiprxmickey.skey[0];
>=20
> - }
> - /icv_len included the mic code/
> - datalen =3D precvframe->u.hdr.len - prxattrib->hdrlen -
>=20
> - prxattrib->iv_len - prxattrib->icv_len - 8;
>=20
> - pframe =3D precvframe->u.hdr.rx_data;
>=20
> - payload =3D pframe + prxattrib->hdrlen +
>=20
> - prxattrib->iv_len;
>=20
> - seccalctkipmic(mickey, pframe, payload, datalen,
> - &miccode[0],
> - (unsigned char)prxattrib->priority);
>=20
> - pframemic =3D payload + datalen;
> - bmic_err =3D false;
> - for (i =3D 0; i < 8; i++) {
> - if (miccode[i] !=3D *(pframemic + i))
> - bmic_err =3D true;
> - }
> - if (bmic_err) {
> - if (prxattrib->bdecrypted)
>=20
> - r8712_handle_tkip_mic_err(adapter,
> - (u8)is_multicast_ether_addr(prxattrib->ra));
>=20
> - res =3D _FAIL;
> - } else {
> - /* mic checked ok */
> - if (!psecuritypriv->bcheck_grpkey &&
>=20
> - is_multicast_ether_addr(prxattrib->ra))
>=20
> - psecuritypriv->bcheck_grpkey =3D true;
>=20
> - }
> - recvframe_pull_tail(precvframe, 8);
> - }
> - }
> - return res;
> -}
> -
> -/* decrypt and set the ivlen,icvlen of the recv_frame */
> -union recv_frame *r8712_decryptor(struct _adapter *padapter,
> - union recv_frame *precv_frame)
> -{
> - struct rx_pkt_attrib *prxattrib =3D &precv_frame->u.hdr.attrib;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - union recv_frame *return_packet =3D precv_frame;
> -
> - if ((prxattrib->encrypt > 0) && ((prxattrib->bdecrypted =3D=3D 0) ||
>=20
> - psecuritypriv->sw_decrypt)) {
>=20
> - psecuritypriv->hw_decrypted =3D false;
>=20
> - switch (prxattrib->encrypt) {
>=20
> - case WEP40:
> - case WEP104:
> - r8712_wep_decrypt(padapter, (u8 *)precv_frame);
> - break;
> - case TKIP:
> - r8712_tkip_decrypt(padapter, (u8 *)precv_frame);
> - break;
> - case AES:
> - r8712_aes_decrypt(padapter, (u8 *)precv_frame);
> - break;
> - default:
> - break;
> - }
> - } else if (prxattrib->bdecrypted =3D=3D 1) {
>=20
> - psecuritypriv->hw_decrypted =3D true;
>=20
> - }
> - return return_packet;
> -}
> -
> -/*###set the security information in the recv_frame */
> -union recv_frame *r8712_portctrl(struct _adapter *adapter,
> - union recv_frame *precv_frame)
> -{
> - u8 *psta_addr, *ptr;
> - uint auth_alg;
> - struct recv_frame_hdr *pfhdr;
> - struct sta_info *psta;
> - struct sta_priv *pstapriv;
> - union recv_frame *prtnframe;
> - u16 ether_type;
> -
> - pstapriv =3D &adapter->stapriv;
>=20
> - ptr =3D precv_frame->u.hdr.rx_data;
>=20
> - pfhdr =3D &precv_frame->u.hdr;
>=20
> - psta_addr =3D pfhdr->attrib.ta;
>=20
> - psta =3D r8712_get_stainfo(pstapriv, psta_addr);
> - auth_alg =3D adapter->securitypriv.auth_algorithm;
>=20
> - if (auth_alg =3D=3D 2) {
> - /* get ether_type */
> - ptr =3D ptr + pfhdr->attrib.hdrlen + LLC_HEADER_SIZE;
>=20
> - ether_type =3D get_unaligned_be16(ptr);
> -
> - if (psta && psta->ieee8021x_blocked) {
>=20
> - /* blocked
> - * only accept EAPOL frame
> - */
> - if (ether_type =3D=3D 0x888e) {
> - prtnframe =3D precv_frame;
> - } else {
> - /free this frame/
> - r8712_free_recvframe(precv_frame,
> - &adapter->recvpriv.free_recv_queue);
>=20
> - prtnframe =3D NULL;
> - }
> - } else {
> - /* allowed
> - * check decryption status, and decrypt the
> - * frame if needed
> - /
> - prtnframe =3D precv_frame;
> - / check is the EAPOL frame or not (Rekey) /
> - if (ether_type =3D=3D 0x888e) {
> - / check Rekey */
> - prtnframe =3D precv_frame;
> - }
> - }
> - } else {
> - prtnframe =3D precv_frame;
> - }
> - return prtnframe;
> -}
> -
> -static sint recv_decache(union recv_frame *precv_frame, u8 bretry,
> - struct stainfo_rxcache *prxcache)
> -{
> - sint tid =3D precv_frame->u.hdr.attrib.priority;
>=20
> - u16 seq_ctrl =3D ((precv_frame->u.hdr.attrib.seq_num & 0xffff) << 4) |
>=20
> - (precv_frame->u.hdr.attrib.frag_num & 0xf);
>=20
> -
> - if (tid > 15)
>=20
> - return _FAIL;
> - if (seq_ctrl =3D=3D prxcache->tid_rxseq[tid])
>=20
> - return _FAIL;
> - prxcache->tid_rxseq[tid] =3D seq_ctrl;
>=20
> - return _SUCCESS;
> -}
> -
> -static sint sta2sta_data_frame(struct _adapter *adapter,
> - union recv_frame *precv_frame,
> - struct sta_info **psta)
> -{
> - u8 *ptr =3D precv_frame->u.hdr.rx_data;
>=20
> - sint ret =3D _SUCCESS;
> - struct rx_pkt_attrib *pattrib =3D &precv_frame->u.hdr.attrib;
>=20
> - struct sta_priv *pstapriv =3D &adapter->stapriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - u8 *mybssid =3D get_bssid(pmlmepriv);
> - u8 *myhwaddr =3D myid(&adapter->eeprompriv);
>=20
> - u8 *sta_addr =3D NULL;
> - bool bmcast =3D is_multicast_ether_addr(pattrib->dst);
>=20
> -
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
> - check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
> - /* filter packets that SA is myself or multicast or broadcast */
> - if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN))
>=20
> - return _FAIL;
> - if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast))
>=20
> - return _FAIL;
> - if (is_zero_ether_addr(pattrib->bssid) ||
>=20
> - is_zero_ether_addr(mybssid) ||
> - (memcmp(pattrib->bssid, mybssid, ETH_ALEN)))
>=20
> - return _FAIL;
> - sta_addr =3D pattrib->src;
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> - /* For Station mode, sa and bssid should always be BSSID,
> - * and DA is my mac-address
> - */
> - if (memcmp(pattrib->bssid, pattrib->src, ETH_ALEN))
>=20
> - return _FAIL;
> - sta_addr =3D pattrib->bssid;
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
> - if (bmcast) {
> - /* For AP mode, if DA =3D=3D MCAST, then BSSID should
> - * be also MCAST
> - */
> - if (!is_multicast_ether_addr(pattrib->bssid))
>=20
> - return _FAIL;
> - } else { /* not mc-frame /
> - / For AP mode, if DA is non-MCAST, then it must be
> - * BSSID, and bssid =3D=3D BSSID
> - */
> - if (memcmp(pattrib->bssid, pattrib->dst, ETH_ALEN))
>=20
> - return _FAIL;
> - sta_addr =3D pattrib->src;
>=20
> - }
> - } else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
> - memcpy(pattrib->dst, GetAddr1Ptr(ptr), ETH_ALEN);
>=20
> - memcpy(pattrib->src, GetAddr2Ptr(ptr), ETH_ALEN);
>=20
> - memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
>=20
> - memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
>=20
> - sta_addr =3D mybssid;
> - } else {
> - ret =3D _FAIL;
> - }
> - if (bmcast)
> - *psta =3D r8712_get_bcmc_stainfo(adapter);
> - else
> - psta =3D r8712_get_stainfo(pstapriv, sta_addr); / get ap_info */
> - if (!*psta) {
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
> - adapter->mppriv.rx_pktloss++;
>=20
> - return _FAIL;
> - }
> - return ret;
> -}
> -
> -static sint ap2sta_data_frame(struct _adapter *adapter,
> - union recv_frame *precv_frame,
> - struct sta_info **psta)
> -{
> - u8 *ptr =3D precv_frame->u.hdr.rx_data;
>=20
> - struct rx_pkt_attrib *pattrib =3D &precv_frame->u.hdr.attrib;
>=20
> - struct sta_priv *pstapriv =3D &adapter->stapriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - u8 *mybssid =3D get_bssid(pmlmepriv);
> - u8 *myhwaddr =3D myid(&adapter->eeprompriv);
>=20
> - bool bmcast =3D is_multicast_ether_addr(pattrib->dst);
>=20
> -
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) &&
> - check_fwstate(pmlmepriv, _FW_LINKED)) {
> - /* if NULL-frame, drop packet /
> - if ((GetFrameSubType(ptr)) =3D=3D (IEEE80211_FTYPE_DATA | IEEE80211_STY=
PE_NULLFUNC))
> - return _FAIL;
> - / drop QoS-SubType Data, including QoS NULL,
> - * excluding QoS-Data
> - /
> - if ((GetFrameSubType(ptr) & WIFI_QOS_DATA_TYPE) =3D=3D
> - WIFI_QOS_DATA_TYPE) {
> - if (GetFrameSubType(ptr) & (BIT(4) | BIT(5) | BIT(6)))
> - return _FAIL;
> - }
> -
> - / filter packets that SA is myself or multicast or broadcast */
> - if (!memcmp(myhwaddr, pattrib->src, ETH_ALEN))
>=20
> - return _FAIL;
> -
> - /* da should be for me */
> - if ((memcmp(myhwaddr, pattrib->dst, ETH_ALEN)) && (!bmcast))
>=20
> - return _FAIL;
> - /* check BSSID */
> - if (is_zero_ether_addr(pattrib->bssid) ||
>=20
> - is_zero_ether_addr(mybssid) ||
> - (memcmp(pattrib->bssid, mybssid, ETH_ALEN)))
>=20
> - return _FAIL;
> - if (bmcast)
> - *psta =3D r8712_get_bcmc_stainfo(adapter);
> - else
> - *psta =3D r8712_get_stainfo(pstapriv, pattrib->bssid);
>=20
> - if (!*psta)
> - return _FAIL;
> - } else if (check_fwstate(pmlmepriv, WIFI_MP_STATE) &&
> - check_fwstate(pmlmepriv, _FW_LINKED)) {
> - memcpy(pattrib->dst, GetAddr1Ptr(ptr), ETH_ALEN);
>=20
> - memcpy(pattrib->src, GetAddr2Ptr(ptr), ETH_ALEN);
>=20
> - memcpy(pattrib->bssid, GetAddr3Ptr(ptr), ETH_ALEN);
>=20
> - memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
>=20
> - memcpy(pattrib->bssid, mybssid, ETH_ALEN);
>=20
> - *psta =3D r8712_get_stainfo(pstapriv, pattrib->bssid);
>=20
> - if (!*psta)
> - return _FAIL;
> - } else {
> - return _FAIL;
> - }
> - return _SUCCESS;
> -}
> -
> -static sint sta2ap_data_frame(struct _adapter *adapter,
> - union recv_frame *precv_frame,
> - struct sta_info **psta)
> -{
> - struct rx_pkt_attrib *pattrib =3D &precv_frame->u.hdr.attrib;
>=20
> - struct sta_priv *pstapriv =3D &adapter->stapriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> - unsigned char mybssid =3D get_bssid(pmlmepriv);
> -
> - if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
> - / For AP mode, if DA is non-MCAST, then it must be BSSID,
> - * and bssid =3D=3D BSSID
> - * For AP mode, RA=3DBSSID, TX=3DSTA(SRC_ADDR), A3=3DDST_ADDR
> - */
> - if (memcmp(pattrib->bssid, mybssid, ETH_ALEN))
>=20
> - return _FAIL;
> - *psta =3D r8712_get_stainfo(pstapriv, pattrib->src);
>=20
> - if (!*psta)
> - return _FAIL;
> - }
> - return _SUCCESS;
> -}
> -
> -static sint validate_recv_ctrl_frame(struct _adapter *adapter,
> - union recv_frame *precv_frame)
> -{
> - return _FAIL;
> -}
> -
> -static sint validate_recv_mgnt_frame(struct _adapter *adapter,
> - union recv_frame *precv_frame)
> -{
> - return _FAIL;
> -}
> -
> -static sint validate_recv_data_frame(struct _adapter *adapter,
> - union recv_frame *precv_frame)
> -{
> - int res;
> - u8 bretry;
> - u8 *psa, *pda, *pbssid;
> - struct sta_info *psta =3D NULL;
> - u8 *ptr =3D precv_frame->u.hdr.rx_data;
>=20
> - struct rx_pkt_attrib *pattrib =3D &precv_frame->u.hdr.attrib;
>=20
> - struct security_priv *psecuritypriv =3D &adapter->securitypriv;
>=20
> -
> - bretry =3D GetRetry(ptr);
> - pda =3D ieee80211_get_DA((struct ieee80211_hdr *)ptr);
> - psa =3D ieee80211_get_SA((struct ieee80211_hdr *)ptr);
> - pbssid =3D get_hdr_bssid(ptr);
> - if (!pbssid)
> - return _FAIL;
> - memcpy(pattrib->dst, pda, ETH_ALEN);
>=20
> - memcpy(pattrib->src, psa, ETH_ALEN);
>=20
> - memcpy(pattrib->bssid, pbssid, ETH_ALEN);
>=20
> - switch (pattrib->to_fr_ds) {
>=20
> - case 0:
> - memcpy(pattrib->ra, pda, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, psa, ETH_ALEN);
>=20
> - res =3D sta2sta_data_frame(adapter, precv_frame, &psta);
> - break;
> - case 1:
> - memcpy(pattrib->ra, pda, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, pbssid, ETH_ALEN);
>=20
> - res =3D ap2sta_data_frame(adapter, precv_frame, &psta);
> - break;
> - case 2:
> - memcpy(pattrib->ra, pbssid, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, psa, ETH_ALEN);
>=20
> - res =3D sta2ap_data_frame(adapter, precv_frame, &psta);
> - break;
> - case 3:
> - memcpy(pattrib->ra, GetAddr1Ptr(ptr), ETH_ALEN);
>=20
> - memcpy(pattrib->ta, GetAddr2Ptr(ptr), ETH_ALEN);
>=20
> - return _FAIL;
> - default:
> - return _FAIL;
> - }
> - if (res =3D=3D _FAIL)
> - return _FAIL;
> - if (!psta)
> - return _FAIL;
> - precv_frame->u.hdr.psta =3D psta;
>=20
> - pattrib->amsdu =3D 0;
>=20
> - /* parsing QC field */
> - if (pattrib->qos =3D=3D 1) {
>=20
> - pattrib->priority =3D GetPriority((ptr + 24));
>=20
> - pattrib->ack_policy =3D GetAckpolicy((ptr + 24));
>=20
> - pattrib->amsdu =3D GetAMsdu((ptr + 24));
>=20
> - pattrib->hdrlen =3D pattrib->to_fr_ds =3D=3D 3 ? 32 : 26;
>=20
> - } else {
> - pattrib->priority =3D 0;
>=20
> - pattrib->hdrlen =3D (pattrib->to_fr_ds =3D=3D 3) ? 30 : 24;
>=20
> - }
> -
> - if (pattrib->order)/HT-CTRL 11n/
>=20
> - pattrib->hdrlen +=3D 4;
>=20
> - precv_frame->u.hdr.preorder_ctrl =3D
>=20
> - &psta->recvreorder_ctrl[pattrib->priority];
>=20
> -
> - /* decache, drop duplicate recv packets */
> - if (recv_decache(precv_frame, bretry, &psta->sta_recvpriv.rxcache) =3D=
=3D
>=20
> - _FAIL)
> - return _FAIL;
> -
> - if (pattrib->privacy) {
>=20
> - GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt,
>=20
> - is_multicast_ether_addr(pattrib->ra));
>=20
> - SET_ICE_IV_LEN(pattrib->iv_len, pattrib->icv_len,
>=20
> - pattrib->encrypt);
>=20
> - } else {
> - pattrib->encrypt =3D 0;
>=20
> - pattrib->iv_len =3D pattrib->icv_len =3D 0;
>=20
> - }
> - return _SUCCESS;
> -}
> -
> -sint r8712_validate_recv_frame(struct _adapter *adapter,
> - union recv_frame *precv_frame)
> -{
> - /*shall check frame subtype, to / from ds, da, bssid */
> - /then call check if rx seq/frag. duplicated./
> -
> - u8 type;
> - u8 subtype;
> - sint retval =3D _SUCCESS;
> - struct rx_pkt_attrib *pattrib =3D &precv_frame->u.hdr.attrib;
>=20
> -
> - u8 *ptr =3D precv_frame->u.hdr.rx_data;
>=20
> - u8 ver =3D (unsigned char)(*ptr) & 0x3;
> -
> - /add version chk/
> - if (ver !=3D 0)
> - return _FAIL;
> - type =3D GetFrameType(ptr);
> - subtype =3D GetFrameSubType(ptr); /bit(7)~bit(2)/
> - pattrib->to_fr_ds =3D get_tofr_ds(ptr);
>=20
> - pattrib->frag_num =3D GetFragNum(ptr);
>=20
> - pattrib->seq_num =3D GetSequence(ptr);
>=20
> - pattrib->pw_save =3D GetPwrMgt(ptr);
>=20
> - pattrib->mfrag =3D GetMFrag(ptr);
>=20
> - pattrib->mdata =3D GetMData(ptr);
>=20
> - pattrib->privacy =3D GetPrivacy(ptr);
>=20
> - pattrib->order =3D GetOrder(ptr);
>=20
> - switch (type) {
> - case IEEE80211_FTYPE_MGMT:
> - retval =3D validate_recv_mgnt_frame(adapter, precv_frame);
> - break;
> - case IEEE80211_FTYPE_CTL:
> - retval =3D validate_recv_ctrl_frame(adapter, precv_frame);
> - break;
> - case IEEE80211_FTYPE_DATA:
> - pattrib->qos =3D (subtype & BIT(7)) ? 1 : 0;
>=20
> - retval =3D validate_recv_data_frame(adapter, precv_frame);
> - break;
> - default:
> - return _FAIL;
> - }
> - return retval;
> -}
> -
> -int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe)
> -{
> - /remove the wlanhdr and add the eth_hdr/
> - sint rmv_len;
> - u16 len;
> - u8 bsnaphdr;
> - u8 *psnap_type;
> - struct ieee80211_snap_hdr *psnap;
> - struct _adapter *adapter =3D precvframe->u.hdr.adapter;
>=20
> - struct mlme_priv *pmlmepriv =3D &adapter->mlmepriv;
>=20
> -
> - u8 *ptr =3D precvframe->u.hdr.rx_data; /point to frame_ctrl field/
>=20
> - struct rx_pkt_attrib *pattrib =3D &precvframe->u.hdr.attrib;
>=20
> -
> - if (pattrib->encrypt)
>=20
> - recvframe_pull_tail(precvframe, pattrib->icv_len);
>=20
> - psnap =3D (struct ieee80211_snap_hdr *)(ptr + pattrib->hdrlen +
>=20
> - pattrib->iv_len);
>=20
> - psnap_type =3D ptr + pattrib->hdrlen + pattrib->iv_len + SNAP_SIZE;
>=20
> - /* convert hdr + possible LLC headers into Ethernet header */
> - if ((!memcmp(psnap, (void *)rfc1042_header, SNAP_SIZE) &&
> - (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_IPX, 2)) &&
> - (memcmp(psnap_type, (void *)SNAP_ETH_TYPE_APPLETALK_AARP, 2))) ||
> - !memcmp(psnap, (void )bridge_tunnel_header, SNAP_SIZE)) {
> - / remove RFC1042 or Bridge-Tunnel encapsulation and
> - * replace EtherType
> - /
> - bsnaphdr =3D true;
> - } else {
> - / Leave Ethernet header part of hdr and full payload */
> - bsnaphdr =3D false;
> - }
> - rmv_len =3D pattrib->hdrlen + pattrib->iv_len +
>=20
> - (bsnaphdr ? SNAP_SIZE : 0);
> - len =3D precvframe->u.hdr.len - rmv_len;
>=20
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
> - ptr +=3D rmv_len;
> - *ptr =3D 0x87;
> - (ptr + 1) =3D 0x12;
> - / append rx status for mp test packets */
> - ptr =3D recvframe_pull(precvframe, (rmv_len -
> - sizeof(struct ethhdr) + 2) - 24);
> - if (!ptr)
> - return -ENOMEM;
> - memcpy(ptr, get_rxmem(precvframe), 24);
> - ptr +=3D 24;
> - } else {
> - ptr =3D recvframe_pull(precvframe, (rmv_len -
> - sizeof(struct ethhdr) + (bsnaphdr ? 2 : 0)));
> - if (!ptr)
> - return -ENOMEM;
> - }
> -
> - memcpy(ptr, pattrib->dst, ETH_ALEN);
>=20
> - memcpy(ptr + ETH_ALEN, pattrib->src, ETH_ALEN);
>=20
> - if (!bsnaphdr) {
> - __be16 be_tmp =3D htons(len);
> -
> - memcpy(ptr + 12, &be_tmp, 2);
> - }
> - return 0;
> -}
> -
> -void r8712_recv_entry(union recv_frame *precvframe)
> -{
> - struct _adapter *padapter;
> - struct recv_priv *precvpriv;
> -
> - s32 ret =3D _SUCCESS;
> -
> - padapter =3D precvframe->u.hdr.adapter;
>=20
> - precvpriv =3D &padapter->recvpriv;
>=20
> -
> - padapter->ledpriv.LedControlHandler(padapter, LED_CTL_RX);
>=20
> -
> - ret =3D recv_func(padapter, precvframe);
> - if (ret =3D=3D _FAIL)
> - goto _recv_entry_drop;
> - precvpriv->rx_pkts++;
>=20
> - precvpriv->rx_bytes +=3D (uint)(precvframe->u.hdr.rx_tail -
>=20
> - precvframe->u.hdr.rx_data);
>=20
> - return;
> -_recv_entry_drop:
> - precvpriv->rx_drop++;
>=20
> - padapter->mppriv.rx_pktloss =3D precvpriv->rx_drop;
>=20
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_recv.h b/drivers/staging/rtl=
8712/rtl871x_recv.h
> deleted file mode 100644
> index 0760bccbf389..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_recv.h
> +++ /dev/null
> @@ -1,208 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -#ifndef RTL871X_RECV_H
> -#define RTL871X_RECV_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -#define NR_RECVFRAME 256
> -
> -#define RXFRAME_ALIGN 8
> -#define RXFRAME_ALIGN_SZ (1 << RXFRAME_ALIGN)
> -
> -#define MAX_SUBFRAME_COUNT 64
> -
> -/ for Rx reordering buffer control */
> -struct recv_reorder_ctrl {
> - struct _adapter padapter;
> - u16 indicate_seq; / =3Dwstart_b, init_value=3D0xffff /
> - u16 wend_b;
> - u8 wsize_b;
> - struct __queue pending_recvframe_queue;
> - struct timer_list reordering_ctrl_timer;
> -};
> -
> -struct stainfo_rxcache {
> - u16 tid_rxseq[16];
> -};
> -
> -#define PHY_RSSI_SLID_WIN_MAX 100
> -#define PHY_LINKQUALITY_SLID_WIN_MAX 20
> -
> -struct smooth_rssi_data {
> - u32 elements[100]; / array to store values /
> - u32 index; / index to current array to store /
> - u32 total_num; / num of valid elements /
> - u32 total_val; / sum of valid elements /
> -};
> -
> -struct rx_pkt_attrib {
> - u8 amsdu;
> - u8 order;
> - u8 qos;
> - u8 to_fr_ds;
> - u8 frag_num;
> - u16 seq_num;
> - u8 pw_save;
> - u8 mfrag;
> - u8 mdata;
> - u8 privacy; / in frame_ctrl field /
> - u8 bdecrypted;
> - int hdrlen; / the WLAN Header Len /
> - int encrypt; / 0 no encrypt. !=3D 0 encrypt algorithm /
> - int iv_len;
> - int icv_len;
> - int priority;
> - int ack_policy;
> - u8 crc_err;
> - u8 dst[ETH_ALEN];
> - u8 src[ETH_ALEN];
> - u8 ta[ETH_ALEN];
> - u8 ra[ETH_ALEN];
> - u8 bssid[ETH_ALEN];
> - u8 tcpchk_valid; / 0: invalid, 1: valid /
> - u8 ip_chkrpt; / 0: incorrect, 1: correct /
> - u8 tcp_chkrpt; / 0: incorrect, 1: correct /
> - u8 signal_qual;
> - s8 rx_mimo_signal_qual[2];
> - u8 mcs_rate;
> - u8 htc;
> - u8 signal_strength;
> -};
> -
> -/
> - * accesser of recv_priv: recv_entry(dispatch / passive level);
> - * recv_thread(passive) ; returnpkt(dispatch)
> - * ; halt(passive) ;
> - *
> - * using enter_critical section to protect
> - */
> -struct recv_priv {
> - spinlock_t lock;
> - struct __queue free_recv_queue;
> - struct __queue recv_pending_queue;
> - u8 *pallocated_frame_buf;
> - u8 *precv_frame_buf;
> - uint free_recvframe_cnt;
> - struct _adapter *adapter;
> - uint rx_bytes;
> - uint rx_pkts;
> - uint rx_drop;
> - uint rx_icv_err;
> - uint rx_largepacket_crcerr;
> - uint rx_smallpacket_crcerr;
> - uint rx_middlepacket_crcerr;
> - u8 rx_pending_cnt;
> - uint ff_hwaddr;
> - struct tasklet_struct recv_tasklet;
> - struct sk_buff_head free_recv_skb_queue;
> - struct sk_buff_head rx_skb_queue;
> - u8 *pallocated_recv_buf;
> - u8 precv_buf; / 4 alignment /
> - struct __queue free_recv_buf_queue;
> - u32 free_recv_buf_queue_cnt;
> - / For the phy information /
> - s8 rssi;
> - u8 signal;
> - u8 noise;
> - u8 fw_rssi;
> - struct smooth_rssi_data signal_qual_data;
> - struct smooth_rssi_data signal_strength_data;
> -};
> -
> -struct sta_recv_priv {
> - spinlock_t lock;
> - sint option;
> - struct __queue defrag_q; / keeping the fragment frame until defrag /
> - struct stainfo_rxcache rxcache;
> - uint sta_rx_bytes;
> - uint sta_rx_pkts;
> - uint sta_rx_fail;
> -};
> -
> -#include "rtl8712_recv.h"
> -
> -/ get a free recv_frame from pfree_recv_queue */
> -union recv_frame *r8712_alloc_recvframe(struct __queue *pfree_recv_queue=
);
> -void r8712_free_recvframe(union recv_frame *precvframe,
> - struct __queue *pfree_recv_queue);
> -void r8712_free_recvframe_queue(struct __queue *pframequeue,
> - struct __queue *pfree_recv_queue);
> -int r8712_wlanhdr_to_ethhdr(union recv_frame *precvframe);
> -int recv_func(struct _adapter *padapter, void *pcontext);
> -
> -static inline u8 *get_rxmem(union recv_frame precvframe)
> -{
> - / always return rx_head... */
> - if (!precvframe)
> - return NULL;
> - return precvframe->u.hdr.rx_head;
>=20
> -}
> -
> -static inline u8 *recvframe_pull(union recv_frame precvframe, sint sz)
> -{
> - / used for extract sz bytes from rx_data, update rx_data and return
> - * the updated rx_data to the caller
> - */
> - if (!precvframe)
> - return NULL;
> - precvframe->u.hdr.rx_data +=3D sz;
>=20
> - if (precvframe->u.hdr.rx_data > precvframe->u.hdr.rx_tail) {
>=20
> - precvframe->u.hdr.rx_data -=3D sz;
>=20
> - return NULL;
> - }
> - precvframe->u.hdr.len -=3D sz;
>=20
> - return precvframe->u.hdr.rx_data;
>=20
> -}
> -
> -static inline u8 *recvframe_put(union recv_frame precvframe, sint sz)
> -{
> - / used for append sz bytes from ptr to rx_tail, update rx_tail and
> - * return the updated rx_tail to the caller
> - * after putting, rx_tail must be still larger than rx_end.
> - */
> - if (!precvframe)
> - return NULL;
> - precvframe->u.hdr.rx_tail +=3D sz;
>=20
> - if (precvframe->u.hdr.rx_tail > precvframe->u.hdr.rx_end) {
>=20
> - precvframe->u.hdr.rx_tail -=3D sz;
>=20
> - return NULL;
> - }
> - precvframe->u.hdr.len +=3D sz;
>=20
> - return precvframe->u.hdr.rx_tail;
>=20
> -}
> -
> -static inline u8 *recvframe_pull_tail(union recv_frame precvframe, sint =
sz)
> -{
> - / rmv data from rx_tail (by yitsen)
> - * used for extract sz bytes from rx_end, update rx_end and return the
> - * updated rx_end to the caller
> - * after pulling, rx_end must be still larger than rx_data.
> - */
> - if (!precvframe)
> - return NULL;
> - precvframe->u.hdr.rx_tail -=3D sz;
>=20
> - if (precvframe->u.hdr.rx_tail < precvframe->u.hdr.rx_data) {
>=20
> - precvframe->u.hdr.rx_tail +=3D sz;
>=20
> - return NULL;
> - }
> - precvframe->u.hdr.len -=3D sz;
>=20
> - return precvframe->u.hdr.rx_tail;
>=20
> -}
> -
> -struct sta_info;
> -
> -void _r8712_init_sta_recv_priv(struct sta_recv_priv psta_recvpriv);
> -sint r8712_recvframe_chkmic(struct _adapter adapter,
> - union recv_frame precvframe);
> -union recv_frame r8712_decryptor(struct _adapter adapter,
> - union recv_frame precv_frame);
> -union recv_frame r8712_recvframe_chk_defrag(struct _adapter adapter,
> - union recv_frame precv_frame);
> -int r8712_validate_recv_frame(struct _adapter adapter,
> - union recv_frame precv_frame);
> -union recv_frame r8712_portctrl(struct _adapter adapter,
> - union recv_frame precv_frame);
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_rf.h b/drivers/staging/rtl87=
12/rtl871x_rf.h
> deleted file mode 100644
> index 7d98921a48fa..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_rf.h
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/****************************************************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef _RTL871X_RF_H
> -#define _RTL871X_RF_H
> -
> -#include "rtl871x_cmd.h"
> -#include "rtl871x_mp_phy_regdef.h"
> -
> -#define OFDM_PHY 1
> -#define MIXED_PHY 2
> -#define CCK_PHY 3
> -#define NumRates (13)
> -#define RTL8711_RF_MAX_SENS 6
> -#define RTL8711_RF_DEF_SENS 4
> -#define NUM_CHANNELS 15
> -
> -struct regulatory_class {
> - u32 starting_freq; /MHz, /
> - u8 channel_set[NUM_CHANNELS];
> - u8 channel_cck_power[NUM_CHANNELS]; /dbm/
> - u8 channel_ofdm_power[NUM_CHANNELS];/dbm/
> - u8 txpower_limit; /dbm/
> - u8 channel_spacing; /MHz/
> - u8 modem;
> -};
> -
> -enum _REG_PREAMBLE_MODE {
> - PREAMBLE_LONG =3D 1,
> - PREAMBLE_AUTO =3D 2,
> - PREAMBLE_SHORT =3D 3,
> -};
> -
> -enum {
> - RTL8712_RFC_1T =3D 0x10,
> - RTL8712_RFC_2T =3D 0x20,
> - RTL8712_RFC_1R =3D 0x01,
> - RTL8712_RFC_2R =3D 0x02,
> - RTL8712_RFC_1T1R =3D 0x11,
> - RTL8712_RFC_1T2R =3D 0x12,
> - RTL8712_RFC_TURBO =3D 0x92,
> - RTL8712_RFC_2T2R =3D 0x22
> -};
> -
> -#endif /_RTL871X_RF_H/
> diff --git a/drivers/staging/rtl8712/rtl871x_security.c b/drivers/staging=
/rtl8712/rtl871x_security.c
> deleted file mode 100644
> index e46a5dbc7b65..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_security.c
> +++ /dev/null
> @@ -1,1386 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl871x_security.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_SECURITY_C
> -
> -#include <linux/compiler.h>
>=20
> -#include <linux/kernel.h>
>=20
> -#include <linux/errno.h>
>=20
> -#include <linux/slab.h>
>=20
> -#include <linux/module.h>
>=20
> -#include <linux/kref.h>
>=20
> -#include <linux/netdevice.h>
>=20
> -#include <linux/skbuff.h>
>=20
> -#include <linux/circ_buf.h>
>=20
> -#include <linux/uaccess.h>
>=20
> -#include <asm/byteorder.h>
>=20
> -#include <linux/atomic.h>
>=20
> -#include <linux/crc32poly.h>
>=20
> -#include <linux/semaphore.h>
>=20
> -#include <linux/ieee80211.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "osdep_intf.h"
> -
> -/* =3D=3D=3D=3D=3DWEP related=3D=3D=3D=3D=3D */
> -
> -struct arc4context {
> - u32 x;
> - u32 y;
> - u8 state[256];
> -};
> -
> -static void arcfour_init(struct arc4context *parc4ctx, u8 *key, u32 key_=
len)
> -{
> - u32 t, u;
> - u32 keyindex;
> - u32 stateindex;
> - u8 *state;
> - u32 counter;
> -
> - state =3D parc4ctx->state;
>=20
> - parc4ctx->x =3D 0;
>=20
> - parc4ctx->y =3D 0;
>=20
> - for (counter =3D 0; counter < 256; counter++)
> - state[counter] =3D (u8)counter;
> - keyindex =3D 0;
> - stateindex =3D 0;
> - for (counter =3D 0; counter < 256; counter++) {
> - t =3D state[counter];
> - stateindex =3D (stateindex + key[keyindex] + t) & 0xff;
> - u =3D state[stateindex];
> - state[stateindex] =3D (u8)t;
> - state[counter] =3D (u8)u;
> - if (++keyindex >=3D key_len)
>=20
> - keyindex =3D 0;
> - }
> -}
> -
> -static u32 arcfour_byte(struct arc4context *parc4ctx)
> -{
> - u32 x;
> - u32 y;
> - u32 sx, sy;
> - u8 *state;
> -
> - state =3D parc4ctx->state;
>=20
> - x =3D (parc4ctx->x + 1) & 0xff;
>=20
> - sx =3D state[x];
> - y =3D (sx + parc4ctx->y) & 0xff;
>=20
> - sy =3D state[y];
> - parc4ctx->x =3D x;
>=20
> - parc4ctx->y =3D y;
>=20
> - state[y] =3D (u8)sx;
> - state[x] =3D (u8)sy;
> - return state[(sx + sy) & 0xff];
> -}
> -
> -static void arcfour_encrypt(struct arc4context *parc4ctx,
> - u8 *dest, u8 *src, u32 len)
> -{
> - u32 i;
> -
> - for (i =3D 0; i < len; i++)
> - dest[i] =3D src[i] ^ (unsigned char)arcfour_byte(parc4ctx);
> -}
> -
> -static sint bcrc32initialized;
> -static u32 crc32_table[256];
> -
> -static u8 crc32_reverseBit(u8 data)
> -{
> - return ((u8)(data << 7) & 0x80) | ((data << 5) & 0x40) | ((data << 3)
> - & 0x20) | ((data << 1) & 0x10) | ((data >> 1) & 0x08) |
>=20
> - ((data >> 3) & 0x04) | ((data >> 5) & 0x02) | ((data >> 7) &
>=20
> - 0x01);
> -}
> -
> -static void crc32_init(void)
> -{
> - sint i, j;
> - u32 c;
> - u8 *p =3D (u8 *)&c, *p1;
> - u8 k;
> -
> - if (bcrc32initialized =3D=3D 1)
> - return;
> -
> - for (i =3D 0; i < 256; ++i) {
> - k =3D crc32_reverseBit((u8)i);
> - for (c =3D ((u32)k) << 24, j =3D 8; j > 0; --j)
>=20
> - c =3D c & 0x80000000 ? (c << 1) ^ CRC32_POLY_BE : (c << 1);
> - p1 =3D (u8 *)&crc32_table[i];
> - p1[0] =3D crc32_reverseBit(p[3]);
> - p1[1] =3D crc32_reverseBit(p[2]);
> - p1[2] =3D crc32_reverseBit(p[1]);
> - p1[3] =3D crc32_reverseBit(p[0]);
> - }
> - bcrc32initialized =3D 1;
> -}
> -
> -static u32 getcrc32(u8 *buf, u32 len)
> -{
> - u8 p;
> - u32 crc;
> -
> - if (!bcrc32initialized)
> - crc32_init();
> - crc =3D 0xffffffff; / preload shift register, per CRC-32 spec */
> - for (p =3D buf; len > 0; ++p, --len)
>=20
> - crc =3D crc32_table[(crc ^ *p) & 0xff] ^ (crc >> 8);
>=20
> - return ~crc; /* transmit complement, per CRC-32 spec /
> -}
> -
> -/
> - * Need to consider the fragment situation
> - */
> -void r8712_wep_encrypt(struct _adapter *padapter, u8 pxmitframe)
> -{ / exclude ICV */
> - unsigned char crc[4];
> - struct arc4context mycontext;
> - u32 curfragnum, length, keylength, pki;
> - u8 *pframe, *payload, iv; /,wepkey/
> - u8 wepkey[16];
> - struct pkt_attrib *pattrib =3D &((struct xmit_frame *)
> - pxmitframe)->attrib;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> -
> - if (((struct xmit_frame *)pxmitframe)->buf_addr =3D=3D NULL)
>=20
> - return;
> - pframe =3D ((struct xmit_frame *)pxmitframe)->buf_addr + TXDESC_OFFSET;
>=20
> - /start to encrypt each fragment/
> - if ((pattrib->encrypt =3D=3D WEP40) || (pattrib->encrypt =3D=3D WEP104)=
) {
>=20
> - pki =3D psecuritypriv->PrivacyKeyIndex;
>=20
> - keylength =3D psecuritypriv->DefKeylen[pki];
>=20
> - for (curfragnum =3D 0; curfragnum < pattrib->nr_frags;
>=20
> - curfragnum++) {
> - iv =3D pframe + pattrib->hdrlen;
>=20
> - memcpy(&wepkey[0], iv, 3);
> - memcpy(&wepkey[3], &psecuritypriv->DefKey[
>=20
> - psecuritypriv->PrivacyKeyIndex].skey[0],
>=20
> - keylength);
> - payload =3D pframe + pattrib->iv_len + pattrib->hdrlen;
>=20
> - if ((curfragnum + 1) =3D=3D pattrib->nr_frags) {
>=20
> - length =3D pattrib->last_txcmdsz -
>=20
> - pattrib->hdrlen -
>=20
> - pattrib->iv_len -
>=20
> - pattrib->icv_len;
>=20
> - *((__le32 *)crc) =3D cpu_to_le32(getcrc32(
> - payload, length));
> - arcfour_init(&mycontext, wepkey, 3 + keylength);
> - arcfour_encrypt(&mycontext, payload, payload,
> - length);
> - arcfour_encrypt(&mycontext, payload + length,
> - crc, 4);
> - } else {
> - length =3D pxmitpriv->frag_len -
>=20
> - pattrib->hdrlen - pattrib->iv_len -
>=20
> - pattrib->icv_len;
>=20
> - *((__le32 *)crc) =3D cpu_to_le32(getcrc32(
> - payload, length));
> - arcfour_init(&mycontext, wepkey, 3 + keylength);
> - arcfour_encrypt(&mycontext, payload, payload,
> - length);
> - arcfour_encrypt(&mycontext, payload + length,
> - crc, 4);
> - pframe +=3D pxmitpriv->frag_len;
>=20
> - pframe =3D (u8 *)RND4((addr_t)(pframe));
> - }
> - }
> - }
> -}
> -
> -void r8712_wep_decrypt(struct _adapter *padapter, u8 precvframe)
> -{
> - / exclude ICV */
> - u8 crc[4];
> - struct arc4context mycontext;
> - u32 length, keylength;
> - u8 *pframe, *payload, *iv, wepkey[16];
> - u8 keyindex;
> - struct rx_pkt_attrib *prxattrib =3D &(((union recv_frame *)
> - precvframe)->u.hdr.attrib);
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> -
> - pframe =3D (unsigned char *)((union recv_frame *)precvframe)->
>=20
> - u.hdr.rx_data;
> - /* start to decrypt recvframe */
> - if ((prxattrib->encrypt =3D=3D WEP40) || (prxattrib->encrypt =3D=3D
>=20
> - WEP104)) {
> - iv =3D pframe + prxattrib->hdrlen;
>=20
> - keyindex =3D (iv[3] & 0x3);
> - keylength =3D psecuritypriv->DefKeylen[keyindex];
>=20
> - memcpy(&wepkey[0], iv, 3);
> - memcpy(&wepkey[3], &psecuritypriv->DefKey[
>=20
> - psecuritypriv->PrivacyKeyIndex].skey[0],
>=20
> - keylength);
> - length =3D ((union recv_frame *)precvframe)->
>=20
> - u.hdr.len - prxattrib->hdrlen - prxattrib->iv_len;
>=20
> - payload =3D pframe + prxattrib->iv_len + prxattrib->hdrlen;
>=20
> - /* decrypt payload include icv /
> - arcfour_init(&mycontext, wepkey, 3 + keylength);
> - arcfour_encrypt(&mycontext, payload, payload, length);
> - / calculate icv and compare the icv */
> - *((__le32 )crc) =3D cpu_to_le32(getcrc32(payload, length - 4));
> - }
> -}
> -
> -/ 3 =3D=3D=3D=3D=3DTKIP related=3D=3D=3D=3D=3D */
> -
> -static u32 secmicgetuint32(u8 p)
> -/ Convert from Byte[] to Us4Byte32 in a portable way */
> -{
> - s32 i;
> - u32 res =3D 0;
> -
> - for (i =3D 0; i < 4; i++)
> - res |=3D ((u32)(*p++)) << (8 * i);
> - return res;
> -}
> -
> -static void secmicputuint32(u8 p, u32 val)
> -/ Convert from Us4Byte32 to Byte[] in a portable way */
> -{
> - long i;
> -
> - for (i =3D 0; i < 4; i++) {
> - *p++ =3D (u8)(val & 0xff);
> - val >>=3D 8;
>=20
> - }
> -}
> -
> -static void secmicclear(struct mic_data pmicdata)
> -{
> -/ Reset the state to the empty message. */
> - pmicdata->L =3D pmicdata->K0;
>=20
> - pmicdata->R =3D pmicdata->K1;
>=20
> - pmicdata->nBytesInM =3D 0;
>=20
> - pmicdata->M =3D 0;
>=20
> -}
> -
> -void r8712_secmicsetkey(struct mic_data *pmicdata, u8 key)
> -{
> - / Set the key */
> - pmicdata->K0 =3D secmicgetuint32(key);
>=20
> - pmicdata->K1 =3D secmicgetuint32(key + 4);
>=20
> - /* and reset the message */
> - secmicclear(pmicdata);
> -}
> -
> -static void secmicappendbyte(struct mic_data pmicdata, u8 b)
> -{
> - / Append the byte to our word-sized buffer */
> - pmicdata->M |=3D ((u32)b) << (8 * pmicdata->nBytesInM);
>=20
> - pmicdata->nBytesInM++;
>=20
> - /* Process the word if it is full. */
> - if (pmicdata->nBytesInM >=3D 4) {
>=20
> - pmicdata->L ^=3D pmicdata->M;
>=20
> - pmicdata->R ^=3D ROL32(pmicdata->L, 17);
>=20
> - pmicdata->L +=3D pmicdata->R;
>=20
> - pmicdata->R ^=3D ((pmicdata->L & 0xff00ff00) >> 8) |
>=20
> - ((pmicdata->L & 0x00ff00ff) << 8);
>=20
> - pmicdata->L +=3D pmicdata->R;
>=20
> - pmicdata->R ^=3D ROL32(pmicdata->L, 3);
>=20
> - pmicdata->L +=3D pmicdata->R;
>=20
> - pmicdata->R ^=3D ROR32(pmicdata->L, 2);
>=20
> - pmicdata->L +=3D pmicdata->R;
>=20
> - /* Clear the buffer */
> - pmicdata->M =3D 0;
>=20
> - pmicdata->nBytesInM =3D 0;
>=20
> - }
> -}
> -
> -void r8712_secmicappend(struct mic_data *pmicdata, u8 src, u32 nbytes)
> -{
> - / This is simple */
> - while (nbytes > 0) {
>=20
> - secmicappendbyte(pmicdata, *src++);
> - nbytes--;
> - }
> -}
> -
> -void r8712_secgetmic(struct mic_data *pmicdata, u8 dst)
> -{
> - / Append the minimum padding /
> - secmicappendbyte(pmicdata, 0x5a);
> - secmicappendbyte(pmicdata, 0);
> - secmicappendbyte(pmicdata, 0);
> - secmicappendbyte(pmicdata, 0);
> - secmicappendbyte(pmicdata, 0);
> - / and then zeroes until the length is a multiple of 4 */
> - while (pmicdata->nBytesInM !=3D 0)
>=20
> - secmicappendbyte(pmicdata, 0);
> - /* The appendByte function has already computed the result. */
> - secmicputuint32(dst, pmicdata->L);
>=20
> - secmicputuint32(dst + 4, pmicdata->R);
>=20
> - /* Reset to the empty message. */
> - secmicclear(pmicdata);
> -}
> -
> -void seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 mic_=
code,
> - u8 pri)
> -{
> -
> - struct mic_data micdata;
> - u8 priority[4] =3D {0x0, 0x0, 0x0, 0x0};
> -
> - r8712_secmicsetkey(&micdata, key);
> - priority[0] =3D pri;
> - / Michael MIC pseudo header: DA, SA, 3 x 0, Priority /
> - if (header[1] & 1) { / ToDS=3D=3D1 /
> - r8712_secmicappend(&micdata, &header[16], 6); / DA /
> - if (header[1] & 2) / From Ds=3D=3D1 /
> - r8712_secmicappend(&micdata, &header[24], 6);
> - else
> - r8712_secmicappend(&micdata, &header[10], 6);
> - } else { / ToDS=3D=3D0 /
> - r8712_secmicappend(&micdata, &header[4], 6); / DA /
> - if (header[1] & 2) / From Ds=3D=3D1 /
> - r8712_secmicappend(&micdata, &header[16], 6);
> - else
> - r8712_secmicappend(&micdata, &header[10], 6);
> - }
> - r8712_secmicappend(&micdata, &priority[0], 4);
> - r8712_secmicappend(&micdata, data, data_len);
> - r8712_secgetmic(&micdata, mic_code);
> -}
> -
> -/ macros for extraction/creation of unsigned char/unsigned short values =
*/
> -#define RotR1(v16) ((((v16) >> 1) & 0x7FFF) ^ (((v16) & 1) << 15))
>=20
> -#define Lo8(v16) ((u8)((v16) & 0x00FF))
> -#define Hi8(v16) ((u8)(((v16) >> 8) & 0x00FF))
>=20
> -#define Lo16(v32) ((u16)((v32) & 0xFFFF))
> -#define Hi16(v32) ((u16)(((v32) >> 16) & 0xFFFF))
>=20
> -#define Mk16(hi, lo) ((lo) ^ (((u16)(hi)) << 8))
> -
> -/* select the Nth 16-bit word of the temporal key unsigned char array TK=
[] /
> -#define TK16(N) Mk16(tk[2 * (N) + 1], tk[2 * (N)])
> -
> -/ S-box lookup: 16 bits --> 16 bits */
>=20
> -#define S(v16) (Sbox1[0][Lo8(v16)] ^ Sbox1[1][Hi8(v16)])
> -
> -/* fixed algorithm "parameters" /
> -#define PHASE1_LOOP_CNT 8 / this needs to be "big enough" /
> -#define TA_SIZE 6 / 48-bit transmitter address /
> -#define TK_SIZE 16 / 128-bit temporal key /
> -#define P1K_SIZE 10 / 80-bit Phase1 key /
> -#define RC4_KEY_SIZE 16 / 128-bit RC4KEY (104 bits unknown) /
> -
> -/ 2-unsigned char by 2-unsigned char subset of the full AES S-box table =
/
> -static const unsigned short Sbox1[2][256] =3D {/ Sbox for hash (can be i=
n ROM) /
> - {
> - 0xC6A5, 0xF884, 0xEE99, 0xF68D, 0xFF0D, 0xD6BD, 0xDEB1, 0x9154,
> - 0x6050, 0x0203, 0xCEA9, 0x567D, 0xE719, 0xB562, 0x4DE6, 0xEC9A,
> - 0x8F45, 0x1F9D, 0x8940, 0xFA87, 0xEF15, 0xB2EB, 0x8EC9, 0xFB0B,
> - 0x41EC, 0xB367, 0x5FFD, 0x45EA, 0x23BF, 0x53F7, 0xE496, 0x9B5B,
> - 0x75C2, 0xE11C, 0x3DAE, 0x4C6A, 0x6C5A, 0x7E41, 0xF502, 0x834F,
> - 0x685C, 0x51F4, 0xD134, 0xF908, 0xE293, 0xAB73, 0x6253, 0x2A3F,
> - 0x080C, 0x9552, 0x4665, 0x9D5E, 0x3028, 0x37A1, 0x0A0F, 0x2FB5,
> - 0x0E09, 0x2436, 0x1B9B, 0xDF3D, 0xCD26, 0x4E69, 0x7FCD, 0xEA9F,
> - 0x121B, 0x1D9E, 0x5874, 0x342E, 0x362D, 0xDCB2, 0xB4EE, 0x5BFB,
> - 0xA4F6, 0x764D, 0xB761, 0x7DCE, 0x527B, 0xDD3E, 0x5E71, 0x1397,
> - 0xA6F5, 0xB968, 0x0000, 0xC12C, 0x4060, 0xE31F, 0x79C8, 0xB6ED,
> - 0xD4BE, 0x8D46, 0x67D9, 0x724B, 0x94DE, 0x98D4, 0xB0E8, 0x854A,
> - 0xBB6B, 0xC52A, 0x4FE5, 0xED16, 0x86C5, 0x9AD7, 0x6655, 0x1194,
> - 0x8ACF, 0xE910, 0x0406, 0xFE81, 0xA0F0, 0x7844, 0x25BA, 0x4BE3,
> - 0xA2F3, 0x5DFE, 0x80C0, 0x058A, 0x3FAD, 0x21BC, 0x7048, 0xF104,
> - 0x63DF, 0x77C1, 0xAF75, 0x4263, 0x2030, 0xE51A, 0xFD0E, 0xBF6D,
> - 0x814C, 0x1814, 0x2635, 0xC32F, 0xBEE1, 0x35A2, 0x88CC, 0x2E39,
> - 0x9357, 0x55F2, 0xFC82, 0x7A47, 0xC8AC, 0xBAE7, 0x322B, 0xE695,
> - 0xC0A0, 0x1998, 0x9ED1, 0xA37F, 0x4466, 0x547E, 0x3BAB, 0x0B83,
> - 0x8CCA, 0xC729, 0x6BD3, 0x283C, 0xA779, 0xBCE2, 0x161D, 0xAD76,
> - 0xDB3B, 0x6456, 0x744E, 0x141E, 0x92DB, 0x0C0A, 0x486C, 0xB8E4,
> - 0x9F5D, 0xBD6E, 0x43EF, 0xC4A6, 0x39A8, 0x31A4, 0xD337, 0xF28B,
> - 0xD532, 0x8B43, 0x6E59, 0xDAB7, 0x018C, 0xB164, 0x9CD2, 0x49E0,
> - 0xD8B4, 0xACFA, 0xF307, 0xCF25, 0xCAAF, 0xF48E, 0x47E9, 0x1018,
> - 0x6FD5, 0xF088, 0x4A6F, 0x5C72, 0x3824, 0x57F1, 0x73C7, 0x9751,
> - 0xCB23, 0xA17C, 0xE89C, 0x3E21, 0x96DD, 0x61DC, 0x0D86, 0x0F85,
> - 0xE090, 0x7C42, 0x71C4, 0xCCAA, 0x90D8, 0x0605, 0xF701, 0x1C12,
> - 0xC2A3, 0x6A5F, 0xAEF9, 0x69D0, 0x1791, 0x9958, 0x3A27, 0x27B9,
> - 0xD938, 0xEB13, 0x2BB3, 0x2233, 0xD2BB, 0xA970, 0x0789, 0x33A7,
> - 0x2DB6, 0x3C22, 0x1592, 0xC920, 0x8749, 0xAAFF, 0x5078, 0xA57A,
> - 0x038F, 0x59F8, 0x0980, 0x1A17, 0x65DA, 0xD731, 0x84C6, 0xD0B8,
> - 0x82C3, 0x29B0, 0x5A77, 0x1E11, 0x7BCB, 0xA8FC, 0x6DD6, 0x2C3A,
> - },
> - { / second half is unsigned char-reversed version of first! /
> - 0xA5C6, 0x84F8, 0x99EE, 0x8DF6, 0x0DFF, 0xBDD6, 0xB1DE, 0x5491,
> - 0x5060, 0x0302, 0xA9CE, 0x7D56, 0x19E7, 0x62B5, 0xE64D, 0x9AEC,
> - 0x458F, 0x9D1F, 0x4089, 0x87FA, 0x15EF, 0xEBB2, 0xC98E, 0x0BFB,
> - 0xEC41, 0x67B3, 0xFD5F, 0xEA45, 0xBF23, 0xF753, 0x96E4, 0x5B9B,
> - 0xC275, 0x1CE1, 0xAE3D, 0x6A4C, 0x5A6C, 0x417E, 0x02F5, 0x4F83,
> - 0x5C68, 0xF451, 0x34D1, 0x08F9, 0x93E2, 0x73AB, 0x5362, 0x3F2A,
> - 0x0C08, 0x5295, 0x6546, 0x5E9D, 0x2830, 0xA137, 0x0F0A, 0xB52F,
> - 0x090E, 0x3624, 0x9B1B, 0x3DDF, 0x26CD, 0x694E, 0xCD7F, 0x9FEA,
> - 0x1B12, 0x9E1D, 0x7458, 0x2E34, 0x2D36, 0xB2DC, 0xEEB4, 0xFB5B,
> - 0xF6A4, 0x4D76, 0x61B7, 0xCE7D, 0x7B52, 0x3EDD, 0x715E, 0x9713,
> - 0xF5A6, 0x68B9, 0x0000, 0x2CC1, 0x6040, 0x1FE3, 0xC879, 0xEDB6,
> - 0xBED4, 0x468D, 0xD967, 0x4B72, 0xDE94, 0xD498, 0xE8B0, 0x4A85,
> - 0x6BBB, 0x2AC5, 0xE54F, 0x16ED, 0xC586, 0xD79A, 0x5566, 0x9411,
> - 0xCF8A, 0x10E9, 0x0604, 0x81FE, 0xF0A0, 0x4478, 0xBA25, 0xE34B,
> - 0xF3A2, 0xFE5D, 0xC080, 0x8A05, 0xAD3F, 0xBC21, 0x4870, 0x04F1,
> - 0xDF63, 0xC177, 0x75AF, 0x6342, 0x3020, 0x1AE5, 0x0EFD, 0x6DBF,
> - 0x4C81, 0x1418, 0x3526, 0x2FC3, 0xE1BE, 0xA235, 0xCC88, 0x392E,
> - 0x5793, 0xF255, 0x82FC, 0x477A, 0xACC8, 0xE7BA, 0x2B32, 0x95E6,
> - 0xA0C0, 0x9819, 0xD19E, 0x7FA3, 0x6644, 0x7E54, 0xAB3B, 0x830B,
> - 0xCA8C, 0x29C7, 0xD36B, 0x3C28, 0x79A7, 0xE2BC, 0x1D16, 0x76AD,
> - 0x3BDB, 0x5664, 0x4E74, 0x1E14, 0xDB92, 0x0A0C, 0x6C48, 0xE4B8,
> - 0x5D9F, 0x6EBD, 0xEF43, 0xA6C4, 0xA839, 0xA431, 0x37D3, 0x8BF2,
> - 0x32D5, 0x438B, 0x596E, 0xB7DA, 0x8C01, 0x64B1, 0xD29C, 0xE049,
> - 0xB4D8, 0xFAAC, 0x07F3, 0x25CF, 0xAFCA, 0x8EF4, 0xE947, 0x1810,
> - 0xD56F, 0x88F0, 0x6F4A, 0x725C, 0x2438, 0xF157, 0xC773, 0x5197,
> - 0x23CB, 0x7CA1, 0x9CE8, 0x213E, 0xDD96, 0xDC61, 0x860D, 0x850F,
> - 0x90E0, 0x427C, 0xC471, 0xAACC, 0xD890, 0x0506, 0x01F7, 0x121C,
> - 0xA3C2, 0x5F6A, 0xF9AE, 0xD069, 0x9117, 0x5899, 0x273A, 0xB927,
> - 0x38D9, 0x13EB, 0xB32B, 0x3322, 0xBBD2, 0x70A9, 0x8907, 0xA733,
> - 0xB62D, 0x223C, 0x9215, 0x20C9, 0x4987, 0xFFAA, 0x7850, 0x7AA5,
> - 0x8F03, 0xF859, 0x8009, 0x171A, 0xDA65, 0x31D7, 0xC684, 0xB8D0,
> - 0xC382, 0xB029, 0x775A, 0x111E, 0xCB7B, 0xFCA8, 0xD66D, 0x3A2C,
> - }
> -};
> -
> -/
> - **********************************************************************
> - * Routine: Phase 1 -- generate P1K, given TA, TK, IV32
> - *
> - * Inputs:
> - * tk[] =3D temporal key [128 bits]
> - * ta[] =3D transmitter's MAC address [ 48 bits]
> - * iv32 =3D upper 32 bits of IV [ 32 bits]
> - * Output:
> - * p1k[] =3D Phase 1 key [ 80 bits]
> - *
> - * Note:
> - * This function only needs to be called every 216 packets,
> - * although in theory it could be called every packet.
> - *
> - **********************************************************************
> - */
> -static void phase1(u16 *p1k, const u8 *tk, const u8 ta, u32 iv32)
> -{
> - sint i;
> -
> - / Initialize the 80 bits of P1K[] from IV32 and TA[0..5] /
> - p1k[0] =3D Lo16(iv32);
> - p1k[1] =3D Hi16(iv32);
> - p1k[2] =3D Mk16(ta[1], ta[0]); / use TA[] as little-endian /
> - p1k[3] =3D Mk16(ta[3], ta[2]);
> - p1k[4] =3D Mk16(ta[5], ta[4]);
> - / Now compute an unbalanced Feistel cipher with 80-bit block /
> - / size on the 80-bit block P1K[], using the 128-bit key TK[] /
> - for (i =3D 0; i < PHASE1_LOOP_CNT; i++) { / Each add is mod 216 /
> - p1k[0] +=3D S(p1k[4] ^ TK16((i & 1) + 0));
> - p1k[1] +=3D S(p1k[0] ^ TK16((i & 1) + 2));
> - p1k[2] +=3D S(p1k[1] ^ TK16((i & 1) + 4));
> - p1k[3] +=3D S(p1k[2] ^ TK16((i & 1) + 6));
> - p1k[4] +=3D S(p1k[3] ^ TK16((i & 1) + 0));
> - p1k[4] +=3D (unsigned short)i; / avoid "slide attacks" /
> - }
> -}
> -
> -/
> - **********************************************************************
> - * Routine: Phase 2 -- generate RC4KEY, given TK, P1K, IV16
> - *
> - * Inputs:
> - * tk[] =3D Temporal key [128 bits]
> - * p1k[] =3D Phase 1 output key [ 80 bits]
> - * iv16 =3D low 16 bits of IV counter [ 16 bits]
> - * Output:
> - * rc4key[] =3D the key used to encrypt the packet [128 bits]
> - *
> - * Note:
> - * The value {TA,IV32,IV16} for Phase1/Phase2 must be unique
> - * across all packets using the same key TK value. Then, for a
> - * given value of TK[], this TKIP48 construction guarantees that
> - * the final RC4KEY value is unique across all packets.
> - *
> - * Suggested implementation optimization: if PPK[] is "overlaid"
> - * appropriately on RC4KEY[], there is no need for the final
> - * for loop below that copies the PPK[] result into RC4KEY[].
> - *
> - **********************************************************************
> - */
> -static void phase2(u8 *rc4key, const u8 *tk, const u16 p1k, u16 iv16)
> -{
> - sint i;
> - u16 PPK[6]; / temporary key for mixing /
> -
> - / Note: all adds in the PPK[] equations below are mod 2**16 /
> - for (i =3D 0; i < 5; i++)
> - PPK[i] =3D p1k[i]; / first, copy P1K to PPK /
> - PPK[5] =3D p1k[4] + iv16; / next, add in IV16 /
> - / Bijective non-linear mixing of the 96 bits of PPK[0..5] /
> - PPK[0] +=3D S(PPK[5] ^ TK16(0)); / Mix key in each "round" /
> - PPK[1] +=3D S(PPK[0] ^ TK16(1));
> - PPK[2] +=3D S(PPK[1] ^ TK16(2));
> - PPK[3] +=3D S(PPK[2] ^ TK16(3));
> - PPK[4] +=3D S(PPK[3] ^ TK16(4));
> - PPK[5] +=3D S(PPK[4] ^ TK16(5)); / Total # S-box lookups =3D=3D 6 /
> - / Final sweep: bijective, "linear". Rotates kill LSB correlations /
> - PPK[0] +=3D RotR1(PPK[5] ^ TK16(6));
> - PPK[1] +=3D RotR1(PPK[0] ^ TK16(7)); / Use all of TK[] in Phase2 /
> - PPK[2] +=3D RotR1(PPK[1]);
> - PPK[3] +=3D RotR1(PPK[2]);
> - PPK[4] +=3D RotR1(PPK[3]);
> - PPK[5] +=3D RotR1(PPK[4]);
> - / Note: At this point, for a given key TK[0..15], the 96-bit output /
> - / value PPK[0..5] is guaranteed to be unique, as a function /
> - / of the 96-bit "input" value {TA,IV32,IV16}. That is, P1K /
> - / is now a keyed permutation of {TA,IV32,IV16}. /
> - / Set RC4KEY[0..3], which includes "cleartext" portion of RC4 key /
> - rc4key[0] =3D Hi8(iv16); / RC4KEY[0..2] is the WEP IV /
> - rc4key[1] =3D (Hi8(iv16) | 0x20) & 0x7F; / Help avoid weak (FMS) keys *=
/
> - rc4key[2] =3D Lo8(iv16);
> - rc4key[3] =3D Lo8((PPK[5] ^ TK16(0)) >> 1);
>=20
> - /* Copy 96 bits of PPK[0..5] to RC4KEY[4..15] (little-endian) */
> - for (i =3D 0; i < 6; i++) {
> - rc4key[4 + 2 * i] =3D Lo8(PPK[i]);
> - rc4key[5 + 2 * i] =3D Hi8(PPK[i]);
> - }
> -}
> -
> -/The hlen isn't include the IV/
> -u32 r8712_tkip_encrypt(struct _adapter *padapter, u8 pxmitframe)
> -{ / exclude ICV */
> - u16 pnl;
> - u32 pnh;
> - u8 rc4key[16];
> - u8 ttkey[16];
> - u8 crc[4];
> - struct arc4context mycontext;
> - u32 curfragnum, length;
> -
> - u8 *pframe, *payload, *iv, *prwskey;
> - union pn48 txpn;
> - struct sta_info *stainfo;
> - struct pkt_attrib *pattrib =3D &((struct xmit_frame *)pxmitframe)->attr=
ib;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - u32 res =3D _SUCCESS;
> -
> - if (((struct xmit_frame *)pxmitframe)->buf_addr =3D=3D NULL)
>=20
> - return _FAIL;
> -
> - pframe =3D ((struct xmit_frame *)pxmitframe)->buf_addr + TXDESC_OFFSET;
>=20
> - /* 4 start to encrypt each fragment */
> - if (pattrib->encrypt =3D=3D TKIP) {
>=20
> - if (pattrib->psta)
>=20
> - stainfo =3D pattrib->psta;
>=20
> - else
> - stainfo =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - &pattrib->ra[0]);
>=20
> - if (stainfo) {
> - prwskey =3D &stainfo->x_UncstKey.skey[0];
>=20
> - for (curfragnum =3D 0; curfragnum < pattrib->nr_frags;
>=20
> - curfragnum++) {
> - iv =3D pframe + pattrib->hdrlen;
>=20
> - payload =3D pframe + pattrib->iv_len +
>=20
> - pattrib->hdrlen;
>=20
> - GET_TKIP_PN(iv, txpn);
> - pnl =3D (u16)(txpn.val);
> - pnh =3D (u32)(txpn.val >> 16);
>=20
> - phase1((u16 *)&ttkey[0], prwskey,
> - &pattrib->ta[0], pnh);
>=20
> - phase2(&rc4key[0], prwskey, (u16 *)&ttkey[0],
> - pnl);
> - if ((curfragnum + 1) =3D=3D pattrib->nr_frags) {
>=20
> - /* 4 the last fragment */
> - length =3D pattrib->last_txcmdsz -
>=20
> - pattrib->hdrlen -
>=20
> - pattrib->iv_len -
>=20
> - pattrib->icv_len;
>=20
> - *((__le32 *)crc) =3D cpu_to_le32(
> - getcrc32(payload, length));
> - arcfour_init(&mycontext, rc4key, 16);
> - arcfour_encrypt(&mycontext, payload,
> - payload, length);
> - arcfour_encrypt(&mycontext, payload +
> - length, crc, 4);
> - } else {
> - length =3D pxmitpriv->frag_len -
>=20
> - pattrib->hdrlen -
>=20
> - pattrib->iv_len -
>=20
> - pattrib->icv_len;
>=20
> - *((__le32 *)crc) =3D cpu_to_le32(getcrc32(
> - payload, length));
> - arcfour_init(&mycontext, rc4key, 16);
> - arcfour_encrypt(&mycontext, payload,
> - payload, length);
> - arcfour_encrypt(&mycontext,
> - payload + length, crc,
> - 4);
> - pframe +=3D pxmitpriv->frag_len;
>=20
> - pframe =3D (u8 )RND4((addr_t)(pframe));
> - }
> - }
> - } else {
> - res =3D _FAIL;
> - }
> - }
> - return res;
> -}
> -
> -/ The hlen doesn't include the IV */
> -void r8712_tkip_decrypt(struct _adapter *padapter, u8 precvframe)
> -{ / exclude ICV */
> - u16 pnl;
> - u32 pnh;
> - u8 rc4key[16];
> - u8 ttkey[16];
> - u8 crc[4];
> - struct arc4context mycontext;
> - u32 length;
> - u8 *pframe, *payload, *iv, *prwskey, idx =3D 0;
> - union pn48 txpn;
> - struct sta_info *stainfo;
> - struct rx_pkt_attrib *prxattrib =3D &((union recv_frame *)
> - precvframe)->u.hdr.attrib;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> -
> - pframe =3D (unsigned char *)((union recv_frame *)
> - precvframe)->u.hdr.rx_data;
>=20
> - /* 4 start to decrypt recvframe */
> - if (prxattrib->encrypt =3D=3D TKIP) {
>=20
> - stainfo =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - &prxattrib->ta[0]);
>=20
> - if (stainfo) {
> - iv =3D pframe + prxattrib->hdrlen;
>=20
> - payload =3D pframe + prxattrib->iv_len +
>=20
> - prxattrib->hdrlen;
>=20
> - length =3D ((union recv_frame *)precvframe)->
>=20
> - u.hdr.len - prxattrib->hdrlen -
>=20
> - prxattrib->iv_len;
>=20
> - if (is_multicast_ether_addr(prxattrib->ra)) {
>=20
> - idx =3D iv[3];
> - prwskey =3D &psecuritypriv->XGrpKey[
>=20
> - ((idx >> 6) & 0x3) - 1].skey[0];
>=20
> - if (!psecuritypriv->binstallGrpkey)
>=20
> - return;
> - } else {
> - prwskey =3D &stainfo->x_UncstKey.skey[0];
>=20
> - }
> - GET_TKIP_PN(iv, txpn);
> - pnl =3D (u16)(txpn.val);
> - pnh =3D (u32)(txpn.val >> 16);
>=20
> - phase1((u16 *)&ttkey[0], prwskey, &prxattrib->ta[0],
>=20
> - pnh);
> - phase2(&rc4key[0], prwskey, (unsigned short )
> - &ttkey[0], pnl);
> - / 4 decrypt payload include icv /
> - arcfour_init(&mycontext, rc4key, 16);
> - arcfour_encrypt(&mycontext, payload, payload, length);
> - ((__le32 )crc) =3D cpu_to_le32(getcrc32(payload,
> - length - 4));
> - }
> - }
> -}
> -
> -/ 3 =3D=3D=3D=3D=3DAES related=3D=3D=3D=3D=3D /
> -
> -#define MAX_MSG_SIZE 2048
> -/*/
> -/ SBOX Table /
> -//
> -
> -static const u8 sbox_table[256] =3D {
> - 0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
> - 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
> - 0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
> - 0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
> - 0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
> - 0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
> - 0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
> - 0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
> - 0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
> - 0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
> - 0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
> - 0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
> - 0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
> - 0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
> - 0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
> - 0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
> - 0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
> - 0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
> - 0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
> - 0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
> - 0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
> - 0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
> - 0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
> - 0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
> - 0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
> - 0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
> - 0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
> - 0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
> - 0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
> - 0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
> - 0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
> - 0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
> -};
> -
> -//
> -/ aes128k128d() /
> -/ Performs a 128 bit AES encrypt with /
> -/ 128 bit data. /
> -/***/
> -static void xor_128(u8 *a, u8 *b, u8 *out)
> -{
> - sint i;
> -
> - for (i =3D 0; i < 16; i++)
> - out[i] =3D a[i] ^ b[i];
> -}
> -
> -static void xor_32(u8 *a, u8 *b, u8 *out)
> -{
> - sint i;
> -
> - for (i =3D 0; i < 4; i++)
> - out[i] =3D a[i] ^ b[i];
> -}
> -
> -static u8 sbox(u8 a)
> -{
> - return sbox_table[(sint)a];
> -}
> -
> -static void next_key(u8 *key, sint round)
> -{
> - u8 rcon;
> - u8 sbox_key[4];
> - static const u8 rcon_table[12] =3D {
> - 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80,
> - 0x1b, 0x36, 0x36, 0x36
> - };
> -
> - sbox_key[0] =3D sbox(key[13]);
> - sbox_key[1] =3D sbox(key[14]);
> - sbox_key[2] =3D sbox(key[15]);
> - sbox_key[3] =3D sbox(key[12]);
> - rcon =3D rcon_table[round];
> - xor_32(&key[0], sbox_key, &key[0]);
> - key[0] =3D key[0] ^ rcon;
> - xor_32(&key[4], &key[0], &key[4]);
> - xor_32(&key[8], &key[4], &key[8]);
> - xor_32(&key[12], &key[8], &key[12]);
> -}
> -
> -static void byte_sub(u8 *in, u8 *out)
> -{
> - sint i;
> -
> - for (i =3D 0; i < 16; i++)
> - out[i] =3D sbox(in[i]);
> -}
> -
> -static void shift_row(u8 *in, u8 *out)
> -{
> - out[0] =3D in[0];
> - out[1] =3D in[5];
> - out[2] =3D in[10];
> - out[3] =3D in[15];
> - out[4] =3D in[4];
> - out[5] =3D in[9];
> - out[6] =3D in[14];
> - out[7] =3D in[3];
> - out[8] =3D in[8];
> - out[9] =3D in[13];
> - out[10] =3D in[2];
> - out[11] =3D in[7];
> - out[12] =3D in[12];
> - out[13] =3D in[1];
> - out[14] =3D in[6];
> - out[15] =3D in[11];
> -}
> -
> -static void mix_column(u8 *in, u8 out)
> -{
> - sint i;
> - u8 add1b[4];
> - u8 add1bf7[4];
> - u8 rotl[4];
> - u8 swap_halves[4];
> - u8 andf7[4];
> - u8 rotr[4];
> - u8 temp[4];
> - u8 tempb[4];
> -
> - for (i =3D 0; i < 4; i++) {
> - if ((in[i] & 0x80) =3D=3D 0x80)
> - add1b[i] =3D 0x1b;
> - else
> - add1b[i] =3D 0x00;
> - }
> - swap_halves[0] =3D in[2]; / Swap halves /
> - swap_halves[1] =3D in[3];
> - swap_halves[2] =3D in[0];
> - swap_halves[3] =3D in[1];
> - rotl[0] =3D in[3]; / Rotate left 8 bits /
> - rotl[1] =3D in[0];
> - rotl[2] =3D in[1];
> - rotl[3] =3D in[2];
> - andf7[0] =3D in[0] & 0x7f;
> - andf7[1] =3D in[1] & 0x7f;
> - andf7[2] =3D in[2] & 0x7f;
> - andf7[3] =3D in[3] & 0x7f;
> - for (i =3D 3; i > 0; i--) { / logical shift left 1 bit */
>=20
> - andf7[i] =3D andf7[i] << 1;
> - if ((andf7[i - 1] & 0x80) =3D=3D 0x80)
> - andf7[i] =3D (andf7[i] | 0x01);
> - }
> - andf7[0] =3D andf7[0] << 1;
> - andf7[0] =3D andf7[0] & 0xfe;
> - xor_32(add1b, andf7, add1bf7);
> - xor_32(in, add1bf7, rotr);
> - temp[0] =3D rotr[0]; /* Rotate right 8 bits /
> - rotr[0] =3D rotr[1];
> - rotr[1] =3D rotr[2];
> - rotr[2] =3D rotr[3];
> - rotr[3] =3D temp[0];
> - xor_32(add1bf7, rotr, temp);
> - xor_32(swap_halves, rotl, tempb);
> - xor_32(temp, tempb, out);
> -}
> -
> -static void aes128k128d(u8 key, u8 data, u8 ciphertext)
> -{
> - sint round;
> - sint i;
> - u8 intermediatea[16];
> - u8 intermediateb[16];
> - u8 round_key[16];
> -
> - for (i =3D 0; i < 16; i++)
> - round_key[i] =3D key[i];
> - for (round =3D 0; round < 11; round++) {
> - if (round =3D=3D 0) {
> - xor_128(round_key, data, ciphertext);
> - next_key(round_key, round);
> - } else if (round =3D=3D 10) {
> - byte_sub(ciphertext, intermediatea);
> - shift_row(intermediatea, intermediateb);
> - xor_128(intermediateb, round_key, ciphertext);
> - } else { / 1 - 9 /
> - byte_sub(ciphertext, intermediatea);
> - shift_row(intermediatea, intermediateb);
> - mix_column(&intermediateb[0], &intermediatea[0]);
> - mix_column(&intermediateb[4], &intermediatea[4]);
> - mix_column(&intermediateb[8], &intermediatea[8]);
> - mix_column(&intermediateb[12], &intermediatea[12]);
> - xor_128(intermediatea, round_key, ciphertext);
> - next_key(round_key, round);
> - }
> - }
> -}
> -
> -//
> -/ construct_mic_iv() /
> -/ Builds the MIC IV from header fields and PN /
> -//
> -static void construct_mic_iv(u8 mic_iv, sint qc_exists, sint a4_exists,
> - u8 mpdu, uint payload_length, u8 pn_vector)
> -{
> - sint i;
> -
> - mic_iv[0] =3D 0x59;
> - if (qc_exists && a4_exists)
> - mic_iv[1] =3D mpdu[30] & 0x0f; / QoS_TC /
> - if (qc_exists && !a4_exists)
> - mic_iv[1] =3D mpdu[24] & 0x0f; / mute bits 7-4 /
> - if (!qc_exists)
> - mic_iv[1] =3D 0x00;
> - for (i =3D 2; i < 8; i++)
> - mic_iv[i] =3D mpdu[i + 8];
> - for (i =3D 8; i < 14; i++)
> - mic_iv[i] =3D pn_vector[13 - i]; / mic_iv[8:13] =3D PN[5:0] /
> - mic_iv[14] =3D (unsigned char)(payload_length / 256);
> - mic_iv[15] =3D (unsigned char)(payload_length % 256);
> -}
> -
> -//
> -/ construct_mic_header1() /
> -/ Builds the first MIC header block from /
> -/ header fields. /
> -//
> -static void construct_mic_header1(u8 mic_header1, sint header_length, u8=
 mpdu)
> -{
> - mic_header1[0] =3D (u8)((header_length - 2) / 256);
> - mic_header1[1] =3D (u8)((header_length - 2) % 256);
> - mic_header1[2] =3D mpdu[0] & 0xcf; / Mute CF poll & CF ack bits /
> - / Mute retry, more data and pwr mgt bits /
> - mic_header1[3] =3D mpdu[1] & 0xc7;
> - mic_header1[4] =3D mpdu[4]; / A1 /
> - mic_header1[5] =3D mpdu[5];
> - mic_header1[6] =3D mpdu[6];
> - mic_header1[7] =3D mpdu[7];
> - mic_header1[8] =3D mpdu[8];
> - mic_header1[9] =3D mpdu[9];
> - mic_header1[10] =3D mpdu[10]; / A2 /
> - mic_header1[11] =3D mpdu[11];
> - mic_header1[12] =3D mpdu[12];
> - mic_header1[13] =3D mpdu[13];
> - mic_header1[14] =3D mpdu[14];
> - mic_header1[15] =3D mpdu[15];
> -}
> -
> -//
> -/ construct_mic_header2() /
> -/ Builds the last MIC header block from /
> -/ header fields. /
> -//
> -static void construct_mic_header2(u8 mic_header2, u8 mpdu, sint a4_exist=
s,
> - sint qc_exists)
> -{
> - sint i;
> -
> - for (i =3D 0; i < 16; i++)
> - mic_header2[i] =3D 0x00;
> - mic_header2[0] =3D mpdu[16]; / A3 /
> - mic_header2[1] =3D mpdu[17];
> - mic_header2[2] =3D mpdu[18];
> - mic_header2[3] =3D mpdu[19];
> - mic_header2[4] =3D mpdu[20];
> - mic_header2[5] =3D mpdu[21];
> - mic_header2[6] =3D 0x00;
> - mic_header2[7] =3D 0x00; / mpdu[23]; /
> - if (!qc_exists && a4_exists)
> - for (i =3D 0; i < 6; i++)
> - mic_header2[8 + i] =3D mpdu[24 + i]; / A4 /
> - if (qc_exists && !a4_exists) {
> - mic_header2[8] =3D mpdu[24] & 0x0f; / mute bits 15 - 4 /
> - mic_header2[9] =3D mpdu[25] & 0x00;
> - }
> - if (qc_exists && a4_exists) {
> - for (i =3D 0; i < 6; i++)
> - mic_header2[8 + i] =3D mpdu[24 + i]; / A4 /
> - mic_header2[14] =3D mpdu[30] & 0x0f;
> - mic_header2[15] =3D mpdu[31] & 0x00;
> - }
> -}
> -
> -//
> -/ construct_mic_header2() /
> -/ Builds the last MIC header block from /
> -/ header fields. /
> -//
> -static void construct_ctr_preload(u8 ctr_preload,
> - sint a4_exists, sint qc_exists,
> - u8 mpdu, u8 pn_vector, sint c)
> -{
> - sint i;
> -
> - for (i =3D 0; i < 16; i++)
> - ctr_preload[i] =3D 0x00;
> - i =3D 0;
> - ctr_preload[0] =3D 0x01; / flag /
> - if (qc_exists && a4_exists)
> - ctr_preload[1] =3D mpdu[30] & 0x0f;
> - if (qc_exists && !a4_exists)
> - ctr_preload[1] =3D mpdu[24] & 0x0f;
> - for (i =3D 2; i < 8; i++)
> - ctr_preload[i] =3D mpdu[i + 8];
> - for (i =3D 8; i < 14; i++)
> - ctr_preload[i] =3D pn_vector[13 - i];
> - ctr_preload[14] =3D (unsigned char)(c / 256); / Ctr /
> - ctr_preload[15] =3D (unsigned char)(c % 256);
> -}
> -
> -//
> -/ bitwise_xor() /
> -/ A 128 bit, bitwise exclusive or /
> -/**************/
> -static void bitwise_xor(u8 *ina, u8 *inb, u8 *out)
> -{
> - sint i;
> -
> - for (i =3D 0; i < 16; i++)
> - out[i] =3D ina[i] ^ inb[i];
> -}
> -
> -static void aes_cipher(u8 *key, uint hdrlen,
> - u8 pframe, uint plen)
> -{
> - uint qc_exists, a4_exists, i, j, payload_remainder;
> - uint num_blocks, payload_index;
> -
> - u8 pn_vector[6];
> - u8 mic_iv[16];
> - u8 mic_header1[16];
> - u8 mic_header2[16];
> - u8 ctr_preload[16];
> -
> - / Intermediate Buffers */
> - u8 chain_buffer[16];
> - u8 aes_out[16];
> - u8 padded_buffer[16];
> - u8 mic[8];
> - u16 frtype =3D GetFrameType(pframe);
> - u16 frsubtype =3D GetFrameSubType(pframe);
> -
> - frsubtype >>=3D 4;
>=20
> - memset((void *)mic_iv, 0, 16);
> - memset((void *)mic_header1, 0, 16);
> - memset((void *)mic_header2, 0, 16);
> - memset((void *)ctr_preload, 0, 16);
> - memset((void *)chain_buffer, 0, 16);
> - memset((void *)aes_out, 0, 16);
> - memset((void )padded_buffer, 0, 16);
> -
> - if ((hdrlen =3D=3D WLAN_HDR_A3_LEN) || (hdrlen =3D=3D WLAN_HDR_A3_QOS_L=
EN))
> - a4_exists =3D 0;
> - else
> - a4_exists =3D 1;
> -
> - if ((frtype =3D=3D (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACK))=
 ||
> - (frtype =3D=3D (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFPOLL)) ||
> - (frtype =3D=3D (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACKPOLL))=
) {
> - qc_exists =3D 1;
> - if (hdrlen !=3D WLAN_HDR_A3_QOS_LEN)
> - hdrlen +=3D 2;
> - } else if ((frsubtype =3D=3D 0x08) ||
> - (frsubtype =3D=3D 0x09) ||
> - (frsubtype =3D=3D 0x0a) ||
> - (frsubtype =3D=3D 0x0b)) {
> - if (hdrlen !=3D WLAN_HDR_A3_QOS_LEN)
> - hdrlen +=3D 2;
> - qc_exists =3D 1;
> - } else {
> - qc_exists =3D 0;
> - }
> - pn_vector[0] =3D pframe[hdrlen];
> - pn_vector[1] =3D pframe[hdrlen + 1];
> - pn_vector[2] =3D pframe[hdrlen + 4];
> - pn_vector[3] =3D pframe[hdrlen + 5];
> - pn_vector[4] =3D pframe[hdrlen + 6];
> - pn_vector[5] =3D pframe[hdrlen + 7];
> - construct_mic_iv(mic_iv, qc_exists, a4_exists, pframe, plen, pn_vector)=
;
> - construct_mic_header1(mic_header1, hdrlen, pframe);
> - construct_mic_header2(mic_header2, pframe, a4_exists, qc_exists);
> - payload_remainder =3D plen % 16;
> - num_blocks =3D plen / 16;
> - / Find start of payload /
> - payload_index =3D hdrlen + 8;
> - / Calculate MIC /
> - aes128k128d(key, mic_iv, aes_out);
> - bitwise_xor(aes_out, mic_header1, chain_buffer);
> - aes128k128d(key, chain_buffer, aes_out);
> - bitwise_xor(aes_out, mic_header2, chain_buffer);
> - aes128k128d(key, chain_buffer, aes_out);
> - for (i =3D 0; i < num_blocks; i++) {
> - bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
> - payload_index +=3D 16;
> - aes128k128d(key, chain_buffer, aes_out);
> - }
> - / Add on the final payload block if it needs padding */
> - if (payload_remainder > 0) {
>=20
> - for (j =3D 0; j < 16; j++)
> - padded_buffer[j] =3D 0x00;
> - for (j =3D 0; j < payload_remainder; j++)
> - padded_buffer[j] =3D pframe[payload_index++];
> - bitwise_xor(aes_out, padded_buffer, chain_buffer);
> - aes128k128d(key, chain_buffer, aes_out);
> - }
> - for (j =3D 0; j < 8; j++)
> - mic[j] =3D aes_out[j];
> - /* Insert MIC into payload /
> - for (j =3D 0; j < 8; j++)
> - pframe[payload_index + j] =3D mic[j];
> - payload_index =3D hdrlen + 8;
> - for (i =3D 0; i < num_blocks; i++) {
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
> - pframe, pn_vector, i + 1);
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
> - for (j =3D 0; j < 16; j++)
> - pframe[payload_index++] =3D chain_buffer[j];
> - }
> - if (payload_remainder > 0) { / If short final block, then pad it,*/
>=20
> - /* encrypt and copy unpadded part back /
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
> - pframe, pn_vector, num_blocks + 1);
> - for (j =3D 0; j < 16; j++)
> - padded_buffer[j] =3D 0x00;
> - for (j =3D 0; j < payload_remainder; j++)
> - padded_buffer[j] =3D pframe[payload_index + j];
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, padded_buffer, chain_buffer);
> - for (j =3D 0; j < payload_remainder; j++)
> - pframe[payload_index++] =3D chain_buffer[j];
> - }
> - / Encrypt the MIC */
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
> - pframe, pn_vector, 0);
> - for (j =3D 0; j < 16; j++)
> - padded_buffer[j] =3D 0x00;
> - for (j =3D 0; j < 8; j++)
> - padded_buffer[j] =3D pframe[j + hdrlen + 8 + plen];
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, padded_buffer, chain_buffer);
> - for (j =3D 0; j < 8; j++)
> - pframe[payload_index++] =3D chain_buffer[j];
> -}
> -
> -u32 r8712_aes_encrypt(struct _adapter *padapter, u8 pxmitframe)
> -{ / exclude ICV /
> - / Intermediate Buffers */
> - sint curfragnum, length;
> - u8 *pframe, *prwskey;
> - struct sta_info *stainfo;
> - struct pkt_attrib *pattrib =3D &((struct xmit_frame *)
> - pxmitframe)->attrib;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - u32 res =3D _SUCCESS;
> -
> - if (((struct xmit_frame *)pxmitframe)->buf_addr =3D=3D NULL)
>=20
> - return _FAIL;
> - pframe =3D ((struct xmit_frame *)pxmitframe)->buf_addr + TXDESC_OFFSET;
>=20
> - /* 4 start to encrypt each fragment */
> - if (pattrib->encrypt =3D=3D AES) {
>=20
> - if (pattrib->psta)
>=20
> - stainfo =3D pattrib->psta;
>=20
> - else
> - stainfo =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - &pattrib->ra[0]);
>=20
> - if (stainfo) {
> - prwskey =3D &stainfo->x_UncstKey.skey[0];
>=20
> - for (curfragnum =3D 0; curfragnum < pattrib->nr_frags;
>=20
> - curfragnum++) {
> - if ((curfragnum + 1) =3D=3D pattrib->nr_frags) {
>=20
> - length =3D pattrib->last_txcmdsz -
>=20
> - pattrib->hdrlen -
>=20
> - pattrib->iv_len -
>=20
> - pattrib->icv_len;
>=20
> - aes_cipher(prwskey, pattrib->hdrlen,
>=20
> - pframe, length);
> - } else {
> - length =3D pxmitpriv->frag_len -
>=20
> - pattrib->hdrlen -
>=20
> - pattrib->iv_len -
>=20
> - pattrib->icv_len;
>=20
> - aes_cipher(prwskey, pattrib->hdrlen,
>=20
> - pframe, length);
> - pframe +=3D pxmitpriv->frag_len;
>=20
> - pframe =3D (u8 *)RND4((addr_t)(pframe));
> - }
> - }
> - } else {
> - res =3D _FAIL;
> - }
> - }
> - return res;
> -}
> -
> -static void aes_decipher(u8 *key, uint hdrlen,
> - u8 pframe, uint plen)
> -{
> - static u8 message[MAX_MSG_SIZE];
> - uint qc_exists, a4_exists, i, j, payload_remainder;
> - uint num_blocks, payload_index;
> - u8 pn_vector[6];
> - u8 mic_iv[16];
> - u8 mic_header1[16];
> - u8 mic_header2[16];
> - u8 ctr_preload[16];
> - / Intermediate Buffers */
> - u8 chain_buffer[16];
> - u8 aes_out[16];
> - u8 padded_buffer[16];
> - u8 mic[8];
> - uint frtype =3D GetFrameType(pframe);
> - uint frsubtype =3D GetFrameSubType(pframe);
> -
> - frsubtype >>=3D 4;
>=20
> - memset((void *)mic_iv, 0, 16);
> - memset((void *)mic_header1, 0, 16);
> - memset((void *)mic_header2, 0, 16);
> - memset((void *)ctr_preload, 0, 16);
> - memset((void *)chain_buffer, 0, 16);
> - memset((void )aes_out, 0, 16);
> - memset((void )padded_buffer, 0, 16);
> - / start to decrypt the payload /
> - /(plen including llc, payload and mic) /
> - num_blocks =3D (plen - 8) / 16;
> - payload_remainder =3D (plen - 8) % 16;
> - pn_vector[0] =3D pframe[hdrlen];
> - pn_vector[1] =3D pframe[hdrlen + 1];
> - pn_vector[2] =3D pframe[hdrlen + 4];
> - pn_vector[3] =3D pframe[hdrlen + 5];
> - pn_vector[4] =3D pframe[hdrlen + 6];
> - pn_vector[5] =3D pframe[hdrlen + 7];
> - if ((hdrlen =3D=3D WLAN_HDR_A3_LEN) || (hdrlen =3D=3D WLAN_HDR_A3_QOS_L=
EN))
> - a4_exists =3D 0;
> - else
> - a4_exists =3D 1;
> - if ((frtype =3D=3D (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACK))=
 ||
> - (frtype =3D=3D (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFPOLL)) ||
> - (frtype =3D=3D (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_DATA_CFACKPOLL))=
) {
> - qc_exists =3D 1;
> - if (hdrlen !=3D WLAN_HDR_A3_QOS_LEN)
> - hdrlen +=3D 2;
> - } else if ((frsubtype =3D=3D 0x08) ||
> - (frsubtype =3D=3D 0x09) ||
> - (frsubtype =3D=3D 0x0a) ||
> - (frsubtype =3D=3D 0x0b)) {
> - if (hdrlen !=3D WLAN_HDR_A3_QOS_LEN)
> - hdrlen +=3D 2;
> - qc_exists =3D 1;
> - } else {
> - qc_exists =3D 0;
> - }
> - / now, decrypt pframe with hdrlen offset and plen long /
> - payload_index =3D hdrlen + 8; / 8 is for extiv /
> - for (i =3D 0; i < num_blocks; i++) {
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
> - pframe, pn_vector, i + 1);
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, &pframe[payload_index], chain_buffer);
> - for (j =3D 0; j < 16; j++)
> - pframe[payload_index++] =3D chain_buffer[j];
> - }
> - if (payload_remainder > 0) { / If short final block, pad it,/
>=20
> - /* encrypt it and copy the unpadded part back /
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
> - pframe, pn_vector, num_blocks + 1);
> - for (j =3D 0; j < 16; j++)
> - padded_buffer[j] =3D 0x00;
> - for (j =3D 0; j < payload_remainder; j++)
> - padded_buffer[j] =3D pframe[payload_index + j];
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, padded_buffer, chain_buffer);
> - for (j =3D 0; j < payload_remainder; j++)
> - pframe[payload_index++] =3D chain_buffer[j];
> - }
> - / start to calculate the mic */
> - memcpy((void )message, pframe, (hdrlen + plen + 8));
> - pn_vector[0] =3D pframe[hdrlen];
> - pn_vector[1] =3D pframe[hdrlen + 1];
> - pn_vector[2] =3D pframe[hdrlen + 4];
> - pn_vector[3] =3D pframe[hdrlen + 5];
> - pn_vector[4] =3D pframe[hdrlen + 6];
> - pn_vector[5] =3D pframe[hdrlen + 7];
> - construct_mic_iv(mic_iv, qc_exists, a4_exists, message, plen - 8,
> - pn_vector);
> - construct_mic_header1(mic_header1, hdrlen, message);
> - construct_mic_header2(mic_header2, message, a4_exists, qc_exists);
> - payload_remainder =3D (plen - 8) % 16;
> - num_blocks =3D (plen - 8) / 16;
> - / Find start of payload /
> - payload_index =3D hdrlen + 8;
> - / Calculate MIC /
> - aes128k128d(key, mic_iv, aes_out);
> - bitwise_xor(aes_out, mic_header1, chain_buffer);
> - aes128k128d(key, chain_buffer, aes_out);
> - bitwise_xor(aes_out, mic_header2, chain_buffer);
> - aes128k128d(key, chain_buffer, aes_out);
> - for (i =3D 0; i < num_blocks; i++) {
> - bitwise_xor(aes_out, &message[payload_index], chain_buffer);
> - payload_index +=3D 16;
> - aes128k128d(key, chain_buffer, aes_out);
> - }
> - / Add on the final payload block if it needs padding */
> - if (payload_remainder > 0) {
>=20
> - for (j =3D 0; j < 16; j++)
> - padded_buffer[j] =3D 0x00;
> - for (j =3D 0; j < payload_remainder; j++)
> - padded_buffer[j] =3D message[payload_index++];
> - bitwise_xor(aes_out, padded_buffer, chain_buffer);
> - aes128k128d(key, chain_buffer, aes_out);
> - }
> - for (j =3D 0; j < 8; j++)
> - mic[j] =3D aes_out[j];
> - /* Insert MIC into payload /
> - for (j =3D 0; j < 8; j++)
> - message[payload_index + j] =3D mic[j];
> - payload_index =3D hdrlen + 8;
> - for (i =3D 0; i < num_blocks; i++) {
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
> - message, pn_vector, i + 1);
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, &message[payload_index], chain_buffer);
> - for (j =3D 0; j < 16; j++)
> - message[payload_index++] =3D chain_buffer[j];
> - }
> - if (payload_remainder > 0) { / If short final block, pad it,*/
>=20
> - /* encrypt and copy unpadded part back /
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists,
> - message, pn_vector, num_blocks + 1);
> - for (j =3D 0; j < 16; j++)
> - padded_buffer[j] =3D 0x00;
> - for (j =3D 0; j < payload_remainder; j++)
> - padded_buffer[j] =3D message[payload_index + j];
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, padded_buffer, chain_buffer);
> - for (j =3D 0; j < payload_remainder; j++)
> - message[payload_index++] =3D chain_buffer[j];
> - }
> - / Encrypt the MIC /
> - construct_ctr_preload(ctr_preload, a4_exists, qc_exists, message,
> - pn_vector, 0);
> - for (j =3D 0; j < 16; j++)
> - padded_buffer[j] =3D 0x00;
> - for (j =3D 0; j < 8; j++)
> - padded_buffer[j] =3D message[j + hdrlen + plen];
> - aes128k128d(key, ctr_preload, aes_out);
> - bitwise_xor(aes_out, padded_buffer, chain_buffer);
> - for (j =3D 0; j < 8; j++)
> - message[payload_index++] =3D chain_buffer[j];
> - / compare the mic */
> -}
> -
> -void r8712_aes_decrypt(struct _adapter *padapter, u8 precvframe)
> -{ / exclude ICV /
> - / Intermediate Buffers */
> - sint length;
> - u8 *pframe, *prwskey, *iv, idx;
> - struct sta_info *stainfo;
> - struct rx_pkt_attrib *prxattrib =3D &((union recv_frame *)
> - precvframe)->u.hdr.attrib;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> -
> - pframe =3D (unsigned char *)((union recv_frame *)precvframe)->
>=20
> - u.hdr.rx_data;
> - /* 4 start to encrypt each fragment */
> - if (prxattrib->encrypt =3D=3D AES) {
>=20
> - stainfo =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - &prxattrib->ta[0]);
>=20
> - if (stainfo) {
> - if (is_multicast_ether_addr(prxattrib->ra)) {
>=20
> - iv =3D pframe + prxattrib->hdrlen;
>=20
> - idx =3D iv[3];
> - prwskey =3D &psecuritypriv->XGrpKey[
>=20
> - ((idx >> 6) & 0x3) - 1].skey[0];
>=20
> - if (!psecuritypriv->binstallGrpkey)
>=20
> - return;
> -
> - } else {
> - prwskey =3D &stainfo->x_UncstKey.skey[0];
>=20
> - }
> - length =3D ((union recv_frame *)precvframe)->
>=20
> - u.hdr.len - prxattrib->hdrlen -
>=20
> - prxattrib->iv_len;
>=20
> - aes_decipher(prwskey, prxattrib->hdrlen, pframe,
>=20
> - length);
> - }
> - }
> -}
> -
> -void r8712_use_tkipkey_handler(struct timer_list *t)
> -{
> - struct _adapter *padapter =3D
> - from_timer(padapter, t, securitypriv.tkip_timer);
> -
> - padapter->securitypriv.busetkipkey =3D true;
>=20
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_security.h b/drivers/staging=
/rtl8712/rtl871x_security.h
> deleted file mode 100644
> index 34e5aecf92ae..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_security.h
> +++ /dev/null
> @@ -1,223 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef _RTL871X_SECURITY_H
> -#define _RTL871X_SECURITY_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -#define NO_PRIVACY 0x0
> -#define WEP40 0x1
> -#define TKIP 0x2
> -#define TKIP_WTMIC 0x3
> -#define AES 0x4
> -#define WEP104 0x5
> -
> -#define AUTH_OPEN_SYSTEM 0x0
> -#define AUTH_SHARED_SYSTEM 0x1
> -#define AUTH_8021x 0x2
> -#define AUTH_AUTHSWITCH 0x3
> -
> -#define WPA_IE_ID 0xdd
> -#define WPA2_IE_ID 0x30
> -
> -#ifndef Ndis802_11AuthModeWPA2
> -#define Ndis802_11AuthModeWPA2 (Ndis802_11AuthModeWPANone + 1)
> -#endif
> -
> -#ifndef Ndis802_11AuthModeWPA2PSK
> -#define Ndis802_11AuthModeWPA2PSK (Ndis802_11AuthModeWPANone + 2)
> -#endif
> -
> -union pn48 {
> - u64 val;
> -#if defined(__BIG_ENDIAN)
> - struct {
> - u8 TSC7;
> - u8 TSC6;
> - u8 TSC5;
> - u8 TSC4;
> - u8 TSC3;
> - u8 TSC2;
> - u8 TSC1;
> - u8 TSC0;
> - } byte;
> -#else
> - struct {
> - u8 TSC0;
> - u8 TSC1;
> - u8 TSC2;
> - u8 TSC3;
> - u8 TSC4;
> - u8 TSC5;
> - u8 TSC6;
> - u8 TSC7;
> - } byte;
> -#endif
> -};
> -
> -union Keytype {
> - u8 skey[16];
> - u32 lkey[4];
> -};
> -
> -struct RT_PMKID_LIST {
> - u8 bUsed;
> - u8 Bssid[6];
> - u8 PMKID[16];
> - u8 SsidBuf[33];
> - u8 ssid_octet;
> - u16 ssid_length;
> -};
> -
> -struct security_priv {
> - u32 auth_algorithm; / 802.11 auth, could be open, shared,
> - * 8021x and authswitch
> - /
> - u32 privacy_algorithm; / This specify the privacy for shared
> - * auth. algorithm.
> - /
> - u32 PrivacyKeyIndex; / this is only valid for legendary
> - * wep, 0~3 for key id.
> - /
> - union Keytype DefKey[4]; / this is only valid for def. key /
> - u32 DefKeylen[4];
> - u32 XGrpPrivacy; / This specify the privacy algthm.
> - * used for Grp key
> - /
> - u32 XGrpKeyid; / key id used for Grp Key /
> - union Keytype XGrpKey[2]; / 802.1x Group Key, for
> - * inx0 and inx1
> - /
> - union Keytype XGrptxmickey[2];
> - union Keytype XGrprxmickey[2];
> - union pn48 Grptxpn; / PN48 used for Grp Key xmit. /
> - union pn48 Grprxpn; / PN48 used for Grp Key recv. /
> - u8 wps_hw_pbc_pressed;/for hw pbc pressed/
> - u8 wps_phase;/for wps/
> - u8 wps_ie[MAX_WPA_IE_LEN << 2];
> - int wps_ie_len;
> - u8 binstallGrpkey;
> - u8 busetkipkey;
> - struct timer_list tkip_timer;
> - u8 bcheck_grpkey;
> - u8 bgrpkey_handshake;
> - s32 sw_encrypt; / from registry_priv /
> - s32 sw_decrypt; / from registry_priv /
> - s32 hw_decrypted; / if the rx packets is hw_decrypted=3D=3Dfalse,
> - * it means the hw has not been ready.
> - /
> - u32 ndisauthtype; / keeps the auth_type & enc_status from upper
> - * layer ioctl(wpa_supplicant or wzc)
> - /
> - u32 ndisencryptstatus;
> - struct wlan_bssid_ex sec_bss; / for joinbss (h2c buffer) usage /
> - struct NDIS_802_11_WEP ndiswep;
> - u8 assoc_info[600];
> - u8 szofcapability[256]; / for wpa2 usage /
> - u8 oidassociation[512]; / for wpa/wpa2 usage /
> - u8 authenticator_ie[256]; / store ap security information element /
> - u8 supplicant_ie[256]; / store sta security information element /
> - / for tkip countermeasure /
> - u32 last_mic_err_time;
> - u8 btkip_countermeasure;
> - u8 btkip_wait_report;
> - u32 btkip_countermeasure_time;
> - /-------------------------------------------------------------------
> - * For WPA2 Pre-Authentication.
> - *------------------------------------------------------------------
> - **/
> - struct RT_PMKID_LIST PMKIDList[NUM_PMKID_CACHE];
> - u8 PMKIDIndex;
> -};
> -
> -#define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst) \
> -do { \
> - switch (psecuritypriv->auth_algorithm) { \
>=20
> - case 0: \
> - case 1: \
> - case 3: \
> - encry_algo =3D (u8)psecuritypriv->privacy_algorithm; \
>=20
> - break; \
> - case 2: \
> - if (bmcst) \
> - encry_algo =3D (u8)psecuritypriv->XGrpPrivacy; \
>=20
> - else \
> - encry_algo =3D (u8)psta->XPrivacy; \
>=20
> - break; \
> - } \
> -} while (0)
> -#define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
> -do {\
> - switch (encrypt) { \
> - case WEP40: \
> - case WEP104: \
> - iv_len =3D 4; \
> - icv_len =3D 4; \
> - break; \
> - case TKIP: \
> - iv_len =3D 8; \
> - icv_len =3D 4; \
> - break; \
> - case AES: \
> - iv_len =3D 8; \
> - icv_len =3D 8; \
> - break; \
> - default: \
> - iv_len =3D 0; \
> - icv_len =3D 0; \
> - break; \
> - } \
> -} while (0)
> -#define GET_TKIP_PN(iv, txpn) \
> -do {\
> - txpn.byte.TSC0 =3D iv[2];\
> - txpn.byte.TSC1 =3D iv[0];\
> - txpn.byte.TSC2 =3D iv[4];\
> - txpn.byte.TSC3 =3D iv[5];\
> - txpn.byte.TSC4 =3D iv[6];\
> - txpn.byte.TSC5 =3D iv[7];\
> -} while (0)
> -
> -#define ROL32(A, n) (((A) << (n)) | (((A) >> (32 - (n))) & ((1UL << (n))=
 - 1)))
>=20
> -#define ROR32(A, n) ROL32((A), 32 - (n))
> -
> -struct mic_data {
> - u32 K0, K1; /* Key /
> - u32 L, R; / Current state /
> - u32 M; / Message accumulator (single word) /
> - u32 nBytesInM; / # bytes in M /
> -};
> -
> -void seccalctkipmic(
> - u8 key,
> - u8 header,
> - u8 data,
> - u32 data_len,
> - u8 Miccode,
> - u8 priority);
> -
> -void r8712_secmicsetkey(struct mic_data pmicdata, u8 key);
> -void r8712_secmicappend(struct mic_data pmicdata, u8 src, u32 nBytes);
> -void r8712_secgetmic(struct mic_data pmicdata, u8 dst);
> -u32 r8712_aes_encrypt(struct _adapter padapter, u8 pxmitframe);
> -u32 r8712_tkip_encrypt(struct _adapter padapter, u8 pxmitframe);
> -void r8712_wep_encrypt(struct _adapter padapter, u8 pxmitframe);
> -void r8712_aes_decrypt(struct _adapter padapter, u8 precvframe);
> -void r8712_tkip_decrypt(struct _adapter padapter, u8 precvframe);
> -void r8712_wep_decrypt(struct _adapter padapter, u8 precvframe);
> -void r8712_use_tkipkey_handler(struct timer_list t);
> -
> -#endif /_RTL871X_SECURITY_H /
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_sta_mgt.c b/drivers/staging/=
rtl8712/rtl871x_sta_mgt.c
> deleted file mode 100644
> index 41b8a24e2f33..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_sta_mgt.c
> +++ /dev/null
> @@ -1,263 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/******************************************************
> - * rtl871x_sta_mgt.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_STA_MGT_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "recv_osdep.h"
> -#include "xmit_osdep.h"
> -#include "sta_info.h"
> -
> -static void _init_stainfo(struct sta_info *psta)
> -{
> - memset((u8 *)psta, 0, sizeof(struct sta_info));
> - spin_lock_init(&psta->lock);
>=20
> - INIT_LIST_HEAD(&psta->list);
>=20
> - INIT_LIST_HEAD(&psta->hash_list);
>=20
> - _r8712_init_sta_xmit_priv(&psta->sta_xmitpriv);
>=20
> - _r8712_init_sta_recv_priv(&psta->sta_recvpriv);
>=20
> - INIT_LIST_HEAD(&psta->asoc_list);
>=20
> - INIT_LIST_HEAD(&psta->auth_list);
>=20
> -}
> -
> -int _r8712_init_sta_priv(struct sta_priv *pstapriv)
> -{
> - struct sta_info *psta;
> - s32 i;
> -
> - pstapriv->pallocated_stainfo_buf =3D kmalloc(sizeof(struct sta_info) *
>=20
> - NUM_STA + 4, GFP_ATOMIC);
> - if (!pstapriv->pallocated_stainfo_buf)
>=20
> - return -ENOMEM;
> - pstapriv->pstainfo_buf =3D pstapriv->pallocated_stainfo_buf + 4 -
>=20
> - ((addr_t)(pstapriv->pallocated_stainfo_buf) & 3);
>=20
> - _init_queue(&pstapriv->free_sta_queue);
>=20
> - spin_lock_init(&pstapriv->sta_hash_lock);
>=20
> - pstapriv->asoc_sta_count =3D 0;
>=20
> - _init_queue(&pstapriv->sleep_q);
>=20
> - _init_queue(&pstapriv->wakeup_q);
>=20
> - psta =3D (struct sta_info *)(pstapriv->pstainfo_buf);
>=20
> - for (i =3D 0; i < NUM_STA; i++) {
> - _init_stainfo(psta);
> - INIT_LIST_HEAD(&pstapriv->sta_hash[i]);
>=20
> - list_add_tail(&psta->list, &pstapriv->free_sta_queue.queue);
>=20
> - psta++;
> - }
> - INIT_LIST_HEAD(&pstapriv->asoc_list);
>=20
> - INIT_LIST_HEAD(&pstapriv->auth_list);
>=20
> - return 0;
> -}
> -
> -/* this function is used to free the memory of lock || sema for all stai=
nfos */
> -static void mfree_all_stainfo(struct sta_priv *pstapriv)
> -{
> - unsigned long irqL;
> - struct list_head *plist, *phead;
> -
> - spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
>=20
> - phead =3D &pstapriv->free_sta_queue.queue;
>=20
> - plist =3D phead->next;
>=20
> - while (!end_of_queue_search(phead, plist))
> - plist =3D plist->next;
>=20
> -
> - spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
>=20
> -}
> -
> -void _r8712_free_sta_priv(struct sta_priv pstapriv)
> -{
> - if (pstapriv) {
> - / be done before free sta_hash_lock */
> - mfree_all_stainfo(pstapriv);
> - kfree(pstapriv->pallocated_stainfo_buf);
>=20
> - }
> -}
> -
> -struct sta_info *r8712_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwad=
dr)
> -{
> - s32 index;
> - struct list_head *phash_list;
> - struct sta_info *psta;
> - struct __queue *pfree_sta_queue;
> - struct recv_reorder_ctrl *preorder_ctrl;
> - int i =3D 0;
> - u16 wRxSeqInitialValue =3D 0xffff;
> - unsigned long flags;
> -
> - pfree_sta_queue =3D &pstapriv->free_sta_queue;
>=20
> - spin_lock_irqsave(&pfree_sta_queue->lock, flags);
>=20
> - psta =3D list_first_entry_or_null(&pfree_sta_queue->queue,
>=20
> - struct sta_info, list);
> - if (psta) {
> - list_del_init(&psta->list);
>=20
> - _init_stainfo(psta);
> - memcpy(psta->hwaddr, hwaddr, ETH_ALEN);
>=20
> - index =3D wifi_mac_hash(hwaddr);
> - if (index >=3D NUM_STA) {
>=20
> - psta =3D NULL;
> - goto exit;
> - }
> - phash_list =3D &pstapriv->sta_hash[index];
>=20
> - list_add_tail(&psta->hash_list, phash_list);
>=20
> - pstapriv->asoc_sta_count++;
>=20
> -
> -/* For the SMC router, the sequence number of first packet of WPS handsh=
ake
> - * will be 0. In this case, this packet will be dropped by recv_decache =
function
> - * if we use the 0x00 as the default value for tid_rxseq variable. So, w=
e
> - * initialize the tid_rxseq variable as the 0xffff.
> - */
> - for (i =3D 0; i < 16; i++)
> - memcpy(&psta->sta_recvpriv.rxcache.tid_rxseq[i],
>=20
> - &wRxSeqInitialValue, 2);
> - /* for A-MPDU Rx reordering buffer control */
> - for (i =3D 0; i < 16; i++) {
> - preorder_ctrl =3D &psta->recvreorder_ctrl[i];
>=20
> - preorder_ctrl->padapter =3D pstapriv->padapter;
>=20
> - preorder_ctrl->indicate_seq =3D 0xffff;
>=20
> - preorder_ctrl->wend_b =3D 0xffff;
>=20
> - preorder_ctrl->wsize_b =3D 64;
>=20
> - _init_queue(&preorder_ctrl->pending_recvframe_queue);
>=20
> - r8712_init_recv_timer(preorder_ctrl);
> - }
> - }
> -exit:
> - spin_unlock_irqrestore(&pfree_sta_queue->lock, flags);
>=20
> - return psta;
> -}
> -
> -/* using pstapriv->sta_hash_lock to protect */
>=20
> -void r8712_free_stainfo(struct _adapter *padapter, struct sta_info *psta=
)
> -{
> - int i;
> - unsigned long irqL0;
> - struct __queue *pfree_sta_queue;
> - struct recv_reorder_ctrl *preorder_ctrl;
> - struct sta_xmit_priv *pstaxmitpriv;
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> -
> - if (!psta)
> - return;
> - pfree_sta_queue =3D &pstapriv->free_sta_queue;
>=20
> - pstaxmitpriv =3D &psta->sta_xmitpriv;
>=20
> - spin_lock_irqsave(&pxmitpriv->vo_pending.lock, irqL0);
>=20
> - r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vo_q.sta_pending);
>=20
> - list_del_init(&pstaxmitpriv->vo_q.tx_pending);
>=20
> - spin_unlock_irqrestore(&pxmitpriv->vo_pending.lock, irqL0);
>=20
> - spin_lock_irqsave(&pxmitpriv->vi_pending.lock, irqL0);
>=20
> - r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->vi_q.sta_pending);
>=20
> - list_del_init(&pstaxmitpriv->vi_q.tx_pending);
>=20
> - spin_unlock_irqrestore(&pxmitpriv->vi_pending.lock, irqL0);
>=20
> - spin_lock_irqsave(&pxmitpriv->bk_pending.lock, irqL0);
>=20
> - r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->bk_q.sta_pending);
>=20
> - list_del_init(&pstaxmitpriv->bk_q.tx_pending);
>=20
> - spin_unlock_irqrestore(&pxmitpriv->bk_pending.lock, irqL0);
>=20
> - spin_lock_irqsave(&pxmitpriv->be_pending.lock, irqL0);
>=20
> - r8712_free_xmitframe_queue(pxmitpriv, &pstaxmitpriv->be_q.sta_pending);
>=20
> - list_del_init(&pstaxmitpriv->be_q.tx_pending);
>=20
> - spin_unlock_irqrestore(&pxmitpriv->be_pending.lock, irqL0);
>=20
> - list_del_init(&psta->hash_list);
>=20
> - pstapriv->asoc_sta_count--;
>=20
> - /* re-init sta_info; 20061114 */
> - _r8712_init_sta_xmit_priv(&psta->sta_xmitpriv);
>=20
> - _r8712_init_sta_recv_priv(&psta->sta_recvpriv);
>=20
> - /* for A-MPDU Rx reordering buffer control,
> - * cancel reordering_ctrl_timer
> - */
> - for (i =3D 0; i < 16; i++) {
> - preorder_ctrl =3D &psta->recvreorder_ctrl[i];
>=20
> - del_timer(&preorder_ctrl->reordering_ctrl_timer);
>=20
> - }
> - spin_lock(&pfree_sta_queue->lock);
>=20
> - /* insert into free_sta_queue; 20061114 */
> - list_add_tail(&psta->list, &pfree_sta_queue->queue);
>=20
> - spin_unlock(&pfree_sta_queue->lock);
>=20
> -}
> -
> -/* free all stainfo which in sta_hash[all] */
> -void r8712_free_all_stainfo(struct _adapter *padapter)
> -{
> - unsigned long irqL;
> - struct list_head *plist, *phead;
> - s32 index;
> - struct sta_info *psta =3D NULL;
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> - struct sta_info *pbcmc_stainfo =3D r8712_get_bcmc_stainfo(padapter);
> -
> - if (pstapriv->asoc_sta_count =3D=3D 1)
>=20
> - return;
> - spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
>=20
> - for (index =3D 0; index < NUM_STA; index++) {
> - phead =3D &pstapriv->sta_hash[index];
>=20
> - plist =3D phead->next;
>=20
> - while (!end_of_queue_search(phead, plist)) {
> - psta =3D container_of(plist,
> - struct sta_info, hash_list);
> - plist =3D plist->next;
>=20
> - if (pbcmc_stainfo !=3D psta)
> - r8712_free_stainfo(padapter, psta);
> - }
> - }
> - spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
>=20
> -}
> -
> -/* any station allocated can be searched by hash list */
> -struct sta_info *r8712_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr=
)
> -{
> - unsigned long irqL;
> - struct list_head *plist, *phead;
> - struct sta_info *psta =3D NULL;
> - u32 index;
> -
> - if (!hwaddr)
> - return NULL;
> - index =3D wifi_mac_hash(hwaddr);
> - spin_lock_irqsave(&pstapriv->sta_hash_lock, irqL);
>=20
> - phead =3D &pstapriv->sta_hash[index];
>=20
> - plist =3D phead->next;
>=20
> - while (!end_of_queue_search(phead, plist)) {
> - psta =3D container_of(plist, struct sta_info, hash_list);
> - if ((!memcmp(psta->hwaddr, hwaddr, ETH_ALEN))) {
>=20
> - /* if found the matched address */
> - break;
> - }
> - psta =3D NULL;
> - plist =3D plist->next;
>=20
> - }
> - spin_unlock_irqrestore(&pstapriv->sta_hash_lock, irqL);
>=20
> - return psta;
> -}
> -
> -void r8712_init_bcmc_stainfo(struct _adapter *padapter)
> -{
> - unsigned char bcast_addr[6] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> -
> - r8712_alloc_stainfo(pstapriv, bcast_addr);
> -}
> -
> -struct sta_info *r8712_get_bcmc_stainfo(struct _adapter *padapter)
> -{
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> - u8 bc_addr[ETH_ALEN] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
> -
> - return r8712_get_stainfo(pstapriv, bc_addr);
> -}
> -
> -u8 r8712_access_ctrl(struct wlan_acl_pool pacl_list, u8 mac_addr)
> -{
> - return true;
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_wlan_sme.h b/drivers/staging=
/rtl8712/rtl871x_wlan_sme.h
> deleted file mode 100644
> index 97ea1451426c..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_wlan_sme.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
*****
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - /
> -#ifndef RTL871X_WLAN_SME_H
> -#define RTL871X_WLAN_SME_H
> -
> -#define MSR_APMODE 0x0C
> -#define MSR_STAMODE 0x08
> -#define MSR_ADHOCMODE 0x04
> -#define MSR_NOLINKMODE 0x00
> -#define 1M_RATE 0
> -#define 2M_RATE 1
> -#define 5M_RATE 2
> -#define 11M_RATE 3
> -#define 6M_RATE 4
> -#define 9M_RATE 5
> -#define 12M_RATE 6
> -#define 18M_RATE 7
> -#define 24M_RATE 8
> -#define 36M_RATE 9
> -#define 48M_RATE 10
> -#define 54M_RATE 11
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl=
8712/rtl871x_xmit.c
> deleted file mode 100644
> index a9aab0389e7f..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ /dev/null
> @@ -1,1056 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * rtl871x_xmit.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define RTL871X_XMIT_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "osdep_intf.h"
> -#include "usb_ops.h"
> -
> -#include <linux/usb.h>
>=20
> -#include <linux/ieee80211.h>
>=20
> -
> -static const u8 P802_1H_OUI[P80211_OUI_LEN] =3D {0x00, 0x00, 0xf8};
> -static const u8 RFC1042_OUI[P80211_OUI_LEN] =3D {0x00, 0x00, 0x00};
> -static void init_hwxmits(struct hw_xmit *phwxmit, sint entry);
> -static void alloc_hwxmits(struct _adapter *padapter);
> -static void free_hwxmits(struct _adapter *padapter);
> -
> -static void _init_txservq(struct tx_servq *ptxservq)
> -{
> - INIT_LIST_HEAD(&ptxservq->tx_pending);
>=20
> - _init_queue(&ptxservq->sta_pending);
>=20
> - ptxservq->qcnt =3D 0;
>=20
> -}
> -
> -void _r8712_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
> -{
> - memset((unsigned char *)psta_xmitpriv, 0,
> - sizeof(struct sta_xmit_priv));
> - spin_lock_init(&psta_xmitpriv->lock);
>=20
> - _init_txservq(&psta_xmitpriv->be_q);
>=20
> - _init_txservq(&psta_xmitpriv->bk_q);
>=20
> - _init_txservq(&psta_xmitpriv->vi_q);
>=20
> - _init_txservq(&psta_xmitpriv->vo_q);
>=20
> - INIT_LIST_HEAD(&psta_xmitpriv->legacy_dz);
>=20
> - INIT_LIST_HEAD(&psta_xmitpriv->apsd);
>=20
> -}
> -
> -int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
> - struct _adapter *padapter)
> -{
> - sint i;
> - struct xmit_buf *pxmitbuf;
> - struct xmit_frame *pxframe;
> - int j;
> -
> - memset((unsigned char *)pxmitpriv, 0, sizeof(struct xmit_priv));
> - spin_lock_init(&pxmitpriv->lock);
>=20
> - /*
> - *Please insert all the queue initialization using _init_queue below
> - */
> - pxmitpriv->adapter =3D padapter;
>=20
> - _init_queue(&pxmitpriv->be_pending);
>=20
> - _init_queue(&pxmitpriv->bk_pending);
>=20
> - _init_queue(&pxmitpriv->vi_pending);
>=20
> - _init_queue(&pxmitpriv->vo_pending);
>=20
> - _init_queue(&pxmitpriv->bm_pending);
>=20
> - _init_queue(&pxmitpriv->legacy_dz_queue);
>=20
> - _init_queue(&pxmitpriv->apsd_queue);
>=20
> - _init_queue(&pxmitpriv->free_xmit_queue);
>=20
> - /*
> - * Please allocate memory with sz =3D (struct xmit_frame) * NR_XMITFRAME=
,
> - * and initialize free_xmit_frame below.
> - * Please also apply free_txobj to link_up all the xmit_frames...
> - */
> - pxmitpriv->pallocated_frame_buf =3D
>=20
> - kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4,
> - GFP_ATOMIC);
> - if (!pxmitpriv->pallocated_frame_buf) {
>=20
> - pxmitpriv->pxmit_frame_buf =3D NULL;
>=20
> - return -ENOMEM;
> - }
> - pxmitpriv->pxmit_frame_buf =3D pxmitpriv->pallocated_frame_buf + 4 -
>=20
> - ((addr_t) (pxmitpriv->pallocated_frame_buf) & 3);
>=20
> - pxframe =3D (struct xmit_frame *) pxmitpriv->pxmit_frame_buf;
>=20
> - for (i =3D 0; i < NR_XMITFRAME; i++) {
> - INIT_LIST_HEAD(&pxframe->list);
>=20
> - pxframe->padapter =3D padapter;
>=20
> - pxframe->frame_tag =3D DATA_FRAMETAG;
>=20
> - pxframe->pkt =3D NULL;
>=20
> - pxframe->buf_addr =3D NULL;
>=20
> - pxframe->pxmitbuf =3D NULL;
>=20
> - list_add_tail(&pxframe->list,
>=20
> - &pxmitpriv->free_xmit_queue.queue);
>=20
> - pxframe++;
> - }
> - pxmitpriv->free_xmitframe_cnt =3D NR_XMITFRAME;
>=20
> - /*
> - * init xmit hw_txqueue
> - */
> - _r8712_init_hw_txqueue(&pxmitpriv->be_txqueue, BE_QUEUE_INX);
>=20
> - _r8712_init_hw_txqueue(&pxmitpriv->bk_txqueue, BK_QUEUE_INX);
>=20
> - _r8712_init_hw_txqueue(&pxmitpriv->vi_txqueue, VI_QUEUE_INX);
>=20
> - _r8712_init_hw_txqueue(&pxmitpriv->vo_txqueue, VO_QUEUE_INX);
>=20
> - _r8712_init_hw_txqueue(&pxmitpriv->bmc_txqueue, BMC_QUEUE_INX);
>=20
> - pxmitpriv->frag_len =3D MAX_FRAG_THRESHOLD;
>=20
> - pxmitpriv->txirp_cnt =3D 1;
>=20
> - /per AC pending irp/
> - pxmitpriv->beq_cnt =3D 0;
>=20
> - pxmitpriv->bkq_cnt =3D 0;
>=20
> - pxmitpriv->viq_cnt =3D 0;
>=20
> - pxmitpriv->voq_cnt =3D 0;
>=20
> - /init xmit_buf/
> - _init_queue(&pxmitpriv->free_xmitbuf_queue);
>=20
> - _init_queue(&pxmitpriv->pending_xmitbuf_queue);
>=20
> - pxmitpriv->pxmitbuf =3D kmalloc_array(NR_XMITBUFF, sizeof(struct xmit_b=
uf), GFP_ATOMIC);
>=20
> - if (!pxmitpriv->pxmitbuf)
>=20
> - goto clean_up_frame_buf;
> - pxmitbuf =3D (struct xmit_buf *)pxmitpriv->pxmitbuf;
>=20
> - for (i =3D 0; i < NR_XMITBUFF; i++) {
> - INIT_LIST_HEAD(&pxmitbuf->list);
>=20
> - pxmitbuf->pallocated_buf =3D
>=20
> - kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
> - if (!pxmitbuf->pallocated_buf) {
>=20
> - j =3D 0;
> - goto clean_up_alloc_buf;
> - }
> - pxmitbuf->pbuf =3D pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
>=20
> - ((addr_t) (pxmitbuf->pallocated_buf) &
>=20
> - (XMITBUF_ALIGN_SZ - 1));
> - if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
> - j =3D 1;
> - goto clean_up_alloc_buf;
> - }
> - list_add_tail(&pxmitbuf->list,
>=20
> - &pxmitpriv->free_xmitbuf_queue.queue);
>=20
> - pxmitbuf++;
> - }
> - pxmitpriv->free_xmitbuf_cnt =3D NR_XMITBUFF;
>=20
> - INIT_WORK(&padapter->wk_filter_rx_ff0, r8712_SetFilter);
>=20
> - alloc_hwxmits(padapter);
> - init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
>=20
> - tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
>=20
> - return 0;
> -
> -clean_up_alloc_buf:
> - if (j) {
> - /* failure happened in r8712_xmit_resource_alloc()
> - * delete extra pxmitbuf->pallocated_buf
>=20
> - */
> - kfree(pxmitbuf->pallocated_buf);
>=20
> - }
> - for (j =3D 0; j < i; j++) {
> - int k;
> -
> - pxmitbuf--; /* reset pointer */
> - kfree(pxmitbuf->pallocated_buf);
>=20
> - for (k =3D 0; k < 8; k++) /* delete xmit urb's */
> - usb_free_urb(pxmitbuf->pxmit_urb[k]);
>=20
> - }
> - kfree(pxmitpriv->pxmitbuf);
>=20
> - pxmitpriv->pxmitbuf =3D NULL;
>=20
> -clean_up_frame_buf:
> - kfree(pxmitpriv->pallocated_frame_buf);
>=20
> - pxmitpriv->pallocated_frame_buf =3D NULL;
>=20
> - return -ENOMEM;
> -}
> -
> -void _free_xmit_priv(struct xmit_priv *pxmitpriv)
> -{
> - int i;
> - struct _adapter *padapter =3D pxmitpriv->adapter;
>=20
> - struct xmit_frame *pxmitframe =3D (struct xmit_frame *)
> - pxmitpriv->pxmit_frame_buf;
>=20
> - struct xmit_buf *pxmitbuf =3D (struct xmit_buf *)pxmitpriv->pxmitbuf;
>=20
> -
> - if (!pxmitpriv->pxmit_frame_buf)
>=20
> - return;
> - for (i =3D 0; i < NR_XMITFRAME; i++) {
> - r8712_xmit_complete(padapter, pxmitframe);
> - pxmitframe++;
> - }
> - for (i =3D 0; i < NR_XMITBUFF; i++) {
> - r8712_xmit_resource_free(padapter, pxmitbuf);
> - kfree(pxmitbuf->pallocated_buf);
>=20
> - pxmitbuf++;
> - }
> - kfree(pxmitpriv->pallocated_frame_buf);
>=20
> - kfree(pxmitpriv->pxmitbuf);
>=20
> - free_hwxmits(padapter);
> -}
> -
> -int r8712_update_attrib(struct _adapter *padapter, _pkt *pkt,
> - struct pkt_attrib *pattrib)
> -{
> - struct pkt_file pktfile;
> - struct sta_info *psta =3D NULL;
> - struct ethhdr etherhdr;
> -
> - struct tx_cmd txdesc;
> -
> - bool bmcast;
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> - struct security_priv *psecuritypriv =3D &padapter->securitypriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct qos_priv *pqospriv =3D &pmlmepriv->qospriv;
>=20
> -
> - _r8712_open_pktfile(pkt, &pktfile);
> -
> - _r8712_pktfile_read(&pktfile, (unsigned char *)&etherhdr, ETH_HLEN);
> -
> - pattrib->ether_type =3D ntohs(etherhdr.h_proto);
>=20
> -
> - /*
> - * If driver xmit ARP packet, driver can set ps mode to initial
> - * setting. It stands for getting DHCP or fix IP.
> - */
> - if (pattrib->ether_type =3D=3D 0x0806) {
>=20
> - if (padapter->pwrctrlpriv.pwr_mode !=3D
>=20
> - padapter->registrypriv.power_mgnt) {
>=20
> - del_timer_sync(&pmlmepriv->dhcp_timer);
>=20
> - r8712_set_ps_mode(padapter,
> - padapter->registrypriv.power_mgnt,
>=20
> - padapter->registrypriv.smart_ps);
>=20
> - }
> - }
> -
> - memcpy(pattrib->dst, &etherhdr.h_dest, ETH_ALEN);
>=20
> - memcpy(pattrib->src, &etherhdr.h_source, ETH_ALEN);
>=20
> - pattrib->pctrl =3D 0;
>=20
> - if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
> - check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
> - memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> - memcpy(pattrib->ra, get_bssid(pmlmepriv), ETH_ALEN);
>=20
> - memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
> - memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, get_bssid(pmlmepriv), ETH_ALEN);
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
> - /firstly, filter packet not belongs to mp/
> - if (pattrib->ether_type !=3D 0x8712)
>=20
> - return -EINVAL;
> - /* for mp storing the txcmd per packet,
> - * according to the info of txcmd to update pattrib
> - */
> - /get MP_TXDESC_SIZE bytes txcmd per packet/
> - _r8712_pktfile_read(&pktfile, (u8 *)&txdesc, TXDESC_SIZE);
> - memcpy(pattrib->ra, pattrib->dst, ETH_ALEN);
>=20
> - memcpy(pattrib->ta, pattrib->src, ETH_ALEN);
>=20
> - pattrib->pctrl =3D 1;
>=20
> - }
> - /* r8712_xmitframe_coalesce() overwrite this!*/
> - pattrib->pktlen =3D pktfile.pkt_len;
>=20
> - if (pattrib->ether_type =3D=3D ETH_P_IP) {
>=20
> - /* The following is for DHCP and ARP packet, we use cck1M to
> - * tx these packets and let LPS awake some time
> - * to prevent DHCP protocol fail
> - */
> - u8 tmp[24];
> -
> - _r8712_pktfile_read(&pktfile, &tmp[0], 24);
> - pattrib->dhcp_pkt =3D 0;
>=20
> - if (pktfile.pkt_len > 282) {/MINIMUM_DHCP_PACKET_SIZE)/
>=20
> - if (pattrib->ether_type =3D=3D ETH_P_IP) {/* IP header*/
>=20
> - if (((tmp[21] =3D=3D 68) && (tmp[23] =3D=3D 67)) ||
> - ((tmp[21] =3D=3D 67) && (tmp[23] =3D=3D 68))) {
> - /* 68 : UDP BOOTP client
> - * 67 : UDP BOOTP server
> - * Use low rate to send DHCP packet.
> - */
> - pattrib->dhcp_pkt =3D 1;
>=20
> - }
> - }
> - }
> - }
> - bmcast =3D is_multicast_ether_addr(pattrib->ra);
>=20
> - /* get sta_info*/
> - if (bmcast) {
> - psta =3D r8712_get_bcmc_stainfo(padapter);
> - pattrib->mac_id =3D 4;
>=20
> - } else {
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
> - psta =3D r8712_get_stainfo(pstapriv,
> - get_bssid(pmlmepriv));
> - pattrib->mac_id =3D 5;
>=20
> - } else {
> - psta =3D r8712_get_stainfo(pstapriv, pattrib->ra);
>=20
> - if (!psta) /* drop the pkt */
> - return -ENOMEM;
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
> - pattrib->mac_id =3D 5;
>=20
> - else
> - pattrib->mac_id =3D psta->mac_id;
>=20
> - }
> - }
> -
> - if (psta) {
> - pattrib->psta =3D psta;
>=20
> - } else {
> - /* if we cannot get psta =3D> drrp the pkt */
>=20
> - return -ENOMEM;
> - }
> -
> - pattrib->ack_policy =3D 0;
>=20
> - /* get ether_hdr_len */
> - pattrib->pkt_hdrlen =3D ETH_HLEN;
>=20
> -
> - if (pqospriv->qos_option) {
>=20
> - r8712_set_qos(&pktfile, pattrib);
> - } else {
> - pattrib->hdrlen =3D WLAN_HDR_A3_LEN;
>=20
> - pattrib->subtype =3D IEEE80211_FTYPE_DATA;
>=20
> - pattrib->priority =3D 0;
>=20
> - }
> - if (psta->ieee8021x_blocked) {
>=20
> - pattrib->encrypt =3D 0;
>=20
> - if ((pattrib->ether_type !=3D 0x888e) &&
>=20
> - !check_fwstate(pmlmepriv, WIFI_MP_STATE))
> - return -EINVAL;
> - } else {
> - GET_ENCRY_ALGO(psecuritypriv, psta, pattrib->encrypt, bmcast);
>=20
> - }
> - switch (pattrib->encrypt) {
>=20
> - case WEP40:
> - case WEP104:
> - pattrib->iv_len =3D 4;
>=20
> - pattrib->icv_len =3D 4;
>=20
> - break;
> - case TKIP:
> - pattrib->iv_len =3D 8;
>=20
> - pattrib->icv_len =3D 4;
>=20
> - if (padapter->securitypriv.busetkipkey =3D=3D _FAIL)
>=20
> - return -EINVAL;
> - break;
> - case AES:
> - pattrib->iv_len =3D 8;
>=20
> - pattrib->icv_len =3D 8;
>=20
> - break;
> - default:
> - pattrib->iv_len =3D 0;
>=20
> - pattrib->icv_len =3D 0;
>=20
> - break;
> - }
> -
> - if (pattrib->encrypt &&
>=20
> - (padapter->securitypriv.sw_encrypt ||
>=20
> - !psecuritypriv->hw_decrypted))
>=20
> - pattrib->bswenc =3D true;
>=20
> - else
> - pattrib->bswenc =3D false;
>=20
> - /* if in MP_STATE, update pkt_attrib from mp_txcmd, and overwrite
> - * some settings above.
> - */
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
> - pattrib->priority =3D
>=20
> - (le32_to_cpu(txdesc.txdw1) >> QSEL_SHT) & 0x1f;
>=20
> - return 0;
> -}
> -
> -static int xmitframe_addmic(struct _adapter *padapter,
> - struct xmit_frame *pxmitframe)
> -{
> - u32 curfragnum, length;
> - u8 *pframe, *payload, mic[8];
> - struct mic_data micdata;
> - struct sta_info *stainfo;
> - struct qos_priv *pqospriv =3D &padapter->mlmepriv.qospriv;
>=20
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> - struct security_priv *psecpriv =3D &padapter->securitypriv;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - u8 priority[4] =3D {};
> - bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
>=20
> -
> - if (pattrib->psta)
>=20
> - stainfo =3D pattrib->psta;
>=20
> - else
> - stainfo =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - &pattrib->ra[0]);
>=20
> - if (pattrib->encrypt =3D=3D TKIP) {
>=20
> - /encode mic code/
> - if (stainfo) {
> - u8 null_key[16] =3D {};
> -
> - pframe =3D pxmitframe->buf_addr + TXDESC_OFFSET;
>=20
> - if (bmcst) {
> - if (!memcmp(psecpriv->XGrptxmickey
>=20
> - [psecpriv->XGrpKeyid].skey,
>=20
> - null_key, 16))
> - return -ENOMEM;
> - /start to calculate the mic code/
> - r8712_secmicsetkey(&micdata,
> - psecpriv->XGrptxmickey
>=20
> - [psecpriv->XGrpKeyid].skey);
>=20
> - } else {
> - if (!memcmp(&stainfo->tkiptxmickey.skey[0],
>=20
> - null_key, 16))
> - return -ENOMEM;
> - /* start to calculate the mic code */
> - r8712_secmicsetkey(&micdata,
> - &stainfo->tkiptxmickey.skey[0]);
>=20
> - }
> - if (pframe[1] & 1) { /* ToDS=3D=3D1 /
> - r8712_secmicappend(&micdata,
> - &pframe[16], 6); /DA/
> - if (pframe[1] & 2) / From Ds=3D=3D1 /
> - r8712_secmicappend(&micdata,
> - &pframe[24], 6);
> - else
> - r8712_secmicappend(&micdata,
> - &pframe[10], 6);
> - } else { / ToDS=3D=3D0 /
> - r8712_secmicappend(&micdata,
> - &pframe[4], 6); / DA /
> - if (pframe[1] & 2) / From Ds=3D=3D1 */
> - r8712_secmicappend(&micdata,
> - &pframe[16], 6);
> - else
> - r8712_secmicappend(&micdata,
> - &pframe[10], 6);
> - }
> - if (pqospriv->qos_option =3D=3D 1)
>=20
> - priority[0] =3D (u8)pxmitframe->attrib.priority;
>=20
> - r8712_secmicappend(&micdata, &priority[0], 4);
> - payload =3D pframe;
> - for (curfragnum =3D 0; curfragnum < pattrib->nr_frags;
>=20
> - curfragnum++) {
> - payload =3D (u8 *)RND4((addr_t)(payload));
> - payload +=3D pattrib->hdrlen + pattrib->iv_len;
>=20
> - if ((curfragnum + 1) =3D=3D pattrib->nr_frags) {
>=20
> - length =3D pattrib->last_txcmdsz -
>=20
> - pattrib->hdrlen -
>=20
> - pattrib->iv_len -
>=20
> - ((psecpriv->sw_encrypt)
>=20
> - ? pattrib->icv_len : 0);
>=20
> - r8712_secmicappend(&micdata, payload,
> - length);
> - payload =3D payload + length;
> - } else {
> - length =3D pxmitpriv->frag_len -
>=20
> - pattrib->hdrlen - pattrib->iv_len -
>=20
> - ((psecpriv->sw_encrypt) ?
>=20
> - pattrib->icv_len : 0);
>=20
> - r8712_secmicappend(&micdata, payload,
> - length);
> - payload =3D payload + length +
> - pattrib->icv_len;
>=20
> - }
> - }
> - r8712_secgetmic(&micdata, &mic[0]);
> - /* add mic code and add the mic code length in
> - * last_txcmdsz
> - */
> - memcpy(payload, &mic[0], 8);
> - pattrib->last_txcmdsz +=3D 8;
>=20
> - payload =3D payload - pattrib->last_txcmdsz + 8;
>=20
> - }
> - }
> - return 0;
> -}
> -
> -static sint xmitframe_swencrypt(struct _adapter *padapter,
> - struct xmit_frame *pxmitframe)
> -{
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> -
> - if (pattrib->bswenc) {
>=20
> - switch (pattrib->encrypt) {
>=20
> - case WEP40:
> - case WEP104:
> - r8712_wep_encrypt(padapter, (u8 *)pxmitframe);
> - break;
> - case TKIP:
> - r8712_tkip_encrypt(padapter, (u8 *)pxmitframe);
> - break;
> - case AES:
> - r8712_aes_encrypt(padapter, (u8 *)pxmitframe);
> - break;
> - default:
> - break;
> - }
> - }
> - return _SUCCESS;
> -}
> -
> -static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
> - struct pkt_attrib *pattrib)
> -{
> - u16 *qc;
> -
> - struct ieee80211_hdr *pwlanhdr =3D (struct ieee80211_hdr *)hdr;
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct qos_priv *pqospriv =3D &pmlmepriv->qospriv;
>=20
> - __le16 *fctrl =3D &pwlanhdr->frame_control;
>=20
> - u8 *bssid;
> -
> - memset(hdr, 0, WLANHDR_OFFSET);
> - SetFrameSubType(fctrl, pattrib->subtype);
>=20
> - if (!(pattrib->subtype & IEEE80211_FTYPE_DATA))
>=20
> - return 0;
> -
> - bssid =3D get_bssid(pmlmepriv);
> -
> - if (check_fwstate(pmlmepriv, WIFI_STATION_STATE)) {
> - /* to_ds =3D 1, fr_ds =3D 0; */
> - SetToDs(fctrl);
> - ether_addr_copy(pwlanhdr->addr1, bssid);
>=20
> - ether_addr_copy(pwlanhdr->addr2, pattrib->src);
>=20
> - ether_addr_copy(pwlanhdr->addr3, pattrib->dst);
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
> - /* to_ds =3D 0, fr_ds =3D 1; */
> - SetFrDs(fctrl);
> - ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
>=20
> - ether_addr_copy(pwlanhdr->addr2, bssid);
>=20
> - ether_addr_copy(pwlanhdr->addr3, pattrib->src);
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
> - check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
> - ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
>=20
> - ether_addr_copy(pwlanhdr->addr2, pattrib->src);
>=20
> - ether_addr_copy(pwlanhdr->addr3, bssid);
>=20
> - } else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
> - ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
>=20
> - ether_addr_copy(pwlanhdr->addr2, pattrib->src);
>=20
> - ether_addr_copy(pwlanhdr->addr3, bssid);
>=20
> - } else {
> - return -EINVAL;
> - }
> -
> - if (pattrib->encrypt)
>=20
> - SetPrivacy(fctrl);
> - if (pqospriv->qos_option) {
>=20
> - qc =3D (unsigned short *)(hdr + pattrib->hdrlen - 2);
>=20
> - if (pattrib->priority)
>=20
> - SetPriority(qc, pattrib->priority);
>=20
> - SetAckpolicy(qc, pattrib->ack_policy);
>=20
> - }
> - /* TODO: fill HT Control Field /
> - / Update Seq Num will be handled by f/w */
> - {
> - struct sta_info *psta;
> - bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
>=20
> -
> - if (pattrib->psta)
>=20
> - psta =3D pattrib->psta;
>=20
> - else if (bmcst)
> - psta =3D r8712_get_bcmc_stainfo(padapter);
> - else
> - psta =3D r8712_get_stainfo(&padapter->stapriv,
>=20
> - pattrib->ra);
>=20
> -
> - if (psta) {
> - u16 *txtid =3D psta->sta_xmitpriv.txseq_tid;
>=20
> -
> - txtid[pattrib->priority]++;
>=20
> - txtid[pattrib->priority] &=3D 0xFFF;
>=20
> - pattrib->seqnum =3D txtid[pattrib->priority];
>=20
> - SetSeqNum(hdr, pattrib->seqnum);
>=20
> - }
> - }
> -
> - return 0;
> -}
> -
> -static sint r8712_put_snap(u8 *data, u16 h_proto)
> -{
> - struct ieee80211_snap_hdr *snap;
> - const u8 *oui;
> -
> - snap =3D (struct ieee80211_snap_hdr *)data;
> - snap->dsap =3D 0xaa;
>=20
> - snap->ssap =3D 0xaa;
>=20
> - snap->ctrl =3D 0x03;
>=20
> - if (h_proto =3D=3D 0x8137 || h_proto =3D=3D 0x80f3)
> - oui =3D P802_1H_OUI;
> - else
> - oui =3D RFC1042_OUI;
> - snap->oui[0] =3D oui[0];
>=20
> - snap->oui[1] =3D oui[1];
>=20
> - snap->oui[2] =3D oui[2];
>=20
> - *(__be16 )(data + SNAP_SIZE) =3D htons(h_proto);
> - return SNAP_SIZE + sizeof(u16);
> -}
> -
> -/
> - * This sub-routine will perform all the following:
> - * 1. remove 802.3 header.
> - * 2. create wlan_header, based on the info in pxmitframe
> - * 3. append sta's iv/ext-iv
> - * 4. append LLC
> - * 5. move frag chunk from pframe to pxmitframe->mem
>=20
> - * 6. apply sw-encrypt, if necessary.
> - */
> -sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
> - struct xmit_frame *pxmitframe)
> -{
> - struct pkt_file pktfile;
> -
> - sint frg_len, mpdu_len, llc_sz;
> - u32 mem_sz;
> - u8 frg_inx;
> - addr_t addr;
> - u8 *pframe, *mem_start, *ptxdesc;
> - struct sta_info *psta;
> - struct security_priv *psecpriv =3D &padapter->securitypriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> - u8 *pbuf_start;
> - bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
>=20
> -
> - if (!pattrib->psta)
>=20
> - return _FAIL;
> - psta =3D pattrib->psta;
>=20
> - if (!pxmitframe->buf_addr)
>=20
> - return _FAIL;
> - pbuf_start =3D pxmitframe->buf_addr;
>=20
> - ptxdesc =3D pbuf_start;
> - mem_start =3D pbuf_start + TXDESC_OFFSET;
> - if (make_wlanhdr(padapter, mem_start, pattrib))
> - return _FAIL;
> - _r8712_open_pktfile(pkt, &pktfile);
> - _r8712_pktfile_read(&pktfile, NULL, (uint) pattrib->pkt_hdrlen);
>=20
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
> - /* truncate TXDESC_SIZE bytes txcmd if at mp mode for 871x */
> - if (pattrib->ether_type =3D=3D 0x8712) {
>=20
> - /* take care - update_txdesc overwrite this */
> - _r8712_pktfile_read(&pktfile, ptxdesc, TXDESC_SIZE);
> - }
> - }
> - pattrib->pktlen =3D pktfile.pkt_len;
>=20
> - frg_inx =3D 0;
> - frg_len =3D pxmitpriv->frag_len - 4;
>=20
> - while (1) {
> - llc_sz =3D 0;
> - mpdu_len =3D frg_len;
> - pframe =3D mem_start;
> - SetMFrag(mem_start);
> - pframe +=3D pattrib->hdrlen;
>=20
> - mpdu_len -=3D pattrib->hdrlen;
>=20
> - /* adding icv, if necessary...*/
> - if (pattrib->iv_len) {
>=20
> - if (psta) {
> - switch (pattrib->encrypt) {
>=20
> - case WEP40:
> - case WEP104:
> - WEP_IV(pattrib->iv, psta->txpn,
>=20
> - (u8)psecpriv->PrivacyKeyIndex);
>=20
> - break;
> - case TKIP:
> - if (bmcst)
> - TKIP_IV(pattrib->iv,
>=20
> - psta->txpn,
>=20
> - (u8)psecpriv->XGrpKeyid);
>=20
> - else
> - TKIP_IV(pattrib->iv, psta->txpn,
>=20
> - 0);
> - break;
> - case AES:
> - if (bmcst)
> - AES_IV(pattrib->iv, psta->txpn,
>=20
> - (u8)psecpriv->XGrpKeyid);
>=20
> - else
> - AES_IV(pattrib->iv, psta->txpn,
>=20
> - 0);
> - break;
> - }
> - }
> - memcpy(pframe, pattrib->iv, pattrib->iv_len);
>=20
> - pframe +=3D pattrib->iv_len;
>=20
> - mpdu_len -=3D pattrib->iv_len;
>=20
> - }
> - if (frg_inx =3D=3D 0) {
> - llc_sz =3D r8712_put_snap(pframe, pattrib->ether_type);
>=20
> - pframe +=3D llc_sz;
> - mpdu_len -=3D llc_sz;
> - }
> - if ((pattrib->icv_len > 0) && (pattrib->bswenc))
>=20
> - mpdu_len -=3D pattrib->icv_len;
>=20
> - if (bmcst)
> - mem_sz =3D _r8712_pktfile_read(&pktfile, pframe,
> - pattrib->pktlen);
>=20
> - else
> - mem_sz =3D _r8712_pktfile_read(&pktfile, pframe,
> - mpdu_len);
> - pframe +=3D mem_sz;
> - if ((pattrib->icv_len > 0) && (pattrib->bswenc)) {
>=20
> - memcpy(pframe, pattrib->icv, pattrib->icv_len);
>=20
> - pframe +=3D pattrib->icv_len;
>=20
> - }
> - frg_inx++;
> - if (bmcst || r8712_endofpktfile(&pktfile)) {
> - pattrib->nr_frags =3D frg_inx;
>=20
> - pattrib->last_txcmdsz =3D pattrib->hdrlen +
>=20
> - pattrib->iv_len +
>=20
> - ((pattrib->nr_frags =3D=3D 1) ?
>=20
> - llc_sz : 0) +
> - ((pattrib->bswenc) ?
>=20
> - pattrib->icv_len : 0) + mem_sz;
>=20
> - ClearMFrag(mem_start);
> - break;
> - }
> - addr =3D (addr_t)(pframe);
> - mem_start =3D (unsigned char *)RND4(addr) + TXDESC_OFFSET;
> - memcpy(mem_start, pbuf_start + TXDESC_OFFSET, pattrib->hdrlen);
>=20
> - }
> -
> - if (xmitframe_addmic(padapter, pxmitframe))
> - return _FAIL;
> - xmitframe_swencrypt(padapter, pxmitframe);
> - return _SUCCESS;
> -}
> -
> -void r8712_update_protection(struct _adapter *padapter, u8 *ie, uint ie_=
len)
> -{
> - uint protection;
> - u8 *perp;
> - uint erp_len;
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct registry_priv *pregistrypriv =3D &padapter->registrypriv;
>=20
> -
> - switch (pxmitpriv->vcs_setting) {
>=20
> - case DISABLE_VCS:
> - pxmitpriv->vcs =3D NONE_VCS;
>=20
> - break;
> - case ENABLE_VCS:
> - break;
> - case AUTO_VCS:
> - default:
> - perp =3D r8712_get_ie(ie, WLAN_EID_ERP_INFO, &erp_len, ie_len);
> - if (!perp) {
> - pxmitpriv->vcs =3D NONE_VCS;
>=20
> - } else {
> - protection =3D (*(perp + 2)) & BIT(1);
> - if (protection) {
> - if (pregistrypriv->vcs_type =3D=3D RTS_CTS)
>=20
> - pxmitpriv->vcs =3D RTS_CTS;
>=20
> - else
> - pxmitpriv->vcs =3D CTS_TO_SELF;
>=20
> - } else {
> - pxmitpriv->vcs =3D NONE_VCS;
>=20
> - }
> - }
> - break;
> - }
> -}
> -
> -struct xmit_buf *r8712_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
> -{
> - unsigned long irqL;
> - struct xmit_buf *pxmitbuf;
> - struct __queue *pfree_xmitbuf_queue =3D &pxmitpriv->free_xmitbuf_queue;
>=20
> -
> - spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irqL);
>=20
> - pxmitbuf =3D list_first_entry_or_null(&pfree_xmitbuf_queue->queue,
>=20
> - struct xmit_buf, list);
> - if (pxmitbuf) {
> - list_del_init(&pxmitbuf->list);
>=20
> - pxmitpriv->free_xmitbuf_cnt--;
>=20
> - }
> - spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
>=20
> - return pxmitbuf;
> -}
> -
> -void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *px=
mitbuf)
> -{
> - unsigned long irqL;
> - struct __queue *pfree_xmitbuf_queue =3D &pxmitpriv->free_xmitbuf_queue;
>=20
> -
> - if (!pxmitbuf)
> - return;
> - spin_lock_irqsave(&pfree_xmitbuf_queue->lock, irqL);
>=20
> - list_del_init(&pxmitbuf->list);
>=20
> - list_add_tail(&pxmitbuf->list, &pfree_xmitbuf_queue->queue);
>=20
> - pxmitpriv->free_xmitbuf_cnt++;
>=20
> - spin_unlock_irqrestore(&pfree_xmitbuf_queue->lock, irqL);
>=20
> -}
> -
> -/*
> - * Calling context:
> - * 1. OS_TXENTRY
> - * 2. RXENTRY (rx_thread or RX_ISR/RX_CallBack)
> - *
> - * If we turn on USE_RXTHREAD, then, no need for critical section.
> - * Otherwise, we must use _enter/_exit critical to protect free_xmit_que=
ue...
> - *
> - * Must be very very cautious...
> - *
> - */
> -struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv pxmitpriv)
> -{
> - /
> - * Please remember to use all the osdep_service api,
> - * and lock/unlock or _enter/_exit critical to protect
> - * pfree_xmit_queue
> - */
> - unsigned long irqL;
> - struct xmit_frame *pxframe;
> - struct __queue *pfree_xmit_queue =3D &pxmitpriv->free_xmit_queue;
>=20
> -
> - spin_lock_irqsave(&pfree_xmit_queue->lock, irqL);
>=20
> - pxframe =3D list_first_entry_or_null(&pfree_xmit_queue->queue,
>=20
> - struct xmit_frame, list);
> - if (pxframe) {
> - list_del_init(&pxframe->list);
>=20
> - pxmitpriv->free_xmitframe_cnt--;
>=20
> - pxframe->buf_addr =3D NULL;
>=20
> - pxframe->pxmitbuf =3D NULL;
>=20
> - pxframe->attrib.psta =3D NULL;
>=20
> - pxframe->pkt =3D NULL;
>=20
> - }
> - spin_unlock_irqrestore(&pfree_xmit_queue->lock, irqL);
>=20
> - return pxframe;
> -}
> -
> -void r8712_free_xmitframe(struct xmit_priv *pxmitpriv,
> - struct xmit_frame *pxmitframe)
> -{
> - unsigned long irqL;
> - struct __queue *pfree_xmit_queue =3D &pxmitpriv->free_xmit_queue;
>=20
> - struct _adapter *padapter =3D pxmitpriv->adapter;
>=20
> -
> - if (!pxmitframe)
> - return;
> - spin_lock_irqsave(&pfree_xmit_queue->lock, irqL);
>=20
> - list_del_init(&pxmitframe->list);
>=20
> - if (pxmitframe->pkt)
>=20
> - pxmitframe->pkt =3D NULL;
>=20
> - list_add_tail(&pxmitframe->list, &pfree_xmit_queue->queue);
>=20
> - pxmitpriv->free_xmitframe_cnt++;
>=20
> - spin_unlock_irqrestore(&pfree_xmit_queue->lock, irqL);
>=20
> - if (netif_queue_stopped(padapter->pnetdev))
>=20
> - netif_wake_queue(padapter->pnetdev);
>=20
> -}
> -
> -void r8712_free_xmitframe_ex(struct xmit_priv *pxmitpriv,
> - struct xmit_frame *pxmitframe)
> -{
> - if (!pxmitframe)
> - return;
> - if (pxmitframe->frame_tag =3D=3D DATA_FRAMETAG)
>=20
> - r8712_free_xmitframe(pxmitpriv, pxmitframe);
> -}
> -
> -void r8712_free_xmitframe_queue(struct xmit_priv *pxmitpriv,
> - struct __queue *pframequeue)
> -{
> - unsigned long irqL;
> - struct list_head *plist, *phead;
> - struct xmit_frame *pxmitframe;
> -
> - spin_lock_irqsave(&pframequeue->lock, irqL);
>=20
> - phead =3D &pframequeue->queue;
>=20
> - plist =3D phead->next;
>=20
> - while (!end_of_queue_search(phead, plist)) {
> - pxmitframe =3D container_of(plist, struct xmit_frame, list);
> - plist =3D plist->next;
>=20
> - r8712_free_xmitframe(pxmitpriv, pxmitframe);
> - }
> - spin_unlock_irqrestore(&pframequeue->lock, irqL);
>=20
> -}
> -
> -static inline struct tx_servq *get_sta_pending(struct _adapter *padapter=
,
> - struct __queue **ppstapending,
> - struct sta_info *psta, sint up)
> -{
> - struct tx_servq *ptxservq;
> - struct hw_xmit *phwxmits =3D padapter->xmitpriv.hwxmits;
>=20
> -
> - switch (up) {
> - case 1:
> - case 2:
> - ptxservq =3D &psta->sta_xmitpriv.bk_q;
>=20
> - *ppstapending =3D &padapter->xmitpriv.bk_pending;
>=20
> - (phwxmits + 3)->accnt++;
>=20
> - break;
> - case 4:
> - case 5:
> - ptxservq =3D &psta->sta_xmitpriv.vi_q;
>=20
> - *ppstapending =3D &padapter->xmitpriv.vi_pending;
>=20
> - (phwxmits + 1)->accnt++;
>=20
> - break;
> - case 6:
> - case 7:
> - ptxservq =3D &psta->sta_xmitpriv.vo_q;
>=20
> - *ppstapending =3D &padapter->xmitpriv.vo_pending;
>=20
> - (phwxmits + 0)->accnt++;
>=20
> - break;
> - case 0:
> - case 3:
> - default:
> - ptxservq =3D &psta->sta_xmitpriv.be_q;
>=20
> - *ppstapending =3D &padapter->xmitpriv.be_pending;
>=20
> - (phwxmits + 2)->accnt++;
>=20
> - break;
> - }
> - return ptxservq;
> -}
> -
> -/*
> - * Will enqueue pxmitframe to the proper queue, and indicate it
> - * to xx_pending list.....
> - */
> -int r8712_xmit_classifier(struct _adapter *padapter,
> - struct xmit_frame *pxmitframe)
> -{
> - unsigned long irqL0;
> - struct __queue *pstapending;
> - struct sta_info *psta;
> - struct tx_servq *ptxservq;
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> - struct sta_priv *pstapriv =3D &padapter->stapriv;
>=20
> - struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
>=20
> - bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
>=20
> -
> - if (pattrib->psta) {
>=20
> - psta =3D pattrib->psta;
>=20
> - } else {
> - if (bmcst) {
> - psta =3D r8712_get_bcmc_stainfo(padapter);
> - } else {
> - if (check_fwstate(pmlmepriv, WIFI_MP_STATE))
> - psta =3D r8712_get_stainfo(pstapriv,
> - get_bssid(pmlmepriv));
> - else
> - psta =3D r8712_get_stainfo(pstapriv, pattrib->ra);
>=20
> - }
> - }
> - if (!psta)
> - return -EINVAL;
> - ptxservq =3D get_sta_pending(padapter, &pstapending,
> - psta, pattrib->priority);
>=20
> - spin_lock_irqsave(&pstapending->lock, irqL0);
>=20
> - if (list_empty(&ptxservq->tx_pending))
>=20
> - list_add_tail(&ptxservq->tx_pending, &pstapending->queue);
>=20
> - list_add_tail(&pxmitframe->list, &ptxservq->sta_pending.queue);
>=20
> - ptxservq->qcnt++;
>=20
> - spin_unlock_irqrestore(&pstapending->lock, irqL0);
>=20
> - return 0;
> -}
> -
> -static void alloc_hwxmits(struct _adapter *padapter)
> -{
> - struct hw_xmit *hwxmits;
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> -
> - pxmitpriv->hwxmit_entry =3D HWXMIT_ENTRY;
>=20
> - pxmitpriv->hwxmits =3D kmalloc_array(pxmitpriv->hwxmit_entry,
>=20
> - sizeof(struct hw_xmit), GFP_ATOMIC);
> - if (!pxmitpriv->hwxmits)
>=20
> - return;
> - hwxmits =3D pxmitpriv->hwxmits;
>=20
> - if (pxmitpriv->hwxmit_entry =3D=3D 5) {
>=20
> - pxmitpriv->bmc_txqueue.head =3D 0;
>=20
> - hwxmits[0] .phwtxqueue =3D &pxmitpriv->bmc_txqueue;
>=20
> - hwxmits[0] .sta_queue =3D &pxmitpriv->bm_pending;
>=20
> - pxmitpriv->vo_txqueue.head =3D 0;
>=20
> - hwxmits[1] .phwtxqueue =3D &pxmitpriv->vo_txqueue;
>=20
> - hwxmits[1] .sta_queue =3D &pxmitpriv->vo_pending;
>=20
> - pxmitpriv->vi_txqueue.head =3D 0;
>=20
> - hwxmits[2] .phwtxqueue =3D &pxmitpriv->vi_txqueue;
>=20
> - hwxmits[2] .sta_queue =3D &pxmitpriv->vi_pending;
>=20
> - pxmitpriv->bk_txqueue.head =3D 0;
>=20
> - hwxmits[3] .phwtxqueue =3D &pxmitpriv->bk_txqueue;
>=20
> - hwxmits[3] .sta_queue =3D &pxmitpriv->bk_pending;
>=20
> - pxmitpriv->be_txqueue.head =3D 0;
>=20
> - hwxmits[4] .phwtxqueue =3D &pxmitpriv->be_txqueue;
>=20
> - hwxmits[4] .sta_queue =3D &pxmitpriv->be_pending;
>=20
> - } else if (pxmitpriv->hwxmit_entry =3D=3D 4) {
>=20
> - pxmitpriv->vo_txqueue.head =3D 0;
>=20
> - hwxmits[0] .phwtxqueue =3D &pxmitpriv->vo_txqueue;
>=20
> - hwxmits[0] .sta_queue =3D &pxmitpriv->vo_pending;
>=20
> - pxmitpriv->vi_txqueue.head =3D 0;
>=20
> - hwxmits[1] .phwtxqueue =3D &pxmitpriv->vi_txqueue;
>=20
> - hwxmits[1] .sta_queue =3D &pxmitpriv->vi_pending;
>=20
> - pxmitpriv->be_txqueue.head =3D 0;
>=20
> - hwxmits[2] .phwtxqueue =3D &pxmitpriv->be_txqueue;
>=20
> - hwxmits[2] .sta_queue =3D &pxmitpriv->be_pending;
>=20
> - pxmitpriv->bk_txqueue.head =3D 0;
>=20
> - hwxmits[3] .phwtxqueue =3D &pxmitpriv->bk_txqueue;
>=20
> - hwxmits[3] .sta_queue =3D &pxmitpriv->bk_pending;
>=20
> - }
> -}
> -
> -static void free_hwxmits(struct _adapter *padapter)
> -{
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> -
> - kfree(pxmitpriv->hwxmits);
>=20
> -}
> -
> -static void init_hwxmits(struct hw_xmit *phwxmit, sint entry)
> -{
> - sint i;
> -
> - for (i =3D 0; i < entry; i++, phwxmit++) {
> - spin_lock_init(&phwxmit->xmit_lock);
>=20
> - INIT_LIST_HEAD(&phwxmit->pending);
>=20
> - phwxmit->txcmdcnt =3D 0;
>=20
> - phwxmit->accnt =3D 0;
>=20
> - }
> -}
> -
> -void xmitframe_xmitbuf_attach(struct xmit_frame *pxmitframe,
> - struct xmit_buf pxmitbuf)
> -{
> - / pxmitbuf attach to pxmitframe */
> - pxmitframe->pxmitbuf =3D pxmitbuf;
>=20
> - /* urb and irp connection */
> - pxmitframe->pxmit_urb[0] =3D pxmitbuf->pxmit_urb[0];
>=20
> - /* buffer addr assoc */
> - pxmitframe->buf_addr =3D pxmitbuf->pbuf;
>=20
> - /* pxmitframe attach to pxmitbuf */
> - pxmitbuf->priv_data =3D pxmitframe;
>=20
> -}
> -
> -/*
> - * tx_action =3D=3D 0 =3D=3D no frames to transmit
> - * tx_action > 0 =3D=3D> we have frames to transmit
>=20
> - * tx_action < 0 =3D=3D> we have frames to transmit, but TXFF is not eve=
n enough
>=20
> - * to transmit 1 frame.
> - */
> -
> -int r8712_pre_xmit(struct _adapter *padapter, struct xmit_frame *pxmitfr=
ame)
> -{
> - unsigned long irqL;
> - int ret;
> - struct xmit_buf *pxmitbuf =3D NULL;
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> -
> - r8712_do_queue_select(padapter, pattrib);
> - spin_lock_irqsave(&pxmitpriv->lock, irqL);
>=20
> - if (r8712_txframes_sta_ac_pending(padapter, pattrib) > 0) {
>=20
> - ret =3D false;
> - r8712_xmit_enqueue(padapter, pxmitframe);
> - spin_unlock_irqrestore(&pxmitpriv->lock, irqL);
>=20
> - return ret;
> - }
> - pxmitbuf =3D r8712_alloc_xmitbuf(pxmitpriv);
> - if (!pxmitbuf) { /enqueue packet/
> - ret =3D false;
> - r8712_xmit_enqueue(padapter, pxmitframe);
> - spin_unlock_irqrestore(&pxmitpriv->lock, irqL);
>=20
> - } else { /dump packet directly/
> - spin_unlock_irqrestore(&pxmitpriv->lock, irqL);
>=20
> - ret =3D true;
> - xmitframe_xmitbuf_attach(pxmitframe, pxmitbuf);
> - r8712_xmit_direct(padapter, pxmitframe);
> - }
> - return ret;
> -}
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl=
8712/rtl871x_xmit.h
> deleted file mode 100644
> index 784172c385e3..000000000000
> --- a/drivers/staging/rtl8712/rtl871x_xmit.h
> +++ /dev/null
> @@ -1,287 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ******************************************************/
> -#ifndef RTL871X_XMIT_H
> -#define RTL871X_XMIT_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "xmit_osdep.h"
> -
> -#ifdef CONFIG_R8712_TX_AGGR
> -#define MAX_XMITBUF_SZ (16384)
> -#else
> -#define MAX_XMITBUF_SZ (2048)
> -#endif
> -
> -#define NR_XMITBUFF (4)
> -
> -#ifdef CONFIG_R8712_TX_AGGR
> -#define AGGR_NR_HIGH_BOUND (4) /(8) /
> -#define AGGR_NR_LOW_BOUND (2)
> -#endif
> -
> -#define XMITBUF_ALIGN_SZ 512
> -#define TX_GUARD_BAND 5
> -#define MAX_NUMBLKS (1)
> -
> -/ Fixed the Big Endian bug when using the software driver encryption./
> -#define WEP_IV(pattrib_iv, txpn, keyidx)\
> -do { \
> - pattrib_iv[0] =3D txpn.byte.TSC0;\
> - pattrib_iv[1] =3D txpn.byte.TSC1;\
> - pattrib_iv[2] =3D txpn.byte.TSC2;\
> - pattrib_iv[3] =3D ((keyidx & 0x3) << 6);\
> - txpn.val =3D (txpn.val =3D=3D 0xffffff) ? 0 : (txpn.val + 1);\
> -} while (0)
> -
> -/ Fixed the Big Endian bug when doing the Tx.
> - * The Linksys WRH54G will check this.
> - /
> -#define TKIP_IV(pattrib_iv, txpn, keyidx)\
> -do { \
> - pattrib_iv[0] =3D txpn.byte.TSC1;\
> - pattrib_iv[1] =3D (txpn.byte.TSC1 | 0x20) & 0x7f;\
> - pattrib_iv[2] =3D txpn.byte.TSC0;\
> - pattrib_iv[3] =3D BIT(5) | ((keyidx & 0x3) << 6);\
> - pattrib_iv[4] =3D txpn.byte.TSC2;\
> - pattrib_iv[5] =3D txpn.byte.TSC3;\
> - pattrib_iv[6] =3D txpn.byte.TSC4;\
> - pattrib_iv[7] =3D txpn.byte.TSC5;\
> - txpn.val =3D txpn.val =3D=3D 0xffffffffffffULL ? 0 : \
> - (txpn.val + 1);\
> -} while (0)
> -
> -#define AES_IV(pattrib_iv, txpn, keyidx)\
> -do { \
> - pattrib_iv[0] =3D txpn.byte.TSC0;\
> - pattrib_iv[1] =3D txpn.byte.TSC1;\
> - pattrib_iv[2] =3D 0;\
> - pattrib_iv[3] =3D BIT(5) | ((keyidx & 0x3) << 6);\
> - pattrib_iv[4] =3D txpn.byte.TSC2;\
> - pattrib_iv[5] =3D txpn.byte.TSC3;\
> - pattrib_iv[6] =3D txpn.byte.TSC4;\
> - pattrib_iv[7] =3D txpn.byte.TSC5;\
> - txpn.val =3D txpn.val =3D=3D 0xffffffffffffULL ? 0 : \
> - (txpn.val + 1);\
> -} while (0)
> -
> -struct hw_xmit {
> - spinlock_t xmit_lock;
> - struct list_head pending;
> - struct __queue sta_queue;
> - struct hw_txqueue phwtxqueue;
> - sint txcmdcnt;
> - int accnt;
> -};
> -
> -struct pkt_attrib {
> - u8 type;
> - u8 subtype;
> - u8 bswenc;
> - u8 dhcp_pkt;
> -
> - u16 seqnum;
> - u16 ether_type;
> - u16 pktlen; / the original 802.3 pkt raw_data len
> - * (not include ether_hdr data)
> - /
> - u16 last_txcmdsz;
> -
> - u8 pkt_hdrlen; /the original 802.3 pkt header len/
> - u8 hdrlen; /the WLAN Header Len/
> - u8 nr_frags;
> - u8 ack_policy;
> - u8 mac_id;
> - u8 vcs_mode; /virtual carrier sense method/
> - u8 pctrl;/per packet txdesc control enable/
> - u8 qsel;
> -
> - u8 priority;
> - u8 encrypt; / when 0 indicate no encrypt. when non-zero,
> - * indicate the encrypt algorithm
> - /
> - u8 iv_len;
> - u8 icv_len;
> - unsigned char iv[8];
> - unsigned char icv[8];
> - u8 dst[ETH_ALEN] __aligned(2); / for ether_addr_copy /
> - u8 src[ETH_ALEN];
> - u8 ta[ETH_ALEN];
> - u8 ra[ETH_ALEN];
> - struct sta_info psta;
> -};
> -
> -#define WLANHDR_OFFSET 64
> -#define DATA_FRAMETAG 0x01
> -#define L2_FRAMETAG 0x02
> -#define MGNT_FRAMETAG 0x03
> -#define AMSDU_FRAMETAG 0x04
> -#define EII_FRAMETAG 0x05
> -#define IEEE8023_FRAMETAG 0x06
> -#define MP_FRAMETAG 0x07
> -#define TXAGG_FRAMETAG 0x08
> -
> -struct xmit_buf {
> - struct list_head list;
> -
> - u8 pallocated_buf;
> - u8 pbuf;
> - void priv_data;
> - struct urb pxmit_urb[8];
> - u32 aggr_nr;
> -};
> -
> -struct xmit_frame {
> - struct list_head list;
> - struct pkt_attrib attrib;
> - _pkt pkt;
> - int frame_tag;
> - struct _adapter padapter;
> - u8 buf_addr;
> - struct xmit_buf pxmitbuf;
> - u8 mem_addr;
> - u16 sz[8];
> - struct urb pxmit_urb[8];
> - u8 bpending[8];
> - u8 last[8];
> -};
> -
> -struct tx_servq {
> - struct list_head tx_pending;
> - struct __queue sta_pending;
> - int qcnt;
> -};
> -
> -struct sta_xmit_priv {
> - spinlock_t lock;
> - sint option;
> - sint apsd_setting; / When bit mask is on, the associated edca
> - * queue supports APSD.
> - /
> - struct tx_servq be_q; / priority =3D=3D 0,3 /
> - struct tx_servq bk_q; / priority =3D=3D 1,2/
> - struct tx_servq vi_q; /priority =3D=3D 4,5/
> - struct tx_servq vo_q; /priority =3D=3D 6,7/
> - struct list_head legacy_dz;
> - struct list_head apsd;
> - u16 txseq_tid[16];
> - uint sta_tx_bytes;
> - u64 sta_tx_pkts;
> - uint sta_tx_fail;
> -};
> -
> -struct hw_txqueue {
> - sint head;
> - sint tail;
> - sint free_sz; / in units of 64 bytes /
> - sint free_cmdsz;
> - sint txsz[8];
> - uint ff_hwaddr;
> - uint cmd_hwaddr;
> - sint ac_tag;
> -};
> -
> -struct xmit_priv {
> - spinlock_t lock;
> - struct __queue be_pending;
> - struct __queue bk_pending;
> - struct __queue vi_pending;
> - struct __queue vo_pending;
> - struct __queue bm_pending;
> - struct __queue legacy_dz_queue;
> - struct __queue apsd_queue;
> - u8 pallocated_frame_buf;
> - u8 pxmit_frame_buf;
> - uint free_xmitframe_cnt;
> - uint mapping_addr;
> - uint pkt_sz;
> - struct __queue free_xmit_queue;
> - struct hw_txqueue be_txqueue;
> - struct hw_txqueue bk_txqueue;
> - struct hw_txqueue vi_txqueue;
> - struct hw_txqueue vo_txqueue;
> - struct hw_txqueue bmc_txqueue;
> - uint frag_len;
> - struct _adapter adapter;
> - u8 vcs_setting;
> - u8 vcs;
> - u8 vcs_type;
> - u16 rts_thresh;
> - uint tx_bytes;
> - u64 tx_pkts;
> - uint tx_drop;
> - struct hw_xmit hwxmits;
> - u8 hwxmit_entry;
> - u8 txirp_cnt;
> - struct tasklet_struct xmit_tasklet;
> - struct work_struct xmit_pipe4_reset_wi;
> - struct work_struct xmit_pipe6_reset_wi;
> - struct work_struct xmit_piped_reset_wi;
> - /per AC pending irp/
> - int beq_cnt;
> - int bkq_cnt;
> - int viq_cnt;
> - int voq_cnt;
> - struct __queue free_amsdu_xmit_queue;
> - u8 pallocated_amsdu_frame_buf;
> - u8 pxmit_amsdu_frame_buf;
> - uint free_amsdu_xmitframe_cnt;
> - struct __queue free_txagg_xmit_queue;
> - u8 pallocated_txagg_frame_buf;
> - u8 pxmit_txagg_frame_buf;
> - uint free_txagg_xmitframe_cnt;
> - int cmdseq;
> - struct __queue free_xmitbuf_queue;
> - struct __queue pending_xmitbuf_queue;
> - u8 pxmitbuf;
> - uint free_xmitbuf_cnt;
> -};
> -
> -void r8712_free_xmitbuf(struct xmit_priv pxmitpriv,
> - struct xmit_buf pxmitbuf);
> -struct xmit_buf r8712_alloc_xmitbuf(struct xmit_priv pxmitpriv);
> -void r8712_update_protection(struct _adapter padapter, u8 ie, uint ie_le=
n);
> -struct xmit_frame r8712_alloc_xmitframe(struct xmit_priv pxmitpriv);
> -void r8712_free_xmitframe(struct xmit_priv pxmitpriv,
> - struct xmit_frame pxmitframe);
> -void r8712_free_xmitframe_queue(struct xmit_priv pxmitpriv,
> - struct __queue pframequeue);
> -int r8712_xmit_classifier(struct _adapter padapter,
> - struct xmit_frame pxmitframe);
> -sint r8712_xmitframe_coalesce(struct _adapter padapter, _pkt pkt,
> - struct xmit_frame pxmitframe);
> -sint _r8712_init_hw_txqueue(struct hw_txqueue phw_txqueue, u8 ac_tag);
> -void _r8712_init_sta_xmit_priv(struct sta_xmit_priv psta_xmitpriv);
> -int r8712_update_attrib(struct _adapter padapter, _pkt pkt,
> - struct pkt_attrib pattrib);
> -int r8712_txframes_sta_ac_pending(struct _adapter padapter,
> - struct pkt_attrib pattrib);
> -int _r8712_init_xmit_priv(struct xmit_priv pxmitpriv,
> - struct _adapter padapter);
> -void _free_xmit_priv(struct xmit_priv pxmitpriv);
> -void r8712_free_xmitframe_ex(struct xmit_priv pxmitpriv,
> - struct xmit_frame pxmitframe);
> -int r8712_pre_xmit(struct _adapter padapter, struct xmit_frame pxmitfram=
e);
> -int r8712_xmit_enqueue(struct _adapter padapter,
> - struct xmit_frame pxmitframe);
> -void r8712_xmit_direct(struct _adapter padapter, struct xmit_frame pxmit=
frame);
> -void r8712_xmit_bh(struct tasklet_struct t);
> -
> -void xmitframe_xmitbuf_attach(struct xmit_frame pxmitframe,
> - struct xmit_buf pxmitbuf);
> -
> -#include "rtl8712_xmit.h"
> -
> -#endif /RTL871X_XMIT_H/
> -
> diff --git a/drivers/staging/rtl8712/sta_info.h b/drivers/staging/rtl8712=
/sta_info.h
> deleted file mode 100644
> index 6286c622475e..000000000000
> --- a/drivers/staging/rtl8712/sta_info.h
> +++ /dev/null
> @@ -1,132 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*****/
> -#ifndef _STA_INFO_H
> -#define _STA_INFO_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "wifi.h"
> -
> -#define NUM_STA 32
> -#define NUM_ACL 64
> -
> -/ if mode =3D=3D0, then the sta is allowed once the addr is hit.
> - * if mode =3D=3D1, then the sta is rejected once the addr is non-hit.
> - /
> -struct wlan_acl_node {
> - struct list_head list;
> - u8 addr[ETH_ALEN];
> - u8 mode;
> -};
> -
> -struct wlan_acl_pool {
> - struct wlan_acl_node aclnode[NUM_ACL];
> -};
> -
> -struct stainfo_stats {
> - uint rx_pkts;
> - uint rx_bytes;
> - u64 tx_pkts;
> - uint tx_bytes;
> -};
> -
> -struct sta_info {
> - spinlock_t lock;
> - struct list_head list; /free_sta_queue/
> - struct list_head hash_list; /sta_hash/
> - struct sta_xmit_priv sta_xmitpriv;
> - struct sta_recv_priv sta_recvpriv;
> - uint state;
> - uint aid;
> - uint mac_id;
> - uint qos_option;
> - u8 hwaddr[ETH_ALEN];
> - uint ieee8021x_blocked; /0: allowed, 1:blocked /
> - uint XPrivacy; /aes, tkip.../
> - union Keytype tkiptxmickey;
> - union Keytype tkiprxmickey;
> - union Keytype x_UncstKey;
> - union pn48 txpn; / PN48 used for Unicast xmit./
> - union pn48 rxpn; / PN48 used for Unicast recv./
> - u8 bssrateset[16];
> - uint bssratelen;
> - s32 rssi;
> - s32 signal_quality;
> - struct stainfo_stats sta_stats;
> - /*for A-MPDU Rx reordering buffer control /
> - struct recv_reorder_ctrl recvreorder_ctrl[16];
> - struct ht_priv htpriv;
> - / Notes:
> - * STA_Mode:
> - * curr_network(mlme_priv/security_priv/qos/ht)
> - * + sta_info: (STA & AP) CAP/INFO
> - * scan_q: AP CAP/INFO
> - * AP_Mode:
> - * curr_network(mlme_priv/security_priv/qos/ht) : AP CAP/INFO
> - * sta_info: (AP & STA) CAP/INFO
> - */
> - struct list_head asoc_list;
> - struct list_head auth_list;
> - unsigned int expire_to;
> - unsigned int auth_seq;
> - unsigned int authalg;
> - unsigned char chg_txt[128];
> - unsigned int tx_ra_bitmap;
> -};
> -
> -struct sta_priv {
> - u8 *pallocated_stainfo_buf;
> - u8 *pstainfo_buf;
> - struct __queue free_sta_queue;
> - spinlock_t sta_hash_lock;
> - struct list_head sta_hash[NUM_STA];
> - int asoc_sta_count;
> - struct __queue sleep_q;
> - struct __queue wakeup_q;
> - struct _adapter padapter;
> - struct list_head asoc_list;
> - struct list_head auth_list;
> - unsigned int auth_to; / sec, time to expire in authenticating. /
> - unsigned int assoc_to; / sec, time to expire before associating. /
> - unsigned int expire_to; / sec , time to expire after associated. */
> -};
> -
> -static inline u32 wifi_mac_hash(u8 *mac)
> -{
> - u32 x;
> -
> - x =3D mac[0];
> - x =3D (x << 2) ^ mac[1];
> - x =3D (x << 2) ^ mac[2];
> - x =3D (x << 2) ^ mac[3];
> - x =3D (x << 2) ^ mac[4];
> - x =3D (x << 2) ^ mac[5];
> - x ^=3D x >> 8;
>=20
> - x =3D x & (NUM_STA - 1);
> - return x;
> -}
> -
> -int _r8712_init_sta_priv(struct sta_priv pstapriv);
> -void _r8712_free_sta_priv(struct sta_priv pstapriv);
> -struct sta_info r8712_alloc_stainfo(struct sta_priv pstapriv,
> - u8 hwaddr);
> -void r8712_free_stainfo(struct _adapter padapter, struct sta_info psta);
> -void r8712_free_all_stainfo(struct _adapter padapter);
> -struct sta_info r8712_get_stainfo(struct sta_priv pstapriv, u8 hwaddr);
> -void r8712_init_bcmc_stainfo(struct _adapter padapter);
> -struct sta_info r8712_get_bcmc_stainfo(struct _adapter padapter);
> -u8 r8712_access_ctrl(struct wlan_acl_pool pacl_list, u8 mac_addr);
> -
> -#endif / STA_INFO_H /
> -
> diff --git a/drivers/staging/rtl8712/usb_halinit.c b/drivers/staging/rtl8=
712/usb_halinit.c
> deleted file mode 100644
> index b3cd59b9830c..000000000000
> --- a/drivers/staging/rtl8712/usb_halinit.c
> +++ /dev/null
> @@ -1,307 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**************************************************************
> - * usb_halinit.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define HCI_HAL_INIT_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "usb_ops.h"
> -#include "usb_osintf.h"
> -
> -u8 r8712_usb_hal_bus_init(struct _adapter *adapter)
> -{
> - u8 val8 =3D 0;
> - u8 ret =3D _SUCCESS;
> - int PollingCnt =3D 20;
> - struct registry_priv *registrypriv =3D &adapter->registrypriv;
>=20
> -
> - if (registrypriv->chip_version =3D=3D RTL8712_FPGA) {
>=20
> - val8 =3D 0x01;
> - /* switch to 80M clock /
> - r8712_write8(adapter, SYS_CLKR, val8);
> - val8 =3D r8712_read8(adapter, SPS1_CTRL);
> - val8 =3D val8 | 0x01;
> - / enable VSPS12 LDO Macro block /
> - r8712_write8(adapter, SPS1_CTRL, val8);
> - val8 =3D r8712_read8(adapter, AFE_MISC);
> - val8 =3D val8 | 0x01;
> - / Enable AFE Macro Block's Bandgap /
> - r8712_write8(adapter, AFE_MISC, val8);
> - val8 =3D r8712_read8(adapter, LDOA15_CTRL);
> - val8 =3D val8 | 0x01;
> - / enable LDOA15 block /
> - r8712_write8(adapter, LDOA15_CTRL, val8);
> - val8 =3D r8712_read8(adapter, SPS1_CTRL);
> - val8 =3D val8 | 0x02;
> - / Enable VSPS12_SW Macro Block /
> - r8712_write8(adapter, SPS1_CTRL, val8);
> - val8 =3D r8712_read8(adapter, AFE_MISC);
> - val8 =3D val8 | 0x02;
> - / Enable AFE Macro Block's Mbias /
> - r8712_write8(adapter, AFE_MISC, val8);
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL + 1);
> - val8 =3D val8 | 0x08;
> - / isolate PCIe Analog 1.2V to PCIe 3.3V and PCIE Digital /
> - r8712_write8(adapter, SYS_ISO_CTRL + 1, val8);
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL + 1);
> - val8 =3D val8 & 0xEF;
> - / attach AFE PLL to MACTOP/BB/PCIe Digital /
> - r8712_write8(adapter, SYS_ISO_CTRL + 1, val8);
> - val8 =3D r8712_read8(adapter, AFE_XTAL_CTRL + 1);
> - val8 =3D val8 & 0xFB;
> - / enable AFE clock /
> - r8712_write8(adapter, AFE_XTAL_CTRL + 1, val8);
> - val8 =3D r8712_read8(adapter, AFE_PLL_CTRL);
> - val8 =3D val8 | 0x01;
> - / Enable AFE PLL Macro Block /
> - r8712_write8(adapter, AFE_PLL_CTRL, val8);
> - val8 =3D 0xEE;
> - / release isolation AFE PLL & MD /
> - r8712_write8(adapter, SYS_ISO_CTRL, val8);
> - val8 =3D r8712_read8(adapter, SYS_CLKR + 1);
> - val8 =3D val8 | 0x08;
> - / enable MAC clock /
> - r8712_write8(adapter, SYS_CLKR + 1, val8);
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - val8 =3D val8 | 0x08;
> - / enable Core digital and enable IOREG R/W /
> - r8712_write8(adapter, SYS_FUNC_EN + 1, val8);
> - val8 =3D val8 | 0x80;
> - / enable REG_EN /
> - r8712_write8(adapter, SYS_FUNC_EN + 1, val8);
> - val8 =3D r8712_read8(adapter, SYS_CLKR + 1);
> - val8 =3D (val8 | 0x80) & 0xBF;
> - / switch the control path /
> - r8712_write8(adapter, SYS_CLKR + 1, val8);
> - val8 =3D 0xFC;
> - r8712_write8(adapter, CR, val8);
> - val8 =3D 0x37;
> - r8712_write8(adapter, CR + 1, val8);
> - / reduce EndPoint & init it /
> - r8712_write8(adapter, 0x102500ab, r8712_read8(adapter,
> - 0x102500ab) | BIT(6) | BIT(7));
> - / consideration of power consumption - init */
> - r8712_write8(adapter, 0x10250008, r8712_read8(adapter,
> - 0x10250008) & 0xfffffffb);
> - } else if (registrypriv->chip_version =3D=3D RTL8712_1stCUT) {
>=20
> - /* Initialization for power on sequence, /
> - r8712_write8(adapter, SPS0_CTRL + 1, 0x53);
> - r8712_write8(adapter, SPS0_CTRL, 0x57);
> - / Enable AFE Macro Block's Bandgap and Enable AFE Macro
> - * Block's Mbias
> - /
> - val8 =3D r8712_read8(adapter, AFE_MISC);
> - r8712_write8(adapter, AFE_MISC, (val8 | AFE_MISC_BGEN |
> - AFE_MISC_MBEN));
> - / Enable LDOA15 block /
> - val8 =3D r8712_read8(adapter, LDOA15_CTRL);
> - r8712_write8(adapter, LDOA15_CTRL, (val8 | LDA15_EN));
> - val8 =3D r8712_read8(adapter, SPS1_CTRL);
> - r8712_write8(adapter, SPS1_CTRL, (val8 | SPS1_LDEN));
> - msleep(20);
> - / Enable Switch Regulator Block /
> - val8 =3D r8712_read8(adapter, SPS1_CTRL);
> - r8712_write8(adapter, SPS1_CTRL, (val8 | SPS1_SWEN));
> - r8712_write32(adapter, SPS1_CTRL, 0x00a7b267);
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL + 1);
> - r8712_write8(adapter, SYS_ISO_CTRL + 1, (val8 | 0x08));
> - / Engineer Packet CP test Enable /
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - r8712_write8(adapter, SYS_FUNC_EN + 1, (val8 | 0x20));
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL + 1);
> - r8712_write8(adapter, SYS_ISO_CTRL + 1, (val8 & 0x6F));
> - / Enable AFE clock /
> - val8 =3D r8712_read8(adapter, AFE_XTAL_CTRL + 1);
> - r8712_write8(adapter, AFE_XTAL_CTRL + 1, (val8 & 0xfb));
> - / Enable AFE PLL Macro Block /
> - val8 =3D r8712_read8(adapter, AFE_PLL_CTRL);
> - r8712_write8(adapter, AFE_PLL_CTRL, (val8 | 0x11));
> - / Attach AFE PLL to MACTOP/BB/PCIe Digital /
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL);
> - r8712_write8(adapter, SYS_ISO_CTRL, (val8 & 0xEE));
> - / Switch to 40M clock /
> - val8 =3D r8712_read8(adapter, SYS_CLKR);
> - r8712_write8(adapter, SYS_CLKR, val8 & (~SYS_CLKSEL));
> - / SSC Disable /
> - val8 =3D r8712_read8(adapter, SYS_CLKR);
> - / Enable MAC clock /
> - val8 =3D r8712_read8(adapter, SYS_CLKR + 1);
> - r8712_write8(adapter, SYS_CLKR + 1, (val8 | 0x18));
> - / Revised POS, /
> - r8712_write8(adapter, PMC_FSM, 0x02);
> - / Enable Core digital and enable IOREG R/W /
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - r8712_write8(adapter, SYS_FUNC_EN + 1, (val8 | 0x08));
> - / Enable REG_EN /
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - r8712_write8(adapter, SYS_FUNC_EN + 1, (val8 | 0x80));
> - / Switch the control path to FW /
> - val8 =3D r8712_read8(adapter, SYS_CLKR + 1);
> - r8712_write8(adapter, SYS_CLKR + 1, (val8 | 0x80) & 0xBF);
> - r8712_write8(adapter, CR, 0xFC);
> - r8712_write8(adapter, CR + 1, 0x37);
> - / Fix the RX FIFO issue(usb error), /
> - val8 =3D r8712_read8(adapter, 0x1025FE5c);
> - r8712_write8(adapter, 0x1025FE5c, (val8 | BIT(7)));
> - val8 =3D r8712_read8(adapter, 0x102500ab);
> - r8712_write8(adapter, 0x102500ab, (val8 | BIT(6) | BIT(7)));
> - / For power save, used this in the bit file after 970621 */
> - val8 =3D r8712_read8(adapter, SYS_CLKR);
> - r8712_write8(adapter, SYS_CLKR, val8 & (~CPU_CLKSEL));
> - } else if (registrypriv->chip_version =3D=3D RTL8712_2ndCUT ||
>=20
> - registrypriv->chip_version =3D=3D RTL8712_3rdCUT) {
>=20
> - /* Initialization for power on sequence,
> - * E-Fuse leakage prevention sequence
> - /
> - r8712_write8(adapter, 0x37, 0xb0);
> - msleep(20);
> - r8712_write8(adapter, 0x37, 0x30);
> - / Set control path switch to HW control and reset Digital Core,
> - * CPU Core and MAC I/O to solve FW download fail when system
> - * from resume sate.
> - /
> - val8 =3D r8712_read8(adapter, SYS_CLKR + 1);
> - if (val8 & 0x80) {
> - val8 &=3D 0x3f;
> - r8712_write8(adapter, SYS_CLKR + 1, val8);
> - }
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - val8 &=3D 0x73;
> - r8712_write8(adapter, SYS_FUNC_EN + 1, val8);
> - msleep(20);
> - / Revised POS, /
> - / Enable AFE Macro Block's Bandgap and Enable AFE Macro
> - * Block's Mbias
> - /
> - r8712_write8(adapter, SPS0_CTRL + 1, 0x53);
> - r8712_write8(adapter, SPS0_CTRL, 0x57);
> - val8 =3D r8712_read8(adapter, AFE_MISC);
> - /Bandgap/
> - r8712_write8(adapter, AFE_MISC, (val8 | AFE_MISC_BGEN));
> - r8712_write8(adapter, AFE_MISC, (val8 | AFE_MISC_BGEN |
> - AFE_MISC_MBEN | AFE_MISC_I32_EN));
> - / Enable PLL Power (LDOA15V) /
> - val8 =3D r8712_read8(adapter, LDOA15_CTRL);
> - r8712_write8(adapter, LDOA15_CTRL, (val8 | LDA15_EN));
> - / Enable LDOV12D block /
> - val8 =3D r8712_read8(adapter, LDOV12D_CTRL);
> - r8712_write8(adapter, LDOV12D_CTRL, (val8 | LDV12_EN));
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL + 1);
> - r8712_write8(adapter, SYS_ISO_CTRL + 1, (val8 | 0x08));
> - / Engineer Packet CP test Enable /
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - r8712_write8(adapter, SYS_FUNC_EN + 1, (val8 | 0x20));
> - / Support 64k IMEM /
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL + 1);
> - r8712_write8(adapter, SYS_ISO_CTRL + 1, (val8 & 0x68));
> - / Enable AFE clock /
> - val8 =3D r8712_read8(adapter, AFE_XTAL_CTRL + 1);
> - r8712_write8(adapter, AFE_XTAL_CTRL + 1, (val8 & 0xfb));
> - / Enable AFE PLL Macro Block /
> - val8 =3D r8712_read8(adapter, AFE_PLL_CTRL);
> - r8712_write8(adapter, AFE_PLL_CTRL, (val8 | 0x11));
> - / Some sample will download fw failure. The clock will be
> - * stable with 500 us delay after reset the PLL
> - * TODO: When usleep is added to kernel, change next 3
> - * udelay(500) to usleep(500)
> - /
> - udelay(500);
> - r8712_write8(adapter, AFE_PLL_CTRL, (val8 | 0x51));
> - udelay(500);
> - r8712_write8(adapter, AFE_PLL_CTRL, (val8 | 0x11));
> - udelay(500);
> - / Attach AFE PLL to MACTOP/BB/PCIe Digital /
> - val8 =3D r8712_read8(adapter, SYS_ISO_CTRL);
> - r8712_write8(adapter, SYS_ISO_CTRL, (val8 & 0xEE));
> - / Switch to 40M clock /
> - r8712_write8(adapter, SYS_CLKR, 0x00);
> - / CPU Clock and 80M Clock SSC Disable to overcome FW download
> - * fail timing issue.
> - /
> - val8 =3D r8712_read8(adapter, SYS_CLKR);
> - r8712_write8(adapter, SYS_CLKR, (val8 | 0xa0));
> - / Enable MAC clock /
> - val8 =3D r8712_read8(adapter, SYS_CLKR + 1);
> - r8712_write8(adapter, SYS_CLKR + 1, (val8 | 0x18));
> - / Revised POS, /
> - r8712_write8(adapter, PMC_FSM, 0x02);
> - / Enable Core digital and enable IOREG R/W /
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - r8712_write8(adapter, SYS_FUNC_EN + 1, (val8 | 0x08));
> - / Enable REG_EN /
> - val8 =3D r8712_read8(adapter, SYS_FUNC_EN + 1);
> - r8712_write8(adapter, SYS_FUNC_EN + 1, (val8 | 0x80));
> - / Switch the control path to FW /
> - val8 =3D r8712_read8(adapter, SYS_CLKR + 1);
> - r8712_write8(adapter, SYS_CLKR + 1, (val8 | 0x80) & 0xBF);
> - r8712_write8(adapter, CR, 0xFC);
> - r8712_write8(adapter, CR + 1, 0x37);
> - / Fix the RX FIFO issue(usb error), 970410 /
> - val8 =3D r8712_read8(adapter, 0x1025FE5c);
> - r8712_write8(adapter, 0x1025FE5c, (val8 | BIT(7)));
> - / For power save, used this in the bit file after 970621 /
> - val8 =3D r8712_read8(adapter, SYS_CLKR);
> - r8712_write8(adapter, SYS_CLKR, val8 & (~CPU_CLKSEL));
> - / Revised for 8051 ROM code wrong operation. /
> - r8712_write8(adapter, 0x1025fe1c, 0x80);
> - / To make sure that TxDMA can ready to download FW.
> - * We should reset TxDMA if IMEM RPT was not ready.
> - /
> - do {
> - val8 =3D r8712_read8(adapter, TCR);
> - if ((val8 & _TXDMA_INIT_VALUE) =3D=3D _TXDMA_INIT_VALUE)
> - break;
> - udelay(5); / PlatformStallExecution(5); /
> - } while (PollingCnt--); / Delay 1ms /
> -
> - if (PollingCnt <=3D 0) {
> - val8 =3D r8712_read8(adapter, CR);
> - r8712_write8(adapter, CR, val8 & (~_TXDMA_EN));
> - udelay(2); / PlatformStallExecution(2); /
> - / Reset TxDMA */
> - r8712_write8(adapter, CR, val8 | _TXDMA_EN);
> - }
> - } else {
> - ret =3D _FAIL;
> - }
> - return ret;
> -}
> -
> -unsigned int r8712_usb_inirp_init(struct _adapter *adapter)
> -{
> - u8 i;
> - struct recv_buf *recvbuf;
> - struct intf_hdl *intfhdl =3D &adapter->pio_queue->intf;
>=20
> - struct recv_priv *recvpriv =3D &adapter->recvpriv;
>=20
> -
> - recvpriv->ff_hwaddr =3D RTL8712_DMA_RX0FF; /* mapping rx fifo address *=
/
>=20
> - /* issue Rx irp to receive data */
> - recvbuf =3D (struct recv_buf *)recvpriv->precv_buf;
>=20
> - for (i =3D 0; i < NR_RECVBUFF; i++) {
> - if (r8712_usb_read_port(intfhdl, recvpriv->ff_hwaddr, 0,
>=20
> - (unsigned char *)recvbuf) =3D=3D false)
> - return _FAIL;
> - recvbuf++;
> - recvpriv->free_recv_buf_queue_cnt--;
>=20
> - }
> - return _SUCCESS;
> -}
> -
> -unsigned int r8712_usb_inirp_deinit(struct _adapter adapter)
> -{
> - r8712_usb_read_port_cancel(adapter);
> - return _SUCCESS;
> -}
> diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712=
/usb_intf.c
> deleted file mode 100644
> index df05213f922f..000000000000
> --- a/drivers/staging/rtl8712/usb_intf.c
> +++ /dev/null
> @@ -1,638 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************************************=
******
> - * usb_intf.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define HCI_INTF_C
> -
> -#include <linux/usb.h>
>=20
> -#include <linux/module.h>
>=20
> -#include <linux/firmware.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "recv_osdep.h"
> -#include "xmit_osdep.h"
> -#include "rtl8712_efuse.h"
> -#include "usb_ops.h"
> -#include "usb_osintf.h"
> -
> -static struct usb_interface *pintf;
> -
> -static int r871xu_drv_init(struct usb_interface *pusb_intf,
> - const struct usb_device_id *pdid);
> -
> -static void r871xu_dev_remove(struct usb_interface pusb_intf);
> -
> -static const struct usb_device_id rtl871x_usb_id_tbl[] =3D {
> -/ RTL8188SU /
> - / Realtek /
> - {USB_DEVICE(0x0BDA, 0x8171)},
> - {USB_DEVICE(0x0bda, 0x8173)},
> - {USB_DEVICE(0x0bda, 0x8712)},
> - {USB_DEVICE(0x0bda, 0x8713)},
> - {USB_DEVICE(0x0bda, 0xC512)},
> - / Abocom /
> - {USB_DEVICE(0x07B8, 0x8188)},
> - / ASUS /
> - {USB_DEVICE(0x0B05, 0x1786)},
> - {USB_DEVICE(0x0B05, 0x1791)}, / 11n mode disable /
> - / Belkin /
> - {USB_DEVICE(0x050D, 0x945A)},
> - / ISY IWL - Belkin clone /
> - {USB_DEVICE(0x050D, 0x11F1)},
> - / Corega /
> - {USB_DEVICE(0x07AA, 0x0047)},
> - / D-Link /
> - {USB_DEVICE(0x2001, 0x3306)},
> - {USB_DEVICE(0x07D1, 0x3306)}, / 11n mode disable /
> - / Edimax /
> - {USB_DEVICE(0x7392, 0x7611)},
> - / EnGenius /
> - {USB_DEVICE(0x1740, 0x9603)},
> - / Hawking /
> - {USB_DEVICE(0x0E66, 0x0016)},
> - / Hercules /
> - {USB_DEVICE(0x06F8, 0xE034)},
> - {USB_DEVICE(0x06F8, 0xE032)},
> - / Logitec /
> - {USB_DEVICE(0x0789, 0x0167)},
> - / PCI /
> - {USB_DEVICE(0x2019, 0xAB28)},
> - {USB_DEVICE(0x2019, 0xED16)},
> - / Sitecom /
> - {USB_DEVICE(0x0DF6, 0x0057)},
> - {USB_DEVICE(0x0DF6, 0x0045)},
> - {USB_DEVICE(0x0DF6, 0x0059)}, / 11n mode disable /
> - {USB_DEVICE(0x0DF6, 0x004B)},
> - {USB_DEVICE(0x0DF6, 0x005B)},
> - {USB_DEVICE(0x0DF6, 0x005D)},
> - {USB_DEVICE(0x0DF6, 0x0063)},
> - / Sweex /
> - {USB_DEVICE(0x177F, 0x0154)},
> - / Thinkware /
> - {USB_DEVICE(0x0BDA, 0x5077)},
> - / Toshiba /
> - {USB_DEVICE(0x1690, 0x0752)},
> - / - /
> - {USB_DEVICE(0x20F4, 0x646B)},
> - {USB_DEVICE(0x083A, 0xC512)},
> - {USB_DEVICE(0x25D4, 0x4CA1)},
> - {USB_DEVICE(0x25D4, 0x4CAB)},
> -
> -/ RTL8191SU /
> - / Realtek /
> - {USB_DEVICE(0x0BDA, 0x8172)},
> - {USB_DEVICE(0x0BDA, 0x8192)},
> - / Amigo /
> - {USB_DEVICE(0x0EB0, 0x9061)},
> - / ASUS/EKB /
> - {USB_DEVICE(0x13D3, 0x3323)},
> - {USB_DEVICE(0x13D3, 0x3311)}, / 11n mode disable /
> - {USB_DEVICE(0x13D3, 0x3342)},
> - / ASUS/EKBLenovo /
> - {USB_DEVICE(0x13D3, 0x3333)},
> - {USB_DEVICE(0x13D3, 0x3334)},
> - {USB_DEVICE(0x13D3, 0x3335)}, / 11n mode disable /
> - {USB_DEVICE(0x13D3, 0x3336)}, / 11n mode disable /
> - / ASUS/Media BOX /
> - {USB_DEVICE(0x13D3, 0x3309)},
> - / Belkin /
> - {USB_DEVICE(0x050D, 0x815F)},
> - / D-Link /
> - {USB_DEVICE(0x07D1, 0x3302)},
> - {USB_DEVICE(0x07D1, 0x3300)},
> - {USB_DEVICE(0x07D1, 0x3303)},
> - / Edimax /
> - {USB_DEVICE(0x7392, 0x7612)},
> - / EnGenius /
> - {USB_DEVICE(0x1740, 0x9605)},
> - / Guillemot /
> - {USB_DEVICE(0x06F8, 0xE031)},
> - / Hawking /
> - {USB_DEVICE(0x0E66, 0x0015)},
> - / Mediao /
> - {USB_DEVICE(0x13D3, 0x3306)},
> - / PCI /
> - {USB_DEVICE(0x2019, 0xED18)},
> - {USB_DEVICE(0x2019, 0x4901)},
> - / Sitecom /
> - {USB_DEVICE(0x0DF6, 0x0058)},
> - {USB_DEVICE(0x0DF6, 0x0049)},
> - {USB_DEVICE(0x0DF6, 0x004C)},
> - {USB_DEVICE(0x0DF6, 0x006C)},
> - {USB_DEVICE(0x0DF6, 0x0064)},
> - / Skyworth /
> - {USB_DEVICE(0x14b2, 0x3300)},
> - {USB_DEVICE(0x14b2, 0x3301)},
> - {USB_DEVICE(0x14B2, 0x3302)},
> - / - /
> - {USB_DEVICE(0x04F2, 0xAFF2)},
> - {USB_DEVICE(0x04F2, 0xAFF5)},
> - {USB_DEVICE(0x04F2, 0xAFF6)},
> - {USB_DEVICE(0x13D3, 0x3339)},
> - {USB_DEVICE(0x13D3, 0x3340)}, / 11n mode disable /
> - {USB_DEVICE(0x13D3, 0x3341)}, / 11n mode disable /
> - {USB_DEVICE(0x13D3, 0x3310)},
> - {USB_DEVICE(0x13D3, 0x3325)},
> -
> -/ RTL8192SU /
> - / Realtek /
> - {USB_DEVICE(0x0BDA, 0x8174)},
> - / Belkin /
> - {USB_DEVICE(0x050D, 0x845A)},
> - / Corega /
> - {USB_DEVICE(0x07AA, 0x0051)},
> - / Edimax /
> - {USB_DEVICE(0x7392, 0x7622)},
> - / NEC */
> - {USB_DEVICE(0x0409, 0x02B6)},
> - {}
> -};
> -
> -MODULE_DEVICE_TABLE(usb, rtl871x_usb_id_tbl);
> -
> -static struct specific_device_id specific_device_id_tbl[] =3D {
> - {.idVendor =3D 0x0b05, .idProduct =3D 0x1791,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {.idVendor =3D 0x0df6, .idProduct =3D 0x0059,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {.idVendor =3D 0x13d3, .idProduct =3D 0x3306,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {.idVendor =3D 0x13D3, .idProduct =3D 0x3311,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {.idVendor =3D 0x13d3, .idProduct =3D 0x3335,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {.idVendor =3D 0x13d3, .idProduct =3D 0x3336,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {.idVendor =3D 0x13d3, .idProduct =3D 0x3340,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {.idVendor =3D 0x13d3, .idProduct =3D 0x3341,
> - .flags =3D SPEC_DEV_ID_DISABLE_HT},
> - {}
> -};
> -
> -struct drv_priv {
> - struct usb_driver r871xu_drv;
> - int drv_registered;
> -};
> -
> -#ifdef CONFIG_PM
> -static int r871x_suspend(struct usb_interface *pusb_intf, pm_message_t s=
tate)
> -{
> - struct net_device *pnetdev =3D usb_get_intfdata(pusb_intf);
> - struct _adapter *padapter =3D netdev_priv(pnetdev);
> -
> - netdev_info(pnetdev, "Suspending...\n");
> - padapter->suspended =3D true;
>=20
> - rtl871x_intf_stop(padapter);
> - if (pnetdev->netdev_ops->ndo_stop)
>=20
> - pnetdev->netdev_ops->ndo_stop(pnetdev);
>=20
> - mdelay(10);
> - netif_device_detach(pnetdev);
> - return 0;
> -}
> -
> -static void rtl871x_intf_resume(struct _adapter *padapter)
> -{
> - if (padapter->dvobjpriv.inirp_init)
>=20
> - padapter->dvobjpriv.inirp_init(padapter);
>=20
> -}
> -
> -static int r871x_resume(struct usb_interface *pusb_intf)
> -{
> - struct net_device *pnetdev =3D usb_get_intfdata(pusb_intf);
> - struct _adapter *padapter =3D netdev_priv(pnetdev);
> -
> - netdev_info(pnetdev, "Resuming...\n");
> - netif_device_attach(pnetdev);
> - if (pnetdev->netdev_ops->ndo_open)
>=20
> - pnetdev->netdev_ops->ndo_open(pnetdev);
>=20
> - padapter->suspended =3D false;
>=20
> - rtl871x_intf_resume(padapter);
> - return 0;
> -}
> -#endif
> -
> -static struct drv_priv drvpriv =3D {
> - .r871xu_drv.name =3D "r8712u",
> - .r871xu_drv.id_table =3D rtl871x_usb_id_tbl,
> - .r871xu_drv.probe =3D r871xu_drv_init,
> - .r871xu_drv.disconnect =3D r871xu_dev_remove,
> -#ifdef CONFIG_PM
> - .r871xu_drv.suspend =3D r871x_suspend,
> - .r871xu_drv.resume =3D r871x_resume,
> -#endif
> -};
> -
> -static uint r8712_usb_dvobj_init(struct _adapter *padapter)
> -{
> - uint status =3D _SUCCESS;
> - struct usb_host_interface *phost_iface;
> - struct usb_interface_descriptor *piface_desc;
> - struct dvobj_priv *pdvobjpriv =3D &padapter->dvobjpriv;
>=20
> - struct usb_device *pusbd =3D pdvobjpriv->pusbdev;
>=20
> -
> - pdvobjpriv->padapter =3D padapter;
>=20
> - padapter->eeprom_address_size =3D 6;
>=20
> - phost_iface =3D pintf->cur_altsetting;
>=20
> - piface_desc =3D &phost_iface->desc;
>=20
> - pdvobjpriv->nr_endpoint =3D piface_desc->bNumEndpoints;
>=20
> - if (pusbd->speed =3D=3D USB_SPEED_HIGH) {
>=20
> - pdvobjpriv->ishighspeed =3D true;
>=20
> - dev_info(&pusbd->dev, "r8712u: USB_SPEED_HIGH with %d endpoints\n",
>=20
> - pdvobjpriv->nr_endpoint);
>=20
> - } else {
> - pdvobjpriv->ishighspeed =3D false;
>=20
> - dev_info(&pusbd->dev, "r8712u: USB_SPEED_LOW with %d endpoints\n",
>=20
> - pdvobjpriv->nr_endpoint);
>=20
> - }
> - if ((r8712_alloc_io_queue(padapter)) =3D=3D _FAIL)
> - status =3D _FAIL;
> - return status;
> -}
> -
> -static void r8712_usb_dvobj_deinit(struct _adapter *padapter)
> -{
> - r8712_free_io_queue(padapter);
> -}
> -
> -void rtl871x_intf_stop(struct _adapter *padapter)
> -{
> - /disable_hw_interrupt/
> - if (!padapter->surprise_removed) {
>=20
> - /*device still exists, so driver can do i/o operation
> - * TODO:
> - /
> - }
> -
> - / cancel in irp */
> - if (padapter->dvobjpriv.inirp_deinit)
>=20
> - padapter->dvobjpriv.inirp_deinit(padapter);
>=20
> - /* cancel out irp /
> - r8712_usb_write_port_cancel(padapter);
> - / TODO:cancel other irps */
> -}
> -
> -void r871x_dev_unload(struct _adapter *padapter)
> -{
> - if (padapter->bup) {
>=20
> - /s1./
> - padapter->driver_stopped =3D true;
>=20
> -
> - /s3./
> - rtl871x_intf_stop(padapter);
> -
> - /s4./
> - r8712_stop_drv_threads(padapter);
> -
> - /s5./
> - if (!padapter->surprise_removed) {
>=20
> - padapter->hw_init_completed =3D false;
>=20
> - rtl8712_hal_deinit(padapter);
> - }
> -
> - padapter->bup =3D false;
>=20
> - }
> -}
> -
> -static void disable_ht_for_spec_devid(const struct usb_device_id *pdid,
> - struct _adapter *padapter)
> -{
> - u16 vid, pid;
> - u32 flags;
> - int i;
> - int num =3D ARRAY_SIZE(specific_device_id_tbl);
> -
> - for (i =3D 0; i < num; i++) {
> - vid =3D specific_device_id_tbl[i].idVendor;
> - pid =3D specific_device_id_tbl[i].idProduct;
> - flags =3D specific_device_id_tbl[i].flags;
> -
> - if ((pdid->idVendor =3D=3D vid) && (pdid->idProduct =3D=3D pid) &&
>=20
> - (flags & SPEC_DEV_ID_DISABLE_HT)) {
> - padapter->registrypriv.ht_enable =3D 0;
>=20
> - padapter->registrypriv.cbw40_enable =3D 0;
>=20
> - padapter->registrypriv.ampdu_enable =3D 0;
>=20
> - }
> - }
> -}
> -
> -static const struct device_type wlan_type =3D {
> - .name =3D "wlan",
> -};
> -
> -/*
> - * drv_init() - a device potentially for us
> - *
> - * notes: drv_init() is called when the bus driver has located a card fo=
r us
> - * to support. We accept the new device by returning 0.
> - */
> -static int r871xu_drv_init(struct usb_interface *pusb_intf,
> - const struct usb_device_id *pdid)
> -{
> - uint status;
> - struct _adapter *padapter =3D NULL;
> - struct dvobj_priv *pdvobjpriv;
> - struct net_device *pnetdev;
> - struct usb_device udev;
> -
> - / In this probe function, O.S. will provide the usb interface pointer
> - * to driver. We have to increase the reference count of the usb device
> - * structure by using the usb_get_dev function.
> - /
> - udev =3D interface_to_usbdev(pusb_intf);
> - usb_get_dev(udev);
> - pintf =3D pusb_intf;
> - / step 1. */
> - pnetdev =3D r8712_init_netdev();
> - if (!pnetdev)
> - goto put_dev;
> - padapter =3D netdev_priv(pnetdev);
> - disable_ht_for_spec_devid(pdid, padapter);
> - pdvobjpriv =3D &padapter->dvobjpriv;
>=20
> - pdvobjpriv->padapter =3D padapter;
>=20
> - padapter->dvobjpriv.pusbdev =3D udev;
>=20
> - padapter->pusb_intf =3D pusb_intf;
>=20
> - usb_set_intfdata(pusb_intf, pnetdev);
> - SET_NETDEV_DEV(pnetdev, &pusb_intf->dev);
>=20
> - pnetdev->dev.type =3D &wlan_type;
>=20
> - /* step 2. */
> - padapter->dvobj_init =3D r8712_usb_dvobj_init;
>=20
> - padapter->dvobj_deinit =3D r8712_usb_dvobj_deinit;
>=20
> - padapter->halpriv.hal_bus_init =3D r8712_usb_hal_bus_init;
>=20
> - padapter->dvobjpriv.inirp_init =3D r8712_usb_inirp_init;
>=20
> - padapter->dvobjpriv.inirp_deinit =3D r8712_usb_inirp_deinit;
>=20
> - /* step 3.
> - * initialize the dvobj_priv
> - */
> -
> - status =3D padapter->dvobj_init(padapter);
>=20
> - if (status !=3D _SUCCESS)
> - goto free_netdev;
> -
> - /* step 4. /
> - status =3D r8712_init_drv_sw(padapter);
> - if (status)
> - goto dvobj_deinit;
> - / step 5. read efuse/eeprom data and get mac_addr */
> - {
> - int i, offset;
> - u8 mac[6];
> - u8 tmpU1b, AutoloadFail, eeprom_CustomerID;
> - u8 *pdata =3D padapter->eeprompriv.efuse_eeprom_data;
>=20
> -
> - tmpU1b =3D r8712_read8(padapter, EE_9346CR);/CR9346/
> -
> - /* To check system boot selection.*/
> - dev_info(&udev->dev, "r8712u: Boot from %s: Autoload %s\n",
>=20
> - (tmpU1b & _9356SEL) ? "EEPROM" : "EFUSE",
> - (tmpU1b & _EEPROM_EN) ? "OK" : "Failed");
> -
> - /* To check autoload success or not./
> - if (tmpU1b & _EEPROM_EN) {
> - AutoloadFail =3D true;
> - / The following operations prevent Efuse leakage by
> - * turning on 2.5V.
> - /
> - tmpU1b =3D r8712_read8(padapter, EFUSE_TEST + 3);
> - r8712_write8(padapter, EFUSE_TEST + 3, tmpU1b | 0x80);
> - msleep(20);
> - r8712_write8(padapter, EFUSE_TEST + 3,
> - (tmpU1b & (~BIT(7))));
> -
> - / Retrieve Chip version.
> - * Recognize IC version by Reg0x4 BIT15.
> - */
> - tmpU1b =3D (u8)((r8712_read32(padapter, PMC_FSM) >> 15) &
>=20
> - 0x1F);
> - if (tmpU1b =3D=3D 0x3)
> - padapter->registrypriv.chip_version =3D
>=20
> - RTL8712_3rdCUT;
> - else
> - padapter->registrypriv.chip_version =3D
>=20
> - (tmpU1b >> 1) + 1;
>=20
> - switch (padapter->registrypriv.chip_version) {
>=20
> - case RTL8712_1stCUT:
> - case RTL8712_2ndCUT:
> - case RTL8712_3rdCUT:
> - break;
> - default:
> - padapter->registrypriv.chip_version =3D
>=20
> - RTL8712_2ndCUT;
> - break;
> - }
> -
> - for (i =3D 0, offset =3D 0; i < 128; i +=3D 8, offset++)
> - r8712_efuse_pg_packet_read(padapter, offset,
> - &pdata[i]);
> -
> - if (!r8712_initmac || !mac_pton(r8712_initmac, mac)) {
> - /* Use the mac address stored in the Efuse
> - * offset =3D 0x12 for usb in efuse
> - */
> - ether_addr_copy(mac, &pdata[0x12]);
> - }
> - eeprom_CustomerID =3D pdata[0x52];
> - switch (eeprom_CustomerID) {
> - case EEPROM_CID_ALPHA:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_ALPHA;
> - break;
> - case EEPROM_CID_CAMEO:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_CAMEO;
> - break;
> - case EEPROM_CID_SITECOM:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_Sitecom;
> - break;
> - case EEPROM_CID_COREGA:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_COREGA;
> - break;
> - case EEPROM_CID_Senao:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_Senao;
> - break;
> - case EEPROM_CID_EDIMAX_BELKIN:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_Edimax_Belkin;
> - break;
> - case EEPROM_CID_SERCOMM_BELKIN:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_Sercomm_Belkin;
> - break;
> - case EEPROM_CID_WNC_COREGA:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_WNC_COREGA;
> - break;
> - case EEPROM_CID_WHQL:
> - break;
> - case EEPROM_CID_NetCore:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_Netcore;
> - break;
> - case EEPROM_CID_CAMEO1:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_CAMEO1;
> - break;
> - case EEPROM_CID_CLEVO:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_819x_CLEVO;
> - break;
> - default:
> - padapter->eeprompriv.CustomerID =3D
>=20
> - RT_CID_DEFAULT;
> - break;
> - }
> - dev_info(&udev->dev, "r8712u: CustomerID =3D 0x%.4x\n",
>=20
> - padapter->eeprompriv.CustomerID);
>=20
> - /* Led mode */
> - switch (padapter->eeprompriv.CustomerID) {
>=20
> - case RT_CID_DEFAULT:
> - case RT_CID_819x_ALPHA:
> - case RT_CID_819x_CAMEO:
> - padapter->ledpriv.LedStrategy =3D SW_LED_MODE1;
>=20
> - padapter->ledpriv.bRegUseLed =3D true;
>=20
> - break;
> - case RT_CID_819x_Sitecom:
> - padapter->ledpriv.LedStrategy =3D SW_LED_MODE2;
>=20
> - padapter->ledpriv.bRegUseLed =3D true;
>=20
> - break;
> - case RT_CID_COREGA:
> - case RT_CID_819x_Senao:
> - padapter->ledpriv.LedStrategy =3D SW_LED_MODE3;
>=20
> - padapter->ledpriv.bRegUseLed =3D true;
>=20
> - break;
> - case RT_CID_819x_Edimax_Belkin:
> - padapter->ledpriv.LedStrategy =3D SW_LED_MODE4;
>=20
> - padapter->ledpriv.bRegUseLed =3D true;
>=20
> - break;
> - case RT_CID_819x_Sercomm_Belkin:
> - padapter->ledpriv.LedStrategy =3D SW_LED_MODE5;
>=20
> - padapter->ledpriv.bRegUseLed =3D true;
>=20
> - break;
> - case RT_CID_819x_WNC_COREGA:
> - padapter->ledpriv.LedStrategy =3D SW_LED_MODE6;
>=20
> - padapter->ledpriv.bRegUseLed =3D true;
>=20
> - break;
> - default:
> - padapter->ledpriv.LedStrategy =3D SW_LED_MODE0;
>=20
> - padapter->ledpriv.bRegUseLed =3D false;
>=20
> - break;
> - }
> - } else {
> - AutoloadFail =3D false;
> - }
> - if ((!AutoloadFail) ||
> - ((mac[0] =3D=3D 0xff) && (mac[1] =3D=3D 0xff) &&
> - (mac[2] =3D=3D 0xff) && (mac[3] =3D=3D 0xff) &&
> - (mac[4] =3D=3D 0xff) && (mac[5] =3D=3D 0xff)) ||
> - ((mac[0] =3D=3D 0x00) && (mac[1] =3D=3D 0x00) &&
> - (mac[2] =3D=3D 0x00) && (mac[3] =3D=3D 0x00) &&
> - (mac[4] =3D=3D 0x00) && (mac[5] =3D=3D 0x00))) {
> - mac[0] =3D 0x00;
> - mac[1] =3D 0xe0;
> - mac[2] =3D 0x4c;
> - mac[3] =3D 0x87;
> - mac[4] =3D 0x00;
> - mac[5] =3D 0x00;
> - }
> - if (r8712_initmac) {
> - /* Make sure the user did not select a multicast
> - * address by setting bit 1 of first octet.
> - */
> - mac[0] &=3D 0xFE;
> - dev_info(&udev->dev,
>=20
> - "r8712u: MAC Address from user =3D %pM\n", mac);
> - } else {
> - dev_info(&udev->dev,
>=20
> - "r8712u: MAC Address from efuse =3D %pM\n", mac);
> - }
> - eth_hw_addr_set(pnetdev, mac);
> - }
> - /* step 6. Load the firmware asynchronously */
> - if (rtl871x_load_fw(padapter))
> - goto deinit_drv_sw;
> - init_completion(&padapter->rx_filter_ready);
>=20
> - return 0;
> -
> -deinit_drv_sw:
> - r8712_free_drv_sw(padapter);
> -dvobj_deinit:
> - padapter->dvobj_deinit(padapter);
>=20
> -free_netdev:
> - free_netdev(pnetdev);
> -put_dev:
> - usb_put_dev(udev);
> - usb_set_intfdata(pusb_intf, NULL);
> - return -ENODEV;
> -}
> -
> -/* rmmod module & unplug(SurpriseRemoved) will call r871xu_dev_remove()
> - * =3D> how to recognize both
>=20
> - */
> -static void r871xu_dev_remove(struct usb_interface *pusb_intf)
> -{
> - struct net_device *pnetdev =3D usb_get_intfdata(pusb_intf);
> - struct usb_device *udev =3D interface_to_usbdev(pusb_intf);
> - struct _adapter padapter =3D netdev_priv(pnetdev);
> -
> - / never exit with a firmware callback pending */
> - wait_for_completion(&padapter->rtl8712_fw_ready);
>=20
> - if (pnetdev->reg_state !=3D NETREG_UNINITIALIZED)
>=20
> - unregister_netdev(pnetdev); /* will call netdev_close() */
> - usb_set_intfdata(pusb_intf, NULL);
> - release_firmware(padapter->fw);
>=20
> - if (drvpriv.drv_registered)
> - padapter->surprise_removed =3D true;
>=20
> - r8712_flush_rwctrl_works(padapter);
> - r8712_flush_led_works(padapter);
> - udelay(1);
> - /* Stop driver mlme relation timer */
> - r8712_stop_drv_timers(padapter);
> - r871x_dev_unload(padapter);
> - if (padapter->dvobj_deinit)
>=20
> - padapter->dvobj_deinit(padapter);
>=20
> - r8712_free_drv_sw(padapter);
> - free_netdev(pnetdev);
> -
> - /* decrease the reference count of the usb device structure
> - * when disconnect
> - /
> - usb_put_dev(udev);
> -
> - / If we didn't unplug usb dongle and remove/insert module, driver
> - * fails on sitesurvey for the first time when device is up.
> - * Reset usb port for sitesurvey fail issue.
> - */
> - if (udev->state !=3D USB_STATE_NOTATTACHED)
>=20
> - usb_reset_device(udev);
> -}
> -
> -static int __init r8712u_drv_entry(void)
> -{
> - drvpriv.drv_registered =3D true;
> - return usb_register(&drvpriv.r871xu_drv);
> -}
> -
> -static void __exit r8712u_drv_halt(void)
> -{
> - drvpriv.drv_registered =3D false;
> - usb_deregister(&drvpriv.r871xu_drv);
> -}
> -
> -module_init(r8712u_drv_entry);
> -module_exit(r8712u_drv_halt);
> diff --git a/drivers/staging/rtl8712/usb_ops.c b/drivers/staging/rtl8712/=
usb_ops.c
> deleted file mode 100644
> index af9966d03979..000000000000
> --- a/drivers/staging/rtl8712/usb_ops.c
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/***********************************************************************=
*******
> - * usb_ops.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define HCI_OPS_C
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "osdep_intf.h"
> -#include "usb_ops.h"
> -#include "recv_osdep.h"
> -
> -static u8 usb_read8(struct intf_hdl *intfhdl, u32 addr)
> -{
> - u8 request;
> - u8 requesttype;
> - u16 wvalue;
> - u16 index;
> - u16 len;
> - int status;
> - __le32 data =3D 0;
> - struct intf_priv *intfpriv =3D intfhdl->pintfpriv;
>=20
> -
> - request =3D 0x05;
> - requesttype =3D 0x01; /* read_in */
> - index =3D 0;
> - wvalue =3D (u16)(addr & 0x0000ffff);
> - len =3D 1;
> - status =3D r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
> - &data, len, requesttype);
> - if (status < 0)
> - return 0;
> - return (u8)(le32_to_cpu(data) & 0x0ff);
> -}
> -
> -static u16 usb_read16(struct intf_hdl *intfhdl, u32 addr)
> -{
> - u8 request;
> - u8 requesttype;
> - u16 wvalue;
> - u16 index;
> - u16 len;
> - int status;
> - __le32 data =3D 0;
> - struct intf_priv *intfpriv =3D intfhdl->pintfpriv;
>=20
> -
> - request =3D 0x05;
> - requesttype =3D 0x01; /* read_in */
> - index =3D 0;
> - wvalue =3D (u16)(addr & 0x0000ffff);
> - len =3D 2;
> - status =3D r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
> - &data, len, requesttype);
> - if (status < 0)
> - return 0;
> - return (u16)(le32_to_cpu(data) & 0xffff);
> -}
> -
> -static u32 usb_read32(struct intf_hdl *intfhdl, u32 addr)
> -{
> - u8 request;
> - u8 requesttype;
> - u16 wvalue;
> - u16 index;
> - u16 len;
> - int status;
> - __le32 data =3D 0;
> - struct intf_priv *intfpriv =3D intfhdl->pintfpriv;
>=20
> -
> - request =3D 0x05;
> - requesttype =3D 0x01; /* read_in */
> - index =3D 0;
> - wvalue =3D (u16)(addr & 0x0000ffff);
> - len =3D 4;
> - status =3D r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index,
> - &data, len, requesttype);
> - if (status < 0)
> - return 0;
> - return le32_to_cpu(data);
> -}
> -
> -static void usb_write8(struct intf_hdl *intfhdl, u32 addr, u8 val)
> -{
> - u8 request;
> - u8 requesttype;
> - u16 wvalue;
> - u16 index;
> - u16 len;
> - __le32 data;
> - struct intf_priv *intfpriv =3D intfhdl->pintfpriv;
>=20
> -
> - request =3D 0x05;
> - requesttype =3D 0x00; /* write_out */
> - index =3D 0;
> - wvalue =3D (u16)(addr & 0x0000ffff);
> - len =3D 1;
> - data =3D cpu_to_le32((u32)val & 0x000000ff);
> - r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
> - requesttype);
> -}
> -
> -static void usb_write16(struct intf_hdl *intfhdl, u32 addr, u16 val)
> -{
> - u8 request;
> - u8 requesttype;
> - u16 wvalue;
> - u16 index;
> - u16 len;
> - __le32 data;
> - struct intf_priv *intfpriv =3D intfhdl->pintfpriv;
>=20
> -
> - request =3D 0x05;
> - requesttype =3D 0x00; /* write_out */
> - index =3D 0;
> - wvalue =3D (u16)(addr & 0x0000ffff);
> - len =3D 2;
> - data =3D cpu_to_le32((u32)val & 0x0000ffff);
> - r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
> - requesttype);
> -}
> -
> -static void usb_write32(struct intf_hdl *intfhdl, u32 addr, u32 val)
> -{
> - u8 request;
> - u8 requesttype;
> - u16 wvalue;
> - u16 index;
> - u16 len;
> - __le32 data;
> - struct intf_priv *intfpriv =3D intfhdl->pintfpriv;
>=20
> -
> - request =3D 0x05;
> - requesttype =3D 0x00; /* write_out */
> - index =3D 0;
> - wvalue =3D (u16)(addr & 0x0000ffff);
> - len =3D 4;
> - data =3D cpu_to_le32(val);
> - r8712_usbctrl_vendorreq(intfpriv, request, wvalue, index, &data, len,
> - requesttype);
> -}
> -
> -void r8712_usb_set_intf_option(u32 *option)
> -{
> - *option =3D ((*option) | INTF_ASYNC);
> -}
> -
> -static void usb_intf_hdl_init(u8 *priv)
> -{
> -}
> -
> -static void usb_intf_hdl_unload(u8 *priv)
> -{
> -}
> -
> -static void usb_intf_hdl_open(u8 *priv)
> -{
> -}
> -
> -static void usb_intf_hdl_close(u8 *priv)
> -{
> -}
> -
> -void r8712_usb_set_intf_funs(struct intf_hdl *intfhdl)
> -{
> - intfhdl->intf_hdl_init =3D usb_intf_hdl_init;
>=20
> - intfhdl->intf_hdl_unload =3D usb_intf_hdl_unload;
>=20
> - intfhdl->intf_hdl_open =3D usb_intf_hdl_open;
>=20
> - intfhdl->intf_hdl_close =3D usb_intf_hdl_close;
>=20
> -}
> -
> -void r8712_usb_set_intf_ops(struct _io_ops *ops)
> -{
> - memset((u8 *)ops, 0, sizeof(struct _io_ops));
> - ops->_read8 =3D usb_read8;
>=20
> - ops->_read16 =3D usb_read16;
>=20
> - ops->_read32 =3D usb_read32;
>=20
> - ops->_read_port =3D r8712_usb_read_port;
>=20
> - ops->_write8 =3D usb_write8;
>=20
> - ops->_write16 =3D usb_write16;
>=20
> - ops->_write32 =3D usb_write32;
>=20
> - ops->_write_mem =3D r8712_usb_write_mem;
>=20
> - ops->_write_port =3D r8712_usb_write_port;
>=20
> -}
> diff --git a/drivers/staging/rtl8712/usb_ops.h b/drivers/staging/rtl8712/=
usb_ops.h
> deleted file mode 100644
> index 7a6b619b73fa..000000000000
> --- a/drivers/staging/rtl8712/usb_ops.h
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***************/
> -#ifndef _USB_OPS_H
> -#define _USB_OPS_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "osdep_intf.h"
> -
> -void r8712_usb_write_mem(struct intf_hdl pintfhdl, u32 addr,
> - u32 cnt, u8 wmem);
> -u32 r8712_usb_write_port(struct intf_hdl pintfhdl, u32 addr,
> - u32 cnt, u8 wmem);
> -u32 r8712_usb_read_port(struct intf_hdl pintfhdl, u32 addr,
> - u32 cnt, u8 rmem);
> -void r8712_usb_set_intf_option(u32 poption);
> -void r8712_usb_set_intf_funs(struct intf_hdl pintf_hdl);
> -uint r8712_usb_init_intf_priv(struct intf_priv pintfpriv);
> -void r8712_usb_unload_intf_priv(struct intf_priv pintfpriv);
> -void r8712_usb_set_intf_ops(struct _io_ops pops);
> -void r8712_usb_read_port_cancel(struct _adapter padapter);
> -void r8712_usb_write_port_cancel(struct _adapter padapter);
> -int r8712_usbctrl_vendorreq(struct intf_priv pintfpriv, u8 request, u16 =
value,
> - u16 index, void pdata, u16 len, u8 requesttype);
> -
> -#endif
> -
> diff --git a/drivers/staging/rtl8712/usb_ops_linux.c b/drivers/staging/rt=
l8712/usb_ops_linux.c
> deleted file mode 100644
> index 0c953298d42d..000000000000
> --- a/drivers/staging/rtl8712/usb_ops_linux.c
> +++ /dev/null
> @@ -1,508 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * usb_ops_linux.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define HCI_OPS_OS_C
> -
> -#include <linux/usb.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -#include "osdep_intf.h"
> -#include "usb_ops.h"
> -
> -#define RTL871X_VENQT_READ 0xc0
> -#define RTL871X_VENQT_WRITE 0x40
> -
> -uint r8712_usb_init_intf_priv(struct intf_priv *pintfpriv)
> -{
> - pintfpriv->piorw_urb =3D usb_alloc_urb(0, GFP_ATOMIC);
>=20
> - if (!pintfpriv->piorw_urb)
>=20
> - return _FAIL;
> - init_completion(&pintfpriv->io_retevt_comp);
>=20
> - return _SUCCESS;
> -}
> -
> -void r8712_usb_unload_intf_priv(struct intf_priv *pintfpriv)
> -{
> - if (pintfpriv->piorw_urb) {
>=20
> - usb_kill_urb(pintfpriv->piorw_urb);
>=20
> - usb_free_urb(pintfpriv->piorw_urb);
>=20
> - }
> -}
> -
> -static unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
> -{
> - unsigned int pipe =3D 0;
> - struct usb_device *pusbd =3D pdvobj->pusbdev;
>=20
> -
> - if (pdvobj->nr_endpoint =3D=3D 11) {
>=20
> - switch (addr) {
> - case RTL8712_DMA_BKQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x07);
> - break;
> - case RTL8712_DMA_BEQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x06);
> - break;
> - case RTL8712_DMA_VIQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x05);
> - break;
> - case RTL8712_DMA_VOQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x04);
> - break;
> - case RTL8712_DMA_BCNQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x0a);
> - break;
> - case RTL8712_DMA_BMCQ: /* HI Queue /
> - pipe =3D usb_sndbulkpipe(pusbd, 0x0b);
> - break;
> - case RTL8712_DMA_MGTQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x0c);
> - break;
> - case RTL8712_DMA_RX0FF:
> - pipe =3D usb_rcvbulkpipe(pusbd, 0x03); / in /
> - break;
> - case RTL8712_DMA_C2HCMD:
> - pipe =3D usb_rcvbulkpipe(pusbd, 0x09); / in */
> - break;
> - case RTL8712_DMA_H2CCMD:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x0d);
> - break;
> - }
> - } else if (pdvobj->nr_endpoint =3D=3D 6) {
>=20
> - switch (addr) {
> - case RTL8712_DMA_BKQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x07);
> - break;
> - case RTL8712_DMA_BEQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x06);
> - break;
> - case RTL8712_DMA_VIQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x05);
> - break;
> - case RTL8712_DMA_VOQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x04);
> - break;
> - case RTL8712_DMA_RX0FF:
> - case RTL8712_DMA_C2HCMD:
> - pipe =3D usb_rcvbulkpipe(pusbd, 0x03); /* in */
> - break;
> - case RTL8712_DMA_H2CCMD:
> - case RTL8712_DMA_BCNQ:
> - case RTL8712_DMA_BMCQ:
> - case RTL8712_DMA_MGTQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x0d);
> - break;
> - }
> - } else if (pdvobj->nr_endpoint =3D=3D 4) {
>=20
> - switch (addr) {
> - case RTL8712_DMA_BEQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x06);
> - break;
> - case RTL8712_DMA_VOQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x04);
> - break;
> - case RTL8712_DMA_RX0FF:
> - case RTL8712_DMA_C2HCMD:
> - pipe =3D usb_rcvbulkpipe(pusbd, 0x03); /* in */
> - break;
> - case RTL8712_DMA_H2CCMD:
> - case RTL8712_DMA_BCNQ:
> - case RTL8712_DMA_BMCQ:
> - case RTL8712_DMA_MGTQ:
> - pipe =3D usb_sndbulkpipe(pusbd, 0x0d);
> - break;
> - }
> - } else {
> - pipe =3D 0;
> - }
> - return pipe;
> -}
> -
> -static void usb_write_mem_complete(struct urb *purb)
> -{
> - struct io_queue *pio_q =3D (struct io_queue *)purb->context;
>=20
> - struct intf_hdl *pintf =3D &pio_q->intf;
>=20
> - struct intf_priv *pintfpriv =3D pintf->pintfpriv;
>=20
> - struct _adapter *padapter =3D (struct _adapter *)pintf->adapter;
>=20
> -
> - if (purb->status !=3D 0) {
>=20
> - if (purb->status =3D=3D (-ESHUTDOWN))
>=20
> - padapter->driver_stopped =3D true;
>=20
> - else
> - padapter->surprise_removed =3D true;
>=20
> - }
> - complete(&pintfpriv->io_retevt_comp);
>=20
> -}
> -
> -void r8712_usb_write_mem(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u=
8 *wmem)
> -{
> - unsigned int pipe;
> - struct _adapter *padapter =3D (struct _adapter *)pintfhdl->adapter;
>=20
> - struct intf_priv *pintfpriv =3D pintfhdl->pintfpriv;
>=20
> - struct io_queue *pio_queue =3D padapter->pio_queue;
>=20
> - struct dvobj_priv *pdvobj =3D (struct dvobj_priv *)pintfpriv->intf_dev;
>=20
> - struct usb_device *pusbd =3D pdvobj->pusbdev;
>=20
> - struct urb *piorw_urb =3D pintfpriv->piorw_urb;
>=20
> -
> - if ((padapter->driver_stopped) || (padapter->surprise_removed) ||
>=20
> - (padapter->pwrctrlpriv.pnp_bstop_trx))
>=20
> - return;
> - /* translate DMA FIFO addr to pipehandle */
> - pipe =3D ffaddr2pipehdl(pdvobj, addr);
> - if (pipe =3D=3D 0)
> - return;
> - usb_fill_bulk_urb(piorw_urb, pusbd, pipe,
> - wmem, cnt, usb_write_mem_complete,
> - pio_queue);
> - usb_submit_urb(piorw_urb, GFP_ATOMIC);
> - wait_for_completion_interruptible(&pintfpriv->io_retevt_comp);
>=20
> -}
> -
> -static void r8712_usb_read_port_complete(struct urb *purb)
> -{
> - uint isevt;
> - __le32 *pbuf;
> - struct recv_buf *precvbuf =3D (struct recv_buf *)purb->context;
>=20
> - struct _adapter *padapter =3D (struct _adapter *)precvbuf->adapter;
>=20
> - struct recv_priv *precvpriv =3D &padapter->recvpriv;
>=20
> -
> - if (padapter->surprise_removed || padapter->driver_stopped)
>=20
> - return;
> - if (purb->status =3D=3D 0) { /* SUCCESS */
>=20
> - if ((purb->actual_length > (MAX_RECVBUF_SZ)) ||
>=20
> - (purb->actual_length < RXDESC_SIZE)) {
>=20
> - r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
>=20
> - (unsigned char *)precvbuf);
> - } else {
> - _pkt *pskb =3D precvbuf->pskb;
>=20
> -
> - precvbuf->transfer_len =3D purb->actual_length;
>=20
> - pbuf =3D (__le32 *)precvbuf->pbuf;
>=20
> - isevt =3D le32_to_cpu(*(pbuf + 1)) & 0x1ff;
> - if ((isevt & 0x1ff) =3D=3D 0x1ff) {
> - r8712_rxcmd_event_hdl(padapter, pbuf);
> - skb_queue_tail(&precvpriv->rx_skb_queue, pskb);
>=20
> - r8712_read_port(padapter, precvpriv->ff_hwaddr,
>=20
> - 0, (unsigned char *)precvbuf);
> - } else {
> - skb_put(pskb, purb->actual_length);
>=20
> - skb_queue_tail(&precvpriv->rx_skb_queue, pskb);
>=20
> - tasklet_hi_schedule(&precvpriv->recv_tasklet);
>=20
> - r8712_read_port(padapter, precvpriv->ff_hwaddr,
>=20
> - 0, (unsigned char *)precvbuf);
> - }
> - }
> - } else {
> - switch (purb->status) {
>=20
> - case -EINVAL:
> - case -EPIPE:
> - case -ENODEV:
> - case -ESHUTDOWN:
> - padapter->driver_stopped =3D true;
>=20
> - break;
> - case -ENOENT:
> - if (!padapter->suspended) {
>=20
> - padapter->driver_stopped =3D true;
>=20
> - break;
> - }
> - fallthrough;
> - case -EPROTO:
> - r8712_read_port(padapter, precvpriv->ff_hwaddr, 0,
>=20
> - (unsigned char *)precvbuf);
> - break;
> - case -EINPROGRESS:
> - netdev_err(padapter->pnetdev, "ERROR: URB IS IN PROGRESS!\n");
>=20
> - break;
> - default:
> - break;
> - }
> - }
> -}
> -
> -u32 r8712_usb_read_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u8=
 *rmem)
> -{
> - unsigned int pipe;
> - int err;
> - u32 tmpaddr =3D 0;
> - int alignment =3D 0;
> - u32 ret =3D _SUCCESS;
> - struct urb *purb =3D NULL;
> - struct recv_buf *precvbuf =3D (struct recv_buf *)rmem;
> - struct intf_priv *pintfpriv =3D pintfhdl->pintfpriv;
>=20
> - struct dvobj_priv *pdvobj =3D (struct dvobj_priv *)pintfpriv->intf_dev;
>=20
> - struct _adapter *adapter =3D pdvobj->padapter;
>=20
> - struct recv_priv *precvpriv =3D &adapter->recvpriv;
>=20
> - struct usb_device *pusbd =3D pdvobj->pusbdev;
>=20
> -
> - if (adapter->driver_stopped || adapter->surprise_removed ||
>=20
> - adapter->pwrctrlpriv.pnp_bstop_trx || !precvbuf)
>=20
> - return _FAIL;
> - r8712_init_recvbuf(adapter, precvbuf);
> - /* Try to use skb from the free queue */
> - precvbuf->pskb =3D skb_dequeue(&precvpriv->free_recv_skb_queue);
>=20
> -
> - if (!precvbuf->pskb) {
>=20
> - precvbuf->pskb =3D netdev_alloc_skb(adapter->pnetdev,
>=20
> - MAX_RECVBUF_SZ + RECVBUFF_ALIGN_SZ);
> - if (!precvbuf->pskb)
>=20
> - return _FAIL;
> - tmpaddr =3D (addr_t)precvbuf->pskb->data;
>=20
> - alignment =3D tmpaddr & (RECVBUFF_ALIGN_SZ - 1);
> - skb_reserve(precvbuf->pskb,
>=20
> - (RECVBUFF_ALIGN_SZ - alignment));
> - precvbuf->phead =3D precvbuf->pskb->head;
>=20
> - precvbuf->pdata =3D precvbuf->pskb->data;
>=20
> - precvbuf->ptail =3D skb_tail_pointer(precvbuf->pskb);
>=20
> - precvbuf->pend =3D skb_end_pointer(precvbuf->pskb);
>=20
> - precvbuf->pbuf =3D precvbuf->pskb->data;
>=20
> - } else { /* skb is reused */
> - precvbuf->phead =3D precvbuf->pskb->head;
>=20
> - precvbuf->pdata =3D precvbuf->pskb->data;
>=20
> - precvbuf->ptail =3D skb_tail_pointer(precvbuf->pskb);
>=20
> - precvbuf->pend =3D skb_end_pointer(precvbuf->pskb);
>=20
> - precvbuf->pbuf =3D precvbuf->pskb->data;
>=20
> - }
> - purb =3D precvbuf->purb;
>=20
> - /* translate DMA FIFO addr to pipehandle */
> - pipe =3D ffaddr2pipehdl(pdvobj, addr);
> - usb_fill_bulk_urb(purb, pusbd, pipe,
> - precvbuf->pbuf, MAX_RECVBUF_SZ,
>=20
> - r8712_usb_read_port_complete,
> - precvbuf);
> - err =3D usb_submit_urb(purb, GFP_ATOMIC);
> - if ((err) && (err !=3D (-EPERM)))
> - ret =3D _FAIL;
> - return ret;
> -}
> -
> -void r8712_usb_read_port_cancel(struct _adapter *padapter)
> -{
> - int i;
> - struct recv_buf *precvbuf;
> -
> - precvbuf =3D (struct recv_buf *)padapter->recvpriv.precv_buf;
>=20
> - for (i =3D 0; i < NR_RECVBUFF; i++) {
> - if (precvbuf->purb)
>=20
> - usb_kill_urb(precvbuf->purb);
>=20
> - precvbuf++;
> - }
> -}
> -
> -void r8712_xmit_bh(struct tasklet_struct *t)
> -{
> - int ret =3D false;
> - struct _adapter *padapter =3D from_tasklet(padapter, t,
> - xmitpriv.xmit_tasklet);
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> -
> - if (padapter->driver_stopped ||
>=20
> - padapter->surprise_removed) {
>=20
> - netdev_err(padapter->pnetdev, "xmit_bh =3D> driver_stopped or surprise_=
removed\n");
>=20
> - return;
> - }
> - ret =3D r8712_xmitframe_complete(padapter, pxmitpriv, NULL);
> - if (!ret)
> - return;
> - tasklet_hi_schedule(&pxmitpriv->xmit_tasklet);
>=20
> -}
> -
> -static void usb_write_port_complete(struct urb *purb)
> -{
> - int i;
> - struct xmit_frame *pxmitframe =3D (struct xmit_frame *)purb->context;
>=20
> - struct xmit_buf *pxmitbuf =3D pxmitframe->pxmitbuf;
>=20
> - struct _adapter *padapter =3D pxmitframe->padapter;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> -
> - switch (pattrib->priority) {
>=20
> - case 1:
> - case 2:
> - pxmitpriv->bkq_cnt--;
>=20
> - break;
> - case 4:
> - case 5:
> - pxmitpriv->viq_cnt--;
>=20
> - break;
> - case 6:
> - case 7:
> - pxmitpriv->voq_cnt--;
>=20
> - break;
> - case 0:
> - case 3:
> - default:
> - pxmitpriv->beq_cnt--;
>=20
> - break;
> - }
> - pxmitpriv->txirp_cnt--;
>=20
> - for (i =3D 0; i < 8; i++) {
> - if (purb =3D=3D pxmitframe->pxmit_urb[i]) {
>=20
> - pxmitframe->bpending[i] =3D false;
>=20
> - break;
> - }
> - }
> - if (padapter->surprise_removed)
>=20
> - return;
> - switch (purb->status) {
>=20
> - case 0:
> - break;
> - default:
> - netdev_warn(padapter->pnetdev,
>=20
> - "r8712u: pipe error: (%d)\n", purb->status);
>=20
> - break;
> - }
> - /* not to consider tx fragment */
> - r8712_free_xmitframe_ex(pxmitpriv, pxmitframe);
> - r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
> - tasklet_hi_schedule(&pxmitpriv->xmit_tasklet);
>=20
> -}
> -
> -u32 r8712_usb_write_port(struct intf_hdl *pintfhdl, u32 addr, u32 cnt, u=
8 *wmem)
> -{
> - unsigned long irqL;
> - int i, status;
> - unsigned int pipe;
> - u32 ret, bwritezero;
> - struct urb *purb =3D NULL;
> - struct _adapter *padapter =3D (struct _adapter *)pintfhdl->adapter;
>=20
> - struct dvobj_priv *pdvobj =3D &padapter->dvobjpriv;
>=20
> - struct xmit_priv *pxmitpriv =3D &padapter->xmitpriv;
>=20
> - struct xmit_frame *pxmitframe =3D (struct xmit_frame *)wmem;
> - struct usb_device *pusbd =3D pdvobj->pusbdev;
>=20
> - struct pkt_attrib *pattrib =3D &pxmitframe->attrib;
>=20
> -
> - if ((padapter->driver_stopped) || (padapter->surprise_removed) ||
>=20
> - (padapter->pwrctrlpriv.pnp_bstop_trx))
>=20
> - return _FAIL;
> - for (i =3D 0; i < 8; i++) {
> - if (!pxmitframe->bpending[i]) {
>=20
> - spin_lock_irqsave(&pxmitpriv->lock, irqL);
>=20
> - pxmitpriv->txirp_cnt++;
>=20
> - pxmitframe->bpending[i] =3D true;
>=20
> - switch (pattrib->priority) {
>=20
> - case 1:
> - case 2:
> - pxmitpriv->bkq_cnt++;
>=20
> - break;
> - case 4:
> - case 5:
> - pxmitpriv->viq_cnt++;
>=20
> - break;
> - case 6:
> - case 7:
> - pxmitpriv->voq_cnt++;
>=20
> - break;
> - case 0:
> - case 3:
> - default:
> - pxmitpriv->beq_cnt++;
>=20
> - break;
> - }
> - spin_unlock_irqrestore(&pxmitpriv->lock, irqL);
>=20
> - pxmitframe->sz[i] =3D (u16)cnt;
>=20
> - purb =3D pxmitframe->pxmit_urb[i];
>=20
> - break;
> - }
> - }
> - bwritezero =3D false;
> - if (pdvobj->ishighspeed) {
>=20
> - if (cnt > 0 && cnt % 512 =3D=3D 0)
>=20
> - bwritezero =3D true;
> - } else {
> - if (cnt > 0 && cnt % 64 =3D=3D 0)
>=20
> - bwritezero =3D true;
> - }
> - /* translate DMA FIFO addr to pipehandle */
> - pipe =3D ffaddr2pipehdl(pdvobj, addr);
> - if (pxmitpriv->free_xmitbuf_cnt % NR_XMITBUFF =3D=3D 0)
>=20
> - purb->transfer_flags &=3D (~URB_NO_INTERRUPT);
>=20
> - else
> - purb->transfer_flags |=3D URB_NO_INTERRUPT;
>=20
> - if (bwritezero)
> - cnt +=3D 8;
> - usb_fill_bulk_urb(purb, pusbd, pipe,
> - pxmitframe->mem_addr,
>=20
> - cnt, usb_write_port_complete,
> - pxmitframe); /* context is xmit_frame */
> - status =3D usb_submit_urb(purb, GFP_ATOMIC);
> - if (!status)
> - ret =3D _SUCCESS;
> - else
> - ret =3D _FAIL;
> - return ret;
> -}
> -
> -void r8712_usb_write_port_cancel(struct _adapter *padapter)
> -{
> - int i, j;
> - struct xmit_buf *pxmitbuf =3D (struct xmit_buf *)
> - padapter->xmitpriv.pxmitbuf;
>=20
> -
> - for (i =3D 0; i < NR_XMITBUFF; i++) {
> - for (j =3D 0; j < 8; j++) {
> - if (pxmitbuf->pxmit_urb[j])
>=20
> - usb_kill_urb(pxmitbuf->pxmit_urb[j]);
>=20
> - }
> - pxmitbuf++;
> - }
> -}
> -
> -int r8712_usbctrl_vendorreq(struct intf_priv *pintfpriv, u8 request, u16=
 value,
> - u16 index, void *pdata, u16 len, u8 requesttype)
> -{
> - unsigned int pipe;
> - int status;
> - u8 reqtype;
> - struct dvobj_priv *pdvobjpriv =3D (struct dvobj_priv *)
> - pintfpriv->intf_dev;
>=20
> - struct usb_device *udev =3D pdvobjpriv->pusbdev;
>=20
> - /* For mstar platform, mstar suggests the address for USB IO
> - * should be 16 bytes alignment. Trying to fix it here.
> - /
> - u8 palloc_buf, pIo_buf;
> -
> - palloc_buf =3D kmalloc((u32)len + 16, GFP_ATOMIC);
> - if (!palloc_buf)
> - return -ENOMEM;
> - pIo_buf =3D palloc_buf + 16 - ((addr_t)(palloc_buf) & 0x0f);
> - if (requesttype =3D=3D 0x01) {
> - pipe =3D usb_rcvctrlpipe(udev, 0); / read_in /
> - reqtype =3D RTL871X_VENQT_READ;
> - } else {
> - pipe =3D usb_sndctrlpipe(udev, 0); / write_out /
> - reqtype =3D RTL871X_VENQT_WRITE;
> - memcpy(pIo_buf, pdata, len);
> - }
> - status =3D usb_control_msg(udev, pipe, request, reqtype, value, index,
> - pIo_buf, len, 500);
> - if (status < 0)
> - goto free;
> - if (status !=3D len) {
> - status =3D -EREMOTEIO;
> - goto free;
> - }
> - / Success this control transfer. /
> - if (requesttype =3D=3D 0x01) {
> - / For Control read transfer, we have to copy the read
> - * data from pIo_buf to pdata.
> - /
> - memcpy(pdata, pIo_buf, status);
> - }
> -
> -free:
> - kfree(palloc_buf);
> - return status;
> -}
> diff --git a/drivers/staging/rtl8712/usb_osintf.h b/drivers/staging/rtl87=
12/usb_osintf.h
> deleted file mode 100644
> index 2e512b4a564c..000000000000
> --- a/drivers/staging/rtl8712/usb_osintf.h
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
****
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ************/
> -#ifndef __USB_OSINTF_H
> -#define __USB_OSINTF_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -extern char r8712_initmac;
> -
> -unsigned int r8712_usb_inirp_init(struct _adapter padapter);
> -unsigned int r8712_usb_inirp_deinit(struct _adapter padapter);
> -uint rtl871x_hal_init(struct _adapter padapter);
> -uint rtl8712_hal_deinit(struct _adapter padapter);
> -
> -void rtl871x_intf_stop(struct _adapter padapter);
> -void r871x_dev_unload(struct _adapter padapter);
> -void r8712_stop_drv_threads(struct _adapter padapter);
> -void r8712_stop_drv_timers(struct _adapter padapter);
> -int r8712_init_drv_sw(struct _adapter padapter);
> -void r8712_free_drv_sw(struct _adapter padapter);
> -struct net_device r8712_init_netdev(void);
> -
> -#endif
> diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wif=
i.h
> deleted file mode 100644
> index 498e6dec7e67..000000000000
> --- a/drivers/staging/rtl8712/wifi.h
> +++ /dev/null
> @@ -1,196 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef WIFI_H
> -#define WIFI_H
> -
> -#include <linux/compiler.h>
>=20
> -#include <linux/ieee80211.h>
>=20
> -
> -#define WLAN_HDR_A3_LEN 24
> -#define WLAN_HDR_A3_QOS_LEN 26
> -
> -enum WIFI_FRAME_TYPE {
> - WIFI_QOS_DATA_TYPE =3D (BIT(7) | BIT(3)), /*!< QoS Data */
> -};
> -
> -#define SetToDs(pbuf) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(IEEE80211_FCTL_TODS); \
> -})
> -
> -#define GetToDs(pbuf) ((((__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_=
TODS)) !=3D 0)
> -
> -#define ClearToDs(pbuf) ({ \
> - *(__le16 *)(pbuf) &=3D (~cpu_to_le16(IEEE80211_FCTL_TODS)); \
> -})
> -
> -#define SetFrDs(pbuf) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(IEEE80211_FCTL_FROMDS); \
> -})
> -
> -#define GetFrDs(pbuf) ((((__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL_=
FROMDS)) !=3D 0)
> -
> -#define ClearFrDs(pbuf) ({ \
> - *(__le16 *)(pbuf) &=3D (~cpu_to_le16(IEEE80211_FCTL_FROMDS)); \
> -})
> -
> -static inline unsigned char get_tofr_ds(unsigned char *pframe)
> -{
> - return ((GetToDs(pframe) << 1) | GetFrDs(pframe));
> -}
> -
> -#define SetMFrag(pbuf) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(IEEE80211_FCTL_MOREFRAGS); \
> -})
> -
> -#define GetMFrag(pbuf) ((((__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL=
_MOREFRAGS)) !=3D 0)
> -
> -#define ClearMFrag(pbuf) ({ \
> - *(__le16 *)(pbuf) &=3D (~cpu_to_le16(IEEE80211_FCTL_MOREFRAGS)); \
> -})
> -
> -#define SetRetry(pbuf) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(IEEE80211_FCTL_RETRY); \
> -})
> -
> -#define GetRetry(pbuf) ((((__le16 *)(pbuf)) & cpu_to_le16(IEEE80211_FCTL=
_RETRY)) !=3D 0)
> -
> -#define ClearRetry(pbuf) ({ \
> - *(__le16 *)(pbuf) &=3D (~cpu_to_le16(IEEE80211_FCTL_RETRY)); \
> -})
> -
> -#define SetPwrMgt(pbuf) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(IEEE80211_FCTL_PM); \
> -})
> -
> -#define GetPwrMgt(pbuf) ((((__le16 *)(pbuf)) & \
> - cpu_to_le16(IEEE80211_FCTL_PM)) !=3D 0)
> -
> -#define ClearPwrMgt(pbuf) ({ \
> - *(__le16 *)(pbuf) &=3D (~cpu_to_le16(IEEE80211_FCTL_PM)); \
> -})
> -
> -#define SetMData(pbuf) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(IEEE80211_FCTL_MOREDATA); \
> -})
> -
> -#define GetMData(pbuf) ((((__le16 *)(pbuf)) & \
> - cpu_to_le16(IEEE80211_FCTL_MOREDATA)) !=3D 0)
> -
> -#define ClearMData(pbuf) ({ \
> - *(__le16 *)(pbuf) &=3D (~cpu_to_le16(IEEE80211_FCTL_MOREDATA)); \
> -})
> -
> -#define SetPrivacy(pbuf) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(IEEE80211_FCTL_PROTECTED); \
> -})
> -
> -#define GetPrivacy(pbuf) ((((__le16 )(pbuf)) & \
> - cpu_to_le16(IEEE80211_FCTL_PROTECTED)) !=3D 0)
> -
> -#define GetOrder(pbuf) ((((__le16 )(pbuf)) & \
> - cpu_to_le16(IEEE80211_FCTL_ORDER)) !=3D 0)
> -
> -#define GetFrameType(pbuf) (le16_to_cpu((__le16 *)(pbuf)) & \
> - (BIT(3) | BIT(2)))
> -
> -#define SetFrameType(pbuf, type) \
> - do { \
> - *(__le16 *)(pbuf) &=3D cpu_to_le16(~(BIT(3) | \
> - BIT(2))); \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(type); \
> - } while (0)
> -
> -#define GetFrameSubType(pbuf) (le16_to_cpu((__le16 *)(pbuf)) & \
> - (BIT(7) | BIT(6) | BIT(5) | BIT(4) | BIT(3) | \
> - BIT(2)))
> -
> -#define SetFrameSubType(pbuf, type) \
> - do { \
> - *(__le16 *)(pbuf) &=3D cpu_to_le16(~(BIT(7) | BIT(6) | \
> - BIT(5) | BIT(4) | BIT(3) | BIT(2))); \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(type); \
> - } while (0)
> -
> -#define GetSequence(pbuf) (le16_to_cpu((__le16 *)\
> - ((addr_t)(pbuf) + 22)) >> 4)
>=20
> -
> -#define GetFragNum(pbuf) (le16_to_cpu(*(__le16 *)((addr_t)\
> - (pbuf) + 22)) & 0x0f)
> -
> -#define SetSeqNum(pbuf, num) ({ \
> - *(__le16 )((addr_t)(pbuf) + 22) =3D \
> - cpu_to_le16((le16_to_cpu((__le16 *)((addr_t)(pbuf) + 22)) & \
> - 0x000f) | (0xfff0 & (num << 4))); \
> -})
> -
> -#define SetPriority(pbuf, tid) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16(tid & 0xf); \
> -})
> -
> -#define GetPriority(pbuf) ((le16_to_cpu((__le16 *)(pbuf))) & 0xf)
> -
> -#define SetAckpolicy(pbuf, ack) ({ \
> - *(__le16 )(pbuf) |=3D cpu_to_le16((ack & 3) << 5); \
> -})
> -
> -#define GetAckpolicy(pbuf) (((le16_to_cpu((__le16 *)pbuf)) >> 5) & 0x3)
>=20
> -
> -#define GetAMsdu(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 7) & 0x1)
>=20
> -
> -#define GetAddr1Ptr(pbuf) ((unsigned char )((addr_t)(pbuf) + 4))
> -
> -#define GetAddr2Ptr(pbuf) ((unsigned char )((addr_t)(pbuf) + 10))
> -
> -#define GetAddr3Ptr(pbuf) ((unsigned char )((addr_t)(pbuf) + 16))
> -
> -#define GetAddr4Ptr(pbuf) ((unsigned char )((addr_t)(pbuf) + 24))
> -
> -static inline unsigned char get_hdr_bssid(unsigned char pframe)
> -{
> - unsigned char sa;
> - unsigned int to_fr_ds =3D (GetToDs(pframe) << 1) | GetFrDs(pframe);
> -
> - switch (to_fr_ds) {
> - case 0x00: / ToDs=3D0, FromDs=3D0 /
> - sa =3D GetAddr3Ptr(pframe);
> - break;
> - case 0x01: / ToDs=3D0, FromDs=3D1 /
> - sa =3D GetAddr2Ptr(pframe);
> - break;
> - case 0x02: / ToDs=3D1, FromDs=3D0 /
> - sa =3D GetAddr1Ptr(pframe);
> - break;
> - default: / ToDs=3D1, FromDs=3D1 /
> - sa =3D NULL;
> - break;
> - }
> - return sa;
> -}
> -
> -/ ----------------------------------------------------------------------=
-----
> - * Below is the fixed elements...
> - * ---------------------------------------------------------------------=
------
> - /
> -#define BEACON_ITERVAL 2
> -#define CAPABILITY 2
> -#define TIMESTAMP 8
> -
> -/-----------------------------------------------------------------------=
------
> - * Below is the definition for WMM
> - -----------------------------------------------------------------------=
-------
> - /
> -#define WMM_IE_Length 7 / for WMM STA /
> -
> -#endif / WIFI_H /
> -
> diff --git a/drivers/staging/rtl8712/wlan_bssdef.h b/drivers/staging/rtl8=
712/wlan_bssdef.h
> deleted file mode 100644
> index ec3749813728..000000000000
> --- a/drivers/staging/rtl8712/wlan_bssdef.h
> +++ /dev/null
> @@ -1,223 +0,0 @@
> -/ SPDX-License-Identifier: GPL-2.0 /
> -/**********************************************************************
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ****/
> -#ifndef WLAN_BSSDEF_H
> -#define WLAN_BSSDEF_H
> -
> -#define MAX_IE_SZ 768
> -
> -#define NDIS_802_11_LENGTH_SSID 32
> -#define NDIS_802_11_LENGTH_RATES 8
> -#define NDIS_802_11_LENGTH_RATES_EX 16
> -
> -struct ndis_802_11_ssid {
> - u32 SsidLength;
> - u8 Ssid[32];
> -};
> -
> -enum NDIS_802_11_NETWORK_TYPE {
> - Ndis802_11FH,
> - Ndis802_11DS,
> - Ndis802_11OFDM5,
> - Ndis802_11OFDM24,
> - Ndis802_11NetworkTypeMax / not a real type, defined as an upper bound/
> -};
> -
> -struct NDIS_802_11_CONFIGURATION_FH {
> - u32 Length; / Length of structure /
> - u32 HopPattern; / As defined by 802.11, MSB set /
> - u32 HopSet; / to one if non-802.11 /
> - u32 DwellTime; / units are Kusec /
> -};
> -
> -/
> - * FW will only save the channel number in DSConfig.
> - * ODI Handler will convert the channel number to freq. number.
> - /
> -struct NDIS_802_11_CONFIGURATION {
> - u32 Length; / Length of structure /
> - u32 BeaconPeriod; / units are Kusec /
> - u32 ATIMWindow; / units are Kusec /
> - u32 DSConfig; / Frequency, units are kHz /
> - struct NDIS_802_11_CONFIGURATION_FH FHConfig;
> -};
> -
> -enum NDIS_802_11_NETWORK_INFRASTRUCTURE {
> - Ndis802_11IBSS,
> - Ndis802_11Infrastructure,
> - Ndis802_11AutoUnknown,
> - Ndis802_11InfrastructureMax, /Not a real value,defined as upper bound/
> - Ndis802_11APMode
> -};
> -
> -struct NDIS_802_11_FIXED_IEs {
> - u8 Timestamp[8];
> - u16 BeaconInterval;
> - u16 Capabilities;
> -};
> -
> -struct wlan_bssid_ex {
> - u32 Length;
> - unsigned char MacAddress[6];
> - u8 Reserved[2];
> - struct ndis_802_11_ssid Ssid;
> - __le32 Privacy;
> - s32 Rssi;
> - enum NDIS_802_11_NETWORK_TYPE NetworkTypeInUse;
> - struct NDIS_802_11_CONFIGURATION Configuration;
> - enum NDIS_802_11_NETWORK_INFRASTRUCTURE InfrastructureMode;
> - u8 rates[NDIS_802_11_LENGTH_RATES_EX];
> - / number of content bytes in EIs, which varies /
> - u32 IELength;
> - /(timestamp, beacon interval, and capability information) /
> - u8 IEs[MAX_IE_SZ];
> -};
> -
> -enum NDIS_802_11_AUTHENTICATION_MODE {
> - Ndis802_11AuthModeOpen,
> - Ndis802_11AuthModeShared,
> - Ndis802_11AuthModeAutoSwitch,
> - Ndis802_11AuthModeWPA,
> - Ndis802_11AuthModeWPAPSK,
> - Ndis802_11AuthModeWPANone,
> - Ndis802_11AuthModeMax / Not a real mode, defined as upper bound /
> -};
> -
> -enum {
> - Ndis802_11WEPEnabled,
> - Ndis802_11Encryption1Enabled =3D Ndis802_11WEPEnabled,
> - Ndis802_11WEPDisabled,
> - Ndis802_11EncryptionDisabled =3D Ndis802_11WEPDisabled,
> - Ndis802_11WEPKeyAbsent,
> - Ndis802_11Encryption1KeyAbsent =3D Ndis802_11WEPKeyAbsent,
> - Ndis802_11WEPNotSupported,
> - Ndis802_11EncryptionNotSupported =3D Ndis802_11WEPNotSupported,
> - Ndis802_11Encryption2Enabled,
> - Ndis802_11Encryption2KeyAbsent,
> - Ndis802_11Encryption3Enabled,
> - Ndis802_11Encryption3KeyAbsent
> -};
> -
> -#define NDIS_802_11_AI_REQFI_CAPABILITIES 1
> -#define NDIS_802_11_AI_REQFI_LISTENINTERVAL 2
> -#define NDIS_802_11_AI_REQFI_CURRENTAPADDRESS 4
> -
> -#define NDIS_802_11_AI_RESFI_CAPABILITIES 1
> -#define NDIS_802_11_AI_RESFI_STATUSCODE 2
> -#define NDIS_802_11_AI_RESFI_ASSOCIATIONID 4
> -
> -struct NDIS_802_11_AI_REQFI {
> - u16 Capabilities;
> - u16 ListenInterval;
> - unsigned char CurrentAPAddress[6];
> -};
> -
> -struct NDIS_802_11_AI_RESFI {
> - u16 Capabilities;
> - u16 StatusCode;
> - u16 AssociationId;
> -};
> -
> -struct NDIS_802_11_ASSOCIATION_INFORMATION {
> - u32 Length;
> - u16 AvailableRequestFixedIEs;
> - struct NDIS_802_11_AI_REQFI RequestFixedIEs;
> - u32 RequestIELength;
> - u32 OffsetRequestIEs;
> - u16 AvailableResponseFixedIEs;
> - struct NDIS_802_11_AI_RESFI ResponseFixedIEs;
> - u32 ResponseIELength;
> - u32 OffsetResponseIEs;
> -};
> -
> -/ Key mapping keys require a BSSID/
> -struct NDIS_802_11_KEY {
> - u32 Length; / Length of this structure /
> - u32 KeyIndex;
> - u32 KeyLength; / length of key in bytes /
> - unsigned char BSSID[6];
> - unsigned long long KeyRSC;
> - u8 KeyMaterial[32]; / variable length /
> -};
> -
> -struct NDIS_802_11_REMOVE_KEY {
> - u32 Length; / Length of this structure /
> - u32 KeyIndex;
> - unsigned char BSSID[6];
> -};
> -
> -struct NDIS_802_11_WEP {
> - u32 Length; / Length of this structure /
> - u32 KeyIndex; / 0 is the per-client key,
> - * 1-N are the global keys
> - /
> - u32 KeyLength; / length of key in bytes /
> - u8 KeyMaterial[16]; / variable length depending on above field /
> -};
> -
> -/ mask for authentication/integrity fields /
> -#define NDIS_802_11_AUTH_REQUEST_AUTH_FIELDS 0x0f
> -#define NDIS_802_11_AUTH_REQUEST_REAUTH 0x01
> -#define NDIS_802_11_AUTH_REQUEST_KEYUPDATE 0x02
> -#define NDIS_802_11_AUTH_REQUEST_PAIRWISE_ERROR 0x06
> -#define NDIS_802_11_AUTH_REQUEST_GROUP_ERROR 0x0E
> -
> -/ MIC check time, 60 seconds. /
> -#define MIC_CHECK_TIME 60000000
> -
> -#ifndef Ndis802_11APMode
> -#define Ndis802_11APMode (Ndis802_11InfrastructureMax + 1)
> -#endif
> -
> -struct wlan_network {
> - struct list_head list;
> - int network_type; /refer to ieee80211.h for WIRELESS_11A/B/G /
> - int fixed; / set to fixed when not to be removed asi
> - * site-surveying
> - /
> - unsigned int last_scanned; /timestamp for the network /
> - int aid; /will only be valid when a BSS is joined. /
> - int join_res;
> - struct wlan_bssid_ex network; /must be the last item /
> -};
> -
> -enum VRTL_CARRIER_SENSE {
> - DISABLE_VCS,
> - ENABLE_VCS,
> - AUTO_VCS
> -};
> -
> -enum VCS_TYPE {
> - NONE_VCS,
> - RTS_CTS,
> - CTS_TO_SELF
> -};
> -
> -#define PWR_CAM 0
> -#define PWR_MINPS 1
> -#define PWR_MAXPS 2
> -#define PWR_UAPSD 3
> -#define PWR_VOIP 4
> -
> -enum UAPSD_MAX_SP {
> - NO_LIMIT,
> - TWO_MSDU,
> - FOUR_MSDU,
> - SIX_MSDU
> -};
> -
> -#define NUM_PRE_AUTH_KEY 16
> -#define NUM_PMKID_CACHE NUM_PRE_AUTH_KEY
> -
> -#endif / #ifndef WLAN_BSSDEF_H_ /
> -
> diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl87=
12/xmit_linux.c
> deleted file mode 100644
> index fb7eadafe73a..000000000000
> --- a/drivers/staging/rtl8712/xmit_linux.c
> +++ /dev/null
> @@ -1,181 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/
> - * xmit_linux.c
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - * Linux device driver for RTL8192SU
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -
> -#define XMIT_OSDEP_C
> -
> -#include <linux/usb.h>
>=20
> -#include <linux/ip.h>
>=20
> -#include <linux/if_ether.h>
>=20
> -#include <linux/kmemleak.h>
>=20
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -#include "wifi.h"
> -#include "mlme_osdep.h"
> -#include "xmit_osdep.h"
> -#include "osdep_intf.h"
> -
> -static uint remainder_len(struct pkt_file *pfile)
> -{
> - return (uint)(pfile->buf_len - ((addr_t)(pfile->cur_addr) -
>=20
> - (addr_t)(pfile->buf_start)));
>=20
> -}
> -
> -void _r8712_open_pktfile(_pkt *pktptr, struct pkt_file *pfile)
> -{
> - pfile->pkt =3D pktptr;
>=20
> - pfile->cur_addr =3D pfile->buf_start =3D pktptr->data;
>=20
> - pfile->pkt_len =3D pfile->buf_len =3D pktptr->len;
>=20
> - pfile->cur_buffer =3D pfile->buf_start;
>=20
> -}
> -
> -uint _r8712_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
> -{
> - uint len;
> -
> - len =3D remainder_len(pfile);
> - len =3D (rlen > len) ? len : rlen;
>=20
> - if (rmem)
> - skb_copy_bits(pfile->pkt, pfile->buf_len - pfile->pkt_len,
>=20
> - rmem, len);
> - pfile->cur_addr +=3D len;
>=20
> - pfile->pkt_len -=3D len;
>=20
> - return len;
> -}
> -
> -sint r8712_endofpktfile(struct pkt_file *pfile)
> -{
> - return (pfile->pkt_len =3D=3D 0);
>=20
> -}
> -
> -void r8712_set_qos(struct pkt_file *ppktfile, struct pkt_attrib *pattrib=
)
> -{
> - struct ethhdr etherhdr;
> - struct iphdr ip_hdr;
> - u16 user_priority =3D 0;
> -
> - _r8712_open_pktfile(ppktfile->pkt, ppktfile);
>=20
> - _r8712_pktfile_read(ppktfile, (unsigned char )&etherhdr, ETH_HLEN);
> -
> - / get user_priority from IP hdr*/
> - if (pattrib->ether_type =3D=3D 0x0800) {
>=20
> - _r8712_pktfile_read(ppktfile, (u8 *)&ip_hdr, sizeof(ip_hdr));
> - /user_priority =3D (ntohs(ip_hdr.tos) >> 5) & 0x3 ;/
>=20
> - user_priority =3D ip_hdr.tos >> 5;
>=20
> - } else {
> - /* "When priority processing of data frames is supported,
> - * a STA's SME should send EAPOL-Key frames at the highest
> - * priority."
> - */
> -
> - if (pattrib->ether_type =3D=3D 0x888e)
>=20
> - user_priority =3D 7;
> - }
> - pattrib->priority =3D user_priority;
>=20
> - pattrib->hdrlen =3D WLAN_HDR_A3_QOS_LEN;
>=20
> - pattrib->subtype =3D WIFI_QOS_DATA_TYPE;
>=20
> -}
> -
> -void r8712_SetFilter(struct work_struct *work)
> -{
> - struct _adapter *adapter =3D container_of(work, struct _adapter,
> - wk_filter_rx_ff0);
> - u8 oldvalue =3D 0x00, newvalue =3D 0x00;
> -
> - oldvalue =3D r8712_read8(adapter, 0x117);
> - newvalue =3D oldvalue & 0xfe;
> - r8712_write8(adapter, 0x117, newvalue);
> -
> - wait_for_completion(&adapter->rx_filter_ready);
>=20
> - r8712_write8(adapter, 0x117, oldvalue);
> -}
> -
> -int r8712_xmit_resource_alloc(struct _adapter *padapter,
> - struct xmit_buf *pxmitbuf)
> -{
> - int i;
> -
> - for (i =3D 0; i < 8; i++) {
> - pxmitbuf->pxmit_urb[i] =3D usb_alloc_urb(0, GFP_KERNEL);
>=20
> - if (!pxmitbuf->pxmit_urb[i]) {
>=20
> - int k;
> -
> - for (k =3D i - 1; k >=3D 0; k--) {
>=20
> - /* handle allocation errors part way through loop */
> - usb_free_urb(pxmitbuf->pxmit_urb[k]);
>=20
> - }
> - netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] =3D=3D NULL\n");
>=20
> - return -ENOMEM;
> - }
> - kmemleak_not_leak(pxmitbuf->pxmit_urb[i]);
>=20
> - }
> - return 0;
> -}
> -
> -void r8712_xmit_resource_free(struct _adapter *padapter,
> - struct xmit_buf *pxmitbuf)
> -{
> - int i;
> -
> - for (i =3D 0; i < 8; i++) {
> - if (pxmitbuf->pxmit_urb[i]) {
>=20
> - usb_kill_urb(pxmitbuf->pxmit_urb[i]);
>=20
> - usb_free_urb(pxmitbuf->pxmit_urb[i]);
>=20
> - }
> - }
> -}
> -
> -void r8712_xmit_complete(struct _adapter *padapter, struct xmit_frame *p=
xframe)
> -{
> - if (pxframe->pkt)
>=20
> - dev_kfree_skb_any(pxframe->pkt);
>=20
> - pxframe->pkt =3D NULL;
>=20
> -}
> -
> -netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct net_device *netdev)
> -{
> - struct xmit_frame *xmitframe =3D NULL;
> - struct _adapter *adapter =3D netdev_priv(netdev);
> - struct xmit_priv *xmitpriv =3D &adapter->xmitpriv;
>=20
> -
> - if (!r8712_if_up(adapter))
> - goto _xmit_entry_drop;
> -
> - xmitframe =3D r8712_alloc_xmitframe(xmitpriv);
> - if (!xmitframe)
> - goto _xmit_entry_drop;
> -
> - if (r8712_update_attrib(adapter, pkt, &xmitframe->attrib))
>=20
> - goto _xmit_entry_drop;
> -
> - adapter->ledpriv.LedControlHandler(adapter, LED_CTL_TX);
>=20
> - xmitframe->pkt =3D pkt;
>=20
> - if (r8712_pre_xmit(adapter, xmitframe)) {
> - /dump xmitframe directly or drop xframe/
> - dev_kfree_skb_any(pkt);
> - xmitframe->pkt =3D NULL;
>=20
> - }
> - xmitpriv->tx_pkts++;
>=20
> - xmitpriv->tx_bytes +=3D xmitframe->attrib.last_txcmdsz;
>=20
> - return NETDEV_TX_OK;
> -_xmit_entry_drop:
> - if (xmitframe)
> - r8712_free_xmitframe(xmitpriv, xmitframe);
> - xmitpriv->tx_drop++;
>=20
> - dev_kfree_skb_any(pkt);
> - return NETDEV_TX_OK;
> -}
> diff --git a/drivers/staging/rtl8712/xmit_osdep.h b/drivers/staging/rtl87=
12/xmit_osdep.h
> deleted file mode 100644
> index 1ad42658c883..000000000000
> --- a/drivers/staging/rtl8712/xmit_osdep.h
> +++ /dev/null
> @@ -1,52 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 /
> -/***********************************************************************=
******
> - *
> - * Copyright(c) 2007 - 2010 Realtek Corporation. All rights reserved.
> - *
> - * Modifications for inclusion into the Linux staging tree are
> - * Copyright(c) 2010 Larry Finger. All rights reserved.
> - *
> - * Contact information:
> - * WLAN FAE wlanfae@realtek.com
>=20
> - * Larry Finger Larry.Finger@lwfinger.net
>=20
> - *
> - ***********************************************************************=
*******/
> -#ifndef _XMIT_OSDEP_H
> -#define _XMIT_OSDEP_H
> -
> -#include "osdep_service.h"
> -#include "drv_types.h"
> -
> -struct pkt_file {
> - _pkt *pkt;
> - u32 pkt_len; /the remainder length of the open_file/
> - _buffer *cur_buffer;
> - u8 *buf_start;
> - u8 *cur_addr;
> - u32 buf_len;
> -};
> -
> -#define NR_XMITFRAME 256
> -
> -struct xmit_priv;
> -struct pkt_attrib;
> -struct sta_xmit_priv;
> -struct xmit_frame;
> -struct xmit_buf;
> -
> -netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct net_device *pnetdev);
> -void r8712_SetFilter(struct work_struct *work);
> -int r8712_xmit_resource_alloc(struct _adapter *padapter,
> - struct xmit_buf *pxmitbuf);
> -void r8712_xmit_resource_free(struct _adapter *padapter,
> - struct xmit_buf *pxmitbuf);
> -
> -void r8712_set_qos(struct pkt_file *ppktfile,
> - struct pkt_attrib *pattrib);
> -void _r8712_open_pktfile(_pkt *pktptr, struct pkt_file *pfile);
> -uint _r8712_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen);
> -sint r8712_endofpktfile(struct pkt_file *pfile);
> -void r8712_xmit_complete(struct _adapter *padapter,
> - struct xmit_frame *pxframe);
> -
> -#endif
> --
> 2.43.0

Tested-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@protonma=
il.com>

