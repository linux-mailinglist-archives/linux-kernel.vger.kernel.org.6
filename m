Return-Path: <linux-kernel+bounces-436987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340FF9E8DB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA818853E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A8215708;
	Mon,  9 Dec 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px0ajlkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CF136357;
	Mon,  9 Dec 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733694; cv=none; b=XzA/104E31m/YxJ860w782PPZwYox4OADZrKs5RwWYJFnO2uxuriCvILmgh1tORU9s+ZMBkpd/gdDbctmnJ9RQlChirGaP6OhhRpGZHgCVHpxyIQl8iqRB5lgnRY5Erd25UbPf02+/aQLlIDQN8uxI1LzlzXZF3MFFWLgIhirKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733694; c=relaxed/simple;
	bh=jDoyGXxmK/hzl0isoHA9luNOBfdMCevCyeKzjRCxhn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtV46H7PLZuCKMDkcoi4hvnqnahm6jcOIXKZDk4EbU4iIwhSESvCZGs0sWUGZEj6/YeYvhaOLNEKykzjZ05RUP+L6P5UaPuY6AVU834CP1x7F7UTiWJkdHEJ32NK5vx3+uF+braiqq0pnlOPV6QkpcUAkVJMCGnDMRF3KquoH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px0ajlkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DFEC4CED1;
	Mon,  9 Dec 2024 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733733694;
	bh=jDoyGXxmK/hzl0isoHA9luNOBfdMCevCyeKzjRCxhn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=px0ajlkX+RWhpzoWf0XnSPdacFYK1kom66O+AlVv50CPAukyXsdeAqALgbzLrBRum
	 jyxWRlUzrMVZITF9SAaMmjVEBmzTmKSQ/oPBktsZxWussWgbDklQV+HIf6Hu2iVapI
	 UqbYqi9TWxIr1uT2KyivgjbVYt/Ast+qQiD4k1JQNkwhz9MABCQgYO9Xn0wWbmeNYH
	 spaEmGulCJV6excleuOM13iRkDQiwBMPrBIMizfsavKVucIdnVIVF4l41y0JaxKQKN
	 BT1T5T4fzzrrVBVZePvYut1MfCc5f27tgKJk5X8Rm2QxsCsR4/jS7IYFb3tL43l9br
	 Z6Fy3ikuygFTw==
Date: Mon, 9 Dec 2024 09:41:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: Add Exynos990 SoC CMU bindings
Message-ID: <4thu4plnvcamln52tjiuba74nwxthj5aqmgwo4eliqipuruh5n@rz6boaywnbsw>
References: <20241207-exynos990-cmu-v3-0-20c0f6ea02f0@mentallysanemainliners.org>
 <20241207-exynos990-cmu-v3-1-20c0f6ea02f0@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241207-exynos990-cmu-v3-1-20c0f6ea02f0@mentallysanemainliners.org>

On Sat, Dec 07, 2024 at 10:25:38AM +0100, Igor Belwon wrote:
> +        clocks = <&oscclk>,
> +                 <&cmu_top CLK_DOUT_CMU_HSI0_BUS>,
> +                 <&cmu_top CLK_DOUT_CMU_HSI0_USB31DRD>,
> +                 <&cmu_top CLK_DOUT_CMU_HSI0_USBDP_DEBUG>,
> +                 <&cmu_top CLK_DOUT_CMU_HSI0_DPGTC>;
> +        clock-names = "oscclk", "bus",

One per line

> +                                "usb31drd",

Fix alignment.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


