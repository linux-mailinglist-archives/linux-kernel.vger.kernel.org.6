Return-Path: <linux-kernel+bounces-562887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7565EA6343A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C7E3B0F95
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163718DB0F;
	Sun, 16 Mar 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="HmARq8rR"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F4418BC3B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106033; cv=none; b=GIxXWhHfB9wqGvZGRdGh+1HHO/Gpj8lx3NhnHnEQTn7JNaCA9VjWMISo+t4aLw0f6uobYRvVGAVVO6qbknVMZlGMKPAzFDw0y3J5EvBl6lFtxVw6gCPF1uHbKBlCUd5r1k/QAt3x7P3PS1fkbT1m2oYKrG/1UCofUihzmSIWFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106033; c=relaxed/simple;
	bh=eIYHcWBEiFLknY3tj9cmC1cIpl6ZvopmPvDITgdtRJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEjSIXaWAmjtvspjgdsfYWYctzT6uwqSmzwV/gJ8ZTWFWf3KdQkaVqOX7cUsU909Ui8PLbrJbEeuJfQtSFm6ZcdG6reWrNItmikpJVyyl4a/PuA0P/XjZO7lHQA7i3Yu1jf1C19rImAxcnKZJRxiGpzJSZ5ocOH+6FyNj7aiLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=HmARq8rR; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e609cff9927so2387917276.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106031; x=1742710831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHOnw6NNknF40lG6JQUFbNKg4/fZPxuep0oOWgNFQIc=;
        b=HmARq8rRTDYFHOsFSrBSVn4Kzlo3aYsoQluyJ5qmsJtEH2jr8DgJCBG27SZmECt1OB
         t8VC9y3ARpLx2hzUMLiXaFn5KEOmCIySWDhkJCf+ti9Ztps4S5PltpqCesjj5qSyiSGh
         uA3XUSgLEEBoOOi1CgJtxd4Idk6ALIW++dBNYC5uDSRiXrnD4nhIDofbZuiZGM55OBq8
         njD1eYwpK0aYly9gtOpxxJkzPL2wxV/GuHERCKoRfHXBhEbdga4XdxdqSxBqMnPkhOMA
         f9OFdWhrbeWVgLteNU4mQkcec4W9cqazPg2DyyoMLAUYwgzxSqQ8sczBhoTNBW9Jq72p
         dC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106031; x=1742710831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHOnw6NNknF40lG6JQUFbNKg4/fZPxuep0oOWgNFQIc=;
        b=hUJeaGnJUzxD3sBR5ijcXkbVY1GTJtLLmmV61kBd2vRRJC8USd+xpJTrGhjmJPT5a2
         S3bZPNAbRL+AwhpncDu3bZycfiAESMrv2z1BtI2uDKdbwWjyG/0Ml/98rsdQl09puPE3
         ci0NjG8GmDpQvnSTo8WWhivrOF88K3b3KYNkcgWvc6R0RfBliWzJRtIhwVwPadWKf4kc
         6QJCgI69/gxEGYnvEI9G3OwecKXU2YvLCnGxDEHj9Xpexg2G9cFA7UjOjLpYO3F/kA6G
         6rU3XexLPooulhhWBbmb360aPVCphiJgSRTEMdpyU6t7+XbOO+XkdjbykPT9jM8DN1ts
         WRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcL7HM/W/r/8V646TCesuAYAG2lKeCndWUu710kunq37ioFo7b2EjcJLgbepgRO812XtOmO/zMxBYlreo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgkleBHMc3LaDRruwsgSXDEKvBMbszoypvQwmlU2iU8jwgMAJz
	lbVj1H7GYcAUf9smKMOCnim0z9xNv2d6wd2GPleXmoH216MB7iH/9GZsVH0QoKo=
X-Gm-Gg: ASbGnctLhqsH4tAICi0qCg4empn1jZZhfyvulzY6Xaf57PGHa0N96KnSgbUxFKCCwlQ
	8Mcq+YwsX5eQrKw0Znz2EqBSQlTPiBaQiGwUETgnQ75gNme9rsBeh9RnIdRmsmwNqBVgR3l/Evw
	2r05S1itXVxVKIytowZoclcs2HvIdmyxRb4SBsCBdW+oReQWyuWGMtn+g28NQdSRpRRsp4/55tP
	Dm7Z5qIIdb+jO+Me/GYI5W0/q1+3LCzHPXRXVKJTThky9oLADrt3IXyNh+bdonbF1h+OBvmmMXi
	279rT4LM5MFWsy49uWLgdSEjya1cXlBPHmlr2rXf05FyhXHw+PipTZWk2ztfvpt2tU/WC0f39fM
	9jWHT7xxER4A4wAqedSZD5GlVR8WQLg==
X-Google-Smtp-Source: AGHT+IEr4DfWkNRilwLYG+bm/FQhMCTQPQVmmtd6gIv3USMmxFzqn/38j/vsTorOQl3q/a2PlV56DA==
X-Received: by 2002:a05:6902:2742:b0:e60:5d76:f79d with SMTP id 3f1490d57ef6-e63f65e07dcmr9891498276.43.1742106031254;
        Sat, 15 Mar 2025 23:20:31 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:30 -0700 (PDT)
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
Subject: [PATCH v4 04/16] rust: task: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:13 -0400
Message-ID: <20250316061429.817126-5-contact@antoniohickey.com>
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

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

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
-- 
2.48.1


