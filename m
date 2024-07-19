Return-Path: <linux-kernel+bounces-257501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9E4937AE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795892816EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9861474D4;
	Fri, 19 Jul 2024 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQlz6Z6s"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675941465A3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721406165; cv=none; b=iloJTI2lCwFar3C+uMD3rfyxLDZwpz7uI0njoDeIyH2gNMyJaHfBjcRHeimPfZNf/VMLrgatTesd3vYxlLW00O0ken/WkGxEvCCZdOR/6rReJZoC0fre6QmTKvRkB02fa/G5E1BBWsd1D4UHDLr04eZxnvhnZJidDatLS/OHCPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721406165; c=relaxed/simple;
	bh=PeaGEvjgw6Z3ctImzlglVehYpiYc5zC/ZpWjjZmuwXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6BMeiG52DQYFJzZ2UQse2wYcQZdBuhJFCFiiyPGruQ9wC5NwA3xsIHryH0dGmtr2Z+kgD6c61R74CTtTfhqdutctZGVllB7TVzhn5NU3AdGeglb3Y9ER3G93ft0ulEtjlkVQW4SJv7cVcLR9x0d5jOa2L3lXI3L2oa0i1Ddcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQlz6Z6s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70cec0ede71so670095b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721406164; x=1722010964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojLSUO7T0NFoG3eG+MQ2BRYGZLUkKSxckUAxanepSe8=;
        b=jQlz6Z6soShvuFvGb+elE1hn7jADFdF72VGJzSbLIMRZ7ANHyxLHuCCuWqIk4/YbGj
         KI6P2qA4LPXDRiLBFQWlwnog+KJTQiYAw/yUnV8v1LVyitufH/YJCRjR4TjyRaoK2X3M
         6AZDwBAexrsT1o0vzOHTm9uHiFcvnoskYGrkyOEAgD7uTxkfS8r8tbsG+0auqOI4gBnY
         cS8K7tGBcsDdRVBK6HqDd3NSGGVkKgdokPGY1/+zmkIU00HgqHjir7emcAi6DMS5+dI6
         O7Ri3l2G/ARxG5Knx34P1SgB0cq2VhnZmaU18OjjVsqoYBDIb91vIdTirAUM9KOT7dXw
         cWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721406164; x=1722010964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojLSUO7T0NFoG3eG+MQ2BRYGZLUkKSxckUAxanepSe8=;
        b=EBmSfoGRA9r0wDKUxr+yx23Zj8nGVJFpNQR1M1q8oVD1n1tjzOerAbTLl/dMILMrjN
         SWOHEs5if8zLkiqg9GRMs7sQWCGPooiJFuQUSO8hp+QPnzlcLRY4K2k33tkkdsR3ozqH
         3vC8j3wbMJO7JsHy8YcqHy/DQ5Itc5gG7fVa3S5l5mQ18TEZHBKnxIvjaN5s75dqSxNl
         58jy6tpNCVm9P2z/pUQSfbEI2x3iNEAAZaLpm293+KLdHdawNe3cHiuSPYNciDhZ9NhH
         8SamjUnndVSXfZt7Pao8Qn3RIIy+k2Ogn+H3m7WQ/Swgm86J56JeXf31Yoa9lqIH5Po2
         bp+Q==
X-Gm-Message-State: AOJu0Yyful2ab0EXE2fR33+efIKjTFAGYkKmnnsPWAXykmde3DfwVQH+
	kfON2Hy3JeL3AQHXIUo/ud6Rjo8WYdwhz5gYzzszWFGBkfq+f3kN0fiQLm21
X-Google-Smtp-Source: AGHT+IG+s9+mhx6YFV3OoUNsoax4WHZSrIn8fJL0T3txwsndMCaf3K92Zd/oBED8lvOrMUUCBSBxJg==
X-Received: by 2002:a05:6a00:1943:b0:705:9992:e7f2 with SMTP id d2e1a72fcca58-70d086a1293mr657157b3a.12.1721406163205;
        Fri, 19 Jul 2024 09:22:43 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff4b762fsm1380667b3a.74.2024.07.19.09.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 09:22:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Sat, 20 Jul 2024 01:22:38 +0900
Message-Id: <20240719162238.71387-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
References: <0000000000004a86bf0616571fc7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af474cc191d0..1ee2dff625dd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2258,6 +2258,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 
 	if (unlikely(!curr_skb))
 		goto err_skb;
+	printk(KERN_INFO "num_buf = %d\n", num_buf);
 	while (--num_buf) {
 		buf = virtnet_rq_get_buf(rq, &len, &ctx);
 		if (unlikely(!buf)) {
--

