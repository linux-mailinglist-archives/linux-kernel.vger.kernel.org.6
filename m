Return-Path: <linux-kernel+bounces-566880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BEFA67DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997EC17F17B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE9213E60;
	Tue, 18 Mar 2025 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaVHB+W8"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AD2116FE;
	Tue, 18 Mar 2025 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328861; cv=none; b=pXhpAQRobOyat5pT/cGxDECSHajCp/7aGNHCI89WufAljE/yajfKdXrmutOquaseTy38laUauYhgu5bEY8tkOQy4Wqaud9kNjqcuyrK9KR3Td+84v8KRRv2FvbVoe6BSOJOhfEcSp5DDiuugV+yKwBbvdUkqBe8cKt9hawgY7RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328861; c=relaxed/simple;
	bh=ZC+/wZFnozTe1tBwRApiqqljhJdQUMtpD1iDQ9v6X+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mKD+BGQP0vN8Mcu1yQsM6XQy7XNN/6GaWcA5IGF6Ch3g5ZMONlJd31PanPtGUqURwQ7I3BOwJKa5AAyi8cP2IibpjvrumzD15vvqBYKfioB5sr9G3YiNuYzKMdGzMQho9lU14eLQdtbRUgaXVsb1h5iSZMn+ff2jF9KuHzsZ17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaVHB+W8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fce04655so51795046d6.3;
        Tue, 18 Mar 2025 13:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328858; x=1742933658; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ke2dF+Mv4THIY9Xuoy975jdDp9kAFU9oMkxfHatBWa4=;
        b=FaVHB+W8iL7dtPRxdPY+H4jIM5u+B/5NjeUK+3JnTEQCfcFB6Lv5gsX3gDV3a+bfH1
         cywTSpa7IbTVQhRqgOYTrlaMrpUbyjg/XaIQLvTFub9fHlQfUfaFy1gvb12lUjYHDpu1
         9L6vW5Sn0aQD/MVi0382vUxiGA66Ufase5a6DokV6cJ5Yrr767SgT22g0lYBnNiMm7DS
         vKeTPAKI429UnnH+Z1gZ0W+sW8rWFkCIWCzrnJZywIn6PmIDKP+Jk84UneLLJFvsJVgg
         d+mWUp6uGoyFihB8+ITKrGGrXd59l5Mk989Jcjwm+pwAd+urshL2Mss6+AG3PmRDiLGx
         018Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328858; x=1742933658;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ke2dF+Mv4THIY9Xuoy975jdDp9kAFU9oMkxfHatBWa4=;
        b=WwgfJ+TabwRw9F8wDjBzRLqjhTpjiJ3pmvpYxr3+jX2w8B7YUbxYfx4Syw18bAJfP/
         L3ZTnfJVCcwyfpgmKEDCLrJDsHcPFjfiaiMKnpKJFPWGlblmaIxN1OT3RQRImURpFsJS
         k5o+47kfujqTQdO1Tl0Bs10wzlGdN5KQCmA8TUokzwFEE9uHm7RSmaRwL6URkTyaTnSr
         XdZmgOjzSzwz7noyAQyztuQLcJaN3kl1BaVEIeaQ71oBwxbiO0o+aBqkyM/yPfiLnRvl
         kyB3+OgO8eyPvzhZuOBsEA5E6nBEMKNArIE6M38o5k9wsbWdh4s+DFWJ5MHSCNVrcuMn
         0nRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV07BY5Sthz00tNdWUCdBQiORGi6dSlG4XAqW3DRJUGnqpx0/RAsFcimjrCc2btumeC72zyrLCOwUtaIQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8+2FLRfHQazBUfZAcfthwGwjTMs4UVd4W6143seGQU/YSguwq
	NUnNrkd2W85ceakPvBFHtWEqvRxgEQyA7Plkh3l7pJ17OkHDfOPj
X-Gm-Gg: ASbGncvX4Yug/kE2RzZEnkAEJuvKUebUkEZzqE9iZuYtcQDfybUvZhrL+qB6lBLlJc6
	HWBvVHIxjljApJWW2/ONfl3+br4B8C4eA8T+7yw5CQv3T5s2Vu7Y2dgRCwNM5bojuSsOMeWCfc0
	sLU2wzj9y/SZSJDEmrWs/sCOwjB5lSOqFCMK/g9m4o+4Id/0i6jyvya6u1KJeucr0mW9M5avLlX
	xbmftmZ5Bsofae5EMGb5Ad6yUaDywHfwLrf0E+5CsJr/uiA4/83+m2u0wzg+qc2az8l/x7FDVuG
	LXTIOzWNGsNXkAFVfUoJHbWb5u+VQeHPQ39M/aG424Ra/+n/2f3n/HSaFA==
X-Google-Smtp-Source: AGHT+IG5OV1zgGWKFbtolbXWh3IyHPJMJstn4NFzhyUsmg/s5e2nNmwPc9ykZoatV2c0xsQ8eMIR+Q==
X-Received: by 2002:ad4:5d4b:0:b0:6e8:ebc6:fd5f with SMTP id 6a1803df08f44-6eb2939fb0cmr2802956d6.20.1742328858583;
        Tue, 18 Mar 2025 13:14:18 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2620:10d:c091:600::1:e903])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209335sm71301046d6.22.2025.03.18.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:14:18 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/4] rust: alloc: split `Vec::set_len` into
 `Vec::{inc,dec}_len`
Date: Tue, 18 Mar 2025 16:13:52 -0400
Message-Id: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAHU2WcC/22Py27EIAwAfyXiXKqAeebU/6j2AI7ZIG2SFmjUa
 rX/Xpq99ji2PBrfWaWSqbJpuLNCR6553zrIl4HhErYr8Tx3ZnKUegRh+EHIKzV+o417H8kgKgd
 WsX7xUSjl79P2fum85Nr28nPKD/E3/d9zCD5yMybvgnRWQnq7riHfXnFf2eXxFBf6/Op17WlnM
 VTifb/mNg2YpI5oRHKBMMw+jqh0IpDGWwJNQUUBYN3ZGBou/alpcDpIowKgJWd6FtkIZvZCghK
 gkkb0QoExPeHxCzOT0YMoAQAA
X-Change-ID: 20250316-vec-set-len-99be6cc48374
To: Danilo Krummrich <dakr@kernel.org>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This series is the product of a discussion[0] on the safety requirements
of `set_len`.

This series depends on "rust: alloc: add Vec::truncate method" by Andrew
Ballance <andrewjballance@gmail.com> [1] and rewrites `Vec::truncate`
using `Vec::dec_len`.

Link: https://lore.kernel.org/all/20250315154436.65065-1-dakr@kernel.org/ [0]
Link: https://lore.kernel.org/all/20250316111644.154602-2-andrewjballance@gmail.com/ [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v2:
- Avoid overflow in `set_len`. (Benno Lossin)
- Explained `CString::try_from_fmt` usage of `set_len`. (Benno Lossin,
  Miguel Ojeda, Alice Ryhl)
- Added missing SoB. (Alice Ryhl)
- Prepend a patch documenting `Vec::len() <= Vec::capacity()` invariant.
- Add a patch rewriting `Vec::truncate` in terms of `Vec::dec_len`.
- Link to v1: https://lore.kernel.org/r/20250316-vec-set-len-v1-0-60f98a28723f@gmail.com

---
Tamir Duberstein (4):
      rust: alloc: add Vec::len() <= Vec::capacity invariant
      rust: alloc: add `Vec::dec_len`
      rust: alloc: refactor `Vec::truncate` using `dec_len`
      rust: alloc: replace `Vec::set_len` with `inc_len`

 rust/kernel/alloc/kvec.rs | 87 +++++++++++++++++++++++++++--------------------
 rust/kernel/str.rs        |  2 +-
 rust/kernel/uaccess.rs    |  2 +-
 3 files changed, 53 insertions(+), 38 deletions(-)
---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20250316-vec-set-len-99be6cc48374
prerequisite-patch-id: 85a264a3c7e86025e7b36d91234134f5cc914366

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


