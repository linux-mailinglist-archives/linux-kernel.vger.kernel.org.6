Return-Path: <linux-kernel+bounces-557204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B4A5D4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1203B41B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB941DB124;
	Wed, 12 Mar 2025 04:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN2ymMXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD24154426;
	Wed, 12 Mar 2025 04:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741752238; cv=none; b=eNuZBtId2xQ46jP5bzGtNQO8pO3pe9G91XXzxpa9L5fLYqkU3usJxFq6DhS2M2Um+N0s51NrPGc4HDy/eYKmvMbs5UbtjBUqjqeKAMIgdPlxqIUfgu2OyZ6KCL98kMTTbpFVMMpVeoXfC/+o8QoyQ8h7KvvOMnCNMFB6rq8iiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741752238; c=relaxed/simple;
	bh=XkOWlzk6E8YZf8b8QRvvfwojqXUrA8YB4Q+CY34n8TI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+Z5Cf1YIaPhxN+Kd8wB11YVp9ICxgYXw3uYIlKScBNRwuPelzTSSWFLHNMmdBui1WwkttzFb0T7YCWsvOIBRm6xussXV2I3ZjiRyDvfrQGHb6vsm73KrqVEC3iSur09xWnoBjMiSsz9KwRmYryRgfzc1gmApAwJcWuXUPd9/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN2ymMXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE8DC4CEE3;
	Wed, 12 Mar 2025 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741752238;
	bh=XkOWlzk6E8YZf8b8QRvvfwojqXUrA8YB4Q+CY34n8TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hN2ymMXcw4hGU5fwGZfosxtuSdYfyboEsStjGFykCP8oO9sy6OoeNPAl9FUK3w2OU
	 3zMWOn+CVBTlI/4aRfT1dNGRUNx9w4WAekiT2BXMD4rXKd2oiHgjy3w6uvTzlL4PFR
	 MG0Og9z5mMHBiHucw15sR+r6iPkAwdX6EMqHPQ68Fzt8n4l/ZDaNSpCOn2VtbNDHqu
	 8kMCtJDFhPFhhX5DUPPGJElZprCySjwxP3MwZdekEjySE7lpugMXhu8+PNGCIKj1aq
	 S3XO3FwNQBsDQsyhDO2w2sGxF0O2h4bJ+0KJmOsUV/iQykttIdhEKecptIpNMXTCWd
	 cQBqHPNnPSdww==
Received: by wens.tw (Postfix, from userid 1000)
	id 64EF85FC08; Wed, 12 Mar 2025 12:03:55 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] clk: sunxi-ng: add A523 clock support
Date: Wed, 12 Mar 2025 12:03:54 +0800
Message-Id: <174175218236.1911740.8731884904697217692.b4-ty@csie.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307002628.10684-1-andre.przywara@arm.com>
References: <20250307002628.10684-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

On Fri, 07 Mar 2025 00:26:14 +0000, Andre Przywara wrote:
> this is the fourth drop of the series introducing basic clock support for
> the Allwinner A523 family of SoCs, comprising A523, A527, T527, H728. [1]
> This times just a small rename of a macro name, and fixing the DT
> binding, where the separate patches for the two CCUs got merged into
> one. For a more detailed changelog, see below.
> 
> *************
> Please note that the clock numbers changed compared to v1 and v2, (but
> not against v3) so DTs from that older era cannot be used anymore with
> this driver: you have to update the DTB. Just copying the binding header
> and recompiling the DTB should do the trick, since the symbols stayed
> mostly the same, at least as far they are used in the basic DTs we use
> today.
> *************
> 
> [...]

Re-applied to clk-for-6.15 in git@github.com:linux-sunxi/linux-sunxi.git
to add SoB, thanks! Please note the commit hashes have changed.

[01/14] clk: sunxi-ng: mp: introduce dual-divider clock
        commit: 45717804b75eda8a76eacc04509ca4d68dd2caaf
[02/14] clk: sunxi-ng: mp: provide wrappers for setting feature flags
        commit: cdbb9d0d09db4cd09d23fec02d3b458664bc3d38
[03/14] clk: sunxi-ng: Add support for update bit
        commit: e16b9b71f40f603d5cbdcf02007c05ee03cb2be7
[04/14] dt-bindings: clk: sunxi-ng: document two Allwinner A523 CCUs
        commit: 52dbf84857f051df38f6de3f0c7b7f4506e7ad25
[05/14] clk: sunxi-ng: Add support for the A523/T527 CCU PLLs
        commit: 7cae1e2b5544a6f51972458ec4360c7717ca0145
[06/14] clk: sunxi-ng: a523: Add support for bus clocks
        commit: e6f4b4b77981feb3af06e16da073e788fe16de2a
[07/14] clk: sunxi-ng: a523: add video mod clocks
        commit: 6702d17f54a8f6c48cd6ba12282fae8c936e7944
[08/14] clk: sunxi-ng: a523: add system mod clocks
        commit: 74b0443a0d0ad283f20ee2985758143485942c31
[09/14] clk: sunxi-ng: a523: add interface mod clocks
        commit: ed064e65b92a1d78d90b6b87a3d99790f88c1c83
[10/14] clk: sunxi-ng: a523: add USB mod clocks
        commit: fb2c60366d3259aeb5507902e50032fb05b11895
[11/14] clk: sunxi-ng: a523: remaining mod clocks
        commit: 00bc60ea24a7b31da97a3b8a833711491c285ae4
[12/14] clk: sunxi-ng: a523: add bus clock gates
        commit: f3dabb29f0ca44f2053c0c3943ca6f47b248d348
[13/14] clk: sunxi-ng: a523: add reset lines
        commit: a36cc6cd0feb7ea656a1a33db0e6347149f50fed
[14/14] clk: sunxi-ng: add support for the A523/T527 PRCM CCU
        commit: 8cea339cfb81eb3354b0f27ceb27e2bb107efa6d

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>

