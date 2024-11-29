Return-Path: <linux-kernel+bounces-425843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E525C9DEBB9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77290B217EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E114601C;
	Fri, 29 Nov 2024 17:34:03 +0000 (UTC)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A6956446
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732901643; cv=none; b=I3qmQIU01pB18POMR3xmIOXBsW3HLuRknI27TMoq8ALFLm4SZcEzGd+KzD+QMDqZOMvcpa1M6gVqtx5VlaOdHjSOqhoV5bY1Y2Tf2ugvL3lmOF7mRuuM+fpuDzRppVor2mmqZIapLVp0bE5GOpeubDnbTHWge8b0S9c01tkiZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732901643; c=relaxed/simple;
	bh=ZACRuVPg8rkWHNXqYBS8KZV6UUh5fMqzeJS7lSY2nIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwJn5zXf0t27cDGN/yL2dcr/Obd885dVMdrl8gjnDPEhDwBMWmQUdUaj9XzQfUHqq/JKhY6OjhwZIh0eX2BcY07SoNsNleATag1fty22ySSBhz+UQQyx9O39jDDfqZcf0stZci0C7XlgRGXvfde2OnxJkmuAuzzcg7/3cy+dn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	Peter Xu <peterx@redhat.com>,
	Greg Kurz <groug@kaod.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xmon: Use str_yes_no() helper in dump_one_paca()
Date: Fri, 29 Nov 2024 18:33:35 +0100
Message-ID: <20241129173337.57890-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e6cddbb2305f..6c84169b309d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2623,9 +2623,9 @@ static void dump_one_paca(int cpu)
 
 	printf("paca for cpu 0x%x @ %px:\n", cpu, p);
 
-	printf(" %-*s = %s\n", 25, "possible", cpu_possible(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 25, "present", cpu_present(cpu) ? "yes" : "no");
-	printf(" %-*s = %s\n", 25, "online", cpu_online(cpu) ? "yes" : "no");
+	printf(" %-*s = %s\n", 25, "possible", str_yes_no(cpu_possible(cpu)));
+	printf(" %-*s = %s\n", 25, "present", str_yes_no(cpu_present(cpu)));
+	printf(" %-*s = %s\n", 25, "online", str_yes_no(cpu_online(cpu)));
 
 #define DUMP(paca, name, format)				\
 	printf(" %-*s = "format"\t(0x%lx)\n", 25, #name, 18, paca->name, \
-- 
2.47.0


