Return-Path: <linux-kernel+bounces-333573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2612D97CAE3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2334B22EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0D619EED6;
	Thu, 19 Sep 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ch2d5Ar1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6694199FCD
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755707; cv=none; b=F54OUav/U/kePuuBEgu+L7b6vQrBgOddHjmU3vppuS1gL3n+XPWv32Kow5MtyKMefUSE8mnx0aER7y+2s7r8jupSLdn6QEzssfEbnuJTY9Zxf1jTnN6R54X0mP54RcolBHU+O4nKcE8M/A2s4+I37bFlAdNjKsZ+Pg+35842mlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755707; c=relaxed/simple;
	bh=B/XcRagZj3rNQkkOOHw9npSb84lhCdxcCogl6Bp/SBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5OL2cZ08GwH0TH9X5HwyRcf4RxRqnoEuYejwN6pXNkIMLKIxYbubJbRRkT2wZY4W38X5gM9Zy6jaqVnXOzHTPP1wHQmICGqiNzxypE1bXHqoJd94Q++AQ1G0Nbdw9nh5YZ+NoO+6z6TMO+VP7rPPCIBf4g2UXUM9zSIvbJW9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ch2d5Ar1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C8424220;
	Thu, 19 Sep 2024 16:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1726755620;
	bh=B/XcRagZj3rNQkkOOHw9npSb84lhCdxcCogl6Bp/SBo=;
	h=From:To:Cc:Subject:Date:From;
	b=ch2d5Ar1Utu+/HCXDq+iKrdW27+invce5Ry9B3CF95TkSeHSWY6t/40+ankA5YEEP
	 /WqQkdThWvHPDfl5IF5r5JC7N/hrxGuYrhANVbUu09Jnc5B4/72MX27s4O88VDb6dX
	 JIQbf1jzNAqCdyFOaDI+K9tm3T8aWRYxL0A4fb20=
From: Umang Jain <umang.jain@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/3] staging: vchiq_core: Consolidate bulk xfer helper
Date: Thu, 19 Sep 2024 19:51:27 +0530
Message-ID: <20240919142130.1331495-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Few functions were identified were their declaration, definition
and usage were spread (incorrectly) across vchiq_core and vchiq_arm.

These are being consolidated into vchiq_core in this series.
Please look at individual patches for details.

2/3 is in particular a big one. The code is just a move, but
seems big - as it was diffcult to split it into smaller, compilable
hunks of individual patches.

Umang Jain (3):
  staging: vchiq_core: Move remote_event_signal() vchiq_core
  staging: vchiq_core: Move bulk data functions in vchiq_core
  staging: vchiq_core: Drop vchiq_pagelist.h

 .../interface/vchiq_arm/vchiq_arm.c           | 356 ------------------
 .../interface/vchiq_arm/vchiq_core.c          | 350 +++++++++++++++++
 .../interface/vchiq_arm/vchiq_core.h          |  30 +-
 .../interface/vchiq_arm/vchiq_pagelist.h      |  21 --
 4 files changed, 373 insertions(+), 384 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_pagelist.h

-- 
2.45.2


