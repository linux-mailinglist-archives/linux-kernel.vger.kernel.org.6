Return-Path: <linux-kernel+bounces-266779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE52F9406B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA851C2277F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6F616191E;
	Tue, 30 Jul 2024 05:04:01 +0000 (UTC)
Received: from hkg.router.rivoreo (45.78.32.129.16clouds.com [45.78.32.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DFE7E792;
	Tue, 30 Jul 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.78.32.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722315841; cv=none; b=bTqEeLtQPDl+hgEOTn4jHLPIcYGh0752e792Za8Qz/93KQG+ShbTxfHKVvCbyBNEc9PF9J/trkcxXA/g3lDIiBaVSqUx7PsBVUIcJdKhfqsy9V/bKYd2z3fHtQQYCNH8jV7Tw81L1j4KfYV5NRrHPGOf3/xA72gH7Fii4U3OiK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722315841; c=relaxed/simple;
	bh=vzcBdUXqgSpR0Tr36QiwLkFOsVyrsRsd8QRfyJL0scA=;
	h=Message-ID:Date:Subject:From:To:Cc:MIME-Version:Content-Type; b=MO1NvH8hkTEvzZUYmHVktmzsDQcwrYOVCN8iUX6AACDQKkeM08jpwja0PcW1IrVRDzgqE8hkupVnWamgHYtHZ9VH5VwWEQR9o5fJ9gPNwgLbAQqcRl0zRg48SlzCR7bIhqwDE3+CWoXYKP6vU1m/ekExr/ThNEWcqqwiczyWVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one; spf=pass smtp.mailfrom=rivoreo.one; arc=none smtp.client-ip=45.78.32.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivoreo.one
Received: from tianjin2.rivoreo.one (unknown [10.100.1.128])
	by hkg.router.rivoreo (Postfix) with ESMTPS id F3B6311CF0B;
	Tue, 30 Jul 2024 05:03:57 +0000 (UTC)
Received: from [10.1.105.1] (localhost [127.0.0.1])
	by tianjin2.rivoreo.one (Postfix) with ESMTP id 215D46870F;
	Tue, 30 Jul 2024 13:02:34 +0800 (CST)
Received: from 10.12.4.102
        (SquirrelMail authenticated user whr)
        by _ with HTTP;
        Tue, 30 Jul 2024 05:02:34 -0000
Message-ID: <7aef67e6c45c7e91f1da4a9854b2f770.squirrel@_>
Date: Tue, 30 Jul 2024 05:02:34 -0000
Subject: [PATCH] of/irq: Make sure to update out_irq->np to the new parent
From: "WHR" <whr@rivoreo.one>
To: "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [Rivoreo]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal

Commit 935df1bd40d43c4ee91838c42a20e9af751885cc has removed an
assignment statement for 'out_irq->np' right after label 'skiplevel',
causing the new parent acquired from function of_irq_find_parent didn't
being stored to 'out_irq->np' as it supposed to. Under some conditions
this can resuit in multiple corruptions and leakages to device nodes.

Update 'out_irq->np' before jumping to label 'skiplevel'.

Signed-off-by: WHR <whr@rivoreo.one>
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c94203ce65bb..580b33ce60d2 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -263,6 +263,7 @@ int of_irq_parse_raw(const __be32 *addr, struct
of_phandle_args *out_irq)
 		if (imap == NULL) {
 			pr_debug(" -> no map, getting parent\n");
 			newpar = of_irq_find_parent(ipar);
+			out_irq->np = newpar;
 			goto skiplevel;
 		}
 		imaplen /= sizeof(u32);
-- 
2.30.2



