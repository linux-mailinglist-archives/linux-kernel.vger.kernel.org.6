Return-Path: <linux-kernel+bounces-553745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4EA58E63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA5B1886D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91DE224227;
	Mon, 10 Mar 2025 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDGmw8H/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A759E545;
	Mon, 10 Mar 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596062; cv=none; b=VTVsrhBOFOw5icA1jmC6BXGTbc22o6ZC6570tpAaKeB+iWCtij2Es/0ysLBsgQVUz5laICPNrBuD/1L/neBpKMJWofwU4L8AQ5/S31Et2Sseg+SXB9mlZpqlTrm9SXHuSNH5FuNBFffwhQR5yLuly8q5GSESUOuH2gsJbBJ7YC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596062; c=relaxed/simple;
	bh=wtR3UpPoMz+wCe+/hOCNij3NuEYuHFbuLlXSxRojof8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUNjwOsWK1Ma7NTeCZHGZfTp2NI4wLsOKcPp40RAt6QL6YjHCWuFa1zt2dWiE6U2K574tPNoII6AM3AobZOq0W06pfa+sDquKc8NPnA3MZr2PDQv+hvEE8+6NeEXTaGvBFpWgrEjCYSan9+DD9m5nkcqqAhZABe4FJP3sqKDRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDGmw8H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68EAC4CEE5;
	Mon, 10 Mar 2025 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741596061;
	bh=wtR3UpPoMz+wCe+/hOCNij3NuEYuHFbuLlXSxRojof8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SDGmw8H/0tdvzIu9ylKV+WU+tIIZdDiS5RJEwyZD5VdIcDKJVBhCz+QsETlvT5SWN
	 z2J76go0xVsuWaXnf9ZTIGgaXxHkTRdVTP2TZT+evktcIfeu+oMfxZJBaOtjT3Penl
	 xrzWDJ6ncKadlJYVM38Ve1aVGo+4oaW/w0EX/sZ6yrHwAU1iTU9GHYCzaYFvlG2MeR
	 xtTcUv36qHIdq10TVvpcP8FOMGAjcvJSP2fE1GhgFcSTTim/OehHu6gOUdR17QrImQ
	 WENwykAGLHFVrpS0FjQJv8OJGr7JRMjJ+tGpQpE2Pb1YsQO1+RvoCPDOW3AAWLcBYa
	 MnWZLRfXQ2aIg==
Date: Mon, 10 Mar 2025 09:40:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@kernel.org>, Stanislav Jakubek <stano.jakubek@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 1/9] clk: bcm: kona: Move CLOCK_COUNT defines into the
 driver
Message-ID: <20250310-proficient-free-antelope-abb6b7@krzk-bin>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-1-d6fb5bfc3b67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308-kona-bus-clock-v3-1-d6fb5bfc3b67@gmail.com>

On Sat, Mar 08, 2025 at 08:50:39AM +0100, Artur Weber wrote:
> CLOCK_COUNT defines for each CCU are stored in the DT binding header.
> This is not correct - they are not used by device trees, only internally
> by the driver.
> 
> Move the CLOCK_COUNT defines directly into the driver in preparation
> for dropping them from the DT binding include.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  drivers/clk/bcm/clk-bcm21664.c |  8 ++++++++
>  drivers/clk/bcm/clk-bcm281xx.c | 10 ++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/bcm/clk-bcm21664.c b/drivers/clk/bcm/clk-bcm21664.c
> index 520c3aeb4ea9c4a431512c0909f9545c1761d17a..fa6e1649d6f5f459b63026109caea9e2f72e22dd 100644
> --- a/drivers/clk/bcm/clk-bcm21664.c
> +++ b/drivers/clk/bcm/clk-bcm21664.c
> @@ -17,6 +17,8 @@ static struct peri_clk_data frac_1m_data = {
>  	.clocks		= CLOCKS("ref_crystal"),
>  };
>  
> +#define BCM21664_ROOT_CCU_CLOCK_COUNT	(BCM21664_ROOT_CCU_FRAC_1M + 1)

I hit that wall too, no worries. It might surprise you but 0+1 != 1 :),
so you redefine a define. You need to test this patch bisectability.

Best regards,
Krzysztof


