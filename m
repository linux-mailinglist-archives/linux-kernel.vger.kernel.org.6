Return-Path: <linux-kernel+bounces-562899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E566DA6344C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C75B175071
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F0D1A2C0B;
	Sun, 16 Mar 2025 06:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="rsamJEkT"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482481A0BD6
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106058; cv=none; b=OaszHC4PIlXeapGj06X+/Eo2+dYVIs8dOIbYz9MQcF622T6E8zfO/7rKcttfsMn0N3ZvKeQpwifegYVW2zNFAO/C0Ol45Cutiv0uccUTmky3yPTMEzetVNnf83lYb8JBi8/qyfJSlSgE3anLvLN+E9zXimKmcYfFlA9kUO4Lmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106058; c=relaxed/simple;
	bh=6kUxBrQxMex82Dfiy9yN8C7YKntSC4CHpsJlbHDXZ/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zxg0SBRkNEKm88zSIa1eS39cYvJ9M3BoeACoKjK4f/7nLuu4LFsU/D7ZXT6F99/i2DTSx3Qggpbs2Jn76I3rS9DahLB7/wcKHNwjqZMcB6KZKvFNh1vMl9onPe9S52B/VenyPGHC1emMUf0cvi9sNB5chNoCsirNbLZbXNRSdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=rsamJEkT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e573136107bso3162692276.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106056; x=1742710856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skUHTWyrumrekrxW/UyrijXP0S3ug25d6RXYwbstcOI=;
        b=rsamJEkT8ezTH6UKn+fvnD1oQ+QlbzcEeoJls6jvdTdUx8j/yKDJ8k1GWu4BZClWps
         BqD/T5Mf/OmluFBttl/YYN2PmXV+zujQN8ZVGhH9NxEyjCyWIkvwzaC/lV1zoutxHSis
         8fStBgMIyUtSv3Vm6yak72+DjjD1yxAhsvOmBZh44qlaZ8bUJXzKEEbX23YpiLSayJA7
         H0L8Mdkcr8ueyJK1f05cFMEyEDBmOfDfAfOFqDN0yl6ba4vVohLGSnHhqfuBBvVkiQgP
         WzpEHewxtbJD97APsDvWkiMMax9G96RA35hctV49XlGcJnH05ZpDwKtpziN4rL0k1gL+
         7QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106056; x=1742710856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skUHTWyrumrekrxW/UyrijXP0S3ug25d6RXYwbstcOI=;
        b=GF1zOblUt9K+7ehNC4527GKiy4sMprO0kbBXAdtnlKNNQZl0M+3WcY/RW93MtVGfKt
         NutrFeIXwbLMowupnOKPL5AjLgBJ5ZrUq8lfJZ6GmuRtTYhnKIQxRW5EKNfj+PTlMGUS
         YAKuw5H2yF2mAw1EF7xuPJs1P1GgxpNK6gbFDc6lQcDozeoFke+xdn6R9/yJ+87GJH0O
         YWaG4H796E8YBxBpiIo9UWBeZ0nhuDEZqTgdadK4u0t9X5mPcMWQ592PvNK8CVTxyOMK
         V12EtaWR+u6rqF4B5MnkmeEKQRZmN/PE/87yOiE482T8a0lEnTRwzZOee7kvBhMFNGm8
         vhaw==
X-Forwarded-Encrypted: i=1; AJvYcCVC3qGJgyD9aQHChbGpKK9pvzPp9q5grgu9vkXDmDGGiKeh9wDbOC6YaMHKWYgAy14Br6XbiEONC6o4Yhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVHQeD2FiuFJPlldMtP48KGCSlNTfIsMdSU1VFwWoEEm74oh84
	yxvfnRRDfKrCkWIrFwKvC6gyiV/fGQlBMPnO/7FcJ2MbBxToklcI1/sbMkRqRLM=
X-Gm-Gg: ASbGncsBC+U5RJw+JS5jlugh58vOHtocTW552JZBds10MTJ7NZ8LE2QKdIoFBF8FN7k
	VKzW8TZPtJQUp7DpEv9UJprYjSN24MnlmMlT05Th3/amSQfBl8S6bP9nUOlqD2ZjAXY7R09eY4X
	ANpuGFF5y94qfI7/sBQ1lpYaH3CuDiM0rU9FkwVX2/gCdLXaLORgUkg+jBChdcjM+a/nL8ElPvB
	/jR5sC3A/w4bT5GWK8+lTJN1Ey8C/EgaiJfExcicVXC3jJ1MrQhQw3HeKo1RuBCpo3pyJHZzCs8
	nDN21ET+ZO9OpqJG6j7rH+szyoNs3t8cNLuSzOKsZo7nuZihZpwU5f0BDUK9wIDNGBe7CE/Mxlh
	ejzlxw1OQpLBGWBQCoOUWpze+PPky2g==
X-Google-Smtp-Source: AGHT+IFIA9jJmbRoN7Y4Lg46r7JSKPu6MnbK12bWhd74PXynRk8+s6RQ3a5OoitFk1+oG0NyrHvHGQ==
X-Received: by 2002:a05:6902:2292:b0:e5d:e3b1:4868 with SMTP id 3f1490d57ef6-e63f65c360bmr9498636276.37.1742106056331;
        Sat, 15 Mar 2025 23:20:56 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:55 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v4 16/16] rust: clippy: disable `addr_of[_mut]!` macros
Date: Sun, 16 Mar 2025 02:14:25 -0400
Message-ID: <20250316061429.817126-17-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the `raw_ref_op` feature enabled we no longer want to
allow use of `addr_of!` and `addr_of_mut!` macros.

We instead want to use `&raw` and `&raw mut` to get raw
pointers to a place.

Note that this lint isn't currently reliable, but we enable
it nevertheless because:
1. Document that one shouldn't use the `addr_of[_mut]!` macros.
2. When the lint becomes useful we will already have it enabled.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Link: https://github.com/rust-lang/rust-clippy/issues/11431
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 .clippy.toml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.clippy.toml b/.clippy.toml
index 815c94732ed7..95c73959f039 100644
--- a/.clippy.toml
+++ b/.clippy.toml
@@ -8,4 +8,8 @@ disallowed-macros = [
     # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we simulate
     # it here, see: https://github.com/rust-lang/rust-clippy/issues/11303.
     { path = "kernel::dbg", reason = "the `dbg!` macro is intended as a debugging tool" },
+    # With `raw_ref_op` feature enabled we no longer want to allow use of `addr_of!`
+    # and `addr_of_mut!` macros, but instead use `&raw` or `&raw mut`.
+    { path = "core::ptr::addr_of_mut", reason = "use `&raw mut` instead `addr_of_mut!`" },
+    { path = "core::ptr::addr_of", reason = "use `&raw` instead `addr_of!`" },
 ]
-- 
2.48.1


