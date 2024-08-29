Return-Path: <linux-kernel+bounces-306245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687A963BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80AC8B224CA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4576415C120;
	Thu, 29 Aug 2024 06:47:15 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838E14AD17;
	Thu, 29 Aug 2024 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914034; cv=none; b=NXKomhTIhwsd9CC7G29IoWtMMBSQDiCWxHYm5u5g6uS460nG/OSubH6lFLaim5sdqUS+jkKufbC4/lI/xiQ1PsrQosPU2XcjyDdG3uYlQpDr+l+tlPPujrud4kfaLBnNsf/ZTfvnoTFODzs/bUOxL7ImSC7n2tVOi/bkwD8WpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914034; c=relaxed/simple;
	bh=QxZOgjspyre0glDIFL+XQt9y841jY7bblDybTEVsbaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bW8sQQnjCdNioMij7wf9kQzWC8WJXEvE3NUz/U2wGlT5ya2zjKFllf4COSRyb89yEMOGSZxQH/+lxtLXA41aQZ9zJpwK4iiHhjwjsFIa0l+U5RB5wIYlu5CgFv9gMYQgFKAoHsSv8cn77Efduj5lZpdhLm3HxsTrnC5Lv1tedj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvWt20FfLz20mhH;
	Thu, 29 Aug 2024 14:42:18 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (unknown [7.193.23.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D5E5180019;
	Thu, 29 Aug 2024 14:47:08 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemm600016.china.huawei.com
 (7.193.23.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 29 Aug
 2024 14:47:07 +0800
From: Lin Ruifeng <linruifeng4@huawei.com>
To: <johannes@sipsolutions.net>, <perex@perex.cz>, <tiwai@suse.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] aoa: core: Using helper function for_each_child_of_node()
Date: Thu, 29 Aug 2024 14:33:47 +0800
Message-ID: <20240829063347.69818-1-linruifeng4@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600016.china.huawei.com (7.193.23.20)

Helper function for_each_child_of_node() can iterate
through the DT node, so we don't need to use while loop.

Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
---
 sound/aoa/core/gpio-feature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index 39bb409b27f6..01060f7c3862 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -72,7 +72,7 @@ static struct device_node *get_gpio(char *name,
 		gpio = of_find_node_by_name(NULL, "gpio");
 		if (!gpio)
 			return NULL;
-		while ((np = of_get_next_child(gpio, np))) {
+		for_each_child_of_node(gpio, np) {
 			audio_gpio = of_get_property(np, "audio-gpio", NULL);
 			if (!audio_gpio)
 				continue;
-- 
2.17.1


