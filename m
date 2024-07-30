Return-Path: <linux-kernel+bounces-267180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12960940DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E76282004
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776E1957F0;
	Tue, 30 Jul 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4d+S3x7"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CC194C92
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332445; cv=none; b=WRufULeF+b0NPH/fzBpxTmaFFEwuzH/surTYBXRfoifZain1fhxv/ojl1DyXvD9qYYxvTfkC+PR/XezdcWpCLNbW6HVNHJ1Lyo1IxQltLkM4r6CbZjuz/aRJo6hSGVpnmZGqhBuZec0sxu4bu6Z8XzCZ7r3SJPdh9mYlJO0C+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332445; c=relaxed/simple;
	bh=z6AMQsvLXODLg+pFFWql7FTeV2LVKue/By3e3mHikHE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cSlvGsH1poRKoS8hLAHNI2nGi63dzm96zN62ihWvF6YrAxYRQDipSOa4bRs1WqpTqyeBIH9LbGZOQmzHwraIBeYvdRzg/ykglu09ATHgAwYzS725tMurI0DFUCwitUpUdOJ9EoY4BgKnTLnVy9VEqMwkkai3Vl8Gvi8vrSXdb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4d+S3x7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b35859345so5560089276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722332443; x=1722937243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gS5NAG/xp+5gIQFFz9RUi98/oCWDc4GVmPVVB519uaQ=;
        b=Y4d+S3x7MrIhnRi7AlLb5cFkDkqNAHjmp6nb+ZMTnLvJyoLHvZlyk9UV83iDSNUbcs
         KJoIYSmvfU+EVM//jv/1lvueSmz7DJTvgRiIPXy14JQpKxDTtRJ3XEDcAaS1p2dycX19
         Lp6NzLU+yQOMPsfFJIJT7OVIjMomJuo3h2D8yydBQuhpwHyIOoSYGMvXLKXeWLqkF1Rg
         sSqc+xp/3TcU2m2UfCqxnTW7YLKfh8So/bSlQxLt5iZKJCkhKDHAktHyJWlvp2q3x0Vp
         xQkxM/LrUiaLFXjP2yItOZWFTXtaw47TxXDygQChZzCznn5yO98Tk+PVfrIXlmyQcZwK
         78PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332443; x=1722937243;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gS5NAG/xp+5gIQFFz9RUi98/oCWDc4GVmPVVB519uaQ=;
        b=XOFfNclAZDlICmSWwUYqxvhittbYKea5mPwlNwuSDWqFsaLOIYbBvNzofpBaGXZYBu
         2nhpdmudl//ZIaQQruzlwF+DHvWvXLnoA84HJOVptKsmtiRHrJLb4hu7K0H3HO1mWIpQ
         RI3yQyxvq2QQNx4hv/dk859di9+0aMSKm3NRV57pdgaB0+SuGQ4JcJ8dC39xCJzCaYjz
         uVyzqBkIcB/C8g69jb+5YKfyZbu8m16v9h9VRD4q1MjAOrjeR4fG5gX7691LAuJODHLM
         5jG3C4IxJG2zt6P1uezjT9ULyh6UzA+nk7rJq8ld7Esoub0MfqP5ppIojA2AzuPyD77z
         J48w==
X-Forwarded-Encrypted: i=1; AJvYcCUdiPiTT+PUgSD30VKnK+twxH2HJezf/8k2u7WRHD6oMnqpQQfNpXjqkkP1gsE9z+3FA5AaGePRCg0YGvlvdpHLAHwkt84xEfnj+o4V
X-Gm-Message-State: AOJu0YwthrtHio/A3G2sxCAam7STI/jFXs/tZURk22adyc24U5TU84Ce
	acquW2c8J5eLBgWVL9gq6uPgNcyp1daNSkDaJsCJl7w43+19WR02EtmBLbgMWxVJfa/TsvGHVXS
	Dl7KosYeHwR/cAg==
X-Google-Smtp-Source: AGHT+IG7qRLJEdvzuUk1cU0Hd/aciEvRihM2ezORcoZuOe/k9BC6vaOeX8Kq6q9sv7zNW5IYjU1d4dGctLx6EX0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:c0e:b0:e05:afa1:9c91 with SMTP
 id 3f1490d57ef6-e0b543c014fmr17243276.2.1722332442725; Tue, 30 Jul 2024
 02:40:42 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:40:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPq0qGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNT3ezktEzdZFNLIwtLi1SjpLQkJaDSgqLUtMwKsDHRsbW1ABweSid WAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=z6AMQsvLXODLg+pFFWql7FTeV2LVKue/By3e3mHikHE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmqLT/DlXPvLrNiN9RW7CHa+JUKbZ8WpU9oawxa
 rBXINc5ExKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqi0/wAKCRAEWL7uWMY5
 RifMD/9S9iChYHZ4DJJm411uHpuWsB1EOpo1ysk8eYxa7ATNAbHYYO43Nq9NSWk4IqmW0N9/LvY
 1FVKvuieTZjiFl1MadCOEjxs5fn0wv7FOv4ONkq3gmu4Io0X02PR2a1R41Eyg+9I6FJj4Tt9rbM
 GfPgmL72NxrK2DwxLdfSt+jiAex3megb/Dn4jM8iMgfFb+nJBQOPN3Nqh0jbNjmTWbU3ARvV1k/
 MLDYCkP56vrb8ihRT0TroqIKD/v19BoJqEgVqMnXX/zIKUdHXRgmtIwheMKkZKJ9sXDvsLY1nj1
 xHpWQt2buoPo4zOedf0ly+gcAFUAFoDOU5r7mOsTnBZM0soDJIOuqO6hq2c2wDq4n5AGpJLPjNG
 iVG5edF+gvTNbo880EUp7PwSSVu0emeVCul6+DJSBEcnGiSkoKY9vYHH+ZqNiGeyDabYxSSE6he
 k5GtNCs6SnRTLsWRohtpEPHPja68cl8tuX6aQZOiz+oYgVVJuSjYsiY60oiLFtGhtM549DUxAV6
 AUpo+2txYCvo2a/79q1YghQCMadxNKikcSsZk+vjrivB+EZmw8IOYkfvdhMJ7RT+5DXvgQgGMGv
 cz54JGXnpLJYc4MUDP32bckFXU5vx7zXhikQoahrSqRXKIN234ZIaCya6b4r8ELXDGEj0QLIK9U vv8RhnWsX+Jx/gA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240730-kcfi-v1-0-bbb948752a30@google.com>
Subject: [PATCH 0/2] Rust KCFI support
From: Alice Ryhl <aliceryhl@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Maurer <mmaurer@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

The control flow integrity (kCFI) sanitizer is an important sanitizer
that is often used in production. This patch series makes it possible to
use kCFI and Rust together.

The second patch in this series depends on the next version of [1],
which Miguel will send soon. It also depends on [2].

Link: https://lore.kernel.org/r/20240709160615.998336-12-ojeda@kernel.org [1]
Link: https://lore.kernel.org/r/20240730-target-json-arrays-v1-1-2b376fd0ecf4@google.com [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (1):
      cfi: add CONFIG_CFI_ICALL_NORMALIZE_INTEGERS

Matthew Maurer (1):
      rust: cfi: add support for CFI_CLANG with Rust

 Makefile                        | 10 ++++++++++
 arch/Kconfig                    | 11 +++++++++++
 init/Kconfig                    |  2 +-
 rust/Makefile                   |  2 +-
 scripts/generate_rust_target.rs |  1 +
 5 files changed, 24 insertions(+), 2 deletions(-)
---
base-commit: 8718bc07faa6ddf4f7335a12e4cdd4ffc796bbd8
change-id: 20240725-kcfi-c592898e2bfb

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


