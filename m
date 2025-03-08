Return-Path: <linux-kernel+bounces-552639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C795A57C27
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74A51892B5A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16271E832B;
	Sat,  8 Mar 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="DamSJZ8a"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347181E5721
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452572; cv=none; b=kNN+sJ/h8UR6jDAV823hHd70lIW3jg43EtVgCZsX8X5go1N3tMEVzp1ffl3FZK6v9WXvrE6MbUttDDaQU3VHtUG/QYsr/3We81rxBY9C3bPM4fLqmA7H+7rkIYWXLV712U5sPfOPYJ5n1IXoxcclGUZWi6W6NIw/j/wc2wu1ow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452572; c=relaxed/simple;
	bh=NMBRHjyiUf4fqRzIW1+eJkuyhDfwTkf1Nmf3eaTS+us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=J2QGQ02O44TwchZGS4ALRC1NlWhyv0yxbi1CAvlL+1gZbuL4A4otCWpFi3HNLsPI00DelxVJcrOrZOjEVD0Uwpj0NVXtG8UTW3z9BPKsYoUmj4uheJzzpHdL1jULCdeUGWUDGEGdNkYtRwwT/dnhotlsBR3/Wq0YUBgK1kiBXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=DamSJZ8a; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 3330E240027
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 17:49:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1741452568; bh=NMBRHjyiUf4fqRzIW1+eJkuyhDfwTkf1Nmf3eaTS+us=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=DamSJZ8ahaaBF8tvy/5dEWM6mGA3QgyRPRMdeOiA7aqkA6ZJH38zj9L0zNsIq8G8q
	 Ood1pT80gs6ofSnbZxgTWyDFl/kK8+vVCTq9v1XKu/Gga9aj/vDX6JWHDHkF77M8X3
	 90nQ8PH0cGKN+TdcC8ILZ4cN79nOP0SfDTySit5J4YV8R1BppfJoTC22FDbWUfkCl5
	 p+3voL1JNl1AgOrx4MMnPBZ0XnjmQuwNYGkISfux2GpmTNQAu6ivQBaxdsbbw1mj/h
	 F7tqx4/o5JacWqREONeUjxqSds/c1kTUtPB8lXkK0i+L0A7yspVhKp8OwCDtr7RV+F
	 qWwicU3iNysZg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Z98JQ3Hy1z9rxF;
	Sat,  8 Mar 2025 17:49:26 +0100 (CET)
From: Panagiotis Foliadis <pfoliadis@posteo.net>
Date: Sat, 08 Mar 2025 16:49:05 +0000
Subject: [PATCH] rust: task: fix `SAFETY` comment for Task::wake_up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-comment-fix-v1-1-4bba709fd36d@posteo.net>
X-B4-Tracking: v=1; b=H4sIAAB1zGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwML3eT83NzUvBLdtMwKXSPTFAPLtDTD5OQkUyWgjoKiVKAw2LTo2Np
 aAPQ0Tl1dAAAA
X-Change-ID: 20250308-comment-fix-25d09ff1ccb5
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Christian Brauner <brauner@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Panagiotis Foliadis <pfoliadis@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741452566; l=1255;
 i=pfoliadis@posteo.net; s=20250308; h=from:subject:message-id;
 bh=NMBRHjyiUf4fqRzIW1+eJkuyhDfwTkf1Nmf3eaTS+us=;
 b=8fZQbC42Yqv8+b3HLQN4MZtx/9vCG23pX4ZSUxtpYvpEeGzS1VKZGJU3oKflpnqBElgyKyhvu
 P9mAMgkQzfOD75kqSls1A5wWWtPalhR904r51rADEEdL87PrBb9TBHi
X-Developer-Key: i=pfoliadis@posteo.net; a=ed25519;
 pk=/8ch2dv3mwtZ5ygYwiG7ldc/132K6XmLkAZDmIe0aQw=

The `SAFETY` comment inside the `wake_up` function references
erroneously the `signal_pending` function instead of the
`wake_up_process` which is actually called. Fix the comment
to reference the correct function.

Fixes: fe95f58320e6 ("rust: task: adjust safety comments in Task methods")
Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>
---
 rust/kernel/task.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 07bc22a7645c0c7d792a0a163dd55b8ff0fe5f92..38da555a2bdbb71d698c671ad1a7a337e50c6600 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -320,7 +320,7 @@ pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
 
     /// Wakes up the task.
     pub fn wake_up(&self) {
-        // SAFETY: It's always safe to call `signal_pending` on a valid task, even if the task
+        // SAFETY: It's always safe to call `wake_up_process` on a valid task, even if the task
         // running.
         unsafe { bindings::wake_up_process(self.as_ptr()) };
     }

---
base-commit: 2a520073e74fbb956b5564818fc5529dcc7e9f0e
change-id: 20250308-comment-fix-25d09ff1ccb5

Best regards,
-- 
Panagiotis Foliadis <pfoliadis@posteo.net>


