Return-Path: <linux-kernel+bounces-297949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA82395BF85
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE81281EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790751D173A;
	Thu, 22 Aug 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORYe9iCZ"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D621D0DD7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724358498; cv=none; b=qrauIdUkXLgLJ9KYoeBuI9PYiAn+3LhLp4GF+L5ti7BWbpyyO8bvn0uYadR1j9Y143HvR1hI75vBZieuCO+W5gKGtmVJRQFW8btcsIHDBUR3MNhfGB61Y9fuS6EpFx+tRWtWTeeplxLRPQJk7MfKDHbg+hTM/EAYSEQmvuz//hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724358498; c=relaxed/simple;
	bh=PYlTbsEA2Gnf3V9BDLC5a93rkztOt1IWXxJrQlshLy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPzxZcSMcUml9iRaEbQURouQfo2lyPXWxK400yP7pUpfED+dFmG+kgvluD2Bq5kMWM29EbM4CJ6UvYUmMwXMUg6p9ucML0nPRBeLMYRrudrsrRIzg3UWfRGepPpjY3NoJz2KaOD+OcW8J+f7qwpYJbYMjtBJAQE1JIQsgy5TGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORYe9iCZ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093ba310b0so758811a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724358496; x=1724963296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1s37SmFSoutq4Cla0ROl94+jxjLFGaNMPkeu36ZGaw=;
        b=ORYe9iCZUTr7Dx55ALjhtS4WPgdA8iwpWKxL3445mBibIGBhyMwnfu57DhRCDfUSqR
         HCSaf2L/vOh9ZsBvR7r9TxLOCt+dBDKBtzoUnDv7DpuSM8oOgbWIwQiP7sW+ENh8Isc1
         Wxnm+1QGsKobU9GEsMG5euDlSSfrtjFB3Tu34FK2OQszDoCTdsIS3u+1kLXJT82Stdsh
         uqb+ILSxtXh6ncw3Dit2wHd47D3LLMkUWmZhmwRYr2k8MoJaf5j1XiUHVPqViYsfpHNp
         9V6jIW0FFYO+QaVxA0z5qpPZhXzjOwuG386lc2MncDd9muiwi3n8gGWzUC/NE4Lm24va
         Kuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724358496; x=1724963296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1s37SmFSoutq4Cla0ROl94+jxjLFGaNMPkeu36ZGaw=;
        b=MJBEc2FTqLZ9cIE2RyQdfZFl4lo0SW0U1nEkibkUHR/qve7S4anANZOecUoKxnloTl
         imqtgwubgQlb7aAUmoJSpWzaemz1Fa0R8I/mqMI6eG8lyUM3YK9ESysi8/m41B31xleA
         CearRMG3V6R6A78+XJxa1z+P7QAhBIePcVOg3GNn7dJmM+T3OCbIMhbTyXe/vAiRn9Pj
         JYKmC7XsZV8gtySsnwcBYIrk691hAaLcBdhtGih3ayi3+z1RHDaLxLioC4q0bT+VD29Q
         4Agu6CpA9EWjcuaKobYn8TqLLZMGJXlXF0pSak7mUKCOenq4+8LF/GTWJvcgOc/gAa3p
         lL+w==
X-Gm-Message-State: AOJu0YwkBHyilbrtKeF49lyBRRC7oNwr6CYDNEa/6P4Jm3yUZvqp7jWT
	6DX8aqAhCAV/D/OTFn09dGEEi2dZCYc6usFY0v3xkizCdHuFL2tQ9Jtp277R
X-Google-Smtp-Source: AGHT+IESHeMuha44i7IqObiLapfOnL+cMBaJAbHcBE9nj4YdYiZRc6zMz0Cm5JYiCByoc907pOT7Yg==
X-Received: by 2002:a05:6808:30a6:b0:3d9:e22a:97a4 with SMTP id 5614622812f47-3de19576b43mr8046514b6e.36.1724358496188;
        Thu, 22 Aug 2024 13:28:16 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de2252d5fbsm421265b6e.1.2024.08.22.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:28:15 -0700 (PDT)
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
	linux-nvme@lists.infradead.org
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v8 2/4] driver core: separate function to shutdown one device
Date: Thu, 22 Aug 2024 15:28:03 -0500
Message-Id: <20240822202805.6379-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a separate function for the part of device_shutdown() that does the
shutown for a single device.  This is in preparation for making device
shutdown asynchronous.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Signed-off-by: David Jeffery <djeffery@redhat.com>
---
 drivers/base/core.c | 66 ++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 13253d105062..7e50daa65ca0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4781,6 +4781,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 }
 EXPORT_SYMBOL_GPL(device_change_owner);
 
+static void shutdown_one_device(struct device *dev)
+{
+	/* hold lock to avoid race with probe/release */
+	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
+		device_lock(dev->parent);
+	device_lock(dev);
+
+	/* Don't allow any more runtime suspends */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_barrier(dev);
+
+	if (dev->class && dev->class->shutdown_pre) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown_pre\n");
+		dev->class->shutdown_pre(dev);
+	}
+	if (dev->bus && dev->bus->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->bus->shutdown(dev);
+	} else if (dev->driver && dev->driver->shutdown) {
+		if (initcall_debug)
+			dev_info(dev, "shutdown\n");
+		dev->driver->shutdown(dev);
+	}
+
+	device_unlock(dev);
+	if (dev->parent && dev->bus && dev->bus->need_parent_lock)
+		device_unlock(dev->parent);
+
+	put_device(dev);
+	if (dev->parent)
+		put_device(dev->parent);
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
@@ -4817,36 +4852,7 @@ void device_shutdown(void)
 		list_del_init(&dev->kobj.entry);
 		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent && dev->bus && dev->bus->need_parent_lock)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent && dev->bus && dev->bus->need_parent_lock)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
+		shutdown_one_device(dev);
 
 		spin_lock(&devices_kset->list_lock);
 	}
-- 
2.39.3


