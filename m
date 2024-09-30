Return-Path: <linux-kernel+bounces-344989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F398B0F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5627B24139
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156251A2561;
	Mon, 30 Sep 2024 23:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dwmyw69J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761E198824
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739519; cv=none; b=R2BSp+KaV0L8nd1IzncxcXmzFtpAJcqRMEvyXtaXSvdyjiiNm8ZCjauTZMwRSV7fDWGRpOK9HnISHFw9mIOAfyW3H4IZ15kjSNdNAJVtA6zWutWqdGN1ujxjTXB4a6OpXYhl9i/4UVDfojZ9YKtiVUqwLwObYUeLyi7E6TI4SWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739519; c=relaxed/simple;
	bh=yB1CR6nghtycKraMGw9ly/5Z/34pxsLJc1oWE+UbMNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpFPCftAmvumyBj7+AC6VMQXg4wqPIMMkBC5IFghf9CAlU2ApuMeyBig9jzW+EIHIyviODHK8tWt0YsiyVwsVnaXckOCmXppawFnys7hAzWtFlWKW424XsvKc43FSfQc4Mm3Jw0qZZxiUm5VNalj/m+s67yRa0GR+wdQL7ekVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dwmyw69J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727739517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PJ3TeIAd9cs6+pu/8iyKEZ6SOjd6owM+icv2Rkamtr8=;
	b=Dwmyw69J0aChcEuF3AeoUf40Ky2IT7DwqU3WnSFVpl0jhhLzrcTLRp6HOwUQhb6xewGYzD
	QdbMecu+zA+xL9e1Td+onFt5hi4TbM0D6btC6I/rcPNE1cbpRcpX1x9KqXmoJ7ZXs12tYm
	Dum9eoleICjp83Cl3xaH285BfF3J3ns=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-w3nDE2ciOuyU1w2ZEh1kUw-1; Mon,
 30 Sep 2024 19:38:34 -0400
X-MC-Unique: w3nDE2ciOuyU1w2ZEh1kUw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D37519560B7;
	Mon, 30 Sep 2024 23:38:31 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.32.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36C723003FD1;
	Mon, 30 Sep 2024 23:38:27 +0000 (UTC)
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
Subject: [WIP RFC v2 09/35] WIP: rust: drm/kms: Add Connector.attach_encoder()
Date: Mon, 30 Sep 2024 19:09:52 -0400
Message-ID: <20240930233257.1189730-10-lyude@redhat.com>
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

This adds a simple binding for completing the last step of creating a DRM
connector - attaching its encoder. This function should only be called
before the connector is registered, and DRM should enforce this itself by
returning an error if a driver tries to add an encoder to an
already-registered DRM connector.

Note that unlike most of the methods we'll be adding to DRM mode objects,
this is directly implemented on the Connector<T> type since I don't really
think it would make sense for us to allow this operation on an
OpaqueConnector (a DRM connector without a known DriverConnector
implementation, something we'll be adding in the next few commits).

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

TODO:
* Figure out a solution for making sure that this can only be called when a
  Connector is unregistered, probably via an UnregisteredConnector type.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/drm/kms/connector.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 0fa927a3743b2..54457b327c365 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -28,6 +28,7 @@
 use super::{
     ModeObject,
     RcModeObject,
+    encoder::*,
     KmsDriver,
 };
 use macros::pin_data;
@@ -227,6 +228,20 @@ pub fn new(
             ARef::from_raw(NonNull::new_unchecked(Box::into_raw(Pin::into_inner_unchecked(new))))
         })
     }
+
+    /// Attach an encoder to this [`Connector`].
+    ///
+    /// TODO: Move this to an `UnregisteredConnector` interface somehow…
+    #[must_use]
+    pub fn attach_encoder<E>(&self, encoder: &Encoder<E>) -> Result
+    where
+        E: DriverEncoder<Driver = T::Driver>
+    {
+        // SAFETY: FFI call with no special requirements
+        to_result(unsafe {
+            bindings::drm_connector_attach_encoder(self.as_raw(), encoder.as_raw())
+        })
+    }
 }
 
 /// A trait implemented by any type that acts as a [`struct drm_connector`] interface.
-- 
2.46.1


