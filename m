Return-Path: <linux-kernel+bounces-305563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88586963081
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 276AEB24CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FF1AB503;
	Wed, 28 Aug 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HphzMfK4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C73328DB;
	Wed, 28 Aug 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724871331; cv=none; b=eHBIzq3ywCtJeQWnbZGY3TXfKm9s7kpOZfmUWBOH9ECfLCIv/W46HKgY7oWD4mrFNoVXSb86oJa3G1gvXmxxgRaLkn9yXUj6GrZXERg9lvFIRPA/gRZ+cNmBv/QNSYxd7ui6sOdVMKRkIWeBT9HshRhCUmzsyazUdF6MDyhBL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724871331; c=relaxed/simple;
	bh=K24XdBVS1ZC69+udi8532kBQaRJNZotpK6hDvJIMQWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYW9l9ZPD9jxRUbBMpKwpWp5PRbxVvTWQXCINUjPjh5ClRHSUdn3p5YcNUrktSz7gehyMxPrZATsz2udA61WBZOilk8TS4wCTb70IIEz3K9syhM+a3wdZfk5MTH/0OFJe8t0nKZKRzRIjZjqEq2+iKh2hekFfyNrSQh6JzHd4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HphzMfK4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SItKnH092157;
	Wed, 28 Aug 2024 13:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724871320;
	bh=Qy/V2k5Y2S/JbJqVjEzf8cnsqV6HJ6GGxYP13wMud9s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HphzMfK4+RJu3qVAQwIrP/6yaIntgVsVcOr7Nq97owLDhPl5nrJobNVT0eUDP79v2
	 wJ/dHKRc3nyaLB3eSZiRAL4WIh6Zacb4iOM7qII3tgY6GikY9tfZ76sAu2WeFpSDA/
	 nU4EQdvaLmBTnfVjWjEBjlgFI0EypiUEeGAB0ImY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SItKQ3060099
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 13:55:20 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 13:55:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 13:55:20 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SItKI1048548;
	Wed, 28 Aug 2024 13:55:20 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka
	<jan.kiszka@siemens.com>
CC: Nishanth Menon <nm@ti.com>, Bao Cheng Su <baocheng.su@siemens.com>,
        Hua
 Qian Li <huaqian.li@siemens.com>
Subject: Re: [PATCH v2 0/2] arm64: dts: iot2050: Fix R5 lock-step settings, add overlays
Date: Wed, 28 Aug 2024 13:55:18 -0500
Message-ID: <172487125711.3441200.11079556552266288312.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724830741.git.jan.kiszka@siemens.com>
References: <cover.1724830741.git.jan.kiszka@siemens.com>
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

On Wed, 28 Aug 2024 09:38:59 +0200, Jan Kiszka wrote:
> Changes in v2:
>  - build dtb with applied overlays
> 
> Trying to get our backlog closer to zero. See patches for details.
> 
> Jan
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: iot2050: Disable lock-step for all iot2050 boards
      commit: e0133f883cf115d9e97e704169a9fb6003caefb2
[2/2] arm64: dts: ti: iot2050: Add overlays for M.2 used by firmware
      commit: dba27d026fc841d28a0ed373f617cc84ec0e4504

From what I see, this seems fine, and inline with the good stuff, but if
folks feel it was a bit pre-mature to pick things up, I can drop it, but
prefer to let it cook in next for a short while if possible.

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


