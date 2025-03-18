Return-Path: <linux-kernel+bounces-565961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A0A6719D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B635119A3471
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34A20ADE6;
	Tue, 18 Mar 2025 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WdbMf4Jv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76D208981
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294418; cv=none; b=TRNAHnM9YcYUfEl+dhKPtdoc6ggH5gB/yr3SWS8pFn0bvU72doDuf4wmTOVCD7W41Ah4ZYcdAhNigIDvSsk0OdW/b+bMIPCLMnSDyU8MoopemcANrmvBhNpNqt3T75FGdKWaaNg3oxn40WVc9uUnGuVqU+79EbeqV6l+RjtQ43c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294418; c=relaxed/simple;
	bh=RpLuvQFkZ8DvcX0vAWLUD6hAcQKXufgx2o9rvMpsw7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0oeB1HkwhbYe5VQoysio6oE7xTd2YfaaH74YFcKpY9BVAh6ysaAbhIy72j/3ehqRYERqgQGMAJwV95E6da7qBPodw6M1rlkG8v3BOhZ8JATW1ohniw52zfdUL3KqGUIWUJnax0BiFBTRYTU7gbrwcUcTJZag6LpocvHacvenhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WdbMf4Jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A158C4CEF4;
	Tue, 18 Mar 2025 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294417;
	bh=RpLuvQFkZ8DvcX0vAWLUD6hAcQKXufgx2o9rvMpsw7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WdbMf4JvVkLm0K9jkxRzemTsQahyy22UPXJ4X+aFwp6tx/j3DmRAO7HVFcxqZMZ9J
	 rYVH19fybw09AiRU4rwDXerVizpdws3bF1v2KfUBXZ7dF3NvF42cdixJRQP7vJTM5V
	 BX7LOcgnvBugxib6VgSh+F0pqs58o8GepV6EVtzs9uP1nBG0535JahOcXaJAmbceiq
	 rtrfAafzBIHFNfCHBw/mnNgUngzbvvOf0yXYEY6Fup6ARggbpyQeBD9CGHJCoCEgV7
	 WubHktI9+DiR3m6Pt5Vv4RB5fymiToMlt4R/JW7mQs1zUg3MxJ7Z6VuNmPrJZ2SbJI
	 UTaOEblb3Aidw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:00 +0100
Subject: [PATCH v3 06/18] nvmet-fcloop: sync targetport removal
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The nvmet-fc uses references on the targetport to ensure no UAFs
happens. The consequence is that when the targetport is unregistered,
not all resources are freed immediately. Ensure that all activities from
the unregister call have been submitted (deassocication) before
continuing with the shutdown sequence.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 69121a5f0f280936d1b720e9e994d6e5eb9186ff..cddaa424bb3ff62156cef14c787fdcb33c15d76e 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -239,6 +239,7 @@ struct fcloop_nport {
 	struct fcloop_rport *rport;
 	struct fcloop_tport *tport;
 	struct fcloop_lport *lport;
+	struct completion tport_unreg_done;
 	struct list_head nport_list;
 	refcount_t ref;
 	u64 node_name;
@@ -1078,6 +1079,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 	tport->nport->tport = NULL;
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	complete(&tport->nport->tport_unreg_done);
+
 	/* nport ref put: tport */
 	fcloop_nport_put(tport->nport);
 }
@@ -1507,7 +1510,17 @@ __unlink_target_port(struct fcloop_nport *nport)
 static int
 __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
 {
-	return nvmet_fc_unregister_targetport(tport->targetport);
+	int ret;
+
+	init_completion(&nport->tport_unreg_done);
+
+	ret = nvmet_fc_unregister_targetport(tport->targetport);
+	if (ret)
+		return ret;
+
+	wait_for_completion(&nport->tport_unreg_done);
+
+	return 0;
 }
 
 static ssize_t

-- 
2.48.1


