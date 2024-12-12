Return-Path: <linux-kernel+bounces-443915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E09EFD7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C927D16DB74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16461ABEB1;
	Thu, 12 Dec 2024 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqpjmpDs"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776EF189B91;
	Thu, 12 Dec 2024 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035508; cv=none; b=U7xsa4OEQLpRPf9XtvaFQh8DAtBEb39/x/jkd9qQRWYdjJ6m71bt3sLByOxDnIS56EkQP36HaQNn8CZUarTJ3iZa3t3C5BaJCFQxL3k5dtCHSI7uBrvUDlw2GMrqAHToNAPf6wwYIoElMDyjdbrM7ScTPGdayzGOPs9Ntm3IjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035508; c=relaxed/simple;
	bh=It9cd1U/Pd0oYEIIEd6WaFoV2dInJz6OgbqtcjTiVwI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gqVltPtw5lE62okPvT1cqDIu8pEe0QZJSQr2w1kEkH7fvAhGBiP0lqTp8DYA9DoQ4cBZfRSs9eUgikxsYCVqjqTlw8HYdNPzuji0jGBtq5LFUTQO6N7S8kyyl2VyR5rL/1jiiLIHF1CMi1SauICtNagqiJwUeTG4Joyc+/CT/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqpjmpDs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6e5c74cb7so87268085a.2;
        Thu, 12 Dec 2024 12:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035505; x=1734640305; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/okDfVuYTe6phyTTlRVvXcgDN6/R6ks3Yc0+ibfcV8=;
        b=KqpjmpDs7CI8Q2ga+oy+8ZqXcT3mbNoJCxLRkwhdHhYFuKbsrD8me1g9vz23AbM9Ri
         XmoNAAX8nF1kYLgZ3xzTJTvRDPQTfEkiZV6JlDH9Fy0aC4Smmy4zZxvbvDvFj26s0h9J
         PibNP9YZezV35A65/aNZ6vjERVMoJbp0I0jvwdDuJUPneSOyjwTANXbBBy3Ix8UefTDB
         pgcYQw9YJ+2Phkkt4Q3ookN520aBhGlAyi9k2iEg/SL1Y/jU/YDWsFsiulS7zAZ8nO2X
         MfdcohjNR4ZhaznSuMmb29K71CXH4HHGdwlMW01mfJGXUpsLOobW65rkyQsa6JpQ3TD1
         Ng9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035505; x=1734640305;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/okDfVuYTe6phyTTlRVvXcgDN6/R6ks3Yc0+ibfcV8=;
        b=vnU5PttZTQS4qOz/U4sVwJbByaWfdaPCscyGK03zHFFmO2Zs5PtzGNH+eJx3rco9F+
         jj8fq7BLvg84jIkFskxr/T+B0XED2JKQS6ZgVYpYmXrje2LgJ6+kh613DH2sVRJ8DQZt
         u5O2TcUUxSpoVJilmqsnqDB2FS8QxY5EqFTZrwWkG7UQee/jIkqMUeafRNiueN2OT0fX
         g9t+jtrft76RX8Mo5djdrIjGmg/7gkojmV3u00icPlmcdaCHAu4jJiaBGkq5gLA7YxE0
         g+JbyS30Ly9hfqsK+zagK0aLbBW/DVEjpkbS7buRv3CrxqZ/5U8OJ+GhY6pdYghjHbAF
         03uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxUAy5ppRcGVSF0lLEI7gSSSw2hUYvdHL3ne8JycY4Akz3SGgoLYYIGY6YWrZIe+7Ss+EG0IgT9Vv+Eb0=@vger.kernel.org, AJvYcCV/MKiq319GlSI9hhdTvQ72mcJct9cBGKgjlA1S7Qrh6XAXXs+cS/8SY/xb9S3FllQV+Q0qaejdbblI+Dmtp4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFo7D9k/ewqk/wumpg7RaDpSHRC+XWC7L5/7xH++c5gGKltppF
	ysKux/1bwFNyhMWT0Pko9bnCp8B5/WRAyq+buF0qtHAUcblfFkQT
X-Gm-Gg: ASbGncsJYAOI3IsElvtHP22PHu2ANOskVZRjThg9T2oT4MXyJ1c1U3C1z7JBn2/xFYa
	1706puUXnojR/WkfH88xknShHrmhDCyy1jLCcEZjQPKTBOWRZDm2c4d9JYd27SYF6pq53EB75Jk
	2M11JyJeA4zE0DieB+okX0XddrBOhINHiLEF72m8HtZ5dnW1aHeHvSI7VKxtSoWPs/DF1gBR+QM
	wYbsSMppGeIg80AX2fC1wP8ZyaddXoSVkMO5F/AjpapFRsxVMFGOHgj3G2C/AnDRuMf4J75UTAw
	AQxZKoPi6AIRvaLo3MqVFmzBvNxNFvyzon4w8maYrpsCroVL1EkBS9JI+dhN
X-Google-Smtp-Source: AGHT+IF9caItsjGJ91EwNgYOEKVhtwWNWBL0HKa05+i7Pp7Q6aPwsMYZ6f0N6x7+WGRfCv2GOkPZoQ==
X-Received: by 2002:a05:620a:f0d:b0:7b6:d90f:e4ca with SMTP id af79cd13be357-7b6f893b1cbmr202854685a.26.1734035505337;
        Thu, 12 Dec 2024 12:31:45 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:77da])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6db04175bsm359894485a.52.2024.12.12.12.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:31:44 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v12 0/2] rust: xarray: Add a minimal abstraction for XArray
Date: Thu, 12 Dec 2024 15:31:35 -0500
Message-Id: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACdIW2cC/3XQTW7DIBAF4KtYrEvEgLHBq9yj6mL4c5BiOwXHT
 RTl7iVO1bRqsxwE3zzehWSfos+kqy4k+SXmOI1lAP5SEbvDsfc0unJAOOM1MM5oOuaZnjAlPFM
 TRxfHPlPjg4Qaaq4bRcrTQ/Ihnlb39a3MIU0DnXfJ4zfGBNNcSM3bDTRKg6ScDhZH3G9jj/uIG
 zsNX1by78cSbb6Dj2BddY8lGDVTStMHHY4zbWUABcH7UNtuaW6Gwexp8YY4d1VAy2ofrLStFs5
 a41jruZMagw6amTZY5izW5JZ8F/M8pfNa0KLX9etOAPV/FYumjAoO2jojRaPkth8w7tff3MAF2
 A/lWaHlVmGQS8MNM0Eq/oeBB8OZeMZAYaRCLR2I1ttfzPV6/QRWdRyCAQIAAA==
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

teststs

This is a reimagining relative to earlier versions[0] by Asahi Lina and
Maíra Canal.

It is needed to support rust-binder, though this version only provides
enough machinery to support rnull.

Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcanal@igalia.com/ [0]
---
Changes in v12:
- Import `core::ptr::NonNull`. (Alice Ryhl)
- Introduce `StoreError` to allow `?` to be used with `Guard::store`.
  (Alice Ryhl)
- Replace `{crate,core}::ffi::c_ulong` and clarify TODO with respect to
  `usize`. (Alice Ryhl)
- Drop `T: Sync` bound on `impl Sync for XArray<T>`. (Alice Ryhl)
- Reword `Send` and `Sync` safety comments to match the style used in
  `lock.rs`. (Alice Ryhl and Andreas
  Hindborg)
- Link to v11: https://lore.kernel.org/r/20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com

Changes in v11:
- Consolidate imports. (Alice Ryhl)
- Use literal `0` rather than `MIN`. (Alice Ryhl)
- Use bulleted list in SAFETY comment. (Alice Ryhl)
- Document (un)locking behavior of `Guard::store`. (Alice Ryhl)
- Document Normal API behavior WRT `XA_ZERO_ENTRY`. (Alice Ryhl)
- Rewrite `unsafe impl Sync` SAFETY comment. (Andreas Hindborg)
- Link to v10: https://lore.kernel.org/r/20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com

Changes in v10:
- Guard::get takes &self instead of &mut self. (Andreas Hindborg)
- Guard is !Send. (Boqun Feng)
- Add Inspired-by tags. (Maíra Canal and Asahi Lina)
- Rebase on linux-next, use NotThreadSafe. (Alice Ryhl)
- Link to v9: https://lore.kernel.org/r/20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com

---
Tamir Duberstein (2):
      rust: types: add `ForeignOwnable::PointedTo`
      rust: xarray: Add an abstraction for XArray

 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 ++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/alloc/kbox.rs       |  38 +++---
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       |   6 +-
 rust/kernel/sync/arc.rs         |  21 +--
 rust/kernel/types.rs            |  46 ++++---
 rust/kernel/xarray.rs           | 287 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 394 insertions(+), 45 deletions(-)
---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241020-rust-xarray-bindings-bef514142968
prerequisite-change-id: 20241030-borrow-mut-75f181feef4c:v6
prerequisite-patch-id: f801fb31bb4f202b3327f5fdb50d3018e25347d1
prerequisite-patch-id: b57aa4f44b238d4cb80f00276a188d9ba0c743cc
prerequisite-patch-id: 2387ec5af1cc03614d3dff5a95cefcd243befd65
prerequisite-patch-id: 75e26dd500888d9a27f8eac3d8304eab8d75c366
prerequisite-patch-id: 7f845443f373f975a888f01c3761fe8aa04b8a3c
prerequisite-patch-id: 5a9856c7363b33f0adfe8658e076b35abf960d23

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


