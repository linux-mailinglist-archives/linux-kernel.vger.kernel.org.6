Return-Path: <linux-kernel+bounces-441666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C869ED21B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A301D2812F8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538301DE4F3;
	Wed, 11 Dec 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="dsKcOo11"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF091DDC14
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934913; cv=pass; b=Z2ZFZIh00kbvwY5ULRZHDJPcieHsn0t3ygSQqjiVrGxllBtWBAUBQTdflhNayV8uZGmSvXue52iUsN0H+Njwz+VZ6OH9rwgNauU4krK0ipPTdlWTgQK9+/fgCU/9YTr83MQb7X71JroEvFBM+Y2iToduDwFuCyKLOqc8khmnBGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934913; c=relaxed/simple;
	bh=KPWJiXhwx7vVlrzNBOJ6n+ArWrrbU0T5mQj/UE1Xpxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FT6fMUIoDUf0GlTK5Iq2IC6oOAZzFo0P3vE8oQ5nWhAX6Vmv7Xzf0ZnW/Q/aNuc04LUwwhRDWD3DkIKNu3S2AvVAdxY4OVdlbdNVWpOABgB+aB7cOb30LaWF7yGfRGi8sBO8sGNTAit1F+u0kxKWZ/Bwv+UbnudDl7hgXq7xv6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=dsKcOo11; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733934893; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QMwAFdKmjJl+HPrmSnTxWjjwOBiNXW4q1T0mFWQlS5M9v1xuDIH4+PSfbKifJnT1vRiBJVD1hEE0APP2JAi/TtRv98olKTw5M19hRSt47geErHNbuWVZN9KU5YaszuD98MsjpWBlMIG6hHKJ0t4peavrY4J9eLGET1CFkBcCteI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733934893; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2lmNy/XM6hdTNY+7mSV2llZYnapRKFq/OVQAePLlARA=; 
	b=nXg9fQVyqZ9ITa4sP+3tMPgit8F6KD8gkpN72Y9NWEdgOnDWdmv2c8qEqmPP/yozfJtA/SHa5gr98F6g9JSoB9YI5qbAB0da6cjKUWfWF88+cNlHxujFTtdgWCStkjYK7vdq0UR9jHqmpQ9d9QEJYfogWX1GlyQAHqm3tlvXLtE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733934893;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2lmNy/XM6hdTNY+7mSV2llZYnapRKFq/OVQAePLlARA=;
	b=dsKcOo11YfYhiWUf2bimaYuexaEjNmVdr6ozpeHqs3WjavMqKjhIipPlUAkM80ev
	4qJKJJGFTisTIxRE9Q6u3eqtVifePumaNKdF0LSUSc4ywfcCCpHcR7egzXCXQYORI3A
	5djkIGKnF1KxGXrs4E9Jwz2wPNN0AyUiow9s/r6w=
Received: by mx.zohomail.com with SMTPS id 1733934891458566.2122633790219;
	Wed, 11 Dec 2024 08:34:51 -0800 (PST)
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
Subject: [PATCH v4 2/2] Documentation/gpu: Add fdinfo meanings of drm-*-internal memory tags
Date: Wed, 11 Dec 2024 16:34:32 +0000
Message-ID: <20241211163436.381069-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211163436.381069-1-adrian.larumbe@collabora.com>
References: <20241211163436.381069-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A previous commit enabled display of driver-internal kernel BO sizes
through the device file's fdinfo interface.

Expand the description of the relevant driver-specific key:value pairs
with the definitions of the new drm-*-internal ones.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 Documentation/gpu/panthor.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/gpu/panthor.rst b/Documentation/gpu/panthor.rst
index 3f8979fa2b86..c6d8236e3665 100644
--- a/Documentation/gpu/panthor.rst
+++ b/Documentation/gpu/panthor.rst
@@ -26,6 +26,10 @@ the currently possible format options:
      drm-cycles-panthor:     94439687187
      drm-maxfreq-panthor:    1000000000 Hz
      drm-curfreq-panthor:    1000000000 Hz
+     drm-total-internal:     10396 KiB
+     drm-shared-internal:    0
+     drm-active-internal:    10396 KiB
+     drm-resident-internal:  10396 KiB
      drm-total-memory:       16480 KiB
      drm-shared-memory:      0
      drm-active-memory:      16200 KiB
@@ -44,3 +48,13 @@ driver by writing into the appropriate sysfs node::
 
 Where `N` is a bit mask where cycle and timestamp sampling are respectively
 enabled by the first and second bits.
+
+Possible `drm-*-internal` key names are: `total`, `active` and `resident`.
+These values convey the sizes of the internal driver-owned shmem BO's that
+aren't exposed to user-space through a DRM handle, like queue ring buffers,
+sync object arrays and heap chunks. Because they are all allocated and pinned
+at creation time, `drm-resident-internal` and `drm-total-internal` should always
+be equal. `drm-active-internal` shows the size of kernel BO's associated with
+VM's and groups currently being scheduled for execution by the GPU.
+`drm-shared-memory` is unused at present, but in the future it might stand for
+the size of the Firmware regions, since they do not belong to an open file context.
-- 
2.47.0


