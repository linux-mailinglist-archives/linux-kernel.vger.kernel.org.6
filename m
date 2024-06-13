Return-Path: <linux-kernel+bounces-212741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A539190658B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FD45B21EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806813C693;
	Thu, 13 Jun 2024 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d28EVzuP"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3A136649;
	Thu, 13 Jun 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264792; cv=none; b=nl+YNS689P2qgqwb99573PGGAu582ESEThusy84T8nlR6srvZIcE3NQB8P3HvyDWcrXMxzqsX7HE8RrqsleIyiCi3TSb+glxqb8j/+enwlhF/kUxiQlGFRvaeLFyaLzu4cy8+XaU6AgvMxD1JaSCFs8sy7eav59PKLqlAVucPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264792; c=relaxed/simple;
	bh=nodvEGHFJZ1jzf9QdxAXiw3OHJV9p0GFrZGIFaI1TTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHfWtgwKhjhft3DEPtkFanLMnlpPg8gXikcVM9+z0wthYMTajy3MtwxaV2q2sP8et5WWdvXzWnjd9uk252qefnDFQNkRu59flLVWfMB2BwCnnrt7L8iZNAgNxnPj9ro+E2rO2kcSL/qYEyt8mGg1K8HTAdDOUR60pyMkBMYvHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d28EVzuP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D7kNDO126932;
	Thu, 13 Jun 2024 02:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718264783;
	bh=4I5BcS8rHExDjBMTu+yXRs4EobhlascBLkePDsqFA1c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=d28EVzuPAjUBZNobDlJQwY2tr7VG2Ox4hjQ4cMrpYGfectPk/SUTmsBkU3GB3pKQG
	 2WElvJ1RQLZLjW4iuDNFCJhIdfC+ZiA1+NZc9OM2RuJhrd0DjYorC6ZXvBqfw1CI8h
	 NY8m0R76Jn7G4gEkSHwUhbZt/O3DPUfIClGsR0UI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D7kNpg058779
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 02:46:23 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 02:46:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 02:46:23 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D7kJ9P118658;
	Thu, 13 Jun 2024 02:46:19 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Vibhore Vardhan <vibhore@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <khilman@baylibre.com>,
        <msp@baylibre.com>, <d-gole@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a-wakeup: Enable RTC node
Date: Thu, 13 Jun 2024 13:16:14 +0530
Message-ID: <171826022273.240984.16583834641689878984.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240429184445.14876-1-vibhore@ti.com>
References: <20240429184445.14876-1-vibhore@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vibhore Vardhan,

On Mon, 29 Apr 2024 13:44:45 -0500, Vibhore Vardhan wrote:
> On-chip RTC is used as a wakeup source on am62a board designs. This
> patch removes the disabled status property to enable the RTC node.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a-wakeup: Enable RTC node
      commit: fadfb0e0cc3ee0251a1dba10f4603798b46bed8f

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


