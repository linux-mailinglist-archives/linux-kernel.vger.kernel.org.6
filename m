Return-Path: <linux-kernel+bounces-267162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A5C940DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC632852B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AF6194C9D;
	Tue, 30 Jul 2024 09:33:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCB0194AF2;
	Tue, 30 Jul 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332034; cv=none; b=m0vS72TutjGFCVXR7iw8KXF5gp4HBkdE2QC7d9aEbBZVP8hcDpvbfzrur7MGaVGd2HYeuXTOpIgHbTWqvZFLU+Sjhtu1T9N5ZYmLlnx7aKWYSpPLWdj2Na3ntbNe0+o+uko38PDEixOniDZFpa6EQceJPocZXIpXOBwfWR5SnQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332034; c=relaxed/simple;
	bh=QNY808UvNbqPyMNJKu9Vk8rv1bD1a1jgery45zCLV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/ruTYl+uSb23H/buvcNveS47egWXU+kNYw0kQcoW/c1LQTtksTqRSP8o08J4lv1n8AV501O7mI44ZqyL+A++XXc9P84Ckl0NLHiojhvAAkY2KU7FaD7jpKjHQSULlj+BYkOP4+OFcQvdc4rqgNcPJjrp/f7zEjoqf/dLNzzOD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC5BF1007;
	Tue, 30 Jul 2024 02:34:16 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265763F5A1;
	Tue, 30 Jul 2024 02:33:50 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v4 0/5]  Add Per-transport SCMI debug statistics
Date: Tue, 30 Jul 2024 10:33:37 +0100
Message-Id: <20240730093342.3558162-1-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for tracking information about the SCMI [Patch 2/3]
A config option to enable this [Patch 2]
Cleans up a unneeded call to handle_scmi_info [Patch 1]
In [Patch 4] a selection of new debugfs entries to present these counters
Then finally in [Patch 5] enabled writing on the debugfs entries to reset counts

Based on v6.9, Tested on Arm Juno [1]

Thanks,
Luke

[1]: https://www.arm.com/products/development-tools/development-boards/juno-arm-dev-platform

V3->V4
Rename to counters rather than statistics to reflect the scmi protocol better.
Use basic writing rather than custom function on debugfs in patch 5.
V2->V3
Switch statistic counters to an array to store statistics.
Add more statistics
Add the ability to reset statistics, both individually and all
V1->V2
Add a minor fix removing an unneeded call to handle_to_scmi_info
Use new scmi_log_stats op/no-op rather than if(IS_ENABLED)
Drop unneeded atomic_set's
Use a helper function for stats debugfs creation

Luke Parkin (5):
  firmware: arm_scmi: Remove superfluous handle_to_scmi_info
  firmware: arm_scmi: Add support for tracking metrics
  firmware: arm_scmi: Track basic SCMI metrics
  firmware: arm_scmi: Create debugfs files for counts
  firmware: arm_scmi: Reset counters

 drivers/firmware/arm_scmi/Kconfig  | 11 ++++
 drivers/firmware/arm_scmi/common.h | 27 ++++++++++
 drivers/firmware/arm_scmi/driver.c | 87 +++++++++++++++++++++++++++---
 3 files changed, 117 insertions(+), 8 deletions(-)

-- 
2.34.1


