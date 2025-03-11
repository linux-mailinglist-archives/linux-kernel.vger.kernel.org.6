Return-Path: <linux-kernel+bounces-555489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34953A5B85B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65C2616C84B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 05:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826901EDA38;
	Tue, 11 Mar 2025 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMoHLxpu"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93B1E9B36
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741670671; cv=none; b=dffSTLprKXOhjwW5XmLy0gTMazFh+7HjTrp0P2wfZ/teMSLprSmf/QMME18wml2LzQfuw19lEs8vIY2CPD1orhiTd81taqXOvXPodnUx5P2u6r+tr956B1EjNWXUcL4Q+XKu4b3RevtlLK6FgF05Dn1f/fw4bsw/ZYi0mFwZhso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741670671; c=relaxed/simple;
	bh=dsOfrlJy6yAaqyf3hq//zroUNzciUdyPDkxFIuYhLjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbmiYea1rVqodqTU0Y3HP4O/tXl0jsDkXw+E+x4B3S9e9IEe1gsDMjoE/5IrKB3INz/7vOOsJK3XrHUZA7FZm6E1fedL4kcDeuyCw7JH3gqp8XVbkaunh6YceEPaVl7T96gKYLVEEVVrCTJsDnh8/bgcuE0Odv5+Sy1R6Q8xJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMoHLxpu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso8459338a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741670670; x=1742275470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1pF4iddbaVG4MoDmL/AAVawCh8AKt5TVg4pkwPp5vg=;
        b=lMoHLxpu+gWWJ0/pijngAMID03WO69yUwYg7FISl5WFgtGgzX0uL79IYdGwED8SBvb
         VcWHIFIqAvzFgi6/x/eG84Iw33iY6eA7xRscv4maGA6KFu1k6TGdo0qM1MrLEyJZvKoY
         NVRhv4aSEUkQ8NFynkcRD/QPs/CnKM6G2gOwBUIu13uDErMUH4p7IqVwZa3peKbtCNRr
         2gmk+hSHh1GiEidsQ/EZW4qsMHvVlUCkeDQ/6LUlhXPHcVvskRgpw5iqZOOx0/EojLpb
         a+gPV93um7yu1LPMCA/F8COYT+LaTgAZq5QvCy611rygJ1U3cENdiMycfB/m2SkyFRXW
         yUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741670670; x=1742275470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1pF4iddbaVG4MoDmL/AAVawCh8AKt5TVg4pkwPp5vg=;
        b=AN7m7mLCUZq995538QdMGhK6ps9GPG99Av9vms6gvm+Gn8J7HlOWejr7SOg8zIBAtH
         kGKvI73CPzaP6V9/GjPsXgSlbs95jTtNyLDA/POv0NKbcq89HTeI/mR0UHuAbD1gNzVD
         tKr68KFN2MsJ4zn6JIauzRZG5DQFPXvLWgv4nOCNamSwPdOoX7uWZPG7KBX24Mj2grvZ
         DORLxS+dn31aAKe2aM1dQ8hubOHL/Oe1/Tkay/zolWVHHmrwH6l5dxzq1o4FN1JTHxBM
         h+ucyhsfTK9mh8bhkq476UmkoqmaocmeTdJkKQlkfDIWRWWRBRykSBF1EftGZsEfBPNA
         W94g==
X-Forwarded-Encrypted: i=1; AJvYcCVq0+i4gdpp1L1ve5PrbobIfkwYk9npXQXXXgdWyC94rYrGXnh8UpXLYcAdaAjsOOOV7cmaFrk5YOaUJBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvRrvG3JQXTz+4sBOzjt2cnnL/aTrlXfCC8rMrZInrTLy4IOYF
	zyIO2nD6R4Kd1YyraVm05NK/o59i+Cdk4z7/Hd4TrcrMbwu66/Xt
X-Gm-Gg: ASbGnctw3e9nki7XiizES22cqy8htjqJnrrFssGdzWo0h5AYmojYpouFT5MCgDGeP6b
	j+3jo5PA/qqD7kY8leKWCN89KImhekJC0O1+RPO2VXR/z/kXizyoMBUW3kew3hoMio/CKBDEDYV
	Ph5uS2ruJPqwe+4ODz3rk4eSoWv0CpaSYz5EDmbnjft1Jl+/0ic3IWH5nkLuXlMNND3UxJbcJkh
	PHQ+ZXLh+eNnp3dxxN97tM0Wd6GiMUUCj4pE+8GK6sIWiwtTAZrKVuxxhlEgWN6IWyhxJ410f19
	njFFM33+coUujO2j0xWJBm55OX9TX1JmRuc7xh4lil4yQDHxxcouQYvgv06VRtXH3Kk=
X-Google-Smtp-Source: AGHT+IHhs1lQ6X6CtvWTHpud0q4BG2BkXp27biYSAhd7U+SUwToDeF4LS8HbZBiz0l+qVfWeua7qzw==
X-Received: by 2002:a17:90b:2711:b0:2ff:71d2:ee8f with SMTP id 98e67ed59e1d1-30100559c7bmr3000643a91.13.1741670669506;
        Mon, 10 Mar 2025 22:24:29 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:eb9f:29c2:9ede:46d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693f7f0bsm9023649a91.46.2025.03.10.22.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 22:24:29 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v3 2/3] driver core: introduce device_set_driver() helper
Date: Mon, 10 Mar 2025 22:24:15 -0700
Message-ID: <20250311052417.1846985-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
References: <20250311052417.1846985-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to closing a race when reading driver pointer in
dev_uevent() code, instead of setting device->driver pointer directly
introduce device_set_driver() helper.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v3: new patch introducing device_set_driver() helper (suggested by
Rafael).

 drivers/base/base.h | 6 ++++++
 drivers/base/core.c | 2 +-
 drivers/base/dd.c   | 7 +++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0042e4774b0c..eb203cf8370b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -180,6 +180,12 @@ int driver_add_groups(const struct device_driver *drv, const struct attribute_gr
 void driver_remove_groups(const struct device_driver *drv, const struct attribute_group **groups);
 void device_driver_detach(struct device *dev);
 
+static inline void device_set_driver(struct device *dev, const struct device_driver *drv)
+{
+	// FIXME - this cast should not be needed "soon"
+	dev->driver = (struct device_driver *)drv;
+}
+
 int devres_release_all(struct device *dev);
 void device_block_probing(void);
 void device_unblock_probing(void);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index f9c1c623bca5..b000ee61c149 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3697,7 +3697,7 @@ int device_add(struct device *dev)
 	device_pm_remove(dev);
 	dpm_sysfs_remove(dev);
  DPMError:
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	bus_remove_device(dev);
  BusError:
 	device_remove_attrs(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..b526e0e0f52d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -550,7 +550,7 @@ static void device_unbind_cleanup(struct device *dev)
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
-	dev->driver = NULL;
+	device_set_driver(dev, NULL);
 	dev_set_drvdata(dev, NULL);
 	if (dev->pm_domain && dev->pm_domain->dismiss)
 		dev->pm_domain->dismiss(dev);
@@ -629,8 +629,7 @@ static int really_probe(struct device *dev, const struct device_driver *drv)
 	}
 
 re_probe:
-	// FIXME - this cast should not be needed "soon"
-	dev->driver = (struct device_driver *)drv;
+	device_set_driver(dev, drv);
 
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
@@ -1014,7 +1013,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 		if (ret == 0)
 			ret = 1;
 		else {
-			dev->driver = NULL;
+			device_set_driver(dev, NULL);
 			ret = 0;
 		}
 	} else {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


