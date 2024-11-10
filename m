Return-Path: <linux-kernel+bounces-403399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B779C351B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89A61F21804
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0A215ADB4;
	Sun, 10 Nov 2024 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DUR+0wlB"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402B158A13
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731278073; cv=none; b=ujx1uVJUMF8qDtd0YXtaZc85YszdobdbzKf/Iann0ioSM+qWC+pih0skZxpjIn5LWHZBSqPyTO+YDqU0F8vWacVfFQmnofnxy6NiceOHUUk6tptzIoBHHbndVrAldAqV2DoyTwRcZVrz0nMK/4mNYh4xzV5QvNjuEHqmWpAs/O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731278073; c=relaxed/simple;
	bh=lMgvd/6Lb6Mv/sN/h/nJ3YyBm4498RljATrzTgtmsAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HquSDplV93rMPt4+tLb0cjANRjGXdTpFMCiGB6WNB3ZIcPuU5R8julzI3pvrJ1AFU0Gip3WZaVHArCfq2sbS14TruvJ5v7kGIsjxTxvU61yL4SdsaZ5tj0z3EtN1AlcVNmtn6jszNDKNpPiik+HuFY1mk48JYEKfRMK2VVb1ETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DUR+0wlB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731278070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GwBh2zyz1I6gYEB9wKU7YYpCisQ6JYb2gFv5nfuGH+U=;
	b=DUR+0wlB0yFBOjR+jEY9pG3cNye6e/AI/Na2o832EQQ8gNorf3MTn2zvaoMeYgR1+rb6XG
	lVr7ChKDIYbJfQHQ561XZDbzbKbHQLuzSS5yso9nhh52k9AO94PUkG/tVO7AdakgckMRDf
	/KmWy8x2THMQOZnXAEzb3AjKZPiQdp0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	open-iscsi@googlegroups.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: Replace zero-length array with flexible array member
Date: Sun, 10 Nov 2024 23:33:24 +0100
Message-ID: <20241110223323.42772-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated zero-length array with a modern flexible array
member in the struct iscsi_bsg_host_vendor_reply.

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use DECLARE_FLEX_ARRAY() as suggested by Gustavo A. R. Silva
- Link to v1: https://lore.kernel.org/r/20241110151749.3311-2-thorsten.blum@linux.dev/
---
 include/scsi/scsi_bsg_iscsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scsi/scsi_bsg_iscsi.h b/include/scsi/scsi_bsg_iscsi.h
index 9b1f0f424a79..a569c35b258d 100644
--- a/include/scsi/scsi_bsg_iscsi.h
+++ b/include/scsi/scsi_bsg_iscsi.h
@@ -59,7 +59,7 @@ struct iscsi_bsg_host_vendor {
  */
 struct iscsi_bsg_host_vendor_reply {
 	/* start of vendor response area */
-	uint32_t vendor_rsp[0];
+	DECLARE_FLEX_ARRAY(uint32_t, vendor_rsp);
 };
 
 
-- 
2.47.0


