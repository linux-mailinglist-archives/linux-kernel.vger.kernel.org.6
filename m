Return-Path: <linux-kernel+bounces-425084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5989DBD43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD047B21F74
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382AF1CB9EE;
	Thu, 28 Nov 2024 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="LOD8yZ8n"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303CF1C9EA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828393; cv=pass; b=QMAGaRxTuW0sVV6HPksueoLWchkUXXBPSo/nvQ1EguzpxiOadeUziF2Faw21264dupHc0NcIg+dtmiRum9umAV2J+128v0X+exnvY2vVvT9B91N+vhI+gh/hmP011otY5RHQIiPBQl4+O3GaQe1MGWDfakYpXiP4+3rXbowIn6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828393; c=relaxed/simple;
	bh=AxnCoSsQT/Inwc7H9+HYjCY/COf7gr/Zs98Hst+F+ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sss01taBOUwmW/BWlsxSXOEuT//KSwM1VjbvKbXhpmNcsESBKOWXAXPmcppRAVZRSN1kdN65WtrNQgvWg6leq8299ikebRgEf0fB0MXxb3UO/eR1ro+9+IhshTjQ/scyIS+RvZqqA2Y7XtDDNwO5oqEnmpS3GJsypgpc8dfCln8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=LOD8yZ8n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732828372; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YJElRx/hzL+K4Zo9VKax1AZ9sX8hKK29BRZubKa/9TcKxUB6HEAclE8e7VIODNTT0Rc1Bu0S26M2shot5vz3vBf5NYqU0O9ox3n3Qdgpvghh++gC7nyuUGYrnY3T/rvhbpW1kXZaUEeautEyFGsHHcec+Ivu63GH+EnwcyXpPvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732828372; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Yn/js7NZspWK7Y4TuaoCNTjlLJOty2gRQ/c6GMAPBqY=; 
	b=g9h5py+xo+fqeoSU6l4MQ25B8Fk5VC5mVQur0lNxVQFSyuv79x5RpCqvVCJhqraFQm+hZVuMHYKy9/u1ZshNNOqf+K60N2YRG6Cd87G0wlTF1OJst6K42l2eezFaebxjPEmnh3L67pO5WvpofTctCwz5xrmFYLqCXXEmKzwdsAA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732828372;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Yn/js7NZspWK7Y4TuaoCNTjlLJOty2gRQ/c6GMAPBqY=;
	b=LOD8yZ8nnDldkHQFXBzFXXjyjJTlg/GboTWXzTZTdKAoJPdmQIFAwPAUOAYilJum
	cGK0srOyxZGeW+Ob7/LBTj7WOT+JAQXBB1MmDrUXKo7/yZXhZttK4YTIhTD3fenS0oO
	wS3pUh9ZAVVgYWhHrKlbBoF5kRxDm7DHQzd6bYpU=
Received: by mx.zohomail.com with SMTPS id 17328283726021021.3499072852073;
	Thu, 28 Nov 2024 13:12:52 -0800 (PST)
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
Subject: [PATCH v2 7/8] drm/panfrost: Add forward declaration and types header
Date: Thu, 28 Nov 2024 21:06:22 +0000
Message-ID: <20241128211223.1805830-8-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
References: <20241128211223.1805830-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is to make LLVM syntactic analysers happy.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_mmu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index e6e6966a0cca..27c3c65ed074 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -4,6 +4,7 @@
 #ifndef __PANFROST_MMU_H__
 #define __PANFROST_MMU_H__
 
+struct panfrost_device;
 struct panfrost_gem_mapping;
 struct panfrost_file_priv;
 struct panfrost_mmu;
-- 
2.47.0


