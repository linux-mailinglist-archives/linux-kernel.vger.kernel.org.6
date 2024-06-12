Return-Path: <linux-kernel+bounces-211642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACC9054CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6841C20F85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C3A17DE0D;
	Wed, 12 Jun 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="hHxbjwxy"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A32F17D8A3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201530; cv=none; b=s1zjJ17M662PwUd3J9/prTPXRH/IewyEmbTMtS5cR6E+z1IxoxROVOyp1yA3EQrkvewOtV2PkiRcdRXIeevhycODvc62R3v7zBKBH5wNakAj/F9EN5iXs//j5//gueC9DjVvONadQCq6LCm7y1Cnts0asYQIDKSF2iKNOy2DSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201530; c=relaxed/simple;
	bh=e9SfW1metR3R0MWFRe7yGcE0JtmhD5pGML2QZDcch80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Bb0VV/NCmfTiWqgXOi1E93Zkcx9eloHzEDLKISnYduOloniucIdm48vUQeh5SUKtxXKQwGApFNjK63Kuo4CGcY8I+Xmyrghh0nUIoIanN2vB8EZ4mSpNnWRIHhT9/EGbh/2xWgnYztMG9S0qVC1FZf6YgrHpUoIrzInLBAopPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=hHxbjwxy; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F806DACB4;
	Wed, 12 Jun 2024 16:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1718201525; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=CawtlzSDLIzCAFolNyvw3t+/DIyp3iWGJk127IQAYQM=;
	b=hHxbjwxyiicmDv4Ay69x8UspKJlWzAvmbt+SEDwDXspfUm0qc2ljxlxH8fcrsf9D17qXcd
	FlRGaKnqqBaGCjI39cQLuUXE+HOVW5umgz8+HfnMYfhuJEmOzoxJTLrDH6X7Bc6LNFuadX
	VFtYp0trfz46WFxej59BpuuGU+KNcCbVkQC6r3dejFoiW6O1Rhnqkj0D1Xw4CDbYx9+R1U
	D2dsmcTupEZuh90xCb5rrG6vzuExTCaFFJOEjj17OxSWqQymDRy+rUDwpvRwWeY4UUtgx+
	Ew1gHPuF0k0BZ8aU2ABX390uTc1rxCDBSiUECikbKen0u5st2nUhnVa3msM1rQ==
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 12 Jun 2024 16:11:59 +0200
Subject: [PATCH] nvmet: always initialize cqe.result
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-nvmet-always-init-v1-1-0c0fd94461f0@suse.de>
X-B4-Tracking: v=1; b=H4sIAK6saWYC/x2MSwqAIBQAryJvnaAi/a4SLSSf9aAsNKwI7560m
 1nMvBAxEEbo2QsBE0XafRFZMZgW42fkZIuDEkqLWiru04YnN+tlnsjJU+Gm063QaB1aKN0R0NH
 9P4cx5w8p7K03YwAAAA==
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.13.0
X-Last-TLS-Session-Version: TLSv1.3

The spec doesn't mandate that the first two double words (aka results)
for the command queue entry need to be set to 0 when they are not
used (not specified). Though, the target implemention returns 0 for TCP
and FC but not for RDMA.

Let's make RDMA behave the same and thus explicitly initializing the
result field. This prevents leaking any data from the stack.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Followup on the prevsious discussion on this topic[1]. I think we should add
this one to avoid transfering random stack values to the host when using RDMA.

[1] https://lore.kernel.org/linux-nvme/20240412061056.GA32319@lst.de/
---
 drivers/nvme/target/core.c             | 1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ---
 drivers/nvme/target/fabrics-cmd.c      | 6 ------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 06f0c587f343..4ff460ba2826 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -957,6 +957,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
 	req->metadata_len = 0;
+	req->cqe->result.u64 = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index d61b8c6ff3b2..cb34d644ed08 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -333,7 +333,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		pr_debug("%s: ctrl %d qid %d nvme status %x error loc %d\n",
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 status, req->error_loc);
-	req->cqe->result.u64 = 0;
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
@@ -516,8 +515,6 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	req->cqe->result.u64 = 0;
-
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
 		nvmet_auth_sq_free(req->sq);
 	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 042b379cbb36..69d77d34bec1 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -226,9 +226,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
@@ -305,9 +302,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));

---
base-commit: 6bfd66808f973cf1bb234e54d0cd51a15bba2996
change-id: 20240612-nvmet-always-init-a794804edfed

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>


