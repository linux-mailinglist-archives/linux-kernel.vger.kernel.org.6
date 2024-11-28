Return-Path: <linux-kernel+bounces-425076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942AC9DBD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A34B21B71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5381C3F38;
	Thu, 28 Nov 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Rc1HfQh8"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE2537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828383; cv=pass; b=StdHejRhRYGYVV6b3Sk0boRfvucaSVv4KyLnX3DqikkJIFbgGQUcpS2IUFy+g+RKy1Ol6SnmE+wVih+vyWt6bBk68q/qe26Tfdav9ul5cbKYxohhbNGp7yDVnvmhX/7l8EZewzxq/lnFSGFQ6RqW9e66JGdZfqrL9PS7WLXEj9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828383; c=relaxed/simple;
	bh=t/26AX0Vd6ZHyNsYeJqOUsoj4EBdyXYyKkyFFYiFu4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WhzKcEPosuEEfNRZFO+PagybUx//cffxSVuYYu9YKYCwkl5iOhjzZYL0qZj6wxfwLAkm4vJaztViK9T2zp+11SWjv9elJhAabHsy69UF2g7DfmuGd721a6Rkmp9fPbTM8nC1YLav+YETymI7vOfaUJprBk/wDYkR4rSLFAXNXbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Rc1HfQh8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732828358; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fmHMTOpk7VbqBlZccsNcptSbYwPyS9knyfkbMRnKPmZhkawQ++79sNQoodUdhPv//2JnhRNBeBAV9gT1jMMBdLM0IjWhwjBsJiOeDOIOCk5fIOfAI5QVsfKORHku31YMAwJysZ3tjj+q8e7c8gtoonTCHsL188Oe21HsNj0SeJI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732828358; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3tYBP50ESNPd772Z53QfhHT3Uqd4F/skk0jQayoesP0=; 
	b=MKrV9vNGMN4bI9JmdlnPavf/xKaRVkvXU86XiLmqZkGU6qxbueu1kmv3qrfpbkeuret7GMwHiD6o/4hJktvGXXBGokjnufkBQDPbzwT1Tx5g6xswKRHSa/mJ/G/+CcXdSCTncn5SnRn2lqcwE2Qah8/FroK2gIHOvj8sW3JmV9g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732828358;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3tYBP50ESNPd772Z53QfhHT3Uqd4F/skk0jQayoesP0=;
	b=Rc1HfQh8oPf2qHjT8iYCd4v7adp5YEYHUFwzCU/PJCwWRUyNkOpLidst5bwG2WfI
	/vl0FVgieQidf1iYfyjzvOPzQH8SVxxXV9ZyvGwBzRdsl1N59aeFl37I5VTGWpRN+5g
	8pVrEVCxt+qafdIfVxlbJOe74ymYTx7vk4fpKn3w=
Received: by mx.zohomail.com with SMTPS id 173282835791530.02219913833926;
	Thu, 28 Nov 2024 13:12:37 -0800 (PST)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] Some Panfrost fixes and improvements
Date: Thu, 28 Nov 2024 21:06:15 +0000
Message-ID: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is v2 of https://lore.kernel.org/dri-devel/20241014233758.994861-1-adrian.larumbe@collabora.com/

This patch series is a collection of minor fixes and improvements I came up
with while working on driver related stuff.

Changelog:

v2:
 - Removed commit that provided an explicit fence cleanup function
 - Added commit for removing unused Panfrost device structure member
 - Refactored how optional job interrupt reenabling during reset is handled
 - Make the way errors and successful return values are delivered from inside
  panfrost_mmu_as_get more according to standard.
 - Simplify unmapping of already mapped area when mapping the pages of a BO
 - Fixing management of runtime-PM reference counts when failing HW job submission.

Adrián Larumbe (8):
  drm/panfrost: Replace DRM driver allocation method with newer one
  drm/panfrost: Handle inexistent GPU during probe
  drm/panfrost: Handle job HW submit errors
  drm/panfrost: Handle error when allocating AS number
  drm/panfrost: Handle page mapping failure
  drm/panfrost: Make re-enabling job interrupts at device reset optional
  drm/panfrost: Add forward declaration and types header
  drm/panfrost: Remove unused device property

 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  4 +-
 drivers/gpu/drm/panfrost/panfrost_device.c    | 60 ++++++------
 drivers/gpu/drm/panfrost/panfrost_device.h    |  9 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       | 68 +++++--------
 drivers/gpu/drm/panfrost/panfrost_dump.c      |  8 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c       |  6 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  4 +-
 drivers/gpu/drm/panfrost/panfrost_gpu.c       | 64 +++++++-----
 drivers/gpu/drm/panfrost/panfrost_job.c       | 97 +++++++++++--------
 drivers/gpu/drm/panfrost/panfrost_job.h       |  3 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c       | 90 ++++++++++++-----
 drivers/gpu/drm/panfrost/panfrost_mmu.h       |  3 +-
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c   | 31 +++---
 13 files changed, 256 insertions(+), 191 deletions(-)


base-commit: e511f8fc3b2786999987901dad94c1548e091040
-- 
2.47.0


