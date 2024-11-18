Return-Path: <linux-kernel+bounces-413233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116D09D156C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E61CB26793
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680E1BDAA0;
	Mon, 18 Nov 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNVVrFiP"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DC1B393F;
	Mon, 18 Nov 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947623; cv=none; b=cESgO9qX7ZyWu13ItMyVkv4iaYAQj+mMKYyJlsYkwpNedYjaZ7GvRYgcSJN17aDWFbB/5upCBtdU0eOQg66A05VLTQSzztlTy83blE25rgkCtwXtYmgyohlZMqLTcfa+7atqYbQ2QBXj3jQwuyYemaBsPZd3zWgnS0r291uV/Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947623; c=relaxed/simple;
	bh=DX4r4DTcpTy0ZjOcxMBvzc0rx2DdiUiYOwlxIr7v6J0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qfFJi22tJFyh1h2IWpwOCxgoAhLs2o+YucvrJDT0bEF9qHLWmqrFr4iZZiLj72j6a/VwRg3khmuNIYr4ClKqM35EdHhIrRnzMTgHUQb/qr524kOOn35MSUlvXiiQFoXYF0WgBXTP5tpth8+AFFfyXZnkVr66ZXtZt/6n0++4SQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNVVrFiP; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1434b00a2so178737985a.0;
        Mon, 18 Nov 2024 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947620; x=1732552420; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DybuQx5d3+bgyJ9oEn2gWX7xPyv7WQdEkAa4DLURDs=;
        b=nNVVrFiPW0lyxzIkBD0LbUpxclhm66AUffQfFn5yxWsLwUr+8E+Wwd7GRKXqjLHj0Y
         UfB/WXLOMeQYIHdldMWdZNbB+2oyX6VgzvcuLz/KAVPqBlj8i2E/tvR339aMnDwUXY/T
         WIHFRGM1OTbLha4RBpHUfaI9/8EV0VP+7O7sUYB8l3oxCst8fLiBm0etY5GtDoaeA/B+
         lgjw1EfkYeEbu6p6hY2HkPWdWUzm8GkKghXlOkgNlMs+aTbYBAki+0jXHPGlsqT8fe2c
         kQZFBITc0/1yNxZ/z5CtfxDocjTotdGVUJ7VTsMe/cAn7sQnK4Mv1Taa9XwmGGyim5by
         4Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947620; x=1732552420;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DybuQx5d3+bgyJ9oEn2gWX7xPyv7WQdEkAa4DLURDs=;
        b=MQG1B4hqaWuV2cSDkS5A1/QMvz4QfHyRhtDuw8AfSfyNEuhe9IBls6Dt6aJph/rQYz
         I7mJfe/uL1LKNDMOFo9LMl0wyxKj70Sl/BG3tp4pjIc0oYhQ3zg1H9P3BVAXbJS5f7Ql
         KURllzrFZBpkop4qDpg3wJH7Oq/Qnfit/W9lbH9uta7Kc3Fa4RuDZBjx84mEe3dPUD31
         VaIJJxQA2n0jNySaA8ZwhCKi4ooK+Ix4ZjXb/BrIKZTBTwETMrkImRp13tkjg4oVy++G
         rAXeKzW6QC89zz8wG4IKFKcaxteYmhV+xWDEOhZ8UUVc6aWfBNxthSH52wLTSTg10EWf
         5eIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQKLlsae2HGASX6vBshSkUJe0+S4EiU/rDalFEmjfI6e8p9tT8DCRPsKWNjEYkZKUGzjvM2QswPeL74ZM=@vger.kernel.org, AJvYcCVpL8IIUSH3sgbH3PyyzEI/+05qPh0txWIhtxlg71vklGfvnXuL/XNR6vnNsG6353Vx7MSpv8PROEo74DYx+T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIfKCyc0hXXBb5QnV+KzPg5HIMA4yy8zpfsL5Si7I0QbCAun6v
	dirDAU9RX9FrY0nSVAsJhXmsrNwa4Lvru0FCvFKDhswP2AycnXXs
X-Google-Smtp-Source: AGHT+IGNxiAzkwhQ6JQgPd+SlepmHDLfpb7r81O61a4tjhmMNKgcYN7v9jKylr1KF3/4ZTel+lPgog==
X-Received: by 2002:a05:620a:1a8c:b0:7ae:d2d0:190d with SMTP id af79cd13be357-7b3622eb041mr1823163885a.32.1731947619562;
        Mon, 18 Nov 2024 08:33:39 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:35ca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a8a9fdesm1804185a.124.2024.11.18.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:33:39 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
Date: Mon, 18 Nov 2024 11:33:34 -0500
Message-Id: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF5sO2cC/0WOQW7DIBBFr2Kx7kQwBtt41XtUWQAZHKTYpIOdJ
 opy99CmajcjvZH+07uLQpyoiLG5C6ZLKikvFexbI8LRLRNBOlQWKFEriRJ4KytcHbO7gU/LIS1
 TAU/RKK002m4QdXpmiun6o/3YV46cZ1iPTO5PJltpsTUW+53qBqsMIMzBLe70niZ3Sm4X8vzrY
 vrcatn6Ev6Hjc0rq5XgM3P+gnlboTdRDSoSRR3Gi/l2eFcIqm9O69h47GQbBxcGVL0PxkYT+oi
 6furR2HrrrQ1e7B+PJyMVdIsgAQAA
X-Change-ID: 20241020-rust-xarray-bindings-bef514142968
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is a reimagining relative to earlier versions[0] by Asahi Lina and
Maíra Canal.

It is needed to support rust-binder, though this version only provides
enough machinery to support rnull.

Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcanal@igalia.com/ [0]
---
Tamir Duberstein (2):
      rust: types: add `ForeignOwnable::PointedTo`
      rust: xarray: Add an abstraction for XArray

 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 +++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/alloc/kbox.rs       |  38 +++---
 rust/kernel/lib.rs              |   1 +
 rust/kernel/sync/arc.rs         |  21 ++--
 rust/kernel/types.rs            |  46 ++++---
 rust/kernel/xarray.rs           | 259 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 363 insertions(+), 42 deletions(-)
---
base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
change-id: 20241020-rust-xarray-bindings-bef514142968
prerequisite-change-id: 20241030-borrow-mut-75f181feef4c:v5
prerequisite-patch-id: f801fb31bb4f202b3327f5fdb50d3018e25347d1
prerequisite-patch-id: b57aa4f44b238d4cb80f00276a188d9ba0c743cc
prerequisite-patch-id: 2387ec5af1cc03614d3dff5a95cefcd243befd65
prerequisite-patch-id: 8de2f688833d4d16eece062c5b6937a95a6a0e8b
prerequisite-patch-id: 7f845443f373f975a888f01c3761fe8aa04b8a3c
prerequisite-patch-id: 5a9856c7363b33f0adfe8658e076b35abf960d23

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


