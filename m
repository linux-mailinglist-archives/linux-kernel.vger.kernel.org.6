Return-Path: <linux-kernel+bounces-276129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038FB948EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353F31C22318
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6971C9ECC;
	Tue,  6 Aug 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KszOxV6u"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043591C4622;
	Tue,  6 Aug 2024 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946378; cv=none; b=aqg7DXews7n9q7+bOx482gdhTYno65P0cxwXmgVOfwMurXIKT320XCRVBoo8DOSTNpn3nSMxpVUFmsiMxOiuA+VrIOHcFKVYR/f2Hdlusccuahc2v4t7ZAaH8lG2tHVHnm5GOjPscU74LqLEsC4UX/42rAollYOd49wmQpn7l94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946378; c=relaxed/simple;
	bh=ij9sLePyaJY22skmN2sv317+IUd6trLmSCTEE9vl6wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnzPZNCUVJ58UppcIwqjVhXzj52+4WjZaM3T/b6ZW+sknjyoacF7xx49Ko4dyPGOvGvbEy3xffxbaGvi/uQsQUFY3+YfBr8E57TROSW8Y7GcFqUo13P9TMR3W3Rl34Q2ZIjUJTbvXyPWe36ZbV2qALMqZufEqgZTmmWWXHQ48Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KszOxV6u; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476CCct7063931;
	Tue, 6 Aug 2024 07:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722946358;
	bh=enREF7ItjJiUxrF5pFpnS1rZGxyVdchoSvuFJO/m2yQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KszOxV6unmRdGvZDqWv+dS2JW3Fswk6CrdiX3tC/P8dpzUa9GIAaLXLNXeBt+qxFN
	 OQcFcPPmCGCp0CjF68sBxVBONWTux0uODR1WVcGSktj5Gk7PKklwpuUEJyGUWWBnSA
	 D1FDdQcOLKBsynR5rIKQywvW2+tl0Y8QU5QuRkVs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476CCcaT023414
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 07:12:38 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 07:12:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 07:12:38 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476CCcnM082165;
	Tue, 6 Aug 2024 07:12:38 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Jared McArthur
	<j-mcarthur@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: k3-am62p/j722s: Fix gpio-ranges
Date: Tue, 6 Aug 2024 07:12:34 -0500
Message-ID: <172294634855.366372.6539527201402606616.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801210414.715306-1-j-mcarthur@ti.com>
References: <20240801210414.715306-1-j-mcarthur@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jared McArthur,

On Thu, 01 Aug 2024 16:04:11 -0500, Jared McArthur wrote:
> Fixes issues within the am62p and j722s gpio-ranges. Adds the missing
> holes within the ranges as well as the the missing gpio-ranges
> property within the mcu_gpio0 node of the am62p.
> 
> v2 changes: Removes the duplicate ti,ngpio property from the mcu_gpio0
> node of the k3-am62p-j722s-common-mcu.dtsi.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62p: Add gpio-ranges for mcu_gpio0
      commit: 4e436f6fb95e507131df78c0d98052237db60ecc
[2/3] arm64: dts: ti: k3-am62p: Fix gpio-range for main_pmx0
      commit: 98897a300859dca62f834a5d1f60267032a9fe54
[3/3] arm64: dts: ti: k3-j722s: Fix gpio-range for main_pmx0
      commit: 04c90681144c40619524367c69e40736a6fa690c

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


