Return-Path: <linux-kernel+bounces-241280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7C927959
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2604B217A3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65671B11F4;
	Thu,  4 Jul 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjHiE/rX"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B21B0100;
	Thu,  4 Jul 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105031; cv=none; b=SZ/8+dLQyfxgaa+6pi2j/FV8o+c/bsDO5p62E4rM85vwsHrhPbAAZF2v7dUqC03isF3kyehdZw3IsIc8I9Fn5xxgfBXwDLiwjFKXL2cHl5AWwW8/vXp+hQSeKBwjWy0GmkuQ9S5aPsGABAvhM0EgUzdpnVFMLc2h/S0m/KfbkpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105031; c=relaxed/simple;
	bh=tiKmYbVEapMWXYRuMussgaIK8Zt/n5sQcjSr1monSiQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NROTgx82lq6jG4weWuBJ05zI3BoVZCM/U6RTJUwUA09nJhHWcl8Hxi9ip3aM1Tm0eVHNcGAWfiy/7AU71Cm6vxfxpH9s5BBc3q0Dpx0Ta78BswCISmKDfJpLuymSZiSaphknV8gpzV/uWpFN8Qb8XQxVP7mZAAqiobN9wwLz8co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjHiE/rX; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f3d3919a4aso25748739f.1;
        Thu, 04 Jul 2024 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720105029; x=1720709829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYFNUlJTdZ41JGzgUFxy8QCKv8XVQ/61bzVP+agFjnc=;
        b=FjHiE/rXx5JjT3f+1qGrjcGrWB0J9y1kPJQsTwvS6jENyv/G5DQQ3VysjnrF6xkkAi
         91HhFjC01La2Es7eiaUB3EBFyugeVie2RkWMOYlV3ILSLNf7itv0KlupSEGB+6RQeSJG
         W3BXcdZSxutgfW3qE/bQm7elRCc5jbwZyQX5qSoqWwoVwdlLD/TFDtWY47WRJa4WxxNb
         wpktKfGkfhudaV/dYrmZ3VkAI8THErfHdiTG/j8AB1muj4afrdXxyTIylzJ0Zv/zRIfk
         MEn0QxoCqQkeKxUOLEFqnYL1Ryp/zjeMaRO1G8lcLOEIwQDtTQpVeA6WUggsUG5hChWm
         N6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105029; x=1720709829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYFNUlJTdZ41JGzgUFxy8QCKv8XVQ/61bzVP+agFjnc=;
        b=u0UsuCoUyM6U2jKZswkRj9yyzDDVgF4JeJDe1StonvYO+CAuRS5NTi4omVMFcoFy0D
         we7cJOLbtr+iyda6zZeeR/38jApnhDzvCARYepQuATqXsVvsFljLjvLGsJpJn0MVb85/
         CnNsoLeiqiULRy+DYKOUhMDNIwu4Uu5dugw/uaakw+C/TfXEQtE096W5BIWB0HugHp4p
         8oH7EVRj/xhGpgtWA7vsYY++2J4tIlaoeYvzEz6n7wmaTa+MCODKb39JT0VNjjyoLfZT
         wq6TK/izhX6TSAZC/phhOa8r3OOvvwGnxBM9nr2Pa6Oc8/v1u7zvpDYUmXbngVqhvVYX
         uiGA==
X-Forwarded-Encrypted: i=1; AJvYcCVOweLwHVgJCdhvoOtqzpngnlRrUfBwVPjgw0Km8/+Hlk+5y/KkPp7cJqqF84Y9kZPXBq6/WaEArRue0ygd+ZUzCmXtVN841vwHwVS6IL8V5zLRmksWT1kUjh1PkaLLG67F/VBwc4M3v33lvfQ=
X-Gm-Message-State: AOJu0Yz7qdBYJqaI5/IziXtEPA3pa/deb8Jspb6RdJ26rn0F2hlEIohj
	D2taJBsVdpI/Pr9GWUHR/d0h3KgZVf9TayeCOiYR6MfIXHJr//4w
X-Google-Smtp-Source: AGHT+IEW89rIS3OBXu5yS17WxVaK6fjs4f+dhJL7j8Cwu+fj5HSDOBUv2El+GLpT94t+mkuFKJIS1g==
X-Received: by 2002:a5e:990b:0:b0:7ea:fc3a:fff6 with SMTP id ca18e2360f4ac-7f66deaff74mr228299739f.6.1720105028751;
        Thu, 04 Jul 2024 07:57:08 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb388asm3940867173.5.2024.07.04.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:57:08 -0700 (PDT)
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
Subject: [PATCH v3 0/4] Enable rustdoc tests for the macros crate
Date: Thu,  4 Jul 2024 09:55:41 -0500
Message-ID: <20240704145607.17732-1-ethan.twardy@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses GitHub issue Rust-For-Linux/linux#1076 by
enabling the rustdoc tests for the macros crate and updating kbuild to
compile these tests with appropriate dependencies respected. Reviewers:
Please pay particular attention to the Kbuild changes in rust/Makefile.
I appreciate your time in reviewing this series!

Changes from v2:
 - Remove one more noisy empty line in the macros doctest

Changes from v1:
 - Resolve a duplicate kbuild rule identified by the test robot
 - Fix a number of formatting issues in the tests

Ethan D. Twardy (4):
  kbuild: rust: Expand rusttest target for macros
  rust: Enable test for macros::module
  rust: macros: Enable use from macro_rules!
  rust: macros: Enable the rest of the tests

 rust/Makefile        |  29 ++++++++--
 rust/macros/lib.rs   | 125 ++++++++++++++++++++++++++++++++-----------
 rust/macros/paste.rs |  15 ++++--
 3 files changed, 131 insertions(+), 38 deletions(-)


base-commit: a126eca844353360ebafa9088d22865cb8e022e3
-- 
2.44.2


