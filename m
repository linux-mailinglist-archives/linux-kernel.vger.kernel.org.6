Return-Path: <linux-kernel+bounces-182685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0668C8E75
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 01:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F423283A54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8414039E;
	Fri, 17 May 2024 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ktbVIyFr"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E746F2E64C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715988384; cv=none; b=gyuOLIoYj5yG1/O9J39KQkkwf4CAT2AjPy1E2fDINfRvoODxqH2ZxxPjsKFr9Nk2jVWfAFQkBqJjnni07xwZ/ROqZZ9fXfH53YbnsAwva4fQmtqKvdOQEkIP9dI+B7GHQqsx/3pxjneaTIBSdqPfa8Ul2QbeFaTHM84khNZLTjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715988384; c=relaxed/simple;
	bh=QN6QKj+6b5zWu/0ODXrK+oWfooUCynazaqLMa2pvVc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvUyW78Q6NQGn4+UGN0gA7cabT88qrdSV3YnQurgYUypIP6SmOXGe3sCIdwY90Y5D+tz5jSGrw1EA9FPIuIYlgahou/totaQ0EFXDWoKxGYV5EPpK6ROKCgMpYmNlA4UzfhrpKfBeh1oZi+E89xT+FKoTeToBkv3RK9HPm/AXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ktbVIyFr; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=0u7kgikaSLk5ESRxVAP69RMWkPZcQroGJaOi2Fac3E0=; b=ktbVIyFr59LYhMyF
	huNk9ziHrp5E1T2NhImL1k6eAb2IDhny9GEIZ9d3XH5OSI1GTmPiHY9su17XEhP6dH/5SZjqrVr/F
	8VRNTOZzi94GrGuhzz6ONO6BYlsNqdoqZ3FiMmYv1wMPu9SgFcYNEYnwBSToQ9cLBsWyPUfcC2gfj
	99Ly5tyCC0hMWz1vzQz1WI6wQcIZqCCOA7jnao/pNFZjd7PjvwsQFcu1SqHh7rIxfxO/wrhZK260D
	B6ltUBU80q3NL6XmBWHAmFQpGQRRiOSgzRULeGgZtAz5bA2dZItp76/3vCm2iOcsBNkQbX3tmoeS1
	9+wprLqvXCyjnQykqA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s86xu-001Til-1z;
	Fri, 17 May 2024 23:26:19 +0000
From: linux@treblig.org
To: kherbst@redhat.com,
	lyude@redhat.com
Cc: daniel@ffwll.ch,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/6] drm/nouveau: remove unused struct 'init_exec'
Date: Sat, 18 May 2024 00:26:17 +0100
Message-ID: <20240517232617.230767-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'init_exec' is unused since
commit cb75d97e9c77 ("drm/nouveau: implement devinit subdev, and new
init table parser")
Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/nouveau/nouveau_bios.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bios.c b/drivers/gpu/drm/nouveau/nouveau_bios.c
index 79cfab53f80e..8c3c1f1e01c5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bios.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bios.c
@@ -43,11 +43,6 @@
 #define BIOSLOG(sip, fmt, arg...) NV_DEBUG(sip->dev, fmt, ##arg)
 #define LOG_OLD_VALUE(x)
 
-struct init_exec {
-	bool execute;
-	bool repeat;
-};
-
 static bool nv_cksum(const uint8_t *data, unsigned int length)
 {
 	/*
-- 
2.45.1


