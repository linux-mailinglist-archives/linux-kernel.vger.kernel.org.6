Return-Path: <linux-kernel+bounces-345013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6467098B124
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E869A281859
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2821A42DD;
	Mon, 30 Sep 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6g7HOFe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756331A3BD9
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739701; cv=none; b=a5nfViGnVmLm5xU198+P2mL35R/ezNgFlZY4SWxZu1RJ2U/uaX7sqbNtFQgkO7g3gAAgXV0D13zhmLk0CnrPpJItsCL6wiDgqVJmIgHvAEoxu94u3yAXoysW4JPcjpwXnZXNbZnbzR4YmuBdhIJoDb7jkmNHKpk5a5I2fjD8aDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739701; c=relaxed/simple;
	bh=94KkOQNqZR79fQNKnuklbr4/9lhv4pCxsp6Do6MP7aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n47vyIUQLXfEVHlZwaZ1WMY41qRcxN2fuCGpWN6BZBHeYEJ4xb+KCPfwwiqRa1qZP9o09nAt2FccnwzNhsNs2HeAr7jKfHurxmiDc58TJQgHjly1hGpBjS+twztPMh8ocqXc/vCOWbWsjiJsyBbcf9ieN+EwPo/yHrfsFYWAY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q6g7HOFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7t/iPh52Or/uRW+fztwWU5+XnAVyTy6rcl2tUGiZv4A=;
	b=Q6g7HOFef15WiB1b5ZF1YRLr6gbafy2ERrBXfFFYRrJavNMTJvbaVmAreafaHbOoE0nzum
	tEC7Oakf0P4qPHSRP8+dfBf4WVcVVr+R20cBfQJv4a8e1L+YsA5ndyU91TsWEE2pMrHR4l
	o/Qus0iIQNYeh8V7XSgVpiOR4omXFfM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-OWGYhbbOPTi0_jOaBzYfLg-1; Mon,
 30 Sep 2024 19:41:35 -0400
X-MC-Unique: OWGYhbbOPTi0_jOaBzYfLg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A46919192AC;
	Mon, 30 Sep 2024 23:41:27 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E539D3003DEC;
	Mon, 30 Sep 2024 23:41:22 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Cc: Asahi Lina <lina@asahilina.net>,
	Danilo Krummrich <dakr@kernel.org>,
	mcanal@igalia.com,
	airlied@redhat.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org (open list)
Subject: [WIP RFC v2 32/35] rust: drm/kms: Add Device::num_crtcs()
Date: Mon, 30 Sep 2024 19:10:15 -0400
Message-ID: <20240930233257.1189730-33-lyude@redhat.com>
In-Reply-To: <20240930233257.1189730-1-lyude@redhat.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

A binding for checking drm_device.num_crtcs. We'll need this in a moment
for vblank support, since setting it up requires knowing the number of
CRTCs that a driver has initialized.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms.rs | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 3edd90bc0025a..d0745b44ba9b6 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -253,10 +253,27 @@ pub fn mode_config_lock(&self) -> ModeConfigGuard<'_, T> {
 
     /// Return the number of registered [`Plane`](plane::Plane) objects on this [`Device`].
     #[inline]
-    pub fn num_plane(&self) -> i32 {
-        // SAFETY: The only context which this could change is before registration, which must be
-        // single-threaded anyway - so it's safe to just read this value
-        unsafe { (*self.as_raw()).mode_config.num_total_plane }
+    pub fn num_plane(&self) -> u32 {
+        // SAFETY:
+        // * This can only be modified during the single-threaded context before registration, so
+        //   this is safe
+        // * num_total_plane could be >= 0, but no less - so casting to u32 is fine (and better to
+        //   prevent errors)
+        unsafe { (*self.as_raw()).mode_config.num_total_plane as u32 }
+    }
+
+    /// Return the number of registered CRTCs
+    /// TODO: while `num_crtc` is of i32, that type actually makes literally no sense here and just
+    /// causes problems and unecessary casts. Same for num_plane(). So, fix that at some point (we
+    /// will never get n < 0 anyway)
+    #[inline]
+    pub fn num_crtcs(&self) -> u32 {
+        // SAFETY:
+        // * This can only be modified during the single-threaded context before registration, so
+        //   this is safe
+        // * num_crtc could be >= 0, but no less - so casting to u32 is fine (and better to prevent
+        //   errors)
+        unsafe { (*self.as_raw()).mode_config.num_crtc as u32 }
     }
 }
 
-- 
2.46.1


