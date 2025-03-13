Return-Path: <linux-kernel+bounces-558713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03B9A5E9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA07D1899A3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31718635C;
	Thu, 13 Mar 2025 02:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJaJyvyg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59674747F;
	Thu, 13 Mar 2025 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741832707; cv=none; b=QtaHaY9ETw6kbdo7QSyMMne54f0h/aBx8rseS+Xpzl1/mkNtsYCzENDOWuZEx5VkRPIH4huCeLE1yNYw0IJylnd0CfoHPhUx7nog7FicSvSOYxHrsLnGsEjgKMuUD7JZL+ROE8w4/mzCwEiv0vyrH0XtCiS9lLXe/rtZ0EwSJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741832707; c=relaxed/simple;
	bh=I8KAthGiH8s06JCo7t3WxhGBy8bQbZ3xj9C2UMHkyJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZCFI54jG07HL0y42utQZCNZt6+f0hXpVBpNgDIf/HicL3r2fhlSmg8kpMd8kiQcCUpW+wV9C3j7e4icVkYcRh11kiJ02uIL++JkX3E2y7BgrjHii9eAosZs9t8OOOO+IodDyD+8Rs2OEa2YaZmbaB05TEMOsndEVuqjfxOPrbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJaJyvyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732D4C4CEDD;
	Thu, 13 Mar 2025 02:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741832706;
	bh=I8KAthGiH8s06JCo7t3WxhGBy8bQbZ3xj9C2UMHkyJE=;
	h=From:To:Cc:Subject:Date:From;
	b=LJaJyvyglAuOl5cpv2mcUnQYNYXqXpG/ne/8mbvF0XRTYpskAfwndPXxDxxlFZGBv
	 23f7EBmUlufAZ/IThnWRRcUl2A2lDp+CttJuEoWob4C/ZUkbmxdHsh3y9U8zz0rJPw
	 IoFEd74BdlErpV0NED1XGToLyfCH9+ayFmhGOdx9yeHfUeblJJDPD75SlfEaMbQx2Y
	 WS4FlN8fxclwRe26nwHii/94zbQbILwVoDmRWj73o6iZzIAE4UughmtpxmjBOJT+d7
	 vOSUSVYKAOM/EXyYAcWdb1Csa8lQfz1oljfTKOPQqsSg8EpANOhV0MQykElO91em2m
	 WwhwSNtVxa2VA==
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
Subject: [PATCH v2 0/4] Auxiliary bus Rust abstractions
Date: Thu, 13 Mar 2025 03:23:49 +0100
Message-ID: <20250313022454.147118-1-dakr@kernel.org>
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

This patch series depends on [1] (taken through the nova tree for v6.15) and
[2]; a branch containing the patches, including the dependency can be found in
[3].

[1] https://lore.kernel.org/rust-for-linux/20250306222336.23482-2-dakr@kernel.org/
[2] https://lore.kernel.org/lkml/20250313021550.133041-1-dakr@kernel.org/
[3] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/auxiliary

Changes in v2:
  - implement bus device soundness improvements from [2]

Danilo Krummrich (4):
  rust: types: add `Opaque::zeroed`
  rust: auxiliary: add auxiliary device / driver abstractions
  rust: auxiliary: add auxiliary registration
  samples: rust: add Rust auxiliary driver sample

 MAINTAINERS                           |   2 +
 rust/bindings/bindings_helper.h       |   1 +
 rust/helpers/auxiliary.c              |  23 ++
 rust/helpers/helpers.c                |   1 +
 rust/kernel/auxiliary.rs              | 345 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                    |   2 +
 rust/kernel/types.rs                  |   8 +
 samples/rust/Kconfig                  |  12 +
 samples/rust/Makefile                 |   1 +
 samples/rust/rust_driver_auxiliary.rs |  99 ++++++++
 10 files changed, 494 insertions(+)
 create mode 100644 rust/helpers/auxiliary.c
 create mode 100644 rust/kernel/auxiliary.rs
 create mode 100644 samples/rust/rust_driver_auxiliary.rs


base-commit: 31cc40e864273b384f4e640ba3f11add432b78e0
-- 
2.48.1


