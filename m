Return-Path: <linux-kernel+bounces-235417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D055191D4D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 02:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6AF1C208EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 00:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AC0EC4;
	Mon,  1 Jul 2024 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQM9h7yt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E41366
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792721; cv=none; b=CDXstoIBl9Ony9ZoaECpF4BbT5GulLkSfOqmgTT62RCf7UecXEGJGTvZLJ3n3QAdMirTp9jI/d522lPFGqrEcd/kEyBd2yyJDEGsLhF1W3642qEa0ULomK5Ier2pHJDZkaM1lAHg5+V783nUvEQyWw3qBg1xtB4Zz9HMNhzFKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792721; c=relaxed/simple;
	bh=qDBYmXLIyGEwG4zOGpnCGdxiTHARFZfuUL+hW5BG1ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bFIDyYlCGEyVn/yA8IKHQx+AUQhZuytYFGJuHHcnjZC+ADgMa2zsJ5eoqofJjnf5zWQBs2cntrUHTwfEehh0yakMWC/fge24WRfo5XZsaE++xC7dbJBk22C+4KdoeEqbuqcOET6Ceej/UzwgDCqZiiMoj5gxy9MPe/3g3JiPEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQM9h7yt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719792718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mU9F2wbBHImjhkDE+BEiCHKlQp03FXUfEaZ7m9bIJSM=;
	b=DQM9h7ytjSgOOFlma2WZnJkMhslD/lbSj8N6ZbEvZRtBty6nXQf2KVkzP809mPG5Fz4mNi
	3YxbtB24Y3UVi6lZmYrgxnXQr3y8O5QKj5g+EN8Ujsycw+H+dVzLh9hp9Earpvcj0zD/LL
	b2EHyfcsIirJQRQ1FU4rLXvCsuU6oto=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-QHUHr1ILOp-VMs2HGg-4DA-1; Sun,
 30 Jun 2024 20:11:55 -0400
X-MC-Unique: QHUHr1ILOp-VMs2HGg-4DA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9D9219560BA;
	Mon,  1 Jul 2024 00:11:52 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8F37300021A;
	Mon,  1 Jul 2024 00:11:48 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	Jonathan.Cameron@huawei.com,
	gshan@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH for-next/vcpu-hotplug] arm64: Kconfig: Fix dependencies to enable ACPI_HOTPLUG_CPU
Date: Mon,  1 Jul 2024 10:11:32 +1000
Message-ID: <20240701001132.1585153-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Both ACPI_PROCESSOR and HOTPLUG_CPU are needed by ACPI_HOTPLUG_CPU.
Otherwise, we can have compiling error with the following configurations.

  CONFIG_HOTPLUG_CPU=n
  CONFIG_ACPI_PROCESSOR=y
  CONFIG_ACPI_HOTPLUG_CPU=y

  arch/arm64/kernel/smp.c: In function ‘arch_unregister_cpu’:
  arch/arm64/kernel/smp.c:563:9: error: implicit declaration of  \
  function ‘unregister_cpu’; did you mean ‘register_cpu’?        \
  [-Werror=implicit-function-declaration]
  563 |         unregister_cpu(c);
      |         ^~~~~~~~~~~~~~
      |         register_cpu

Fix it by enabling ACPI_HOTPLUG_CPU when both ACPI_PROCESSOR and
HOTPLUG_CPU are enabled, consistent with other architectures like
x86 and loongarch.

Fixes: 9d0873892f4d ("arm64: Kconfig: Enable hotplug CPU on arm64 if ACPI_PROCESSOR is enabled.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406300437.XnuW0n34-lkp@intel.com/
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e8f2ef2312db..ff17c5705324 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,7 +5,7 @@ config ARM64
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
-	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR
+	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if (ACPI && PCI)
-- 
2.45.1


