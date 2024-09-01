Return-Path: <linux-kernel+bounces-310387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18847967C1C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81A22819D4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3601304B0;
	Sun,  1 Sep 2024 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YXtcz0XM"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B841F957;
	Sun,  1 Sep 2024 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222430; cv=none; b=dG4Hbo/jRvwDRgvItRpLeZECnNRCKe6FpytVZeZa495ptVyGzvK1qgM2+/x36u/lvLNg6MAH9wI6bBZFwV79OeR2WTqCT89wLTmPQJ+11ILmyjHOYdH3BYJuJf0likFw8KyZ198/KWLUO2qdBHBum0i+rNXvShqU0KLsnhoYjW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222430; c=relaxed/simple;
	bh=57VwzEkcZHXXgccDh5EyNjJZFYN3+iigqWVJIHVqyTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I70yqk7+l7aOZGwWGGN9BdHHVTOQ4mU5y+Y6yZPKIiNQ2wZd4oPKO8q4c/VrVlBa80l5m5Uh/dVUp9vUDBsWQ+3pqT9nNSaFZe0N+H8iy8pLNTX3N1DyWfCMRRgZuN3doswhlQYUbcckgwGCZUkh3vU/Zib/Tkj6pJDk3Tc9dJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YXtcz0XM; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KQv9l014322;
	Sun, 1 Sep 2024 15:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222417;
	bh=gGJth2zii1F5FYDRQafLLKVKyZ9sTdN/soYfw5i3RC0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=YXtcz0XM/Pv+hOCZnIBufUUTHaM3aTMxAigjQlmT+Aj7gG1Ha40W1FFOjS4BXDnFk
	 DDwERcyOO/9wu41yTsoEa6Mcv+YkiG2BYqusFZzjpiJIC3XnU3bCErv1bnF0BPwulG
	 51YubpvfshZYHmNc6oQaSwyS/ZR7MFl628Jk9blE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KQvw9018274
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:26:57 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:26:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:26:56 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KQuI6023479;
	Sun, 1 Sep 2024 15:26:56 -0500
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Judith Mendez <jm@ti.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/6] Add and fix ESM nodes
Date: Sun, 1 Sep 2024 15:26:55 -0500
Message-ID: <172522225751.998566.15548857625813492043.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815204833.452132-1-jm@ti.com>
References: <20240815204833.452132-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Judith Mendez,

On Thu, 15 Aug 2024 15:48:27 -0500, Judith Mendez wrote:
> The following patch adds ESM nodes and fixes ESM source
> interrupts for Sitara K3 platforms. Currently watchdog cannot
> reset the CPU because of misconfiguration or missing ESM node
> in DT.
> 
> ESM node was added for am62ax and am65x. For am62px ESM source
> interrupts are fixed. Comments were also added for clarity on what
> source interrupts are routed to ESM based on device TRM.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-am62a: Add ESM nodes
      commit: 54ed32742a2b722a9eeeca601b5d9b715423381b
[2/6] arm64: dts: ti: k3-am62p: Fix ESM interrupt sources
      commit: c94da2159dfdcc44b78a8b1f3ebe4909d4efc9ec
[3/6] arm64: dts: ti: k3-am62p: Remove 'reserved' status for ESM
      commit: d4847546b6209876bbbbc00f5b8583387e80b731
[4/6] arm64: dts: ti: k3-am62: Add comments to ESM nodes
      commit: cc3a295ebb659a56534a2baea9040dc0dec1980d
[5/6] arm64: dts: ti: k3-am64: Add more ESM interrupt sources
      commit: 633bcfa502591103b5d5c4429d90bf10ac9bfd52
[6/6] arm64: dts: ti: k3-am65: Add ESM nodes
      commit: 50f368a0c166ebac9301b834aed729b2bb901e6a

NOTE: There were minor reodering fixups I did (e.g.: removes should
probably precede fixes which precede additions in a patch series
unless there is a specific reason not to; trm urls should be the
canonical urls; Follow the dt coding style in ordering properties) -
please cross check and let me know if you disagree and I can drop the
series from my branch.

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
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


