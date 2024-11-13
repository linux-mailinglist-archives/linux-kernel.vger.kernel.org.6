Return-Path: <linux-kernel+bounces-408100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A179C7AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F6EB296EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAD203713;
	Wed, 13 Nov 2024 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKG05vaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31A2040B2;
	Wed, 13 Nov 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520581; cv=none; b=NBtGmwhdb28BusdDBdLBj0nDHKTt7z4ASg3eWtKTHEjXoxpRlv8zPafce2Y3ayEd7dzifFdFt8bwO/vX9ScCgN4bBFZEerb3ZGo5ZF2uMXxJirHrbBIbqUL8e3d00Yi8PDIi9k0WyS/VP5pZo7Oh780BAaP+8ppIIbuXcv3WCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520581; c=relaxed/simple;
	bh=AWo3GO4KFiwPMorT9Fffr4FZc9Q28ZY7KkvSFl3qFdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EYUTHLY9kf7QeI79slUmZxmLIiDB70mT+SsUTKpMAJLM5AakTLUYbYAdck/x0sQKeFCcDJ2hQGF/k/bmQzdF2BEX8LJT+lElZpGIAVXX5bZC+76DUoU13lerj/8S51CIo92aDPvfWU1z5aJxOfZAsJ6AkmCyXQpqaBZ5JqTyNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKG05vaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9880EC4CECF;
	Wed, 13 Nov 2024 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731520580;
	bh=AWo3GO4KFiwPMorT9Fffr4FZc9Q28ZY7KkvSFl3qFdw=;
	h=From:To:Cc:Subject:Date:From;
	b=uKG05vaXuHUg8KIHza6x4TdUnyxJEwXRvYkOH0g0wMRnD6rVC5sQGYb/AjMqurRGb
	 56DIOYtKRs/8vV7jQRQYT1+HsGnby+QFd1sXVZgc7nvdyD86Rkzjv40A1H5YEMp8C4
	 WNEyhm5RMxsXPRE6NedXIfFw3PZL7inUkNpf+8WCY9H3GHoCJpbuxGeLPBph1gFVui
	 MvRCs4eU9+ul+/JrB9wYLKXjP5R0/aVLb4dxa7v83XthO2ud3a/TrH60HYDR//Naxx
	 ymzB2ENPvD1Q3jzCUo9fClz3EY7OLfE52/A1WWykPwzjmnjpN5hW1BMiB6KWFL+Z3X
	 ks3qhzUweUVQw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frank Li <Frank.Li@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: tmp108: fix I3C dependency
Date: Wed, 13 Nov 2024 18:55:33 +0100
Message-Id: <20241113175615.2442851-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It's possible to build a kernel with tmp108 built-in but i3c support
in a loadable module, but that results in a link failure:

x86_64-linux-ld: drivers/hwmon/tmp108.o: in function `p3t1085_i3c_probe':
tmp108.c:(.text+0x5f9): undefined reference to `i3cdev_to_dev'

Add a Kconfig dependency to ensure only the working configurations
are allowed.

Fixes: c40655e33106 ("hwmon: (tmp108) Add support for I3C device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index f15e72b319af..dd376602f3f1 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2297,6 +2297,7 @@ config SENSORS_TMP103
 config SENSORS_TMP108
 	tristate "Texas Instruments TMP108"
 	depends on I2C
+	depends on I3C || !I3C
 	select REGMAP_I2C
 	select REGMAP_I3C if I3C
 	help
-- 
2.39.5


