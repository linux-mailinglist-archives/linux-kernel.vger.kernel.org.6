Return-Path: <linux-kernel+bounces-233145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1191B2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B839281AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684F1A2FC9;
	Thu, 27 Jun 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aKWngNjD"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9E1A2C35;
	Thu, 27 Jun 2024 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531210; cv=none; b=bQLmgtd0QGcvIZd1X10YUiOCMxzLL+mu2f1vFEVO7bRNHiFExmsGTmvQJP4VfhK3hK+sWGWIYb76k3X42MjfkUilxz3dm7qPSALAmb11P2uj81CcL7MkfL9sFZNb25nBGxU7wZ024NOWY8qmZicAwMm16eIEjUJqxDhgbeUJvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531210; c=relaxed/simple;
	bh=4P2o6uqwVae37onQEtZOYCycspbHgtu6qxE44Q/uNOs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFyg3Ox272VztesEVKQDb1aWKV8XUxmTA/+quoMQvd02n8IrLagJXYZVI0j/ZqAw9fs5d79mBL6m6IzsvPj1fwaDhso4W9REAZaKkWxNVozCuHYpDUxWOzIV5fHE1FW+46lF5f2E1rsP4j6TjVYVs3PlpY6ischfsFlkKDlxhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aKWngNjD; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RNXM31017948;
	Thu, 27 Jun 2024 18:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719531202;
	bh=I5Xhuq/3kjauIvcDzNivPyfZG98LGq9mjBi5SRToxcQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=aKWngNjDKG2q3iD61uDlIgK7xVkiLBTlQPqPG4+J6izkkworP+bAR1hGx968/5e4y
	 OT2f3MXf/CdsQl1axiCWMauQFB4hDu9/gF8zPMQ5l4JvDt6ZAK+7bqDjSUYRncCG+y
	 GOdUNJy6DQTPkdxX83seknXJn/zZMo5qneIZwl4U=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RNXMfe055270
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 18:33:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 18:33:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 18:33:22 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RNXM5Z097268;
	Thu, 27 Jun 2024 18:33:22 -0500
From: Nishanth Menon <nm@ti.com>
To: Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC: Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: Re: (subset) [PATCH v3 0/2] Add documentation for PA_STATS and MAINTAINERS entry for ti,pruss.yaml
Date: Thu, 27 Jun 2024 18:33:20 -0500
Message-ID: <171953113800.1077835.1688161229735338522.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625153319.795665-1-danishanwar@ti.com>
References: <20240625153319.795665-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi MD Danish Anwar,

On Tue, 25 Jun 2024 21:03:14 +0530, MD Danish Anwar wrote:
> This series adds documentation for PA_STATS in dt-bindings file ti,pruss.yaml.
> This bindings file doesn't have a MAINTAINERS entry. This series add the
> MAINTAINERS entry for this file as well.
> 
> Changes since v2:
> *) Added RB tag of Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> to
>    patch 2/2
> *) Added patch 1/2 to the series as the binding file is orphan.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/2] MAINTAINERS: Add entry for ti,pruss.yaml to TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
      commit: 13020adf6be9603ba71a9e269f130046dcea8cc8

I have left patch #2 to come with relevant driver changes as appropriate
rather than have to deal with a refactor of the binding at a later date.

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


