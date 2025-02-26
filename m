Return-Path: <linux-kernel+bounces-534699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD31A46A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F321A16C71B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683CD235C1E;
	Wed, 26 Feb 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIpJWPYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D5235BF3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595582; cv=none; b=tI85Zr7QdEf4OQ2m7S9W/eAMXjwoEa39vqhLqXQZd3Pha7uwWIvN16HawL/+IeMTD6g02rd22zdKQlx68ZAwK5UtunYlPCTrvTlNsQT5WhCwOPBAi6KnRDVaPaqdp/5w+vNt8+FWZ6CrTl6C7+ZKaOF2jB530adxeAf6Ljpqm2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595582; c=relaxed/simple;
	bh=rKfUqV+Xi/1+X0Vimi9wbQfzTnlJ+u0a0ho6TF13EkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VYEZ0FYDgo+6TuQ50xyOzzRkG9bJQ6geRaGDYrIht4qK/bcfXA2TZnKO6UIW0f0jWah04i9W3oHTSXUzr2NkjHDUp8cqfCHZzgICSWpSHYtUnnnw7xkAdfnVZeWqEjLOMlnq1cG++uJX54zLrsqRHRTTTft2TnLB0UeoImQm1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIpJWPYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11ECC4CEE8;
	Wed, 26 Feb 2025 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595582;
	bh=rKfUqV+Xi/1+X0Vimi9wbQfzTnlJ+u0a0ho6TF13EkE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dIpJWPYN6CHZZptVdcsD2pZ41EWeSTLFgSyV5iXq5a+ohjP0UR2Rk1VT2JHkX5cvp
	 WvZ2fqvEYZwauwSHi1reMtRwCfTJhVHHeaaESf0y2yn3q8NKibHNshJ1oh9/e/oNYR
	 j+Gq1dpNmoNSQtNieLWOermSpCbqc5F0Qi4udAlkkzEIOSNenPI3SvamNTxJPbRXAY
	 y2AGj/TK0VVtWW5laMlp5k21b6HeBBFEhktE/cUKN7womc5TqlpxbvTg4tiaX6jecM
	 noH5rWDtKvmGq7ZKVo8yjAFQTpZ/13doaNSYTDbYHLbn0ocOmuMybsp64TxvTIk9Mp
	 kohx1p/H6I5rw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:46:02 +0100
Subject: [PATCH 10/11] nvmet-fc: inline nvmet_fc_delete_assoc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-10-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

There is only one user for this helper function, just inline it.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a5f7cb18ac9f49e41626e1c9a031c3cc830af9ba..fcf191aa1c6bf73e7fb84213bbb7eb76a486734f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1077,13 +1077,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	return newhost;
 }
 
-static void
-nvmet_fc_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
-{
-	nvmet_fc_delete_target_assoc(assoc);
-	nvmet_fc_tgt_a_put(assoc);
-}
-
 static void
 nvmet_fc_delete_assoc_work(struct work_struct *work)
 {
@@ -1091,7 +1084,8 @@ nvmet_fc_delete_assoc_work(struct work_struct *work)
 		container_of(work, struct nvmet_fc_tgt_assoc, del_work);
 	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
 
-	nvmet_fc_delete_assoc(assoc);
+	nvmet_fc_delete_target_assoc(assoc);
+	nvmet_fc_tgt_a_put(assoc);
 	nvmet_fc_tgtport_put(tgtport);
 }
 

-- 
2.48.1


