Return-Path: <linux-kernel+bounces-180114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB5B8C6A43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5181FB243F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91D15666D;
	Wed, 15 May 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6ELehAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE76156230
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789383; cv=none; b=bmSBywqZV8YCY0RDmmbPIhX0l4tG03j/0Ul3tXbN7pnSKRxk4GC3nI31kixjhHag6tkLwva0sVIN01rGT/vJQy3VJhi40gxOgDtEYFA3FSLuTo++Vdebcgk0QT1RgFHcNRDOiZTF6YQkCdmS1AAdM1znrkp4oPDLtOiEMng9J2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789383; c=relaxed/simple;
	bh=NSbjQo0KGQxr91tG/X2mH7UIPoBhdYx/7f7fa50z/kA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJOT7VTZYn4vZRDzIIemulIQ50XSBEdmUlLva+YN0RaYlxuOQU5lGU34qOlXb1/qA9Z530ppvFWxPnjSSGNEjrCBpPDpgCm+dudQjLcSoprbbfUCAdsrzRjR/z7huBp6Oolt1gHrwioAHLJfvz2l65iyhXRR+ZWm4kJzIBKSvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6ELehAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4678DC116B1;
	Wed, 15 May 2024 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715789382;
	bh=NSbjQo0KGQxr91tG/X2mH7UIPoBhdYx/7f7fa50z/kA=;
	h=From:To:Cc:Subject:Date:From;
	b=O6ELehAijm+yZ52B4QPZdDxq6OJ1qBWOnKCsfs0rnFJsB+aktwwNS9zwCXCcLSUjt
	 dF08DEJ+uO3T2ImhEM1SdHWYsvo62MDApyZXvlNMCeCq2ShAKO21yIoHHzV1YFXXNY
	 SOhsBSNFeK2USB41XC6wdQ+OZr8S6odNAs/WsQzqSrAlRBwYSt+xStRI5XdUJnkoIw
	 l/PJqGKL+dN0jpBh/bVsy0GWdErZTqFVvcf9G2O7E1xy173WE7LRYUfHvKWw2RG27M
	 hTo+mbLz0eLR5DUTJM83YDWLziddWvk05+AE1BnauzSLoVVFjXx8NTR65Z64jXa8OX
	 4iWzLxDWWy8Vw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RISC-V: fix Andes errata build issues
Date: Wed, 15 May 2024 17:09:34 +0100
Message-ID: <20240515-comic-sketch-3b40e6676f55@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CAhQk586zjWNLJWwZpilXc2NDKe1f0YCLS1pl9hBeaw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGku9+yC/srPWRVw96D6jISSR8y8xiVZibH1gX/fTL/8I +nzk16GjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk4WZGhkZlmbp3VqsvTP/6 Lv7KQct2/sTPPWsCA0oOT5jbaf6tO4uRoVtwzfSOpX+/KVw5dIIn4M2xlc163a/Xb7m/2tl8++U JaowA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Commit e47c37c24024 ("riscv: Introduce vendor variants of extension
helpers") added includes for the new vendor_extensions.h header in
the T-Head and SiFive errata handling code but didn't do so for Andes,
resulting in allmodconfig build issues when commit 589e2fc85850
("riscv: Convert xandespmu to use the vendor extension framework")
added a user of a macro defined there.

Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extension framework")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: Fixup commit references in the commit message

CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Charlie Jenkins <charlie@rivosinc.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/errata/andes/errata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index a5d96a7a4682..fc1a34faa5f3 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -17,6 +17,7 @@
 #include <asm/processor.h>
 #include <asm/sbi.h>
 #include <asm/vendorid_list.h>
+#include <asm/vendor_extensions.h>
 
 #define ANDES_AX45MP_MARCHID		0x8000000000008a45UL
 #define ANDES_AX45MP_MIMPID		0x500UL
-- 
2.43.0


