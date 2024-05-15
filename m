Return-Path: <linux-kernel+bounces-180104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6198C6A21
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDEC01C22392
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96788156243;
	Wed, 15 May 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dphlepJN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE929155A53
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715788963; cv=none; b=L6nYi9CuxQjhi1fPOp9I8px8X1FtBFJYIYgCJwaDJWI3UoMyFYghtYy0eUHORkjhWGIK+Av0kr/0nNFpcgyMirGZ0h9K8yW3bntgfGQxwY+OVu0O3LDgzsXWnPy+oEsjQ3RYbuF4f0vB0uhVs//KVIekrjVi4bMRMcWH9tJhFrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715788963; c=relaxed/simple;
	bh=AFgzPFaBHoRhzogGDzm865PJZzrfFEUfkq5R7FJmT2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=heFRzgRnEhjdLRM3vPljFkziYXlxjN9D/4OwZmLX0SHJ3wZ9Phs+uHK9w/ABU9O1Z0XlhOalzHJuTDcru6TmPP3PuhLpHVJmtoV40uEzZ8ml+XRi+mamIuqZzP5uEaHr1BD3TJFb9T8wQHZWDL7sv2zrfv66YWjtmPSEwtiMf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dphlepJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2C2C116B1;
	Wed, 15 May 2024 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715788963;
	bh=AFgzPFaBHoRhzogGDzm865PJZzrfFEUfkq5R7FJmT2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=dphlepJNhL0bOPCUtBmG4GlrBuXCoF/B6/azMgXpEC3VX/xg0rSrFYAGn56s2/A7m
	 QErfAf5aceJk50052JVAU+fiYyAYohWIAnoSzl1SrT2rNYTBaz4i0Sq3XWBzAykNZR
	 6fK966EJ3cyu1Dmabgti8rXPi4tVKXLp7X3tesxr0HfTR58IFAxhaQeO6ANisZPq9/
	 RxhRm8PxdC8V97yW+LSMUPqAsxGpWBJxCAloqlNWZZ+S1tSnLhEyBgGYvP8l4bgDsd
	 ZJlrEUHZhG5KzqFLnwKh4rdvq2VKsokk42gEM36jHCXzvlbY0CIz6yhzIfVRmVDVWU
	 gDfswjliJ9JJA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] RISC-V: fix Andes errata build issues
Date: Wed, 15 May 2024 17:02:28 +0100
Message-ID: <20240515-shimmer-retake-37033de08096@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1201; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=MhlCDrRGZxXwwiDuOFsO1SNCrGR0xpsno+lxxYP+x90=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkud6Zuv7D4usZkNhOR7y6dXWc/rDj29tyiPyvefJ/lW 97krn2bq6OUhUGMg0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATudrK8D9n38V9H/Y2qKVP N352/lgV4+uQdfO07ysvS/1Y3O39IfwUw1957dcip2ZLckvazGkS8iwMeBHbcfuxEvMZeZegrp1 Vf7kA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Commit Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor
extension framework") added includes for the new vendor_extensions.h
header in the T-Head and SiFive errata handling code but didn't do so
for Andes, resulting in allmodconfig build issues.

Fixes: 589e2fc85850 ("riscv: Convert xandespmu to use the vendor extension framework")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
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


