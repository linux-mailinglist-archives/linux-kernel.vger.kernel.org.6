Return-Path: <linux-kernel+bounces-565962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A39A6719C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208EF3B7E40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AC20AF7B;
	Tue, 18 Mar 2025 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4SjNouK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E620AF69
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294420; cv=none; b=LLxNTHZXUjoNxWHeWwL59ULzyXusfehWiMS9Gzylo/2lBayU+VnXGTDde/IwyPpvFAJs6linsqPxzmKF3dpT5NsRr7LLKeOGn0LKCDy16y/bEMCCfmSGKl/8i0iF6HoNjE2+scASwx6dpV7eU9RlQG8nHuEHbZQDeNI3jVehGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294420; c=relaxed/simple;
	bh=/K31wKt7+pzmqy2zsNE8F9f+nDwRIU59/QexgN001CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pF0syCAN81S220sIxX+Fg3muaRbN+JWIeoUI1ev3uTwbOUJzG2tU1nMRQmEXvzU9aPfexmAiOshIArGttdoDOM1zZpufgi0QZXYJHrLotI237HZGVK44L3fGLZEz0UKFH5WF2z+HqRM5F8/d0Z/Mwj8zkWRUMum+QS3Xp59cVMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4SjNouK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135EC4AF0B;
	Tue, 18 Mar 2025 10:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294420;
	bh=/K31wKt7+pzmqy2zsNE8F9f+nDwRIU59/QexgN001CE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z4SjNouKzlzKLJIkXtOclDH4imOlVXyBVWWNpGMpJwA5Un4vtHvPsKZcWEBrshH0q
	 k7ILdTYwnudBf+fecOAmA87d7W4DmIwJs+gQg5Clo2jsQzwObCJkDeWgJwGnpmaC9u
	 Q2ozgKmR2eMrtA+a/LYYikN2yD+B5CjrEV8iY+orCc0Q4K6Jtz0nkQkCHlywG3eKwA
	 Iawcf7QYXkDNcZg2bapOHgoys+4OnZa6xJ3OLlpeiBLeHJ98B1+k2/Fht1iTlqk46X
	 GqCqWkohAjLNl8RQA9rsoGE3meOf4dF4W+4dBXweIRi9Y/BsxqxAUdjGW7NgNaAO5g
	 qPF8t3VTevcYQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:01 +0100
Subject: [PATCH v3 07/18] nvmet-fcloop: update refs on tfcp_req
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-7-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Track the lifetime of the in-flight tfcp_req to ensure
the object is not freed too early.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index cddaa424bb3ff62156cef14c787fdcb33c15d76e..cadf081e3653c641b0afcb0968fc74299ab941d1 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -566,7 +566,8 @@ fcloop_call_host_done(struct nvmefc_fcp_req *fcpreq,
 	}
 
 	/* release original io reference on tgt struct */
-	fcloop_tfcp_req_put(tfcp_req);
+	if (tfcp_req)
+		fcloop_tfcp_req_put(tfcp_req);
 }
 
 static bool drop_fabric_opcode;
@@ -671,6 +672,7 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_tfcp_req_put(tfcp_req);
 		WARN_ON(1);
 		return;
 	}
@@ -958,8 +960,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 
 	spin_lock(&inireq->inilock);
 	tfcp_req = inireq->tfcp_req;
-	if (tfcp_req)
-		fcloop_tfcp_req_get(tfcp_req);
+	if (tfcp_req) {
+		if (!fcloop_tfcp_req_get(tfcp_req))
+			tfcp_req = NULL;
+	}
 	spin_unlock(&inireq->inilock);
 
 	if (!tfcp_req)

-- 
2.48.1


