Return-Path: <linux-kernel+bounces-344998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09798B113
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7232280F51
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93D61A4E6D;
	Mon, 30 Sep 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7hv6lBn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86751A4E70
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739580; cv=none; b=NZRiK0OwfXHIQvqQRbnz0H7g/2saMpYY/5rnSffZHAvU5eVa6KYd21MGRb602JZZEFcYEXNlIgLdiCbgTaej12/Cs5obYI/Ysr203qZldangyGyYp/k51Z7RKkQUHIgIQktJs5tuBLaCHy1WPABqoYX1iud6TOU78B7W+EjxcTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739580; c=relaxed/simple;
	bh=e/S2FECgTIuFJBMe60KsljWBZ/900VoXYuQsDe4xbJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqtmie01J/8IHMWaIs/r/po7psuScMhkdbSWwKByrTvm/u4zPZq0UZc2mTWtN7uezpYeUZirgDxHOkaIZlqIAM7dJViUTP3v5fs3E0TTY1RioV19VUewMG+qbkIPCmvWEQ91XJ7GcrP7oc64YOEZCQJDhaF3oHuCxHHI+UCEWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7hv6lBn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2ZqNS7fpaukLWUM4ISWNMCXuLZuLhXZJI56Y+VCkes=;
	b=i7hv6lBnWR6I9WvTowUFDs2/6AlHRu/76nkrwqcH/jCcPPcscohK5dr2ND8WV7ClDDMhc4
	Hoh/DX+tyWBDrvuGGG2PKpIrHk0yeKvek/K9tNyoaMOSQ3CoiupJ5YOYdEYAOpeM+MtUeJ
	wh9X8tuJs6uvFni6eISCB/UWbhQsfao=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-Nr2P90v3PYGPy62zTVK3og-1; Mon,
 30 Sep 2024 19:39:32 -0400
X-MC-Unique: Nr2P90v3PYGPy62zTVK3og-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E21B19626D4;
	Mon, 30 Sep 2024 23:39:30 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C0EF3003DEC;
	Mon, 30 Sep 2024 23:39:26 +0000 (UTC)
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
Subject: [WIP RFC v2 17/35] rust: drm/kms: Add RawCrtc and RawCrtcState
Date: Mon, 30 Sep 2024 19:10:00 -0400
Message-ID: <20240930233257.1189730-18-lyude@redhat.com>
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

Same thing as RawConnector and RawConnectorState, just for CRTCs now.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/crtc.rs | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 1a3c9c448afcc..246d15a15c14d 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -302,6 +302,25 @@ unsafe fn from_raw<'a>(ptr: *mut bindings::drm_crtc) -> &'a Self {
     }
 }
 
+/// Common methods available on any type which implements [`AsRawCrtc`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// CRTCs.
+pub trait RawCrtc: AsRawCrtc {
+    /// Return the index of this CRTC.
+    fn index(&self) -> u32 {
+        // SAFETY: The index is initialized by the time we expose Crtc objects to users, and is
+        // invariant throughout the lifetime of the Crtc
+        unsafe { (*self.as_raw()).index }
+    }
+
+    /// Return the index of this DRM CRTC in the form of a bitmask.
+    fn mask(&self) -> u32 {
+        1 << self.index()
+    }
+}
+impl<T: AsRawCrtc> RawCrtc for T {}
+
 /// A [`struct drm_crtc`] without a known [`DriverCrtc`] implementation.
 ///
 /// This is mainly for situations where our bindings can't infer the [`DriverCrtc`] implementation
@@ -447,8 +466,10 @@ pub trait AsRawCrtcState {
 
 pub(super) use private::AsRawCrtcState as AsRawCrtcStatePrivate;
 
-/// A trait for providing common methods which can be used on any type that can be used as an atomic
-/// CRTC state.
+/// Common methods available on any type which implements [`AsRawCrtcState`].
+///
+/// This is implemented internally by DRM, and provides many of the basic methods for working with
+/// the atomic state of [`Crtc`]s.
 pub trait RawCrtcState: AsRawCrtcState {
     /// Return the CRTC that owns this state.
     fn crtc(&self) -> &Self::Crtc {
-- 
2.46.1


