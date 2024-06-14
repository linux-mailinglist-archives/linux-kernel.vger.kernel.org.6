Return-Path: <linux-kernel+bounces-214337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E15069082F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C94C1F22813
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9C146A97;
	Fri, 14 Jun 2024 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uIyWPRf6"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C478145B0F;
	Fri, 14 Jun 2024 04:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718339408; cv=none; b=ltE02MFr7846Uv55CqFZaa8IxSV3dKfgd9oKJUaLNN4d9s42wAfd3q2YgsUfzX/mA3K97B2a4iwsVrcZoplRal08CYoDN5N/OZaHdWhX0QzUmLqHSN3+gT4ATrJFM5vT2VvFx+AJniFA72A8NZMGKgPGBSGiwi0W6zALfbASO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718339408; c=relaxed/simple;
	bh=0UjDZzGCwpS0vEyslgxoX8dO39jPgh2WtXXu/UWyOvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9Wm8aPWXKS4eklS9DGRSqrJKioCuW7tlDnPy4w4eUCSrWXX9hwTU1BvInJ8wrYsb2jj5u7B+malMWQ4toSNUm8/pPZjaqt4yut/gOCOGUCdd3OqSIiujnPoERo3bflvEPWUGNRQPgczDHbXSv4d1IdbgVUXGy4ljdNKDMLDL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uIyWPRf6; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45E4TuFC071544;
	Thu, 13 Jun 2024 23:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718339396;
	bh=DxmtcHXwF27jHg8lT0TkaoTdHdPyc/MSkbPHQtr5PhM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uIyWPRf6BMHsY+YU+ibs9iXl1/u1EkydbBXWyoJRLvLZlD7v4ajb2zGO3fDxWOD6R
	 uYCKOEJX/MoB5pQCHvG6MiY5Dz5jJ4zmUuEimhiWLJblPqbPhG+4lH+u1JhDv7BDmq
	 QCyEAD9Uy9F9oJd6ESyoHqRE1qPambC+ccODLmIw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45E4Tug7092429
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 23:29:56 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 23:29:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 23:29:56 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45E4TqWY013799;
	Thu, 13 Jun 2024 23:29:53 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>
Subject: Re: [PATCH v4] arm64: dts: ti: k3-am62p: use eFuse MAC Address for CPSW3G Port 1
Date: Fri, 14 Jun 2024 09:59:50 +0530
Message-ID: <171826022276.240984.17076720942255752570.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240604104425.3770037-1-s-vadapalli@ti.com>
References: <20240604104425.3770037-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Siddharth Vadapalli,

On Tue, 04 Jun 2024 16:14:25 +0530, Siddharth Vadapalli wrote:
> Add the "ethernet-mac-syscon" node within "wkup_conf" node corresponding to
> the CTRLMMR_MAC_IDx registers within the CTRL_MMR space. Assign the
> compatible "ti,am62p-cpsw-mac-efuse" to enable "syscon_regmap" operations
> on these registers. The MAC Address programmed in the eFuse is accessible
> through the CTRLMMR_MAC_IDx registers. The "ti,syscon-efuse" device-tree
> property points to the CTRLMMR_MAC_IDx registers, allowing the CPSW driver
> to fetch the MAC Address and assign it to the network interface associated
> with CPSW3G MAC Port 1.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62p: use eFuse MAC Address for CPSW3G Port 1
      commit: 2116f8b73f69a02e42daa89ca3561f367a390e30

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


