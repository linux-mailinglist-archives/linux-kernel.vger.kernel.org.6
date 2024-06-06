Return-Path: <linux-kernel+bounces-205035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0498E8FF684
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A163F2848C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A7413B5AB;
	Thu,  6 Jun 2024 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ou8kv5IN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128B81BDEF;
	Thu,  6 Jun 2024 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708370; cv=none; b=VWHbXWn6G5Btp4S29XUbhfYSDjtkeoV9mWL7x0kYGZtTUUn0MR+A3rOrgZ4qt28tcSt/LOx5laaufmqA1lSgTtvCTdID9XjgmV1REeN9oZwvVkbz5HYS4orGkNaFh4WUIedz7VyOrIH8ygUBeg5HRdsFRRbRFsxISFAB7oXFjk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708370; c=relaxed/simple;
	bh=gfnupUAPz/WWhzeYdhaephd6S8G+uSgDbb6ssPacr2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NfPV21OR7dmEGSaxKLNPl0UgQk2YmiZxs0TxWGBlxyyf/Wf6MF/HaSFpT3BOyY3cXzXvgI7gmxQb6tw+6Q6d12sh3uHw1miY+WXpZ84rX3kiVTjlSvpfsdLST1TUa4HTa4lNzxi3zvVZCfarczCJ5TtEOcatQENFVVwHCAn4XZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ou8kv5IN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717708367;
	bh=gfnupUAPz/WWhzeYdhaephd6S8G+uSgDbb6ssPacr2I=;
	h=From:Date:Subject:To:Cc:From;
	b=ou8kv5INNIPOe3y4ZRitv2E8GiMeLDqmhO0agsTUR5lVsRLxNeknvaBhN6raFEzoc
	 WeuUIZOtMhHhBspNI+KeOet0L6HTZ0XSg71Ylfg/EpGde5h5uqslJ5rZFiB79wlf8h
	 F19SzZAP4FWnPt6wI76tI5KqzXgqc7k2Gey5PIG+yFffnRGGrRqhuyPunF8VTRlISM
	 XliylfIFW4Vk3dDzePOgxGSi/tqJf31C7Smfb1r+feNfQ9f6ohYvFkaOGxIJMJi89N
	 QkGC9KL+WRJzRp4NDX09avtNHAUjVqF9rANgTHflIydBq7YxwMdF7xHIQGFD4S8zcX
	 gyTTkzdDuw/aQ==
Received: from [192.168.1.216] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 403E9378143B;
	Thu,  6 Jun 2024 21:12:45 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 06 Jun 2024 17:12:04 -0400
Subject: [PATCH v2] arm64: dts: mediatek: mt8195: Add SCP phandle to MDP3
 DMA controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240606-mt8195-dma-scp-node-err-v2-1-e14702e9d3f2@collabora.com>
X-B4-Tracking: v=1; b=H4sIACMmYmYC/4WNQQqDMBBFryKz7hQzxGC76j2Ki5hMakCNTERax
 Ls39QJdvgf//R0yS+QM92oH4S3mmOYCdKnADXZ+MUZfGKgmXZu6wWlt1a1BP1nMbsE5eUYWQWN
 bz5aM16GBsl6EQ3yf5WdXeIh5TfI5jzb1s/+bm0KFgVyvKZD2hh8ujaPtk9irSxN0x3F8AWOwz
 jLCAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Moudy Ho <moudy.ho@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

While the MDP3 DMA controller can look for the SCP node based on
compatible, it's best practice to supply the MDP3 node with a phandle to
the SCP since that allows supporting dual core SCP as well. Besides,
relying on the compatible search causes an error to be printed, since
the phandle is tried first:

  mtk-mdp3 14001000.dma-controller: can't get SCP node

Add the missing phandle to follow the best practice and get rid of the
error.

Fixes: 5710462a116c ("arm64: dts: mediatek: mt8195: add MDP3 nodes")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v2:
- Added scp phandle property in DT instead of removing the error message
- Link to v1: https://lore.kernel.org/r/20240605-mt8195-dma-scp-node-err-v1-1-f2cb42f24d6e@collabora.com
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2ee45752583c..a46062258603 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2037,6 +2037,7 @@ dma-controller@14001000 {
 			mediatek,gce-client-reg = <&gce1 SUBSYS_1400XXXX 0x1000 0x1000>;
 			mediatek,gce-events = <CMDQ_EVENT_VPP0_MDP_RDMA_SOF>,
 					      <CMDQ_EVENT_VPP0_MDP_RDMA_FRAME_DONE>;
+			mediatek,scp = <&scp>;
 			power-domains = <&spm MT8195_POWER_DOMAIN_VPPSYS0>;
 			iommus = <&iommu_vpp M4U_PORT_L4_MDP_RDMA>;
 			clocks = <&vppsys0 CLK_VPP0_MDP_RDMA>;

---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240605-mt8195-dma-scp-node-err-6a8dea26d4f5

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


