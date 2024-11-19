Return-Path: <linux-kernel+bounces-415031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189ED9D30D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75271F232BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C51D47A0;
	Tue, 19 Nov 2024 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgKJ+45T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7CE1D6DD1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732057928; cv=none; b=k24iJ0elefwx1mHPII3cyJTHlGwm5GgvlDm8hBKhA1pPhUPEThfEsJfI1IAzTM2qL/6Y8wWFmaZ3Gl54A98UoWKZz402CVUtGqc+3kRp1KLahFObhSnKTpRoiLHVYG3QzC4RauwZ9MNhGjq3WHyoaIMe5NwF/TwNt3X5cQ4q8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732057928; c=relaxed/simple;
	bh=gPr2XVwTvpeMGoGKKjy1o51c1OdPhbUKPI0zWGhZTCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoRbxJS+j8z/gjo7qicXhlxtjfLkPvKP8lFBTNgaad5zAxNPApuf6RS3gPF2JI2IboQ9rhC3eMeByv3yoXd5qc+Rk7kiBkh3UGbU8blolFDRRH/FauDC/qWsXnWCP94Y+jtfcce3SooXamvrKOX8j8eFx7qHsXC3oig7g7UBOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgKJ+45T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732057926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=we497OO4sE4VwaggdPe1vay+83PO5OaOAYCik3HBUv8=;
	b=HgKJ+45TdZKghGQVcn9BE6PaKxhM/8MfJM89olicFXWyvKvYVsF0oboiGCSRD+SPBiHSre
	k6ISTDp11d4mFYuUZCSzZmgEI5RTbIIZYvNr4YmDXGRA5h/BcjL0pXIOoNPOF/zy8DzeSV
	5R/wfpw3J4VPh2nVfnkDIKFXFpP4qH0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-Ctp0QUDxNAaeQxlaH8BMmA-1; Tue,
 19 Nov 2024 18:12:02 -0500
X-MC-Unique: Ctp0QUDxNAaeQxlaH8BMmA-1
X-Mimecast-MFC-AGG-ID: Ctp0QUDxNAaeQxlaH8BMmA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B5721956088;
	Tue, 19 Nov 2024 23:11:58 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27ED130000DF;
	Tue, 19 Nov 2024 23:11:56 +0000 (UTC)
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
	Valentin Obst <kernel@valentinobst.de>,
	Filipe Xavier <felipe_life@live.com>
Subject: [PATCH v4 2/2] rust: sync: Make Guard::new() public
Date: Tue, 19 Nov 2024 18:11:04 -0500
Message-ID: <20241119231146.2298971-3-lyude@redhat.com>
In-Reply-To: <20241119231146.2298971-1-lyude@redhat.com>
References: <20241119231146.2298971-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since we added a Lock::from_raw() function previously, it makes sense to
also introduce an interface for creating a Guard from a reference to a Lock
for instances where we've derived the Lock from a raw pointer and know that
the lock is already acquired, something we do in the KMS API.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index ea65f84b76f8e..139f17f2ec86b 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -229,7 +229,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// # Safety
     ///
     /// The caller must ensure that it owns the lock.
-    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
+    pub unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         Self {
             lock,
             state,
-- 
2.47.0


