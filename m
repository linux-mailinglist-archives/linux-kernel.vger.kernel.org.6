Return-Path: <linux-kernel+bounces-266805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA6C9407F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8117F1C210B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858A816B736;
	Tue, 30 Jul 2024 05:54:00 +0000 (UTC)
Received: from hkg.router.rivoreo (45.78.32.129.16clouds.com [45.78.32.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32F433B0;
	Tue, 30 Jul 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.78.32.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318840; cv=none; b=oN8ij+spSv1AB1xIQ84tmOYkIXzMNeWRadF0P27ZgUUZJoloW7oV7xnG1soWh2e3qJX20pARJRxWSXGOcNpcFk2TUUMQf0T4n9PB8tg8XDCQnvBcosvxiSidHgqx42FdW09wSseT9Ziiqs61GTHleS0JZkylvqOIHByLgQiIZNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318840; c=relaxed/simple;
	bh=Z7La7G7oakeoQB5/SePx2tHx73w8tPhlfrgomARP8Zw=;
	h=Message-ID:Date:Subject:From:To:Cc:MIME-Version:Content-Type; b=pm9j9vnwOdedFuY3aSMySPZ9hqNlQRgmtYJAiCVyg/R9VZ+E1lKfe5rm/CPY1TiOfoMwCM9zC2/q2XZ2ZSUvwie3WxpUaDcFte26WrszmiudosFTIHQeSIIgbs8jSVDoAjA6vcBDSDiUJu2Hf+SOKbdp5NZLMadLL+1EXs41tE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one; spf=pass smtp.mailfrom=rivoreo.one; arc=none smtp.client-ip=45.78.32.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rivoreo.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivoreo.one
Received: from tianjin2.rivoreo.one (unknown [10.100.1.128])
	by hkg.router.rivoreo (Postfix) with ESMTPS id C9DB111CF0B;
	Tue, 30 Jul 2024 05:53:56 +0000 (UTC)
Received: from [10.1.105.1] (localhost [127.0.0.1])
	by tianjin2.rivoreo.one (Postfix) with ESMTP id E54C868828;
	Tue, 30 Jul 2024 13:52:32 +0800 (CST)
Received: from 10.12.4.102
        (SquirrelMail authenticated user whr)
        by _ with HTTP;
        Tue, 30 Jul 2024 05:52:32 -0000
Message-ID: <2046da39e53a8bbca5166e04dfe56bd5.squirrel@_>
Date: Tue, 30 Jul 2024 05:52:32 -0000
Subject: [PATCH v2] of/irq: Make sure to update out_irq->np to the new parent
 in of_irq_parse_raw
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

Fixes: 935df1bd40d4 ("of/irq: Factor out parsing of interrupt-map parent
phandle+args from of_irq_parse_raw()")
Signed-off-by: WHR <whr@rivoreo.one>
---
v2:
Add 'Fixes:' line, and update subject.

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





