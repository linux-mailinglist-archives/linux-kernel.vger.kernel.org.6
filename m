Return-Path: <linux-kernel+bounces-224071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C67911CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1F52821D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF9716C879;
	Fri, 21 Jun 2024 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZxXVfpDa"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E916E882
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955035; cv=none; b=Jn3vf3LqmDyctfqRxM44yuAAcOhyKGKASUMqmNmzRK4DEx/fJLFON6DVwHUiQudXEE+GRaLa7O8PiE/b32fK0h55kStTIXej1Ng4SJ2EOZ+UrOGUzitbHXB3H2xMnbsRXIDRfUn5LbMCe8r3jT5R9Xx3Pm8R8P9Sr8enRd1SpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955035; c=relaxed/simple;
	bh=X8INLkskdkYTHO9nLO+bqJ3aacRr5rFB23PLTToBN9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXFAEy+SegtZclzyC7wAH4tS7yBLiaUefo+et4fBDjKMbm7ozGvv8b5YXletI5qZj2Wl3cngSbGQzBcErsCmLyM6D+2qWteQcITW2q7LyE68mPeQNYB+ymJtM+RyFKAr61UhU8Dnti2qR/eO2Zv7f/MyR+8I25bV/xXvNTM8fCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZxXVfpDa; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=DWqmJaYmk7gfwFyT7gufw56IyMYdyCsAGXbbSjiY3n0=; b=ZxXVfp
	Da1ik4V4mvkkHeHMjxdeMRcprHpBymgYHmxAAjWaGePsGR6z26V/SH8U9SMz3B63
	rLYcn9+qsLZK8fnurJxK6FYSKx6WyAz7z9ztlAY0WSHPP/ATNBl125RKjnD8o4i7
	kvJYKanq6GEWKxj9X90/cjCn69QYqiRAQd/cDKujxQMMVT+QwiyhveBM/u3x6nzE
	Z6gcSPWOa4d4aplRSRGPAf0GhC7EsCYuT6cXFN/W1gJeNdikaP9D+hpW2oVlXthF
	zttPYVnZvijhDwwZC6ZWn8im6PpmBAMPV/mhOzVOZyPLg6JwjIh/4+8ArgcNAnlQ
	ArMHLjLWw283xi3Q==
Received: (qmail 1279191 invoked from network); 21 Jun 2024 09:30:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Jun 2024 09:30:32 +0200
X-UD-Smtp-Session: l3s3148p1@2mPHZ2EbFpAgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v4 6/6] docs: i2c: summary: be clearer with 'controller/target' and 'adapter/client' pairs
Date: Fri, 21 Jun 2024 09:30:13 +0200
Message-ID: <20240621073015.5443-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621073015.5443-1-wsa+renesas@sang-engineering.com>
References: <20240621073015.5443-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This not only includes rewording, but also where to put which emphasis
on terms in this document.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/summary.rst | 41 ++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
index ff8bda32b9c3..579a1c7df200 100644
--- a/Documentation/i2c/summary.rst
+++ b/Documentation/i2c/summary.rst
@@ -31,9 +31,7 @@ implement all the common SMBus protocol semantics or messages.
 Terminology
 ===========
 
-The I2C bus connects one or more *controller* chips and one or more *target*
-chips.
-
+The I2C bus connects one or more controller chips and one or more target chips.
 
 .. kernel-figure::  i2c_bus.svg
    :alt:    Simple I2C bus with one controller and 3 targets
@@ -41,28 +39,37 @@ chips.
    Simple I2C bus
 
 A **controller** chip is a node that starts communications with targets. In the
-Linux kernel implementation it is called an **adapter** or bus. Adapter
-drivers are in the ``drivers/i2c/busses/`` subdirectory.
+Linux kernel implementation it is also called an "adapter" or "bus". Controller
+drivers are usually in the ``drivers/i2c/busses/`` subdirectory.
 
-An **algorithm** contains general code that can be used to implement a
-whole class of I2C adapters. Each specific adapter driver either depends on
-an algorithm driver in the ``drivers/i2c/algos/`` subdirectory, or includes
-its own implementation.
+An **algorithm** contains general code that can be used to implement a whole
+class of I2C controllers. Each specific controller driver either depends on an
+algorithm driver in the ``drivers/i2c/algos/`` subdirectory, or includes its
+own implementation.
 
 A **target** chip is a node that responds to communications when addressed by a
-controller. In the Linux kernel implementation it is called a **client**. While
-targets are usually separate external chips, Linux can also act as a target
-(needs hardware support) and respond to another controller on the bus. This is
-then called a **local target**. In contrast, an external chip is called a
-**remote target**.
+controller. In the Linux kernel implementation it is also called a "client".
+While targets are usually separate external chips, Linux can also act as a
+target (needs hardware support) and respond to another controller on the bus.
+This is then called a **local target**. In contrast, an external chip is called
+a **remote target**.
 
 Target drivers are kept in a directory specific to the feature they provide,
 for example ``drivers/gpio/`` for GPIO expanders and ``drivers/media/i2c/`` for
 video-related chips.
 
-For the example configuration in figure, you will need a driver for your
-I2C adapter, and drivers for your I2C devices (usually one driver for each
-device).
+For the example configuration in the figure above, you will need one driver for
+the I2C controller, and drivers for your I2C targets. Usually one driver for
+each target.
+
+Synonyms
+--------
+
+As mentioned above, the Linux I2C implementation historically uses the terms
+"adapter" for controller and "client" for target. A number of data structures
+have these synonyms in their name. So, when discussing implementation details,
+you should be aware of these terms as well. The official wording is preferred,
+though.
 
 Outdated terminology
 --------------------
-- 
2.43.0


