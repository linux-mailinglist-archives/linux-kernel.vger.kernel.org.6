Return-Path: <linux-kernel+bounces-527529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32DAA40C5B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 01:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B512617E929
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 00:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E079F5;
	Sun, 23 Feb 2025 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZutFYdX"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179801FDA;
	Sun, 23 Feb 2025 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740270094; cv=none; b=tmVaTae9mnftGyN6c6kuGorA8Nfy+w5wKAQ08KRoQyhlfzIXmCXxFEc/eTdH/Pg24aK9OKVQPPJ6Mg4rEBZFabohDqD6QrFJPWSYANN1cPdkJCb7M9kVEKBmSca+XyLVworVRNOZW5MxDPtbjvD/i3M4lnQsjTyPA3aBa8jRTvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740270094; c=relaxed/simple;
	bh=qXDP4z+YXZarlhQNDz+K5EWrva2ygdE7q13wjHm/52c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tFeG0S5TQ8+O7D4PryhxVIq7wTTLRJapwkYVs2ea1tDNnZgXNB5ZuuByOYtzEAG3MiW8DJpwS9JZy302PZQM5UmcFGW1RD189/hgVLrgeGgXCxrbWxZO+znH6TreJGtVIiV8r9NQiOaeKMWYTQzXl6L2XNyGxTdF1TYYQR3dkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZutFYdX; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so5210767a91.2;
        Sat, 22 Feb 2025 16:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740270091; x=1740874891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aqnNaAp+3AnF2qthnAdpA6w8nt5cQONy6efQ/9Ewv7s=;
        b=YZutFYdXJHowZ2z1Tk6Tlf1dCD2zpY28a5/+3JnbpiziisWudJpiskKW/nNqM+82vf
         gK7w0Tf1slpimH8LpFa4c4DzHpksG5k4vIfeUziCMFL3/q2lmk0F5oe2KDfs3X24hCXL
         e7UQpIpIFKrBm9VDW44cpNl81JfBjSbgEQYAp2KgyVJnj8ZLvMUzZ91dJ9fs40marV4X
         jLJLGHXQ80Z8Nhyod1pbDh8tcHSwrKoMUbtwzCEskqvtzoNgbzk40BcrG3+cPUm7FZ/y
         TkoH3bXHIyHCjFO4PK3BCpJoEnlByIOTcmascVBODqfY10jsrtaccgtyp6g+Ug2lbmiq
         oi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740270091; x=1740874891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqnNaAp+3AnF2qthnAdpA6w8nt5cQONy6efQ/9Ewv7s=;
        b=io5iBduYWNAtXdpxKlEE6rFARCrr0cp8dMv9MYg/EQUGNacjgyLDf4+j5NHHste7rp
         E8gzGFkWeU5YYMPtB1TK30NZMiYm18y06HWNW7cgz3Db2EuMwD+AN92cTk7pwCBSB92l
         weO/3WgZ8nYt5U+KeytDuOWnhE8pscstSKZeyv9u6xRjOMR1DdsQ815m1qgRrUKBD+9V
         nwBZ1mE3zAgcln65nlIbMwpabYXO2yib7g//NWwiMuWK5CB+MYaGN8ao8i3T0OUZeAIV
         HL1sW2BUNwX2sfqlvNYkz/UEYQBTAR5TeQVTJC5mJl7iHzf8qcZCLwgeJ9WIiShJIU4i
         6f5A==
X-Forwarded-Encrypted: i=1; AJvYcCX3B+a3X8I1aO4XAxgRfO0IP6VMVALIsWhLE8x7ucThJf3+wo+dszMNvPcnEAxZdRMAZWgzXMW/czgw1B4=@vger.kernel.org, AJvYcCXKFYZHeluIpCkWz/pp/HTzHVIfiWHlMWJK0TpZFJveIXj1CALoOIgzNMAANCZO9H4vYRAn3Dn4FZKvT/MVoHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWVgurmEDW9rF0Gtdq5pKfb75pwnifon8f3tpEcWW3Sx9Pgpf
	2ImTRKAQw52pq8glNXcC89QHcrgrQSBw1KJh6kf95/iVgyGj9GcS
X-Gm-Gg: ASbGncshAtLc1yvMwGhvhH6IHgYxHGC42Qbeg56/Ab8iN0l6qBprM0zkyxgblV7ITuA
	4/SmZYkHPsd8ieADky2WbcmlPxvJvmwuLbEg8y9Xr2C1B6TuQFUCodE+wJoHN4tPpkAjXtAgS5Z
	ZpLN97OFJ5LLB2I2JdXRcPjWHQbeVJecDQzP1O0DaqK2Mx184qG6ZE22L+Up+2cVsbB5u0044mh
	bp1PLETzPhOoPo7UJxu7OzLak9ASDCri4JKdfHL6D1iJAr6s+wMNL77s3Xtbg2rUXoreIjGTHLg
	NTDDNSFPB1r2cAJTo/qrT3r9UAV1DCN3mw==
X-Google-Smtp-Source: AGHT+IHN+Q/3MrUr2jmZHqDsnnPT1QFsGmw9EumhfARnSLma2I/BCeRwbgOEQit74sPlLpTUEvL8Kg==
X-Received: by 2002:a05:6a20:8416:b0:1ee:e58d:aa67 with SMTP id adf61e73a8af0-1eef3c48ff1mr16539046637.8.1740270091071;
        Sat, 22 Feb 2025 16:21:31 -0800 (PST)
Received: from linuxsimoes.. ([177.21.141.136])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add2e0ad0dfsm14248587a12.78.2025.02.22.16.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 16:21:30 -0800 (PST)
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
Subject: [PATCH V5 0/2] author field in module! macro should be a array
Date: Sat, 22 Feb 2025 21:21:17 -0300
Message-Id: <20250223002119.2432-1-trintaeoitogc@gmail.com>
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
V5 changes

- Improved the checkpatch commit
- Improved the comment in checkpatch
- Removed uneccessary "\s*.*" in regex
- Aligned the WARN message
---

Guilherme Giacomo Simoes (2):
  rust: module: change author to an array
  checkpatch: throw error for malformed arrays

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


