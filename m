Return-Path: <linux-kernel+bounces-448041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6474C9F3A38
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176F51888CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3C20CCEB;
	Mon, 16 Dec 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ko3vgjS8"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B820C497
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378698; cv=none; b=h+HBvg7w6KrBQ062kl/iHX75K7LGFhLEUjjzfxKozFJCiiuuUOGVb3hxBxu4/35P5SzHJajKfmQFDa5+TGEbJ1HIEZ8FeMYugffGaGfynH+0f2DQVzU/6tCLunzPmLnC0HQhPzwLQhvPqWhmixDyI6PAqejv/v55GcZYwZVDcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378698; c=relaxed/simple;
	bh=W1Z3MQX8y7Qi7AiKCyHgSsfkmQSyhI/S7kFBYOrFXE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5uYDpSfJzUKrJ0SO6s0D7OZoOcj87TUWtlwyIXFpnTbguKYfUPXyxAMODNDv0JKxh5dMypPgUouiAXxciq5Hpu13yG2DPjzOKJmFOXXwbLM2dK5b4p+6rOiQZUNoha6u/ef+9rkHyS4uUJZeAJZLPNwpenhoJsH0bOsogfekdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ko3vgjS8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734378694;
	bh=W1Z3MQX8y7Qi7AiKCyHgSsfkmQSyhI/S7kFBYOrFXE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ko3vgjS81uyB4VcKRN0CFurxKkz2pbTaUoqa0X64auwPou0zSD8eCTLOyKuhtJjT2
	 E5Svb0WjpxBUl/asdIkcEbyebiFpjauYZ9w1pKKsd0sHIOBJZzCeG5R39JgKFstg0n
	 dr+xquZsLvUyaDKuFy5MNrpdvYljKS0MkGCVfzPLHoWpsOwqI/UaRdXLqbOepo9AoY
	 qPPJQ74Cg7cSEc5PC2vD1SEmzQk1g0TUHF/Wt9490MmF9Z7DD7KCRcDRPGrTN1XEWi
	 o0LqyGihmQgYF9nWH4nBP7A5+ieGbVq6CmXagJyzVuS6bNUsW74jGCW8foRN+ntIJB
	 bj0Hfqr+3Nq9g==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9874C17E3801;
	Mon, 16 Dec 2024 20:51:32 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 16 Dec 2024 16:51:25 -0300
Subject: [PATCH 1/2] arm64: defconfig: Enable sound for MT8188
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-genio700-configs-eth-sound-v1-1-04a719035d6e@collabora.com>
References: <20241216-genio700-configs-eth-sound-v1-0-04a719035d6e@collabora.com>
In-Reply-To: <20241216-genio700-configs-eth-sound-v1-0-04a719035d6e@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Enable platform and machine sound drivers for the MT8188 SoC with the
MT6359 PMIC codec, as well as the MT8186 SOF driver which is also
compatible with MT8188, in order to get working sound on MT8188 SoCs.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dfa5c8d5b65863741be7d7d3c6f6f05567d336da..95af0377ddc673be7003d7517e3990012a817cbe 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -970,6 +970,8 @@ CONFIG_SND_SOC_IMX_AUDMIX=m
 CONFIG_SND_SOC_MT8183=m
 CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m
 CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m
+CONFIG_SND_SOC_MT8188=m
+CONFIG_SND_SOC_MT8188_MT6359=m
 CONFIG_SND_SOC_MT8192=m
 CONFIG_SND_SOC_MT8192_MT6359_RT1015_RT5682=m
 CONFIG_SND_SOC_MT8195=m
@@ -998,6 +1000,7 @@ CONFIG_SND_SOC_RZ=m
 CONFIG_SND_SOC_SOF_TOPLEVEL=y
 CONFIG_SND_SOC_SOF_OF=y
 CONFIG_SND_SOC_SOF_MTK_TOPLEVEL=y
+CONFIG_SND_SOC_SOF_MT8186=m
 CONFIG_SND_SOC_SOF_MT8195=m
 CONFIG_SND_SUN8I_CODEC=m
 CONFIG_SND_SUN8I_CODEC_ANALOG=m

-- 
2.47.1


