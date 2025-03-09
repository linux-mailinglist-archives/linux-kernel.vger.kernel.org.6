Return-Path: <linux-kernel+bounces-553264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B310A58691
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578DC167011
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D255A1EF384;
	Sun,  9 Mar 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW4wc6BL"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF21EEE0;
	Sun,  9 Mar 2025 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543048; cv=none; b=StFF7095cRrhulXJ2Kx61NTM4LGXuy7rKGeKlnXcF5evk2jtxNjB1R9SGHSvYZTmsWvU1wHdQ4V3ALD1F7F2zBNuXbez7Mu15SM2K++oTVRzLtdXCC0Bnm/zrlLk9Qeco8I9onJTrZCu8ChuH4wR55QFxQQ9zHQpvL7F/5nyWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543048; c=relaxed/simple;
	bh=P6RYCX5vDxQaVyNclccQmSzPHLOErBFGlbABG10FJ94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+7T1b/GS4Awc6MDWSOD+Jf5E+hyU6H2q6mngqhWirty9zkdsR+vPAZM5DdrDAclvk9J6W0p/u0dMHkXJMFBC0TVrxxn3/OWBt2jLdfuC6sEb9GmwVf3RZ7G/ROhel5OJwAD5IoBmu824Q/tRfDJv0Cd9dBFCOcCj2acEGM2QZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW4wc6BL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22113560c57so63753705ad.2;
        Sun, 09 Mar 2025 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741543045; x=1742147845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ws0MKDUBHCsCNPohrAs17OMDxN3A3VdvFRaXSo6ysoo=;
        b=ZW4wc6BLaJLfa0V/3wHYt2sqkvdaqvZND43k3OA+vOH1u2Qw0/pKiaAnUiqOQKVjF2
         g7PgTP50N00FS3tA/dZ8egBe5gresJyC2qAsPgbmp0mlKas3WYEOi7vmg2i+nIQZVPce
         HwXYs0ElaHpmiR755ZRWoKK49/14sD3LA5umYn36UTb708PrL0xkHcdB4RFxNmMEtkuw
         H99WsN+0UbRmbYZTJuFijnFRIPJ0ss0vW8OllFTc/yAvTuW9KEIly94g/Uv7ucPpf3fE
         LTiGfzOWggd6CQ4gGThz85h0d1w+SderuTSSKrCK2Gvfpmnqaj13eOq46woTKPwX83Do
         pjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741543045; x=1742147845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ws0MKDUBHCsCNPohrAs17OMDxN3A3VdvFRaXSo6ysoo=;
        b=HboGclf1oEqcaD0ocpkv/tj/91oJ87IMbcoRk7AEqtdCK264q2b4/cDxR0qdt+UdKZ
         +AMr5NtLtuRmuDxC8g1vzD83QwO/sVhtH1BCoS3vt9uEH5h+nmmIlGyigYdA8VuoaU2t
         1y56A8CbP7k7EbcDzpyVgcCGYNOsmRnCtBhKNqdMsY0o4sPX10RSJQCi3XZpKb9mou2e
         lPYoudV/pyHM/bsZATZIJzeWCNsa6FSWlOd7Q61vWnKbCdSMKQ/8dpSIoSTo2mBUf8Jx
         0hUvMVrqDwGEp3ZXAJEuhbLjVO2AVp32YifJllcQdmD7LcRpqebXEXekBuppnEUdvPyu
         u+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVtw8qSTvCmH7BIbUlQZXo3xSpoFqsCb1tBnHDaBIoWSMA0IB7fC4+GTox6qakKw68Bb6QdH2b19VWuhkg=@vger.kernel.org, AJvYcCWiKU1Dzb1PbjcsfNFBOxOsSW00kIbZuJ/7In8VFSvrt9ml/YFEm4lr1o2rJb05m/3ooZJJ9dn+Iec7JtjJfZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygS1a4S8HeSp7NvMZ8A0fS4ylljDTOD+mMvN32F9Dq7xZM72Qk
	/IwnYcOInU8CfTI4fP0LwQ5q6bWatOJzWTAwUl3XLvaXd/lrJ7vv
X-Gm-Gg: ASbGnct0HwaXjOb7BFqVdMDpxLMV0V+63lVUrP00Lh85p94OwX7UfjUdgiqNJTlWh3z
	uHjQRUn2Qot2MD/YAV0DEgeUj8Pj9FLD94GZW2nOWuRKnBosWFMQy1LOcr63DcKya1YlVaxfbwn
	SsvKffH9f0ATY8FPOYHcU4P3aR8I/sE6D0p9kZo6uRtoBlDj2v0+2jYswnV6LIBWMdgSZZ6NiCW
	2x8YyKDIRZMWtPLyX6mZI5D0ceuC4+Ts4A8QsCofOBldlMwfyaluJazMqKcREjTrUrEYckyPWxT
	hZtmldlsyxjBQA+MpjRkluofvxvVL6FSh53VuYpkfzsMlpNhEDLf
X-Google-Smtp-Source: AGHT+IEhJkRYc3xY2G1Ox4pZ+l4SKeXyWOd7DpqhERFIMPHQ1OecGIzx6z4YA+lmvOLI2Hw8WQ0NyA==
X-Received: by 2002:a17:902:eb81:b0:224:1935:d9a3 with SMTP id d9443c01a7336-2242888ab01mr191144485ad.21.1741543045434;
        Sun, 09 Mar 2025 10:57:25 -0700 (PDT)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e944csm62675505ad.74.2025.03.09.10.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:57:25 -0700 (PDT)
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
Subject: [PATCH V9 0/2] author field in module! macro should be a array
Date: Sun,  9 Mar 2025 14:57:10 -0300
Message-Id: <20250309175712.845622-1-trintaeoitogc@gmail.com>
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
v9 changes
- Improved english grammar.
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


