Return-Path: <linux-kernel+bounces-545151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F2A4E9AD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E12F422B12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C07E27BF95;
	Tue,  4 Mar 2025 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="iZ92R1bm"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E492641D2;
	Tue,  4 Mar 2025 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108567; cv=pass; b=qRGurCJXD/uO42N2n0MWYmcvpXH7DwtwZf9jeSw0DxVI6oie812jsAgzcg3siAxMBVOLkzBmVHmq26WOWoTUmAtRrJQJDfIYA3ohm1BgMdRBcfzPlHE4z02isJBsH4CldMa28laMgyYFKI2BNit8eoapCeW6RqwNqCmCwzkp6oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108567; c=relaxed/simple;
	bh=o4ANY14hWRIwtKVWCXcGO/oB6Wh2/DmDCFxxX43F+rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6CO558yYvBmp4ValBt/qPhgYICmpZX92r90bmpZmz+8md/DsM1UxR158aaPFWidEHKExsR0M1MJCJIIHQnYSlBS2omJWCKb7GzXrLyt6878gGJJhp5OwRFdIjfX/WUGz4Nq8Ovdz7lGx6TRlXbdI/6JPsBFQKAXqHN2LPAb/ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=iZ92R1bm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741108545; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lctTwBqJFIARNjlmaiBoqnWTDuFL6WUoet0a2YxlKbWgWdDYPMn95/BTjQToLDf/abIelZwvV1uj3d89LIS1i1ltiEI+UKlRp3/8SyMyJ7SdOWzBsiLfXzXCHVJOtE+umfRg9KEpTKlsWiy4hamAxV09fugUxsO884hC4/nSmDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741108545; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OdTMORqBJYLjJhRhGFzMiRnquj3qLzmSjVu6QO5a5kk=; 
	b=FylPp3MBGmDQMN/pBeGvf/nlfitPWrxtJuNFW1hElVBSKa9gwj9hvgXnC7n3hkYVsrXdJ9tOOOS6e7I9tH0jmq3LJnioHnPOOTHy5Eap+FaXnP6evnYXp7koRxcfjCdwhNnv0LmmqvOeFxqr1Z+xElwHIEHfdTiOXsx8jw5q2os=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741108545;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=OdTMORqBJYLjJhRhGFzMiRnquj3qLzmSjVu6QO5a5kk=;
	b=iZ92R1bmhXCY3JwYVZzfbnH2LfLmo7z7gtnUl330xU5kEcvEPqsbfFbIZJBzSwL/
	TBPwwQK7BbTzEaNVpMyAgSYew4KU6JsfnNOHeBgs9Z8xZuymFdPapP8aic0NcqaVz2e
	gySBtZSmtRTQa/8DJX0urb3IO4lphjRepIKzcVl8=
Received: by mx.zohomail.com with SMTPS id 174110854289189.58519837207825;
	Tue, 4 Mar 2025 09:15:42 -0800 (PST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: heiko@sntech.de, Andy Yan <andyshrk@163.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: rockchip: Add vop for rk3576
Date: Tue, 04 Mar 2025 12:15:41 -0500
Message-ID: <12619358.O9o76ZdvQC@earth>
In-Reply-To: <20241231095728.253943-2-andyshrk@163.com>
References:
 <20241231095728.253943-1-andyshrk@163.com>
 <20241231095728.253943-2-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

Hi andy,

On Tuesday, 31 December 2024 04:57:18 EST Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Add VOP and VOP_MMU found on rk3576.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v3:
> - Split from
> https://lore.kernel.org/linux-rockchip/3330586.aeNJFYEL58@diego/T/#t
> 
>  arch/arm64/boot/dts/rockchip/rk3576.dtsi | 68 ++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3576.dtsi index 436232ffe4d1..130d11a2cc89
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
> @@ -393,6 +393,11 @@ opp-950000000 {
>  		};
>  	};
> 
> +	display_subsystem: display-subsystem {
> +		compatible = "rockchip,display-subsystem";
> +		ports = <&vop_out>;
> +	};
> +
>  	firmware {
>  		scmi: scmi {
>  			compatible = "arm,scmi-smc";
> @@ -826,6 +831,69 @@ gpu: gpu@27800000 {
>  			status = "disabled";
>  		};
> 
> +		vop: vop@27d00000 {
> +			compatible = "rockchip,rk3576-vop";
> +			reg = <0x0 0x27d00000 0x0 0x3000>, <0x0 0x27d05000 
0x0 0x1000>;
> +			reg-names = "vop", "gamma-lut";
> +			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "vop-sys",
> +					  "vop-vp0",
> +					  "vop-vp1",
> +					  "vop-vp2";

These need to be renamed without the 'vop-' prefix.

> +			clocks = <&cru ACLK_VOP>,
> +				 <&cru HCLK_VOP>,
> +				 <&cru DCLK_VP0>,
> +				 <&cru DCLK_VP1>,
> +				 <&cru DCLK_VP2>;
> +			clock-names = "aclk",
> +				      "hclk",
> +				      "dclk_vp0",
> +				      "dclk_vp1",
> +				      "dclk_vp2";
> +			iommus = <&vop_mmu>;
> +			power-domains = <&power RK3576_PD_VOP>;
> +			rockchip,grf = <&sys_grf>;
> +			rockchip,pmu = <&pmu>;
> +			status = "disabled";
> +
> +			vop_out: ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				vp0: port@0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0>;
> +				};
> +
> +				vp1: port@1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +				};
> +
> +				vp2: port@2 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <2>;
> +				};
> +			};
> +		};
> +
> +		vop_mmu: iommu@27d07e00 {
> +			compatible = "rockchip,rk3576-iommu", 
"rockchip,rk3568-iommu";
> +			reg = <0x0 0x27d07e00 0x0 0x100>, <0x0 0x27d07f00 
0x0 0x100>;
> +			interrupts = <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
> +			clock-names = "aclk", "iface";
> +			#iommu-cells = <0>;
> +			power-domains = <&power RK3576_PD_VOP>;
> +			status = "disabled";
> +		};
> +
>  		qos_hdcp1: qos@27f02000 {
>  			compatible = "rockchip,rk3576-qos", "syscon";
>  			reg = <0x0 0x27f02000 0x0 0x20>;

Regards,
Detlev



