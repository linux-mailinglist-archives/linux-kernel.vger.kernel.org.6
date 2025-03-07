Return-Path: <linux-kernel+bounces-551139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A0A56898
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D617A26E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ED8219E99;
	Fri,  7 Mar 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1+7x8xp"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957D12185B4;
	Fri,  7 Mar 2025 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353262; cv=none; b=MXSqtz3tZrbxBmBwXZdLk8elndnOalTZfScaZlayFBFAtowtWE8JyD4r6Kj8PbD1Oh7nOo/wpmmPQuVbUCSmt20iKJpUlgNUFdJDY0AqHtQw+6n3HxhZIZMxaNfafACt3kT8QPSauMI1PsSYd+SF9hTHwetMvHhhPMVjOHHWbHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353262; c=relaxed/simple;
	bh=HVQpQD7mRalUwlfUljUFNbq0Wfu1Q0G9cSUuBltua1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bs7Zf5TNMLGwv3fEdf2aOsiEhVeMCUjH8RT6OMyxarFOO2pLj1LmaCvY4eJygHr+AzlwHP1Bdwxthg6WJBkaZCkQ3ogxOjAu0rMgGsu1DrlQfUbdp+FRGgD3nh6Tl4oDpSI+hoNXakQxnPfWVX7bHNth7P7wDfcuB77VHE09Q7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1+7x8xp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff04f36fd2so3269181a91.1;
        Fri, 07 Mar 2025 05:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741353260; x=1741958060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qI1/fQe9Cksv1NwjSQmSqAPnCNeVSEDaeiSFIVAD0ZU=;
        b=P1+7x8xpMBI0XNYfk5IQau+pRatOiTtrzxicfI9aqlMCGf0Dt4555Gbmc3xcAJPZpt
         CJyTppUvjF+IV4Rm93hWz/797SdI8F9iwnHvhk4K3xfIKr2Ymwi8nLauSW6zVoWQJhO4
         WKZOlGvnE4RPB5HHfUD0GF4FRyjcXCWtZATeEn5FdTJw83uzwk9xImQDRL2MnuKx8OhH
         H5w2fuVVQKksTQNGu7al5Y+5FItkrUBlVMdKtqCJLCkJIdRngBrMBcwLRU+xAf/dtsrg
         aTJa6ha/DSWX0aPzesBUR3oTF7X3J42PqylHTZJOz+/8WCwno0VmbObWvvEJi3EyXBGY
         r8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353260; x=1741958060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI1/fQe9Cksv1NwjSQmSqAPnCNeVSEDaeiSFIVAD0ZU=;
        b=SOlFf5XSIgWtsU1hYiTZ+UKxS2DyS6zm9kW5MvhDtqSzTBS6hWrF+ZIXa6s+N6tI2u
         i5Eir23/ci/Njb6iQp6LJ/bRlOymofRi+uWm1S3vPdBrPoc2qceqK/ynez3TNvcob50h
         PNnDrPhVTocENreB5xbavYBJOH1RyqdDa9L2Yml8Egrph9WkdtCM0Zvtzt79Ht7DVWjD
         0wkztu6OUCrPcwBn08VwAzXlnwZu/D7wVIAK0cM9uxvscgk/O2dYKTpxskIvXE6UObK6
         bovnnpUkx7qmce3RIXaumWtFtrTLNMiQpeBWVNpPlkbiByVPgnPQJsp069rApEpYv6+C
         CY/g==
X-Forwarded-Encrypted: i=1; AJvYcCX6YGouH7WphIcLUY+Yp25ZdT9V+cz4H6MQdrtv/8RvA154x8uoKtP9WDiGP15tJsiOwDVGwz391QpfrRY=@vger.kernel.org, AJvYcCX9svSebNv/0uK6hV+Yv1aO4pwRtkOqWCMHf5dFyAw0jUsMAxptoJepoXNzIKUqn3hrjy1zldUKYVxgkCtsl9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB0DXy/wTHWGjI32I546AYRwndWMmyYMG7N66MaZAPb+MhOKDy
	760yS6Rld3bUt0TVME2948Mo4iViWbMleVhBcCwoIqqmBXwQPsV1
X-Gm-Gg: ASbGncstu0emNfivrGSd+oF79EvkMOuiI0FsX370nAlNKKS+DUW6flYSko165kKDHOx
	0KbgqUYhJi7a8L2t8bHmwH7SJc0TVPFU+RJQ37g297f2w8skvKgPhtJan3VfcVeOVmJtAhv7ZDq
	toBO50TNiaZp8o++yqR4ZM8tYiv8NuIwvn11soNGn0jmI9kB7/Tdcah7kBwVi7VkDeYPx65Zb0C
	dJiKkZla7A2b2ItTtR7wHEWz/n5wJXbt00wUk0G8h4nFLax1ccrWO2mXHfCkI2Kb2cWByVPvQ3x
	sXoEA144ZkR96Rnf7Nw7YHAtwjxTO3VMYsdq4Ww+Z2y3DO/CGIPS
X-Google-Smtp-Source: AGHT+IHl1PlmnZhr7l8HvQERQ2NSfb8Vk1Fc+YfHkH7F6ARMT3yyLXYIzUllT4RPzzmmphfNIOzDbw==
X-Received: by 2002:a17:90b:1d8e:b0:2ee:f19b:86e5 with SMTP id 98e67ed59e1d1-2ff7ce6fd4amr6105166a91.14.1741353259519;
        Fri, 07 Mar 2025 05:14:19 -0800 (PST)
Received: from linuxsimoes.. ([187.120.156.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693e7358sm2965708a91.30.2025.03.07.05.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:14:19 -0800 (PST)
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
Subject: [PATCH V7 0/2] author field in module! macro should be a array
Date: Fri,  7 Mar 2025 10:13:59 -0300
Message-Id: <20250307131401.638820-1-trintaeoitogc@gmail.com>
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
V7 changes
- Add in checkpatch a check for vertical arrays not align
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


