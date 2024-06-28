Return-Path: <linux-kernel+bounces-234021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172291C0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD8282C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9C11C004D;
	Fri, 28 Jun 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEm0dkE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D610B645;
	Fri, 28 Jun 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585043; cv=none; b=kjRFR72Two3L3TXKCVgHQ3WjsAfCw9fjwGihkDk1XNrf2K3pmn4txrHdHfQ0ioPsxRd6/AdIgnOe7w7xwy+MfFluLQCL30X3ARKaU1P/5DRpx8cdssNtO2DtF2ssCeY5d8dshcbeHUAB6I6eLva3+sZNOJOSoGyYFqe5jmR4Ezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585043; c=relaxed/simple;
	bh=/WL5WbmLDaPp407+RLqwWYRH8m1SF1h+OQOP9m79KB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rsjR8542Ti6SHrzjiNfBnFmvvFLQttGq4s2b9oz7uZtMmooRD0SWBiJlL+1PxjoddMxjU/54XLy7WFIBuVtxkkzLnQLL7fh6ciCBxbRf9ZJ8WAhJCZilCLonBMyN9krqKmimMIs/+kZ3HN3GUdYI+crSyCP6qd0TsnitMXGsPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEm0dkE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA49C116B1;
	Fri, 28 Jun 2024 14:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719585042;
	bh=/WL5WbmLDaPp407+RLqwWYRH8m1SF1h+OQOP9m79KB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DEm0dkE+IVL8XZqwhVZKkgj452jQQ2dECaYEWhMBWPpi2OZr35sYM4PD36/NzuSmp
	 0yGXa01DVFPklSoZpVWclyBcLG6f/AZlUwZFY5qfisr1/E6MSOQiv2Iu+n6OBT/g58
	 qboa/caSMXgXO3LNJsk+pHriJU0TPRPYHoJOVI6HVPGaL7gl5XwK+Zws+CH35SkZ6S
	 mHg6kSmwLJeNBcp7JxhUIcgcbE1ZdkmabBE7t8qdvonQ0VbJTZC37h0nc9XbOn45nb
	 vkD5jXc7ytZOgV9soLlR9WP2mWltpH00uCkrovYi+zsl3D+3M7gMGIqR2w30b/e8n9
	 UPDLPJ1bN3G6g==
From: Lee Jones <lee@kernel.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Rahul Tanwar <rahul.tanwar@linux.intel.com>, 
 Amireddy Mallikarjuna reddy <mallikarjunax.reddy@intel.com>, 
 "Zhu, Yi Xin" <Yixin.zhu@intel.com>, Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
References: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
Subject: Re: [PATCH v3 0/7] dt-bindings: mfd: syscon: Document more
 compatibles and require simpe-mfd description
Message-Id: <171958503719.3306667.9209937406996217499.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:30:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 26 Jun 2024 12:09:09 +0200, Krzysztof Kozlowski wrote:
> Dependency
> ==========
> Rebased on Lee's MFD tree, because dependency is there already:
> https://lore.kernel.org/all/171828959006.2643902.8308227314531523435.b4-ty@kernel.org/
> 
> Merging
> =======
> Preferrably everything via MFD tree (file/context dependencies).
> 
> [...]

Applied, thanks!

[1/7] dt-bindings: mfd: syscon: Drop hwlocks
      commit: 9e1d9c508ad657b8ca01d5faa5ad6412b5ed6848
[2/7] dt-bindings: soc: sprd: sc9863a-glbregs: Document SC9863A syscon
      commit: 375f375ce42f8700ebafb2271a826deb37355b9d
[3/7] dt-bindings: soc: intel: lgm-syscon: Move to dedicated schema
      commit: 473c6ff312f9cc7d69791843de42f090e84e0555
[4/7] dt-bindings: soc: microchip: sparx5-cpu-syscon: Move to dedicated schema
      commit: 4a3b558d40d18dbad4c6a58093e80b137ffec5ed
[5/7] dt-bindings: soc: ti: am654-serdes-ctrl: Move to dedicated schema
      commit: 662ffb5b0edcbc902bb3185512aa972e6b9e905b
[6/7] dt-bindings: mfd: syscon: Split and enforce documenting MFD children
      commit: 91d5927467b5dc7b87c0283721b3e0e64ed84a77
[7/7] dt-bindings: mfd: syscon: Add APM poweroff mailbox
      commit: 33c0e553c8c3cee355ea7bcd358d653b0f022b2d

--
Lee Jones [李琼斯]


