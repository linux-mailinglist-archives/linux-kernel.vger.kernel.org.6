Return-Path: <linux-kernel+bounces-412539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 521979D0A43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E152CB22506
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BB7192597;
	Mon, 18 Nov 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WOVk2pdU"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E0186E2E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914995; cv=none; b=tCG5wGKgUmak16urKs8vqeFSHZDCDE1Ud/hQPoqRIj+GpUizM+SauU7Ff3C7yzm8zc84fO2ahrYlMDMY0U5t950FHCSZ6355Dvn7ZtheDK2pq2Eb88FZOLkO5mOs0S/A2cCM4+5jIA6yTRTcBs1aGL6hzmEw/e/EAkgRFnNPlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914995; c=relaxed/simple;
	bh=kfG0y9K+O0idmwwz3aV0NXnyQm6c+F/DJ73QLT35W9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6QHBUhr8Guwwe74ByXZf7s11i8SsYbpu9kervPA+dYGUWtZ+1UmEcBgRgtHixqmRq9Fw2/aVby+0CYr2qjUPNvWPl/YqY6WpIWAsrrXWNsZUx/1q1XJyCAahMoXCtbiz9YXfPoUMVgE31gV7kkYWU1vytfoSIwhVBFj31/jFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WOVk2pdU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=aAd/+tR/6amb3iC4y9aIm0hPICd8LWcv5HI4xQzRV/c=; b=WOVk2p
	dUoujkGOyrKFrqsvR767kNsLYhPt+wyZFiZbpLM9wjTE6mQGSaWnJo9tUvK8W8xj
	5BW/0k+Muhwq21b/HjtmDzce+eyKIdLGm6LTdGu0/vAX27RV9e6vpg0JJs85EbJM
	qcoFSkfXzTMXlTcvCRLEvqMfGj9PB/M8S5265ESzDZG+av0P0Hhgv71gew7yE9Pf
	Oucie6QaZ5XnM/7DpUa1qIqq3rv0WiQ6SsIUHCT4kkY8OHcnD32C/vSmfoO3xk8w
	lqyryIpg2WwKcZeQZ6pKUh1g7pEw99qaK7E+DzEsXFGu9ZWb0mKx1fMeLPcv1O2q
	9uxbre/f6DNFc62Q==
Received: (qmail 112434 invoked from network); 18 Nov 2024 08:29:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:38 +0100
X-UD-Smtp-Session: l3s3148p1@0+IT4Son8tUujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 06/15] Input: sun4i-lradc-keys - don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:05 +0100
Message-Id: <20241118072917.3853-7-wsa+renesas@sang-engineering.com>
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
 drivers/input/keyboard/sun4i-lradc-keys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c b/drivers/input/keyboard/sun4i-lradc-keys.c
index f304cab0ebdb..9a4fdef2650e 100644
--- a/drivers/input/keyboard/sun4i-lradc-keys.c
+++ b/drivers/input/keyboard/sun4i-lradc-keys.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeirq.h>
-#include <linux/pm_wakeup.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
-- 
2.39.2


