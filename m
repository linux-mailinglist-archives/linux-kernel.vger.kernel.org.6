Return-Path: <linux-kernel+bounces-289408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438319545E0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4FD286D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0115145A0A;
	Fri, 16 Aug 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=woltmann.art header.i=@woltmann.art header.b="yP46K5ci"
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEAA144D1E;
	Fri, 16 Aug 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800880; cv=none; b=Fhrl/bZi2xCIJ+90cwYCxq58w0pc0WrotjOeZHSIOfNbuwkzpsCZSsixR7Q9nsCGEShzDlEfR6XKpyQYIJNKJrNYp/IuFFT0VC4sYWVtv301Rd5KcRpub6qMv1/5wTm6bYLyHsu/W4I/ZikgwBtj+TxySAfU47B2Riykc2fcgxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800880; c=relaxed/simple;
	bh=7iDkFYG5RkMPP56mIRilbSqwBpcRWatHTDBWDVNp+u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYZeh57QrqMd134JgRxzaWvDN1EzaJMmmK+g7WeSDeD392fxXlDUw/jpOC9hdFX42g14wcXrpbWH2kCpMV/giztkdwONauWSmuLE3FoK1GdRO6o0DsloU0bOKBC0q10yLarHr+CsNOsuGTY2Ubd5jH+qX78+rFz1rhN/zacq6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=woltmann.art; spf=fail smtp.mailfrom=woltmann.art; dkim=pass (2048-bit key) header.d=woltmann.art header.i=@woltmann.art header.b=yP46K5ci; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=woltmann.art
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=woltmann.art
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4Wlc7F1J23z9vrR;
	Fri, 16 Aug 2024 11:26:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woltmann.art;
	s=MBO0001; t=1723800377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0TnN4/Tb5Dkm1VaiSSoGRXQN59kCugLF+H3VFSUu7DU=;
	b=yP46K5cidUWcBOBCVtCR31zzzFSwnr48TtDBV7xK0UIWAwLcOULYjCdQ8cKN1+t56S97QA
	VdLw93THr7uTunTubwRJjIR6aDnrKJHplJ9RNEH4tUEgRS1AN1W3ffbFhliGl1EcLUyDKZ
	ESuOLctW0j/7VIaMBQG9ShRhYYsaJ0Y6wDHsBQkokAED1M0OkpwmRTg6IM432rMPCBVKTC
	HFVlXaWMGamx4RXr6PZ3Sd5BRVOGus65wPQY/U+M1yx/WnUmFzd1ENNhqo3muT6jG8Vh0A
	RyN6pGQwRiIc+nQ2Td6f7CaE686d5ZUdSGXlXW+Emb9RsyORY2dO3O568CHMIg==
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
	Julian Merkle <me@jvmerkle.de>,
	Wei Liu <wei.liu@kernel.org>,
	Sven Van Asbroeck <thesven73@gmail.com>,
	Adam Bratschi-Kaye <ark.email@gmail.com>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rust: Remove erronous blockquote in coding guidelines
Date: Fri, 16 Aug 2024 09:25:31 +0000
Message-ID: <20240816092536.2444105-1-vincent@woltmann.art>
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
 Documentation/rust/coding-guidelines.rst | 38 ++++++++++++------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rust/coding-guidelines.rst
index 05542840b16c..da87c65600fd 100644
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
+While sometimes the reason might look trivial and therefore unneeded,
+writing these comments is not just a good way of documenting what has been
+taken into account, but most importantly, it provides a way to know that
+there are no *extra* implicit constraints.
 
 To learn more about how to write documentation for Rust and extra features,
 please take a look at the ``rustdoc`` book at:
-- 
2.41.0


