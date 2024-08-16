Return-Path: <linux-kernel+bounces-290281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801BC9551B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CAD1C21BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EED1C5784;
	Fri, 16 Aug 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=woltmann.art header.i=@woltmann.art header.b="bvUlWJAG"
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA6E1C3F2F;
	Fri, 16 Aug 2024 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723838641; cv=none; b=nmipzsrYVZ00Ivac4h9o3L49B73jFNxod0LFezYGIeKmOZDfdstfYci7zSJ9VHfGnAj9LrLWwDbGHW1+kF+AID+E5crdUU5q54JU1n8JyAiyr+NHjqd3AVvSGYGcqK9/a1YFeftqPrwTmcZBgm+iUJxqHXLSloZ3S8fMII9+h7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723838641; c=relaxed/simple;
	bh=EfY6RyzPijR+8o0uiBmOE9Km3u7n4FAWqGLHE1nmejU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=covnUdqiE3ao2nOgm1WO/8+JChnDOrsTx0WTgY7X6gSbsWJNVYKCvy9D5pVSrSZLS1wQHd25xaQbtVlXJCWIJuC6uDhmFLeZw7ydCEm+NkYkpVG/74Haq1SmxIT0K5MbHdoKEYxmA+JYMLf6gN7OJDghi71kLoxQRqpvk7EeyZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=woltmann.art; spf=fail smtp.mailfrom=woltmann.art; dkim=pass (2048-bit key) header.d=woltmann.art header.i=@woltmann.art header.b=bvUlWJAG; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=woltmann.art
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=woltmann.art
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4WltGx6yLhz9wHW;
	Fri, 16 Aug 2024 22:03:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woltmann.art;
	s=MBO0001; t=1723838634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AyxiDhwXGVsv4189wxQK+GGVD/RgUw6fevyZy61wors=;
	b=bvUlWJAGI28MaTEumJg4BxxqZAgk3Z4iXbQonAUCV67RoAVk/3PVFGnPfcZ3BXYcU3BYU6
	i96Su/nSC1g44wOOhKnjQa349oK52J0IkLY8pf84kFft9yfiFo7a9e0v57QrGeRXKL8UnO
	U9dJvEujLa3DSYIXhCTlIfvoNyj+LiJMbRUWNAEeNioUCoqxCsR+beiOlftz+LOqpz97AY
	HOyZR8jnffCp/gQbIwPlc6oEgifOieeYXkB94VclLe4zZo3CQqLEH/l5fn1Kf6VcGMsCYm
	nF57AHHxGXTVapAJW1bjfziqv2E9mts1aSQY5qr/LD1OQ6PFUTkLi1M9MNMHwQ==
From: Vincent Woltmann <vincent@woltmann.art>
To: rust-for-linux@vger.kernel.org
Cc: Vincent Woltmann <vincent@woltmann.art>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Wei Liu <wei.liu@kernel.org>,
	Yuki Okushi <jtitor@2k36.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] rust: Remove erronous blockquote in coding guidelines
Date: Fri, 16 Aug 2024 20:01:42 +0000
Message-ID: <20240816200339.2495875-1-vincent@woltmann.art>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An unordered list in coding-guidelines.rst was indented, producing
a blockquote around it and making it look more indented than expected.
Remove the indentation to only output an unordered list.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://github.com/Rust-for-Linux/linux/issues/1063
Fixes: d07479b211b7 ("docs: add Rust documentation")
Signed-off-by: Vincent Woltmann <vincent@woltmann.art>
---

Changes since v1:
 - Readded the last paragraph to the list, which was removed because I
   deleted too much indentation in v1

 Documentation/rust/coding-guidelines.rst | 38 ++++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rust/coding-guidelines.rst
index 05542840b16c..329b070a1d47 100644
--- a/Documentation/rust/coding-guidelines.rst
+++ b/Documentation/rust/coding-guidelines.rst
@@ -145,32 +145,32 @@ This is how a well-documented Rust function may look like:
 This example showcases a few ``rustdoc`` features and some conventions followed
 in the kernel:
 
-  - The first paragraph must be a single sentence briefly describing what
-    the documented item does. Further explanations must go in extra paragraphs.
+- The first paragraph must be a single sentence briefly describing what
+  the documented item does. Further explanations must go in extra paragraphs.
 
-  - Unsafe functions must document their safety preconditions under
-    a ``# Safety`` section.
+- Unsafe functions must document their safety preconditions under
+  a ``# Safety`` section.
 
-  - While not shown here, if a function may panic, the conditions under which
-    that happens must be described under a ``# Panics`` section.
+- While not shown here, if a function may panic, the conditions under which
+  that happens must be described under a ``# Panics`` section.
 
-    Please note that panicking should be very rare and used only with a good
-    reason. In almost all cases, a fallible approach should be used, typically
-    returning a ``Result``.
+  Please note that panicking should be very rare and used only with a good
+  reason. In almost all cases, a fallible approach should be used, typically
+  returning a ``Result``.
 
-  - If providing examples of usage would help readers, they must be written in
-    a section called ``# Examples``.
+- If providing examples of usage would help readers, they must be written in
+  a section called ``# Examples``.
 
-  - Rust items (functions, types, constants...) must be linked appropriately
-    (``rustdoc`` will create a link automatically).
+- Rust items (functions, types, constants...) must be linked appropriately
+  (``rustdoc`` will create a link automatically).
 
-  - Any ``unsafe`` block must be preceded by a ``// SAFETY:`` comment
-    describing why the code inside is sound.
+- Any ``unsafe`` block must be preceded by a ``// SAFETY:`` comment
+  describing why the code inside is sound.
 
-    While sometimes the reason might look trivial and therefore unneeded,
-    writing these comments is not just a good way of documenting what has been
-    taken into account, but most importantly, it provides a way to know that
-    there are no *extra* implicit constraints.
+  While sometimes the reason might look trivial and therefore unneeded,
+  writing these comments is not just a good way of documenting what has been
+  taken into account, but most importantly, it provides a way to know that
+  there are no *extra* implicit constraints.
 
 To learn more about how to write documentation for Rust and extra features,
 please take a look at the ``rustdoc`` book at:
-- 
2.41.0


