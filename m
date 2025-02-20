Return-Path: <linux-kernel+bounces-523549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A3CA3D854
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5527A7428
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E608204698;
	Thu, 20 Feb 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoioMFH/"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FF1FF5F4;
	Thu, 20 Feb 2025 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050200; cv=none; b=IJqAU2CSwo/t8q3vzrVPy80+XfSdHZl7xFHBNFjY26YdeXVj7iBG+rxkA3pQ3zqQGF9RJHdgjhF2U0Zw351+/vI5w7QHmW4kgO9aruqhriBPxKS15RnlkRF4QC/nEBhFQHChTAU41O5QypAnagdnj/lKPGFudBXtajrp3Kqojeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050200; c=relaxed/simple;
	bh=JE2QFEJDOTUcseNdOMCQxx49xsb1gRr4XRQDaNQtwZg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ot3ROtjBgUlEzr/RFwdpx2hdkmY2ZfiMugCXEeQa7edCzT0GXNYlMYO1WONGOr+l+bMY6sgFZ+JKDRS54Ox6WpMy/7mv6eQoYzJeathtvyKFE6NpI9h0qj62TWgyr2l98cfC77UiLSSQbKNBMrDKtitQEjvJbt+wsUjcwOpSI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoioMFH/; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab78e6edb99so114705666b.2;
        Thu, 20 Feb 2025 03:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740050197; x=1740654997; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u33bNsVrNxNtTUoEnhMd7zgtXI5olli4RASjpX/hNKk=;
        b=FoioMFH/MJSkHqY7tbCvcmHEsiiTQ3CXYKDlqbDFGoOwM5Zw9oYjFiOd2CFp9oTl0v
         HYz4WXc5vosuoc6BdEFrLAjVEV7v3sdlHazUBr64yXvqrcmyyHheiFZkzQtN1ucEZOnn
         qnumhHuBqEwcq46aLi3V09YXs4i8MUIFn6G09C5lNX8uMC0G58+ehAcVYSZ2NFHqneBZ
         TYgcQeSzM1OGo7dqsL/+qZFXKY6+8c6W4j4yTf9cSpb1HaF1bpwjrla56t5dhmFIUBsF
         R97iya1DmhJ9zF+xoGoReORUbrZg72Op94l8efripYST7C667F+P5OGYnhzeG8UYBgzT
         RoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050197; x=1740654997;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u33bNsVrNxNtTUoEnhMd7zgtXI5olli4RASjpX/hNKk=;
        b=QM5fLSLZgID028wEB4sh1jUeX3ZFinfWmYyBCC3P9CiUB4aF+1BQHd5RRFhO0XfoWx
         aKh62gOkwe/f34J5c4LVXpB30i7MUNg0XKZlfWN4+FYrUG1+hsYN0a4D5ECu0iqwpAYp
         A2T7I0yxZ0lgxxOjhHodyn5nPCZxdeEb4LHk7+wiKzOoOZwr5IgPtuZWkjA8h6oueYHF
         uc6MH2dwX0blaTSqN8LWmvXFS+acIdX6E4E3fdIDFdAoXOsHH0Gx+421YR3y1M27+AG5
         2k/vZfCOLtJ+kz8AIWCyb36/fIkgv2wvERC4zsOZNM3evTpH1vlw6B5DqqwdrQKC88VL
         ba7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtBT1kVxYUIGBNW6etOIOBkSPDCa2ALdxVw7MAukXXjIq+JR8RgM/lbDvmcJ+iWA1aa0dt+oCZASrn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/bnZ+GFluuxsEyMSjeIrfxIbWix+z5xP3a88ziQ6icXapS/e
	SeQP9XZAkwusc5DOIKvnPIIqw+luFIPKGIUzuyadGqrzSpI1LV8g
X-Gm-Gg: ASbGncu/SNHb4WsNmTagRII/D8/NAaoYDJtH1jkU7UqDAtciaVQZP4xDXTXOD4S+mOT
	VNtuS7THtLdUO1bM5913m6j7laBgHC8dq9IJ3oouG8eG7fM5lZBXq0FFK2pgSNVUImPSeND+WFk
	pyNhTRWANoxclnMFP1W5VAvyKFaKPAydB9qhDNMyfzKWxb7hnbKkOAhkCmMsfg4RNfhndFGTMlA
	41WW7QJ8XVPW1vPnuwJAHdityOYU+uKjxh+OlrpONoiOm8qQVx7XUKloxpV03NS3LPkI0kSmb1Z
	r8l/134tQo/oTT6LirVAbIzi/duVJlUbZ5hmViVg+tUIKrcj9fceJ0j8j9W/Mniw2Ex2knmN
X-Google-Smtp-Source: AGHT+IFmWBcDPInhp9w4btY1qA9eIzy3GXZXztUdnckb0Hqqtby2WfdghhMP/SBKRVAMezhhUK82sg==
X-Received: by 2002:a17:907:3da3:b0:ab7:9b86:598d with SMTP id a640c23a62f3a-abbcce1eeaemr613793166b.17.1740050196513;
        Thu, 20 Feb 2025 03:16:36 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba9bd6e22sm630838366b.121.2025.02.20.03.16.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 03:16:36 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v7 0/3] Add HDMI audio on the rk3588 SoC
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250217215641.372723-1-detlev.casanova@collabora.com>
Date: Thu, 20 Feb 2025 12:16:20 +0100
Cc: linux-kernel@vger.kernel.org,
 Algea Cao <algea.cao@rock-chips.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel@lists.freedesktop.org,
 Niklas Cassel <cassel@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 kernel@collabora.com,
 David Airlie <airlied@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>,
 Robert Foss <rfoss@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org,
 Chen-Yu Tsai <wens@csie.org>,
 FUKAUMI Naoki <naoki@radxa.com>,
 devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B8EF5196-55FB-44EC-B93C-E327C791225B@gmail.com>
References: <20250217215641.372723-1-detlev.casanova@collabora.com>
To: Detlev Casanova <detlev.casanova@collabora.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Detlev Casanova =
<detlev.casanova@collabora.com> w dniu 17 lut 2025, o godz. 22:47:
>=20
> To support HDMI audio on the rk3588 based devices, the generic HDMI
> Codec framework is used in the dw-hdmi-qp DRM bridge driver.
>=20
> The implementation is mainly based on the downstream driver, ported to =
the
> generic HDMI Codec framework [1] recently merged in the master branch.
> The parameters computation has been kept as is and the data stored in =
the
> dw_hdmi_qp struct as been cleaned up.
>=20
> The table for the N values has been edited to reflect N recommended =
values
> as well as CTS recommended values.
>=20
> The downstream kernel also implements a machine driver for HDMI audio =
but
> it is doing exactly what the simple-audio-card driver does, so use =
that
> instead in the RK3588 SoC device tree.
>=20
> This adds HDMI audio support for both HDMI TX ports.
>=20
> *** Dependencies ***
>=20
> Based on Linus' master branch, but also needs Cristian's dts patches =
for HDMI1
> support [2], which depends on Heiko's patchset for
> phy-rockchip-samsung-hdptx [3]. Patches will apply without [3], but =
HDMI will
> not work (at all).
>=20
> [1]: =
https://lore.kernel.org/all/20241224-drm-bridge-hdmi-connector-v10-0-dc895=
77cd438@linaro.org
> [2]: =
https://lore.kernel.org/linux-rockchip/20241211-rk3588-hdmi1-v2-0-02cdca22=
ff68@collabora.com
> [3]: =
https://lore.kernel.org/lkml/20241206103401.1780416-3-heiko@sntech.de/
>=20
> Changes since v6:
> - Fix arguments alignement (checkpatch --strict warnings)
> - Add hdmi1 audio support too
> - Move hdmi0_sound node under hdmi0_out_con
>=20
> Changes since v5:
> - Simplify audio math computation for N
> - Move hdmi0-sound node up with other address-less nodes
>=20
> Changes since v4:
> - Moved hdmi0_audio node the rk3588-base.dtsi
> - Enable hdmi0_audio in rk3588-rock-5b.dts
>=20
> Changes since v3:
> - Renamed function to start with dw_hdmi_qp
>=20
> Changes since v2:
> - Also clear the audio infoframe
> - Write AUDI_CONTENTS0 to its default value in case it gets =
overwritten.
> - Store tmds_char_rate in the dw_hdmi_qp struct in atomic_enable
> - Clear tmds_char_rate in atomic_disable and only write registers when
>   tmds_char_rate is not 0.
> - Do not use connector_state duplicates
>=20
> Changes since v1:
> - Remove useless audio_mutex (was used downstream for multiple drivers =
access
>   to audio functions)
> - Let hdmi_codec build and setup audio infoframes
> - Only access audio registers when connector is connected
> - Rebased on master branch
>=20
> Detlev Casanova (2):
>  arm64: dts: rockchip: Add HDMI audio outputs for rk3588 SoC
>  arm64: dts: rockchip: Enable HDMI audio outputs for Rock 5B
>=20
> Sugar Zhang (1):
>  drm/bridge: synopsys: Add audio support for dw-hdmi-qp
>=20
> arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  17 +
> .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |  17 +
> .../boot/dts/rockchip/rk3588-rock-5b.dts      |  16 +
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c  | 489 ++++++++++++++++++
> 4 files changed, 539 insertions(+)
>=20
> --=20
> 2.48.1
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


Detelv,

Just curious of your opinion:

I=E2=80=99m on 6.14-rc3 and using =
https://gitlab.collabora.com/cristicc/linux-next/-/commits/rk3588-hdmi-bri=
dge + this v7 series.

On mine rock5b all works nicely but - at boot time - i=E2=80=99m getting =
some oops in kernel like this: =
https://gist.github.com/warpme/e1668acbef7817e5d2a88a6840328722

I=E2=80=99m not sure where issue is but it looks to me like kind of =
interference between analog audio and hdmi audio as commenting analog =
audio in dts ( =
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/arch=
/arm64/boot/dts/rockchip/rk3588-rock-5b.dts?h=3Dv6.14-rc3#n24 ) stops =
kernel from oops=E2=80=99ing=E2=80=A6.

 rock5b dts i=E2=80=99m using is like this: =
https://gist.github.com/warpme/a8a32afd4a05d4b7f25d2808984b05ac



