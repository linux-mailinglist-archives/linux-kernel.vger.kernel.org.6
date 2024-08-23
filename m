Return-Path: <linux-kernel+bounces-298420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE095C709
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A28F1F22891
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB413D606;
	Fri, 23 Aug 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dVGWg5a+"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3813C80A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724399776; cv=none; b=d8JY8b5ApjYM7VuHG+wsmLJtKXkGkCMsYjHIc5gSSUGjfINLw/7AdLIwKE3d88mbtjzdBDS2RhuCZpoUKgyc9owlcFvMusOUwUIM9ERTtqfR6tWuk+kdFA/4xHic/y/pR8LCtfonoMtO0ut6oM9d61erbgEwpCkRFWkF3QqWpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724399776; c=relaxed/simple;
	bh=Ur66gQ2xbRGto3dKywxKhkwVyR35hNRMuakPBs2mDIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLlTF9uEVksUfJAkOWoSXPAthy6hXygv/f0BLhlRudKZIy/D0hEOuq+vPIm4Q810ThYMuSGh5nlrGJM3W+a0PlsN4j8JSfdYfDCXSCpQedm1vuggWqS1wgLNnZd4CKyms3rh69vPPMBilMljjKYkUpr7ugAJm5vJZaBD3BhF1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dVGWg5a+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724399772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wXsNfVPcmkrEmMW4LtduBkbPhK5/geuA+UgJn3R5/4U=;
	b=dVGWg5a+SHioMcvCiYzG0E9Ku/h/naEQ3dEjiNizKosq0R+t45ukuk+qISipoe3mYdK24S
	3m6DJXqA/76q9eCrR5euFO9IZaFZIbSJaIvvIl6zj0KBNRv1gChLqdXTMP1DvFP40vKSvx
	eT1OyLrjs9Usdk7F+7A/knLVsKwBIZc=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] platform: Make platform_bus_type constant
Date: Fri, 23 Aug 2024 15:55:44 +0800
Message-ID: <20240823075544.144426-1-kunwu.chan@linux.dev>
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
struct bus_type, move the platform_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/base/platform.c         | 2 +-
 include/linux/platform_device.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4c3ee6521ba5..6f2a33722c52 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1474,7 +1474,7 @@ static const struct dev_pm_ops platform_dev_pm_ops = {
 	USE_PLATFORM_PM_SLEEP_OPS
 };
 
-struct bus_type platform_bus_type = {
+const struct bus_type platform_bus_type = {
 	.name		= "platform",
 	.dev_groups	= platform_dev_groups,
 	.match		= platform_match,
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index d422db6eec63..7132623e4658 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -52,7 +52,7 @@ struct platform_device {
 extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
 
-extern struct bus_type platform_bus_type;
+extern const struct bus_type platform_bus_type;
 extern struct device platform_bus;
 
 extern struct resource *platform_get_resource(struct platform_device *,
-- 
2.41.0


