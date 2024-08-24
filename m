Return-Path: <linux-kernel+bounces-300180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6BE95DFE4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29066B210E0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0507DA9E;
	Sat, 24 Aug 2024 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jKmowXyT"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C656742;
	Sat, 24 Aug 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529144; cv=none; b=VTEGNGoHEMnJbXNcv07A1bjN3T/6v6Ow0cmL1Fulw3PmZLpEzt8upx5JwXivl7sfZzEU8I75GAZnez6nFiyywVUFG0y0wa+oxsHAZz5+iWU6zNJ8wAnWa8cUAcUW3jpRqyrNJE5Y3WQYRDcq4irb2Qe50JFdfVmnNlb3YHVKRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529144; c=relaxed/simple;
	bh=II6+M+1Z6xVwso7xyUzlyy26IMOzNBCDlaJj8IrQdP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoAUrge4/aYbmlIIwxYoL4Hqj6cunB9qZzdaWzHD/FVkRAVVUCn9pBbOawK+WZS1w8EOQ/UH5zaDVp8N260UFrPucxioE3Qife2GCUU4vkcte4qRvr+5GMHSpzySMblH2DK7jVWd7gJ3sZLHkU/HwV8RQKf9x2aVFAO4dj0ZSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jKmowXyT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJqDXD089040;
	Sat, 24 Aug 2024 14:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529133;
	bh=5AsaQQ9/E20/m8K0pGac7XbkUvwnHnpw6m9g4vxTsrc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jKmowXyT4237osiuE7dVhWV83+PnGsezCVMibYotfwXaIGdJ8AiDOUbyaGniPZgSg
	 3flE6Zn4LsoTwUpxTKH/h3MdjoMqdc8aAZ+K+7fxEelnfCqQYACGrNW5vYhKQ1Ad1r
	 TzXldFoISd36qE/0Wu2TQZPH6QnOz4/LWJessGeU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJqDxb024084
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:52:13 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:52:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:52:13 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJqDU0006728;
	Sat, 24 Aug 2024 14:52:13 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-arm-kernel@lists.infradead.org>,
        "A. Zini"
	<alessandro.zini@siemens.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62: enable cpu freq throttling on thermal alert
Date: Sat, 24 Aug 2024 14:52:11 -0500
Message-ID: <172452909600.505477.9105244268555185595.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814214328.14155-1-alessandro.zini@siemens.com>
References: <20240814214328.14155-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi A. Zini,

On Wed, 14 Aug 2024 23:43:28 +0200, A. Zini wrote:
> Enable throttling down the cpu frequency when an alert temperature
> threshold (lower than the critical threshold) is reached.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1] with minor
capitilization fixups.
Thank you!

[1/1] arm64: dts: ti: k3-am62: enable cpu freq throttling on thermal alert
      commit: 10e7bfd8114c207acd3858086f07061e447dd04f

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


