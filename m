Return-Path: <linux-kernel+bounces-200367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C128FAF09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72521F2657A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7D143744;
	Tue,  4 Jun 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G6oVertT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39FDF42;
	Tue,  4 Jun 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494098; cv=none; b=XJtUahESGykCpo7TkTERinqO4qxJoYnwEeHis7ZNjhSyQFkqb1vwOyKmbgazeBA4ulzYyHgEGUzCi8gsLz7mAmSiaYnfBcTTAaCo7Qg1XnndZF9MFzJ7oCPHcSIqE8kqI35DO2kmsYJc4cNsyX6ZBkbnCdFtitcokyzvxkst+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494098; c=relaxed/simple;
	bh=SM2Az87ssMEdKl3Zc6l2aKiefImSYFd3zFQ+NVZiM8Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dLt7lPqEWqBFQal/L4+UbmKh9kZFhPa1P7QZd55tf/VfEtcpiZeZ0ydpn/OLUFWIvLFHSBgrutVvL+zxlsbIO343fENq+Dfi+39wrg9WnNNvnHXAsULf+ka5Dmeu9yVAeCLIvsovYVlfoWVpi/xRmlEaHKLEQS4WGFUo32PZHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G6oVertT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4549fQt7115448;
	Tue, 4 Jun 2024 04:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717494086;
	bh=6TaSMg6yCHdU4fGxayde3wr54vclOoz7TVh8CskP6ac=;
	h=From:Subject:Date:To:CC;
	b=G6oVertTrsqAIxYtdO7pT7Qxx9/oqk4nojO6QBJ+XmBvuRENf0HkiVAKqrnHoUlBs
	 b7NHVVjE2cWMyCUbhbJckNz/v7APP5qb8d7DkkEeI8iIQAQX/3uML0mnliSFrEwGxG
	 CmffAFAEmIwLp/D/x3mM2MywwpyIoY0+MKfeEP6Q=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4549fQuK120169
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 04:41:26 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 04:41:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 04:41:25 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4549fPxX096381;
	Tue, 4 Jun 2024 04:41:25 -0500
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 0/7] arm64: dts: ti: McASP fixes
Date: Tue, 4 Jun 2024 15:11:01 +0530
Message-ID: <20240604-mcasp_fifo_drop-v1-0-03ebe25f47db@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3hXmYC/x3MQQqAIBBA0avIrBNsEomuEiFmY82iFIUIpLsnL
 d/i/wqFMlOBSVTIdHPheDX0nQB/uGsnyVszoEKtjNLy9K4kGzhEu+WYpBmH1Q+6RzQIrUqZAj/
 /cV7e9wPC3np4YQAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jayesh
 Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Bryan
 Brattlof <bb@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra
	<j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1264; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=SM2Az87ssMEdKl3Zc6l2aKiefImSYFd3zFQ+NVZiM8Y=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuE5uK4c/b2Zl6qGWNpK63IjSUv0gq0VacjNV
 UMz7JJFCr6JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7hOQAKCRBD3pH5JJpx
 RaIIEACqXGigY3NvqATLvdfmrfAxj0QeBTWZ6W1b/igylp4PG01YLrV7d/hes2xqMsuEOMVLcT3
 32F+ojHbcz+HQW00zz7RnzpqPbjPrA3sTbmVD+oEZGnihREFtMvyD05qKvO6zgEE7Z8FRwVSlNq
 m1ZtBtOrLSQxAEVh9HGGM9U5GJ7Dz8knDW3M3K9OOL5NV+FYqPjPxnzq+ecGRPnj/SyTA1OEAHz
 ZK+BY0WeHZcuyeyoVn6zkPFy1aer47U/07FGDMZC4XPiC/16lrNHTvvR45ZaLnNUJpIH8BTL9xq
 cgmKrqnTNtIMWeOv6cDp5rFIZ0mYuVi5Mgmq9Iez+vlBbafHrVFmOhCqfW29k7Ls2TuPmdgTbMb
 r3EQqEf0OvNA5scUJYDeKG4115UmGd0etzasRx6OtFVunLz1YQrj5RuSMuc1eQWOdCE5uX7qrcE
 s97MzrOI7vI1IoHcj3gDqjH1YMdk+zsISVKlFUIindZNGPfusNSvHkabGCY0E8UHeY58hO/ZlZt
 9Q+XnUDhmtu8vH2+5Cn2Xh51H8Wiv5OFekKNLvIa2mLr01SMPSJZSb1TiMJ3FE9gzW96dwGReO1
 L9JLXk0LUV/BpxJEsM/+aQcv8YrIlEWFpdAk9HTl4VBxR+roYrUevrWI3x1PUlhvaiN4/OBrMQ/
 1srH0vXX0x6FJag==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Drop McASP AFIFOs for all AM62 based platforms, as the extra buffering
is not needed with BCDMA already having internal buffering.

Also fix the pinmux for McASP1 on AM62P.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Jai Luthra (7):
      arm64: dts: ti: k3-am62x: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62a7: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-beagleplay: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62-verdin: Drop McASP AFIFOs
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Drop McASP AFIFOs
      arm64: dts: ti: k3-am62p5-sk: Fix pinmux for McASP1 TX

 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi            | 8 ++++----
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts        | 4 ++--
 arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts               | 4 ++--
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts               | 6 +++---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi        | 4 ++--
 6 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240604-mcasp_fifo_drop-683bc3412262

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


