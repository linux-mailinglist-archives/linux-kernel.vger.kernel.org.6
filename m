Return-Path: <linux-kernel+bounces-548844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2A0A549EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BAD1888348
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0720A5D5;
	Thu,  6 Mar 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyAOGc7j"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C02080F9;
	Thu,  6 Mar 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261669; cv=none; b=EDMWxAl5yrxJRNJpe5FDodoIWhY7S4ZKjqmcexSKJaLBu9zmbuCyQxQpkK+V/pGIrh+HPYTfMaOKAnASx9DZILGtNN9GezjPQhIQbT0OBcOysBrLVwjDr1yxkMEC/LzWAimhYltgkPdm7hh45G/sSQ6ym0W0GkVDiCitkXiszYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261669; c=relaxed/simple;
	bh=dEJU0Oe1WgC6cKTgwv4DNPi2NzyjIhMtHcYQU2kxbYM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D6ZZRTJTqhYlRvIku8muIIIXpYynfWZRJwfcSO+py7ij3Noto3zNR7j1YuS0Y2LGe/qZn0x/SnJE7Mj/ojFuFK31rtp/bhOzG6HYsAmY8tBGANNYed9bGKjEe8Cbnkx6IlrFcT8f9PJTh04G3Hh08ij9pWTb3g0l1IB5njdyffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyAOGc7j; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e4c0c12bccso947985a12.1;
        Thu, 06 Mar 2025 03:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741261666; x=1741866466; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeRfzX4J4SSpOIDf0qW1PY6Ceutjf1oaVySsSvMl5vc=;
        b=IyAOGc7jGoPRVUbPNa857B1rMofSHQAso4WTYZfOW9bDlYfpReel/v5x6sduq1lpK+
         HYZMkZL2EHRbOw0i7xvB0uZjuDMZae2X2OiKiC1EQZwm+Oxf9lsycycvCA6pP/qli1Ee
         MTKRX5wU3kywsMVsYROyrQV6FtEO0MMLTftds7+TuZ28sCt5FI2Jx0oCt/K/PPV636A/
         IQnrFeDGTe+I7yoTiPHq05b/og+aqTbrD+AiReeYYYXviVip4RbL/2jj3ORN/b+Q/vLw
         /5h/FzQNU7kzd7OtboZ2tmYfbiLREU/oAYgmZyq2SFmdMJmnVqYgt2ROei3rH3UNqpmD
         zEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741261666; x=1741866466;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeRfzX4J4SSpOIDf0qW1PY6Ceutjf1oaVySsSvMl5vc=;
        b=g5Aw/dNGAuZ+lM13TlxuzwXupuYF5v6AqOL877aOgU9CuAkfzniBgkyU/sGjnFs0W0
         +2kkzUlv5BKg7dKVvyYxj5Mm5dgdWanZ/qon2HDs8zjZKLycreJq7mJ+DO/FzdGcBGf/
         XdOHYSYu0zYlTjh0CRdTYK/4F2Ds3IMhSwqeW7ggy1o6m17TqrYx9en5IFJjvBovpRiV
         yO3QP+BTdpw0eAiuKTr7YyhrnECBOBJ5V32iGc405RqFoT4ge3FRCxbJPOefopF2xnzl
         O4l+WwT5qyxtsv0FE0ferYep4skMvDcH5Pej0kbug7MObDRTaoEZ8AADlCS2SmoC8LJs
         9+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI024+2JhlGh2FB8vGltgy9rZwhdvRZXS6vMwiyZ4qJy+Pkibc1E+SV261malMSAVEMlcHUflFWjMqcAqg@vger.kernel.org, AJvYcCW1a4Pxfw+JWXJYXiVmkJlZsWyYnjawD1leF+s761mmEQnThYCkOBs0dpNe9SjflCppOnMVA5QuJnwU@vger.kernel.org
X-Gm-Message-State: AOJu0YwbuCSwZWWm2Z0eFpAJZ8QdRqdqAotQzNIH4ebmpl3rgSIOZHI7
	zJyb8lSjchr6NkapheEXZgsU06hwLFOhe171NAjepEfwE/Iv3tJ9
X-Gm-Gg: ASbGnct5FAmVuxvlFOn8S7anZLv0sSYuvj7OtuMaDngYgyDgKkJdEodFIphTYj7cgCc
	G0wPH3ijYCsrdo3Z7InSTmplXy3/GaAa9dj3fduyc4RtLMuz2u5dY3/V2eggWa7M2BR9uSkFhWa
	eNLMKKZmMWgb0iWCf4Bvz17UPwBly6uS/6pVnKu6KvMvb/crF1T7q6BdQcC8KRYKsG2KAd+Pb3Q
	P1+OQXsIMJyI4egB/moJt6EeeFDVqx/kaJHrvjYTQ6kT5lsSwv5bcqS6uVnkV2LzhfbF2yA3Ggv
	jJiC3vS61TyEjTqj6lpZf2DT8DBI+pwO36HRv8MVfZyFXTQ3SpLUXdeSjDc72lIWc7xYonWCNAd
	Pp48UUD/hG4OLhVpwdQfCupnZsQ==
X-Google-Smtp-Source: AGHT+IGmWH/iGLqzVwuFP7RJWXn1M1/VMzVhYdWXO/tkwNgc0iTeL4UpWXsQLzyXQnZ0n4LlZ1JcXg==
X-Received: by 2002:a17:906:730d:b0:ac2:63b:6a45 with SMTP id a640c23a62f3a-ac20db4ccd0mr725046966b.30.1741261665523;
        Thu, 06 Mar 2025 03:47:45 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23973a8d0sm82006266b.87.2025.03.06.03.47.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Mar 2025 03:47:45 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 0/6] Add support for RK3588 DisplayPort Controller
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
X-Priority: 3
In-Reply-To: <74c154b6.8c50.1956aa8c8d2.Coremail.andyshrk@163.com>
Date: Thu, 6 Mar 2025 12:47:31 +0100
Cc: heiko@sntech.de,
 neil.armstrong@linaro.org,
 sebastian.reichel@collabora.com,
 devicetree@vger.kernel.org,
 hjc@rock-chips.com,
 mripard@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 yubing.zhang@rock-chips.com,
 dri-devel@lists.freedesktop.org,
 Andy Yan <andy.yan@rock-chips.com>,
 krzk+dt@kernel.org,
 robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1573D5D6-AFED-4D92-8112-B0C6BB52D5FF@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
 <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
 <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
 <44213B17-FE14-4FB8-8319-1E31BBF6EAA0@gmail.com>
 <74c154b6.8c50.1956aa8c8d2.Coremail.andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)


> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w dniu =
6 mar 2025, o godz. 09:53:
>=20
>=20
> Hi,
>=20
> =E5=9C=A8 2025-03-06 16:42:00=EF=BC=8C"Piotr Oniszczuk" =
<piotr.oniszczuk@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>=20
>>> Wiadomo=C5=9B=C4=87 napisana przez Andy Yan <andyshrk@163.com> w =
dniu 6 mar 2025, o godz. 01:59:
>>>=20
>>>=20
>>>=20
>>>=20
>>> Both of the two config options should be enabled.
>>> andy@Pro480:~/WorkSpace/linux-next$ rg DW_DP .config
>>> 4044:CONFIG_ROCKCHIP_DW_DP=3Dy
>>=20
>> here i=E2=80=99m a bit lost=E2=80=A6.
>> greping on full kernel sources (with applied =
https://patchwork.kernel.org/project/linux-rockchip/list/?series=3D936784)=
 gives me no single appearance of ROCKCHIP_DW_DP=E2=80=A6
>> Do i miss something?
>=20
> see PATCH 3/6:  =20
>=20
>=20
> diff --git a/drivers/gpu/drm/rockchip/Kconfig =
b/drivers/gpu/drm/rockchip/Kconfig
> index 26c4410b2407..c8638baf9641 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ROCKCHIP
> select DRM_PANEL
> select VIDEOMODE_HELPERS
> select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
> + select DRM_DW_DP if ROCKCHIP_DW_DP
> select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
> select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
> select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
> @@ -58,6 +59,12 @@ config ROCKCHIP_CDN_DP
>  RK3399 based SoC, you should select this
>  option.
>=20
> +config ROCKCHIP_DW_DP
> + bool "Rockchip specific extensions for Synopsys DW DP"
> + help
> +  Choose this option for Synopsys DesignWare Cores DisplayPort
> +  transmit controller support on Rockchip SoC.
>=20
> =
https://lore.kernel.org/linux-rockchip/047EECFC-7E55-44EC-896F-13FE04333E4=
D@gmail.com/T/#m178a325ea0ebc64187aae474d77c3f7a9e0bc93d
>>=20


Ah my bad!
One patch patch was commented - so not all dp code was applied.

Now it is much better:

root@myth-frontend-56b0f018b5e0:~ # dmesg | grep drm
[    9.795380] panthor fb000000.gpu: [drm] clock rate =3D 198000000
[    9.796257] panthor fb000000.gpu: [drm] mali-g610 id 0xa867 major 0x0 =
minor 0x0 status 0x5
[    9.796262] panthor fb000000.gpu: [drm] Features: L2:0x7120306 =
Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
[    9.796265] panthor fb000000.gpu: [drm] shader_present=3D0x50005 =
l2_present=3D0x1 tiler_present=3D0x1
[    9.851869] panthor fb000000.gpu: [drm] Firmware protected mode entry =
not be supported, ignoring
[    9.851921] panthor fb000000.gpu: [drm] Firmware git sha: =
814b47b551159067b67a37c4e9adda458ad9d852
[    9.852127] panthor fb000000.gpu: [drm] CSF FW using interface =
v1.1.0, Features 0x0 Instrumentation features 0x71
[    9.852436] [drm] Initialized panthor 1.3.0 for fb000000.gpu on minor =
0
[   10.003108] rockchip-drm display-subsystem: bound fdd90000.vop (ops =
vop2_component_ops)
[   10.004705] rockchip-drm display-subsystem: bound fde60000.dp (ops =
dw_dp_rockchip_component_ops)
[   10.006085] rockchip-drm display-subsystem: bound fdea0000.hdmi (ops =
dw_hdmi_qp_rockchip_ops)
[   10.006679] [drm] Initialized rockchip 1.0.0 for display-subsystem on =
minor 1
[   10.006737] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes
[   10.007663] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes

Unfortunately still nothing on screen

dri state: =
https://gist.github.com/warpme/5e971dfd2e9fd52fae76641831cebe46

and kernel dmesg https://termbin.com/r0m3

i=E2=80=99m not sure what is missing (some dts enablement or=E2=80=A6.)
 =20







