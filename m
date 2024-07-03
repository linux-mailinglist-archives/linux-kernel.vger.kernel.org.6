Return-Path: <linux-kernel+bounces-239653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E97926394
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F521C218DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2184117D340;
	Wed,  3 Jul 2024 14:38:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF517D892;
	Wed,  3 Jul 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017492; cv=none; b=U0yY6M4k4I6FX4pveYSeaENQshYnNkJCqs98qSkR92bhVOruZCDhk8Z/hN424RXHpiGWRhWzNbETEKEIIq2JVvjvkMMg4WDpvKJILOAIaOga0BIVNUqCjz504Gqxr35G36CjU6RSUq/zlB/M0HdUN8Ig5mjP97ZE7dR/3/Hv9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017492; c=relaxed/simple;
	bh=4M58wVwOJr5zFxSIDGKpKL2tVO/BB694v2hfvz1uXJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S7PUosGRpdM5VINAFEyyhTlH7y7wrYKVpTNBxyJ/CgACGjb17e2fvWwCtsuz1iiQX8pVdScci6f6Bkk6b1vkmz8fxEe7BvMbMWcl7gcgzgHiZnF35hFGRRb5N1jUrk7xw+kienAztRHtS+xn88Km4xm9vQGWRSr/868z7Oymv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45579367;
	Wed,  3 Jul 2024 07:38:34 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F503F766;
	Wed,  3 Jul 2024 07:38:08 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH v2 0/4] Add Per-transport SCMI debug statistics
Date: Wed,  3 Jul 2024 15:37:34 +0100
Message-Id: <20240703143738.2007457-1-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for tracking Arm SCMI statistics [Patch 2/3]
A config option to enable this [Patch 2]
Cleans up a unneeded call to handle_scmi_info [Patch 1]
And in [Patch 4] a selection of new debugfs entries to present these statistics

Based on v6.9, Tested on Arm Juno [1]

Thanks,
Luke

[1]: https://www.arm.com/products/development-tools/development-boards/juno-arm-dev-platform

V1->V2
Add a minor fix removing an unneeded call to handle_to_scmi_info
Use new scmi_log_stats op/no-op rather than if(IS_ENABLED)
Drop unneeded atomic_set's
Use a helper function for stats debugfs creation

Luke Parkin (4):
  firmware: arm_scmi: Remove superfluous handle_to_scmi_info
  firmware: arm_scmi: Add support for tracking statistics
  firmware: arm_scmi: Track basic SCMI statistics
  firmware: arm_scmi: Create debugfs files for statistics

 drivers/firmware/arm_scmi/Kconfig  | 11 ++++++
 drivers/firmware/arm_scmi/common.h |  9 +++++
 drivers/firmware/arm_scmi/driver.c | 62 ++++++++++++++++++++++++++----
 3 files changed, 74 insertions(+), 8 deletions(-)

-- 
2.34.1


