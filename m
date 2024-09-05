Return-Path: <linux-kernel+bounces-316911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCAA96D6D5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48354284594
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F119995D;
	Thu,  5 Sep 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="a2kUXhMM"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB98194A61
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534842; cv=pass; b=enkcSwsgmqLM0NIdjsL16pJmav4SInUMhCljav2TGh3JVKoB4z2gBx7vxGYVdnyMIGGxcS653FPb/2oUCEmU0cKby91eh7P56VYhjrSHoUjqqg0iFM3xFVcGuFLv2MvZpFhwVLaZitEEGktntmN/2EpJHtxdj6sG93ejDI73kkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534842; c=relaxed/simple;
	bh=eLEKl96BFrGuna6PMoNoK14KCaUNqA2U9Aud/MfBf9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lFjzu3+o2vEmVbzuQDcuyxI55GcRVMBKXYvUFcylcaZpL8iKkwVpS+KiYZq9nFi6dvCqKXVzZUBA8UYos0EzVegij3PUeX27AU1Ryu/L1xVKG59R7wSO1F9FTzE7gxiYLlz5DTDYT7ZDNncgGShlmhduMbcqb9vRMmG02A4kNrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=a2kUXhMM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725534835; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ko+ssTjfuzPSoVr5DCixIvL3qEV+P46vAy/qfUPUYEMINkqFX6b+LgLp05dF178JwOBoCJCY6RsZDC+JzuHkYZ4DXMKI64wAYYM7i0uXOwZzIRMXVpeJFi9cNzlx1pTz/r3LR1NB4LA4E3GyqEPkMlF2dIDRWQeyr4kUvY6oUbY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725534835; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zYO5M+XyjUp7mPx9nd9oE8rcz7ltsIbCI/ZCic2x2mA=; 
	b=jiW9jWOLQDgsiUlR6U7m+ORi0LdrGwbIzGTRulyHt8ifuvJSg1tebKS3CJo4VW5YaLydYbdemYNVANEro+4i9lcSyY/vF5FiJxFr155rSsjSmbHhAjEFm6p1kUI3VHaRRcBwDf8nPf00AH+G4Lr0YUD4ZqXkM/tuezG3DPcanL8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725534835;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=zYO5M+XyjUp7mPx9nd9oE8rcz7ltsIbCI/ZCic2x2mA=;
	b=a2kUXhMMBjaPKLip3MF83DxcNCQEwhiDizIplRF43//Jm7JjnnPgZWhZRICO1bxF
	finMm+AFTsJF9/Sb2WuJ8hFDYHQINfRl4TFo5q1kHWC2JlMf8rA6V+uHZ4aCG3yABWj
	QbVz1dFCwQmdvdkFS9Otg3nkp3Uqa+22mFmE+Qkg=
Received: by mx.zohomail.com with SMTPS id 1725534833685272.4438221352942;
	Thu, 5 Sep 2024 04:13:53 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christopher Healy <healych@amazon.com>,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH 0/2] drm/panthor: Expose realtime group priority and allowed priorites to userspace
Date: Thu,  5 Sep 2024 13:13:36 +0200
Message-ID: <20240905111338.95714-1-mary.guillemard@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This patch series adds support for realtime group priority and exposes
allowed priorities info with a new dev query.

Those changes are required to implement EGL_IMG_context_priority and
EGL_NV_context_priority_realtime extensions properly.

This patch series assumes that [1] is applied. (found in drm-misc-fixes)

The Mesa MR using this series is available here [2].

[1]https://lore.kernel.org/all/20240903144955.144278-2-mary.guillemard@collabora.com/
[2]https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30991

Mary Guillemard (2):
  drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME group priority
  drm/panthor: Add DEV_QUERY_GROUP_PRIORITIES_INFO dev query

 drivers/gpu/drm/panthor/panthor_drv.c   | 61 +++++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_sched.c |  2 -
 include/uapi/drm/panthor_drm.h          | 45 ++++++++++++++++++
 3 files changed, 87 insertions(+), 21 deletions(-)

-- 
2.46.0


