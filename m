Return-Path: <linux-kernel+bounces-244025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C801A929E22
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E511C21B64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59536376E9;
	Mon,  8 Jul 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eRXQCSQA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960752D611
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426554; cv=none; b=UtzHZIdX5UsCx7w2R347pLv9yRZEB6AfBxd3Y39KETYpbfBCVjcyRC05yUehrxserZ/0+dn2pe3y1hc+7a9J8fL5rCwNVBIN/zrROwlM7xoT9H13QWsal6PuryTxpbC2UlN8yWD6oD/m19mQil+6voC63lGc7P87y4Bty8FCsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426554; c=relaxed/simple;
	bh=Pmkg/VBczEI3GcD1L/d7HTmxj0h/61tF+5xHjYgikZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPJitUTcdFZRZLInzXJsQ61153MDPHb286HK/rSll5DxYXISoZFo1znML5qGQZpOiLHK5eZr2ZZ/tzkDh0BQ6WDe9kGM00lqp7C/8WLVIyJQAoRJTatl1YRz9WWdgaOEoQWFbYPFgJz/v2E2IMvx1XqwgssfIIqgaVi3wqdv71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eRXQCSQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91134C116B1;
	Mon,  8 Jul 2024 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720426554;
	bh=Pmkg/VBczEI3GcD1L/d7HTmxj0h/61tF+5xHjYgikZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRXQCSQAQfv/fDjvqhDd1ZW+ZlpT5ckLVcH3SRYzDHFiKkGb0CbqKIBmsS3tIZwRF
	 B2swj8K3G+xCfHhdPeVFpkrSKUtjP0Xl1IIWYa8dg5F+l2ubfNHsAAbQre4kz2TyP6
	 ONOrJrTmloQMaS1jVNig7LEv3Cwiene/mrwIKeRk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 2/3] driver core: make driver_find_device() take a const *
Date: Mon,  8 Jul 2024 10:15:46 +0200
Message-ID: <2024070849-broken-front-9eb5@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024070844-volley-hatchling-c812@gregkh>
References: <2024070844-volley-hatchling-c812@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 96
X-Developer-Signature: v=1; a=openpgp-sha256; l=4228; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=Pmkg/VBczEI3GcD1L/d7HTmxj0h/61tF+5xHjYgikZ4=; b=owGbwMvMwCRo6H6F97bub03G02pJDGndC0zzu2rdrkvE1xvMT/I4bltTl+HH6cjQLXTuq/sE8 b8Xri3qiGVhEGRikBVTZPmyjefo/opDil6Gtqdh5rAygQxh4OIUgIlM3MWwYKqWkM+9a2/XOVdN njKN532/8pt/6Qzz/TrXs37imy4zQ+yWkVons7DEz1xfAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The function driver_find_device() does not modify the struct
device_driver structure directly, so it is safe to be marked as a
constant pointer type.  As that is fixed up, also change the function
signature on the inline functions that call this, which are:
	driver_find_device_by_name()
	driver_find_device_by_of_node()
	driver_find_device_by_devt()
	driver_find_next_device()
	driver_find_device_by_acpi_dev()

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/driver.c         |  2 +-
 include/linux/device/driver.h | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 3eeafdb79d0e..88c6fd1f1992 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(driver_for_each_device);
  * if it does.  If the callback returns non-zero, this function will
  * return to the caller and not iterate over any more devices.
  */
-struct device *driver_find_device(struct device_driver *drv,
+struct device *driver_find_device(const struct device_driver *drv,
 				  struct device *start, const void *data,
 				  int (*match)(struct device *dev, const void *data))
 {
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index dceb36f1c42c..1fc8b68786de 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -155,7 +155,7 @@ int driver_set_override(struct device *dev, const char **override,
 			const char *s, size_t len);
 int __must_check driver_for_each_device(struct device_driver *drv, struct device *start,
 					void *data, int (*fn)(struct device *dev, void *));
-struct device *driver_find_device(struct device_driver *drv,
+struct device *driver_find_device(const struct device_driver *drv,
 				  struct device *start, const void *data,
 				  int (*match)(struct device *dev, const void *data));
 
@@ -165,7 +165,7 @@ struct device *driver_find_device(struct device_driver *drv,
  * @drv: the driver we're iterating
  * @name: name of the device to match
  */
-static inline struct device *driver_find_device_by_name(struct device_driver *drv,
+static inline struct device *driver_find_device_by_name(const struct device_driver *drv,
 							const char *name)
 {
 	return driver_find_device(drv, NULL, name, device_match_name);
@@ -178,7 +178,7 @@ static inline struct device *driver_find_device_by_name(struct device_driver *dr
  * @np: of_node pointer to match.
  */
 static inline struct device *
-driver_find_device_by_of_node(struct device_driver *drv,
+driver_find_device_by_of_node(const struct device_driver *drv,
 			      const struct device_node *np)
 {
 	return driver_find_device(drv, NULL, np, device_match_of_node);
@@ -203,13 +203,13 @@ driver_find_device_by_fwnode(struct device_driver *drv,
  * @drv: the driver we're iterating
  * @devt: devt pointer to match.
  */
-static inline struct device *driver_find_device_by_devt(struct device_driver *drv,
+static inline struct device *driver_find_device_by_devt(const struct device_driver *drv,
 							dev_t devt)
 {
 	return driver_find_device(drv, NULL, &devt, device_match_devt);
 }
 
-static inline struct device *driver_find_next_device(struct device_driver *drv,
+static inline struct device *driver_find_next_device(const struct device_driver *drv,
 						     struct device *start)
 {
 	return driver_find_device(drv, start, NULL, device_match_any);
@@ -223,14 +223,14 @@ static inline struct device *driver_find_next_device(struct device_driver *drv,
  * @adev: ACPI_COMPANION device to match.
  */
 static inline struct device *
-driver_find_device_by_acpi_dev(struct device_driver *drv,
+driver_find_device_by_acpi_dev(const struct device_driver *drv,
 			       const struct acpi_device *adev)
 {
 	return driver_find_device(drv, NULL, adev, device_match_acpi_dev);
 }
 #else
 static inline struct device *
-driver_find_device_by_acpi_dev(struct device_driver *drv, const void *adev)
+driver_find_device_by_acpi_dev(const struct device_driver *drv, const void *adev)
 {
 	return NULL;
 }
-- 
2.45.2


