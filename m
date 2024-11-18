Return-Path: <linux-kernel+bounces-412545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431E9D0A53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20271B23BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03F198E77;
	Mon, 18 Nov 2024 07:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="MRyiiq3q"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8FC194AD9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731915002; cv=none; b=MsAI0Um9FExrbJxxE7MQDbtXHYIY1x0/548+1bWm9hotH61bMV1mBNbUeqjwuWjiA9Tfl61ISKIgC8oH/MHkCxTMED3PLvcCRJ0U4odegPIeFoVZ9cXCO7Z1k83HlcbGNiPkO0MMO9tQHpCvvDa3yppUMc/jPOKdMUEFsRlUwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731915002; c=relaxed/simple;
	bh=yYejkGVmhQSxgt1LSIBLxXNAaQ3bld9Y7GYMSQUvulw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsHdxz8BL7khy10rW+0cmAWNpn0ggOUfUzcLi3/TqgaPHlEZqptxG99X6pqN4073Y7KNjCN1bamAObgY7yU/kxDu+YdxZ+XLT2XKAFAVi+/dXTEpzvNZT3faiGudKndzHB/ZEabVYrvZP1pQiwp6l5EA3HasvtTb48mbTJe/p40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=MRyiiq3q; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=AlqpJCs+yskoKvKohsqem2hmeNhPOpiYtkfKCY3Ow1c=; b=MRyiiq
	3qPpvACKY9KB6T1Lip1KaWBB5nUTjb/Igib5RranATGY+fzHThzQgYbJ3U3Jkubd
	cZIVqg3Mp13A1CLFKLKPetHV8AlU9VVKtoAFPkq5oYeeWcim0PmOARvTUa8mxA81
	hN1a0GcudWIEw6y7T9/QtLniRwxGOHAZUvPYctJdto8Z0PfpdWpxxbK4TwtrdP4O
	/hpWmQgF59Vqvywf9lJr/oXm/dIpcwvAo4cww1Pm3bs2cMphkexQTn9hpSeuNunY
	XwAJjk997eyCM9dd/yaBJIrO6XAph1CpJ0Mie2APjvAVSxkYpCgMr8eGNq51sJ9p
	T8nEDGEfJtXcOIdA==
Received: (qmail 112550 invoked from network); 18 Nov 2024 08:29:42 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:42 +0100
X-UD-Smtp-Session: l3s3148p1@qrVM4SonqIYujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 12/15] platform/x86: quickstart: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:11 +0100
Message-Id: <20241118072917.3853-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/platform/x86/quickstart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/quickstart.c b/drivers/platform/x86/quickstart.c
index 8d540a1c8602..c332c7cdaff5 100644
--- a/drivers/platform/x86/quickstart.c
+++ b/drivers/platform/x86/quickstart.c
@@ -20,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
-#include <linux/pm_wakeup.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-- 
2.39.2


