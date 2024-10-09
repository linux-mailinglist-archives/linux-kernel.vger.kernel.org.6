Return-Path: <linux-kernel+bounces-357661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C409973DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5A081F24090
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8931E1029;
	Wed,  9 Oct 2024 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M605sFaC"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E261D356C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496679; cv=none; b=Rck0pPNEB235O/oxHCkvUWW2rze+IHPp/NwwJ0D2ZhFjetOOnRTbJIdlP3JUgH2+CPM+loNjw9oswxElGD81+TVhfXRXbm5u3oNE6DgJ1m/6Sa6eQ20gy1JTDvG9246mWiWOiPvikgCUEuQRNqha13Jb+NUcE+PpatKnbVRpWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496679; c=relaxed/simple;
	bh=0rTi+zR6nxurhg2CC++4MHJnM0nVd582QJCaKUM/Mtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8ovhcDMqdcA3zhs7R9waJj20SseGF05TcK1dZpULOk2rJgKhLZi6/ipMBY7anRUrscLrtMJBsxg2jb/mFMwbqduzlP2VXnFW4L+5f1ql/+9YvztZSvQPufPPCmbdpwAaZObXtV+hnLLIMFEgG0yiX0SNbIONSRf0IVOnbX9BIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M605sFaC; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5eec95a74so29123eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728496677; x=1729101477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuL/8aIw/afMIlL0zgRWmNHbdROCz4p8+8UOkY7QcKo=;
        b=M605sFaCeAnqFUREuGGjcrOl0ECktPNIuhB0zJZ3X4Ovx4gDyTqPcI7I+QQJxyROU4
         QkH8gd6FFTi1nc7k3Un4SoJUR46eVdN7kaBmVeFxoV0e5n9eL3i/6riJgeMe5OIF8aBP
         UbuP6va8ju6vMJLiXlaKiqHdvJz2wAbhLjSRggwSKu6hi2PgMpt5WoH03DH4L50154RR
         rxJYUXkVfi+2Des5lqcA50EPuoN0mMyXLLQJfQ5XhQ8eHDHCsOcIKyv/aM0W14Dr7LeW
         BmDqZIjGATB99sh/6mo+XcnorMbJJfYKEqDxjq4++EWzfq5LWdGkqL1mkEAagonZIrif
         6F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728496677; x=1729101477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuL/8aIw/afMIlL0zgRWmNHbdROCz4p8+8UOkY7QcKo=;
        b=eV3Kry033sb/oCzBXedzKBT+vpMQAWUQSnsnZqMmYVzPGHe3z66flQWnRTLTyeScos
         KdntBv6hYpws80CP8OzeLz6q7gko4rNrAVTW7bztTPtFItHkPn3MjsypFWmp7ks1he7+
         myzfRBCx7KJEI2jdYoYB1Yv2PBa7ppKGxZMHQNPkucpXIy8t+fd9spWU4uGJ9MwOoVVu
         HsUt/lrS6J22Jq7zkgsAKEMcUw/dJUmuvJOA3phm/kNNvkQGNg1QD+xLRxfyedihr7jN
         26Slz/gnxRy72lFo/WpKqinV9KPwF57KNWjmzjW0BzVlk4ilHS2Lvp+AkzOHM88jTAt+
         tvog==
X-Gm-Message-State: AOJu0Yx1Zp3EhwU2LBR+21kuEOoQaW+YTTwMIKS1VxhzZbGHUUy4J8x9
	NVh30SluVbEIaKh+Hmsbl1713L7yZ5w31Y33/sxqsC6tgrXwBxBiC60uwLKp
X-Google-Smtp-Source: AGHT+IE/e+vGPUrJ26IlI7cLrBAxrlVYHJ5MhFchi6chEvdYi6UN+vPbB7ACvmCE2pKN5Yd2RD2hpQ==
X-Received: by 2002:a05:6820:1992:b0:5e5:c49a:b53 with SMTP id 006d021491bc7-5e987c3014amr2857685eaf.7.1728496677079;
        Wed, 09 Oct 2024 10:57:57 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e7d711f219sm2442489eaf.9.2024.10.09.10.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:57:56 -0700 (PDT)
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
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v9 2/4] driver core: separate function to shutdown one device
Date: Wed,  9 Oct 2024 12:57:44 -0500
Message-Id: <20241009175746.46758-3-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com>
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
index 2bf9730db056..4482382fb947 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -4779,6 +4779,41 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
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
@@ -4815,36 +4850,7 @@ void device_shutdown(void)
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


