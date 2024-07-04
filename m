Return-Path: <linux-kernel+bounces-241484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD8927BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DE028AAC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05EB1B3F2D;
	Thu,  4 Jul 2024 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="deRXnyC1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764541B151F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720113041; cv=none; b=t6+wOsRo85COwU4KWhmf1uvgpFVe+oH3sp5cro0b7W4WwU3bMQP06Z2N+tosi2GfPIHWuHdGTLdwYBfJPE1ICAzBHVRCozIRCYDWY25bF+rLyse1DJi2yMZXlRWxNOOUrmzd+f0GEHBU76uIC1wyZyNgAJ/Oaz6e0zkdwsNnJDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720113041; c=relaxed/simple;
	bh=KPHOcd8xOVqXjxDDUIb/H8iK/xQwdrfcnmftClPv6B8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d562C62RSLpu2LGCyaVXfVT7gCo40mTPtcvC665z2Vt22wyDuP8uUGo4naOUtYsiLC5ZPpzt3p01l2+l6IMEE6/sOyylpu2nS8Jg69MM1vaV1yLiyt6lAdv7/XsFBj8YIx79qbu+sf1E/ugAR3UXYQb/IpTkuVK/r0wIcdtP4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=deRXnyC1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720113037;
	bh=KPHOcd8xOVqXjxDDUIb/H8iK/xQwdrfcnmftClPv6B8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=deRXnyC1lRbV3rtJxF/iWlseoOQZzKJXSCBMfUmwhbJWBZxId1PCN3xDjsc3bFNRu
	 97a80RlMeKWOS0LvINVcl4kPV7ENt5RxtOMUnkR17jffwZPGvU3eYWNNiQo2wTdycT
	 tLUF7N13u5Ly4tTo4tZUmSel6m0jRR6TGX51sYxv/iGEWI0L0wk4qWZLzU83Imj0n6
	 f60Z48JjUBboFN9w2boPz3tvRtXFswqcY+mXe5adpjFMEr4BwG3vGtJu5V4ai09fV7
	 WqtS1z/7enXA83qqpY8qRckT01ApHd0P8aDoaGMiIe2g0Dp5upsOrKh5Gy2th1mJHh
	 U5TGClBedyA5A==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1BD8F378219E;
	Thu,  4 Jul 2024 17:10:37 +0000 (UTC)
Message-ID: <81bd0794ff2731c8ca38069a872649e007340802.camel@collabora.com>
Subject: Re: [PATCH 00/13] rockchip: Enable 4K@60Hz mode on RK3228, RK3328,
 RK3399 and RK356x
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org, Diederik
 de Haas <didi.debian@cknow.org>, kernel <kernel@collabora.com>
Date: Thu, 04 Jul 2024 18:10:36 +0100
In-Reply-To: <20240615170417.3134517-1-jonas@kwiboo.se>
References: <20240615170417.3134517-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jonas,

[ + Diederik who has already done some testing ]

On Sat, 2024-06-15 at 17:03 +0000, Jonas Karlman wrote:
> This prepares and enable use of HDMI2.0 modes, e.g. 4K@60Hz, on RK3228,
> RK3328, RK3399 and RK356x.
>=20
> Patch 1-3 fixes some issues to help support use of high-resolution modes.
>=20
> Patch 4 fixes reading of EDID on RK3328 when using a forced mode.
>=20
> Patch 5-7 adds hdmiphy rate validation in mode_valid so that HDMI2.0
> modes can be enabled on RK3228 and RK3328.
>=20
> Patch 8-11 modify phy, current and mpll tables to match what ChromeOS
> and vendor kernel use. These patches originate from old ChromeOS and
> vendor kernels and have successfully been used in LibreELEC distro for
> the past few years.
>=20
> Patch 12 enables use of HDMI2.0 modes on RK3399 and RK356x.
>=20
> Patch 13 help fix use of console at 4K resolution on RK3399.
>=20
> This series may not fully depend on but was only tested together with
> the series "drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID
> cleanup" at [1].
>=20
> I have tested 4K modes on following devices:
> - Asus TinkerBoard (RK3288)
> - Pine64 Rock64 (RK3328)
> - Radxa ROCK Pi 4 (RK3399)
> - Radxa ROCK 3A (RK3568)
>=20
> A copy of this series can also be found at [2].
>=20
> [1] https://patchwork.freedesktop.org/series/134727/
> [2]
> https://github.com/Kwiboo/linux-rockchip/commits/next-20240531-rk-dw-hdmi=
-v1/


I tested this patch series (together
with=C2=A0https://patchwork.freedesktop.org/series/134727/) on a Radxa ROCK=
 4SE and
things appear to work quite well - other than the hotplugging issue describ=
ed
below.

One problem I did see during testing was in SOME cases, hotplugging a 4k60
monitor didn't seem to show a console or anything on the HDMI output after
replugging (e.g the display shows "no signal"). Sometimes this happened aft=
er
the first hotplug, other times it needed a couple of hotplugs to occur. And=
 in
other cases it doesn't happen at all. But once it occurs, there doesn't see=
m
to be any way to get the device to start transmitting and a reboot (not har=
d
boot) is needed. It's not clear why it gets into this state.

Another way of getting the device into this state is connecting a 4k60 scre=
en,
then connecting a separate 1080p screen (it's not clear if changing the
resolution from Linux causes the same behaviour), then reconnecting the 4k
screen. In this case, there is no output from the HDMI port. This happens
pretty consistently.

For the record, with libreelec kernel patches for 4k60 applied to kernel
5.something, the above hotplug behaviour does not occur. So it must be
something introduced in this patch series ?


I wonder if you can confirm this bug ?

I will refrain from adding my Tested-by for now.


Thanks

Chris


