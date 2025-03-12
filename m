Return-Path: <linux-kernel+bounces-557102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A5A5D3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBE6189920E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164314CB5B;
	Wed, 12 Mar 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSfYrsHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FB182D7;
	Wed, 12 Mar 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741739278; cv=none; b=N0QMUDAtQCkP7y+tvDyg6JjZACvPkDqI94J3sG0cjjLMkPcOVq5i2KnhHu1F0+HVrkoFJYg1TsAibtiu79LUT1453GEC/EVgGmcKLUXY+8qhfABQPHsfag4BPz196sxlA9wJaKddktd9eigtDlptISv2Eb6IYdep+xEwc/HSOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741739278; c=relaxed/simple;
	bh=KCbFaRWdIjN4o5Yx3j3PPgl0g6xPJDV2hYe2S//eYDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWwOlU6gtOZWB4z48WxjPqi0YmczUspGc0HgqY+si+52eGR3bczK6fgHwj5FSQRdShlzy4EG3ysyre1jAUzoJ8myEAb19wK9N3sMyAowvWkqYhJ3ZHYQCYX0ZlQph1qFwX2zIlBiAS8aN2lhn9jjLntu66YQgTXGJlc+vGwPsxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSfYrsHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C146C4CEE9;
	Wed, 12 Mar 2025 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741739277;
	bh=KCbFaRWdIjN4o5Yx3j3PPgl0g6xPJDV2hYe2S//eYDc=;
	h=From:To:Cc:Subject:Date:From;
	b=dSfYrsHgvSpWFdTFurvNYNhu7Nqo4h9LjGWubSiLl/JnceILN6q5sVmrbuFK0DkPC
	 vto9/DeVLlH5T5w6LnenYMdm/1O1VqFfbG92FWFBUEMe2ToL7uWwYgIF8KypVZnzJb
	 Wq7Wbw7gEVg2L/ja3rZZZN6usIL9QtjXqY5dV6qV40e7B8bjxHR5DFfKW3ZqFpfkZi
	 H5D0GzNxWMkfRBEUoe62Eb9+RByrMLotV6yomV/kTeYXHbQiE5iEiTFIfVtywf8QMT
	 1MK0NzA/O8qw/RjbePEiQ8gmByRHF+szfBRivtUrH1GE/t7UIhICkfkBZGTwqKV+4n
	 6oZULEKDseJIQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	airlied@gmail.com,
	acourbot@nvidia.com,
	jhubbard@nvidia.com
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/4] Auxiliary bus Rust abstractions
Date: Wed, 12 Mar 2025 01:19:06 +0100
Message-ID: <20250312002741.453350-1-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds Rust abstractions for the auxiliary bus.

It implements the required abstractions to write auxiliary drivers and create
auxiliary device registrations. A driver sample illustrates how the
corresponding abstractions work.

The auxiliary abstractions are required for the Nova driver project, in order to
connect nova-core with the nova-drm driver.

This patch series depends on [1] (taken through the nova tree for v6.15); a
branch containing the patches, including the dependency can be found in [2].

[1] https://lore.kernel.org/rust-for-linux/20250306222336.23482-2-dakr@kernel.org/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/auxiliary

Danilo Krummrich (4):
  rust: types: add `Opaque::zeroed`
  rust: auxiliary: add auxiliary driver abstractions
  rust: auxiliary: add auxiliary registration
  samples: rust: add Rust auxiliary driver sample

 MAINTAINERS                           |   2 +
 rust/bindings/bindings_helper.h       |   1 +
 rust/helpers/auxiliary.c              |  23 ++
 rust/helpers/helpers.c                |   1 +
 rust/kernel/auxiliary.rs              | 311 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                    |   2 +
 rust/kernel/types.rs                  |   8 +
 samples/rust/Kconfig                  |  10 +
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_driver_auxiliary.rs |  99 ++++++++
 10 files changed, 458 insertions(+)
 create mode 100644 rust/helpers/auxiliary.c
 create mode 100644 rust/kernel/auxiliary.rs
 create mode 100644 samples/rust/rust_driver_auxiliary.rs


base-commit: b28786b190d1ae2df5e6a5181ad78c6f226ea3e1
-- 
2.48.1


