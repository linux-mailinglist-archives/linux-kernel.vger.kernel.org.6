Return-Path: <linux-kernel+bounces-320974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49529712E4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A3E2B23532
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1D91B29CC;
	Mon,  9 Sep 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+HBD4wZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498CF1B141B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872662; cv=none; b=hdI+AjXavsJUGlKs7KTwmqywkh1vU84/kvy5Bp3m82NmVnFDJMRhR+UCp/uU86fUsvb6ERalp402NioVkQCmqe1marQ743083A/LSKbNhEAeiMiLEGPDw1xKXASvQe1b9SQ5yM5ltijxc3v3fCk+H4mse4NT91R0LjrXfd95XYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872662; c=relaxed/simple;
	bh=21XZgZhhL5UrKCuLusQQvPQ+rZd4NBRQIgirkMHUuQU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dFds/kc9GZofusbSniyq6jbf9RzsjKSBCqQa3h5nMn18ygRZ2H+E/1iOgq/vtzFwLTVgDMtGh6sF9G6ACk8GRdf8VKma0mx8HNctTpv+LMB9uLqHl3G+BQXhnjt/aYbWCIizo430wmvbqce4afQ/FiFq+vPhWLHOAEsNTMFcnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+HBD4wZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F520C4CEC5;
	Mon,  9 Sep 2024 09:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725872661;
	bh=21XZgZhhL5UrKCuLusQQvPQ+rZd4NBRQIgirkMHUuQU=;
	h=From:List-Id:To:Cc:Subject:Date:From;
	b=A+HBD4wZpTR/Ado+/zpqSuVbg8SdVRW9jYJ9ZRrKeitPSVMMzQqYN+Euw7OdhPG2B
	 kdZgpgotkeHgfYeJ5E/mJi5HLB6ijqfYbGHc06HN+vWLKNFqfLdnt5OhTXOYkgkpvs
	 t4bw70fZKJnbBAlgcFQWHbRLYXoPV7FcaE2bbciFRjCE5MZc0/D5FWCSq8NDzqaZRO
	 DGOFSZikUaehqkiXQolI1Y2GLybWkpeyqID+iUY2oozgHhdkeOLsWbvNwCjPZgGeWa
	 UBgTZWaPaKesMVteHj79ApfNCxd1LYRhlf0nmHTKq9VyN5WYhJSvXeTtEwx3F0E44v
	 aPllUjdnpytqw==
From: Arnd Bergmann <arnd@kernel.org>
To: soc@kernel.org,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform: cznic: turris-omnia-mcu: fix HW_RANDOM dependency
Date: Mon,  9 Sep 2024 11:04:09 +0000
Message-Id: <20240909110417.247453-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There is still a build failure when the rwrng support is in a loadable
module but the mcu driver is built-in:

arm-linux-gnueabi-ld: drivers/platform/cznic/turris-omnia-mcu-trng.o: in function `omnia_mcu_register_trng':
turris-omnia-mcu-trng.c:(.text.omnia_mcu_register_trng+0x11c): undefined reference to `devm_hwrng_register'

Change the dependency to explicitly disallow the broken
configuration.

Fixes: 41bb142a4028 ("platform: cznic: turris-omnia-mcu: Add support for MCU provided TRNG")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/cznic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/cznic/Kconfig b/drivers/platform/cznic/Kconfig
index a111eca8ff57..49c383eb6785 100644
--- a/drivers/platform/cznic/Kconfig
+++ b/drivers/platform/cznic/Kconfig
@@ -70,7 +70,7 @@ config TURRIS_OMNIA_MCU_TRNG
 	bool "Turris Omnia MCU true random number generator"
 	default y
 	depends on TURRIS_OMNIA_MCU_GPIO
-	depends on HW_RANDOM
+	depends on HW_RANDOM=y || HW_RANDOM=TURRIS_OMNIA_MCU
 	help
 	  Say Y here to add support for the true random number generator
 	  provided by CZ.NIC's Turris Omnia MCU.
-- 
2.39.2


