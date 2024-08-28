Return-Path: <linux-kernel+bounces-304186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE15961B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B16285030
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0B381AD;
	Wed, 28 Aug 2024 01:35:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38317BCE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808933; cv=none; b=WPOotbXFuzHrqkU+dwcIIf5wBd4g5lI0XJJiT8m+BcgFc6CPY07Vlcu232nyoK/LmyiAtk/Y4GM1ib+Fev/u1erzm7ysbwXiBO6IRyPCtLflqtew95rNtKU2dWhMj0VRqX/PYWVxZlkdCCB82nTe43Fc6zg3S5M9YCFyeqm6ass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808933; c=relaxed/simple;
	bh=jlgllz+6hmWfSJuJZTb5WNZ8bGsuyeZXh2mvP4JxsrQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AL2k/eJK6kzvls32v+m8uVS3Wryn+ZJTyxkZJo6XkaTWGGlJXAOYNUlD/dnK14rgnJ7y1D/s39/qcQAVmyfgys+CaXuipB9IYjHiilpxiWPspko+5BqZCu7XKX5L2z4HHu1XL09FgmBTF29kzSyJqfJBA72hIImanJ8SFM86FYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d5101012eso71307935ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724808931; x=1725413731;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRQQyo3Da2kERF9nfV7a82LTxTAXYagzMvTQap7Ko4s=;
        b=fCtGi06bcsYsXEynDsjbq6CmjLQ0gdZ/o14SI1Vpy88J9g/G1QFRob38Aae4SLWF+w
         iGH/vQOi8PuvrWdgQluMIVA+I3p20TqiCJnzhdy6Zh1E3CJ1moKnCgNsX2Oqm+1/QTQv
         yw5iw38BtRigP/QOexGN7wHUoXvirmrjx8yCnh2AyaDssheAc6f/sbgdcOqcivKb59Gq
         oBQDJDqA3KAG2gGpy5Rhq3IwbO/2vO8S5Ofsq5RC4hI9NeZ3jLbEnWRwjglQXmCCl1t+
         jZSoDmAj73IvTI4NOOjHO83EG5YdeDyb2wBq6uOVa3TzAep3/hK5YCoMqf8h+pSsbTYD
         973g==
X-Gm-Message-State: AOJu0Yy3Ceknu31VRFCtwM3jioWVwN8zb7tOImjYZnvXZA+v/Y20QqHv
	fpETY+M/zxUb1vb5rsQugYAi15qCJW1IEtDRt4dqGvzLVg81CL/KEc1TuubOAvygKCMAbLkUTQL
	FHpqZCv380GLLM4w5m1QghibaLmfRazaIP4zvO1nA+HWXu8kdsPNb1ZQ=
X-Google-Smtp-Source: AGHT+IEGET+yLX02pgNAAGP5db8gTMloGheY73bV7ylJ7cf/aRy+jZwWiw9tk7t7TbWczV4lMUaq6Mh0oiEZjplRbXZ/UzTu62ZE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8e:b0:39d:637f:97cf with SMTP id
 e9e14a558f8ab-39f325ed353mr532285ab.1.1724808931296; Tue, 27 Aug 2024
 18:35:31 -0700 (PDT)
Date: Tue, 27 Aug 2024 18:35:31 -0700
In-Reply-To: <00000000000094740b0620b32b4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7dc870620b45f8f@google.com>
Subject: Re: [syzbot] general protection fault in phy_start_cable_test_tdr
From: syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in phy_start_cable_test_tdr
Author: djahchankoike@gmail.com

#syz test

In ethnl_act_cable_test_tdr, phydev is tested for the condition of being
null or an error by checking IS_ERR_OR_NULL, however the result is being
negated and lets a null phydev go through. Simply removing the logical
NOT on the conditional suffices.
---
 net/ethtool/cabletest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index d365ad5f5434..f25da884b3dd 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -346,7 +346,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	phydev = ethnl_req_get_phydev(&req_info,
 				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
 				      info->extack);
-	if (!IS_ERR_OR_NULL(phydev)) {
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}
-- 
2.43.0


