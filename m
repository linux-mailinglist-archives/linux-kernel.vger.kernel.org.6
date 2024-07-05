Return-Path: <linux-kernel+bounces-242298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666CF928666
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7931B210AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFA7146A62;
	Fri,  5 Jul 2024 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TqssU6fG"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4413B5BB;
	Fri,  5 Jul 2024 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174115; cv=none; b=lFGJpHy4hIOidqdb4BVgi2FZaloMkEVkpF5p0FjXtg7i/CqdSzeJHDDBKDAxJbH7KQ1ZsdGZcGzr4WXdPdGCQtaQQ4WHP+IMcQj82PoMJ7Bih/ZZ/rYb+dgcnqVlIQclJXIjZq5J0SBdTtlaN3FaZf51jPXH9dxclMS7BZR1Lcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174115; c=relaxed/simple;
	bh=kP3QeFnDIFukQzzLmnBwW3AvNzEX33OvNmR/mRSuSKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgCKl1aP0Gx5SEWi4eYAV1YT6UiFrCz+CjerUmCTuF5wkmRbd4JxmiiOWhB1k6THrCoiP15tZCvCy32UwjWbxL4ctubO36FFW+okU6ApYNVY92XvOMu2q/QC6+Wwfr6SX1rkGafh6zcncqDfSD2+Ah6lVaP+u2O1biDRBAUSenQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TqssU6fG; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465A8NjV042760;
	Fri, 5 Jul 2024 05:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720174103;
	bh=X0TWfqISVSqoER+zfdbU+LKPndrXxzn6J1t1M6cfB1Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=TqssU6fGcplUwTRFTwLmmeFfBfOrzCl7RhMpUafKPqCHvBCwj4G81hx/OekqOAOng
	 ZFuGoHDqVEOrrFiY8+O4YLNVATIT0VuYdSteS1hEzeQ8rImZOckKPfZS0zL7m6Gl5p
	 CCtJ3jzVAb3exn9XUI1lcMJpL1cH2dzknl+0U488=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465A8NVi029913
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 05:08:23 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 05:08:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 05:08:23 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465A8M5t115201;
	Fri, 5 Jul 2024 05:08:22 -0500
Date: Fri, 5 Jul 2024 15:38:21 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Neha Malcom Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Beleswar Padhi
	<b-padhi@ti.com>
Subject: Re: [PATCH v2 0/5] Add bootph-all property for J7 boards
Message-ID: <20240705100821.p24a52g2xrlw7kfq@uda0497581>
References: <20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On 11:56-20240705, Manorit Chawdhry wrote:
> The idea of this series is to add bootph-all and bootph-pre-ram property
> in all the leaf nodes wherever required and cleanup any other places where
> bootph-all/bootph-pre-ram exist in the parent nodes as well.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Changes in v2:
> 
> * Aniket
> - Change wkup_vtm0 bootph-all to bootph-pre-ram
> - Add bootph-all explicitly to dmsc/sms nodes as otherwise the boards
>   don't boot
> 
> - Cleanup more nodes along with some testing with u-boot.

Here is the u-boot patch with the cleanup that I have tried [0] and here
is the corresponding boot log for that [1].

[0]: https://github.com/manorit2001/u-boot/tree/b4/upstream/j7/remove-bootph
[1]: https://gist.github.com/manorit2001/da42b634fabb662a48728927cdcb1acc

Regards,
Manorit

> - Fix build errors
> - Link to v1: https://lore.kernel.org/r/20240507-b4-upstream-bootph-all-v1-0-c6d52651856f@ti.com
> 
> ---
> Manorit Chawdhry (5):
>       arm64: dts: ti: k3-j721s2*: Add bootph-* properties
>       arm64: dts: ti: k3-j784s4*: Remove bootph properties from parent nodes
>       arm64: dts: ti: k3-am68*: Add bootph-* properties
>       arm64: dts: ti: k3-j721e*: Add bootph-* properties
>       arm64: dts: ti: k3-j7200*: Add bootph-* properties
> 
>  arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   | 10 ++++++++++
>  arch/arm64/boot/dts/ti/k3-am68-sk-som.dtsi         |  2 ++
>  .../boot/dts/ti/k3-j7200-common-proc-board.dts     | 23 ++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |  2 ++
>  arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    | 11 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |  7 +++++++
>  .../boot/dts/ti/k3-j721e-common-proc-board.dts     | 20 +++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  2 ++
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    | 10 ++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 18 +++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |  5 +++++
>  .../boot/dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |  2 ++
>  arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   | 12 +++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |  2 ++
>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  9 +--------
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  7 ++++---
>  17 files changed, 145 insertions(+), 11 deletions(-)
> ---
> base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> change-id: 20240430-b4-upstream-bootph-all-8d47b72bc0fd
> 
> Best regards,
> -- 
> Manorit Chawdhry <m-chawdhry@ti.com>
> 

