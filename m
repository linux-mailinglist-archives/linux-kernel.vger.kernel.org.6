Return-Path: <linux-kernel+bounces-362738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFD199B8CE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0371F2166D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4661C13CA8A;
	Sun, 13 Oct 2024 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X4wTqUy+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E25F13B5AF
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728809144; cv=none; b=Uthb1m5AmxZaWC4E5O3zLHAv9/m62MNjk1YcQ1PEBc6A7KLPMk/oC1wHGgCVGHFBi6c7KdihJQi4kIKNM/YAo0Hs5lOjSGevBGZpCXTHQho1nUgSEZJa1zciI15JkFG0Hl91GXbeqZQkIBRLuupvGOz6E72/ZGVEFpQUvXqIcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728809144; c=relaxed/simple;
	bh=7wga7BLx8JWrnFajc2dhp1MguSKadTRPOW8I9HrD7NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAdQMuQglkZMGGdtcHES/F9tYIiCY//Jb1P4SE9MQaD1Zvk/7Vzy1rfINluc2omk7n1LxJZxE1vRoVm0ZXTzX/B5vHFE5/LGAlKZVjH969Rq/Dgs6nUtrEAdkch97CXrzA9kRM7zfRSsp+rO8Sso2vzDpfkhXP352mtaiiXJsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=X4wTqUy+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 07369A06;
	Sun, 13 Oct 2024 10:43:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1728809041;
	bh=7wga7BLx8JWrnFajc2dhp1MguSKadTRPOW8I9HrD7NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4wTqUy+gaf3umh1+aZFJWSmJa/NJBlwebPbB9sqXclPhJphjZc/LCgArzyetLJtu
	 9HygrIJanehRaYpSxPm7yNx1V7rJ+pHJe5SpM4v57V5T5IkkUB9TJzMzF4jTqub2Tp
	 vmYW7pO+a4MHdhcWtE/2afzW+i5UAeAU8A5aQGnk=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/2] staging: vchiq_arm: Use devm_kzalloc for mgmt
Date: Sun, 13 Oct 2024 14:15:29 +0530
Message-ID: <20241013084529.377488-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241013084529.377488-1-umang.jain@ideasonboard.com>
References: <20241013084529.377488-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index e780ed714a14..334fb7037766 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1345,7 +1345,7 @@ static int vchiq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	mgmt = kzalloc(sizeof(*mgmt), GFP_KERNEL);
+	mgmt = devm_kzalloc(&pdev->dev, sizeof(*mgmt), GFP_KERNEL);
 	if (!mgmt)
 		return -ENOMEM;
 
@@ -1403,8 +1403,6 @@ static void vchiq_remove(struct platform_device *pdev)
 
 	arm_state = vchiq_platform_get_arm_state(&mgmt->state);
 	kthread_stop(arm_state->ka_thread);
-
-	kfree(mgmt);
 }
 
 static struct platform_driver vchiq_driver = {
-- 
2.45.2


