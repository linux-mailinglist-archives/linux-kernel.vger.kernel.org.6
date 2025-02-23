Return-Path: <linux-kernel+bounces-527856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19316A4108A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6041732A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5D155327;
	Sun, 23 Feb 2025 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIwpDSrA"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B3081727;
	Sun, 23 Feb 2025 17:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740332541; cv=none; b=tf+wYNrO7hdq8HiwHU/+tbeNoSLcjxSn00AKPKFFyPS75tgkmMjNPN1H5IfAQDjBoVsmafXhff9KY6vIXd56lKTyzeGVXw5w+CD2ct1tvN1/q6VmadUaE2u9/x++7NlRz8Y8q1S1LtM6VYop8Rrp3OyRCOlQdZ5scfW+jtXKjiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740332541; c=relaxed/simple;
	bh=zsa4ZuLua+wziSJDltxwr+yG+ZdNiVPrIwMJoYagzTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E3t6S1juFMU7jOe/24bcHOMCoHN6/H7yXL1tZAPFLfIcRVwFKDfUTVSMHkyJmtOVP+x2EiR17PO+4dCp0SWExlevBYUmN4lya62FWC8yiFswKwhAayvT9Bwdmejp0Vt8Iwjpz65pyZsKMGDA13kVKBqiSqvKYewgjA1SrwR7t6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIwpDSrA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc291f7ddbso5884094a91.1;
        Sun, 23 Feb 2025 09:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740332539; x=1740937339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJCgrtf2cXLyKtMVFGyaw6wBF2AT51fryY5mQvf8iIc=;
        b=dIwpDSrAGm/1Ce6UPw4mT0MmpuoZ5J4yS36Sh2YSKzi+NUeKKLidCVgUCq5W/c8h05
         kgFi/T0wD1XAAXRUNjVgERaCC26jTLm9FfTLxkX1WB0VDlWW4C5xGyBX/mpJjoxTGJA/
         ay+GF0j4pWhX8RjHDhP3ne5wQYQp2RsSBRiUF+CqABDyagJOXr5NIvPw0FtXUixj7P7D
         uiJAHdgZeTC/L2dMpetWsJ6H9tsLkrUXy+03Un5nkE6Mv6TEzGdRPVf/iIjF6AyTFlum
         h1bj9f0I5X0iX2cpySAE3qCwABQkP2GjM7nHQVEmLNFnNmd7vGMi0FeAcnzwBYnV46uo
         nKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740332539; x=1740937339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJCgrtf2cXLyKtMVFGyaw6wBF2AT51fryY5mQvf8iIc=;
        b=JUkrRWQl+wrTElepx1pyhXC0DeuFLzHhSMLlCb+/VEHd8ipsvOcoYGQxl9Zf34iD5b
         Yc04VEinoy6AWLFV/KRBTg5rFDa5zBbB3A4xYL4LxCd2YMtFjD+TGjZ6226x/DrlC3gX
         Z+C4SE6ODx9USStcKNmiX9F6Mnk0OlKcNVBC9kx8JNbu1wR67TH+sG4E9qjRZpX8XFFB
         WFhybTqlFqvmIPP5k7S5zfuZUWyQB1J4kv1pIqYvf6XdQAJw4kE2UOPrEaK110G4oEEo
         qvbZHTiVjzoLSoy3xm5QBNjhwyXL5yCFWHpA8W0c+hXQqLmcuHOH/BhBWPmqMFaYdK1p
         AmQw==
X-Forwarded-Encrypted: i=1; AJvYcCVPRNyi87vQnx4eqfXmrDQZjSm48MQrsPjeNLJsMRwp0Moxd7XT0iXDhwvcP1pQx70XTPRyqrdqxiKFwNQ=@vger.kernel.org, AJvYcCWk+E5/uw+LstLzw/GWVOckR+GcgY525DQR0xyrsBbTj3yvzHaUQEJ1jZpxd3omF0Idh/V5bRQDt8XqO1D+hcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHGrZdh3+LoK6KyoYLQ/6eWqSLea+ByDtXO/ZLTfl7qnGIvKP
	0SWk9o/4owvSpItyTmxpJECHeM3bnsQ8pSy3Gy74hca5V48hRtFY
X-Gm-Gg: ASbGncv3p1OM8rTiQgYO95wWGjp/w5T7GNfMMn0uUBI2kmKIzlSEqlOdrrBoI2ZBN6G
	VbUWY32/9PJ25l/4EUHjDgh0hoMteXHDhfJEp2z68FGuIP+nr5sL+B1K8wWRi5CT8z4jEyPwhLk
	e5lp4tXXLL5pp7g+tM7o3RNqgxMkVR9loyY8zdz5+7SzAr3uk/h3ZPUeI+L4alwbheLS1ov3yOW
	qA0GMqSygimiTTGUdTi2p4nNckEv6fOZC9ecqnc8BwYexqaM6l7V87BE8uh/cjwuUzxAwWrsIwT
	yFMIf7TvxuZmaZrvx5DIkzlkuQcOquowtg==
X-Google-Smtp-Source: AGHT+IHCrwsVqMYYNZR6T5cg2yqsviZMiy6i/YXuB5cpSQfZSKYPN2F8YALqYYyYNdCN+8a1Pts+og==
X-Received: by 2002:a05:6a20:2444:b0:1ee:d06c:cddc with SMTP id adf61e73a8af0-1eef3da4cf2mr22046686637.30.1740332539451;
        Sun, 23 Feb 2025 09:42:19 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5aa21bbfsm17433834a12.74.2025.02.23.09.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 09:42:19 -0800 (PST)
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
Subject: [PATCH V6 0/2] author field in module! macro should be a array
Date: Sun, 23 Feb 2025 14:42:03 -0300
Message-Id: <20250223174205.48404-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the module! macro, the author field is currently of type String.
Since modules can have multiple authors, this limitation prevents
specifying more than one.

- Change the author field to Option<Vec<String>> to allow creating
  modules with multiple authors.

- rename the field from author to authors to make it explicit that it
  can refer to multiple authors.

- In modules that use the author field, update its value to an array of
  strings, and also rename it from author to authors.

- Change the checkpatch.pl to find poorly formatted arrays in the macro
  module!

---
v6 changes
- Use consistent style in warn messages
- Improved the commit title for checkpatch changes
---

Guilherme Giacomo Simoes (2):
  rust: module: change author to an array
  checkpatch: check format of Vec<String> in modules

 drivers/block/rnull.rs               |  2 +-
 drivers/net/phy/ax88796b_rust.rs     |  2 +-
 drivers/net/phy/qt2025.rs            |  2 +-
 rust/kernel/net/phy.rs               |  4 +--
 rust/kernel/pci.rs                   |  2 +-
 rust/kernel/platform.rs              |  2 +-
 rust/macros/lib.rs                   |  6 ++--
 rust/macros/module.rs                | 12 ++++----
 samples/rust/rust_driver_faux.rs     |  2 +-
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_minimal.rs         |  2 +-
 samples/rust/rust_misc_device.rs     |  2 +-
 samples/rust/rust_print_main.rs      |  2 +-
 scripts/checkpatch.pl                | 43 ++++++++++++++++++++++++++++
 15 files changed, 66 insertions(+), 21 deletions(-)

-- 
2.34.1


