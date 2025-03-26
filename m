Return-Path: <linux-kernel+bounces-577657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF02A71FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F5A178246
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F88255E2E;
	Wed, 26 Mar 2025 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEA1SiU4"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6F215196;
	Wed, 26 Mar 2025 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019984; cv=none; b=FM8EzhyIwfWzVsEtTG0Mc6l45K58GysRSUu5h3PLOaOviQjTZhbBoOXqGlbWuRaQ2J2Fq1Co3rjUTYUkKOD8ml5YjHoT1BRNRoow1iBAONAsO78i27nlwVataGkVQPNSg62mCf0Sa+elX8jbNw1+7MRjDSdrduzyVJmR1O3DWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019984; c=relaxed/simple;
	bh=stYmGGDpjD4/tFiBC4B/cjq8Qdu/fF5PqqR/CNBxpus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/OAHhYx0VBnjCE1eKyixKCTnLD4VzBIvRtB2sPasWd63/TWlRAjjQxs9efjTdAzQYj9n2Z2WqZu/Le/X+VktEXfd6saMbx8+n6xnH6uvQf2iE7N+ozM4pj+7/TeSV4zzR4/jHTXlnbe3Q9ZNgh4Kkib2kpP56r8VexRoA3goos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEA1SiU4; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf8632052so2940471fa.0;
        Wed, 26 Mar 2025 13:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743019980; x=1743624780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvGhRgUQQTe7LDrfZkfw77IPStuXrPdo85w1zZBpkJw=;
        b=aEA1SiU4auebeRCdPBJTqqj+d6z/6NJaK1Vv2GemllEKsDu/u6j+9B7gPwn7GUlcwu
         GjfyaO8TJ2GgwBzxx+txyfKPq4OjElxI0K4mifttBGLNfIDJmRnM/SHAi22SlgLch2c6
         xEoOIIVRpFdTj2cW6BOgNK/d1SycWYVMfNHd/mwbRCeP+Utim+2bxB2oOKjBRcNL+G6b
         zbkZqh59MU+E0tBgQJQfZYeTYGzW1E3skG+ryynRxWJJ04ZoD5meRO1IPHNi6cURnEep
         Z7pdW2zweXgHoN0+qD5clE0eqY4BbsfqY220zQ6YQDOFEr69VWiaEVC8vxKSd3YWf7wM
         UX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743019980; x=1743624780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvGhRgUQQTe7LDrfZkfw77IPStuXrPdo85w1zZBpkJw=;
        b=arvHt8WlWDOX6ZAf4JOk3LzrTs0gs5JSe2MhfAG3dl3gI6nFFeuzIwaNYFB5ggaJaR
         F50VgruYmp/eyso5CZHHha5iyJt+lJlIrZMZcvLFArVuAhwtfK0ipN0aGj+7M3Oo3fcr
         tT01a9tSGJ2IZXkLW52/BdDyF7N1RWXAu47XnIBXeOxXiJgX2ffUpg/OzPshDq2mxvTG
         ECFTSpAXkwrYS+jJlG8wXwdaPnFK+vR0PaAIviL+GfGKzyF0bHotHdFS3BWh8AqUsFNO
         shdMxpAdzpdg/836gn6E8hDu3acVnO3gWmdyH3+5nt3UIXTmqtPzuwb5V+4eR0MMuK+d
         wJug==
X-Forwarded-Encrypted: i=1; AJvYcCWFzP5gTEZUUe/2mQ4pf73ptKckv6Fk2euOgPN8qvy7sTBSo7B2r5jN8DBs7Qdl1exGr1J278j1xPhH3T0=@vger.kernel.org, AJvYcCWahAA9m97pEfaUuPo1//KTJ7HcbtMs7ms9phYy7AwaRByWRPt9m0wKjUEkoobcYlp9OMAyoIzHwn4saT0b8X4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9N0GBz5SABJA+DrJ4ENFoS5g4eipSNR6hP8ieeGXgsmHHbTQ
	3gmbOSpwX0i1n/5H0Fbp00pQ56rSvK/hMrVVLtP0JscNskDQiThC
X-Gm-Gg: ASbGncvnTWNjOIvtfwQScugnZ9m3YAg4qSlrwThZ7vwb/TiXSXt4BnY7+bjRnG/Jait
	PZlfmrKEwhpeTcB4k+ffq4+Cj0/2/dBet2ebdGEZebjevzRi4X4KQHZTe/dCzJgAWOBGrKh5ldP
	VTc6JCfBBWx9jiGW7UbWLIFU1mbVeIzY58HSllq9FwgNkW/kCtu99Q67tQy5tKp1nIrYjCHG4tS
	njDbVjFTzTdVH8sC8Z0E/+XGpCWi/VuK+NHvqwpZK5VAxi6kcfko2Xb5vLL0n+7rI6/hEezQPMw
	e4djvLNbgi9dDXgikc0XZ6FEC9PNkUSdU83dow4IUiRVYyk/TMt7dIiQntfvMRS89+OQow/rnJf
	Gn3u06Cd2GG/dQKR19BnneA==
X-Google-Smtp-Source: AGHT+IH+TqDP71XrNIXqtEqJEpXk/B2z8Fv+6HePdoMFwLb0bvleEmB5zHlEOlYypeoPyLwRZuNHKw==
X-Received: by 2002:a05:6512:1393:b0:549:6bad:3977 with SMTP id 2adb3069b0e04-54b011dd205mr454607e87.31.1743019980249;
        Wed, 26 Mar 2025 13:13:00 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646873asm1872136e87.46.2025.03.26.13.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:12:58 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: a.hindborg@kernel.org,
	ojeda@kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org (open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]),
	Marek Szyprowski <m.szyprowski@samsung.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH 0/3] Additional fixes for dma coherent allocator
Date: Wed, 26 Mar 2025 22:11:41 +0200
Message-ID: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Additional fixups to improve the documentation and make the read/write
macros return Result as suggested by Andreas Hindborg as well as support
for reading and writing large blocks of data.

Abdiel Janulgue (3):
  rust: dma: be consistent in using the `coherent` nomenclature
  rust: dma: convert the read/write macros to return Result
  rust: dma: add as_slice/write functions for CoherentAllocation

 rust/kernel/dma.rs       | 153 +++++++++++++++++++++++++++++++--------
 samples/rust/rust_dma.rs |  21 ++----
 2 files changed, 131 insertions(+), 43 deletions(-)


base-commit: e6ea10d5dbe082c54add289b44f08c9fcfe658af
-- 
2.43.0


