Return-Path: <linux-kernel+bounces-516635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3DA3750A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CD73AA017
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DA199947;
	Sun, 16 Feb 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="kgAy8grO"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A521993A3;
	Sun, 16 Feb 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739719614; cv=pass; b=V3wlbgdpOx7CVrzFWAiQvT9gjMRh6Jj5119EC9jSaM5qUGUcqeokDxckF6uD5lsu4q9eo8kpNvNbn+ZrerbhAJzUdAOMD+73vvpS9N7/LsEYENN1P0lwyXIsac0oo4ErSANvByAsg+rxCQn0W2qsUwjHQtl66gBfa9HVq4xyVx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739719614; c=relaxed/simple;
	bh=P1GGikOFBhM64e8ThnF+EAlpwy8a7Ben4RjDWz90wQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drM3WEfL/QO62eDWvaoRhuvqu2kmQTY3QgPRC6B1aNysIRADtr5dldCpx3G7wvkpv0uXWL6Q2eVH7CG1zVnKJO6UdvQKI1RqMct2AE5xaZU0vriDO5eYQdt/Kdxmgu7Fvuz8Zt2lHfGlZaBx3Lj1V/KSpp9mRBjrIIIZP2iWMhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=kgAy8grO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739719582; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lUhEfBRVSo79Huwj+wzJXrPk5x+fk3E/WKGITPucvjJqsA9W28bDmDYVIJV5OtFAzZeiVpgvZPaVBL0jA2EZlDpwAJwHH9YYg2PUUYKyNt01rrEr3hbg9a+dPEq0rW0iyLQDZMJ8tkEy0GxUX31+9P0heIbOShMCEwNL8d5xrfw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739719582; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nGRt15avi2VNEMTjVMkiOHeiNiOp/BakzHpL53Qa5IE=; 
	b=U9YsfwGHz31g0HHvFlwd3Ll2mrkoeK5MGiFIJng82FZjicNRTv862tyKmTmh5OhEUNTocN9QrCZIiZh0SGOBfnBzbZx2P/uVVTZnLLccxOmR3hvfnfNaP3x24xhDsBYoGVY/sd+S8hhIHwCCSGhzx+eIOwNA5WZOyeIxZvyUjAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739719582;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nGRt15avi2VNEMTjVMkiOHeiNiOp/BakzHpL53Qa5IE=;
	b=kgAy8grO7hkyPy96FKPI4UObo/yrWIeiiaBNuy7Tc950wRdugBlFZpr/ZONvD7Ah
	ULiiPIxBSZs4lF8cvqP6J3Jlduftn7FOEMoRpzuwUIvxgREIecs7vZbTc28F07I9i8F
	Nd7mJq4SelsxoZ2nib+Oh6mugQdlM/n37qoawp2M=
Received: by mx.zohomail.com with SMTPS id 1739719580093298.8599431071333;
	Sun, 16 Feb 2025 07:26:20 -0800 (PST)
Message-ID: <68b4a5bb-79df-425a-af66-fa8973866729@collabora.com>
Date: Sun, 16 Feb 2025 18:26:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] arm64: dts: rockchip: rk356x: Add MSI controller
 node
To: Marc Zyngier <maz@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kever Yang <kever.yang@rock-chips.com>,
 XiaoDong Huang <derrick.huang@rock-chips.com>,
 Peter Geis <pgwipeout@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 kernel@collabora.com
References: <20250215235431.143138-1-dmitry.osipenko@collabora.com>
 <20250215235431.143138-4-dmitry.osipenko@collabora.com>
 <87r03y1a75.wl-maz@kernel.org>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <87r03y1a75.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/16/25 12:59, Marc Zyngier wrote:
> On Sat, 15 Feb 2025 23:54:30 +0000,
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
>>
>> Rockchip 356x SoC's GIC has two hardware integration issues that
>> affect MSI functionality of the GIC. Previously, both these GIC
>> limitations were worked around by using MBI for MSI instead of ITS
>> because kernel GIC driver didn't have necessary quirks.
>>
>> The first limitation is about RK356x GIC not supporting programmable
>> shareability. Rockchip assigned Errata ID #3568001 for this issue.
>>
>> Second limitation is about GIC AXI master interface addressing only
>> first 4GB of DRAM. Rockchip assigned Errata ID #3568002 for this issue.
>>
>> Now that kernel supports quirks for both of the erratums, add
>> MSI controller node to RK356x device-tree.
>>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> index 28be38b7182e..423185686600 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
>> @@ -284,7 +284,18 @@ gic: interrupt-controller@fd400000 {
>>  		mbi-alias = <0x0 0xfd410000>;
>>  		mbi-ranges = <296 24>;
>>  		msi-controller;
>> +		ranges;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>>  		dma-noncoherent;
>> +
>> +		its: msi-controller@fd440000 {
>> +			compatible = "arm,gic-v3-its";
>> +			reg = <0x0 0xfd440000 0 0x20000>;
>> +			dma-noncoherent;
>> +			msi-controller;
>> +			#msi-cells = <1>;
>> +		};
>>  	};
>>  
>>  	usb_host0_ehci: usb@fd800000 {
> 
> You can merge this patch with the previous one. Marking the GIC
> non-coherent is pointless if no ITS is available, because there is no
> point in allocating memory for them.

Ack

-- 
Best regards,
Dmitry

