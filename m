Return-Path: <linux-kernel+bounces-431599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C289E3F44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B7728425D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D4620D4F7;
	Wed,  4 Dec 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaP9pl7I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865E20B81B;
	Wed,  4 Dec 2024 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733328394; cv=none; b=KFT7S5tf66Kl2VLKG2JVzv0+vfkJkEsqIWK3DeZJR7UQ02G752i91zUymOyl3tDvbi1usdLSE4w4LJ51n46SkzaWJhHOE6CNQy7zpJUlrPWHs1iPQt6hNX1qY5Lap4M1G2YLU57PRlEtL6ooQAAOIsvYZsx39DMQIUP0IPzjSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733328394; c=relaxed/simple;
	bh=wAsPvRdwvf4EGb7r/h+7/Kb530DijpuY7cPegHSkeFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RF4ZQqmx9NrrT4FVxx9pEW3EDf0m9xVJwSTyYJCGBNIQeAWezxrfauscxO/RWMU9P/24PGlKFx/6h9OlMyVq810D8xiAdxuCzF5cfgTvBsN44uSN9aTwFzw4PvlCEmJBvn8VnjhzoiwCtghcKmkkngNfghMcFIarfO2g6lJPFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaP9pl7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6EA6C4CEEA;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733328394;
	bh=wAsPvRdwvf4EGb7r/h+7/Kb530DijpuY7cPegHSkeFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FaP9pl7IriAWHBBCuuOzeoYAA7Lxdxjx6C6YJEJ76Hbtgq7roFkIr2CM6xmYSlB+R
	 EWJ6CM5pvuR3tQy71X09hpnWO1daXPe3q8/0gfatpu97IyxXGmNanrAV/N6TkPvgwu
	 JFQkfYNBiBxZtSubW4Yj++6gJWIBvOyCidT+oEHWfcsbDLTa6+jjJp6kBuoYCMkvos
	 i3xggVrwhEx/EVRNYPbMCafFilSnWMag7xAKaxTkrBK7HFLezKCpbkHg78r+yJQ+2W
	 812DQpBN/VhbrsUIx4tl4g/XpCL+bNWLZuv0J4hi+1kW7tZvD7PpU09pGEVOl47THe
	 fdzolChHeOfrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1FAE7716E;
	Wed,  4 Dec 2024 16:06:33 +0000 (UTC)
From: Nikolaos Pasaloukos via B4 Relay <devnull+nikolaos.pasaloukos.blaize.com@kernel.org>
Date: Wed, 04 Dec 2024 16:05:26 +0000
Subject: [PATCH v5 3/6] arm64: Add Blaize BLZP1600 SoC family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-blaize-blzp1600_init_board_support-v5-3-b642bcc49307@blaize.com>
References: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
In-Reply-To: <20241204-blaize-blzp1600_init_board_support-v5-0-b642bcc49307@blaize.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Cowgill <james.cowgill@blaize.com>, 
 Matt Redfearn <matt.redfearn@blaize.com>, 
 Neil Jones <neil.jones@blaize.com>, 
 Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733328392; l=981;
 i=nikolaos.pasaloukos@blaize.com; s=20241111; h=from:subject:message-id;
 bh=ndFGNT8hlTjNTdZtp9EMF7h9pwy1ILkNSgtZflY+7U4=;
 b=MyPoGjnzkT21+M12LN3XkWoTRhNAyGCpyFpNDXLknKSuLzlcwQhBBIbe5pcXYqfNGx9v/CqLu
 t5ia9ty7GHHBS4ZxaodUF1IJmzo724S4lb0JwYXNOTplVUljFFUTE8W
X-Developer-Key: i=nikolaos.pasaloukos@blaize.com; a=ed25519;
 pk=gGEjGCXdSuvCJPIiu0p0UeiPcW5LC710Z6KGN/dzo3g=
X-Endpoint-Received: by B4 Relay for
 nikolaos.pasaloukos@blaize.com/20241111 with auth_id=274
X-Original-From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reply-To: nikolaos.pasaloukos@blaize.com

From: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>

Add ARCH_BLAIZE SoC family to the arm64 architecture to
support the BLZP1600 System-On-Module and the Carrier-Board-2
development board.

Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6c6d11536b42ec6e878db8d355c17994c2500d7b..08dd5b3b2d7381a01bd5c4347c29202edff3495f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -101,6 +101,11 @@ config ARCH_BITMAIN
 	help
 	  This enables support for the Bitmain SoC Family.
 
+config ARCH_BLAIZE
+	bool "Blaize SoC Platforms"
+	help
+	  This enables support for the Blaize SoC family
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG

-- 
2.43.0



