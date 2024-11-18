Return-Path: <linux-kernel+bounces-412537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38039D0A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7967B282355
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B5A1891B2;
	Mon, 18 Nov 2024 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="G+gAL0pb"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8E1714A1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914993; cv=none; b=iW4QIKJkYdl6wjIdU9pB0dTg9zQiMBUThbcbU4+C81qzK/2lB7mWhr9AtqhHg1gMrRLq6KNAB7NIAZNDtPXWDFto4DBb4grXo0z9F2GugO+Esj836URaDXS0o/QVWcTGc5qKUU+ihrQeY4nC6k67ASRgcQtn0C/B1vPzezBowWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914993; c=relaxed/simple;
	bh=uagz0rNb9yNu8AS1b3iptSmA4T51iRjhi8SLaz65OpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixybl/DGtuPqnoQOw5YAUSJASBbCl4W6LR4b7LseA0zyl1gfWW1MBUBC48cqfl1+3WSpmrXVYuhMRAEtxqUL+W461j2dkIKmra7ofXxvn2tCn2X2GifnHX5kR2BkzmXEVSKZGF3USe3XrGne6Bg/chadkai1pN6sAb43OSg0Hok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=G+gAL0pb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=tGBxrzkqv227oRKatiTK1hbdP+UN67VHPWxn7DyvmWc=; b=G+gAL0
	pb0dqUV9tF43gdvBkJmhhOpluwo5w6M5oYgedT720Ciuk4c9AJ6MNf8SiKQlactI
	0e7cidwmb3i7uafLWeD3JDe2EIIpafWSm9EnY7s17sB1ltss0tM7iPdFR4Y8SjKS
	Z9+CJxxUkUEwA0506d8zFqQaOpM+wDG1GKf1YFgGFzaVs4QiAun/VYTFzZLH62gD
	Zb+lKSZUBTC6Rh2vhZBTgzlGvE4xz0mwkzBIbt9RoUmn87IgkPyNN0GMunYg1Xri
	ysr+NkHzGbJKSjU8j2p6BfIHnL7yhZHGyRJsMlbXXUywYX+ATMUnQz+FEm5qFTly
	rlkOg/YnsCyMZiWQ==
Received: (qmail 112383 invoked from network); 18 Nov 2024 08:29:37 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:37 +0100
X-UD-Smtp-Session: l3s3148p1@y4MB4Son1NUujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/15] coresight: etm4x: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:03 +0100
Message-Id: <20241118072917.3853-5-wsa+renesas@sang-engineering.com>
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0..559972a00fdf 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -23,7 +23,6 @@
 #include <linux/cpu_pm.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
-#include <linux/pm_wakeup.h>
 #include <linux/amba/bus.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
-- 
2.39.2


