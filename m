Return-Path: <linux-kernel+bounces-348376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F4C98E6D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5733B2821C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59B19E990;
	Wed,  2 Oct 2024 23:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unr6w84d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2D16419;
	Wed,  2 Oct 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911691; cv=none; b=NA08dETrpUg41VS6P1gMM5jm82vujAQl479K6/G8AlWF+Zb3V2sZq9M67J2vCaPdyeOD/7//AomiAXjdWKbAXAWdAjWZKwyjHV+hXtbnO5BL/V3R48/JYyVJWWgKIWs2vpevm061Zj/5NH9S4wELz9GfuqXHi39+8zuBwOaGJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911691; c=relaxed/simple;
	bh=W1lLp2pPTaIJzlX9xAi0bfcKDw6TZrgG4RIG2rCObS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0i1/Fjfwc/BgjSq0zsxH68NonrV6vPiK2RXvpYG7Qr367IfOm4XwscwIYeso6iho6COEOMzN1d62n0kFG7Jc3Ib9fn83boBPdzb1C8nQhYg4Gc/Va7YV4KElBKeoRG0X8+pe2OxY45KgH/Q/+Po/Jz6CMjg70q7lX/6CfXUNtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Unr6w84d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF7BC4CEC2;
	Wed,  2 Oct 2024 23:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727911690;
	bh=W1lLp2pPTaIJzlX9xAi0bfcKDw6TZrgG4RIG2rCObS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Unr6w84d6DcYViY8Oq8lTRe5r+ynB+qwxQRrN0PXQ21hGMkiKtB4s+zuEuU7KgpYA
	 TSoyTy9NdgpoDmEXHgf4H9vD54L2mqioM8O8Q55Mz3xFJzmEwYrYIZksMHxmoQ+bx+
	 TRB6kRjWMye99RRcvujFvNaJjx4Y102A5IOydiG0jgasJ/IDIiNGsA5uq52FGncphq
	 oPdmA3iZznDTTA3cenmQBNg2ZemPEC8HPwC6hpNUD2Y3M+brqCWLe5wQkeEtzLI6gI
	 opZq4Y0GK67ARrTe7g6QsUfAFsvzu8szHL4p2v9CTrKgy99FpJHg39Wsbca4gqrL/U
	 KJ9AX2YFhxvpA==
Date: Wed, 2 Oct 2024 18:28:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-amlogic@lists.infradead.org,
	Jassi Brar <jassisinghbrar@gmail.com>, linux-clk@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	valentina.fernandezalanis@microchip.com,
	linux-kernel@vger.kernel.org, pierre-henry.moussay@microchip.com,
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v1 03/11] dt-bindings: mfd: syscon document the non
 simple-mfd syscon on PolarFire SoC
Message-ID: <172791168896.1540364.4847195288763668574.robh@kernel.org>
References: <20241002-private-unequal-33cfa6101338@spud>
 <20241002-clambake-raider-a8cbb3a021a8@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-clambake-raider-a8cbb3a021a8@spud>


On Wed, 02 Oct 2024 11:48:01 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The "mss_top_scb" register region on PolarFire SoC contains many
> different functions, including controls for the AXI bus and other things
> mainly of interest to the bootloader. The interrupt register for the
> system controller's mailbox is also in here, which is needed by the
> operating system.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


