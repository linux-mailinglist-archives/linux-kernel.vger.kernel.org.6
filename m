Return-Path: <linux-kernel+bounces-555842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB1CA5BD57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A158A7A7485
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538CD23770D;
	Tue, 11 Mar 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU6a9bF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F12376E2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687921; cv=none; b=MpCDf97OgUyuxkijj6uCRH1MFboiwVwg2cJvx6WPLlEWovEmkxycY5/azbZ6x8a1Bmrr21H7zfsPfFYQ6zxjj/Vj7oaWeGNk4Q5mIeYibu3M/rC2AL3kI1ogP5RWd8l2dU2Bd6RKQPh+1H4ehpXifNxY3jCJk74dfp5YThHtE6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687921; c=relaxed/simple;
	bh=Mkhlppx0FsVphIwJbAtHmS+qw0+FM0F2IkB19SZNYoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTERe+ocCwljzlb5yq2Zuzs965RxOqjoB2hQc8oG/vtzBIOKGgPosm96rr2yznAlJfOw3iMXvSx1yyody4e7uwKULaPgh2yRWvZm0VcXQ3rROsPSc/Aiy1ltz+xfDewOOvHtzfrN98mmePKpLfXe6s93mROTELiABM1m3hsVOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU6a9bF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FF6C4CEEB;
	Tue, 11 Mar 2025 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687921;
	bh=Mkhlppx0FsVphIwJbAtHmS+qw0+FM0F2IkB19SZNYoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LU6a9bF04DUMcwQHC9ppkDQ0WpF6f8jtS4aiIbCejVEtC93HoTkXHQwOoAVc7kN2t
	 bFms3o2SGkc1vFtJV72wDXS2+yfwzvMGNVsXYofLvd4m3cbsFwF4+urQqeUaUmj7fq
	 qpjclOXyTlztwO18/ZSAScr1PKijOqDRj0tk7asxwkd4JMc9wYhFPOaaNEIp9DN9Vv
	 lzr4zYyA1a3WS3TuU3uxZPsZQfaEGYwy/Hwh4Zbzd/cjlaPjDMiKGMiHLjUnH1CL3h
	 MwYjZ2Twbl1wkLlvkXc4p9SBS2LbONYhjr9+hdqrpIERZcXL3MqIOKuEl1HETG9A0v
	 daja4sz5T1Vyg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:34 +0100
Subject: [PATCH v2 08/15] nvmet-fcloop: add missing
 fcloop_callback_host_done
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-8-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
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
index 4ba75f7f51e0bd95ab806b6e82452e75593ff0cf..e6d9474f72c8c9f17b544e4d63039fd33f820db6 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -969,9 +969,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
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
@@ -985,6 +987,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 		WARN_ON(1);
 		return;
 	}

-- 
2.48.1


