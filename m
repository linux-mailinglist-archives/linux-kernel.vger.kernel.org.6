Return-Path: <linux-kernel+bounces-388124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293A9B5AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256F0283916
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB403198A0D;
	Wed, 30 Oct 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FKEByTDY"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1753F82899;
	Wed, 30 Oct 2024 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264075; cv=none; b=TyxasBAt3cl90LM+S1tS5Jq0EBGfMlZJ0AGQIJVtkENfch1RWoT+JrRZ6V00Q4Wimwby+YpjIP3s/pNfUQppWDIoGvuVZA+l7ycrPZNdwz6NmDe41HnXZu1IW6HygBsk8w28FBfgDWipBePBSUbd+9ukD4HiAp0wNclrnjQyl80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264075; c=relaxed/simple;
	bh=wlXwWBhkokDz6umu5vrGR/bq+03UBF7BVjl4Smmzuyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uU59mCmKZ3xw+9jW/rfAqM8KVtynDyl66MOJC3D0mLHelduY4sUWJdgKwPOQeZeE7veputfCmBAttzHNlouZxLlVX4V+wcoT6KltjXKZYBM92go6wXNDA+QK7LouMhkwcdOlCWH3StFVwYbl3Dsrd+MLjR74XuNhQXnqKmnvTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FKEByTDY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49U4sR8B060578;
	Tue, 29 Oct 2024 23:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730264067;
	bh=NF1ozKFoQkWPI0e7AdbdJLTmdxko1lP62hOtfBf8zzk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FKEByTDYstGw2/SsbzV4sJpKQUQv/Pm0bszpsMlTT1KB5pB2sxNdkLz3w5IEfabeU
	 6PlrpEiyIrRe+YPsDrbGSO9SLPgro/WwxutnpWiJkkgFVFfVwVF5tMarroFiSqD0zC
	 nQNt7oFIOONAy31jDtYWw7IaiZ14LfHKxpkG8HRM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49U4sQto118844
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 23:54:27 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 23:54:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 23:54:26 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49U4sMU1064291;
	Tue, 29 Oct 2024 23:54:23 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <vaishnav.a@ti.com>, <j-keerthy@ti.com>,
        Anurag Dutta
	<a-dutta@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: Re: (subset) [PATCH 0/4] MCSPI clock ID fixes for J7200/J721E/J721S2/J784S4
Date: Wed, 30 Oct 2024 10:24:17 +0530
Message-ID: <173021674663.3859929.6398782356598128564.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023104532.3438851-1-a-dutta@ti.com>
References: <20241023104532.3438851-1-a-dutta@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Anurag Dutta,

On Wed, 23 Oct 2024 16:15:28 +0530, Anurag Dutta wrote:
> This series fixes the clock IDs for MCSPI instances across:
> 1) Main and Wakeup domains in j7200
> 2) Wakeup domain in j721e
> 3) Main and wakeup domain in j721s2


> 4) Main domain in j784s4

J784s4 bits dont apply cleanly anymore. Please respin.

> 
> In j7200, kernel crashes were observed due to incorrect clock IDs.
> In j721e/j721s2/j784s4, there was only a mismatch of clock IDs w.r.t
> documentation, however it did not trigger a crash. The clock IDs can be
> verified from the below links.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/4] arm64: dts: ti: k3-j7200: Fix clock ids for MCSPI instances
      commit: 3a47e381670f130870caef6e1155ac531b17b032
[2/4] arm64: dts: ti: k3-j721e: Fix clock IDs for MCSPI instances
      commit: ab09a68f3be04b2f9d1fc7cfc0e2225025cb9421
[3/4] arm64: dts: ti: k3-j721s2: Fix clock IDs for MCSPI instances
      commit: 891874f015e98f67ab2fda76f2e859921e136621

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


