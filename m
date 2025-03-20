Return-Path: <linux-kernel+bounces-569054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58580A69E14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BF016E802
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8FD1E0E13;
	Thu, 20 Mar 2025 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="RTzP18VU"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAA1DED46
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436489; cv=none; b=p3B3ztd9nZAxswNcvAUxu3o4lmoA+slCKnuq7nFrr/WVejlqrB/ouAC5kZ+iNbW1+IIyDTAP7HabJ7eknbw3L0EUnZMilCxaLv8ssoFCQTiGjzoQ+MhkdbC34jcxw7nOBNxC22wVyM6782W9TeB9x+U91Kvyf8T2EKEQw346/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436489; c=relaxed/simple;
	bh=CoA/2hVi92eZQd/UwZ3tw5ujIhmIXQsdItxz6SHTHIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhhW3V5to18cjjSiWVf0Z5pChvxe9sSmNAL5+l8MRhArWZa1YGSq5j+LSsHoSeMWwfT/XJro2X03prcP21MvpROLjy7wjv5EKPS4VYjLorZVczOfbKBZk7gKIctX11lzTnj56lp6xZ31qqIhq6tbbJ18Vla2lAsp5p40CLmynt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=RTzP18VU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e46ebe19489so190256276.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436487; x=1743041287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzqtkZzwBBAw59T4If4/NvkVtKC0U46N8wwS9fJHshI=;
        b=RTzP18VUtbt86tIqdbhoHg/Oeuts3mBIXRRfejMCTYZatLbPZ6ERLYK/l2L0tP6lKG
         TLJB9B5YWiD9/7fBfwu9GFdDxRu5N48mpVLPml7V1UF43nicRSdmX6+n8YQCGI8wL91W
         xz/u8ybpQXyejXlCay4XcbrKl+UCnwXG0fsDm3H/R6B9jpcoHf7vZIo+aNpeEWGEkxeT
         R1ZEQoDbO00jD7wljPgBoDU7laTIuN70msW3baetHbKKcjQ6bCD9aQ6hTWcPiG/Hi6iB
         wkY3Do2PQLAuS19utU1DkCB/n7g+y5Eh2KwcikUbdMu39kbOUFeG9qQnBTkmO8L7LrAa
         NfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436487; x=1743041287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzqtkZzwBBAw59T4If4/NvkVtKC0U46N8wwS9fJHshI=;
        b=jrRvadyhLVfajeOrErO+FH4uFYACDdYug+6g/+AXANYcKla1IxVCaGbyOubVEcXZmK
         IeYxp5qdd6srDB3BTdh3KmRlZCw0zMvXilPmPat+lHR8CkQYUCPW5QygAEDStn7nNTkJ
         /OPtUA8XeAMNp6ZyBTNWEQO905OWAwJYpbkF8wgd684pxVd2l0XGm+rGWg0hDiGyQWYg
         ulqgFwBHxlCUBk43KY2c5Jlk/0nQlBkxNkS85gMdoJpXqxZtJinzHD+BKAo71B1y2vf7
         bQs/BV56JTGDIEsOj94mFL/XNX34bIfvDD1jtjrsh3dDG1CYTPNLwosUkDTMT+riMgaN
         jDtA==
X-Forwarded-Encrypted: i=1; AJvYcCWarCn1aapo0oHuamGJrDAoR6krDiQWGs7gvTCCY2CGwwPfrx2G6szNRywH8qXuaFtSWtsLd3+HAJWk6+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7D7RkKo85HNJaFfrj90iEhBK8t3SJ8DmkbHwGDLdyQ6aaStk
	+EQKwc0vGCUBPWjkFZVqxqQdiNNN8ffhyyhaCV0h4ZIVzNbqq/YsDEddmspWGaY=
X-Gm-Gg: ASbGncvtEaqQvv7/GLMaiOjxReSfna/wOYO5EU22ofoIUL2FbWnZn6CLm4UZ5EHWWgA
	2dRNebkyECkaCnWe9NEcWI/2LhDQpHVnjS9N0udr6oJVQl/Ir9XmKPzo/kO6lxev3hpRu5O3qi6
	CY7tqf+Cm5AQE1WSDm0hRYvOo02/Hke/4btL2Os+luIXRDg3KxwOhllI1+SiFP1XB2ucEsVBFEp
	y8yzyvCWf1o4scSNjlVzXzM3VNxsQXH4bHGkkTT5O02m37uWZOJ7glUfz1uLNlXnx1Ud0kchWzI
	q1wvcmz6p5YYwvBVEjNm0u37SdiGtyXzxGFIgkALWiSg6tdMrHWT4tNkDmH/S+f0EQqG40D9r9F
	QoADcYSXbKSxSaekv5iyy+w+kWFsuq3wQ8KsvjH91
X-Google-Smtp-Source: AGHT+IGrrHo42oeZzwXEXnfIxB02LQfOA0p257k8khsUUdzI6mnH/HgxPiYAXsLkWVyYj4hsQ/s+iQ==
X-Received: by 2002:a05:690c:6306:b0:6f9:56d1:a8be with SMTP id 00721157ae682-700ac6e43afmr20778107b3.32.1742436486768;
        Wed, 19 Mar 2025 19:08:06 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:06 -0700 (PDT)
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
Subject: [PATCH v5 03/17] rust: list: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:22 -0400
Message-ID: <20250320020740.1631171-4-contact@antoniohickey.com>
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

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/list.rs                    | 2 +-
 rust/kernel/list/impl_list_item_mod.rs | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index c0ed227b8a4f..e98f0820f002 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -176,7 +176,7 @@ pub fn new() -> impl PinInit<Self> {
     #[inline]
     unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
         // SAFETY: The caller promises that the pointer is valid.
-        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
+        unsafe { Opaque::raw_get(&raw const (*me).inner) }
     }
 
     /// # Safety
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index a0438537cee1..014b6713d59d 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -49,7 +49,7 @@ macro_rules! impl_has_list_links {
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
         //
-        // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
+        // The behavior of `raw_get_list_links` is not changed since the `&raw mut` op is
         // equivalent to the pointer offset operation in the trait definition.
         unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$id>)? for
             $self $(<$($selfarg),*>)?
@@ -61,7 +61,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
                 // SAFETY: The caller promises that the pointer is not dangling. We know that this
                 // expression doesn't follow any pointers, as the `offset_of!` invocation above
                 // would otherwise not compile.
-                unsafe { ::core::ptr::addr_of_mut!((*ptr)$(.$field)*) }
+                unsafe { &raw mut (*ptr)$(.$field)* }
             }
         }
     )*};
@@ -103,7 +103,7 @@ macro_rules! impl_has_list_links_self_ptr {
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
                 // SAFETY: The caller promises that the pointer is not dangling.
                 let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type $(, $id)?> =
-                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
+                    unsafe { &raw mut (*ptr).$field };
                 ptr.cast()
             }
         }

