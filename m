Return-Path: <linux-kernel+bounces-284060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B194FC82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4BC283492
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC641C287;
	Tue, 13 Aug 2024 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDjlykrN"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48514F98
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723521898; cv=none; b=r95yN81sPLd+mlBNgX3kzgVUFO7cP0Pn0MqV6hyPqZzx4C/FYfHmRPsw6+SHmtaoK4Tc+mgyLuGNvnhB2hrK6hQKSXzEmMfdu6XVn0M/YnJmNUEY0umge9+9hr6UTNfGd++NyB/Ih3m78vzZ7/y21j7+gFxOrCseGbepuVAnhKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723521898; c=relaxed/simple;
	bh=EcZZm4CJUm3zXZIu6azr1f2Vecpbky8jyiiMJ5x2r9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XAfQhGAIJexXY4X/GYDZtiwvVka0PnLTTbzMNuasIFSqK35ypxS+fq2WrooRaimfGU4qkd9DqJbnu+utsQe9wHmRmZ1PHNqSei6rOU73yEE4Fzh944FVtKyic8oEqmjvYPJ6f8a37Im1pp+zbxL/oeMXEZp3uiIQ1JAzJ1fQL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDjlykrN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso37593575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723521894; x=1724126694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=En16KWI62fl9qTE96h/U4N3IelKgrLoPh565oRUDNpM=;
        b=gDjlykrNDXgjgZ7qvk1sjidqTIQ3kfYXQ9mmwjvJlO2y82uHv0Y5upr1NP1fZtrrCO
         K2NTooUeJW39vwUMDruqMdCy5zupMhhd64f5KTntKynVPT3v4ex+oanTVEaflici84GF
         zKCfhkIAWnpObuIJh5mNQkZlxbA8oMIz8iVsX1NlEk1P+wXoPdcMn/pwMUaGE1UAaWWq
         eCN43CfnNzmEeKDbUUT8rGWlZUJ3HfLWIl+oBwYJ+bXtyLaPdBegKHIBnG5jIKsoGRVS
         X9+DIhWGO9zwJlxx0lw+H2r+MEoR7dt8UjQpCviAeh4VrczEj4KrQ8cSfntup9vAZaAq
         DyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723521894; x=1724126694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=En16KWI62fl9qTE96h/U4N3IelKgrLoPh565oRUDNpM=;
        b=rNa8aExPE076tR/TqHK4XNebmB5CSN6EMJBG4oDE8MHWURhuZmUlrArj20F1aBD1M8
         PvutA6C8D0CszHd/lgsrlPUwPTwOlDgHDx9Vddp7bcZ3eJ1DBbwQmTWrP/Q5DhG63aGl
         7/nPBEn+4ZEvFIYQVqZw7TD5OwnKD3kHGctgQLIJbkXOYSOexdtzlmbJ65D9lRyX0PaS
         JjXbUrvucT1HejlgDuAWJ/O3StVGyksUQn4haHWcavXUS5oenZsOBB73N4E7EDp16K1O
         IJreCHCyl1IReiLhIHROZhS4ul6D8eMqHts+xM6vVF7A+HohkKr3dFVIKkym6KOnQaYu
         QHbQ==
X-Gm-Message-State: AOJu0YxfhWDOi3O/t113UE++O6Mq0Fvg/q2DUv2pffh5z3WABsC0xq4Q
	vfcLYR9dvHOsI/3mSnfuQbCga4ZEKhWCsefVaLoTPwxFS73LqdbL
X-Google-Smtp-Source: AGHT+IGcgmH2rDRaO17GvzoH+LLLAH81PbZhR2r/bfyRtBWhXWaxsNSg8TLLDrm8UqEQFWoq4xUtcg==
X-Received: by 2002:a5d:5284:0:b0:366:ec2c:8646 with SMTP id ffacd0b85a97d-3716cd24ddemr1447562f8f.43.1723521894311;
        Mon, 12 Aug 2024 21:04:54 -0700 (PDT)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ecc7a52sm8910469f8f.103.2024.08.12.21.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 21:04:53 -0700 (PDT)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: eli.billauer@gmail.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com
Subject: [PATCH] drivers/xillybus: fix deadlock upon cleanup_dev
Date: Tue, 13 Aug 2024 09:04:25 +0500
Message-Id: <20240813040425.187418-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot found an issue [1] when cleanup_dev() is called twice,
causing deadlock. It is called in xillyusb_probe()
in the end of wakeup_all():

	INIT_WORK(&xdev->wakeup_workitem, wakeup_all);

then on "goto fail" path it's called again, where it's deadlocked in
destroy_workqueue(xdev->workq) due to first call's work_completion.

Also the deadlock prevents UAF as cleanup_dev frees struct xillyusb_dev.

It should be also the cause of previous syzbot report which was fixed in
commit 0d151a103775 ("Bluetooth: hci_core: cancel all works upon
hci_unregister_dev()").

[1]
WARNING: possible recursive locking detected
6.11.0-rc2-syzkaller-00004-gb446a2dae984 #0 Not tainted
--------------------------------------------
kworker/0:1H/58 is trying to acquire lock:
((wq_completion)xillyusb){+.+.}-{0:0},
((wq_completion)xillyusb){+.+.}-{0:0},

but task is already holding lock:
((wq_completion)xillyusb){+.+.}-{0:0},
((wq_completion)xillyusb){+.+.}-{0:0},

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)xillyusb);
  lock((wq_completion)xillyusb);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/0:1H/58:
 #0: ((wq_completion)xillyusb){+.+.}-{0:0},
 #0: ((wq_completion)xillyusb){+.+.}-{0:0},
 #1: ((work_completion)(&xdev->wakeup_workitem)){+.+.}-{0:0},
 #1: ((work_completion)(&xdev->wakeup_workitem)){+.+.}-{0:0},

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Reported-by: syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e528c9aad0fb5383ec83
Fixes: a53d1202aef1 ("char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)")
---
 drivers/char/xillybus/xillyusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 5a5afa14ca8c..099fe681aed5 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -2151,6 +2151,7 @@ static int xillyusb_probe(struct usb_interface *interface,
 	if (!xdev->workq) {
 		dev_err(&interface->dev, "Failed to allocate work queue\n");
 		rc = -ENOMEM;
+		kref_put(&xdev->kref, cleanup_dev);
 		goto fail;
 	}
 
@@ -2174,7 +2175,6 @@ static int xillyusb_probe(struct usb_interface *interface,
 
 fail:
 	usb_set_intfdata(interface, NULL);
-	kref_put(&xdev->kref, cleanup_dev);
 	return rc;
 }
 
-- 
2.34.1


