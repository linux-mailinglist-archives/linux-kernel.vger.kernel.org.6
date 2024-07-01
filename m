Return-Path: <linux-kernel+bounces-236446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2C91E272
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDE31F231D0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBF51684B1;
	Mon,  1 Jul 2024 14:29:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D3167272;
	Mon,  1 Jul 2024 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844169; cv=none; b=lbvPkpeDsoMVWQ2x3ZGCpElWKZmBWTfE1pP/DgGHpWZkakU9g2GWaYAPWbROLdQazYn+/1ILFNfpAsPNbCyQowM5ZUo3XkNx9nmdA//ZI49dIx9hRq7SqpJdoUq7SyaaL/DdiPCBMkCb1Uxbkdj/5i8Z3ao9Pa9V4EiX37xdSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844169; c=relaxed/simple;
	bh=EKkJ5H6HYETh6az5TgIYrk5kx0HN2Nm66NAhMMcNQrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGqNYYM2m9sllmzq6m0cQvMTTARMhjZAE4xGYqNnMFzuEdiqvm8nbCKist+999B+9r6qDEK5391GBtrwxBcdXed62krr5QJl5pPyYxB8zZJafS+XmpgokY7mMOGlwo1mq3H/XngHGBUu0SSaqV8rMfD1PL45q3xVCBD00fHwGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5795C339;
	Mon,  1 Jul 2024 07:29:51 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8160E3F762;
	Mon,  1 Jul 2024 07:29:25 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH 1/3] Add Kconfig option for scmi debug statistics
Date: Mon,  1 Jul 2024 15:28:49 +0100
Message-Id: <20240701142851.1448515-2-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701142851.1448515-1-luke.parkin@arm.com>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new config option for statistic tracking in SCMI subsystem.

Signed-off-by: Luke Parkin <luke.parkin@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..fac50fd0be72 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -55,6 +55,16 @@ config ARM_SCMI_RAW_MODE_SUPPORT_COEX
 	  operate normally, thing which could make an SCMI test suite using the
 	  SCMI Raw mode support unreliable. If unsure, say N.
 
+config ARM_SCMI_DEBUG_STATISTICS
+	bool "Enable SCMI Raw mode statistic tracking"
+	select ARM_SCMI_NEED_DEBUGFS
+	help
+	  Enables statistic tracking for the SCMI subsystem.
+
+	  Enable this option to create a new debugfs directory which contains
+	  several useful statistics on various SCMI features. This can be useful
+	  for debugging and SCMI monitoring. If unsure, say N.
+
 config ARM_SCMI_HAVE_TRANSPORT
 	bool
 	help
-- 
2.34.1


