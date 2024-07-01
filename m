Return-Path: <linux-kernel+bounces-236131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7791DDD2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3879F1F2399E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64540143885;
	Mon,  1 Jul 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNRvU9RA"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A013D53D;
	Mon,  1 Jul 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833253; cv=none; b=cGKn9UyvOU+0RtNylzwO7XfcZb47JMrn9TEoibnWteRq4+LzY04GJoRVNvmia/9J3bGd4qwmiSivMoM828OfyxieFKVfII1tWadsawThmDhEVhzycBrfhTJr9xDlXdjZ48HvjCmBHG9dW6l4lk4FrheGHmZbaaVZ63cL2IfnmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833253; c=relaxed/simple;
	bh=MiE+t/Qy7mTvW/UJKwZYIqpcyNeA4NT5zBhuLcSvdtU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s3xDM3ngiyvAVJFuz88JcCV8N2AedrgkZFYw/yazj107+fRO1QxEwFGHjwwm81qYJEAvvaulvZhR2RKIHjHziQ5FB7Pv9db9FjXcaK/jP0Xe5eufi5wZdNNGsAsK8hZfHt+UcTOt+skP0c0US4fkLUPR+Bn51jIwNb6y28FapiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNRvU9RA; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f3d6785665so94286939f.1;
        Mon, 01 Jul 2024 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719833251; x=1720438051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N33ic0hVrQ47JNPqyZI6N613/A1ho/xocad/pxtq+J0=;
        b=aNRvU9RAMwhIm+74wK4rluPFXOZybkHxAL/8neHeeBe4+nBNIz66uPD/OPUOkN4cEE
         Qmmnvmwgfrco4FAZ5UsKtQ+pMdHX65lttLGmupe+21pSZzkuWhRVi32Q3MG3G7Z7325L
         wIbIhqIVihDqgHBFfKviMZC/ZCywysbSs1Hr7Hft5gTLy9M4QZ6nn7nz1eAlXOlv02uc
         HB/NSeWx/B+hwlgSg/qhMXFk+4Yww46KBKuPJPkF+LoVnDkTMFpMygCw4XxISdmGzvRh
         PQChbKzOK7fjUo87GF/4Ic00TR2OYQT6o50Rxkp4FV+sn3o5BIERfrNrKhcVUD+O4ZMs
         SzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719833251; x=1720438051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N33ic0hVrQ47JNPqyZI6N613/A1ho/xocad/pxtq+J0=;
        b=ivEDxACU2mL1YyikVmOilRxaVcBbcVN2TszQvEsah5ANSnKvZIlD46aKzUMlT0QkpF
         o5Y5JByf+odnVRuI3q0bU5t/OIWXf7AaV5zqlM/ZORd3a0xZUq2YQ+X9Vs2ZEQLaQQ9c
         Ztp40yiWA4y/qOPhVBAmYmA7rU5rslEiFAVAK4hqnPqK8WyoFx5fU/uYd5BOdCcw1BIP
         1RBr8CMVPvjXW+FFzN7IYRvRozzs5J6jCMXqDUFKZeQljNglmq73CQJSd/25s0SYDH+z
         q6S8p5dUsM6GeEaRoRI0LBwyyziVaf3Qtu+bJjV6UCYz6EV2/5yzcTMBZlLeQ9h+WNmm
         pYZw==
X-Forwarded-Encrypted: i=1; AJvYcCULewcX9uDBICKOWQimmuA+R9133hjv3OUu3eFhmcvjv9mSUhQQ9emiFhOqN8i1qdLVhEqcpBVky3BQ0YQ5oF9ttF0zrSr5LhQ+xgrIfrDH0AOXDAP7RbVuUFJTJ3s2olJy/nSIMP+gUCLfbM0=
X-Gm-Message-State: AOJu0Yz2j0/ZYpazklBN9l5K23IIToprQVAmbWoh9IusP3Obftyc0mtb
	nHuOBHRS8ORm7/EeDz7SZFF9AKK/WOF77wZj2goTfZcsI1cj3U2v
X-Google-Smtp-Source: AGHT+IGElsOEdy1buV/bEtFs7g4vLLosB7qQ/q9Xcw9NwcsuJ7Si/vEtp+iTGcjdsPf8hgiUzGYIaw==
X-Received: by 2002:a05:6602:2358:b0:7f6:369f:262c with SMTP id ca18e2360f4ac-7f6369f328bmr461928039f.10.1719833251388;
        Mon, 01 Jul 2024 04:27:31 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73e062e3sm2087317173.75.2024.07.01.04.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 04:27:30 -0700 (PDT)
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	"Ethan D. Twardy" <ethan.twardy@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Aswin Unnikrishnan <aswinunni01@gmail.com>,
	rust-for-linux@vger.kernel.org (open list:RUST),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 0/4] Enable rustdoc tests for the macros crate
Date: Mon,  1 Jul 2024 06:24:22 -0500
Message-ID: <20240701112448.28638-1-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1:
 - Resolve a duplicate kbuild rule identified by the test robot
 - Fix a number of formatting issues in the tests

Ethan D. Twardy (4):
  kbuild: rust: Expand rusttest target for macros
  rust: Enable test for macros::module
  rust: macros: Enable use from macro_rules!
  rust: macros: Enable the rest of the tests

 rust/Makefile        |  29 ++++++++--
 rust/macros/lib.rs   | 126 ++++++++++++++++++++++++++++++++-----------
 rust/macros/paste.rs |  15 ++++--
 3 files changed, 132 insertions(+), 38 deletions(-)


base-commit: a126eca844353360ebafa9088d22865cb8e022e3
-- 
2.44.2


