Return-Path: <linux-kernel+bounces-523059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEACA3D184
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B357A4739
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B703C1DE4EF;
	Thu, 20 Feb 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2giG+Rg"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D4B664
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740034019; cv=none; b=pSVVt4zmMqoxke7VSCK5bRpnfQfrrSEHsFTsdH0+F5qMfDvaihRNdoWcyrdXtUFTY1KU1RqI1hBTA0a1TpeD3UpvQWK5H20Lkm8l+WmMs3Q4vDLfYisAW/jmJkMqZkTZXGjp1APysywhbDM4iW0PHPIgFug50xbm0gOyIxje1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740034019; c=relaxed/simple;
	bh=cXkO/eicdPJOhfRSFJ5ei5irZwJ6ZBLQA0vIu7ssUz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mugg1Nsp+8ly/qhTInsNUe/WQp53XUFfx0ZpStth+9nSFQkyvQAwBj1qwufk1YaEhJ8XFsTQ/zzzknTiZDkBac8uNmpeWWm1L58JH40BfVvBWr//GpAazPYevNH6YGZEUv0xD1yhequW4eSpAYzY9EbO1yt6920i4dcFmmmMbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2giG+Rg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d28c215eso8305685ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 22:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740034017; x=1740638817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8T+zfryMvLGNSWD+FIyMTGJvbiqVBQ6P8RLLHRnG8iY=;
        b=U2giG+RgryBBguNcVRNMRqxE6H20kXlrqT4egqSWssLwLfadmuZT+BqKAGjbAuHVNw
         h0BC+9CobW29Ypg1T4OmIpBriPGSAD5xR6R0+Vxtjuy1oJyCpkthjxpPPh7C8qWQqCt0
         fDjD7hBfj4Gbl47ybvOPN4HxcvHnTy2Zukn6pK9Buyh4fyVzSf1Ww7dUwuoNTtf3wT3S
         rihiY/87bCYPQ+n7Nv/e0pxbQpZlyQ9HPiPCCErlg9CmtXxTUXdD3/TM87v1syRWwVDZ
         0q2eCxLqI4ic3WJhfG1fbpiin1V0dWhilO8uM5dgtxYmgVg06DQKM/tKMD86KAXFHLoL
         BSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740034017; x=1740638817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8T+zfryMvLGNSWD+FIyMTGJvbiqVBQ6P8RLLHRnG8iY=;
        b=ljWp0bSSOsq6AWcVjVD4W4ik/xOSCh5YMHYXMphG8j+NilrGGFxOVfCIJKny1OL64J
         ns547e6nepkNoHX77w4kkbtjFlEDcaXJN50vP6pzxy+p3kvF+kHt/b2DSN+RwlA9+Lkj
         zKe1NZnMU681Lpdi4CnzafpF9W6akb2fEaydILWGvs6NsDMhQ6g8svRxMweB/wRm4php
         wCd7pGZKeuZuomaD9aljIF0av6GS8PuS63/2SpqnnRpEazqXVwEY6cR6pmShrFsx/Ldq
         Qoq1MekAtDgA84Efn0n1/2+YCLMCwWwqCz+5aiJLowiXuOgwMrUVpJSbdetOpxzeoZB1
         PWXw==
X-Forwarded-Encrypted: i=1; AJvYcCUOHBit0q7xlQQK7v/IApJEqgMEq1FMZ8upEutOgmnD27hmktLW5ibipea5O+f5M0KKxOtLJpMJQ3GmCCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfr/dJGTW+LUl9iTAizI2E/Zk+wTyzOOH+XEA1Bd6MqwR3VcWm
	MeKFFwttc83UaZGbeRmFznnyFj/j48cjosRjeKz3//rX66cBUS3P
X-Gm-Gg: ASbGncs3TOQrymVXNV/9FGAZp9nSr0HeyxHQ8Vv/ZnjFENaVB90PlLWES3w296YgLel
	a9PrdoL2Da4lbbCC13jq4p4EE5147lwMEkyxsG/4zPuqzx8P7sqLNG4hEZ720VVU/gw82NERsf9
	jZPDbi1AbpYETIqJAkDT2NGX1LxBBR2YWCZLjWR5wI10VgdbVEizQQ6yLhEZ6Cs/dUtR2G9oJrn
	LZvLvUWY2JneGwNyI8c51x5hOqE0VACJtqCe2gaWk4bq4uPSXHCc+oPWga//wIKq623tz27spuo
	rBpSwnADRKghqTS3EigsIUStIaLtrZoaUg2hqwc=
X-Google-Smtp-Source: AGHT+IGUGmL6dEbKraabl1UeqstFIV9DtEyuBI+EnqWKsAcHTtaIutZcrS9VP3t6WwsQyeBSqIwlxQ==
X-Received: by 2002:a17:902:ce03:b0:215:7446:2151 with SMTP id d9443c01a7336-221040135f4mr352159125ad.4.1740034016880;
        Wed, 19 Feb 2025 22:46:56 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:a028:2c35:8941:966f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534903csm115162125ad.32.2025.02.19.22.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:46:56 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/2] Revert "drivers: core: synchronize really_probe() and dev_uevent()"
Date: Wed, 19 Feb 2025 22:46:44 -0800
Message-ID: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0.

Probing a device can take arbitrary long time. In the field we observed
that, for example, probing a bad micro-SD cards in an external USB card
reader (or maybe cards were good but cables were flaky) sometimes takes
longer than 2 minutes due to multiple retries at various levels of the
stack. We can not block uevent_show() method for that long because udev
is reading that attribute very often and that blocks udev and interferes
with booting of the system.

The change that introduced locking was concerned with dev_uevent()
racing with unbinding the driver. However we can handle it without
locking (which will be done in subsequent patch).

There was also claim that synchronization with probe() is needed to
properly load USB drivers, however this is a red herring: the change
adding the lock was introduced in May of last year and USB loading and
probing worked properly for many years before that.

Revert the harmful locking.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5a1f05198114..9f4d4868e3b4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2725,11 +2725,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
-	/* Synchronize with really_probe() */
-	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
-	device_unlock(dev);
 	if (retval)
 		goto out;
 
-- 
2.48.1.601.g30ceb7b040-goog


