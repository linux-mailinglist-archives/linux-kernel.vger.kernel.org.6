Return-Path: <linux-kernel+bounces-576176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83230A70C07
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158167A372E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF0269802;
	Tue, 25 Mar 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0ntSM+q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4F51F1300
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938129; cv=none; b=GQJoZBGig7m4NcMiNW+DBz17TFwAmEBPwDmw8r7RwyTfh6RBisezhR7lNVMDkRRMmjozuk24zwLZtiOwFjUsrDVRo5R7Q+2x11sKstbwZv2PYu3s0Ri2XPuSx6J6Xd2O8qh7xVY3AMYxutSAwNU+p7ZgsINsfa/rcgzBemB54YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938129; c=relaxed/simple;
	bh=QzvD+twqG+PK6CX3j8Cn8yeRU+WFHIBiOGn35iMcfkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeaHs2oHKa6OIZNBJf7Bp/U0ai9a3ehTiFbru+6OcOZNl07wa2TA49y/ZPMV2xC3qNrmMr7JRbSd/Ta3yiC3d6hqujbBMsS+uL93UywLAiWsY5nUFcFkRWfctppqGQwAWI5epffP4wyTQDuXkoSusFaWtjhNEDBEHDo/fnCxYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0ntSM+q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742938127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4xLb8V8T6CZWLRFn4kKzM+FxRUrfETXJPEGmVxhSAE=;
	b=c0ntSM+qtA1my+9HOGZfjcYdKV2QSj5dBgA8pTI73EDzqpr9fXdtavCqm0gJr+VI7nE8g6
	srMgvEf2EER6nW3iBK5psRY3PtfPNityzQpcc7v7pLuoWg4RvvCTeTTwxtQhjdRuxitV9A
	GSMvvumFu5w3K+1WEa6kxgITTmqJ1Cw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-mekVL5PmOnOPqw1sBArMJQ-1; Tue,
 25 Mar 2025 17:28:42 -0400
X-MC-Unique: mekVL5PmOnOPqw1sBArMJQ-1
X-Mimecast-MFC-AGG-ID: mekVL5PmOnOPqw1sBArMJQ_1742938120
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1BFA1801A00;
	Tue, 25 Mar 2025 21:28:39 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.80.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 878B219541A6;
	Tue, 25 Mar 2025 21:28:35 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: Maxime Ripard <mripard@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:RUST:Keyword:\b(?i:rust)\b)
Subject: [PATCH 1/2] drm/edid: Use unsigned int in drm_add_modes_noedid()
Date: Tue, 25 Mar 2025 17:27:04 -0400
Message-ID: <20250325212823.669459-2-lyude@redhat.com>
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

A negative resolution doesn't really make any sense, no one goes into a TV
store and says "Hello sir, I would like a negative 4K TV please", that
would make everyone look at you funny.

So, let's make these parameters a bit more reasonable and ensure that
they're unsigned - which makes the resulting rust bindings for this
function a bit easier to understand and work with.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 include/drm/drm_edid.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 13bc4c290b17d..2e2e1d2347397 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -7099,7 +7099,7 @@ EXPORT_SYMBOL(drm_add_edid_modes);
  * Return: The number of modes added or 0 if we couldn't find any.
  */
 int drm_add_modes_noedid(struct drm_connector *connector,
-			int hdisplay, int vdisplay)
+			 unsigned int hdisplay, unsigned int vdisplay)
 {
 	int i, count, num_modes = 0;
 	struct drm_display_mode *mode;
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index eaac5e665892a..b38409670868d 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -437,7 +437,7 @@ bool drm_detect_monitor_audio(const struct edid *edid);
 enum hdmi_quantization_range
 drm_default_rgb_quant_range(const struct drm_display_mode *mode);
 int drm_add_modes_noedid(struct drm_connector *connector,
-			 int hdisplay, int vdisplay);
+			 unsigned int hdisplay, unsigned int vdisplay);
 
 int drm_edid_header_is_valid(const void *edid);
 bool drm_edid_is_valid(struct edid *edid);
-- 
2.48.1


