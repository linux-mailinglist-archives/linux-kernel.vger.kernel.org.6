Return-Path: <linux-kernel+bounces-325733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FCC975D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935CE1C21FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6CC1C1AAD;
	Wed, 11 Sep 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR2myOkh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBE1BC074;
	Wed, 11 Sep 2024 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095439; cv=none; b=O5LbY1QrkMk2ZnXXJJ8m0iyKHBMwSG5+Uo+VspCPnxxQaypn0XR+6v6eMGGZ4YgZ+M+NQFzegBvpkYIqoeQALg1miMOwi296uO+tk+af3x2hStS7vXG7G6xqNrZd3EVI44t418a5QOhW14NQ0Sw7xGa29XiPcCMQE/yt/R7Dnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095439; c=relaxed/simple;
	bh=MA63j2l96SFmNAW2ZFKeN7OYc4kzJPq4eXgb27o0nko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgZOyKtz9k3duU6JubfvORWzvxYUhxMVzeSwqP5dexJJERsO2nM+AtPDysDcNFDGioOpI+X2tW3R5jL4bo7rkwlW8ggarw6d9IEA0ZRI9rvjDoQXnKfMN7fgFZyjg6nq7cLTtDUJwnLqH5dFRZHGa+pdQc58NhRdcu8m/nGSnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR2myOkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6657DC4CECD;
	Wed, 11 Sep 2024 22:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095439;
	bh=MA63j2l96SFmNAW2ZFKeN7OYc4kzJPq4eXgb27o0nko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NR2myOkh+9gGnmPS2kTc/yg2gApS991zzrQnL13Z3QDyUHo8klpn52EysPtMFhadg
	 rBBDarK2Lo3HtvcLZmyafp6cQ/NooD0a5Mr+BbG4ZDKrda9xzsWWbV5qJ8D+Rkk51x
	 qmYHJcJl8x8siUwA9t2m9zPFZ0mXVEugSCkgMa+VUXsHZr+5nybS6F6pStN0zjZCMi
	 fdyOg34SRfXUluMcm88odzsoq/DqrnOJ6Am3VF8g1/mcHzcvDXOOKyQ8oUHdexq4RP
	 /wfna5X5/a7/6l/Dl6GecSb3Si8FLLzmMJzs96MWVGhq1LPrixpNmgFfXvKYxJzSVX
	 hRx64lF9uLVdQ==
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
Subject: [PATCH v7 26/26] MAINTAINERS: add entry for the Rust `alloc` module
Date: Thu, 12 Sep 2024 00:53:02 +0200
Message-ID: <20240911225449.152928-27-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911225449.152928-1-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
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
index 77b395476a80..f57e3b5bc410 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19929,6 +19929,13 @@ F:	scripts/*rust*
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
2.46.0


