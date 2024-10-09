Return-Path: <linux-kernel+bounces-357852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2719976F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CB2289458
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504A1E2039;
	Wed,  9 Oct 2024 20:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VtZYzH/k"
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E713AA27
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507207; cv=none; b=crPBUelh98rSgl+5v5HakzzMySFfUOH4a3WxqCN/VI9pBQVDArB3uldfNbXAQAiaufGXly0RttzKwg+KAkoaVQZlbKBICmPIGoUBKoPVpMlBE6F+kdMAH4FYbLSBvOplWbXj1XH31t/oL2mLDpDNjcJOBHcwLMqPawuF41kt4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507207; c=relaxed/simple;
	bh=cm4hzRUJo2yX56GidV3TeMZXjhelTRy83ajD48PXCtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcE3dKvbIhEv0KhiwCuKBw94YQKD1P30W5f+WmrJ2WsDfd2+bn+yvFsh1AbopkG83C75xjHGdH7H0NSng/RtDjiEBX58YAi1EA8vnMaTPXFmPXZlWrBsl+bIhJMtRLi87N3I44SRT+fX+obSworNOyR0pzEZcyRdeWky184l/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VtZYzH/k; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ydgIsdEnS6TFnydgIsgFcl; Wed, 09 Oct 2024 22:53:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1728507195;
	bh=dSXhwlffwVEEgQQdtZSnHKoCCDh7Esjjv1zZwlIWnlQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VtZYzH/ktUnAkVuvP2/dZkf5o6rdN6molzRWGUcM1I06J/sjbDZy3q4zRSEQd1hGF
	 Jo44hjLaqqVm3HZHGj8xbrpoYiRm0WIoglg0SjgVWGVAHWYmu5+hfNE7MVa27Q11ga
	 YWviuFyoO60x2e5iOMrMVysUT42fNari0voD8pTOshG6IN2uF5b8h6tciPRAeilotu
	 6cWHUCOvMzGh9SRALWzRIjUvseyxyowbQZi5PwGXHJvDaMVKTDnOehA/mv+kcnjwrf
	 BFAuobpZvFm4YaXXk/i3KjSepdB60Kh1tKvVQrnPdviq9zlxvECxWB6f07Skl8pZfI
	 Bzry3ETglCjOA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 09 Oct 2024 22:53:15 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] rpmb: Remove usage of the deprecated ida_simple_xx() API
Date: Wed,  9 Oct 2024 22:53:05 +0200
Message-ID: <df8bfbe2a603c596566a4f967e37d10d208bbc3f.1728507153.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The ida_simple_get()/ida_simple_remove() API was close to be removed (see
[1]). A usage has been re-introduced with this new driver :(

[1]: https://lore.kernel.org/all/cover.1722853349.git.christophe.jaillet@wanadoo.fr/
---
 drivers/misc/rpmb-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/rpmb-core.c b/drivers/misc/rpmb-core.c
index bc68cde1a8bf..ad1b5c1a37fa 100644
--- a/drivers/misc/rpmb-core.c
+++ b/drivers/misc/rpmb-core.c
@@ -64,7 +64,7 @@ static void rpmb_dev_release(struct device *dev)
 	struct rpmb_dev *rdev = to_rpmb_dev(dev);
 
 	mutex_lock(&rpmb_mutex);
-	ida_simple_remove(&rpmb_ida, rdev->id);
+	ida_free(&rpmb_ida, rdev->id);
 	mutex_unlock(&rpmb_mutex);
 	kfree(rdev->descr.dev_id);
 	kfree(rdev);
@@ -176,7 +176,7 @@ struct rpmb_dev *rpmb_dev_register(struct device *dev,
 	}
 
 	mutex_lock(&rpmb_mutex);
-	ret = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&rpmb_ida, GFP_KERNEL);
 	mutex_unlock(&rpmb_mutex);
 	if (ret < 0)
 		goto err_free_dev_id;
-- 
2.46.2


