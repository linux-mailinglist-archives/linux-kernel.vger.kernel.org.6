Return-Path: <linux-kernel+bounces-236604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F7291E4B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6893A1F2478A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FCE16727B;
	Mon,  1 Jul 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pfpXL7mR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2DEEB5;
	Mon,  1 Jul 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849702; cv=none; b=VfaeDuh+FTMZPZA+gruqL8R9qrqZvtcRym3qhnXsh8ebA4I9SWDuNhpGhVVyRdzCNwb+ZM7c9PLtuQqsPi6OtJuOiNuCGMdF91l5f2AFPlFzFo/QUvgEOunob/RPNXq68NvsIeqw05ZapfhylPUGCgE2ITTwPAppNl64LKCQdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849702; c=relaxed/simple;
	bh=YptetY8g5PbRgblxD/K9UqoVocA40UqH2KNgi4FJGP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1QtrzaDfKVKBEvikBgOiVK8w5NKpg726ListBmGjEOYbqwZpc9Q5r7ZJvRqDb5PUYbKNc7bFrCaYXNzC0psB8fllhff7eosZz/JO0xnSEZwhkOKKyM5zbpOcDrjzP6Aw5H/wi0Beb1tIHYB7qCL1B6VKlXxNCkC2P+eo8jAcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pfpXL7mR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461G1S6J011901;
	Mon, 1 Jul 2024 11:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719849688;
	bh=Cg7rUwwI//mmk6bNZn23Ww3ehLdzrtbZaEJR6k0akSY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=pfpXL7mRB0hD2cU7j00ELE7CqjtB+iX7rK+qumBwRoycMpj1N992fnNdDi1zRH/w7
	 RYKHXjYomNnGQMKXTPvxpMNdgfRdQQUGvZDPtQjbD9bV0vrerFlLErLqZU3w0zPO4g
	 H8+rspE0Df7ccUaQ3ihv6fAUUe/aRuvdgqEqL9PM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461G1SIi075759
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 11:01:28 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 11:01:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 11:01:28 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 461G1PSm043765;
	Mon, 1 Jul 2024 11:01:25 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62*-main: Remove unwanted properties from crypto
Date: Mon, 1 Jul 2024 21:31:22 +0530
Message-ID: <171984950176.3152309.10031093512487224951.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618-remove-ranges-v1-1-35d68147e9bf@ti.com>
References: <20240618-remove-ranges-v1-1-35d68147e9bf@ti.com>
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

On Wed, 19 Jun 2024 15:27:25 +0530, Kamlesh Gurudasani wrote:
> As there is no child node in crypto node, remove the properties
> that are not needed.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62*-main: Remove unwanted properties from crypto
      commit: b6861f152b4bf6f194b5e5162ee238f2c97e5aec

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


