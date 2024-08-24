Return-Path: <linux-kernel+bounces-300181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4095DFE6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 21:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27130B21B0D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A7B7DA84;
	Sat, 24 Aug 2024 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uhZKwXOC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3F57DA78;
	Sat, 24 Aug 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724529164; cv=none; b=evFwdB/tpzhNepSn961LcAedz9tYig1Uw3igKgFEgNeR33V+thfzHIBU5KAXFSgdYRgfZUk0rGEnZ47tYN4zoRcfGObEpMAO6btz2+HZ9HEuch20qH1iPvsg1Cm+iQjBN5m7RzuSNobpdSeZpk6wJ0Zh1aBxyKHSxl/97ustlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724529164; c=relaxed/simple;
	bh=BlBjr6ONu2xjC3nyDxxB4vOLngkVKxItPTkb8BFCne4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbtdkEC6t9+uW6uq9gziON+RNzN6Ws0oyQP+4M18LYHcF6VzrDVDG4ZRqwpniRKOSTnd6ay7AJbv1OfnW4xoNi7ZPMQHgJ6Nest+lnzqnlY5vg30PJzvEY95udZu+K1ERXm6u+O/Dle7e+tm/u5yZYxAUIKE5tnF1+hLoWxuagk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uhZKwXOC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47OJqX0V089077;
	Sat, 24 Aug 2024 14:52:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724529153;
	bh=b19crDCdCJdBFmczbG3q3HsphfigXrMayjdxXbCgfw8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uhZKwXOCRsjEnfUnGvZR99Yp/5hSFyAbYJMFkOTJZr6ReVsGUIdYt7GkPd+9yJKBP
	 KaVfamiTv8KRhtCc62IxfxeRxfHQBdjqOg0W/0D7D/IuOdP4foY6Oj7808xFV8M08h
	 Ye62hkxkWV3Ci6tIqoNiF6d96r/5z89n4kUD77Os=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47OJqXe0024196
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 24 Aug 2024 14:52:33 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 24
 Aug 2024 14:52:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 24 Aug 2024 14:52:33 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47OJqX7K130516;
	Sat, 24 Aug 2024 14:52:33 -0500
From: Nishanth Menon <nm@ti.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>,
        Wadim
 Egorov <w.egorov@phytec.de>
CC: Nishanth Menon <nm@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: am642-phyboard-electra: Add PRU-ICSSG nodes
Date: Sat, 24 Aug 2024 14:52:31 -0500
Message-ID: <172452913739.505561.15074573597660272229.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815113212.3720403-1-w.egorov@phytec.de>
References: <20240815113212.3720403-1-w.egorov@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Wadim Egorov,

On Thu, 15 Aug 2024 13:32:11 +0200, Wadim Egorov wrote:
> The phyBOARD-Electra implements two Ethernet ports utilizing PRUs.
> Add configuration for both mac ports & PHYs.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: am642-phyboard-electra: Add PRU-ICSSG nodes
      commit: 87adfd1ab03aec17600de2d881ee4ca6914a8674

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


