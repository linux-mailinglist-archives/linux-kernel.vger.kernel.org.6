Return-Path: <linux-kernel+bounces-232896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79C91AFA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25F01F22F83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF3F19CD1A;
	Thu, 27 Jun 2024 19:27:46 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99A19AA56;
	Thu, 27 Jun 2024 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516466; cv=none; b=JhlaAGGVLPk2DXDw2m74FWVs5oGwKra3MDPUhtSWuF7w0AUCZEsnPqKKNy0EYimk6cGCbfT+mCINH1pkZ/086krkA270GNmha2Y3thMyoqiO6sqUgpZnK1g5V12+YNJXK3UmrC3jY4y1oWIO2AsNhnsUMaxRo6+VXi1id0BhuHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516466; c=relaxed/simple;
	bh=TTz5jvyFepWyRUancw86ATJ72rFaJ7NYD9OERcsxr7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9bfSw0m+7TFM3TqR2flQawYdvRAK/avBc2UpAipZU94dRIu7oGU55T0AvDrNzR6jE2KptWfSxmJYF9WP3o8KO/WVWssY1+6xW0UojCM3CMspKpcypt8YU9vA0SHF/IWO9+GR93f4Ij/bkKjq5fcfc44pq3z0pwn9OuOqpdrP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sMumL-0000wK-5T; Thu, 27 Jun 2024 21:27:33 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	alchark@gmail.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Delete the SoC variant dtsi for RK3399Pro
Date: Thu, 27 Jun 2024 21:27:27 +0200
Message-Id: <171951643516.1057727.11647703095785160366.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
References: <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 2 Jun 2024 08:25:38 +0200, Dragan Simic wrote:
> The commit 587b4ee24fc7 ("arm64: dts: rockchip: add core dtsi file for
> RK3399Pro SoCs") describes the RK3399Pro's PCI Express interface as the way
> built-in NPU communicates with the rest of the SoC.  All available evidence
> shows this not to be accurate, as described in detail below.  Moreover, the
> rk3399pro.dtsi isn't used anywhere, so let's delete it.
> 
> The publicly available schematics of the Radxa Rock Pi N10 carrier board [1]
> and the Vamrs VMARC RK3399Pro SoM, [2] which put together form the currently
> single supported RK3399Pro-based board, clearly show that the PCI Express x4
> interface of this SoC is fully functional and actually not used by the SoC
> to communicate with the built-in NPU.  In more detail, the VMARC SoM exports
> the SoC's PCI Express interface at its board-to-board connector, and the Rock
> Pi N10 routes it to an M.2 M-key slot with four PCI Express lanes.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Delete the SoC variant dtsi for RK3399Pro
      commit: 40113edfe63310ad529700fca24f2ebd49ae09ea

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

