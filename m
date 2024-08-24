Return-Path: <linux-kernel+bounces-300184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15F95DFEC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4CC1C2104F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B4811EB;
	Sat, 24 Aug 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xXgCthzU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9507DA6A;
	Sat, 24 Aug 2024 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529300; cv=none; b=FWmS1YkTOe8EFMXW0XYOU7vKpirDljZDGYESAb8OfVLHPhwNAzK/x1IVVSBIX/z52nHCq06J9ilml3HIlD1efKGQmqXbkOxDmyFXvj7AN65e44EwLliXg8lEWWJ+3zQcIUsmV3lue/MEVDKQo/4KGaLKdEJogRDwVJGlbu+AjGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529300; c=relaxed/simple;
	bh=4TSVbgyvS4QJGyIWLVRtrqcZCMtT1+Kxe07aerzN7gA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3QVM7z/aSw2RXeN1qLyhMEHFPQNW4JCN1PScjh4CCJ2QMoDjGkEbjNncYc6syZou/bjUI9HMcA1cLZ7ZbsDjLVASqWsO8eJEybMln9WHX+Vre8lOJ2BbnLrfHqYgivnpu1PqyGWJtHbg3QGr5ogt4WSrfwci1hlo9qSdncH7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xXgCthzU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJsox8027369;
	Sat, 24 Aug 2024 14:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529290;
	bh=8EEwpvgoV+JIZJzECvQlx2aUXbJ764xGXQPW+tpnTcc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=xXgCthzUS75kgUCKM68/RfLYLx1XQJHxVbKXXafwxWG9tH4cS/kTHz0iL2iuvQH8h
	 dcIVyxqhn/kW3/dRmtiunb83A2wLxpsyruS7w6YzQcfAzF59U39Q0CveR5ntp2wX0+
	 cJiDjvWbeyeUP7J9lLxFdSeBemyw+IMnJDu3F57g=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJsodP104158
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:54:50 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:54:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:54:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJsngo008278;
	Sat, 24 Aug 2024 14:54:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jan
 Kiszka <jan.kiszka@siemens.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bao Cheng Su
	<baocheng.su@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>
Subject: Re: (subset) [PATCH v4 0/3] arm64: dts: k3: Resolve remaining dtbs_check warnings
Date: Sat, 24 Aug 2024 14:54:48 -0500
Message-ID: <172452924926.505816.7580905718644351705.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723653439.git.jan.kiszka@siemens.com>
References: <cover.1723653439.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Jan Kiszka,

On Wed, 14 Aug 2024 18:37:16 +0200, Jan Kiszka wrote:
> Changes in v4:
>  - drop no longer applicable mux-controller
>  - model dss-oldi-io-ctrl@41e0 and clock-controller@4140 as regular property
> 
> Changes in v3:
>  - convert mux-controller from patternProperties to regular one
>  - dropped k3-j72xx-mcu-wakeup patch after simple-bus conversion
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
I have picked Andrew's fixups, so just 1 patch in this series
is relevant. Let me know if you disagree. Thank you!

[1/3] arm64: dts: ti: k3-am642-evm: Silence schema warning
      commit: 182a862560097dec7adf774af58076984cd6c1ed

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


