Return-Path: <linux-kernel+bounces-238865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9692524C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 06:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C292886BE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 04:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F628DCB;
	Wed,  3 Jul 2024 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EUw0ICzB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462303BBEA;
	Wed,  3 Jul 2024 04:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719981001; cv=none; b=gC0IN/s0iJf7UKxpqaNmRXZJrb/lAyiCxrfnPTnPhzJZiWMYWqR8s3nZ/eUgc3OqkjyHNsU8/mjtBG6NlpJ/g19qytkVkb5eEwJ5eduPqXdaqzBKMZjgZ36I7WHYe0Dacq1Du3PKzMJ3kRnn3HisESJ8er6TjDLg6yegcwY/iCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719981001; c=relaxed/simple;
	bh=nq5+dXf0g3QpZEs/IZCIf2JcoMLabFmdSf05aBUD/nQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdXvsscUQGKEIJLwMOaVrUCo4bLxAT+TXlIExc8v4bzw9ogWh4zrM4AHAyJmUhVFNt1+NVg7xM3QTBG0/sN5nFPN4PQeoI7aw5X6xDjJcIdoFMcMbwxC3kIpKrI9NjoyhR5wO3JtEhoITY6c6mh3X7sIVKRV1HhnvKpt4nibvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EUw0ICzB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4634Tgnx021140;
	Tue, 2 Jul 2024 23:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719980982;
	bh=VKvK+7gAPjbzJmTzU/+4Aci4GXZX3q+V5uiHMgYeeoc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=EUw0ICzBPsvNPfFUll68j9wo1akhXtxeZkyZyOsANeJbiq6VuKuGdY8gEGWTwr2dg
	 +x5OYcODcQSolRZ6+Jp4hjKNdhSoGfx1nrIU25+ePXGx63VuO/bRo2/RTSA2YdNRLQ
	 ixK0VbNBhWma5cBCZWV6m8H1yQSeb31Hx8NVs0IU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4634TgRM026478
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jul 2024 23:29:42 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 23:29:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 23:29:42 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4634TcfB044102;
	Tue, 2 Jul 2024 23:29:39 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Nathan Morrisson <nmorrisson@phytec.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
Subject: Re: [PATCH] arm64: dts: ti: k3-am6xx-phycore-qspi-nor: Add overlay to enable QSPI NOR
Date: Wed, 3 Jul 2024 09:59:36 +0530
Message-ID: <171984950180.3152309.2996249751900445828.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240621233143.2077941-1-nmorrisson@phytec.com>
References: <20240621233143.2077941-1-nmorrisson@phytec.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nathan Morrisson,

On Fri, 21 Jun 2024 16:31:43 -0700, Nathan Morrisson wrote:
> Add an overlay to change from the default OSPI NOR to QSPI NOR
> for all am6xx-phycore-som boards.
> The EEPROM on am6xx-phycore-soms contains information about the
> configuration of the SOM. The standard configuration of the SOM
> has an ospi nor, but if qspi nor is populated, the EEPROM will
> indicate that change and we can use this overlay to cleanly change to
> qspi nor.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am6xx-phycore-qspi-nor: Add overlay to enable QSPI NOR
      commit: 45a792b5131a02cfa9771b8e1ad9df797b01263a

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


