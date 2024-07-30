Return-Path: <linux-kernel+bounces-267175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112DE940DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0B0285713
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D19194C9B;
	Tue, 30 Jul 2024 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7tfWTu5"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D07194140;
	Tue, 30 Jul 2024 09:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332296; cv=none; b=YmPnf0lgDReOlAoVshizZMfU81bRClCTnTv+wGEurlgjoFPZ2xWU1gHRLi0lWDnREmNA1NzBK00pTJq/DPPYJmIbeFBlQ4GxOlS2a8yvvBOMn7yz2+n6NparB9YqVsZqd+8sF/yhZirnKnRYtC9iz9gIz82q0OsbgvzAzfmx+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332296; c=relaxed/simple;
	bh=DwLFtEiElQ/3D4yNuQ5m7YF07dO8c14iwsl62eSuZtM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RZIaQV6D0h78b0N0ASTXMb2/jAelZnYoWxtwvs3Rgmdnbqu8Pfn+Axs39aCZHDGDaNbzcBOpTtNwyXXedI+5WH5v8GavFsESb8IOq7969IihlbDUsKpQVIozRYkA0crdOLBJvf6CIoLZ8KKfLTZRFdZEguPvmhRvZ4t+OiK54Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7tfWTu5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so4301277a12.1;
        Tue, 30 Jul 2024 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722332293; x=1722937093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYk6hexZkIu1KsNcGcB/6xdUxP9FHGUqGXf6v+D1grs=;
        b=g7tfWTu57qeKwZaw0xadI8q4XfU9N958SaWTgvsnUBNxf13siMbmmak9kKKRgbLFrV
         m2IJERsfmud6aDM2VD5cZl6oYOxym88/+udChOAMB1XkZJE5ncPnnIhs/m4G3pwWotO6
         pMQxCs3xtupEENUNNLBz9PIZ3MObSOkPCkigU6/0zsfh1PmHk5Ou2MimgugmFISc4l2/
         RGLVKARkBw2pAwBLgjm54fMsYjVi4i9mLcCTKLskuB5FHQAlepFP7qMYuL8SeH1MvBvv
         ax1QhJKWwhKoA8W1hQ7LkjC7WqaRDMayq7PiXih+dN3lhVMPWMiH3RpPrDH8eoyEyFKp
         4+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332293; x=1722937093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYk6hexZkIu1KsNcGcB/6xdUxP9FHGUqGXf6v+D1grs=;
        b=TCW27j92DmwaSSE6zj/8JXPEPVziPUlOADY9wrsXcQyqscSirqJXKqBz4iITmmCdPn
         qoHvwe0jqbKoHSvTZWR1fZ7SqGI3HbhmJw6ro0lKDoXVTGqBCxKXDquqDLrVpINYabm2
         MWGdJIlP7WrHiief5QKilfoqC0WmrQGo/x/KclzpJGZHYOr3DyaxwsiYzeqodhFTVMmT
         X+FTFMnMT8fnSJU3KJdA1FGuDiRUibg1rvX3FQEZM5XXJ1RGldhmlPxCfH/r1m/EBpjz
         E9vLEHS3vuyfo6k+DMGswK9B0k/VYit0TxBtkdA7Qp50E0MM+k35ycykjOrP0+uUOPCY
         Mfnw==
X-Forwarded-Encrypted: i=1; AJvYcCWFRZ5q/xYA8R51P7SNGMeI9iMXUzCPHi9JeWkbIM9wJzg89AdbuIx7XYnLkNr3OtboxUoOFqPkWgftqPWU7A4iJd8AkBsL7K338CCfFpkyYX0xvxKSjMwh8kdELV7VdZchEeIlb59sZg==
X-Gm-Message-State: AOJu0YwrrAGrM8/+GdTBKcPxiCkwO6zwqilExomIKDUDld8t8tyhSCE1
	6Gfg4dTQ9P6UdIJWAJi2bc4Hzp8Vfq1/ZUI9+vGh8U9Qo4CyAkxs
X-Google-Smtp-Source: AGHT+IGbhRs9nJholLOLVhLsvxULMGP1/MxzpVWNfaIm9yRfiGrakmJA0Pk2xTuKIkzyoL43x6mr0A==
X-Received: by 2002:a17:906:f599:b0:a71:40d4:b1d7 with SMTP id a640c23a62f3a-a7d4015f9aemr644826966b.56.1722332292611;
        Tue, 30 Jul 2024 02:38:12 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acada27ddsm613910666b.184.2024.07.30.02.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 02:38:12 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs
Date: Tue, 30 Jul 2024 11:37:54 +0200
Message-Id: <20240730093754.1659782-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parth Pancholi <parth.pancholi@toradex.com>

Correct the McASP nodes - mcasp3 and mcasp4 with the right
DMAs thread IDs as per TISCI documentation [1] for J784s4.
This fixes the related McASPs probe failure due to incorrect
DMA IDs.

Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/j784s4/psil_cfg.html#psi-l-source-and-destination-thread-ids/ [1]
Fixes: 5095ec4aa1ea ("arm64: dts: ti: k3-j784s4-main: Add McASP nodes")
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index f170f80f00c1..d4ac1c9872a5 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -2755,7 +2755,7 @@ mcasp3: mcasp@2b30000 {
 		interrupts = <GIC_SPI 550 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "tx", "rx";
-		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
+		dmas = <&main_udmap 0xc403>, <&main_udmap 0x4403>;
 		dma-names = "tx", "rx";
 		clocks = <&k3_clks 268 0>;
 		clock-names = "fck";
@@ -2773,7 +2773,7 @@ mcasp4: mcasp@2b40000 {
 		interrupts = <GIC_SPI 552 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 553 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "tx", "rx";
-		dmas = <&main_udmap 0xc501>, <&main_udmap 0x4501>;
+		dmas = <&main_udmap 0xc404>, <&main_udmap 0x4404>;
 		dma-names = "tx", "rx";
 		clocks = <&k3_clks 269 0>;
 		clock-names = "fck";
-- 
2.34.1


