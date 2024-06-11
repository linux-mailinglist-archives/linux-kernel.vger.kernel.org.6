Return-Path: <linux-kernel+bounces-209893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51832903C98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE799B212DC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708DA17D884;
	Tue, 11 Jun 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ExpJfHUt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892D17D357
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110887; cv=none; b=basxfu0v9mavOiJT7+4fHPEdRfAk/rCXJc5aRZSWY7oICdpGbC2naPAvwIityI7sfuc4gDkkyEIPSUPXhd1s3CAOjeTRCGQZ7QCtk95UYJfKLaNSInXg9+9OSmB1BBrmYF/IGjECyW87eg5mMY1G7m7W3Eo1wHSb2d30i8Yj8Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110887; c=relaxed/simple;
	bh=Ewiq4xx5eBrJ6zT/nXIgeEyinKpoSQ+oZEBy9wIt8XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLNu3fTp8wkW+CZdsDjeRToQU1ZwIUI9wOCoCXHqfZPOVY9n+KGvEuKiwJU0XMYw/oeYop3tKP0ah2Iiavvkn4ONJWqSNJeVRJZWjVQZqqNR6ZNYXqnAdSz6myb0qmcRKgTAJ5OpmC0Q2ISSk5QwD3/EV0i/K+px2KWtucLk728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ExpJfHUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71EAC2BD10;
	Tue, 11 Jun 2024 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718110886;
	bh=Ewiq4xx5eBrJ6zT/nXIgeEyinKpoSQ+oZEBy9wIt8XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExpJfHUtZVpo3xPrxe61mCjd28c9S6PDLKJqYjBXt549dNl0JuXG+A9ETEYZ3ta92
	 JzrZw476EKyMXQfqqCdAlk0dRuoEYbghtku5f6cWP0S8HI343QjzVnDthp+MdeXteB
	 iHoLdn9dHMhEZqy2tumDYd2T5qggqibr8tL98/dQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 5/6] driver core: make driver_detach() take a const *
Date: Tue, 11 Jun 2024 15:01:08 +0200
Message-ID: <20240611130103.3262749-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
References: <20240611130103.3262749-7-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=gregkh@linuxfoundation.org; h=from:subject; bh=Ewiq4xx5eBrJ6zT/nXIgeEyinKpoSQ+oZEBy9wIt8XA=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkZXpN+35bSqHKum7PbhdOlpW1hzOmu3/+s+tebTTjaz vLt8cvFHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARv9cM82sTD9ulR9Wo3Nnj Ib9YM+iy+YXHvgwL9gs8fZelM3nJpR06Z62aFimrKF4IAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

driver_detach() does not modify the driver itself, so make the pointer
constant.  In doing so, the function driver_allows_async_probing() also
needs to be changed so that the pointer type passes through to that
function properly.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/base.h | 2 +-
 drivers/base/dd.c   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index d332b87cde9e..9df8028c3201 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -158,7 +158,7 @@ void bus_remove_driver(struct device_driver *drv);
 void device_release_driver_internal(struct device *dev, const struct device_driver *drv,
 				    struct device *parent);
 
-void driver_detach(struct device_driver *drv);
+void driver_detach(const struct device_driver *drv);
 void driver_deferred_probe_del(struct device *dev);
 void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf);
 static inline int driver_match_device(struct device_driver *drv,
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index c24eca917d41..76b26096b033 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -863,7 +863,7 @@ static int __init save_async_options(char *buf)
 }
 __setup("driver_async_probe=", save_async_options);
 
-static bool driver_allows_async_probing(struct device_driver *drv)
+static bool driver_allows_async_probing(const struct device_driver *drv)
 {
 	switch (drv->probe_type) {
 	case PROBE_PREFER_ASYNCHRONOUS:
@@ -1333,7 +1333,7 @@ void device_driver_detach(struct device *dev)
  * driver_detach - detach driver from all devices it controls.
  * @drv: driver.
  */
-void driver_detach(struct device_driver *drv)
+void driver_detach(const struct device_driver *drv)
 {
 	struct device_private *dev_prv;
 	struct device *dev;
-- 
2.45.2


