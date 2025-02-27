Return-Path: <linux-kernel+bounces-537110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F68A4881F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5C5188A804
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355125CC6E;
	Thu, 27 Feb 2025 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="R06d9cIO"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13411F5820;
	Thu, 27 Feb 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682061; cv=none; b=tGaRAuMgyImlr309p2c8LmTnGEKkIeLBSr8FlRWVMSIhxyyYi5k9uDeNIF4TSuEOIYBlCCfyIzAAyBBpSmXEF4QNS6Ofy1wwjnFGRKYr+190DpHDpaulkteoSi/5/GYcWQ6E08mFj4PbyspTAKufPlPr96lcr8JSQXLV7UCqjqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682061; c=relaxed/simple;
	bh=tNxufyEmqvelo58l5TdexlWiSdxOsHppCDLg7M4W79s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KayweUAsFNRUtFmIvBldUz3cj20VslHdKaJ/vzUvxY5dj8o+NTPz/0sqjo7E1uRyhlT8W4htLUYTNu7RHGpPDGKRz+OoJBvaFlWp5FfweDEyb1RF5mFToSEykmuqXpz2wI5G8HJXNK+BrcoxzXZgMrm/q41rP9QcYfullN5MTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=R06d9cIO; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DFBD225A3E;
	Thu, 27 Feb 2025 19:47:30 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NeJMdeaV9PgI; Thu, 27 Feb 2025 19:47:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740682050; bh=tNxufyEmqvelo58l5TdexlWiSdxOsHppCDLg7M4W79s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R06d9cIO2xlwenccd6afG9XhP6C1IMj8IPLlXGO2KvKAHnpKzXfum2DQz+NcuTWN0
	 eKaJSBCJKrnbfQQgvtFqZPEN+i7v3DGl8C684Z8qWwcqPcbW3DfBXne0RuN0Zye6c7
	 vNBvlgZfE8Cgz5bOGrDF0Ymao6CA+y1aPGAVom1Jc2wJNEOrukHwqR+wEmNT9sEYKp
	 GovGi0gZqWlwIc/+oF4wO6g3RJLP7UgCqg2RYctlfK6ddTayjeqBPi8cZfGb4Mo3Lz
	 pG3qtSfHwL78PCjTxzK/CfA7qWPDwVcwPtyZXS4sGKx/B43qXN/LIPPzUATLbb4GyF
	 hSMehDccy9T1A==
Date: Thu, 27 Feb 2025 18:47:12 +0000
From: Yao Zi <ziyao@disroot.org>
To: Jonas Karlman <jonas@kwiboo.se>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] clk: rockchip: Add reset lookup table for RK3528
Message-ID: <Z8CzMNI_1CjUgSrl@pie.lan>
References: <20250227175302.2950788-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227175302.2950788-1-jonas@kwiboo.se>

On Thu, Feb 27, 2025 at 05:52:57PM +0000, Jonas Karlman wrote:
> In the commit 5d0eb375e685 ("clk: rockchip: Add clock controller driver
> for RK3528 SoC") only the dt-binding header was added for the reset
> controller for the RK3528 SoC.
> 
> Add a reset lookup table generated from the SRST symbols used by vendor
> linux-6.1-stan-rkr5 kernel to complete support for the reset controller.
> 

Thanks for completing the reset part! The patch looks good to me, but

> Fixes: 5d0eb375e685 ("clk: rockchip: Add clock controller driver for RK3528 SoC")

I wonder whether it deserves a Fix tag: to me it's more like a new
feature. Please correct me if I'm wrong.

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/clk/rockchip/Makefile     |   2 +-
>  drivers/clk/rockchip/clk-rk3528.c |   2 +
>  drivers/clk/rockchip/clk.h        |   1 +
>  drivers/clk/rockchip/rst-rk3528.c | 306 ++++++++++++++++++++++++++++++
>  4 files changed, 310 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/rockchip/rst-rk3528.c
> 

Thanks,
Yao Zi

