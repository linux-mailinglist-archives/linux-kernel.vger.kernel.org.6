Return-Path: <linux-kernel+bounces-305547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC0963049
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4801F22230
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671321AB525;
	Wed, 28 Aug 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yqu4BTCo"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E741AB516;
	Wed, 28 Aug 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870480; cv=none; b=rU/jFfZc0zxiiVqQwh4I/LLuPsoyj3LI3U89MxE4tDEeDbSnfZkUqm5NvnV5hU8Im6XHepFhvy/yMARb9H258aa9y1O37TPCAxox/qYYX+uOe/pVK7mCQZE+t0hjxjgPadYlrUfeikJ4ONxSCASLyxUa/QZzanmGDqLnlV4OkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870480; c=relaxed/simple;
	bh=tXMckQrvm0MyR2eX18HhDwWW+YFg0bAGbHF3Lcbw9RE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuWr+FiwbNCf5AejViwDuXjXgYBKQL+9d/x1KumlzfTwWQidsnhg+AemDpdF9VmazdLMzfhW4LCl+3wkzAM1JQ0CT1d9FMYHTqYxdgHkghAs9Uhwr/UYbh4lIt9pTmNK0wq8AnGFvxUUA465TYf8/YPf3lkVG0dyFrVIFDocrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yqu4BTCo; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SIf2aA089117;
	Wed, 28 Aug 2024 13:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724870462;
	bh=2cukJ9RvwW94P3cFpOls9Le+mixF9l3PqTQ3do4PFVM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Yqu4BTCo5mTRxlftV318g3/ek5gQNRHcbJf7kHkDAYbsVIayvqs7J6PKqlofROmpn
	 nagBNYMfkvGjl919pVW40LiOMahyt/B4nV+gpUsdF664EZjRZLP9enaunAPrIjyeJ6
	 6Iat9JdOkIcH9LHS01oT6y7zDg9x/Bd5dRMJlzRo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SIf1M0063555
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 13:41:01 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 13:41:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 13:41:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SIf1vS035407;
	Wed, 28 Aug 2024 13:41:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Logan Bristol
	<logan.bristol@utexas.edu>
CC: Nishanth Menon <nm@ti.com>, Josua Mayer <josua@solid-run.com>,
        Matt McKee
	<mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
        <linux@ew.tq-group.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default at SoC level
Date: Wed, 28 Aug 2024 13:41:00 -0500
Message-ID: <172487040667.3437873.12482413208486691957.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809135753.1186-1-logan.bristol@utexas.edu>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Logan Bristol,

On Fri, 09 Aug 2024 08:57:53 -0500, Logan Bristol wrote:
> External interfaces should be disabled at the SoC DTSI level, since
> the node is incomplete. Disable Ethernet switch and ports in SoC DTSI
> and enable them in the board DTS. If the board DTS includes a SoM DTSI
> that completes the node description, enable the Ethernet switch and ports
> in SoM DTSI.
> 
> Reflect this change in SoM DTSIs by removing ethernet port disable.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am64* Disable ethernet by default at SoC level
      commit: fdf47b3a379b180403bd29b59e4159deff748e0b

I did check the change on phycore, it looks fine, and this patch seems to
have waited long enough.

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


