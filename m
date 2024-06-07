Return-Path: <linux-kernel+bounces-205689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AD78FFEF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A7FB21505
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A115B55F;
	Fri,  7 Jun 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCl9vHVJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3F152511
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751559; cv=none; b=c+7vApF9ce1etUuQB+KrgvAprS4e54tw2O/lot3ICCiGwrvFJi2wrz05+XBhu6D9wUMjoEcyxZ1y1VIMeDKJiylZdyYPUj0jgKmHVAVQY5C9oM+v9+9jdGq/aLSErSnqCOyDFV4aNpjIkWXqankD6Cv6YzUVWXzvinCAhXs3WiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751559; c=relaxed/simple;
	bh=Q2KyKee5qAk5yhcRdV4zkO1fcS4SwRxZde8YLboA1fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJI8mtk7IW68XwJZaPqhbeL4QwlM22UiagpRDihmZe8NVocr0iQkBpU7FA/qdM1j82uU7PhGKOPVo1/UKglxRfmWj1kF5A49EuPiv6cuL4Z98TFn95B21dSioUYoZPVFdsaUUC2XPwzi9yL4By/lwqchxicU3vGoX0/KvgAxNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCl9vHVJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6342c5fa8so18058835ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717751556; x=1718356356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPveJQ5m/OIT5FdwV6oYgK1mHcEkZsFVv5qp/eyftFQ=;
        b=aCl9vHVJECUN8oyvlZIZqfL11NXmIXugJjUpD00WAuL0qWZyjotVrVM9Xi5gHljFbp
         nN5yQZQif0FBMAbhPPGgde8G2+fQ7Z6wrO2usRhLrvtcc4RV7tH76SG13vL83JePM4DS
         37Gtg9NpDx9sH1T277jyi2B5VJyHOEy46Y/4M882B/7HSGkD/uMLEWU6HwgergO5+/2+
         IMxWiX5uEqRGAgiugWl9UmFZlBwUCrG/UIKd1b4W9H+HAndfAILQScbytqHWskuSR57M
         iQzcpLXEma/Jpkg6s7QL1yGTBRXF3C2h74hOU75XoUZOTLEbGOAIl2F0DjTAuffvOBUf
         cHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751556; x=1718356356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPveJQ5m/OIT5FdwV6oYgK1mHcEkZsFVv5qp/eyftFQ=;
        b=maMcGCdgMb0pmNj6FwwH91u/+oumG4S0C7NtoCaz7lAKyZ476lWT5ULFW2KMUuneuf
         7bW9krCYL5Ladijpnsviz3LpfEOthbtO+9X1vxyHOEdUu/gO4174XeI4dBu0pRZu6n/P
         6w3bTFjeNVPQjApzsAlBMS2zC4eaxsDsR8PmAmCN+KJQSia9X2XGpBNvzO8+MW9opkgp
         jNLF6Uz4jYcusa/lJ6fN2UI2Flhsbb/eGVxfkfo5Pz12ScnvmC4z9naa4GL8H0zxR3Bj
         kPfcxV5QZYsf+EUPkD94m6HX3CJ+HRMK0vLYzQP5R5xhT5xDBvYjeSH12yM6Xya+0Rxv
         umGA==
X-Forwarded-Encrypted: i=1; AJvYcCX93i6B1WSDIvANtKTfKTxwRCTaugiRvonJap7nfATfDRgSVAQY3GN3p0b5twEnYK0FG+jiVYyv05K+XQpyg3OIVC9RkldQZXjMUix2
X-Gm-Message-State: AOJu0YzVgpJwuucmLgSicOI27RsoZF7zK5JWZjb9aWX78c92dtuX7TtT
	z8wS0J+wC7QvDaunddC7X2QxTQKpFBZFjNnA+SdeZKyapGRykIW1mmf63xSUQ0w=
X-Google-Smtp-Source: AGHT+IETqK0zIIliNwoalKCFWPqaghIKyxJIFCSap/cz1CcyLlXt9SgcECRYv4nhSTpyDxxto+jOcQ==
X-Received: by 2002:a17:902:d2ca:b0:1f6:7f0c:6c3e with SMTP id d9443c01a7336-1f6d02d3acamr23916915ad.12.1717751555988;
        Fri, 07 Jun 2024 02:12:35 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e3e66sm29238035ad.182.2024.06.07.02.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:12:35 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH V2 0/8] Rust bindings for cpufreq and OPP core + sample driver
Date: Fri,  7 Jun 2024 14:42:15 +0530
Message-Id: <cover.1717750631.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This RFC adds initial rust bindings for two subsystems, cpufreq and operating
performance points (OPP). The bindings are provided for most of the interface
these subsystems expose.

This series also provides a sample cpufreq driver rcpufreq-dt, which is a
duplicate of the merged cpufreq-dt driver (A generic platform agnostic device
tree based cpufreq driver) used on most of the ARM platforms.

This is tested with the help of QEMU for now and frequency transitions and
configurations work as expected. No performance measurement is done as of now
with this.

These patches (along with few other dependencies) are pushed here for anyone to
give them a try:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git rust/cpufreq-dt


This depends on basic bindings for few other modules: device/driver, platform
driver, OF, clk, and cpumask. I am not looking to upstream a full fledged
support for them yet.

Based staging/rust-device from the Rust tree (which is based over v6.10-rc1).

V1->V2:
- Create and use separate bindings for OF, clk, cpumask, etc (not included in
  this patchset but pushed to the above branch). This helped removing direct
  calls from the driver.
- Fix wrong usage of Pinning + Vec.
- Use Token for OPP Config.
- Use Opaque, transparent and Aref for few structures.
- Broken down into smaller patches to make it easy for reviewers.
- Based over staging/rust-device.

Thanks.

Viresh Kumar (8):
  rust: Add initial bindings for OPP framework
  rust: Extend OPP bindings for the OPP table
  rust: Extend OPP bindings for the configuration options
  rust: Add initial bindings for cpufreq framework
  rust: Extend cpufreq bindings for policy and driver ops
  rust: Extend cpufreq bindings for driver registration
  rust: Extend OPP bindings with CPU frequency table
  cpufreq: Add Rust based cpufreq-dt driver

 drivers/cpufreq/Kconfig         |   12 +
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/rcpufreq_dt.rs  |  229 +++++++
 rust/bindings/bindings_helper.h |    2 +
 rust/helpers.c                  |   15 +
 rust/kernel/cpufreq.rs          | 1070 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |    4 +
 rust/kernel/opp.rs              |  886 +++++++++++++++++++++++++
 8 files changed, 2219 insertions(+)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


