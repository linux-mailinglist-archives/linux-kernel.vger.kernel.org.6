Return-Path: <linux-kernel+bounces-300182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B6295DFE8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C393F1F21BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031380C02;
	Sat, 24 Aug 2024 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MK2UZuZS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1092433A4;
	Sat, 24 Aug 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529241; cv=none; b=qokIvdijT/9E2Dy0Rlak2VdQdpBm7ThDfElgBGJ/KKsunXwEP8W2yrCAHz0SVktegQm85uifgBrnjvAY/ybm9WUi0hAoiNeP6T6XhVUtSlSrSJx/r8lUTtSf2KFr1jwrCWSeL5kSVQA7hyNd0Unj6DGWPLg7VsumlQM1u7u9iVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529241; c=relaxed/simple;
	bh=zMhYN7CbJY+VDwVdu0lQvKSASAJ+w+sk0H5Zqr2tcfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1g4rqwQ7O4M+eCkbCNpEwgULxtxnOP2PMcOlpe/wulI58HgofCpoGXXUwkp/IjDXB3zMGPKGAQRmAmwwSRwEHkdotBpJ0YT8USz5VwDX+t9ilLFHugrmKeZnqqqffY5TQEXMT0lRvz6zcfSPjF47h6UQX5WjwIjC/7UrxcQWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MK2UZuZS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJroB1060281;
	Sat, 24 Aug 2024 14:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529230;
	bh=Cn3djYQJ7y9frUnmnF3un7UqFk5/z2fh+iMrYTgtRpQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MK2UZuZS6E9Hy48zy4mM/77Yy80hV7F6OrJQ1Icsl9rrm8U/6EEb3+0JXwFtwBAur
	 IryXfdLtbCLypjoLTxQE6kUEfVp/GEL6HBInCrAnBK1sX3ny1k6jQzPSTsqLfmLwnz
	 aM47QSd5uatH3wV6ovzgXUTVF3xLdZJm0vmyuySA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJroZ7043787
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:53:50 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:53:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:53:50 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJroPg000537;
	Sat, 24 Aug 2024 14:53:50 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add simple-mfd to compatible items
Date: Sat, 24 Aug 2024 14:53:48 -0500
Message-ID: <172452915710.505630.14478626634743313398.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240821162337.33774-1-afd@ti.com>
References: <20240821162337.33774-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Wed, 21 Aug 2024 11:23:36 -0500, Andrew Davis wrote:
> This node contains a child which is only probed if simple-mfd is in the
> compatible list. Add this here.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
NOTE: I edited your second patch to include a closes link (used the patch from
Jan as reference), Let me know if you disagree and I can drop the series (for
future reference: Reported-by is usually followed by Closes tag)
Thank you!

[1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add simple-mfd to compatible items
      commit: f92ed4e4c8454144158bda90614109373e210676
[2/2] arm64: dts: ti: k3-am65: Add simple-mfd compatible to SerDes control nodes
      commit: 73f7ec38556e51f32627fd18c28e56aac4da2646

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


