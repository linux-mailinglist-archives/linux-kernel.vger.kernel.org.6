Return-Path: <linux-kernel+bounces-550943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD53A5664C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E013B6D93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70454215786;
	Fri,  7 Mar 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tgm5ESy1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DB9215168;
	Fri,  7 Mar 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345718; cv=none; b=Nww6/GrTKD7l52JqAzkniqcFEUQvTZAFZmRbybAC/L5v/rZN1Xzovwtbj3jEgea3xbMZKpmkibjQFw/FRd2Hob0Q4nOxAhxzxyZYV/334LhCo1poaWoAJAI9TDVIKXkzqwA654hnaqelqMmsn9TU5ZILnfFcf8no1Ehh4xUuDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345718; c=relaxed/simple;
	bh=jMCtgMty8Xj5S+wgAPSjJqGBcyOB8F6TpYrMc2l1nJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyGwty81knv9EDgOCB4GTzSEGzhMvUplmQoa7AK1jxOwCNFt8rRfgkP2QT+b310zHv5SbIdDaL9fNHocVPrBdQDvkn6nnNYA7LA9XAHAMqlJc18BLA7in5Z2YcazgSbH3nfPBBFYIIe5LGFgeCrD+mdvv+cW1A972CvDWTskS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tgm5ESy1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so2086472e87.1;
        Fri, 07 Mar 2025 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741345715; x=1741950515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=goq+Rv5UchdtTKanUxqHPoTKyKgnqXI7XzQqTTMH450=;
        b=Tgm5ESy11riRpJtt8/F8eKIonVM3BeYJPkWrhL5s7yX5O+dXg1M2fdmU1jn0TPvULC
         r6qdUy6DnVINfOZ7yS7e+WtXE5xArZ6Avd7i0iiBXwj9Si6UjKpl6Ce1J+qiGGMiP1td
         WGzHhY1d4blcQ3BLKy3HraGbYQvneb0q6EoJz4bhkVg0v1q0Ifr9Bk8qa9gLORbT6Eh8
         avADio5rOCany/U+GTg+GPax2IuJfRdE90JljnjnophWnbenOo5xmldZtfGJNK44eJvT
         OSV+cUaQI+aU4XAKcN9AAe5Ra96pYsQj8zCCmHIQcdCCHLcID0PftGsOoXTQrz7b1JIN
         PVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345715; x=1741950515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goq+Rv5UchdtTKanUxqHPoTKyKgnqXI7XzQqTTMH450=;
        b=V+dq4Nr0pC1Zv2S4JG4aQ/hOZ8DG22HOGpBr8Bn9E4dYmP3/gyh5XUEalWMOSgvguw
         /UKSNmt9331niQsygjBKnGQe4VXrB+jkaLvr/o7aabttX4baRQ+HR7d7SgkzRBVGZNVs
         t8C7thbXH3VSKnwTu/pcZvRMaQyGnnnaDNZSY3Ia6S+f78YCi6W5bX1W7Zog21iE6JgW
         09Xs8K6EIViYJPqu2/+3/VW2JfE8yudC4DUDmzbUs+havodUXcnej8+8S5YKmhNvcS5+
         wx246jK7vOME1C4hDYS4DRf/BPznmUk+XSXcSkAHCEREYnP3KLujGqck3mdcdvwexrMJ
         292Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM7zNb1rrAUTKhSfxwciTpBU6qzbY+LLq3ZRLPQtm8lko1zM4tH6nCvKW5UoNrT4Y3pKuyoRKwAmbSIMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8+05c2SUkHsH7Nqm37BDzsuTGkRaaYMuQ9ApN2+P0x4zYhZo
	OGB7WCVGyvT60hEHJJkZz47FZUzE/5jDlifx/U4Doe/hNJZvDdnSFKD69Q==
X-Gm-Gg: ASbGncv5FgB6OYhXiAymAQm1gTlRpePbxxWP2kaxoEJQw+fVZNB6M/uxfrifxIvpdsi
	l7Px5QZLo6MRIo1podeLJ8Qb//Vz0vA3B/v0xO8yjloZyS9k5WlmDXaQCbBm4Bea5x2uoHc0o6P
	9Oubn6gwE54Pvo02vjYJpzOFQ5StcCGd5w/fpOS44is2c8e1Ex0P7hdqLkQx8zYyE0S5eJaGDo/
	hgTyH1BxUiQBu8KVPNku+ZxnhYSQ/D5WO4xBnMRUzo+3/4tAzxQRiY4ElfWo80jzjnoslCN7mgK
	T/xsnthR0TeTG2tvjufU46o+jmhaibkKJCmGaDXcYLUwpvpKun71yl/gpeW99GYCFBpGBR1DOMr
	MSEcEmwya0sC2G+W4u6JE6g==
X-Google-Smtp-Source: AGHT+IHivXfHpJ/MkL3ckqcRz7Dp1glsJZvC43jbwp51OZ0izhWjLDTusmZgB0CbVNeM12vJynXOpw==
X-Received: by 2002:a05:6512:224f:b0:549:9078:dd4a with SMTP id 2adb3069b0e04-54990e5e0f7mr929157e87.14.1741345714361;
        Fri, 07 Mar 2025 03:08:34 -0800 (PST)
Received: from abj-NUC9VXQNX.. (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c2a08sm448920e87.223.2025.03.07.03.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:08:33 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	daniel.almeida@collabora.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	aliceryhl@google.com
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	airlied@redhat.com,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v13 0/7] rust: add dma coherent allocator abstraction
Date: Fri,  7 Mar 2025 13:06:17 +0200
Message-ID: <20250307110821.1703422-1-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds the rust bindings for the dma coherent allocator which
is needed for nova-core[0]. For v13, the biggest change is to move out
the as_slice and write helpers for later discussion. The object is also
now wrapped in Devres to explicitly tie it to the lifetime of the
device[1]. This is tested on a Nvidia GA104 GPU device using PoC code
which parses and loads the GSP firmware via DMA.

Changes sinve v12:
- Move out the contentious functions: as_slice, as_slice_mut, and write
  for later discussion as a separate patch. Make write unsafe as well.
  Remove skip_drop, use volatile r/w for field_read and field_write
  (Alice Ryhl, et al.).
- Documentation improvements, use markdown for intra-doc links
  (Miguel Ojeda).
- Move dma addressing capabilities to a separate patch within device.rs
  (Andreas Hindborg).
- Add a simple driver to excercise the basics of the api (Danilo).
- Link to v12: https://lore.kernel.org/lkml/20250224115007.2072043-1-abdiel.janulgue@gmail.com/

Changes since v11:
- Ensure robust handling for potential pointer arithmetic overflows
  in bounds checking (Petr Tesařík).
- Add dma mask helpers (Daniel Almeida).
- Clarification in the safety aspects of the as_slice/as_slice_mut API,
  Use ManuallyDrop trait as a replacement for into_parts(),
  Add dma_read!/dma_write! helper macros (Alice Ryhl).

Changes since v10:
- rename read() to as_slice() (Boqun Feng)
- Do a bitwise copy of ARef<Device> in into_parts() when returning the
  device reference (Alice Ryhl).

Changes since v9:
- Use ARef<Device> in the constructor arguments, docs clarification avoid
  manually dropping the refcount for the device in into_parts(), use
  add() instead of wrapping_add() in the pointer arithmetic for performance
  (Alice Ryhl).

Changes since v8:
- Add MAINTAINERS entry
- Fix build issues due to switch from core::ffi to crate:ffi in bindgen.
- Ensure the wrapped attribute is non-pub in struct Attrs, declare it 
  #[repr(transparent)] as well (Daniel Sedlak)

Changes since v7:
- Remove cpu_buf() and cpu_buf_mut() as exporting a r/w interface via
  a slice is undefined behaviour due to slice's requirement that the
  underlying pointer should not be modified (Alice Ryhl, Robin Murphy).
- Reintroduce r/w helpers instead which includes proper safety
  invariants (Daniel Almeida).

Changes since v6:
- Include the dma_attrs in the constructor, use alloc::Flags as inpiration

Changes since v5:
- Remove unnecessary lifetime annotation when returning the CPU buffer.

Changes since v4:
- Documentation and example fixes, use Markdown formatting (Miguel Ojeda).
- Discard read()/write() helpers to remove bound on Copy and fix overhead
  (Daniel Almeida).
- Improve error-handling in the constructor block (Andreas Hindborg).

Changes since v3:
- Reject ZST types by checking the type size in the constructor in
  addition to requiring FromBytes/AsBytes traits for the type (Alice Ryhl).

Changes since v2:
- Fixed missing header for generating the bindings.

Changes since v1:
- Fix missing info in commit log where EOVERFLOW is used.
- Restrict the dma coherent allocator to numeric types for now for valid
  behaviour (Daniel Almeida).
- Build slice dynamically.

[0] https://lore.kernel.org/lkml/20250131220432.17717-1-dakr@kernel.org/
[1] https://lore.kernel.org/lkml/20250305174118.GA351188@nvidia.com/

Abdiel Janulgue (6):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.
  rust: device: add dma addressing capabilities
  samples: rust: add Rust dma test sample driver
  MAINTAINERS: add entry for Rust dma mapping helpers device driver API
  rust: dma: add as_slice/write functions for CoherentAllocation

Danilo Krummrich (1):
  rust: pci: impl AsMut<Device> for pci::Device

 MAINTAINERS                     |  12 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/dma.c              |   8 +
 rust/helpers/helpers.c          |   1 +
 rust/kernel/device.rs           |  29 ++
 rust/kernel/dma.rs              | 464 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/pci.rs              |  11 +
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_dma.rs        | 104 +++++++
 12 files changed, 644 insertions(+)
 create mode 100644 rust/helpers/dma.c
 create mode 100644 rust/kernel/dma.rs
 create mode 100644 samples/rust/rust_dma.rs


base-commit: 6ad64bf91728502fe8a4d1419c0a3e4fd323f503
-- 
2.43.0


