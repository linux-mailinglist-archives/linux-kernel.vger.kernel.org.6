Return-Path: <linux-kernel+bounces-534690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4595CA46A02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630083A418D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F6B21A92F;
	Wed, 26 Feb 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGEMDyIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FC23535E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595560; cv=none; b=I7oOLdvZvF6ndB0G+nOlR9l1AlBmp3Ypgnz9MtD0mrKn45nIySMVwynUOF+8VrV0rZOQEyCOpO24HbGjNT3grwoW4XVvzqNTqX2EJoW+n4qvmwVn2a/3khsbYwResY+Wn3Q6iogE9FfzWYs4RiZoRgoEBD5zrODoF1GInZcnyvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595560; c=relaxed/simple;
	bh=Kc4e83KgunYQeubPAAe08urkDG6fAFT7j2kclg3zHWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFHjoGpo+2TTUFPuTCCtuFZSSwA0NXXtNV2j8RPH2YS7Hi6+QlXm1qYUJwzyUsBKScKzkjjXKnXX6BV95A+/eLlcsi0lde+3ka5fQaysK/+7z6ExhwMaeCPAY30TzaOdCMzYkW5euax399FkwHfR+x7MxRfKc/iidLzYZFkBFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGEMDyIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BA2C4CEE9;
	Wed, 26 Feb 2025 18:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595559;
	bh=Kc4e83KgunYQeubPAAe08urkDG6fAFT7j2kclg3zHWg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eGEMDyIZtQQ7R0NoksWK/rVAa1ueZlaZXWjk0D2OqfnYfobPXyWares5WRQs0LwaP
	 xbwFkJE0B/8UHMx7/nrtOfBQCfXRm/klF66DlNKAH3z4m6gUbN/0X/yyAQsc0YTsOP
	 8hQO/9uQoHDVrohmqojwC25EwO6LR2e0Rm0AI7Aiw6BQ4EOq60iPAM4Y9zUryZ9Swi
	 1E2i+Piv6aWPqL/Kcy9UJ+tcqGrOg76vYxCTyJgILNhHjfae55vwdXotsq8bm1JBsF
	 D0b9z1vDeA/YMDW7M9nJl2thHuQvY4mglFnnQzdpPdvZyALGblOL01cYlPdcjBbRoY
	 BuQQaMKmJLwVg==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 26 Feb 2025 19:45:53 +0100
Subject: [PATCH 01/11] nvmet-fcloop: remove nport from list on last user
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-nvmet-fcloop-v1-1-c0bd83d43e6a@kernel.org>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
In-Reply-To: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The nport object has an association with the rport and lport object,
that means we can only remove an nport object from the global nport_list
after the last user of an rport or lport is gone.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index e1abb27927ff74c9c55ddefd9581aab18bf3b00f..5493677a948d34391c7c08055dfefd91cc3ff33f 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -1005,6 +1005,11 @@ fcloop_nport_free(struct kref *ref)
 {
 	struct fcloop_nport *nport =
 		container_of(ref, struct fcloop_nport, ref);
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&nport->nport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
 
 	kfree(nport);
 }
@@ -1363,8 +1368,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
 
-	list_del(&nport->nport_list);
-
 	return rport;
 }
 

-- 
2.48.1


