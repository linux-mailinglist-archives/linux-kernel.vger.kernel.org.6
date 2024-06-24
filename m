Return-Path: <linux-kernel+bounces-227905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744FB9157F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114491F21D75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E11A071F;
	Mon, 24 Jun 2024 20:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkXsulp9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC8137748;
	Mon, 24 Jun 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260907; cv=none; b=IeWtHZCwWvgyiBPPNl18LxEDIV2bvhpw49xCi1XJ99Oq5uPZ2uhfYLz3MaNZMTxtONT+8kdvxNezDCa42lE7NHS0iRgW18Im5zPzr2+VrdrD/MvBfQWESnMiH866RDb8FFR8DOqWm0Sn1/SPr2h0JwypB5JpILJ1CVa64ligs98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260907; c=relaxed/simple;
	bh=HL7UJ/iRbKbk7kdt37fx7w1eCbakq9KlVaHHm4Ee8YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmAT/cN/IP4B3f7SwVAl6jWNNG/lODt4ldqh8BVxrdbRtYfPeD9+2JbxEhmQScL3UKfCUrVC4Bst3Igrf0FfpmxRHKIzSdV5YCTCC3STPTDvvLYJqvXKmwzwaOY+MmBnyCZSmmqrGNBdBDT8ZcHUBR/hFMaPx0zp0ZwirKiAdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkXsulp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6A5C2BBFC;
	Mon, 24 Jun 2024 20:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719260907;
	bh=HL7UJ/iRbKbk7kdt37fx7w1eCbakq9KlVaHHm4Ee8YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZkXsulp9syLWY+sZw//zcuqYiWdoQaPOADpd4MwIteCIaoOP0sY9A33y6x3hqYO+K
	 t2kdQ42rzbZdSAypc21O/Afbgu69nRYjwyiGxJ0d9T4MnWiGVpYu3RPulzFnJVjHaF
	 X0xoGKs3Quz3DD2cOKmLYGaCnDd0oYBALak/NfDTDoP4myaqSSFlNl3zYRZyN8F+4q
	 /JdEhATIuiYjypfPK/10zC4yVUg6C0qpN6Ez7QN70UDxCX4UXbqgs/0isgm9V0KZbF
	 zQCp8Ik8aRov4QvKl4pArXh01s/iSpwE4/nneuZNEzms17LnuAw4VMNwcSMnai4acN
	 SdVJnkIRuD7ig==
Date: Mon, 24 Jun 2024 14:28:25 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-mediatek@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-arm-kernel@lists.infradead.org,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Lee Jones <lee@kernel.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	Nishanth Menon <nm@ti.com>, Jacky Huang <ychuang3@nuvoton.com>,
	devicetree@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 6/7] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
Message-ID: <171926090377.354722.8861218849398833034.robh@kernel.org>
References: <20240616-dt-bindings-mfd-syscon-split-v2-0-571b5850174a@linaro.org>
 <20240616-dt-bindings-mfd-syscon-split-v2-6-571b5850174a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-dt-bindings-mfd-syscon-split-v2-6-571b5850174a@linaro.org>


On Sun, 16 Jun 2024 15:19:26 +0200, Krzysztof Kozlowski wrote:
> Simple syscon nodes can be documented in common syscon.yaml, however
> devices with simple-mfd compatible, thus with some children, should have
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
> Split the syscon.yaml binding into:
> 1. Common syscon properties, used potentially by many bindings.
> 2. Simple syscon devices (NO simple-mfd!).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on:
> 1. Patch in MFD: https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/
> 2. Previous patches in the series.
> ---
>  .../devicetree/bindings/mfd/syscon-common.yaml     |  72 +++++
>  Documentation/devicetree/bindings/mfd/syscon.yaml  | 294 +++++++++++++--------
>  2 files changed, 251 insertions(+), 115 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


