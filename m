Return-Path: <linux-kernel+bounces-422596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887059D9BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FCC7B2A6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223881DA2E0;
	Tue, 26 Nov 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDzC8hvR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE81D8E18;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639282; cv=none; b=meEG58ZFmk1AbMmDhP8RhEAQB+8dQO9KYh6HNjDInAM1KZej+6lBeT39+UwKCsOJ31zcbIE2p1+H9pIiROqn84Gger1Iinnm0Lgo8xQIufRmyK2S2JTUqX+y14UlfeA24RjvAfP1jZLelbxMobldhcfleuhyXkJovpPMqSZmeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639282; c=relaxed/simple;
	bh=TXCvQS2ahX/hhNk47wS2krc25xjMQW0mokjRm+QW2hE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r5voOUwwYfNZd7p+ng5qisWDI/o/IuHA+79WMoYoUxZFxzaVcYrgXJd3gk8NANsb4cVT9Y9xzuxvpXOTr2/lnozzCXKY5oydoRr6X7Y/EOCcFp0DVsuLep0ZDhc9Ft2TgD8kwxGHmSGUjBLynhv/uvZxtoLo8LR4y2oYnI3N3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDzC8hvR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10D6BC4CECF;
	Tue, 26 Nov 2024 16:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732639282;
	bh=TXCvQS2ahX/hhNk47wS2krc25xjMQW0mokjRm+QW2hE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uDzC8hvRaCswXNJPKmnrwFBJSt0G8mOFXwq6T/7m/Zqn2TbnnKb3m3dU1JFejMBoE
	 cTyt5vO7PJbb7JF3BrIAPu8FcyQyw4Lj37m4ol8y5OwXGiheJcwjgxl2Nur5pdq/5m
	 Z2Gl4xM5lNWwwkVJBco6NlmDQxbGrcy+Yz2z0RA5W6w6ViCpazpSJ/cXtqB+LVKfwW
	 o97CPCu/KoFPwZj/HJRhOGUjTQW6J0Jwd/W/SVChi6O7vO16buJDJ172Qw44uVDl4H
	 gTMzkaTXVGyo9eBrfZn/PFPPyDXTZ0xu9G4AiwohHhVhV1zb+iaoMLvpFkOLfrmTse
	 d/Bp55+xkRjEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81A1D65521;
	Tue, 26 Nov 2024 16:41:21 +0000 (UTC)
From: Jens Korinth via B4 Relay <devnull+jens.korinth.tuta.io@kernel.org>
Subject: [PATCH v4 0/3] rust: Add pr_*_once macros
Date: Tue, 26 Nov 2024 17:40:56 +0100
Message-Id: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABj6RWcC/3WOy27CMBBFfwV5jSM/Ege64j+qCjlmTKbCGTQ2U
 SuUf6/DBiRU3dVZnKN7FxkYIYuPzV0wzJiRpgrtdiPC6KczSDxVFkaZVmvVyysfaQpwTD4wZel
 auwMXu2FvrKjSlSHizyP4+VU5MiVZRgb/mrF1nVVN7/rOSS3j7RuLbwolmojxcE4eL02gtCZHz
 IX493FxNmv43zezkUqegrK6j9EqDYdyq10ksX6Z7au8f5Ntld0Ag2lBBR92T3lZlj+dj1SJKgE
 AAA==
X-Change-ID: 20241107-pr_once_macros-6438e6f5b923
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732639280; l=2042;
 i=jens.korinth@tuta.io; s=20241107; h=from:subject:message-id;
 bh=TXCvQS2ahX/hhNk47wS2krc25xjMQW0mokjRm+QW2hE=;
 b=+0qPh84yAX2uxWGdAqymsJMknJSFQEqTR+ty5Cxq5muulovNz9qxkB+KHN6/KaW75+hkRrciO
 APeLtr9QfIqD4ow8u7CW0FBMWgU2BhifyaydUz/ZMdCRAmZ4IpDOHR4
X-Developer-Key: i=jens.korinth@tuta.io; a=ed25519;
 pk=bG0q4Zyj3o4d/r326zKL7ym+/tXzyykcjh+U0M13iyc=
X-Endpoint-Received: by B4 Relay for jens.korinth@tuta.io/20241107 with
 auth_id=270
X-Original-From: Jens Korinth <jens.korinth@tuta.io>
Reply-To: jens.korinth@tuta.io

Add Rust version of pr_[emerg|alert|crit|err|warn|notic|info]_once
functions, which print a message only once.

Introduces a `OnceLite` abstraction similar to Rust's
[`std::sync::Once`](https://doc.rust-lang.org/std/sync/struct.Once.html)
but using the non-blocking mechanism from the kernel's `DO_ONCE_LITE`
macro, which is used to define the `do_once_lite` Rust macro.

First use case are an implementation of `pr_*_once` message macros to
print a message only once.

v4:
- Move `do_once_lite` macro implementation to `OnceLite` abstraction
- Use `OnceLite` in `do_once_lite`
- More documentation, examples
v3: https://lore.kernel.org/rust-for-linux/20241109-pr_once_macros-v3-0-6beb24e0cac8@tuta.io/
- Fix rustdoc error, formatting issues
- Fix missing Signed-off-by
v2: https://lore.kernel.org/r/20241107-pr_once_macros-v2-0-dc0317ff301e@tuta.io
- Split patch into do_once_lite part and pr_*_once macros
- Add macro rule for call without condition => renamed to do_once_lite
- Used condition-less call in pr_*_once macros
- Added examples
- Removed TODO in kernel/error.rs using pr_warn_once
v1: https://lore.kernel.org/rust-for-linux/20241106.083113.356536037967804464.fujita.tomonori@gmail.com/

Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Jens Korinth <jens.korinth@tuta.io>
---
FUJITA Tomonori (1):
      rust: print: Add pr_*_once macros

Jens Korinth (2):
      rust: Add `OnceLite` for executing code once
      rust: error: Replace pr_warn by pr_warn_once

 rust/kernel/error.rs     |   3 +-
 rust/kernel/lib.rs       |   1 +
 rust/kernel/once_lite.rs | 127 +++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/print.rs     | 126 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 255 insertions(+), 2 deletions(-)
---
base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
change-id: 20241107-pr_once_macros-6438e6f5b923

Best regards,
-- 
Jens Korinth <jens.korinth@tuta.io>



