Return-Path: <linux-kernel+bounces-517934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6069A387D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809511897182
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78858224B03;
	Mon, 17 Feb 2025 15:39:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D56224AF9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806772; cv=none; b=CWLwLtkRTQxlK7emljgsSY97Z/DZ72wrwloiPM5akrVZ7pJ+JI9r8n6WPCdkq3OxLlwtVUudxjPwSKpEJcV9mHvo1ao6ydzL1L5hvBa1T7y6ZGR+8K/qo2hr2CWWwJ2lQI2KyAAYIk24qqtp+KrwXywlSPnTJWwM7b7A4Yu+XDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806772; c=relaxed/simple;
	bh=tJtJ+iZ/RH0kV6E8FVz8GWyFPWw0X5nxEmvPF+pyVpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=MT+R/HZQioBFcz8btsoIsBM4GnAxnhd4/MGP1xy9ZZ/TsMN0Lq825GXprVALmnsCr02QZg1lez2GE3lnJRyFg++ZCnH143XlU4nCjTS9P6kPoFvY227zg4MYqtLkRfjeJlxS2mLjiyQ4mQ4MeNPjvEBERW7xohuuRXLoPwG7Cfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3EC1692;
	Mon, 17 Feb 2025 07:39:49 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25D243F6A8;
	Mon, 17 Feb 2025 07:39:29 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:42 +0000
Subject: [PATCH v3 01/19] firmware: arm_ffa: Replace SCMI by FF-A in the
 macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-1-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=tJtJ+iZ/RH0kV6E8FVz8GWyFPWw0X5nxEmvPF+pyVpA=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gtXHWnKMr9WB5CJdIm1VEcTqqQjHoG8va+Y
 X+57qiPKpOJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLQAKCRAAQbq8MX7i
 mC22EACTJ1oYJdI/jH3Mk8BIbelop4SG8s08yql/bZfcv1x+PDI8uqU+FBC/c//aJVpOaNmDPXf
 BKFVqR3r5o9svjC82IAsKRD6ZW4JjGrUsn6QGJxHKS4eW+LGaNEduPnr+mb8GHT1YzDju2ZLDDh
 97OQ/j4mVz5CVJdtlmcgAXHjVY/W15F2iE/PkRfVgVlsVeLdKuNGH5TSIyLZGSempxZvHHukxIT
 fPSopQAPDGFWZchtSzzA4TW50gevDU46kEYa54iqa2uVw2H+ne9qvXuXzesc+ddUGLFfqeF6oCD
 pjPw8F544ZDRfw3zMiqprjyD+bIE4WWpOfpu/iUJZ+rUMkUiMJdCYZbed6QMswj9r5iNTL2pCcO
 /t0jRtiUWkGaAjONSI2j2KJDWaFuqNNTkBXCnkniam5UQe85P9xfVPMHlbSMQo9pCl8/igVHNS9
 23sfDJt0Qjw79Cdw6Rgzqu1Ps5KyO9o++c5QlvrYrUz7+jGim5GuLX5LtduNWUtAG4Dc3wzruFE
 qFhD9LokcPbKVyMTErbDonSV07AwRli6OFuAvYhMoZ/bkgpSN8onj2HbjGWJTrDk+D7fXcBgraY
 RLACo93enHMMfIutecbjQ8q7c5jIGTeZGlDtGAGqY/K90z3qI6yt1OA6DXlYOc4b94ASxJ4u8bR
 OB0SxNn84EAe9BQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Commit 22779149e93d ("firmware: arm_ffa: Emit modalias for FF-A devices")
added modalias for FF-A devices. However the macro added used SCMI
incorrectly. Replace the reference to SCMI by FF-A and update the macro.
(i.e. s/SCMI/FFA/)

No functional change.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index dfda5ffc14db7208e8b622cdd648194c9cb1ef34..52b1f09209a0e51e321cd23a69aa7e4c4daa8dd1 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -15,7 +15,7 @@
 
 #include "common.h"
 
-#define SCMI_UEVENT_MODALIAS_FMT	"arm_ffa:%04x:%pUb"
+#define FFA_UEVENT_MODALIAS_FMT	"arm_ffa:%04x:%pUb"
 
 static DEFINE_IDA(ffa_bus_id);
 
@@ -68,7 +68,7 @@ static int ffa_device_uevent(const struct device *dev, struct kobj_uevent_env *e
 {
 	const struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
-	return add_uevent_var(env, "MODALIAS=" SCMI_UEVENT_MODALIAS_FMT,
+	return add_uevent_var(env, "MODALIAS=" FFA_UEVENT_MODALIAS_FMT,
 			      ffa_dev->vm_id, &ffa_dev->uuid);
 }
 
@@ -77,7 +77,7 @@ static ssize_t modalias_show(struct device *dev,
 {
 	struct ffa_device *ffa_dev = to_ffa_dev(dev);
 
-	return sysfs_emit(buf, SCMI_UEVENT_MODALIAS_FMT, ffa_dev->vm_id,
+	return sysfs_emit(buf, FFA_UEVENT_MODALIAS_FMT, ffa_dev->vm_id,
 			  &ffa_dev->uuid);
 }
 static DEVICE_ATTR_RO(modalias);

-- 
2.34.1


