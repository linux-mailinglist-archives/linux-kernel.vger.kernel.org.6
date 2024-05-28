Return-Path: <linux-kernel+bounces-192303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1A8D1B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 439C328468A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18316D9AA;
	Tue, 28 May 2024 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="aTYiduIz"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD6316D4EB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899349; cv=none; b=EpHL8QHjYVwSpeMTDFoVO/2A+CDCrR3R1qu9+Npb9Kh8pL3Zkl40tB6aQLcV4+ihUjcdpxaROqA1+AxmK5PEalKsRj753cRcH6pBHXPgWs5AEhB6jARwlj5QxC8M4f4NcLerPPLqu6yGfZw8DvroQp5MRJd1JTGfQ5MCVyH25uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899349; c=relaxed/simple;
	bh=rvbdUN0VgLOxYODsqTBZc4SNyjK2yjGwIGw8fwwSIhg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EmVHB4UBEDUdfnEUl7hqsleWDB2fblAf9yCHZYKkq+IuQE3UW/PqPvt43xK8EYBnvWuHOSoQK+3Z5Gm+OrfnZNf5nSf1N16e2x3ai2hPsPH8FqDHgSNlZ8KsvowJCWpygw3pnYDFb/mh4IXsPME0oVJb4jGlHsxXBY8GEgKWYkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=aTYiduIz; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=caMKrdEi8GmeDybKcQjT0Mo+9mRU5xyYPBFpLgpU7mA=; b=aT
	YiduIzrgX0rBg2aMeQudM1FDfvFKJ343fVanRBJ5VkuasUeYrUlWDdIsD6/xoXz/QB4G60zOBfQSF
	/rvQ1Zt9PUVklV9jwsCCC6HdP4j5KgUZTq/UXUFbFT3Dx+ZUnW0/LALiZA86anaMDv3mj9Oq7UibS
	28bHw0MonA9UHaD47MazwUFnhNgozYSk7bSFSUe5ZZmnxP+lwu3ARBh0U1kdRAR9aueBK/1t3C1IM
	iIXmq/Ju5+V5GlTv+qrF8173SGRGeBYZs6NsY9Lnt0tzmoTuJfopVqyTI18t0HzpOj9pn5PMOzYER
	Wt3YYzACaE8zomu1gJlCzPvymMiHXU4g==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBvwt-000G8p-HX; Tue, 28 May 2024 14:29:03 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBvws-000C97-0D;
	Tue, 28 May 2024 14:29:02 +0200
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v2 0/2] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
Date: Tue, 28 May 2024 14:28:51 +0200
Message-Id: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAPOVWYC/3XMQQ7CIBCF4as0s3YMUC3WlfcwXbR0oJMoGDCkp
 uHuYvcu/5e8b4NEkSnBtdkgUubEwddQhwbMMnpHyHNtUEKdxFm1aNMD2Ro0wVt2aC5a90JNqtc
 E9fSKZHndwftQe+H0DvGz+1n+1r9UliixI2t1O81GU3dzNHpejyY8YSilfAHeNOeYrQAAAA==
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716899341; l=1744;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=rvbdUN0VgLOxYODsqTBZc4SNyjK2yjGwIGw8fwwSIhg=;
 b=1H0rFqG0iwRxc9arIZ+939vI/XBypQXHYkFazli6NBy3csijY7hcf/xVFDS1azQUvTdjmRH/k
 u/XdQsx/uStBk4lCFDMcFLzKhAE/3SrU/borh93m1ZnEBh8C1JPn7+w
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
driver selects FSL_IFC automatically, we need the CONFIG_FSL_IFC option to
be selectable for platforms using fsl_ifc with NOR flash.
    
Fixes: ea0c0ad6b6eb ("memory: Enable compile testing for most of the drivers")
To: Krzysztof Kozlowski <krzk@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
To: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Esben Haabendal <esben@geanix.com>

Changes in v2:
- CONFIG_MTD_NAND_FSL_IFC depends on CONFIG_FSL_IFC instead of select.
- Refresh powerpc config snippet accordingly.
- Link to v1: https://lore.kernel.org/r/20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com

---
Esben Haabendal (2):
      memory: fsl_ifc: Make FSL_IFC config visible and selectable
      powerpc/configs: Update defconfig with now user-visible CONFIG_FSL_IFC

 arch/powerpc/configs/85xx-hw.config | 2 ++
 drivers/memory/Kconfig              | 2 +-
 drivers/mtd/nand/raw/Kconfig        | 3 +--
 3 files changed, 4 insertions(+), 3 deletions(-)
---
base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
change-id: 20240523-fsl-ifc-config-c877902b297e

Best regards,
-- 
Esben Haabendal <esben@geanix.com>


