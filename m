Return-Path: <linux-kernel+bounces-298369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DC095C653
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 182E6B22AC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022913AA2A;
	Fri, 23 Aug 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqKIrPsG"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1D56B7C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724397266; cv=none; b=eHxu99H38Tvkrob7SLhVSH1OuKNUFKN9KHkHGkjuw9vJlVrPwjvLHQsfBKHDmoqjkLA62xZ7ftVOgj4RT3lbqyAgbEGvrQNgaf5tnch5IoR2ebsmc2+kpR3Q5LnQIUvj1zq+tGFVwvD5hd9KGaBlS5J+M8cMo95lcrePNGvBvuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724397266; c=relaxed/simple;
	bh=5nft/KliCoQs2Uu6eBpsf+2Zd9Bm1mXVFdrP0Rkbr+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PasTDf+wI7ibR8RnNPwIkuT+rTZor/LFtPrbvCZyUJpTx40k2N/Qim3X5iU8LWvmuvCOJB2jzqsWzw5K7cCazOrO24GIQqqOQJrwezXlK/qeoZVg2/IP+lJdt+cyOeI3xpOQDEeRHjCAx3u6eQnZiKUy3gxqyUAkKITmIlfhu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqKIrPsG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724397262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x16rzROS5ipIsbNhe8+EPAh6NBZTMRY9OCgFaADVYgY=;
	b=pqKIrPsG/OeI52J5+EzieLWSfc4INn39OwgfK6xgMZaYlqqk+pmXOyk/N5dlZ65reAwyF+
	sGI9pwY46B7Vi1H54AbycFAyrTHez84l4gxqhAM0CbwtyG3XuuU0w5Pp/OnkgrKv6mvTga
	ihj/UYMfnNsMDa+z4ny/29w/6eZmzfs=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] cdx: make cdx_bus_type constant
Date: Fri, 23 Aug 2024 15:14:12 +0800
Message-ID: <20240823071412.130246-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the cdx_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/cdx/cdx.c           | 2 +-
 include/linux/cdx/cdx_bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 07371cb653d3..e92164ae88a9 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -643,7 +643,7 @@ static struct attribute *cdx_bus_attrs[] = {
 };
 ATTRIBUTE_GROUPS(cdx_bus);
 
-struct bus_type cdx_bus_type = {
+const struct bus_type cdx_bus_type = {
 	.name		= "cdx",
 	.match		= cdx_bus_match,
 	.probe		= cdx_probe,
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index 79bb80e56790..b1ba97f6c9ad 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -234,7 +234,7 @@ int __must_check __cdx_driver_register(struct cdx_driver *cdx_driver,
  */
 void cdx_driver_unregister(struct cdx_driver *cdx_driver);
 
-extern struct bus_type cdx_bus_type;
+extern const struct bus_type cdx_bus_type;
 
 /**
  * cdx_dev_reset - Reset CDX device
-- 
2.41.0


