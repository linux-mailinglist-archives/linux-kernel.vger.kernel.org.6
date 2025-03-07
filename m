Return-Path: <linux-kernel+bounces-551491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB9A56D1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1181F16B3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D47221735;
	Fri,  7 Mar 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InapfVeh"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520282206A3;
	Fri,  7 Mar 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363635; cv=none; b=ch1NQ5LRgW/I6CxoPzDlFsZ1PClvZoboDEE9WJnq8qR2v4+A4hiB+BqNh3na9AdiAjQ20D9Hk2OETuBp/kFrturHRoBT623QL3SUmToUWIGOKrdkC5ixLFWeEl18uKk/SstGxkjsT1oh6Gd3JHlJ5K1utL8rkFvmTclo+3usIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363635; c=relaxed/simple;
	bh=CG7VNwPXH6vw/IoUKby12enXKta9xz3bSb8PLMnDXp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tPKhrkfc1H87xDMPAMzdYZ+2LijW/qbuzlB2x+gwuGZG9YzNDpNyfIMLaiE90PQE3y7OVE1pceM6CyFvLpNmC3rFT/97JoadBhsNfPeBmaSGFBmBxj5MgnwxI8G2qPfUbdjn0avszjsStftXl+KtgPRak8pu4PdTLmcZxjlDy2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InapfVeh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22409077c06so10265965ad.1;
        Fri, 07 Mar 2025 08:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363633; x=1741968433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ef4YA0CbSyNipF9WDRPCiwZEWBsAsJ0uP6GmQCxNhY=;
        b=InapfVeh89zdpG4dxKoG2DuDMKANeFvyIveyUR3iu7E1UhlWW8acmMcy2/aUoiphS4
         EtdHZclN0xHbm0W7HxZP1PRYIkfo0XKGrdJa+AReidrozYMHRAcxwxQGGXfJTjLeN0XC
         KRZnH3ItNrEM43Mr++oakAL+VbfAW2K056ZPbIdF3iVtNsXLEbnlBx1DbQ81sjto3KU/
         qyNPlItAVYAjH/US4NxyJtBuooJEDvJJnahvZTtencElk5UTaZECxC5/xDMpV435eXnk
         2oXufwLOuvbit0LiXWF/Y8f0TaO/RQI/YS8wbh+u7VTffgNxQkwqOroOeqDc+sf5OiA5
         f5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363633; x=1741968433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ef4YA0CbSyNipF9WDRPCiwZEWBsAsJ0uP6GmQCxNhY=;
        b=aHw5mnrJWRvU9TSL9PnLQTs8aj8n27IqFU4Ocnu45FPLGJc3SJxW8WFhKwOmVJCVeV
         JAM/ysXNVptETChvLOAjTEMRXC/Emp2N2kb/j2t/y6y+8cw3iu1HHliVUkVv2GMmUycA
         haY+zdEwoBKeuyD73DddF0DjpYr4cxG9gOsT9fQbSVOKE1cfHSXV0xcZbmOrcZhkj5kE
         iEqwtPP6lnynqKhtTeBB7vdAYiTzgFZ5wwRhLjZX1UG3Qxw9NdSpRJBpwTjVDxUpqEEF
         8lfgTEOCaOkNfGdNcLa20hBxp8yNevgDLsjsESnJEIPjVQDx+pEckozCImA/M2mPsBMl
         9FLg==
X-Forwarded-Encrypted: i=1; AJvYcCUmLQ3HIMi+BmOvJ8A40abiXT/eF4rT55NxsrUKypHhE020A3Mi8KDnXZMlYbLkB0DuZUXQDpsIoJP1hBQ=@vger.kernel.org, AJvYcCXmY5NtDSXz6IYwc2YWbobCKrJo5VwvP32CaikAh1IKtzA67PebR9tFXzlC8mvjBiodFgJr9SpTouuzR0u1V14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/tQHBrz7f3qYa3UUr6jbiNLQXS5AI7QAxsOVAYqySkq5jCnOP
	OEqDuL+prSkp0fLvSdT+DodBnO8QgBrtGncwa65ZfoAwxbte3Y9T
X-Gm-Gg: ASbGncskLCjaobH1I21reRW1E3aSKgKJ6uscIDIf/VgjMuCzDxfVwYf9zQkKSw2mlCh
	X2CmFbFaGu+ODi5KEDTw4c+jL3tLTIe0Gje9iuity8OTMMIOuBD9PDwFhXPoxwfXl3ik7nKRz4G
	cuZfF5oum12DYkV4GH6pDH5tvxvGABG/GRt5Ys/VS8H5YKnkNJ7wWorGB31y1lFMkuC8sTbfRRJ
	3QhZVSAouVZ0bVVQ8occ0/254JgB2MgrWf5tCXTy5aHEhD0KQA+V8CFENXGnzK62R9eDmByK19F
	h0pfvvSdbprOT6gCVebkUaYcnaf/HpIpzaWmpC0q5z4IqoVcAnbY
X-Google-Smtp-Source: AGHT+IENvXvtKSPklFI+xpq0XPUAvwXNSJk+G8S2EZzpZDidRNewFuasadRUGUlKqKAqq3W8X7lcBA==
X-Received: by 2002:a17:902:e74c:b0:223:5c33:56b4 with SMTP id d9443c01a7336-224288975admr51239245ad.20.1741363632954;
        Fri, 07 Mar 2025 08:07:12 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698514f58sm3508421b3a.133.2025.03.07.08.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:07:12 -0800 (PST)
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
	walmeida@microsoft.com,
	charmitro@posteo.net
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V8 0/2] author field in module! macro should be a array
Date: Fri,  7 Mar 2025 13:06:55 -0300
Message-Id: <20250307160657.641014-1-trintaeoitogc@gmail.com>
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
V8 changes
- Add Reviewed-by tags in first commit (1/2)
---

Guilherme Giacomo Simoes (2):
  rust: module: change author to an array
  checkpatch: check format of Vec<String> in modules

 drivers/block/rnull.rs               |  2 +-
 drivers/net/phy/ax88796b_rust.rs     |  2 +-
 drivers/net/phy/qt2025.rs            |  2 +-
 rust/kernel/net/phy.rs               |  4 +-
 rust/kernel/pci.rs                   |  2 +-
 rust/kernel/platform.rs              |  2 +-
 rust/macros/lib.rs                   |  6 +--
 rust/macros/module.rs                | 12 ++---
 samples/rust/rust_driver_faux.rs     |  2 +-
 samples/rust/rust_driver_pci.rs      |  2 +-
 samples/rust/rust_driver_platform.rs |  2 +-
 samples/rust/rust_minimal.rs         |  2 +-
 samples/rust/rust_misc_device.rs     |  2 +-
 samples/rust/rust_print_main.rs      |  2 +-
 scripts/checkpatch.pl                | 67 ++++++++++++++++++++++++++++
 15 files changed, 90 insertions(+), 21 deletions(-)

-- 
2.34.1


