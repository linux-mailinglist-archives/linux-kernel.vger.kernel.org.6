Return-Path: <linux-kernel+bounces-511810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1FA3300A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9803B18898C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55420011F;
	Wed, 12 Feb 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3rbMiVP"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25401FCF62;
	Wed, 12 Feb 2025 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389654; cv=none; b=NZ8+TxymFxPTJVDZB16xVD2riKA8GtRiZBfdZntAKGDRZMDIMvn8xac8WqiJsk7L4Bf87zVq58ab/uMf8fkmr77Pfp4nxoe9CzH/KJJpG9lF7hELIwb0fWL8Pqy0q6+hi2AA2IZ9+D4QjG03ub0RISNCl/NGqxHpwkQvMv9y4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389654; c=relaxed/simple;
	bh=ywIzaOVXmImOoO4Gas/GMqK2ose5vqyNopDAxiufQoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hxTK9RuOKpQL+5M9Fys6QVD08vPWUFEkmFl2acvCFEzR2UP3X/u+3cbLupjbY4zCFASOR028rYgKeLaX/cC75QvpbwqqHa/rxNiBBGO0LWXZvGXaoIqd5WRParRuDh+VA+q4NzrcK7mCK5r3qRFbszbNQxXHG8KD3oJ2rCmubhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3rbMiVP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-726d1760f23so667574a34.1;
        Wed, 12 Feb 2025 11:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739389652; x=1739994452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPSeivS3uH0MhnhX3dDqt0ADzcQbXXGvaG4UAUIk9ZM=;
        b=O3rbMiVPgLOfSa2XjUbLK9wTeEd9pbycyN7RyiuIuj9e2zqxPGOXZffRVDHhRROchI
         +IcPp4ihwNCNfWM67Plyew0oxmgITKo5SFYDhB7XDND6Bx+oPI4xzjdLJIxvQEqN4G2W
         fEe2P+AGiTPEr8uBi58Krt6EoP22kDfnPGTeVTa2lXJyinWbuQbNbemskq/3uGG9c0V1
         I2eOp4DhAvtUviEzg5r5ojwO57du43CSilkzc2uMDSdpErvncoO5L0Iy8kamvmc88Yt1
         KqZrrrjFSDtliuN2ILNDShRJ0pSYVtLTUR/DHno1KUFmezhqTdt3//e3PxYJQo+imt54
         9rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389652; x=1739994452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPSeivS3uH0MhnhX3dDqt0ADzcQbXXGvaG4UAUIk9ZM=;
        b=GXQID6/VkitjZ2/U9r6c5200hKdkr4mmTIvaLuhbTOiHsUa7YXyq0h0NY/Kx6wbmPp
         UzLIGWZP4QlA1uke08SEW/LmQYKMJ58YoAQN6ZSs6VbuofIub/Ul6AamUGpsXCQyqOg5
         NNa3XWCIN/LJpfxPfrf/dikLG5NBMRRv/QMPqSBFBngivHtHl+j5OQpamggMNWtxSuFF
         /XzQenUqeYnmt7dW7aMhCYZPcmpgE0D1ViqNdKsRObcRUmV0fndVwijtWuIdSEiwUZfp
         pA3YYFy8EAe3yEa6p++e13DSqk/gFaHD/RgF6wIFRZr7yEu2Vn13jK7bg6odHjDgxCe3
         exCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69JLa/jYoK962OubIuiCm0RBaoGLcOsy6Sttx7YCACEAIp//5SieF5J+HVe771Pt/7mdo/YwitdZF9ItYz2E=@vger.kernel.org, AJvYcCXvu3Z8q/931XovOMFDNW+w+14wCfAZB2mwFRrnAy/oubR3jXH3oDvHFQgH8BIjfm0U4sw32i5jYhGtjSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+sg9r/1SGWx1czSXD6lqDzbj9fYGl5IVvBz/Plq0fqrGaXspj
	feX3EIbprSbdXdr9/P52lVq1fAGfOqN/k2qSeoK/G9V79qsE797/
X-Gm-Gg: ASbGncveV2eGl6RQJixd6xpuIn8kTNZefBHq+1gCnCGQed7EnAMKookgp3O5Zoi6DZT
	C3WcGJg9XAhZqXJw9AyelHhMmKhvrISizsnsPJFSjCaEL6OJYDfrFlCNEBteWh1uusXdWxqKIpN
	ZuSdaGf0DEA22wp8VggU6LmRuNwD1QnRAOIo+Y30nDEcz+zx/nv8r7DyJuE31aW5p8Q5sMOtX87
	NUdoqTkjkE+qPntiX2nFmTxiyoCodaPFIrMztZPWykppmeJy3gR/ozH0Ho8XR4vHflWi9fMtyEi
	6IOvb5wRGdB6mdKiQdQBsDao
X-Google-Smtp-Source: AGHT+IENtAK6jt1/iPLIYEahs5UvlFVx0krfmrRVdA1n3MtjeeXklN4Gym1dgBXkb1tvP8amQAG4Hw==
X-Received: by 2002:a05:6830:40ac:b0:726:d0d4:eda6 with SMTP id 46e09a7af769-726fee67bbemr146432a34.1.1739389652042;
        Wed, 12 Feb 2025 11:47:32 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726f151c732sm1433485a34.14.2025.02.12.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:47:31 -0800 (PST)
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
Date: Wed, 12 Feb 2025 16:47:14 -0300
Message-Id: <20250212194717.191979-1-trintaeoitogc@gmail.com>
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


