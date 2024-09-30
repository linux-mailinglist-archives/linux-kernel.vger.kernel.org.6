Return-Path: <linux-kernel+bounces-344990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F070C98B0F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642CA1F2108E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670218C918;
	Mon, 30 Sep 2024 23:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnAN1Cck"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFE618C909
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739529; cv=none; b=FbNccQiu2/Q+Fk9CjVD3i8FYTQNhYFEA8qiNG+7Mh0VPa2INmhNAd9XQFXBUtdIAz3sFnuRREk4GDpqwj1XSAR2M3pXfbU/N5tiOOIeUWUGlJVahoYLKF7dUhrsZPwUICIfUT6Ev7ftCufljRLxMxc3xP/cPOnsX4AEA6WKlCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739529; c=relaxed/simple;
	bh=c4eiuZdsRj7afF+3jw40ZTHmY1qU4WuvzFmyE12lS0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh2CDepxj2MAW9ogPDJ6AZLToI5G0bDUaPngPp4GgaC1mzNAecLCwTurr0rEzZE0GQUT5S3ubDomgyLiIknNovqIAB9Or1kDq/vVjwDUBMh3yLSwg9JlgcQDImJUbLXas1MCqwkG3ma6b+EqPpjTDuo3aEaNQg8lNjuFPSyDojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnAN1Cck; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JlrhV03R2ar0qDWbNL3ocjtNNVJ3Ps0MyvSIOpYYekY=;
	b=CnAN1Cck4bloD3jmRGEF9xu4XhHB3rOyy8fqUogdkTu0Z1IZwnk0bm+Zx62xffHpLihWGE
	OK314QfaOUssM5Q8Tfvc9Qd7Ktun606fAGQx5WObdy0sNkPYdxImAXP651Ox46Lw1UPv4o
	9R/XB3a8wCpTk1lyMOT4S6AL2R2MYjM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-B90LovqUMrGEpOIDcW1CJw-1; Mon,
 30 Sep 2024 19:38:43 -0400
X-MC-Unique: B90LovqUMrGEpOIDcW1CJw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48B401955F09;
	Mon, 30 Sep 2024 23:38:40 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E0E33003E4D;
	Mon, 30 Sep 2024 23:38:36 +0000 (UTC)
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
Subject: [WIP RFC v2 10/35] rust: drm/kms: Add DriverConnector::get_mode callback
Date: Mon, 30 Sep 2024 19:09:53 -0400
Message-ID: <20240930233257.1189730-11-lyude@redhat.com>
In-Reply-To: <20240930233257.1189730-1-lyude@redhat.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Next up is filling out some of the basic connector hotplugging callbacks -
which we'll need for setting up the fbdev helpers for KMS devices. Note
that connector hotplugging in DRM follows a BFL scheme: pretty much all
probing is protected under the mighty drm_device->mode_config.lock, which
of course is a bit counter-intuitive to rust's locking schemes where data
is always associated with its lock.

Since that lock is embedded in an FFI type and not a rust type, we need to
introduce our own wrapper type that acts as a lock acquisition for this.
This brings us to introducing a few new types:

* ModeConfigGuard - the most basic lock guard, as long as this object is
  alive we are guaranteed to be holding drm_device->mode_config.lock. This
  object doesn't do much else on its own currently.
* ConnectorGuard - an object which corresponds to a specific typed DRM
  connector. This can only be acquired with a ModeConfigGuard, and will be
  used to allow calling methods that are only safe to call with
  drm_device->mode_config.lock held. Since it implements
  Deref<Target=Connector<T>> as well, it can also be used for any other
  operations that would normally be available on a DRM connector.

And finally, we add the DriverConnector::get_modes() trait method which
drivers can use to implement the drm_connector_helper_funcs.get_modes
callback. Note that while we make this trait method mandatory, we only do
so for the time being since VKMS doesn't do very much with DRM connectors -
and as such we have no need yet to implement alternative connector probing
schemes outside of get_modes().

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms.rs           | 70 ++++++++++++++++++++++++++++++++
 rust/kernel/drm/kms/connector.rs | 57 ++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index d5cad598f016f..d74267c78864f 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -18,6 +18,8 @@
     types::*,
     error::to_result,
     private::Sealed,
+    sync::{Mutex, MutexGuard},
+    container_of
 };
 use core::{
     ops::Deref,
@@ -233,6 +235,21 @@ impl<T, K> KmsDriver for T
     T: Driver<Kms = K>,
     K: Kms<Driver = T> {}
 
+impl<T: KmsDriver> Device<T> {
+    /// Retrieve a pointer to the mode_config mutex
+    #[inline]
+    pub(crate) fn mode_config_mutex(&self) -> &Mutex<()> {
+        // SAFETY: This lock is initialized for as long as `Device<T>` is exposed to users
+        unsafe { Mutex::from_raw(&mut (*self.as_raw()).mode_config.mutex) }
+    }
+
+    /// Acquire the [`mode_config.mutex`] for this [`Device`].
+    #[inline]
+    pub fn mode_config_lock(&self) -> ModeConfigGuard<'_, T> {
+        ModeConfigGuard(self.mode_config_mutex().lock(), PhantomData)
+    }
+}
+
 /// A modesetting object in DRM.
 ///
 /// This is any type of object where the underlying C object contains a [`struct drm_mode_object`].
@@ -339,3 +356,56 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         unsafe { bindings::drm_mode_object_put(obj.as_ref().raw_mode_obj()) }
     }
 }
+
+/// A mode config guard.
+///
+/// This is an exclusive primitive that represents when [`drm_device.mode_config.mutex`] is held - as
+/// some modesetting operations (particularly ones related to [`connectors`](connector)) are still
+/// protected under this single lock. The lock will be dropped once this object is dropped.
+///
+/// # Invariants
+///
+/// - `self.0` is contained within a [`struct drm_mode_config`], which is contained within a
+///   [`struct drm_device`].
+/// - The [`KmsDriver`] implementation of that [`struct drm_device`] is always `T`.
+/// - This type proves that [`drm_device.mode_config.mutex`] is acquired.
+///
+/// [`struct drm_mode_config`]: (srctree/include/drm/drm_device.h)
+/// [`drm_device.mode_config.mutex`]: (srctree/include/drm/drm_device.h)
+/// [`struct drm_device`]: (srctree/include/drm/drm_device.h)
+pub struct ModeConfigGuard<'a, T: KmsDriver>(MutexGuard<'a, ()>, PhantomData<T>);
+
+impl<'a, T: KmsDriver> ModeConfigGuard<'a, T> {
+    /// Construct a new [`ModeConfigGuard`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that [`drm_device.mode_config.mutex`] is acquired.
+    ///
+    /// [`drm_device.mode_config.mutex`]: (srctree/include/drm/drm_device.h)
+    pub(crate) unsafe fn new(drm: &'a Device<T>) -> Self {
+        // SAFETY: Our safety contract fulfills the requirements of `MutexGuard::new()`
+        Self(unsafe { MutexGuard::new(drm.mode_config_mutex(), ()) }, PhantomData)
+    }
+
+    /// Return the [`Device`] that this [`ModeConfigGuard`] belongs to.
+    pub fn drm_dev(&self) -> &'a Device<T> {
+        // SAFETY:
+        // - `self` is embedded within a `drm_mode_config` via our type invariants
+        // - `self.0.lock` has an equivalent data type to `mutex` via its type invariants.
+        let mode_config = unsafe { container_of!(self.0.lock, bindings::drm_mode_config, mutex) };
+
+        // SAFETY: And that `drm_mode_config` lives in a `drm_device` via type invariants.
+        unsafe { Device::borrow(container_of!(mode_config, bindings::drm_device, mode_config)) }
+    }
+
+    /// Assert that the given device is the owner of this mode config guard.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `dev` is different from the owning device for this mode config guard.
+    #[inline]
+    pub(crate) fn assert_owner(&self, dev: &Device<T>) {
+        assert!(ptr::eq(self.drm_dev(), dev));
+    }
+}
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 54457b327c365..57ab29473c344 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -19,7 +19,7 @@
 use core::{
     marker::*,
     ptr::null_mut,
-    mem,
+    mem::{self, ManuallyDrop},
     ptr::{self, NonNull, addr_of_mut},
     ffi::*,
     ops::*,
@@ -28,6 +28,7 @@
 use super::{
     ModeObject,
     RcModeObject,
+    ModeConfigGuard,
     encoder::*,
     KmsDriver,
 };
@@ -93,7 +94,7 @@ pub trait DriverConnector: Send + Sync + Sized {
             destroy: Some(connector_destroy_callback::<Self>),
             force: None,
             detect: None,
-            fill_modes: None,
+            fill_modes: Some(bindings::drm_helper_probe_single_connector_modes),
             debugfs_init: None,
             oob_hotplug_event: None,
             atomic_duplicate_state: Some(atomic_duplicate_state_callback::<Self::State>),
@@ -101,7 +102,7 @@ pub trait DriverConnector: Send + Sync + Sized {
         helper_funcs: bindings::drm_connector_helper_funcs {
             mode_valid: None,
             atomic_check: None,
-            get_modes: None,
+            get_modes: Some(get_modes_callback::<Self>),
             detect_ctx: None,
             enable_hpd: None,
             disable_hpd: None,
@@ -132,6 +133,12 @@ pub trait DriverConnector: Send + Sync + Sized {
     ///
     /// Drivers may use this to instantiate their [`DriverConnector`] object.
     fn new(device: &Device<Self::Driver>, args: Self::Args) -> impl PinInit<Self, Error>;
+
+    /// Retrieve a list of available display modes for this [`Connector`].
+    fn get_modes<'a>(
+        connector: ConnectorGuard<'a, Self>,
+        guard: &ModeConfigGuard<'a, Self::Driver>
+    ) -> i32;
 }
 
 /// The generated C vtable for a [`DriverConnector`].
@@ -229,6 +236,19 @@ pub fn new(
         })
     }
 
+    /// Acquire a [`ConnectorGuard`] for this connector from a [`ModeConfigGuard`].
+    ///
+    /// This verifies using the provided reference that the given guard is actually for the same
+    /// device as this connector's parent.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `guard` is not a [`ModeConfigGuard`] for this connector's parent [`Device`].
+    pub fn guard<'a>(&'a self, guard: &ModeConfigGuard<'a, T::Driver>) -> ConnectorGuard<'a, T> {
+        guard.assert_owner(self.drm_dev());
+        ConnectorGuard(self)
+    }
+
     /// Attach an encoder to this [`Connector`].
     ///
     /// TODO: Move this to an `UnregisteredConnector` interface somehow…
@@ -327,6 +347,37 @@ unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connector) -> &'a Self {
     drop(unsafe { Box::from_raw(connector as *mut Connector<T>) });
 }
 
+unsafe extern "C" fn get_modes_callback<T: DriverConnector>(
+    connector: *mut bindings::drm_connector,
+) -> c_int {
+    // SAFETY: This is safe via `DriverConnector`s type invariants.
+    let connector = unsafe { Connector::<T>::from_raw(connector) };
+
+    // SAFETY: This FFI callback is only called while `mode_config.lock` is held
+    let guard = ManuallyDrop::new(unsafe { ModeConfigGuard::new(connector.drm_dev()) });
+
+    T::get_modes(connector.guard(&guard), &guard)
+}
+
+/// A privileged [`Connector`] obtained while holding a [`ModeConfigGuard`].
+///
+/// This provides access to various methods for [`Connector`] that must happen under lock, such as
+/// setting resolution preferences and adding display modes.
+///
+/// # Invariants
+///
+/// Shares the invariants of [`ModeConfigGuard`].
+#[derive(Copy, Clone)]
+pub struct ConnectorGuard<'a, T: DriverConnector>(&'a Connector<T>);
+
+impl<T: DriverConnector> Deref for ConnectorGuard<'_, T> {
+    type Target = Connector<T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
 // SAFETY: DRM expects this struct to be zero-initialized
 unsafe impl Zeroable for bindings::drm_connector_state {}
 
-- 
2.46.1


