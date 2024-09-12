Return-Path: <linux-kernel+bounces-325785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35142975E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6590F1C21F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFC41877;
	Thu, 12 Sep 2024 00:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEceMrOf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B22F3E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726102554; cv=none; b=Cq+GSL2BpDkJiehtbpo7547Sa1jsD1Ryyc2EqkMLQicbGAUe2z8VQjY2VXD0VWUdX4xLl7LnkJa5zI4PdDW9a5MbqzOMhkzCJ9+3wSr/wAHDpN06lghUSNjanDsB0nxeUETYuqyxwOrIWcepX+oQA5q9pbxbHHL+EZms99vCFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726102554; c=relaxed/simple;
	bh=allnzNoZ5adyq7EbzXq3qivJGaoQmFasRqpMPa5ZioU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1CSJ1wT6+cacXhPuFWO+6VPCiXUABN0lwtJiDa/ZKUwm8vwG7c/i1fWf5aJ3+Xk8x9lXG9IDqZh2LbuCfMPOMyrgsOim+phjWgyj8ChNvYJ8qPwM4BmFFcnqjbV72T2ZopkL0v6OuEf1gnFVdxCtXAvwDuh+iyt/BrYTiczkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEceMrOf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726102551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vq8g+VbGslfb1hOl6tAeTLv/FON/Of4no1HXOLBWnao=;
	b=PEceMrOfv7fv9w+5RQJJKihKldtRCc72hCZ+AZEl+W5GSFv7toekkvESPGv/T2QMx9/cQy
	VPB2ezcQZOKfnSP6hDjPFv42uYUtHdfJ08r1HJxppBaQfN5oj3CilGHajkY4xOJZAqBmGF
	3787iDGfDBeMF9C0m/cMoV8TeOEYvLo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-IE3cpcCxNWSLXNZHNWqwrw-1; Wed,
 11 Sep 2024 20:55:48 -0400
X-MC-Unique: IE3cpcCxNWSLXNZHNWqwrw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F6001955DD3;
	Thu, 12 Sep 2024 00:55:46 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.32.36])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 90A4119560B1;
	Thu, 12 Sep 2024 00:55:41 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v4 0/3] rust: Add irq abstraction, SpinLockIrq
Date: Wed, 11 Sep 2024 20:55:31 -0400
Message-ID: <20240912005539.175428-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This adds a simple interface for disabling and enabling CPUs, along with
the ability to mark a function as expecting interrupts be disabled -
along with adding bindings for spin_lock_irqsave/spin_lock_irqrestore().

Current example usecase (very much WIP driver) in rvkms:

https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-example-08012024

specifically drivers/gpu/drm/rvkms/crtc.rs

Lyude Paul (3):
  rust: Introduce irq module
  rust: sync: Introduce lock::Backend::Context
  rust: sync: Add SpinLockIrq

 rust/helpers.c                    |  23 +++++++
 rust/kernel/irq.rs                |  90 +++++++++++++++++++++++++
 rust/kernel/lib.rs                |   1 +
 rust/kernel/sync.rs               |   2 +-
 rust/kernel/sync/lock.rs          |  17 ++++-
 rust/kernel/sync/lock/mutex.rs    |   1 +
 rust/kernel/sync/lock/spinlock.rs | 105 ++++++++++++++++++++++++++++++
 7 files changed, 236 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/irq.rs


base-commit: 8d8d276ba2fb5f9ac4984f5c10ae60858090babc
-- 
2.46.0


