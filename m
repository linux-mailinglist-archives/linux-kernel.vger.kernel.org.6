Return-Path: <linux-kernel+bounces-233133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AB091B2B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182EA283A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B652F1A2FAB;
	Thu, 27 Jun 2024 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c6mA5vrg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96383FBA5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530916; cv=none; b=EMwV8cJ83BdH4M94KkUJHhfw8Pjife+KHEz+D7j11XVZwdpAUc3pDGFEkBfn9PoCVnycbK6kHD5tiLY+8GFLQPTWmxoeSJETCuFpBt/b68KxvtU3WMT2l/hDZxo48C7jfcYT9TENPIue8NP/bghonh8MAb+/ka+nJW2YazxST2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530916; c=relaxed/simple;
	bh=ewOcn7yPN+2Yi03I2LV5cAEi/ctmLhHvgxx63HOfURM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AK76UjgPB26Ad6KFwv1xjLJRZ0485ZIo/oS5HhrhEkCW19Nbaq2/d5NsXqbHqL9iyQeS3WfqCLoLFEUI9e/R39XGWnppjXt2pO/sUtWRqb6Fph3ELTWJIf8N9xKpn3zj8n/++BN5egxCsKZBWZibuXsTHAbjW6xCYvjdi2gPdLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c6mA5vrg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RNSNhM064430;
	Thu, 27 Jun 2024 18:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719530903;
	bh=zyIfLjDtgnWn64vfAgQlRVEExq9e7iB229jkcThO9tE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c6mA5vrg41iLGqW4fxOVJlSFvKsAPiplSQ8u9696gBJPC/4Z0w3nNz9ud/fO/+P3v
	 ncZM1uGx/FZ6j2SuJztnINWCOaSMlrNvkpB5w+f+unZrWk3a5eSjkvyZpye+5RsKSq
	 2yqHO9sCYaNW8eg1ABOeW4k5qdAO2kTlD4mqIvuo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RNSNJt060064
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 18:28:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 18:28:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 18:28:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RNSNXq088931;
	Thu, 27 Jun 2024 18:28:23 -0500
From: Nishanth Menon <nm@ti.com>
To: <ssantosh@kernel.org>, Vasyl Gomonovych <gomonovych@gmail.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: Fix missing newlines in log statements
Date: Thu, 27 Jun 2024 18:28:22 -0500
Message-ID: <171953088527.1077261.13765320042029947916.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240517212930.2019962-1-gomonovych@gmail.com>
References: <20240517212930.2019962-1-gomonovych@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vasyl Gomonovych,

On Fri, 17 May 2024 14:29:10 -0700, Vasyl Gomonovych wrote:
> Add the missing newline characters to two pm33xx log statements
> to ensure proper log formatting.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: Fix missing newlines in log statements
      commit: d77b1befb18ac1fecfdde9110eb1400f0601ca93

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


