Return-Path: <linux-kernel+bounces-391436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFF9B86B7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691201C23179
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A45F1E8836;
	Thu, 31 Oct 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhEuwGSn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D4D1E2829
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416250; cv=none; b=MOPf44Y/Q/XMxosV0TOVjLe8r3crv/nulMxTCCaPfOdMfvKaLZ7g69fcEFPPgCxICK7IFrugFC0F34LP7D5+erkQenzWUGizcGQQ/s5bWg/CHk7OTY+rR2LbT4glRT0e5sBWgwRgXpYe52UZA93PTBeMEe740kyNvamFXf/77zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416250; c=relaxed/simple;
	bh=lAb+KoAdQ87cofb05ltyd5UIDk8kT+Z5t0DWa4dPvI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgP6XB6ePsAcuG6HM8Vd44vRrMrup7B1Y34ksyMIeylC55BlGP37LxvggexqFlORWl+Is05nZaRJPKb687Q2NbDZeyVxBjDSz5jjWajxMWuO/C3GxFo1REojL6zpkX448Dzb0SXRtbCvSOAbmoGNCU+pYsn2yp7H4D3KjGT2+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhEuwGSn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730416243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DZnsYyIg0Og+DO16uL+SmlJ8+QeUunLJYMjB8ZHgwo=;
	b=YhEuwGSnbQuAhf9l4/nidqCRUuyR1CvNfP+XAJb5BezDwzi8kMvAAO6A0Eb4Xb1rMtDTz+
	Y/98ao6JSL1EWmpRUYWgo8Lmg64KotzORnp2cBfrTvnqeI4+jBXPn8o8gtD8uciVTNl/A3
	FXhhTs3b+AcFgJAFGe1LdEyUziPoQEU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-CcWf5aMIOQihoeTAbhAwvA-1; Thu,
 31 Oct 2024 19:10:40 -0400
X-MC-Unique: CcWf5aMIOQihoeTAbhAwvA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2716219560B1;
	Thu, 31 Oct 2024 23:10:38 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.202])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DE8F1956052;
	Thu, 31 Oct 2024 23:10:34 +0000 (UTC)
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
Subject: [PATCH v3 2/2] rust: sync: Make Guard::new() public
Date: Thu, 31 Oct 2024 19:08:45 -0400
Message-ID: <20241031231025.3466571-3-lyude@redhat.com>
In-Reply-To: <20241031231025.3466571-1-lyude@redhat.com>
References: <20241031231025.3466571-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Since we added a Lock::from_raw() function previously, it makes sense to
also introduce an interface for creating a Guard from a reference to a Lock
for instances where we've derived the Lock from a raw pointer and know that
the lock is already acquired, something we do in the KMS API.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index c7b0c6351f793..4d6d5e00ca334 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -225,7 +225,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
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


