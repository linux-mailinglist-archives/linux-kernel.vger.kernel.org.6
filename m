Return-Path: <linux-kernel+bounces-555834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD7A5BD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30373A61AA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0161231A3F;
	Tue, 11 Mar 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND1IwkII"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA722FF42
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687904; cv=none; b=amasS2pha/dh84PAwIUpgUJhTz4uE+WxGMM/8Hw9TKhJKwdfLGcHXLweBaGfgSOptTRqYQyQWzwoZJ/fhnfrEmS45KhNeBrAApzKGy+e4icWvT3dkqDfgGPgaME2q/pxITWpBSmGQNTKBfeNssMkwEfaVlDKsIb8mitEzCn/eik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687904; c=relaxed/simple;
	bh=MDYxwyBzQKrmV0tTE4ueZcBadH+sNzw7R8Ql8WpB9yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cg9ii+ot8J1YKTsot3uQ3ktSaufHJLXGQWMz0uLc/AlGUJmJBfyfVtLmPte4ExDNKLlR8vTf7HfhhpH/lrXfln4kc6dLZFs0IEGY+w8ZiseXDR445Li5cWiyg/p+BWHkwxEn7078IOTOwF4SgCDd0lK4BGmjjsWzIilgDFUCTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND1IwkII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F1BC4CEED;
	Tue, 11 Mar 2025 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687904;
	bh=MDYxwyBzQKrmV0tTE4ueZcBadH+sNzw7R8Ql8WpB9yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ND1IwkIIk0V5C/IPLyWxnqM0wIamp0hbqGWdNmMU/zWC3XXyfZCSr//3pPxmzeWw2
	 6o+NjpxmU33U1QKtqskkwgAMslmL8ABuJ2qtIWYctIkSB9HM+BzV55PiVqjEGUk4Vm
	 fx5Nlq2YPXSOcqENUp0voS5j9fAdqGxFbRcmsAPIIafr1whAoHQKXYHJwFxPbPtQ3K
	 ROS+sv+luyfTaT0QnFB110O0qcglTZNeLiG1f5wy4D1lfLcCD32jOuS8ZfWELF8a6m
	 sAj5oIJUrbaZpY4RPQBxwlAteFZcSnaNGecYciSFp6VkAzy1OYf+/PP7P3fMsbGC2S
	 p5Lvo8jc2Gg+Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:27 +0100
Subject: [PATCH v2 01/15] nvmet-fcloop: remove nport from list on last user
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-1-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The nport object has an association with the rport and lport object,
that means we can only remove an nport object from the global nport_list
after the last user of an rport or lport is gone.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


