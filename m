Return-Path: <linux-kernel+bounces-513221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0CFA3448C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7F93B0728
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EEB153598;
	Thu, 13 Feb 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY5ycHhJ"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1214AD2B;
	Thu, 13 Feb 2025 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458458; cv=none; b=OiEpeBqpUfkO3JCbqobiRqF1zeQmqBokit3E/ieCVnde+s0YFn9LGgVvBFzegf5TIr0D4bbkEe1wCXuH/FAMPA0vr5fcyoe84yDoluEgx7oREQf1Qzdyc4UjvimUg08QYmni3JQ+TH44t6+7CfHqAfzyB4YsmXB0icFFgyNoxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458458; c=relaxed/simple;
	bh=et8g6XjkVCDTaLLFWWxZjOUmP09hKqZH4LcW4kk8EYY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ntvvl2TREqzF7B40N/zywFg0GzPTpYO4fKyWDXIGm5Zhn19Fk9gTmbPlqiG4najzlL62NahhR9bOFIpH8rnNddS04bSLxztxG8rNKxvYQUwVwzf3Uzbk3g9v/xQijjggOZWnS3Ftb/ZtaOipDJH751xJIGXIexxNfk7QSMYrEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY5ycHhJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab78e6edb99so156305066b.2;
        Thu, 13 Feb 2025 06:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739458454; x=1740063254; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUwOmDEJF2wOs2nTiLIA+I47nkpCmb6VTNh/7P12ZFk=;
        b=XY5ycHhJR7XQwQrYzrVE5F7H7KcLjbgLibrSgAu+AieW4VymMmt/S1TXC4mjRRDp39
         kqi8YcyxExIGMRQMl1duEWA7JczWGkIyaUujotmCJbv/5EAChxBpjq92j4eOdh5t45k7
         49Qf+PGuBMQTZcvbHw82hwtN1r7AjuRKXAdVT+3g8H4ZSwhV9Ro3alneDBc/IX2q+snB
         KQIlRui83EINoQK+5qEX21bfdfy/1/VZnOV29ScCDkBLazEv0cj1g+QCOkLvU42N9m1w
         YHiIwjzaasDuTzG2PpB0ZLX9bJ5RTvgp/S3MWHukdRxypHBIgdhQGMMyQQEyeiQxN/UC
         whaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739458454; x=1740063254;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUwOmDEJF2wOs2nTiLIA+I47nkpCmb6VTNh/7P12ZFk=;
        b=G5DB+4s9Al4u3pk0IuCfADj6T0Cz/nwOvvdyV7F3LXnmRzfX1zNKUMXePTJCNcpl86
         WWX5tLJz47yIVlmQf5ZMJnLJZ1eVnZEwFwcb7Zzno6Kq5ko+LvuMitTVw7EgYn0wzkZe
         nOx0M8shrlgyIQtTwRUzYVCsjrpHgZyN4RegN+kQ87NcNl4YMwBD50BjGRMrPrT5wukg
         33E1JJu8C2vntKnfBRSLAeP7nOUbJxWzfkzYUVQWpVej0BFZzp9W0nmmCys4uXcdJsEa
         +XzY5Fd+5tBlpPztJ8Sy94daFa7WlR28e51Ujfda4y9Hkei2UQ9IxMvLBIm8/7PPQS3R
         VAyA==
X-Forwarded-Encrypted: i=1; AJvYcCWFk/9Bn2vJjhYSxisUIxdAXs99Mu4ZiZ2ZJLGHMUe75a5zGt/Fekmiyz1bQg+Ge8Kg/we7lJu18YH7@vger.kernel.org, AJvYcCWeJ1U7fF7b5Yx1/ygaAXRIqReIXe9Ia+WbM6qzaJPVg60fK/kcZsT0p5AULpidlBqUjF0EuVnBGFl+4j1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoz2t9xj7qr38vSRjJHH1O6RPMQn+onRUZKrcMy0mBxeSPmd5M
	qreiDjflYNejQ3GGNi9CFNLM2NDhPJlCaMNlKFX+3tDIkSB7h1a2
X-Gm-Gg: ASbGncsE5z3uEJksCscxG6T8MeJipFPRnSJb/RxOTgLXUmoroQmCTJMMPqCfAq5mt8n
	YNJA010tZGhmMP/HGe7Lwizvl9PUKFfKUzUCQqbrUWKSKa822FKSHv6hPsfbhQz6H0laJygfzL+
	ce6ZshAuLbiQw77NpvGkctnVrrJQKNq3J7iDdLZwftoTkHzyf2VUVpzeJRYXiEWl2Si3M7cupXr
	WoTzCDO5tHu+PGd1SnJxzoz1F3u5RL33/dToOYamaXKK7El9ChuN5u0+JZoxDPEAsQFQ8luxLeS
	SmPlA7Yup4oks2HVP1re+lU/MPV0qoZLmoFGWye1yQ+6eNJpJy2uwglLzSScVxm10zMu/mjN
X-Google-Smtp-Source: AGHT+IHRjDETV8MTnwCbNtSq+kIovSq5moe9v0r+//O++wk+ZnIkHd4F+W0Aw7g4U3jTuMaXq46XsQ==
X-Received: by 2002:a17:907:7207:b0:ab2:db7b:5db3 with SMTP id a640c23a62f3a-ab7f34e7515mr682372866b.54.1739458454075;
        Thu, 13 Feb 2025 06:54:14 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322c4sm146145866b.34.2025.02.13.06.54.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2025 06:54:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v6 00/14] Add eDP support for RK3588
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250123100747.1841357-1-damon.ding@rock-chips.com>
Date: Thu, 13 Feb 2025 15:54:00 +0100
Cc: heiko@sntech.de,
 robh@kernel.org,
 conor+dt@kernel.org,
 algea.cao@rock-chips.com,
 rfoss@kernel.org,
 devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 sebastian.reichel@collabora.com,
 dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com,
 kever.yang@rock-chips.com,
 dmitry.baryshkov@linaro.org,
 vkoul@kernel.org,
 andy.yan@rock-chips.com,
 krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <5044FFCB-B325-40D0-BA82-03AF64EAF029@gmail.com>
References: <20250123100747.1841357-1-damon.ding@rock-chips.com>
To: Damon Ding <damon.ding@rock-chips.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Damon Ding =
<damon.ding@rock-chips.com> w dniu 23 sty 2025, o godz. 11:07:
>=20
> Picked from:
> =
https://patchwork.kernel.org/project/linux-rockchip/list/?series=3D923593
>=20
> These patchs have been tested with a 1536x2048p60 eDP panel on
> RK3588S EVB1 board, and HDMI 1080P/4K display also has been verified
> on RK3588 EVB1 board. Furthermore, the eDP display has been rechecked
> on RK3399 sapphire excavator board.
>=20
> Patch 1~4   are preparations for the RK3588 eDP support on both =
Analogix
>            side and Rockchip side.
> Patch 5~8  are to support to get panel from the DP AUX bus.
> Patch 9~11 are the RK3588 Analogix DP driver support.
> Patch 12    is to add the power sequencing delays for panel model
>            LP079QX1-SP0V.
> Patch 13    is the addition of RK3588 eDP0 node.
> Patch 14    is to enable the eDP0 display on RK3588S EVB1 board.
>=20
> Damon Ding (14):
>  drm/rockchip: analogix_dp: Replace DRM_...() functions with drm_...()
>  drm/rockchip: analogix_dp: Use formalized struct definition for grf
>    field
>  drm/rockchip: analogix_dp: Expand device data to support multiple edp
>    display
>  drm/bridge: analogix_dp: Add support for phy configuration.
>  dt-bindings: display: rockchip: analogix-dp: Add support to get panel
>    from the DP AUX bus
>  drm/bridge: analogix_dp: support to get &analogix_dp_device.plat_data
>    and &analogix_dp_device.aux
>  drm/bridge: analogix_dp: Add support to get panel from the DP AUX bus
>  drm/rockchip: analogix_dp: Add support to get panel from the DP AUX
>    bus
>  dt-bindings: display: rockchip: analogix-dp: Add support for RK3588
>  drm/bridge: analogix_dp: Add support for RK3588
>  drm/rockchip: analogix_dp: Add support for RK3588
>  drm/edp-panel: Add LG Display panel model LP079QX1-SP0V
>  arm64: dts: rockchip: Add eDP0 node for RK3588
>  arm64: dts: rockchip: Enable eDP0 display on RK3588S EVB1 board
>=20
> .../rockchip/rockchip,analogix-dp.yaml        |  25 +-
> arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  28 +++
> .../boot/dts/rockchip/rk3588s-evb1-v10.dts    |  54 ++++
> .../drm/bridge/analogix/analogix_dp_core.c    |  76 +++---
> .../drm/bridge/analogix/analogix_dp_core.h    |   1 +
> .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  52 ++++
> drivers/gpu/drm/panel/panel-edp.c             |   8 +
> .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 238 +++++++++++++-----
> include/drm/bridge/analogix_dp.h              |   8 +-
> 9 files changed, 401 insertions(+), 89 deletions(-)
>=20
> --=20
> 2.34.1
>=20

Damon,

I=E2=80=99m playing with hdmi0 port enablement on radxa rock5 itx board =
with 6.14 mainline.

rock5 itx has 2 hdmi ports: hdmi0 is wired to rk3588 typeC1/eDP1 eDP =
with ra620 eDP->HDMI converter and hdmi1 from hdmi/edp tx1
(see page3 & page29 at =
https://dl.radxa.com/rock5/5itx/v1110/radxa_rock_5itx_v1110_schematic.pdf)=


I=E2=80=99m on 6.14-rc2 with applied:=20
[1] Cristicc hdmi code =
(https://gitlab.collabora.com/cristicc/linux-next/-/commits/rk3588-hdmi-br=
idge)
[2] eDP support for RK3588 =
(https://patchwork.kernel.org/project/linux-rockchip/list/?series=3D927765=
)
[3] Add eDP mode support for Rockchip Samsung HDPTX PHY =
(https://patchwork.kernel.org/project/linux-rockchip/cover/20250205105157.=
580060-1-damon.ding@rock-chips.com/)

Is edp1 supported by yours [2] series?

If yes - may you pls hint me about required dts additions in =
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch=
/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts?h=3Dv6.14-rc2 ?

(for reference: rock5 itx bsp dts goes like this: =
https://github.com/radxa/kernel/blob/linux-6.1-stan-rkr1/arch/arm64/boot/d=
ts/rockchip/rk3588-rock-5-itx.dts)

in [2] i see dts adds for EVB1 - but i=E2=80=99m not sure will simple =
extrapolation of evb1 edp0 dts additions to edp1 in rock5 be enough=E2=80=A6=
.

thx in advance!


