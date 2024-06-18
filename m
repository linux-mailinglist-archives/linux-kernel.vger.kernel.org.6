Return-Path: <linux-kernel+bounces-218571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD03290C21A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06741C21969
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5237819B5AD;
	Tue, 18 Jun 2024 03:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B45UZoMX"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9D1D9503
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679657; cv=none; b=ou7E+je2nzvSGJpWpS6NfobWk4LcKvLiKHTtl646Rzl88wg+KlEEdTUKONJ0dKrbsBqfUBIkgZwIias2OjFv7ey+ulZr5kf0EW2vC0DGqYqS68uGkZM7jiswmkbb39UIUZFSemtssPKGGoAgF2nFNKHx2Do7cEXv440PW+DoVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679657; c=relaxed/simple;
	bh=/9XXFoMIDUejWLXPGASjELUaNhjf29SkPsmiAKjFxIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyWu/9rqsM1mLr05xlhtZgLsqs8sXkASSjGJBeW5RbaPxARnQDLue1msRaAXsQ50sT7aS6HfirB605plbkGd4HQ6DgSzVAn3eHUw+5hGX8cwTk1Tz65UriSnyCKMcl7iKRBD7W6nYOssKZkJZOT+HdOdck21wLr9VPJA/0g5W/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B45UZoMX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rZ3Tb4qAu6Z+twWJyOcZ2EZNot0n9kRT91kObBenkKQ=; b=B45UZoMX/ee8Rq+ArfpTmWwIIx
	GMD49HtipMR6pUyRxth9XneNoqH/GPE4ok7wQg96kroUv6/TAaQNr0T+aloAM9yHS2g3PImG7hl4M
	cPXt3ZHLgSJmy4Yz/rKFrYWd6EZ0BtX+bX4rLL5rODbfAVGNAQI9jUcTR0B26dEVCebFsuA2Viaej
	GGDOC8ZMOKdjs9sDUAcDCOPEdR7gyTy5gLN1tDyoNU4dBcqQnvazoSsijtu3ADcSiUp8j6AkMNrI3
	QdH7C2KPtIb/0kib/kl992VHsQC1CSGo6Gx8H1cubbXfFk9BXCup/Ntb5K1781Khf4Bcs2ClhUpDH
	tINbMfoQ==;
Received: from [191.8.29.108] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sJP5X-004YXc-0k; Tue, 18 Jun 2024 05:00:51 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel-dev@igalia.com,
	Melissa Wen <mwen@igalia.com>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Simon Ser <contact@emersion.fr>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	daniel@ffwll.ch,
	Daniel Stone <daniel@fooishbar.org>,
	=?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
	Dave Airlie <airlied@gmail.com>,
	ville.syrjala@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Joshua Ashton <joshua@froggi.es>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v7 2/9] drm: Support per-plane async flip configuration
Date: Tue, 18 Jun 2024 00:00:17 -0300
Message-ID: <20240618030024.500532-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618030024.500532-1-andrealmeid@igalia.com>
References: <20240618030024.500532-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Drivers have different capabilities on what plane types they can or
cannot perform async flips. Create a plane::async_flip field so each
driver can choose which planes they allow doing async flips.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/drm/drm_plane.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
index 9507542121fa..0bebc72af5c3 100644
--- a/include/drm/drm_plane.h
+++ b/include/drm/drm_plane.h
@@ -786,6 +786,11 @@ struct drm_plane {
 	 * @kmsg_panic: Used to register a panic notifier for this plane
 	 */
 	struct kmsg_dumper kmsg_panic;
+
+	/**
+	 * @async_flip: indicates if a plane can do async flips
+	 */
+	bool async_flip;
 };
 
 #define obj_to_plane(x) container_of(x, struct drm_plane, base)
-- 
2.45.2


