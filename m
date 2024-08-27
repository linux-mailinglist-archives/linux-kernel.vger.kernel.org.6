Return-Path: <linux-kernel+bounces-303889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55453961687
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DBE1C229C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DBF1D31A3;
	Tue, 27 Aug 2024 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UKtnCYcu"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC41D278F;
	Tue, 27 Aug 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782356; cv=pass; b=TDiFRjjgIHAtDJAarTwxWgu6nbMZD/3nrzsgNoG62VmpjW55Sdz/tbTClglP8Ar/D9mPHfB096zhVeWlyGiem5o9bXXPQRoRPDkMVfPlMSIdDb7Q6RCxN2llVeY1czkQfkhKszw03OJrEuDWZxHYn/2GrCRtZTrn7ceba4nYdUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782356; c=relaxed/simple;
	bh=fGK3sr087LlRrDU7/01v1k8bQjwsZtJxPIB7V0I3ElM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1FJk3bHLcb9Fe53+s/AH57b8FsjoQ7jl4yAY0eck6ZExCBuHLayHIh51SlU3yhWqSdO0Ls25cPfLcxorPhAGe/uSaA+1nSd03bnh3sCmlGkKeA0WJhVkODTblQLobDv8r+gc0/wzm5ezXwZB1/5FIVDOHZiX0xT4V65GdIlHqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UKtnCYcu; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724782336; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LMgi7/NBcxEZkmDljZOPFkoW1DnfJ8dU991UVIRW1hk2wbdOIHDHBk4JEERf6BxGN9lrwlnAvYhjWVLspsxWAw5Ff5hOkDlWLsivXHt9UI1vZQjemlpreO7gmjlaYY+qe9M/J8qEatk4mgXF4bOSHNbC173lLqXI9LgM3a4xRKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724782336; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7Qw7xQaaRdRo3sbWDfRfnQBuFJO1K2dl+tdXAcckUEQ=; 
	b=RDGHAOz0ni4V3Sq3GshnAjqTT9jB9aDngqsgkwq4c9farVsGkSBVkdFlCynJFfPOmnpGJDJMOJnopUmTsRuPCnZDqydMts1D0Q5Y2FHKrBC5covMMmQ/BmauaOcj/8bpWpwvtALBWEfBxkn5qOrpRtRvnFWClMZiwpK6i6n2hLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724782336;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7Qw7xQaaRdRo3sbWDfRfnQBuFJO1K2dl+tdXAcckUEQ=;
	b=UKtnCYcu5tPRq303+Z3hmCNHrJVTcAvTatB+lc3dJrEnnm+f8ZNu+c9h/z+QRroF
	e6SvPEuUw6NBFNcxXcnj1mbyykxuodAQy4cMp6oi1hF6EID5SbJsZOhtA+OSfqzvzZa
	1+2HuR1UT+dNnMb9JWFgxtiycPlPJ7May91bMPdc=
Received: by mx.zohomail.com with SMTPS id 172478233479718.156062356846064;
	Tue, 27 Aug 2024 11:12:14 -0700 (PDT)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E10EC4800E1; Tue, 27 Aug 2024 20:12:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v8 1/2] arm64: dts: rockchip: Add VEPU121 to RK3588
Date: Tue, 27 Aug 2024 20:10:20 +0200
Message-ID: <20240827181206.147617-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240827181206.147617-1-sebastian.reichel@collabora.com>
References: <20240827181206.147617-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

RK3588 has 4 Hantro G1 encoder-only cores. They are all independent IP,
but can be used as a cluster (i.e. sharing work between the cores).
These cores are called VEPU121 in the TRM. The TRM describes one more
VEPU121, but that is combined with a Hantro H1. That one will be handled
using the VPU binding instead.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588-base.dtsi
index b6e4df180f0b..595f129a2d8c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1122,6 +1122,86 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};
=20
+	vepu121_0: video-codec@fdba0000 {
+		compatible =3D "rockchip,rk3588-vepu121";
+		reg =3D <0x0 0xfdba0000 0x0 0x800>;
+		interrupts =3D <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
+		clock-names =3D "aclk", "hclk";
+		iommus =3D <&vepu121_0_mmu>;
+		power-domains =3D <&power RK3588_PD_VDPU>;
+	};
+
+	vepu121_0_mmu: iommu@fdba0800 {
+		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg =3D <0x0 0xfdba0800 0x0 0x40>;
+		interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
+		clock-names =3D "aclk", "iface";
+		power-domains =3D <&power RK3588_PD_VDPU>;
+		#iommu-cells =3D <0>;
+	};
+
+	vepu121_1: video-codec@fdba4000 {
+		compatible =3D "rockchip,rk3588-vepu121";
+		reg =3D <0x0 0xfdba4000 0x0 0x800>;
+		interrupts =3D <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER1>, <&cru HCLK_JPEG_ENCODER1>;
+		clock-names =3D "aclk", "hclk";
+		iommus =3D <&vepu121_1_mmu>;
+		power-domains =3D <&power RK3588_PD_VDPU>;
+	};
+
+	vepu121_1_mmu: iommu@fdba4800 {
+		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg =3D <0x0 0xfdba4800 0x0 0x40>;
+		interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER1>, <&cru HCLK_JPEG_ENCODER1>;
+		clock-names =3D "aclk", "iface";
+		power-domains =3D <&power RK3588_PD_VDPU>;
+		#iommu-cells =3D <0>;
+	};
+
+	vepu121_2: video-codec@fdba8000 {
+		compatible =3D "rockchip,rk3588-vepu121";
+		reg =3D <0x0 0xfdba8000 0x0 0x800>;
+		interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER2>, <&cru HCLK_JPEG_ENCODER2>;
+		clock-names =3D "aclk", "hclk";
+		iommus =3D <&vepu121_2_mmu>;
+		power-domains =3D <&power RK3588_PD_VDPU>;
+	};
+
+	vepu121_2_mmu: iommu@fdba8800 {
+		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg =3D <0x0 0xfdba8800 0x0 0x40>;
+		interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER2>, <&cru HCLK_JPEG_ENCODER2>;
+		clock-names =3D "aclk", "iface";
+		power-domains =3D <&power RK3588_PD_VDPU>;
+		#iommu-cells =3D <0>;
+	};
+
+	vepu121_3: video-codec@fdbac000 {
+		compatible =3D "rockchip,rk3588-vepu121";
+		reg =3D <0x0 0xfdbac000 0x0 0x800>;
+		interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER3>, <&cru HCLK_JPEG_ENCODER3>;
+		clock-names =3D "aclk", "hclk";
+		iommus =3D <&vepu121_3_mmu>;
+		power-domains =3D <&power RK3588_PD_VDPU>;
+	};
+
+	vepu121_3_mmu: iommu@fdbac800 {
+		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
+		reg =3D <0x0 0xfdbac800 0x0 0x40>;
+		interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks =3D <&cru ACLK_JPEG_ENCODER3>, <&cru HCLK_JPEG_ENCODER3>;
+		clock-names =3D "aclk", "iface";
+		power-domains =3D <&power RK3588_PD_VDPU>;
+		#iommu-cells =3D <0>;
+	};
+
 	av1d: video-codec@fdc70000 {
 		compatible =3D "rockchip,rk3588-av1-vpu";
 		reg =3D <0x0 0xfdc70000 0x0 0x800>;
--=20
2.45.2


