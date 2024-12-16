Return-Path: <linux-kernel+bounces-447158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D89059F2E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A32F7A1623
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACA82036FC;
	Mon, 16 Dec 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oEktoE4a"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923ED2010EF;
	Mon, 16 Dec 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344619; cv=none; b=Sney2KFyT6ZWRSba9vlHIX6sdvTb4AMCuCwkgZInD17DKDyKIVcvL24wXvLDIvu0qx/3Eo45dBvWKIH/4ACgJyRZXE/Vu0Ogpg8jiZoCXyRC8WsBudozFSGzAAN/Jc8qtI+HPLZ4dH4jC5vNpi/uXo5NSL5RJbvSbfqceJ6F8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344619; c=relaxed/simple;
	bh=UR6BT10WJBMcan81i1y8w0R9qUZV+RZW9V8xUt1G82U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CEWwkaikUce224HjzuhZS2HBsKD4Z7bw9wNepUMLJqWMCXLv8TgeR0pTlN6KBULPwo0qwuaD0eW5MF1wJQXew0kOdFfePTmhB0S/ZtN52x0HQHks9QEhKiSlVi1rJQ+DnQg1GisedrEtPyq+wdDaBywPV9AJ4l294r4rQGcZ3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oEktoE4a; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BGANJAT3534883
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 04:23:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734344599;
	bh=uX3GRQY8ZjoFkYOsoectf+6ARiXV3tO9qdpKTI0l3jI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oEktoE4aCS2xjadU5ED3jaR2J1oHjDhRc+M2DRBX0FEEt+UUpvfqqEtimb9B9oqfg
	 xuC+yrxMhZIUMHRH+9Vg2zgjD+O2yJ61c0eHU9yulLUwKNMb/qqUwtWGjJRmhT8yto
	 9kNIQvs8x3v6ss341kNl2I7FSXUdEwS8sGbH3ROQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BGANJqK077479
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 04:23:19 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Dec 2024 04:23:18 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Dec 2024 04:23:18 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BGANE26104700;
	Mon, 16 Dec 2024 04:23:15 -0600
Message-ID: <7c48ccdc-41b3-4205-854d-9b7a60f70da2@ti.com>
Date: Mon, 16 Dec 2024 15:53:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add Clocks for ICSSG
To: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <ssantosh@kernel.org>, <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>, <kristo@kernel.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20241113110955.3876045-1-danishanwar@ti.com>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20241113110955.3876045-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vignesh / Nishant

On 13/11/24 4:39 pm, MD Danish Anwar wrote:
> This series adds clocks for ICSSG for AM64x.
> 
> PATCH 1/2 Adds the dt binding necessary to add clocks to the device tree.
> It adds the `clocks` in the dt binding of ICSSG node. Each ICSSG instance
> has 7 clocks available to them as per AM64x TRM [1] Section 6.4.3 Table 
> 6-398. They are not added in the dt bindings yet. This patch adds all
> available clocks to ICSSG bindings. 
> 
> PATCH 2/2 Adds the required clock to the ICSSG nodes. It also changes the
> clock used from clock 20 (ICSSG_ICLK) to clock 0 (ICSSG_CORE). This patch
> adds the clock-names, assigned-clocks and assigned-clock-parents to icssg
> nodes.
> 
> More details on clocks can be found at [2]
> There is no additional driver changes needed for this binding change.
> 
> Changes from v2 to v3:
> *) Modified commit message of PATCH 1/2 to state why clocks are being added
> to the binding.
> *) Added all available clocks to ICSSG bindings. Earlier only two clocks
> were added.
> *) Added all available clocks to AM64x DTS. Earlier only two clocks were
> added.
> 
> Changes from v1 to v2:
> *) Dropped assigned-clocks and assigned-clock-parents from DT binding as
> suggested by Krzysztof Kozlowski
> 
> [1] https://www.ti.com/lit/pdf/spruim2
> [2] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am64x/clocks.html#clocks-for-pru-icssg0-device
> v1 https://lore.kernel.org/all/20241107104557.1442800-1-danishanwar@ti.com/
> v2 https://lore.kernel.org/all/20241108142946.2286098-1-danishanwar@ti.com/
> 
> MD Danish Anwar (2):
>   dt-bindings: soc: ti: pruss: Add clocks for ICSSG
>   arm64: dts: ti: k3-am64-main: Switch ICSSG clock to core clock
> 
>  .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 10 +++++++++
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi      | 22 +++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> 
> base-commit: bd05b9a700c10473c2f52bf12c5c5938c30e80b0

This series still applies cleanly on latest linux-next (next-20241216)
and doesn't need a re-base.

Can you please pick this.


-- 
Thanks and Regards,
Danish

