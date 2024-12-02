Return-Path: <linux-kernel+bounces-427022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5789DFB4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C470D282264
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3331F9A90;
	Mon,  2 Dec 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKAehXu0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F14481A3;
	Mon,  2 Dec 2024 07:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124786; cv=none; b=Mt2h6P5zFQEwiTvC1ZzSXFAkNGa4D+U0S5GfrV0YyGocOyTTCAfZjKUgdFW3U03Pd/0bESHSN5R5MS7zBgkOkxykRk1K8+um2k2pCJZ+NL/lDCdif8/xw9Wgytpj4lu/4MKzV8F4FU6qdEtM1QI5/9RdvixJJ6vOuFcI6oIREw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124786; c=relaxed/simple;
	bh=7pfshbH0/yBTHMIOHD/y8iFOlZveGZPhEOADQVkMTh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6F4kJn7tjo2OiJmAPzZnQM9gD3GS+VHsuiWyeHo0eYTLmSj9HMCKWfZAxZVTn09Cq426izU/CjGMoxpBfR44OUzI/eKPyYRspUBV65go9QRnr4zs8zNY2p95SQh/seslEmk08s83rumYSUZEnRIlv6ml6uRDNC87jHpvTTP78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKAehXu0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF0FC4CED2;
	Mon,  2 Dec 2024 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733124785;
	bh=7pfshbH0/yBTHMIOHD/y8iFOlZveGZPhEOADQVkMTh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKAehXu0uhSQ5k0I31ANKuyzTu2TmaZKf0ql48DjtPxj23R82PMU32TSLjH3qjgcN
	 MDHjH5vMN7VJwjcY7vY+b+XYalfMSyao1JtYDET8mKjr6MIA/S3HE/ay1J6j+MEWFb
	 S/CwSE9AyNZ7Lzz4wztLREMysf7bvPGKi3TgK9BQdw+SBCM7Utd+NMlk7VnCIWfq19
	 csZKbwQSAYwuXyr/gJbdrUI4NJaZDodhYtHJp2Jn9BbRbcrqr7IYFnBZdQVuirmHvA
	 QrMpElEL3+3yYr1/BHjwzcR51LMFhAVXJkl0tCcFTahnG7HaJdHRqtxqwRkkF6ha3M
	 EXYUpbX/AagNA==
Date: Mon, 2 Dec 2024 08:33:02 +0100
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
Subject: Re: [PATCH v4 02/18] clk: imx8mp: rename video_pll1 to video_pll
Message-ID: <h5eswwlw3rpuc46ote3bhexetlf35i72btwlq2xsqt7p4rg2jx@eugvszlgpuvc>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
 <20241201174639.742000-3-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241201174639.742000-3-dario.binacchi@amarulasolutions.com>

On Sun, Dec 01, 2024 at 06:46:02PM +0100, Dario Binacchi wrote:
> Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
> name used in the RM is video_pll. So, let's rename "video_pll1" to
> "video_pll" to be consistent with the RM and avoid misunderstandings.
> 
> The IMX8MP_VIDEO_PLL1* constants have not been removed to ensure
> backward compatibility of the patch.
> 
> No functional changes intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
>  - Added in v4
> 
> ---
> 
> (no changes since v1)


Same problems.

Best regards,
Krzysztof


