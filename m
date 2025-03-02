Return-Path: <linux-kernel+bounces-540527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8518FA4B1D6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B711F7A6ABA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34561E5B6F;
	Sun,  2 Mar 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b3OwSEX3"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2DE1E2614;
	Sun,  2 Mar 2025 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921536; cv=none; b=drhFGWY4BU6HnepClT/mUEwCy/p1Jj4Q/Wl1+qmx9k+METBrNC1O+K5EIc4osy+uVNkDw1vFW8qY7kd5xO9OUrHCXiay/5zQ0kXI5Czikpw2PrR69ZX6ZdfXUzDKIh3oImG58gg23fypHBDt7yr4VqhO1028wWlXoRVPCmxzwUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921536; c=relaxed/simple;
	bh=DiFUWSZzhvOwN541E/HFkmm5mxdTE8KxRpQCCduMAkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wx+TKVdttfh1E2S9/Y+I/vZKryl4UqpkkZn2ZvIJUr4yBPcBh4lwlvIcRHB2t5Bf7sPJMdhdQOhkRzEFA7C2JSBnMhXrGLpbm2s1s+9Vv8c1abXCG8C6sX+9Fvl12f7Vv/84YzLfxLJGKk4UI1EbzyrTNjWq08MEJBpVK0B68YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b3OwSEX3; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DInK42536673
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:18:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921529;
	bh=E/u9uJ4mVGOB8YWwELgSSWErhtDPl+MfL90KiFeE0p4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=b3OwSEX3M6Ynl7WUeBnuSROmAQhUUdoAuI+6WCzmWLNer7T0RPNTW7FQV5BrjjkWc
	 PuF1/3NS8o24R9fVUdyJ1j7slYoQ7OCJondMou++vT0BG8ple9cU5dcHT/cCy8OSkb
	 14fELeGBvNFWB7lRjoHqlc5GclyBv9wfIxjLkz34=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DInE4016957
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:18:49 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:18:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:18:48 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DIiui116537;
	Sun, 2 Mar 2025 07:18:45 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Kendall Willis <k-willis@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <msp@baylibre.com>,
        <khilman@baylibre.com>, <d-gole@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
Date: Sun, 2 Mar 2025 18:48:43 +0530
Message-ID: <174092143356.3272913.3416298233282580231.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214232212.1158505-1-k-willis@ti.com>
References: <20250214232212.1158505-1-k-willis@ti.com>
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

On Fri, 14 Feb 2025 17:22:12 -0600, Kendall Willis wrote:
> Adds alias for SoC RTC so that it gets assigned rtc0. PMIC node is
> assigned rtc1 so that PMIC RTC gets probed as rtc1. This makes it
> consistent for testing rtcwake with other AM62 devices where rtc0
> is SoC RTC.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a7-sk: Add alias for RTC
      commit: 34887f2dab33b30de2730005681c796114fba351

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


