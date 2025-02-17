Return-Path: <linux-kernel+bounces-517945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4C1A387D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5379D3B4428
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC4622655E;
	Mon, 17 Feb 2025 15:39:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A5226528
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806782; cv=none; b=ruFTZmmdp1hJ9zRphuGGGvmyRz4M8hyWEObScBHMEDVdwgd/mbUUn68Ja/SgGQjkcjmsZvr5glrX4lteIa8YZXyAdjQLvqDKk87rxRxoky1QfLvqs4mQL9p7QLAxWAGW8UiIli6AT0bLzcSiivM3w0OB7i/ah3xh7VJP9HCgfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806782; c=relaxed/simple;
	bh=hUYLqZtlRI6Y6zWVPccEHPCN6XfeE5xkOBosV7oWkjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=q7OP3yVSqrzDd6cFuWgwBnb7G1bDqBz5gLaY1hxQLCDlQy9NxAKcyjZ0wRTFF3vFyQ/h6wVYu8G7MqQdaupFQheXwKJAiXo3AgPTXX5Q10cL4cF9A11cLoTs+N2HWtu7oqyfx95sJiAVA6C9dueIfVj4BTUDcWMt8U9KOYawRF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542F61692;
	Mon, 17 Feb 2025 07:40:00 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 703B63F6A8;
	Mon, 17 Feb 2025 07:39:40 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:53 +0000
Subject: [PATCH v3 12/19] firmware: arm_ffa: Reject higher major version as
 incompatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-12-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=hUYLqZtlRI6Y6zWVPccEHPCN6XfeE5xkOBosV7oWkjw=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gvPBXUm+PU5UaWOx8OeaNF2Sib2Z4JpmBpW
 YHmcXla4vyJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLwAKCRAAQbq8MX7i
 mHtID/42BE/x0L0hVj8+T1jkTQJeIPYpa2lZbI2IUchyI9APrySzXzTdsoGWa0Ybkf9LEt0wOI5
 mW7qVAaxN4tTOPNpP+a7TvyMI/6J6ZDjA57obCdIeG2IvMaMivhpEjKNEPjiwxiNnTe56eyZmOC
 LOCuF76kcXILynWZrA/w68GonydunUrDqxU3mVuegw8E988ew4VNE5UIBeEAyaqM+10EqxlL9FU
 GKbu4TCJqpME7blSpbCpFAiZb4cFF+Pb9ES+T+xgN7MY0dbX6VIuZjmAP98VJ7oXYTQ2SX+jrRH
 usJnh0s/9GfMxGXE81z5GXCssmqjVTFq0pZpUNs+rtG+AyrNhweW3BgpqoWaQBu4bgYC0nzk6XJ
 jL4Xv6vX2/8gN/J3PI4werouYzfNxOfjgWoCmFHECW5LP34LvdHunOXVhwEbAO7EqOIDMgayVoy
 26FYt4Tpu9J2h3WE/qFaZ+Aa074W0fL7Rz01yYoT7SRX+YV6bswsXkMdAr60++izvw67FJwE7aS
 +MvuyeF+sz+gnLSm3zlE0C15ZiYrObOPGJo0cPd285MAQHXX7aO+UeJVePvFy0tox0MZgQgy1zH
 NMNrxEHhVAnYaZb+4PQ8kw9boSB3jpPvHLSrahZn7kuYvuRzl1aAniq7AT8++PtWzKeboKK/EHh
 LJXYECxMv6cXqpA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

When the firmware compatibility was handled previously in the commit
8e3f9da608f1 ("firmware: arm_ffa: Handle compatibility with different firmware versions"),
we only addressed firmware versions that have higher minor versions
compared to the driver version which is should be considered compatible
unless the firmware returns NOT_SUPPORTED.

However, if the firmware reports higher major version than the driver
supported, we need to reject it. If the firmware can work in a compatible
mode with the driver requested version, it must return the same major
version as requested.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index d8421a32a92fed6d56770cba282ea55b2571b155..ad2f6b410e4431bb133fa0f05dd3eec802f5ee07 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -150,6 +150,14 @@ static int ffa_version_check(u32 *version)
 		return -EOPNOTSUPP;
 	}
 
+	if (FFA_MAJOR_VERSION(ver.a0) > FFA_MAJOR_VERSION(FFA_DRIVER_VERSION)) {
+		pr_err("Incompatible v%d.%d! Latest supported v%d.%d\n",
+		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),
+		       FFA_MAJOR_VERSION(FFA_DRIVER_VERSION),
+		       FFA_MINOR_VERSION(FFA_DRIVER_VERSION));
+		return -EINVAL;
+	}
+
 	if (ver.a0 < FFA_MIN_VERSION) {
 		pr_err("Incompatible v%d.%d! Earliest supported v%d.%d\n",
 		       FFA_MAJOR_VERSION(ver.a0), FFA_MINOR_VERSION(ver.a0),

-- 
2.34.1


