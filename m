Return-Path: <linux-kernel+bounces-565963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEE4A6719B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 818A57A9106
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AC20AF9A;
	Tue, 18 Mar 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXy78qeV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278220967B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294423; cv=none; b=dl1AieMkKFRp07E0xYs7CzX0B4XYeUrRlKoOdtFwr3rbJlVOAmYFKULhw/B4bplBmVCcuxVNFGnwnAkfgT3Gb/xiCfc1wQ2qOzZmgSxtqAj0dYvmzhil8kRfTw5RwPdbAxrSEtJhV01WjpQOUdSfR00RdiiGdgqQhUFwyzy1TBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294423; c=relaxed/simple;
	bh=JTLpMEKu43lVUED42qFb7QDyfoLGefK5QDiEX4OAcCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQDQMLucWMdfXX4kkVipOI5SX4GxCDxscN03WmECj6RLgceK/LioFu9VpS8A2U+Avg9o9uJYBYlrWpFQI9fs8fStmXI/JaDn0UWpdXT3VIxoIwWtwjqv1BoKcBLbkMOig+XFLqoCSR6iup1h+BMZjgHJR2aRbcFUiLKH4XMEeRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXy78qeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE54C4CEDD;
	Tue, 18 Mar 2025 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294422;
	bh=JTLpMEKu43lVUED42qFb7QDyfoLGefK5QDiEX4OAcCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sXy78qeV0HjURROd9BFGrAxVsdc51t3zCXW3oUfrGCkHr1gOQtkHlR0FSrmb1NsVq
	 FPYCZin06m9CFFnFxkPlsqS1058O5HK57MvXBOOsfucwMOA9nFXFKVf7qRLpSFv5Ow
	 SIQbSUDk+Hi8NHZ1REyQ12Gg+anZLTs+aRbTJxOnzVeiPWjslC+Ij0VNKduEjhSREb
	 ZIiIexYEM7GVrcge2yXMB4wRdYur64V8wY7KGlDoxI/y9s4y/fL5Y1NKUbszALQWsP
	 dxjkeAjD5WrnRq9BojwO/iRX4RwU63vbHerm3T74+OIsGtTeRwuUeojlMyph2KBVA1
	 Bli7m3bKjzcsQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 18 Mar 2025 11:40:02 +0100
Subject: [PATCH v3 08/18] nvmet-fcloop: add missing
 fcloop_callback_host_done
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-nvmet-fcloop-v3-8-05fec0fc02f6@kernel.org>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
In-Reply-To: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

Add the missing fcloop_call_host_done calls so that the caller
frees resources when something goes wrong.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index cadf081e3653c641b0afcb0968fc74299ab941d1..de23f0bc5599b6f8dd5c3713dd38c952e6fdda28 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -966,9 +966,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	}
 	spin_unlock(&inireq->inilock);
 
-	if (!tfcp_req)
+	if (!tfcp_req) {
 		/* abort has already been called */
+		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 		return;
+	}
 
 	/* break initiator/target relationship for io */
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
@@ -982,6 +984,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 		WARN_ON(1);
 		return;
 	}

-- 
2.48.1


