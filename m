Return-Path: <linux-kernel+bounces-200679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8138FB348
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD91283DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57671146A94;
	Tue,  4 Jun 2024 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="nuYGQBRa"
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA8146591
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506938; cv=none; b=JgnPYFauWUnQ7o/YfMUdKJn+cVFcIHKruOiKM1JLXUAr1Mx1GuSjeGcs1YhqZGxam6LbFso10B88/j8azlnS3nlAlPfRZO5ArAFZal/wng7wbwtzwd0LANTx0jyXvYb8yF5BwckVuu0/M/q+xXfkNVObGIn+RvejQzf4xzYxPCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506938; c=relaxed/simple;
	bh=DButXpkKLCVpKLooxjGachqXWYUOoZ1VJfazz4Gocqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PZ2T9ekaJ2tEReCXIeo876xgQIleDKRgTuCbJmgqpcQLlOr2aXXD5whr+B2t/eBHd+4qyqo0RL+TJqzUfbzcl8rnnW0tO/smjBtueiGxxknDY7ovVdT1pAk3dSgRQY8X6/HfU8cBbGWHkGTGX4hA7tfUoj6bLffs7DKLggdk2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=nuYGQBRa; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240604131525ef92ae7a21cd43c559
        for <linux-kernel@vger.kernel.org>;
        Tue, 04 Jun 2024 15:15:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=G4cQmy7CbcUofO7XKPsbl0jSqmp8k3uPxgYXTGCvYM4=;
 b=nuYGQBRaVePixTrPNaIvgAFNdBmVzhgYSNombKiN+GoWprNPp+isfbsCOVQMk2L0KyHt3j
 hHR+m0LXFP/NctMLDAXSzDfNCDJDAT0A82dwKHDNXwN2gQJF49p5HzOZX1+V1SN+BhkJpgTX
 hVza+p4fH9HKcRItrwVwpoRcctf1c=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH net-next v2 0/3] Enable PTP timestamping/PPS for AM65x
 SR1.0 devices
Date: Tue, 04 Jun 2024 14:15:09 +0100
Message-Id: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF0TX2YC/1WMQQ6DIBAAv2L2XBoELeqp/2g8CG7rHgQDhNgY/
 l7CrcfJTOaCgJ4wwNRc4DFRIGcLiFsDZlvsBxmthUFw0fFejIzwYIPW3SKNHvljgFIeHt901ss
 LLEZm8YwwF7NRiM5/6z611f+dUss4U0JJw1U/ilU+A+GONtyN22HOOf8AZut60aIAAAA=
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717506924; l=2637;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=DButXpkKLCVpKLooxjGachqXWYUOoZ1VJfazz4Gocqk=;
 b=8/DOE0yNPzKrkUD8wKBATO1Fa0Ok+FuvybDpdld6vrNy0G/8Xv9uh1pFPa4UWS/eV4HcZLRgd
 3To6L4eRY9cAD+CTgvsehPCW2gch0D04ka9NTPbSa9iiKPMiz6m6OpG
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

This patch series enables support for PTP in AM65x SR1.0 devices.

This feature relies heavily on the Industrial Ethernet Peripheral
(IEP) hardware module, which implements a hardware counter through
which time is kept. This hardware block is the basis for exposing
a PTP hardware clock to userspace and for issuing timestamps for
incoming/outgoing packets, allowing for time synchronization.

The IEP also has compare registers that fire an interrupt when the
counter reaches the value stored in a compare register. This feature
allows us to support PPS events in the kernel.

The changes are separated into three patches:
 - PATCH 01/03: Register SR1.0 devices with the IEP infrastructure to
		expose a PHC clock to userspace, allowing time to be
		adjusted using standard PTP tools. The code for issuing/
		collecting packet timestamps is already present in the
		current state of the driver, so only this needs to be
		done.
 - PATCH 02/03: Add support for IEP compare event/interrupt handling
		to enable PPS events.
 - PATCH 03/03: Add the interrupts to the IOT2050 device tree.

Currently every compare event generates two interrupts, the first
corresponding to the actual event and the second being a spurious
but otherwise harmless interrupt. The root cause of this has been
identified and has been solved in the platform's SDK. A forward port
of the SDK's patches also fixes the problem in upstream but is not
included here since it's upstreaming is out of the scope of this
series. If someone from TI would be willing to chime in and help
get the interrupt changes upstream that would be great!

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v2:
- Collect Reviewed-by tags
- PATCH 01/03: Limit line length to 80 characters
- PATCH 02/03: Proceed with limited functionality if getting IRQ fails,
	       limit line length to 80 characters
- Link to v1: https://lore.kernel.org/r/20240529-iep-v1-0-7273c07592d3@siemens.com

---
Diogo Ivo (3):
      net: ti: icssg-prueth: Enable PTP timestamping support for SR1.0 devices
      net: ti: icss-iep: Enable compare events
      arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0 devices

 .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    | 12 ++++
 drivers/net/ethernet/ti/icssg/icss_iep.c           | 74 ++++++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c   | 51 ++++++++++++++-
 3 files changed, 136 insertions(+), 1 deletion(-)
---
base-commit: 2f0e3f6a6824dfda2759225326d9c69203c06bc8
change-id: 20240529-iep-8bb4a3cb9068

Best regards,
-- 
Diogo Ivo <diogo.ivo@siemens.com>


