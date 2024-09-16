Return-Path: <linux-kernel+bounces-331140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC6897A910
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D16B23CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDF15CD6E;
	Mon, 16 Sep 2024 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIOkIkEt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77B6146A68
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726524516; cv=none; b=ntlRDGrczzBUx3ILtqQrcv4Z4auxvV455P2ByMnVDDhdfx91ceNX/lxPt+ec4Sy9TOf+9Zr7iFsbVWhI85+e15T0oa6it17FrYN+2RMg1WCkUYIBWpL4Yj5IzgnhKhlDZsB4TDLGJaaqq1DB1ClGcXx4qpw0PGmQfWupgZHfKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726524516; c=relaxed/simple;
	bh=jIk6JDhGrzbfso5hiK1W/HYLxyAcArm2o+kPc9FaZxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X28f+gU5W6hgOxRY/VkqJvx1pRBgaO1W2wHfNCgaTMH4eJsyGl32uN7V72qvgAsBZ4KDYx8uUf4HFtJWbbntiKCc4EOeo1BA1K2azi4n0wfnQf0LsUMyVhCx3UOxe7glDnm2KLuI5msNtTy1O27/Sw55GgKxnMqTNAv4pt3Z/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIOkIkEt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726524513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xKD5TpxRq2Xi5Y/fuxovAwJrOONXHn7sCTllfhO0AlE=;
	b=GIOkIkEt9AOEHYYGHDAYQJLWg7ZExR7hz6/eLqCEqq7YSe5HoyZsP+0K5UZgGYMmQKhsua
	o4q5KdpydFmzH6guIC8mSG32/gKG/BrR+oy9wZTRwb/+UgLCILSWjAt8NpfGGxKmIrPiGS
	Cwj7U2v8h8uVVF7kIDj74B1fQBEw2hY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-Z16nLSUQNvSehYzcsATVzQ-1; Mon,
 16 Sep 2024 18:08:30 -0400
X-MC-Unique: Z16nLSUQNvSehYzcsATVzQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F6421955F41;
	Mon, 16 Sep 2024 22:08:28 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.33.131])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2924C19560AA;
	Mon, 16 Sep 2024 22:08:22 +0000 (UTC)
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
Subject: [PATCH 0/1] rust: sync: Add Lock::from_raw for ZST data types
Date: Mon, 16 Sep 2024 18:05:45 -0400
Message-ID: <20240916220818.567277-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This patch just adds a ::from_raw method to the kernel's Lock type,
which can be used for locks where the data type is a ZST.

The current example usecase for this is rvkms, specifically
rust/kernel/drm/device.rs (kernel::drm::device::Device::event_lock())

https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-example-09162024

Lyude Paul (1):
  rust: sync: Add Lock::from_raw() for ZST data types

 rust/kernel/sync/lock.rs | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)


base-commit: a2f11547052001bd448ccec81dd1e68409078fbb
-- 
2.46.0


