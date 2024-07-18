Return-Path: <linux-kernel+bounces-256377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9B4934D43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D422BB2117F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854513B593;
	Thu, 18 Jul 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Ox3t3J"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC19E78C93
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306049; cv=none; b=PgQJ0aYuSeR1UdltGh4XEYAI4vAxap9Yz4ZpZ3AfWQRbcX+IUOckJRmVVmhzJ3IUdNse1oD0rKslQx+46VhcUMFJpptchxbXLXKi3XIT/OARofpWVtHl6q+zVd7muTpMXOE9bjWc9p1ofWSjSSDzCWa+8CECz4N2h2E9CxEURmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306049; c=relaxed/simple;
	bh=9/PRQnT6m7ZKE4E0lTCWt3wr0JNjTQcZeKQYDcLzk1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDD77CXed2sDHM64muTCESrgL90rvwCdQ0sNYhfpyNxm9+bbkvoiUiS8ybH11ASpRUnjKFVysImMnJm8tBM+6pPDWxTTQ5tJMyAIln3vbsoj2U5Xt9olA04CkP2CAVVRrM5DmqrDUL0NduVLqrHhGvlZPSQDRCpQA6YpIDN336I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Ox3t3J; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc6a017abdso2577015ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721306047; x=1721910847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7RzpzbytVKsMSo/gRdZ+hmuL1xtdjhM/yZEN5JcVuc=;
        b=d0Ox3t3JqoU17ZFg4MYF2zEn4baV7dXnBMu9H9TsrP+PSQupzYPtvalTTblw3UiBWx
         dZh42MyppJPQJdlcR0H7vE9+Rm0ORZju5AqwfaN32oqIYqGS26TdGN5EnayP17q8kQNq
         FnXr3Nb6rdJQGJj3pGzOcz/lwxeQkQL9lU2K0L4uCVWPzPpf9qrVI++mnluSU4GkxByL
         Ggt5HNi2gZb/tKLX5M1zR6TkegEBPZN6WGxP0c4h95q7YvF/BQNGE3vLJfyPqViP5yg5
         TNyLN4OfNjRljcog/hWQq0YvBsPbP2lJVFczizu2cAQwJdZwfmLjtIk4EWrTOl1ViFxX
         4A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721306047; x=1721910847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7RzpzbytVKsMSo/gRdZ+hmuL1xtdjhM/yZEN5JcVuc=;
        b=tDZTq6Oesw7iWpWdovfMShXLApVyQgfIz/uiHq4ZF6cshsh5fGPa5cZftGShPe9Ut6
         CV8ey+iWj2t/XyMsNHMV8WWZw+1wTpRD/CCr+b4wwRuF/Y7ESSkfAGT750+/LxW3Xr4j
         AB+Gqvb4pb+9OPOPfsgskpVPtmNueQWANV8yMKm/de0cxpOkCwQTM8JqQpfg9rK46unB
         2ApGSbm6tGndPEk2Fw2woaZXufoj7Tk7lMepV5SXoOEzoKtskP5HK13w6RTwLocGEt+U
         mt6F0Z/nuWCsoaIufg9ZAtgC8gBi/9zOiE50wBRW58JIYUV+S8ViQSjhV8X68X4by+XU
         nnIA==
X-Gm-Message-State: AOJu0YyZpJCO+Y1VFSQAK91bNRVKi6X6qC41Pw5bywaGp7oqYfnvvibp
	pKYiZOwkodCW0lAEEo5NpoAW750L4TEY54eBmNkIsWUbZngw3oKBulk/kL6j
X-Google-Smtp-Source: AGHT+IF8iR7aWsEDsucKBTzizmCkqxlKKioHWhy2W0os2pqVjNGU3eBKQKB9Ckw6K/tgAIh1LRxIMg==
X-Received: by 2002:a17:903:187:b0:1fb:83c5:cf93 with SMTP id d9443c01a7336-1fc4e1471bamr36631195ad.27.1721306046992;
        Thu, 18 Jul 2024 05:34:06 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fdc9sm92123275ad.52.2024.07.18.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 05:34:06 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Thu, 18 Jul 2024 21:34:04 +0900
Message-Id: <20240718123404.59833-1-aha310510@gmail.com>
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
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af474cc191d0..2088b566d10b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2895,7 +2895,7 @@ static int virtnet_open(struct net_device *dev)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL | __GFP_ZERO))
 				schedule_delayed_work(&vi->refill, 0);
 
 		err = virtnet_enable_queue_pair(vi, i);
--

