Return-Path: <linux-kernel+bounces-332030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250A697B47B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6D7B25D15
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 20:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4E170A0B;
	Tue, 17 Sep 2024 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fafmN/fg"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43223B1A1
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726604123; cv=none; b=h6K/66wKry9tC61fDyrMOzysWrnji1Gb2PB/ylpQf6ErO2nuhmbbkoajhvD6SJwqHdRai3bF6BbDCTLcNmyAv5TZwz7GO3Ij4bDjGjoBFcfwcgh/VpzvERrpyfbiYg6gBoi+SIJjf4JaTWOpyX2NDP3VCAcNIsAanLsDmYyhMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726604123; c=relaxed/simple;
	bh=aOnxkE629Q7uxQvdIEGwqukFgP0+vOvNqIQw17ZdUFg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PBUE8sZRjYf1lg79rP96IapRWdsmqGi4FQtSAuJoFwJ5HL8dRUkyH2blTt7wSiGwBM+LKhkd/h83Do6PJ5XXRIZ/4kK28SWhZJRbFkd8T/QZyRZbTrLG8iVDCdkp0XiwYpI+sj7S7dETq1Qtovgl9Ll9RE44+YuSE7Ks70v/T7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fafmN/fg; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-710f63ff31eso48440a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726604120; x=1727208920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnpem1ad9XMHCNEO0doEltppxSVMaPU0TbCxRa1UzLo=;
        b=fafmN/fg5SnVuJUOrSxdif8yEZsOZJmec4H5KCN/9h9gMDL4V9Q/9vHSu8Mwvg3Jlq
         3SQ/1lZLJIv7ubXJnKpZKLG23WBfpNTxy589V82Ma4fvznsVjR18CTp+HhR2JAOsAKnb
         fJD6LmmebKwHZnk9JCStT9dOgpQxeKbdY/oH+MK40J09/eqw/fO5mYlBVTStLnCf38iT
         18XcoaRWLfDWpOdF6/s57lrgsLhA6iCHPqmoFskrsi9Se1MKA9JRD+NhIO44oL59yf1L
         g4TFgBc9W83NwwmNORW0JrIi+qjMjsCc5MAvX3CPCJDl+HY8CXeJcMiuH2RNP4y1f+Zv
         +5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726604120; x=1727208920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qnpem1ad9XMHCNEO0doEltppxSVMaPU0TbCxRa1UzLo=;
        b=bgZo98Lvhgsb44WEbD5BplDQJl0KRmpQ9ilsrFlTEMwIUw8rB1nbB3BT8BCrRUkwh3
         89s7eRaYFs4Sxa0ExL4AGyxyYmpd2lZUSKWg+d+7rp6TdEmCfo7h8DWN2TxfNvRubjmd
         C2t8/7r7NUWQeHRtkZl+zJSGL+9emS2144+C8/snls8yd3+SKD99D/PXkJRnobdt0tnr
         6rlkxyJMqyR2UZEOOuv7Jhk95FCvidwWC+xLsCqw/lFBggIiswtatSERlk6U//dFt1Ku
         cwTLn4R7s3apFVC5YYfPPkczgzrtKduwGJGwGe8xxdlQ/7To04jaixpAO4wzsuw6pPdc
         Yt0g==
X-Gm-Message-State: AOJu0Yz7K6TK6sAoWWqN6RSn2Ib3kD0bCUsvUzBRtbNiVilooJkChOT8
	4Iq3dH3jc9L75FGt/SDBUiVBR/5GRhHvwIbWuFXqK29XyDbXIzoM4QgEwR+d
X-Google-Smtp-Source: AGHT+IHYsJ26P2MaX5MBeePofbG6Q73+J96JWmdrsHLigQQKy8YEHdjmxWSVwl73tuTml2XudIBiFw==
X-Received: by 2002:a05:6830:4121:b0:709:41c4:6a5 with SMTP id 46e09a7af769-71109b666c7mr8531945a34.3.1726604120676;
        Tue, 17 Sep 2024 13:15:20 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71239e9fef8sm1658393a34.29.2024.09.17.13.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 13:15:20 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] driver core: fix async device shutdown hang
Date: Tue, 17 Sep 2024 15:15:17 -0500
Message-Id: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify device_shutdown() so that supplier devices do not wait for
consumer devices to be shut down first when the devlink is sync state
only, since the consumer is not dependent on the supplier in this case.

Without this change, a circular dependency could hang the system.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/base/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b69b82da8837..76513e360496 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4898,8 +4898,16 @@ void device_shutdown(void)
 
 		idx = device_links_read_lock();
 		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
-				device_links_read_lock_held())
+				device_links_read_lock_held()) {
+			/*
+			 * sync_state_only suppliers don't need to wait,
+			 * aren't reordered on devices_kset, so making them
+			 * wait could result in a hang
+			 */
+			if (device_link_flag_is_sync_state_only(link->flags))
+				continue;
 			link->supplier->p->shutdown_after = cookie;
+		}
 		device_links_read_unlock(idx);
 		put_device(dev);
 
-- 
2.39.3


