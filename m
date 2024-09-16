Return-Path: <linux-kernel+bounces-331192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF9897A97B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 01:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B573D1C26D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 23:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC014F9DD;
	Mon, 16 Sep 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzPicrWO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1CF9FE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726528728; cv=none; b=neBxFfQjYkyG7hKNmHPyS8lW9I4/KxsGVQZ6C5SPBMtupGTqRFzWfUPhU5TaLvYWgFK0PpRVfL2URl+soa7fKp/flWLiHKRIRCbg3sJP9swUnN184fFMRo7PGOpMEoFZidudS009hatVq1gNXssZX72NKs3PVHOe+lXYvbwgpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726528728; c=relaxed/simple;
	bh=Z/ZJymDHJg7RKH0MUBS1UwUnP282hsZbkrkzbjWY3+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVf9G5aF3mhUVxCat8FhdJi8aqqQzBkSa/gU7mIsn44OlglkZjo6f4FeughME1Ew0PMcIDXbIACn91jMBQxIrVDIoPyssiub/RxVyIiMtKyf+k88Op2aPAb3NhNSLbSnkyWp3AsHl47/2Y6MjOoZuqF7P4Rx69hHudhnVLNWtkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzPicrWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726528725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0PC6UPYOd/7M3SprWhjXyVMVes5yK76DkhkzLnitrjU=;
	b=AzPicrWOSvKiX3FKTUN5ecAQaD4uCI5wtPl7FL6bW66Zj09nOav7Hnbu/MfWoWDb2rmwD0
	gb5HfKlqi/oImVVZjvIJUMqz0XKWoJ41X56aFZI+JyI7Yo0NtJftjGr3zD1vN3JxxTWke+
	zGuR/tLaYbHBdGHtGlK3lfm7qd/Yldw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-VebcTU1OMke-0gs2uSR_BA-1; Mon,
 16 Sep 2024 19:18:42 -0400
X-MC-Unique: VebcTU1OMke-0gs2uSR_BA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A6E719560B8;
	Mon, 16 Sep 2024 23:18:40 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.33.131])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2050F19560A3;
	Mon, 16 Sep 2024 23:18:33 +0000 (UTC)
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
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH v2 0/1] rust: sync: Add Lock::from_raw for Lock<(), B>
Date: Mon, 16 Sep 2024 19:17:30 -0400
Message-ID: <20240916231817.643934-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch just adds a ::from_raw method to the kernel's Lock type,
which can be used for locks where the data type is ().

The current example usecase for this is rvkms, specifically
rust/kernel/drm/device.rs (kernel::drm::device::Device::event_lock())

https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-example-09162024

Lyude Paul (1):
  rust: sync: Add Lock::from_raw() for Lock<(), B>

 rust/kernel/sync/lock.rs | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)


base-commit: a2f11547052001bd448ccec81dd1e68409078fbb
-- 
2.46.0


