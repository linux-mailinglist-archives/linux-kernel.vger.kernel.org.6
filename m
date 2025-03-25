Return-Path: <linux-kernel+bounces-576177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F6CA70C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2A6188956A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D01E26980C;
	Tue, 25 Mar 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUFYLfrb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF31FF5FC
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938130; cv=none; b=MFnmHWbQtkt5C90JppfZ1t5UMA7UmqZl1wKs1qKSUTTeU1AujCXzVfwoa8wRto3+souTFqNKkSNu0G8uzeaGhgqM9oPVyEHYh+R1ZvuVjUSRU4BjQCd5X5s5mpimntMLAzyv6lq1U9qrhf1ioXLNaKrzmEyslry/CSSI40Buwwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938130; c=relaxed/simple;
	bh=WOKjfO5Le5ZbWGc0aTaU8R66dTfSI7l0KXfGeSy0yr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUNTKmJD9aEc6xWxWQCq7HQ5eZlHdMj9D4KU46MswpHoJfpC8m2jCxdOh7tWv3rQomL3V4x3tEVb1mJ8s4jnFnzQ5mzINe0WkcOqlyOJzs0g7vJffsNoJvtay/MzbkDrW05wXAjcvEAGXqjzcT7sJ759D9AKn51R6TXXj2GCUPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUFYLfrb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742938127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMQDXtxbqTS7ziJJiCZIX0LB76TW0s62efGfyV0tZrY=;
	b=aUFYLfrb0mBOEMKUjEETUJj+EkREsgMrRS5b9oKFxZlp0X87i+ohUQodIldXWYsW+s8C+F
	J6oLpZ7H3dgKA72h1TlCLrwgXAUmiMdTcn6aDLDuWc898SJ8AYjKH2yQ4l4wEDadsp1Q+J
	lcaP26Lbs9dXjwkbjoMQBFMHxN7RCMk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-h6ygNYWKM4q_iEEXd15dvQ-1; Tue,
 25 Mar 2025 17:28:44 -0400
X-MC-Unique: h6ygNYWKM4q_iEEXd15dvQ-1
X-Mimecast-MFC-AGG-ID: h6ygNYWKM4q_iEEXd15dvQ_1742938122
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EE1A196D2CF;
	Tue, 25 Mar 2025 21:28:42 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.80.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7462919541A5;
	Tue, 25 Mar 2025 21:28:40 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 2/2] drm/mode_config: Make drm_mode_config.(max|min)_(width|height) signed
Date: Tue, 25 Mar 2025 17:27:05 -0400
Message-ID: <20250325212823.669459-3-lyude@redhat.com>
In-Reply-To: <20250325212823.669459-1-lyude@redhat.com>
References: <20250325212823.669459-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Similarly, it doesn't really make much sense for us to allow devices to
specify their minimum/maximum resolution as signed. So, let's fix that as
well while we're at it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_mode_config.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 271765e2e9f2d..4b8f0370b79bf 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -532,8 +532,8 @@ struct drm_mode_config {
 	 */
 	struct list_head privobj_list;
 
-	int min_width, min_height;
-	int max_width, max_height;
+	unsigned int min_width, min_height;
+	unsigned int max_width, max_height;
 	const struct drm_mode_config_funcs *funcs;
 
 	/* output poll support */
-- 
2.48.1


