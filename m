Return-Path: <linux-kernel+bounces-304910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 742C0962697
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CABB224C2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC071741D9;
	Wed, 28 Aug 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vcpdoxPq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A315B968
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847048; cv=none; b=EmSZFrrM4b28EpGwKjpks9qmF32fpgxTIwW1uO19PMH9sI8VlJ0I47zFK5sM4FV8E7iH/6AGcaZHfcIWcXEPDKbXGUiij3EKUm1QCLOMEYWQGRbUchfNl99bZMMhy4ovMJtk8TIvMLVypWcrKPNzfQnOf1YsAdfkG5dbzrIDu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847048; c=relaxed/simple;
	bh=qnSAC7svISXYC4hXe6Ir5GHeB/1k3CZAcZC7XqlMWZ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KE3BAIY0gtpMPQnd3GSzch2Ux0gJAxjvE800Lxd+8ByNp5ImXeoucjet/uU/ugJh8sOA4fAvhYsGhKJgOR4h6/OXt2rn6mNya/8piBQg7lyaqiLJViozby73e3gk9iviyDwGSUS3uxZO3isrV5YVrQEln/toUrcB0JHyEGNJ97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vcpdoxPq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SCA9aV071428;
	Wed, 28 Aug 2024 07:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724847009;
	bh=X+eohlseBm4K7XE6ERpIFZvej9v+WhaqFO5TH8psUN8=;
	h=From:To:CC:Subject:Date;
	b=vcpdoxPqplu4G8EZ2/Y6DWXfu5K6m1sIDruofSgB8R0b953snfJKTDZtu0E4iVa+h
	 JqoL1qt6tdnbWM8+yYzcZ8xvK6QRz5g3w4xwAWNhhL6P3coHB0bjFAQ1bwLe5f/64x
	 h2gUFg58CqcXweZ7VDo2ei2q4HPAQyMgUY4/dze8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SCA9EX078166
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 07:10:09 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 07:10:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 07:10:09 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SCA9i3062377;
	Wed, 28 Aug 2024 07:10:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <bb@ti.com>, <d-gole@ti.com>, Nishanth Menon <nm@ti.com>,
        Jan
 Dakinevich <jan.dakinevich@salutedevices.com>,
        Mark Brown
	<broonie@kernel.org>
Subject: [PATCH] mfd: syscon: Set max_register_is_0 when syscon points to a single register
Date: Wed, 28 Aug 2024 07:10:08 -0500
Message-ID: <20240828121008.3066002-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Commit 0ec74ad3c157 ("regmap: rework ->max_register handling")
introduced explicit handling in regmap framework for register maps
that is exactly 1 register wide. As a result, a syscon pointing
to a single register would cause regmap checks to skip checks
(or in the case of regmap_get_max_register, return -EINVAL) as
max_register_is_set will not be true.

Fixes: 0ec74ad3c157 ("regmap: rework ->max_register handling")
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Mark Brown <broonie@kernel.org>

WARNING:
This is probably going to expose some other hidden bugs in other code
bases, for example: https://lore.kernel.org/r/20240827131342.6wrielete3yeoinl@bryanbrattlof.com
exposed a very interesting behavior - regmap_read now correctly fails
with -EIO in https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/ti-cpufreq.c#n343
when the dt is modified to provide exact syscon register, but cpufreq
driver attempts to read at 0x18 reg offset, but then, the code assumes
that invalid regmap ranges imply OMAP3 and goes and reads some random
register.. (fixes for cpufreq is pending).

in the above example: adding prints in cpufreq driver (in the same
location pointed above):
before this patch:
read returns 0 with value 0x00000243 and regmap_get_max_register would
return -EINVAL

After this patch:
read returns -EIO with value 0x00000000 and regmap_get_max_register would
return 0x0

This would be the correct behavior.

 drivers/mfd/syscon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 2ce15f60eb10..3e1d699ba934 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -108,6 +108,8 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_res)
 	syscon_config.reg_stride = reg_io_width;
 	syscon_config.val_bits = reg_io_width * 8;
 	syscon_config.max_register = resource_size(&res) - reg_io_width;
+	if (!syscon_config.max_register)
+		syscon_config.max_register_is_0 = true;
 
 	regmap = regmap_init_mmio(NULL, base, &syscon_config);
 	kfree(syscon_config.name);
@@ -357,6 +359,9 @@ static int syscon_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	syscon_config.max_register = resource_size(res) - 4;
+	if (!syscon_config.max_register)
+		syscon_config.max_register_is_0 = true;
+
 	if (pdata)
 		syscon_config.name = pdata->label;
 	syscon->regmap = devm_regmap_init_mmio(dev, base, &syscon_config);

-- 
2.43.0


