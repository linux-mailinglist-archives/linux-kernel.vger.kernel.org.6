Return-Path: <linux-kernel+bounces-254934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EE893396F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3141283540
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D033FB83;
	Wed, 17 Jul 2024 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pK+fggm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C23D38E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206520; cv=none; b=CZ7ddgBsG9Ta+RKOnR5F8kr+M2OhWeK8j9A/KgWNgKBKfsLlcWr2lIPytrvgmvmddBvJ+qqQ8P+JeIOl6vq2AJlMSLuhHrVLlHLETNrv88PA6uLkurmfncuRWcdBQFYqOPWDAaABOTwtySdiGa2hF6IZPVbZJwQOM6HHl1drT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206520; c=relaxed/simple;
	bh=DHZSdFj12CNoCuzszmzk1V86rPvtnt1xB5Fb8oSp9OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AKJ7C0skew4StyzbTZd3IjwM27NOxRWarXVNhw4aHQigDrWjsmU/vHl3tia4csm7bVo1RnyRMap06i109/IC2gH77c9//Nndm81J6G4dJO0UwGKPj5MfFRBxKFgQ7RBKRYdxnJUYsOdxqY3269aC/RVidyCzCt4K1FFD4TfqWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pK+fggm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C068C4AF09;
	Wed, 17 Jul 2024 08:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721206519;
	bh=DHZSdFj12CNoCuzszmzk1V86rPvtnt1xB5Fb8oSp9OA=;
	h=From:To:Cc:Subject:Date:From;
	b=pK+fggm7RCbX+rv3w9xGhY2LhgtENb6q3oqIU5XVw4tliZBtLUuTnPBN/CoPdoGqF
	 fOaDZK/Wh/YvCA/UXLxZUww66bZq+nl9wculpRitIHnEirnxhXGUjV+0Raf3mqfxx+
	 InYhHB8AOD7ionSDaWwlxXyVn3SGhu2D7WtTAz3hrOqzMfux4jyXD//5wcQ5LqpiOP
	 kwXyDXijHb823bNlaY0mNT9ih6ij07uXa2M+C1FCO4UVYdUNQr0ADYZ+kscylUdDBW
	 vwrCVzR18f9fJgSOQGcYYQ1ek4nrT0bhAHcMkU3Rda3OH7AF8QA+OyMNXrEeLI6DAI
	 dAixryMtZdRzw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] RISC-V: hwprobe: sort EXT_KEY()s in hwprobe_isa_ext0() alphabetically
Date: Wed, 17 Jul 2024 09:54:38 +0100
Message-ID: <20240717-dedicate-squeamish-7e4ab54df58f@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=6NJp1/sgFysXap5wH5veGRgn0KXcr6TsXGlfdh3O0z4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnT285Z1jQIrRT62hcml2eZ/f/zCt1M3oP1hy/w56WFO GoUmVt1lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCJeyYwM92brNDZ1/7qgcPrs TP9pu76wl9kExC0XZf+d6hPf0WIRwvBXfMqEOfmyVyqmdq58OKu+9ur3O/GbD4jvrJt6z+iYX9U VbgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Currently the entries appear to be in a random order (although according
to Palmer he has tried to sort them by key value) which makes it harder
to find entries in a growing list, and more likely to have conflicts as
all patches are adding to the end of the list. Sort them alphabetically
instead.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/kernel/sys_hwprobe.c | 43 ++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 685594769535..8a1c9ce170e8 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -93,44 +93,45 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		 * regardless of the kernel's configuration, as no other checks, besides
 		 * presence in the hart_isa bitmap, are made.
 		 */
+		EXT_KEY(ZACAS);
+		EXT_KEY(ZAWRS);
 		EXT_KEY(ZBA);
 		EXT_KEY(ZBB);
-		EXT_KEY(ZBS);
-		EXT_KEY(ZICBOZ);
 		EXT_KEY(ZBC);
-
 		EXT_KEY(ZBKB);
 		EXT_KEY(ZBKC);
 		EXT_KEY(ZBKX);
+		EXT_KEY(ZBS);
+		EXT_KEY(ZCA);
+		EXT_KEY(ZCB);
+		EXT_KEY(ZCMOP);
+		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICOND);
+		EXT_KEY(ZIHINTNTL);
+		EXT_KEY(ZIHINTPAUSE);
+		EXT_KEY(ZIMOP);
 		EXT_KEY(ZKND);
 		EXT_KEY(ZKNE);
 		EXT_KEY(ZKNH);
 		EXT_KEY(ZKSED);
 		EXT_KEY(ZKSH);
 		EXT_KEY(ZKT);
-		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZTSO);
-		EXT_KEY(ZACAS);
-		EXT_KEY(ZICOND);
-		EXT_KEY(ZIHINTPAUSE);
-		EXT_KEY(ZIMOP);
-		EXT_KEY(ZCA);
-		EXT_KEY(ZCB);
-		EXT_KEY(ZCMOP);
-		EXT_KEY(ZAWRS);
 
 		/*
 		 * All the following extensions must depend on the kernel
 		 * support of V.
 		 */
 		if (has_vector()) {
-			EXT_KEY(ZVE32X);
-			EXT_KEY(ZVE32F);
-			EXT_KEY(ZVE64X);
-			EXT_KEY(ZVE64F);
-			EXT_KEY(ZVE64D);
 			EXT_KEY(ZVBB);
 			EXT_KEY(ZVBC);
+			EXT_KEY(ZVE32F);
+			EXT_KEY(ZVE32X);
+			EXT_KEY(ZVE64D);
+			EXT_KEY(ZVE64F);
+			EXT_KEY(ZVE64X);
+			EXT_KEY(ZVFH);
+			EXT_KEY(ZVFHMIN);
 			EXT_KEY(ZVKB);
 			EXT_KEY(ZVKG);
 			EXT_KEY(ZVKNED);
@@ -139,16 +140,14 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZVKSED);
 			EXT_KEY(ZVKSH);
 			EXT_KEY(ZVKT);
-			EXT_KEY(ZVFH);
-			EXT_KEY(ZVFHMIN);
 		}
 
 		if (has_fpu()) {
-			EXT_KEY(ZFH);
-			EXT_KEY(ZFHMIN);
-			EXT_KEY(ZFA);
 			EXT_KEY(ZCD);
 			EXT_KEY(ZCF);
+			EXT_KEY(ZFA);
+			EXT_KEY(ZFH);
+			EXT_KEY(ZFHMIN);
 		}
 #undef EXT_KEY
 	}
-- 
2.43.0


