Return-Path: <linux-kernel+bounces-286724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9CA951E58
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD0FB27600
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D361B1426;
	Wed, 14 Aug 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VERw/oj/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749611AD9D4;
	Wed, 14 Aug 2024 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648329; cv=none; b=gZrDfEYycXwb+tsQeXEt86KiDoAroU4fy8y5kQxeaFmzyDzUkVYOaS2J3AAM6DCaE3YctXKcwuJ3Xx2xO1JFEZJ9slmGN4Su6Nn7YVUn5jNyqykE5RZH3tB+WNskqXPUF5dqXQZNYnUbM08Ah0UKie/j+I9epSy/L2zU+jOKt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648329; c=relaxed/simple;
	bh=N0GjTO6lw4nWbRucXBBjCG3Ca2P3uIbvoiXaED5K/nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G2ffU9L0ZO33yv0ibnCuzThVL1sRA7FXa1uaMadJ04DEnC9GHnwUuQieGPfzaTBo+ItY9gOYIcATNCV9hPt6FW3TlqMBFTTNLOYHq79n8kNxP5JYyz1coQ2wx6GG9QOOg+woAcgsUzzB4I/L7d7F+i8zQzFaaanGwq0AcL6duUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VERw/oj/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EFBwaZ074051;
	Wed, 14 Aug 2024 10:11:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723648318;
	bh=1mHukVPhO0wytGSj5rvSZUWLOHHrbX9az+sUuQyJhF8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VERw/oj/xKZIakzD/+8/9qdR4njZhj3TCcr3dvcMzhX7jeb1R9ub92Hmvh8absW0q
	 MT26UlrbVbMaWBxxhvl410mCRrjJ7WAfx2i4e8+Scn3wg6ehgaYz15RvB8E1FFrCpn
	 mQ8+Nj/hMeNlAJivznckCmadpSjxWQayV7RK8BtE=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EFBwpE057805
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 10:11:58 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 10:11:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 10:11:57 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EFBorG079640;
	Wed, 14 Aug 2024 10:11:51 -0500
Message-ID: <8394ab04-5e5c-4e06-b1d1-7eb64bacedbe@ti.com>
Date: Wed, 14 Aug 2024 20:41:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arm64: dts: ti: k3-j7200: Change timer nodes
 status to reserved
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240814104151.2038457-1-b-padhi@ti.com>
 <20240814104151.2038457-2-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240814104151.2038457-2-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/14/2024 4:11 PM, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain

There is no DSP on this SOC.

Please consider to re-word commit message


> use timers. Therefore, change the status of the timer nodes to
> "reserved" to avoid any clash. Usage is described as below:
>
> 	+===================+==========================+
> 	|  Remoteproc node  |        Timer Node        |
> 	+===================+==========================+
> 	| main_r5fss0_core0 | main_timer0, main_timer2 |
> 	+-------------------+--------------------------+
> 	| main_r5fss0_core1 | main_timer1              |
> 	+-------------------+--------------------------+


> This change is already incorporated for timer nodes in the MCU voltage
> domain.

For whole series,  on MCU domain R5 we have device-manager firmware,

which is needed to get SOC functional. So MCU domain timers are reserved.

So my suggestion will be to avoid above message


>
> Fixes: c8a28ed4837c ("arm64: dts: ti: k3-j7200: Add general purpose timers")
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   .../boot/dts/ti/k3-j7200-common-proc-board.dts      | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 6593c5da82c0..a65066bd7f09 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -471,3 +471,16 @@ &main_mcan3 {
>   	pinctrl-0 = <&main_mcan3_pins_default>;
>   	phys = <&transceiver3>;
>   };
> +
> +/* Timers are used by Remoteproc firmware */
> +&main_timer0 {
> +	status = "reserved";
> +};
> +
> +&main_timer1 {
> +	status = "reserved";
> +};
> +
> +&main_timer2 {
> +	status = "reserved";
> +};

