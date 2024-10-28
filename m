Return-Path: <linux-kernel+bounces-385235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6D9B3466
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D751F2167B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230771DE2C4;
	Mon, 28 Oct 2024 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RdLPTFg7"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DC15E5B8;
	Mon, 28 Oct 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127983; cv=none; b=tvD/xKVTtXEJugk+9Y5a6naKsHccbcFl6NN68dI/2kv1wnArfBwp9+3Qkrutilp5ld1qNCvVqJDq4S/uzOjYmkQ7QNCpYQ57FQdSJk4yqkW5X1B9AOY6WaMcvvSapqe/5c2oTNs0hcO/db3L/AsAyGO805Lyi0LJXehD/DhNeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127983; c=relaxed/simple;
	bh=r4uhjlaq1sr5t8pckPBV94jWiqtY1lwdhvRCQf/vffo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTBcZUAELKc0VUQ3WA/mP/EBKXOFAJ2zcFWlFwaHeH60um46pAACptmGok5wdn8evLD62mdbI/S9I/8uKUOpXP8nmhRUhVMq+NHjz5d74wbMl8uYyL2n1GYu3qWZvasfuYnBvSmnEBHxdN9r1j1jI9/p/EqkzVYFR6CKigg7BlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RdLPTFg7; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5wB1022225;
	Mon, 28 Oct 2024 10:05:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730127958;
	bh=9Uq5bz0/uLvuCGnqo7Ja68lnqAVIcBafEDmrDLYmls4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=RdLPTFg7+rmpq9di6vik8km+WtCAZnYeKKuyhi6BCl81mGdwOS8CgDLN+vRK40Olj
	 4EXCrB04KY+Vp31W5nkd5vGfW2SZlVGEU75VvrVE22AcQzZEtGd6VG3p0RJBYDbXh8
	 qGLdh27FtuU7umKSQEWt5QHRjoMF1r6GRVXtC2zI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49SF5wPf039975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Oct 2024 10:05:58 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Oct 2024 10:05:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Oct 2024 10:05:58 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49SF5tco129665;
	Mon, 28 Oct 2024 10:05:55 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 0/5] TI K3 M4F support on AM62 and AM64 SoCs
Date: Mon, 28 Oct 2024 20:35:20 +0530
Message-ID: <173012710988.558239.13240176298323302898.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241003170118.24932-1-afd@ti.com>
References: <20241003170118.24932-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew Davis,

On Thu, 03 Oct 2024 12:01:13 -0500, Andrew Davis wrote:
> M4F driver[0] and DT bindings[1] are in, so last step is adding the
> nodes to the base AM64/AM62 DTSI files, plus a couple of our
> SK boards. These can be used as a reference for other boards using
> AM64/AM62, or I can add these nodes for existing upstream boards,
> just let me know.
> 
> Thanks,
> Andrew
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am62: Add M4F remoteproc node
      commit: be4bac3bcb281b264bd35ae1ff7bbbb99e3e00fe
[2/5] arm64: dts: ti: k3-am625-sk: Add M4F remoteproc node
      commit: 23a6aba92e53883bccbbb27933aad6dd09992e6f
[3/5] arm64: dts: ti: k3-am64: Add M4F remoteproc node
      commit: ef1876ff76096b3cad6fdb8b797226e4914f5726
[4/5] arm64: dts: ti: k3-am642-sk: Add M4F remoteproc node
      commit: 6e36e6200360e1703071b38fa5e91f4894716658
[5/5] arm64: dts: ti: k3-am642-evm: Add M4F remoteproc node
      commit: 8e77fc1fbb291e193664df0ac5176ac9fbfb3ea8

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


