Return-Path: <linux-kernel+bounces-402973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BAC9C2F22
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143B12824C0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C7E1B1D63;
	Sat,  9 Nov 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="qOsnP34H"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A531D1A42A5;
	Sat,  9 Nov 2024 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176861; cv=none; b=mwoxHqT2hrwXNQLMEnda24OZuibfdlZcx/Jktl0P5xTvFjrByZgXDKp+JaAHAkfzdRYJ5GPH1kN9SdKbHP3SC+sI86O3G2r7Re5xWL8hwdIr646y7VXzUbxQNYqvgRH2pKkIO2fGFq1UrZAvKXQjZkV1lMobxobJJokYafkWn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176861; c=relaxed/simple;
	bh=NdVsUwK3bVW3+3wBmA9hnRx7U3BbDztE/2LBzrdqb4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKItpf422j4sBgsKvv5clqAeNCkNDppiw+Ej32I/+wc9HCUfLr2tEA85maFttcwxCVVRC7LHZbXvjYv9yK2RI1BvjDlVKfNeUaPXad4Eu7dToWl/h7csKk/kwNBatpEr6eONDgp+PyDBfDMjlG+QWJZDHxg3VgeY19aHFqWb9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=qOsnP34H; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gSKanQf0BmxKHhIhUXq0enULNI1TVd/OdUXWSMftuIg=; b=qOsnP34HUawU0TWZvm8UKgXPaU
	PtH0PUeyFGjxsY68jFjAgi7Z2b1uMHTIggP4rZ6TLw6c2TLNY52E2Xyc/Qn8YlPWSWW7rJElcVpzP
	vmPdfQRRNkLhRNF3g8oljkfDR3uoro0B2dsMY2noEc+TyYMKf2rmt2kBBaN526eqbVJAXZ2Kz3QbS
	afynPjHmGxBxDrFjzWtWQFnZdJGrFiGmvBYX76vF7Du4CKsEFn9LUs65uweBLMuRleNiohljYMGUf
	uSED23GccLJK6fLSeiFTwRajwDhDc2itsvvPuL75XMe/Irdtq3o9TbL9qUctVuEqYxSso99Y2K7Ro
	s477Oy1w==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBH-0007Km-4h; Sat, 09 Nov 2024 19:27:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	didi.debian@cknow.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2 0/3] Update, encapsulate and expand the RK356x SoC dtsi files
Date: Sat,  9 Nov 2024 19:27:11 +0100
Message-ID: <173117675956.1131306.6435149045133652112.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730516702.git.dsimic@manjaro.org>
References: <cover.1730516702.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 2 Nov 2024 04:08:58 +0100, Dragan Simic wrote:
> This series tackles the Rockchip RK356x SoC dtsi files in a few different
> ways.  First, it updates the lower and upper voltage limits and the exact
> voltages for the Rockchip RK356x CPU OPPs, using the most conservative
> per-OPP values for different SoC bins.  This is rather similar to the
> already performed adjustment of the GPU OPP voltages. [1]
> 
> Next, this series prepares the RK356x SoC dtsi files for per-variant OPPs,
> with the RK3566T being the first new RK356x SoC variant to be introduced.
> This follows the approach used for the RK3588 SoC variants. [2]
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
      commit: 0e183fcc92b0eaa13b33b39846d86c3d65b8330a
[2/3] arm64: dts: rockchip: Prepare RK356x SoC dtsi files for per-variant OPPs
      commit: 853f9632a17624e9264c68be5c9587f13d04be54
[3/3] arm64: dts: rockchip: Add new SoC dtsi for the RK3566T variant
      commit: e4832d190b4fb69cf28630543804825bf1636ff1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

