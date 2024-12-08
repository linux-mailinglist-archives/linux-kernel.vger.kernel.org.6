Return-Path: <linux-kernel+bounces-436530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10D9E872B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595681885507
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94B189B83;
	Sun,  8 Dec 2024 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JG4BftGV"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B914601C
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733680413; cv=none; b=NT7TyEQj8BvIrdh/t+Y3sZQQ+Rmv0pWFy2wTYU4XdFYEvDsuidtDdHZDksPf1yMpugHRFUWTcn7ZRzc6HaBWWq2nV7ngEE84WpcOqVwGxai/RrF3w8JHknxwnCZyXBSMFx9qQGME7d07dTsRn5DCSviL7EA8Ceh6KzBXQOnOu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733680413; c=relaxed/simple;
	bh=EfQ3q09C1m5D3DWM50HHT9wlsO6zMZWYwUCT5g8OuVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKiKAn9rkopRssd7uuqgtCJTQ6LU5qYVkKN0mxOohmC2GzH+YA1QRzl4DMDIIyRENd0OjlVEkr99JMz2/bOIW+uGTSWCfpZY9pnyKdmij3xvGOIXm9evxeidkVDnyPVHNHGxeYwzXeizQpX/F+V1gXBddRY6h2Yf70z57oTqyoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JG4BftGV; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d902aea641so4872926d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 09:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733680410; x=1734285210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mogfde4HD2tesO+IHIV06pNlbHgCI2p0y0QxJlMrRW4=;
        b=JG4BftGVVycNMbNp6gOhcuTstqnnqEM69z3LORLJQfO+1++OtASUW13hW0BlxO/7SN
         j4bD4FZgigWMLasPghnaco6kKpqMX1gKLcRoUIXkHyI4VNLYwx4yn9dXPDYXAWE/2OKo
         cDydEw+9/bGy3l5FXcjrk47OfyjNibmbvb6A+7qp7Pg/vSnJSvx1q77n2BWC/sxo0HJr
         6wNGwOGjwtkEl02cbTvL1EYmPfTTFtI1ildSPhtxnr16fOOkwXiNcGM4yP0rpAQQ3620
         fXqvuF+F1vH2fkN57rrUOTH0aYsyYf2LWRGdhQ+95HFf0N3dnCQe3livihKZFou8hNB2
         KfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733680410; x=1734285210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mogfde4HD2tesO+IHIV06pNlbHgCI2p0y0QxJlMrRW4=;
        b=kE/QaMvns4vdk82BqhaUNLr8sdNf3XNo2E7wk4a1bIJXCH8bYPPhq9rSQJXCHEZvu+
         BR8ZxmV2hSagrOReI+3iUCH3TgJ8YvB47UWzvRWXur0i5j4YFY32jQSn038DCH9xWtWn
         6415n8hwF+2xFnP+3SW5GBt6OAl/5ba89wCJBJwEkoANIWLzJQH6WvAfxsmJ0gKhqU7M
         8Ov6oMVeGLYLHod9LTUfqPZpYwh+JOPtj2i8bcdq8aqLNbZ9JF+C8fozUunRpqwNHM0+
         jHIGMxbB/AI1gYwgDntxxTXk1Yuuyp4OhLIp5AqgO3RHfGXeFORvyZQg8pYzyqGwllsr
         KTQA==
X-Gm-Message-State: AOJu0Yzy3T7xAI316wjMAICcsEIu+oYguRhg6q+s82TMNmScCspp4W52
	d9R79hhJNeyDrqyJ0+hYvTFwq/nUhCdkQx3RVflkzJW/iyx4wjVp
X-Gm-Gg: ASbGncvVvdew0YiA4U6opotQ9v0eRyh760HoLDtPX3S7W/VCJOmxDKNAeMf+IhYoKFu
	3V5nqzzorbh6k7p9tpqPO9rEJLmVwahNldH0eXUT6ga27rOckcgri49ZUgNTq1Nnd+ljO7AK2mv
	hYYFZ5FQiLAlL38ooJ5EKrkmu3K+T80ssAHrltRO7QqVnXZzfeJ3vpCjkghezmfc+3OEzs+DDeK
	flmbu/bBt8jzvOeY+V9cmLB3fFuu8I9WxsYb4SVq62Fy65D98HmdCAfQ8h3u3tQVR8vjXtUnjoR
	r5i6o+K/gaF1rmdvoc1a9BBS47U3
X-Google-Smtp-Source: AGHT+IEuV++ppUuVlAS1PRse28GLtcZHBJtSvyEBx9LecOF2uDS0wPVg7p19uYzVfSC0hVh2qfS/oA==
X-Received: by 2002:a05:6214:20a8:b0:6d8:a188:369f with SMTP id 6a1803df08f44-6d8e7114890mr158277376d6.14.1733680410600;
        Sun, 08 Dec 2024 09:53:30 -0800 (PST)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6d8dabfb438sm40539386d6.106.2024.12.08.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 09:53:28 -0800 (PST)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: richard@nod.at,
	chengzhihao1@huawei.com,
	miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] MTD: fix slab-use-after-free due to dangling pointer in notifier chain
Date: Sun,  8 Dec 2024 12:52:12 -0500
Message-ID: <20241208175211.9406-2-dennis.lamerice@gmail.com>
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
notification chain and is freed during the detaching process. This
results in the slab-use-after-free.

To fix this, I added an unregister notifier function in the ubi_wl_close
function to ensure that the notifier is removed from the chain after the
device has been detached.

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
Reported-by: syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67409091.050a0220.363a1b.013d.GAE@google.com/T/
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


