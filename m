Return-Path: <linux-kernel+bounces-400567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7D9C0F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCCE1F24DA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B07218581;
	Thu,  7 Nov 2024 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Plgr2cOE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE85218300
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008903; cv=none; b=PyIZHHENJfSB+piYjFQ5nDTr8fYTi1K3XQoUpMXSBSKy9tN/5IDFS/3EN1I6MR/tXU+5Lrwg8oUYn8XT8zj2TRsS9nVSQrmIdkf8MtWF6NUhCGTLoGfOsKREMB5YrVeNqbTmNoC2BUC5SaMPqFZL/U/AbNM89p+aR5gFeWWwnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008903; c=relaxed/simple;
	bh=u3Nlc3VrK6eIFZ/S5a9xrWzVB09MmxR0BHD8rNbHZ9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXZqehzTzJjtQeE/196DzS4KUENC1JAUDsatP5z2RnLkLWVCKI2btKVyc6OB84x/amHieO2/tgEH+/mF4oZJS+hsh9wblN103C8+FQQUcsdQ+beUvnDuyIUaPlCf+Adyk5pvemjV5WVxjWMrv7wIAqi430oMdqxO2YbBcvF2s5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Plgr2cOE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:c173:4b:4a04:3a21])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 87AF899F;
	Thu,  7 Nov 2024 20:48:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731008890;
	bh=u3Nlc3VrK6eIFZ/S5a9xrWzVB09MmxR0BHD8rNbHZ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Plgr2cOEIf3tTqxCgt5dXMIK+DMiSd+f4ueONz75ODGLhPZbcybzbHcYDu9+zAGYW
	 DFFYlu5piJdtUoaivonivYdwdodXVR1U+0YcIM3izORQcl9n7eEO+digqYgj52AoUx
	 QVPSyDDH8JSjT9hnTlgQRGmSKMB0pxCeAWlpfeU0=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 2/3] staging: vchiq_core: Rectify header include for vchiq_dump_state()
Date: Fri,  8 Nov 2024 01:18:05 +0530
Message-ID: <20241107194806.90408-3-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241107194806.90408-1-umang.jain@ideasonboard.com>
References: <20241107194806.90408-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header vchiq_core.h does not need <linux/debugfs.h>. It needs
the <linux/seq_file.h> for vchiq_dump_state() to dump the vchiq
state through vchiq_debugfs.[ch].

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index fadca7b1b196..9b4e766990a4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -7,11 +7,11 @@
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
-#include <linux/debugfs.h>
 #include <linux/dev_printk.h>
 #include <linux/kthread.h>
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock_types.h>
 #include <linux/wait.h>
 
-- 
2.45.2


