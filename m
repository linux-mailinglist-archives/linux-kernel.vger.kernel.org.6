Return-Path: <linux-kernel+bounces-524201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D9DA3E081
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AAA702B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A520E032;
	Thu, 20 Feb 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aj9r+giO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3F1FF5FE;
	Thu, 20 Feb 2025 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068405; cv=none; b=H6NVhFJHeA91l3tGa+na4DVgg23/UtUA25hQAIIY0Sts3rLQtcOSn203qwPkctyQGB3YlkbPpTsIIPLzHTVUIMwKoQOiUpADJS+bGpxXvwGnhMxRBXoz2JIVF0HFOLwjZardheOfrOmaIjxc9FwH9T0Vn6NXSz1ka4qqX1oG33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068405; c=relaxed/simple;
	bh=JTx/DivSX26tTibgAJFvQhL7qIqzPuH+ImHcd7gNfjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ez+VqJsFyS7oPBWcDnB0hQqQPvWW2ZBIw5Ht1tZESXFzIR7zdkiAymZO8Vqi1BvHYUyUjXDv05TfNKOaHuBUewAyhTrQv+NN3dtIFGuwyBnIr8f47Ru6Rmg49SxthYzGeUOQxWuWc+/fjc0h6ulGVaXuFw0sWbObgs8bT6usjnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aj9r+giO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2210d92292eso32406925ad.1;
        Thu, 20 Feb 2025 08:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740068403; x=1740673203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6MKYjKIt6NeyvlVec3PO0rK9zJCfJF3a0DPT/uo2+w=;
        b=aj9r+giOGSNKJ3mzOStk7rMOARvT2LXYfHhcefvqidb3vpoK6bdokSfTr4kZt+o11u
         1mvlcha9JPmISeE7tBbu+IHAAsEUYyjQ+agDVIQZtzi8AJXrmYfR1s/OqNQALkQkMnqo
         Imueh8Ww9j3tNhp6s7MNeySmhJ0PsJiovHxLvlYYoTbjUQk5DqEAYt87rflIUNlc6ORv
         Gxs+L/2j3OSAxe4ZNZy+6/gglSdq0qnscnTxEJSLyKzKG2t+GHP+4Ojf96w1R5maiUox
         fqEg8aH3QnWE/5+FdRpz2h1Y6unnXCkqWYcxeIL2+oXNja8SvHtMUnNvrx7LaKejHnwK
         UwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068403; x=1740673203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6MKYjKIt6NeyvlVec3PO0rK9zJCfJF3a0DPT/uo2+w=;
        b=RhPwlc71RGGQmHLl64XwDnY1BL+xHJw0y/0eShqxdZ7feMeTsViWnUOs4szwISBbfl
         5BsgxX9S18rKaaposEHlS2ZOjkCyd3NuNSe+VK7Fx1zqvvRbKS/626u1LdKGolK51AC8
         iZXFjLpO+zga8TTLm+OjtZJ7TfM229bZEDCIz9MPKHpzCSyShGaaLZluIMgrcxGhMqDP
         /mVBfpZ/FyC4LvBM9cMUfBXvz9dROiM2Der+I7mQHimCfzPQcpA4kOsvw6tFgnojIK8J
         q6qAnIxhwbEzi8hg+1EvmiPeTQ/el50cT87ailV4OMD20+tn9dQCHl7cIyU4yLOVQaBo
         kkew==
X-Forwarded-Encrypted: i=1; AJvYcCWEuKVKhz7wZxoIK18bm4ZauY7le7EpgqHJqoIOp7XGYnt5UBYeIc6aecUBKZs6VTLrsDUwRIe7s2DNg0s=@vger.kernel.org, AJvYcCXWFvIWT4TUKwEtU1C6vYcjpl8oQ729+LesL/SkKiROzBSRMblAMvJT8b70lAwOGPBFuURO+KXnTnkL33TfoF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2ziZjmW6CdNRWd61h6yWjOCK1pqPx5d1abCaYM7SX3wm8GR/
	ufYq3fen1gvxzlBT2sL2jqIlHYY5z1jzjjduOpgjuQaJOu9slIkX
X-Gm-Gg: ASbGnctpJgyXr8WRYIi4LRD9AfPCkk6p2ebDFOyNjFsxeUnQng+Mh4Lw/fZhnI7zH+H
	VoiDsahU+Vl0YC8WmsEBqsZoFVjqThJyKLhRHIr4TaMN7Hzcxq7e0vC46nOSSsa+dDeDKPVy98L
	gBKoPvhQEO2d1nyQYSBrhIUEMSR+5WueqY+Pw2ZfzUB1VxNFguYKVTOFBaQ4pEjxwiAcba6U60d
	Gc60ggIOgm8ViH1WOHdj042bLdJuwjZTIIgOCs7PemLm77+917WUaBv2hvVsINgr139FgXEHply
	9lEjU3UjwFSdynHwKdICk3k=
X-Google-Smtp-Source: AGHT+IE7MbYH5ETLR/2hPUtk/sU+CWVfQzb+DFjnspOOiMHyuCK9fpqPk01ZvLszAiyRvUSLp50FHQ==
X-Received: by 2002:a17:902:f689:b0:220:bd01:6507 with SMTP id d9443c01a7336-22170988a48mr126888115ad.25.1740068402760;
        Thu, 20 Feb 2025 08:20:02 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a540aasm120910545ad.245.2025.02.20.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:20:02 -0800 (PST)
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
Subject: [PATCH V3 0/2] author field in module! macro should be a array
Date: Thu, 20 Feb 2025 13:19:49 -0300
Message-Id: <20250220161951.844367-1-trintaeoitogc@gmail.com>
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
V3 changes 

- Improved commit messages
- Changed field name from author to authors
- Included the forgeted samples/rust/rust_driver_platform.rs in 1/2
- Change the documentation in rnull.rs
- Fixing the WARNING messages in checkpatch
- Fixing align messages in checkpatch
- Removed unneccessary \n in $herevet in checkpatch
--- 

Guilherme Giacomo Simoes (2):
  rust: module: change author to an array
  checkpatch: throw error for malformed arrays

 drivers/block/rnull.rs               |  2 +-
 rust/kernel/net/phy.rs               |  4 +--
 rust/kernel/pci.rs                   |  2 +-
 rust/macros/lib.rs                   |  6 ++--
 rust/macros/module.rs                | 12 ++++----
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_minimal.rs         |  2 +-
 samples/rust/rust_misc_device.rs     |  2 +-
 samples/rust/rust_print_main.rs      |  2 +-
 scripts/checkpatch.pl                | 43 ++++++++++++++++++++++++++++
 11 files changed, 62 insertions(+), 17 deletions(-)

-- 
2.34.1


