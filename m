Return-Path: <linux-kernel+bounces-231418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3B0919880
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9217E1F2347A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF13C193081;
	Wed, 26 Jun 2024 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWvcV22N"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F819192B7A
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719431235; cv=none; b=UgMx0r/qGISy1bjUlVU9EYyvK6DLAi98esKp5do0A54/4O870oX47oqSjJ4eq7I9kl/f7ufY1TGroZxgTj3yNbMeuCI0gfml0Z8gDhZAgzwanScQCao7uWEScvvrqWkXrazWwg+X+KcWNyTV0T0DOJOQaqtPISGJ+QylrURAGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719431235; c=relaxed/simple;
	bh=whW4NEDtUAWvPFkHfGqM/eWmy8LMHrs8iCjhNrO7gzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V+X+jGPV0oMxfv/si/gp4f1JDX8YQVZ54Ygk4OnbNjWGqj8KJ2p5bwbOhDrEhK593V1IADc0k3e5loIOOoRDlj0TzUzFuNvqYfY+9srod+SBIbrI3Nny2wpKWvqrZGaFiusEFH75UP7HrFhNFA/uFvKl/5LIw4ji2PXQ09EAhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWvcV22N; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b4ff7cb429so30173196d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719431232; x=1720036032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t53QVoqoslUPlZCx8x17h7LOVaKiKwVjI+I5ylRm50=;
        b=OWvcV22Nk8fG+0KkXqIANZZiqaDsigJlfeSjbLgQqG7Flxfv9zuLHMJuw7QvVXQzGb
         3abQf4TSyFK7v7C2QxWx3E4dcfxwJ8dhf1afugKbwY88o7LguLvSOgNv5bhcpwo06Hny
         Odc8Ytfy79w069NapqnNrmXvvf+OwK6mbFsFl/Kiyz8u5Y/KgbS8OH3VlI9+gENjVea2
         B3Xkw7e/N2PpwA+vnGvZumpODGNOvBwao4h/dFSItRh8knU2BFBYZfqyGtbjLhGFzQnP
         Z6MwG2Qz5kbL777FkJPu0S1qyw6DKrQXGYzQxhrQuQPN1gGdYm+kz8U5SG0qit4zXQaU
         QTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719431232; x=1720036032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t53QVoqoslUPlZCx8x17h7LOVaKiKwVjI+I5ylRm50=;
        b=FPrEbIcjn0zB5R9cWAhmz5dTHzvBKv1+V6pkOzWbrzZxGCdnqvH8YzQWCcQJ/H3FKG
         wpaYzK/hsp1PU2/neTm/4mQwAkXDT4uPfZAdI/vhEyptJweNhrpmd23TNcwnWIMZ1d19
         /nb91Oj1fkvvqoFs+ZoxIfzI+9qCsWubXLYFN5CvYr/nSfbtlccB9rxM3WbTKPVskVc8
         M8ktxu1OofUVLyte3PFz3KYIUc3k/gEAd+tp7Us6nxlV/1V2PDJ0E86qiW4oRrjuatLn
         ApgMPS0KYxV85ndMGO6Jwap6UrX8LUkxfui2Z+RUHTPGFDbhugj8GeYMpHscA/guNe9N
         XqQA==
X-Gm-Message-State: AOJu0YwGmz/7S9qMBMnwNiuZbtWR6Nsz5lp2z++r3T/hmFLN+m+OGz1N
	fLSCS8kdZZavbnJbL2bB9YNZ0TvjH/ddNp41ZpzcjKohk6VRagsFYOsT1nDP
X-Google-Smtp-Source: AGHT+IFBvOA+iyHRobdSxdaxMTRLIM1evBlCzixHNIMYcGypuDRbefQ1cYpWHTm6lnaQXv9sHGFacA==
X-Received: by 2002:a0c:e441:0:b0:6af:2344:5811 with SMTP id 6a1803df08f44-6b540afb170mr122808676d6.55.1719431232429;
        Wed, 26 Jun 2024 12:47:12 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b52ac1028csm48489996d6.99.2024.06.26.12.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:47:12 -0700 (PDT)
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
Subject: [PATCH v7 2/4] driver core: separate function to shutdown one device
Date: Wed, 26 Jun 2024 14:46:48 -0500
Message-Id: <20240626194650.3837-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
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
index 03edf7a7ec37..4be6071c2175 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4778,6 +4778,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
@@ -4814,36 +4849,7 @@ void device_shutdown(void)
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


