Return-Path: <linux-kernel+bounces-570508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12292A6B18C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC819C011C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67022A7F7;
	Thu, 20 Mar 2025 23:21:41 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A9218ADD;
	Thu, 20 Mar 2025 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742512901; cv=none; b=sx7zJe555RIfgxTObOXxlnHHelsMW65kb28A/2uQ3c6pUOcmVBnyv7YcuSHqdSap3snWD3jISl9jMSXuNlNSgar6FWtzLt/Kphw4RbSNBlmacu9AIAvtN2/9pM1hRGTw2EnqCTROQrKyb7PUL8SSn1WyZC13i6e82OXjKyf3Ibg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742512901; c=relaxed/simple;
	bh=/vPGeeOT0+rQYGORIq3JATAs3leuflo/1CsOvx6J7Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKoJfty0YWMDEOnlvhevbMeFbGTm2xFSyMVc1qUtkAUe/71Bqxfp+0M4ygSJcc+WpGh498FfaDEmqbb15HawT3slxBX/OuRMRmYXvzfJ34yO4Q2RDdIq7pI0+lCHkug32mzab8F9HP9DvF1YFkYsYyB/axCPcTrh5HGvSGJ2cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 9FFC13430AD;
	Thu, 20 Mar 2025 23:21:38 +0000 (UTC)
Date: Thu, 20 Mar 2025 23:21:28 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: spacemit: add K1 reset support
Message-ID: <20250320232128-GYA10498@gentoo>
References: <20250320194449.510569-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320194449.510569-1-elder@riscstar.com>

Hi Alex:

Thanks for sending this patch series

Can you also CC spacemit mailing list: spacemit@lists.linux.dev
it should be handled automaticlly in next 6.15-rc1 version as the
MAINTAINERS file updated
https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=4a0c4e723c94

On 14:44 Thu 20 Mar     , Alex Elder wrote:
> This series adds reset controller support for the SpacemiT K1 SoC.
> It is based on Linux v6.14-rc1.
> 
> It is built upon the clock controller driver that Haylen Chu
> currently has out for review (currently at v5):
>   https://lore.kernel.org/lkml/20250306175750.22480-2-heylenay@4d2.org/
> 
> It also depends on two commits that will land in v6.15: 5728c92ae1123
> ("mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes")
> and 7ff4faba63571 ("pinctrl: spacemit: enable config option").
> 
you can use b4 to handle patch dependency, and currently you may got 
linux.riscv.bot complaint, but may fix later
https://github.com/linux-riscv/github-ci/issues/24

> The first patch adds three more system controller CCU nodes to those
> implemented by the SpacemiT K1.  The second updates the existing clock
> driver with a structure used for OF match data, allowing both clocks
> and resets to be specified.  The third provides code that implements
> reset functionality.  The fourth defines groups of reset controls
> implemented by the CCUs that have alraady been defined.  The fifth
> makes it possible for a CCU to be defined with resets but no clocks.
> The sixth defines three new CCUs which define only resets.  And the
> last patch defines these additional syscon nodes in "k1.dtsi".
> 
> All of these patches are available here:
>   https://github.com/riscstar/linux/tree/outgoing/reset-v1
> 
> 					-Alex
> 
> Alex Elder (7):
>   dt-bindings: soc: spacemit: define spacemit,k1-ccu resets
>   clk: spacemit: define struct k1_ccu_data
>   clk: spacemit: add reset controller support
>   clk: spacemit: define existing syscon resets
>   clk: spacemit: make clocks optional
>   clk: spacemit: define new syscons with only resets
>   riscv: dts: spacemit: add reset support for the K1 SoC
> 
>  .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
>  arch/riscv/boot/dts/spacemit/k1.dtsi          |  18 +
>  drivers/clk/spacemit/ccu-k1.c                 | 393 +++++++++++++++++-
>  include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++
>  4 files changed, 539 insertions(+), 19 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

