Return-Path: <linux-kernel+bounces-569055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54909A69E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117C61889616
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DF31E3761;
	Thu, 20 Mar 2025 02:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="y1xvEpuO"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCB1E0B62
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436491; cv=none; b=plwN2RmMOb8Epf1jOCcnipmJS+YR4b07bQgkBnsdkJxUVvaZu412ad5UoMZ8rW7Y7JuUxB75JcypvSQM5N6Cfa7+iTslD3sv3+5CcPCi9ZHkpb3LUynr2qpWTBtBFwjQ9OUR2a4OV3zbeYFq5l2F8L/ewtIYCZ6n8EkUOsIM2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436491; c=relaxed/simple;
	bh=03IFx5F/8s+ERTelQ6QipCTshCLvkxnBip1S5FpTytA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmjpijHtisYdjIvnDFONEClInx94ffAlPYCVNhjSFZyMky+BBIcop30mY396s6PgP0IDJSsH1W+kR2E2BSJnJzsyrt0Xh+T0wwbvG9YmEK9lOubRF/7cbKdaXptjxgI37DvFoODp9tyQKf66hPgwbhmviWmyVYvqP9c2IIsXslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=y1xvEpuO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e63504bedd0so190364276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436488; x=1743041288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuXZhvGZx7xMwwoF8Xjn7fJDSV5CszWctHzFd7M09OI=;
        b=y1xvEpuObKoy4SZITMEFWbgFoCVFFS9OH8GotC0i/DWNL3NTRe/DYNaZ5szPmPVAD8
         QLyKkBLvoPTdBPF3cyS15LP91HmvL5KpeX2sIP1LP4JlsiI4mjDSrJzqd1oIxXHKdZ/v
         dI51iQ1gDVnnsksJQd3eutz0dsWeyOYRiboX9rGjz6VasYRHA+WFKU+uS75jab0wghYa
         3KG0hznOoljHsTelVtiJouUy2t5Z/FpzujvkzNIsZaxJKVqXz8ObMuoJMyJV+ufuT+9E
         EDE4zb+0ewfWNMxLDz7DB9WenF951y/Z651zShR5pNjm1xDf82c5DDMMKJJN/VDQ3cWy
         Yalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436488; x=1743041288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuXZhvGZx7xMwwoF8Xjn7fJDSV5CszWctHzFd7M09OI=;
        b=lB38Kr02As8AdJz5HuwgDOZYY3I3Z1Xc+BNUw3TZqC/kSuBbAaP5NYo9ZMaEx8z4Ka
         h9nqwUN/OjGcz/pi8kfZYgWN3kzXiTQ+OfDALG0RnDdW9Qe4/aHWL/oZPMMJ1eC4X1pN
         Pkn8pqF1czTtp8tpLZdeXmssszq39SldOe1JESfRiP47Ao6ZmnB2QP3+zXhfEP9twNG5
         xjVT7tVPIDr3WT1QR7w7hM4yNP9zJXQ+h6bMmU6PEibuNaxwUF8KW0yx7AknrX6gm9Gi
         5PatF7zv9ExBfldKLvmyw3n+urXHvB1BphgixHGRyXnvNEYUe15/JTCMBmDtnNuYTejv
         QAxg==
X-Forwarded-Encrypted: i=1; AJvYcCX8F6Y7zjxGl0/LAQmOT3jOP6tpA2IywUOAwE/7rHTP1hcQJpWKCU5+hhnJT3pZOI80t13uhIqCGwOIvp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkBEX/6uozSsiaP4QawsqIwU8bhkc5ghGrTGD5vK90SCKgOXO
	x8Udvg8X3sp+KMwqEry5pDP1RQf/EinF9vG+NfIwu22NduVDZ1I/oCtupWFrliM=
X-Gm-Gg: ASbGncuRpJ8M8Vx83TXx0bl3JfRyqd6Qg+VE4JxGuvXSSwKlm9ITXtmisDnoTE/wOvY
	bXQmdTCMrntxCJwlXCeDWOg5iLJ9mtaihH02yqiEqDj2JX4+7SEVSUJu0BCpoODCOcDL7ZnWJii
	rRijgpXKYljtbw9PvLRz9IOYOULD4vMyR3S4PnKj34zX9vGjB4KZ+wlF4d4iWbYfr5deQDSvryw
	M4WG5YAgDL2qWzGqB92hEZHvzLF8jD9+5uzQObOJPhYRwgbnHNGX212uBqFA9+kTBdyJQ2rgjSN
	aoojqR2Y36Kt2TMM2HxwB4DYulWgQJMQYC4M1ZP6MgzqJToPzTwJ8M+TGBGdvDD8s7JkngvZUxr
	gRWWRc2Cs1ySR3mO8uIc30AcFCKFo1Q==
X-Google-Smtp-Source: AGHT+IFTW7X0utxwDE7gdYWpCHlNdJyLmZKN2FueLNxq4+vvY6Arwtu/HikraiAQxOArkDTjw8Fwdg==
X-Received: by 2002:a05:690c:62c7:b0:6fd:4367:e31a with SMTP id 00721157ae682-7009bf83c4emr62770207b3.9.1742436488474;
        Wed, 19 Mar 2025 19:08:08 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:08 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 04/17] rust: task: remove use of `addr_of!` macro
Date: Wed, 19 Mar 2025 22:07:23 -0400
Message-ID: <20250320020740.1631171-5-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of `addr_of!` here is unnecessary since its immediately
dereferenced. The main benefit of `addr_of!` is to avoid intermediate
field loads without immediate dereferencing, so there's no benefit in
using it here.

We can achieve the same behavior by directly accessing the
`group_leader` and `pid` fields, which is more idiomatic.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/task.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 49012e711942..568b528e2cc4 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -257,7 +257,7 @@ pub fn as_ptr(&self) -> *mut bindings::task_struct {
     pub fn group_leader(&self) -> &Task {
         // SAFETY: The group leader of a task never changes after initialization, so reading this
         // field is not a data race.
-        let ptr = unsafe { *ptr::addr_of!((*self.as_ptr()).group_leader) };
+        let ptr = unsafe { (*self.as_ptr()).group_leader };
 
         // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
         // and given that a task has a reference to its group leader, we know it must be valid for
@@ -269,7 +269,7 @@ pub fn group_leader(&self) -> &Task {
     pub fn pid(&self) -> Pid {
         // SAFETY: The pid of a task never changes after initialization, so reading this field is
         // not a data race.
-        unsafe { *ptr::addr_of!((*self.as_ptr()).pid) }
+        unsafe { (*self.as_ptr()).pid }
     }
 
     /// Returns the UID of the given task.

