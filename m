Return-Path: <linux-kernel+bounces-291644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5D795651F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7341F22EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1515820F;
	Mon, 19 Aug 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="OwN/wTzp"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3101614D29A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724054570; cv=pass; b=D1Usel3HpVgDr+nJxd+M/HKa/KjYT7jD93KuGQrfWlwnRLN4Ge55vq7dzeapN49AfGVO6hgH/TUpsoeutJgth5tfDRjkOGujYDMq+Xyr7/phnghfJvmCzf8vq1UhsULRl4DBVKHWx3w8myRspV3BMwKMt4l6kcwClznvoNsSfLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724054570; c=relaxed/simple;
	bh=uHeaFHnUCPF35wv2ZHjQfBGmRS6XWVKPqaK+AJLCtz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TZHllVdAwJ8I8yfr24FSofD3xKATuR6OqYToP3lIdTqzscKfXBz7AsI4R+ZEvzUy2pLZ2h69eZpjqau5sIPi+5/WalbaaQouvflGrsXLtAZKWKjp5nKis8UE2Cvk45XUKS5U8CpSYQRaXleRGLVVKXD9hZn/yx/nyGmrM7K5m9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=OwN/wTzp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724054563; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F+aHLvqM9zhqrszCW2u2orE+61M4gpadZfNPHrWJTs3aW68cK8jWjF+tsMI1npsCocJ6idf7t2TK5sMi4NaKln3a9rgLkJHw0Jo8p4nEdex8F8RshFGft4+Wir3FJ0j1oZYSQceatg6eDiHHA+Nzrf1utI3korCyrSBPxMZVZXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724054563; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aGM52OwWaSooqo/uVTXBAszQkcvYzLAzmkE020PQmws=; 
	b=jeWVDRnqO4DR1Lx/Sdon2KKGqCQFS7Fu5tRyRzCBixy3zi2QuDmegy7Hiq7dnabvWM9r5NACF6sEmcP9pxdL9xIIO2tU0POU3uYeE96vQ0wg0i7/51QjEPtG5tKMR6HoDtCVFAGwbHpnBZRXkK3ZPW4piVbB0rWJJ5j2kAe2gGU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724054563;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=aGM52OwWaSooqo/uVTXBAszQkcvYzLAzmkE020PQmws=;
	b=OwN/wTzpo2fMFKmJsgcqP4mDbEwv4gSJkXk33ufGlA9Tpzsf0ciuAWRGeYClDwfd
	8UAMbtkmkOGDJ8YXUTylzjm36v4B3se55eQCpbzfcuOJfWS7UMrhVIseGlmVLVv/CwT
	0MpV9+nMoM1lZ/N0W4XWEW/Y/I3hi70Lu/vHW5mY=
Received: by mx.zohomail.com with SMTPS id 1724054559948931.2584917515253;
	Mon, 19 Aug 2024 01:02:39 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH v3 0/2] drm/panfrost: Wire cycle counters and timestamp info to userspace
Date: Mon, 19 Aug 2024 10:02:21 +0200
Message-ID: <20240819080224.24914-1-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Mali has hardware cycle counters and GPU timestamps available for
profiling.

This patch series adds support for cycle counters propagation and
also new timestamp info parameters.

Those new changes to the uAPI will be used in Mesa to implement
timestamp queries for OpenGL and Vulkan.

The Mesa MR using this series is available here [1].

v2:
- Rewrote to use GPU timestamp register
- Add missing include for arch_timer_get_cntfrq
- Squash job requirement uAPI changes and implementation in one patch
- Simplify changes based on Steven Price comments

v3:
- Address Steven Price comments in the first patch
- Fix a codestyle issue in the second patch and add Steven Price r-b

[1]https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30553

Mary Guillemard (2):
  drm/panfrost: Add SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY
    parameters
  drm/panfrost: Add cycle counter job requirement

 drivers/gpu/drm/panfrost/panfrost_drv.c  | 45 ++++++++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_gpu.c  | 12 +++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h  |  1 +
 drivers/gpu/drm/panfrost/panfrost_job.c  | 28 +++++++++------
 drivers/gpu/drm/panfrost/panfrost_regs.h |  2 ++
 include/uapi/drm/panfrost_drm.h          |  3 ++
 6 files changed, 78 insertions(+), 13 deletions(-)


base-commit: 3e828c670b0ac8a9564c69f5c5ecf637b22a58d6
-- 
2.46.0


