Return-Path: <linux-kernel+bounces-528944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F28EA41E45
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7781891290
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BB9158870;
	Mon, 24 Feb 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeRwyg45"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767B25D546;
	Mon, 24 Feb 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397837; cv=none; b=cS1J2JVLG90BKRuBDFGETlZtX4QSbhQH9uUJExlypaCQeNXU+i1pmKqrXm5bOOx8+Secn6gM4jtVGMmgApzHv5e+UBUmfbb5OYe+qbDiKHox7MmYT0tY3tAlsGCuDVrY+rn4b4ZMOspy1pND423DpI3it/kqtKlFQk2+mDQQJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397837; c=relaxed/simple;
	bh=YDNlTCQoGkJaNVtqgLpI0u33kBZS6sYuWLEQLNwBwM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vu1TmC8Lg44lJS6PzG5GJgphqF1chVyYDHcU52Codj936/udcTgPAh0Rwta67x3l7SdAqozJizTOAu9yWZxiNhUFrwko/NXrXmWHn3xeyDZfKKR8/aNFGVhWRFTDTq4rGybN3cCOIpf/34aF2bkBvMLTkNgz/ZIjelKwXKMMNwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeRwyg45; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a04so45806951fa.2;
        Mon, 24 Feb 2025 03:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397832; x=1741002632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nvYQvXkD0Ar4QdoxJqSHp8EpN6ZHUmaSp2XNQrJj5I=;
        b=ZeRwyg451Z5schit36GmoBUtdITPztp+vOK65yGZj+pk23AfD/l1VD3aQKEpSObunA
         AZ4OHqOAOQ0juDR0pmEp1zZ2DdS81b7AIRRBq7hWsDAOhctTbQInZ7YRtYmebVFlyUrg
         FTxsGaQILueEdi9PCWgXE+ZdjvySLL4PLJXf54TEye8SDlOBq2IDWjCEChoQP7Auzd6K
         PxJiEhBF1e/frXGwF9xSchhVrB4TMoRMAyolc6bE7EaKYgHScsg35cxei6594qm4W19n
         U5BOjpO9QPEvNhW0q/uhKcH2DgeqFkMLvTWxQ3CnEr8cIO5js7O1ezKbjhBFeTYmcB1s
         XLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397832; x=1741002632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nvYQvXkD0Ar4QdoxJqSHp8EpN6ZHUmaSp2XNQrJj5I=;
        b=XXHVNt7FntVF5CIu+xzzONwds42oUDMZA69475+7HELZXNXvbnAVYVniR46IuF55oA
         2dCBCRHvcnbm+45CD1WVnsMUn++Qk9+brblUZVAGBi/gBaL9X8DBXBUxkjptE65Tnt1f
         8KqBUl4EyheAknUKNWDDcEkh8665/lC2a3vuBzZJ3oxPFxwvmzIIYgL5SzxWL70fuhNG
         pM5jHHLFq1aoIZclFHX53jYhpesQfwTYynykKw2Bb5QyeaNTi/m36iWrkKDw51qMrL+s
         48e9ms1yE7n5zDNYZh/lcb4NTTW75Xd0sDKiGdt1ikwRXSdD62YrxCKSFv6oZqeIda40
         gvsA==
X-Forwarded-Encrypted: i=1; AJvYcCVcDifvlyVAwHmGFVtSdJXPgTNBUXQlN+1qIVakNFWzO3joylt1eBpTIXBvpfYSEihe3CQ8i+AAZJfhMwk=@vger.kernel.org, AJvYcCWIx0SGXDzE/iflnP9jPlOdzcFgQQATO6KwZk76uDFsAoeW26zsh/dA9pwF9J1sK0yS9xWmdLktK3y3h7cxx3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYzRh3hNJzw3xcvxg3S+TWuP+F5qxeoMR15cEWFWocTsTsXy7y
	XXs9ILZtu7Vewefs2WdjrkeWshtW5CtXG3Q8WZJm+SwP9M61Dih2
X-Gm-Gg: ASbGnctfNFZSh6pq0UTl7pDhUuyZQ7RSsIhkwTW3OHt09k0mJbZV0oMog7ahwDs9Z+s
	Tw+zCtM/rA0XhoIQbL3K2RqWk4A881hVTtNXVa/nyzlGpXpp1tY+aGPIVZ4FVaCk0PwA6KeA8cp
	s8rFMnoaL7E99fAY0Uyuh6OTHGIAr5/TuK404NovkRzVVzlnBXgK5cZZYyAZSY/YYMQSWT0KLHg
	nEzULgxN+CHBr/CtdIePXVBr/dHoZ3cjmTeEHkb+IcHwoBHUvJL5nE0mHNzAe/2s8Ysa0xna5Dr
	ho8lsku+o0CWkrBqOu5k8bIc4/91Bbc4bcZp2MNBVdd5fJK/UShCvbYCr31eq8fJIdJKCpwZ
X-Google-Smtp-Source: AGHT+IFPu6tr3k4lr0i+UTEWtLUz2QUN9RBBkDDNDW6fc64OhExid58PNm2lBtTjf3FY6e5KF3KbtQ==
X-Received: by 2002:a2e:9f42:0:b0:309:2653:5dc9 with SMTP id 38308e7fff4ca-30a5b217b39mr38422761fa.37.1740397832198;
        Mon, 24 Feb 2025 03:50:32 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3091f26cd5bsm33174541fa.18.2025.02.24.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:50:30 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: aliceryhl@google.com,
	dakr@kernel.org,
	robin.murphy@arm.com,
	daniel.almeida@collabora.com,
	rust-for-linux@vger.kernel.org
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
Subject: [PATCH v12 0/3] rust: add dma coherent allocator abstraction
Date: Mon, 24 Feb 2025 13:49:04 +0200
Message-ID: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
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
is needed for nova-core[0]. This is tested on a Nvidia GA104 GPU device
using PoC code which parses and loads the GSP firmware via DMA.

Changes since v11:
- Ensure robust handling for potential pointer arithmetic overflows
  in bounds checking (Petr Tesařík).
- Add dma mask helpers (Daniel Almeida).
- Clarification in the safety aspects of the as_slice/as_slice_mut API,
  Use ManuallyDrop trait as a replacement for into_parts(),
  Add dma_read!/dma_write! helper macros (Alice Ryhl).
- Link to v11: https://lore.kernel.org/lkml/20250123104333.1340512-1-abdiel.janulgue@gmail.com/

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

Abdiel Janulgue (3):
  rust: error: Add EOVERFLOW
  rust: add dma coherent allocator abstraction.
  MAINTAINERS: add entry for Rust dma mapping helpers device driver API

 MAINTAINERS                     |  12 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/dma.c              |  14 ++
 rust/helpers/helpers.c          |   1 +
 rust/kernel/dma.rs              | 411 ++++++++++++++++++++++++++++++++
 rust/kernel/error.rs            |   1 +
 rust/kernel/lib.rs              |   1 +
 7 files changed, 441 insertions(+)
 create mode 100644 rust/helpers/dma.c
 create mode 100644 rust/kernel/dma.rs


base-commit: beeb78d46249cab8b2b8359a2ce8fa5376b5ad2d
-- 
2.43.0


