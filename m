Return-Path: <linux-kernel+bounces-529316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE7A422F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70E53AE2EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD66D14884C;
	Mon, 24 Feb 2025 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPOBNDx0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29687664C6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406734; cv=none; b=tuyFY6fHk4XDe8jSYn26klceHXi6F8YM4ajv87K+wFHZPASBfVsl0pan5ATZL0G6aJciBa6Gohcuu6eljsYlww3Ch0NjnN9CfS738Ru4tp900K1EY1n5IJh0momQqnfieo+EfOPyEkn0eX1CDsQCHWA7PNSgupD0I+5M01WJaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406734; c=relaxed/simple;
	bh=XGy6ySdf82izw5K6kTl82Njx2t9JHfIhacnjeWsK05E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RDPmgP1wa9kfkj3SsYgiCUM9n5p1hnnWSea5SMOeAVyJBfWCAjAzd2FLYmMu1t00BCEeu8xiV2SsQK5wBRug99bhgshJ+vIPkmN5bjoIFBGoLTqCJ67tHgytyYf9SzhWb2TOsRMBOTz99sd5j0mh4qnfyv46pRG+GKBWiC9Q5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPOBNDx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCFAC4CED6;
	Mon, 24 Feb 2025 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406732;
	bh=XGy6ySdf82izw5K6kTl82Njx2t9JHfIhacnjeWsK05E=;
	h=From:To:Cc:Subject:Date:From;
	b=TPOBNDx029SXmHcLYeKjRmmBLYUvh+UMCB1n5W7o8yGin5F/yk/dxCP6KseDI5NEX
	 zvVctgn2wFyt4QIDTYlfKL6d0BSA2o7OyaZoUYcEUThdr8k48rY5tcD614hfmylF/x
	 BHM6MiEABHhwm+HpKop7lpbtkATvqJl0/b2kWMSsR5JnpfgH4/1NL0cXxFDWu25i+2
	 pc7VNlgLW7C1g2wUDJ9xBECnBWbUXFjYylSUpulkMImLQ2YbAXqK1oWB5eqk7X0Y3U
	 40vRrCZ0PmvfBa14OTPzP8qDJLskhjiypxEYSsybLV8shMaauDEe/Gkjx2OlzHnJSW
	 bx0I/UWpkRoUg==
From: Arnd Bergmann <arnd@kernel.org>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Joel Granados <joel.granados@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] reboot: hide unused hw_protection_attr
Date: Mon, 24 Feb 2025 15:16:09 +0100
Message-Id: <20250224141849.1546019-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The reference to hw_protection_attr is inside of an #ifdef block,
but the definition is not:

kernel/reboot.c:1092:30: error: unused variable 'hw_protection_attr' [-Werror,-Wunused-variable]
 1092 | static struct kobj_attribute hw_protection_attr = __ATTR_RW(hw_protection);
      |                              ^~~~~~~~~~~~~~~~~~

Add another #ifdef to match the first.

Fixes: 6f0ec17b2d82 ("reboot: add support for configuring emergency hardware protection action")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 5299790a2832..2d6a06fe6c66 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1071,6 +1071,7 @@ static int __init hw_protection_setup(char *str)
 }
 __setup("hw_protection=", hw_protection_setup);
 
+#ifdef CONFIG_SYSFS
 static ssize_t hw_protection_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
 {
@@ -1090,6 +1091,7 @@ static ssize_t hw_protection_store(struct kobject *kobj,
 	return count;
 }
 static struct kobj_attribute hw_protection_attr = __ATTR_RW(hw_protection);
+#endif
 
 static int __init reboot_setup(char *str)
 {
-- 
2.39.5


