Return-Path: <linux-kernel+bounces-435037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F0C9E6EAA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0259328441E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E009204F75;
	Fri,  6 Dec 2024 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWszWwZ+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FD1FECD4;
	Fri,  6 Dec 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489790; cv=none; b=B2JNzaXfh4VzJbrqfV66j2YutyRf85CXpQtWqxKHPBuA0KhpJhLfm7PiSqm3qe8pa1UR5i/R9G+b+/V8lS0j0Fl7ol6Opma9EQfaXhjLTaTxJhemG4Rc5fNZTK1gZf1aQwLBH7N+Xn9nPC96mnVjRtFPDTqdLVQbu4VR6AiicEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489790; c=relaxed/simple;
	bh=CcvGwj3nX/cJL1PK353IPE4b9ZUoSfd2vgCJQVxEO60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KevfqbDwEL8e836dsuhHawqLpygVh6UVx6Cwd9masDsnxPoOVIGz17rhq/k9gdfwVJv67vKKy4KFEPN7yX/HcCNlITOn1t1ggVElx6NzHnQPHTUqTzCr8tD5QHV+LAp4zeuu1RbSKakhwQ8/Vop09vR7MgTVzGJr8h48Ce7IuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWszWwZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D9AC4CED1;
	Fri,  6 Dec 2024 12:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733489790;
	bh=CcvGwj3nX/cJL1PK353IPE4b9ZUoSfd2vgCJQVxEO60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWszWwZ+HkTEZCTr5MgjLWvfnHiAllNkXcFZAWTxxeoGEO8/pNdIiAUXZ4Surj0Ns
	 5eQopZu6arlr0rUCaCYGfuWVaPwMQ+NNMLo/DtH9opaUI66OMWxn7imQEKM/zYdeV7
	 gduhLq/UgTZU+VbmiV/Z0d3cXWfKk8RVdfuoisXRDyYFWiFjo9sdu35EsjLl+hf0fL
	 gdwwKtEXApQfv+f2nvV70UtDXoL72NGXyTW8oxAb50lK/tQLuSktRv197wqNSi5LDX
	 +b3dINQlpqtV7+kuh/s+7mRogj1tdMucOx1IKydrkM734Uf4C1Ucej9JGu9Zr/GaSb
	 +aQ0TWgPnJo+Q==
Date: Fri, 6 Dec 2024 13:56:26 +0100
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
Subject: Re: [PATCH v5 01/20] dt-bindings: clock: imx8mm: add VIDEO_PLL clocks
Message-ID: <cnacul23vrat2vmoxmi626awgmodp5zvb7rf5pu2g6cwysmlzh@oqcopgp7tzlm>
References: <20241205111939.1796244-1-dario.binacchi@amarulasolutions.com>
 <20241205111939.1796244-2-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205111939.1796244-2-dario.binacchi@amarulasolutions.com>

On Thu, Dec 05, 2024 at 12:17:36PM +0100, Dario Binacchi wrote:
> Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
> name used in the RM is video_pll. So, let's add the IMX8MM_VIDEO_PLL[_*]
> definitions to be consistent with the RM and avoid misunderstandings.
> 
> The IMX8MM_VIDEO_PLL1* constants have not been removed to ensure
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


