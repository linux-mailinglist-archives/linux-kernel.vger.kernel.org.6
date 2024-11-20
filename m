Return-Path: <linux-kernel+bounces-416369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822D89D43E8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F8B1F22822
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFBC1C7292;
	Wed, 20 Nov 2024 22:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fP4QTdyE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199FA1C6F54
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141681; cv=none; b=Ji965t95Iz2d+IwyCLo+gPwulq+Foqmw6oA+JctCHIS7RuE6/Koa1/KuammHeY6rFPHbCz9dhkLsBP+1/UpXhzBdjavexkCdryZlsOY/mDQFfX1X+jCBkLwavewz97XAA0Yz/pIfXJBdDpw04r3ocjJMciEVs3pNnxmbit5JV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141681; c=relaxed/simple;
	bh=+lVGu84p1gi7XJweOuTj9nd0/+5uqOqhs1NVKt6TfWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYJJiNtiacvfnoOAmgadkQR/O8wBAHUxCTTsbTd829/3jdDTNdb8NkakYL/pfxBs6fELQUHmxP1xlaBhH3WP4IJR5pR6eUe3MrdYI3oSC8N4AiXtPKgD6kM16gkBFsyMhvKh+gqnc01oVF0D3W7Ph9VucBRHglBjw2M4/1DB4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fP4QTdyE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732141679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnF/ASEMLKIeD+1oLAnAGOV+Mp//Bp/l46axBXA2lAs=;
	b=fP4QTdyEVEiPMhhVebhoAPVkwX7ZbGy+fLz9dQxrAVhPV78BPcikKLPa2ydgASSLYy/19f
	TeAgrBGaYGLQPMUmwI0IFLZqM+Xyar0rfNAUkp/3lO1Q+kKzI9q4WhyUcW8JoXjuwnYKj5
	bohm/Ng//8821fjQ4twlBBFAKVIscfk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-uPc41WsFM0SENU5OA-ue5Q-1; Wed,
 20 Nov 2024 17:27:55 -0500
X-MC-Unique: uPc41WsFM0SENU5OA-ue5Q-1
X-Mimecast-MFC-AGG-ID: uPc41WsFM0SENU5OA-ue5Q
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A57701955F3C;
	Wed, 20 Nov 2024 22:27:53 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4470B1956086;
	Wed, 20 Nov 2024 22:27:50 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Filipe Xavier <felipe_life@live.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 1/2] rust: sync: Add MutexGuard type alias
Date: Wed, 20 Nov 2024 17:26:28 -0500
Message-ID: <20241120222742.2490495-2-lyude@redhat.com>
In-Reply-To: <20241120222742.2490495-1-lyude@redhat.com>
References: <20241120222742.2490495-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

A simple helper alias for code that needs to deal with Guard types returned
from Mutexes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync.rs            | 2 +-
 rust/kernel/sync/lock/mutex.rs | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 2bdd1cffcdab3..0f630714da2aa 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -15,7 +15,7 @@
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
-pub use lock::mutex::{new_mutex, Mutex};
+pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
 
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 0e946ebefce12..10a70c07268dc 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -86,6 +86,14 @@ macro_rules! new_mutex {
 /// [`struct mutex`]: srctree/include/linux/mutex.h
 pub type Mutex<T> = super::Lock<T, MutexBackend>;
 
+/// A [`Guard`] acquired from locking a [`Mutex`].
+///
+/// This is simply a type alias for a [`Guard`] returned from locking a [`Mutex`]. It will unlock
+/// the [`Mutex`] upon being dropped.
+///
+/// [`Guard`]: super::Guard
+pub type MutexGuard<'a, T> = super::Guard<'a, T, MutexBackend>;
+
 /// A kernel `struct mutex` lock backend.
 pub struct MutexBackend;
 
-- 
2.47.0


