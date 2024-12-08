Return-Path: <linux-kernel+bounces-436316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0764D9E844A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95D618849F2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA291384BF;
	Sun,  8 Dec 2024 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djR/T4vW"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D801B7F4
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 08:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733647897; cv=none; b=LIes5X4ihbwZ993wKvbVPw47cipy3r4szfS/ww/UkLm5FTIAnm0Y3Nw5bAQyhNwI/fvWl3N3Ybj0yoF4XJeyf+GkCgPAnU2AL+8qTHG32AdGs3ZZZ1dNBqvUu8HE8qisvEsgvIfhJHHvoB3OxIn1MlUo+b4sdL7Q65HDa7rX4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733647897; c=relaxed/simple;
	bh=Avpt0DavYQhK37MRViyLzXclUmDDOhpjQ4RwJEJrV1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8pD2v4Ivqnj82d9D75jS0USGeg/ewyBmkazLDVe4CFL9zCsLWvYUB3NMjRMUf5L69H1hEj0WhWnaqJqlPNDjRiC4C6CcwxguO4yTguw79xU25aIB5qiRZR4GjUlaLJqSDt56N5BaSGxOpc+NE1mk0+dH7f57QcVzo3oudCyjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djR/T4vW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d8f99cb0d9so8179616d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 00:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733647895; x=1734252695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVvqWdbxf/H6jRAhod1WVWJ8TNzuw0kAnIVXqhdFydo=;
        b=djR/T4vWoso1y859NTYNTJgi/LkuE5/dk9mkVAtBhQ6D2Mi2vj9u7130e8BqQcd8T0
         naz44ApPbUyc4Yia98B++RqTCwh4CYcfJyWbtl+Is1YdJipxAhqTPh2FUVVbQVZrRRar
         HJTGloM+0yLRVOZfRpS8fz0B/bqW2rBlp2q0sWARAOG/qScBAYZULy0ix/IUz4rBNnJL
         uRMWsgFopL6olrzi69i5sItkZad6OtvuklzqMNAZsYKv4f74SJns7qFKbe1vc5VbgyYU
         3fHLVCftBcqgLW5CCxRdTJc72ifzHv5g9F4Gh69Vfptfv9JGyVMaSNhJjF50XDX4aa2R
         27iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733647895; x=1734252695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVvqWdbxf/H6jRAhod1WVWJ8TNzuw0kAnIVXqhdFydo=;
        b=aL9RYFMZxgayleraxfNdSnPYNpjWgEmmvHPfQ04vc/UbhNdDBZ81gLvwdjIQU6XJsP
         jKSRFgISzEZ2qYmHViE0ssAx4/EOTGbqoSCvO+umcT7IQNporUhTUuvCGhhy8V4As5kE
         ELJATpGn/5Bl8bT5iZ7MdQa4ytxrquz3yLkW2yT0N6hqPERWUcEnKNZ/lni1ZDeZJqR3
         l8iRUVaT791bK1b8/02hnnotSkRSPlXWLoXU9IB9kUlsqPG+O9B05ijUKvX0eY1UcJDI
         vtVEkDaXLzOuEpytBNJQvz7SpEfwRJXj7Z+qLlICDoq/soLXefstKAIHV7pW9yPDDyoW
         Z9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyLNY1IiP6qcNADOCBu+HVy6TwdRvWaBPEEqsmuhPGglezTUxP/EXjlYK0ChlXVWnFQAaj42QoWXZJY0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CcUu1XnqDtmVfxjOiIc2uRWXWIsoaEX5j9uNLt1f5XITAcS4
	0XqrQvHmScmQZJBwz4uyhrggKk48Wc62+95QLQnOUBjAcpP6lep5
X-Gm-Gg: ASbGnctoYFUNzDWwz5k1anZ858kwXR4zzcchKHNk+KsIeSgA1b2OGCYBcVMbZFOoWsX
	m/H9+MxtYcAN5vvOVA7lKYV/e8o52+bVzkJBDUXD1iFQ5hn1CKIgUGQIPBPun00vsUM4R5IFaEr
	XBazG0U5oixLWvY9qz2OyGA+A+O2kcL+7y8DjETGw7d3SZ2RyaWVwwkSHQtFYzjGmKKlSIFp+e5
	z+CWUQHo5bJH70yGeQPIq4mHOfQN2HO+u+MSgZ3yYuzUAvDzLDqpkV5X3XCA7O2o5WHfCIukSXU
	eNrq/pSx1Rjdo1m4kz5Uu/JnNOe2
X-Google-Smtp-Source: AGHT+IGKXpOFhEG+cldwUV3LOiwRTsB7qVtq7s8BEE3ykr2xumtKNi/IcShLrgQaeTaZypL/IOTtOg==
X-Received: by 2002:ad4:5ae5:0:b0:6d8:a188:369a with SMTP id 6a1803df08f44-6d8e72512camr159088336d6.48.1733647894874;
        Sun, 08 Dec 2024 00:51:34 -0800 (PST)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6d8da66db6fsm36966536d6.10.2024.12.08.00.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 00:51:34 -0800 (PST)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: syzkaller-bugs@googlegroups.com,
	syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [[PATCH] MTD: fix slab-use-after-free due to dangling pointer in notifier chain]  MTD: fix slab-use-after-free due to dangling pointer in notifier chain
Date: Sun,  8 Dec 2024 03:44:38 -0500
Message-ID: <20241208085121.53415-1-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When attaching MTDs, a reboot notifier is added to the blocking
notification chain. However, when detaching a MTD and freeing its
related objects, the notifier is never unregistered from the
notification chain. Thus, when the chain is iterated there is a
possibility of finding the address of the reboot notifier which has
already been freed, resulting in a slab-use-after-free error.

To fix this, I added an unregister notifier function in the ubi_wl_close
function to ensure that the notifier is removed from the chain after the
device has been detached.

Reported-by: syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67409091.050a0220.363a1b.013d.GAE@google.com/T/
Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 drivers/mtd/ubi/wl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 4f6f339d8fb8..31a1e5515d98 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1995,6 +1995,7 @@ static void protection_queue_destroy(struct ubi_device *ubi)
 void ubi_wl_close(struct ubi_device *ubi)
 {
 	dbg_wl("close the WL sub-system");
+	unregister_reboot_notifier(&ubi->wl_reboot_notifier);
 	ubi_fastmap_close(ubi);
 	shutdown_work(ubi);
 	protection_queue_destroy(ubi);
-- 
2.47.0


