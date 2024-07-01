Return-Path: <linux-kernel+bounces-236445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0A91E271
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BA91C2316B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E94167290;
	Mon,  1 Jul 2024 14:29:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1141167272;
	Mon,  1 Jul 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844162; cv=none; b=YVdUU9girvZZKIH50/yYAaWcGivsUmJ4pxhxeuhdVdJABIEvDf2nKoeV7SyhvAnPo0AEZk5IttcOchuVchVgGJ6YmjSnqcqHRoE+PnfdvmrcNYu5Qyd1Fz8hnDW8GIRTj2G9Ok510S8sP0IyREEvqAdKMkF5AsCbTuQNU0E59yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844162; c=relaxed/simple;
	bh=wrxd0Fuph4vel1ozo2/VNd3LYjzMS8VKldgVOhQuxIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ABbQCVvhns50Jv7feydLnjMxc9aOkJZ+XTZAwMFz7deUu3/4fDYJFxv6N4AhxyZQ1L5UzsB0+pL5ojNu8j2AG9E+jKZPIJUCsJWPwTZXs2FXEKYve5CkOvikZHJzLcnAfeipig3h0Qc6DbyCA6xZrRgV9xFVxrlnqElD4lwH+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D13DE339;
	Mon,  1 Jul 2024 07:29:43 -0700 (PDT)
Received: from thinkcentre-m93p.cambridge.arm.com (thinkcentre-m93p.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0390A3F762;
	Mon,  1 Jul 2024 07:29:17 -0700 (PDT)
From: Luke Parkin <luke.parkin@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	Luke Parkin <luke.parkin@arm.com>
Subject: [PATCH 0/3] Add Per-transport SCMI debug statistics
Date: Mon,  1 Jul 2024 15:28:48 +0100
Message-Id: <20240701142851.1448515-1-luke.parkin@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for tracking Arm SCMI statistics, [Patch 2]
A config option to enable this, [Patch 1] 
And in [Patch 3] a selection of new debugfs entries to present these statistics

These statistics are per transport instance, and will be a helpful resource when
debugging the SCMI and running tests.

Based on v6.9, Tested on Arm Juno [1]

Thanks,
Luke

[1]: https://www.arm.com/products/development-tools/development-boards/juno-arm-dev-platform

Luke Parkin (3):
  Add Kconfig option for scmi debug statistics
  Track basic SCMI statistics
  Create debugfs files for statistics

 drivers/firmware/arm_scmi/Kconfig  | 10 +++++
 drivers/firmware/arm_scmi/driver.c | 61 +++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.34.1


