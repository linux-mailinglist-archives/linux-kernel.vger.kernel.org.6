Return-Path: <linux-kernel+bounces-233142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A816B91B2C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F601F21B18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F538199E93;
	Thu, 27 Jun 2024 23:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dZLHf3Nd"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3690413B58F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531139; cv=none; b=EZ83PHGGZQXsH0qOavfRtHoWb1zQ0d3ajqRQdDGLl653K4MEQ3iFCszsvUAP5DEnos2t0wb0BYxisWVP90f5AotC70wVrwQcCW2heGDPE8lfM3w+2gtFKT+7eh7ikHsdAoQAZ0u8jVVhFFn2K82kBnkNquzqPf4o0UTuH/GmCjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531139; c=relaxed/simple;
	bh=ldkHZ6ChnFKceUzn99yfKBBafsgXiRRykIWe3fdaBZQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGUti3nMIfq0Ggu2KWLez/gjvuVdSpRrYnaCmgj/TFV9U5JQLj5F6Jm9LTT1Q+7H7zhhwF6yYjpqI2Kb60jBvKbuNYtZ8dKdqWbAK5L0OhPc2eKIAksLvTuNZiMLeZhCXLkGOh43OUgkAJCgmfqstC+h2aBzY2pe6VtUPHx8nP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dZLHf3Nd; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RNWBAA129492;
	Thu, 27 Jun 2024 18:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719531131;
	bh=HdnuzqQ9aQ6x17DxpUNOrFiA9c/0Lls6I14xLvBxONQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dZLHf3NdhIcXxvwV6THLBx8/FZvf59TWN5ZZnG3hkexLkPjlzeE2Hk3uQnjO7np6G
	 YZrZWtWppfsPFErFoPywEgKPqnj3v+P2WmHOltMPNXBHLb6C1reXAnbYPJS+nUAjPm
	 eHerecaHuV8jK732LAhGgEgxudbEA0rahGKJ7ymY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RNWB4g054662
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 18:32:11 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 18:32:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 18:32:11 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RNWB4A064293;
	Thu, 27 Jun 2024 18:32:11 -0500
From: Nishanth Menon <nm@ti.com>
To: <ssantosh@kernel.org>, Neha Malcom Francis <n-francis@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add J721E SR2.0
Date: Thu, 27 Jun 2024 18:32:06 -0500
Message-ID: <171953110789.1077768.5161640689319910021.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624065205.718449-1-n-francis@ti.com>
References: <20240624065205.718449-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Neha Malcom Francis,

On Mon, 24 Jun 2024 12:22:05 +0530, Neha Malcom Francis wrote:
> Add support to detect J721E SR2.0
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: k3-socinfo: Add J721E SR2.0
      commit: e44097c6d535163f28c6106605452a2fdb1d8cba

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


