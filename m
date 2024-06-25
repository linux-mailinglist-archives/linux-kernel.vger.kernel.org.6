Return-Path: <linux-kernel+bounces-229231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14799916D21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4739F1C22630
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A84516F0FD;
	Tue, 25 Jun 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olCwcuEj"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E279D2F5;
	Tue, 25 Jun 2024 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329611; cv=none; b=ROxLNIIf9ZpW5aqmxQwhyo82OLKDM2JlfeI707SMGyHglcBQ2x76zPhxsb2/Usgr9/NuREWdVHBdvoJimS8ZnSbJIxzutC+cj6rL1xaIwfgIMQF+xQHTLP+O8jbWDQEST2R6NUyKDqZd0CogJexdwnXrRw6PJ+ENPTfxDCgAXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329611; c=relaxed/simple;
	bh=QvNvFEHoBwEH1VIOqHQAmQ3EV4Rb4HeDRHpL5s+dJTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gZjz/Pf1mwhaNhLTTS9DEwBUFpqRQ6FySDjnT1QmUotbb9mOuR8fxyrqFrc4YqM/aPCDp7QCuIfOLxzPIrUnZrXEwhhup8KU6reDN0bF2yuyCdfl181hKtK+t+JJqcrRGUoFYbJEs3ymP2+r0BxMbeHjVD/pjDvtEcbK7iN8nYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=olCwcuEj; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PFXMX1056299;
	Tue, 25 Jun 2024 10:33:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719329602;
	bh=k4HXMomJZKq9jOBnN7r4GjioLYvEZzxX1ikda9RKXHY=;
	h=From:To:CC:Subject:Date;
	b=olCwcuEjs63v0XImKFLQN0NUXapMLxqgQ5mTB+fYD/+p91xkVUJm0EHnzMcP0Sxn+
	 ViN5YfwZwA48HbH/PNdxKJ9R2PTzEn92yVUx4NzBt0POZKpn1xOE5m3LCB9GZGfnR4
	 kKvIef0ZwGbFL8IL1UxCgc2ed0eMJ2oCjomKTAas=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PFXM2b011722
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 10:33:22 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 10:33:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 10:33:22 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PFXMMm113821;
	Tue, 25 Jun 2024 10:33:22 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 45PFXLmm017355;
	Tue, 25 Jun 2024 10:33:22 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>
Subject: [PATCH v3 0/2] Add documentation for PA_STATS and MAINTAINERS entry for ti,pruss.yaml
Date: Tue, 25 Jun 2024 21:03:14 +0530
Message-ID: <20240625153319.795665-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

This series adds documentation for PA_STATS in dt-bindings file ti,pruss.yaml.
This bindings file doesn't have a MAINTAINERS entry. This series add the
MAINTAINERS entry for this file as well.

Changes since v2:
*) Added RB tag of Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> to
   patch 2/2
*) Added patch 1/2 to the series as the binding file is orphan.

v2 https://lore.kernel.org/all/20240529115149.630273-1-danishanwar@ti.com/

MD Danish Anwar (2):
  MAINTAINERS: Add entry for ti,pruss.yaml to TI KEYSTONE MULTICORE
    NAVIGATOR DRIVERS
  dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support

 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 20 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 21 insertions(+)


base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
-- 
2.34.1


