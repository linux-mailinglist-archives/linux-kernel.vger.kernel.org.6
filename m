Return-Path: <linux-kernel+bounces-229237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C6916D49
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DB71C20859
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD717624B;
	Tue, 25 Jun 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DFmQ6Ejg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6B174EC5;
	Tue, 25 Jun 2024 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329623; cv=none; b=ng8F1drhh3dRlEFM9k7Va44ht8yKQb/6N3monWWoOkf0ewq2d99htuy0ZQbbxsAc1pD0DestenQVlq5a1WYfS5NuMBmgaYm93Uik2eEf2syFm4ymM5PXSQJMqZwiqDkZI2Jt2UGinsNJ8Gm5MjlXYECVL0bjLg+ekKZRFQbt3jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329623; c=relaxed/simple;
	bh=QvNvFEHoBwEH1VIOqHQAmQ3EV4Rb4HeDRHpL5s+dJTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZXwIS+pD56br10wRDdbmu4wx0nnNvCp7HJZJuEShJb1v+UXjstIDB2IBpfgsOg8edl0bz4QFnTtPh47euFYJzQNFQvf0PhqR9TmerK599FUjjltAtXFcCLer5vwntGULkBlGT3CLby/usSuiakd/14swvBY2770r4TfCpGgP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DFmQ6Ejg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PFXSeS082459;
	Tue, 25 Jun 2024 10:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719329608;
	bh=k4HXMomJZKq9jOBnN7r4GjioLYvEZzxX1ikda9RKXHY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DFmQ6EjgCepNXfF3Rch8aNiYzwH/tdi2tvtjStbFfRsGLZ3o33vxUidqYWAdpQtin
	 kAsojxgfK8/bA8IX1h6HQcRjws2haN5BYzt9u/XEw7h8tLOXdK/28P3020u4cozVBQ
	 1g1/yxPm5eLqvg07ZtX9zc3CCQV+VK1GbnUBKHO0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PFXSGM049931
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 10:33:28 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 10:33:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 10:33:28 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PFXSFj113908;
	Tue, 25 Jun 2024 10:33:28 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 45PFXR4k017371;
	Tue, 25 Jun 2024 10:33:28 -0500
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
Date: Tue, 25 Jun 2024 21:03:17 +0530
Message-ID: <20240625153319.795665-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625153319.795665-1-danishanwar@ti.com>
References: <20240625153319.795665-1-danishanwar@ti.com>
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


