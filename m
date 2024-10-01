Return-Path: <linux-kernel+bounces-346206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 445F698C11D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AE71F229F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219621CC158;
	Tue,  1 Oct 2024 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRxFv1vq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800781CBEA9;
	Tue,  1 Oct 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794973; cv=none; b=Y2ml5nw5d3BR6r+I4CJ4Oj/2NSmlAXswHxrLYjwLBQTaD5zYxSmaq5M/MSazeMWMTq2DyISa+Odbx67L+oboG9YCWyuojNkxyPkahA7ToMXzaOSst7XsOOmdVoWl0FHs+vOdE5+TbpHrirW4O4eJFQ7sw+RQnEzv7CkHvpAIrt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794973; c=relaxed/simple;
	bh=5WhXHbdkvCvx2BiDbC2YGf2YH6m+QGC4hgOdP8LRL/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2fAx+UThKFCEyZ5djsoTQouSVOLisllzpYbHb+j35vYKm1R82Vgekw997MlTtEvC8Zb/YxYmN1o/G3EpCr17E4OveaGmwgVmVDgHNPSKrcM0VWEiFQODaNH83DfCBYZZKiX/Glo2IcZYi8wzvtYZoWEIqfxSH4enspoj+TO2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRxFv1vq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31880C4CEC7;
	Tue,  1 Oct 2024 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794973;
	bh=5WhXHbdkvCvx2BiDbC2YGf2YH6m+QGC4hgOdP8LRL/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRxFv1vqGJmKwc0Q+OIGBKJ0n6aReQHI1G1uiAx7R6CXZwLUZPy2wVbtreTtE9euP
	 s2dT/+RMLyEDr5f1mMvCLIXqOD5fTE9yPmQ3P+YyEvgU9LqT6BWom5bOCJuJVmkqaX
	 deV3L9KHhHe2mCYzEJm78GcPT4+SA3tpuhSA4KkpNoVGTZDBm5oyHHBx0HeRZqxzHH
	 w2SQ20rvlgK+0zjc/KLTAT+j87VPRmflRjp/DBZOvoiK9Ga7tBWLfBfjNYdfbOdezn
	 HUI+FcZp70AWKd2rMAgloTnBYbFwNjA8SEywnUslSnmpMpb/B5ha2lDkirXXmrk6jZ
	 0B9TDthI3f/Ww==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v8 29/29] MAINTAINERS: add entry for the Rust `alloc` module
Date: Tue,  1 Oct 2024 17:00:04 +0200
Message-ID: <20241001150008.183102-30-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add maintainers entry for the Rust `alloc` module.

Currently, this includes the `Allocator` API itself, `Allocator`
implementations, such as `Kmalloc` or `Vmalloc`, as well as the kernel's
implementation of the primary memory allocation data structures, `Box`
and `Vec`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..3091ea621b5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20225,6 +20225,13 @@ F:	scripts/*rust*
 F:	tools/testing/selftests/rust/
 K:	\b(?i:rust)\b
 
+RUST [ALLOC]
+M:	Danilo Krummrich <dakr@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/alloc.rs
+F:	rust/kernel/alloc/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 M:	Marc Dionne <marc.dionne@auristor.com>
-- 
2.46.1


