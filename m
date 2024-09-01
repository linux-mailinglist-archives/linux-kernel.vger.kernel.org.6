Return-Path: <linux-kernel+bounces-310385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA20967C14
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 22:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F601C20FA1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 20:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866478C6C;
	Sun,  1 Sep 2024 20:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ViUGWnN1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F254662;
	Sun,  1 Sep 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725222236; cv=none; b=n1C7Yw6EjxAMgIJLb+fLzjgLdVktQJ9n9r+h92M6vNNHZ8r57RwgguDt9Rw3bFRu0BQP1fRzEtvAs/kbLb9a7exPsZ1DhBAqhcLQgudtpbfkuhFOQH3FUzu+V8RO8vkUBWTJLGG1hRJusmg/jDMRaqO7zsEGz9hu9rw6ZDJq804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725222236; c=relaxed/simple;
	bh=FZrbsELm0g3Ghd5/WGBvUUoerN2XTOCue0gWCNJnbTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRob4AYVLXA4CVp5TJZO0eGiGZ7TPYt9/h3pcCBUWjbOCooVk6AxD8tViCsw6Bp12yXi5gdhoScadyqNRHL6xUBx3/+/EuvLx5sJX/xMsI7QB+MzaNbT4tqjHQqoqlIGhk7BSAvTgjxU7xBdldJ3r1wq77XMi8cxjHt5/Q149jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ViUGWnN1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 481KNndD022580;
	Sun, 1 Sep 2024 15:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725222230;
	bh=imuvd7icXzSFnS2+tcRq6AcwVEyctqOadbzWaKilcfM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ViUGWnN1MHjssV3uDrKQT32chBa3KuARE9r8nstd2J5AI0ebnaEMc8cA+DFj5RYk0
	 +5Um5M/He7SUPWkIQvI+i67frLwXnI0mPSdlYzpXCbASgB92NOaEYjp/3vIuujQbHG
	 N2LjhSQTnwZ/4Lt80maNm0HsTBQjAVGyQ3NBUbMM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 481KNnjQ083515
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Sep 2024 15:23:49 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Sep 2024 15:23:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Sep 2024 15:23:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 481KNnk2020607;
	Sun, 1 Sep 2024 15:23:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Nishanth Menon
	<nm@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-evm-gesi-exp-board: Rename gpio-hog node name
Date: Sun, 1 Sep 2024 15:23:48 -0500
Message-ID: <172522221149.998271.7947834668550804221.b4-ty@ti.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830102822.3970269-1-nm@ti.com>
References: <20240830102822.3970269-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth Menon,

On Fri, 30 Aug 2024 05:28:22 -0500, Nishanth Menon wrote:
> Fix the gpio hog node name to p15-hog to match up with gpio-hog
> convention. This fixes dtbs_check warning:
> p15: $nodename:0: 'p15' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721s2-evm-gesi-exp-board: Rename gpio-hog node name
      commit: 5c19aeb8ae4fc539a73d7ff8b25decd745950c39

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


