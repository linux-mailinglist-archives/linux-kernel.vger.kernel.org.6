Return-Path: <linux-kernel+bounces-199270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C88D84A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F21A1C2407A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA2012E1EE;
	Mon,  3 Jun 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW9Xb19P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0073812DDAF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423811; cv=none; b=nnscLVijq+SzOjibgZ5II/R0eZv06/E1TYeIl3uKhKNpfphUz/5ensBPmM9v3GIUCH10QyEmeJ6EfiNZbRGf52HGa4ikuYzFOrx6aZhY3Hdcf7eQGuA8wa/3bUe/f2K6L/Xo2ohdCfUGh0VcuK479+D/YLFHkF3ESQbGRDBqktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423811; c=relaxed/simple;
	bh=oLnbUsQZPTSZJyGgOFY8nDJg8AfY08tVTPvKyraZzn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzdugaASj0dRMi4CWTlPBjwp9wBgGeIZX9h8DOmmxIBCFZDSoQcfEu0bJw+dOnAA0mXAyTVVS5x7ZoN7Rs7t+emnBfFelPnQyAyy+Jl2etIJ3/zEliGwZ7fsbBgZNb0OGYUFRD4U5TRPsumCsiNSzTnRXJFdqKJeia1n/Frp7hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW9Xb19P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E12C2BD10;
	Mon,  3 Jun 2024 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717423809;
	bh=oLnbUsQZPTSZJyGgOFY8nDJg8AfY08tVTPvKyraZzn4=;
	h=From:To:Cc:Subject:Date:From;
	b=RW9Xb19Pt6ajq+uWDsGZDrI7Q+K0ozp1AhOzXoTb7wwv027HRQtV1k/2HFm9ptrKY
	 wqqpMNUtKTj0v8H3+eTyyNuWW4dfpZWOJ2NqqQO4dsVu0Y0hinoEfPIQrOYuCcSHxW
	 8dLLdTNlA7WLg7H58ctmK9Gqewhz7tQExcBUf2e/Vt4yCiGOGv6PglPmXMYTD//D6V
	 qG5C0GUfKibNB1CoyJM3qFDY58qKnRPaPrcnIiqnHrT1u3e3MnyHzwZMj7cIv/r7SW
	 /++mRHyPEbhDSyhXPDCzFqyFbA3djQxirSt/2pHRVzMlMTkhd/wL700yeBiQYn9VZn
	 vZL/qzZIG6Z3g==
From: Borislav Petkov <bp@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Narasimhan V <Narasimhan.V@amd.com>
Subject: [PATCH] x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()
Date: Mon,  3 Jun 2024 16:10:05 +0200
Message-ID: <20240603141005.23261-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

memblock_set_node() warns about using MAX_NUMNODES, see

  e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")

for details.

Reported-by: Narasimhan V <Narasimhan.V@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/mm/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index ce84ba86e69e..b44a3ae51e9a 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -614,9 +614,9 @@ static int __init numa_init(int (*init_func)(void))
 	nodes_clear(node_online_map);
 	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
 	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
-				  MAX_NUMNODES));
+				  NUMA_NO_NODE));
 	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.reserved,
-				  MAX_NUMNODES));
+				  NUMA_NO_NODE));
 	/* In case that parsing SRAT failed. */
 	WARN_ON(memblock_clear_hotplug(0, ULLONG_MAX));
 	numa_reset_distance();
-- 
2.43.0


