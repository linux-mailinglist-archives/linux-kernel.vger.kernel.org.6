Return-Path: <linux-kernel+bounces-192239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5638D1A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1B0B26892
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D216C875;
	Tue, 28 May 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSw92NH1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD48E4C97;
	Tue, 28 May 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897585; cv=none; b=NjXZQcbfroR8K55f0XT6bvzgInRMELDnjPLrtCvzCwLlMaeUkR4CP6BT8nxUH/BOjlU+COb7oqd9XiSbhA8lZk1G8NhNVZIfL1DNTDDKzRakLalfi5jFNnZQZN2UG+TT7TLgAsObA6IC7w6u0Hv8LJvNkSoKw/pApKWcdlRfFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897585; c=relaxed/simple;
	bh=PJ6dm+ojt4tB8KatVUHmNd4ox8+zoZGcn/Tu/Vumpvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dbLnErrhZaoh3eU9/VfKrr1Zxa/pisvbnj6Mn+02J2K3qlxpSCBxU3fs0+sipLiek0TmxLiKK8BUcDdcan8L2LTBGgtxKetyeQG9ytpEAgCJaQe1m351/Y1rKWsDHnzHtcgq+kuZMSTXqlo8FLe97NJKD2E50L3A/rWAeWx2GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSw92NH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9F9C3277B;
	Tue, 28 May 2024 11:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897585;
	bh=PJ6dm+ojt4tB8KatVUHmNd4ox8+zoZGcn/Tu/Vumpvg=;
	h=From:To:Cc:Subject:Date:From;
	b=fSw92NH1+IcaGXB0/E0EVitFVJAe5MUKtDUk5DgyUoNRo9eTzpU4uZeji57srdptp
	 Ef4rEKITaSAdxJjddldsfiqdw5n0/Nm2dtbiAIb/Zyan8txG45YavEwGtua76O0beX
	 31wSslTX2Tz42exe4ZWoDeRYdEioaxRhXMAkwm1iih54n/6y71QpqXlKixcyzondFw
	 2D471jjJ54e09DZf2aw2LVYTBDzF57xIpftc5GcT1dkkLDV1cdWauKqbTWmG4hz+BK
	 dhac6CYFGxEloxMRni/G95Cga+XRbkkPPJKbjdxS0Wk+DdfqnhDpilsvqQrby+/ssG
	 ZwCLl7SvRmfOA==
From: Arnd Bergmann <arnd@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Armin Wolf <W_Armin@gmx.de>,
	SungHwan Jung <onenowy@gmail.com>,
	Henning Schild <henning.schild@siemens.com>,
	Ai Chao <aichao@kylinos.cn>,
	Robert Joslyn <robert.joslyn@redrectangle.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: yt2-1380: add CONFIG_EXTCON dependency
Date: Tue, 28 May 2024 13:59:33 +0200
Message-Id: <20240528115940.3169455-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This driver uses the extcon subsystem and fails to build
when it cannot call into that subsystem:

x86_64-linux-ld: vmlinux.o: in function `yt2_1380_fc_worker':
lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9d819): undefined reference to `extcon_get_state'
x86_64-linux-ld: lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9d853): undefined reference to `extcon_get_state'
x86_64-linux-ld: vmlinux.o: in function `yt2_1380_fc_serdev_probe':
lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9da22): undefined reference to `extcon_get_extcon_dev'
x86_64-linux-ld: lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9dc0c): undefined reference to `devm_extcon_register_notifier_all'

Add a Kconfig dependency to make it it always builds correctly.

Fixes: b2ed33e8d486 ("platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcharger driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 809888e4c1e7..9f850e4617bf 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -136,6 +136,7 @@ config YOGABOOK
 config YT2_1380
 	tristate "Lenovo Yoga Tablet 2 1380 fast charge driver"
 	depends on SERIAL_DEV_BUS
+	depends on EXTCON
 	depends on ACPI
 	help
 	  Say Y here to enable support for the custom fast charging protocol
-- 
2.39.2


