Return-Path: <linux-kernel+bounces-276941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867FF949A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852ED1C21714
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930414C5A1;
	Tue,  6 Aug 2024 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JdiRnpKw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22ED374C4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980025; cv=none; b=vAEkzGnZT9gt0heitqB1TuHUYG6BQ5ucTtczwXAkwCePjuoTladwz2QIbfvnldjgnpp1wfwXoR7fhSucDwcUb4Br2Q+wzDhu6ZARHhXzP7RW7hDvrPACa5Ts3JE6t4xeozchB+805JYCCCaq0D52aTaEwBiWaE4whVXvl0wMcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980025; c=relaxed/simple;
	bh=4aAUCfUArXtfbZ21wUlTfDc2cy+5/mBeLUqkDByFS4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vB7+arx2KeepZUa4arwsy4mIpw9He5Vi1Fcbjy0mQHGG83j16fC+18tMXsuY+RQ7HBMgEcxhTJjRPx9Kr8VTqOcYJv4VRPtypbi8BHHcXsVQLtTaPheRyQiSWc482KEWzCPrClfZaxUYKcyxCqyhchvY7A//2rDAHdcrgNQQPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JdiRnpKw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476LXa6m122107;
	Tue, 6 Aug 2024 16:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722980016;
	bh=hg9eR4/XMhP+PbigmiNKVLPUs7NXOerX1QaoHdvYn7g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JdiRnpKwgfFLsbHEFhYwPRCeKhppYDx2rV4oP3VZpFZJ1Y4SMuEHhw8EiPjCuDJNl
	 KlyPv4ZpZ8IbzEz9+CGVitfohy78c5vMMVmewiUqryqDttMvqpW09zF5t8MeCUiPXA
	 xzmZvW135DI4nsWECkduLy3wiE9lmLKDWI0w8UBc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476LXaCD018516
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 16:33:36 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 16:33:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 16:33:36 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476LXacW084337;
	Tue, 6 Aug 2024 16:33:36 -0500
From: Nishanth Menon <nm@ti.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
        "Rob Herring (Arm)"
	<robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: knav: Drop unnecessary check for property presence
Date: Tue, 6 Aug 2024 16:33:33 -0500
Message-ID: <172297993279.487934.13417516887545247613.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731201407.1838385-2-robh@kernel.org>
References: <20240731201407.1838385-2-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Rob Herring (Arm),

On Wed, 31 Jul 2024 14:13:57 -0600, Rob Herring (Arm) wrote:
> of_property_read_u32() returns -EINVAL if a property is not present, so
> the preceeding check for presence with of_get_property() can be

I fixed up the typo s/preceeding/preceding locally

> dropped.
> 
> This is part of a larger effort to remove callers of of_get_property()
> and similar functions. of_get_property() leaks the DT struct property
> and data pointers which is a problem for dynamically allocated nodes
> which may be freed.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: knav: Drop unnecessary check for property presence
      commit: 8737e167dc55cc00c5818b408f47ba03b6ddb25b

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


