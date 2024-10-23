Return-Path: <linux-kernel+bounces-377908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E569AC877
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5B41F22717
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509B1A2C0E;
	Wed, 23 Oct 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MC08WefE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF83156968
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681487; cv=none; b=KFN4HA46xy4bI0uwRVX+Ip0k7xRhKcmeQi+9trwuGzNkdJCKS1IRu9N7OrEr5v3KrHf3vghGqoJf+HEap/OBXZC6E4XkEyv6B6WeOYDxw9hmM1g+RV+EKwSmM36Zvp++N5o6rkSTlpTddLWjHVwpQft9Pq4Jcp2NCWk051EQ7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681487; c=relaxed/simple;
	bh=mgBvfrl3vzYkOmmt/1RDTsr84t06CJd4a1PW6agEUnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YMrPFc6Fu7DOZVd69CStX8TWezBhU0Nb3nTswE8Na/rnUKmv6fGyG3TsMxKhsp+Ef0IaE7vwiNfTuX8qmLedenuqzNNRfXL0iQjA4N0am8tnWm4THruXHTDeV0QohsmAWVmMHIvoP665GHJZqn9k5d4lWv99boUjqciEjDGCK2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MC08WefE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE4A382A;
	Wed, 23 Oct 2024 13:02:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729681376;
	bh=mgBvfrl3vzYkOmmt/1RDTsr84t06CJd4a1PW6agEUnY=;
	h=From:To:Cc:Subject:Date:From;
	b=MC08WefE5jYCOunqjEPolR2OEF0I6OAhIkxuxXTlhlnnW3lTIpfaJmMVVf9yfwnhk
	 GT+WW9q9HfP3W+Ns8dTw3pel11YPfU+GDlsUK878P1Fy3hv0lz/AD/OTREO22fZrMb
	 YDczwbS7DzVS1s8rl/6gMoSUBWO3moSQW8M4F0vA=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	kernel-list@raspberrypi.com,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/6] staging: vc04_services: Clarify bulk 'userdata' usage
Date: Wed, 23 Oct 2024 16:34:00 +0530
Message-ID: <20241023110406.885199-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bulk 'userdata' pointer is categorically abused through the
vc04_services interface. This series attempts to fix it and clarify
what it is and its usage.

Patch 1/6 simply renames a member for dma_addr handle for better
readability.

Patch 2/6 dissociates 'userdata' being used as bulk_waiter pointer
in bulking mode.

Patch 3/6 renames vchiq_bulk 'userdata' to 'cb_data' - which is what it
essentially is - data pointer to callback in VCHIQ_BULK_CALLBACK_MODE

Patch 4/6 similar to 3/6 for completion_data struct.

Patch 5/6 and 6/6 helps track the data pointer when initiated from
user interface.

Umang Jain (6):
  staging: vchiq_arm: Rename a struct vchiq_bulk member
  staging: vchiq_core: Bulk waiter should not piggy back on bulk
    userdata
  staging: vchiq_core: Rename struct vchiq_bulk 'userdata'
  staging: vchiq: Rename vchiq_completion_data 'bulk_userdata'
  staging: vchiq_core: Pass vchiq_bulk pointer to
    make_service_callback()
  staging: vchiq_arm: Track bulk user data pointer separately

 .../bcm2835-audio/bcm2835-vchiq.c             |  3 +-
 .../include/linux/raspberrypi/vchiq.h         |  7 +--
 drivers/staging/vc04_services/interface/TODO  |  4 --
 .../interface/vchiq_arm/vchiq_arm.c           | 39 ++++++++-------
 .../interface/vchiq_arm/vchiq_arm.h           |  3 +-
 .../interface/vchiq_arm/vchiq_core.c          | 48 ++++++++++++-------
 .../interface/vchiq_arm/vchiq_core.h          |  6 ++-
 .../interface/vchiq_arm/vchiq_dev.c           | 16 +++----
 .../interface/vchiq_arm/vchiq_ioctl.h         |  2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  7 +--
 10 files changed, 74 insertions(+), 61 deletions(-)

-- 
2.45.2


