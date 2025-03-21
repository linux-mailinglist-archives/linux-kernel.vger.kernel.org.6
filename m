Return-Path: <linux-kernel+bounces-571096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F96A6B919
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6644E484D52
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3963E21D00E;
	Fri, 21 Mar 2025 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="rSjeqTRt"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A690D1F3B8D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554365; cv=none; b=VBSyfGcvJ+DMXzTapr9lVKsAQ2BRf2X7ad6eyuJUsrOkyU5A8rCwP9vqzo9ODWyA6wXW3WI+/stE4/3YOqEcazqGmmWjh6Gtnh/66w1GRYj8b7q0ArUEylSqIjqe/g91mSnZVQbnbo4DtfCz7ibzxKXxmYiXwuA5QLeAuqzlU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554365; c=relaxed/simple;
	bh=MYqkRWB+TghBUM8TiGGt7dciThOxEF3r7kTN0p6WCLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4keEtQXqkCzEvA+hETT4ckW/TDc98StHCyquiUaIAL7h0Y/yo+koqF8iueeTNeJCNZW1lAoBhjP2LMFHepJytBTVmm37g91lV2zAe4+rzzTKlFgkPw7R54kqmnwndT19amnySTApQHi/YUDn7qpXEgLnRgkMLnxNwXmVcGHkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=rSjeqTRt; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742554359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYBXdsWrAF4XCKt8xl9DU8RcwjIds3O8UdltDFshuKk=;
	b=rSjeqTRt0mTYpqOTR0+1Vu5QEr94xolka6rqV4VbnE5GmqKCydNSZgOZS+tlC1ZC3qtjZR
	FmeonyU2Fx/nw/BBvRPXc4c/wxvU2PnYW00x7Qjf58khxdbvqp3Qjxg9u50FIP1tqpuf7D
	7flH1Ehi9gu375DpWFNwHMpzHekQu9M=
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Ma Jun <Jun.Ma2@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Yang Wang <kevinyang.wang@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 0/5] drm/amd/pm: Prevent division by zero
Date: Fri, 21 Mar 2025 13:52:30 +0300
Message-ID: <20250321105239.10096-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patches prevents possible division by zero.

The user can set any speed value.
If speed is greater than UINT_MAX/8, division by zero is possible.

Found by Linux Verification Center (linuxtesting.org) with SVACE. 

Denis Arefev (5):
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero
  drm/amd/pm: Prevent division by zero

 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_thermal.c   | 6 +++---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_thermal.c | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_thermal.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

I did not change these files, because the functions you are 
interested in are not used there for a long time.
drivers/gpu/drm/radeon/si_dpm.c
drivers/gpu/drm/radeon/ci_dpm.c

-- 
2.43.0


