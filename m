Return-Path: <linux-kernel+bounces-435038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34DA9E6EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B0A18863E7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4E204084;
	Fri,  6 Dec 2024 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhMlta4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C05464A;
	Fri,  6 Dec 2024 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489804; cv=none; b=cUvgXjixH1bvnM64ixK654MO1x3zjqUYx91jjyoJyLSCD9024rx3pwG78sSo5RTT/OI3uP7r+kuaJcFY5YyeCbrjFODkG1IDHbTznxtJ0rN5mJNLG7pMzK3S4pxtqK5woHFVepMA/2tl4TIXyx1vujE+9srYmcG5wSrUIjdM1Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489804; c=relaxed/simple;
	bh=vtIIcakrqZxr5Cn12lC9/zaEE5BlQXDpTN+QCqnD/HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPW1a4rXWHvK7yJwsXneiO/O+AT7XTBC9bX9oe8owWO+8fQg0ksjIY/rtWV32UIA32s1l9ChkTuPAa30lhez26MI6DQtzjUfTBEhkr2oj1Xwy0ODwNV5UfkeqICCEww9nLEo6YHICldkVqc+0M/8jeSIC+xXt4iFGuimmgJHxyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhMlta4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EC2C4CED1;
	Fri,  6 Dec 2024 12:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489804;
	bh=vtIIcakrqZxr5Cn12lC9/zaEE5BlQXDpTN+QCqnD/HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jhMlta4k3VdC6X1yLUjTKn3OqxwJ4bH0bZMCxuho7rL7Sike9wibGA2REkSQVV3gm
	 oSm1ibOqks4h00ay9Irq8q0VFDuBunrab0b5jxUJw+a64h3PFygtUb5NTLCFjCZ0Cf
	 LEy0cKQTc5N2Jg+W0e9rE8HnrS8I0S6YRl9m868OcbhbQJQT3WZ8PitB0P5jFdlJS+
	 aPQRxd29agli47B2iW/tMNko/Ami+KWXxg/03HzM5/U6yCk2n6fziYxi64k4zRbJvf
	 QslR7QF0chJJLtXOotiUtJUoBtQuUuv2zICPh28MLaBxreHLurRnp10nq9H0m79biE
	 DH3ofo99XXuIQ==
Date: Fri, 6 Dec 2024 13:56:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 03/20] dt-bindings: clock: imx8mp: add VIDEO_PLL clocks
Message-ID: <djqa52bhxkwtdf5uyccyay5omgwkyevilylmta5aydigdpgk3v@nd3glqyhsyl6>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
 <20241205111939.1796244-4-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205111939.1796244-4-dario.binacchi@amarulasolutions.com>

On Thu, Dec 05, 2024 at 12:17:38PM +0100, Dario Binacchi wrote:
> Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
> name used in the RM is video_pll. So, let's add the IMX8MP_VIDEO_PLL[_*]
> definitions to be consistent with the RM and avoid misunderstandings.
> 
> The IMX8MP_VIDEO_PLL1* constants have not been removed to ensure
> backward compatibility of the patch.
> 
> No functional changes intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> Changes in v5:
> - New
> 
>  include/dt-bindings/clock/imx8mp-clock.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


