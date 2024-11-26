Return-Path: <linux-kernel+bounces-422598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92119D9BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEED286AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB151DA612;
	Tue, 26 Nov 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVGTn06X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF119F410;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639282; cv=none; b=DqXyhtJKltTPJRnaqSrE7iyN99qwD/aIggJarCehsU+Ac6Duym5RBUnIdUCXuhd8i8uzyXqmpvl4dcAZWLhJ0hQB9OVFOxvIxIfLbtEBnlPMrE1ZutWT35qfBeAANyXjYulOuT4ELUXu0eLh/yWhxQJ/n+PNdD9FHzI/HQaoDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639282; c=relaxed/simple;
	bh=S5PgWcf5k5x487bSWpv1A5GU8RveioFsB4grSMq9X6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXrQio22hfBDDNJOMSjVdrQt+S5B0mT3Mjn2bpyT5fDO+XeZ2kheEfLi/62vBTGWQVUntJNuhI3jGvpawMS/cZfozDKBZWEdrvQ5tva374HTu8WZvn7TUU3NGhdip5L3h/rf0fU5mLdU76E8PiwHJpriMqLkvPt1qBJzEDW8PgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVGTn06X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37560C4CED8;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732639282;
	bh=S5PgWcf5k5x487bSWpv1A5GU8RveioFsB4grSMq9X6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tVGTn06XAgs2xNL+/yLrm/4pLscBnPur5fVsTMkORf/6uWhW4kzWGp9HoAzZB1N4x
	 VT/YavZ+yyM5lRXLCeDlknmEEaeuipf8oN9hZRl3S4lcSfOEj6CXs0z1rIQYNQ6W+H
	 cDcam5b6qL2sLFw5p9VRjhtt4r6bwwyJCX0rV1PCw945PoG6tOp+j2ZFBTWUY72NDy
	 1igagVv0UqhaKpfFPdYlQBA6CWA2Irbce53SXa2NwzdVYhkpsFJkPPHpfm1dW3uLtG
	 +MfM+z2g8xnZwLzUelxM5h/lZxYWF6m+1A5MvRzLTjUjy8fAB2/Q9B4V8DJmPDiyTS
	 3kH1BLrwgaGjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E71D65522;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
From: Jens Korinth via B4 Relay <devnull+jens.korinth.tuta.io@kernel.org>
Date: Tue, 26 Nov 2024 17:40:59 +0100
Subject: [PATCH v4 3/3] rust: error: Replace pr_warn by pr_warn_once
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pr_once_macros-v4-3-410b8ca9643e@tuta.io>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
In-Reply-To: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
 Jens Korinth <jens.korinth@tuta.io>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732639280; l=872;
 i=jens.korinth@tuta.io; s=20241107; h=from:subject:message-id;
 bh=Ibn3wEyptEN6rItZsMxTwWDZUjDEMOkNcZSR4EQjX4M=;
 b=MnERlW0iiP5yuqZAjJpBuHzt97f3tAqsZl9SVLCPvMjRPTJAHSg/fNl90GinoaOYCJ1wtfdys
 j90U8UUchUDCAGgCqNYJEStmvh62yiv5Zit+gDB4ftZJURYincQqO8c
X-Developer-Key: i=jens.korinth@tuta.io; a=ed25519;
 pk=bG0q4Zyj3o4d/r326zKL7ym+/tXzyykcjh+U0M13iyc=
X-Endpoint-Received: by B4 Relay for jens.korinth@tuta.io/20241107 with
 auth_id=270
X-Original-From: Jens Korinth <jens.korinth@tuta.io>
Reply-To: jens.korinth@tuta.io

From: Jens Korinth <jens.korinth@tuta.io>

Use new pr_warn_once macro to resolve TODO in error.rs.

Signed-off-by: Jens Korinth <jens.korinth@tuta.io>
---
 rust/kernel/error.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 52c5024324474fc1306047f3fd7516f0023d0313..f6813dace1128b7ef91f64e79cd83bb64995bf97 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -102,8 +102,7 @@ impl Error {
     /// be returned in such a case.
     pub fn from_errno(errno: crate::ffi::c_int) -> Error {
         if errno < -(bindings::MAX_ERRNO as i32) || errno >= 0 {
-            // TODO: Make it a `WARN_ONCE` once available.
-            crate::pr_warn!(
+            crate::pr_warn_once!(
                 "attempted to create `Error` with out of range `errno`: {}",
                 errno
             );

-- 
2.47.0



