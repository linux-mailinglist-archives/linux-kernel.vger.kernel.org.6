Return-Path: <linux-kernel+bounces-312570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6981296984B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5902859C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A0519F418;
	Tue,  3 Sep 2024 09:07:00 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE041C7668;
	Tue,  3 Sep 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354419; cv=none; b=aOw+ctFTxV6gSBgbOQWgVGwgIce8DoGsiXKshC0LsMugk+P9xzJh+0oKuIyghHrmc9Wg+puimJqAxZZaIN6Klf0skrM9mZ6EIpZ4f5LuaAtp3Q0thswYwvWwAaTpKhDNNese8kDePghXi7t88C7+iN+Hv82GLJKMGhB+Af7rJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354419; c=relaxed/simple;
	bh=vo2cM9jaeWckeFgAQvhRLqYW4BeSokYzEi0tKMiKYLs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eYiDhcWhahM6goGJO2hdYQIz5C3djGZQ9uXeki5NczTAoOVTkIDLHT5FNI4r+bntIjaa08aFytjLTUUXApK5iWpNSPdlka2NQG6qCgkytbqAHeo2SdeTjIKh1kv0UaYbdjRvox79l2Wfm3D4lxij3oQ6oDgIUBcdNfT257Ds8qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966d6d19c53d-e1541;
	Tue, 03 Sep 2024 17:06:37 +0800 (CST)
X-RM-TRANSID:2ee966d6d19c53d-e1541
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee666d6d19a36d-de227;
	Tue, 03 Sep 2024 17:06:37 +0800 (CST)
X-RM-TRANSID:2ee666d6d19a36d-de227
From: tangbin <tangbin@cmss.chinamobile.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangbin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ASoC: loongson: fix error release
Date: Tue,  3 Sep 2024 17:06:20 +0800
Message-Id: <20240903090620.6276-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function loongson_card_parse_of(), when get device_node
'codec' failed, the function of_node_put(codec) should not
be invoked, thus fix error release.

Fixes: d24028606e76 ("ASoC: loongson: Add Loongson ASoC Sound Card Support")
Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>
---
 sound/soc/loongson/loongson_card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/loongson/loongson_card.c b/sound/soc/loongson/loongson_card.c
index fae5e9312..2c8dbdba2 100644
--- a/sound/soc/loongson/loongson_card.c
+++ b/sound/soc/loongson/loongson_card.c
@@ -127,8 +127,8 @@ static int loongson_card_parse_of(struct loongson_card_data *data)
 	codec = of_get_child_by_name(dev->of_node, "codec");
 	if (!codec) {
 		dev_err(dev, "audio-codec property missing or invalid\n");
-		ret = -EINVAL;
-		goto err;
+		of_node_put(cpu);
+		return -EINVAL;
 	}
 
 	for (i = 0; i < card->num_links; i++) {
-- 
2.33.0




