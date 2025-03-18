Return-Path: <linux-kernel+bounces-565974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90017A671AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D31E19A5662
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478C20CCF2;
	Tue, 18 Mar 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDAXeKKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B420CCE5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294448; cv=none; b=ZXdnX0fg6+UVKZGDfoYfVHHHJhSA94hiqswr8DCUvMs1F5qySP8kUxHa+uBHoXSEPETXEPH19IKE6xKkcwtObet+3n5bpmJADtoI72I043S3yM+10Gn/Te3tMUF4G4Z1MiFG3KUw9uyy8m+s3yrXKrmgrXNP9vZTjtQKgEJq6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294448; c=relaxed/simple;
	bh=qZceJnRtvOAv9rMro0CCwHgopDRbxFnO5xByz8l5QYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VdmybVtqhwFuVOpjf6IJtG9zfLoesQtyO8RwjgoAfWRgBVDIkYCenhrzV3tHBdwYLXsa3eRyRqPQ3srjc2j7H7Sa2Zh84qgRWiFqcWt/UyeCVHN302FROPktyyU1ioOtAjIift1Txo+Ur6ItLCFEDwsJaoUOMT+ZR/6U0xMY5bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDAXeKKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B7FC4AF09;
	Tue, 18 Mar 2025 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294447;
	bh=qZceJnRtvOAv9rMro0CCwHgopDRbxFnO5xByz8l5QYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oDAXeKKyx/GcWKE1PYi2a00cQWzBDgZAaLfOy93Pa69FN1H54ugiwAl5+Ja52XHn2
	 k54kM1r/OD7hediKoPE+s1tQKg8xItGlSbLEDrsTqo01eXsJ2Sq+QrGXa24qesl0mF
	 DV6cY2Zyo9Yu2XkQhrfLq39tvHbsgKhPpmPKKE7OKBgKLTzButZ+UJ1IFm3pkJgJ98
	 fXJRwni8G42CHvKUjd6Bcu1aWqvGlgz+FExYZf/zMk+4+4jR0K2vIDYYbf5SlTptVm
	 KBRC9xJE+qSNJbWI2g7Ak0aU4zR1dfosXVq0FOlK2lQ6zMgBNsrFHMpcnKigRUl8RN
	 emCIe2STozCsg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:12 +0100
Subject: [PATCH v3 18/18] nvme-fc: do not reference lsrsp after failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-18-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The lsrsp object is maintained by the LLDD. The lifetime of the lsrsp
object is implicit. Because there is no explicit cleanup/free call into
the LLDD, it is not safe to assume after xml_rsp_fails, that the lsrsp
is still valid. The LLDD could have freed the object already.

With the recent changes how fcloop tracks the resources, this is the
case. Thus don't access lsrsp after xml_rsp_fails.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b9929a5a7f4e3f3a03953379aceb90f0c1a0b561..2c32ba9ee688d7a683bbbf8fc57a5f9b32b2ab8d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1410,9 +1410,8 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 }
 
 static void
-nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
+nvme_fc_xmt_ls_rsp_free(struct nvmefc_ls_rcv_op *lsop)
 {
-	struct nvmefc_ls_rcv_op *lsop = lsrsp->nvme_fc_private;
 	struct nvme_fc_rport *rport = lsop->rport;
 	struct nvme_fc_lport *lport = rport->lport;
 	unsigned long flags;
@@ -1433,6 +1432,14 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	nvme_fc_rport_put(rport);
 }
 
+static void
+nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
+{
+	struct nvmefc_ls_rcv_op *lsop = lsrsp->nvme_fc_private;
+
+	nvme_fc_xmt_ls_rsp_free(lsop);
+}
+
 static void
 nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
 {
@@ -1450,7 +1457,7 @@ nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
 		dev_warn(lport->dev,
 			"LLDD rejected LS RSP xmt: LS %d status %d\n",
 			w0->ls_cmd, ret);
-		nvme_fc_xmt_ls_rsp_done(lsop->lsrsp);
+		nvme_fc_xmt_ls_rsp_free(lsop);
 		return;
 	}
 }

-- 
2.48.1


