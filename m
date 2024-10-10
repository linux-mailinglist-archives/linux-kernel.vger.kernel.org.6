Return-Path: <linux-kernel+bounces-359463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F6998D57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA80B3A583
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590D1CDFCB;
	Thu, 10 Oct 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f0ooyYto"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DE1C9ED3;
	Thu, 10 Oct 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574524; cv=none; b=QSAOoVz0EtOawCiGIhx7YWuKM9682ezA7hHrOqioiTfpTL6wBWQOam5orIln7cb3yBXo10CXP+8rNEIQp5iAuKSYcM8O1xK1LZz3YTNwjRRXrTCnlYzSHAVOhbu3b0/NpboXvckqMKMQFcQQu+s71ZlyGo3P7pF/2/awZRZOGp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574524; c=relaxed/simple;
	bh=S4ZTiA63hcp1zp2AaoACJv2E5yFttOZ3Qjc9pOsDwvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ccAFdGR9G8oQSuvL0VJMA6lXATawWa58jBUWdNWyBpAD9FKP9+M0DFfljchjs5usujG9s/LG55HsBEm/xKTItniQNh1Rs516tqve2F89J+s360QFXrXCeaQ4uykWUCMtcG1Q87TQuyQX7EGqZJtM+gWFaqtTv/5qpSjYaNnxFZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=f0ooyYto; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49AFZCdj123024;
	Thu, 10 Oct 2024 10:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728574512;
	bh=+n1MH9ezTRTumafnMkWg0MYerZadPH86fR420sIJO5k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=f0ooyYtovZoVJsRDDLE0/dDBIPICxpybZiaQmkf3BEeYrjG1nnp8IqzbjiUgE30UA
	 KRgT6PdOO2g0WF/Gl2vVaKJsh70UZM5jP/7naVVE6W5zutxeAAO9CT7BvFy6J9bg4M
	 Es8xotWkhev+Xlj/ijyRGvL4FE6Din/LqgoJyBqU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49AFZClQ107533;
	Thu, 10 Oct 2024 10:35:12 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 10:35:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 10:35:11 -0500
Received: from [10.249.130.82] ([10.249.130.82])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49AFZ6T4064121;
	Thu, 10 Oct 2024 10:35:07 -0500
Message-ID: <c9b46bc4-aa4f-47fa-8c88-4fd80b91386f@ti.com>
Date: Thu, 10 Oct 2024 21:05:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] arm64: dts: ti: k3-j784s4: Mark tps659413
 regulators as bootph-all
To: Andrew Halaney <ahalaney@redhat.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
        Eric
 Chanudet <echanude@redhat.com>,
        Enric Balletbo <eballetb@redhat.com>, Udit
 Kumar <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240916-j784s4-tps6594-bootph-v3-0-ab70da0de7bd@redhat.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20240916-j784s4-tps6594-bootph-v3-0-ab70da0de7bd@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 16-09-2024 22:44, Andrew Halaney wrote:
> This series marks tps659413's regulators as bootph-all in order for
> the nodes (and parent nodes) to be accessible during MCU's u-boot SPL.
>
> This in turn is desired since the tps659413 needs its MCU ESM
> state machine setup in order for the watchdog to reset the board.
>
> This took me a little while to track down, as enabling the ESM, TPS6594,
> etc in u-boot would result in the below boot failure:
>
>      U-Boot SPL 2024.10-rc4-00007-g44b12cbcd1b3-dirty (Sep 06 2024 - 14:25:52 -0500)
>      SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
>      Initialized 4 DRAM controllers
>      SPL initial stack usage: 13408 bytes
>      ### ERROR ### Please RESET the board ###
>
> Which turns out to actually have failed far earlier in spl_early_init(),
> due to these nodes not being accessible in u-boot. That's hard to tell
> though since console isn't setup until later (and for that reason I
> think spl_early_init()'s return value in j784s4_init.c isn't
> evaluated since a panic() at that point would leave a user with *no*
> information at all).
>
> I've tested this in conjunction with a u-boot series which I'll link in
> a follow-up response on the k3-j784s4-evm. I'd appreciate someone testing
> on the k3-am69-sk at a minimum, as it should suffer the same fate if things
> aren't setup appropriately.
>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
> Changes in v3:
> - Added Udit's Tested-by tags
> - Reordered bootph-all to align with dts-coding-style (Beleswar)


Thanks for the change, LGTM. For the series,

Reviewed-by: Beleswar Padhi <b-padhi@ti.com>

Thanks,
Beleswar

> - Link to v2: https://lore.kernel.org/r/20240911-j784s4-tps6594-bootph-v2-0-a83526264ab1@redhat.com
>
> Changes in v2:
> - Only mark the regulator nodes as bootph-all since parents are implied
> - Link to v1: https://lore.kernel.org/r/20240906-j784s4-tps6594-bootph-v1-0-c5b58d43bf04@redhat.com
>
> ---
> Andrew Halaney (2):
>        arm64: dts: ti: k3-j784s4-evm: Mark tps659413 regulators as bootph-all
>        arm64: dts: ti: k3-am69-sk:  Mark tps659413 regulators as bootph-all
>
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts    | 8 ++++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++++++
>   2 files changed, 16 insertions(+)
> ---
> base-commit: 7083504315d64199a329de322fce989e1e10f4f7
> change-id: 20240906-j784s4-tps6594-bootph-19d3f00fb98a
>
> Best regards,

