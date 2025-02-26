Return-Path: <linux-kernel+bounces-534707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA30A46A22
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4E616C70E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0B9235341;
	Wed, 26 Feb 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mgT8sKAL"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC67023372B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595791; cv=none; b=kcQRP91h8bxurlrJ7zPlJOveTfxXeNGn2j7JyWTRfJ7g+AnXUWsUDK0nYQCF74+kGGUhjRdMY2jojH63a65wnqS50xHxKwutu8VhoYwWrsGPWN6cmC9aoxbD8KylkW4wonRkAwVgptXXwbgJTxjTigAix31powaysX37fMELkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595791; c=relaxed/simple;
	bh=zH0rhyLTD+9+FCudzZ3TJBEPUYeSRZveoLu3I9buYgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6rqBw8AK4jsE3GG/yLk0nSyOHMFHJXv4MqUNlHIiSxM5jq/ksrbNxfN/sBf0O7ZgRoLsE/OZXQnPqpLJAQhd2BXzHE5pJo4yQQPAhOUg5n9aNa6aYfnKSPO80c5HjYjp86xRyALHsn8oaDhvpPNQEONnEatluNtFEy0GHG0J+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mgT8sKAL; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QIniZ02145700
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Feb 2025 12:49:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740595784;
	bh=KKMuNxLA1fCsNlSUJGtUjABr3K5qCbQd6sWHC+XeUAs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mgT8sKALO3eo5hAd5mPcKvaD3pPe2BRES9DfXL/TFfkiOdTSBZ3u+GAkQSFjkxweE
	 NC1TN/eu33Ca0F6Lh/v2wWczgKCWTc62aqtH+leDktpf2BqkB4yYqoDxLFKZnwPcvd
	 LuUc9Lr/zTFYsZcxrpELG69ZmyQc8Z6V28awvOOQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QIni2f010452;
	Wed, 26 Feb 2025 12:49:44 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 12:49:44 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 12:49:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QIniA6082237;
	Wed, 26 Feb 2025 12:49:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: k3-socinfo: Do not use syscon helper to build regmap
Date: Wed, 26 Feb 2025 12:49:42 -0600
Message-ID: <174059577037.2603518.10904968408240864617.b4-ty@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250123181726.597144-1-afd@ti.com>
References: <20250123181726.597144-1-afd@ti.com>
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

On Thu, 23 Jan 2025 12:17:26 -0600, Andrew Davis wrote:
> The syscon helper device_node_to_regmap() is used to fetch a regmap
> registered to a device node. It also currently creates this regmap
> if the node did not already have a regmap associated with it. This
> should only be used on "syscon" nodes. This driver is not such a
> device and instead uses device_node_to_regmap() on its own node as
> a hacky way to create a regmap for itself.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: k3-socinfo: Do not use syscon helper to build regmap
      commit: a5caf03188e44388e8c618dcbe5fffad1a249385

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


