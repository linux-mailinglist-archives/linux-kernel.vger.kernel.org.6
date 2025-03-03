Return-Path: <linux-kernel+bounces-540996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E7A4B747
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11BA1889CD8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 04:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B071E1C1A;
	Mon,  3 Mar 2025 04:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oBZN9xmu"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302491DE8B3;
	Mon,  3 Mar 2025 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740977365; cv=none; b=kTxAk6Vz/CV5Mf84+07uvz4EFAlrtHk0tyiaJVYTr+FE6azT0hr+BpvElwkncpW2Mx5xT3vvRHGlET/3OGfLTq3cgmcTN/7B6Lw5xz0WE91+pzrWNeZ0RBCwnGy7Qh+PfMJiBCblEJ9q10gBLmq6eCFn9JHTqWHPgYonvgFdtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740977365; c=relaxed/simple;
	bh=BZ2LtecqY895whqnKu2nk2Wm2ooNYORq0o/ZAbbZF+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jciVYpUvuXL5EEHvbjxSYeiXNw0HTOLVVqkD4B/bJ/stds82KFNREyxn8fVvRYGUxFFEFkkUZOFTMYXnIetTH9h1syNlG4dhjDNV1x48BfEyWOvOomW3TdMhFpHzruKtp7GwQcrsrWJ7ju3pveOXjg2/p8whe4zAqtn+suU3ZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oBZN9xmu; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5234nDee3208569
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 22:49:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740977353;
	bh=Hzsi9R5SdyeZEbtSlNgVuCa4Zbe40AjNavhwDq4fcj4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oBZN9xmusTyC23NSTUkrLStCt8moBIk/T5k+HZFE3mVi8b54Gmn/TJ3cZUUhWYi7v
	 bFSBKh2Z50IPypJe+DgAFKkm7JFw7BV8VqlE3baSMLiQ930B36to83KIB5KA+GXcR/
	 1SS1w1YPp69MA5sep5Btb0zIBClL4arYuZ8n8/o4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5234nDDk019246
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 22:49:13 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 22:49:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 22:49:13 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5234n8ao108410;
	Sun, 2 Mar 2025 22:49:09 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Kendall Willis <k-willis@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <d-gole@ti.com>, <tony@atomide.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-j722s-common-wakeup: Configure ti-sysc for wkup_uart0
Date: Mon, 3 Mar 2025 10:19:05 +0530
Message-ID: <174092143357.3272913.5649051492068672148.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212215248.746838-1-k-willis@ti.com>
References: <20250212215248.746838-1-k-willis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Kendall Willis,

On Wed, 12 Feb 2025 15:52:48 -0600, Kendall Willis wrote:
> Similar to the TI K3-AM62x Soc commit ce27f7f9e328c8582a169f97f1466976561f1
> ("arm64: dts: ti: k3-am62-wakeup: Configure ti-sysc for wkup_uart0")
> The devices in the wkup domain are capable of waking up the system from
> suspend. We can configure the wkup domain devices in a generic way using
> the ti-sysc interconnect target module driver like we have done with the
> earlier TI SoCs.
> 
> [...]

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p-j722s-common-wakeup: Configure ti-sysc for wkup_uart0
      commit: b0de0b2de409d99408c0f3a38af841ae3bcaa225

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


