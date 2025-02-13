Return-Path: <linux-kernel+bounces-513920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AC3A35042
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014BA3ACA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C61266B7C;
	Thu, 13 Feb 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="JLMjc8xX"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A59194AD5;
	Thu, 13 Feb 2025 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739480950; cv=none; b=jbfRKzPtFA9Y2htNGgG/w4MSuMJIgai+whjYlb/fpHdM1SR6PEFMrpv7gVgfiBLskfpaVbm4zdhTOxJRIEaVMa8NjFiNGJZnySgs+4IHxSrVwOLf/eW9hdpSiwn6ds0FhbI99xR2CxlWgvfY8KkZ3HlTFL+6cHKLf6/Ycmwp/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739480950; c=relaxed/simple;
	bh=Y1I3Wu3T4m+Mdyx3XS2h7cgF7AqOrEoM3WwaR3Wyx78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll71opfULzK53W7AnFEXGGKble2zi2P9VHKf0OTixiozvvEG83zYU565aX+Kh0TRIf+qPq5lmiE1/DexA+bGEi4fFscKEGCzF82GQMdZUwqVI0wHlRHobzKnVrZOiHrgb8l9ztKNpbcnij3/RLwiHOidAFWlMUjHRnNgRkDeyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=JLMjc8xX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DJwimBcRqLSyXYEID3ttBpVRmf268sK2AExRPEHgOEI=; b=JLMjc8xXqVS83EWPH15sVxIbDP
	yKlFs7JwlHERsFF56d6h2cSeXBzC7u//NenkcNAvdYiQ09DmQCviukCuQM/igm0UvDRTKpmheit5t
	ZZ+4f4+YcJRNI8Of8AwaytmsdhARr6vLIAGwNYEqPODpOr8SDOK3lkYJzZC9bEzjw4wheLGZjKMRL
	g9dzDWyWxS2pBHaEXZ4EmIzOBz3NmWsueePys4hMtwR4ARF1wBDn/eOYFK0PjlzG3GheAc2LHoodc
	ZOhad2aju/3KBddc2lo3HnKSIBFzMau2WgSWDjSQAeIA8nldPw1xHWU9+zmP/uk3Se9MfxZFg4a/c
	+Dgof7Sg==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tigSG-0006a0-Mn; Thu, 13 Feb 2025 22:09:04 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: vkoul@kernel.org, kishon@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quentin.schulz@cherry.de, sebastian.reichel@collabora.com,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, dse@thaumatec.com
Subject: Re: [PATCH v6 0/2] MIPI DSI phy for rk3588
Date: Thu, 13 Feb 2025 22:09:03 +0100
Message-ID: <6831884.31tnzDBltd@diego>
In-Reply-To: <20250213210554.1645755-1-heiko@sntech.de>
References: <20250213210554.1645755-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Donnerstag, 13. Februar 2025, 22:05:46 MEZ schrieb Heiko Stuebner:
> This adds the phy driver need for DSI output on rk3588.
> 
> The phy itself is used for both DSI output and CSI input, though the
> CSI part for the whole chain needs a lot more work, so is left out for
> now and only the DSI part implemented.
> 
> This allows the rk3588 with its current VOP support to drive a DSI display
> using the DSI2 controller driver I'll submit in a next step.
> 
> Only generic phy interfaces are used, so the DSI part is pretty straight
> forward.
> 
> changes in v6:
> - rebase onto 6.14-rc1
> - add Krzysztof binding review
> - v5 was sent at the beginning of december '24, so probably has been lost
> 
> changes in v5:
> - add bitfield.h for the FIELD_PROP definition
>   (reported by kernel-test-robot)
> - add Sebastian's Reviewed-by
> - add Conor's Ack to the dt-binding
> 
> changes in v4:
> - moved to #phy-cells = 1 as suggested by Sebastian, with the argument
>   denoting the requested phy-type (C-PHY, D-PHY). This works similarly
>   how the Mediatek C/D-PHY already implements this, see mails around:
>   https://lore.kernel.org/all/20230608200552.GA3303349-robh@kernel.org/
> - dropped Krzysztof's review tag from the binding because of this
> - dropped custom UPDATE macro and use FIELD_PREP instead
> - build a FIELD_PREP_HIWORD macro for the GRF settings
> - add received Tested-by tags
> 
> changes in v3:
> - add Krzysztof review tag to the binding
> - address Sebastian's review comments
>   - better error handling
>   - dropping empty function
>   - headers
>   - not using of_match_ptr - this should also make the
>     test-robot happier
> 
> changes in v2:
> - fix error in dt-binding example
> - drop unused frequency table
> - pull in some more recent improvements from the vendor-kernel
>   which includes a lot less magic values
> - already include the support for rk3576
> - use dev_err_probe
> 
> Heiko Stuebner (2):
>   dt-bindings: phy: Add Rockchip MIPI C-/D-PHY schema
>   phy: rockchip: Add Samsung MIPI D-/C-PHY driver
> 
>  .../phy/rockchip,rk3588-mipi-dcphy.yaml       |   87 +
>  drivers/phy/rockchip/Kconfig                  |   12 +
>  drivers/phy/rockchip/Makefile                 |    1 +
>  .../phy/rockchip/phy-rockchip-samsung-dcphy.c | 1604 +++++++++++++++++
>  4 files changed, 1704 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-mipi-dcphy.yaml
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-dcphy.c

Forgot to transplant from the v5 cover-letter - the series got a 

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

on RK3588 Tiger with Haikou Video Demo in [0]


[0] https://lore.kernel.org/r/63cda072-3671-42c9-9650-7a3ece39dec6@cherry.de




