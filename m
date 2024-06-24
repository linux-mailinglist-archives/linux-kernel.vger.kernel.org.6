Return-Path: <linux-kernel+bounces-226592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EDD9140B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 05:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBE2283BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 03:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1A379F6;
	Mon, 24 Jun 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCtwLPnB"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A094414;
	Mon, 24 Jun 2024 03:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719198251; cv=none; b=aK1pTvrH7H0mD8+e059oupfof28XGWmjUA7VLFCsVs2j/yFSpmKFKUnxHzWmxK2/4/Rv3AyJ82go0PKomjUis00kEHk/hV2CeTjyv9AYy0ZDOMoOunjNqESAHKpfOOOqOnhMH8IYQM1G5xXeBybbNZJyfkAQ7DEokXFKGFmSxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719198251; c=relaxed/simple;
	bh=wEVlm5KTIctksbyrUJ305mnfHLguP/uuxQhuuJXMlOc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rW7MsnRoUjzX1D2DCqtxyyTYr1yvZtYXLp0l55AbxEsnCn8grglKWqVuC4GK+O64nsRO9goYSjdF8z0nlYjzokoVfhB4pwF3qdljQ/qINjNwt5QFE0lrgsZcMQjuigQc3lppYTBgALtuhklQvGMZQFNEv7K+QJ+1voL1YcQSHTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCtwLPnB; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f38f5584ebso128142639f.3;
        Sun, 23 Jun 2024 20:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719198248; x=1719803048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0AS7LIiATWIFmT/GbHKd1lPZf8qyVPZ39foeYhnx8Q=;
        b=GCtwLPnB5WESjuJ1zm3GIL1Hxcizylg9hDcw4O7266/Whtz7V4ZnSywjn/HMEYV4Ci
         jpI+WS9uW66yfnr6avNy4TPiwMEvV/oD3Re6L3YVuY6WhxAKV/uZlrcTs5Dq6I9vOh7l
         5B4vd6uQ8VeWbNyq4wSRd0RqN45pyRaxauO21MU9QvI3WuKCouQfxlNsMehi+ps7FaxS
         V99deJgM9TzJi44J4el6T+9XLWU8r7c52RQVs9I4bX817273ar3SWLpTrn2KxrUBV9Qy
         S39rtdeVLhImS8xai1oSKTz94hTwHYH3Y/IktPGr54uBwYS6/32qHK94VFNTFVpo4oFz
         Jnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719198248; x=1719803048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0AS7LIiATWIFmT/GbHKd1lPZf8qyVPZ39foeYhnx8Q=;
        b=Pvy0IYgo+2oM8unBgYRdsN7S3+niqAhOodj40TMq+PhtkMmjhH1a9lFoNNNaMu2WW5
         ++j/rlaVlBnQR5mGY6FBdarvGMoO7g/Ybq/AaxQI9HZsCM1Mb5bZjqgaulHGTAUGx2cB
         cGEIVubaEPJrQzOxmJsdFRS7fL7eONMeF1zc56zYJqxqMq6dEtuBX1OJ7pAoJgHg1By5
         QxHTaFmfGYDk9IKTI4/uyTMFiVOXzmqcJtUE6O3u48FFKHFaVxKbmHuMIn3+2lTi7uCq
         yicgvJIlTRAiyKIhBYB7wYc4o7IvFPwIBKVjF4w4UNvXmqLEd9rJ+evmtQ19OrYAno8v
         XcZA==
X-Forwarded-Encrypted: i=1; AJvYcCWnBUcu/RLJmZ22rpjCFji2KT5JVSp2aGHmWovcCYc85NgO69YWLPATW7QnydEcD5TMP+JM4Sr6CQta+YDhs98z7CMPIgEA3kEeMW81dn82im9eWx33yxZiEomZbKq3k8FLuxxULtpr2mgGP+I=
X-Gm-Message-State: AOJu0YwlzlpS7x0seElP8xJ6D0T3XnYj4P/fb9g8/Puhsc4AiXTbNTER
	J5dyCyCUU3bgNwomsZvTOE6akG0ajg6r/UQ7pnczLF7jgFRs2sVn
X-Google-Smtp-Source: AGHT+IGZtrpKDrL+vKIP/MKC7NxyY1qVKFgfb3z40mtXIz+qPEb2/4NiWtcVJIQ3YW54XiXlRIbXRg==
X-Received: by 2002:a05:6602:6015:b0:7eb:9697:95e1 with SMTP id ca18e2360f4ac-7f3a4d48277mr443782739f.0.1719198248387;
        Sun, 23 Jun 2024 20:04:08 -0700 (PDT)
Received: from localhost.localdomain (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9ea0957c0sm1045476173.131.2024.06.23.20.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 20:04:08 -0700 (PDT)
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
Subject: [PATCH 0/4] Enable rustdoc tests for the macros crate
Date: Sun, 23 Jun 2024 22:03:02 -0500
Message-ID: <20240624030327.90301-1-ethan.twardy@gmail.com>
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

Ethan D. Twardy (4):
  kbuild: rust: Expand rusttest target for macros
  rust: Enable test for macros::module
  rust: macros: Enable use from macro_rules!
  rust: macros: Enable the rest of the tests

 rust/Makefile        |  37 ++++++++++++-
 rust/macros/lib.rs   | 127 ++++++++++++++++++++++++++++++++-----------
 rust/macros/paste.rs |  15 ++++-
 3 files changed, 142 insertions(+), 37 deletions(-)


base-commit: a126eca844353360ebafa9088d22865cb8e022e3
-- 
2.44.2


