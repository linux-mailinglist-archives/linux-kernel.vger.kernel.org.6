Return-Path: <linux-kernel+bounces-234022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006EC91C0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F141F21F41
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846591C0DC5;
	Fri, 28 Jun 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXHgSbuy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F91C006F;
	Fri, 28 Jun 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585048; cv=none; b=sIoKENFUdkzZaBJ7eWbPW2LEllOB/kkSAqChsvTnpJ076P+pU5B8BAFnVTFy4dRbZbnwq3OxLeRWyu5i/yrfitflwuq/1cu75GceIsZ6Gic9VUOgSndFiyRB9fLkhW8sIl2xIP4+8Lpy2IAu7r6oG9nHZnN/1qnJJOsXLsKpUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585048; c=relaxed/simple;
	bh=G/YKMmh5ynJkRfR1KCNhOSc5Vr29OJN/VYhFGy2/5yQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hVgsCL0uCzd/XwavBXlLbI+6PauV3nqxJVZf/r44b6L3PVyIaqL017DRr3YgAM9N6VA+bVMU65nMSY8w8d987FAenKRbKhf/uY6o2ERdPnKaxXtNdKwIVHDcnc65Mr6ePLwCjJxflmurGPnZK11h7u8mFYqFdjs2ObsGy9oTG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXHgSbuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD37C32786;
	Fri, 28 Jun 2024 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719585048;
	bh=G/YKMmh5ynJkRfR1KCNhOSc5Vr29OJN/VYhFGy2/5yQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZXHgSbuyQK14CZx0u1ouwH0oc+IQtz6DNsl1/PFhPv5aVfinNltzKc1+6dOLsgmJo
	 viXW1oEz7FVtkDrlC+YgYMnSogTcWsQSwW0V6yURaqbpBbvesMmEmvj90wZ5xVPJII
	 ibMwE6iHckikog8reA3RROgXnzDl62uRz6B0TDeMgXPY1IsNJy6jDwzNTRw+85tR63
	 LHXLasCoTIaDIi/mgv4xkt/AG05wPnXwZdvnGbs8CyWk+iU9v7C4c6eZf5dNptyJx0
	 vTkNrTnwYrHisxE3o5C4J4CR1SptGx51+oibmkXlvb5FTC9prrCBvmch7ytWlTF7Ww
	 bbp/iOCDFmXFw==
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
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
Subject: Re: [PATCH v4 0/7] dt-bindings: mfd: syscon: Document more
 compatibles and require simpe-mfd description
Message-Id: <171958504286.3306667.1828808107260619095.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 15:30:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 27 Jun 2024 12:32:16 +0200, Krzysztof Kozlowski wrote:
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


