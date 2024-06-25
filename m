Return-Path: <linux-kernel+bounces-229234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8F916D27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2CF1F2952B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A887173322;
	Tue, 25 Jun 2024 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E9Bq5sLE"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD87172BC2;
	Tue, 25 Jun 2024 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719329619; cv=none; b=RYuFlOCIw3QDdUceBU6jbf3HmS5302FiQJ5fvc8md7oJGyjidMhHlhLgVl7aq9yCAfYje4TRlOBFhkgHFrfqa6mtQnEoNvWi2Q9IHQvQTBxCKoepvnSyjAvhBBqFwSDfhp7Rn8r4IKcKlv1vjsA7LO5u7YuBgmTULrFw2DyDtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719329619; c=relaxed/simple;
	bh=m/QkqVyyFTb96FWNC8deZodOWSXnmpCP4cB1QZEGLxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uy+XxCbbYC0iUOFwW06N/eaiEpa4FS/O3gycUAOmhaI+K2HFRKBO7MvknQLsmqZetY7YlcXWTXDGtcyInPlx/m+ge3dUahRz/wy8VnMece36P7HlmHPv54PXDFrt4Jx2Ml7/5uOW3mHXQ9Xf4Da9JX9t7gzeNvXw5YyKwR4+kKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E9Bq5sLE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45PFXU68076639;
	Tue, 25 Jun 2024 10:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719329610;
	bh=PKaSpbExb5kIf+FXUtT4UKtJXOHhVjmxLC56LnsRzdE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=E9Bq5sLEXO9SgqtBJDvClQtVLO37pV0k79/WlCr0u4shSs9wFptGd7idN+aP+ej8w
	 fulHADdmOzA+VIWqYxXrscYhBui8sX23pgbf+hRD1fkFYGjM9uvBwXld3VrGP9MsSp
	 Hypeb2rzLqjBcKBtMsKaGtcmOXm2pAhKr+vnF400=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45PFXUfj049942
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Jun 2024 10:33:30 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jun 2024 10:33:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jun 2024 10:33:30 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45PFXUjm065381;
	Tue, 25 Jun 2024 10:33:30 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 45PFXTl9017376;
	Tue, 25 Jun 2024 10:33:30 -0500
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
Subject: [PATCH v3 1/2] MAINTAINERS: Add entry for ti,pruss.yaml to TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
Date: Tue, 25 Jun 2024 21:03:18 +0530
Message-ID: <20240625153319.795665-5-danishanwar@ti.com>
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

Currently there is no entry for
Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml file. The driver
file corresponding to this binding file is drivers/soc/ti/pruss.c which
is maintained in TI KEYSTONE MULTICORE NAVIGATOR DRIVERS. Add the
binding file also to the same section so that this could be maintained.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77008faf25ee..cc4731bbc655 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22759,6 +22759,7 @@ L:	linux-kernel@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
+F:	Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
 F:	drivers/pmdomain/ti/omap_prm.c
 F:	drivers/soc/ti/*
 
-- 
2.34.1


