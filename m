Return-Path: <linux-kernel+bounces-416368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F73C9D43E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D187E1F222BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5921BC097;
	Wed, 20 Nov 2024 22:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3mmaH+9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9815531A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141676; cv=none; b=Wv9m4WY8UUPo2LUH6GlKAcb8D0d2tKwXXt6WRGuXehKRWlinkhKjlbtE0GAFKS9NiCRVHfQ85OVC52HktQvF5fr5XhatE3DZrPXyHDhiBaeULulmm1vm6X5gRD1vGPTvcw0Xne16/hijWRNiVUkoEWHIqdimahdryIcD+yn+yFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141676; c=relaxed/simple;
	bh=No3jVm3u6iyFpb+a4hL3QfWBxHqnazENh1ZSee1n1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAfhBRveN0794dejcV98WeUVetJnRy5o/Mwt2A3SHNjS7BEM0uljNZ3oH5xfirSYLX8x0Y58bkGj7Ar4alMJfQTBqhP22I6dOxvq0YfA+oEvuGiIU23WE3Qaj1KKNHExNBATxrm2dXPcCtyRtQweQlkUSaoL2PlaVbKa74E7J38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3mmaH+9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732141674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AVhCvS8SDSeDPdSF6lihwFqqhnBx9WhgdEqDOLX4ANI=;
	b=e3mmaH+9KPthSCrVTG0o9/3LZWzdK6bWwjx9LA5rT09ArkV4g+iXED/KYnXRWSnJe5/vvY
	/BCgE5BRy7XtiKd4qYenSRfDHNq6kW8zBXLlol7jRfaenqZm4DtL5JKJwOnLH+QpiRy0yI
	fFx20NIg6x+LQ039zFVA4ZtHD8l5VRQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-veWi5WvEMg6JUESbfve1xg-1; Wed,
 20 Nov 2024 17:27:50 -0500
X-MC-Unique: veWi5WvEMg6JUESbfve1xg-1
X-Mimecast-MFC-AGG-ID: veWi5WvEMg6JUESbfve1xg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 12E3A1956064;
	Wed, 20 Nov 2024 22:27:49 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E8CD1956086;
	Wed, 20 Nov 2024 22:27:46 +0000 (UTC)
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
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH 0/2] rust: sync: Add Guard related type-aliases
Date: Wed, 20 Nov 2024 17:26:27 -0500
Message-ID: <20241120222742.2490495-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

This is something I originally meant to do when adding Lock::from_raw
and exposing Guard::new - introduce type aliases for the various types
of Guard that we can run into.

Lyude Paul (2):
  rust: sync: Add MutexGuard type alias
  rust: sync: Add SpinLockGuard type alias

 rust/kernel/sync.rs               | 4 ++--
 rust/kernel/sync/lock/mutex.rs    | 8 ++++++++
 rust/kernel/sync/lock/spinlock.rs | 8 ++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)


base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
prerequisite-patch-id: 8c65a39abe47832d0c98c9c266b4b9348fb3526a
prerequisite-patch-id: 211faf8533feec77907b0a1b9b2f788e72c5ac58
-- 
2.47.0


