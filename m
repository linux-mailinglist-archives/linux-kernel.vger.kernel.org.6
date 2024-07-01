Return-Path: <linux-kernel+bounces-236605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA99591E4BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C6E1C21A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2016CD1E;
	Mon,  1 Jul 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lq1jIc6+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92703142624;
	Mon,  1 Jul 2024 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849717; cv=none; b=Src3Vg0h1Uk49m7LdXkp28+9rY+oJ8er5G/hNb/TvBL5cCgbYUQRoky9dYp/RTHArcxSq+PM3YgpeT6N/qz3MBhv3dt/7mL4SHa1vs/pUmTqnw8xwVUivJ2iyeZNFPPTPSsKLSRq4EjSOIMByTVDjjSiPw6wI4137LJgUHn8Njk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849717; c=relaxed/simple;
	bh=hOVgztX5aRZUelBLzXKsUa1jcr3sRcfH4cpgfhepbB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TufXD4W5gFn5Vum4jvv4bX0Y7XSE7xWIISkpMbAhA4HVcO31LAU3pFhvzEfhx6FJbQGZ3ycJiAuHojJrYHbGgSdPj4OMYNE8rwE8SyrGYVVjA6KtnbYRyQ6mKItHa9sv8JbAB5oJz9wr9n4lnlXuK9pu5k0cFMeN009uSZMcf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lq1jIc6+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461G1i5e099906;
	Mon, 1 Jul 2024 11:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719849704;
	bh=EPp252fPRm63KzgIuXGKRMLf5I8ys+FPMN5TgPmJFpY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Lq1jIc6+sKfDvZJMC/JGtw+OfcYutbejuFiybFcEbuw7XlkxfWF+wmfkXvw0w5XGm
	 zsyObdbpLnGfYmfAIdS3FYlOs2caFfB6yT1nlC+zFEhcENjXzYwnG2j73mmEVzuCAY
	 tvAvptvNVeeMeL7dmN9M3fdkrBzjUafewtRn7pbo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461G1iKT075898
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 11:01:44 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 11:01:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 11:01:44 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 461G1eQT061733;
	Mon, 1 Jul 2024 11:01:41 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am62a-main: Enable crypto accelerator
Date: Mon, 1 Jul 2024 21:31:39 +0530
Message-ID: <171984950176.3152309.8066747674925594460.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617-crytpo-am62a-v2-1-dc7a14f2635b@ti.com>
References: <20240617-crytpo-am62a-v2-1-dc7a14f2635b@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Kamlesh Gurudasani,

On Tue, 18 Jun 2024 18:11:13 +0530, Kamlesh Gurudasani wrote:
> Add the node for sa3ul crypto accelerator.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62a-main: Enable crypto accelerator
      commit: 11926848eb550ea3018ad9e14761785a6f7f25df

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


