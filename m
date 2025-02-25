Return-Path: <linux-kernel+bounces-532526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95751A44EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AE5170D03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988CD19CD0B;
	Tue, 25 Feb 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iF6J8uA6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D79212D7B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519114; cv=none; b=AZUr/fM1cTwFEO1jC+NSH8D40xHTHthkppiWWwctgspCCvBa30vwh0Mp+zzCK8PC1c1Lk8nrzY+my6derIaOno4ATW5XxDxH+Wn9JHpUQxpEAjdh7An+GqEiQ4bKhHTyfPqOEEPJGPaRJcRvCaYUeQZhsTzR+BOe+m/c//SIRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519114; c=relaxed/simple;
	bh=zrhrDgM0ctEpI222qGUx9IWX43BtlDZuRBaUoY+wjYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4ToWxdgDXA4Q2siSwkLX4sLm/qGqH2LCndcTxEwusQHG+dRygLR0Zf6k8UtKtDTkEEXW+vIEMvpGV76OszYlJybb0JNtNgU1xZMjdy15mAOUlZpuDbHRwbzlZ8tZ3dwtNE33j2/PAgMX5kmYJDDDi046+JB5l91bOltHnn+vR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iF6J8uA6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740519110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akEZi1I0P0sCOWBlRceS3uyTfEq/SBGrMjFtQoAVrHE=;
	b=iF6J8uA60BHbgnKDJnM+t5DoKFpHxOuPu+aYLEDpJBtZ7FmAV5NyLrfIjBUojKDkTLpkii
	m3yYFXsL9baWiFUKtPJXveElAPm+D4bX5MK61pxyF7C9UG+JGCK0PxtsQHpRbGYmwWZzId
	bNcJS/M9YKboCLjqq3H7B5naQLPGrlU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-Mf0iJF6vMrmnxoiOX-IgPQ-1; Tue,
 25 Feb 2025 16:31:44 -0500
X-MC-Unique: Mf0iJF6vMrmnxoiOX-IgPQ-1
X-Mimecast-MFC-AGG-ID: Mf0iJF6vMrmnxoiOX-IgPQ_1740519101
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A48BB1800264;
	Tue, 25 Feb 2025 21:31:41 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.234])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 443371955BD4;
	Tue, 25 Feb 2025 21:31:38 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] rust/faux: Add missing parent argument to Registration::new()
Date: Tue, 25 Feb 2025 16:29:01 -0500
Message-ID: <20250225213112.872264-3-lyude@redhat.com>
In-Reply-To: <20250225213112.872264-1-lyude@redhat.com>
References: <20250225213112.872264-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A little late in the review of the faux device interface, we added the
ability to specify a parent device when creating new faux devices - but
this never got ported over to the rust bindings. So, let's add the missing
argument now so we don't have to convert other users later down the line.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/kernel/faux.rs              | 10 ++++++++--
 samples/rust/rust_driver_faux.rs |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 41751403cd868..ae99ea3d114ef 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -23,11 +23,17 @@
 
 impl Registration {
     /// Create and register a new faux device with the given name.
-    pub fn new(name: &CStr) -> Result<Self> {
+    pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
         // SAFETY:
         // - `name` is copied by this function into its own storage
         // - `faux_ops` is safe to leave NULL according to the C API
-        let dev = unsafe { bindings::faux_device_create(name.as_char_ptr(), null_mut(), null()) };
+        let dev = unsafe {
+            bindings::faux_device_create(
+                name.as_char_ptr(),
+                parent.map_or(null_mut(), |p| p.as_raw()),
+                null(),
+            )
+        };
 
         // The above function will return either a valid device, or NULL on failure
         // INVARIANT: The device will remain registered until faux_device_destroy() is called, which
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index 048c6cb98b29a..58a3a94121bff 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -20,7 +20,7 @@ impl Module for SampleModule {
     fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
-        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"))?;
+        let reg = faux::Registration::new(c_str!("rust-faux-sample-device"), None)?;
 
         dev_info!(reg.as_ref(), "Hello from faux device!\n");
 
-- 
2.48.1


