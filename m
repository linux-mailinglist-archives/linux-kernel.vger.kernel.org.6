Return-Path: <linux-kernel+bounces-372537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3A9A4A0C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE83283FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 23:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABCD191494;
	Fri, 18 Oct 2024 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XM6tOJQO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C12768E1
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293802; cv=none; b=tPyyba7nqeo2R1y0KKxw9isSEto04nky/e7ep6FnyXURAD9efuq5k4Djhj+U2FRaQIW1jnLC6e8iE13yI2oCWgCoqJTv0HymteIF0uDwG8WjEbdC0hBKU99uUs/nC6CTQ530IYHPXt2Eg9QbIUKJomNHIPQ36SZ4w0z9iiIg9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293802; c=relaxed/simple;
	bh=jkQ5oVMFESfYOiFvRn91EuQksYVygfld3FSvumY5Frw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijSR5xd5QsezsS8+3htfl5vIZR5g9RFWFmH2QY8BFmOOdYOc4bdFHKDKKmXaF9/a0CpD5D3y8nrQ1VbyyxV0EFTFukVXoV4va4hGCcowBPxI/E5z+YyjS1Q6YC/KoZjlgwbNm7Fs4UDxLcm2xq4440guLzPEwlCw/59HX/Puk3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XM6tOJQO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729293799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2B6acW4tTnIG6zQB3rXrmD1k8+xNnpYCn36VFU/vUO8=;
	b=XM6tOJQO3+70L0cjcPGCFagoElkrz5jdLsM8P4zIxTRrnEbqNyFI1ljtk5caeuOItnLPTy
	eFFYuOS5q8PY5s+pDKOYFUEbBwduV/src4LRhSKHszxncML5EGVDhzkSApkaMvtVYBncTw
	EzWcdiytUQsczVZEfwdx037XpXq8zzg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-mzE70CnSNT6mlQi0BnTMaQ-1; Fri,
 18 Oct 2024 19:23:16 -0400
X-MC-Unique: mzE70CnSNT6mlQi0BnTMaQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 154811956080;
	Fri, 18 Oct 2024 23:23:14 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E13319560A2;
	Fri, 18 Oct 2024 23:23:09 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v8 0/3] rust: Add local_irq abstraction, SpinLockIrq
Date: Fri, 18 Oct 2024 19:22:24 -0400
Message-ID: <20241018232306.476664-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This adds a token for annotating contexts where IRQs may be disabled on
non-PREEMPT_RT kernels, a way to use these tokens with Lock types, and
introduces bindings for spin_lock_irqsave() and
spin_unlock_irqrestore().

This patch series depends on the NotThreadSafe type from Alice:

https://lore.kernel.org/rust-for-linux/20240808-alice-file-v9-1-2cb7b934e0e1@google.com/

(Please re-review, since there's been some changes here!)

Lyude Paul (3):
  rust: Introduce local_irq module
  rust: sync: Introduce lock::Backend::Context and
    lock::BackendWithContext
  rust: sync: Add SpinLockIrq

 rust/helpers/helpers.c            |   1 +
 rust/helpers/irq.c                |   8 ++
 rust/helpers/spinlock.c           |  14 +++
 rust/kernel/lib.rs                |   1 +
 rust/kernel/local_irq.rs          |  56 +++++++++++
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock.rs          | 118 ++++++++++++++++++++++-
 rust/kernel/sync/lock/mutex.rs    |   1 +
 rust/kernel/sync/lock/spinlock.rs | 150 ++++++++++++++++++++++++++++++
 9 files changed, 345 insertions(+), 6 deletions(-)
 create mode 100644 rust/helpers/irq.c
 create mode 100644 rust/kernel/local_irq.rs


base-commit: 6ce162a002657910104c7a07fb50017681bc476c
prerequisite-patch-id: 4e3cfb97c9dc94e99912e67f383497848ac6f81d
-- 
2.47.0


