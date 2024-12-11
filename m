Return-Path: <linux-kernel+bounces-441664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA549ED216
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A8E1885330
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C641DE2D2;
	Wed, 11 Dec 2024 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="WHT4wOwt"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3FE1DE2C2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934907; cv=pass; b=CHzVxqzqssuJXNT/aaqlqXwgzUm1Bu4L8pLY4aHT4/BAiQ5iuE8Cgdl4grwYgOljAWY4Q5zjpZItmPHJRZAC4INhCOo8CvbCtfldOIwUqm1ZU0npRu/esX3AcAxc8RKHI92TaS0j+QGe+bBfBMCBxcTDdbyLm5qcyMQ7jdgM3s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934907; c=relaxed/simple;
	bh=uax6qeKKuZMM9GNNa/+uB6Mn5snEJQeTBuyPlz9KdcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/vo9LihGOgv1gLiCoDDeRctIzTVC0BlLdFXZT/bF2HE9hQhuc4s5i9FPK0NoiOoSVdcs9EtpdI7fB7C9o1UzMGBwoTdSXacC16vZbfUaMG3GsmglvXFYONuXsLeizq6WF/kMXXyhlv/7v++OFNi4tZhie+FMDAHeysFQ9odj0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=WHT4wOwt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733934887; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hFwO3hozzfeWnSx24Ww8Dl5opS9oZ2SFDgQRPrbwMGpzMkdPwOqOlgeGvrVJtTI3nXqck460bTLMYDHC7jMZl6NLr5yQzod1jLjJoAen4ijThZdt64FuJtIVrhGV4ABoZhpFaF4X40T0TIGGYpR/oElW6p5Ta9JO03eayCJp5Ac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733934887; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HDsZiPXRiyT2DtFdDqPzRkEMG3ihCmTo/xJvACrvICs=; 
	b=OfTVOdlf2ACd+/dHgTdkKHkZZXaIPJr/5fbwhkw300KGBIqSJyArf4oatCaFphgQg1kD+B2iYL1ibehSXOR2d0yzZP/xLdA5q2AIeKchilRlyopV/k+WyMwDhMBWqbFTqhyO+8FjwP0wuv36kRibgbViZVD8Dk8BNNfp1YJceD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733934887;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HDsZiPXRiyT2DtFdDqPzRkEMG3ihCmTo/xJvACrvICs=;
	b=WHT4wOwtHDZy8dUma01ejXv1nxZd+GU6JmRJU2pav9AOdMAzkILcthe0+0Ek+cRM
	KQ4mYnVoVd0pJ9P1zrhJAdvOgrD2HDJygbiX1jed6M2zsI1VW07gUSuoR9Tpc4JGwjN
	DOvfl7tSSLFkgtssCtSgJuo8/otoMq+f8Xs5vWXg=
Received: by mx.zohomail.com with SMTPS id 1733934886492542.7231123372303;
	Wed, 11 Dec 2024 08:34:46 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] drm/panthor: Display size of internal kernel BOs through fdinfo
Date: Wed, 11 Dec 2024 16:34:30 +0000
Message-ID: <20241211163436.381069-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series enables display of the size of driver-owned shmem BO's that aren't
exposed to userspace through a DRM handle.

Discussion of previous revision can be found here [1].

Changelog:

v4:
 - Remove unrelated formating fix
 - Moved calculating overall size of a group's kernel BO's into
 its own static helper.
 - Renamed group kernel BO's size aggregation function to better
 reflect its actual responsibility.

[1] https://lore.kernel.org/dri-devel/20241205233915.2180630-1-adrian.larumbe@collabora.com/

Adrián Larumbe (2):
  drm/panthor: Expose size of driver internal BO's over fdinfo
  Documentation/gpu: Add fdinfo meanings of drm-*-internal memory tags

 Documentation/gpu/panthor.rst           | 14 +++++++
 drivers/gpu/drm/panthor/panthor_drv.c   | 12 ++++++
 drivers/gpu/drm/panthor/panthor_heap.c  | 26 +++++++++++++
 drivers/gpu/drm/panthor/panthor_heap.h  |  2 +
 drivers/gpu/drm/panthor/panthor_mmu.c   | 35 +++++++++++++++++
 drivers/gpu/drm/panthor/panthor_mmu.h   |  4 ++
 drivers/gpu/drm/panthor/panthor_sched.c | 52 ++++++++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_sched.h |  4 ++
 8 files changed, 148 insertions(+), 1 deletion(-)


base-commit: c6eabbab359c156669e10d5dec3e71e80ff09bd2
-- 
2.47.0


