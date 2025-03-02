Return-Path: <linux-kernel+bounces-540529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2208AA4B1DB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C99188B0D8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182F21E5B6D;
	Sun,  2 Mar 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fhfsseeQ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E441DF735;
	Sun,  2 Mar 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740921586; cv=none; b=AuR1yxVTlqf432t/UxoK+Dnm5SBP7Cw4KocFNbLwEZJcalVe88Bv84CAElROdoUWKjCTwAugDbZd50tjZEnqDyYZ5q3o8QEaSxQno3IJqcoqDiJGReKMsSPXdq8Biii9sS3jdfxAtHHMbLUHQFPDp9SBLuMgoxCFZ2TCFNkdTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740921586; c=relaxed/simple;
	bh=N93N8sbr9pYjQhBhkTre3vmbvaZaJScZk7m/IxhXYvw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uuBpCzb1raRWzFRoGvki7ZDMmzOw6T2LypuKsxd3aB8YILRcxxhoM+xIgeA9AQ2KwOtF39PiOXj7rdkeJR4iquqCx8g7cWsIxlLxtuwXhIgA46OYpzupamYBCBZelHyfIACrzG3akvcAWq/G+kLu1Qtyw05hRUDO2SmwAJ0v1Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fhfsseeQ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 522DJdTk2461655
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 07:19:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740921579;
	bh=c/wwbEqTWYhVHr/BOInsu6yf96NR5fVapiEtbZi2/Ww=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=fhfsseeQQzDzObkHWqS3PTuZ6mp5L6USofy+tlldwD8tTJXruLkoymjQ5qxy18qSH
	 ul7y5UdqoFn8TNYUP36PW3HntntflwdfSYG77XjHa5ywPPCNo4Ys30MmsblR97Ndi7
	 HKdx3LbldyR/7VYov0gt43c+ZIZk96e6/IHVzwVU=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 522DJdlA017472
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 07:19:39 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 07:19:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 07:19:39 -0600
Received: from uda0132425.dhcp.ti.com (dhcp-10-24-69-250.dhcp.ti.com [10.24.69.250])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 522DJZmc117215;
	Sun, 2 Mar 2025 07:19:36 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <s-vadapalli@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <c-vankar@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j784s4-evm-quad-port-eth-exp1: Remove duplicate hogs
Date: Sun, 2 Mar 2025 18:49:33 +0530
Message-ID: <174092143352.3272913.15934714323142045116.b4-ty@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250110105753.223049-1-j-choudhary@ti.com>
References: <20250110105753.223049-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Jayesh Choudhary,

On Fri, 10 Jan 2025 16:27:53 +0530, Jayesh Choudhary wrote:
> The j784s4-evm board dts now has the gpio hogs for MUX2 after integration
> of audio support. Remove duplicate gpio-hogs from the overlay dtso to
> prevent mux probe failures leading to can-phy3 deferred probe:
> 'gpio-mux mux-controller: probe with driver gpio-mux failed with error -16'
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-evm-quad-port-eth-exp1: Remove duplicate hogs
      commit: 8a3629a6a9e52b30c55910b26c9c0dbc376f9d29

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


