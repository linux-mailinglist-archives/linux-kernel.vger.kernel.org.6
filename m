Return-Path: <linux-kernel+bounces-274698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E174947B97
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD867283A67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A1015AD99;
	Mon,  5 Aug 2024 13:10:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A81E49F;
	Mon,  5 Aug 2024 13:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863419; cv=none; b=Gi3BIZCptcsUwybip6SRS/wO8dRI0rCdRW1TpdkbkujMqwFI5CRw6kwXPmTcqoP4e4biTyKaWMDtYls0uGSiHxKENjJLz7CQS6rgSii5Yd0sPzIn/agKgEA67sVqrlUYWn7xRAng8zca52629dPD+x6n71g+vHlXKZBYEt65a24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863419; c=relaxed/simple;
	bh=xOpP4EF0WtTkzHAfFcrDjtiqgFJJO8v+ZDLllKUQfDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NhECo39sEPM76/E0gqDofg4IBUmBvTxfz7e4gsj1aNavOOPGlFCxa3y4XC/9tEh36Sf4vJP4Nlm4Bp1C15uYpxlzI6UJ59vwUYt+mRHMzDzmoCc/7XSA3PwIyOXbWQyGH+Om83GC41oGrPIsD09FH/GL3qKkCqnAzvlAgv++kTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2567E143D;
	Mon,  5 Aug 2024 06:10:43 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6D643F5A1;
	Mon,  5 Aug 2024 06:10:16 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v5 0/5] Add per-transport SCMI communication debug statistics
Date: Mon,  5 Aug 2024 14:10:07 +0100
Message-ID: <20240805131013.587016-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for SCMI communication debug metrict tracking.
I am just sending on behalf of Luke with minor reworks in his absense.

Cristian,

I have retained your review tags, please shout if you disagree.

Regards,
Sudeep

V4->V5
- Updated/improved some patch titles and commit messages
- Moved all debugs strings to an array and changed the creations of the
  same into a for loop
- Minor changes to the debugfs file names itself to improve readability
V3->V4
- Rename to counters rather than statistics to reflect the scmi protocol better
- Use basic writing rather than custom function on debugfs in patch 5
V2->V3
- Switch statistic counters to an array to store statistics.
- Add more statistics
- Add the ability to reset statistics, both individually and all
V1->V2
- Add a minor fix removing an unneeded call to handle_to_scmi_info
- Use new scmi_log_stats op/no-op rather than if(IS_ENABLED)
- Drop unneeded atomic_set's
- Use a helper function for stats debugfs creation

Luke Parkin (5):
  firmware: arm_scmi: Remove superfluous handle_to_scmi_info
  firmware: arm_scmi: Add support for debug metrics at the interface
  firmware: arm_scmi: Track basic SCMI communication debug metrics
  firmware: arm_scmi: Create debugfs files for SCMI communication debug
    metrics
  firmware: arm_scmi: Add support to reset the debug metrics

 drivers/firmware/arm_scmi/Kconfig  | 14 +++++
 drivers/firmware/arm_scmi/common.h | 24 +++++++++
 drivers/firmware/arm_scmi/driver.c | 83 +++++++++++++++++++++++++++---
 3 files changed, 113 insertions(+), 8 deletions(-)

-- 
2.46.0


