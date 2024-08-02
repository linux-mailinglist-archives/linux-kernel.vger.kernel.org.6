Return-Path: <linux-kernel+bounces-271934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075EF945525
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E3B1C221D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903734C9D;
	Fri,  2 Aug 2024 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPad1rk7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AC4C66
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557718; cv=none; b=iLzCAuDeR4gtkyCdp8RMvSQSMTd2MjkW51GYBHFZGVIXc911A/mXRCO91MWCzfQ0yNPhvDAD/tPPc8FrtJtWgR9yb47PuN3RPjr45RDjs5bdDv2RSAfA1lzYl4Pn653cNShjIqWuQNzwLxa/9J6syYgoCtsaU90i9vo5GRaRfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557718; c=relaxed/simple;
	bh=H8w51v+nXeO1qfzgzLbh/xeQk/YWg7SgUXJXZKyKaRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJ1o+lh6POdKHtrW/R4QbBTF+lWwqdaYa6lxSz+nUVvbvofIFIQwXmbx3XlA3IwuTS9OKnDifIQYJ4p8lMichx4I2Ab2IyNyuxNFCyPcDU29CxI+DfmwHVrLGeymvT+QnC95raIiAqYoK8YpCNJkVsBgF1xpwymD5SVgaIM69e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPad1rk7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722557716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yIferRbCZzSXIPIM3xVfnJIMFNXeCsJZwI7KPb1OH+w=;
	b=NPad1rk7Uc2EboEKgpr+/RI6IeRv6n+UnLSrkE//AShLIdiKTGQkQlzWr37g3bBbgZ1+9j
	C+5ZZ5TRDDnQ/2KER2/cKFzwKoC9F/UnWIZN8oTuIN83Bmltgw7GkqcNA/dS4t077+QdZG
	MFAUzx9bS5F5hjzU3VW1ahmNJ66FXsg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-WOYZ4MaYNDquGgwqst0z8Q-1; Thu,
 01 Aug 2024 20:15:12 -0400
X-MC-Unique: WOYZ4MaYNDquGgwqst0z8Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76C111955D45;
	Fri,  2 Aug 2024 00:15:10 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.9.60])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B0B01955D42;
	Fri,  2 Aug 2024 00:15:05 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v3 0/3] rust: Add irq abstraction, SpinLockIrq
Date: Thu,  1 Aug 2024 20:09:59 -0400
Message-ID: <20240802001452.464985-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This adds a simple interface for disabling and enabling CPUs, along with
the ability to mark a function as expecting interrupts be disabled -
along with adding bindings for spin_lock_irqsave/spin_lock_irqrestore().

Current example usecase (very much WIP driver) in rvkms:

https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-example-08012024

specifically drivers/gpu/drm/rvkms/crtc.rs

(The kunit tests also compile)

Lyude Paul (3):
  rust: Introduce irq module
  rust: sync: Introduce lock::Backend::Context
  rust: sync: Add SpinLockIrq

 rust/helpers.c                    |  22 +++++++
 rust/kernel/irq.rs                |  84 ++++++++++++++++++++++++
 rust/kernel/lib.rs                |   1 +
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock.rs          |  17 ++++-
 rust/kernel/sync/lock/mutex.rs    |   1 +
 rust/kernel/sync/lock/spinlock.rs | 105 ++++++++++++++++++++++++++++++
 7 files changed, 229 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/irq.rs


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
2.45.2


