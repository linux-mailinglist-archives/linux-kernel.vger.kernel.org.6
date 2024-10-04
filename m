Return-Path: <linux-kernel+bounces-350697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D62A8990821
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1194C1C21B82
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEF1DACAE;
	Fri,  4 Oct 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwEfrzFA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA261DACA5;
	Fri,  4 Oct 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056685; cv=none; b=lKc/mjyT2OEEmaI/SOALS8/Ninmc96GRoo3aFCIvggGIDARuQx7N9Kl3SWGbKDYA0NfyJxL0YDEUotIC1lDuFHL5Rytgc4hz52iRtDNrvdnhzYdTtTZYuETTHRLRc9DAJ/SOfr+UWYo03pjehb5F9VY9Ot47pseBIR96kL9jcyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056685; c=relaxed/simple;
	bh=LdzqPbgEKI128eCZYKb03oyNMyTA/dv0Gv7wqQmMX2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spyTb7K1aI3BWxPjqgxlFVete6rGcplGQclQedjLdrvylIcfyegk8FZTQj33b0x9lBeQT0uZC/CXhGSbY6c7DC0bAY9iyfFdPfshMd4jSac/mFVAI814ndTGGeqJ334FeK8edOHjzVshSF+F+b7JlxnC7ltv0s/OU/jublqV2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwEfrzFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC34AC4CEC6;
	Fri,  4 Oct 2024 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056684;
	bh=LdzqPbgEKI128eCZYKb03oyNMyTA/dv0Gv7wqQmMX2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwEfrzFAPdp4OWI26Vyob0+ciU7heTInmH5hXtmwaC+7O3Pvo6QP8pRMhkfZCUh7W
	 qmx00+qBV+Vk3YE6eIiTiigQRtr8Ur069zHII6bJEp3a8+jVrhgVnfTd9zPrxPkO6v
	 HoTXtL/Nv1k5wa5fUd7csJhRgcIUbaVIwm4yn93X8bVoBDlb0DgISPoJ1HaRDCUOhj
	 iW05DEBQo1hiA3F8fKTiHU0PnFbMTDK5XwV7RxHVY/oX0mEgu77q7Af+/t6NyoNW2W
	 wviRjO1xkrf0ZonCjFrg84ILr1fRTAoOjyyyUslrzz7UDVekl42NGaiT0eHD7EZj9q
	 SvMT1iEUYNPIQ==
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
Subject: [PATCH v9 29/29] MAINTAINERS: add entry for the Rust `alloc` module
Date: Fri,  4 Oct 2024 17:41:33 +0200
Message-ID: <20241004154149.93856-30-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
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
index 67f9f2b8bb50..aa3b124e4989 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20226,6 +20226,13 @@ F:	scripts/*rust*
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


