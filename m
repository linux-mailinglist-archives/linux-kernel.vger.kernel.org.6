Return-Path: <linux-kernel+bounces-511808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C3A33007
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB47188BEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2475200114;
	Wed, 12 Feb 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRSJyY9C"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D21FFC69;
	Wed, 12 Feb 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389492; cv=none; b=HgsqfQuXTllZ8UFFmITjb7/VhDVoN0NKwKhVtTYvrTPscUOfF+nZcq9BPSx4hYQE2braqniLRKkiRNNdvKR92/XswHZllU2qkDyzEKB1y3WkQ8u9G6il78Rbzf4XrmyJXGKDCKE4bTmnbtykvOXMtd+wxuHxj+Q+WTQ/1jSxH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389492; c=relaxed/simple;
	bh=ywIzaOVXmImOoO4Gas/GMqK2ose5vqyNopDAxiufQoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nYMXbhUH2+eZpQhHQe5tkiRza3TaqDVBOekXMQPY74Omm7cnNkH8doveE31cOB1A0TgxJnsH/ChF3FZlnkPCo6gcFDSBEEcrK0dCfuK70W8/rVWH0bNX5BYCzNoZFBx6Ys9qj9jJKjOv4rbKXSElpql5NPYA1hBo1RLNzslxR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRSJyY9C; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fc7d346980so46728eaf.1;
        Wed, 12 Feb 2025 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739389489; x=1739994289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPSeivS3uH0MhnhX3dDqt0ADzcQbXXGvaG4UAUIk9ZM=;
        b=nRSJyY9Cd3FlMk7wpBMxAl5Aq1LCMs+e/UxuptaqEwx6xgj8GX2qzhJ0jyQonTwHZr
         sT9vzYsqS+wOcYxjjGFwPvSQx5VMIB7dV2a/1zjfbaXfjDM0EsTA/BjJn9wfeEnYQrz8
         uJ+sxs1Mt0NQMf7r0vJGLzDxztZ87d4ExtmUtw2XyFx9WlcscdMIvG3jri6/nD2sF258
         ypdUUGiyAsA40tnkBNTPNZlRGscACj6QYWyIjUxLWUcaWCdMbGeXynib89i0/gg2X4u7
         ZmCTB7wkexMPRYNMVjThGFVHBq8R7xPovkylOuH4notuRCutx5FEKoYpue+8ooQRiI3N
         6HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389489; x=1739994289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPSeivS3uH0MhnhX3dDqt0ADzcQbXXGvaG4UAUIk9ZM=;
        b=AE78VsV9aiWR4Wf4siOKVaI00ZQnoc78HKv44esLFeoDcEFDu8rHkS2/zpzGZOTUOr
         cuJbjlwdjVlTDSdEJ1YZS+rWORG/NTcOiey80E1sHZuEYbyb+2DfVhrXj1wZeXRrGQRT
         DJx8QJ+gKjOihYLUS/3mUdBsxgfmZZJ3nNn6P9fkthMacUGqGWJpfuvirnFbC/oLDDMu
         lOcFdpJSB3nHiVkc32+CTryQEgidENGl2f/OoOQsYIMc04b0/WEGBlAMXgxySuXmzDYo
         6rlzFZXbuwaBxQKW/jtF5Y+HVOrTWvUsrgR3IheNT6cEvnQGuX0b4nVBI9wp1qaI9cmJ
         k+Og==
X-Forwarded-Encrypted: i=1; AJvYcCVNLe2k91NlWJltfS4MG7DWFEqtOZmpBCb9x0EPkBf+ortV9enb1wCu6We3WGqYFQbkKXXYQfANok70udc=@vger.kernel.org, AJvYcCVd9/ysv3HdTtz9vpgmDFrEkVr7oNKxKeiaHSVL4h9GL49NQVAJpxLBiaEzPICNZKw6gz/Nsw5zS9KlA3MjHzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIchI3/KSJGz5EreAMubfxTN0D0u9MPKnT4zBh9oDiCBpG9Qh+
	l99uvEk5TfUg8n3DJrdCt2ePZABuyC/c5/OAd5yhqpzS5mKL3qPQ
X-Gm-Gg: ASbGnct2v+hafB/mITgal5zfHBwupvtxMlOwgHN2PhOXShcH7d+fEYZYfrRKG2Y8LB0
	9b0+ubngvbCHqA1So9i4TtVa4ddMR/rpkk01qmmGl7tWPendbUg+xXmzDf0kJTBBOmelATCAZiM
	N9SavCmyWKv4T6C7URoHyx4BJ+0T9kgNKjDlUyGwh/TkNwV3ZuoMg3onLOLGapXBn1QgISBtNnw
	N6a4obWANIThzZmZI/MKWGOAYVjsaL34f+0jq4Ldwd0r3hInz79b/GwORs3awxGMqs00S90mgQU
	ImXPuVjUT7D0Oz/lJx8u2zi0
X-Google-Smtp-Source: AGHT+IG1q7HGNZPT8DKly1ZJUqQ7kl1B2boZmwT8sZe5OX/BYvT62Tib01zooHzL3adQanG4Bv2URw==
X-Received: by 2002:a05:6820:1995:b0:5fc:a44c:b62a with SMTP id 006d021491bc7-5fca44cbd34mr2529986eaf.6.1739389489570;
        Wed, 12 Feb 2025 11:44:49 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc8a0cb99bsm2590915eaf.9.2025.02.12.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:44:48 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	tmgross@umich.edu,
	walmeida@microsoft.com
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] author field in module! macro should be a array
Date: Wed, 12 Feb 2025 16:44:30 -0300
Message-Id: <20250212194433.191882-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the module! macro, the author field has a string type. Once that the
modules can has more than one author, this is impossible in the current
scenary.

- Change the author field for accept a array string type and enable
  module creations with more than one author.

- In modules that use the author field, change its value to a string
  array.

- Change the check patch to find poorly formatted arrays in the macro
  module!

Guilherme Giacomo Simoes (3):
  rust: module: change author to be a array
  rust: macros: change author field to array
  checkpatch: throw error in malformed arrays

 drivers/block/rnull.rs           |  2 +-
 rust/kernel/net/phy.rs           |  4 +-
 rust/kernel/pci.rs               |  2 +-
 rust/macros/lib.rs               |  4 +-
 rust/macros/module.rs            |  8 ++--
 samples/rust/rust_driver_pci.rs  |  2 +-
 samples/rust/rust_minimal.rs     |  2 +-
 samples/rust/rust_misc_device.rs |  2 +-
 samples/rust/rust_print_main.rs  |  2 +-
 scripts/checkpatch.pl            | 68 ++++++++++++++++++++++++++++++++
 10 files changed, 83 insertions(+), 13 deletions(-)

-- 
2.34.1


