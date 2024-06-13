Return-Path: <linux-kernel+bounces-212739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF27906584
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FD7B247A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E4D13BC39;
	Thu, 13 Jun 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jSA6HefQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588561674;
	Thu, 13 Jun 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264755; cv=none; b=ArVi531kMdJu6/mLFXNoHo2YjQx8SxGLOv9lSzELpQD0FB7VZqrJUpIuMVHNjmyifYY0bYVrOlp/YKEJICZXji8HOXK/WKmtAhHjf+DPX9ue+nd/AN06UXKtttQw7Zw0IquwFGiwPp43dl7wXbfY8u41isKkTHT2uF6ZLIZwKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264755; c=relaxed/simple;
	bh=b0nwDmk85Th+Ea9Hzl6X6r7Ux7VNBJoTY2env1nbsvs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s03IzYo9pVYfkOLlcTxe0l7jYZxXZV/P9+dV+3vGJ4d5SHXpWYiRUivfvfLGbCgfhZz7o10lUrXCftx5Xv5M1SGiMSTXMhDid5DUk6hmTD5BfHXOhLo2LoB7FG5eZkmB7C4F3wOloqqgkyH8G0caX5H3VvgLuVbBaEEgHOW6si4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jSA6HefQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D7jhNG087821;
	Thu, 13 Jun 2024 02:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718264743;
	bh=HcCz8yqlqo54hv8N+FW7nqgKgZ+aOt5M+8+4ovoUPuY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jSA6HefQyTEiY9V30j6DS1KzUK1tiB3zIR4wVgRpD7+Cb1E2bYxHpvn4WcHtYBLrM
	 mYiGt37wmhT2+N1yekvJv2nSuVXOzeWxgxk+tu8YFfRRmqeT8YuKH49q2PIcJluCmu
	 TVXfKsQOLh1J0cGZyUcBFD9mpz0QjyGdwOierIRI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D7jht8013059
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 02:45:43 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 02:45:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 02:45:43 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D7jdHI111881;
	Thu, 13 Jun 2024 02:45:40 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Josua Mayer <josua@solid-run.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: correct rs485 rts polarity
Date: Thu, 13 Jun 2024 13:15:36 +0530
Message-ID: <171826022271.240984.15893653753162141926.b4-ty@ti.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240504-ti-rs485-rts-v1-1-e88ef1c96f34@solid-run.com>
References: <20240504-ti-rs485-rts-v1-1-e88ef1c96f34@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Josua Mayer,

On Sat, 04 May 2024 13:35:54 +0200, Josua Mayer wrote:
> The RS485 transceiver RE (Receiver enable) and DE (Driver enable) are
> shorted and connected to both RTS/CTS of the SoC UART.
> RE is active-low, DE is active-high.
> 
> Remove the "rs485-rts-active-low" flag to match RTS polarity with DE,
> and fix communication in both transmit and receive directions.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am642-hummingboard-t: correct rs485 rts polarity
      commit: 9dcc0e1065f3c40d0b2ad79a858bb4ebaba33167

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


