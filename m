Return-Path: <linux-kernel+bounces-540993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A8FA4B741
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D8963A88CC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD1101C8;
	Mon,  3 Mar 2025 04:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AcebxZ7+"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6303C1AD3E1;
	Mon,  3 Mar 2025 04:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977321; cv=none; b=Q+Vv2+D/bpizLlkYJYoxeuPfIxABySzCYnJHgXMr6kZ/5ObtcxAJcldqWsVCoxM/Z8hh0TCYy/MQWJ20bGpjbEz8snwY7jaQLVKA4vLTrgcEMWAcIjgv72JRP2WnS86kIAW1VC8QYkIbzRbG0p8R9z7hV5GMDkwRab7ZtRUD5lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977321; c=relaxed/simple;
	bh=p6LwRYtnrJJfZZ5+BCgQMKzaVUcIMcR0HgH6NfODAlA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glP/92PR1xW14syeU8szaMDBzK+kvxHHHunMh2rRFHTMnXHNyZfFf7iNbZXBuQ3WxsM+sCsybjjkOHMyEgTQaC/4i6llZZFguStS3xZ8tZnm8n1JtCAyJRMvlLYaqj2avePYOUEaL/fKDCyPjCwElSkXFIevWVUXev3OU+csT28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AcebxZ7+; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5234mVZX3208506
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 2 Mar 2025 22:48:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740977311;
	bh=5Pd0XNKoaa+c5gJJj/KYlWqJ+Okkhjx9Gpi5+4VeGsY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AcebxZ7+J6s7vmnwnJ9lZbjTG3EiyILDgP2xu2uzJG2KgA70SousSikGCM/Dj49E3
	 TEI9eOQZ6EA9AQPATMbmSsQBAu0E3/uS9fP5bQkiuoNWYtqCwdbouZ09ASsN3xT6OU
	 2Qnzaa060XJIRe4LnHWoKXFQ0G7nmw7FA+B9NerY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234mV5m030303;
	Sun, 2 Mar 2025 22:48:31 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 22:48:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 22:48:30 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234mQEw107786;
	Sun, 2 Mar 2025 22:48:27 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <r-gunasekaran@ti.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>, Hrushikesh Salunke <h-salunke@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <srk@ti.com>, <danishanwar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Fix USB2.0_MUX_SEL to select Type-C
Date: Mon, 3 Mar 2025 10:18:21 +0530
Message-ID: <174092143353.3272913.3498123853092206909.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250116125726.2549489-1-h-salunke@ti.com>
References: <20250116125726.2549489-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hrushikesh Salunke,

On Thu, 16 Jan 2025 18:27:26 +0530, Hrushikesh Salunke wrote:
> J722S SOC has two usb controllers USB0 and USB1. USB0 is brought out on
> the EVM as a stacked USB connector which has one Type-A and one Type-C
> port. These Type-A and Type-C ports are connected to MUX so only
> one of them can be enabled at a time.
> 
> Commit under Fixes, tries to enable the USB0 instance of USB to
> interface with the Type-C port via the USB hub, by configuring the
> USB2.0_MUX_SEL to GPIO_ACTIVE_HIGH. But it is observed on J722S-EVM
> that Type-A port is enabled instead of Type-C port.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j722s-evm: Fix USB2.0_MUX_SEL to select Type-C
      commit: bc8d9e6b5821c40ab5dd3a81e096cb114939de50

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


