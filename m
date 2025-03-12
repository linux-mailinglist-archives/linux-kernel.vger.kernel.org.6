Return-Path: <linux-kernel+bounces-557332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A04A5D775
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A0189EF19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD191F4285;
	Wed, 12 Mar 2025 07:40:38 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457041F4189
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765238; cv=none; b=Jmh7BpEIYubrYwlGgY1XqvMAvdO91I7fObNqmwlWHGnrkBD4gGHRex4kcyY5kJbxgWZbVAMqTLTBQsHHDhkYXCFd0XAiTZ9eY01g9tHipqNEmeEMiXNGin5qck8C+1/dqXT8BQEVwU/Rcrkxb1r7oZZ4Dy0pfwLLJHjFPiGYiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765238; c=relaxed/simple;
	bh=I8VeSuVWU7hBG97/XrhJeDb8Qe+2PoDcl4Ry8eqIDqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=llLLSmId1nqrAiO3HUb161NkZ79TiRewo0UlEKXJ4YtQgAsZ61hYHCwk6+y/GCj3PnGT+XW1LvpUpoTZ0UfayUP07UmelS04UQ8UqTFR6mA+ekqc3270xj06nRu4cVsPegm1K2ZGyIbiuu4IXn+rGyd9cquQ6yzp8sMzeN4Ef+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowABnbW1xOtFn42F9FA--.41781S2;
	Wed, 12 Mar 2025 15:40:33 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: mporter@kernel.crashing.org,
	alex.bou9@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] rapidio/rio_cm: remove redundant 'flush_workqueue()' calls
Date: Wed, 12 Mar 2025 15:40:21 +0800
Message-Id: <20250312074021.1430114-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnbW1xOtFn42F9FA--.41781S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1xZFy7tr1DuryrtFyxZrb_yoW3Cwc_uF
	W3JFZ7G3yDta1vkw1UXr1rXFZ2vaykZF1FvFWrKF98KryUZw1Fvr4DZr4kuw4UZw15GFnr
	u34kX34UZrnrCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUS38nUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- flush_workqueue(E);
  destroy_workqueue(E);

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/rapidio/rio_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index 9135227301c8..c5662c6c52fd 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2196,7 +2196,6 @@ static void riocm_remove_mport(struct device *dev)
 	if (!found)
 		return;
 
-	flush_workqueue(cm->rx_wq);
 	destroy_workqueue(cm->rx_wq);
 
 	/* Release channels bound to this mport */
-- 
2.25.1


