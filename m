Return-Path: <linux-kernel+bounces-427024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F3B9DFB53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C54F3B24CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277E41F9A8D;
	Mon,  2 Dec 2024 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H18LKsD9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F161F940D;
	Mon,  2 Dec 2024 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124825; cv=none; b=LERw0m0fvLte8wuglVjZqVsWcGdnJNrEl3r/jVWNFUEfwsJXNe/WE/6/STxjzqQCx94T8JpZic1jsd7faupCbgut3J68We8ZSHkVpluZ5i8cS1JlPg/C0jtk+U8+OxSy+WYjh1ys9Z7BMWU8zzZ8xM9QJe5ZiwE4/ml6s3wF6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124825; c=relaxed/simple;
	bh=XOBsyR5DiRbgmlAcXrezcofMfsl0yDzLXPs9uCednS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/5ilENy0hoSlAtavj6ohLenqW59SwhI77B34WzAdssZ7AsOrmGvimiNa7FNlb+r3UzzVVH2g8AvaCkxgKbxi8+LyJQTCMDbIb73LWw4vIVf+wVlUH5wA03UjIyklg42Bn5dYKozXq75/AxACR/sh3jsaUJTRU+deaAPTpNu5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H18LKsD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714B3C4CED2;
	Mon,  2 Dec 2024 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733124824;
	bh=XOBsyR5DiRbgmlAcXrezcofMfsl0yDzLXPs9uCednS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H18LKsD9QsEdL61655SufKEXHNOnhYGkHw+Zz/lTG1RcTEWROKUAQjH8YBOj1+sbV
	 PEB0L3AHmV/gvZ1ymar+Snmxud1Kl3ZPh3csSEWgt61V5m2MrFLLXhTkDpbRudooZx
	 w7cLUE9k5EXcjeMT5gNjyKPSYQASvMRHdduFFQsI68kl7VKOMgobO33G0QDa2GtMC5
	 O6Tgu/tMDshqYGXQdCXECxzHQpxoA/nbeM2sKDMzr/gI7Rgxtri03b5ElcxJk6nUYB
	 lsDuf/xFiPMMAh+2SCsM8krN8EXlGGGN0vJe6uJOrZhrb9rSGvNkgLzTYvntPOTtnr
	 LTOwzorOjdnlQ==
Date: Mon, 2 Dec 2024 08:33:41 +0100
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
Subject: Re: [PATCH v4 08/18] dt-bindings: clock: imx8mm: add binding
 definitions for anatop
Message-ID: <2t7eok4xmjxywt4dzjviz4brvohk2y7gceu2srioocgpekpu23@grgdf24djo4o>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
 <20241201174639.742000-9-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241201174639.742000-9-dario.binacchi@amarulasolutions.com>

On Sun, Dec 01, 2024 at 06:46:08PM +0100, Dario Binacchi wrote:
> Add the bindings definitions for the anatop node. The patch is
> preparatory for future developments.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
>  - Added in v4
> 
> ---
> 
> (no changes since v1)

My comments apply everywhere, I'll mark everything as changes requested.

Best regards,
Krzysztof


