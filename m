Return-Path: <linux-kernel+bounces-343855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558AF98A05F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874371C21952
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F51922D7;
	Mon, 30 Sep 2024 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="YloFHyI+"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED919007F;
	Mon, 30 Sep 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695308; cv=none; b=LyIvHuXGhzFpAFubVhp8ywmU77nYWPy2M7fi9uVY1z10JPQ8ZUYrGrQz65bXYIsEphzanqN6VLcFofdgJI8lFx/5/bKRjqibIF0hgfzZm16347oITAHrLn5c6gcy2b+ItVGJkpq/fEcilDKJZoQjvSVzM7ZDt5dFfeGgv4qglvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695308; c=relaxed/simple;
	bh=Ci6Now09oVMC57oRzdnMxKpRTy6yzJcrIyHyt/wFE/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XpKkBFTUIIfvHwYNkHE2liu4j5UxwMNQCHEjhU91vOGguIltc/jwfnGybcjRw5G6dkxcAhQ7dvIbk7nqWMiSmJodVPR1IWQCkaGsFfYBJuNjSIrxBGUqYlGLy9RXADGA3QgxyfIUYTMjZdQoz7g1D+kLkKoAk9OGolqvFkHZpbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=YloFHyI+; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3CE01wnnuaV12E63oXSfBewShL+SIE6Xrnixx2NRW5c=;
  b=YloFHyI+f1M5jGXmlZKNqzmamICNGcErZFAYjcWcAknKBCjGcOmw2hci
   7oPHyljJuQY/quZwbU6VDyOGkpXnteOWe9sBWLN1FI5c6MeplqhI1SZLb
   YANADl+3kMiYIsRLNXp7R9JviCML/kMa5+vPq/hNtnW+xEvtJKQSQMjKJ
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956882"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:26 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Geoff Levand <geoff@infradead.org>
Cc: kernel-janitors@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/35] powerpc/ps3: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:20:57 +0200
Message-Id: <20240930112121.95324-12-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/platforms/ps3/interrupt.c  |    2 +-
 arch/powerpc/platforms/ps3/repository.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 49871427f599..af3fe9f04f24 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -378,9 +378,9 @@ int ps3_send_event_locally(unsigned int virq)
 
 /**
  * ps3_sb_event_receive_port_setup - Setup a system bus event receive port.
+ * @dev: The system bus device instance.
  * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
  * serviced on.
- * @dev: The system bus device instance.
  * @virq: The assigned Linux virq.
  *
  * An event irq represents a virtual device interrupt.  The interrupt_id
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 1abe33fbe529..b8c030eab138 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -940,7 +940,7 @@ int __init ps3_repository_read_vuart_sysmgr_port(unsigned int *port)
 
 /**
   * ps3_repository_read_boot_dat_info - Get address and size of cell_ext_os_area.
-  * address: lpar address of cell_ext_os_area
+  * @lpar_addr: lpar address of cell_ext_os_area
   * @size: size of cell_ext_os_area
   */
 


