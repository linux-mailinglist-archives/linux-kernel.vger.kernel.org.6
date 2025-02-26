Return-Path: <linux-kernel+bounces-534705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A225EA46A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C223A6C56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FF023372B;
	Wed, 26 Feb 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oligV4bn"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FA225768
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595776; cv=none; b=F/ltzw8sHGpFI1lWi4T/JALVORchnNA6BHg4DTBfSYQIlliYPYFJhgsR0Tv6dzbpwvD+MYXMCWTmVQdkTd3NjWjT/Kv3KMzxpCbU0BeWCqWtWs40tdik1iqqWWs9uXSthGuADe8frUyqSfi8cinvUQxSfArj49ICPzr6g5VHsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595776; c=relaxed/simple;
	bh=8xdZw9GHrP/m1pM6/bpTxfPuTw5lkK+7dlJD9pX6kFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDY8ITKlZsy1VEvTS5e1CjowgcHZT38uipKRHhseWrHGnRN3LgM9nGlAoI8d/8jbkqRBSQXo6snmddv9XmD+RN/LRmiWGZDwORtY6cU7+yRwREBBlxUauyFHNLZuZo8Wz4I1pe4o690S6Luukh0x8xqMVHjSkMAA8znQyHou1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oligV4bn; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QInHoh2145653
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 12:49:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740595758;
	bh=eegVb8hV5ADxrMFsqlhDaUuB2PFLABHCzNpeRnUf3FQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=oligV4bn87+Ij3VgJo1rAnTptMBm0yVQZ9hH3HOvM7yrRURnhakEq0ORLWt3k23eE
	 CbmXMhwgolZBBzyU6NC5A1LlryxUlMgLWAVXIBbWZHr2IOxrF/gIKo+zsNQ9wNfrNF
	 bi8CX6vBjTnQEH1a+Z0x35BomiuokT2/A+38oMYg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QInHwU032091
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 12:49:17 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 12:49:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 12:49:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QInHZR126373;
	Wed, 26 Feb 2025 12:49:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        <d-gole@ti.com>, <lorforlinux@beagleboard.org>,
        <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
        Ayush Singh <ayush@beagleboard.org>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] arm64: defconfig: Enable gb_beagleplay
Date: Wed, 26 Feb 2025 12:49:15 -0600
Message-ID: <174059567626.2601256.10455663850759431952.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250131-defconfig-beagleplay-v3-1-f556b851ff96@beagleboard.org>
References: <20250131-defconfig-beagleplay-v3-1-f556b851ff96@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Ayush Singh,

On Fri, 31 Jan 2025 15:41:33 +0530, Ayush Singh wrote:
> Enable greybus driver used by TI K3 AM625 BeaglePlay.
> 
> The driver communicates with TI CC1352P7 co-processor which acts as
> Greybus SVC. Additionally, it also provides firmware upload API support
> for TI CC1352P7 over UART.
> 
> 
> [...]

I have applied the following to branch ti-k3-config-next on [1].
Thank you!

[1/1] arm64: defconfig: Enable gb_beagleplay
      commit: 8c96eb23f203da025f07d7ca5387e1a42382b50c

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


