Return-Path: <linux-kernel+bounces-419248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B78779D6B55
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCF2B2178E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216D1990D3;
	Sat, 23 Nov 2024 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYCSFowO"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E413C9C4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391958; cv=none; b=jl8RqZ9US0ITykSAUsBA2mdSWg7LiZVDQKH707A6O0T5PrF8U7BHEY9cMB9X19YjPnZhtBQYfhgJJHhVX5wuuKXDBiIP8QGI6STTW5ZUjImnRj52uQiL0uVdcqaGYwMpKpeL3Kod9r2H/XinPkdOhkIuUczMdwoEvNf4NPJnx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391958; c=relaxed/simple;
	bh=ppk6dUlKVq4vTfFNQ5pLZlqXaoNf/7pJprtxbyvpKfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ALX8BRd3tcHjZsKVb3Rt1DnhwfUX4ofPI8TIxbPzNYAoHwvNp0xYcTMF34LqQpi3W/RqiFhze3dYcFHu2iIrBBtXwlS3T5GkjaFCpoddTD0X4Zp0eDb3NLGn4CocEbsN4CGtDRmFQiJxASSxjZQ4h0rLHJyKMTBAoezRrgncwmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYCSFowO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2124ccf03edso31285345ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732391956; x=1732996756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTd40TlAxinzrp4LL6DZMdpsXul9ShE3mjiH7jh5bSo=;
        b=fYCSFowO/2kUiG7axs3n0CwjDu9EsBSNQktErkkxcdpegqRvv5suuI5bbqBlCxedAX
         GBqNtjxC6xJxifmdBTIgQFKVib3ws2DvxADdCvsuVnGUby400Zv7u9y0LBn+GGeLwmv9
         4aMVcyD9vHrHaVcx+ljWMlU9Vh7ys6YPjlOU07F/ZMndFC5xFlRuumPTavtntoruBr6L
         2qCxvMoL76PXaKpcdnWywvyHCDw7Etss1GdMXb1RJBwePJixHvN0zJ60sGHK2lLeJh6x
         +MZPQMoYvWkRRB3Txw89aeW9Tzoow4Bkp/+WRpsNWim2wF0gzFlYDaU1ike4O3vlo5EC
         ma6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732391956; x=1732996756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTd40TlAxinzrp4LL6DZMdpsXul9ShE3mjiH7jh5bSo=;
        b=M5y9jmPCibL/HHN8Y3srC30xNPiM3AQtJQYSecD+gjNKTHqsCEWB3U5VLbF9xRw/H8
         D7Ar/48LI/gtUJsDrkPegSn/JkmsecDNbyH2ZUN6P4uM/GNhO4tsb5U/rD8zG8AGxIHk
         TDkXOit93UhXoIuYir+3NY1Pe3ZK9xn5Ydb+jMW8YoD2ppweu5gmVcYZMg/MLQclxb+z
         U6D/SxQ5l6CDuQ48OOvkEyyF/w5L6L7b6DRmsYD4+Hz7HoNlY8xldu8GmyDr2hS2sZ6o
         88HWvt+vOpUi1DU9ojf6dMfN6X7Kc168eAB+eO+CM8STgYk2ga//Y8BkHeBt/8XWBAnr
         CBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl56REgvIfQllCBz5PpkPxOsFz9qFnvW17rfwmOeVvEprdSOT6Tw2+8oxkAwZ4LKkAxgYOAM0Lk6UQ2tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDaJgqp7RuWclEQPZk9qf4/ZtLOqNfbefdFGqd/20FwMfRwNr
	e/bDVIbNcGnLcLtLwdzB7RjsGV4gTNkgFE2Txx4rO50F+oQf+rdP
X-Gm-Gg: ASbGncurhkIZBr9Zjt+4phY/nX4MbCeAkwitEgKNJJKMnqtmcrZiY5m5sGsOMUOiXKv
	r6rCyvKbuyBzwv8IJ9mxnnwdT3WZuc9GmGE6Ang+47SEy8nYrRF5GbCA37XeXkF0y3ERLO/0n19
	trrIO9aXh7z0c3+Swmw8pEviaFe22RIqOHvWCCWaavlXUtOJ4HvYLa70krKBeXM2tuf9irFldjs
	OBiOQ5ZaY4dKtcCR3+cjGtk9L5Q5syCrMRp0mTTz+9/HvU3iNOXPZnQa/LPObDYMzGKAigggXYs
	HZVV3Huftx93+g==
X-Google-Smtp-Source: AGHT+IHmDjBvRFPJEqiINap153R0Kmft+Rw5KDn0MqKLa8tYfUTc2qMbUniCnDGG7L3zgGwso85yxg==
X-Received: by 2002:a17:903:1c6:b0:211:f52d:4e03 with SMTP id d9443c01a7336-2129f799e5bmr84412135ad.27.1732391955525;
        Sat, 23 Nov 2024 11:59:15 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:103e:6828:c968:a0b4:c749:4c7a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454b5asm3738085b3a.27.2024.11.23.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 11:59:15 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: jgg@ziepe.ca,
	kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com
Subject: [PATCH] iommu: iommufd: fix WARNING in iommufd_device_unbind
Date: Sun, 24 Nov 2024 01:29:00 +0530
Message-Id: <20241123195900.3176-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by syzbot:
WARNING in iommufd_device_unbind
iommufd: Time out waiting for iommufd object to become free

Resolve a warning in iommufd_device_unbind caused by a
timeout while waiting for the shortterm_users reference
count to reach zero. The existing 10-second timeout is
insufficient in some scenarios, resulting in failures
and the following warning:

WARNING in iommufd_device_unbind
iommufd: Time out waiting for iommufd object to become free

Increase the timeout in iommufd_object_dec_wait_shortterm
from 10 seconds to 12 seconds (msecs_to_jiffies(12000))
to allow sufficient time for the reference count to drop
to zero. This change prevents premature timeouts and reduces
the likelihood of warnings during iommufd_device_unbind.

The fix has been tested and validated by syzbot. This patch
closes the bug reported at the following syzkaller link.


Reported-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com 
Closes: https://syzkaller.appspot.com/bug?extid=c92878e123785b1fa2db 
Tested-by: syzbot+c92878e123785b1fa2db@syzkaller.appspotmail.com 
Fixes: 6f9c4d8c468c ("iommufd: Do not UAF during iommufd_put_object") 
Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 drivers/iommu/iommufd/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index d2683ad82..954c021e9 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -104,7 +104,7 @@ static int iommufd_object_dec_wait_shortterm(struct iommufd_ctx *ictx,
 	if (wait_event_timeout(ictx->destroy_wait,
 				refcount_read(&to_destroy->shortterm_users) ==
 					0,
-				msecs_to_jiffies(10000)))
+				msecs_to_jiffies(12000)))
 		return 0;
 
 	pr_crit("Time out waiting for iommufd object to become free\n");
-- 
2.34.1


