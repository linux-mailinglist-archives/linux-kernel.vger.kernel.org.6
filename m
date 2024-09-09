Return-Path: <linux-kernel+bounces-320688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F194B970E67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60004B225C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151971AD9CE;
	Mon,  9 Sep 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b="dBNongc4"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D7177999
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864537; cv=pass; b=kZ1e19RErafnEZptMFpctw1zhNi0ynPWXXDkbCAU1csXRVGWa903N+0LjSZ387JRSaAQAGPkiECevbZ3Nonad1rOV0a2hdaTip29kTwfjpS1AgzhqlW57GghdlyHgXk1BmhcW5AFFtw9YQTkwgyRuiE2GgaSaSocVjITvVF3p8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864537; c=relaxed/simple;
	bh=9nLsvbVdSlQ706JiltumJKUCJcifsMULIcZ8ikYtkGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1Qs2PWY10dh0rb63HZLf0/Raz/6cBMPc/wm1+vnSDIFJg9F2J3DQVZ/cVBpFBKAegewuWo8/wSnqBKOeayiKSKW18ZBuQo9/Vzpnbn282IfmuLZ630NOmALiZu8mrVtluWWuxxJqE+ucNkwPB1fdYpbh59RdPpwIcpmq6MzxIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=mary.guillemard@collabora.com header.b=dBNongc4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725864527; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JBZia3zCnvI6oZy7maTvumeptCtx3i8ydXti9LxynmfCTHu3Z58DrKZzeX5wcekrOo0hVUQZKipnR8QUpVyEoOPLCjlZlFOQCvE/XGhoOblO/hfC/6vaVpsZyXdt9eEB2xZYAST0DBU4y5Qovat/MwpFtHefJNdJSuim6/vadhc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725864527; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DQqWcutoKL6a0GFhm3Jo0PNfy9O3Da/ndDAvyoZuXPI=; 
	b=ag3KTLZPx3WzeaiyqKa0QB4E4rmIIB685McJs4novmXBlQMSn9T7yow1lDmv2fQB3fumj3jpFIHHrnomrda8cLpDqPxHZ5HuZjWtWRc9eLD4oFnrCm1RQYYiZS8OH/07DFdzyKdjnOxdXyuSMwvYSzUxl5bTNMM0qhrdrvNmjWA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=mary.guillemard@collabora.com;
	dmarc=pass header.from=<mary.guillemard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725864527;
	s=zohomail; d=collabora.com; i=mary.guillemard@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DQqWcutoKL6a0GFhm3Jo0PNfy9O3Da/ndDAvyoZuXPI=;
	b=dBNongc40i87PBKU77QpWkaSFJLBYmLH3PxLm/nRViSY7inIXLIuQ/sB3Pc8rXCq
	yj07osxJtphnl3bERHFlmyGykxrHLpyrVkIz6dhqwmhxh5tN+Zy5z6A5jsc/wgwDjLR
	qRqEl3gzP6Flu2pUnjJSJbFPW0acUe9i3Kr4SLuo=
Received: by mx.zohomail.com with SMTPS id 1725864525859560.608359750444;
	Sun, 8 Sep 2024 23:48:45 -0700 (PDT)
From: Mary Guillemard <mary.guillemard@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Christopher Healy <healych@amazon.com>,
	kernel@collabora.com,
	Mary Guillemard <mary.guillemard@collabora.com>
Subject: [PATCH v3 0/2] drm/panthor: Expose realtime group priority and allowed priorites to userspace
Date: Mon,  9 Sep 2024 08:48:19 +0200
Message-ID: <20240909064820.34982-2-mary.guillemard@collabora.com>
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

v2:
- Add Steven Price r-b on the first patch
- Remove drm_panthor_group_allow_priority_flags definition and document
  that allowed_mask is a bitmask of drm_panthor_group_priority on the
  second patch

v3:
- Use BIT macro in panthor_query_group_priorities_info
- Add r-b from Steven Price and Boris Brezillon

[1]https://lore.kernel.org/all/20240903144955.144278-2-mary.guillemard@collabora.com/
[2]https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/30991

Mary Guillemard (2):
  drm/panthor: Add PANTHOR_GROUP_PRIORITY_REALTIME group priority
  drm/panthor: Add DEV_QUERY_GROUP_PRIORITIES_INFO dev query

 drivers/gpu/drm/panthor/panthor_drv.c   | 61 +++++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_sched.c |  2 -
 include/uapi/drm/panthor_drm.h          | 29 ++++++++++++
 3 files changed, 71 insertions(+), 21 deletions(-)

-- 
2.46.0


