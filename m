Return-Path: <linux-kernel+bounces-406510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A4F9C6027
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8551F21FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96D215C4F;
	Tue, 12 Nov 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqktWRkr"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2704F213154
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435461; cv=none; b=FVaJZ4oWhivWaUBXQ45RZhl7SbrvVu6UvIzUzsoT4w5+o+d8x0JPmakgoWiLYeTZk5A2r7wAsFh9RMCexoZIv43dPSPWjdFuUFyzkqyvJsRabEhaRXBQAbEHWOt0bdbLXZmqGMSboJwV6VVGgvpm7BWWAzox1VL+2roIU5bmqqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435461; c=relaxed/simple;
	bh=Y/dTUHtupuwcj2O5IbQXs4jsi2wuCJhyQ67B6Au6hbM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZuYCwxd/Bairf0qGs2Hg/lcKYSlmPlYVLz+egG0RU+0RGfbdKZec2x/rBhlUYNXLbzWoX1vBvHCDkcVo4H/UD3OPOeoUC0gvSoXVqe/uoJ9xfWW6Q7oMG5yhDNo8mBAZCLZZ6GW42VkrQC+S+EwbCIv7qBXOQ+3rQ3sfVU5MvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqktWRkr; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-720be27db74so9372b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731435459; x=1732040259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GXTXOEOysyHBE0iWhZWDRL8SYdiQsYVa+Qbm4+nz9U=;
        b=kqktWRkrmoXxab652o6/719qii5L5aTn8kE6E+cXwSrVBnh4Lcc0Z2p9mCBwMo/clR
         N1qpVKHDQWPMPYlwli34LNI2fx0fZNLeZYwXqR4l0vSRHkFeqi727M/RHR3CiWCiADM2
         tr9ZYdDSzy1aTyPiVwGG6byWUazSqt6IlbwySDLCNgPs681J3DA7maNRZJtg2vqCEYhD
         gYO1u7d89YdHqpnAstczK3+N7XIihRGEw0lR2EXlkUZ95qVI39V9QSpyk6D8St0XGcMs
         OqlicvmMNY0DDQvhnnDOGgKedW2HFRLe2sPgfkaMMDK5gJfqvDToFEpoZVfmKn1AbtYY
         AXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435459; x=1732040259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GXTXOEOysyHBE0iWhZWDRL8SYdiQsYVa+Qbm4+nz9U=;
        b=cs5doTAUryTn+D2yqubwTaJgjqtiILf3I24yd3YCNqAmrZzBl/xNmEuXgKoLes1z3c
         jTeRZ1u7VQTi19YCEnZKVZHJ0VNNsK3FlxiXi9aXQuHPMgAQI1JyAL1AofAuv946cbFl
         jPE+rnxQEB5BXLObXAjtorwjP6WeRKO8j85BcnTQqgBWHBnto3pFEqsvGmglCjoKPBRx
         xsFDAIS+q5dydfUw0rmn/XulCi+FVRmyJlDANBmbpXwuQMYUtMfRPQwITiNdlCc655qa
         HNDuMYe8ms2sNKpZU+bTH8v1hvO7TPdZPeYkn8ir+Gb5vR9VIA+cImstaA4ieETPjMLl
         zNAg==
X-Gm-Message-State: AOJu0YwCebwtQrCCNV/j/qtSWbx1Vi4R7uu2fMcuoSWVJ/fF6DzhxEz5
	TxRf77vd0LstYLWAvxwg/hFdMzZ/n8uhrwH8Vo3a98ZWb+1xrC4Z
X-Google-Smtp-Source: AGHT+IH6v89oidzb1PXNHFBYdMfrv40Aj6dM057UgbaufnO9zh9gKbduRZoKhwu7Hg99JX0sOPDFSw==
X-Received: by 2002:a05:6a00:a1a:b0:71e:71ba:9056 with SMTP id d2e1a72fcca58-7241407b632mr25047758b3a.10.1731435459193;
        Tue, 12 Nov 2024 10:17:39 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([124.127.236.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3a9csm11430045b3a.110.2024.11.12.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:17:38 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>
Subject: [PATCH v2] driver core: Fix concurrency issue in match driver interface
Date: Wed, 13 Nov 2024 02:17:33 +0800
Message-Id: <20241112181733.148068-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch identifies a concurrency issue. Taking the fsl_mc_bus_match()
function as an example, fsl_mc_bus_match() is an implementation of the
drv->bus->match interface. Since the entire function is not protected by a
lock, it can experience a data race with the driver_set_override()
function. The driver_set_override() function is provided by the driver
core, and in this function, the driver_override field is updated while
holding the device_lock.

After the check if (mc_dev->driver_override), the driver_override field may
be set to NULL, but the strcmp() function does not handle the case of a
NULL pointer. If the empty driver_override field is passed to strcmp(), it
could lead to a null pointer dereference issue. Additionally, we noticed
that in the driver_set_override() function, after storing the new dev
value, the old value is released. If a race condition occurs, this could
lead to a use-after-free (UAF) issue in fsl_mc_bus_match().

The only reference to fsl_mc_bus_match() is through the drv->bus->match
interface, which is a typical example. Many drivers, such as amba, base,
cdx, and others, have similar implementations.

To fix this issue, we examined the interface that calls this function and
found that the fsl_mc_bus_match() function is called by the drv->bus->match
interface, which in turn is called by the driver_match_device() function.
We discovered that there are three places in the code where
driver_match_device() is called. In the call chain from __device_attach to
__device_attach_driver to driver_match_device, the call to
__device_attach_driver within __device_attach is already protected by a
lock, so the call to driver_match_device in this chain is locked.

Since the driver_set_override() function, as mentioned earlier, is called
in several drivers, including amba, base, cdx, and others, this data race
issue is relatively common. Adding a lock at the lower level would conflict
with the lock in the upper-level __device_attach(), leading to a potential
deadlock. Therefore, we decided to add locks at the other two places where
driver_match_device() is called to ensure that when the match interface is
invoked, it prevents changes to the driver_override field during the call
to driver_set_override(), thus resolving the data race issue.

Fixes: 49b420a13ff9 ("driver core: check bus->match without holding device lock")
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
In 2008, the kernel moved all match checks outside of the lock, and at that
time, there was no override, so this approach worked. In 2015, one function
moved the match check into the lock on one of its paths in order to support
asynchronous device binding, which led to inconsistent behavior. Later,
some kernel drivers added the driver_override feature to support binding
specific drivers, and the driver_set_override function was widely used to
control it. This function uses device_lock to control concurrency. This
issue is caused by both lower-level drivers and upper-level drivers, so
I'm not sure if the fixes tag is correct, and I haven't added a cc. I hope
to discuss this issue with the developers.
---
V2:
The incorrect description have been fixed.
Thanks Greg KH for helpful suggestion.
---
 drivers/base/bus.c | 16 +++++++++++-----
 drivers/base/dd.c  |  2 ++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0d..78d8c58fc50c 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -261,13 +261,19 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
 	const struct bus_type *bus = bus_get(drv->bus);
 	struct device *dev;
 	int err = -ENODEV;
+	int ret;
 
 	dev = bus_find_device_by_name(bus, NULL, buf);
-	if (dev && driver_match_device(drv, dev)) {
-		err = device_driver_attach(drv, dev);
-		if (!err) {
-			/* success */
-			err = count;
+	if (dev) {
+		device_lock(dev);
+		ret = driver_match_device(drv, dev);
+		device_unlock(dev);
+		if (ret) {
+			err = device_driver_attach(drv, dev);
+			if (!err) {
+				/* success */
+				err = count;
+			}
 		}
 	}
 	put_device(dev);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f0e4b4aba885..0b894719eb28 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1169,7 +1169,9 @@ static int __driver_attach(struct device *dev, void *data)
 	 * is an error.
 	 */
 
+	device_lock(dev);
 	ret = driver_match_device(drv, dev);
+	device_unlock(dev);
 	if (ret == 0) {
 		/* no match */
 		return 0;
-- 
2.34.1


