Return-Path: <linux-kernel+bounces-291859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BDA95681E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3443E2840B6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5E1607A4;
	Mon, 19 Aug 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Uhqe6piA"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DE156F5F;
	Mon, 19 Aug 2024 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062762; cv=none; b=bBs3uD2Xblp/+1ozm8KUFKN4TsSHsd7OXG/TtL0eB7OQwvm2+EoKX8l/kaFmbR7nxRhub3+k1cIT/VG55UKbPTDajPNLHeK/93SLyQm3zTr/v51gP9XsDHSSgAnsYRFTPLuvvj96h1dIRz741kDE1El8igv3X4Wkh0iTUvdba+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062762; c=relaxed/simple;
	bh=Q62Oyv03OgPbwTGMho6j6YX833MBxT9dLfA6Gf490mY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dl3/Rfzz/qva2oqqpw0Ly1Ava6ON6+lNZ6aLbFxXlTzWGNUFFZ/x9ONTmFDWHZQxa5z8Zki0l8dvtQD9eQoMreNDoS+BD04uAwX0pA+C2UmeWq0yloQABL9Fl2rSC9WCtb/F9PKmNmJuDDIKTsJLVYJFZ6hBSrxfphvTrHf5O5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Uhqe6piA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724062758;
	bh=LK7wkpPSnBuGzhxGUxSmpc4/F155DFfTozWzyWzCmxc=;
	h=From:To:Cc:Subject:Date:From;
	b=Uhqe6piAwiCldj5DGb+CeWuX9vI7vJvQqWj48r0RhE2ynRo1eZhssPJv3YmzHI3JR
	 nIXVImJBw3kRF8O7lUQ5CaIJ0jAHAHX5BI+b9n07DRIdKJB/tTjk3PATmDl2Ojd0c3
	 Ddy1mrw6xGaO5TCK4rEDr9Wde1y+DUBw6DqnnoBOoLkWE51ThGsK9xDyCrVXY5j9g3
	 /6KkZibg0T2v8gkwb2P4cQNY132/htHQfSkLLdp/MVdxS4RAStO2NcJ2pmaB9IuSOn
	 PPc/BcXP3Bd5tC1lhfWsZKFJ/+2hrn5RAoPj4AMU2MB46vlOP2q4jIVlZQ6CaZYnID
	 KFupb+Oymw10A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WnT9203KRz4w2N;
	Mon, 19 Aug 2024 20:19:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	<linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<hch@lst.de>,
	linux-ppc@kolla.no,
	vidra@ufal.mff.cuni.cz
Subject: [RFC PATCH] ata: pata_macio: Use WARN instead of BUG
Date: Mon, 19 Aug 2024 20:19:13 +1000
Message-ID: <20240819101913.489513-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The overflow/underflow conditions in pata_macio_qc_prep() should never
happen. But if they do there's no need to kill the system entirely, a
WARN and failing the IO request should be sufficient and might allow the
system to keep running.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/ata/pata_macio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Not sure if AC_ERR_OTHER is the right error code to use?

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index eaffa510de49..552e3ac0d391 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -554,7 +554,8 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 
 		while (sg_len) {
 			/* table overflow should never happen */
-			BUG_ON (pi++ >= MAX_DCMDS);
+			if (WARN_ON_ONCE(pi >= MAX_DCMDS))
+				return AC_ERR_OTHER;
 
 			len = (sg_len < MAX_DBDMA_SEG) ? sg_len : MAX_DBDMA_SEG;
 			table->command = cpu_to_le16(write ? OUTPUT_MORE: INPUT_MORE);
@@ -566,11 +567,13 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 			addr += len;
 			sg_len -= len;
 			++table;
+			++pi;
 		}
 	}
 
 	/* Should never happen according to Tejun */
-	BUG_ON(!pi);
+	if (WARN_ON_ONCE(!pi))
+		return AC_ERR_OTHER;
 
 	/* Convert the last command to an input/output */
 	table--;
-- 
2.46.0


