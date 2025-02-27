Return-Path: <linux-kernel+bounces-537399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC552A48B60
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126617A8272
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD027FE77;
	Thu, 27 Feb 2025 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnNXYaer"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945F27FE73
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694913; cv=none; b=H7Tkka5zm4O6pD/bvHPzkIiMVoXsGoxYzC+VZ6XiwJTFuP8W9F41/q0Qpf3QCJtyjXPH0fVUyTi6yAiJb4QXJTFnPT0qWkINhKcfjPlSNxvnTg8lXSxQJJzudLLqz/9XkE9y+v0Ho5NyDnGzVxYL4iAajsJhvwj7VDHaGups+0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694913; c=relaxed/simple;
	bh=jF/Rhzpzm/dHCcOSMAyGvRp49x3ckxeqe/+xym+bBPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuuUnXwoTftPh0rc5gyI1ZVJRpHdluPmXeT+h9/2HEoewuIKI60tkmcSbjYFT6Dsq9JjO0nQpVW01PWyOKlOfSzGrPonsPoxQgqr994Vagv62GPguuoooHBjEypK296t/+1wyyn6Z9CXYi9kQBZD9dDqQAXseY55QsIrOwGItjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnNXYaer; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740694910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMPVRvmOY4K4fNwOzdANhVMl0k0pQryl0H5Q7HLHGko=;
	b=LnNXYaersPXK9mHIeaJnzwjnj6MPqSiXMxL1c8hazK8wMdVo93tr978Q4USqOFKll5Lrf6
	TZ44mmAF0XnDd/A0X4GyKLnWdEegfU9eL7Q4GgC+oynDvXNUic3UjKPECKxMU4YxEnKhnU
	QnhsFV7jLkPnAD2BSng5F20qmtfLNS8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-0CdOvRe4M6efnGidCvpoMg-1; Thu,
 27 Feb 2025 17:21:46 -0500
X-MC-Unique: 0CdOvRe4M6efnGidCvpoMg-1
X-Mimecast-MFC-AGG-ID: 0CdOvRe4M6efnGidCvpoMg_1740694904
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1921A1800988;
	Thu, 27 Feb 2025 22:21:44 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.89.128])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E5AD1944D02;
	Thu, 27 Feb 2025 22:21:40 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)
Subject: [PATCH v9 5/9] rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
Date: Thu, 27 Feb 2025 17:10:16 -0500
Message-ID: <20250227221924.265259-6-lyude@redhat.com>
In-Reply-To: <20250227221924.265259-1-lyude@redhat.com>
References: <20250227221924.265259-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Boqun Feng <boqun.feng@gmail.com>

spin_lock_irq_disable() and spin_unlock_irq_enable() are inline
functions, to use them in Rust, helpers are introduced. This is for
interrupt disabling lock abstraction in Rust.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/helpers/spinlock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 42c4bf01a23e4..d4e61057c2a7a 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -35,3 +35,18 @@ void rust_helper_spin_assert_is_held(spinlock_t *lock)
 {
 	lockdep_assert_held(lock);
 }
+
+void rust_helper_spin_lock_irq_disable(spinlock_t *lock)
+{
+	spin_lock_irq_disable(lock);
+}
+
+void rust_helper_spin_unlock_irq_enable(spinlock_t *lock)
+{
+	spin_unlock_irq_enable(lock);
+}
+
+int rust_helper_spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return spin_trylock_irq_disable(lock);
+}
-- 
2.48.1


