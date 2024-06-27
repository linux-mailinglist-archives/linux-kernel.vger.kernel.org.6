Return-Path: <linux-kernel+bounces-231992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C982191A147
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E36D2831F3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3709678C9A;
	Thu, 27 Jun 2024 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hyj8fE5Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0581CAB3;
	Thu, 27 Jun 2024 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476342; cv=none; b=lEPLQnWRWvwzOhCmBP8CeojQOUm4Rsx8X4WzUMwcw+4KMEtDeoQaud+52F7jiC9Df303/cICv3rA0K56D1XvlCgconUPVPn1NwsB9XgZnQ13fbq5XClCKTm3x7dvslv1fkLzvqBdSYUlBnEv1dtTZv6Xkn1NO9fqnjJ7IQlu+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476342; c=relaxed/simple;
	bh=iVl5R4+HXbf/5A+fy4DPGQQgVODrP+GEinz+6PySv8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT5QaFgvyMA/DyVjwJIb6KohxMasycE9z/BjoKzwVml14UVCWLRPCITVuRxbougsa4PR+GTIjpk/wgGZ0jutI5SFA1O4w3ZCqC67b8+K3FtNcuqFYigADyHH49IWBgouNjyMmg0KpQJSMnYCN2nLPiaYzioA2KxEWS765NE2zbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hyj8fE5Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81ACC2BBFC;
	Thu, 27 Jun 2024 08:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719476341;
	bh=iVl5R4+HXbf/5A+fy4DPGQQgVODrP+GEinz+6PySv8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hyj8fE5QZpbW9ucDN27Qui9TvgPDrMEcdEC0Ax958ZvsoFqDYu6yUwBvGdBfdNtOT
	 uZfMGMTqS/xKoEveEaocX2IfvAGwL62tEoRA1uV4e3ilcBKui2tGU1+hrwK95b0sL9
	 xg6LTHPZjhS9AyRYRz4h16Hf5RCoYncgGhbsMufJU0yN0Hklajo/TeRa/TK7h7jQC2
	 FDOrt0GSx65j2k2Kx/zbOqOM0ox/XMQOSWs8l/0Fnb5G17x0pBO3Fqcwigt3rAg8e3
	 dNBCHB/iDYsYYY0BLsc1OKY54R+jwAE5IsyKcW5BHL48cU9lxLvSNESSHHDluPwM5H
	 D/l0CGwT9LfHQ==
Date: Thu, 27 Jun 2024 09:18:53 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chuanhua Lei <lchuanhua@maxlinear.com>,
	Rahul Tanwar <rtanwar@maxlinear.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Nishanth Menon <nm@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rahul Tanwar <rahul.tanwar@linux.intel.com>,
	Amireddy Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
	"Zhu, Yi Xin" <Yixin.zhu@intel.com>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v3 0/7] dt-bindings: mfd: syscon: Document more
 compatibles and require simpe-mfd description
Message-ID: <20240627081853.GF2532839@google.com>
References: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>

On Wed, 26 Jun 2024, Krzysztof Kozlowski wrote:

> Hi,
> 
> Dependency
> ==========
> Rebased on Lee's MFD tree, because dependency is there already:
> https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/
> 
> Merging
> =======
> Preferrably everything via MFD tree (file/context dependencies).
> 
> Changes in v3
> =============
> - Add tags
> - intel,lgm-syscon: change maintainers (email bounce)
> - syscon/Split: drop unneeded |, use const instead of enum in select:
> - Link to v2: https://lore.kernel.org/r/20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org
> 
> Changes in v2
> =============
> - Add acks
> - lgm-syscon: add ranges to binding and example
> - syscon.yaml: add big select with all compatibles for older dtschema
> - Link to v1: https://lore.kernel.org/r/20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org
> 
> Description/problem
> ===================
> Simple syscon nodes can be documented in common syscon.yaml, however
> devices with simple-mfd compatible, thus some children, should have
> their own schema listing these children.  Such listing makes the binding
> specific, allows better validation (so the incorrect child would not
> appear in the simple-mfd node) and actually enforces repeated rule for
> simple-mfd devices:
> 
>   "simple-mfd" is only for simple devices, where the children do not
>   depend on the parent.
> 
> Currently the syscon+simple-mfd binding is quite broad and allows
> any child or property, thus above rule cannot be enforced.
> 
> Solution
> ========
> 1. Split the syscon.yaml binding into common syscon properties, used
>    potentially by many bindings, and only simple syscon devices (NO
>    simple-mfd!).
> 2. Move some known simple-mfd bindings from syscon.yaml to dedicated
>    files.
> 
> This patchset might introduce new dtbs_check warnings for devices having
> simple-mfd and being part of syscon.yaml previously. I fixed some of
> them, but probably not all.
> 
> Best regards,
> Krzysztof
> 
> To: Lee Jones <lee@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Lars Povlsen <lars.povlsen@microchip.com>
> To: Steen Hegelund <Steen.Hegelund@microchip.com>
> To: Daniel Machon <daniel.machon@microchip.com>
> To: UNGLinuxDriver@microchip.com
> To: Nishanth Menon <nm@ti.com>
> To: Matthias Brugger <matthias.bgg@gmail.com>
> To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> 
> ---
> Krzysztof Kozlowski (7):
>       dt-bindings: mfd: syscon: Drop hwlocks
>       dt-bindings: soc: sprd: sc9863a-glbregs: Document SC9863A syscon
>       dt-bindings: soc: intel: lgm-syscon: Move to dedicated schema
>       dt-bindings: soc: microchip: sparx5-cpu-syscon: Move to dedicated schema
>       dt-bindings: soc: ti: am654-serdes-ctrl: Move to dedicated schema
>       dt-bindings: mfd: syscon: Split and enforce documenting MFD children
>       dt-bindings: mfd: syscon: Add APM poweroff mailbox
> 
>  .../devicetree/bindings/mfd/syscon-common.yaml     |  71 +++++
>  Documentation/devicetree/bindings/mfd/syscon.yaml  | 306 ++++++++++++---------
>  .../bindings/soc/intel/intel,lgm-syscon.yaml       |  57 ++++
>  .../soc/microchip/microchip,sparx5-cpu-syscon.yaml |  49 ++++
>  .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    |  55 ++++
>  .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      |  42 +++
>  6 files changed, 457 insertions(+), 123 deletions(-)
> ---
> base-commit: 8dc7c29f608649f3d9eca826e9d4fe4b8a32c472
> change-id: 20240517-dt-bindings-mfd-syscon-split-37e23996523d

Okay, I tried to apply these whilst fixing up all the conflicts, but
lost the will to live.  Please rebase and [RESEND].

-- 
Lee Jones [李琼斯]

