Return-Path: <linux-kernel+bounces-543817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9163A4DA46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347311884B17
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B421FDE2F;
	Tue,  4 Mar 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q6h6GErp"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4061FECA5;
	Tue,  4 Mar 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083800; cv=none; b=AU9FeCSBfnVLE02m00whrI+vxXLF5f4PqHdLmOD/A37o4NMmABwWwiCft4aDwynVB6gXA5kHAEGIXAXDvwmbNCcKTlJezLcwlJFXL7Nma8RaHOtM+zo0RIiZ3tyUDg71h3QX9OFYmhpRlbAryHwA6h8VkPEMzhE9Bc7QKQfkZd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083800; c=relaxed/simple;
	bh=Lwj3dnQDXVkjv/QiIR1dDejiefFavpViYn5l82/vQk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TI2R46uexYYZbGNuIF3kMXhHk5Jddq6ZjE87P5IZ91UW8toOLjMq6jo8ZGkngYeQsNiDaS2+SAT7SX07OpqhPph+LA9Oh352G3ByTblqRP0D+EMhZGF1o0R3Wi07paBn+FhuKowWVn+ck/wCAH2+TKnENyrhvP7CMJ+pEaj6Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=q6h6GErp; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 524ANApX3620563
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 04:23:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741083790;
	bh=hetC0MzNXHD4UZFh6wahMxCRZ/46j2INBM97HWBrLzw=;
	h=From:To:CC:Subject:Date;
	b=q6h6GErplVzthPveVdZqqSb9ixi/4p0Zc15R8Y4Sqc2Bsts6mdnTs4YosMx964KDo
	 mOQQm1EoPxlqyx6MFLmPznjMBv/yMtfz4kArHYb/Jajji7KH9IY9RS3c3d8Ur3prRF
	 yAQBdoND0mpfqsl36uOW6Tm/or5HgGGJUsL6K0XM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 524ANAE4008547
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Mar 2025 04:23:10 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Mar 2025 04:23:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Mar 2025 04:23:09 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 524AN8kE061934;
	Tue, 4 Mar 2025 04:23:09 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Peter Rosin
	<peda@axentia.se>
CC: <s-vadapalli@ti.com>, <danishanwar@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Chintan Vankar
	<c-vankar@ti.com>
Subject: [RFC PATCH v2 0/2] Extend mmio-mux driver to configure mux with new DT property
Date: Tue, 4 Mar 2025 15:53:04 +0530
Message-ID: <20250304102306.2977836-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This series extends mmio-mux driver's capability to configure driver in
with extended property.

In current driver implementation, driver is parsing register's offset,
mask and value from two different device tree property which makes it
complex to specify a specific register or set of registers. Introducing
mux-reg-masks-states will make it easier to specify the same values for
particular register or set of registers.

This series is based on linux next tagged next-20250303.

Link to v1:
https://lore.kernel.org/r/20250227202206.2551305-1-c-vankar@ti.com/

Changes from v1 to v2:
- Updated dt-bindings for the required conditions as suggested by Conor
  Dooley and Andrew Davis.
- Modified driver changes as pointed out by Andrew Davis.

Chintan Vankar (2):
  devicetree: bindings: mux: reg-mux: Update bindings for reg-mux for
    new property
  mux: mmio: Extend mmio-mux driver to configure mux with new DT
    property

 .../devicetree/bindings/mux/reg-mux.yaml      |  28 +++-
 drivers/mux/mmio.c                            | 144 ++++++++++++++----
 2 files changed, 141 insertions(+), 31 deletions(-)

-- 
2.34.1


