Return-Path: <linux-kernel+bounces-297548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7167495BAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F21B3B222E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4BB1CC899;
	Thu, 22 Aug 2024 15:39:21 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF9A1C9ECE;
	Thu, 22 Aug 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341161; cv=none; b=GVGY+L/CZkYxrwT8cnWkjvT35QWe60WeQfeHrktAM5cegylKrnmgv6vAoNv/nI+5qlWD1px8rnUc0ERhMa8HUX97Q/+L7qRL2v0RaQEZ76Tc6tDYp37+4OUEnRBs8oVuRrnsyBY9iZLFKxasPjDX/Yy4g3f5/+7kROOpaw0pIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341161; c=relaxed/simple;
	bh=00XpW/Z7rKIVaG9iuy1gYpInRutT2SI9B/JtwNeNIH8=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=XlrRpP7nF/m5+lAQTuZMDFWhpJK3K8VqQXohTQ9Jfj9zu79d4rSRWMr0BVytKmKGmeDXZlequnQThodEy/u0L3nl7nxEaodWz3hpIchV2F7pM9hmdOE5wmCJWjXP4oPDPkKvaIHjr8XdLqg9pNHsjlkbhJlRvVa/k9l5aCOQGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69d44.dsl.pool.telekom.hu [::ffff:81.182.157.68])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000074DF4.0000000066C75B9E.001CDB97; Thu, 22 Aug 2024 17:39:10 +0200
From: Gergo Koteles <soyer@irl.hu>
To: Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] platform/x86: lenovo-ymc: Ignore the 0x0 state
Date: Thu, 22 Aug 2024 17:38:57 +0200
Message-ID: <08ab73bb74c4ad448409f2ce707b1148874a05ce.1724340562.git.soyer@irl.hu>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

While booting, Lenovo 14ARB7 reports 'lenovo-ymc: Unknown key 0 pressed'
warning. Because lenovo_ymc_probe() calls lenovo_ymc_notify() and that
time the YMC part is not triggered yet (which is mandatory for this
model). At the end of lenovo_ymc_notify() YMC is triggered by the
ideapad-laptop driver and then lenovo_ymc_notify() will be called by WMI
to report the actual value.

Add 0x0 YMC state to the sparse keymap to ignore.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/platform/x86/lenovo-ymc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e0bbd6a14a89..bd9f95404c7c 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -43,6 +43,8 @@ struct lenovo_ymc_private {
 };
 
 static const struct key_entry lenovo_ymc_keymap[] = {
+	/* Ignore the uninitialized state */
+	{ KE_IGNORE, 0x00 },
 	/* Laptop */
 	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
 	/* Tablet */
-- 
2.46.0


