Return-Path: <linux-kernel+bounces-228903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33403916875
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0691C22446
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9868E15ECD4;
	Tue, 25 Jun 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cd0A3Mqx"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6F157A6C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320306; cv=none; b=cdqkDLimySPSI2vmpc4oR2QMhOFD/ymm8wbm1FiHy7VGQQraHq7RYmcKrX7QB9bJvJNGciVeLY4N2HkhOFx9ktmI6o4+aITECra7MmQ4zLIEh/UwIryvtROTlQyYHaX4ztlQ72eckAkh4zcsND0ccbw4/lBDyWB60vNzS7bE4Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320306; c=relaxed/simple;
	bh=R+0v3SjYynSFu6kDngop0Uopo9Xqhn/mNhXd+Yeuzas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5tGE3lV6ooiimKSJKLA7/CjL2S4yVkGbJ3GQg1uNNDF1HgZX9qeJoDwqNZ8pG0ld9ClFL+AmPNO644CMlQ0JmgscqBAWK2K9n9RNV5LOw32e5VZPwqdKxuw7R9CmiIe1PJEn9quVI9WTOHQBnIL/XrOjeRIvPLV9u1pTinZm2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cd0A3Mqx; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=u73BM2k0P5V0AYjELtkiQ2BhOsIZOrApdWBJKOtljdU=; b=cd0A3Mqxf8WtqGzNNBqSZzdhFe
	51ANiA2VcZdEPlHP5VTbnLoyccrXwEHOYk97oHIgGPYcz8Vsj/w14T5ZQVYO2mko5ixw5gTzjtTnV
	LRMVlcgu735PH73u4Mj71RUymizaVWyvpq6LQOJtiK89pXNmzfcv0hKxNR/yhoAoDvibeRtEwduo1
	sz1omZjEiVSrHQn6HWWqpRe60/abE3kM/RdeCHHB75ALRjPl9SnhO52UYu/4/w5fBT7j/0+pI9E4A
	mwwZcZCJsXNLj0Qvde6ghN9IhKW3qbmuoHj2r3ZAmUyQmNZdQ7oYz6ZSonONvXPSiCbLfQKgCqRVd
	roJzfXaA==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sM5kW-007J4a-AU; Tue, 25 Jun 2024 14:58:16 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] arm64/numa: Add NUMA emulation for ARM64
Date: Tue, 25 Jun 2024 13:58:03 +0100
Message-ID: <20240625125803.38038-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240625125803.38038-1-tursulin@igalia.com>
References: <20240625125803.38038-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

Allow selecting NUMA emulation on arm64.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: “Rafael J. Wysocki" <rafael@kernel.org>
---
 arch/arm64/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8e80df015bdd..49c1cdc545d3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1507,6 +1507,16 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+config NUMA_EMULATION
+	bool "NUMA emulation"
+	depends on NUMA
+	select GENERIC_ARCH_NUMA_EMULATION
+	help
+	  Enable NUMA emulation support. A flat machine will be split into
+	  virtual nodes when booted with "numa=fake=N", where N is the number
+	  of nodes, the system RAM will be split into N equal chunks, and
+	  assigned to each node.
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SPARSEMEM_ENABLE
-- 
2.44.0


