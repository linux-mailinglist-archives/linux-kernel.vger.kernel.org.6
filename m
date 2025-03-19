Return-Path: <linux-kernel+bounces-567883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26E3A68BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F583BF6C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760A1254855;
	Wed, 19 Mar 2025 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FAnZR4OS"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AE251788
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383473; cv=none; b=B7buIVvQBCGJms/KkJHrDKbdS3WhzdFWIdXtU2FxQt31+TQtkqr7IrIVuf6apjmAwHx2oyQsyOWMaDmEcRnxowjr8ztp3JAD6bWZjBzLkECteKEevGpmKJzOi1aBG0zOBoU0OVWdZwcu6Kx7lvyaMsgAfItRo8hTnxTQf/aM/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383473; c=relaxed/simple;
	bh=QTqailsonrpbQzmjwOzDl5cAf0C4+SMDAnXr0siyRN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DZvPJFpOfpzImeYviqTmjkWLWBEGtvNJDeRalQjIIaMZ8q8IIJMUJzsB1S/sc4u1+uyYAINrD/4ZsjPhjcNn0jo+5axYghGfmy0xVYxmF0fvAEwMK1nIhyP4whMdb6r2gcI4rkogvkh3nZvnEf+gbhZ6y4gzgNU/jhD4xjk204w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FAnZR4OS; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52JBOPVF315729
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 06:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742383465;
	bh=a0uS0DVRPkHnzbGHlaFhbIr9q0UKNRRLssP4z1+6RRI=;
	h=From:To:CC:Subject:Date;
	b=FAnZR4OSqTw3jH2jEdcdFNryRaRnIAU1BvhGpwMIhtVxcEOhrEXajMXzsZXZ0V0yI
	 UtZSExvCkl/T0PDI/bGQDC+GyaYYlu93yyxNDf3MAtKhsYnlbct3Y/b0xlwweVwEIH
	 +Q1oJMkvRbziSYw3rM7+KFmeY2CXmStPoBWu9GTc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52JBOPhj114206
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 06:24:25 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 06:24:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 06:24:25 -0500
Received: from pratham-Workstation-PC (pratham-workstation-pc.dhcp.ti.com [172.24.227.40])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52JBONLH106746;
	Wed, 19 Mar 2025 06:24:24 -0500
From: T Pratham <t-pratham@ti.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
        Robert Jarzmik <robert.jarzmik@free.fr>
CC: T Pratham <t-pratham@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib: scatterlist: Fix sg_split_phys to preserve original scatterlist offsets
Date: Wed, 19 Mar 2025 16:44:38 +0530
Message-ID: <20250319111437.1969903-1-t-pratham@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The split_sg_phys function was incorrectly setting the offsets of all
scatterlist entries (except the first) to 0. Only the first scatterlist
entry's offset and length needs to be modified to account for the skip.
Setting the rest entries' offsets to 0 could lead to incorrect data
access.

This patch removes the offending code, ensuring that the page offsets
in the input scatterlist are preserved in the output scatterlist.

Fixes: f8bcbe62acd0 ("lib: scatterlist: add sg splitting function")
Signed-off-by: T Pratham <t-pratham@ti.com>
---
 lib/sg_split.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/sg_split.c b/lib/sg_split.c
index 60a0babebf2e..0f89aab5c671 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -88,8 +88,6 @@ static void sg_split_phys(struct sg_splitter *splitters, const int nb_splits)
 			if (!j) {
 				out_sg->offset += split->skip_sg0;
 				out_sg->length -= split->skip_sg0;
-			} else {
-				out_sg->offset = 0;
 			}
 			sg_dma_address(out_sg) = 0;
 			sg_dma_len(out_sg) = 0;
-- 
2.34.1


