Return-Path: <linux-kernel+bounces-380843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A7B9AF6D5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABCA2841FC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBFF1F5E6;
	Fri, 25 Oct 2024 01:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pMi2kEfx"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C515A8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819954; cv=none; b=Y7nAECBS9Yo6bYYajkU8V83PHVoi6pEt/4Eq1fKavfifJvdcuPw4yU7pToHr57QaD2KNJ5ex8CQ86MGrjhRL3ziEpA7ea47XMJgV3XMacnQ4v82J7FFTcXgLwkPQ9wYfdTQPbjJlhOwXQJHKoYxdbiVfMPMb4fNYgdSUg9y2nQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819954; c=relaxed/simple;
	bh=km5mUSbYQwwAraSCYvoXizWYdFZwGRl1jTOVcbjYwxc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NUBpFwnnokZqIyZXt+/no0v5CjCOrg4r+tUv2e6Cd9EHBhzTyluCEgQhWKl4xyRjCDBO+/kAO1MEetq9AZ+4qcJOIxM5eKBeVQ1K5ccFkKp81djRRcdJ7BJ7C/sLRYuqYsWKCjao1ZYqhAeycTAUjbQyABMoUpznx5iEcC7Soew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pMi2kEfx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=XJyr1k5hsMzXecc3r0
	bnTK4J08ys6q4zjF7voVTLkpg=; b=pMi2kEfxiIEZOJHUsSpWJZ2k2YumTBKBPl
	lRckLnLyiKZ8atECugJg/NspZkSFPYJiH/IPjqftH9RtOuOVYyreqZthl3YD6Vw+
	1TRZRlTcKLv0icbee+fieUzazkSodq8jpQE4PRavihc7wXdob8jCzvideJHD+4Ia
	C1Q+00Kg0=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDX3xV88RpnafuUBA--.35786S2;
	Fri, 25 Oct 2024 09:16:48 +0800 (CST)
From: huanglei814 <huanglei814@163.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH] arm64/Kconfig: introduce GENERIC_ISA_DMA
Date: Fri, 25 Oct 2024 09:16:41 +0800
Message-Id: <20241025011641.4858-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wDX3xV88RpnafuUBA--.35786S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw45CryrZFyfAFyUKF43GFg_yoW3XFg_G3
	4fua1kGw18ArZ0qryYqF4fWryYka48GryfWryxtr1kXrW3Zw1fGrWUZF42kr17Gan09FWf
	XrZayFn0qr13tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbQ6ptUUUUU==
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbixxKD9mca5F34ewAAsn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: huanglei <huanglei@kylinos.cn>

Enable GENERIC_ISA_DMA feature on arm64 platform,
thus, request_dma and free_dma interface can be export.
and driver modules can use the this interfaces on arm64
platform.

Currently, many pcie parallel port drivers still use these
interfaces when ported to arm64 platform.

Signed-off-by: huanglei <huanglei@kylinos.cn>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd9df6dcc593..986eb251f68f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -367,6 +367,9 @@ config GENERIC_CSUM
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
+config GENERIC_ISA_DMA
+	def_bool y
+
 config SMP
 	def_bool y
 
-- 
2.17.1


