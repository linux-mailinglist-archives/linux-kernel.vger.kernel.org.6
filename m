Return-Path: <linux-kernel+bounces-181269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8513E8C79C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11BF1F21E01
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FBF145FE0;
	Thu, 16 May 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCKtdax8"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7114F114
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874584; cv=none; b=Rc8KGGVCxGf7WUbLCGcHHQMXbJ4jeN/dsCwO8BSw5mcJOi1y2Ojb9VRtycgtQh4McGkcym8exa15zSYFLUfNYUmXa3p33GWdS/qhnw5zTl2aZEuFb2u5keiZXX3/PWa0Np4cI6pNM0pxALX9VtTecywrHlaJtuUGxo18Qj9XT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874584; c=relaxed/simple;
	bh=EVxLaUmi4wnckNMNHXzYTMXdTPVbbQZdt0IOYxoXGtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cYGjPeOQTSbfnKhKzWtCzuHZuOeNcZCl6wUFa530YHVRhB5H0ntFi3dC8Ss3q+NziQp3JPGGX5aCfbfo7ScaP5u18WzYSFGiPdjftvA6biEYYuG3ZnA1/lIKKW+JQ/O+TERh2sx2yqBhnkW8o80rPD0VhIQZaYOOA3Aoo3N+vVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCKtdax8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f054c567e2so216306a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715874581; x=1716479381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdxvUmUr/n3drhohz+SzK2EeawufACujFjOU7myXx/g=;
        b=OCKtdax8RaEjcT6ll2wchFCdJgdxIlTMQLmuPBH1y3KX5y6VnqJ9UlGT8M6/cJyr+y
         0vcDOAttls90GmtrQJuffSk9rt9wbJq3/KQRh7QOxPnwyE7TYNgIPDgDaSqWk03kZxg3
         Wbz8ncPYd6NF/6yXAT6RgAPiqXMa97yKdK1VssZk17Bc9GsAFOIgeDw0qtctBuBtoAec
         UfoBI3a/9FxcgJ+fJMjTJZdleTpt6R6wMlu+0lY9i7SHgUEOLN+eS+/X0ozNzSTpBz2R
         /IWyiOhF+N4yflWIeow4xmKkz9CaTQ/QIfK8NRjF6Kay8isZe+JrcVjnJVd6cIf3zrAn
         jZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715874581; x=1716479381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdxvUmUr/n3drhohz+SzK2EeawufACujFjOU7myXx/g=;
        b=LUMJyHWc58m5IRaWiJKlO78ZMJGym9XEpmYANOHxfrp4fTrH/o+b4n1D+oMjRGnmq/
         lOhR8K5ja3vkuQgiN80fobDM+c5qE8CyRPaF+zi6gIWOMs6XKpx4UxNw1lRyLRN9bImc
         skqrGItLpgmKNc91F8NoHm4yeuFpesKugYPmaToWMxrcHZmNqP+BZLzDAKpFwBC4LPwb
         JWTNq/wdQ3flx97Y5923hRUqe+oOlgIUeM8rcXd6UzpQqxA0OW8BT9uRrB9wJoVyCbUP
         O2GBooKYLPCwOGvtwFwLDAM78z9qWNINzkHXc8EQZewOkex4atfQDy57l2+zA8LizOuG
         oQjQ==
X-Gm-Message-State: AOJu0YzFnQ8wynGhIxlxl/YH1mpGX7a/psX0RfJlyvnPcv2iwJpaIGXy
	ZFuApmA9B8/BsY2FQ9zmAOOtlcdYJYdQw2pLr/CrBL+S1u6lnX7QpPP24dIF
X-Google-Smtp-Source: AGHT+IHTwAQvrUcBgReDLYo3j6uEenDDM0m6mgD/4TKTn44LluYWEepiGRIUA0sp3FRMMd0xbjb3LA==
X-Received: by 2002:a05:6870:c45:b0:239:7802:cd5 with SMTP id 586e51a60fabf-24172a4205emr22868219fac.6.1715874580898;
        Thu, 16 May 2024 08:49:40 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412a3c82edsm3562563fac.12.2024.05.16.08.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:49:40 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tanjore Suresh <tansuresh@google.com>,
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
Subject: [PATCH v6 2/4] driver core: separate function to shutdown one device
Date: Thu, 16 May 2024 10:49:18 -0500
Message-Id: <20240516154920.221445-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
References: <20240516154920.221445-1-stuart.w.hayes@gmail.com>
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
index e63177314e86..e76cba51513a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4819,6 +4819,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
@@ -4855,36 +4890,7 @@ void device_shutdown(void)
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


