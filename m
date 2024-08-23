Return-Path: <linux-kernel+bounces-298476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA395C7CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B01F1F27055
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C173140397;
	Fri, 23 Aug 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jgowvR7P"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11774424
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400915; cv=none; b=rt5cEqpPB6O2FNX6bZkla0xEFa3KWCXUE3BxXHuCqNXuAPd9+2dk/UjFHhgCTlD4UcsA/S/VKKPmNozrm6azDNcaqK+XKnqbuPjC5c/3CwLwBDT3boTT0bt9FinfoK9vlygoGC9rM21kxh1PseH+Z1TLAyekAaQutHfO4yKEpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400915; c=relaxed/simple;
	bh=Nh03TPqbFYsYRBEpl8X2Yih+mFdq5vPg8NDq77DNQWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBvAsF9IuuwzDBVwHQg8SuT9va0opDC0HHDAenCjCp8EjWBn23Rgn6GAjAmh7HIJdDGY9kdrk9juyD8gIdIeuYnaynyrzjh3ZGGYcIAW9ICvRpfKyC8SiiubuJ+7JOyvXW6mup4KQ6r9+I1kEVdwULI8H9HHoj+uYDyTCcQl4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jgowvR7P; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724400908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gNkEcx0ZY4Xc5R2zIwTHsYHGGBpssYeCMYyP4MX7JfI=;
	b=jgowvR7PjfcdtLG6qDjXeusG/K6Nu3tHQHPP0H0wDDojCPMbxoOjBIeUGbpjzePMrn1MC+
	fgBOdPVCDlHzkslsAJItF/Xu6/FMFSAIh2ZDGo+sZD1QSjcGXQ989wlTbsKyLkyJc1CRXB
	1iqlkF/Eg5vTF+DSqdPIp1EPvi+fCTQ=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ARM: riscpc: make ecard_bus_type constant
Date: Fri, 23 Aug 2024 16:14:44 +0800
Message-ID: <20240823081444.150976-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the ecard_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 arch/arm/include/asm/ecard.h | 2 +-
 arch/arm/mach-rpc/ecard.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ecard.h b/arch/arm/include/asm/ecard.h
index 4befe8d2ae19..7cbe001bf9cc 100644
--- a/arch/arm/include/asm/ecard.h
+++ b/arch/arm/include/asm/ecard.h
@@ -195,7 +195,7 @@ void __iomem *ecardm_iomap(struct expansion_card *ec, unsigned int res,
 			   unsigned long offset, unsigned long maxsize);
 #define ecardm_iounmap(__ec, __addr)	devm_iounmap(&(__ec)->dev, __addr)
 
-extern struct bus_type ecard_bus_type;
+extern const struct bus_type ecard_bus_type;
 
 #define ECARD_DEV(_d)	container_of((_d), struct expansion_card, dev)
 
diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 9f7454b8efa7..2cde4c83b7f9 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -1124,7 +1124,7 @@ static int ecard_match(struct device *_dev, const struct device_driver *_drv)
 	return ret;
 }
 
-struct bus_type ecard_bus_type = {
+const struct bus_type ecard_bus_type = {
 	.name		= "ecard",
 	.dev_groups	= ecard_dev_groups,
 	.match		= ecard_match,
-- 
2.41.0


