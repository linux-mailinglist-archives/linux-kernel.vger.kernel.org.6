Return-Path: <linux-kernel+bounces-333088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DD97C350
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48C61C216C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB2179BB;
	Thu, 19 Sep 2024 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE7h8y6m"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E023AB
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726720313; cv=none; b=B+8ejTlRyM/Vlrv49o5tFUetypAEKCa0YCfjaOuFKm/c7O5mrSCaUudIbG+nbLkt45lF3Wi4/LqwgwhEDBGbeNpthFX9DsHy3QtbgmhQ2oWxqwsEifUPEUIY29BTGOu5cPtE3jygwmAJaWkNpwsBIrEvaD85/g16WiBctSU2+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726720313; c=relaxed/simple;
	bh=EcEbpoT4Yi23+De7VvqDSLDM9LsvEFlD/sABkkZCJpw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VopyLxxNvvmaT7LcV2lOBNcUSJL6CDpQy9v6Y2eCo2etv7li7pLyWyqyh7G28ueHLItPasdQdXgMeh3vmNvQ+3ZdjkDHK+CJepSOOk8ba94uw6pyNtloOykRuau01/G+hhJO+gbU9fnPVN/VzG2S960TewGaOQKG98EdsIPuEKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mE7h8y6m; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e0438e81aaso301180b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726720311; x=1727325111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jnEOZ1pExE6GXIP1uo6O5xxRyy89O+vheaw1Do4bDlo=;
        b=mE7h8y6mQZWOfcR3XB/eXaZZqWT/BtO0WObmP/glPS/BXXVnzsRLrDEbHKrtXFC7W3
         j89ohHPrycjF7x+lFb4Xijfpz0//dkkv7CB5R8jIprEiohg8hkgYX48qyZmWquXL/qS1
         WSHM0qLTJHtLNhQZeO6e9dhtLebdjde53D4GvrwnKlbFaV+rwwgDpe/5LouO99grKZ5V
         biNkslj28uWGyG4PvBUTm/Et9KGA9t6pigxiIjGFffWcgTXAYwg/CaBuu5cUL03kEqZk
         ahlni2m5c5+xtJvsbZ820vu+ghbVUF+xLa8G6Ax/3Nvhl1yR3m7NVK8IPhb7gJlFkEuQ
         WCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726720311; x=1727325111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnEOZ1pExE6GXIP1uo6O5xxRyy89O+vheaw1Do4bDlo=;
        b=NBtlX4quRdJoYNL6BUCEhNSz/7YzmZwudvSrmP53+buEjaO8WlUzSz8hWFtNbnrAe2
         6rRCLWEtcBy+cHyNsrAulPnSVrzJR+Twc23jmFQd98RLb4myoolMMWq25emMY5Gt1lb+
         ZKreKVNruznh1asFsoF/lBThEAs2eCcyAsl2D4fITJ+za5XJqR3QaIWS0V01zeSXu5TT
         92YMRiFIHhJj/MRMQrPkxpc9jWy5HJWfxJ+VF55lpMJoM6vtay49aTRGdoR4WcFupEfK
         zw+xjMB6mHKaKeEpGYhExYX7l+aJz4qE1TUWDAZgiqLKzdcJ0Eae7fiN1V4kGt0Q/TGH
         O7Ag==
X-Gm-Message-State: AOJu0Yyzm3Pp4rUg3VeBB97qfTd53H8DkVXUkJrKRptlCMe0blRLUGRM
	8FLnRdhbZ0NaT5vYd70FZtxtvI0r8bXCBAJ8GniDEpcNTJuvTFkTj2QaIo4S
X-Google-Smtp-Source: AGHT+IFPY1p11K7SNgnXsHQAZuSMJj8nXShqm/KTnmJE87uRTzNxmpFc9IFDksQCU3rAM51H34Q8Mw==
X-Received: by 2002:a05:6808:1821:b0:3e0:6b72:f324 with SMTP id 5614622812f47-3e07a125223mr12371571b6e.20.1726720310623;
        Wed, 18 Sep 2024 21:31:50 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e26b6ac829sm207305b6e.18.2024.09.18.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 21:31:49 -0700 (PDT)
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
Date: Wed, 18 Sep 2024 23:31:43 -0500
Message-Id: <20240919043143.1194950-1-stuart.w.hayes@gmail.com>
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

Fixes: 8064952c6504 ("driver core: shut down devices asynchronously")

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
The patch this fixes is in driver-core-next and linux-next.

Please let me know if this needs to be a V2 or if it needs anything
else... it is the identical patch I sent in yesterday, except I added
a "Fixes:" tag and the comments.  Thank you for the help!

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


