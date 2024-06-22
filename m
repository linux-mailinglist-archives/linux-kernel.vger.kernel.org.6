Return-Path: <linux-kernel+bounces-225564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE08C91324D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 08:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8796284135
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 06:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40D14B07D;
	Sat, 22 Jun 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yYphDpyM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7C1433A4;
	Sat, 22 Jun 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719037090; cv=none; b=uz8iKXFQYbIR+KL/SsZHHBIf5wvel3I4AR+DkOmS89QNQiicfLeS8xUfTAxe+h1V3U6V4TM4+MVZs6eqHQu5eZ0by8vMFr3gj1xgpeSkIQVIywrZkWOE3NOa4lxqBizco/INFUJ3rlW2O6s509nb5tDLDd7atY1AmylkpA1Szjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719037090; c=relaxed/simple;
	bh=tHiFydCYBgOcvHTV0ti5D0aX1AGYBtM8vFL0PBIZups=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8m7VOG7FBFZqnfHblJH1ZQZx2cUi1e59DJQ+hAMloqp3r1al3+8OVG3wZ3U6IctaU/OKoNSxBfY/uyfQll87Z+l6JgPkHHqtIC8gM8TKU6jdRNFHBBpjQe+VTgg3AqsOYKk6EFw69Z/IbPCBlkHew4QYaTHFjDmXTdUqCKTwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yYphDpyM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45M6HoFs093442;
	Sat, 22 Jun 2024 01:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719037070;
	bh=qUzUPLdrT8LFfrcP6qmCVJcDz2Dz21GTWgwCpXvJCYY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=yYphDpyMDOc3+pG8a36g8CjeH/aybg05vBRwotYi+Ul7fnT/jTTjO7vfdew7gEpzk
	 ttgr04tmLj7Qj3uJDMGYFflIHjEy+ms9PNBvsD+BqTPDATbNGcd2+Q/ibvP8crhRO6
	 kdELHckXWHSLqUNlC5Vp+cAnX/MN03ae61EwBqQk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45M6HowU000773
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 01:17:50 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 01:17:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 01:17:49 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45M6HkxF002316;
	Sat, 22 Jun 2024 01:17:46 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Add node for EHRPWMs
Date: Sat, 22 Jun 2024 11:47:43 +0530
Message-ID: <171898028150.2272421.3470042778112808935.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240603112938.2188510-1-u-kumar1@ti.com>
References: <20240603112938.2188510-1-u-kumar1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit Kumar,

On Mon, 03 Jun 2024 16:59:38 +0530, Udit Kumar wrote:
> Add dts nodes for 6 EHRPWM instances on SoC.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4-main: Add node for EHRPWMs
      commit: f53f477bfcb8aa7490b3bd3030e3bef1b95dbdce

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


