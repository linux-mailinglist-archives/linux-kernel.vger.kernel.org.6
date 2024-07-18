Return-Path: <linux-kernel+bounces-256355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B741934CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CD1B21E41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF7137905;
	Thu, 18 Jul 2024 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2U7gy2f"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C944712FB13
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304285; cv=none; b=JqwSVov/2sz7Oc9Zir1C9iworrf0QYQuvqb4tQ/T5AixH5l7T9h/ocHkA9FWMkcOixuJGmyk1JKxGqs1Vre6dqWR+d6CKSbdwdAGKqFE9RVIX6j+IMofgjU6bOshncQwmZge2ZXhf4jCDgeuUsVHnKT6aItmmyDUqFu79vlSM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304285; c=relaxed/simple;
	bh=Lx+yy9Iw767d4BIHylrSib1+7BL5Oh0LwpkDO9BukPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4EQa6LczDgyeGngfAtZ7w6F4OjT0QMZgzcNKJWXyBbit2iBS9IA0o/T6okSsiloMarRxD7drupwt40c4/UmoxOkAn/AYiNUZEs23EmcY//3ZOC/Yk7tuAbM7xJur01JbrG8CXiYFfnWQlBjvR7Smljp5Q0/H04s3H7lBclQf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2U7gy2f; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc424901dbso6675035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721304283; x=1721909083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xJnAZcJFi/7QBpbb2lPd2reHM3PE2XgOmpWH+Y0tPI=;
        b=T2U7gy2fY65Ry7m62ioNWSuDBUdFFcNgMROY/Sqr+WmdQ54oPrY0QmOb8tK0Vzvw/Y
         mnLHqVP85JDcrUfy8iX2vdwn2hNu7tzzyHezLk1USHvw3oT3+2dwUnp0+Bm+PQ/CSma8
         3MkVfWIohKtLkKw2XJyXmMIVgnjRe7RmKtbb6XIVAbnpskMJoWyydQOV9zNsZVUeRG3n
         vHkm4pdTTujX/lLnoUGBId8ARm0x3tTw+MhArs7ehf1VPlLhbkq54MG3hoIFLSGXzGb9
         7hl5wHuoF79I33aVR8N9t12DwAwitSuA3xLid/pd56yy4w+pAmXMJqWTzL3untaPPP4i
         CC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721304283; x=1721909083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xJnAZcJFi/7QBpbb2lPd2reHM3PE2XgOmpWH+Y0tPI=;
        b=oECBOgMx+c7GfKCrkBnBKqjqJkvA+FuFwzAUlv5KYNMEXh/NjYd3ojSDhLV5q7cAiK
         eFBHR/UautUqLv5ToEAQxEkHa+c18xNEqkORJf5nFdDXeC5cv2BZe9l2dwfnoGXYd5p7
         DBD34tgsSDnWzgQ8V+zZOsp4nAO+I1n+5O8G2ZfuNVyJMl6Y/CWhh1kRBgKj9viiUvyM
         +p9B2JFFwebs2YGfwjExwDqa2q0iHPEn7Eng31pRUuoOMmC8Kxyo4wxM5USP3Nf0zYJ0
         g+I4HQEjEyiPfATe670PJ99Zrs8ukMoFfwaMRWvMXtOFtXMqNX3IwVZdM/Sm+X0apyqq
         qDXQ==
X-Gm-Message-State: AOJu0YwMUhpYpk27wziY2Q03nZUsmiiTwTtSWorfGYJM3lszOx+KHWdx
	T2tkLjBXyHSGK8cVTAd8DjxmG3yR7MkUGWhcx/wKxVhRpyQ8f57W
X-Google-Smtp-Source: AGHT+IF3zjoG9QvOXyeZC59ZkKL+h+5406IcCivXZEuwOqSiqH2+9C/ZgpAbqqYOIwe5UVRjdpXa+A==
X-Received: by 2002:a17:902:f64e:b0:1fc:71fb:10d6 with SMTP id d9443c01a7336-1fc71fb1160mr862865ad.6.1721304282938;
        Thu, 18 Jul 2024 05:04:42 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc2b822sm91169705ad.160.2024.07.18.05.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 05:04:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Thu, 18 Jul 2024 21:04:39 +0900
Message-Id: <20240718120439.59661-1-aha310510@gmail.com>
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
+			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL | GFP_ZERO))
 				schedule_delayed_work(&vi->refill, 0);
 
 		err = virtnet_enable_queue_pair(vi, i);
--

