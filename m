Return-Path: <linux-kernel+bounces-568764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A4BA69A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705491B61801
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E921149C;
	Wed, 19 Mar 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="up0KQCd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF291EC013;
	Wed, 19 Mar 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416501; cv=none; b=LhWUGyE2vJ04da+faUAHzeWcyVfJpisfIHGXRajNYrNDElPgzKEC3r+bfFU9jFr2TCwi9wN2+fUoz8xwBllpR8DdMPGa0PBz/3LNiy5AMe4ORv8zcjTD2t6tf4KgOzifx+z7SyG6F7ju0v6NwDVQ4FOC7b48RG6zYpmVjAF+2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416501; c=relaxed/simple;
	bh=H0rFOMCRzN8MVAiRADCgAvh9RBoNUtNwjYU5xaKEGAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpDciqoK9IIozHBH34p5YBjaiOfAIaXELhyG+9E2S2DgeHGjuOiWgMdlwhUK+tgtWn7HI0++PEVEosuDjuWoH5lwWVccGCCjXr9arsNaRg86KeyLedTp9ge5XAhtAIS6Ejifn70t/byFKvdJ9TVeu9oxjay/5P09w4dCReNXbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=up0KQCd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8731C4CEE4;
	Wed, 19 Mar 2025 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416500;
	bh=H0rFOMCRzN8MVAiRADCgAvh9RBoNUtNwjYU5xaKEGAA=;
	h=From:To:Cc:Subject:Date:From;
	b=up0KQCd8jxONa+a0C34prRiS6W0LLEbK3ue6PfqxEI2CbDi+Km15MMYq9CbZiRsax
	 OjQlAth+PJ+eeyyPnQWMyoH6oAM9PMVlz11gHq3/yXHFVryiZuolL58HwObJNiqK8L
	 klkH4JiSlZqIDtL4z4hHBFCdOegTxwmSPrZ9F9ja/zCP768GjeJYAoxIB/k/JeC80s
	 dRYqJ8Bs3TdDdBoS2NZ0jAP0PnjCZM8V6M04/kgUPG/0YrGKexM71FyaGFOxBz8nRg
	 Tb+v8umr6N2ZlQ9Lw3swev/xzMK7DUxUAnMLY41EQ7hLoBVmcvXB2KBpSu9BL93bj1
	 PUBrvlgGqMdAg==
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
Subject: [PATCH v3 0/5] Auxiliary bus Rust abstractions
Date: Wed, 19 Mar 2025 21:33:52 +0100
Message-ID: <20250319203455.132539-1-dakr@kernel.org>
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

This patch series depends on patches queued for v6.15-rc1 from different trees
(driver-core, nova), plus the patches in [1]; a branch containing the patches,
including the dependencies can be found in [2].

[1] https://lore.kernel.org/lkml/20250319203112.131959-1-dakr@kernel.org/
[2] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/auxiliary

Changes in v3:
  - export auxiliary_bus_type
  - implement impl TryFrom<&Device> for &auxiliary::Device
  - implement Send + Sync for Registration and Device

Changes in v2:
  - implement bus device soundness improvements from [2]

Danilo Krummrich (5):
  rust: types: add `Opaque::zeroed`
  driver: core: auxiliary: export auxiliary_bus_type
  rust: auxiliary: add auxiliary device / driver abstractions
  rust: auxiliary: add auxiliary registration
  samples: rust: add Rust auxiliary driver sample

 MAINTAINERS                           |   2 +
 drivers/base/auxiliary.c              |   3 +-
 include/linux/auxiliary_bus.h         |   2 +
 rust/bindings/bindings_helper.h       |   1 +
 rust/helpers/auxiliary.c              |  23 ++
 rust/helpers/helpers.c                |   1 +
 rust/kernel/auxiliary.rs              | 383 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                    |   2 +
 rust/kernel/types.rs                  |   8 +
 samples/rust/Kconfig                  |  12 +
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_driver_auxiliary.rs | 110 ++++++++
 12 files changed, 547 insertions(+), 1 deletion(-)
 create mode 100644 rust/helpers/auxiliary.c
 create mode 100644 rust/kernel/auxiliary.rs
 create mode 100644 samples/rust/rust_driver_auxiliary.rs

-- 
2.48.1


