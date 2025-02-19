Return-Path: <linux-kernel+bounces-522531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B96A3CB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C83B41A7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA72580DC;
	Wed, 19 Feb 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FMdKruiw"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4AC23C388
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000940; cv=none; b=ps4bLYxkzqjLLZBiREgDpkycGizYV2wNSsz584tW88JDmGoGEWcE3MWEazKatOr8baUgTgI7TLAmQAXjbc8T4lG7aW4qTiMbLoAADyvjtn8O+nuefNxKDazhWiq0E68MGnV2wkXf418w7y2GPDh7GMeFjNa0WX7bZtqbv/GdjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000940; c=relaxed/simple;
	bh=im3t3OjHDLzye+vFUZQNnk8vn6E90LHBobDoyMeyvKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISCrXf6eqYN1AyAFKoJdykFVp/18KdXXzXD9t4kDHwyo/C9CAb+wSbPo8WvmwtZoXSChw4AkflXvgZEQIlpHLooEDLOgPYy5XkrHrpznp8Alhxv2sTQN26jcWexDVL7/x/TemhMWzqN5j3eJkBJqWMvN1dwg3a4a5IRx83997cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FMdKruiw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=w5g9otFiJkeNvBm1eGPsPJCmTn9xUTThN+I9+NmpxrY=; b=FMdKruiwht0LyTiwr7WdOr8gv/
	7AOuzoKTijGIy/YVuUvrjjZ8eQsTlJHrDd3Ec7Atc0xIycYibdnZLbh/ToyhIAZtCmL3U8V3bgQIz
	bTFvT1cGPpaWo/3y+ZHyOprWF/lUhbRw54oE1nyLpwUatPykgXxVo/t2LkVvpsJb+qU6gOiXKxRVM
	Yml1ibP3v3au5OmHYKENLQfLNTJ4YpRPpSby44LAa+MXXGfOAOchp9KobXYhVZXlAWttqOK7iQGWN
	R1GDJH5ngPEcou5wuyDoAmHh0GytFLY0EKCoP++47DBZIfus5YaesGstXgcPusvG0gAm73YDSLVa4
	iZ6mXwfg==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkrj3-00F1SN-Rf; Wed, 19 Feb 2025 22:35:32 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	siqueira@igalia.com
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 1/3] drm/amdgpu: Log the creation of a coredump file
Date: Wed, 19 Feb 2025 18:35:15 -0300
Message-ID: <20250219213517.281556-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219213517.281556-1-andrealmeid@igalia.com>
References: <20250219213517.281556-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After a GPU reset happens, the driver creates a coredump file. However,
the user might not be aware of it. Log the file creation the user can
find more information about the device and add the file to bug reports.
This is similar to what the xe driver does.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 824f9da5b6ce..7b50741dc097 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -364,5 +364,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
 		      amdgpu_devcoredump_read, amdgpu_devcoredump_free);
+
+	drm_info(dev, "AMDGPU device coredump file has been created\n");
+	drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredump/data\n",
+		 dev->primary->index);
 }
 #endif
-- 
2.48.1


