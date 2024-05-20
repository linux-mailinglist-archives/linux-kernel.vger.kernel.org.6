Return-Path: <linux-kernel+bounces-184186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFB8CA3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1703D1F21F20
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CE4139CFD;
	Mon, 20 May 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOkwLKD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75BE1D531;
	Mon, 20 May 2024 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239330; cv=none; b=QeNoMLCDQDeoyO8QpDWSHYmkgYY3YyOGy0P37wR5CmlQb5D72/WMaKnEdyfGN188ky3vk3bWv4WAaewaquBNKnyuzBOF0e5UAZwvSIAAYvQnVamcdbRf3fttH1v0B7gEOhCY61JMKHb4fcS83goiEU/M2c9h1N80qs8pPP01QaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239330; c=relaxed/simple;
	bh=KXsctDjiPvmFDLCwn2rtvgL33Mj9ioJK9ltO3XPn0mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZbUz3QX0/X0t5KkBaGSPfPWFubuQV99iX3cmu4IPmqPJYZtrX8b5R2mPhJv/EusOwuO9lkBnamQ5WDS6jH+sHvQ0XHH405IgM1DEX02Q9068D8yhGQLkBsX+/YHktaE7cLCoVc7VXvi3jcxXl75z2mJRtvBjheMmXaGoSXBMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOkwLKD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D29C2BD10;
	Mon, 20 May 2024 21:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716239330;
	bh=KXsctDjiPvmFDLCwn2rtvgL33Mj9ioJK9ltO3XPn0mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOkwLKD1HIFpF9QNIzg2+NQCdduRTnqataQ6SZfpBXX6/qoY8CFjKY0uaY5xz+Cjg
	 lMqfdGVaAXZvb71HnMqwCvzJM3AOTzn6ko1H2A0intxz30sWVtAkTRAz0dTbRvjGCT
	 3kMZ0lldfDEeyZwaJ5534aPg3t09thcvQcsWrN0yBblftQjRqc4qI1hkAKLc330lxK
	 Vv+PsQ+2ehYFjZPFt/vCtoQKaJf4TrNJI95+0vWkY5pMtpr89cFFsPi66WxDTLd9D+
	 Swrb84DuONnqM43uHE48GsCmur+ywprWxhuxrSIo7TsaLpSI/3H6jcvtHKCV6yg9is
	 l0LV+oxYBB3Tg==
Date: Mon, 20 May 2024 16:08:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Nishanth Menon <nm@ti.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Lee Jones <lee@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>
Subject: Re: [PATCH 5/8] dt-bindings: soc: ti: am654-serdes-ctrl: Move to
 dedicated schema
Message-ID: <171623932593.1530457.11631541498637142639.robh@kernel.org>
References: <20240519-dt-bindings-mfd-syscon-split-v1-0-aaf996e2313a@linaro.org>
 <20240519-dt-bindings-mfd-syscon-split-v1-5-aaf996e2313a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519-dt-bindings-mfd-syscon-split-v1-5-aaf996e2313a@linaro.org>


On Sun, 19 May 2024 20:42:20 +0200, Krzysztof Kozlowski wrote:
> ti,am654-serdes-ctrl is not a simple syscon device - it has children -
> thus it should be fully documented in its own binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Context might depend on
> https://lore.kernel.org/r/20240510123018.3902184-1-robh@kernel.org
> and also further patches here depend on this one.
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml  |  1 -
>  .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      | 42 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


