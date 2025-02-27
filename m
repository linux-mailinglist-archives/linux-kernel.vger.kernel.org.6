Return-Path: <linux-kernel+bounces-537200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223ACA48919
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CBA3A5E56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3181D21ABA1;
	Thu, 27 Feb 2025 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFBNmSue"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A8270054
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684936; cv=none; b=IYiBjfav6HxzPqd9h3aJYw7oJqoA3/EXZt3yG2nCbzzYcyIEeBP8wY8WAJi9nkE0txWpOtNfVKOCk/pE0bDIxT/wPsY4Gw4NfKUNg1Lv933+eeKGzeEKeRHm1BVmcsZAKpgcDqYACXQ+OM0/gMLA+7UxrBu7yM7MDw3mMH9iLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684936; c=relaxed/simple;
	bh=FH0gbpAWBPT4AWbZ3ePpIZYvCfi4ApXO9/ZceptCgcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fATNZ5qB8BPC2ArteQWLkRwCYAOiRMuCPaIeM6E3alUPT4I0W+9wkzNda/mFEkdoq2fDFPDndr8sJP4LcyJ/YxOLptLl7O7iLI6YU0E/fMClUXe5Hb9U5uYrjEkZWoAahiTLWyFnO+vIeN79Q07jLpMd/BXNVRxNip81wRUi1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFBNmSue; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740684933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DnGJyjIdsCMLEUIDz023Z2Ivnfma9tOFIkKCoKLI8v4=;
	b=dFBNmSuenY6Y/spQBTOYWbXjhL2qkD+fTli7kcHKVIBdEIKhbKm1zXKj8bWD5IVwgaXKoB
	V95Z049S7xHwNRNDSfaFA5SFUeamM2tuzLfF5K5KxVVfT6WatXP0qNpzQQusdK0IUYciYv
	feeg7zdacvJq2dOEGGF/UNMe4veszxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-ddD6ZWaxPqaYAcq1ipvTUA-1; Thu,
 27 Feb 2025 14:35:30 -0500
X-MC-Unique: ddD6ZWaxPqaYAcq1ipvTUA-1
X-Mimecast-MFC-AGG-ID: ddD6ZWaxPqaYAcq1ipvTUA_1740684928
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2441180087F;
	Thu, 27 Feb 2025 19:35:27 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.89.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6611219560AE;
	Thu, 27 Feb 2025 19:35:24 +0000 (UTC)
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
Subject: [PATCH v2] rust/faux: Add missing parent argument to Registration::new()
Date: Thu, 27 Feb 2025 14:35:06 -0500
Message-ID: <20250227193522.198344-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

A little late in the review of the faux device interface, we added the
ability to specify a parent device when creating new faux devices - but
this never got ported over to the rust bindings. So, let's add the missing
argument now so we don't have to convert other users later down the line.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
V2:
- Add SAFETY comment about `parent`
 rust/kernel/faux.rs              | 13 +++++++++++--
 samples/rust/rust_driver_faux.rs |  2 +-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 41751403cd868..3277f35c3f79b 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -23,11 +23,20 @@
 
 impl Registration {
     /// Create and register a new faux device with the given name.
-    pub fn new(name: &CStr) -> Result<Self> {
+    pub fn new(name: &CStr, parent: Option<&device::Device>) -> Result<Self> {
         // SAFETY:
         // - `name` is copied by this function into its own storage
         // - `faux_ops` is safe to leave NULL according to the C API
-        let dev = unsafe { bindings::faux_device_create(name.as_char_ptr(), null_mut(), null()) };
+        // - `parent` can be either NULL or a pointer to a `struct device`, and `faux_device_create`
+        //   will take a reference to `parent` using `device_add` - ensuring that it remains valid
+        //   for the lifetime of the faux device.
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
 

base-commit: be5c7bbb3a64baf884481a1ba0c2f8fb2f93f7c3
prerequisite-patch-id: 9fdd77ac551de34c26f3910137354e21e04d85e0
-- 
2.48.1


