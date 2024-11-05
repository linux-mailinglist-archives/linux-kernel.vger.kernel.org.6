Return-Path: <linux-kernel+bounces-396941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC89BD4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182141F234BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4C1E8850;
	Tue,  5 Nov 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r/eT5FBO"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828CA188703;
	Tue,  5 Nov 2024 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831793; cv=none; b=S9jD1FK8RmjyUpkpGqzb2L3bhcTntjNJYeIf5idJKVx18zMPJElUD0APT9qP7CK6G0iKiVMtSXwwW1KdFT9QfTX1jjuKmxOcNyNgopMvsdc15yxufORbjOkSOJaWg74HbYrsDhQPhGDtT63EpX2g+un7rsaVlQKNqm/vnRxwzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831793; c=relaxed/simple;
	bh=z6u/32qG+4VOxWxyQMcxtikghEw3g/GuPpIgKl24hiQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsL5tWHQK2YyFvdPuLFTMeBRQNqp+OpiXhpW5qUbfF1U5iw5OC+p3iczzFz+rsXzFYaL2OjwWJbvLH+Q2bQxZ+yAbSIyz92FlsrTZwggFbKp19wqNl8tCfZ6yJA5w7LE15OUiF+CRkMzuGUdr19J73SXCgw9OGSSAyRacx4YUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r/eT5FBO; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730831791; x=1762367791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z6u/32qG+4VOxWxyQMcxtikghEw3g/GuPpIgKl24hiQ=;
  b=r/eT5FBOHkYUYHYeYZ31tPDD456wYKoBHaITgKk6MgSrbkI8K/4FbuEm
   NvC9gwdQj7/7dXBwHBEQBW8kR6WkT0+zAlaIdZuG2BlPKRnZTO0KVU40v
   x8VZOfX2xWNzzhiXskRGJK4lOfC7+5pOLVlJjIvrdt7C+NuxuR5o2OBeA
   T888/yMe78uuRnaGqY/1hcrKBk7VWaqFXyNr25rafnfikzXsO+4utRwgq
   tHCQ04gbLCFGSlXW56xlPeoN7G066Hr+eZCWAQd4J82FSgrBYpgbYw4hU
   6RM/+VRvx6cK4UsYjD8AFkuN6HtGEST2dTpV4tXywXGoLoRXHohMVuKr/
   A==;
X-CSE-ConnectionGUID: T1uVhdVNQzWREZUebUBC5w==
X-CSE-MsgGUID: KUCIu0viQTCzfI5QziG2lQ==
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="37385616"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Nov 2024 11:36:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Nov 2024 11:36:21 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 5 Nov 2024 11:36:18 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<ycliang@andestech.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	<peterlin@andestech.com>, <samuel.holland@sifive.com>,
	<conor.dooley@microchip.com>, <alexghiti@rivosinc.com>,
	<ruanjinjie@huawei.com>, <takakura@valinux.co.jp>, <conor+dt@kernel.org>,
	<jassisinghbrar@gmail.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 2/4] riscv: export __cpuid_to_hartid_map
Date: Tue, 5 Nov 2024 18:35:11 +0000
Message-ID: <20241105183513.1358736-3-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105183513.1358736-1-valentina.fernandezalanis@microchip.com>
References: <20241105183513.1358736-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

EXPORT_SYMBOL_GPL() is missing for __cpuid_to_hartid_map array.
Export this symbol to allow drivers compiled as modules to use
cpuid_to_hartid_map().

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 arch/riscv/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index c180a647a30e..d58b5e751286 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -43,6 +43,7 @@ enum ipi_message_type {
 unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
+EXPORT_SYMBOL_GPL(__cpuid_to_hartid_map);
 
 void __init smp_setup_processor_id(void)
 {
-- 
2.34.1


