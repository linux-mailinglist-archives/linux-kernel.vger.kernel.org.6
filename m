Return-Path: <linux-kernel+bounces-195543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312C8D4E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35CE281CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B2317D8A5;
	Thu, 30 May 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="i39I0L77"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802217C208
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080422; cv=none; b=q8XEdvdjGwJF1gEKcvKZi7LpvqgPo9J+mEdJ5WOqwgflmqUtg+WQ7nN4aTnrLq1vYmXbz4TXWbB+N8XIO+kYUe/9ua8t6rw0sKhINUdVJ4Dxy+0usTezSCaFYkptPtZeQvyMDWnxXp5meXVsPJQzOQmgGdzR8Ju/gjd6voxdCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080422; c=relaxed/simple;
	bh=3WWCjetdOX3kQpU87n8wx9QXjR46liZT87iarxYhdGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CbXvYYZgIMEdYApPfriOzg/t+iPXLCNKHCF6Gxh+PPk3ukfiKi6Amq75zfdJWYzQXm06y9XGFq1v9xlc5dHh4b+n8xLsWNDRBsvfROjOslQhB/vfG9nUq/Y7Ih6g11XwiuP3Uz028NYsMeAEBtsE50QbDWbg4i2l0cq9PKpJ/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=i39I0L77; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=toaWrj5FfqF/ruqvJdFwvhUkuZ/5yd2B9mg0A1EUPCc=; b=i39I0L77RLa/WGDh9Rr8VkM6Ns
	UpmaSvHkHTN/CPEBgqmCyHI/OZQXd8UZrDjsbNpE5y5LQSfZFnZdlMldkzlgzFectIjOqX9zRM22R
	PAhaTuzYoojP7K7IXMRoW8jc5LAwkqCKAXXLw6xQHCf9qzh6LSGpMDGdqI8rKR031F0XJzyOphdJu
	l2bH7e+/99H2TjtCxOkzmORte2tJ8Br/R65LSW9/tf5lm1xVZaa6csPWrmyrOUY/kiO5+Fbf4Ib9g
	jLYNLzl2r3d++3k+VBXlmd/1TxYhhyziDu81OPW0n81QudB/XnnBgJ1Nfc7Z3Xhz5II1hMQ9pX5i+
	6uYAg+tA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sCh3C-000CAq-LO; Thu, 30 May 2024 16:46:42 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sCh3B-000NEd-27;
	Thu, 30 May 2024 16:46:41 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Thu, 30 May 2024 16:46:38 +0200
Subject: [PATCH v3 3/3] arm64/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-fsl-ifc-config-v3-3-1fd2c3d233dd@geanix.com>
References: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
In-Reply-To: <20240530-fsl-ifc-config-v3-0-1fd2c3d233dd@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717080399; l=723;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=3WWCjetdOX3kQpU87n8wx9QXjR46liZT87iarxYhdGQ=;
 b=Kr8jncXQgANZyX+WMklgsKt5SScKqWEIneLy3JnIPD5Z7LxQ6+bIZGAEkTM7JxWF2zvKlqZa0
 xBCjvJcbjx7Cei1AW69pPLT8TqKo3ViOJHZyBPp8xAkLrH8gfItiX/j
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27291/Thu May 30 10:29:52 2024)

With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
selected in defconfig.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..d101593c3be2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1429,6 +1429,7 @@ CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
 CONFIG_EXTCON_PTN5150=m
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
+CONFIG_FSL_IFC=y
 CONFIG_RENESAS_RPCIF=m
 CONFIG_IIO=y
 CONFIG_EXYNOS_ADC=y

-- 
2.45.1


